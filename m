Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBD5C61DA4
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 19:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjBCTdR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjBCTdP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 14:33:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BB2384A
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 11:33:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso5877977pjb.4
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 11:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69HT3C1W69Znw2CIhBXwEWLe/nM3/aFHpCnZaHmEP3M=;
        b=n7U3TKdEWMlyQf+epd0G6bxL5PtgxY+f0P8kc2nsv/wJii7yyN3trhIEgD0Wv10pJ0
         AwiT6/wnmgAy4ai8Y4tB7Z/KVha/zUxgOMx0J+Me3jOmVDpgHWKdxlz6MvMdOX/py+mk
         wTsO2okH57hQHAGMzqwDeyXDrurpAe8cPAwz4tROCP4C8/k9S4FkQF7HsfiE3BkQZGcZ
         ZD9+6Xq9WdsElo6mwi/uVlIAID90WSJc7NG3DbKS29l0LrSMAmqMrrxnVkJS+RldlD+Q
         N+aOSTcBByTTlPEn7tzxVVbGVhodg3rpmgBBCgDFuNitO3piO2r6RsD81l5+rl/IgvqL
         agEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69HT3C1W69Znw2CIhBXwEWLe/nM3/aFHpCnZaHmEP3M=;
        b=5LuBFtn7pW9iPOO1eVV0Dis3ZLtPOOxuaqKg0+5fJgE+4CDvat5aBm+D9CQPnp7rNs
         FZKGvjFwS3IHSLrB7ZeWXOcN+/W9HTTUISzbVGLfjOE+sEzoBk+wwJBGFFioGnvA5xU+
         RBzhme0SQ7m5uaNPckUlsgAnLaxk/D6b4cM+pjlcHu8T2jdfPD7diiriv/c/4sguFdjK
         N2NiG5nSR2gRhiWWHzlNMmavQaPjUMP9kVdliLuDwE7LGD+zIWEd3on7ArI0K01DZ6On
         sZIEm9CBaul9Uoa/sbd4jXKk/BvLefbk82mVxWGmP3c7e5C6wseT6i5rmshOVf9BIH21
         5NJg==
X-Gm-Message-State: AO0yUKU+Iz+2sOgQeqagNKkwf5ayewOpDY/De9XcnTmpOjFmoPxyUiQ5
        TFe4sZOJ3viykwIG0C3BcSAA0jb7QJuuPnFVI+9eJw==
X-Google-Smtp-Source: AK7set+1t4TfDgOLP72lXzwE5JiDGbuemSC8eqVfaBw8zrXlGh9cqk3+5dCoQINbyKhhguwyt5o6bvNGWkenF1azLJk=
X-Received: by 2002:a17:90a:e81:b0:230:826f:fdd3 with SMTP id
 1-20020a17090a0e8100b00230826ffdd3mr342617pjx.129.1675452787358; Fri, 03 Feb
 2023 11:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20230203173946.gonna.972-kees@kernel.org> <CAFP8O3LdXO4-w57KeX+E2D2rOAv-bK47ur0=8XLgfEkXgB=5eg@mail.gmail.com>
 <63dd5f7a.170a0220.d72b.022f@mx.google.com>
In-Reply-To: <63dd5f7a.170a0220.d72b.022f@mx.google.com>
From:   Fangrui Song <maskray@google.com>
Date:   Fri, 3 Feb 2023 11:32:55 -0800
Message-ID: <CAFP8O3LX+fhgghnUiWD-U5UWOVsG9UPojJHXDPh0V2rdAURP1w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Support Clang UBSAN trap codes for better reporting
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 3, 2023 at 11:24 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Feb 03, 2023 at 11:14:49AM -0800, Fangrui Song wrote:
> > On Fri, Feb 3, 2023 at 9:39 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > When building with CONFIG_UBSAN_TRAP=3Dy on arm64, Clang encodes the =
UBSAN
> > > check (handler) type in the esr. Extract this and actually report the=
se
> > > traps as coming from the specific UBSAN check that tripped.
> > >
> > > Before:
> > >
> > >   Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
> > >
> > > After:
> > >
> > >   Internal error: UBSAN: shift out of bounds: 00000000f2005514 [#1] P=
REEMPT SMP
> > >
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: John Stultz <jstultz@google.com>
> > > Cc: Yongqin Liu <yongqin.liu@linaro.org>
> > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Yury Norov <yury.norov@gmail.com>
> > > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > > Cc: Marco Elver <elver@google.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: llvm@lists.linux.dev
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > v2: improve commit log, limit report strings to actual configs, docum=
ent mappings
> > > v1: https://lore.kernel.org/lkml/20230202223653.never.473-kees@kernel=
.org/
> >
> > Thanks. I'll add the Linux kernel use to
> > https://maskray.me/blog/2023-01-29-all-about-undefined-behavior-sanitiz=
er
> > when this lands:)
>
> Oh nice post! Thanks for the pointer. :)
>
> >
> > > ---
> > >  arch/arm64/include/asm/brk-imm.h |  2 +
> > >  arch/arm64/kernel/traps.c        | 21 ++++++++++
> > >  include/linux/ubsan.h            |  9 +++++
> > >  lib/Makefile                     |  2 -
> > >  lib/ubsan.c                      | 67 ++++++++++++++++++++++++++++++=
++
> > >  lib/ubsan.h                      | 32 +++++++++++++++
> > >  6 files changed, 131 insertions(+), 2 deletions(-)
> > >  create mode 100644 include/linux/ubsan.h
> > >
> > > diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/as=
m/brk-imm.h
> > > index 6e000113e508..3f0f0d03268b 100644
> > > --- a/arch/arm64/include/asm/brk-imm.h
> > > +++ b/arch/arm64/include/asm/brk-imm.h
> > > @@ -28,6 +28,8 @@
> > >  #define BUG_BRK_IMM                    0x800
> > >  #define KASAN_BRK_IMM                  0x900
> > >  #define KASAN_BRK_MASK                 0x0ff
> > > +#define UBSAN_BRK_IMM                  0x5500
> > > +#define UBSAN_BRK_MASK                 0x00ff
> >
> > Q: How is 0x5500 derived?
>
> This is 'U' << 8 from:
> https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/AArch64/AA=
rch64InstrInfo.td#L7571

Ah, yes. I forgot to check the code of 'U'

> > [...]
> > > +#ifdef CONFIG_UBSAN_TRAP
> > > +       register_kernel_break_hook(&ubsan_break_hook);
> > >  #endif
> >
> > IIUC, the break hook is a list so CONFIG_KASAN_SW_TAGS
> > (kernel-hwaddress) can be used with CONFIG_UBSAN_TRAP.
>
> Should I be doing something different here?
>
> > [...]
> > > +#ifdef CONFIG_UBSAN_ALIGNMENT
> > > +       /*
> > > +        * SanitizerKind::Alignment emits SanitizerHandler::TypeMisma=
tch
> > > +        * or SanitizerHandler::AlignmentAssumption.
> > > +        */
> > > +       case ubsan_alignment_assumption:
> > > +               return "UBSAN: alignment assumption";
> > > +       case ubsan_type_mismatch:
> > > +               return "UBSAN: type mismatch";
> > > +#endif
> > > +       default:
> > > +               return "UBSAN: unrecognized failure code";
> > > +       }
> > > +}
> >
> > I wonder whether keeping the dash-prefixed name is better since that
> > matches compiler-rt/lib/ubsan.
> > People can search for "add-overflow" and get cross references from
> > compiler-rt/lib/ubsan, instead of needing to knowing that "addition
> > overflow" is another name for "add-overflow".
>
> I think that the consumer of these messages wants as much plain-language
> detail as possible, so I'd prefer to expand these into full phrasing. To
> make it all more discoverable, I included all the details about how the
> mapping worked in the comments.

Ok, fine with me.

> > [...]
> > Reviewed-by: Fangrui Song <maskray@google.com>
>
> Thanks!
>
> --
> Kees Cook



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
