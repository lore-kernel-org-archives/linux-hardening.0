Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31011C77B71
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Apr 2023 09:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjDFJLv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Apr 2023 05:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbjDFJLt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Apr 2023 05:11:49 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC019D
        for <linux-hardening@vger.kernel.org>; Thu,  6 Apr 2023 02:11:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id u97so3332589ybi.10
        for <linux-hardening@vger.kernel.org>; Thu, 06 Apr 2023 02:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680772308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8kd1BcfwPPSqwXTX0SEVb5soTBP6qJhq+QXHtHsYn9Y=;
        b=a++H6iu7o/Cl0qisj3TeHIvqYQ1G2yInrxtOqcuj+73vykQfjPOzZ59oE+o6MpUfHl
         cDN/C2oe8jFPpaPIx9kvb6uUaSDAfhswh1ZaMcmOTDLfjgcQTTipom/KagLe1f0rkHA6
         SD2rv1EGBznEj8ImNCMljoM8bbpFMaZwyx+xflXOCue5CXK0N1O3NyaHoD2yhfDcqe+M
         g0LUPutgX7NXar8Mvq+ekBGjq4c5wS6Vwc2OCkts5qGym2W2480J1OcJp7RYRBmeUKDS
         yd5+xcCSU/NjiCQsmoxoFJaCA/SShUWYlOosVPErN5dGrPPOGoPBRCJb2Uv5q7wSYrjQ
         upLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680772308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kd1BcfwPPSqwXTX0SEVb5soTBP6qJhq+QXHtHsYn9Y=;
        b=JfNvFIkCId/6xUY1YIChswgh6xz+ttvb3A7GGj25AN6ayqyb4o7yOaDp944FjIID2w
         Dfr6POfwO8nTOrYyNK2mzvbDNnTlM270uEXYQXtOovwSoxfgHFFWV93aKmI5vsHbr5jQ
         gFoYk6VrWWjoxadrNBxE5K+2kKzKYTu/Ki7NU5leLBGJ9aN+z1HmSW8zk3UFXmunnjAW
         GASRdHhbbPaqygnSfulqdkZziye16ZKlrbS1SMVNSr3+ENsNMW4fQPqvR398ub3a+9/g
         ubrZdC1hx4xzTuu/bWR3KobNGdtmUUs77DB+fCmARrh8Oby5X6tpVIzbxGXBeZLFoUj4
         Fu6Q==
X-Gm-Message-State: AAQBX9cxOfjoO9fz6vvXpSGutqqe/Dx8QBSDlmYgSXuxOrLdmhlPVBpJ
        mJOBo9OkTLQEQJDCa8IAvayxrwNdPwDqgK4BdW4YQw7xflc1dmoTAZhq3g==
X-Google-Smtp-Source: AKy350b28nJPi9ZcNpz1lgIyJkEGuXrdiEoRKs9W2DQ6woHEVVBrHw/uP2w9Z5Xq5GatvTwKypwven4PIvdIbUXNXPo=
X-Received: by 2002:a25:2786:0:b0:b75:760a:966b with SMTP id
 n128-20020a252786000000b00b75760a966bmr1576483ybn.23.1680772308148; Thu, 06
 Apr 2023 02:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-3-keescook@chromium.org>
In-Reply-To: <20230406000212.3442647-3-keescook@chromium.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 6 Apr 2023 11:11:09 +0200
Message-ID: <CAG_fn=V-3yxPihQdt+OJuOfF6sBuNvQ2OQfYNZak1xbx6viU2w@mail.gmail.com>
Subject: Re: [PATCH 3/9] string: Add Kunit tests for strcat() family
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

> +static void strncat_test(struct kunit *test)
> +{
> +       char dest[8];
> +
> +       /* Destination is terminated. */
> +       memset(dest, 0, sizeof(dest));
> +       KUNIT_EXPECT_EQ(test, strlen(dest), 0);
> +       /* Empty copy of size 0 does nothing. */
> +       KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0) == dest);
> +       KUNIT_EXPECT_STREQ(test, dest, "");
> +       /* Empty copy of size 1 does nothing too. */
> +       KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1) == dest);
> +       KUNIT_EXPECT_STREQ(test, dest, "");
> +       /* Copy of max 0 characters should do nothing. */
> +       KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0) == dest);
> +       KUNIT_EXPECT_STREQ(test, dest, "");
> +
> +       /* 4 characters copied in, even if max is 8. */
> +       KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8) == dest);
> +       KUNIT_EXPECT_STREQ(test, dest, "four");
> +       KUNIT_EXPECT_EQ(test, dest[5], '\0');

Maybe also add a test case for strncat(dest, "four", 4) that checks
that the fourth byte of dest is not 0?
