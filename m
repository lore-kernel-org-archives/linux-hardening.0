Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210423;
	b=0TvHcAz2X4LGCwE39FuijzJtEn6+UfsNyI9Q1126raKOlZCvMwDEIHOdEkDeahz8SDaN
	 cla+Pr6vLhNU38auWePzn6BJHPDH+9fmcSh0u1N9ySPa3jppoBIwmt6IMxOXU+grVWLNM
	 Ra/E+4hFqPMjaYDhvl+9/frj3zcSI+vzzttMCryav3hDrdpsYXzjwopsn4q3JsdIZtIvi
	 Zx8w2e2IcDrznZf6TaENU6s+SfKdrVl3qUaRJOh5MG2CCmXz1+LXb5ARc+omj1/kcsx7i
	 w3qP/FTF7JSHgEa9QqoeqHwBJj2KBBJ856xiULvoZxSzlDizxf7Ewy1HB9NpGeJZGYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210423;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v/U7/rXg7EsEp/osuGKqrhQBi4K3Sjc5+LWGYjqAy0g=;
	b=IatzacOujnuhUx9Cb2mdJ+MJDQ7XWZ1euB60jIok/q98bcFxymLYq5Y09o8Ha4DDTsxk
	 SpunRiBbDIFnYAv/q0MSOJDQoLZjT5blFp2BQacwJ9lJv4JgrTS8eq+K/oWaWLDOajFAx
	 CQRm8Uks5PgQTVnVaF/iQLYTbrvZL464WfrfOSh6MLJEEPpGU3QMWYZS6J1Cd+k6+BeD0
	 wJa2OwXAUvj00kDZKrjCaP9Zf0YrCjlQSikuaO4rhQ8xZ5DSxh0GaQ0eJsnhCAuQ9Kx3b
	 N7dVMF0wscnU3uxp8WuYcrHWl5ext21YLtgBEldHcffEkey3Tcxq1EywPjvqZ8HLykw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioWEMP26;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952D606A31F
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioWEMP26
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BEF1F01825;
	Wed, 28 Oct 2026 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210423;
	bh=v/U7/rXg7EsEp/osuGKqrhQBi4K3Sjc5+LWGYjqAy0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ioWEMP26IckpWkIVNPHDAiK9yb7VciuVjiN1IMTQUO0FNGrppEK2sG5V3ff08xk/E
	 aN22+niv9lYUwnJ2YFd7cyIzMQCuLvghoI7fL1CA4RGt/Uf43TSahPR5M+gmtOODIt
	 VW/Q10f7meH2h3mz7rFw4oVW5rarUT1FhBHELAPCHckaDibI/hUuh36b1M4/JvUNkh
	 lkdJxa7u8mfqpKHnQqn68dYlsdAl1sxbi309TAWXPSUq7uFKK0TmxHKmu1lBGrU70G
	 izp0hwIjI1DLzqoXLPDjro7piNrdPmOxsCAGEaUcLLfQOXT6BKvAx6hGIkSOTHvC9n
	 tgrQqW48flC/w==
Date: Wed, 28 Oct 2026 19:00:19 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_putc() and strings
Message-ID: <auI38dBMI7aaSkY1@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
 <20261028134755.176f8323@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="ktx4lrfuldq7qmtx"
Content-Disposition: inline
In-Reply-To: <20261028134755.176f8323@gandalf.local.home>


--ktx4lrfuldq7qmtx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: seq_buf_putc() and strings
Message-ID: <auI38dBMI7aaSkY1@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
 <20261028134755.176f8323@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261028134755.176f8323@gandalf.local.home>

Hi Steven,

> Date: 2026-10-28 13:47:55-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Wed, 28 Oct 2026 18:13:40 +0100
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> > Are there any reasons to not write that NUL byte?
>=20
> Yes, for speed. seq_buf is used in hotpaths in tracing. I purposely made
> the design decision that the seq_buf string is never guaranteed to be NUL
> terminated.

Hmmm, okay; I'll keep that in mind when rewriting.  Thanks!


Cheers,
Alex

>=20
> -- Steve

--=20
<https://www.alejandro-colomar.es>

--ktx4lrfuldq7qmtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmriOC0ACgkQ64mZXMKQ
wqmX0A//ZNouAvNYPUIf7YEdv2r0ugJI4Yfm0IVJxK+MvfSmbrgimWHy+90SPIR7
am4KI74uUwKPiPGRLDUt0Gp3EyLRQEUchgnW2E8PlfteMel5i1Sl0jj+MWusO3Z5
fyeLCNHuly2s06Tu/LCx/EUtD+dEffc+RBqdbAVAgvm020OS0NhAP/Xbn52Ygs2R
tJErx4YgpP/UltRvKIFiDSFY4b5S2fmR93dsPJ7FE85w6P+CYMymbC/cR/EsmCl5
ykQrC1JcUqaoFdUFu2Kx+dTFHFVWtNFFE0XmFUejjLE8hvEOA5o0IPEALbm50I8Y
7lx9Cs7OlVho2EZiYmp1PzRSEUi1N0jcYiztr2DoeidoAzY/zsX6DHi7XdtJxoSO
uLGY2J0eJIWlnHTo7o9BHh34rDS2pIDcLhut2Cvl3NfigHOXbDUgEKLDOxa1cdEb
uw/iSyNJQNicMy7AelmDWk1SKpuW7H6sBWr3O35+EpkK9apHZO5KqU+x/IYvAP6Y
4pqKUjXizYp6K6u56xanEYQ+SP3Fc91ZLZlCUSeyHMIJhQQ59Cis/oYlydXSTI19
ZtoNJKZXEJ6p2mnWBVYzVGn1RhypgezkRjHe5UwiR10emILbv3YgHTGV4H8qZK4Q
FULToLSafEh2RbnF9vyuVNOLO7mii2bNqqTo+m4EyKg54JG4eI8=
=bKC9
-----END PGP SIGNATURE-----

--ktx4lrfuldq7qmtx--
