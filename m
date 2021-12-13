Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C89BC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 20:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbhLMU1w (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 15:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhLMU1w (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 15:27:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C054C061574
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 12:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JC19I3YmCLDNiHEoNY94YjXvINc6vMnbscoJJqR8MbA=; b=OIJHFK/0ykYrEoU6/eIuJs6rCG
        l6vl5/kGpfVvWQBs1Zge1nsi5I370qhHwDiTptrXoSByHjQO3gzcO0x8Z3wSVVWSGY8fdYCPC3cKg
        V449PPqCZ7A1Evc4iDxD823eovBsZMLPVh9Jl0xSO2+qu68Mkg35rH+HSJTZzPTtYPGRBstoGXBU/
        2G9VVFlWP5jBYcSEJGhsUD4+o0SRnkM7AcxaVWRuQ2Qi0/jGE2rRWuIWwoKMJj4qm6psLgwjRo8Ja
        tCvXTd90e0CqPlVvRz/nNdGLdPkdcaab/aY1p0rmJ0sriXA+aBlsuMMO3JKKCZXz003uvUiEQLmB3
        8Ki4zV7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwrvC-00D8JT-Qf; Mon, 13 Dec 2021 20:27:42 +0000
Date:   Mon, 13 Dec 2021 20:27:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Assorted improvements to usercopy
Message-ID: <YbesvmxAI3P5UFnv@casper.infradead.org>
References: <20211213142703.3066590-1-willy@infradead.org>
 <196BFB9E-9A72-48B1-863E-021DE0B162A7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196BFB9E-9A72-48B1-863E-021DE0B162A7@oracle.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Dec 13, 2021 at 07:18:57PM +0000, William Kucharski wrote:
> I like these, but a quick question:
> 
> Since the usercopy_abort() calls are all because the offset exceeds the page
> size, is there a reason why you don't specifically state that via the detail
> parameter rather than just supply a NULL pointer?

Hmm ... I'd defer to Kees on this, because I'm not familiar with
usercopy_abort() usage, but the only places which use the detail
parameter today are slab/slub, which use it to pass the name of
the slab.  I think the user is supposed to infer that we overran the
end of the page based on the offset & length values.

> Otherwise for the patch series:
> 
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Thanks!
