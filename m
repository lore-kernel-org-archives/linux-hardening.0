Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41549C6379F
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 19:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBCTY5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjBCTYo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 14:24:44 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E592C37
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 11:24:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so8539387pjq.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0tPk4sfZJKNFpNFIGP01Wf1d6d+4z4fWOS2PRxRpJ+E=;
        b=QXl2BnJHqyLgWtq5mVKGbYbUgudUOgtq6id4YzZbbuUJWlFhOJ3y4KYubpj278lKSA
         Fcjy5e5bxvPvceFrK0V4A+e7mkVtJq99nAz8sJ+fjrtrOzJ8UhGq7OUeU6G3v2K3BBGw
         JH740zRZlZ/O/KBqQEkaM5+wTWFmCdtkAATqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tPk4sfZJKNFpNFIGP01Wf1d6d+4z4fWOS2PRxRpJ+E=;
        b=VR1xYENJGuM6m2z+VOqUqgsPKufWIQP8zoS5wb+61nGvK8qPtimOMmGhqIOBY4USaU
         2BH92GCmysD3bzUAVbF8BNthKB4kFtiOU9fcAtQ44x31zte5jCscQ1ctuFhCmnhUxT3/
         bjdNw1cfRfWWidA79ohLAuYYUd6fY0n0xcqZOUPjSZP9if9cCHb3+NKge86BsKkBqDHf
         IImwlZm6Ofk5hAstNzazgnn5Q3hfdvZWJ7M/jynfezATojMi8pHWBvsHyQ/uUHhXHkXy
         /H+/EnLmfIlBew46nafs90gAt8G3VPlXpm3NGNSo7IGN9WaE8pItso0aYZuK/GznCqAj
         diRQ==
X-Gm-Message-State: AO0yUKX/jeQoMjkPqFZDZmvb3+HomKwQf3BcoxKrzewFaep8wJl86ve+
        fhKEgu+yoGzV3Dq7edT9OJ27ag==
X-Google-Smtp-Source: AK7set9nb8IbFAca/MYa8HvF65jyp8xy0f7/JDopphMMG2OBivnP5gsUXEntugNeV5MaZ/75901RVg==
X-Received: by 2002:a17:903:230d:b0:196:4fe3:21b1 with SMTP id d13-20020a170903230d00b001964fe321b1mr12827800plh.27.1675452282886;
        Fri, 03 Feb 2023 11:24:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b00198ef93d556sm58432plj.147.2023.02.03.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:24:42 -0800 (PST)
Message-ID: <63dd5f7a.170a0220.d72b.022f@mx.google.com>
X-Google-Original-Message-ID: <202302031918.@keescook>
Date:   Fri, 3 Feb 2023 19:24:41 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Support Clang UBSAN trap codes for better
 reporting
References: <20230203173946.gonna.972-kees@kernel.org>
 <CAFP8O3LdXO4-w57KeX+E2D2rOAv-bK47ur0=8XLgfEkXgB=5eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFP8O3LdXO4-w57KeX+E2D2rOAv-bK47ur0=8XLgfEkXgB=5eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 03, 2023 at 11:14:49AM -0800, Fangrui Song wrote:
> On Fri, Feb 3, 2023 at 9:39 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > When building with CONFIG_UBSAN_TRAP=y on arm64, Clang encodes the UBSAN
> > check (handler) type in the esr. Extract this and actually report these
> > traps as coming from the specific UBSAN check that tripped.
> >
> > Before:
> >
> >   Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
> >
> > After:
> >
> >   Internal error: UBSAN: shift out of bounds: 00000000f2005514 [#1] PREEMPT SMP
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Yongqin Liu <yongqin.liu@linaro.org>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v2: improve commit log, limit report strings to actual configs, document mappings
> > v1: https://lore.kernel.org/lkml/20230202223653.never.473-kees@kernel.org/
> 
> Thanks. I'll add the Linux kernel use to
> https://maskray.me/blog/2023-01-29-all-about-undefined-behavior-sanitizer
> when this lands:)

Oh nice post! Thanks for the pointer. :)

> 
> > ---
> >  arch/arm64/include/asm/brk-imm.h |  2 +
> >  arch/arm64/kernel/traps.c        | 21 ++++++++++
> >  include/linux/ubsan.h            |  9 +++++
> >  lib/Makefile                     |  2 -
> >  lib/ubsan.c                      | 67 ++++++++++++++++++++++++++++++++
> >  lib/ubsan.h                      | 32 +++++++++++++++
> >  6 files changed, 131 insertions(+), 2 deletions(-)
> >  create mode 100644 include/linux/ubsan.h
> >
> > diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> > index 6e000113e508..3f0f0d03268b 100644
> > --- a/arch/arm64/include/asm/brk-imm.h
> > +++ b/arch/arm64/include/asm/brk-imm.h
> > @@ -28,6 +28,8 @@
> >  #define BUG_BRK_IMM                    0x800
> >  #define KASAN_BRK_IMM                  0x900
> >  #define KASAN_BRK_MASK                 0x0ff
> > +#define UBSAN_BRK_IMM                  0x5500
> > +#define UBSAN_BRK_MASK                 0x00ff
> 
> Q: How is 0x5500 derived?

This is 'U' << 8 from:
https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/AArch64/AArch64InstrInfo.td#L7571

> [...]
> > +#ifdef CONFIG_UBSAN_TRAP
> > +       register_kernel_break_hook(&ubsan_break_hook);
> >  #endif
> 
> IIUC, the break hook is a list so CONFIG_KASAN_SW_TAGS
> (kernel-hwaddress) can be used with CONFIG_UBSAN_TRAP.

Should I be doing something different here?

> [...]
> > +#ifdef CONFIG_UBSAN_ALIGNMENT
> > +       /*
> > +        * SanitizerKind::Alignment emits SanitizerHandler::TypeMismatch
> > +        * or SanitizerHandler::AlignmentAssumption.
> > +        */
> > +       case ubsan_alignment_assumption:
> > +               return "UBSAN: alignment assumption";
> > +       case ubsan_type_mismatch:
> > +               return "UBSAN: type mismatch";
> > +#endif
> > +       default:
> > +               return "UBSAN: unrecognized failure code";
> > +       }
> > +}
> 
> I wonder whether keeping the dash-prefixed name is better since that
> matches compiler-rt/lib/ubsan.
> People can search for "add-overflow" and get cross references from
> compiler-rt/lib/ubsan, instead of needing to knowing that "addition
> overflow" is another name for "add-overflow".

I think that the consumer of these messages wants as much plain-language
detail as possible, so I'd prefer to expand these into full phrasing. To
make it all more discoverable, I included all the details about how the
mapping worked in the comments.

> [...]
> Reviewed-by: Fangrui Song <maskray@google.com>

Thanks!

-- 
Kees Cook
