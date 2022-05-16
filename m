Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3408C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 21:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiEPVgA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349345AbiEPVf7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 17:35:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC51020
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 14:35:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id g16so19692320lja.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwkH153JjE/VISwDC6yOaTP7NOzBFSKZdipSvNP+ktE=;
        b=pPEsL44A8/+VNexCO9dAr1v1HAI5ycZSTdy7Flz8UBakDFVI1Rxg0FRqBCOmyGWTXT
         TVAE+qwcOA6paQsDhTqw2ITaa/gsU/0l/O/x52asujpIJJuF0kTMD7zhJ8OECUjiJTSm
         or+nY2JtuynV/X2RIdxr05qWoL1N7dVZ9+ghQy3Ox46w6lwgjIwEYwNcr8Bo9Kehx8Wx
         UpJumvUJjYDPDPWt1ycthLsqqFZEMNJ3HM9JE0VYSbPSrAE3GEZpuyUd8TnRW1qK+e6M
         Uu2iZivkDEufqTjA9Pnfqxj/SRSwptWKzhvDJMHRaNO6zEfuDLy//XKHmnvMwvb2xWGg
         I7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwkH153JjE/VISwDC6yOaTP7NOzBFSKZdipSvNP+ktE=;
        b=WMCSl8H5uIN9jFSQCdqjasfJ3UbgZHXEJk1KpYnS3+4YJpkRAdmSFdzLJVJRwVdBLK
         9fWQJZ5NIuySfpnqjLTdHCI0u5Recis3evyUJX7DQ5AcZejLagoZ0WNDNKz7xIrJivkk
         RYq+BpeVtLUVhgSUVn1EStbNjhWW4ZrdtK22LA2/VV8dkE4b0iJxn1GFDZZZ0yWsQVZo
         Ovcs5DzZxEiT0aW8v4HGdmrFPRxjwYYU6qDjEpTcm9Hn0SgcuqyWvkwf8+GzoJasrhZr
         0342H7vnZX6TOskxyWXc2pMqxtVFdDiNST7WMzhNTMzZuG9qax2z7XZPmMs9mI6QPRkp
         wuQQ==
X-Gm-Message-State: AOAM530IAMS0VJoyO+8GguKIsmPa7lCoLcX4Ge78AabCIhMHlHb8CCDJ
        euIpoZ+g4c2jcGoglxfqMGmdk3Pbu3HCBtHrq4jHXg==
X-Google-Smtp-Source: ABdhPJzU9+gfgDOfFGF1PxDHLodCEyA3jCCPrw7fhlBjvTt89XPwU+9AcC6bORZU1NTMdnruU+wLNmh9RPLfai8Jksg=
X-Received: by 2002:a2e:91cf:0:b0:24f:11ea:d493 with SMTP id
 u15-20020a2e91cf000000b0024f11ead493mr12125591ljg.408.1652736956594; Mon, 16
 May 2022 14:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220511174531.1098548-1-keescook@chromium.org>
In-Reply-To: <20220511174531.1098548-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 May 2022 14:35:45 -0700
Message-ID: <CAKwvOdkXUiB3T_YkcqDZAkdvN0=cB2NH-i6jj+Y=sL8r9VCJ6A@mail.gmail.com>
Subject: Re: [PATCH] lib: overflow: Always build 64-bit test cases
To:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 11, 2022 at 10:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> There shouldn't be a reason to not build the 64-bit test cases on 32-bit
> systems; the types exist there too. Remove the #ifdefs.

I think this is breaking 32b ARM for clang-13 and older?
https://github.com/ClangBuiltLinux/linux/issues/1636

>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
> Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/overflow_kunit.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 475f0c064bf6..ac37bb543476 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -255,10 +255,8 @@ DEFINE_TEST_FUNC(u16, "%d");
>  DEFINE_TEST_FUNC(s16, "%d");
>  DEFINE_TEST_FUNC(u32, "%u");
>  DEFINE_TEST_FUNC(s32, "%d");
> -#if BITS_PER_LONG == 64
>  DEFINE_TEST_FUNC(u64, "%llu");
>  DEFINE_TEST_FUNC(s64, "%lld");
> -#endif
>
>  static void overflow_shift_test(struct kunit *test)
>  {
> @@ -650,10 +648,8 @@ static struct kunit_case overflow_test_cases[] = {
>         KUNIT_CASE(s16_overflow_test),
>         KUNIT_CASE(u32_overflow_test),
>         KUNIT_CASE(s32_overflow_test),
> -#if BITS_PER_LONG == 64
>         KUNIT_CASE(u64_overflow_test),
>         KUNIT_CASE(s64_overflow_test),
> -#endif
>         KUNIT_CASE(overflow_shift_test),
>         KUNIT_CASE(overflow_allocation_test),
>         KUNIT_CASE(overflow_size_helpers_test),
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
