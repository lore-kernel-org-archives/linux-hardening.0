Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DEF3559DD
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488823; cv=none; b=rjj2//clUeikILlVQluwXKp08TZQEyPn4SsxljJkrlm1yDncRLgfkTVVeywsC1/+H3xz926cxe7dLx8/d61hpH3Vp+3BdxiiV89WcWFGaM5H2L2zNHB98FFSLEAxXZuD0+j7dImcS5OL7scleiwpeLYizVtEQi2YeZBCcQXpn4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488823; c=relaxed/simple;
	bh=swNWq/Qxez0tgxAwoz1l6nJo+pCorfSqxCY1iXrFZHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XP3OYirKfmXNG8jAEetgO/mxn0yOu5snC78d+ED82ln7f9vKUy2LTuThU3m6evjhaTUrwO0irPME+SDrCnd0FVnNbZT70tx2LIMn9L3Mgpz/Ot9A6apIX6f0/PQ0JRbZ16lBcjE6Uwf36xgqxG62B5b/SCv/vdVcPruZf2jeAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JdFoLE6l; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdFoLE6l"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc544b09so722919f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 06:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768488819; x=1769093619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHHyxMePqBdKnAeFR/9faD5DxG5+hRTAA8ppV4k9N0M=;
        b=JdFoLE6lsO3/oM2JGXO/yGXC6L0YrK6il/9okubnHpD3W5FLZPcGZCyxbYJW3LXrfE
         DsoAhnbYdzc5nzgWQjkDiYaVac7ncAQyD0SyqBW2zvJJghwXC4LNwJzMPHV7uoVd87sM
         YAlcZxWTNYIyTrEEsNymdzEiLf3SIec7fc0MpG+yqqyez8Mcye5yMWrhhrt5Bl2Fdqsk
         QnjtY5ApXmMR9hgqvyQHSW/9nrunVJRgdO89/ZfRk0NnE8zzWN5gZeglS2CHXQWlaFiQ
         1nhCJQzs3N8rB/ATZjN7pex/2FkRgIPJZg3GiHaE6dZM35X1nSJNp4HlLG+P4ZDEdRt6
         RKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488819; x=1769093619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHHyxMePqBdKnAeFR/9faD5DxG5+hRTAA8ppV4k9N0M=;
        b=p/2xVg7vP3vcrifvHWViXw6VKtDfYwG/Pk24MSLMPEZuB3tIjNidaqjyoErEwogYcB
         hKv9zyD1g9RVFF1O/1775Rm7ZndN7FYMZRDF6TH+xje5URIcgqixs3oWtJ7xcc62MAK/
         URelPR1OlVTFx228qxfCfKHVSqxz6cQFezbyi9E4X+Dinqaowk0xZjm+pOQd+URHnnFr
         y8VXzhWSOn+ziH/aVq2xUP3oO88LizkEMbDq2pbO0cph6ILXlrOu//lxz9ByaKx6nx9N
         d+LNpR6yn9kaJATF9GWLubhdVT6ZTInVeq3+bXH2bW5aRXN0tLessbwILPQ9khV6FkJv
         jatQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1YoBlZi0uYdg4JiAjISvaqemhb9QOkgKAqZyahUIClLYLpjvHZAZ99zgVCZu4jWxF4l7FpljB34nDe2k41Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/szEOkXn1Dn10gbQXDerTecvurRAo8gCAE6+D+9wXdKmUblj
	wWZeNQy+g08vwmKcGBDoVx/zOHfgoT7pQ/pBX/hDhlMh1tIvPpSXcQSLG0sZVFEtyuw=
X-Gm-Gg: AY/fxX7MQ7wncDrOURJCcurNfqzKK0CpqwX2rHpiNufIxlKoO0gFrZ/Fakwjer2bckd
	HAGfMUN9Uev3Eh2Zf2kLVSR5Vx/EvJDDuetnya5KMY5OzKNo1+/StbwnEO/GXLDyrDGqrmAo9tB
	HJWrubMEoFvkUSJH8pWzNr9uGYoq2a/Ap/yrPsH7HOTTids/wKkt8Y+OR/Dj/pE8eQB2ZKg4HcV
	GutMzlvYldyJzLYMOMfC7rR34ipYVaxM6AuWfDJQRA0Zj1JDwGSTBtpC36c9Khu4A2VZ0ScJME2
	RAHrnMKY5GADXEICHCy+h6evN2nOoohAqOrexleCUpauY5oBDQ1M7Di9pj3xLp1h1iWvKHO/sUD
	DybLFfjBLInQZ356MSwnLZ6NXKO8lpaiQDPUZX+O3/eAdoYaR/pp8cxPrEeuKrU+CpI1vhjdPSl
	tEqbVqQjzShnZN3zeWpA==
X-Received: by 2002:a05:6000:26c6:b0:431:9b2:61c8 with SMTP id ffacd0b85a97d-4342c4ee902mr8010060f8f.10.1768488819096;
        Thu, 15 Jan 2026 06:53:39 -0800 (PST)
Received: from [10.11.12.107] ([86.127.43.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6e09acsm6183638f8f.35.2026.01.15.06.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 06:53:38 -0800 (PST)
Message-ID: <200d34bf-150e-4f8a-b400-2f54863502ac@linaro.org>
Date: Thu, 15 Jan 2026 16:53:36 +0200
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
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260115-slim-denim-potoo-cad9cb@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 3:36 PM, Krzysztof Kozlowski wrote:
> On Wed, Jan 14, 2026 at 02:16:31PM +0000, Tudor Ambarus wrote:
>> Document the bindings for the Thermal Management Unit (TMU) System
>> Controller found on Google GS101 SoCs.
>>
>> This memory-mapped block exposes the registers required for reading
>> thermal interrupt status bits. It functions as a syscon provider,
> 
> I don't think this is syscon, but the actual TMU. Syscon is various,
> unrelated system configuration registers.
> 
>> allowing the main thermal driver to access these registers while
>> the firmware manages the core thermal logic.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  .../bindings/mfd/google,gs101-tmu-syscon.yaml      | 37 ++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml b/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..6a11e43abeaa23ee473be2153478436856277714
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml
> 
> Not MFD either, but soc.

You are right, it's not a syscon, it's just a normal thermal IP block
from which I need to access the interrupt pending registers.

Then I guess I shall describe the new binding in bindings/thermal/,
please correct me if I'm wrong.

> 
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/google,gs101-tmu-syscon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Google GS101 TMU System Controller
>> +
>> +maintainers:
>> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
>> +
>> +description: |
> 
> Drop |
> 
>> +  The TMU System Controller provides a memory-mapped interface for
>> +  accessing the interrupt status registers of the Thermal Management
>> +  Unit. It is used as a syscon provider for the main TMU driver.
> 
> No, it is not a syscon provider. Entire last sentence is incorrect. You
> must describe here hardware and this hardware does not provide any sort
> of syscon to any sort of driver.
> 

Indeed.

I'm going to link the ACPM TMU child node with the TMU node via a
"samsung,tmu-regs" property.

Some concern that I have is that I describe the clocks and interrupts in
the ACPM TMU child node. Usually the clocks and interrupts belong to the
node that contains the reg property. But I guess that's alright because
the interrupts property is expected to be in the node that the driver
binds to. For the clocks, by placing it in the ACPM child node, I allow
runtime PM to manage it.

Do you think the below description is accurate?

soc: soc@0 {
    tmu_top: thermal-sensor@100a0000 {
        compatible = "google,gs101-tmu-top";
        reg = <0x100a0000 0x800>;
    };
};

firmware {
    acpm_ipc: power-management {
        compatible = "google,gs101-acpm-ipc";
        /* ... */

        thermal-sensor {
            compatible = "google,gs101-acpm-tmu-top";
            clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
            interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
            samsung,tmu-regs = <&tmu_top>; 
            #thermal-sensor-cells = <1>;
        };
    };
};

Thanks!
ta
