Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959772D9EE1;
	Wed,  3 Sep 2025 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932460; cv=none; b=sRFlwr25EMHtj7FZaV5vS3wtKnCLg/vehxbn19SAVW4rdaMjO7gdSEsSSasAZ4evdJLytW5ez53QoDGxLiASzA1X40rN3m93QaGIuHZatkjGit+0JEX7w1p8SdkIm1XVwYm5LdwQelnc1kdqhHAUbjwf2UQmYPYXH+3b1WNmc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932460; c=relaxed/simple;
	bh=fmmefG9viijRhTVNQthic+Hu8WGTQ6x3xU0/JdzSOjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAWAMaRxdoXtRbRLwfunMGZS3584zok4X5LiUqgisqz5D58C5rf+Bj6HC6rMmVPRcy3OVp/PkmXeX7uAEkh+4p5mewSQEqn/w+OEOh82+eqI5EmHZB6B75C7yseG8aldb1ydxKqsDj8XgjFcL1z9k/OOScB1nl7fiXZeDeeqRx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVrMb9ZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVrMb9ZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F28C4CEE7;
	Wed,  3 Sep 2025 20:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932460;
	bh=fmmefG9viijRhTVNQthic+Hu8WGTQ6x3xU0/JdzSOjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVrMb9ZVNzZejicKw11SwSxH3otxG3KBAreea14rAz36ny2rEHcNl7rGQcic+LFYt
	 iOuXWzfsOLHxgZMfKi2vN/TMl8agBwyhCXYDdEIwzpIoYk0gCFLvJFMLL4j/ZJkqgw
	 DKZKPNnv8BjZXgEWcTDudeAqeXUiWRoKVF+CSWkotf+byb0UvtV7G4lBoL5u3e7vLr
	 njz4cOVmWMlCx94tu086RPh5z1Gs3uZw1V99FJfJ6fLtnOhIVEYVBBTOVzQm1MoY1Z
	 Z52sAjAau7oW7q3+CTm/6KEfi16kSGFUOpF01dhS93kv1LVqG4OwzT7JV21AhQ+Jju
	 6TqHkMmey6kqg==
Date: Wed, 3 Sep 2025 15:47:38 -0500
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
Subject: Re: [PATCH V3 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
Message-ID: <20250903204738.GA2744698-robh@kernel.org>
References: <20250903095906.3260804-1-manikanta.guntupalli@amd.com>
 <20250903095906.3260804-2-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095906.3260804-2-manikanta.guntupalli@amd.com>

On Wed, Sep 03, 2025 at 03:29:05PM +0530, Manikanta Guntupalli wrote:
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
> ---
>  .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
> new file mode 100644
> index 000000000000..32f73c31121e
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

Where does the version number come from? This must correspond to some 
h/w documentation or it is useless.

Rob
