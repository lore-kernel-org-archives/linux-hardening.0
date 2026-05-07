Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D523254A0;
	Thu,  7 May 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173557; cv=none; b=qoZyRFcoHbj+CzFP1aJpk2zQG6G9em3T8wPKzUSuuHvKYrvi7rdlL4PmWTx+pddEYH+jrzJatwvkdlGQmUQJAltuGNfQLNtvdTBgsYhjOn3CvwI5dZDxTQEbxv1mrG1SNtaTHutWH0KcBZJDnBNXS366ouDF352WVkyKZsOBQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173557; c=relaxed/simple;
	bh=xP4kvN20Q4l2M3zAgqCtFzM8COxGNtbqy5n6gljAOkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiauGRnmDl9/ctb8uGJNzr6TGPu+J8LfLhzXVcP3UHkg7XKXeQAKPMW10BGFitQFqfvWI0QQAtTgc+VqnXC9zPfxgbz6J66rY0IR0kvnFHc32xbqjT6At5gHABTDNKJhRzqIDDewTPbAPS2vYkayE6dSiOvqua4VcYfkhDwNwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEYVWUFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEYVWUFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176F8C2BCB2;
	Thu,  7 May 2026 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173557;
	bh=xP4kvN20Q4l2M3zAgqCtFzM8COxGNtbqy5n6gljAOkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEYVWUFYfs+Hu3bCpGtYs3PemIHPivPhjLOQ+wc2B+b3o8O1XjDIVzjw0cvLRsgTD
	 gDRycUVn51z/r3FD5XkWutO1NrMxGkCr+3yoPXHKbirSCGN4w2UN3CRG5SsgJ86RrO
	 Hgt60M0Een1ax9wSussdAFhHLGVBvV/gF/1eWroNbIzjEe46tEF4dU6ErHZb/wgnz6
	 85JFEi7gcjUAm/AfBOIcALNGPvihLEi/nuPLbDiKHHDjJ1ueYGkuEHOZshyYp6g2m1
	 6F24te6W73TlhF3v1mqdnCDjs/EOxGuxssr/HMYfbYRjUjhZLakpSbcfAEbbeKK3YG
	 ZZMA+ERjc2+kA==
Date: Thu, 7 May 2026 18:05:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
	Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: raspberrypi,bcm2835-firmware: Add
 bcm2712-firmware compatible
Message-ID: <20260507-wish-acre-1e4389843c75@spud>
References: <20260506-rpi-otp-driver-v3-0-294602663695@linutronix.de>
 <20260506-rpi-otp-driver-v3-1-294602663695@linutronix.de>
 <20260506-unguided-duty-892b11b7c618@spud>
 <7g6bvlp5fs4bkviiyywqu5wb5hndkczcamgtir5ow262cqkmdo@xyj2otywjepn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ro8e+12XL9fqGZ2"
Content-Disposition: inline
In-Reply-To: <7g6bvlp5fs4bkviiyywqu5wb5hndkczcamgtir5ow262cqkmdo@xyj2otywjepn>


--5ro8e+12XL9fqGZ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 09:42:54AM +0200, Gregor Herburger wrote:
> On Wed, May 06, 2026 at 05:50:42PM +0100, Conor Dooley wrote:
> > On Wed, May 06, 2026 at 02:28:15PM +0200, Gregor Herburger wrote:
> > > Add a compatible string for the bcm2712 firmware.
> > >=20
> > > Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> > > ---
> > >  .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml      | 13 +++=
+++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bc=
m2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi=
,bcm2835-firmware.yaml
> > > index 983ea80eaec9..fbcfa2bc168a 100644
> > > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-f=
irmware.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-f=
irmware.yaml
> > > @@ -21,9 +21,16 @@ select:
> > > =20
> > >  properties:
> > >    compatible:
> > > -    items:
> > > -      - const: raspberrypi,bcm2835-firmware
> > > -      - const: simple-mfd
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - raspberrypi,bcm2712-firmware
> > > +              - raspberrypi,bcm2835-firmware
> > > +          - const: simple-mfd
> > > +      - items:
> > > +          - const: raspberrypi,bcm2712-firmware
> > > +          - const: raspberrypi,bcm2835-firmware
> > > +          - const: simple-mfd
> >=20
> > This diff doesn't make sense, either the new firmware is compatible with
> > the old one or it is not. It shouldn't appear twice.
>=20
> Ok. I will change it to:
> -    items:
> -      - const: raspberrypi,bcm2835-firmware
> -      - const: simple-mfd
> +    oneOf:
> +      - items:
> +          - const: raspberrypi,bcm2835-firmware
> +          - const: simple-mfd
> +      - items:
> +          - const: raspberrypi,bcm2712-firmware
> +          - const: raspberrypi,bcm2835-firmware
> +          - const: simple-mfd
>=20
> While reading the writing-schema.rst documentation I saw that it says most
> bindings shouldn't need a select. Imho the select in this file doesn't add
> anything which isn't covered witht the compatible. I wonder if I should d=
rop the
> select block?

That shouldn't be required, other simple-mfd users do not have it.
Remove it and run dt_binding_check just to be sure. It'd be a separate
patch from this one FWIW.

--5ro8e+12XL9fqGZ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafzGbAAKCRB4tDGHoIJi
0jcEAP9De/nmvd7WAcOJiOqJ8uorUaz7Zs4p72tklWAnAe+kZwEAve3uDlZgWZ8X
+GSEgozVGiK5jmv6gykKHjV7ZQuVLgM=
=B3W5
-----END PGP SIGNATURE-----

--5ro8e+12XL9fqGZ2--
