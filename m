Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D537C77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 22:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjEVWia (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 18:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjEVWi3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 18:38:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF7DB
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 15:38:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bf7bb76d0so2817a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684795105; x=1687387105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OmBpDRSSbwI449wncEKKHIr08pizy/6x6aOd767vrw=;
        b=Je2sOFMeyw4pTXmE/29WmEAUo244TysWAsA0DYFWsnM2gG5UANAC0jyXl/Q3GlDneG
         a0Qb8yIVs7VF5pxprl565rnjkY8SwmCXcV4dH4cmZ7OQVNI3uLxV+OFQ2HXEqY0oADoR
         65J4RJ7YCPJjsxhaYxIxcxNrJTo0abu1P4vIbCDXsf9YWVY0eU7ntUyXHGwzkEOi2MGG
         kAaEFLkAFx5qDeW55/q5NfF+2ErD7boq/7vBaPOrsw5yQcLFMttoYtB6tqGV+pewOPJI
         vSgG68Jq3Wsrak1w2pQJj5L+GY/5NXftoRSnp9WC1OXwa0mtVsMCShK9Y7cCsN7qVPzI
         mxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684795105; x=1687387105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OmBpDRSSbwI449wncEKKHIr08pizy/6x6aOd767vrw=;
        b=boZ5C/VbIwj6jBO6ICgEGP/hCmM2tgc+qrpesnluFWay31q3oH2kzXKAiEAfhtWmoE
         DyBhYL4pcvUdy/NWMb+9nTUbCGr5F0MXwRZUQ+AwiqMLv01YmCU9h4kAzxqYkD9twqv4
         3vU/2NC6shIFm9AAtxcC8nGG0gNcMm5Diue8lnk103wtzxU0oOKPJeZGlM9zHxHDKCWL
         o0PrpFW6XKyQg2Pb3P6AngRlIPdxuK3b4xB4IrK50IFwDezq2VKmmfAzkw5G9OjnUXDE
         JgyCfD6XwHaMjUyWn/dsV1iv6SSJetba6qHKGddtuK6yxcuPtxuuXjooVgjWIUdAR/11
         +SNA==
X-Gm-Message-State: AC+VfDzfJDask2wc7CKR5KW5yj+qhijFJiTG21pKRL5Bd0lQzKZBh4Ry
        G7DctrryA2tGmMZbHUaKCRrTKysu5JCE9fXvRrzb
X-Google-Smtp-Source: ACHHUZ4lJmqdV7xIDj3vLmn1PxNTvQcHwQIDPtQ5dW806lONr5h84EdgwoG2BvvjsS9kQGVQuNBZhF9MeoN/wewjrz4=
X-Received: by 2002:a50:9f05:0:b0:505:863:d85f with SMTP id
 b5-20020a509f05000000b005050863d85fmr42956edf.4.1684795105374; Mon, 22 May
 2023 15:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230522212949.never.283-kees@kernel.org>
In-Reply-To: <20230522212949.never.283-kees@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 22 May 2023 15:38:09 -0700
Message-ID: <CAGG=3QWFHYnUex4ZUYyMp=JNS9PDLjcagkdLbgTdLQf81Xqp_A@mail.gmail.com>
Subject: Re: [PATCH] lkdtm/bugs: Switch from 1-element array to flexible array
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 2:30=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> The testing for ARRAY_BOUNDS just wants an uninstrumented array,
> and the proper flexible array definition is fine for that.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Bill Wendling <morbo@google.com>

> ---
>  drivers/misc/lkdtm/bugs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 48821f4c2b21..224f42cdddf2 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -305,11 +305,10 @@ static void lkdtm_OVERFLOW_UNSIGNED(void)
>         ignored =3D value;
>  }
>
> -/* Intentionally using old-style flex array definition of 1 byte. */
>  struct array_bounds_flex_array {
>         int one;
>         int two;
> -       char data[1];
> +       char data[];
>  };
>
>  struct array_bounds {
> --
> 2.34.1
>
