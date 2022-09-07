Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D90FC38145
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Sep 2022 23:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIGXKr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGXKr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Sep 2022 19:10:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F2C0E7C
        for <linux-hardening@vger.kernel.org>; Wed,  7 Sep 2022 16:10:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 14so7337517pfu.9
        for <linux-hardening@vger.kernel.org>; Wed, 07 Sep 2022 16:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=D9GYa8OJDUYWVtjvzZNWj4WxHz/CsMN9FwfpuX4V0rg=;
        b=fHmNShdgI4dnC6hErvVoYwXgDNbgsvnYw6M/vzNGlywwNb8ieN/SlRLVWwpWKkoSu1
         vq0hcEhlT+GKynnWf9AqlWHeUPpZL08URJGii/8YbtzlfJ0IfDSoFsIU4KgaZEj4R4uU
         m+2r1/Ucjkq3qLNSD1SgrXHQXWlvKtbJxGq1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D9GYa8OJDUYWVtjvzZNWj4WxHz/CsMN9FwfpuX4V0rg=;
        b=m+oIlM59peBDwfawCFljd+vxepvQaLWu86jn8jYdH41qndwizllhmY1XhasJRghV23
         xfU7HRbiWVhQiCNUoxxRlrzp84eDmZT1B6aaogKYiq3ffyVJwQJ0uu6efmPsy9CinY6a
         EnbfAPQegVceXtU947UDPinpDRGmh3xGobzB4pVx94k0Li7p87zcyTe+bsVg1QofeVpQ
         mNdmi3XYXtKQRa7XhfxuylXSI5ylllsVPLSge2yXKRHvYNu8oj3drDVApHDOpwW7o8xM
         I1JTsYKy+VgeIIDMcD6jja8RvfI7wuM1tnv2lHJJPQgIw5tY1+w+TNy0SVXgCC7+qemG
         HB/w==
X-Gm-Message-State: ACgBeo1/sUxwYxJ1qHsQggR2OBxUUvcyN8dh5f16BdBZkXv/X7ZeQPQo
        OlDC/+0RIQNADjv0d94p8+pPCA==
X-Google-Smtp-Source: AA6agR5mOZptHzyKX2MhRGXlipNiPACZtnxxJGgxQ8tn93t85KvuvocH+td73K+d6+k4fFh4O61YPw==
X-Received: by 2002:a63:1e61:0:b0:41c:45d:7d50 with SMTP id p33-20020a631e61000000b0041c045d7d50mr5135945pgm.507.1662592245677;
        Wed, 07 Sep 2022 16:10:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v28-20020aa799dc000000b00537ab89c66csm13683408pfi.143.2022.09.07.16.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:10:44 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:10:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
Message-ID: <202209071609.BE5BF18D6@keescook>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook>
 <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
 <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 07, 2022 at 10:50:03AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 11:00:07PM -0700, Nick Desaulniers wrote:
> > On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > > > [...]
> > > > >         callq   *pv_ops+536(%rip)
> > > >
> > > > Do you know which pv_ops function is this? I can't figure out where
> > > > pte_offset_kernel() gets converted into a pv_ops call....
> > > >
> > > This one is _paravirt_ident_64, I believe. I think that the original
> > > issue Nathan was seeing was with another seemingly innocuous function.
> > 
> > _paravirt_ident_64 is marked noinstr, which makes me suspect that it
> > really needs to not be touched at all by the compiler for
> > these...special features.
> 
> My source tree sayeth:
> 
>   u64 notrace _paravirt_ident_64(u64 x)

I don't see noinstr either. But it seems a reasonable thing to do?

Bill, does fixing up the noinstr macro and adding it here fix the
problem?

-- 
Kees Cook
