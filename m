Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391553;
	b=wJm8VrlhsCaTpFcSBNub7oC3F4fn5h8iq97kh+ElD9D/OUTF7wTrDV79mrkVhy8FnuPH
	 zIrhytqNnT+pCxunRmOkw6z8hWdIljqeHwB/I6fxUqSnReiQuzbkgeEvoUa/dGE3CRlZ/
	 5mkKuZ+ILzwirzzC8VOT0gZEGMkezwmjlTcN8eM5PIr+LQWqPiHAe5f/AHw510uC3Ozf2
	 rQgiWaabK/xJLuFJluQTtIFpnTZhQxGyteuuTV7x/kVxz5+4Z9dwH6X+1XimnNlonhfhx
	 9nMBp3+FNO5IP76ZG8R5KmBHmyK7kxZeNCbUnlfczOCK1A7MTV8B5aqyhpE3HeFvzkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391553;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1JrIP6AT0wpypFfVE9TUU/IL7uCZEU12jsI9CBGrv+A=;
	b=kMUUDVtFyw87VXBTfmKFlViQZq55Kp8j2j3H0Zw3eOuBkCIHNfpiW6zl0nwlAkk9dllb
	 cqTWwkV0owRWtRifM8a3Mih5hD+dVJ0vhv7yL9UBtUz316iRj2Oi81VBwCgSUKzKjAnKy
	 gl5iw9yVTGECW3xEzJXA96O0VcudexdmHl7VDzEzBRD9LFMv/exoVi1OEjeBXxA6NK4F/
	 SyUzK9zT4zhqFoe/WYC3lJKuj1XLyc5gOASanhPrs/TRfUZGg6dF2QWbjaLs+1h+R9pQF
	 nlDy2oYy6b8ETQpdWets2Ga6X+iEwCE0rJbAfucWjNvdIEHi4GlcjL7dfO+tdWGgSVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmTCtQBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DA606A31A;
	Fri, 30 Oct 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmTCtQBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A851F000C1;
	Fri, 30 Oct 2026 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793391552;
	bh=1JrIP6AT0wpypFfVE9TUU/IL7uCZEU12jsI9CBGrv+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kmTCtQBoB3eg5+p0rX8E6q9UNcr5pKJ5aKXoDBCyfon3tN7b/a5YIRW25Jqsvqy9w
	 hUmw+EDE4GfH9ysd6ncHTyZpDUfwNQPnfkdTc1HioMLETIgY7Qj69MBcgdIft+5bxo
	 OuuF7jOj4b5Lmc+bSko+LY1x+2sUzOZGrGTXYML1O023HUmI4f237bRUrSPhojBxcd
	 HEx9uNeM2f535B/WyF+x/9y1pozLKZxnnGHW5u1YL/rDyuJnSqzI6HAsKiZHuVoTEz
	 3bQimFO8vgoC//lsXEaLeXDP3G76RLCt6iKFiOIlvShp3GQAiemlD1XwaPAptDLzfO
	 +MfhPaaf3xPig==
Date: Fri, 30 Oct 2026 21:19:07 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <auT50pyaME8jbTco@devuan>
References: <20261030192049.stay.397-kees@kernel.org>
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
	protocol="application/pgp-signature"; boundary="axvha27ff2n6a76s"
Content-Disposition: inline
In-Reply-To: <20261030192049.stay.397-kees@kernel.org>


--axvha27ff2n6a76s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuvam Pandey <shuvampandey1@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <auT50pyaME8jbTco@devuan>
References: <20261030192049.stay.397-kees@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030192049.stay.397-kees@kernel.org>

Hi Kees,

> Date: 2026-10-30 12:20:54-0700
> From: Kees Cook <kees@kernel.org>
>
[...]
>=20
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20261016145928.16eddc9a@gandalf.local=
=2Ehome/
> Fixes: 8d1478bfd63be ("seq_buf: Add seq_buf_strlen()")

That Fixes tag seems wrong.  That commit was only moving code around,
AFAICS.  I see the bug already present in v5.13, when
seq_buf_terminate() was added.

	$ git show v5.13:include/linux/seq_buf.h | grepc seq_buf_terminate;
	(standard input):static inline void seq_buf_terminate(struct seq_buf *s)
	{
		if (WARN_ON(s->size =3D=3D 0))
			return;

		if (seq_buf_buffer_left(s))
			s->buffer[s->len] =3D 0;
		else
			s->buffer[s->size - 1] =3D 0;
	}

Back then, we already had a _putmem() function that could fill the
entire buffer:

	$ git show v5.13:lib/seq_buf.c | grepc seq_buf_putmem;
	(standard input):int seq_buf_putmem(struct seq_buf *s, const void *mem, un=
signed int len)
	{
		WARN_ON(s->size =3D=3D 0);

		if (seq_buf_can_fit(s, len)) {
			memcpy(s->buffer + s->len, mem, len);
			s->len +=3D len;
			return 0;
		}
		seq_buf_set_overflow(s);
		return -1;
	}

	$ git show v5.13:lib/seq_buf.c | grepc seq_buf_can_fit;
	(standard input):static bool seq_buf_can_fit(struct seq_buf *s, size_t len)
	{
		return s->len + len <=3D s->size;
	}

Unless I'm missing something, the bug was introduced in f2616c772c76
(2021-03-18; "seq_buf: Add seq_buf_terminate() API").  Thus:

	Fixes: f2616c772c768 ("seq_buf: Add seq_buf_terminate() API")


Have a lovely night!
Alex

> Signed-off-by: Kees Cook <kees@kernel.org>

--=20
<https://www.alejandro-colomar.es>

--axvha27ff2n6a76s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrk+7UACgkQ64mZXMKQ
wqkpZBAAh1buyiaQpslQm+v/RXK8po7iZnJrT3X1TRnirZ8PAgV9zYeC7CGS7waY
aSH+4sfMYLGy+nJdVU0PPx/3d5G34K9tySE2MX7qXEAf7qL6L7mNVWbkp+XcqRJJ
1uRugeoL3B1qE2twXbbeBFDWCtYmL35jR9Fu9BEKvWRJC1kIIZc54f1F3jphKqjo
QtkBqBa+dLDNm0wohUrzpUzz4YAgnmU5l658cyFvNEvn675auHp9BggZUuIIkTP3
F1YRR96qjybVsh0YTOZXrN9mk7qZqtGTW1TMHx0fesZQkBhsdcOfCLIolQkdRGSQ
lATVNYr6DBQD9cORcWYkGMA3+xYTKjzyyGCFoh6Kx6bDv3PMbWRzStD8f0AMwPRa
VleVrGk3EcZVuLXevppoo/jbUnrJYkXkqK6XrWkbPTOX8qBzEXk0h+xodTd+zEXl
8ryw7FqqXO/FGttYv9vQRnFsFZrbB5WYVqXcsljU7YUts3PjvthtqAPiyTIdHvhA
h/aS8yZBtUri7nCKB1a0VKYC9WBcmjjTJ+IjqOVZeTQ5IoybQfSUQftjRAl6/rWR
QrYIGlbpyq+udDgMuYTRy34GQbxSBWupIu+OWleztSNlBSYX6gGeq3LC230uYOTg
YH/ufD8dmT8zzGzXSNepHtEgYihcjzxOEx9/DVaMIp4IFmdhgnA=
=K8wC
-----END PGP SIGNATURE-----

--axvha27ff2n6a76s--
