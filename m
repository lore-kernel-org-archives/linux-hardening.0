Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D5C38A2D
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Oct 2022 18:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiJZS0w (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Oct 2022 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiJZS0v (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Oct 2022 14:26:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A382625
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 11:26:50 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c8so11577421qvn.10
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v3TrCD3rKy7ECmCNklfjzMUU1ItZed04yLxmZz8iGiA=;
        b=c7Pv0diJ7cfnwwoP1PvT1EctizPOp1wxiFORNv0ZoJu9OyyXRkjxZzfuEbyJonQnbF
         xn9gU9nG/RsQGqW/3OxFcW1k6IvPzYHoTzW4xnLPu0l7Vvwivo+kliOcBtaD4MGySTdt
         KO0JVKm8QHCR6H3LKQnLDOpscClbmkuYSUILznjaxZYYjTSI3Tde7enfvPqGRykvim93
         /5gMpRWRf25qGdOOGsYygP35kZJt9VgvpT6hgQLJiuwVL3YyKYHO2exkk28DzJQAKQOL
         /7Wse0mTLnkDgvpr1s2Q2aF4vED+SvIyYxLO+xmA1PIUjDQ2fHYrWIqInH3ZLGj8BsWL
         t8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3TrCD3rKy7ECmCNklfjzMUU1ItZed04yLxmZz8iGiA=;
        b=I/DUyHdZwf999cEFg9savHaUAsjHr+Vk25ZwWEaWYDLI5A/6ydeA5AsmvUyC+gDesp
         0YrkIIirTEO9KoSxAOG74ZjTg/q3SUNCcn9KKsP5uDgYmYYJvkqLFc/RWP8LLWKb7VQk
         34aFaJkSanRWB/YbXLwMT8oxnq2CmidsBoqM0phrNZPGBNzToVm6cnSOuyleY1gJoK+j
         KnXJ/CIh7kmt1lMI8IxREuXfC4OfF9vOSmbEoEXW+uCFSYTptW9guVCQ7EOiDW5XC7s1
         Z+0PZa6PD+VAcXCKlqmeooQg7qC3NLwj3xWRHVgrxFQ4FZ3QUzzohjEODg/EhOLZCzZ1
         nTFQ==
X-Gm-Message-State: ACrzQf1pUbbRfqmDLILA6jmWCn5KkTq6OovCH+are9+TDj3vkPTje+rj
        lV6GeOogZPOdvpgami+lbI0sJ9Cv95Vz6lxlc+gYAYic6yGggA==
X-Google-Smtp-Source: AMsMyM6IdRphRBbG3V6yzZv6ryLQEqD8f/xfny37uZa7Nfjs/0O81S+227ql8F1ywU15jYLCGwCgluMf4ZTkJxzCw1c=
X-Received: by 2002:a17:902:b218:b0:184:710c:8c52 with SMTP id
 t24-20020a170902b21800b00184710c8c52mr45212107plr.95.1666808799104; Wed, 26
 Oct 2022 11:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221025231627.never.000-kees@kernel.org>
In-Reply-To: <20221025231627.never.000-kees@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Oct 2022 11:26:27 -0700
Message-ID: <CAKwvOdkDaSQZ_e0hX0ggNqsWn+=0xyqMdbf6J+YW0-iZ=ewViQ@mail.gmail.com>
Subject: Re: [PATCH] fortify: Do not cast to "unsigned char"
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 25, 2022 at 4:17 PM Kees Cook <keescook@chromium.org> wrote:
>
> Do not cast to "unsigned char", as this needlessly creates type problems
> when attempting builds without -Wno-pointer-sign[1]. The intent of the
> cast is to drop possible "const" types.
>
> [1] https://lore.kernel.org/lkml/CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com/
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 3009f891bb9f ("fortify: Allow strlen() and strnlen() to pass compile-time known lengths")
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index f3dd5d1a6a25..09a032f6ce6b 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -18,7 +18,7 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
>
>  #define __compiletime_strlen(p)                                        \
>  ({                                                             \
> -       unsigned char *__p = (unsigned char *)(p);              \
> +       char *__p = (char *)(p);                                \

If the intent of __p is to avoid repeated application of side effects
from the evaluation of the macro parameter p, this could also be:

__auto_type __p = (p);

I think this is nice because it doesn't strip potential const
qualifiers from the macro parameter.

>         size_t __ret = SIZE_MAX;                                \
>         size_t __p_size = __member_size(p);                     \
>         if (__p_size != SIZE_MAX &&                             \
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
