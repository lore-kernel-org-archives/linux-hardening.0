Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327255;
	b=oM6q4e3Ni0DWbDQ9VCLc8K8pSyAAJRg7CijSc2GbneXwaWT+lPWAG4v/PvbnbCZFjNOb
	 xKad3P3ybB7pMsJDOtBxOAcGzDvG0dw3KTSfuJ6zIgMs4mYAawvGrTbQG0zQYQzPWwnxF
	 zlG8BfuS2gk6gkG8Ks0khHZ6Caha+P7ow75PQavE8q9xRuuaL+C7uzcim514qI39OoTN1
	 LMOhX2HKj772F+mG9eppWSOEWbeVRe5kWgglfK/kVFcwczvaIQ49WyNpl/TL1sBGbwcEw
	 Pzp9BXSW3NZO7tKphHtBJ4y1cHrpueX9iYNQGl8S5aYXZ9rk/x1ZWA9amc+AcUtSCmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327255;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=a2d/fBfzfFNSaTFIalghXmF7Nmh1cwB84PjdUqrUwow=;
	b=5W3kgm8av3RSD18LPCL+7ym100CwW71uMfhSpH5uINe0Nu6KMUEeOaIwzx9CTGviXktL
	 qHPn48YFisLtK+9mn1dL0W6fyE2qxIYGNfeYEjXQB/6qL1YZJzIPmf63IvFfmOQjUAFHR
	 AXN63WTPXp0m0knkGiYg2RKYwlD4dxcgmpmnuKstvtJgMUOsYNW/TSWMB5yAycCjmUQ+L
	 nufcoldT7CerCHVVq6AyAW8Y5Tw9ER2UF42dhhSZGZob6w8wGrUhpezujdxpVUFYvdn95
	 2E6Ys/HLavW0ckef/1iJIaqVuiuRehS8jfsKQyp77WGNonXF640jW4+eebnFgzEepAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ab06j4EB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD5606A326;
	Tue, 10 Nov 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ab06j4EB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C847B1F008A1;
	Tue, 10 Nov 2026 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327254;
	bh=a2d/fBfzfFNSaTFIalghXmF7Nmh1cwB84PjdUqrUwow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ab06j4EBUjZ+I1S1yBO2pSb67Qh9FrF+mRBi623YxyIQJdHvKj8/hKxJ6AToz63uF
	 CQmgrkwCpgpk9UPECCP68pkPAt3CIGH61Pp5zRTVYQLxplg1lb/h3WlIKhMIxrgRD0
	 2Zk4bIzZfy0TFiS6dNEdxGzk7Lqy7xk5BUq4jNCVLPq0m0Kfi5SM8XUCJOxIpu68HQ
	 f+w5nXCIF2afv98n20t9bLBX+sYXVQTnKuzBIJYXg8sPe3MR1NiVUjAm6E1LvaZ5Gd
	 IU2DODwMwILlW6MHbuJg1AX13CqOwS8SEZ3T9g+eIodWABWWc+lprmxnm7Kf2CIQcA
	 4WR5drvhOFJVw==
Date: Tue, 10 Nov 2026 17:14:06 +0100
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
Subject: Re: [PATCH v3 1/5] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avNCY5ghSn-M8oqB@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <556766412884389a7cecfe6affcc9fa3a78f9807.1794323750.git.alx@kernel.org>
 <e7b48186a65a759935fdfdc2003b266d05ee2d4c.camel@perches.com>
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
	protocol="application/pgp-signature"; boundary="6az5minxxtrwr4gt"
Content-Disposition: inline
In-Reply-To: <e7b48186a65a759935fdfdc2003b266d05ee2d4c.camel@perches.com>


--6az5minxxtrwr4gt
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
Subject: Re: [PATCH v3 1/5] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avNCY5ghSn-M8oqB@devuan>
References: <cover.1794323750.git.alx@kernel.org>
 <556766412884389a7cecfe6affcc9fa3a78f9807.1794323750.git.alx@kernel.org>
 <e7b48186a65a759935fdfdc2003b266d05ee2d4c.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <e7b48186a65a759935fdfdc2003b266d05ee2d4c.camel@perches.com>

Hi Joe,

> Date: 2026-11-10 07:47:55-0800
> From: Joe Perches <joe@perches.com>
>
> On Tue, 2026-11-10 at 16:33 +0100, Alejandro Colomar wrote:
> > As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> > between an empty prefix matching an empty string from a non-matching
> > prefix.  This is a fundamental design flaw in this API, and not
> > something that can be fixed.
> >=20
> > As always, this is a consequence of choosing sizes instead of pointers.
> > Sizes are often the wrong choice.  In this specific case, pointers are
> > more capable of differentiating these cases, as NULL is a special
> > sentinel value that doesn't need to overload a valid value.
> >=20
> > Let's implement strprefix(), a function that returns a pointer
> > right after the prefix if found, and a null pointer if not found.
> >=20
> > We'll slowly migrate existing code from str_has_prefix() to strprefix().
>=20
> Most uses of str_has_prefix could use the existing strstarts.

Hmmm, actually, both str_has_prefix() and strstarts() can be replaced by
strprefix(), which provides functionality for both use cases.  It's the
more generic API for this.  And I expect compilers can optimize the
unused parts if actually unused.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--6az5minxxtrwr4gt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzQskACgkQ64mZXMKQ
wqnQMQ/+JSd+d9JXXdBlPNG7Sau+EnfWITQPtqNVph42m8pmt0QrtmNSgdOTgyRU
UJDFWdQ+pD9VzeNRedBQVbE/5zu0AxKunpKIM6aUGvl7UER57ZMKzR1gyHB2bY7M
FLd3hIfedcj+DfqqUzXUMZuf8D3CqQRlv07iy92PvC0ZScwyuGkI/E/r2cNQ+Exn
xk+2Ko1d1tvMspJfkcNtGGS3Nb5qrSpUXPK0+O6xXmHftcAAhRe5pESoiuymHtib
VO0+alNsE/U9qP6isgMbwxvBtO3KoCmZAD74eOg912eG6+yuJjgEg4YXDEVGWhxo
CRUjGaUVMBuTOq6HJyWwD4/kW3S9BtGnsDrUh2/xHtUMwUVQeiuxOTRTJMnlGt+Y
dNGV43DEQGatNPcQ6BRYiT8DAFmvRh2TZP1JHr6iJVWoF/Xv4iw+VMDyZPKd93wk
ygi6Ju+mF8TEOYuKaG+9vCpi3yIDTYax+xW7WjeIaVpqCI1P+vth96BocsIEo7XI
nqoha2jX7YdkkLNw410UrdEvyR5H0TdykNxHZAv6AT2xlkegEOVIrJKGdsVOf4+E
mH/FCJj8eLjYA+hQVgTR82PUnWi0kuaGq3xbU601GJdFnunqQ8oFqBipVftrEfhd
FoTAWprqrPzqAP5sERTQEy/HwnqrWfT5ccRo3UfkOy0IGoK84jw=
=Ddl8
-----END PGP SIGNATURE-----

--6az5minxxtrwr4gt--
