Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906186;
	b=xQb0e/qUK6w72iMToCtzm5W0erIw8dpKUx23uXYPvzyDRyle6GX6IfIDvrDw3xrBcwIJ
	 yZPXIYx26j8WRjdOfwd6GX6ZnsdM8RzNf4GUt+mXvt2ysjQUAvrKA7LnkmE5eBgc2Gr8I
	 78Lg+b9UjX/HZGRSOO6a6ZzspIZYkQrxGztOMJRCBVqGWIX60Wt1ja4am8dSmI7/whPHH
	 31czmpRqO+KxCGe859j10KDntoFvvOcx+b6P+gwu6wCyxBhZoeqLPkMZhtwJzW0Ik/tk+
	 zGNzo91QK0pCYBY4fLDfZJGVmE+YWZ+f9uNdLuie9yqLbqXekdrjs5HoZYkK0bhYnvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rml9Tae3yUrPwjvQLyFAzHjGFjivfeaY5pWvQRSh8QM=;
	b=nd4WJRW7Qd/Kiz6KQJWC8x+V2SlMqT5zFzWWeYZQ3Un3eVor7yQV7PWMxHTppFSP2kOG
	 2w1TVV34d13IjwpniFzRA3GMu3wDMuCBnh2JrK5S7g62qkt5VEy4AKHLdQkSsCyadMXOR
	 zRF4dZDTNedh4bU9ydPMSv5VTUp/e3RCgWxEHQBGD+FPTTRhqE6TciwjQziuWBDW7uLAQ
	 39K+N9+JeGHnoQ2hB7LWei72Nsb4xBhUlsybMRDuBmW+0WUo/HuHtYrZ/4wzii5ED9jB0
	 V65a5kgl8KE/IcFn3EFSqCS99jCw9V3MWILPJ2Vwnee9pm5Y6b5KaapMkTLTGFAG2wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P02okCnL;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68351606A31C
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 09:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68351606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P02okCnL
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b904d10882so1775402b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 01:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794906185; x=1795510985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rml9Tae3yUrPwjvQLyFAzHjGFjivfeaY5pWvQRSh8QM=;
        b=P02okCnLOX7GQFg/FdyY1inxehwiUGMREuCWwjos/1ThOA4/pD0rqRQNGvoKrmJBLi
         jrPE7mYXfKmBLqYxDEzlMN1iQMhpO4rwtnClO63o6PidRV6Q1UDy3qAQQet+KE5ddlU6
         GhMPJ57s47bvZ3aty0Os6yO50Sacp7WmosuzBY8Yv7t5hLtXVX2gJrio3Ya6i2aluIyD
         5hip/jBIn5QkgC3WesUImZ7jrwRLs3c4LK5lBH9plIYqZE0IqpOfDKX7BQSQ8bIX2xEK
         3QGA2uwm02LMchE9oMe8vExBqjODkAwFXg42qRk1OAl7RV8wd1gsbSz8qxi0HcWONXVk
         nPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794906185; x=1795510985;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rml9Tae3yUrPwjvQLyFAzHjGFjivfeaY5pWvQRSh8QM=;
        b=FOXX0ziqba51MZF2aS9kkoCwXog7Ukvq3p2dk7KHe+3z7rcTalWKAjAW+/igfkZUzy
         kI5GW6batepsu6aaYVI/nyQYAwumv8naub5xyAbITCi1Uwxpdoe6G26i/4PTD8gBD9xH
         UzVNvDu8zk+c2nNmstt7pzmCjzgDTnxGa5rriAVpzW/wVFCvmcWXyZ2CjToxVSXK66ZR
         jPD63nKDJzbkoMl/7acKbFlOQRVyuKyUKFS5eOQT25phLSEUxZfzxKuIQ+KvqJF+9gVQ
         ircZczTca/jpf5VDZD0qYk0XmtOWAupgG/DZQTMRRZydez0mf9fnO28w8I2w1fLs8e4a
         ryiw==
X-Forwarded-Encrypted: i=1; AL+hErF0DY7X0ZDHcnXTAKh0YzCQ66gEfRqHdH2W++wA/D7Oo+KQ36P1ZicLAIXq8LXTlot/gZSwcLhgVOMxhzYGhbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZcDJr1cr+Kn9JTBIiItQ+oJNwIvrzdhnYvXCKzjSNPp52Q/fg
	xAZgtbqlUpR+LUcqD9Z+x6B1qwkV2IC/yWwyUhtRwDKzZanejOiLVzSEz3JQM4em
X-Gm-Gg: AYBFou1rJn4/3Me005kS/ThcoJf/MjB0MkQXf/eJhNuqiShNlYJSZ+ShbE8KfXSqF2b
	2/U/Yolk+QAeOdAiwUbAV13RqwZouChL5qdw4AM/KmI6Geg9yeuisnh4whO4D1HkRgbo35iM3qT
	0gaUOFZw8K0myTLhjMl6wxm/cQ1XyPM4lt5wUZuE6hvn72EzL9mpENBqJP/OpP9FI3XqfEe31xt
	C8eWn1GRpcaKoInYddgpU/R9JiacTw1zPAFQIAFYiuY9Pt+bIQapOPoM8ttLiQpPsqPUjvDixEC
	Rvmy2kCcFCFbNOEklvnCc4kRJooRYtzWzRbyT8EUiG+rgXbmXvqwuN9KRZUPQZ+qXIhRPRZMbaR
	sD9Olf6BMs0q/L66GvChZUgJE4mLy5gNdr7AqbEn9k18Sm/09+7gQ83ZtUNKKi2vzYw2+ZwqYJa
	HqHZyyM8ywClNnzkd7m3L5SxUhyUnBOt5uctsEB4aMII2TQfRwFlRILPLUixYdZQyYAf7szK9QY
	hiclug2onOYOFO5Ye5vtVMlKJPwRxkdyIiRgFKRG02M9NkAkvo1QPzCkA0oHulNMtCb9ulMU/aV
	YooBMpm0HNP0SlG9U+mv7l1i8nfPGXSPtV69UvYSD9zP1M7HG2kcEFv/Hik13/fQY6DKK2oRDs5
	nqrJ8sQ==
X-Received: by 2002:a05:6a00:1c9c:b0:89d:5a80:5256 with SMTP id d2e1a72fcca58-8beb56cd05amr11614200b3a.9.1794906184648;
        Tue, 17 Nov 2026 01:03:04 -0800 (PST)
Received: from [172.19.1.51] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2a20fc8sm4517468b3a.49.2026.11.17.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 01:03:04 -0800 (PST)
Message-ID: <57e46e27-db98-4f9e-a657-1f224d3428b7@gmail.com>
Date: Tue, 17 Nov 2026 17:02:45 +0800
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
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document
 MA35D1 PDMA controller
To: Frank Li <Frank.li@oss.nxp.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org,
 Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261109052900.2960473-1-shanchun1218@gmail.com>
 <20261109052900.2960473-2-shanchun1218@gmail.com>
 <avtum_vwVClf7xhE@SMW015318>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <avtum_vwVClf7xhE@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Frank,

Thanks for your review.

Best Regards,
Shan-Chun

On 11/17/2026 4:59 AM, Frank Li wrote:
> On Mon, Nov 09, 2026 at 01:28:59PM +0800, Shan-Chun Hung wrote:
>> Add binding for Nuvoton MA35D1 PDMA controller.
>>
>> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
>> ---
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
>>   .../bindings/dma/nuvoton,ma35d1-pdma.yaml     | 71 +++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
>> new file mode 100644
>> index 000000000000..d05971662a5d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/nuvoton,ma35d1-pdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 PDMA controller
>> +
>> +description:
>> +  The MA35D1 SoC has four Peripheral DMA (PDMA) controllers. Each controller
>> +  has 10 channels and performs memory-to-memory, memory-to-peripheral and
>> +  peripheral-to-memory transfers.
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
>> +  resets:
>> +    maxItems: 1
>> +
>> +  "#dma-cells":
>> +    const: 2
>> +    description:
>> +      The first cell is the PDMA channel number. The second cell is the
>> +      peripheral request source number, as listed in the reference manual.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - interrupts
>> +  - "#dma-cells"
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
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
>> +            resets = <&sys MA35D1_RESET_PDMA0>;
>> +            #dma-cells = <2>;
>> +        };
>> +    };
>> +
>> +...
>> --
>> 2.25.1
>>

