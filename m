Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D23AC64E7B
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Dec 2020 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B451C2076C
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Dec 2020 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jwAPYMuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbgLAOts (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Dec 2020 09:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389488AbgLAOts (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Dec 2020 09:49:48 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED2C0617A6
        for <linux-hardening@vger.kernel.org>; Tue,  1 Dec 2020 06:49:07 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id m19so4588575ejj.11
        for <linux-hardening@vger.kernel.org>; Tue, 01 Dec 2020 06:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQmiVxJd+Kl2UDX74aE8ZcT26AtGS/wklDJV5DWlb3M=;
        b=jwAPYMuzH8oNFpb2B3klwVMdsmIjlpPrDfYD0OKHi+ansmJ1xkPwf6DfJacdvGbEhh
         6WnHZBSNLKx7hcEJ2IPsIojFee9my/FoLbJlkNlz/NbhTV9jhkQn8ME8J7cdaryRPbo8
         lVhF5Ij3hgCndTWby3BXtKNErZ9FUeF2dUMjr7NkjYJHyTGXtXou+nSO17xVSXHUawJz
         8/bOnngSJaErW3NxFTeBTklslB6aQJ0/vTHSJRfjmDuGPnLEFkSvpufW90liCaX/o4QK
         2nbG3vny/XyoEpAtuaTbCZeWeZwxVQS0F+fr8h56vGWhO1g473rDd0lc0sFTO3XPtqru
         sIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQmiVxJd+Kl2UDX74aE8ZcT26AtGS/wklDJV5DWlb3M=;
        b=lGnzGpesf8LrjVHK1dq61BfmHIb0oo9Gdedjz4t4D+xtES+QSPbsEVKpFiEPCyQMIX
         c+u2hjZjjeu5GVGerFvHlI4BHwgozR45to8cHMirFoIcFOFgtPxAvYdF5ZIOZuLYft5w
         AKnFbizpcMay32vfm9BiXM5DRWNciqxzPMA03/tTCnsX48U/V0Onf+jkOpyhNISmmxXn
         lfRWcf6UPT/TSAYu7dzPLxC6/Ge5guirKwliTAOJuCdEOkKs7AUITx1yyHV45hMfhNNf
         tEPYCP6njMVc5um9eSIDnZc8FekF/LoMr45VNoQkPQZRb1M5nEgXOcq3ThbsxFrgpw8+
         qJ0A==
X-Gm-Message-State: AOAM531E/Sc6uXnrTMZi2fXIdejRhCy84MBPFAJ3SGVb9ANTQ8DIqUpm
        krJqKlaI6PCpR4RTKQNVRIcHrphert3SIHGu5dPafw==
X-Google-Smtp-Source: ABdhPJx/znI8GH1T3tz02M68wDeFcvy3SeGIIJVLF7bwXNUsXDKYkXpr1p5++qs6ZnNs6bz2c6CH7QTdAPo10EfXcyM=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr3382153ejb.168.1606834145234;
 Tue, 01 Dec 2020 06:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20201119170739.GA22665@embeddedor>
In-Reply-To: <20201119170739.GA22665@embeddedor>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 1 Dec 2020 15:48:54 +0100
Message-ID: <CAMpxmJXhy4wRNZWz0iqfB5=g5-F2cdE_q9hRcPr-zRxg9O-jDw@mail.gmail.com>
Subject: Re: [PATCH][next] gpiolib: acpi: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 19, 2020 at 6:07 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpio/gpiolib-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 6cc5f91bfe2e..e37a57d0a2f0 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -233,6 +233,7 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
>                 default:
>                         break;
>                 }
> +               break;
>         default:
>                 break;
>         }
> --
> 2.27.0
>

Applied, thanks!

Bartosz
