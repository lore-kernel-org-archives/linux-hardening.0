Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310426;
	b=XdYv1eI3/EI9fC2ZWSNQ9ryzaRmo3rMV3dxr9Bs5CRP4yWrcDMsyJvWzwKV28C3Ik1VC
	 E1Rm+w/37qSCh75MlhUt9PK+sd1BRktiABOEs7YKvL0z+udHOYlOz81XKNDpMXCrOImeX
	 t67ksVPXvL6ink5/eSiJ8rFFFAHziNDNcKi6fFKv0QCInBG8ck7ncCa8bIcQTJUC0EYxj
	 7oywxRU/D/j9XtK2DrZCOjB7/qbms7NgvkHdgedfMh1jSLJM5LawH9sjhQjlZCIpsWIeD
	 Ijh60GboGETiaTiH0DXT5ages7Fm/2anHT1Lxf5xlEurtW0ziuRtPfcBkBwiVr1R/8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310426;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qSyfjuA959utatcArln6EmhrXSRtAzPm1CEV93pQekE=;
	b=gX4URF6JTJXYS4NlK75BZ+/eazS9/N9aY/QtC02DdeSVBGY5nzypDg9fmeBr5HrPDtFN
	 AELSM4YVLxF3eH2aPu0/YnJj9QAM7B4KENzUQ5DV8g3V4RL4IXL8JIJDpdazNvoAfM3CW
	 XC8qZCyGK6SuSDmiY+8mbBWZxRek1VXDBBlZmFoc6o7Ko3GbVWK/p+kwBewuddM06M1yA
	 p0VYRzTL8ENi9x4TqfGI9nQaRVQn44nIqEgtXxd2wAx3HJsyIjluCbKypj9lk2ouXaSuH
	 y0JfgIPDDcTmgS6dA3stL1ynfmASS3wXn2EGStHFk/gWPvPA0gAcvK2E6G5C/63uKhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=du52QDeR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0495606A31C;
	Tue, 10 Nov 2026 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=du52QDeR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3E01F008A4;
	Tue, 10 Nov 2026 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310425;
	bh=qSyfjuA959utatcArln6EmhrXSRtAzPm1CEV93pQekE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=du52QDeRIFHy8bI+5Q47+XWXw3u31Siid62br2VzIibxPeafdZB4547fFTYXzom6t
	 +i+mAfRclnzFMs2I8AZd+5Qe4UrUoQIIreBpF998NZabjErKGR8hrtb0MSlkadz9HF
	 WKsWu149MlfAhiQIcAapwS2F6s1mVisJaZWq2rGtRDhVkua+nAVAy7fFiSGFbbiIDz
	 nsPmvzUjvISL6AfrCPHZlENNHZHwPRlAG+9cS/0NgUsa4qgor51DuOJ0ROzHisEMQ+
	 Mop4sm7tBX2U1FRMamPUTXNDBDizLC5TvhfjyLRXzqShXN9VohX4P5T+wyIcovUG2N
	 lSTpgju/Oxnzw==
Date: Tue, 10 Nov 2026 12:33:38 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <avMAsybq-5Fhj_7Q@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com>
 <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
 <CAHp75VdZpqt8PzVypQ85U1OjxszXOmCP9MKv3ozQOh-UVFnR-w@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="vumu5els7olatlj5"
Content-Disposition: inline
In-Reply-To: <CAHp75VdZpqt8PzVypQ85U1OjxszXOmCP9MKv3ozQOh-UVFnR-w@mail.gmail.com>


--vumu5els7olatlj5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <avMAsybq-5Fhj_7Q@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com>
 <l7ppjeoqvc6hblk52a6upei4ee2caahe2ltiur4gwig3ez7d3c@dmzzy22ixvlc>
 <CAHp75VdZpqt8PzVypQ85U1OjxszXOmCP9MKv3ozQOh-UVFnR-w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHp75VdZpqt8PzVypQ85U1OjxszXOmCP9MKv3ozQOh-UVFnR-w@mail.gmail.com>

Hi Andy,

> Date: 2026-11-10 12:51:53+0200
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>
[...]
> > drivers/base/property.c: In function =E2=80=98fwnode_property_get_names=
=E2=80=99:
> > drivers/base/property.c:607:36: error: passing argument 1 of =E2=80=98m=
atch_string=E2=80=99 from incompatible pointer type [-Wincompatible-pointer=
-types]
>=20
> > And I don't see a good way of working around it without doing:
> >
> >         match_string((const char *const)merged, n1, sec_props.array[i])=
);
> >
> > which is ugly.
>=20
> Ah, got it! But why is the "merges" char ** and not char * const *? I
> believe that will fix the issue.

It solves it in C++, and will solve it in C2y, but doesn't solve it in
current C.
<https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3987.htm>


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--vumu5els7olatlj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzAQwACgkQ64mZXMKQ
wqkezA/+L6gjJppvEkdo0JnNVWFScVnzLzYUTt8uoJ6DFOq7S4Sa/cHtaEXzSpRr
TsGxxYQndLkF/NFIWEE+l2H7Rj8U+FHZEx6fjzTxzHq0seSmOVhPJaANO+3kMugA
7BNl42BS2X7/azpOzXMDI0ywnHyKUEM1Dt5YbSIRK+2/g7C8lNrvXpKqExemyMkc
SW3Ba1UtCi2Rj7a430er2XFqRrcsskH1+2TeiCV0l0FfoQ8Utww3mJ8cGWpypbTF
zFakPJOMiqH3DPVjVs5WjBx7VfaN3z6pswjmXUQK6vBeDFD938257ccbkUsDbg1U
YlLW8XVT5I6natBYOdxRuzVAodkNbFkg/yJt3fY/uHJa9wHvzEDVcTbFTDgbvQn2
37Qcu6vFGkss6VcsOJ7rwaNQEbML8k5VcyqDMfkkvVCee0c8qN18ZjGIBCHMaQ9s
JAGTSWawBlejU9LzSZoSQdmVOvLzEuVIAa72v815O7t4jsfI6Xd3Z4ki73cjHj4Y
J+nCDawxOMtLKrsoYNpnaVn4Yt1d4EjZ2iYPhoB5leVpYudmdp1OjGxPNE2JE1Sy
UFzniOSlSmkJ/0K5dq87uqENRG8hHQu+voOojytCh7kDK/mHb8SM6zklruHEI57H
OgvtItfxA9+9fp1cg+lWaEwnGqXelC2WNTG1fzqKhy57fVU961A=
=RuHO
-----END PGP SIGNATURE-----

--vumu5els7olatlj5--
