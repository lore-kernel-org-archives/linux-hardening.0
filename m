Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF2BECAAD2
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Sep 2022 00:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiIBAeJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiIBAeI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Sep 2022 20:34:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C19F1B3
        for <linux-hardening@vger.kernel.org>; Thu,  1 Sep 2022 17:34:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y64so783121ede.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Sep 2022 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=g0W4XosBFsOU9OJyk6RCXP1Ph74BaHmTWPXYbDZyi0E=;
        b=g7NAxXDM5jwt2ZQIuC23zS+Gj6bX7gmaIfqxEAECYQiGWpEAFQa1f2CsL5nh5ft/Y9
         AIr2al38oLiJRpzGtrGgnk4w9IfIMWUonkE+9DZ6k2P21Kl0EvuSxr29PbDA1+1em1cd
         dYTEjCtfgKnZWDVIJDxxMjQp1lOCGSGhpovijuO0b3qiav5w11KiSdLi8IeR1Geo5r/F
         b3Rjza8J92KowwOKuk21IB4N0MxylAQhqeD2/xpXuUb7S+NMLxhQTDWf08GnJke1P5zt
         6uPpCh2NkLp/0pddJFPMNAMbbgzJsAElawX2udhNU0JRHIMRapcX8PefW1fFTfaGdcet
         aB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=g0W4XosBFsOU9OJyk6RCXP1Ph74BaHmTWPXYbDZyi0E=;
        b=wDXwachaeF4N1R/pvAgy1zDFbJomJdLLSANr/6Fsq0Yo59szzZRV9QGtT0OXlNOPmv
         Et1ET8mbDUBzAuVV3/nt5ROUK0FB4iubBp4iNvgThT9ahx1WNuRTecgTE+Pp4+uBBopn
         vkWw5EW9cTjjwHqTlpom5w3H4o7YMrvEmOXHUZbXSR/q3qFdDBUZW2WqDjy7jr/dd8Yy
         bhISuKsDFjvhoCuclSQKEJ95W5TcnKjyjj+bA1I/LH1IXCLWs9+dTNIrqUorDlXIUloG
         BOOZy7Sls07uFoQskke0UEbwExvMf3GEyeVKjcb1H5CGKMOLNpx5iSs5CIpz0RCGKKtS
         xtNQ==
X-Gm-Message-State: ACgBeo3AhrztiIRtyqJ1IHaOuOKRPYykkgVE7MEM2V6Xu6vlzqaEbkNR
        22RYYqapDpVvVu7grZ+TQay9VcpbmquM9gkj8ACFow==
X-Google-Smtp-Source: AA6agR7L1g+GrifIuIL2RvuO0MF4C2Vtm6LL1S4dqJ/PngqADbOmXg04ta+aDasVtIdRN9a8Nlvw5KjebtJPyg0x6M0=
X-Received: by 2002:a05:6402:3227:b0:448:706c:185d with SMTP id
 g39-20020a056402322700b00448706c185dmr18264220eda.357.1662078845879; Thu, 01
 Sep 2022 17:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com> <YxEh+pLyOyPalW1u@dev-arch.thelio-3990X>
In-Reply-To: <YxEh+pLyOyPalW1u@dev-arch.thelio-3990X>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 1 Sep 2022 17:33:29 -0700
Message-ID: <CABCJKucP5nXGiCTTCEPUGYo5Z9A9qaQkJ6_kXTOfw-o-=TYH0g@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] KCFI support
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Nathan,

On Thu, Sep 1, 2022 at 2:19 PM Nathan Chancellor <nathan@kernel.org> wrote:
> I took this series for a spin on arm64 and x86_64.

Thanks for testing!

> I did not see any runtime issues on my arm64 or AMD test machines but I
> do see a set of failures on my two Intel test machines when accessing
> the files in /sys/devices/pci0000:00/0000:00:02.0/drm/card0/gt/gt0:

Yes, I suspect there are a few sysfs type mismatches left to fix
still. I believe Kees was looking into these earlier.

> The source of those is drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c. I
> have not looked too closely yet but the fix should be something along
> the lines of commit 58606220a2f1 ("drm/i915: Fix CFI violation with
> show_dynamic_id()").

I don't have hardware for testing this driver, but that looks like a
typical kobj_attribute / device_attribute mismatch, which happens to
work because struct device starts with a kobject and the attribute
structure is identical. I can take a look at this next week.

> Interestingly, I do not see the KVM failure [1] that I reported anymore.
> I do not see an obvious fix for it in this series or -next though, could
> it have been an issue with an earlier revision of kCFI on the compiler
> side?

Most likely the compiler either converted it into a direct call, or
inlined it. There are a few type mismatches in the kernel still that
don't trip KCFI because they're optimized into direct calls.

> I do see a few new objtool warnings as well:
>
> vmlinux.o: warning: objtool: apply_relocate_add+0x34: relocation to !ENDBR: memcpy+0x0
> vmlinux.o: warning: objtool: ___ksymtab+__memcpy+0x0: data relocation to !ENDBR: memcpy+0x0
> vmlinux.o: warning: objtool: ___ksymtab+memcpy+0x0: data relocation to !ENDBR: memcpy+0x0

That's interesting. I can only reproduce this warning with
allmodconfig+LTO, even though the relocation exists in all builds (the
code makes an indirect call to memcpy) and memcpy (aliased to
__memcpy) doesn't start with endbr. I'll have to take a closer look at
why this warning only appears with LTO.

Sami
