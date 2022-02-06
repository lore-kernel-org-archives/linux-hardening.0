Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1163C433EF
	for <linux-hardening@archiver.kernel.org>; Sun,  6 Feb 2022 16:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiBFQqu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 6 Feb 2022 11:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiBFQqu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 6 Feb 2022 11:46:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73880C043184
        for <linux-hardening@vger.kernel.org>; Sun,  6 Feb 2022 08:46:49 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x11so9424212plg.6
        for <linux-hardening@vger.kernel.org>; Sun, 06 Feb 2022 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AV/FzMjsxogtDwb4DWVIrdYcYlkVfJVUqj5wlwsCnNI=;
        b=IM9nujf2vxUCcqhBkGmCyCSjSPkM/1Z8UCnM9qCzcghIic6L3kdbcJM5Sg/f688jy/
         W6dY+M87VLHAvepwQ6rUnjSZXMumB51f7PU/oCwhuJICX0tXiZseOjojEEhmBUjTqMtO
         jKtbreY27ABOCklcIwgWFLJw4armPQjQIaTlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AV/FzMjsxogtDwb4DWVIrdYcYlkVfJVUqj5wlwsCnNI=;
        b=gLqcWyMj2WY8yZH43CggWf/jhutt1SEhTYaSnvTy+TGNdGs9glVFe73Sgl/JzaKrgt
         WFP07j+wyON6vkUlT3lDHpuUYxBP0RWnqpcDW3BDSeGIAti93L5bWiOI8WMnLMTefE+d
         p4haI96AQGbUAYEoinYzNW/ILGwkWGYeHSwbb+GHZGQTeP5p/w5VXyfYkqvb44Y1oUr7
         cbPndREBTkWUURxfisrFFScGPZf/mQIwMvOPKwSLed56it1lv7mxyXTDhVXYadJzMHKH
         ulnCR9i+1BFCnGhO1IQqapZwnJlxGgUCWVKlqCLgTZwjt7jjiRNuiAif8PREivD7GEFh
         HUmA==
X-Gm-Message-State: AOAM5322S705N3Vk/SI/TtWq7gfHV1acuBxrQlFH4S2sUA0JmhCG3SwT
        7dq3nk0QwSTSV42a0eY4THMb0wf4xAN4gA==
X-Google-Smtp-Source: ABdhPJy2qKrHFsxitkkqN9O4RqiQ22JSOYLOpVX3iDRRP/MtqLZZ7QOW64c3Byn6vBd5rthkziC33A==
X-Received: by 2002:a17:902:ed85:: with SMTP id e5mr12436620plj.46.1644166008765;
        Sun, 06 Feb 2022 08:46:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm9273853pfv.24.2022.02.06.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 08:46:48 -0800 (PST)
Date:   Sun, 6 Feb 2022 08:46:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <202202060819.3C86C47DCA@keescook>
References: <20220202001918.4104428-1-keescook@chromium.org>
 <20220206115816.GA23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206115816.GA23216@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 06, 2022 at 12:58:16PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 01, 2022 at 04:19:18PM -0800, Kees Cook wrote:
> > Is it correct to exclude .noinstr.text here? That means any functions called in
> > there will have their stack utilization untracked. This doesn't seem right to me,
> > though. Shouldn't stackleak_track_stack() just be marked noinstr instead?
> 
> This patch is right. stackleak_track_stack() cannot be marked noinstr
> becaues it accesses things that might not be there.

Hmm, as in "current()" may not be available/sane?

> Consider what happens if we pull the PTI page-table swap into the
> noinstr C part.

Yeah, I see your point. I suspect the reason this all currently works
is because stackleak is supposed to only instrument leaf functions that
have sufficiently large (default 100 bytes) stack usage.

What sorts of things may end up in .noinstr.text that are 100+ byte stack
leaf functions that would be end up deeper in the call stack? (i.e. what
could get missed from stack depth tracking?) Interrupt handling comes
to mind, but I'd expect that to make further calls (i.e. not a leaf).

> > @@ -446,6 +447,8 @@ static bool stackleak_gate(void)
> >  			return false;
> >  		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
> >  			return false;
> > +		if (!strncmp(TREE_STRING_POINTER(section), ".noinstr.text", 13))
> > +			return false;
> 
> For paranoia's sake I'd like .entry.text added there as well.

Yeah, that's reasonable. Again, I think I see why this hasn't been an
actual problem before, but given the constraints, I'd agree. It may
allow for the paravirt special-case to be removed as well.

I'll send a follow-up patch...

-- 
Kees Cook
