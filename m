Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427656;
	b=f+W6UivBapi3PTOsyFVj4Af+0zeJm/YsvZa1kr7W1a2bADmLJuPoYnZCJKA6w+SQA2ig
	 0zln1oYrv4oTB9Fkm7VgRGRzEleaxYEU1UTUZmItXquCA8Pwm580YF1u7A5KZ1cgUy5Cr
	 +flbkztsod90lZYQ1d4Mudlmgdl/940XDzWcL5aOI/yuvu+lWvXGTNW84c9p7lxqp3Unj
	 F73gbhTFGgMtA0ShPfYqEACYdI6WHEkNAIlFO2IXkKT1XZErWqX4h6Ux6vittKajls00/
	 nKSlSQHQaD5gEjj2fuGUSoCAdc0dj/5WwmbpefNwfjtvs3Zys4P399ZJRhsWNUEchmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427656;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lXweVJ/XkYgJByHlOBLO1riU9AfOcOECoeF7DgHtmRM=;
	b=Rbaz1awmrdgkE4WIbgI2GHvSn0w/SimO4xLLvScJDHPpPFzC2JOe40AwDTk0D2e6qzaE
	 yQ1qfIYgCaKlDix6LQYUcyw8YBl8WnbdFTfEO0a/iBIOWAEfhDqJjn4nmdWNq1VM42+LW
	 L6R4G0ns4ke2VMNB5q8RpjivHzjUvR83lUxf1fi+GtagiDlxjaDOD/aol03IM8cYkK87q
	 c0+bo3pkpezv4bGRBrYAEYMwIeBApNB9lm7SdETjanzDqKrCczL7gyLA7fsU4ugjGYRSo
	 JTHoClGrsjfjjC1UN2cu0NhNlWVmmVFfoAV/XgPhWigXb2tXcAvY2GzXls2qXUVqcXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3jStdQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15663606A31C;
	Wed, 11 Nov 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3jStdQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A2B1F00A05;
	Wed, 11 Nov 2026 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427655;
	bh=lXweVJ/XkYgJByHlOBLO1riU9AfOcOECoeF7DgHtmRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a3jStdQb8/c/hsEUANdapn6XLJVc0QouxE/0Bd2EQmoOgr2pwgQ405FnlumJlB3i6
	 9UfMke040DZ8M6CvO4Mxzym6xqlRSpVJK5WvK6Ko1MvpCW6cNhazXetv8VYREJiIvc
	 g2i9w6RH/EU6DM+wKDYoc9+441xOIYgAYL4nEhNfQ0wMl8VTwyldPpNswAvUBwaM5h
	 191NXHr6hp3+AgRHIePTss5zmdtVZzOqIngtQ3IaETLlgyBIf7vbjNHoNDZoqHTSNF
	 AXJS/Q4XY7MlTIn9gKbV8IEw/U9Cclqv6aDQWNbQPukU414iQqXLHDIOdYF94Zk/aF
	 EdPUE7qnZhC7w==
Date: Wed, 11 Nov 2026 21:07:27 +0100
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
Subject: Re: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <avTK1lHYJhn_rozA@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1794425425.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ykipaqb2ba6zydjw"
Content-Disposition: inline
In-Reply-To: <cover.1794425425.git.alx@kernel.org>


--ykipaqb2ba6zydjw
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
Subject: Re: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <avTK1lHYJhn_rozA@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1794425425.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1794425425.git.alx@kernel.org>

Sorry; I forgot:

v1: <https://lore.kernel.org/linux-hardening/cover.1793876837.git.alx@kerne=
l.org/>
v2: <https://lore.kernel.org/linux-hardening/cover.1793882260.git.alx@kerne=
l.org/>
v3: <https://lore.kernel.org/linux-hardening/cover.1794323750.git.alx@kerne=
l.org/>




--=20
<https://www.alejandro-colomar.es>

--ykipaqb2ba6zydjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr0yv8ACgkQ64mZXMKQ
wqkIeQ//a4J5GAtKXiDtLIFbagGYLZ60kDEveljZEfxDn8dDW77FmdAJVWYX/h+1
Ti9OOO1q2zGR7wXuPy9A7aKhxlveKpvU4ppn9XsvrJjHW6TTkWhXqIg2QQoHWddI
xOrgMD8cL5WFVeHRH1/DanJ24G1rnidMIKKod5AKrmZSTIqNGodL+k2Xqg7KxGeq
v05ct6hAu7fK8O3ox2wx2vjeyvACQqhYKEoOCnn0GcMaiHjLyQpGZ935eOvZ4XTB
ANiXfu8o6Vp8Pa6/rh9657abKTFimI1YDaiYLsg+9RMTxizD8/UxL/pdCiFnWIh7
NXj5o0TfBa2hkZUADVO0gJy7r/0nXkGEwCADnqyUyd6szNfF5pEGQfp1Olz+EZnK
NBH7ez8YS172iAbXA1ih4384TtrjERZMEYeqbOJskGkXSe0jesiNK7YRCA2bgUTV
bcgEeTF2x/WbmpA7S5uPoUxsiuiT6wnb/XtVrOj0Dlqy2YNn8BhQVLrV9OT2eE1l
wZ6Rus1rRcqawvnXF+iYHzG25XGyfS5Iza6XTsdYQdyBIKWLe4dlM3sR/8fjGV6a
wWfMsktGOgNQ1hNEq3MCHHVxgNMxau7mGL8RI0h4GavjHlarzg84dzX6WSFy6sWC
kngzqtznmLFd5S2+aOCiRk7xZgydUbzPZMb44fXDUlOqT3KA3Mo=
=YTyE
-----END PGP SIGNATURE-----

--ykipaqb2ba6zydjw--
