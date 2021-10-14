Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5817C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 09:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA64460F41
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Oct 2021 09:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhJNJnw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Oct 2021 05:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhJNJnv (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Oct 2021 05:43:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 446D160FE8
        for <linux-hardening@vger.kernel.org>; Thu, 14 Oct 2021 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634204506;
        bh=+pJC+Rkqx7OwiUym9k2/c49FU2yNvL/+R4TIiQPyJHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HiUibQxxeVy+br1Rj2734BQtTtFQO2V9nrlxSs0xVmjh0zuekwFjj0tMZTe2dAcWB
         9Y/aSFk8UM2fKs47kJMwg3ol3PPSgAtTMRIxKiNCA3xZOM8NpApb32ObuJL9EiV+3r
         VZL3+1ZEsID+PxgoXy/oML3XyR0dcS5AnCLar3Bthmi6jiDImLNbnT2ztE1auPvUzt
         JyqkHL9KpCDGjlnHABDNBGhITuaUjSoLFT8qWDUgKgbTBxOqhUg2n+u8u97LimjR6i
         YiIIuRkdD2O+eRtLeCJNQzXelECrF2zcKOHVhhUPlaTojoNORMgAlTEOW25x597ySO
         qR/f97NyKHMFg==
Received: by mail-ot1-f43.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so7433130otr.7
        for <linux-hardening@vger.kernel.org>; Thu, 14 Oct 2021 02:41:46 -0700 (PDT)
X-Gm-Message-State: AOAM532bq8KjBERGRpB7jsqYuymOXXkgFFMGL11H4Z9u42Awkjk2qJeM
        eOUVhCksV2/p6MfKk3HmNx+o70Cl2Z+qm6cubaw=
X-Google-Smtp-Source: ABdhPJzua6jofMCS8Pl1Rjhixioz+F1B3LZGfjUEZ1zrXhd0g7jjjMiRt4cCJdCsmpPVYCCGRWD4L1UQ3oHTcNiS6iI=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr1578208oto.112.1634204505543;
 Thu, 14 Oct 2021 02:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211013152243.2216899-1-ardb@kernel.org> <20211013152243.2216899-10-ardb@kernel.org>
 <82104d87-b077-87a0-2393-ab15ac66dcf7@linux.alibaba.com>
In-Reply-To: <82104d87-b077-87a0-2393-ab15ac66dcf7@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Oct 2021 11:41:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGNpnXF5_xEBmomdb5O+pDyX16eZ1TRgaCB7hYBF+9scA@mail.gmail.com>
Message-ID: <CAMj1kXGNpnXF5_xEBmomdb5O+pDyX16eZ1TRgaCB7hYBF+9scA@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] arm64: implement dynamic shadow call stack for GCC
To:     Dan Li <ashimida@linux.alibaba.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 14 Oct 2021 at 00:35, Dan Li <ashimida@linux.alibaba.com> wrote:
>
>
>
> On 10/13/21 11:22 PM, Ard Biesheuvel wrote:
> > Implement support for the shadow call stack on GCC, and in a dynamic
> > manner, by parsing the unwind tables at init time to locate all
> > occurrences of PACIASP/AUTIASP, and replacing them with the shadow call
> > stack push and pop instructions, respectively.
> >
> > This is useful because the overhead of the shadow call stack is
> > difficult to justify on hardware that implements pointer authentication
> > (PAC), and given that the PAC instructions are executed as NOPs on
> > hardware that doesn't, we can just replace them.
> >
> > This patch only implements this for the core kernel, but the logic can
> > be reused for modules without much trouble.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   Makefile                      |   4 +-
> >   arch/Kconfig                  |   4 +-
> >   arch/arm64/Kconfig            |   8 +-
> >   arch/arm64/kernel/Makefile    |   2 +
> >   arch/arm64/kernel/head.S      |   3 +
> >   arch/arm64/kernel/patch-scs.c | 223 ++++++++++++++++++++
> >   6 files changed, 239 insertions(+), 5 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 7cfe4ff36f44..2d94fed93d9d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -933,8 +933,8 @@ LDFLAGS_vmlinux += --gc-sections
> >   endif
> >
> >   ifdef CONFIG_SHADOW_CALL_STACK
> > -CC_FLAGS_SCS := -fsanitize=shadow-call-stack
> > -KBUILD_CFLAGS        += $(CC_FLAGS_SCS)
> > +CC_FLAGS_SCS-$(CONFIG_CC_IS_CLANG)   := -fsanitize=shadow-call-stack
> > +KBUILD_CFLAGS                                += $(CC_FLAGS_SCS-y)
> >   export CC_FLAGS_SCS
> >   endif
> >
> > diff --git a/arch/arm64/kernel/patch-scs.c b/arch/arm64/kernel/patch-scs.c
> > new file mode 100644
> > index 000000000000..878a40060550
> > --- /dev/null
> > +++ b/arch/arm64/kernel/patch-scs.c
> > +static int scs_patch_loc(u64 loc)
> > +{
> > +     u32 insn = le32_to_cpup((void *)loc);
> > +
> > +     /*
> > +      * Sometimes, the unwind data appears to be out of sync, and associates
> > +      * the DW_CFA_negate_ra_state directive with the ret instruction
> > +      * following the autiasp, rather than the autiasp itself.
> > +      */
> > +     if (insn == 0xd65f03c0) { // ret
> > +             loc -= 4;
> > +             insn = le32_to_cpup((void *)loc);
> > +     }
> > +
> > +     switch (insn) {
> > +     case 0xd503233f: // paciasp
> > +             *(u32 *)loc = cpu_to_le32(0xf800865e);
> > +             break;
> > +     case 0xd50323bf: // autiasp
> > +             *(u32 *)loc = cpu_to_le32(0xf85f8e5e);
> > +             break;
> > +     default:
> > +             // ignore
> > +             break;
> > +     }
> > +     return 0;
> > +}
>
> Hi Ard,
>
> According to my understanding (may be wrong), here may need to filter out
> '-march=armv8.3-a'. When it is specified, gcc will use 'retaa' instead of
> 'autiasp' as a pac check.

We can't use that for the single kernel image anyway, since retaa is
UNDEFINED if the PAC extension is not implemented. So in this
particular case, it does not really matter, given that you would not
include the SCS fallback in a kernel that is targetting only hardware
that implements PAC.
