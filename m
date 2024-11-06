Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753F20408D;
	Wed,  6 Nov 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911261; cv=none; b=TJSYjEDCA7jU1FY1B8ua1BnE931mcKC0LhcAaod1R4d/9zRSok2tZHfIMXRfDSPD1bAOQjskzo99iJdgeByRxvwQQP11/h8/BPGsXaoS3NTgaoC+iwiy9na0QoeuZ/HdKJQY/NAStpmrsfLSMvSHWV5lNoVS0aR9LbkkiW95x1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911261; c=relaxed/simple;
	bh=/GIrb8lH6MtB9ni0oZQC5O1PWk0ZuEvid3uRJD/gFEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIzq9bOs0FZbvQA8Sd+Ob2kY0p16cqfa2BVvUFp90Byd2YEIVgAo8mbDT6uEzca10OG/o0uH1hKMYOSsuuEGq3KtEkzp/KowsC4M9/ZfqPaNux8qXTB3SRBeLFdvp/oPTod7kELPMs3qkNpxw+C4p3EdvVob3ZG3V0vr67HQ4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/tDVlPs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/tDVlPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC78C4CEC6;
	Wed,  6 Nov 2024 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730911260;
	bh=/GIrb8lH6MtB9ni0oZQC5O1PWk0ZuEvid3uRJD/gFEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/tDVlPsFSxqrW/jxij2IoAoHIVPLSEYkIWy4w1eFfFs8RoMwmk3WbWBgmUVjitiR
	 kYy7iRQs/rx0N5huEMCFuFRGHgVPtI7vVGbJfPS3N5bBwlcJA+3f02facNV4Y5RjBG
	 o5UbkUB3XNhvFIjFLP0CsZwXriRM66aWfZYgBnRtIc9IgJ7ykIXwD2XPHBNoGbhQk0
	 urJvbUcOaX0rmlSegERf/yG2qsPlR5Fl9OuKadaKKd7O18Q17zVcmszNnzVjeswddX
	 El3xioF32fP6OkqbGaQdE+AqbuyJv92rowbq5itKl41dC3ZvJwaoQVjb3ro9SAgKTa
	 yGUO3AyedBd/A==
Date: Wed, 6 Nov 2024 16:40:54 +0000
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
Message-ID: <20241106-happy-anything-46f7293f6aca@spud>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <20241104-floral-dexterous-7d3fee2ff616@spud>
 <c73cac598788ccabd1791b1232e8fd9d7ce23ac6.camel@ew.tq-group.com>
 <20241105-tinsmith-countable-fbb51045bc98@spud>
 <7286141141fe4930cd2581dac7a1fb36a98e62c4.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oJ2Y6Urhi+vkl28I"
Content-Disposition: inline
In-Reply-To: <7286141141fe4930cd2581dac7a1fb36a98e62c4.camel@ew.tq-group.com>


--oJ2Y6Urhi+vkl28I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 01:03:08PM +0100, Matthias Schiffer wrote:
> On Tue, 2024-11-05 at 18:55 +0000, Conor Dooley wrote:
> > On Tue, Nov 05, 2024 at 11:40:20AM +0100, Matthias Schiffer wrote:
> > > On Mon, 2024-11-04 at 18:47 +0000, Conor Dooley wrote:
> > > > On Mon, Nov 04, 2024 at 10:47:25AM +0100, Matthias Schiffer wrote:
> > > > > The TQMa62xx is a SoM family with a pluggable connector. The MBa6=
2xx is
> > > > > the matching reference/starterkit carrier board.
> > > >=20
> > > > Why all the wildcards? Why isn't there a compatible per device in t=
he
> > > > family?
>=20
> Because all variants use the same Device Tree. There is also only one com=
patible and one (main) DTSI
> for the AM62 SoC family, which our Device Trees are based on.

So what varies between the members of the family?

> > > For the compatible string we've chosen the TQMa6254 as the representa=
tive for the TQMa62xx family.
> >=20
> > And all the boards in the family are the exact same?
>=20
> There is a single TQMa62xx PCB, which has some AM62 family SoC installed =
(AM6254 in the case of the
> TQMa6254, but all AM62 are possible). TQMa62xx is also the name used for =
marketing when not talking
> about a specific SoC variant:
> https://www.tq-group.com/en/products/tq-embedded/arm-architecture/tqma62x=
x/
>=20
> Some SoM variants with different RAM/eMMC/SPI-NOR/... do exist, but they =
don't have separate device
> trees (firmware may patch some variant information into the DTB however, =
like the correct RAM size).
>=20
> Choosing one representative for the family including the SoC variant numb=
er, but not distinguishing
> minor variants matches the level of detail used for our other SOMs alread=
y supported by mainline
> Linux (like the TQMa64xxL and various i.MX-based platforms).

I don't like any of this wildcard stuff at all, who is to say that the
next soc you put on your SoM won't be an am62a7, which has a specific
compatible in the kernel? Your fallback then would be ti,am62a7 not
ti,am625. Probably someone will say "that's the am62a family not the
am62 family" - but that exact thing is why I hate all of this
wildcarding. It's barely any more effort to have a tqm6231 and a tqm6254
compatible than what you're doing with wildcard but it is unambiguous.

--oJ2Y6Urhi+vkl28I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyucFgAKCRB4tDGHoIJi
0nTOAP49AhXzVo1rMKvtd3ePJuffEjuHdGlp/GqT6bBrNTGtFwD/eogtLPtuaM+U
fil0gvlsrbgOMKWtdE3BthhK3ZCfvQw=
=yzQZ
-----END PGP SIGNATURE-----

--oJ2Y6Urhi+vkl28I--
