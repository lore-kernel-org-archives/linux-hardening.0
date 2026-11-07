Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794037163;
	b=5sq7hcp9ojNZWv7KUhlR0ndIEEKXEcml979J+zIQfQ0rN/oPskOGcqeSG/eoIanOAeuu
	 iu6bJBeueDhn80FNQaK91sF/jaejiMoqvdOvmNp07Q4/VIfXTDzphtLbzgWtvNCdWvkmi
	 m8MJsALaJ0xCzk+ZnUc35FqmcZivTWlSmd9VWCwSepPnVlOLin1xisGeriXu9ygEgnAQg
	 /EOX/7150btEqpS2YCbo1CO6AFX0KhAqw0QUWci4tlFC+lL2EVkryDnbUN6LXyyvjWR1H
	 AsvonPTP9XHLN6EkCUavTcc+GHgXfixOEN3mElEY/5Q9BVswDqBhm8qrZ+JLinKgSJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794037163;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zu/rlsVIB7XbSi8SCOkQ51ETv9PfkH78xu7u3H31dmU=;
	b=R0APK28yBaRu04sxXa8pJQBGMqKHb6s6SihHXPkg6ubOBYuq1vjHYk+mbmMbeoPscJ/y
	 kIhSk4CdXyDMjPYfB5QyqPp2w2cPHn3y93lrJKXMzOJo5qsZD77W4n44BK2/laMsctIjV
	 2EU2rawh1hloAzVmHIXPVQw+7mrD8/cKjfEzCRDfnazjVg+d7CaegU8lRWlixs4rUuxcf
	 CdqRbgXcHilJWatnHdbyCiuaZ/0HwUlDCc+K4SCC96zBsFrSoG3UwfnRQkwwMHAuIW2GZ
	 +IJD+pgWBsOnjBO3HQtQW0KK5zt9mGvKbt9UZBjORDn9imuEK6c6YWiHB8Op6BH13cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FY+IjFwp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B09606A326;
	Sat,  7 Nov 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FY+IjFwp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C20A1F0089F;
	Sat,  7 Nov 2026 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794037163;
	bh=Zu/rlsVIB7XbSi8SCOkQ51ETv9PfkH78xu7u3H31dmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FY+IjFwpqIZfIxr8ZkosI+ydg07CtovX2l/6HFrZAty9u0y0hnqQ2RTJPqPhtGjq2
	 4mFm4bGGgw16585X10ba4QS+93GntOm/cGoelx5eZ9hT8yy3ivuFUijYPM17gmL0m0
	 YoLTmJx0zMUzhMb0hBz9GlU+qljgUpoym9R+JKwtzli2zv5/2PcJU8Hp4oh2EjpAUS
	 3VoxFNqJ5SU3vUhdfgG2op3ZHYDNQ5/lA2zQogsnKtz1I9yUUWVKy6c8kebCZ8Ovsb
	 lumGr/otg7URESJT8uq0UDebNWIG3yg25yIqYSrXGHgp5rV/++OpzAt88uXJAj5vGH
	 VsCAXEj0YnoyQ==
Date: Sat, 7 Nov 2026 08:39:13 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: hverkuil@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <au7VGW5qpYAbVLxc@debian>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <au2uDjVhB9232IuB@devuan>
 <CAPDEY+Wa2+zxSVz8fewXDP78eA8-3ymAKurXuvB1Dhx7heLMiQ@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="aa66c3z4sxbk2y4b"
Content-Disposition: inline
In-Reply-To: <CAPDEY+Wa2+zxSVz8fewXDP78eA8-3ymAKurXuvB1Dhx7heLMiQ@mail.gmail.com>


--aa66c3z4sxbk2y4b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: hverkuil@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <au7VGW5qpYAbVLxc@debian>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
 <au2uDjVhB9232IuB@devuan>
 <CAPDEY+Wa2+zxSVz8fewXDP78eA8-3ymAKurXuvB1Dhx7heLMiQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPDEY+Wa2+zxSVz8fewXDP78eA8-3ymAKurXuvB1Dhx7heLMiQ@mail.gmail.com>

Hi Mariia,

> Date: 2026-11-06 20:31:53-0800
> From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
[...]
> > > @@ -255,10 +256,15 @@ static int vidioc_querycap(struct file *file, v=
oid  *priv,
> > >                                       struct v4l2_capability *v)
> > >  {
> > >       struct radio_tea5777 *tea =3D video_drvdata(file);
> > > +     struct seq_buf s;
> > >
> > >       strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> > > -     strscpy(v->card, tea->card, sizeof(v->card));
> > > -     strlcat(v->card, " TEA5777", sizeof(v->card));
> > > +
> > > +     seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> > > +     seq_buf_puts(&s, (const char *)tea->card);
> > > +     seq_buf_puts(&s, " TEA5777");
> > > +     seq_buf_terminate(&s);
> > > +
> >
> > Why are the casts needed?
>=20
> Hi Alex,
>=20
> I added the casts to make conversions from u8/__u8 to
> character-pointer types expected by the seq_buf helpers explicit.

I was surprised that it wasn't needed before.  In theory, strscpy()
should be expecting the same types, so if it wasn't needed before, it
shouldn't be needed now (and conversely, if it is needed now, it would
have been needed before).

>=20
> I'm also considering simplifying these two-part string constructions
> using scnprintf() instead. Would this approach be preferred?

I certainly prefer scnprintf() over seq_buf.  :)


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--aa66c3z4sxbk2y4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmru1aEACgkQ64mZXMKQ
wqlIlQ/9HFOMJmAaYKi3k3WB5Op2kYRFvqakDT9jQRg6gn1xidFRHgPSVAuWiJZO
f9VMVxpFgvKlQlQYtrKiyHFV4Sv0n7hoThQneQFHI/yGnxq3Zhj+wUEuEyF/n49X
cupvON7ZU5pnX+OBDRkMh5e0FDpaIcH6JTLLJG30ORmR/g5PwlOHPFx5imvROIT5
NbGQXmUPYepIVpXr6vOithpa5OH7IhZw0z/2wtuAOBjtEjlyqGO9XrJ29D3XUpOj
dA0xfWSt0TiCXzRf7jk3w6iJlpDA6HJ8JO28MpEO7mZ/aZD7vrY2K0J1N/bfHJsx
pXukh96NlKnXVu5G6/FSHBbsifIKt9a0DWRZghzTknyRmKqqCrD6vmLql87i+j5d
U1kH8vHtUO7Oor+F0k8+XeNw3gs3NV7frDWvoH2RhxfaDht9LIg95MsSqOqn5xMf
BEmph3yjnmp2lpD+/Zduzk6KCZ9qZa3FGejeS03LaHKR1M8RK+AN9QaylQmS1mO3
i4Jlf5dUqGOBIOftRxmOlj81hweN8pQmgmWP3/R1o4sXsKQyxGebx/fQ4kuPgLtc
3m433eEy1KUMI4JODNiYMMi5ZO15Ia3naHGnQW8QRkj+zOhN5a2gluWco1kubizv
iKJCPsv/yjPcrkpSec9GckzdPoLCMT1jkNXJtAnXrkge0wQ+Nr0=
=lL0H
-----END PGP SIGNATURE-----

--aa66c3z4sxbk2y4b--
