Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925C19B
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 03:15:12 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC38139
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:15:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c46b30a1ceso38250965ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695525311; x=1696130111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amfWmJu/D4QCQg50FQhzHOc1h7E/bVbjM0QuAI+Q2Gk=;
        b=TIDf5zSN9LdiJvqXnghqlpKej7FcCscsssdJmQ384ZNH02UE8rDH75xcZp0ayoaGpw
         xX8qcBgTt5F4wb9jHB2w7i4Tie2DrTPeZnrjlcHmsq0UvcpOw1om/8zNQUqzOpeEF2t1
         c9nBnN6ewUnBoOaDKMZzzoumvH5eygjf+LBys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695525311; x=1696130111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amfWmJu/D4QCQg50FQhzHOc1h7E/bVbjM0QuAI+Q2Gk=;
        b=DiOgjQN5sTn5KjrzTn9/3Wf8Y9yuCuiOTIw7XMWaNfmHzsFnBh1zvMEsPbikCyDjbd
         N8upUF1jqQvJp1WuqU0q8VD8atHYRIchTsJZ812mBkmpPZoHX26mwoeRxu1q7U1DTq6+
         T+TQsiKAoXCPwcrUuu/JytbKJ1OKvYfzQX0FbFZbYWFsOVxF4oOJNY+NjZBSG9Km7YF6
         DUbluZ3U0f+1tQ26ADziuRzRvtfoiyca+VBp5bcvStQ0ehDqunJrBGfpUILYRUI0+SVP
         awJ0vmrsYEFugmdwxOY1FAUOnNy9Q4PyfzKzreqjvgjsFK8qFJfKz4xWf2Np9PRe9Osb
         0hOQ==
X-Gm-Message-State: AOJu0Ywp9uJFKWIBooDV0Z6LttQVzTNESswt80px6ZZssuH/BZmIGMdm
	ii6NKT838uB5fNJ93KlZ3GxKGg==
X-Google-Smtp-Source: AGHT+IGisq+WD0tay8J8+6P9QCEXyW0JTTlcVZMxuf3DfjOxdjEguwLeM2nc5M2gPZJSS04saXBlow==
X-Received: by 2002:a17:903:11c6:b0:1c4:4251:68b3 with SMTP id q6-20020a17090311c600b001c4425168b3mr4201343plh.54.1695525310870;
        Sat, 23 Sep 2023 20:15:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i18-20020a170902eb5200b001bbdd44bbb6sm700006pli.136.2023.09.23.20.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:15:10 -0700 (PDT)
Date: Sat, 23 Sep 2023 20:15:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-adc: replace deprecated strncpy
Message-ID: <202309232006.690F89A@keescook>
References: <20230921-strncpy-drivers-iio-adc-stm32-adc-c-v1-1-c50eca098597@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-iio-adc-stm32-adc-c-v1-1-c50eca098597@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 04:54:00AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> We expect adc->chan_name[val] to be NUL-terminated based on ch_name's
> use within functions that expect NUL-terminated strings like strncmp and
> printf-likes:
> | 	if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
> | 		/* Check internal channel availability */
> | 		switch (i) {
> | 		case STM32_ADC_INT_CH_VDDCORE:
> | 			if (!adc->cfg->regs->or_vddcore.reg)
> | 				dev_warn(&indio_dev->dev,
> | 					 "%s channel not available\n", ch_name);
> ...
> 
> There is no evidence that NUL-padding is needed either.

Agreed -- it's used as a C string everywhere I can see.

> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding. If, for any reason, NUL-padding _is_
> required we should go for `strscpy_pad`.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested
> ---
>  drivers/iio/adc/stm32-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index f7613efb870d..9cdcf396d901 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2209,7 +2209,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  				ret = -EINVAL;
>  				goto err;
>  			}
> -			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
> +			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);

I still prefer sizeof($dst), but yes, these are the same:

        char chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];

If this needs a v2, please improve the Subject, but it is technically
correct, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

:)

-Kees

-- 
Kees Cook
