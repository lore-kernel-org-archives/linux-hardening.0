Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB02FC77B73
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Apr 2023 21:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjDSVCh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Apr 2023 17:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDSVCg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Apr 2023 17:02:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6EB3AA4
        for <linux-hardening@vger.kernel.org>; Wed, 19 Apr 2023 14:02:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a7ff4a454eso245935ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Apr 2023 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681938153; x=1684530153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyuMuSEmljtk0uCa6yhRHNZgUIVDVBS+k9XudbHJtvA=;
        b=NLbpzlPuW8YRaR7ZBfd0UwmtozZCtfufOPiJKcb35nvfU47ArbMZnKzXT9sTLnPcAd
         8hGNdip4XvNJ1W30z1IamXiX8dojcLP5mHGNP15iARHvhyrxIYKCL1e1d3hw8uiZw4he
         RgSaMrvD5/t21c+F8wgj9LosNvR62bx60wUJ/YepUxY2pRSPXO0BdRnRruGKemettefF
         tl4JDGzAjbd5Se/Qhmsl08Ny1XxweGrnlGIsPe/vdEOKT3F/kaZGgXdr1OqZIdS4uzE0
         +EWnazDNHkXXCjuLflA2bfaGsJurFYAwDvlhzBX4cQTthY/3OM9yRDWrhX/tIF1W5kGM
         s5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938153; x=1684530153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyuMuSEmljtk0uCa6yhRHNZgUIVDVBS+k9XudbHJtvA=;
        b=YmUWZw/4DDJtpFHKuIN0sn2fC3U14MidM9eadQZFQL6jELRZWvabAbZLGNIcBJSryF
         dy7KGFjydlwOInQ9+j8wk+PAtPkUP9giyZiMxlWlab99qTKyyGnPu3VBj6b35QDlHfA+
         ryQx/CxINeupFN7RkN4UJ+5j/51zxP3rspqYzyEAibbOV2BCyTHBJ9bZez3llDaub4FU
         gs1dP58dYqkDrBepQasfqOWSTAN9nRpLMtKZ7jvKEGfRaWjnJ59kTbkebgORQfsh9FD8
         hF7zZlcHyNKR9c/zHEm3IduHzxxQGXazmNnOqOZban+16aRo7HDmxQ9SJbCfsm3ww7Ig
         foww==
X-Gm-Message-State: AAQBX9dpbaCq85Tmpd3ISaUOvLH1JqhCufAsc07NTXoupeMjfHl5cCau
        LDaHsiYLbvNvwXlnWMNviDACuQloWOwK+q6CuvOY6w==
X-Google-Smtp-Source: AKy350ZXTlD268fHGIdwqk/FY6ac3wDAgmgs4JQ5UlJgaWyoePq9l7arX6DBkVc0TCMFe1Cz2LdzUs6aEd9TtMqSCXc=
X-Received: by 2002:a17:902:f70e:b0:198:af50:e4de with SMTP id
 h14-20020a170902f70e00b00198af50e4demr76325plo.4.1681938152739; Wed, 19 Apr
 2023 14:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230407215406.768464-1-ndesaulniers@google.com>
 <20230407215824.GA1524475@dev-arch.thelio-3990X> <CAFP8O3+YzvwgeSS_GvU3oTtxunyUm8qMaAnV3Mt-ezTsxZ=Q0Q@mail.gmail.com>
 <6436ca47.a70a0220.e83cf.adf4@mx.google.com> <CAFP8O3K2c-7wCeDrxPaFpNe-yV9M1g0BPQw7qA6JdpUD74dC1w@mail.gmail.com>
In-Reply-To: <CAFP8O3K2c-7wCeDrxPaFpNe-yV9M1g0BPQw7qA6JdpUD74dC1w@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Wed, 19 Apr 2023 14:02:21 -0700
Message-ID: <CAFP8O3K1pO7AAMDeDyiSj3jCL2aOm_X88sUf5yZ4onc3whr9Jw@mail.gmail.com>
Subject: Re: [PATCH] ubsan: remove cc-option test for UBSAN_TRAP
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-hardening@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Apr 12, 2023 at 11:13=E2=80=AFAM Fangrui Song <maskray@google.com> =
wrote:
>
> On Wed, Apr 12, 2023 at 8:12=E2=80=AFAM Kees Cook <keescook@chromium.org>=
 wrote:
> >
> > On Tue, Apr 11, 2023 at 05:12:24PM -0700, Fangrui Song wrote:
> > > On Fri, Apr 7, 2023 at 2:58=E2=80=AFPM Nathan Chancellor <nathan@kern=
el.org> wrote:
> > > >
> > > > On Fri, Apr 07, 2023 at 02:54:06PM -0700, Nick Desaulniers wrote:
> > > > > -fsanitize-undefined-trap-on-error has been supported since GCC 5=
.1 and
> > > > > Clang 3.2.  The minimum supported version of these according to
> > > > > Documentation/process/changes.rst is 5.1 and 11.0.0 respectively.=
 Drop
> > > > > this cc-option check.
> > > > >
> > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > >
> > > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > >
> > > > As an aside, we should really consider having some standard format =
of
> > > > comment around cc-option checks so that we can easily remove them w=
hen
> > > > they become stale...
> > > >
> > > > > ---
> > > > > Masahiro, Kees: get_maintainer.pl leaves much to be desired for t=
his
> > > > > file. Can one of you please pick this up?
> > > > >
> > > > >  lib/Kconfig.ubsan | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > > > > index fd15230a703b..0e7ad0782399 100644
> > > > > --- a/lib/Kconfig.ubsan
> > > > > +++ b/lib/Kconfig.ubsan
> > > > > @@ -15,7 +15,6 @@ if UBSAN
> > > > >  config UBSAN_TRAP
> > > > >       bool "On Sanitizer warnings, abort the running kernel code"
> > > > >       depends on !COMPILE_TEST
> > > > > -     depends on $(cc-option, -fsanitize-undefined-trap-on-error)
> > > > >       help
> > > > >         Building kernels with Sanitizer features enabled tends to=
 grow
> > > > >         the kernel size by around 5%, due to adding all the debug=
ging
> > > > > --
> > > > > 2.40.0.577.gac1e443424-goog
> > > > >
> > > >
> > >
> > > -fsanitize-undefined-trap-on-error is a legacy option from 2013 when
> > > -fcatch-undefined-behavior instead of -fsanitize=3Dundefined enabled
> > > UBSan.
> > > On the Clang side, http://reviews.llvm.org/D10464 added
> > > -fsanitize-trap=3D in June 2015.
> > > It's best to use -fsanitize-trap=3Dundefined and avoid uses of
> > > -fsanitize-undefined-trap-on-error.
> >
> > But that's Clang-only. -fsanitize-undefined-trap-on-error works for bot=
h
> > GCC and Clang.
> >
> > --
> > Kees Cook
>
> Just filed a -fsanitize-trap=3D feature request for GCC:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D109489 :)
>
> https://reviews.llvm.org/D10464 (2015) does mention the state of the
> legacy option:
>
>   // https://clang.llvm.org/docs/UsersManual.html#cmdoption-fsanitize-und=
efined-trap-on-error
>   -fsanitize-undefined-trap-on-error
>   Deprecated alias for -fsanitize-trap=3Dundefined.

Circling back. it seems that GCC 13 will have
-fsanitize-trap=3Dundefined (a commit from 2022-06).
The current https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html
says "The -fsanitize-undefined-trap-on-error option is deprecated
equivalent of -fsanitize-trap=3Dall."

We need to discourage further uses of the deprecated
-fsanitize-undefined-trap-on-error.
