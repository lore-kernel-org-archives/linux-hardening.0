Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3D3E9594
	for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947652; cv=none; b=m/PVO7lCS1ywYa0g/5Rw2vBgusvrkhUQsX3uLx2GpVS47IhuyNY5kj65wVbrrsG++Hfcf1o5nW8bhXPrYKafYKtuSRFSy9UH4N0M/D0pTBks6f46o5xNLTa31szNCiFUBpidYAGMYnf/nN67q23Fi/GOYffYNWupMD+s1EjPJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947652; c=relaxed/simple;
	bh=SHt8/jDSXolzcD5Ycs/HtVeMQJoHpcSGMEeHPCWu22c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIJA0WwSpmfj0XF/ulMLz6jIJ3R/WitgkjH3p3CCI8lh1q51L8TgfL4stPchPcsIGfwcT+3IYnZV6B68Mb/dDrUvyVJc+xogzpt9y+r/T9BHPEboOJiCtfIYFW31o9tVNH22hyco2hS8G+8uO1iLs8DBOwbDiXoEgRs5kJqaWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyuRrHlB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyuRrHlB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ad135063so58518335e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776947649; x=1777552449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHt8/jDSXolzcD5Ycs/HtVeMQJoHpcSGMEeHPCWu22c=;
        b=OyuRrHlBpR0TcLjq11DTQNVtYQFiAa0ENCTgMudk1mmQm9bi3GjK0R+oqirFvaux56
         tiRflDIWvLlzZ0z0VxddZifTV8BBSsdBZDJ83frSosJnARIDfSQvBCWqcDIk/20KWfF8
         RLnCxbLa42aWvpoN3X5VBE8QCtyZUTqn5uHDT74lEb83MawzycdF5ewTBOMq8jM/GmZ9
         EGnQyJAsjGh4MX4X2Nf+i2LlYrrwenkMWqPKmxB/1LtLVIpImd5HAvjizdmNEMlc3NMT
         weIWR5WCAM4x+JDd3XhJW3AZ+3PILhr8/095YeW4587nwhr6XPNaIspj7jKjrWLB/rUc
         8QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947649; x=1777552449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHt8/jDSXolzcD5Ycs/HtVeMQJoHpcSGMEeHPCWu22c=;
        b=IBG7DLT/bOaWroW9ZJib86CLcbP1sDt43GuyvZaLsVjiaNrKcslWHqygo8P39Pb6Ge
         R/SdkScnTl9GR8n0iJ2Kkk8i0WvIY294a297ESE3gMUgBmmOHJviPf1noO2eYly3TNEc
         upfePc27Ei5F3aGwaR3OkYcCP3a4TzAYNe0+6uMZTW9zxJChjOu3ywsnhRO7kPJ5AKw7
         PgJ0gWxrws/e1b9PA75wPq/cuUkoTDRMKHj2ahMDQay28X/C6iM3MZOAgjRJldB0/Fql
         ONWGTFWMsfLsv1mhmBtcVlOy8Dv07336NA7N7xVkcVIdw0+i+4tLSqLDb3+bu0n+/kmR
         skTg==
X-Forwarded-Encrypted: i=1; AFNElJ8pxSQAfxVqeoofAnqyLyMfNk1MYD20ndG3PUOtmrUUUPmdZyTfXFp7BNTcVJEE4k05imABFHNgKwuqS1H6ijs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZMPCbqtxxppVTyHMcDX4KnPymUqfS09c4fFp9f30JvRuRxrn
	GjemVLEb5qM9NQFsKQh18xUhAsWdxQdmyeV0+QnbQdVR9lQ/248gFpuBakWuodmERiI=
X-Gm-Gg: AeBDietwOSjcwImLQcZ8cFtBRhfGz5JhOKhJJpQSSC2mHMajsaDfh6au0VIPQKL3Zir
	k1GyJK8tOvLBcu2M/s4Pdkk/nHw7hBmUJCrnhPq5SUm8A4dePYYoo6eZY0xkhH9X2ynkbURs37B
	UAbPi17+pbN8AuzvBFEnAHjf5ieo6reKUxIRCf1PyEKyAjv3HD04cPnkf40CW2ZCYDqvKI9P8fX
	NSLwaQE2GaJHXR5hWOJLdUsRVDqZ5s8FSZJ/d+pK9MDuQAFPlM1BeQo4fGRY3m7P5Jw5vAvLbxo
	yhLvp5X/juyR1V0SVmh7CRX9A4Wi62WQF2wP6o2ddWiROKWKktNNbukigwraIPrwhRL/ZWCZkqK
	J6SbKZ2g4MkddGjyhy9ClYfpjVI1vfv2gwA1C6uqPsHSaLEOrJvBEuStv72mOWU5ZC0cCnesV0B
	p2qylzm5MttbswzfoDsHFfWbgs6+WhImdlwrcaceoHT88=
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488fb77d343mr363286325e9.18.1776947649347;
        Thu, 23 Apr 2026 05:34:09 -0700 (PDT)
Received: from [10.11.12.108] ([86.127.43.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c773fsm588535385e9.12.2026.04.23.05.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 05:34:09 -0700 (PDT)
Message-ID: <b85c3dc6-46a7-4d08-8008-a8334262f4a1@linaro.org>
Date: Thu, 23 Apr 2026 15:34:04 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] thermal: samsung: Add support for Google GS101
 TMU
To: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
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
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Sashiko identified few bugs in the existing upstream acpm code.
And two bugs for the current proposal. Preparing v4 where I
squash all.

Thanks,
ta
