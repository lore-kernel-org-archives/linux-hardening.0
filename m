Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882981;
	b=YFKVbMx5diwngJneDm5PERzfsto1adqV8pLmmgnWuQvqrU7hmghZ/HMpNALorIyH2HDS
	 1jHvBkxdiTJoHaX83ZD4SjKXU6NzF0a8/HjSvt78pI7+aPkcwuCjewywAjudxHJ27RDp8
	 KcSg47UwHQv6UQrFmSjK1eWbufwg93Z+WTFbvQhlPLROsIUIag4kVTKZImX7+NyB+dTBr
	 QFqWjK3aHKrsjdOkf0mxVRHfchMonGEMh0sj4CT327Z330lLNO0wnDydFVqV3vWF5qN5d
	 JfsZCKe7qB8OddsP5F8nUQO7M3eD8v3GJ9JuwZY+Stt9AWSOXodebQZKpoiPuBjPqvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882981;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M15O/B9yC/WOawdn7jyj2AadwGXmudVfBrAQSwYveoQ=;
	b=j4n8B07YDQd2PoHTLQCBuDXI0vuWMokmiu2IUhu8UmOFTBLxXrLOyoTB3aAWDx9QsVvp
	 hn9uS2VGQ8GgvZ0o61o9reMIa68sUsj4ZDsPzO+t8FqzVj70/wzljnqFPV1PeFso6THP+
	 Ylu+U6dCUyuR1eOZVJch3Hbzkop80hGbWzcIxnl6ul71A4pPVRwPekJYb3ohC9Zezcogq
	 6u+DbZlt3E6BtPWhzK/zv3SAL9QD+kGpfY8ekm9hoUsi2JBweEDq8QRizgwD/0HlfqGNn
	 9Xn+8fDRXDBib8T+mCZzWUNvggynkb+tWBfNvG0GlkPorpqlf31QXW3MmN/E+DRq/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibOo1Rtg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C0E606A31B;
	Thu,  5 Nov 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibOo1Rtg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4909A1F000C1;
	Thu,  5 Nov 2026 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882980;
	bh=M15O/B9yC/WOawdn7jyj2AadwGXmudVfBrAQSwYveoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ibOo1Rtg85Epay9/H+AegOFjwAPptCrIhp+JD5uEZimCF5bJi4Y04CR6dhTOkVZDO
	 Ht9hiqhz+6HHU2xZoey9L8SAKBsTQ6qmFX9m8lTmJDrqfEgkhA2NO0WMDSeRPxJXeq
	 a6prvOBaUtodxm6JQNGzxCQ0CeBmnddZMdNmUsdOW7sp49A7J0/aOAHIIxxyyCPFJb
	 1xBnFmN/EncwUCFynwiJSKsgGZpTfEPmT54Xh0K9NdE/FNKFW7A1FZMoi6KuIG/TM6
	 vwpsvVUVRI2xyDh6LC94Od4T0Bir11QaQ8G2cfofhUt+swmKQCtW7AjDd6pFHxepKS
	 B0sz/3POPGJUQ==
Date: Thu, 5 Nov 2026 13:49:33 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <aux7GHsXcRxzB5RO@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <i6htkk2ggfh5fdgooihazeaqlnx25seyb3y77qyvldu2efj4ud@4dgvnv2xpbl2>
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
	protocol="application/pgp-signature"; boundary="e4bitkibv2evwuva"
Content-Disposition: inline
In-Reply-To: <i6htkk2ggfh5fdgooihazeaqlnx25seyb3y77qyvldu2efj4ud@4dgvnv2xpbl2>


--e4bitkibv2evwuva
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <aux7GHsXcRxzB5RO@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <i6htkk2ggfh5fdgooihazeaqlnx25seyb3y77qyvldu2efj4ud@4dgvnv2xpbl2>
MIME-Version: 1.0
In-Reply-To: <i6htkk2ggfh5fdgooihazeaqlnx25seyb3y77qyvldu2efj4ud@4dgvnv2xpbl2>

Hi Bartosz,

> Date: 2026-11-05 13:30:08+0100
> From: Bartosz Golaszewski <brgl@kernel.org>
>
> On Thu, Nov 05, 2026 at 12:12:55PM +0100, Alejandro Colomar wrote:
> > Hi!
> >=20
> > str_has_prefix() is based on sizes and lengths, which means it must
> > overload the valid length 0 to mean not found.  This is a typical
> > consequence of choosing to design an API around sizes and lengths, and
> > vanishes when moving to pointer-based similar APIs.
> >=20
> > This patch set adds strprefix(), deprecates str_has_prefix(), and uses
> > strprefix() in one place to fix a bug reported by Bartosz.
> >=20
> > We can later work on replacing the other uses of str_has_prefix(), which
> > might hide similar bugs.
> >
>=20
> Thanks. As Andy said, we'd need kunit tests for that.

Agree.  v2 (sent a few seconds ago) contains kunit tests.

> I can also fold it
> into my series that actually triggered the problem if you like.

Sounds good.  Thanks!


Have a lovely day!
Alex

>=20
> Bart
>=20

--=20
<https://www.alejandro-colomar.es>

--e4bitkibv2evwuva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrse1wACgkQ64mZXMKQ
wqkf2g//dAqTvtCu9yZxvUMFRKCF48KLSUCPu6uRODX46y9DQNpvNIXB3nZGsEFC
5VDia828Tmg802ue95bBDb0hjp3pL6gNldzY5uEfar55WwUtEXEKzAl33m3F/Y20
8/TqYpsAVrVFmSYzum/W5QR3BE44lPFZ5SDDqbwJdnPXUeHp01igeXyAl2bMvGDn
OVghBH0gvLj8PzUbC2WCheo8IS6g2FvSy124QeQm5Qj1Ndaq2RJXgQXW7Z2ktDHW
8khkKbuSdrONhXcTW+o6bct3v74BEZRsEZl+SGVD9to9VNRZJUWMhtiV4FXupktN
aR5fc7KBwqk25ek8E1WDr0LNFF215jFxyu0BA4fcrxbYPCT7hvTI277UUpaT2PSQ
g5DDMRNbdUEbbBujhF39Vz7yuvRlzbfZc+lBkVSx2/+C/ClVj6aXv2utCR6Lrz+V
tyomeHG0MW3nkTeCCt4ed1ZqWA4HucU+Yre/Fa6JsLi2n7dt1A1a5Bb8IwocIlgB
qTyG/YfGyzs62peqsmVXdvxAOBDAmceXjR48f6dEAmb2R9fWYCMcr5u8QGMKxkxz
3Eu3hdDEtSCnOGaVrD0r38+EMblBvsUgikhiE5SigIPdSgeAgNlcZKjSycId17hq
9TiMmwA4ERx4ArfbylcIStdpEoLKtkKdc15QbRkk8P6xh9lERZY=
=8wgW
-----END PGP SIGNATURE-----

--e4bitkibv2evwuva--
