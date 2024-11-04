Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B519BBA;
	Mon,  4 Nov 2024 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746038; cv=none; b=CQ/yO0c4505Qfg43eS4LtARNTR5/baSXOptOtn8xcSS0nhIZj/D94q07HIm2jzGNUsH4DEYAfmO/EPtIeK0iRonpoqv/irxLW6ACKz3LbQw5waphpbbP4NYZRzjdQWshMsf6lzOE2cYo7+Z2Wa6R5d/U69u6F2zPC/qnqWjDC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746038; c=relaxed/simple;
	bh=rWhTWVbW4mGA5mw9ohHUzN2aUaoDA1BFpsVVEDEm4CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOu0SvpKeVuaOtnvzqf3y+Rce+cenpbLSOXlD8z/eNIdQa96S20N0c2+Y9M3uqPDla21sta3Vkr7pPpDBCK/SMyIRi7fwAWrynlBYL1rN4edQX1pkNhlvg4WWfhklI+a17bhNLCVv/FsrWweyg0pw70LTACMLwGIJxmnC9G8mrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBdhTekT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBdhTekT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029BAC4CECE;
	Mon,  4 Nov 2024 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730746037;
	bh=rWhTWVbW4mGA5mw9ohHUzN2aUaoDA1BFpsVVEDEm4CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBdhTekTdA/WpeLSglViKAU25A+dbJ2m5atIn1kG9m3IG/PkMCnp9SsoMI7qveMN7
	 1RKFj2d5s3eR6cB8h1UtUItSmUErSlYA3V9P9rcVBvRGl1le/8fxHaYaQ42QqyaKU/
	 SwPoyHFMk1f0c3zu3JwsrfqJa+DZVaxwZQHx2jiIwH2Tpfo8+52y768Q76Ee52TT7P
	 wDQZdp298qgm6ALheVskJoyu52aQlLiM9M8SpPV8/WfaVcn1SEOMHQdK09dRdCM9K3
	 55Lbeh33zG+h3rxNQ+V8Xk4Zg0KfzOULGiuI0wNT6n73kV6cnlUAT2EQyssffP/5r+
	 +tH8DOCO1nhuQ==
Date: Mon, 4 Nov 2024 18:47:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Felipe Balbi <balbi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>,
	Hari Nagalla <hnagalla@ti.com>, linux@ew.tq-group.com
Subject: Re: [PATCH 2/5] dt-bindings: arm: ti: Add compatible for AM625-based
 TQMa62xx SOM family and carrier board
Message-ID: <20241104-floral-dexterous-7d3fee2ff616@spud>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EATJd2ZSzXL2Ixpt"
Content-Disposition: inline
In-Reply-To: <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>


--EATJd2ZSzXL2Ixpt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 10:47:25AM +0100, Matthias Schiffer wrote:
> The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
> the matching reference/starterkit carrier board.

Why all the wildcards? Why isn't there a compatible per device in the
family?

>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documenta=
tion/devicetree/bindings/arm/ti/k3.yaml
> index b0be02f9d1253..d8b52b95fba7b 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -73,6 +73,13 @@ properties:
>            - const: toradex,verdin-am62          # Verdin AM62 Module
>            - const: ti,am625
> =20
> +      - description: K3 AM625 SoC on TQ-Systems TQMa62xx SoM
> +        items:
> +          - enum:
> +              - tq,am625-tqma6254-mba62xx # MBa62xx base board
> +          - const: tq,am625-tqma6254
> +          - const: ti,am625
> +
>        - description: K3 AM642 SoC
>          items:
>            - enum:
> --=20
> TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht M=FCnchen, HRB 105018
> Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
>=20

--EATJd2ZSzXL2Ixpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZykWrwAKCRB4tDGHoIJi
0jo3AQC+LelXQR2pEsAaZyVgw5FfWNOZ0ohjhWoy+Oi8MG8yzgEAtUuldRsTZUU+
yG2hlyDNYR07kMS1/Md+DDOKJb2DJQ4=
=lA4g
-----END PGP SIGNATURE-----

--EATJd2ZSzXL2Ixpt--
