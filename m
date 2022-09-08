Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59868C54EE9
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIHVQU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIHVQS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:16:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3606EBFA86
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:16:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e18so26275537edj.3
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Lr8oiy+JZ5JB+d+QkGV7FDirBPOdIiFwxT3YvDwpj8w=;
        b=LEaHRiXOMVqfETuRtrKDKenARH14qGRl7NuB14aBEgeGMGDbtWkzQVh7KylKuhB81s
         TxAgAz88H1/wFtBfBFXaJMjn9BqJ3YVRnK2wBWrnAUzzcO+Jcxz/bAKaZfjSBtkDEYaN
         JrtGiPbJ0nlKQXtYte0RSwd2BUastFp1538FMZRnLjouyAQw7TyOiH939vzUi4PgnPlU
         1ywc9DWipvNeZaDaO1iTX6M6UH88ZAe8GEoN/8DOuPX30m3kHZpUCsKR0iu87CXHLS2P
         oM0cYVleAG1luTB1ykljvduO8DDMzt8jbpchT1b/rzsJR9qe2XXu8HxXOVCuG6l1mGBC
         Y4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Lr8oiy+JZ5JB+d+QkGV7FDirBPOdIiFwxT3YvDwpj8w=;
        b=e4uVByQSaFWxnca4nZJtTMZKUnWHKo1kUyKTf/6hMAsTqzqKc3/ErcELDJTNqz+/Ae
         T+xEWhBR7jiEcLm64C+JvmR0r2/30iQ/hk9luqYjCVUgSooulSdvbWxNYAdULaNtpbTc
         Hxpg0aopcMHUC+ooMtcXxSLsggrg/9TbNVJoIRCMc6vDUAVCLn+Cmh0pBLr4zhefQu8M
         UWKo4kWJOrQ0LQOB6RsaPmVnw3vHnv8Th7wkmVG0MAAtoR2+CG2/5sWuf6iQLD8lgcaT
         N6LeLtT2ed+jSfeONStSEKsxv3GekYm8560nw5/JcRCaj/CA498ip6GBOqsBjdHLCexe
         ni2A==
X-Gm-Message-State: ACgBeo1F5DDtpSh4w786FSiUdPLc96QY+rk8GLjT/R//K9npZnqwUs1n
        tW5iGpKFIAcAW7sv0m7WT0rBkfyuW7VTVBzNeKlK
X-Google-Smtp-Source: AA6agR5lsRmAOE/0+TTz415bYxQiXfuxn/OW7pA3his5JST/uY+2zxr8lfmlZJuVp7ZpH5p8b5vEhIAXAzK3XUN1mds=
X-Received: by 2002:a05:6402:274c:b0:44f:334e:1e11 with SMTP id
 z12-20020a056402274c00b0044f334e1e11mr5788349edd.304.1662671775594; Thu, 08
 Sep 2022 14:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220902213750.1124421-1-morbo@google.com> <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook> <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
 <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net> <202209071609.BE5BF18D6@keescook>
In-Reply-To: <202209071609.BE5BF18D6@keescook>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 8 Sep 2022 22:16:04 +0100
Message-ID: <CAGG=3QUcQCQXff9Hk+eHrvbAhPT16BmFGNuAGcd-N0d-G8yBKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 8, 2022 at 12:10 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 07, 2022 at 10:50:03AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 06, 2022 at 11:00:07PM -0700, Nick Desaulniers wrote:
> > > On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
> > > >
> > > > On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > > > > [...]
> > > > > >         callq   *pv_ops+536(%rip)
> > > > >
> > > > > Do you know which pv_ops function is this? I can't figure out where
> > > > > pte_offset_kernel() gets converted into a pv_ops call....
> > > > >
> > > > This one is _paravirt_ident_64, I believe. I think that the original
> > > > issue Nathan was seeing was with another seemingly innocuous function.
> > >
> > > _paravirt_ident_64 is marked noinstr, which makes me suspect that it
> > > really needs to not be touched at all by the compiler for
> > > these...special features.
> >
> > My source tree sayeth:
> >
> >   u64 notrace _paravirt_ident_64(u64 x)
>
> I don't see noinstr either. But it seems a reasonable thing to do?
>
> Bill, does fixing up the noinstr macro and adding it here fix the
> problem?
>
[sorry for late response]

Let me give it a shot. I'll also test out Peter's suggestion, which
might be a better option in the long run. I suspect that we'll need to
devise similar patches for other places, but it shouldn't be hard to
find them all.

-bw

-bw
