Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CF158535;
	Fri, 28 Mar 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743122825; cv=none; b=iOSACTuTuchIryAuRFpDJfi/fEUwfKFefybI4l/sRr2TrZ6aJvrG97Y6rwsC8BuSOnwcE0IIcyaHu7VqjNqYycB6nbvozYzMy8WtvheUOJdp+U9QG9ecCwJB3Osom3blwzZN2Fn9TnAUTneO/o0g810MDvYfzbuxZBkfh9/FT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743122825; c=relaxed/simple;
	bh=p+ra6T2kuA7+mt1Iw7ON824iAjkZzokAvi5uNjYApfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJ//45XFJWO1L1Bs7bu6Vsesucow26XGFOBKuv1BOsEUX6JwMRS/qSLYfBcIvJtZ6ZBbUOZ3TVZl2by8kM1sHfld8wNoDbONjADubmGICMIeIQbYpf8tUhAOiymZ55ss1QMzE8S/vWlwmg0jlh+TbDakrgf8o8fiyEc+V5QXmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=l8YUapQx; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="l8YUapQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1743122814;
	bh=p+ra6T2kuA7+mt1Iw7ON824iAjkZzokAvi5uNjYApfw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l8YUapQxzkeoWlqLL49sQe2NZt+CDE+Nbw6PPh7eZKP++2Ac/TSsnK1tiM8aLmjXH
	 ar97VpEYv4CJvV2HBzYiqAYvGRrXS5SX1+jOn8cZbD2UXHu0hG+ziM/hyTG7h0MAyp
	 eCrvBZPGJH/pl5yjqZGxCdUUZbbPn8RAshQSwN2XFyx4y5qhrlsHmE6fttMcr9p63Y
	 mWibmTpNIuw6aArxfyUc4gHIgIdHCwAgKe6okSnUvEjAtjpNnsrMVqHfJBpdi0NiFD
	 essgIYoScXVdiCnLgBILlmAyiayUxWWj4wNKzK4NeNA9WT/igeteJsm/lHbAnK/DGU
	 wBJTYZY0MyPmg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C0E4C7BC5A;
	Fri, 28 Mar 2025 08:46:50 +0800 (AWST)
Message-ID: <d0f7003c22e19c8fc7617610043edc7be925a180.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/3] dt-bindings: pinctrl: aspeed,ast2600-pinctrl
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Willie Thai <wthai@nvidia.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, kees@kernel.org, tony.luck@intel.com, 
	gpiccoli@igalia.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Cc: leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com
Date: Fri, 28 Mar 2025 11:16:49 +1030
In-Reply-To: <20250324175926.222473-3-wthai@nvidia.com>
References: <20250324175926.222473-1-wthai@nvidia.com>
	 <20250324175926.222473-3-wthai@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-24 at 17:59 +0000, Willie Thai wrote:
> Add EMMCG5 enum to compatible list of pinctrl binding for emmc
> enabling.
>=20
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Signed-off-by: Willie Thai <wthai@nvidia.com>
> ---
> =C2=A0.../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 1
> +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> pinctrl.yaml
> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> pinctrl.yaml
> index 80974c46f3ef..cb75e979f5e0 100644
> --- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> pinctrl.yaml
> @@ -276,6 +276,7 @@ additionalProperties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - BMCINT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG4
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG5

What pin configuration does this correspond to for the eMMC controller?
These groups aren't arbitrary, they correspond to the 1, 4 and 8-bit
bus modes.

You may have added this squash a warning, but I suspect the pinctrl
configuration in your devicetree is incorrect.

Andrew

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ESPI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ESPIALT

