Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801016;
	b=aq2N8Zn07UnGj9i1xSDbW0PHBVeSjJI7qiEMsm/gVgAGrldXoOosHKLkNlcsV2S33Su2
	 eB0gvWSec17blFcf0tJumtF7yzPYCx+D3qp7ZzAnQl99EtnyHj7u8PPavvZqWO/HvIwJp
	 m8zHmFj0eiIODLqWhyBAuAi8NkD+VIJMTDVaJ/J0MvmWm0ixnhrdwsSCEoUNQ1ClheFpj
	 wsVqQ+SjXuhtNu9oCOgnhd/DSohpvKuspDFk0xZGSqIn9wZ1gcN/K5jNKMSPZG5m05t1P
	 FAGcOB00Ef3tlxWRjtZIPEWc/4wOMdoC3DHVoypzt8kIEwfFGcJU9bXs7pC0oxI6HCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801016;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uknA9LO5XfZyma+M7n03w/JxLoJTVSxXbrmN0E2Qqwk=;
	b=PeHiqWSnkeFtNH78B+P2dz6JguOCl/6vKYdtqVAr6wwHUaFqq1W63E0I5+bhndynxjON
	 tEL75d4Xo93+JkMyWHFcjTq0IY72m8Z6V6VNkjKaWl3P/L4FJQ2jWkljN4FOZUUybkIMY
	 xAWcbVGaoChaeclB2rAX/IYnAfiV0uKv28Ch9kvkv/vSCumhlB6/yoYMIGDFmCNKYWdMQ
	 hapx9qUHnuP2L8JkJOg/1If3srC0D8hZaaJ/sAfiWwwFmYs4fx3SlduQz08XVir1T/blp
	 l1o5w1t41rk6k6gPN3PvzjJV4XtIjg7csiLtdFlhaemtg8J4qekVDjKtdz6gNLcSz4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3zOtOlW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC9606A31B;
	Wed,  4 Nov 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3zOtOlW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94E1F000C1;
	Wed,  4 Nov 2026 14:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801016;
	bh=uknA9LO5XfZyma+M7n03w/JxLoJTVSxXbrmN0E2Qqwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G3zOtOlWX3MGmRDd5z/B4xbOCZZdTwCaGj35JCzfNwkvryB8Lgtd5yWEpArAooh63
	 enx/9Uowo+XlfwgYddKPXN6IvHQ4UwitDFFZQoqMGWZ/5jrWG1mB7Ub2T8mrtnwK9C
	 10xfSV0BEtoZVLwAlTkPWG8llG+QezSFxQ/L6TrOof5EMwuow2nGs3tAziCJ68WAZW
	 46U0Jsi7d+s8ZenOVI99LKlKuV7LjsmcBEf85/SKzlI4/wLMBnG7KnScjRDe3ZQ9xR
	 GBMlM7hGYZfi6l728afXvYzWPew12XKhawrid3K7RnZ5BRXRuMKvRnPbK27W++r1iK
	 ngFpNwQY8LX+w==
Date: Wed, 4 Nov 2026 15:03:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org, 
	Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: nuvoton,ma35d1-pdma: Document
 MA35D1 PDMA controller
Message-ID: <20261104-vole-of-legendary-plenty-811cf1@quoll>
References: <20261103022202.2139674-1-shanchun1218@gmail.com>
 <20261103022202.2139674-2-shanchun1218@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103022202.2139674-2-shanchun1218@gmail.com>

On Tue, Nov 03, 2026 at 10:22:01AM +0800, Shan-Chun Hung wrote:
> Add binding for Nuvoton MA35D1 PDMA controller.
> 

Looks like valid Sashiko review, so only few nits, not a full review:

> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
> ---
>  .../bindings/dma/nuvoton,ma35d1-pdma.yaml     |  72 +++++++++++
>  include/dt-bindings/dma/ma35d1-pdma.h         | 113 ++++++++++++++++++
>  2 files changed, 185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
>  create mode 100644 include/dt-bindings/dma/ma35d1-pdma.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
> new file mode 100644
> index 000000000000..cd752571242c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/nuvoton,ma35d1-pdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 PDMA controller
> +
> +description:
> +  This describes the devicetree bindings for four Peripheral DMA engines to perform

Do not describe what the binding document is describe. Just describe
that directly, so explain the hardware. Look at other examples.

> +  memory-to-memory, memory-to-peripheral, or peripheral-to-memory data transfer
> +  capable of supporting 10 channels, implemented in Nuvoton MA35D1 SoCs.
> +
> +maintainers:
> +  - Shan-Chun Hung <shanchun1218@gmail.com>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-pdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 2
> +    description:
> +      The first cell is the channel number. The second cell is the
> +      peripheral request source (REQSRC) selection, which defines which
> +      peripheral is connected to that PDMA channel.
> +
> +  dma-channels:
> +    const: 10

Why isn't this implied by the compatible? Drop.

> +
> +additionalProperties: false

This goes after required block.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - "#dma-cells"
> +  - dma-channels
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        dma-controller@40080000 {
> +            compatible = "nuvoton,ma35d1-pdma";
> +            reg = <0x0 0x40080000 0x0 0x2000>;
> +            interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk PDMA0_GATE>;
> +            #dma-cells = <2>;
> +            dma-channels = <10>;
> +        };
> +    };
> +
> +...
> diff --git a/include/dt-bindings/dma/ma35d1-pdma.h b/include/dt-bindings/dma/ma35d1-pdma.h
> new file mode 100644
> index 000000000000..0ddc99d29661
> --- /dev/null
> +++ b/include/dt-bindings/dma/ma35d1-pdma.h

Filename must match the binding filename.

> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2026 Nuvoton Technology Corp.
> + */
> +
> +#ifndef __DT_BINDINGS_DMA_MA35D1_PDMA_H__
> +#define __DT_BINDINGS_DMA_MA35D1_PDMA_H__
> +
> +#define MA35D1_PDMA_MEM			0


Hole

> +#define MA35D1_PDMA_UART0_TX		4
> +#define MA35D1_PDMA_UART0_RX		5
> +#define MA35D1_PDMA_UART1_TX		6
> +#define MA35D1_PDMA_UART1_RX		7
> +#define MA35D1_PDMA_UART2_TX		8
> +#define MA35D1_PDMA_UART2_RX		9
> +#define MA35D1_PDMA_UART3_TX		10
> +#define MA35D1_PDMA_UART3_RX		11
> +#define MA35D1_PDMA_UART4_TX		12
> +#define MA35D1_PDMA_UART4_RX		13
> +#define MA35D1_PDMA_UART5_TX		14
> +#define MA35D1_PDMA_UART5_RX		15
> +#define MA35D1_PDMA_UART6_TX		16
> +#define MA35D1_PDMA_UART6_RX		17
> +#define MA35D1_PDMA_UART7_TX		18
> +#define MA35D1_PDMA_UART7_RX		19
> +#define MA35D1_PDMA_UART8_TX		20
> +#define MA35D1_PDMA_UART8_RX		21
> +#define MA35D1_PDMA_UART9_TX		22
> +#define MA35D1_PDMA_UART9_RX		23
> +#define MA35D1_PDMA_UART10_TX		24
> +#define MA35D1_PDMA_UART10_RX		25
> +#define MA35D1_PDMA_UART11_TX		26
> +#define MA35D1_PDMA_UART11_RX		27
> +#define MA35D1_PDMA_UART12_TX		28
> +#define MA35D1_PDMA_UART12_RX		29
> +#define MA35D1_PDMA_UART13_TX		30
> +#define MA35D1_PDMA_UART13_RX		31
> +#define MA35D1_PDMA_UART14_TX		32
> +#define MA35D1_PDMA_UART14_RX		33
> +#define MA35D1_PDMA_UART15_TX		34
> +#define MA35D1_PDMA_UART15_RX		35
> +#define MA35D1_PDMA_UART16_TX		36
> +#define MA35D1_PDMA_UART16_RX		37
> +#define MA35D1_PDMA_QSPI0_TX		54

You should not have holes in the ABI or this is not DT ABI, so drop or
move out entire file from bindings.

Best regards,
Krzysztof

