Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188F374E7E
	for <linux-hardening@vger.kernel.org>; Tue,  3 Mar 2026 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528507; cv=none; b=ELQ7UjEn13X8ry8/TTfZLWpwn9FZRVeipjE/SsscL8dXi0FRTI/rXuO3owxaft9yE4Y9Idq6hI3oFYYzm2IbFnVk7UvX4VBTRTrFyPF3JQfPkAklf4Ov3tBZF18bqUoIRKyR6iMB+3jrnvFoK2MlQ0YjJXOHBmD9x780ty7T6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528507; c=relaxed/simple;
	bh=wKzv8JjnWV5gBG65VFCZ2zPm9xxHlHBRT8kIM6tUCBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFWNyQ1irAUYRpGRX2nb4Qtx+2jIne2MBjKlqUcmq16mBg9Mht9NpN50iG22FVt6bMisVa5TdqUyYNsw5VbQvC02bv7ZkEM3ZbYKwh/hL0rpTHb3JxfS2sV1/cHyFLplUb4G2fzGXDimA4U9TlxWz+nD7tFRs3FXclsTYj3Bq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5+HF9S7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5+HF9S7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4837584120eso38716005e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Mar 2026 01:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772528505; x=1773133305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xKcWF7NPjeXU/Yo9Rn3BptYJg8YH0is0Fv10MXJEt8=;
        b=w5+HF9S7SpRWMZba5sOz4lNbxVM1DShoNulBVR9GGxFlErxPJAQIB1tNRAoWMdSf9C
         4BQawI3ab20j7asF+paexzPduMb7qjwh9hq1tq23FAwz3VLgUEjHntxUJLgcFMkVXLms
         ZjqZoRqfWx5XWsj7PG5+UmShQlKIhGKOaQpzTzyIsMPk1iLbgnWdm9f3g6OcBdl5ARw4
         hPxMlFP3mbZ/0b3uVahPv3nIW9eJeMuqGARhNAOpjhht2yD2DU0pE2Qzt26m2fGqAnEr
         SRfpD4Pre9Svmd0Mm+o43o+qLWIfHVbPYYM8BeczfOir0/EhL6Rca1XiFSiWQXosLsLu
         pYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528505; x=1773133305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xKcWF7NPjeXU/Yo9Rn3BptYJg8YH0is0Fv10MXJEt8=;
        b=W4aQPt2VnNc8i+e+CxXRBVwn2CG5rhEGBCGyqG4oJHsI//oZpI+6QuO22pdMWFhw1Z
         JsLCGBp5Wn77lrNer2FqzwnGXTCmrQ9CPVqjpUiW3VByxlqf7Ce0Z2hIBed67gNouZpP
         xymjGidk+BfFbyfdadw5STd18vrkCh6Ro5VmVqTbbfhkOrw4+vs1e2LgNoM4SNOhTsR8
         ewcOJmxKAkhj/j24qgxX4A3TChTehaHcmSSDcPkwYnujvSZqDGav9KligtReV/H9VLQ+
         EgRSJ7Bu979Y1o7WZW6JwzgL8vnzjq7EsW/3wichdicXhH+SOOnAPHwyx0s+QSyANoLH
         qoLw==
X-Forwarded-Encrypted: i=1; AJvYcCXV7DERFEsyO53m05zZsVBT17yHtzfs7T4dlCRZrvYbXsWKpGGYZW/6DOTOWkRbc1t4Ces2Cp4Tv1mnzumxi+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WXfo0gw3sJq1JCVaeJHwg2QcIi7iNP5NL7nhMLqTwjDL73zH
	EzJ4TGA/ZGZvLsOXM1+3IJPO3L0orr+i5EYHPgQ5bry5g48Dc90QoTqVFchG7VzNqq0=
X-Gm-Gg: ATEYQzzgcLRnl+P0fW2a1t58XM3rQ32erEoXdu/X4tcjuC1Fm5ZUkan1Gla9T/WDPKh
	IGBlSwNW3HNdXDEeWXbHksbzu7/0/rDM91k9vv4NUPALyTYMXUyogI4zvQlQ9L6gqeMwpzZMIMk
	hd1Rd9P+bHTCe2/rL3OXtWHZmmD4lm57fSOaA5+tN4A3gmpudW1jxgK3yK0XHWE+0aTjkovbI5u
	0MKvzqfPyfRS8mvhudoSQgoMUqZF+sFA1Jqg9gyqR/aYpdHrVb4oSDdAv94NEtZSptqAepMnsxz
	15tuzQEj8SiEHr9Q/PArNewMK1c6rwXhUMrslP5GqYnF6ysrN19NH5VDKZ5Iv1hwLG8GJ9DjeVX
	Emh3BK+fgvSCYk4sJ1gX4/4WUG9uNhhl6YnhObY5fWfyboDURZRAi/0pr/1pIbjRm6N5xzPvjwA
	4qvVe9uZ8EUm4XtwxwMWMrbFhLe1+OFz4=
X-Received: by 2002:a05:600c:6385:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-483c9b53c9cmr291863355e9.0.1772528504551;
        Tue, 03 Mar 2026 01:01:44 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3474dsm312924805e9.1.2026.03.03.01.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 01:01:44 -0800 (PST)
Message-ID: <b8a029f1-1229-418b-895e-b8dc0319b545@linaro.org>
Date: Tue, 3 Mar 2026 11:01:40 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101 TMU
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <CANgGJDpjsyoCnuXuMMi1L3nWNJsM4aMs6C=NvBcTkWeC3NFadQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CANgGJDpjsyoCnuXuMMi1L3nWNJsM4aMs6C=NvBcTkWeC3NFadQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/2/26 8:30 PM, Alexey Klimov wrote:
> Hi Tudor,

Hi!

> 
> On Sun, 1 Mar 2026 at 02:26, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
> [...]
> 
>> ---
>> Tudor Ambarus (7):
>>       dt-bindings: thermal: Add Google GS101 TMU
>>       firmware: samsung: acpm: Add TMU protocol support
>>       firmware: samsung: acpm: Add devm_acpm_get_by_phandle helper
>>       thermal: samsung: Add support for GS101 TMU
>>       MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
>>       arm64: dts: exynos: gs101: Add thermal management unit
>>       arm64: defconfig: enable Exynos ACPM thermal support
>>
>>  .../bindings/thermal/google,gs101-tmu-top.yaml     |  67 +++
>>  MAINTAINERS                                        |   8 +
>>  arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 209 +++++++
>>  arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
>>  arch/arm64/configs/defconfig                       |   1 +
>>  drivers/firmware/samsung/Makefile                  |   1 +
>>  drivers/firmware/samsung/exynos-acpm-tmu.c         | 212 +++++++
>>  drivers/firmware/samsung/exynos-acpm-tmu.h         |  33 ++
>>  drivers/firmware/samsung/exynos-acpm.c             |  35 ++
>>  drivers/thermal/samsung/Kconfig                    |  16 +
>>  drivers/thermal/samsung/Makefile                   |   2 +
>>  drivers/thermal/samsung/acpm-tmu.c                 | 643 +++++++++++++++++++++
>>  .../linux/firmware/samsung/exynos-acpm-protocol.h  |  30 +
>>  13 files changed, 1275 insertions(+)
>> ---
>> base-commit: e2211f5d980086dd9fbdab3bcd86b715e12cae13
>> change-id: 20260113-acpm-tmu-27e21f0e2c3b
> 
> JFYI, the series doesn't clearly apply on today's linux-next:

okay, thanks. I'll submit a v2, but right now I'm dealing with other
higher priority topics.

> 
> Grabbing thread from
> lore.kernel.org/all/20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 18 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 20 code-review messages
> Checking attestation on all messages, may take a moment...
> 
> Base: using specified base-commit e2211f5d980086dd9fbdab3bcd86b715e12cae13
> Applying: dt-bindings: thermal: Add Google GS101 TMU
> Applying: firmware: samsung: acpm: Add TMU protocol support
> Patch failed at 0002 firmware: samsung: acpm: Add TMU protocol support
> error: patch failed: include/linux/firmware/samsung/exynos-acpm-protocol.h:40
> error: include/linux/firmware/samsung/exynos-acpm-protocol.h: patch
> does not apply
> 
> Was it done against mainline?

Of course, yes. It was on top of what was the latest Samsung SoC tree
at the time of development. Internal kernel trees may change,
depending on the maintainer.

If you want to try the code while I submit a v2, I pushed what I
think it was v2 at:

git@github.com:ambarus/linux-0day.git, branch b4/acpm-tmu


Cheers,
ta
