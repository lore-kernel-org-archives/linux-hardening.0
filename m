Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F1ECAAD8
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Sep 2022 10:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiINKOS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Sep 2022 06:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiINKON (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Sep 2022 06:14:13 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B456524C
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 03:14:11 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id o123so15345732vsc.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aVHGh2KXaAGeDBRMRckt00P09mGtnKYfnn7Un16et9k=;
        b=fyFvrZ3JObd/xtxvG5Ow0U9li7MbmyuOhfuVYcFdexiTt688/Bd+KepOFtO6WI7k53
         uvq6Og4MS4pY4OG2UojhtIlYM5kOk6tfs6ZD6venLIjryw2tUtBXnxW1rE9n5bNATZWp
         zu9Z0bEPA98OgeHml0eR0TW5A/k2Pe+Obv1rpRGy3+nlomGS3TXFT8SHLklf7/jT7KG2
         O0leXfG15LQrviHnoZ6vOs/FiCQejxIDJXzWOauQwLxnwtRir/bcabwX2G8x6J3SgMXG
         KakGlgV+9aDtBKfYvDyPARU+oV5a3jzXVceHJB++z7dMF0TbgNuU8qmaNgT6iLIWPQjJ
         T/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aVHGh2KXaAGeDBRMRckt00P09mGtnKYfnn7Un16et9k=;
        b=XCGjd+VpZ+3UnX5TnCxU9T3ll+RSZCVA+bCV+lo89NwcivWqTpsNw7DYO6t/FZsh9A
         aUG29fCEmPQFHYP6CtJlqg9gdmjyXz9+64uvb81x9pk+sN1OYdhCQeVeiiT5a48TmTfr
         DzgVWs3w1AA8qwuEx7HWLquWicJxl0AZxX1a82eWAYBgEhUs/Szdx1PcuChwi74vyVuz
         9KGhStn17rkazoLKYd69ZVhYJgNNhQfKj1E6H8O4/yNM65gp3ocxye34h9bFyQ3MuX/I
         IMBKWJiS9heHf7CyC6r9boPMMSVvStDn2f6nSa6ip8KBlaI9+XjvnICEvoXNjxqdyIJB
         gpFQ==
X-Gm-Message-State: ACgBeo0/xhln8XENFY6PesEZu3U69V1KOyK7YcB4ZlhmJqtMu2XnXFLX
        Anl7xzqnlXfIBNVD1dllz86ijvZ9aDcvWqAX/9PecgzL5rrsUg==
X-Google-Smtp-Source: AA6agR4bxwbfTAdlXC3065+Rj0FOZ3/0/EKkHVL8gqO4/u1CRlKPF0tDXfVxyEweZ5yqatpRrrTT+nzW/SfvGU4zcUo=
X-Received: by 2002:a67:e04d:0:b0:397:f787:7880 with SMTP id
 n13-20020a67e04d000000b00397f7877880mr12930358vsl.71.1663150450866; Wed, 14
 Sep 2022 03:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220913173136.1926909-1-keescook@chromium.org>
In-Reply-To: <20220913173136.1926909-1-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 14 Sep 2022 18:13:59 +0800
Message-ID: <CABVgOSnSsMxHQJNPs77rzA729wW1k6o17_ERqGvszFVkQ-hv_Q@mail.gmail.com>
Subject: Re: [PATCH] fortify: Adjust KUnit test for modular build
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 14, 2022 at 1:31 AM Kees Cook <keescook@chromium.org> wrote:
>
> A much better "unknown size" string pointer is available directly from
> struct test, so use that instead of a global that isn't shared with
> modules.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/lkml/YyCOHOchVuE/E7vS@dev-arch.thelio-3990X
> Fixes: 875bfd5276f3 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Whoops! Thanks Nathan! :) This fixes it for your reproducer.

Ah, this is better than saved_command_line, IMO. I don't think it'd
necessarily be a _disaster_ to just introduce a new dynamically-sized
string here, which would be more explicit, but test->name is at least
obviously related to this file anyway.

Reviewed-by: David Gow <davidgow@google.com>

Cheers
-- David

> ---
>  lib/fortify_kunit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index 99bc0ea60d27..409af07f340a 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -17,7 +17,6 @@
>
>  #include <kunit/test.h>
>  #include <linux/string.h>
> -#include <linux/init.h>
>
>  static const char array_of_10[] = "this is 10";
>  static const char *ptr_of_11 = "this is 11!";
> @@ -31,7 +30,7 @@ static void known_sizes_test(struct kunit *test)
>
>         KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
>         /* Externally defined and dynamically sized string pointer: */
> -       KUNIT_EXPECT_EQ(test, __compiletime_strlen(saved_command_line), SIZE_MAX);
> +       KUNIT_EXPECT_EQ(test, __compiletime_strlen(test->name), SIZE_MAX);
>  }
>
>  /* This is volatile so the optimizer can't perform DCE below. */
> --
> 2.34.1
>
