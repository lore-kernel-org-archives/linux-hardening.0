Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D047314B6D
	for <linux-hardening@vger.kernel.org>; Fri, 17 Apr 2026 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432533; cv=none; b=J/Kwn2eqO3H95srdWVAOJIwj0PreR8uF5uklMQsWk8SvStM8nSu9+4Dkq7D5YZR1leAfAyWDY0mJv0fIBkaldkeXTZ90twN2tJdNioZ1G2MMBaiwvQ5YJxfkvvrPPyU4RbHlvx8R2ol/h+GqOaQK+KmqOGoA9PeeUb/ZpNhSrfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432533; c=relaxed/simple;
	bh=LX0qWu7Xbd8TT1NvBOE97BzH3UzHyHp8aIxB3oRV2iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zqtf/yhvUauSPxwlqBypM1WhNyiRF//bk+rX2SWmIKjLSSkxUPQQRONSW2guIQ4/DgBFCRvuXb9Wl8YvTyfoiseve+9+lZHuoOJEZrrkxGbNkrCmeqTCEL3D5TwL2VuEfRy5paLPPToPfd+J7zGkUYx35KR5c3ZWOCSPL08r64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fGYXAHpe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGYXAHpe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488c2690057so7018955e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 17 Apr 2026 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776432530; x=1777037330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiSRutZE2i6BYCdYYnb6mg9P5OvuB1XSyhcSB7iODxI=;
        b=fGYXAHpe1Soi9YINpIgSZWLTi0aHWdHeqniatQYcxVVGY/osBdF+OfGFMELkn8ZC2S
         kbqy3Za0da5vNOq0qF8yGzKgvNErTWQExc4GnlG4ODFp2Q0lfKV3WrXLKcE2DUCOkGA5
         v69RB/Tzs4dmgp7TGA//CWuCznEqEVu/Nlg7RodmWwBDhRswLkS7t2xJYJMWtFSeNBml
         MkeCcmqxj4z0sI1JDYEUbAparuCZe4k/tNVGtzp1idM0OWB9qYZWp6me00EqOx41bNTO
         H+elb4tbHxGNVpAHjyQiWNuHhp4JiUoX/3mQ3Zhs1aqO7LtZlVzEGa6eSqUAd8GeJJLY
         hodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432530; x=1777037330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiSRutZE2i6BYCdYYnb6mg9P5OvuB1XSyhcSB7iODxI=;
        b=bpNE4FmflPcXbeHevCF06r2/AfFzCJebUNE08aa6jNKPdM8a/AwbWYr/eUoPbcVq/o
         JR0xlb4w5XFFIhePjttdAkmv9jPTkFfaWNgcWwrDLMB0In1jDHX+340ZjuFzCfcpNnIe
         X/x0RhvL0OauOcpfxgT6hnWPF16h842JnK04NBbZGt3ovPFfh6pkkvt8IlrZEAPncNCR
         P8oXmZY8J/OIHiF4r4ejqXUO9Ewqo1TLy+wQ/b3nN8Sd9P1Xq++UFZWb9yFIG+A3lX9i
         KBVy+kbYW5fjgiAid0mNpdxH4q4C0JhgvWB0t0wBRAi2P3717gAbLbvx3Xd6qjhnh8qq
         KKDg==
X-Forwarded-Encrypted: i=1; AFNElJ9R5kvzorVY3pEZHBIZF8rznS76KhmJMMbMyG+Q1O5bCYja5gaLIv3HEov13fcIrXWGb0/pbrITVfqVRP/8WCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qglV+K3bZC1JLyXwwjz+ExfrPqJX6h11DaYKRVmlIAhGTpPJ
	xLoEMDQmUPyExPdbygQEmMImhPFztZMXVGYBZGHOXzNI6jETD2oKfUQI1/ecJy3Sy7RALS93LPQ
	whsu4GfQ=
X-Gm-Gg: AeBDies34x8tWg9ZG1vT72UEXGtw2eFmByI/neSEoLEaERew5vdhNE5gUWr+hKNvGNz
	DKckxvyIGBRWhK1maL1RDOKd6QN6lk+bkD4cTa1SSKnzUVq6PgaMGOU09AFoStO8as9KnmHtj8v
	j8jY5S0JcrhBOJDXbCEs3QlGUnqMyO9s8YuDIumCwJsTHT8MdeigqTYFdpFG+HPFkyIwZ3uE70p
	qczYPQefLwY673BL19RsrO76V4HeGdptoodRKx+vY1HIcWP3L5PSbdTXaw+zkoVC4tBPGLwAaw4
	Jf2tZotOU0N04TpmL2gkuOYs0BQFaOmUnUO/EJ54Jfi0xxjqzR8ZER15JTULYoo/j2WyNLUudiA
	ZEmzWtMZlHLYD1EKBLWXPZRxJdJjNPVj7Nrgbcy10QnXzounHbcouFyN1h2gGVhu0XSPbBTFNp1
	CR7A+l3swZWC2t9u3aaeKninblfbuzHHMW5OZNTOX31w==
X-Received: by 2002:a05:600c:a318:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-488fb784662mr31297785e9.25.1776432530464;
        Fri, 17 Apr 2026 06:28:50 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c0354sm40049075e9.11.2026.04.17.06.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 06:28:50 -0700 (PDT)
Message-ID: <3a36821a-4a44-4f3a-9f0d-5ce521b323aa@linaro.org>
Date: Fri, 17 Apr 2026 16:28:42 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: thermal: Add Google GS101 TMU
To: Alexey Klimov <alexey.klimov@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <20260119-acpm-tmu-v2-1-e02a834f04c6@linaro.org>
 <DGUJIFLIOK7Y.1Q4PZQU3MOWTT@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DGUJIFLIOK7Y.1Q4PZQU3MOWTT@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/26 5:48 AM, Alexey Klimov wrote:
> Hi Tudor,
> 
> On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
>> Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.
>>
>> The GS101 TMU utilizes a hybrid control model shared between the
>> Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
>> firmware.
>>
>> While the TMU is a standard memory-mapped IP block, on this platform
> 
> this ^^
> 

okay

cut

> Is it Google TMU hardware block or Exynos/Samsung TMU block?
> 
> My understanding at this point is that ACPM interface, ACPM protocols, etc
> appeared on Samsung SoCs before gs101 (maybe even before initial SCMI
> prototyping). It looks like ACPM firmware, communication via mailboxes,
> TMU channel, dealing with TMU behing ACPM, etc are actually a standard
> Samsung Exynos architectural feature, rather than a Google-specific
> implementation. I can't say though what was the first chipset where it
> was implemented.

autov920, exynos850 too can use the hybrid ACPM TMU approach.
I'll generalize the description.
> 
> Given that this is a Samsung design that predates the gs101, would it
> make sense to use more generic name for this binding to reflect that
> it is Exynos-derived? That would save us from generalizing things later

The name has to match the compatible. We can rename it when other Samsung
compatibles are added.

Cheers,
ta
