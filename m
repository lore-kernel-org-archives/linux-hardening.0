Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB22C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 23:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbhLMXrf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbhLMXrf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 18:47:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD98C06173F
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 15:47:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b11so12291948pld.12
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 15:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4NeqGUpgiKq/CSr5Hrjt+fDUe8zcECnhuKEw/ldsDPE=;
        b=VPOaPOHF8pzjwCuZV9F8FCY96Xb+4T2npLrgyUAeo+BHoeXWJJQO8A+x59hPRT1GVO
         AHHTFBDm0TfSXFVH607lkqWs+QCU7GibwKI5CIoMw2JaII0/EOPR8SWFX1x9blwwRz28
         s1KxS6KbZXlrAUJ9ezMe+NUAXgDt7WM/FC4wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4NeqGUpgiKq/CSr5Hrjt+fDUe8zcECnhuKEw/ldsDPE=;
        b=nTMtrorV6YE3ksPpTOj4aL8/MHW5r5CRdQhI8Zv6m5MsxmRDIvmcC3HjlVmVxoXe30
         +spdR/K94wRGWlTNcW/NBGOsHHLx0uqqSUdHy5DUjwa8K+REYZ22DouRb0MSxsDT21t3
         AKOt1OwvL5EvENdrEOkbbwGQvsk2PrgWEERllE/PJRbPIN3hzZpKh3Tp6c3W6/aT3PHV
         75aKUM50DxI59z1UbP1h3AoI8INk/wtDd+Yn4Fv5uXooqWIMd/UYfjSRFj0BYiWAkZf6
         uwuBCHxUySecERy/Itbds+1FMcprSGR0i9tzGCp9X20XbTwC7LrG+1qZSNSkuyMoPSe7
         RMmw==
X-Gm-Message-State: AOAM532sjKRhRonJfIQszIeF7jIY7GcJURKcCYi+vwBi3ch5jf5YznDS
        pgdRyjkExxh/mR9E/ZhWFTbpxg==
X-Google-Smtp-Source: ABdhPJw4LBum7QxKEAfLtz15sLW0IDQvjLum2jXNjRXPttp3DiE1QYsg4QQYDo1ft0yFMFh7Laihew==
X-Received: by 2002:a17:902:748c:b0:141:c45e:c612 with SMTP id h12-20020a170902748c00b00141c45ec612mr1388757pll.73.1639439254777;
        Mon, 13 Dec 2021 15:47:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm13724338pfv.135.2021.12.13.15.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:47:34 -0800 (PST)
Date:   Mon, 13 Dec 2021 15:47:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Assorted improvements to usercopy
Message-ID: <202112131544.86E9D533@keescook>
References: <20211213142703.3066590-1-willy@infradead.org>
 <196BFB9E-9A72-48B1-863E-021DE0B162A7@oracle.com>
 <YbesvmxAI3P5UFnv@casper.infradead.org>
 <202112131246.4BBFBA69A@keescook>
 <Ybe4PoG2qQyn8zCX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybe4PoG2qQyn8zCX@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Dec 13, 2021 at 09:16:46PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 13, 2021 at 12:47:58PM -0800, Kees Cook wrote:
> > On Mon, Dec 13, 2021 at 08:27:42PM +0000, Matthew Wilcox wrote:
> > > On Mon, Dec 13, 2021 at 07:18:57PM +0000, William Kucharski wrote:
> > > > I like these, but a quick question:
> > > > 
> > > > Since the usercopy_abort() calls are all because the offset exceeds the page
> > > > size, is there a reason why you don't specifically state that via the detail
> > > > parameter rather than just supply a NULL pointer?
> > > 
> > > Hmm ... I'd defer to Kees on this, because I'm not familiar with
> > > usercopy_abort() usage, but the only places which use the detail
> > > parameter today are slab/slub, which use it to pass the name of
> > > the slab.  I think the user is supposed to infer that we overran the
> > > end of the page based on the offset & length values.
> > 
> > I agree that leaving it NULL is best here. The "detail" is really about
> > adding more information about which thing it was, which for slab makes
> > sense, but most other stuff there isn't really anything to quickly
> > distinguish one from another (i.e. vmap is all vmap).
> 
> There _is_ a bit more information in the vmap case (not in the kmap
> or compound page case).  You can see it in /proc/vmallocinfo.  We
> could pass it in like this?
> 
>         if (is_vmalloc_addr(ptr)) {
>                 struct vm_struct *vm = find_vm_area(ptr);
> +               char sym[100];
>                 unsigned long offset;
> 
>                 if (!vm) {
> ..
> +               if (vm->caller)
> +                       snprintf(sym, sizeof(sym), "%pS", vm->caller);
>                 offset = ptr - vm->addr;
>                 if (offset + n > vm->size)
> -                       usercopy_abort("vmalloc", NULL, to_user, offset, n);
> +                       usercopy_abort("vmalloc", vm->caller ? sym : NULL,
> +                                       to_user, offset, n);

That is interesting, but I think we don't want to do it here; adding
to stack or making an allocation for this (even though it's slow-path)
doesn't seem like a good idea as far as keeping code size down.

-Kees

>                 return;
> 

-- 
Kees Cook
