Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274522;
	b=lajvUFgc1lq87YLTQyeUbJu3UgeUKZrOwyIxbUMluCnmlOq3KCfNxwvrqbDr9BBFcTJs
	 7QsAaRt44LWdc1KXXYY9WpLqnFbX5Y9vtl5SjR2XY81fb1ks9b4WfrFKjo0QGrE6vA+lv
	 l4CjhoUc9aTLZxceo8CbXii+O3KKHK23p8sku0U5Yx9fXOflAbbwffA2lzn626Z109Joi
	 hejkksCk2+sB8rpooix1lfaDYX2/xeuP+H9N3JQOJX0/y3NtinZ1tLAbURuEEHfP1Bzou
	 XeZagrsF+1r6W8X7l4jVKyOn4/1BqGXQjKSPIlWK7uSy19NpgPDym/IIy44WY03cqsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274522;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+EPrHYHHbbxWxUisk93IYfYduKuSv6ecVqU7vVDeWjY=;
	b=hncNOHccfWqhLKuuHPzELTPThARCbrz+oj4GAjjxg+44+C3fzLD6XyVn7s3oRgUjYNMQ
	 2uaC2CAKglLHe4v+8rKmOdSO4PoCXkjQroCZ5K5QpMoaMDb91NtTuTorcde8dq3UP+thd
	 bHEDCMYaqWzfb/Z5Lh4Dq5jJbapev3w1/ulrm89wRPvVwJbeX8Jjr9TYMEv21XSjturbD
	 oIhXCT6LfDELC8u3y1/ptpImlVqG283UZksDK9rRiUbY/9/MbxNXWFuAwqJ4LRno6IXoX
	 y1iF9znapr4ueW6ezZOBl2rVq/YbhPPDpP38e8eCFy8lZU2tR2lEfwViMFKKOozD/4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awecAuXG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F5606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awecAuXG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E3C1F01825;
	Thu, 29 Oct 2026 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793274521;
	bh=+EPrHYHHbbxWxUisk93IYfYduKuSv6ecVqU7vVDeWjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=awecAuXGkWJASvmIkGXl+B8Xl0++1PQB45+bo+OryQsGnwLhF3EirB5pp3g3GG45g
	 XzIO709Qr5hwFgiCrC1a8J+nKXwAf8SG6iPfK4HrHMTkqs88pdE2v8gifkuBFjv1Qd
	 AhzQBDvhTUA/SDzQNyguP51tyO3Mi32opcHAvJY+0NTbtkmFw6BpM3PTBrvfgpqWDx
	 7eTbzmKOWMxrCGBfEGQ2/ZUHAFM1aMeylFkZC8sYEsZp3fhnPCX01xG9nweuOniTEp
	 vf8I2LxDlnpPsQgt0CjKFAZ7/1aG+Rmh7dr6FHj3Pm3jfd0vzAiuvOTu9Xu7YnF6TI
	 QRj6q+82x1pJQ==
Date: Thu, 29 Oct 2026 12:48:38 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_str() silent truncation (data corruption)
Message-ID: <auMyY4Xfuo9lZA24@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
 <auJmkx1p3nIrYeJ_@devuan>
 <20261028210444.295bbf96@fedora>
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
	protocol="application/pgp-signature"; boundary="6ucnhyyzop3nwjeo"
Content-Disposition: inline
In-Reply-To: <20261028210444.295bbf96@fedora>


--6ucnhyyzop3nwjeo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_str() silent truncation (data corruption)
Message-ID: <auMyY4Xfuo9lZA24@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
 <auJmkx1p3nIrYeJ_@devuan>
 <20261028210444.295bbf96@fedora>
MIME-Version: 1.0
In-Reply-To: <20261028210444.295bbf96@fedora>

Hi Kees,

> Date: 2026-10-28 21:04:44-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Wed, 28 Oct 2026 22:30:38 +0100
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> > Let's see the implementation of seq_buf_str():
> >=20
> > 	$ git show v7.3:include/linux/seq_buf.h | grepc seq_buf_str
> > 	(standard input):static inline const char *seq_buf_str(struct seq_buf =
*s)
> > 	{
> > 		if (WARN_ON(s->size =3D=3D 0))
> > 			return "";
> >=20
> > 		if (seq_buf_buffer_left(s))
> > 			s->buffer[s->len] =3D 0;
> > 		else
> > 			s->buffer[s->size - 1] =3D 0;
> >=20
> > 		return s->buffer;
> > 	}
> >=20
> > The first check is fine (we don't trigger the WARN_ON()).
> > seq_buf_buffer_left(s) will return 0 (it returns 's->size - s->len').
> > This means we'll execute the second branch.  That branch will result in
> > overwriting the third byte with a '\0', without reporting the overflow.
>=20
> Yes, Kees and I already discussed this:
>=20
>   https://lore.kernel.org/all/20261016145928.16eddc9a@gandalf.local.home/

Oh, indeed!  I didn't understand it enough back then so didn't relate it
to this.  :-)


Have a lovely day!
Alex

>=20
> -- Steve

--=20
<https://www.alejandro-colomar.es>

--6ucnhyyzop3nwjeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrjMpYACgkQ64mZXMKQ
wqkLlQ//XYgMv2XzE0vuaFGbIdtQE5GifhklRMCSM+joNm3LPdW6cDtPfCC3nrKs
ZH6Brp15bow0k4Y+JFaSYD78vR4kP5Xz/Pueb2lH4quAmxtRfsrlinkhaT0ESx3D
UWa89eploJrgouD7/fLeOO/TKgdojKH4KeJhI/Y4J/V7C1YfmZBxIJ53CpSyfWAo
qJMQ+C1fL543xRhR7R2A521uX44/D/My7jbv2Qx8Lnu0A6icKZs3USuQUA0/zbzo
uACPoFlqZiojmXUxMe+DFHwLZEx2XBZr/L0sQEnMLDUqTJb711WRHaT6I+KmMh/k
A04hCT8OS0R0ttww8c9oYFuqRxCHV+vNoJ+pR8zV55y1a9rbi2TbpEkGPLEUN+Iz
DQM6MHMP5eSUxKYcl/rpaW1kDuFEmb8bgFnG1ARr5EOqCmypqR75IF7fOxoqh0lm
J+dcdf5YcI60eXdcfCyNTiGisPsZVY8Pj5MUPtUXch8XyLSL8YGnCztDtmKaOTbG
QBw9wzTEj5TpqpAcPk4D3izY6zmikpPAVPbPT8sYlB5gUijg1s8is7wqBsbwo5BW
z60cuGtrtyu87A1zhjfkSeclqGUwnNTQZESZHA0wJarfhxhbhby/sWn2cBnbQXu8
HJNGyPMD/X97750YoyYKrzpcm/Fb/4A1F4rwLgETLIXc4Ljp9tE=
=7PlT
-----END PGP SIGNATURE-----

--6ucnhyyzop3nwjeo--
