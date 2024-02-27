Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF11137C2D
	for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028848; cv=none; b=ITjIwNzHQBKZQbeYrJTLqGAJiaTYWwnHOWumg7t9blRBne8HcMvDGUWsz49XBDFBsSRPQ2h/TKWrRizRB8nxS+d+YODhG+1imCngkJiR4eggYEinQQyPMrCzEshKOtez7F6Z+ozP8xanR6i9m7JwWfsvP/b4n2gW/VX8ExQOLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028848; c=relaxed/simple;
	bh=ybp7X2Yo/Up/skAf//xn0KFyXmDy92/4atlYjExbrX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vi+P8T4Zvk2J4j+oAM3rKM8GvDPylwPSpCiI7vlHXsdlSkWJ96qAnXcKAw1GOidIHJraF/SCRIP9ZX8radScljFginRCALh8UUneCI0X/Dql63JgYIaZpmHWtJz6hBOgyBmR9M4f+j0GVbGtVC5t2OvuR3mKXHG8FIVd1sdNRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nN5d/4ji; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nN5d/4ji"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33de6da5565so659613f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Feb 2024 02:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709028845; x=1709633645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZlz8agQ+YjAiyv3zJWLFDnAFeGnSfEt7c/xO61sPNU=;
        b=nN5d/4jibgfQbyyh1quzZYwOZWIwmvFBxMJo0bZo3GjlsrbyVQQztAb7LQFKdEyxe/
         qc7nx3fxB7BqpNOmQKMNcurN2ptyCDvzbemYtg0V+Mtn6dvXxA1laR1vbVo257ulM9l2
         yFnr9TO6ORr55cbe51jah9ole7KP7KVBkfoySKiFhESW7qNB1ZXDUrn/ti/9qmmk9w29
         7OOOwcDGuTVcbGrEyJ0bXHTbO3au/NBcBzoHGTiBydV9QkPRBwK/KpL//EMzuj/2KyYC
         /0W7h/e7jdwAwAdNeWZolx1+71p9n/kJhZvB1oMrF55T5tZ/QqVdiLFcYQGocrx0PVth
         a40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028845; x=1709633645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZlz8agQ+YjAiyv3zJWLFDnAFeGnSfEt7c/xO61sPNU=;
        b=RfxfRgyl3uXJljj6yNDF8uZgbitdfNX2WPAoo6keNLj32T7KySJfbJxNk6cjAOAxe7
         Er2fGuAg10GribpyHFvpUzhMVCgNvrrnA9vwomjexZUC2ZJNzflz3rIS4bYY8VhT1kRu
         Rrjs77akYi33O8mSFkCCBCoAJJ1I7UwcK44ZXDE9Fo/Deb5aVAcWYa4t06cYr9mPf+vS
         aLpoPTMURoRwyLRxmK+uMZzcQ3Fx5dfcdOfLahjuSo6xCnDUwTKi77H+Fl3cs1GiTxs7
         iRGD2U9HzNgIaOW++f20eng1Z0WnquAPw9yuJLsa5sTVZhrTu51qCV+AHVmZKXxl4mAa
         I84w==
X-Forwarded-Encrypted: i=1; AJvYcCX8clQSyx2kpS4uPAyfREZ/2h5Facha5qBk1pTG2EcVcplV3p5uncLUUBE7W8zn6lCHJxzoU7WYnL/0y5dffvo9n+FSK8WvlMtjOO+gV8io
X-Gm-Message-State: AOJu0Yzm4wP+yi1fzMrTBK+6aD+uKdPG873HAjN2uqv6e+Bl1n6cS1XY
	pAllGWL5mV6X6KCaW+xptKYcHEIGmmbZqDwW8PBQfE3Y3yjTeIiPJomBNfOBVig=
X-Google-Smtp-Source: AGHT+IF6M/KvyQWZkBqnm+Q4tlZfBA93iXtO36HTDRvaS2rEQtKauW8pffUxFc+oqF3ND5gRvvw12w==
X-Received: by 2002:a05:6000:4012:b0:33d:d82f:cc72 with SMTP id cp18-20020a056000401200b0033dd82fcc72mr4290911wrb.51.1709028845239;
        Tue, 27 Feb 2024 02:14:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c2-20020a5d4142000000b0033cf453f2bbsm10834019wrq.35.2024.02.27.02.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:14:04 -0800 (PST)
Message-ID: <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
Date: Tue, 27 Feb 2024 11:14:04 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, keescook@chromium.org,
 gustavoars@kernel.org, morbo@google.com, justinstitt@google.com,
 stanislaw.gruszka@linux.intel.com, linux-pm@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 patches@lists.linux.dev
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/02/2024 01:54, Nathan Chancellor wrote:
> When booting a CONFIG_FORTIFY_SOURCE=y kernel compiled with a toolchain
> that supports __counted_by() (such as clang-18 and newer), there is a
> panic on boot:
> 
>    [    2.913770] memcpy: detected buffer overflow: 72 byte write of buffer size 0
>    [    2.920834] WARNING: CPU: 2 PID: 1 at lib/string_helpers.c:1027 __fortify_report+0x5c/0x74
>    ...
>    [    3.039208] Call trace:
>    [    3.041643]  __fortify_report+0x5c/0x74
>    [    3.045469]  __fortify_panic+0x18/0x20
>    [    3.049209]  thermal_zone_device_register_with_trips+0x4c8/0x4f8
> 
> This panic occurs because trips is counted by num_trips but num_trips is
> assigned after the call to memcpy(), so the fortify checks think the
> buffer size is zero because tz was allocated with kzalloc().
> 
> Move the num_trips assignment before the memcpy() to resolve the panic
> and ensure that the fortify checks work properly.
> 
> Fixes: 9b0a62758665 ("thermal: core: Store zone trips table in struct thermal_zone_device")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/thermal/thermal_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index bb21f78b4bfa..1eabc8ebe27d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1354,8 +1354,8 @@ thermal_zone_device_register_with_trips(const char *type,
>   
>   	tz->device.class = thermal_class;
>   	tz->devdata = devdata;
> -	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>   	tz->num_trips = num_trips;
> +	memcpy(tz->trips, trips, num_trips * sizeof(*trips));

IIUC, clang-18 is used and supports __counted_by().

Is it possible sizeof(*trips) returns already the real trips array size 
and we are multiplying it again by num_trips ?

While with an older compiler, __counted_by() does nothing and we have to 
multiply by num_trips ?

IOW, the array size arithmetic is different depending if we have 
_counted_by supported or not ?



>   	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>   	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> 
> ---
> base-commit: a85739c8c6894c3b9ff860e79e91db44cb59bd63
> change-id: 20240226-thermal-fix-fortify-panic-num_trips-5f94094fb963
> 
> Best regards,

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

