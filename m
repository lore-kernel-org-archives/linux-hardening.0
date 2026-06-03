Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91B389DF3
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483128; cv=none; b=eSqHJxzBS4AxTXluZw74nf6Szcy4cRvrqScVSXmiUonOhjzNAT8whfO80rR2WeDOK33okW5v5S9yoyJORpx238IfFc02VSmYYlifU7v18SKPXwH35Jo9ra8MjpC8R/QckIyQYAlrVO7yEICZINNVg+bHR9qVapTggJkdJcNGhIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483128; c=relaxed/simple;
	bh=YX0a0jpNYBmGFxakN2CbC25kVRva7yDB8L+NCVPEiTs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qTRnNGZMemXTYSvLj7GxF6xQ/SHDCwhOcTABBeFME0eA6JV21fBbvju6ga4Hno/CdAuqfz495TzjIYQXQseHnoIJY4MGBKRSqOZRDXuBTrS0s1H5HxqTHJndvxNXtMxd/4FHclaPZheezLnUsVk5ZehylVb0NF73LCiJbGttooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7fuJLMl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7fuJLMl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b613a17bso7604505e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 03 Jun 2026 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780483126; x=1781087926; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX0a0jpNYBmGFxakN2CbC25kVRva7yDB8L+NCVPEiTs=;
        b=X7fuJLMlz5MZvCjERHFhiUkSQVtVz1UwmlO2tR6qmQwMpruc3xYG8d1mdSH7PlD1/w
         FGAV6s2h1blkjop1RpCfU82ihIUhR9/b1XSYu5O8RK1IN4FzJ2691Y+m873fex1q6kmd
         /iBN634tKFusQqkiKEHUH4At8ekulsLsMFekWmQ1oD5/3oeCgMlsZ5Mq1m+9HBGlP7ls
         ksfAME0e5o02tIxJnbCCp4lMPjv1SNHO6u26bkAJDA43j2YwJVt3+LiA0vICgXBIw0ZE
         6DuL1c0IPiKg+LYEQu2h5Tu7bbMivO8Y7zq4PEwtWD8VnWLydTMb/Tjqpt3ofv200bZa
         28SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483126; x=1781087926;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YX0a0jpNYBmGFxakN2CbC25kVRva7yDB8L+NCVPEiTs=;
        b=jBXPdhbAF75PvATscIlF3+Scw3DeeSGwSNDa54x+HgVWNWeEbMFr3H1gZhrKYhyQ9R
         Kqw6zjvbXUSMLjbMx7nkeXLMhBZeyR0aDKw58IyFn+wyHbX7KZMJ5n5SCFhgFCHqzY/9
         vTS5Rq1WQjG6umQhJbIQxSlewpK2X4xbZbZshfDdUCW4l8zmppZnBro3BhkcCnrXtLiQ
         ujyx/Pj56jRU8h4a52e9yhi14dPwSJ828YI0VB2Ml1HfEHI72+mcI20FG9o/5QmQjFv4
         lap81MOUEzCBiqPfgAtGkbL+Nzw5zWwu86pFSaHXRabu8kKG936SyOaBMRtDj/5KLLL/
         Tzmw==
X-Forwarded-Encrypted: i=1; AFNElJ/TEpB3Sll3EJkwFAPSn77zW817q/VBNV5jLz7kH6k5lBO3NpFiBPCt2zZQjmpQAucBaFKkOx+Z4NAOFt2Foog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkQ8VzGntVpz61Enn0F5+DTnbUJ62YPNV+7qI5Ky+RfJKin1G
	770Aoz6lPQyrKs2TETbTSktGVYHKNhxIHMfF3yf6KRWxX3jwziYm4gximA/U5spOO0I=
X-Gm-Gg: Acq92OE8LIGEiy6hnr8pR4sfnd+eVCBn9gv2JM/Wua4ALr/UXD+pHzQnq0NEQOvSMm3
	BwPConJDX1ee9rLa+gGMWwxv45cWKM/8pDR37cm7QBa6woWhx2UAQ0LrQ8OYn1NoVnsVfuzbeWa
	bvmmHTz37qcqa3vdKtCM1SjsTB7U5T8itr9ziJEjxDbnMeMhXK4zGm+JhGOd2EoHSM8C3eA8UVs
	CvtgEs6CEZq4hVYcWkTGfAkx4FC/xa2eyZbqxvlPs/RJeBPbV/Gvsn4pX7jr0rYqqIpgAxN8Gbr
	gKZahNVlgM19emwvPFGpbjcAOvI0cPdrG3PrpQT873U/GcT17B3feooZqskTrSl8Hvd0/oCrp24
	vdzrp/2ryjSt8DEWdBsrHHqVHJcUmsWuo8LJv9y8nJc0fa190jJA1ncieZgqAkkg3dZna53SewT
	qujYVht1CC9t/cRKrwYN2ZNtGUKDsBLIpjUkw2gpxzknMwxE1Tyy3lfkCpWMzp6fc4vDLLTQOBx
	AHMlAEqxfecLClkYBzSOLM4IeW2
X-Received: by 2002:a05:600c:3596:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-490b5edd71amr48759235e9.24.1780483125952;
        Wed, 03 Jun 2026 03:38:45 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:9b1c:c9e0:4645:9af0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b616d6a9sm49891265e9.7.2026.06.03.03.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 03:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 11:38:43 +0100
Message-Id: <DIZCLBAOV4ZM.9SJGGMZONFB7@linaro.org>
Subject: Re: [PATCH v7 2/5] thermal: samsung: Add Exynos ACPM TMU driver
 GS101
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Peter
 Griffin" <peter.griffin@linaro.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>
Cc: <jyescas@google.com>, <linux-kernel@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: aerc 0.20.0
References: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
 <20260602-acpm-tmu-v7-2-8047dd54b0e9@linaro.org>
 <DIYTOGU8I2DV.1GKZ59F7AJWTE@linaro.org>
 <c76c8f9b-bdd1-4006-aa28-735254f0409a@linaro.org>
In-Reply-To: <c76c8f9b-bdd1-4006-aa28-735254f0409a@linaro.org>

On Wed Jun 3, 2026 at 10:26 AM BST, Tudor Ambarus wrote:
>
>
> On 6/2/26 10:49 PM, Alexey Klimov wrote:
>> On Tue Jun 2, 2026 at 6:00 PM BST, Tudor Ambarus wrote:
>>> Add driver for the Thermal Management Unit (TMU) managed via the Alive
>>> Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
>>> Google GS101 (and Exynos850, autov920, etc.).
>>>
>>> The TMU on utilizes a hybrid management model shared between the

You might also want to correct this "The TMU on utilizes..". On
gs101-based I guess?

>>> Application Processor (AP) and the ACPM firmware. The driver maintains
>>> direct memory-mapped access to the TMU interrupt pending registers to
>>> identify thermal events, while delegating functional tasks - such as
>>> sensor initialization, threshold configuration, and temperature
>>> acquisition - to the ACPM firmware via the ACPM IPC protocol.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>> ---

Thanks,
Alexey

