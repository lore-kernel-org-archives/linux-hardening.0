Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9940C46CA1
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Sep 2023 05:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjIRFVm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Sep 2023 01:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbjIRFVR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Sep 2023 01:21:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D56116
        for <linux-hardening@vger.kernel.org>; Sun, 17 Sep 2023 22:21:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b974031aeaso66606281fa.0
        for <linux-hardening@vger.kernel.org>; Sun, 17 Sep 2023 22:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695014467; x=1695619267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUqOvKW20gasQsATUUwUlctmLMbjgvZAK+yffD5Uyfg=;
        b=LhRr4tG848LI/P2PuKHw/6EUZZNelR1RdeU91BxyCaC1mOHtsc9xKcuDZVBPtCcAMB
         o9xVFnzESAR7uTDmyczgTO5E4NUMHW0CL87zF7kwwX9mTN9M6lbMycayD72zjDz3kzYX
         TZAB2slaiiDjFh8EwBDKm1cah3vavvdGTCKXqU30sc0zlUHsRQy/l6/0YT04tG/5gMl5
         H+aOLTCVdtb4VP1lLOC6471h70ry/AQ8eMYSfMd2jZ5l7gW7FZ1YnBdXYEkKRinWKltL
         PD3SF+SmwsH5AyWPlay/OFnmtSTzbBnzGK6IjeIk9WyhpZnEoXI99Pjbl9eN+sZzlvub
         xSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695014467; x=1695619267;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUqOvKW20gasQsATUUwUlctmLMbjgvZAK+yffD5Uyfg=;
        b=Zh5PMfJJ1oU/sbTvvk7wPKHvThWgrcDKT9MkWonT+DEUZpXbSrKlZLIeWa4EguuV88
         CQLHp+nYefpNOAvbbuGT19w8wAf4v8+Lzt9j3/lE69ar+XNnO6PYsC6Wpd3qJQQgFW7R
         YCzH8ZFE8ak85wY8KybW+26Z7fo+XHc9BANo63ogTBfAKIAK1aVnLlUv1tzUoTExJY2y
         knK/13DPcKLzuAUUTyZ5pnCjFlkQuDWUCCKRUA23aUHidLlEqAcEWHw7rMwrPyr5F/vv
         15OOjMrD9zO9CNyZTi0RzoggPP4maG5l3TMa/qXTIxITjbhVcAwPx75mu4U2KOF0YtRk
         vMFw==
X-Gm-Message-State: AOJu0YwETqemBx9LvWoEI67rHprhRkxjUdb5ACw2IKXWwWx2C3Zaw+43
        xrE/322Bjj04sIKLk+x9Ni653A==
X-Google-Smtp-Source: AGHT+IGxZSTVlGdgiAqlRYsJc9cSkiCTCX8EBP3s1HUqt8CLrGGNYHaHF7CoPnJ2bp65LJ0taBT0pw==
X-Received: by 2002:a05:651c:97:b0:2b6:d6e1:a191 with SMTP id 23-20020a05651c009700b002b6d6e1a191mr6585652ljq.23.1695014467372;
        Sun, 17 Sep 2023 22:21:07 -0700 (PDT)
Received: from [172.20.10.8] ([213.233.104.217])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d997000000b0052a3edff5c3sm5483584eds.87.2023.09.17.22.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 22:21:07 -0700 (PDT)
Message-ID: <92da7e0d-0096-7407-1fc5-fc026c5e446d@linaro.org>
Date:   Mon, 18 Sep 2023 08:21:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] mtd: rawnand: atmel: Annotate struct atmel_nand with
 __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201219.never.352-kees@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20230915201219.never.352-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 15.09.2023 23:12, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct atmel_nand.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> index 3f494f7c7ecb..4cb478bbee4a 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -165,7 +165,7 @@ struct atmel_nand {
>  	struct atmel_pmecc_user *pmecc;
>  	struct gpio_desc *cdgpio;
>  	int numcs;
> -	struct atmel_nand_cs cs[];
> +	struct atmel_nand_cs cs[] __counted_by(numcs);
>  };
>  
>  static inline struct atmel_nand *to_atmel_nand(struct nand_chip *chip)
