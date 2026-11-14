Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675824;
	b=kS3CmahNVnkE0AMnebwRktE1Fsr8gRMi45j5DGQPlIgdHCLSIZ0L4DVqypkkJpyLg4EG
	 o7lA0jX3TAmBPPFuP3T6+Yx3G5aYx1yJZHqLixsJ+xa/xapGaCRcwLKu+2XfZON4FuLhY
	 h3tVAD+k6d8ddjNjp0qWqTf+l2CD+J73Z6yxOrgsN02V+vvMLsYv6fxGrnl6SAWocCM02
	 LEP9cHfI8JY9JqfjGn6ApN/8rBIbPTKCNucLNi3kXYy4wmB+vkPEVH6TT50EvXPx6VWdo
	 uatxcDWSs5CLVsiP7b6lglJe6PjWwVxt5+MxRb5Ij21QxpEqe5oo61TgtqGGJLebltA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LleCm0FKoePUE7q3MO/5peHKV2q7rvd2yTLayAa69tA=;
	b=4KYfyoAlnaf3NWDAI7kTz78Ll19nazNlFWSncOa96gFNCM1m5a2d/4IM4UgXsy3qMSG0
	 rIhb18eeLdKYdl8ljGekGDPaDW8cKXLI/C7+GsVPd9kcAMF/8O7CSQ2ZL/YWLA1TbAzOR
	 7ixvC15PxGBQ4CEdh5ReI0p6me+jTnNunrz99zlfZrjHUIwaVTEGnH6GvMUiRK34yrIZg
	 HPJlRpy0O56V3Pba6PyMLJqeGpm6FusBXrO0FhM6/fVU/abMToMF/PuzW5wSTlaAHXKSY
	 Abung+aATjXa+r//gl+he680+x6egoo5YcnmmDMcFBM9R4Sdkwh7rjgAL+pTEId5p6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdWgrot+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7D606A327;
	Sat, 14 Nov 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdWgrot+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570BF1F000C4;
	Sat, 14 Nov 2026 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794675824;
	bh=LleCm0FKoePUE7q3MO/5peHKV2q7rvd2yTLayAa69tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BdWgrot+GEUwBNsPzIICuki2vXgswrF5u4qhgMQm9EgbWR74ch47A5ubZz445ChdV
	 PiBACIzGj0tbIkEEmsOE6TVvWr1+aSue7KsqjkI1bLqvJQPJ30yopKO6uJ1iAAr4l6
	 HsjQhgUYTY5SkKPV3vyNSuVTuDjhX3ZvUo4y7CwThIYOXWnTKZ1pxOUAgSQP4fOBRb
	 vaeYoWGPLpwqDOkNksDCVsbOyrq5hbFfLHyiUqJq2zzcuGzaEVSZxzKteR3vLRrn6V
	 R51Zjo7moYhtV0/8L3Qjg21GOI/vAJAlOntigkirr0t8O84ra7Uu+OBgNJfsvhhNUd
	 SDw8BHeuN4QGA==
Date: Sat, 14 Nov 2026 18:03:36 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
Message-ID: <aviTcYS995cB-lTY@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <6de04b9cf2dfe9ff1dacdddc0a76752a714a991c.camel@perches.com>
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
	protocol="application/pgp-signature"; boundary="dnrnpq4pdqknn6vy"
Content-Disposition: inline
In-Reply-To: <6de04b9cf2dfe9ff1dacdddc0a76752a714a991c.camel@perches.com>


--dnrnpq4pdqknn6vy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
Message-ID: <aviTcYS995cB-lTY@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <6de04b9cf2dfe9ff1dacdddc0a76752a714a991c.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <6de04b9cf2dfe9ff1dacdddc0a76752a714a991c.camel@perches.com>

Hi Joe,

> Date: 2026-11-14 07:28:23-0800
> From: Joe Perches <joe@perches.com>
>
> On Sat, 2026-11-14 at 16:22 +0100, Alejandro Colomar wrote:
> > As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> > between an empty prefix matching an empty string from a non-matching
> > prefix.  This is a fundamental design flaw in this API, and not
> > something that can be fixed.
>=20
> I still think this description is poor.
> It's neither a bug nor a flaw.
> It's a design choice.

As explained in more detail in the subthread, I think it is a bug.

If the function name were strprefix_len(), it would be a legitimate
design choice, since 0 would indeed be the length of such a prefix, and
it would be arguably useful to return 0 on a non-matching prefix.

But the function is named str_has_prefix().  Since an empty string is by
convention (strstr(3), etc.) the prefix of every string, returning false
is a bug.  Since the function returns 0 for such a case, it misbehaves.

Perhaps we can reach an agreement if I prepend this commit with one that
renames all uses of str_has_prefix() to strprefix_len().  Then, I would
agree to consider this as a design choice, and remove the text above.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--dnrnpq4pdqknn6vy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4lGgACgkQ64mZXMKQ
wqncSRAAoVpZLVtleFTnY0aEZEyyD8Jem8uGtog2B9sGphpZJlQsd8AUAyg5/N//
b2/gMy8/ta8bSyVUW13PUj9BzNQzok5II1QFD9rWc2Xig1SJwHiEIVUrsAFjoCLe
DsD6WYdNpf3FC8olZyDshH9ygFzD4RCDq7SvPm/ENY7AxejQrGHeeyDI6oxh3ELj
Ecb87Mv7dmwGc2jYrW0PQfn9L2GedPvvtaPmuFNUwbjzbhzaYJr+9demRmyNE3jn
qIbhoWyO971352U8n4LBWxXBOiJMdl7dQR8AIZF8l9AhfsM90CDDbuoepoS48I7r
FpzKIMKxYQNu79Uh5W6ePzIMERxckgQ5uOXXTYggy+8ImXHixLJeatAYPmI8p41l
gMBhICxmsSsvtIaOKvwsr5GFStwutEAaxXDftjJShEG8Dsmouvc+odugJmOujEpJ
wz9P2br1Nzppcu4gILaTq6tHcHXQs1BpU4z1G1eSdTJIWrCjZ1li6mlKeB4+kmqL
i24XfGQXStDZtL+iVbEt+fYR4c2hRdwYU+pp5D+QGjmnvdPa2Yf6lyJiUH6Kb0K9
0nRbH4LuzQGnEJk+NfyCLNqbYz1I2XzVq9qZA+rl/Qfe1iNIz27RpqvhRXAlmVSq
NfGzRjZ7FiI97GL3+lOYGLp2KPW5GICIKxxuxWhUmZ7zBTeeRmw=
=vRWi
-----END PGP SIGNATURE-----

--dnrnpq4pdqknn6vy--
