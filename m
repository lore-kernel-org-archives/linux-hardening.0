Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353734;
	b=WvKmeAXnRxgwYPAGhotGdMsGmcOKwPXsvVSYxTLpp7AljwvWiP+PR23AxTATkpu05ODG
	 a9egx4iWiOLqm/NjT569VFLGm6PU1IaFKGmD5wEt1/UjCwCEMUSYa/HiRq+AoWStGc7uo
	 qtRvuxkZrqbAETYri/D3jEFNwvabN2JGVUep6EddK5AP0hPG/dxVJThoIYfphA3x+jQlT
	 bRACmKLcuYkfUWNP62DC83OYw6q599A1W/UVZJMMhtKB7R5BwbO4GY41eP5oRMAruOuuH
	 bXNZCcSrXrIcqlJIMcSV7y+bo6RiI96hSo0Wph6ftxNCTuLdYGNdaIR/f+Zo9O2g62Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353734;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FVWSedM9iFS/LbbcpBco1ZXRMtpFb+1Ki8reNQusrt8=;
	b=RhiqiZwVd/bveJ+wv6fVuvvAvsztJmVUs+iBINcpwxoVINdU5N8IkXaEnJHdytS92yaS
	 HLQ63wrLPLiCqnLc1XtYJPqfWf/P9QSok4Acwkqm+Zc3rIWONMb8qXhS66Wj9vHSWmwA4
	 v4nm+76RyKgt9SQLfI+FaDvLb036Q7MQvGEbNFAQ7uX0jwDuqxxsh+VMwzoIf8EUoNv1P
	 vd5TyPOY2GaJVXACjdUTTMpSQX9DMiT+NWNKhJSgmNfQPeqPiQe/qcBpF6F8GGjWiw3RB
	 M8AoaL2vxwYsWRGpB4Pl1SNyMqDeAnEptk7i6QobgIUXUJwGMBHj9wTnt88Xl5toeHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGJ9KVVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D4606A31C;
	Tue, 10 Nov 2026 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGJ9KVVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC151F0093C;
	Tue, 10 Nov 2026 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353734;
	bh=FVWSedM9iFS/LbbcpBco1ZXRMtpFb+1Ki8reNQusrt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iGJ9KVVMtOheJnMsrM8uFL1zU74tBZwEjfSs9NWaXiRiVIWesCIbpQwlMXDmG8NYU
	 lOk16zlM0e0p8y7PjxXn8RMvwEoRSKM++rmA1QbFvw5ebnH30pQfH+6e8ElyWM2GsA
	 +pLjPgPfuoelXlFhTBfQhrzowubnwYvnANRmGqWJPNEPLKtk2VNPl1ABKAgcvZPKre
	 cJLxLTilnW5BSDd6/NmAm7kuN7SlCNHN8yRXbjmEjYn5rDsouS5iuxANZm5RULyR6J
	 JWtIX93PXolctO2ONcQacrBAdtv4dnxGElKoptoPzAlXfBjmz9hwOthXgvR5SP2Qf5
	 pDtUkLxbpQ8Xg==
Date: Wed, 11 Nov 2026 00:35:30 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <avOp9udFzahnsmN_@devuan>
References: <20261104033110.out.418-kees@kernel.org>
 <ausWlN1oWc0Utnxb@devuan>
 <20261110220716.37bfac-kees@kernel.org>
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
	protocol="application/pgp-signature"; boundary="qx2e4j7hkek3tvqm"
Content-Disposition: inline
In-Reply-To: <20261110220716.37bfac-kees@kernel.org>


--qx2e4j7hkek3tvqm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <avOp9udFzahnsmN_@devuan>
References: <20261104033110.out.418-kees@kernel.org>
 <ausWlN1oWc0Utnxb@devuan>
 <20261110220716.37bfac-kees@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261110220716.37bfac-kees@kernel.org>

Hi Kees,

> Date: 2026-11-10 14:07:24-0800
> From: Kees Cook <kees@kernel.org>
>
> On Wed, Nov 04, 2026 at 12:28:27PM +0100, Alejandro Colomar wrote:
> > Please include:
> >
> > Cc: Alejandro Colomar <alx@kernel.org>
> > (or perhaps a second Reported-by.)
>=20
> You were Cc'd. :)

Yup; what I meant is please store my name in the patch body, since
I want to be CCd if anyone looks at this patch in the future.  :)

> I try to avoid explicitly listing CCs in patch bodies,
> though I don't always manage to wrangle "git send-email" correctly.

Then a second Reported-by might be better there.


Cheers,
Alex

>=20
> -Kees
>=20
> --=20
> Kees Cook
>=20

--=20
<https://www.alejandro-colomar.es>

--qx2e4j7hkek3tvqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzqkIACgkQ64mZXMKQ
wqnYlhAAnbMPVhP+XfjyXqCOqNN4q754m0vECI4rSlv64ulG4xNY2Xa+g54/6fqp
LBqcEJMqPT6NPUmlEsQGu9GDxoR2QrDjREhbEzuuWNKgQgz0d5J1ad8qbX78n5PX
uAZ/t6ZcTnnIohGSpkzeDbNvVx3ZvvTxUmmLRMocAFNaCO0/ArbctTVTyVwhu4Q+
lD8RbJEjz6TyfRiHIk4dbcrP3cJwfQ20ci15X6f+ZMqJBHyfTZ7zZXR2uZXqWPHP
WBt0mjHILBt8U37D95phwr+HOY/3DgUkpFWwJo/vqE+gIZGe1CW+0/1SBJyt1cAY
pgafzXH2Wb1oTnRPTgodajqkNtheDHyNJ1xuT0Mxhe8h4vhhZaoH3gbxtHeUDrJq
RaNw16lwYSQxqYXv2sP/ljxZgp3NZpJ0yN5/9UfWL/5PT3g19sPKbu5sRvk1ozxa
TYntODN9yiG7vUYMMmmZ2qd/UplljcSckk7/X5vBu+stArtgwBZXRLq4qM/kRjWt
7BLVzn2B35ngsrAIMbRgBppkhQ33I+xRSDErbUH6Iq2ixtclFOuvLCOFfcUWqra0
W11+szy0+hdAamf3zVlYUYIvBc4BYdrOdPQzrXJLadedzdyrZr4SjaT4TqEWn3Kb
20zOzykyxyLDwxcWRLIuPnbFce2oinEmTUPz9hid47hT7m5QUTE=
=JnEy
-----END PGP SIGNATURE-----

--qx2e4j7hkek3tvqm--
