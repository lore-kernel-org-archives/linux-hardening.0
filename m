Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4C2749D5
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553453; cv=none; b=tROxXivffKkz3maIRyy565BQADc90yCGokzrchb7QWKWlbtywFibX+CRRTY3dZ2jdW3WJV5eBAjOAJUQc0NkK+rYh0c4BbfgLMsYtfJT2hpQAdBJIg7+GCkBzX0v2nqO/42fk/HGQNoCqcXwvIxfPT/bA7x2ldp9LWYFmS1Yz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553453; c=relaxed/simple;
	bh=IxxkAHO4EnPiHaHTmJj8q4lvkE9SooXBNoQmhRF6Nyk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZFahueD2F+sduiohjoCQXmsQhetoRMIS9b6ZdMBxUGzivQilszJbSlH35z+4wrHswUifVY0txcu5fBr9/niHMuKYlesWCrqmoSn5JLFQoXfmf+V56brGFJ3J2Ww0HTVDYIYK2KFXMxcsxNXFaBdrHKN3IArdVcxVhzmpGE36SsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zvBuCoPB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvBuCoPB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so4423275e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 00:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768553450; x=1769158250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXXyXgD5w4PG1Vior3rmQ9g78aObU3Raj1nrRdpjO4M=;
        b=zvBuCoPByJXT9NLYNA68cAungP0ITFpI66ZhsO+5vkuZ5N1TpAFG+ih63w5C76MILC
         G61Se8IF2SxC68Nr71xtzdG6xwL6Krchlw3SKkG22w1/NVpTUfbQ7A3n542Jt4LYu4tJ
         KKE33g1lXRqwinONAfe+l4Imp2CHXhDwiwWImNeogjaql4y4C1SeqN9RTOR3hpGAwGtH
         FnD7wBcDWaeZ5S8mJeHkeq/F8LvWJ5qtmtToGx4k0BhjDiInimIo+0MWgj9aVK/JXOh0
         ocunQbzUYBnIW/U6KMNGP+QgT/8TpTn63eKTh9NNJOBhaNNr29RlKwXLGxwlUNnfveI7
         QaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768553450; x=1769158250;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXXyXgD5w4PG1Vior3rmQ9g78aObU3Raj1nrRdpjO4M=;
        b=MKo2rvp8XzqFlRP69pYiFRzp+axYLfb0fvVkVCqZt5X1W4fq6iowfc9PlttLsMiXri
         QBpusINPjJeIA7DYp0LMhrfZ0CojtZW2l3i+BZKURViF3xPotVu1oVniZPmwAgcHtpEW
         //iHHHeiCqZpM1bCEuuLpncYgDeodsJpgZTH+VHSPQozSgXvhFnh6L+ezqRE4lhuPl2K
         ScZnVtJcrGz5p4ojTTvsakt2qqsjQkoR0IB5+ls/Y6imNniT6EBA9S/PSCpN1bSAYma2
         tk7wAF4nfmDiVp5dvR5Sdi9nLefn47LvutovrM3yx11IcQRhhnLh5laTz73Ka2KB7+3B
         vQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/zGY+mYtRxQyFkhAXHd3Kb2D21eQ413sbEMhS1Dkewfnv720PKkMO+ChGqIUR7AW6EbOSs31Z7py1qJxtEsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVl5sh0w/Ys3JbSvIDScdjxEhuRfBAbOhX521cYqINMoFBndM
	RvX2KfQuljuopbhg2x2Wrc1IibDTvRMIn1uBR31rYOuULGgwQY0va245bGOl4Yv1nU0=
X-Gm-Gg: AY/fxX4Wwd+NDTwzdeg8QzS65Actk2mBBJwOrCgcIJ4CoDUWdbj7aL5DXk2cVKvVgf/
	FiPH9zzUfY3SP9ygX7gLyzUlFtqB95+KTVyDwIYRkzkH4wrtlpQ6ewDh14pf8A+jlAvrbbNTjho
	yDRsxATgg7kw6OVPokEL4f/QSVV96yuLf20fQ7BVNEiDXu16+JU6O3xYXBzJjGklhvkI+oRLfdC
	/CH9fzRzzs2p4U3d6dopBzn/qyfiz6DmtQ6ybRYLjYvFvcx+jnznvKhRT3s0ZbugOqEJZn61UXe
	sqGZwZzrckZ0/W0En4JlTkYRgRJJFvL79RdG74OkmUiLj6o6UGLkNG1H0FGzfNhBjLqflIBa5cK
	+qjmP9gRyJyUfWg37kXGgxY2vjbF0LO5+14oKfM+J1cE7np3DcqRtcIsVHxFgyF7LtMhez5+JlV
	dFnVn3dZBGWUiBVFhUPg==
X-Received: by 2002:a05:600c:414f:b0:480:20f1:7abd with SMTP id 5b1f17b1804b1-48020f17c12mr10430535e9.31.1768553449885;
        Fri, 16 Jan 2026 00:50:49 -0800 (PST)
Received: from [10.11.12.107] ([86.127.43.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b267661sm87966875e9.13.2026.01.16.00.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 00:50:49 -0800 (PST)
Message-ID: <26d86470-aaa2-46e3-9940-010a903df4fd@linaro.org>
Date: Fri, 16 Jan 2026 10:50:47 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] dt-bindings: mfd: Add Google GS101 TMU Syscon
From: Tudor Ambarus <tudor.ambarus@linaro.org>
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
Content-Language: en-US
In-Reply-To: <fcc5405e-189d-4195-8db0-3acf35bbc0a9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 6:10 PM, Tudor Ambarus wrote:
>>> I'm going to link the ACPM TMU child node with the TMU node via a
>>> "samsung,tmu-regs" property.
>> This could be fine, but I actually wonder what's there. What registers
>> exactly. For example modern Exynos 88xx, already with APM block, still
>> have exactly the same TMU unit at 0x1008{04}000 with all typical
>> triminfo, current temperature and thresholds.
>>
> It's the same for gs101, the TMU instances have all the typical registers,
> it's just that everything is handled via ACPM but the intpend registers.

I could still use some guidance, Krzysztof, thanks for the help so far!

Based on the current feedback I was going to propose the following
description:

soc: soc@0 {
    tmu_top: thermal-sensor@100a0000 {
        compatible = "google,gs101-tmu-top";
        reg = <0x100a0000 0x800>;
        clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
        interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
    };
};

firmware {
    acpm_ipc: power-management {
        compatible = "google,gs101-acpm-ipc";

        thermal-sensor {
            compatible = "google,gs101-acpm-tmu-top";
            samsung,tmu = <&tmu_top>;
            #thermal-sensor-cells = <1>;
        };
    };
};

GS101 handles the thermal sensors in a hybrid way: it uses the TMU IP
block to read the INTPEND registers, and everything else is handled via
ACPM calls. There's also the abstraction that one ACPM sensor is comprised
of multiple physical TMU sensors.

My concern now is that the ACPM TMU child node is not hardware per se,
but just a firmware abstraction (One-to-Many sensors).

If everything was handled via ACPM, without the need to read the TMU's
INTPEND registers directly, I would have describe the sensor just as an
ACPM child.

Because of the hybrid approach I'm arguing the ACPM child node does not
fully describe the hardware, and it's just a firmware abstraction.
So option 2/ would be to have just the TMU IP block described with a
phandle to the ACPM IPC:

soc: soc@0 {
    tmu@100a0000 {
        compatible = "google,gs101-tmu-top";
        reg = <0x100a0000 0x800>;
        clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
        interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
        
        /* The "Firmware Phandle" approach */
        samsung,acpm-ipc = <&acpm_ipc>;
        
        #thermal-sensor-cells = <1>;
    };
};

Which one do you think it better describes the hardware?
Thanks!
ta
