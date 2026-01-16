Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545F33A03A
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555109; cv=none; b=EMWxxY7Z7ccGNVu3nV5E+5u0vuCER3EsXx6beHK/EVsTZyZyP01jD8M3seoPyYHr/ajA6b71Fd4Erm21iz/MQ40ii8J4SG3z8gZGvsKYJz83lEvO3Erh6E50zI0n5lxY4iLCWPA3oL+YQJj0fuIHFYbI3vQoTuiIJ1D+n9R9csk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555109; c=relaxed/simple;
	bh=AghABfkarHqDZQKCjjyiZmDcR7FwtgnGUdqMcOQ//v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsA9RF8QHXjg9BdZ2EfoR/sY9su1pMAj8BLAaMRvifnXR1R7D4CdtjiA//bce64N9XZm3Fad7i4QmD6ZQAMcnbc0nLmPVfqSwpv/pJBnR7XAlh2Xg11OViVWnBDQy91aLjxJNrg7JVJ8ydk329Uk800tFCILFuii4ft7Rkt2Vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPaj2LfF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPaj2LfF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee974e230so15959165e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 01:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768555106; x=1769159906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+AGXRtrMXkyrXKzRmoE9z026WTEqpV4D7gQD8MxXK4=;
        b=pPaj2LfFQNsV88/GHrQq8j7NyFSfU/ZTDN+4B8nBIYcZJrzTPueWLPTs/Q0d1gyv/c
         HgdMyYHx8FLjkpzE2hY7VFzLJSKVDHDMSNa42+8Y919PDLXNcAJOOW8jrU9NM0z0c5o4
         FvXWiuzEtD6EjoYC+U1BUyQPd2te4/iiWI43aai+IbYvMOYO+ii4DcpPGFqhWUo0fx9J
         DnAqW2ZeVyRho43aCwDPZrtXkPsUdcW9XHNnm1R00tYWW5jJmTzPJCvJa72QG84mYyvV
         424yZJ8tX3V5N/hjMCH0pRxE0qZ9m/edSu5OLEXRJ7UNVcViOY4YPedEMQW7eEoyWAG9
         2mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768555106; x=1769159906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+AGXRtrMXkyrXKzRmoE9z026WTEqpV4D7gQD8MxXK4=;
        b=dZ/O4h6H3ajUttfEgikaVxlfPTcpQ2CQUJvcZ1wKeMuiiqcvuQyBHnZpbPHC+utMlu
         FOm6GIn/Yc7XJr/bqC28xrok4mKrfCNISvaV5gD37IW5lLPoR1Udr9uAJXMYscm5tQ4z
         nCv2bnMF3ZSM5Wk+2ThfclYvC+AePfybqjzYUinZMPULX/3cEp4vRiTo0Wlkp2+1N9BX
         gwXZrU4RGZnUNxyMPe6hz3sU1txsmE8s5NqjLEr91VoEzvVacpVncFgSMU+Kr6QyQRaS
         wuFKC/7ixAlyCEqzhKKnLKsehFt44RvgrrsEN4hUglbcjuJ6ZB+wUrG2sOpONvOoz3FQ
         EkPw==
X-Forwarded-Encrypted: i=1; AJvYcCUYGPUg44git5BYXQpIZ64zOO7CcYMUNF3kmq/FRoijZrH9XU0pqANZqqGUhCLrZEf93ODvLCp3VSUPZFdY0/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuznV4qF6tKG3bxeJf83xeNOb0sGgSEhY4bw4v0DOyajfrcaS
	hcBZEdv2JjEoSv7VBO91r8uVxH1LuhmMpM8j5SuIzA9CHO5bthdZX90FQcED2n8nohM=
X-Gm-Gg: AY/fxX6bKi3WptAVeCZnf/4gPxRPzKtEbT2Emqwa2gb4C2Qyv4T/Axcz3ZzI5Xjrh79
	Pe/SJK7/hB5ObOmY+tXbDRlNWUwThgOtZu0Kc2S2lqCdOuocG6lgxpM9k061NOOa/pfbWSjlxJk
	J/ldtXoR7cxCqNvESnnzKik1IUMD+1Guw0Zrb1H6BOSom/tXMxuJX0WUdd5erjK6m6viE5YgPhw
	UyHdpp3I1OG5hC3UjsYCvvYlp++E+BO+QeKy+9F2HUwnsXWTFqbuQGPsdgdCYnI3xR44u59u6ow
	0cqXD4h6CAOjff1iMuNE069Ahtq0BquYP5FqN0YZYKo0Ro0jGJzr/i0HDyP+1yIeHOsfFvUrhTx
	W1ZZm/LOXC+QgA1wX+D48m2pV92wGtoSySIwaOzcE14fbf62agEA6otoerZQk0Lv4kJx7RpvdAw
	+ZZIKdnBunCp2M9U6j3A==
X-Received: by 2002:a05:600c:6209:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-48023ea2fc7mr6725565e9.4.1768555105706;
        Fri, 16 Jan 2026 01:18:25 -0800 (PST)
Received: from [10.11.12.107] ([86.127.43.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm87551575e9.10.2026.01.16.01.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:18:25 -0800 (PST)
Message-ID: <d3dedf5e-ada3-4d33-b1a5-7556ba80ffb1@linaro.org>
Date: Fri, 16 Jan 2026 11:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] dt-bindings: mfd: Add Google GS101 TMU Syscon
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, willmcvicker@google.com,
 jyescas@google.com, shin.son@samsung.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
 <20260114-acpm-tmu-v1-3-cfe56d93e90f@linaro.org>
 <20260115-slim-denim-potoo-cad9cb@quoll>
 <200d34bf-150e-4f8a-b400-2f54863502ac@linaro.org>
 <e2f028d6-774f-4773-889f-7d56b833067e@kernel.org>
 <fcc5405e-189d-4195-8db0-3acf35bbc0a9@linaro.org>
 <26d86470-aaa2-46e3-9940-010a903df4fd@linaro.org>
 <0176a63a-6b04-4e30-b718-847133882050@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <0176a63a-6b04-4e30-b718-847133882050@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/26 11:14 AM, Krzysztof Kozlowski wrote:
> On 16/01/2026 09:50, Tudor Ambarus wrote:
>>
>> Because of the hybrid approach I'm arguing the ACPM child node does not
>> fully describe the hardware, and it's just a firmware abstraction.
>> So option 2/ would be to have just the TMU IP block described with a
>> phandle to the ACPM IPC:
>>
>> soc: soc@0 {
>>     tmu@100a0000 {
>>         compatible = "google,gs101-tmu-top";
>>         reg = <0x100a0000 0x800>;
>>         clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
>>         interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
>>         
>>         /* The "Firmware Phandle" approach */
>>         samsung,acpm-ipc = <&acpm_ipc>;
>>         
>>         #thermal-sensor-cells = <1>;
> 
> Yes, this one, I think it's the best representation.

I was leaning towards this as well. Thank you! I'll start reworking the
patches.

Cheers,
ta

