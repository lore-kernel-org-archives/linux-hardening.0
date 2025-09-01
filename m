Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC50218EBA;
	Mon,  1 Sep 2025 05:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704067; cv=none; b=Je/yoQSKpWX1hXx2vO8qPH0FVpkBvvrtaERkVPpo8P1lgL9tW3wKHwvrTUdYY7noWjcQz/fFCG904+xqGRs3EjjXg1I0DokZ6kimAE0kF4tV79mb4ekRSN/FHsuL5JeIAPaINMcHSuGXbz5LnBfWhaB1zJMItqLRrlj9vkSbU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704067; c=relaxed/simple;
	bh=p73wikkWjgPiEXtKBYuxdsbxYw/1Fn1rox3FNuHjuNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvjluZJC+DFY1kqmO1I0ThrxZe3BcFLNlb0AGoEh/YQhenCA9yWnIEZnU9zsWHOgIUksPOA+1S7BeEQBM/Lj0zhT5+DGo0GOo2kdylbihkRmi0zaZZ9M5k0hfv8fmII7Xnhj2p98ZYuWLCxraa1cI+gVYIO+UPUMyQbHtbv/JjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJM61YiT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJM61YiT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC43C4CEF0;
	Mon,  1 Sep 2025 05:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756704066;
	bh=p73wikkWjgPiEXtKBYuxdsbxYw/1Fn1rox3FNuHjuNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJM61YiTet+yQE0KLUtqO/JBa3O54UgDiKgSc7JnNCikYZGRdGKkQzPVhVyXz9TBz
	 gCOgADD3DEnLu2NYiTpaUWA8uMnmKYtJP8N/KD/LFKawXWrk2O9iyhAe7g8dTD06qL
	 BlVw6kBmqeCg1FheP7czoC7LRDEsqa1YqZhFcuXVuB+Acce0j/VoIooRtXJjBsXEdV
	 QzEOmfROJJoA9UzMTvDmFrpML0c/YW25rDxkCrXcespvcamK9NBGSWGcrD+G5HEu7b
	 Kk1GAiLCMj0KMgJfu39kGSHjM7m8bjZIORvvr06cY05h6sD8lEZbwZFtFmEfRos08x
	 HA3FI3O/opGSg==
Date: Mon, 1 Sep 2025 07:21:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com, 
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, jarkko.nikula@linux.intel.com, 
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com, srinivas.goud@amd.com, 
	shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V2 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
Message-ID: <20250901-hospitable-tentacled-chicken-05b2ac@kuoka>
References: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
 <20250829171327.2590730-2-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829171327.2590730-2-manikanta.guntupalli@amd.com>

On Fri, Aug 29, 2025 at 10:43:26PM +0530, Manikanta Guntupalli wrote:
> Add device tree binding documentation for the AMD I3C master controller.
> 
> The controller is represented by the compatible string "xlnx,axi-i3c-1.0".
> The binding specifies required properties including register space, clock,
> resets, interrupts, and provides an example usage.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Updated commit subject and description.
> Moved allOf to after required.
> Removed xlnx,num-targets property.
> ---
>  .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> new file mode 100644
> index 000000000000..48be3c53c1be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD I3C master
> +
> +maintainers:
> +  - Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> +
> +description:
> +  The AXI-I3C IP is an I3C Controller with an AXI4-Lite interface, compatible
> +  with the MIPI I3C Specification v1.1.1. The design includes bidirectional I/O
> +  buffers that implement open collector drivers for the SDA and SCL signals.
> +  External pull-up resistors are required to properly hold the bus at a Logic-1
> +  level when the drivers are released.
> +
> +properties:
> +  compatible:
> +    const: xlnx,axi-i3c-1.0
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1

Reg is the second property. Rest should go alphabetically.

> +
> +  clocks:
> +    maxItems: 1
> +
> +required:

By convention, also compatible.

> +  - reg
> +  - clocks
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i3c@80000000 {
> +        compatible = "xlnx,axi-i3c-1.0";
> +        reg = <0x80000000 0x10000>;
> +        clocks = <&zynqmp_clk 71>;

Make the example complete - missing resets and interrupts.

Best regards,
Krzysztof

