Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EAFC64E7B
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Dec 2020 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940EB204EA
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Dec 2020 14:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M6aCuNhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbgLAOvO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Dec 2020 09:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389739AbgLAOvO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Dec 2020 09:51:14 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33D4C0613CF
        for <linux-hardening@vger.kernel.org>; Tue,  1 Dec 2020 06:50:24 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id g20so4051856ejb.1
        for <linux-hardening@vger.kernel.org>; Tue, 01 Dec 2020 06:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u11hnNgXTS9zHw9F1VKspmTAQsvSEt7QVrPJBjDHu6g=;
        b=M6aCuNhUcEkKmxd2/vopzwE3KJ+WxtGAgKPzeagXFjrrmNAkATleXsRB/oZM/db+dt
         ls2r4BhXUW2CdPXcopCP75b6Lc8PeGrN6y2MV1V+OEikX1tCgtSTAaov149IlIMU1+P2
         1umLDMyp5eZZm8FyqysZpP8Z0FIHWVGSg5twL6zjAVagJTQeo5pjd5YF9csMisiSVwTM
         kTsWUlW2dgQ4h+H5/Y2oA5uQcayqKSuG+TVNxW2ltAM96/x4tHzSC86aFdA0ubYT4uXu
         ehUSpDUW6w5aASkXX2LO6oFFKZ17FdtCaKdq3F959IqbAUMydq6RsktatxMoU3Q6hVXK
         Qivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u11hnNgXTS9zHw9F1VKspmTAQsvSEt7QVrPJBjDHu6g=;
        b=Dl4illipBdEAnUgvizJNhfABJSIJinUe4i3Y6vcHhMuxqasMoWD4BZSVuS9T/YDqTe
         9Xw4YYzE2jXAlNWg8At9cAJ+HCvPJvRAXtof+JeBi2HKX5c3cJtyxUvOXDcQQUU+IPOk
         FehE4LzvIPS5Y9ANN4ZYzbfxBRe58Zjj2ife8fCaX0ot4jMg7tYSSO2LdR65lsHyGM7P
         62hJciaVyJr2lFU8RNBSNFEX1fmaiVnP9ekEyIUl+GtLLLCUTgDXgmdT1zV99znlFx3h
         7N668wVkzaE+TSSBS33C7rfw4VjyezXNLzymwuSj96m3Y0BLcPWq+7SQ8odFn7Hm2WFm
         L2vQ==
X-Gm-Message-State: AOAM532DXEY5ZC3mAlJNNrQjiDtFJ/729bKjmJDepvYxPd5NEo478Crm
        T0gOP2+8UeuugSBrVWKB+878myy3kufUFUuIBf98fw==
X-Google-Smtp-Source: ABdhPJwG0IqVrtCOsiapz9tOGvEqeMur8iwjMo+Odo3ubld5i/SHRYQZyOqybTSa9RuzGktyWVLOruBXRsHV2wJcHmo=
X-Received: by 2002:a17:906:15cc:: with SMTP id l12mr3193264ejd.363.1606834223625;
 Tue, 01 Dec 2020 06:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20201119170901.GA22703@embeddedor>
In-Reply-To: <20201119170901.GA22703@embeddedor>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 1 Dec 2020 15:50:12 +0100
Message-ID: <CAMpxmJXD+qiJLoEdFxmceVNyXPDfmvKPwG+SthOS8oHd2GqLuA@mail.gmail.com>
Subject: Re: [PATCH][next] gpio: ath79: Fix fall-through warning for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 19, 2020 at 6:08 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> warning by explicitly adding a fallthrough pseudo-keyword to indicate
> that the code is intended to fall through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpio/gpio-ath79.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
> index d5359341cc6b..678ddd375891 100644
> --- a/drivers/gpio/gpio-ath79.c
> +++ b/drivers/gpio/gpio-ath79.c
> @@ -123,6 +123,7 @@ static int ath79_gpio_irq_set_type(struct irq_data *data,
>         switch (flow_type) {
>         case IRQ_TYPE_EDGE_RISING:
>                 polarity |= mask;
> +               fallthrough;
>         case IRQ_TYPE_EDGE_FALLING:
>         case IRQ_TYPE_EDGE_BOTH:
>                 break;
> --
> 2.27.0
>

Applied, thanks!

Bartosz
