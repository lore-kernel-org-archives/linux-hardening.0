Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C737C4320E
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B716610CF
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 21:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhHYV4T (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhHYV4S (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 17:56:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431AC0613C1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 14:55:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p15so1223132ljn.3
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxSZH2j2eaq7YbJpNkogw+OvVkZIag0gCuTap1CAdjw=;
        b=kPYP3C82a/M7SugtamQJkWGW6tsr0GCoZasJjWGPGWn/2mFy0X292UYyt2jDo6E1HW
         SXiuK2kkURpEO3A4GKL/UNLg2p2nKC3s35L36EfI9HTEp9JqipvY2CbrnkSXWAgpvyJD
         byjSrQCBb+63UpNYs2OaAM0Qax3/FIjsbcHrEZhU3eHFhxlF48LMEH8wD0EikY1S86+n
         5Ob8nqqP5DQ9N8GGMObnSVbNyOpphaxEYMAdt02FxxFuTTObWvVAQ/6lfCJUQrwH4wvh
         Qkxo3dv0IGM9C18cW1YXfYjbsM6X5U8mp7ejd+iDiF+/U7vb83w1+0C7qiguX6TQ+eIU
         a6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxSZH2j2eaq7YbJpNkogw+OvVkZIag0gCuTap1CAdjw=;
        b=OiXn4OqpUgvJ1eMllUsq4Cs8qP/+GThifIA5Cx+RRAIUysYUpm93N9/G6saxMufet6
         /hygyZfDuY+wHkNw4b5+4SjUeiV17Z9K2CEx9zVOwQcMkQU23ZN6P24CQj1ekJk59Zky
         K3K2MLjt5Qen4ThNX1jhigtn6rUfcFBx4Dhl7kTkLbouYhlw4re/5tkrO7PjSFZzPeuw
         7KUYO+p0nX6TWVf5bJ58fkkGoy1QA2obt8oWJP8pth8qcybpjD4mRtDTPviu4NjX8luo
         JnuZmGqVxgmhZ6jwyclMA4dqn7nP3qAiaQQXaDRb3umFqRMFEgnFEUgloKkCvx4O2pY/
         EeIg==
X-Gm-Message-State: AOAM533MPcsyxOmOkgrrUGRRvHq4Hmekh4O90+kj5O499XwNdpH493RJ
        TWslIICdKGI9fUXEMNrny96KppiNvs+lCFlxy7ETyw==
X-Google-Smtp-Source: ABdhPJxaGr9ffS+ETTZWl7jSA9yzFobVViTrobQlYBli7DBKBt0Qu750YeW7cWfUe4RwlxfOeeNAhe7MJaSJIgKZ/7g=
X-Received: by 2002:a2e:a788:: with SMTP id c8mr321743ljf.116.1629928529265;
 Wed, 25 Aug 2021 14:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-18-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-18-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 14:55:18 -0700
Message-ID: <CAKwvOdnjaBZiPOD35hxb3SLVpV59mYcDBs=YZBz0KrTisULi9Q@mail.gmail.com>
Subject: Re: [PATCH for-next 17/25] fortify: Fix dropped strcpy() compile-time
 write overflow check
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Axtens <dja@axtens.net>,
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
> The implementation for intra-object overflow in str*-family functions
> accidentally dropped compile-time write overflow checking in strcpy(),
> leaving it entirely to run-time. Add back the intended check.
>
> Fixes: 6a39e62abbaf ("lib: string.h: detect intra-object overflow in fortified string functions")
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Francis Laniel <laniel_francis@privacyrequired.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/fortify-string.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 7e67d02764db..68bc5978d916 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -287,7 +287,10 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
>         if (p_size == (size_t)-1 && q_size == (size_t)-1)
>                 return __underlying_strcpy(p, q);
>         size = strlen(q) + 1;
> -       /* test here to use the more stringent object size */
> +       /* Compile-time check for const size overflow. */
> +       if (__builtin_constant_p(size) && p_size < size)
> +               __write_overflow();
> +       /* Run-time check for dynamic size overflow. */
>         if (p_size < size)
>                 fortify_panic(__func__);
>         memcpy(p, q, size);
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210822075122.864511-18-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
