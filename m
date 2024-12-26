Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D532BCF5;
	Thu, 26 Dec 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735234602; cv=none; b=AAXGJbkXmRtsQkiqBsfh725JL4HhOzjS4l6rTCyDK0G9mpLkIo3XS/wZ0ESSScas6kPxyYxeh+N9c9xgyrz1BI8EvH4jOGWAnDT+DxVrKH/NSgayZAySJOpwZtQFweLTu64FXZjHneYimvZX/WCD6G+cqYPFwMsf+d2rzqZXTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735234602; c=relaxed/simple;
	bh=E98IMWNWXz+q/sQ0HonTh/il92ipi5DSg9DWWA5c2aA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF3oaBcwMFj/OqSo81ZG2mCkaTpn/bU4Nx3JbmAjRCIulc/GALDP7osFsclfwDh0e9pfvtXBPZH4M7kVCOretdjNFsetCUmKSVfKRVkiR3JlbWXlDMdHpYRWXoYfeOIrUGJqgmNTd/WnZYUxQwZ06Pa0HhvtGv6TLWuobe7WGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gqkbLQqW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gqkbLQqW"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BQHa5Sm007975;
	Thu, 26 Dec 2024 11:36:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1735234565;
	bh=dx45m49A7rbyoDNzZ9IqzaqQc5ODntfqPsXgrpTfP7I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gqkbLQqWJJcNL4toy1hHZQ0RKhSDt+x218lryK14wGIr59q0ueCPV+89sOVFX4P2N
	 bjDIStQwmUHsD1v2U5ZHCt+xwqmASS7GMwoznnTBuD4NjPLe5scDj9gxXFvCdD3nkg
	 kGouUdr+t7sfusd959jzpgkZIi+EIfBcofPK9CzU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BQHa55p078363;
	Thu, 26 Dec 2024 11:36:05 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Dec 2024 11:36:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Dec 2024 11:36:05 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BQHa5xr072158;
	Thu, 26 Dec 2024 11:36:05 -0600
Date: Thu, 26 Dec 2024 11:36:05 -0600
From: Nishanth Menon <nm@ti.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Felipe
 Balbi <balbi@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, Devarsh
 Thakkar <devarsht@ti.com>,
        Hari Nagalla <hnagalla@ti.com>, <linux@ew.tq-group.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: usb: dwc3: Allow connector in USB
 controller node
Message-ID: <20241226173605.hcvybgbi5pmmeh2b@sweep>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
 <06497b8aadc0b5becced274d0a5fbcd808d87a48.1733737487.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <06497b8aadc0b5becced274d0a5fbcd808d87a48.1733737487.git.matthias.schiffer@ew.tq-group.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10:51-20241209, Matthias Schiffer wrote:
> Allow specifying the connector directly in the USB controller node, as
> supported by other USB controller bindings.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 1cd0ca90127d9..2976fb1a58061 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -68,6 +68,12 @@ properties:
>          - enum: [bus_early, ref, suspend]
>          - true
>  
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +    description: Connector for dual role switch
> +    type: object
> +    unevaluatedProperties: false
> +
>    dma-coherent: true
>  
>    extcon:

This needs to go via the USB subsystem team. The device tree changes can
go once this is merged.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
