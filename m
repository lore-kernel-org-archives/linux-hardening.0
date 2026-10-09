Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256449A3D2;
	Fri,  9 Oct 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538312; cv=none; b=ATwJykR4paCfBmow9aqvwVWz6mCNPxdqHHHwBkbX96DtZvNTHfclpnUbR51Tzt9zSG9ONkE+4bfwxOBolVnxY3YJBOmXlavzmZDg+axHa7dbp+vO1GJ9BGRuwlaMrORu3zmBCdHdyP9cqxrDzL9QdrdpGdv23z75zC1VgYcu5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538312; c=relaxed/simple;
	bh=j3BjLAvA3Bq5JnSG/zolAG4cMSh78NzeXeYs2MYU6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apBPDQJ9NlL9INYbACJzl4s97ME71OX6goN4Fa1x7qhI1NGjjE2z4TfWmJpT5CmXOO20gRV83nS0p6EC3vwz4RI4HfxDGfdueNkmO7bQZuwSWC+nRg9JCZiMT3F6OJ3LpkHGaj6ycPQj0Mwy74w2WPOx3oBgsMq1ule4P4n/tOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwB1Q/iZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwB1Q/iZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58601F000FF;
	Fri,  9 Oct 2026 09:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791538310;
	bh=s8xH1F/JaR1AxQIsxpZSOc+O+rct9Lu7coFrpOF8Daw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwB1Q/iZ3QJTtD9mlHQtZiKNCTC5E1HewCNOMKPP3epLLGfgCdzvPo0gJQ8zTehw5
	 0WcwYH4tZryXGVIeCfYPZhTA5aa+6UPwOs4DQbPLiiQeTw9uCQpY+KnHf2y3VDWmrw
	 2j9cCxe1xNbiPipGXaEZI5oOYtNw2NU+ioV40lRQU5o90TF2PP+bLTRE4CDBWyORT+
	 5j45IGKhLjaSA0wKIpsY7MPMLloxxmkXCl3QPac1GfRI2M7IH4EN5FVnTSrZhIboXZ
	 +Wgj5Zdq9upDxBwEf87SDwYQ1+J7ijGuwxtSAiMxGTGWer0EYjRmyl6Kn0AIB2XRJX
	 IVNjkaue4cJHg==
Date: Fri, 9 Oct 2026 11:31:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, abelvesa@kernel.org, kees@kernel.org, gustavoars@kernel.org, 
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: introduce
 toshiba,tc9564-clock.yaml
Message-ID: <20261009-gifted-stylish-tortoise-95b14d@quoll>
References: <20261005230927.2000398-1-elder@riscstar.com>
 <20261005230927.2000398-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005230927.2000398-2-elder@riscstar.com>

On Mon, Oct 05, 2026 at 06:09:24PM -0500, Alex Elder wrote:
> Define the binding for the clock controller functionality present in
> the Toshiba TC9564 SoC.
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - Only define clock information, not reset information
>     - Reworded description to avoid talking about software
>     - Clock IDs are now consecutive (no more commented-out values)
> 
>  .../bindings/clock/toshiba,tc9564-clock.yaml  | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  include/dt-bindings/clock/toshiba,tc9564.h    | 34 ++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
>  create mode 100644 include/dt-bindings/clock/toshiba,tc9564.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml b/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> new file mode 100644
> index 0000000000000..329b8f002cf2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/toshiba,tc9564-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC9564 Clock Controller
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +  - Daniel Thompson <daniel@riscstar.com>
> +
> +description:
> +  The Toshiba TC9564 is an SoC accessed by a host system through the
> +  upstream PCIe port on the PCIe switch it implements.  The switch
> +  includes an embedded PCIe endpoint that provides access to various
> +  SoC peripherals (including a clock controller) via its BARs.
> +
> +  A total of 21 clocks are implemented, though two of these are not
> +  controllable.  Access to the clock controller relies on PCIe being
> +  functional, so the PCIe clock is assumed to be always on.  Similarly,
> +  the PCIe controller relies on I2C, so the I2C clock is also assumed
> +  to be always on.
> +
> +  Clock ids are defined in <dt-bindings/clock/toshiba,tc9564.h>.
> +
> +properties:
> +  compatible:
> +    const: toshiba,tc9564-clock
> +
> +  toshiba,config-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle for the configuration space system controller.

I do not see my previous comment addressed - you have no resources here,
so this belongs to the parent. You responded something about pci-ep, but
the parent is not pci-ep. Open your code:
https://lore.kernel.org/lkml/20260918165234.687224-5-elder@riscstar.com/

I clearly see code like:
  syscon {
    clock@ {
    };
  };

so I do not understand what pci-ep has anything to do here.

What's more, I still do not see any usage of these clocks outside. And I
still did not receive actual answers (or I missed them) how these clocks
are routed OUTSIDE of the connector. You said for example:
"Ultimately the TC9564 SoC has a single 25 MHz input clock,"

but that is input. I did not ask how this device receives clocks. I
asked how the host receives the clocks from this device.

> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - toshiba,config-syscon
> +  - "#clock-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/toshiba,tc9564.h>

Looks unused.

> +
> +    clock {

Anyway, if this stays, that's a clock-controller.

Best regards,
Krzysztof

