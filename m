Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395CD25A2A1;
	Fri,  5 Sep 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115639; cv=none; b=naPd3b8srlnrtJIla3wwm+ZbfRrajGqh2wGY130+C//+o67qUCsZFo+0hmvUS6nmEUhbKLPKYEVWIHN9U6D6ohBqN5QpYfMbUnE11sFgAqI9xxdFU14YZ9KFhCQwdvS1DzQ1h9vfqCXhZvOlIpExw9+EBASC8Ww9rhnR0pJvd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115639; c=relaxed/simple;
	bh=vxYzG+tFLchZIj9rrVbtGxvJOup9VkxSvC/g/VUhtwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCxf7BNsGNUU7AcZAX+6uQG62QYltKKlZBlvNzgBWsOdtKyleKtElYaXUJwcd32jInpS98tKmcwsIyQ35P1QFZlnIIrkZtxSboaXZpfO52QYpjJT2JVF/TSd76HYqQbkmuVJZOyw1aB3ZdRuCqzy2pCVTok28kgtaB/YKXuSy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzHfgPr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzHfgPr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2962C4CEF1;
	Fri,  5 Sep 2025 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757115638;
	bh=vxYzG+tFLchZIj9rrVbtGxvJOup9VkxSvC/g/VUhtwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzHfgPr8OJpeMDxSoZMMpg9Mc3C/PaBn+3rO4JAV0xviSHIoBnv97jHdnenX85p3x
	 D3wdwaX1vEvoptJw2RYW6NObvWJBVxgcbA9DiJGZKUAVIPUZc4JaJjENtfLtp8lnAh
	 UPOtGI2DnYD5oGE+MEB3afuk3wC+MEPiQ6TOnpo2ilFKUneWalFtDx+XLGYlDtCV0b
	 WY3+/pIUO2UXzGIOh+QkWSOpt/FclzWtyvasmox5chvwJXHK7fCJDETQjBreMHLack
	 c27Vb7kbA28oVJZevQGW/dRQ4KUZ589jo7aTMAlJsMqnCF9CKvQBaNoPFDffPLnZb3
	 5b7zQUhNDpOOQ==
Date: Fri, 5 Sep 2025 18:40:37 -0500
From: Rob Herring <robh@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com
Subject: Re: [PATCH V4 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
Message-ID: <20250905234037.GA1512025-robh@kernel.org>
References: <20250905113740.3841181-1-manikanta.guntupalli@amd.com>
 <20250905113740.3841181-2-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905113740.3841181-2-manikanta.guntupalli@amd.com>

On Fri, Sep 05, 2025 at 05:07:39PM +0530, Manikanta Guntupalli wrote:
> Add device tree binding documentation for the AMD I3C master controller.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Updated commit subject and description.
> Moved allOf to after required.
> Removed xlnx,num-targets property.
> 
> Changes for V3:
> Updated commit description.
> Corrected the order of properties and removed resets property.
> Added compatible to required list.
> Added interrupts to example.
> 
> Changes for V4:
> Added h/w documentation details.
> ---
>  .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> new file mode 100644
> index 000000000000..1daeb20205ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> @@ -0,0 +1,55 @@
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
> +  For more details, please see https://docs.amd.com/r/en-US/pg439-axi-i3c
> +
> +properties:
> +  compatible:
> +    const: xlnx,axi-i3c-1.0

I'm still wondering where 1.0 comes from? From the link the only 
versions I could see are Vivado tool versions which appear to be year 
based. If the IP is bundled with the tool, then use the tool version 
(oldest version you tested with) if there is no other versioning. A 1.0 
version really just sounds like you made it up.

Something like bindings/sifive/sifive,blocks-ip-versioning.yaml is what 
I'm looking for.

Rob
