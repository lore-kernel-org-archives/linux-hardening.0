Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC254C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 21:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbhLMVQz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbhLMVQz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 16:16:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EEFC061574
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+oXlu81/pzMeMxFRDIwBJ0v+cxjFnt//6x6F6HOoz78=; b=KHOC4D3vl9Dn44+uRqxpWFJJkQ
        LH7RpKmZrJr8HD7j4c8mLIkbNUyFCs3LNQMhJwah/MQ80h7VEm+MeRnbukoYhAfsHjQ2T+B6yx94w
        qDR71S9o9juKgz52uQGFTDYMafRBRL78E95RrMhZardAysJaOgaWdw1SYn19ybkE4M8a17uUIL7+D
        cXaKfbyvb1N9JbYGe526FoLo87tsekaQPV4uhO+Sf6ruw0qciuhdhT7MuJGXpWKQSGgHCosg7i5PY
        J/JtI7pyITVAFEKXnvCQQrO0TpCzGw9wUs+rtdQB06WMbCOjUg4TWN6eJaxECZhSbuTCgVNb05qVU
        QKbb8UpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwsgg-00DA7y-QU; Mon, 13 Dec 2021 21:16:46 +0000
Date:   Mon, 13 Dec 2021 21:16:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Assorted improvements to usercopy
Message-ID: <Ybe4PoG2qQyn8zCX@casper.infradead.org>
References: <20211213142703.3066590-1-willy@infradead.org>
 <196BFB9E-9A72-48B1-863E-021DE0B162A7@oracle.com>
 <YbesvmxAI3P5UFnv@casper.infradead.org>
 <202112131246.4BBFBA69A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112131246.4BBFBA69A@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Dec 13, 2021 at 12:47:58PM -0800, Kees Cook wrote:
> On Mon, Dec 13, 2021 at 08:27:42PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 13, 2021 at 07:18:57PM +0000, William Kucharski wrote:
> > > I like these, but a quick question:
> > > 
> > > Since the usercopy_abort() calls are all because the offset exceeds the page
> > > size, is there a reason why you don't specifically state that via the detail
> > > parameter rather than just supply a NULL pointer?
> > 
> > Hmm ... I'd defer to Kees on this, because I'm not familiar with
> > usercopy_abort() usage, but the only places which use the detail
> > parameter today are slab/slub, which use it to pass the name of
> > the slab.  I think the user is supposed to infer that we overran the
> > end of the page based on the offset & length values.
> 
> I agree that leaving it NULL is best here. The "detail" is really about
> adding more information about which thing it was, which for slab makes
> sense, but most other stuff there isn't really anything to quickly
> distinguish one from another (i.e. vmap is all vmap).

There _is_ a bit more information in the vmap case (not in the kmap
or compound page case).  You can see it in /proc/vmallocinfo.  We
could pass it in like this?

        if (is_vmalloc_addr(ptr)) {
                struct vm_struct *vm = find_vm_area(ptr);
+               char sym[100];
                unsigned long offset;

                if (!vm) {
..
+               if (vm->caller)
+                       snprintf(sym, sizeof(sym), "%pS", vm->caller);
                offset = ptr - vm->addr;
                if (offset + n > vm->size)
-                       usercopy_abort("vmalloc", NULL, to_user, offset, n);
+                       usercopy_abort("vmalloc", vm->caller ? sym : NULL,
+                                       to_user, offset, n);
                return;

