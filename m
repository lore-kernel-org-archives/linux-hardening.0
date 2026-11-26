Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729879;
	b=Iru4q4GHsVOBuhq6caQWBqptoi+L0yS1PjAStgmUO9YMFz49HiEYmQUmEeVpbPU4CAWO
	 ee84u4pANeziQtiS94c9D7hWuMSbfF217NtbT2Kf8jUGx4h+XQS3FKialFiKc6xwiBVjN
	 zfqjR67UegUy08/m11eHhvl7ZJe9FY1yDodQV4aLeijUg4GaeFwtZQAB8Mdm8ASDmd86f
	 AE1Rs8bnosm4CfkC8LQ614gSjCGDAS6I9U39V49ZM/wBfHcyMWt975JZlMmfkGvnieEVZ
	 2BE4w7u/X97pnUNOQcbyHQ5ES8MLU7IraQooGLDn+hrWrkBElaCmCcTYKpNpLH3/u6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729879;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WbA+jsGv0wskRc45vxrESitu3ujSAtU/NZMKbke3qrM=;
	b=cJxX6PcQIJP1mPF/gMWeV/GaCqBnUjk1Hh7V8YzsHN/QVs3AQMFU+NfoP3HGKXsqYfOZ
	 wg7gsova3jnBVB5m7vcxXTowKCIPPHfpndLJjm8rxVfV30jIaMqLW3LGFt+ns11VfIJ3V
	 zd24PYezo9F1in8p2Wgq801OUZAaU0B2YQpHFiNpeCvS9bQmdB2bCe/TYcSGW0yyKdvpX
	 us9+oRdN66l5juHy1hsKzk9o3VMuqFHGcqtlLopiSNY4EPwcJtxZUF24tx+CowrmRCGHY
	 fA45diN1mVbEA+blJDflWICdrnDAZ8yb4XQhI0Tl2YkBy2D3Ury6ndZ0mXJYBCz+MRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioRGYjCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51208606A31C;
	Thu, 26 Nov 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioRGYjCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B6E1F000C1;
	Thu, 26 Nov 2026 21:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795729878;
	bh=WbA+jsGv0wskRc45vxrESitu3ujSAtU/NZMKbke3qrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ioRGYjCY51cDGF73s01dz3ctyFlRMSE1xVp2PsV2uUvfzrQ8DIWl/XcCCl8GFjSYJ
	 +32Smpr1Mie5+3Q9CSky9lH/GV3gGFVvP6V4rh8cMDW1pnuRy+UcpOlRSHyrFpdQTK
	 uiPwpubNBNbSNZ6tFE2j7YhG6p0TEyLra8g1hI3boBQq9c/0laAP+r6pO2u03UKBpU
	 oyA9QroDaQBH1HQKs7qvkaVBknS7XyOVA5QyNzxHm6xmhr+FmhHvfDTEpIa02thkOO
	 TrephghAEiEJJILokwwBZOPn9mF/BJzfdI6jCZ1rENGvvbw7GcZkgVUlyh7TSUyqB/
	 ZQWT525IgczlA==
Date: Thu, 26 Nov 2026 22:51:11 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Add strprefix() and fix a bug with it
Message-ID: <awipprsECiIWE6US@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1795695151.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="jfvf2jdenz5dkrbl"
Content-Disposition: inline
In-Reply-To: <cover.1795695151.git.alx@kernel.org>


--jfvf2jdenz5dkrbl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Add strprefix() and fix a bug with it
Message-ID: <awipprsECiIWE6US@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1795695151.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1795695151.git.alx@kernel.org>

Hi,

> Date: 2026-11-26 13:17:12+0100
> From: Alejandro Colomar <alx@kernel.org>
>
> Hi!
>=20
> str_has_prefix() is based on sizes and lengths, which means it must
> overload the valid length 0 to mean not found.  This is a typical
> consequence of choosing to design an API around sizes and lengths, and
> vanishes when moving to pointer-based similar APIs.
>=20
> According to its author (Steven R.), str_has_prefix() was never meant to
> accept an empty prefix, but that's not documented, and there's no
> obvious reason why that would be acceptable for a generic string
> function (as opposed to a function very specific to its original use).
> Anyway, as suggested by Steven, I've added a WARN_ON_ONCE() to catch
> such uses, and also added documentation stating this limitation.

Oops, I forgot to update this text from the cover letter.  There's no
WARN_ON_ONCE() anymore, and it's instead only documented.


Have a lovely night!
Alex

>=20
> If the function had been named something like strprefix_len(), that
> design would have made sense, but being called str_has_prefix(), the
> obvious way to call it will result in bugs, because the name contradicts
> its intended use.
>=20
> Users of strings need a function whose behavior extends naturally to the
> empty string, and we can do better, by returning a pointer.  And indeed,
> users have ended up using str_has_prefix() with empty prefix, expecting
> it to work (as is natural of a generic string API with that name).
>=20
> This patch set adds strprefix(), and uses strprefix() in one place to
> fix a bug reported by Bartosz.
>=20
> It also adds streq(3), just because it simplifies the tests, and is also
> a nice interface.
>=20
> This patch set doesn't include the sibling strsuffix(), and also doesn't
> replace any other cases which would benefit from strprefix(), to allow
> merging it quickly.  I'll work on a follow-up patch, including the
> patches from v6 that have been dropped in this v7, after this has been
> applied.
>=20
>=20
> Have a lovely day!
> Alex
>=20
>=20
> Changes in v8
> ~~~~~~~~~~~~~
>=20
> -  [*/4]
>    -  Add Tested-by and Reviewed-by tags.
> -  [4/4]
>    -  Remove Message-ID tags.  [Andy, Geert, Bartosz]
>=20
> See the range-diff and interdiff below.
>=20
> v1: <https://lore.kernel.org/linux-hardening/cover.1793876837.git.alx@ker=
nel.org/>
> v2: <https://lore.kernel.org/linux-hardening/cover.1793882260.git.alx@ker=
nel.org/>
> v3: <https://lore.kernel.org/linux-hardening/cover.1794323750.git.alx@ker=
nel.org/>
> v4: <https://lore.kernel.org/linux-hardening/cover.1794425425.git.alx@ker=
nel.org/>
> v5: <https://lore.kernel.org/linux-hardening/cover.1794574496.git.alx@ker=
nel.org/>
> v6: <https://lore.kernel.org/linux-hardening/cover.1794667407.git.alx@ker=
nel.org/>
> v7: <https://lore.kernel.org/linux-hardening/cover.1795639368.git.alx@ker=
nel.org/>
>=20
> Testing
> ~~~~~~~
>=20
> Since there are no code changes since v7, I haven't tested again.
> See the link for v7 above to see the testing of v7.  Bartosz also
> tested v7.
>=20
>=20
> Alejandro Colomar (4):
>   string: Add streq()
>   string: Add strprefix()
>   string: Document corner-case misbehavior in str_has_prefix() for empty
>     prefix
>   device property: Fix fwnode_name_eq() for empty node names
>=20
>  drivers/base/property.c            |  5 +---
>  drivers/clk/socfpga/clk-gate-a10.c |  2 --
>  drivers/clk/socfpga/clk.h          |  1 -
>  include/linux/string.h             | 42 +++++++++++++++++++++++++++---
>  lib/tests/string_kunit.c           | 22 ++++++++++++++++
>  5 files changed, 61 insertions(+), 11 deletions(-)
>=20
> Interdiff against v7:
> Range-diff against v7:
> 1:  ad8500a6eb0a ! 1:  8f3840fa232e string: Add streq()
>     @@ Commit message
>     =20
>          This removes some driver-specific definitions of streq(3).
>     =20
>     +    Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
>     +    Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
>          Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     =20
>       ## drivers/clk/socfpga/clk-gate-a10.c ##
> 2:  b32d70163fb4 ! 2:  a688f0a1c20a string: Add strprefix()
>     @@ Commit message
>     =20
>          Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-=
for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
>          Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
>     +    Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
>     +    Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
>          Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     =20
>       ## include/linux/string.h ##
> 3:  c4131a109098 ! 3:  fb24c7a543f8 string: Document corner-case misbehav=
ior in str_has_prefix() for empty prefix
>     @@ Commit message
>     =20
>          Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-=
for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
>          Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
>     +    Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
>     +    Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
>          Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     =20
>       ## include/linux/string.h ##
> 4:  396395e1d02c ! 4:  5c23d229235a device property: Fix fwnode_name_eq()=
 for empty node names
>     @@ Commit message
>          Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-=
for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
>          Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
>          Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>     -    Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
>          Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
>     -    Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@=
kf63j4lb3flk>
>          Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
>     -    Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@=
kf63j4lb3flk>
>          Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     =20
>       ## drivers/base/property.c ##
> --=20
> 2.55.0
>=20



--=20
<https://www.alejandro-colomar.es>

--jfvf2jdenz5dkrbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsIqc4ACgkQ64mZXMKQ
wqmd1BAAhioU4qXCSPoC9eZ7SMmdqAx2ab3diOPWpJM/5zXgoA56mQKCcP9AnyAj
/dzdZDy/pPDgrPCuPv1R/EXpfozRg3CNg6cbwb6iHiv919mLuSQClY0CyFKGG3z1
H3/QUnNgbtUE0ThoxTBWUKKR04vtxmpjzgNthSccPZwRMzlocCIdNwKPEAVGs+S+
Z/aHYgY0DfIYEVvXiAGQo2dgvfMhHQbuW038Mxi3NrhAvSxoMN13NcjNiSWOWuQQ
+FSyJtRA4/d+6rbiP4/JVcWUL7ErPcU6Cm9MEmCn9D+hVVWcTQ0VWxjUASEqzLgb
XFitqqaRhGwafYmNTF9f1QV/StqUebcat4BWiJGbmEl+E5olgxKryVB+As4iPdm1
qcBXZZs95i5KJUg++OL1RYWvsws8cQ/D7qYQXl+gz8rO79+dM7Ccha4NA/TurEgP
4GpIE3ZxNnJ7Wp/WHFozZD/Q0sWLGFcci4Tju6m7vu6S9wtbGRk5G2ryAXapwJaM
5wl/UkTGiknqoLkMQRPrD06exME6i/e8MOfjQdLAYk0wyAipxdvYtfpju86iXC6d
5I+tA2NRn6M9hIZr024dm7Mr1PEkcwW1Mh+ysZp3rWXM/VM0wW2oBxZM8XydZgPT
DQB9VafJKSDkVr3pdO6uR3P52Q6cjyYAT8QfXqcP0pH5YRLxUVw=
=8rG6
-----END PGP SIGNATURE-----

--jfvf2jdenz5dkrbl--
