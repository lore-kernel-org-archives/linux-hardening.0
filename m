Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234617;
	b=BMdH02GdenKh+231GB9RO8iUnYljA7J50OlUXq5KCCC+PmWPZJocbwH5I0tpNYq2JGPK
	 b5pku9xoDhCebl6AJjp6zZdx2Iy8QtsxTpuZZQV/IyYC6DC7Q3dZZ1SsgoyQl//Z+lCT8
	 bg8m41NWmS5rwGCgtfqPnTDfhslXZO6ScdICtPlEd5a5LBd8IG9GXfHkFzP0WRMS3uwGa
	 pcWvxiXSHjKrRUncHGd62n6cca2d7N4q59TGhhMryQSXmGUk/dDA+C8fbQG5sicA2+Rku
	 UNBz0AycFunkrJyxvdtUB/DmV//j7MC3EQ+iIkMfyC6AuyoB61Yj91fWEO1LMbTFJOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234617;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BEl+L8NJ9Qmwwtf8B/hCyQX7FAPLXL9PcfseCEpgh+g=;
	b=waktSlhNTfZEJTfjtePCRbs1yzLSASzAnMocysiBT5Jgnm83HwVYRLGgtgPVEEV3JS93
	 +V0dNoJJejnWHvzaRDWKarIMUp0TBTLgZvdhqFMMw65W0n+6jyWnfn8RRBjaIPR7mzHj7
	 EsZkrixhivrioz0IN73BixejRJz2xfwZW+GjW7shr4T/KXcSwjOAHzIp1u/4gtfKtqtDM
	 SD/AJEVzfMtscp874fziAlplFRLKCe7MlvLvaniF/CecxjPgPukDsc5oGXPxgo6D26RMb
	 4gvr0iuMhXTbq7OdEn7W1FhWFqtmdUVbV9psqWBuhRV3CnC6GZpp4BYQdHgGHHtp/4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QG6kwPnH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D4606A339;
	Mon,  9 Nov 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QG6kwPnH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5074C1F008A1;
	Mon,  9 Nov 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234616;
	bh=BEl+L8NJ9Qmwwtf8B/hCyQX7FAPLXL9PcfseCEpgh+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QG6kwPnHCV1z2vqbHuc2U+61eVdTqvDY8AXDs96jZUvvDvUF/tygYDemhRQWgZGPm
	 4RgjsPVWczQp5Yd8/dHb4xW4s31q2SuYI2pquhTSyr5wpCkpaBOs7vdS/oQ95Dypkg
	 WhoA53HH+BwFHv/QwJ1c3xJssvZeEeWtHXr43uFAxEOXtSPJ86JYbLVr2fLpcdE97j
	 3Ai8EJjqYW5VJg/37mOQUsLYEmqEDNrKLeDIp6SE7sE3sDYuOp3mQ9M5JUKVYRzOMm
	 Wzfuk9/cpo1gTHRTxkLgp1dFiggSIFtZfERr/4bN3IRSEn+kNR7bIxv0QdmCVksmhm
	 4zLDvoqgUK7lQ==
Date: Mon, 9 Nov 2026 15:30:08 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/9] device property: provide fwnode_property_get_names()
Message-ID: <avHXwL53ClRQptIh@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
 <auug8QoQ62ETGg1D@ashevche-desk.local>
 <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>
 <avG8MITPLRuFcZdO@devuan>
 <6b7uxzbhrce55f5bgkvmg2r2h4ax4xg7le6vxkhzezbsef23gq@ojm3wm33v3xn>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="em4352y5go3jlcfe"
Content-Disposition: inline
In-Reply-To: <6b7uxzbhrce55f5bgkvmg2r2h4ax4xg7le6vxkhzezbsef23gq@ojm3wm33v3xn>


--em4352y5go3jlcfe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/9] device property: provide fwnode_property_get_names()
Message-ID: <avHXwL53ClRQptIh@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
 <auug8QoQ62ETGg1D@ashevche-desk.local>
 <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>
 <avG8MITPLRuFcZdO@devuan>
 <6b7uxzbhrce55f5bgkvmg2r2h4ax4xg7le6vxkhzezbsef23gq@ojm3wm33v3xn>
MIME-Version: 1.0
In-Reply-To: <6b7uxzbhrce55f5bgkvmg2r2h4ax4xg7le6vxkhzezbsef23gq@ojm3wm33v3xn>

Hi Bartosz,

> Date: 2026-11-09 13:59:05+0100
> From: Bartosz Golaszewski <brgl@kernel.org>
>
[...]
> > > > > +int fwnode_property_get_names(const struct fwnode_handle *fwnode=
, char ***props)
> > > >=20
> > > > Triple indirection is rare. Do we really need it?
> > > >=20
> > >=20
> > > I don't have a better alternative. Having two functions: one for
> > > counting the names and another for retrieving them into a
> > > caller-provided array is IMO the worse alternative, so I'd keep it.
> >=20
> > Would it be possible to return the pointer, and then pass the count as
> > a parameter?
> >=20
>=20
> Is this really better? I think it's less intuitive than just passing a
> pointer to an array of strings.

Returning allocated pointers has a benefit for static analysis: the
function could be marked with __attribute__((__malloc__(deallocator))).


Cheers,
Alex

>=20
> My personal preference is what I did in v1. Unless there are strong
> objections, I'd prefer to keep it this way.
>=20
> Bart

--=20
<https://www.alejandro-colomar.es>

--em4352y5go3jlcfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrx2OoACgkQ64mZXMKQ
wqnTHhAAq9lr9inrO5+sbViAOboiBTG49DapuOkHoOD6fa3GmZzqB6t050vFMegQ
ip6ErIBH1WtYWiuJbOWJ2x3oThL37chjBeuAFBqVQz+74+YmDCdL/bTgS6akJGuz
mUtyEyT9FEFl1/vL6Fwh1FTl0rkwQyKth5yDY9AYltGEIk0/qeWxwcI45UZaCj9X
08g6t9oMseT06Z5AvYrYvm541WFNMqU+VMGKdjePlMvzl9thd61OCqLAjxUaCfBy
a8H+5468dmxXYLIgOodscuPVfEBV5+3EJlsUsPWMkOxXnuJmM7OOwaJWNcJbKLSW
stG5oG9x6No9YXTiu6Wnk06lzxHVunq42vMcMysrmHti43+ANa/5I5bHuo/k+m6i
/h+6U0tz6ovdlD4P3T8K8OrgAlKYdfdM4Hw1FGC5OiGmH/WwtTw8IWw0jKk1QG1q
fXFBQlX3PKLpohfC1n9kC82USb4VoDsyL7XRQExyufCcEFf4UQvKj91hwaj7hLK5
JE3OkG2r8ieMvAOGQJy/oLZAVzirk0afGqca/wQhKIbxM/84+Sk4lBx6tU0vI0+G
DqCoqWzete1HHh4djkwghdvr8dS2S+YZCmNRWnaSZtFz6qS7ue5Uq/lEWmLGCnmq
xoLhW7oizyJZ4TFC52wBvtvxIQ8zP4RpHbCLBQp2K6kVsZqrQ9E=
=HZPM
-----END PGP SIGNATURE-----

--em4352y5go3jlcfe--
