Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A6BC83F01
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 21:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjH3VCj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbjH3VCj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 17:02:39 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D8E1B1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 14:02:02 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so917545e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693428944; x=1694033744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGxGsSt4NIbvMer12GEtMD95qVZZXJT3njM8Rf3Knrg=;
        b=g+xI+jhvpKx9uEcxHVEve+jjV2BZ6NCc+vRNq88rJoxN1JhIxPJQScfRl7oQmgnR1h
         wxijQJhwSWXAnV+I8Ju71XHjCqQqniKLbtSzXxp90YkwBE9ACi4tTuujobVMiRsMkqCn
         e4vftKRgE0EjsSHwSS4v7vA+WMFGMdweg8+5LS9WnrJhm4axuzWCk6VWGzJEpN5/agbk
         pZquVW4POitpsQC5HnMqNY/Jwc7Z4oPjPD/YYqQ6hB+nmyvIXxX2ITyg8Yd1EoGTHHdn
         bcH9CWMEdfYWUBR6ra9QyZQiYnElxN25r8iddvDKseW98jW9rLW8NKBpEJ3SbFoXKfTp
         13NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428944; x=1694033744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGxGsSt4NIbvMer12GEtMD95qVZZXJT3njM8Rf3Knrg=;
        b=iAVSoAokxSq29OMO5ttP7T6/3cAq4BjUSwp0u0NO0mJjLdc54lqWUqdETkS25tMIHU
         ZK4rRBwwUvgJecjuPl2QwO0bTUfMwmXKbnH7XukhrQrMsu+WY1YT4ZidDlnhPRq3iNUS
         puMrnNci5A3Od9jjR1iVEbl6Pkbzu3ZZycHRJVDuX/Pu0FtHApQwCDQm+sS+jmdHk9+m
         FfQnbageNXXviNjkIoBL8W3r+JhQd5ZwTwJOmPMO1JQO9jTuAE9qlZfEHCG0H9tX7sRg
         l7hsaHHyIv1nR02ecJSwC5PxaDZNTN8+2EWTxzVh2/ZeyEsiyxIoRlvgcLky1rFkenrk
         R5Pg==
X-Gm-Message-State: AOJu0YxZxjuCjKyedMhCnNK8LB3ibh+v8cXJyrzC0KKKip9tZzQZVXlO
        RlX4Yqov51fw8cVz1Eq1uvRHDmeTkC5ZuUgBAWLydNL84RTIgc3dTXu7gg==
X-Google-Smtp-Source: AGHT+IGvr8r7wcRDT1BESk7m579e6n9dy6u1pTfteN4ENqgGAendGDssO0IA1rpPNl/A0Cq/tJqaVjI3NhqNnSurerw=
X-Received: by 2002:aa7:d1c7:0:b0:523:c10d:1d5b with SMTP id
 g7-20020aa7d1c7000000b00523c10d1d5bmr2630745edp.37.1693426126942; Wed, 30 Aug
 2023 13:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 30 Aug 2023 13:08:35 -0700
Message-ID: <CAFhGd8q3CutOKOcJpny=-5SuMWvMy0EZOLQHLkLuu_BOAPOMig@mail.gmail.com>
Subject: Re: [PATCH] init/version.c: Replace strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 30, 2023 at 12:29=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.=
com> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).

Great patch! This is similar to [1] which aims to eradicate strncpy.

>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  init/version.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/init/version.c b/init/version.c
> index f117921811b4..94c96f6fbfe6 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -21,10 +21,10 @@ static int __init early_hostname(char *arg)
>  {
>         size_t bufsize =3D sizeof(init_uts_ns.name.nodename);
>         size_t maxlen  =3D bufsize - 1;
> -       size_t arglen;
> +       ssize_t arglen;
>
> -       arglen =3D strlcpy(init_uts_ns.name.nodename, arg, bufsize);
> -       if (arglen > maxlen) {
> +       arglen =3D strscpy(init_uts_ns.name.nodename, arg, bufsize);
> +       if (arglen < 0) {
>                 pr_warn("hostname parameter exceeds %zd characters and wi=
ll be truncated",
>                         maxlen);
>         }
> --
> 2.41.0.255.g8b1d071c50-goog
>
>

[1]: https://github.com/KSPP/linux/issues/90
