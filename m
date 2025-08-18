Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AF2236E0;
	Mon, 18 Aug 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536481; cv=none; b=OpwWaSHpU0oUvLV6T0EgryHAMpzkPUYaKfB7UyDHRlpFKshjE20TNzGrDalZTUhAEPKJO27iBynrqh2bpPjwHwJjG3bm3G0CGm6PNgefGUvUZTQCFJTVrgujJdx8xPHt6UeTOP4DSNWMpl2Gc1XmnWhj6ZzLNUptUVekx356pgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536481; c=relaxed/simple;
	bh=HACcRh47pib7srbjF+9nIoKNELE6V0XNbpJdUKYXrMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrPCIiFondwKWBTxwSaNnCKx4ap0rKWcd4ykSJeNdEgfHsawWnE+GPWG5QXqVOkXQ0DtzG2F/5zxY3kw/NGaCvRBcYjc9W+mxIlrR4WfXF1lfg/tnusrsPRd7Pg+3txyxzDk8SEhNlGmFyZrcwqpPFa8xR1cy841iDZRQ8gJpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvDPSRoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvDPSRoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6D0C116D0;
	Mon, 18 Aug 2025 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755536480;
	bh=HACcRh47pib7srbjF+9nIoKNELE6V0XNbpJdUKYXrMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvDPSRoKwNkoreX4vgeYAq/ATnNXaS7iQPzZzziP9JoV/tCSJkwDffOju+TxRu6zb
	 w6BwBKbfEF8XvPXoxMPC6hrlnlWvYZ16NURbnFwZTtk6K7Td2ueBjAsrHgz2THTKE4
	 CwFynAKveW5zabNGgpSYpoTdiETck0x3D3W6kh6Xd2T+rLf7d9HF2Yx95zg+Kwl/SP
	 qKfZgzWxLuD1GHqYIDVzm5QpakcThDONHH8MKpJRrOBXMXoIZRRo3/n6a4hY/QBElk
	 ATOofdGJVHR1miIRKKbb6jg51Ia1Wj3mgYDiq3zw26ToRcVp3wgCLo7vTq/ckBoYA4
	 XoaXav6wkzSJg==
Date: Mon, 18 Aug 2025 18:01:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gastmaier@gmail.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <20250818-stunner-duchess-abb12098ab5b@spud>
References: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
 <20250818-adi-i3c-master-v7-1-f7207902669d@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fQXvwKjG+OgYED7Q"
Content-Disposition: inline
In-Reply-To: <20250818-adi-i3c-master-v7-1-f7207902669d@analog.com>


--fQXvwKjG+OgYED7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 01:51:13PM +0200, Jorge Marques wrote:
> Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
> core that implements the MIPI I3C Basic controller specification.
> The IP Core is versioned following Semantic Versioning 2.0.0 and
> ADI's open-source HDL guidelines for devicetree bindings and drivers.
>=20
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--fQXvwKjG+OgYED7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKNcWwAKCRB4tDGHoIJi
0hMPAQDCIOHavm73r9ecryn4inj2X4/0elOD1EBAKzBe6rgQTQEA4qt0PMMxwDV8
tvH/O3adl8ft4Xr/fj8DjLRwj+iSdwY=
=h21F
-----END PGP SIGNATURE-----

--fQXvwKjG+OgYED7Q--
