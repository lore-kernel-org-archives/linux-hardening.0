Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893C18D642;
	Mon,  4 Nov 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746082; cv=none; b=IdalAhkdPKfIaDrvlFVi+nkkzKeLiJJjkwy2f/lhCt/boRtdvVArof4p3B1ggFKj4wyxd35nYLuaFu+PTTChKPRmpiu4FwZ4z54jdPmbkb6T0F8GYPZGEZ57Rf2GLlLV6UgAXrcei0+7hkNYYXGorT9TtjpXFzFKIKldxS20Yak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746082; c=relaxed/simple;
	bh=R6enrP37S1Lalzqg/vwJusOD1jfo+xSMpEE/34E4UvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRQLJX5wa2cZl/pMKCCGBrsOEL6Zc5gvkL5ep2CK+sF527qmhmbWy6VwT0QrbPmSfdaX6S3i7sxMrQXVsaYKKN+W+V4SPxprw7O5htWNV/E3msNgQBKlMw7uwk5EQoE8qaqMhnTOY7ccPPTz7RC9PcyMRzoUhqCvNRFKJWjlgCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsd4f5Tj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsd4f5Tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C1CC4CECE;
	Mon,  4 Nov 2024 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730746082;
	bh=R6enrP37S1Lalzqg/vwJusOD1jfo+xSMpEE/34E4UvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsd4f5TjAfpKOeeA9jmcZKkCiTU/v4Si8fT8Xi8MCST4MLqB/1rWyte0a4Yn7SLYv
	 n/J/EGbobg4mTbJ41BvPj2oXrsX0Cdglbb/aJTTZzG4FAAs/jynSw7buGoTXNi7sHz
	 bEYqD6KbkbZzdUvacl5kliiRXIxdIljQ7GDHspXQOdAizWoNDptwBU02kDAdQIn4TN
	 23ZaCGII+Cvgth04+5Er1rzCQL0sG2fFMMYf9WlcCE2JiYGLlKlf3uQePJrB40PSfU
	 2mliFvqYVC77hbbTj3IH08iyf01NDrq7fUbUr7w2sVW8Jv1Lcn58CgiB9cZAV5lTtC
	 7gPK855LhHaPA==
Date: Mon, 4 Nov 2024 18:47:56 +0000
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
Subject: Re: [PATCH 1/5] dt-bindings: usb: dwc3: Allow connector in USB
 controller node
Message-ID: <20241104-elevate-margarita-6d28317061d3@spud>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <c8c9f19c300378916e920f5d3c26c67bac95d143.1730299760.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z6TAEo5WjG+TxVyM"
Content-Disposition: inline
In-Reply-To: <c8c9f19c300378916e920f5d3c26c67bac95d143.1730299760.git.matthias.schiffer@ew.tq-group.com>


--Z6TAEo5WjG+TxVyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 10:47:24AM +0100, Matthias Schiffer wrote:
> Allow specifying the connector directly in the USB controller node, as
> supported by other USB controller bindings.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Z6TAEo5WjG+TxVyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZykW3AAKCRB4tDGHoIJi
0t5fAQCmiNYR6DPPTIjBTLUm3zGkagYYxIwcEcQPBoO9ZQ2u9AD/dLu9HA+JtHYH
mgxreyJp3BHPFh+92r0t0rrQOhAfiwY=
=Quc0
-----END PGP SIGNATURE-----

--Z6TAEo5WjG+TxVyM--
