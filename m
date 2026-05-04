Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ECC37CD55;
	Mon,  4 May 2026 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888454; cv=none; b=Gwy+xQrPoWaGzNj8Tr5ueTHhOTWhgVYDvwZaG1CysMwM7ArX1TvRa45hzxHx9/ds4tL1Lh37HHFPCkhihaxQftrtlL1luqlAwx34qHo+kYfdC/pVXS+cPPEvJMmrrUcMfA8e/cKFSv8m62JL1FhosZIUqhad2y7Orxa/vokhAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888454; c=relaxed/simple;
	bh=Z8fiul8TmU7YltudEE+77XwXuYIqxOtXGRfJLVZBnJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ6Cuzv66zemA29h/U2QgekgeNw7mvy4Pi2HlSgt/ZUutW3zINCBfzMD8Iit+gQSVEQjATT8tKnGM5HN18flJK8ov+w9El2InZZGvfS+xHOlUuxs2QM5KQEnnJ05g5oc5PYGOAmy9OCJhZVm6DmrnViIrcrPIPPYDnXoRmNRo7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLW1uNjv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLW1uNjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC083C2BCB8;
	Mon,  4 May 2026 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888454;
	bh=Z8fiul8TmU7YltudEE+77XwXuYIqxOtXGRfJLVZBnJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLW1uNjv9+lCrTZa3oGmivE6EjkkcGTu7/RS8MVs/ucukTxRnlSdxmx3n592yqO8W
	 v609tW8k0qfx3e33eNN96/KQNe6Hu6x94PtvoVbkqBAxTJiCHQLY0S02GfnXLNS94j
	 my2P32hras+TwoEMrYf6AwsAHsybHooVGnFjbJ1rpnhBiXWamS591JH47Ds9l7qqgx
	 86jX2PVFVoJc3CGQKke3/dK6w3N6rLjCSPQfyBo1FYg8dYfKlaQIuF0SifwsmebFuM
	 EfdLUCKmFd9rMf1oToEZBHHycwJhl8DC7n1ZWhU9/rZOp34gM9CGjL4IahiXbQCL5s
	 yPBSqSTH/fBtg==
Date: Mon, 4 May 2026 11:54:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Ze Huang <huang.ze@linux.dev>, 
	Alex Elder <elder@riscstar.com>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Spacemit K3 USB3/PCIe comb phy
 support
Message-ID: <20260504-logical-nice-python-1e1f43@quoll>
References: <20260430022843.1090138-1-inochiama@gmail.com>
 <20260430022843.1090138-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430022843.1090138-2-inochiama@gmail.com>

On Thu, Apr 30, 2026 at 10:28:40AM +0800, Inochi Amaoto wrote:
> +properties:
> +  compatible:
> +    const: spacemit,k3-comb-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 2
> +    description:
> +      The first one is phy id, the second one is phy type.

You could mention here the defines representing supported phy types.

> +
> +  spacemit,apb-spare:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to APB SPARE system controller interface, used for
> +      PHY calibration.
> +
> +  spacemit,apmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle of APMU syscon
> +          - description: configuration of the PHY lanes
> +    description: |
> +      Phandle to control PHY mux configuration. The configuration
> +      is described as follows:
> +      bit 4: 0 - PCIe A x8 mode, 1 - PCIe lane share mode
> +      bit 3: 0 - PCIe A x4 mode, 1 - PCIe A x2 and PCIe B x2 mode
> +      bit 2: 0 - PCIe C lane 0 is PCIe mode , 1 - USB mode
> +      bit 1: 0 - PCIe C lane 1 is PCIe mode , 1 - USB mode
> +      bit 0: 0 - PCIe D lane is PCIe mode , 1 - USB mode

I assume this device k3-comb-phy handles phys for PCIe A, B, C and D?

> +
> +      The bit[3:0] is only valid when bit 4 is 1.
> +
> +required:
> +  - compatible

reg required.

> +  - "#phy-cells"
> +  - spacemit,apb-spare
> +  - spacemit,apmu
> +
> +additionalProperties: false

Best regards,
Krzysztof

