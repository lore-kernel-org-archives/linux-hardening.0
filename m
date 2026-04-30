Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79EE428462
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556418; cv=none; b=hwncgM5xISe9GVxZTsNoUeRC7yf5iz2cXkYFzx7s6ePQ+Op2CPiBSO8vTNFzFO5+6Mb61e179yqnmbkaS75gvAZW+1ogcn82uheBtZqshWtyNQDSu63lQjNAL9UYwXVCGqW+ToxCRSnpkVYcMVWJRPvnsOK88RxgmB/I0/qpPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556418; c=relaxed/simple;
	bh=66i8SiZie1Gm4LFg+caCbRColkgs0M0GxG5EPWDPZas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bj1oLZ9SY2zUTHPV4kyq97qLzuE1mGWMuBN//2/3ffnDReAbcNjPe5M5LN7xzR8MCG/kEx7XrplBtGPJ9MmqFs7leWrGX39T9qUMhoSEHzD4YBmdR7Hp4at9M12JvBkvZnibLqtg8CCcyOYH44Dxu/WODrzivNbfNgq/nrtKU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EKtLRtYg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKtLRtYg"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d73422431so847867f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777556415; x=1778161215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meUp30gG/FVsgvAEeVESK01aKYB23yJUpx9wfRGIDWY=;
        b=EKtLRtYgX/Nl6Ve0ubV9vwpQaGqjSHwvQifUuHF5emo5B/cT8jFYqMwgASfY2b3o0N
         BqkoHpbMByB5Yj3zGcDYK8tg9VjxHViKYXcURXSTuSQZkOY6c867G/Gg2o6NsBDp9Jwr
         kTWTv7yw0ACdd+BH8YRYqe4YTepDEV/h5NT+AeK44PBx1qReR2EUwDDkz/U3mV71LdX+
         YWM5B3WDp9H1WALbDNEf/oxT3WIBT12kA7AyfrPF+OY/ew503qkFE3Bm/C+6ykIMZFJI
         XL7yoSBWHAPWHyctLFQCHNXr03YC0e7EVjtVnCr6WjFYDx9nSJWiRcqtvCR6GjKmrZaz
         QbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777556415; x=1778161215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meUp30gG/FVsgvAEeVESK01aKYB23yJUpx9wfRGIDWY=;
        b=gfKCKr8yEV7pWJuyfz3NtqpofP9zlyKRuSbxNuImCSufTaBjZGYb95L2Baq9U3h/Rs
         K3Fm3wFDpi020KF9HXBs4pY72YIm6hLg/Sdhf5MogJ3TZDtRRlWGcOmwM5YFsFH24vQy
         SJM9qO7lgnDTdZ23k6rX/mX6WOqe5e3kkrib07USgZOUJf2dgDLT8mGF+70hBg4pT3iF
         wDNh2tVLN38GBPIU3t9EbyhBMsP2h0UUyQ8GcN/v9+NkzhXCxmze/Y7kj6pqB/wM2VOs
         HqxKP4Jq5kqEEntO8zZ/LUaMqJe1x7cRhjWooVjKyS0FL4B7LeCxXReEJWQsn02htBZh
         kN9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+uSZEKXJf728XVE/K2suwklv1n7zlvO3IBIZdk9B9kq0y+nb8a1/ex1XsVAL4MJYrgtLPjGFXgc5OsWBWnmnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwO3pxR0ZKAfxMqf+x5/yFOO5fCY+CPAK/g9IEJNGdZP+bb4C
	GPeZktq4duzK2qAgRiWfhDelgPIL4B6VvhnYgLTIJyiiz4DAhEdNGioxaP07KIbZT+s=
X-Gm-Gg: AeBDievhF8G65wx0ZpWsMYDzVGhjcsoBWBXn/gST710Ly+FE7fOKhAviQ9fWsvOyIuy
	JVLEorB/NfaTbP8+ShmLHbPSNrCXM6RDZDK1Rg/e2O6o14kxdL8lunTujCz54rDojGvQJfbthRN
	2DYmhpmKgQPF3UgmBbrw/wLsM9en+SCjGa6aNmAieGGGzFPJk9wZ1r9buEI4yLPDbtdYT6ZXNTO
	2H4/ymFHwakAQdQqUGkRMFFXyPmflsZSe/kb8uokpDZYXfsikVw0CldkedXrZ0j4FbMQyirKnYA
	lfBya7yud9ygLkN5WpO4rLArrn/kquNc7soYOXD230a9pRH+f0flKZ0tZgDQaPskFstK45T/4V/
	t1j15mzLJPZ40ihgQhXH/3WwcJg1L0ugt8yE8e9aUiHLW5LJuutux233JFVfTmPPqhWXIxFVPZZ
	an2UYbT8DUi39AKeX05NihN7O8A58lORI06Caxb7DNJPc=
X-Received: by 2002:a05:6000:1862:b0:43d:77c6:be78 with SMTP id ffacd0b85a97d-4493f42beb1mr5272265f8f.39.1777556415022;
        Thu, 30 Apr 2026 06:40:15 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca664csm13806106f8f.35.2026.04.30.06.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:40:14 -0700 (PDT)
Message-ID: <56c1bb6d-54e4-4977-bd88-9ce7a6086b1d@linaro.org>
Date: Thu, 30 Apr 2026 16:40:08 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] thermal: samsung: Add Exynos ACPM TMU driver
 GS101
To: Alexey Klimov <alexey.klimov@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux-clk@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
 <20260423-acpm-tmu-v4-8-8b59f8548634@linaro.org>
 <DI6IGZIW2HZ8.OBLZIORMOH2F@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DI6IGZIW2HZ8.OBLZIORMOH2F@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/26 4:07 PM, Alexey Klimov wrote:
>> +static struct platform_driver acpm_tmu_driver = {
>> +	.driver = {
>> +		.name   = "gs-tmu",
> What "gs" stands for in the name?

:) Google Silicon I think.

> Shouldn't it be called something more acpm-ish generic like acpm-tmu
> at least?

yes, it should! will update.

Thanks!
ta
