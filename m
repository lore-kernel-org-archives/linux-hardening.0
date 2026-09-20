Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0333A014;
	Sun, 20 Sep 2026 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928496; cv=none; b=orkWNfUSfpmOpqhPJ/q9WR5e89ams5gdQNgmhxCKoQG6GGPozRKwyNVL7VQT7XpX6BvUIoHil/RMQKIEt1wN+iie4jJWeaiIr786nr7eLnOcV/szYxpMv0FIITGk5jGu1ihSRLUbQwFwFZRcofAlanl0ATYgzwzac2ExPC98ltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928496; c=relaxed/simple;
	bh=oqLqZEXOp993eRGRX5QrOw+njfG+kUjvHBFxyQ8khMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9xuK9sT1pcLOJeVniRC+ZkyNfQFb599KhkVJ97WGPl9dU1tgO+Z8Xrj/izMXEXWzonjMp/fYEyDqr8jIOWA5ijSszr9AbM3dkS6AI1pY2i78qlu0FZrK9ytO5QI+/C269PJI/M3ZO1jxge3T4fp4/IjOJEFoUMW7ycDxbJJpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwHXWUL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwHXWUL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428B71F000FF;
	Sun, 20 Sep 2026 18:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789928494;
	bh=5g79bEpYNdEBFfwM1CZ+5KAYmu+AdIKJVtVBe1RyNzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HwHXWUL8/gey82ZrxlUXzmOEpJJtkTQenE3+tef1ubFteKm08N3xq4/3bhAIcB/jl
	 EabB6ROOh8md63hOGfosDbzpjHZSTtExx+VPGA384V2PCUAungwfRrc0p73z6bbdN8
	 hNzxRi+KfooguYEqHkVFtMz/R7TKbU9vwPlYzihQS1KyKMry6zLQi2Marez7YZk/SA
	 GLcVlugUWXSQ4G/YYomYHeicI5Cvsoo68tCrJNQc6Pw+0yl615MQuVAGyPhaELkSjh
	 U2Ieg4gdWqkp1YuEBM4itrjmwYRbHKXQIUCGo6E8i8xzjnuF0lUi25G6rZJfRiDdoV
	 HUCbZVjLNkKpg==
Date: Sun, 20 Sep 2026 20:21:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, kees@kernel.org, 
	gustavoars@kernel.org, p.zabel@pengutronix.de, daniel@riscstar.com, 
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: clock: introduce
 toshiba,tc9564-clock.yaml
Message-ID: <20260920-messy-successful-caracara-fcdbcd@quoll>
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918165234.687224-3-elder@riscstar.com>

On Fri, Sep 18, 2026 at 11:52:31AM -0500, Alex Elder wrote:
> +description: |
> +  The Toshiba TC9564 is an SoC accessed by a host system through the
> +  upstream PCIe port on the PCIe switch it implements.  The switch
> +  includes an embedded PCIe endpoint that provides access to various
> +  SoC peripherals (including a clock/reset controller) via its BARs.
> +
> +  The SoC is represented using a devicetree PCI endpoint bus, so the
> +  clock controller is bound to its driver using a platform driver

Do not mention drivers here. Just say that host can access clocks etc
via PCI.

But then more questions. This is PCI, yes? So how are the clocks from
PCI routed BACK to the main soc, which would justify having this in DTS
in the first place?


> +  compatible string.  All of the clocks are simple gate clocks.
> +
> +  A total of 21 clocks are implemented, though two of these are not
> +  controllable.  Access to the clock controller relies on PCIe being
> +  functional, so the PCIe clock is assumed to be always on.  Similarly,
> +  the PCIe controller relies on I2C, so the I2C clock is also assumed
> +  to be always on.
> +
> +  In addition, 13 resets are implemented.  Similar to clocks, the PCIe
> +  and I2C resets are assumed to be deasserted and cannot be controlled.
> +
> +  Clock and reset ids are defined in <dt-bindings/clock/toshiba,tc9564.h>.
> +
> +properties:
> +  compatible:
> +    const: toshiba,tc9564-clock
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/toshiba,tc9564.h>
> +
> +    clock@1004 {
> +        compatible = "toshiba,tc9564-clock";
> +        reg = <0x1004 0x20>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;

No resources except small address space, so does not look like a
separate device and should be folded into the parent node.

> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2d3257b8f892..66d0e7e65adcb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27670,6 +27670,13 @@ F:	Documentation/devicetree/bindings/media/i2c/toshiba,tc358743.txt
>  F:	drivers/media/i2c/tc358743*
>  F:	include/media/i2c/tc358743.h
>  
> +TOSHIBA TC9564 CLOCK DRIVER
> +M:	Alex Elder <elder@kernel.org>
> +M:	Daniel Thompson <danielt@kernel.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> +F:	include/dt-bindings/clock/toshiba,tc9564.h
> +
>  TOSHIBA TC9564 PCI DRIVER
>  M:	Alex Elder <elder@kernel.org>
>  M:	Daniel Thompson <danielt@kernel.org>
> diff --git a/include/dt-bindings/clock/toshiba,tc9564.h b/include/dt-bindings/clock/toshiba,tc9564.h
> new file mode 100644
> index 0000000000000..75732fddd3025
> --- /dev/null
> +++ b/include/dt-bindings/clock/toshiba,tc9564.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +/*
> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
> + */
> +
> +#ifndef __ClOCK_TOSHIBA_TC9564_H__
> +#define __ClOCK_TOSHIBA_TC9564_H__
> +
> +/* Clock IDs */
> +
> +#define CLOCK_MCU		0
> +#define CLOCK_INTC		1
> +/* #define CLOCK_PCIE		2 */
> +/* #define CLOCK_I2C		3 */

Drop both, and SRAM is number 2. Or enable and implement them.

Best regards,
Krzysztof

