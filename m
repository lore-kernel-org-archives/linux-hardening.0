Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173142;
	b=wkZNch7c9mUw2aj1sqQGOWvZZRTTTC92rk7VT+eB+XZP4OXBUU0P5qfAz9WxyX8BCSnc
	 sVIVbsSpRl1GfAXya8RMmdB8KavibILWlwv3QV2UIZAr3XxG8ZWOVKaos5qP8exuFK9k8
	 WDi62q6Pi4+qIfbBrcW42nkn6IPlzG6FyNL5cQOWHK0cEy9te5arrE73Z/dLL7u/UOM5P
	 URysUuo5GYSOBRx0lwbGMp4G4nMj+se9ZlAnXdDo0GyV1Z8u6JO+giqZStRCBkfF/x8CC
	 Avp3pBD9XEpOZx2SUH7h8CHCeeWYqFjWV7d34PjgNZWy56kXfH3roMwGdwb9Ixd7GgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173142;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bKEHoOfE111HoCliQNT4ASit67LTkTVYJszuxD9vPKU=;
	b=JAICOa1egNIadEk/PdZqnEvucIRbt9jKPHdwa9PLbSJmTInz5XoZycftOgAIWMfYA4Xy
	 /QbynsehN1stx16rC/5tM8T4OQb6U/KYNw9VEw2xLUftmnhBi8OkQ5YckC6IxsGirehx+
	 4WrLFsW4E7KiA/sN/ENhIvcH1uyeTIUH6yUzddooSJBoqvXISkiGt1WTINou6iEPnHpUr
	 6lj0kz7jelkyUxddR94l8PB/qp6wf27MEOLMtSnByVYzzbqJNi+hZro6MsxbHeSyU/A8L
	 QyrFbhCQstNBLZfLfrdrwjyf7JOyfs+jtvna5xktV317QezUVSxc2YgqMBOCT/JPK1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaKJ0aKi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFE606A31C;
	Sun,  8 Nov 2026 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaKJ0aKi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B731F0089F;
	Sun,  8 Nov 2026 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794173141;
	bh=bKEHoOfE111HoCliQNT4ASit67LTkTVYJszuxD9vPKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eaKJ0aKiTdgiSeCKi8RR55h2hUagHCHkFM1evp/ZYCOgGbGyzZDfbtMc1G08HEOYq
	 qnwZ2oxm/vIUy/xXwx7iXTae5gYMbKWJtWW1mqPiV7AABkEJJCck1LPhUCjj12XHy3
	 C3knnHuCVoibMMYqFxTxJHm8Cno2RNhRvKL13DCUVzMVKZgmJOuK2r2EN3D9HZYiWL
	 nwP/aeajYNhDO4dkfr1Ta1GwIaKZAY45x3pX5AynDvCM6JwwB42fW1SAcmwD6hQKV2
	 FO+sD07FXvmhFRC9XKR7D4vr/rZYJNle4WrDaZR8IkeyirVetwnM6UbMnmncyq3E5a
	 0T8Y9XXBuMLqQ==
Date: Sun, 8 Nov 2026 22:25:35 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, hverkuil@kernel.org, 
	mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <avDmyLYpWOQ2WB-i@debian>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <20261108210232.13800dd3@pumpkin>
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
	protocol="application/pgp-signature"; boundary="25eotijdriyozm5s"
Content-Disposition: inline
In-Reply-To: <20261108210232.13800dd3@pumpkin>


--25eotijdriyozm5s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, hverkuil@kernel.org, 
	mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <avDmyLYpWOQ2WB-i@debian>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <20261108210232.13800dd3@pumpkin>
MIME-Version: 1.0
In-Reply-To: <20261108210232.13800dd3@pumpkin>

Hi David,

> Date: 2026-11-08 21:02:32+0000
> From: David Laight <david.laight.linux@gmail.com>
>
[...]
>=20
> seq_buf is just OTT.
> Using to replace a single strcat() is just silly.
> There is no point doing these patches until there is a sensible alternati=
ve.

Agree.

[...]
> >  	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > -	strscpy(v->card, tea->card, sizeof(v->card));
> > -	strlcat(v->card, " TEA5777", sizeof(v->card));
>=20
> What is wrong with (and almost OTT):
> #define TEA5777 " TEA5777"
> 	BUILD_BUG_ON(sizeof(TEA5777) <=3D sizeof(v->card))
>=20
> 	len =3D strscpy(v->card, tea->card, sizeof(v->card) - sizeof(TEA5777) + =
1);

I can answer this one: bugs (particularly, off by one) are quite prone
in such code.

=46rom the Authors of strlcat(3), you can look at OpenBSD's manual page:

	Since it is known how many characters were copied the first
	time, things can be sped up a bit by using a copy instead of an
	append:

		char *dir, *file, pname[PATH_MAX];
		size_t n;

		...

		n =3D strlcpy(pname, dir, sizeof(pname));
		if (n >=3D sizeof(pname))
			goto toolong;
		if (strlcpy(pname + n, file, sizeof(pname) - n) >=3D sizeof(pname) - n)
			goto toolong;

	However, one may question the validity of such optimizations, as
	they defeat the whole purpose of strlcpy() and strlcat().  As a
	matter of fact, the first version of this manual page got it
	wrong.

> 	if (len < 0)
> 		goto fail;
> 	memcpy(v->card + len, TEA5777, sizeof(TEA5777);
>=20
> What might be useful is a helper that would let you write:
> 	len =3D strscpy(v->card, tea->card);
> 	len =3D strscpy_at(v->card, len, " TEA5777" [, implied_length]);
> 	if (len < 0)
> 		goto fail;

Indeed, as said in other threads, I have such an API:

	p =3D v->card;
	e =3D ARRAY_END(v->card);
	p =3D stpecpy(p, e, tea->card);
	p =3D stpecpy(p, e, " TEA5777");
	if (p =3D=3D NULL)
		goto fail;

Linus didn't like my function name.  We could indeed call it strscpy_at().


Have a lovely night!
Alex

>=20
> David
>=20
> > +
> > +	seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> > +	seq_buf_puts(&s, (const char *)tea->card);
> > +	seq_buf_puts(&s, " TEA5777");
> > +	seq_buf_terminate(&s);
> > +
> >  	strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
> >  	return 0;
> >  }
> > diff --git a/drivers/media/radio/tea575x.c b/drivers/media/radio/tea575=
x.c
> > index c37315226c42..e49228eb7c46 100644
> > --- a/drivers/media/radio/tea575x.c
> > +++ b/drivers/media/radio/tea575x.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/slab.h>
> > +#include <linux/seq_buf.h>
> >  #include <linux/sched.h>
> >  #include <asm/io.h>
> >  #include <media/v4l2-device.h>
> > @@ -221,10 +222,15 @@ static int vidioc_querycap(struct file *file, voi=
d  *priv,
> >  					struct v4l2_capability *v)
> >  {
> >  	struct snd_tea575x *tea =3D video_drvdata(file);
> > +	struct seq_buf s;
> > =20
> >  	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > -	strscpy(v->card, tea->card, sizeof(v->card));
> > -	strlcat(v->card, tea->tea5759 ? " TEA5759" : " TEA5757", sizeof(v->ca=
rd));
> > +
> > +	seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> > +	seq_buf_puts(&s, (const char *)tea->card);
> > +	seq_buf_puts(&s, tea->tea5759 ? " TEA5759" : " TEA5757");
> > +	seq_buf_terminate(&s);
> > +
> >  	strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
> >  	return 0;
> >  }
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--25eotijdriyozm5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrw6M8ACgkQ64mZXMKQ
wqnrxA//SB1OVwBLezPpyZI5ZaVSWgNmrH3YCjoGeAmMBl5SlwMMD5qpn14298F6
wJZBoeiqHmvcCG8HXMN9Vv8djtEB3Z7xbBSb6bIl1ybpeWsU0AGT62maRT/7Js57
XW5wt9IHf8eerjfS+3HfKSrkkqL6/IvOuWlXXY/ckVZEapBlCJO/Ra7WdLM8wsTA
LCny+GEr0Xi6RkfURgDDRqKNPMJgk3WVy3WDU5G7fnclB/nt2/YnGcgVc6baxd03
/GoocN9i/gfGlP5rWTS12G9ToA599dCxSzp/zcQxLZ2d12Zw1jUzh1eLx3NBBIIH
ts7NxPFTlQOI+9+kFwah9LUmlA2IBAfFjVGXZEkw+7YoGacRqBRn+T9954/u/sx6
r/ok9Hj7kbvyf7rdKNkmGud9En+nLgmRXm+OesxX8QL9yB0FeVDXvb/5dIGIO1O4
w/V5oD+XxaMBIIlbO87HCkpwnQ0et0dbtIKhZV8/bEFTxyi2NMORh6vGhEsaCmZX
uKh04FN6r0gvtnpmG4pqifhN8GF4IplIt5ELBUZqnYOy5xndU5C3LRHRron1Jw63
gTzdZa3Yoh1b1F3ZyPDUqefbkmrfXtSMz1uMygtZMt9y0yaIaPVxddq40MqrFo9m
JlRKECbPYTqi0sP/5DbPxIfCKIXHl6R/1m370GpazMX0toZWaQ8=
=Phyf
-----END PGP SIGNATURE-----

--25eotijdriyozm5s--
