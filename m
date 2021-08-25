Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA2C4320A
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 22:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7B960EE0
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 22:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhHYWCz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 18:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhHYWCy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 18:02:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D17C0613C1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 15:02:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z2so2074957lft.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ap07zgvRCzHUWZsKzTqV0nv5eVeNrhiykOkW+2Q+N8I=;
        b=V0RfDdAyEknz5KXI21deyJWGKBtldhdU7eYU32v3+FYtF8NzVK6ypPcrEQF8iGVh9+
         R31/nL49iM2YuRMj6y07FYcnclwCqu87K4SCTWIdrCiyF816igVvCdfHYrfhyJ+UMKZJ
         YrIH5Sd3c7JRcix5m4U4SC4LSMyIbi24SUN22kt6fPeCw9xxYZe1jh0C2Aqi/HH0Tq5l
         K+1tLSG8Uzo4O2xuhUFeKcfFkgWa8dmjcF24ogJxzOUGVIddLld72otsgtWnMrEgJajR
         KrTIFh/vHsTkdSwzHCZwABYf8Li+J/BY75/krxwgZCKkUKe9uSRWfpqG3hKooSdUFzhU
         WbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ap07zgvRCzHUWZsKzTqV0nv5eVeNrhiykOkW+2Q+N8I=;
        b=hmNewilRUFOE/mOCIaAtXn1u8Q3Ei+5Q21bAuivr23IjUivNFWZ/Fj4vp3qYrRWARh
         75YpaVw6+3Aq6y6lf/Apn2/kzKtWnZkBfnHdJ9q0V0TFRU6MVsykR+xAbJiMWJd50Aa6
         tpko6Q+rDQsF5l4QkNnpARsd7m5vWMr2r36CcBUqNlSgDkDlGc3stiRnO2coZ1ODUabG
         wQwG06/qVjWbWJXT0HiFXO707+gEaGsBOQ+vEuQ/uY9s4lKG8Yfb4Y1McJSurEOQ3mXa
         4gUB00xULlCG5LQIcESCo6awzBWlePeQvzEscMOKe6Fer8IrY5n0STTD3EgrcnzT9Wm6
         BZsg==
X-Gm-Message-State: AOAM533r+ytFi8S6dUV3czZYPwcUVJkUYPdMb2Sp3VRR4vMKfMggqFh7
        WzoXcFp4qO97pTCIT0oz/sxW/ba6xHZ0MJ99A9ZqSQ==
X-Google-Smtp-Source: ABdhPJww2+7yBE9cppy9XJx9RGtuG2b3Nw6jhEEVvCLdZyZzODN88Y5xBICzIm0DAaG/K8nuxqq2bli3ZyrX9IeaqDE=
X-Received: by 2002:a19:f017:: with SMTP id p23mr190205lfc.547.1629928926500;
 Wed, 25 Aug 2021 15:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-19-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-19-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 15:01:54 -0700
Message-ID: <CAKwvOdmYP=-SOpjEX+J8KzvkhpH9LXFrHEUob2w5LxiSMwn_0w@mail.gmail.com>
Subject: Re: [PATCH for-next 18/25] fortify: Prepare to improve strnlen() and
 strlen() warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Aug 22, 2021 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> In order to have strlen() use fortified strnlen() internally, swap their
> positions in the source. Doing this as part of later changes makes
> review difficult, so reoroder it here; no code changes.
>
> Cc: Francis Laniel <laniel_francis@privacyrequired.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/fortify-string.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 68bc5978d916..a3cb1d9aacce 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -56,6 +56,17 @@ __FORTIFY_INLINE char *strcat(char *p, const char *q)
>         return p;
>  }
>
> +extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
> +__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
> +{
> +       size_t p_size = __builtin_object_size(p, 1);
> +       __kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
> +
> +       if (p_size <= ret && maxlen != ret)
> +               fortify_panic(__func__);
> +       return ret;
> +}
> +
>  __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
>  {
>         __kernel_size_t ret;
> @@ -71,17 +82,6 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
>         return ret;
>  }
>
> -extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
> -__FORTIFY_INLINE __kernel_size_t strnlen(const char *p, __kernel_size_t maxlen)
> -{
> -       size_t p_size = __builtin_object_size(p, 1);
> -       __kernel_size_t ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
> -
> -       if (p_size <= ret && maxlen != ret)
> -               fortify_panic(__func__);
> -       return ret;
> -}
> -
>  /* defined after fortified strlen to reuse it */
>  extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
>  __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210822075122.864511-19-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
