Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E87C6FA82
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Sep 2022 15:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiINPtk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiINPtj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Sep 2022 11:49:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7283BFD35
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 08:49:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z21so22906519edi.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4dhFsHlPlvcgQnVjUa+mHnTzrJV68XTZuGnDxYxZSu4=;
        b=IN4R36fVYPVs6/B3yawNpatvT0g56oTugoNv50vlbOXyXAsWcQoX74Glmu+xcRhOae
         GvAaCg3MG/L8Q3tas9HwCOXN3WC128YoUW6cyI94sICqKBOFj+qu5Pqj+Xtjd7FCE/B9
         KkxrkeW/KK4wmkj30T3mcNCqF/q+6LqDkPiPNAKPsxrctP5e4Kojgv2JnihFQoPjqdJ/
         DM/T11hN+TzYjoppc5tkW7sVbID5LzLP59xDvMfco3TjvCbrG0Oq/OjRNaBHrGmkAU+U
         11JcCqoTcYzdCIF31VPjJE7zXI8LZoG7BMP+YKmd9Nk/SlkVy6K+g49IFh1ZQOJfuSxr
         8gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4dhFsHlPlvcgQnVjUa+mHnTzrJV68XTZuGnDxYxZSu4=;
        b=8BVgC91hKcw/jKFGhHfaJxrWTe42bDMPOqbYfRXNVvB2S8MwenJk8MCotWkmYK94IX
         /di4q2NVLpvulPiEZvToTLU2AGy3m5jfNJRGCCsyBXLCv7JPos/+qbPUGtA+ehzZYhjX
         lrtoU5p/L/iFleJINS14LlcJ1ytZKXx3q6bkh5uxy+PUC3FOw4KnBOL79gJk6SNNI3R/
         DsOUW+/FPHElSeDdjNA3NhSgDwPtwdRoxGf+89SrQMfghVY/nYijpqsxr5mP53ohPkGG
         Lww201pon+qoYLs2OoRKtue/mfDyZ3E7yr/eQjRhYCP1kpYT8IR758Sl0Di8CHJ5fvGJ
         fQ0g==
X-Gm-Message-State: ACgBeo1IRy91iDqFc+ayfro6bV6TuC73g/4wZx/Shg6bzv7OG356+IT5
        glb3zijTD+OS3moJCIWMOan+r3u3N9n0fH1UK2RJ
X-Google-Smtp-Source: AA6agR6Z4Bn46EoUvSA1obe0hHw0oo1/HH93DbRoRMf9w53XlRDeYqGX/S8m5ayEPeAxSsXgKiop3kZAgsLMXX0XPUY=
X-Received: by 2002:a05:6402:274c:b0:44f:334e:1e11 with SMTP id
 z12-20020a056402274c00b0044f334e1e11mr28344216edd.304.1663170575800; Wed, 14
 Sep 2022 08:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220902213750.1124421-1-morbo@google.com> <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook> <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
 <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net> <YyHn+UbfC7e1XIT3@dev-arch.thelio-3990X>
In-Reply-To: <YyHn+UbfC7e1XIT3@dev-arch.thelio-3990X>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 14 Sep 2022 16:49:19 +0100
Message-ID: <CAGG=3QVCH+Cgki8_Jvsj3Jz3=4Tpot4aHN_obY7Hy3wAwEODhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
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
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 14, 2022 at 3:41 PM Nathan Chancellor <nathan@kernel.org> wrote:
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
> >
> > And that function is only ever called at boot, after alternatives runs
> > it's patched with:
> >
> >   mov %_ASM_ARG1, %_ASM_AX
> >
> > Anyway, if you want to take it away from the compiler, something like
> > so should do.
>
> This appears to work fine for me in QEMU, as I can still boot with
> CONFIG_ZERO_CALL_USED_REGS and spawn a nested guest without any issues.
>
Thanks, Nathan. I much prefer to use this patch then and file a
separate issue to investigate the clobbers issue for later.

-bw

> > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > index 7ca2d46c08cc..8922e2887779 100644
> > --- a/arch/x86/kernel/paravirt.c
> > +++ b/arch/x86/kernel/paravirt.c
> > @@ -80,11 +80,16 @@ static unsigned paravirt_patch_call(void *insn_buff, const void *target,
> >  }
> >
> >  #ifdef CONFIG_PARAVIRT_XXL
> > -/* identity function, which can be inlined */
> > -u64 notrace _paravirt_ident_64(u64 x)
> > -{
> > -     return x;
> > -}
> > +extern u64 _paravirt_ident_64(u64 x);
> > +asm (".pushsection .entry.text, \"ax\"\n"
> > +     ".global _paravirt_ident_64\n"
> > +     "_paravirt_ident_64:\n\t"
> > +     ASM_ENDBR
> > +     "mov %" _ASM_ARG1 ", %" _ASM_AX "\n\t"
> > +     ASM_RET
> > +     ".size _paravirt_ident_64, . - _paravirt_ident_64\n\t"
> > +     ".type _paravirt_ident_64, @function\n\t"
> > +     ".popsection");
> >  #endif
> >
> >  DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> >
