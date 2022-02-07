Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4700CC47082
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Feb 2022 05:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiBGFyz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Feb 2022 00:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349444AbiBGC6C (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 6 Feb 2022 21:58:02 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555FC061A73
        for <linux-hardening@vger.kernel.org>; Sun,  6 Feb 2022 18:58:01 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso11994345pjm.4
        for <linux-hardening@vger.kernel.org>; Sun, 06 Feb 2022 18:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FxExIV77Tn6LTPoKZIRsR52CbJyPFso/VdKEunHEkBw=;
        b=S7jQ23s8oyEzwMduypPD3WabdNlC9spE9m3Kp9V+vzRoH/cm/FwunXNxpa1ssKTugi
         qcIL8WI1Wc5t0QkN/MpKucZlCvlLRDQ13BBLq/ypDhwEO1gO0VwdwNUueWi0I4Z0hMhl
         sN0+Z4irV0bTGVKeLxH1EPYrNFPxV/SA4kCXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxExIV77Tn6LTPoKZIRsR52CbJyPFso/VdKEunHEkBw=;
        b=CjdqJhD7eaBNwqU2X7P5cS9qZRGiLTw2ufn/o0yjLTgoF2k5KjpszXqCMbNjOMfuQ3
         kgGWyFpnnwtdgrGslrteuHf2xlckZPGWMl5dtPKut4HTxrXRCrJyBI+WP2V8LA3La5gN
         ndSuJ5ljcyRGXRNUJ8h2C4roov80TwHJyJTEH/XybhWfc6jzsMvErfYBJbziRayXCRU/
         ehMm9frZVDiQgSFFBhVcsumCyuzCIXK04pnQlUuHMMV5dl9HY6rZeu9iwr5vuQYQWHQK
         hsLOpX+fZZXv1JxzYHOPr08D29qWvHAEDx4cO8q/IQ8juKuQ9MHy5J4JKG/T10toCiTK
         Qegw==
X-Gm-Message-State: AOAM530aO/rIp/4nMPDbaNWcw3ysOSv7B1CH48KfP2qwRCya/XOF6JzV
        Rsa9UV6LLEemTixtlGUi6w/lCA==
X-Google-Smtp-Source: ABdhPJxWKveza+zkkF09dV74hhKksjFAaFudcZ5ZAuZ08pfsZe1frMkRh60VirGM4nvUEKziJSRZNw==
X-Received: by 2002:a17:903:32c6:: with SMTP id i6mr14627977plr.60.1644202680932;
        Sun, 06 Feb 2022 18:58:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kx5sm2167786pjb.16.2022.02.06.18.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 18:58:00 -0800 (PST)
Date:   Sun, 6 Feb 2022 18:57:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins/stackleak: Use noinstr in favor of notrace
Message-ID: <202202061856.EBC48533B@keescook>
References: <20220202001918.4104428-1-keescook@chromium.org>
 <20220206115816.GA23216@worktop.programming.kicks-ass.net>
 <202202060819.3C86C47DCA@keescook>
 <YgAyL2D25nweODX3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgAyL2D25nweODX3@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Feb 06, 2022 at 09:40:15PM +0100, Peter Zijlstra wrote:
> On Sun, Feb 06, 2022 at 08:46:47AM -0800, Kees Cook wrote:
> > On Sun, Feb 06, 2022 at 12:58:16PM +0100, Peter Zijlstra wrote:
> > > On Tue, Feb 01, 2022 at 04:19:18PM -0800, Kees Cook wrote:
> > > > Is it correct to exclude .noinstr.text here? That means any functions called in
> > > > there will have their stack utilization untracked. This doesn't seem right to me,
> > > > though. Shouldn't stackleak_track_stack() just be marked noinstr instead?
> > > 
> > > This patch is right. stackleak_track_stack() cannot be marked noinstr
> > > becaues it accesses things that might not be there.
> > 
> > Hmm, as in "current()" may not be available/sane?
> 
> Exactly the case; if we lift the PTI address space swizzle, we start
> with C without having the kernel mapped or even the per-cpu segment
> offset set. So things like current will explode.
> 
> The whole noinstr thing was invented to get back to C as portable
> Assembler, with the express purpose to lift a bunch of entry code to C.
> 
> > > Consider what happens if we pull the PTI page-table swap into the
> > > noinstr C part.
> > 
> > Yeah, I see your point. I suspect the reason this all currently works
> > is because stackleak is supposed to only instrument leaf functions that
> > have sufficiently large (default 100 bytes) stack usage.
> > 
> > What sorts of things may end up in .noinstr.text that are 100+ byte stack
> > leaf functions that would be end up deeper in the call stack? (i.e. what
> > could get missed from stack depth tracking?) Interrupt handling comes
> > to mind, but I'd expect that to make further calls (i.e. not a leaf).
> 
> All the syscall/exception/interrupt entry stuff is noinstr; I don't
> think we have huge stackframes, but with all that in C that's much
> easier to do than with then in asm.
> 
> If you worry about this, it should be possible to have objtool warn
> about excessive stack frames for noinstr code I suppose, it already
> tracks the stack anyway.

Yeah, I think we should be okay at least for now.

Let me know what you think of
https://lore.kernel.org/linux-hardening/20220206174508.2425076-1-keescook@chromium.org/
and if you like it I can send a v2 Linus's way...

-Kees

-- 
Kees Cook
