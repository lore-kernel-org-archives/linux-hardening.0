Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87A1E766B;
	Tue,  5 Nov 2024 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832933; cv=none; b=ETGFOPbqsL2v0CyFECjzpx2HCW46rTERq6nK/rvUsLw05wll7mGD9Ma3uiPOy0gp+i4cfZFLe1txtto88DwMO7Nj9Adt1i7CzWugSptVxtNTBVYoHs5rFWwaqO/gbtysZrQ0ZP7kICH6AX6oZBwgIc25FQJc4l7K70oUYP/uTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832933; c=relaxed/simple;
	bh=fdvKRMgW7zF0SKQdqUfQdOZv/sf80HPqPrtGxl6gaIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7ROJLwMOZ40BhyGFYqpSWtP2p4YiO3TmmeWEL4LF6UE9pccvkW1HES8qGavhIPuzZy0bkJL1HqHl5RrFhcO967oRoPvv8MLTlrXu0a/Bub47Vgsdx7d7TO+VX4Bb+/FpeZqseRKY1nlem+Rjb9ClJELXaFEHOTMa5huJi8xgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riXfZ0fP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riXfZ0fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367CDC4CED3;
	Tue,  5 Nov 2024 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730832933;
	bh=fdvKRMgW7zF0SKQdqUfQdOZv/sf80HPqPrtGxl6gaIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riXfZ0fP3TYDNEXcR84bacJljgVXs1yvtCSpGF6d0oi9AT/0PjnQgdGpb459+yjub
	 /MVNxPsrXctufX4oDudFI6jIqlIHBpneRgJ0ryO5rPys1TCnH56noTJt4t4nL7XRoU
	 YQLJbiVckj2UdroqxdDzCWkSax1UfOjdKZGa87ZX0hktzF2s+JCO42yXf1mu4Zsa0b
	 qXLCKPFoD8cHOsXW5ONW/vKxFku4ROJ39T+6PPGMvh4HqzWbClYkPHU4raH6inlsA0
	 7ffoHAW7rWCweJnUxXQ3oCiL2lHhyUdG+xPhV855qpNNRXU4lp3B+sTG/eCaidQQ4Z
	 5MQnBQcNl0DBA==
Date: Tue, 5 Nov 2024 18:55:27 +0000
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
Message-ID: <20241105-tinsmith-countable-fbb51045bc98@spud>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <20241104-floral-dexterous-7d3fee2ff616@spud>
 <c73cac598788ccabd1791b1232e8fd9d7ce23ac6.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BiH5KkwowkxZuLss"
Content-Disposition: inline
In-Reply-To: <c73cac598788ccabd1791b1232e8fd9d7ce23ac6.camel@ew.tq-group.com>


--BiH5KkwowkxZuLss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 11:40:20AM +0100, Matthias Schiffer wrote:
> On Mon, 2024-11-04 at 18:47 +0000, Conor Dooley wrote:
> > On Mon, Nov 04, 2024 at 10:47:25AM +0100, Matthias Schiffer wrote:
> > > The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx =
is
> > > the matching reference/starterkit carrier board.
> >=20
> > Why all the wildcards? Why isn't there a compatible per device in the
> > family?
>=20
> For the compatible string we've chosen the TQMa6254 as the representative=
 for the TQMa62xx family.

And all the boards in the family are the exact same?

>=20
> MBa62xx is the proper name of the baseboard; this board can be combined w=
ith any TQMa62xx family
> SOM.

Then that one is fine.


--BiH5KkwowkxZuLss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZypqHwAKCRB4tDGHoIJi
0jlmAP9cOMTcv1GKBS/z0Rp5HGJWn1/Hbig/hZ/MpUT7ibMGbwD+PNjKY3hXXs+2
2Co/oEtSJ8B74WmjFsXxTJYlYsmT8wA=
=2Dxh
-----END PGP SIGNATURE-----

--BiH5KkwowkxZuLss--
