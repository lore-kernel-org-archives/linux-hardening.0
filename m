Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2B3EC8747
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Sep 2023 00:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbjIHAEf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 7 Sep 2023 20:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjIHAEf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 7 Sep 2023 20:04:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6219D
        for <linux-hardening@vger.kernel.org>; Thu,  7 Sep 2023 17:04:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so26762121fa.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 Sep 2023 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694131469; x=1694736269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiQCKbyXB8abg8qGcuuiBGfaep6ol1DgaRx2mq6P7fA=;
        b=Yngk7s+RlfrEaTRKkZz29yVVqPnJqkMayx3YFBHQLzIeudgk9wTfGfUo6b9ptfhZax
         AuYFR1UxCH1+RWCktvJaldUxK3h22sqSSCXp/sgkLa8v6qMedG2L3L/fC1/Hdd2NKHAC
         ldCTaeK1+DwJXfvDryRKLyBTkefoHvR0cU7rCl+vFJ7pKcZ0VtOiz+n+t6dePV0GVINY
         KRFZx32/O9LjEZI14mbYb1wlA7WlKiVA7YKb2E7UigM9qvw5MvmNmBe+ZpyyQAahzBHe
         Wf6Eoh2nbhDXwjoflvSIk4PtTHafY70Yqdwxf9Q3mNpD5hxmlqGHA/55pqoAX0VaTtGF
         uwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694131469; x=1694736269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiQCKbyXB8abg8qGcuuiBGfaep6ol1DgaRx2mq6P7fA=;
        b=fLiGt5cSmWltvoSwFmlEC8qNonaifx/JbgVQjpIxJYWIE2KS3C2NLaGmAWb5AP91wj
         XQoJfQIVaHkpJ8Ovp9g97wUZ2iB4E17Kfcbu5gPvbs+JopyBV+sxeMX2oE+chGLjg3oY
         JraAKIIm6qbq0LQrP3+oy7N9u7RlaHtuCtJnXVRbtY+Is1dc6Bdc099DNIaZAYFDU+M0
         P8Y6yXxtUZ+gu3G/ZgVwqPEC78FVaOUn+7b9wLbqMTRcM8rxRSgBd46nD5FffQbonfr4
         HQ8bNtsktfxsd7mP9G/vzRW2eSe7dWobu+7mu6++jVrOHRALBnXxrSJcsOcp9W11BWcl
         qT+A==
X-Gm-Message-State: AOJu0Yy+qJylkSNvm/9hdjMdpaGoQaTi8h3gkPZ+WoRhFsFAW92j7vkN
        cf4CZXP8oqaDhH/sdQuXeK6z8beQmYLky+bcljNIMg==
X-Google-Smtp-Source: AGHT+IHPF0FPZiC2uV97EcJOPkwMbXmVJ7HuCxJNzq4UIytQxII5P52NpTrwgUQRKfeNKpQClu024wWCpT6hJqBPooE=
X-Received: by 2002:a2e:880d:0:b0:2bc:b821:84ad with SMTP id
 x13-20020a2e880d000000b002bcb82184admr419405ljh.16.1694131469048; Thu, 07 Sep
 2023 17:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com> <amh6pp2mkmn22jcvz5tva7c4aaqxaq7zaz6v5u6rb7emsqp6p2@nxd7ynj524sx>
In-Reply-To: <amh6pp2mkmn22jcvz5tva7c4aaqxaq7zaz6v5u6rb7emsqp6p2@nxd7ynj524sx>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 7 Sep 2023 17:04:18 -0700
Message-ID: <CAFhGd8qj+FOXjmBKUURR7fqwda-GVDUXtk8+xN65kYEoODP3VQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/sysreg: refactor deprecated strncpy
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 7, 2023 at 2:23=E2=80=AFPM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
> On Fri, Aug 11, 2023 at 04:33:51PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1]. Which seems to be the case here due to the forceful setting of `bu=
f`'s
> > tail to 0.
> >
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy`!
> >
> > In this case, we can simplify the logic and also check for any silent
> > truncation by using `strscpy`'s return value.
> >
> > This should have no functional change and yet uses a more robust and
> > less ambiguous interface whilst reducing code complexity.
> >
>
> I'm sorry, but this patch is wrong.
>
> __parse_cmdline() is supposed to match the command line against a set of
> keywords, one word at a time. The new implementation ignores the
> word-boundaries and matches the whole command line once and then breaks
> the loop, typically without having found a match. (See below)
>
> Can we please have this patch dropped, Will?
It has been, I believe. At any rate, a v4 is up [1] which prefers
memcpy over strncpy.

>
>
>
> Also, the commit message is a blanket statement about why strscpy is
> better than stncpy, but I don't see how this is applicable to the code
> it attempts to "fix". Afaict the code already handled these cases.
>
> > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on=
-nul-terminated-strings[1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Changes in v2:
> > - Utilize return value from strscpy and check for truncation (thanks Ke=
es)
> > - Link to v1: https://lore.kernel.org/r/20230810-strncpy-arch-arm64-v1-=
1-f67f3685cd64@google.com
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
> >  arch/arm64/kernel/idreg-override.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idr=
eg-override.c
> > index 2fe2491b692c..aee12c75b738 100644
> > --- a/arch/arm64/kernel/idreg-override.c
> > +++ b/arch/arm64/kernel/idreg-override.c
> > @@ -262,9 +262,9 @@ static __init void __parse_cmdline(const char *cmdl=
ine, bool parse_aliases)
> >               if (!len)
> >                       return;
> >
> > -             len =3D min(len, ARRAY_SIZE(buf) - 1);
>
> Here "len" was either the number of bytes to the first space, the end of
> the string, or the last byte in "buf".
>
> > -             strncpy(buf, cmdline, len);
>
> So this will copy one word, or the rest of the string.
>
> > -             buf[len] =3D 0;
>
> And it will NUL-terminate the word, which is then matched upon below.
>
> > +             len =3D strscpy(buf, cmdline, ARRAY_SIZE(buf));
>
> In this new implementation, the code copies the rest of the command line
> to "buf", makes an attempt to match with with the keywords, and then
> breaks the loop (as cmdline + len is the end of the string).
>
> Regards,
> Bjorn

[1]: https://lore.kernel.org/all/20230905-strncpy-arch-arm64-v4-1-bc4b14ddf=
aef@google.com/
