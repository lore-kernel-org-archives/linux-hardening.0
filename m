Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712706;
	b=BOp1R28X2G2YYYqtnypVUi8kE42Q8uEjejVOSoGcC/PoEgiLLAbSPmE6ITg49aMlyEq0
	 hyPiX7SgoojS6kDgOUb7QBkjEP34fWMyq3ldGwrno1n03RYz7/Gxr84R1ALuriwOih0ne
	 AVdDKkOCjzQ/eYmP/fV2+PIZcE3xXPGUMCQE9mojAG4wtg24k7lArb5oQxDI9Y8g7Pgds
	 iqX7h4+wkWwxvYFRMrfTdAKDXfY3a9DDTQ5elFgfloozyXbHJvdr5tPuaJ7r6xHMpPXb9
	 7M8qauh7WnAGpjzuvaHfFzI1x00p5w/3Wzt77dLWj/eUfeAHRGm1FZFErJCPfKWzPHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712706;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=62xUaQoKaHy86ervGNtnM45ld1Sm4ShPu6+Zz39RH44=;
	b=wKjxfjmi+supYORWuizURp1UXi4eQgRfvVbUHoCy/LLwZalFNpjNGQR+xyvqPROiJ1Zt
	 FdDA4FdUzmTzFZbEQov3yFbCmz0LTi5WAYHu7N0gd/nopxCL/s/hD0eeeCiqK0JDCmkN4
	 SLte3xrkc20MGthrXNzzU0GoDZ0P2n8HPw7xiBknBSuVwn98NYI+AFR7hyW3RmapauqaX
	 t9Zr1Ym2tQ+rOf7FT1Bt4CHUWNdHpl8ympkW0xosTt4mgneT08FVKi7wunMJ50ywzWgN5
	 dlrBt8jsdJZjPc0VHAdjvqqknGJp1Rf81F4IoD/JrsmhG+mA+AuMBy05ot6UFbVPnyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQJYktRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C878606A33D
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQJYktRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EEC1F0093A;
	Tue,  3 Nov 2026 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712705;
	bh=62xUaQoKaHy86ervGNtnM45ld1Sm4ShPu6+Zz39RH44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XQJYktRmw/3EjBEv/79ns5vwpN9CQXGLoLCHNi0BkSW/tDCd0CPyZYSjr9pkAco/z
	 KS9ObOtQBLn1JEbH8+k9K5oDuY+fLAvXf6kfJ+2PKATC2pYK7MCKQzhYQFj1aay1QV
	 n99XniGdSyQJY52LNpSD/qqIOQYr/D4bVTK1pkza14DyTZ6Mv8S6QU9eTCKic3Nk4y
	 KrJZzlmXEL1e+L7ZPbCB6GjXUD2qb0nZZogV9IOMnVcZFIn8BdY4HSChkFLq8ltzJr
	 pxUkRBRi1BShniTfyqalKz2BQIuub9OrFZj39WSbVAwvQ9YIlN9wZjgLN8QUgGFNat
	 IrZgARZy5uNdQ==
Date: Tue, 3 Nov 2026 14:31:43 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/2] args: Add DEFARG() to implement macro default
 arguments
Message-ID: <auniCwwVW4AjWkIB@devuan>
References: <cover.1793712214.git.alx@kernel.org>
 <be1057524eb2d7bb378d205c3fc8074acbf124e2.1793712214.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="wab5bqux2z6owonk"
Content-Disposition: inline
In-Reply-To: <be1057524eb2d7bb378d205c3fc8074acbf124e2.1793712214.git.alx@kernel.org>


--wab5bqux2z6owonk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/2] args: Add DEFARG() to implement macro default
 arguments
Message-ID: <auniCwwVW4AjWkIB@devuan>
References: <cover.1793712214.git.alx@kernel.org>
 <be1057524eb2d7bb378d205c3fc8074acbf124e2.1793712214.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <be1057524eb2d7bb378d205c3fc8074acbf124e2.1793712214.git.alx@kernel.org>

> Date: 2026-11-03 14:27:11+0100
> From: Alejandro Colomar <alx@kernel.org>
>
> It needs __VA_OPT__, which is a C23 feature, but it's provided by GCC
> and Clang in GNU-C mode as an extension even without C23.  __VA_OPT__
> was implemented in GCC 9 and Clang 6, I think, so it should be widely

Actually, it seems it was implemented in Clang 12, not Clang 6.
I got that 6 from llvmorg-6.0.0-rc1, but that version number seems to
not be the same as the Clang version number.  Anyway, Clang 12 should be
fine, I think.


Cheers,
Alex

> available.
>=20
> Here's a small example program showing how this works:
>=20
> 	alx@devuan:~/tmp$ cat d.c
> 	#define D__(x, ...)  (x)
> 	#define D_(x, ...)   D__(__VA_ARGS__ __VA_OPT__(,) x)
> 	#define D(a, b)      D_(a, b)
> 	D(1, 2)
> 	D(1, )
> 	D(, 2)
> 	D(,)
> 	alx@devuan:~/tmp$ gcc -E -Wall -Wextra d.c | grep '^[^#]'
> 	(2)
> 	(1)
> 	(2)
> 	()
>=20
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/args.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/linux/args.h b/include/linux/args.h
> index 0562dc51435e..5886011cf791 100644
> --- a/include/linux/args.h
> +++ b/include/linux/args.h
> @@ -3,6 +3,11 @@
>  #ifndef _LINUX_ARGS_H
>  #define _LINUX_ARGS_H
> =20
> +/* Expand to 'arg' if non-empty, or to 'def' if 'arg' is empty.  */
> +#define ___DEFARG(x, ...)   (x)
> +#define __DEFARG(def, ...)  ___DEFARG(__VA_ARGS__ __VA_OPT__(,) def)
> +#define DEFARG(def, arg)    __DEFARG(def, arg)
> +
>  /*
>   * How do these macros work?
>   *
> --=20
> 2.55.0
>=20



--=20
<https://www.alejandro-colomar.es>

--wab5bqux2z6owonk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrp4j4ACgkQ64mZXMKQ
wqkJvw/9Ft00pDmyDeKPpFAeObGeHXW5QT+U6uISbK4K4LpxYzzEizvVCpyXO3AN
WqpXsgZvX4iElSn2ssNph19XfLo+IBjiIuFoRD2BlMzImWibzmeyudkq3R8Xtxnv
PdZKbn7REoGGY0pX194lI/Vhl4JmH4vgB9vhkXbmB35uBuKBABG8708CI1LmvkiU
jyEJAGSA5JHGc6tYegRep/uqqh4DsZlfcUIXbV4Hfv4LYDYOaV4bv1lsKM90zfF0
i/+296Zy/dDyLilkHRMXy0kbdiUJ8600HmDlve7LD16PIRc9l+GJAohzwJrEhweB
2taUGEGqnssygos8oE9nLia0Xh7O+Vp7A+Z/U1B26b2CorQ8ThZn4/YBjTTxj5U0
xpGdOQBRw18lF+Ms48jqh6OnehfeCUxs1EYLAhYRQI/521PUm3dub4/NgPGfzPtH
ZSVXN3QavxWLKOok9Jk3eeUPKegs3IyU25Cr7Q0PO8KWsBXbRdNKkwNWbodXunUz
pWeLN1GBW8ShgSyBdGBFMjfoQmJ/FcjAQ4Q2zOI0ZsNsumAroUhmn4HCR4TmoXTy
ltPeZVd9/feEJ42TFfAUFZmIJZHKYRajOJV5FvSTl3lWgXb+BzbdCFHJysNR8JDQ
GsdybyHED5FxhFRoq9oyxxVFwFi+D03j4f/zYOZCuPhyKfxUvT0=
=EZqH
-----END PGP SIGNATURE-----

--wab5bqux2z6owonk--
