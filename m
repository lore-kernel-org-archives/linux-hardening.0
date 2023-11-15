Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756AEDC
	for <linux-hardening@vger.kernel.org>; Wed, 15 Nov 2023 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HtFwonew"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7BACC
	for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 19:03:40 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so6601087b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 14 Nov 2023 19:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700017420; x=1700622220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h2NJqY9YsGejP0tvY4g7KbbK4VWtM2B+ypFWWtUvLTI=;
        b=HtFwonew5CH0YCRi9Iq3JtlA2XZgjZT9G76q45CnKI8IQsuN1XHOBjq8HTOOBcWNaa
         Sd5umjK9xOE9VKvI6AZH4E0LP5Jtya7SmaIfcKoQancwTPoCX6mHYtLc168XNObpQOOn
         e7LUS76sdiSODj44hijj+cRWs0PoqXhFIIjqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700017420; x=1700622220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2NJqY9YsGejP0tvY4g7KbbK4VWtM2B+ypFWWtUvLTI=;
        b=GWipjjyoEF+Yezh1V7nt+bTnjmBoU9SN6+m28VybMaOaiELTIJ+68WugB+BcEsMsnU
         OwvplhJLmMvunuNpY7XTaMTx/Tza+mJbne5PXWYhDrUuGA0SxMF8jwB5we391ZlRGuVs
         u4D3xsDblmQV7Sg9jpQ+Gp77DqNj1k/UNeuBip3ujDA+FyZa+YQw0OEjO/7x92/lzVe4
         S9PSTau7GqglLzY1OpdFSzaLDv3U9npfT4aBcIxzAvEZ+nBq+YCTWKbk7TlfmsPK58BA
         1a5TU3YzebUPaPTgpZTWkn+Y2AYXc9yCbtX+/7o1A4QqDVzRyiY+rvSIO1v4wPSWQ6zq
         fPyg==
X-Gm-Message-State: AOJu0YygeO8METIxjY/vOUQhBwBdL4bhlmBLjgjtG+zZQ6QUQhsNUJXc
	I+Drx9N7pdt04F/OM09HNDvVbQ==
X-Google-Smtp-Source: AGHT+IH2CmT0U/FV4WE9B/tMn8JLmXuKHQNxah2EdL59VFMPy803dw0H/rvMltvHqKIyGPgpgSRxYg==
X-Received: by 2002:a05:6a00:e0d:b0:68a:54e5:24e6 with SMTP id bq13-20020a056a000e0d00b0068a54e524e6mr12166196pfb.8.1700017419680;
        Tue, 14 Nov 2023 19:03:39 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y22-20020a056a00039600b00692754580f0sm1888588pfs.187.2023.11.14.19.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:03:39 -0800 (PST)
Date: Tue, 14 Nov 2023 19:03:38 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] hwmon: (aspeed-pwm-tacho) Fix
 -Wstringop-overflow warning in aspeed_create_fan_tach_channel()
Message-ID: <202311141902.A5AE1300@keescook>
References: <ZVPQJIP26dIzRAr6@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVPQJIP26dIzRAr6@work>

On Tue, Nov 14, 2023 at 01:53:08PM -0600, Gustavo A. R. Silva wrote:
> Based on the documentation below, the maximum number of Fan tach
> channels is 16:
> 
> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>  45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>  46                 integer value in the range 0 through 15, with 0 indicating
>  47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>  48                 At least one Fan tach input channel is required.
> 
> However, the compiler doesn't know that, and legitimaly warns about a potential
> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
> in case `index` takes a value outside the boundaries of the array:
> 
> drivers/hwmon/aspeed-pwm-tacho.c:
> 179 struct aspeed_pwm_tacho_data {
> ...
> 184         bool fan_tach_present[16];
> ...
> 193         u8 fan_tach_ch_source[16];
> 196 };
> 
> In function ‘aspeed_create_fan_tach_channel’,
>     inlined from ‘aspeed_create_fan’ at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
>     inlined from ‘aspeed_pwm_tacho_probe’ at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
> drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>   751 |                 priv->fan_tach_ch_source[index] = pwm_source;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> drivers/hwmon/aspeed-pwm-tacho.c: In function ‘aspeed_pwm_tacho_probe’:
> drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object ‘fan_tach_ch_source’ of size 16
>   193 |         u8 fan_tach_ch_source[16];
>       |            ^~~~~~~~~~~~~~~~~~
> 
> Fix this by sanity checking `index` before using it to index arrays of
> size 16 elements in `struct aspeed_pwm_tacho_data`. Also, pass `dev` as
> argument to function `aspeed_create_fan_tach_channel()`, and add an error
> message in case `index` is out-of-bounds, in which case return `-EINVAL`.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for the v2! This looks good; it's able to pass back the error
now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
