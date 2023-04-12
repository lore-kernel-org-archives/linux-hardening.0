Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD49FC7619A
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Apr 2023 00:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDLAMj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Apr 2023 20:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDLAMi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Apr 2023 20:12:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F044A3
        for <linux-hardening@vger.kernel.org>; Tue, 11 Apr 2023 17:12:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w11so10217498pjh.5
        for <linux-hardening@vger.kernel.org>; Tue, 11 Apr 2023 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681258356; x=1683850356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUfNHvgbMHbCxR7Z5ej0J4OW6YiW5Ee09V0uQZNWLuA=;
        b=yRuWuTRhiWx3XwFpc57Ol2M1IPyVrYtxZC3LJYOl+z6YsIP1MVABRg2+I1SYgCvB5r
         9ma9A/JibUHa8FeY439yp5Z1o59QK0Jr36B5oqQWOJiPUjdfX83Yl8tuXtbQFh6gLWR8
         dwnI3QGeP/PgL/C7Bi7zDPqNmKSIwYahqjJxsklqdeVWzEfsf3VWL64TZmkx+pwkwv7a
         gY7m98i6jaFqo3atHGNZpP8nwW4Vil4325RnsXUn1l8VDrF2qkisVY/7Id5ooJQIC4gk
         6zn380pEKuZ0vlDDYZsLg2fIGhtIJ61YuSVuQnxwtUt/6ag6cQGbY825Ls8Jf7Edy4hD
         ff9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681258356; x=1683850356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUfNHvgbMHbCxR7Z5ej0J4OW6YiW5Ee09V0uQZNWLuA=;
        b=jPtYuHB80qQyLpwypD9AgVWMwM+oSAkaivgX2NXU7zWwZECUnj9A9CFTzsWi87TZ1s
         tyPhrqN9cdtGl7jk6L5Z35MSAz6mis6XCYQcrfg7/KorZK8EDijt5M29jOTSaTVpUSXe
         C+tmwyLGQ3txwbqUl9PwKYrreri4udi2M4v8+2okOTw/QuvjI+WR0c8syR5CHp6xz3wW
         oZCQDEgBh1NoO1jFSymvU2Q80qzCd/YghbykYgyrx/Lm1m0sOx6HSmGW3AO2ly8g/qzh
         dR9F4MiW4eoi7WyqZ3bbkWyoaLSRYFmMmzK+1p1BERFb6q6v0QfMNAHtL63z23k8vqKc
         HVxA==
X-Gm-Message-State: AAQBX9d4nl3aObRvdDxdd2Hgc7C5VV2YMYSF2l/HYeRpPIT2EYM/vC2a
        ZfU9ydH8ej00AqQHz6M0K4EexVuGbKz5K506QmTl8A==
X-Google-Smtp-Source: AKy350a6v0Bzy8uTYnPo43Z1a0p7U8LI2dM7an6ki1cKagG6JpglxhSHLcrBIVpCj5q+AYqQphGmoJQ/Nqm5Pnc108M=
X-Received: by 2002:a17:90b:3641:b0:244:987c:a873 with SMTP id
 nh1-20020a17090b364100b00244987ca873mr4635662pjb.7.1681258355815; Tue, 11 Apr
 2023 17:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230407215406.768464-1-ndesaulniers@google.com> <20230407215824.GA1524475@dev-arch.thelio-3990X>
In-Reply-To: <20230407215824.GA1524475@dev-arch.thelio-3990X>
From:   Fangrui Song <maskray@google.com>
Date:   Tue, 11 Apr 2023 17:12:24 -0700
Message-ID: <CAFP8O3+YzvwgeSS_GvU3oTtxunyUm8qMaAnV3Mt-ezTsxZ=Q0Q@mail.gmail.com>
Subject: Re: [PATCH] ubsan: remove cc-option test for UBSAN_TRAP
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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

On Fri, Apr 7, 2023 at 2:58=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Fri, Apr 07, 2023 at 02:54:06PM -0700, Nick Desaulniers wrote:
> > -fsanitize-undefined-trap-on-error has been supported since GCC 5.1 and
> > Clang 3.2.  The minimum supported version of these according to
> > Documentation/process/changes.rst is 5.1 and 11.0.0 respectively. Drop
> > this cc-option check.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> As an aside, we should really consider having some standard format of
> comment around cc-option checks so that we can easily remove them when
> they become stale...
>
> > ---
> > Masahiro, Kees: get_maintainer.pl leaves much to be desired for this
> > file. Can one of you please pick this up?
> >
> >  lib/Kconfig.ubsan | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > index fd15230a703b..0e7ad0782399 100644
> > --- a/lib/Kconfig.ubsan
> > +++ b/lib/Kconfig.ubsan
> > @@ -15,7 +15,6 @@ if UBSAN
> >  config UBSAN_TRAP
> >       bool "On Sanitizer warnings, abort the running kernel code"
> >       depends on !COMPILE_TEST
> > -     depends on $(cc-option, -fsanitize-undefined-trap-on-error)
> >       help
> >         Building kernels with Sanitizer features enabled tends to grow
> >         the kernel size by around 5%, due to adding all the debugging
> > --
> > 2.40.0.577.gac1e443424-goog
> >
>

-fsanitize-undefined-trap-on-error is a legacy option from 2013 when
-fcatch-undefined-behavior instead of -fsanitize=3Dundefined enabled
UBSan.
On the Clang side, http://reviews.llvm.org/D10464 added
-fsanitize-trap=3D in June 2015.
It's best to use -fsanitize-trap=3Dundefined and avoid uses of
-fsanitize-undefined-trap-on-error.



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
