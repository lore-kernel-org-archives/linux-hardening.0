Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B4438FED
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835927; cv=none; b=h5txonSR471qD5w5asOFQS7/VvB2daqWoVHs4xpMD1/atYm948Q2qGM8pVHAdrZopES2jcCu1nXvfiwGCLWg8CCyLGLtO9W1pan/2VYHKpw9Czs1gVSnjbzZV23qDSC6f8HOTHY+q1OypRlcpA6CDqgEphpffmW4M6E31YOSa9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835927; c=relaxed/simple;
	bh=uSw4iLWni+08K3Y2XPPthhXGT8z8eNuujhWRQ0NoO/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnsnAZWVU5nQg8i6UW4TgR2Bunk/Ay+tGp8/yI6YVfo74r25HPtWo8GCcJPAWeQvGv69fGLaK4WOqy+qCO9jdLDCEL5vV79A7WaByu/XbsWKxI3s7HQ1qVCZWdUrgisgySavXzvM3HT8smwi6ccHCe9BevmEimS9XmFfd6vNfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHyyCsJe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHyyCsJe"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8fbe18b1dso3283303e87.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778835920; x=1779440720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSw4iLWni+08K3Y2XPPthhXGT8z8eNuujhWRQ0NoO/Y=;
        b=kHyyCsJe2muVQQwvt5wzTDwFbOnpO8COGH0q1Pdfoium2jscGMdGqfANjXUVrUE3C9
         VnMimtm9+Z4/jWxsOwkxKqH06B7crDANToskrImuzZZmyEDQI5LkBfXmHgCnCjeIMt/F
         vglNcNGR0xahOFJallcd6yaIwYmzRlRgtyLXajTCN7l9vdELtSdSRAJ2M1UTqDHapTjH
         +Yz4pvf0EtoJ7o8/ZfKeQJmhUTokJQ63FCH4yHaaMdA7oIeG4SlNGyE7tTwahzxeRMxW
         6zcIjq4E3xbTjJ/O61qgrcXbwE2hBicr9E9UmN9PXmM0RVnfFy4BmejiKV8+3gRLe3n5
         hg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835920; x=1779440720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSw4iLWni+08K3Y2XPPthhXGT8z8eNuujhWRQ0NoO/Y=;
        b=Po677+mZdzcAHVHQhAsGxgmnUNyD+jbDat9EqhiVKfNMyOCN4dIk4lNyIshuPxChlk
         fQkZhrfVBxHlJ2N738KtnYY1ICjGv5biT0BqHuzOiKUcUvawG3V1RVLj0AQzIEGGRzEH
         kMAu2KgGgFhRsmgIMhlo3hK679eL9TYXQiMJ6B3rEG6QgqJEnt/pRHfvFtNOrnEG7uY3
         rB79W98EYbH+G7t/b+9+u5KfQ60qri73cBxaCA83GbvBcqYzYoU2ho2uFF0MGifm+klW
         P9ydQNgszHFD4z+dEVhauTitjAf5jwKiv+1+dDuuqJaVUGY6B7a33FAv0EfeY9EQl3AB
         Hujg==
X-Forwarded-Encrypted: i=1; AFNElJ/YVJ7jtFUDYZjhxaTEnITJ5esPKQf291qPYWa5qTOt/Pv4PEKXLqWQY5Yxaq6hUjnYcnRk5rLxjcSXKZFEBo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyLfiVWEpmUs0n/bqzXuR/jL0jd8RFDJLKNihwRRzIaRq8NRX
	MfKM/GRC8FDtYSZUigBolXh6jz50lFoQNZCsY5gyhVQXIGNV642mTMDclH3lrzD0p2g=
X-Gm-Gg: Acq92OFd0eAuSknVttG8K2oxB2m32rJgfLiHiFCSm2u/gXfqIivj5DTu3CZt6EZcQbL
	OqAv/6hwB4FDXeM+sZz1heFDXR+xb9mBbJ9hCU+tj05LP9uX6r0G64RfV2gOENZG/a+tmHwKKyw
	BRphp6U5Q1UNdeV7rXm/chKNm6xEGRNcMqRopzM38aTgajtIq8H1Bqskq3CBknF+tvcPtIIGFic
	BAmwjp5i4XQcwzp3h/29bOEZasgNUZvgeOqNwUy0Wntxu+WiRjVE/AfeHZTxCbJF+eLMcVjloEW
	KFUx9wsQLnie1dltk7/cdCfZf5Ttj9CTrkpmWN90U5VzkIaGxF7vram3sKNm36bWs3qlBXZ380x
	f5grac8nkBekl6Gdr0VY9txLbc4K6Un1yGHygD5K8gjCfe51lkpApcuTAURG3lbvFf2eHqewK1V
	G36ITMhoXy5tP9hpTfT4AlPs3U/z3nSuEX
X-Received: by 2002:a05:6512:3ba4:b0:5a8:6cbc:60f3 with SMTP id 2adb3069b0e04-5aa0e769d53mr851416e87.34.1778835919654;
        Fri, 15 May 2026 02:05:19 -0700 (PDT)
Received: from [10.11.12.109] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm13447979f8f.33.2026.05.15.02.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:05:19 -0700 (PDT)
Message-ID: <e91af899-9ff2-456a-a54f-613b859260e7@linaro.org>
Date: Fri, 15 May 2026 12:05:15 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] firmware: samsung: acpm: Drop redundant _ops
 suffix in acpm_ops members
To: Lee Jones <lee@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
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
 <sboyd@kernel.org>, willmcvicker@google.com, jyescas@google.com,
 shin.son@samsung.com, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-clk@vger.kernel.org
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
 <20260420-acpm-tmu-v3-3-3dc8e93f0b26@linaro.org>
 <20260507120003.GG305027@google.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260507120003.GG305027@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/7/26 3:00 PM, Lee Jones wrote:
> Acked-by: Lee Jones <lee@kernel.org>
Thanks, Lee!

The set evolved [1], but this particular patch was not changed.
I'm going to carry your Acked-by in the resend I'm going to do.

Cheers,
ta

Link: https://lore.kernel.org/linux-samsung-soc/CADrjBPqzKpcd9vuCmNUptCUPyPpPbHcc19-7kN-1c0RpW1e5DQ@mail.gmail.com/T/#mcce154a7e0c6cd1ca6cd5a1e37541ed7a85a84d4 [1]


