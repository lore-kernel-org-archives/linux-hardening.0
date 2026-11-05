Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837696;
	b=GJDMYO2OnsKoeXtfwqJayCODWTkZz3CLvfCtb/s+TKHiiC6g4o8XN5z+oBUr4Q0MTwji
	 SIsQjzJUnf5gw5DmjaKPABo/hTNYT6O0yMVAtrMsfsEC78G9E4Mufm0vXzup1t9XwDEna
	 uho/qYn9n1gg+7FFRtKACIjqDdeQUdNXWP1glh7kTBsesfqaf5Ujo8JuzFJAtQosy/8l+
	 ILeJCB6qSScMHUvcHj9qGDIAAgq382t8NZlrz+4CnpcEjkfDSdhlfox5CtlE7cHrCae9N
	 +ItPnsjkfr2EP2v9Lo8oQaDiqvVVRxwF9u8+pc0Yfvuub7ePDQsslkUOlV3gfZCP6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mGc2vAFhLjrhjQgo4ZedaQEUC/gPM0pIwb1vV2XkbM0=;
	b=sXXohhtmmvpGu8ftbKBHj7BLbpaGT1Blv81gs8l34/eWk1DMhnY9JHyF3cNoRIs77abb
	 mT6Y01cDinzlMCR009aIChHAO2gGlfvl1+JL1ez2mzwyE30wPyAJAEO4bqDNlO4RJxJQv
	 UjQX4QrfdOVanmzmKOCSXka3QvvCkOKdDhb71z0sY9P12ma+9FUFacxgBC4+R0O+RRYzC
	 f5rBT7UbDqYdytw0eheVm/TjekNyzH00CMVYHt9LO41QUXFCsDY0mqi1YGFPtW+k/MtuG
	 V+4JT6xr97TeBt0XrOdBzeOKQigmYy1eUj/8dzHKb6LyKV489AU4xhR0cw7J0z5hFMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eEYMfFoN;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E1606A326
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 00:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 526E1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eEYMfFoN
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-353804b591eso2486703eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837694; x=1794442494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGc2vAFhLjrhjQgo4ZedaQEUC/gPM0pIwb1vV2XkbM0=;
        b=eEYMfFoNspCoeIoNJY/b+Xve+xQTdefKAOBOHo69CfVlhXO5RRGt7oiyDZ9rQ2JAXc
         +rKLYOgD4O1o6ey0v/5apJZyPckwCN7shQ44vm1fC2PV4b2OpPbTQOCkjwGDVq3EEVM8
         H+w8U084nlAju7ObwISQEKsM3LIXoB9AE1BPO5dnz/yH/PofFMUDWafsWtgFlISeslVB
         gccWZF+3rRQFnwehdP9vevIAYQviLvVBOoD2VyTAqXiY/lklaybqqwJdQoVJCqrq7+RX
         1/faSvnVEy0IknDRynJ2edkA146IykKE/c2rFUP2Su0rYvVrBvFw9lMm0NC2zIa9WKMw
         x8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837694; x=1794442494;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGc2vAFhLjrhjQgo4ZedaQEUC/gPM0pIwb1vV2XkbM0=;
        b=1M8g/MJtR1MZHxMRX+ZqusP8yGVzbW2O780d7B38JCrpUPfho9rlTYt/LwIkrb1OC2
         lv0FPJRtGB5N33/mlSZkanXw9Efno9VrXSH+Myq1mc/s57ChF+pmqkkZJ7mQM8OzHL6r
         c9YmiDAinERTik6txxJtgJfnTwgOhA+fb4nd67KllDUkkuJiByH/9d7aK1HIH1vLb90p
         1sDv8LT/15sRSKF9JRchZdxmeb76reDhljZbnclDuOn1rS7sic+MkOE1TEIcRbW0KU7w
         oT9d0Q8MRJd1w2KtlBgNvRzmRw9B6PZzYD8Gm1aMLyEcXDjvkQhnqhjyWx2QZ27tmOeP
         lwsw==
X-Forwarded-Encrypted: i=1; AKwUvBxS4U3NhrPHvYhLodalZWc2/AH1RUZbiB2WAiB3XM3UzeL/FKyJkxFgsUT/NsjX+H1IN1p6uaa5sWVEtBJ0uK0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+O3OXn+q/6KF3FTuhseqvHYa/2+omq6mrpeLhvmkG4haJimMzY
	hY6tyIcfe3t5L+yBUdcuklWfEIKnvRFyRb63ZcVk9LRtHB7S8FqcHqdc
X-Gm-Gg: AYBFou1RH+MzNTL5PozBdRvquQEUNALR3v9q0k6sAXWrASJS/xlAPPqsqEcEKdlBIaH
	KRa9KVlQ6pEHlY8ruUIFTUFeMCWr49m2vpmArf7ix69ivl/Ha96XUWagOyo1CWJmIQKfk4prIJk
	HMEEIx3Ud/QIJJOZ2n3/PfBcoLrcwccc9DNSzOTgYkpkrLE3NXdP/zJWYeciDlRwJWe09b78Q4w
	SmDzUXM5stEHfCy8ENT/c16AzPS6wF8L0YVhjHvPN88CwMNetRNCROteBeCRiVMOzg9pHNLuzVW
	Nv+XbzFlqVIAeDCdtwp6cr1E5D+P1gZEnRjHSjHG3KZATV/nLYuBXKF4Lzn/Vcj/DxrUzS31G/A
	XBHkx2Qvs8D2m5Q1Sjb7jEq5sTaMseDh7HQyR/QL2ZS3iZFN2TMGT8Ah11jZ+U4jbroEuzfSgRX
	80M9YCbG3+uq/JXiHeVEEgdVr1K/iTgjMC9QsKBesYzKzAgkdvSezwyc9ogwgGNGFwtbrILtoxF
	Ds2P0efcVlUmWh06O5Pttlaoop0pqRR8IpN2fu4s4fOUanlPWaxLbHyNsmhrTVZlTTyIgYJqoXl
	3BoES+Og44FhALH0vkML8JwLw/StMHgcLmN6nQ8rFz00I//tqqi7BzWPzQN8nCzhMkJWNZYCnY9
	c0gQ=
X-Received: by 2002:a05:7300:c00f:20b0:36a:4ea9:19ad with SMTP id 5a478bee46e88-36a4ea91fd1mr23802841eec.9.1793837694081;
        Wed, 04 Nov 2026 16:14:54 -0800 (PST)
Received: from [172.19.1.51] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39972d4sm18304920eec.26.2026.11.04.16.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 16:14:53 -0800 (PST)
Message-ID: <0093d120-b966-4ece-be57-55a4751e17be@gmail.com>
Date: Thu, 5 Nov 2026 08:14:41 +0800
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document
 MA35D1 PDMA controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org,
 Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261103022202.2139674-1-shanchun1218@gmail.com>
 <20261103022202.2139674-2-shanchun1218@gmail.com>
 <20261104-vole-of-legendary-plenty-811cf1@quoll>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <20261104-vole-of-legendary-plenty-811cf1@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Dear Krzysztof,

Thanks for your review.

On 11/4/2026 10:03 PM, Krzysztof Kozlowski wrote:
> On Tue, Nov 03, 2026 at 10:22:01AM +0800, Shan-Chun Hung wrote:
>> Add binding for Nuvoton MA35D1 PDMA controller.
>>
> 
> Looks like valid Sashiko review, so only few nits, not a full review:
> 
>> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
>> ---
>>   .../bindings/dma/nuvoton,ma35d1-pdma.yaml     |  72 +++++++++++
>>   include/dt-bindings/dma/ma35d1-pdma.h         | 113 ++++++++++++++++++
>>   2 files changed, 185 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
>>   create mode 100644 include/dt-bindings/dma/ma35d1-pdma.h
>>
>> diff --git a/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
>> new file mode 100644
>> index 000000000000..cd752571242c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/nuvoton,ma35d1-pdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 PDMA controller
>> +
>> +description:
>> +  This describes the devicetree bindings for four Peripheral DMA engines to perform
> 
> Do not describe what the binding document is describe. Just describe
> that directly, so explain the hardware. Look at other examples.
I will fix it.
> 
>> +  memory-to-memory, memory-to-peripheral, or peripheral-to-memory data transfer
>> +  capable of supporting 10 channels, implemented in Nuvoton MA35D1 SoCs.
>> +
>> +maintainers:
>> +  - Shan-Chun Hung <shanchun1218@gmail.com>
>> +
>> +allOf:
>> +  - $ref: dma-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-pdma
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  "#dma-cells":
>> +    const: 2
>> +    description:
>> +      The first cell is the channel number. The second cell is the
>> +      peripheral request source (REQSRC) selection, which defines which
>> +      peripheral is connected to that PDMA channel.
>> +
>> +  dma-channels:
>> +    const: 10
> 
> Why isn't this implied by the compatible? Drop.
I will remove it.
> 
>> +
>> +additionalProperties: false
> 
> This goes after required block.
I will fix it.>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - interrupts
>> +  - "#dma-cells"
>> +  - dma-channels
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        dma-controller@40080000 {
>> +            compatible = "nuvoton,ma35d1-pdma";
>> +            reg = <0x0 0x40080000 0x0 0x2000>;
>> +            interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&clk PDMA0_GATE>;
>> +            #dma-cells = <2>;
>> +            dma-channels = <10>;
>> +        };
>> +    };
>> +
>> +...
>> diff --git a/include/dt-bindings/dma/ma35d1-pdma.h b/include/dt-bindings/dma/ma35d1-pdma.h
>> new file mode 100644
>> index 000000000000..0ddc99d29661
>> --- /dev/null
>> +++ b/include/dt-bindings/dma/ma35d1-pdma.h
> 
> Filename must match the binding filename.
I will fix it>
>> @@ -0,0 +1,113 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (C) 2026 Nuvoton Technology Corp.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_DMA_MA35D1_PDMA_H__
>> +#define __DT_BINDINGS_DMA_MA35D1_PDMA_H__
>> +
>> +#define MA35D1_PDMA_MEM			0
> 
> 
> Hole
> 
>> +#define MA35D1_PDMA_UART0_TX		4
>> +#define MA35D1_PDMA_UART0_RX		5
>> +#define MA35D1_PDMA_UART1_TX		6
>> +#define MA35D1_PDMA_UART1_RX		7
>> +#define MA35D1_PDMA_UART2_TX		8
>> +#define MA35D1_PDMA_UART2_RX		9
>> +#define MA35D1_PDMA_UART3_TX		10
>> +#define MA35D1_PDMA_UART3_RX		11
>> +#define MA35D1_PDMA_UART4_TX		12
>> +#define MA35D1_PDMA_UART4_RX		13
>> +#define MA35D1_PDMA_UART5_TX		14
>> +#define MA35D1_PDMA_UART5_RX		15
>> +#define MA35D1_PDMA_UART6_TX		16
>> +#define MA35D1_PDMA_UART6_RX		17
>> +#define MA35D1_PDMA_UART7_TX		18
>> +#define MA35D1_PDMA_UART7_RX		19
>> +#define MA35D1_PDMA_UART8_TX		20
>> +#define MA35D1_PDMA_UART8_RX		21
>> +#define MA35D1_PDMA_UART9_TX		22
>> +#define MA35D1_PDMA_UART9_RX		23
>> +#define MA35D1_PDMA_UART10_TX		24
>> +#define MA35D1_PDMA_UART10_RX		25
>> +#define MA35D1_PDMA_UART11_TX		26
>> +#define MA35D1_PDMA_UART11_RX		27
>> +#define MA35D1_PDMA_UART12_TX		28
>> +#define MA35D1_PDMA_UART12_RX		29
>> +#define MA35D1_PDMA_UART13_TX		30
>> +#define MA35D1_PDMA_UART13_RX		31
>> +#define MA35D1_PDMA_UART14_TX		32
>> +#define MA35D1_PDMA_UART14_RX		33
>> +#define MA35D1_PDMA_UART15_TX		34
>> +#define MA35D1_PDMA_UART15_RX		35
>> +#define MA35D1_PDMA_UART16_TX		36
>> +#define MA35D1_PDMA_UART16_RX		37
>> +#define MA35D1_PDMA_QSPI0_TX		54
> 
> You should not have holes in the ABI or this is not DT ABI, so drop or
> move out entire file from bindings.
I will fix it.>
> Best regards,
> Krzysztof

Best Regards,
Shan-Chun
