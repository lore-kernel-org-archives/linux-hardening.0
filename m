Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27443C001B0
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 19:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjHJTZw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjHJTZv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 15:25:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101DC90
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 12:25:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso1991392e87.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691695549; x=1692300349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui+/RSFXmkly+Of7wEIbSn+oHjGwlO6sa+YZNmyTY50=;
        b=l6LqtvqZLaxvJv63CGdQtShhMNo5V3oeupCcmXrj6nB7XuGP8Yk7woCX6WlBjOrz0v
         rZaGwyi+q2UN5xhK3mwVEzJr8CxeWQf8mGUnD5qJswfQ31mDqv2dl7UpuR+3g5cazkq9
         CFJ5g7BIBWu7Th36zvxWD0y/j9VMHSUy5XEUR9OGt3dISEw34bQOIU0vqNaQkj4xkAT9
         nBmLsJg8mA5stqU7zdtUQ2LctSisqOQBn8M9pUQSnY+OBOut9wHeWojfPu4rVWjgOpXc
         Ai/QhnQNzasBPSsYbpx2dc6KAKpbAkKQZzM5A5hJ5yiXCZ/ymkh0RnndgU5MuHbrltxt
         Nk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695549; x=1692300349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui+/RSFXmkly+Of7wEIbSn+oHjGwlO6sa+YZNmyTY50=;
        b=NSMuVGBywrFN7COKiNGvdUdNT3C2wGXXvA/Qv0o9yxsWs1PPVr1T8aZ/T9R8h/iYls
         +KDxxxMj4KB7o7HDh8qHcMhj7A3EaQHynPmoBWmASIm3CJla7ul3atbjWvhqi+cBm70T
         VrpvD9Jb8QqqUXU/C9t7/Hx6tTBfxgcQJV4FHz0r8Aa/g4afv/PW+TeUl0AZw1LPiByD
         utvqM0WyJoVzlGsg/NBvqXdoriZgs9fVrzhCJIeyxceyazIvIu2fPgzQEjrZ8azIhpJx
         kJ6saEka44r8OplLn/tb7MewAnSgwbZva4XQnPUBUnddEjlDD4Fed2i+AARHpGF9uXGQ
         Zhow==
X-Gm-Message-State: AOJu0YxBDjVYmoRXFAh6Hx8a5M+xiRnbZt8oFoRlZGnHrvlzLg1oM8JH
        t0dT7xz0sQ2/EJUt2BkoOgW2LdjVEmUrZ8W9IAe+KA==
X-Google-Smtp-Source: AGHT+IE1itl2Nxd6jMhWYziw9rWyGoEFs0VONyLJLFt1oFHZH0GsZu34WACRjlRzmNy4o7UTtSGvLg/e396OjToi3VE=
X-Received: by 2002:a05:6512:32d1:b0:4fb:7c40:9f95 with SMTP id
 f17-20020a05651232d100b004fb7c409f95mr2818211lfg.47.1691695549065; Thu, 10
 Aug 2023 12:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com> <202308101155.81497C5B@keescook>
In-Reply-To: <202308101155.81497C5B@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 10 Aug 2023 12:25:37 -0700
Message-ID: <CAFhGd8rfKLY5KujEdvSnqv2MZFhTbEBo_bi7xVacY1pcBC1jRg@mail.gmail.com>
Subject: Re: [PATCH] arm64/sysreg: refactor deprecated strncpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 12:00=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Thu, Aug 10, 2023 at 06:39:03PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1]. Which seems to be the case here due to the forceful setting of `bu=
f`'s
> > tail to 0.
>
> Another note to include in these evaluations would be "does the
> destination expect to be %NUL padded?". Here, it looks like no, as all
> the routines "buf" is passed to expect a regular C string (padding
> doesn't matter).
>
> >
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy`!
> >
> > In this case, there is some behavior being used in conjunction with
> > `strncpy` that `strscpy` already implements. This means we can drop som=
e
> > of the extra stuff like `... -1` and `buf[len] =3D 0`
> >
> > This should have no functional change and yet uses a more robust and
> > less ambiguous interface whilst reducing code complexity.
> >
> > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on=
-nul-terminated-strings[1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> >
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > For reference, see a part of `strscpy`'s implementation here:
> >
> > |     /* Hit buffer length without finding a NUL; force NUL-termination=
. */
> > |     if (res)
> > |             dest[res-1] =3D '\0';
> >
> > Note: compile tested
> > ---
> >  arch/arm64/kernel/idreg-override.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idr=
eg-override.c
> > index 2fe2491b692c..482dc5c71e90 100644
> > --- a/arch/arm64/kernel/idreg-override.c
> > +++ b/arch/arm64/kernel/idreg-override.c
> > @@ -262,9 +262,8 @@ static __init void __parse_cmdline(const char *cmdl=
ine, bool parse_aliases)
> >               if (!len)
> >                       return;
> >
> > -             len =3D min(len, ARRAY_SIZE(buf) - 1);
> > -             strncpy(buf, cmdline, len);
> > -             buf[len] =3D 0;
> > +             len =3D min(len, ARRAY_SIZE(buf));
> > +             strscpy(buf, cmdline, len);
>
> This, however, isn't correct: "cmdline" will be incremented by "leN"
> later, and we want a count of the characters copied into "buf", even if
> they're truncated. I think this should be:
>
>                 strscpy(buf, cmdline, ARRAY_SIZE(buf));
>                 len =3D strlen(buf);
>
Thoughts on using the return value from `strscpy` here?

> -Kees
>
> >
> >               if (strcmp(buf, "--") =3D=3D 0)
> >                       return;
> >
> > ---
> > base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> > change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
>
> --
> Kees Cook
