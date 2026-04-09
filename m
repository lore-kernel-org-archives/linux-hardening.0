Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8263B7756
	for <linux-hardening@vger.kernel.org>; Thu,  9 Apr 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737386; cv=none; b=a6v9xx9ut4J0iuNhHBjUOeXY2Rrg4rnP4DhbvXR6zqiJ8bT1hC2ZGiQX6ShO9O+2Dx7gpwkbjXFN3Tkv3eEIzTr73y10YbosjOz2Js+FsLv6C7+fIyT8EnHDJ4VYVoIaiiZLvqiro+OI5FrDmrU+AAIzu0qDnQQrklt31mLrRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737386; c=relaxed/simple;
	bh=8ha08POWCdts2kcxBytAF07AGORB5Xw+1RHSI50iK3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ2n0tzqsa9/GBT4XCfcU18eSx3XvrOe+A9PfWMX7rVUWGlqkAJKdEABv3Kc4TIbb8C91bu2eCEK1H+8+Nd01G9kW2IC13ya0ovtjxKoJp/4dIEV7efW23IDq+n9Edyz7tXKBisUaEIlrxctfsaWcZj3pBbhrXHeEIizrZ9mFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OEiGXjJT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEiGXjJT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48896199cbaso8420975e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 09 Apr 2026 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775737383; x=1776342183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNUR+AEM+0xI0nm5DHe+rKxaeNx6oASLbxq9t2PiLlQ=;
        b=OEiGXjJTi57weYjl+rhiQNvazHT2ysm2cUX3YIA27lwwzCFHaPZbsXpndWn60MGp0o
         DVrrw+VtarCCVRX96UvNaBAu2z9v6pwvm+cQ84aZeFSTzzhdfGLmG4sbjVu91ih06F02
         YG1IWyi0Do33dl02HAxtBzlzteHp0xEOeh8yGzl4Ys+cc6vNPH2ndFLwmdi+zEfs8CQC
         7tjsLu1PQhReACU1uqhDjCumpcos7kWg+98w+V1ZE0kuM760A5m47y2gX+xDG5mqWEoJ
         ypTwtmZGODY09vjY0t4Gn7Qgg3Zs6KTrGMeKXyYeB+QM8446mAstDGV3Uq0Oxp8mPf4L
         9P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775737383; x=1776342183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNUR+AEM+0xI0nm5DHe+rKxaeNx6oASLbxq9t2PiLlQ=;
        b=CB20qecUmNvw9+bxiNJyZOJBiqD47BUOIQ8GiDP2bXYqW310J89cCp9DtKchZ5E5Q/
         PhEa203Ca63r9aWZvWCcIj2JuhWjtmxFRRwY3RYRpk9CSqYpCjxmYB2gREfnb6+y4tux
         TWK02BfAcbyvpCQX9xAYs5VYHwuQ9OBrramFstIqAXr+ylPMCFhrWe8ZK2X8begin4bM
         7NjFPe0VaF4NrSfa2k1KbStGM2uWDbIla247YJdfsRN7BLqrZf48Xle/tkekXoXTvWfN
         /Xc2zi6AyJIt+n0UadlMY4Vl43mgUNF6obhucmRHyinasPMh89Wkjucy4sYQf/n9iJ85
         cHtg==
X-Forwarded-Encrypted: i=1; AJvYcCWoN1XjEnfxue71XHVCTUPR/hqD/2YeCohmDjMk5l3PDWxenTb8uEFcBWmBDVG2z4drzPdOkDHhZsJrYqWxBok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kiU52LJHcWZfBcWpvcmU55nykdCbcnmFiBqpwE2LvNMTi0zv
	el+RMiofh8kGKUhpO31XZD6XcZ9V69nEPPnKD6MJEoUC8xdsA7qLtoPuozyBn391IM8=
X-Gm-Gg: AeBDiet37W2i75a+626lfyC+BkrM+9fleyPwGSQ9y/btwUCWHALRNdvUvQ9I/2QRTxA
	ulGGx0MVx8D2s4YX0djhbAKUC8PrIBKz2hLNbPQTaLCKQ9LYExuZ0j+etN1//Y/ncY3zbjewTVw
	pgm1POhQiD++paDh0S9dx0QiqKp6mBnjElAgQdL7fJ6CRbyhE6F+P2E4UyN/qjZtfiJ+ox7XPB4
	qZ4dmnLMXnVSMs18Xwd5TTNq7mdwyrM0FwSSry5tQyY1E9uhBegVxkSCfG/LP0QN467hemBUQB6
	SBeCm3o5Yh6kqnNBHD0p+qEUlQ9VG2Spv3dVUNDjfN8QdqRzHMWHVyrsqgYjZBrgRv9Lkk0QRVM
	DajpQjLi7AmJdwe+6DX/t7tV3DzHtVXIkWTv8QE5iE47nX0+0CVK48GaaRujDp61gFmIsYKQgJW
	hWzdLBOmrsrp+71v53KP3/vS33WZXRTB9CNieuE73Pjg==
X-Received: by 2002:a05:600c:1554:b0:488:a639:b787 with SMTP id 5b1f17b1804b1-488ccfb7907mr47873215e9.11.1775737383421;
        Thu, 09 Apr 2026 05:23:03 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd21b604sm69928745e9.10.2026.04.09.05.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 05:23:03 -0700 (PDT)
Message-ID: <63087cad-a8d1-4ff0-870a-6e1a738ff8b8@linaro.org>
Date: Thu, 9 Apr 2026 15:22:59 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101 TMU
To: Alexey Klimov <alexey.klimov@linaro.org>, daniel.lezcano@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
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
 <DHNUUPQPD5DR.18P18VV0LNTI8@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DHNUUPQPD5DR.18P18VV0LNTI8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/26 5:49 PM, Alexey Klimov wrote:
> On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
>> Add support for the Thermal Management Unit (TMU) on the Google GS101
>> SoC.
>>
>> The GS101 TMU implementation utilizes a hybrid architecture where
>> management is shared between the kernel and the Alive Clock and
>> Power Manager (ACPM) firmware.
> 
> Do you plan to update or work on this series? If, by some reason,

I'd like to resubmit, but I got derailed by other tasks.

> this series is postphoned I can rebase it and re-send, for example.
> IIRC it needs a clean rebase as a minimial change.
> 

No, it's more than that. When I talked with Daniel about this driver, he
suggested I shall really focus on using the .set_trips callback instead of
.set_trip_temp. I'm not sure if it's possible given the static nature of
the ACPM interface. So it needs a bit of investigation, which I couldn't
do lately.

If we can go initially with .set_trip_temp and then come up with an iterative
patch about .set_trips, I can of course respin, it takes me just a few
minutes to rebase and test. But it's Daniel to decide.

Oh, and the device tree needs a little update on the trip points, but other
than that, we're good to go.

Cheers,
ta
