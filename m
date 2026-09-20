Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266A3DF01C;
	Sun, 20 Sep 2026 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928326; cv=none; b=oR1BqfTDPqhE6Oa8j90eEBa9R7cjNzk0TiWoZamNbRbWKW3j0+KP3yBtYJrZsjulaxhYNfCS5mUZOXgLR3V3g6Io2SLZp72dxGo7aHM0sk/ikXmSwEr7d/Z+B2lhatspvtb7MN1lyvRhy+r7RoEpklSBhribLfHPKzqJJiI/OUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928326; c=relaxed/simple;
	bh=oColPJm7byDapCx6KUmBg6fWkywzUvd2Yt8UBbtrxIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF+YLi3KJ+UG7Bo3r2kCdsqycLcszk1rZfjin5j0qHVTHYH6HeYLkvFOYNQuz6iI7TgRyter7oPZai7FqKcb64uvi/dVrUNCqCelUCdQ+D+mr0qlAfNYA5mSDdGKwpsaLEDih73bJvwtUWtX7vVzXY72m4oa1pQyDxeknF+DaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW0QsLK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW0QsLK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6401F000FF;
	Sun, 20 Sep 2026 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789928324;
	bh=mHGhS5D3hwDg2bZdL0zyDjYJ+/3CST/aN6uzLGqVjq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dW0QsLK1o62TrLNh2bC1MdK9kcwGTMIPy+Wo4jcbbAjmzwhTnwFKT6NzjKkLGnBX2
	 vnQdvIf7Cqum22EdvRwXCB5C8xUGxpUrbmQzv8f3Bu6ASz7DenPt53PO7PSJpFeKI4
	 9hZaOABik7O+MjcOiEG4fLjqj99XRFZ5d/sAndzQXhRB8NV/EAP7DfSJAlaKVwnRxW
	 k27M/6A2yMmxo+BDZpnqhOWEBeP4l2lbFGt2TkfasXhoqUIYa3Te3S4Xv0LGt3EB/o
	 Ok3KiX6d8CokRGm8ghHTUU64cDCltyrF8k23OUi+R+UghqYfKH4S2kSrMg+bJHjN2r
	 dml0Np+kcX/OQ==
Date: Sun, 20 Sep 2026 20:18:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, kees@kernel.org, 
	gustavoars@kernel.org, p.zabel@pengutronix.de, daniel@riscstar.com, 
	mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: mfd: introduce the TC9564 config syscon
Message-ID: <20260920-fiery-fanatic-manticore-6abf0a@quoll>
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918165234.687224-2-elder@riscstar.com>

On Fri, Sep 18, 2026 at 11:52:30AM -0500, Alex Elder wrote:
> Define the binding for a system controller used in the Toshiba
> TC9564 SoC.
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/mfd/toshiba,tc9564.yaml          | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml b/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
> new file mode 100644
> index 0000000000000..32e73a727c82a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/toshiba,tc9564.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC9564 System Controller
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +  - Daniel Thompson <daniel@riscstar.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Toshiba TC9564 is an SoC accessed by a host system through the
> +  upstream PCIe port on the PCIe switch it implements.  The switch includes
> +  an embedded PCIe endpoint on one of its downstream ports that provides
> +  access to various SoC peripherals (including a clock and reset controller)
> +  via one of its BARs.  A system controller provides managed access to the
> +  first two pages of this memory region to ensure accesses made by these
> +  peripherals produce well-defined results.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: toshiba,tc9564-config
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1

Both properties and simple-mfd are redundant. You do not have children.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

And this should be additionalProperties instead

> +
> +examples:
> +  - |
> +    syscon@0 {
> +        compatible = "toshiba,tc9564-config",
> +                     "syscon",
> +                     "simple-mfd";
> +        reg = <0x0 0x2000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;

As you can see here - no children.

I also have doubts that this is needed - I see no updates to the misc
binding, which would be referencing it. But then another point would be,
that you do not need separate child node, which has no properties.

Well, has one - address space.

Lack of full picture is not helping here.

Best regards,
Krzysztof

