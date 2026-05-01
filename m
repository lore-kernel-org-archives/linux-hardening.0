Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572281FA272
	for <linux-hardening@vger.kernel.org>; Fri,  1 May 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646005; cv=none; b=TfLp2dWv6p5nde0/+MWRGcFjQH31825Cd47DMAfGRJRsZe4hcRcEQhAQL0gb9yz6V7OkJcyTpumRPBuKe+pcgCpUVPDMWE+5epluI+S76rzuZyYRNV3/kskRqC8WQ82Z1WsTtc0ReRCBSoyHBbQyelshAH4zIz7vAkd+DW4nMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646005; c=relaxed/simple;
	bh=rM+ohjUAcsn8dXq0mb8PfyO9eXL54RezXFWp9ONY54M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIo6ikJug98IhR7mCrIEYM2xWvWMfe3iE/wtxtWjZL/TZZCCUIoWyaR4oCB1ZXfhagBsYWDUTnp7pD3KL1u4/LRuMYn73WZk1tWHP8bZIq7Dn5U3o55rGkgYjwK5i7aCJlDW3QHlHz5GujwQ8cXRvZbXBTjGMzoLcbjD1TCoUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEcbau33; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEcbau33"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso13975005e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 May 2026 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777646003; x=1778250803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5SFIqaEshVlX9LzlwHH+wo3PqHlpQWvbDIgoSHoIug=;
        b=tEcbau33Ob5YtTyQcrz2W+Cl6OvOVYR7jq6iHBP+ST0ZA1zGQ1+VJ/LtcCDszZkKiW
         4e3S4DEmvlsOPJZXUeJyQOjRxDtsyCMXaQvw76U5RpoWrAtcqzOPnYJISFPyP0CwZozN
         gkZv17Vkk2x04EhITaJZ8M/G3yCg8ZewkyittQ1M9A5eItqHtMIlFqLs1m55c1LHWKGf
         EAmVDvfS6NTSZsxk24AUeM9k1n7Z2FpJmYbTjKYc5K09JvrxPGqaWVlVN39OuIeI8tJQ
         sVAFPr5OxLZFXD7VSLd5xBMHPSm6witUm1McH4ptuvLooE9Y/S13wWj2vJmGEIvEknJA
         KzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646003; x=1778250803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5SFIqaEshVlX9LzlwHH+wo3PqHlpQWvbDIgoSHoIug=;
        b=ecBzspMz2ZKXGhuY+YdarJ0VSDyRa3ZO8LnYU8MQP8j1nUM56PaM4vs3nWJeORgiul
         dIhpbPZoUPGK+5Rg6+anG0etsFjA+d5PoVEFbzndQZhdOwmPyLx2igaveSFElIJ50Sqh
         isrEqiKylbXLkpz9zPQSMTWKTD/F4qzsIIQ/nfiA/1UxK3bL3yp+lNFgp4NydMJfvQdz
         MZiN/G0CJD5h8wuunK1OlwMUd5g2RJbIFvenGf6xvLZFyzzBWBC5FCzmagajW1D9dsFD
         dswasNx78m7tcO/3yHX2nnj4VULJ2Nat0ugG3YMs0SM4SGmJUiixU8UBlYdlp3CxojRJ
         ZVHg==
X-Forwarded-Encrypted: i=1; AFNElJ829qxGfRPd5PJwnHluL6Vgy4PsIOf/Fvx29DPY5+klUiT0InWYkEMqi1OgSi8FySY9owluMCysF6Ofp/Z1qKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MRlnavQD8GyJKHiS5kmyJ0h8mpUXJLhPKVXC7cIwwuJilQJb
	wrEibHUfKT0It5Jnl/FbPi0jnf7AdVNedcI4tY4uU8eTDyrJaIvgRugLiLqnrKFhTJU=
X-Gm-Gg: AeBDiesn//h0Uzz+jLgP3wmr29k/nSnW90ykehgZoBAdEx45fLr1FBq5mcX++f5K62R
	Mgeoj1THutCrjJpXl2DedXDbkuxcTlP1WPrLdTjZIpfPIDy/giL6STp9ntOi72VD9CdzLamL3qV
	2e3NAPZghz2FtgigFXpxTFemwi7yb8m9inZe9Rx4IuWz8gwX5Q8Hrxsz8qKNJwqjWs6Rt9ZcC33
	MrekF+x/ih+YYWgZzUO2gcIQKHgSnqMxjxLGQZ6VF0RQBXAh+xj38nA7QUbYbc0rP5/vyZx2fC9
	0+Ul04fBBWUXl1AKQuqWcBvlr7T+MUiTxy8g7xteSg1Ze2KfoDox9niaO8sks7GXOHPca/gey3m
	a++c0CUhnMKM7Cp4nm6LXRl+ME5ccgJqhaXTv//ZRA4bjUeC8fOsMO2pJ/P/5VKaecewSnN761i
	h98UDfp8fgmLcaRcarwHrXCBsWSwLXQu4LQ+/byCBYRlY=
X-Received: by 2002:a05:600c:49a3:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-48a8b02aeaamr51995435e9.11.1777646002848;
        Fri, 01 May 2026 07:33:22 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm132049825e9.4.2026.05.01.07.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:33:22 -0700 (PDT)
Message-ID: <b9fa48f1-0ace-4a8b-b2bf-b5e01f789f7b@linaro.org>
Date: Fri, 1 May 2026 17:33:15 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] thermal: samsung: Add support for Google GS101
 TMU
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
 <DI7D7JXW4RGK.XB0BE6ZXNMHS@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DI7D7JXW4RGK.XB0BE6ZXNMHS@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/1/26 4:13 PM, Alexey Klimov wrote:
>> Dependencies
>> ============
>> - context dependency on the ACPM fixes sent at:
>>   Link: https://lore.kernel.org/linux-samsung-soc/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org/T/#t

cut

> I've took series locally using b4 and result doesn't compile:

take the set linked above as well please.

Cheers,
ta
