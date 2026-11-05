Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881728;
	b=lxLcaEc02ZTLggz9PbVJOoINvoiTwTkuM0DgNiRYnJ4QhDsdtxGyWa2mr7/XrLYU0nVR
	 Y0iyatiom98pnFixCcuyShNQSxa7vQblxzcjhjVARZfkVKvlETajRXYI2R4qtCtOX7HR9
	 QAnPJHlKissbWfSqDsGYhJKnVT3oqPNY+Yuluar5NXHRhtsRKL0E83xFvX8BjzfR1Vp1x
	 m05HjPPZBqcFmLeMxP2FumZpCcAsmg7ByedMiOYZHowcC1+GTFjFEzDs70jTqQuvoR/X9
	 7U+O4aako5d4qGEgtbNpe48s4x4ss+w+p2RI+mkNajTpdo8qyaloL7pHIVJNclgzh+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881728;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x1XJ/jEjgFqTAPzVVo351o8IaYkdQ0sV8TwMGCEATU8=;
	b=13bHMb5J/Ibax0TvO1QjnYHpFrU4NKUVeWKSrsTM+vnXe6YP+wNY4OuDPFimkBHNy5Gq
	 G7asX5WhHdgy1UH+lVXMcN2rTKgnX1Z/f2V8MEtXx26vuP1q8vBT6AJfKDepm6nlOn/UV
	 GYsQkCXM0uwxqVDkm8/CvPKAoF/PzPEdYazj3jrVUZ2Ki1Hlo81HcCOZoB3H8Yk/2qguQ
	 iQugsOFo80rdYWmdMPqCwNtuGDJ2iwyuHXFRZbPVMsFdcZ1ilzfBdQxi1Ezt0DdT97vBt
	 Vb5cxPSa2YLkuFFeVIaTB+JZ+C7fejuUrphsh1MtMa7pgQq0FB0PNbNe0yDtaKHF0jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A96V+hxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B756606A326;
	Thu,  5 Nov 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A96V+hxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FE41F000C1;
	Thu,  5 Nov 2026 12:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881728;
	bh=x1XJ/jEjgFqTAPzVVo351o8IaYkdQ0sV8TwMGCEATU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A96V+hxixBlQj/Nge02JdbafA8kB8Ax9X8TxvrZCtBuSwbEHUoP5/xJ8+uq2GaGpm
	 ocdccQSSaf8S/CHqp2DZoc0EDb8gcgU2HaWZcp5Rx8p5HeKFavoG9M2qajh4WrkWIg
	 sbygSSOwjvahIqhuzCqO8errwvJJSBtYhw3dReIVCRei0IlxLb18pdP5L1GvKVAhDi
	 4KU6hHf4hvl/I+bS26EDNemGY0MzT5EXvzwcBnHmxQoTbBPY6s/J6gybkkXHb96Izj
	 MDt/J608l83w+0PY/0V2INMYq3bTjv9jCp5oFibm6wYONLJ5jfTb1yGg8iu1uBfed4
	 5F/1PgFtBDAPQ==
Date: Thu, 5 Nov 2026 13:28:40 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <aux2SQeWcg1PAsna@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <CAHp75Veb=TsXJcjqQeD3ciNGRvLebGr8t8TnZju6FX5ANeVNTA@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="ztgabi3eeqld3thq"
Content-Disposition: inline
In-Reply-To: <CAHp75Veb=TsXJcjqQeD3ciNGRvLebGr8t8TnZju6FX5ANeVNTA@mail.gmail.com>


--ztgabi3eeqld3thq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <aux2SQeWcg1PAsna@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <CAHp75Veb=TsXJcjqQeD3ciNGRvLebGr8t8TnZju6FX5ANeVNTA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHp75Veb=TsXJcjqQeD3ciNGRvLebGr8t8TnZju6FX5ANeVNTA@mail.gmail.com>

Hi Andy,

> Date: 2026-11-05 13:27:15+0200
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>
[...]
>=20
> This list is twice as long as the commit message! That's why I highly
> recommend moving it under the '---' line below. The email headers will
> get all the listed Cc and git history will be clean from this rather
> noisy list.

Oh, thanks!  I didn't know git(1) would pick 'Cc:' under ---.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--ztgabi3eeqld3thq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsdnIACgkQ64mZXMKQ
wqkrWRAArC3jH5dRrU1V1wAcbh/CM0P6WPacL4gRihfKLWTWeWd+QsqmYNQBSakc
oYVbtN0TJ31WSV6qX0HnCxeB01k8pamzmcV9H+Wotq+jPf8i3ZrjnfZh9x7C/Ozz
wPYsX2SbtKNr8m9dFDJ5yR8rrFtKAnrxjvx7h2wIxDUBaAEnVj7HZDeXxg2epkG6
z2aGLR9/MtJVAPoRqibeNTspsNcOWUVr+L2p/FIWGWo28uH7ptQFprfgnu0QScDY
PJI9J75BHX5Nh9vcXha8h9Ft/6IFbaac/u/1IWpF2lytCOcjSpKxoGzLc7mnFn+k
6B7rAu+Y7VA5J6TusxEE7RDn9G/drM9mz/gb+I3C8jil/OVfZcgfmC0WBE+xaAnF
O6TznK3ltNCM+UOKmlCIxyUgkaJ7KbJFBAg4/M40rGCtcG5AGBZ/fSV4B1yG51u8
dh47P66s1KzsBHCteA+xCGxfvAcGh5kiQkqZv3pJfc5/xVMmiRwsvTBUTNYuLeWw
9oUd4snWoK51pLM9XEja4+dPCIqj0334RoDP/nPsj0eTAi2f87oVaBDjQt235yJP
2CIVER2N4PVBWIr/nWGps8ojtGjq2KRurLJW80RlsotgwQCvMw7GypaYiXp1vbVz
kiGwbVzT1lhQZAc3wWi/v61q0AsDN+WrIGhgiyVjqBAkR/Uw4hI=
=4yBI
-----END PGP SIGNATURE-----

--ztgabi3eeqld3thq--
