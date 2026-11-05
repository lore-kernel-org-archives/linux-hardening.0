Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877680;
	b=YojPb2g3q7zr9Oe8z1VI9hY7TiIJCGcqi2TNPZRBADICM//HtDsVvmr49P33GzrcoWav
	 BsYGwOalD8t15wvOIZS7qFT8x/MdeySleXsJxotYt02dboetL4fcnosNefbHFYt4XpQzA
	 rdGNVNnTjloCiuFkPUbBZfIM0I0NnuxPy8ZjmXUwjp0/rBxKlkUa7J/Mh/A4OEypKzP5u
	 7IZZsLN9dctRJUiagE7ERA0nJZdSKWq9z2Qx9lOBwzGxi/bq8nKDSlzQhbnb8XdhIoWow
	 Mi0aIbmzhDcBvQbSVffS9wgr6QgkDdRDLIUJl/OhEEamVGmpF2lBQnSLTZ+YsTJE/hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877680;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=k4sQAbXpKHUY8nhoWycmhBVWKX5xwmsOPX94PcmoAqw=;
	b=vycEi3tTSFnWLCEXg5ZWP9XoFrbUQV3JmfUN3x2PIdprYkbCOhhWv7id1h+XpIaQ6mce
	 Tcs0GAsF+iT/BIcZQqEZe11DMWiHg3t3wC02VYUAjzTqTcg3rR1s0ZuQDQWQb2EF9zlmw
	 TDW0LF2SBS3bB50eSPJfk86hrU49ETaQRqJnKywoMu7ncbLqKcyroN4BDBMoe0uGQA07r
	 HnnbbLsxIT1lT/AioopC7WOWrxP04bqlQzQzEKnuPY8DXern9d5p8lD6/FDaHH/O6E69n
	 OnNEzh7H9J8LBAsdZmR7Js/OXtJYv7ozHmGhVaW0x39nArozLwfdptA4g7GciGPoy7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="anAG/xP9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E601606A31B
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anAG/xP9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6001F00919
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877679;
	bh=k4sQAbXpKHUY8nhoWycmhBVWKX5xwmsOPX94PcmoAqw=;
	h=Date:From:To:Subject;
	b=anAG/xP9Q2tU8Qa9RrNI6jCMEpigxituDBqJqIkNGGXPJy2xyhZcfcvmbNfxbS4+X
	 Vu5WESuRB5/9axqoLGjRiojU6uYJIIOmNb6S6EpcdklUsSmFOAitRiS16BRqFQfNZB
	 T/3kk4bDwAtB8fM+0Alpnd8EVbDMBsg7KT43TwbrhpoWTbzzwukjrjYMA3Yq5bHGa9
	 Va/j3o2rDzWgkwEX40FQpShTcA1fVA5xALYUOUQhwdbWu2VJnNDdmo3S7ItTRiX0eu
	 baaMIHydHyP89dOhIF/JN0OJL98sGM3mpKsXPPTi8CGmGu7eX2l7YWjCEHx09Z/VOc
	 osiOkqwy62Qug==
Date: Thu, 5 Nov 2026 12:21:17 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Subject: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <cover.1793876837.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
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
	protocol="application/pgp-signature"; boundary="23sscqkfu6lpnrtc"
Content-Disposition: inline
Message-ID: <20261105112117.l_hzTox1lO4v5WNbZ3ji8BvSlQOpLzyG08iG4d416Mo@z>


--23sscqkfu6lpnrtc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Subject: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <cover.1793876837.git.alx@kernel.org>
MIME-Version: 1.0

Hi!

str_has_prefix() is based on sizes and lengths, which means it must
overload the valid length 0 to mean not found.  This is a typical
consequence of choosing to design an API around sizes and lengths, and
vanishes when moving to pointer-based similar APIs.

This patch set adds strprefix(), deprecates str_has_prefix(), and uses
strprefix() in one place to fix a bug reported by Bartosz.

We can later work on replacing the other uses of str_has_prefix(), which
might hide similar bugs.

Testing
~~~~~~~

I've built this patch set with 'allmodconfig'.  I've not run the
resulting kernel, though.


Have a lovely day!
Alex

Alejandro Colomar (2):
  string: Add strprefix(), and deprecate str_has_prefix()
  device property: Fix fwnode_name_eq() for empty node names

 drivers/base/property.c |  5 +----
 include/linux/string.h  | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

Range-diff against v0:
-:  ------------ > 1:  9c81f6f62fd0 string: Add strprefix(), and deprecate =
str_has_prefix()
-:  ------------ > 2:  37eafcd682b0 device property: Fix fwnode_name_eq() f=
or empty node names
--=20
2.55.0


--23sscqkfu6lpnrtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsZq0ACgkQ64mZXMKQ
wqlnrA/+IaosNZSxf3m5h84SwQJ7qpr5tDoEBq7VHrRgE382x1yxAQfCz7Zd/LLo
kLW05Resy32qUfx1QYlMJNNLw3QCoDKqEXbEUa0a/H8SafjQyDtVAWTeJOuv60kT
U2ytmK1k0dVFe2lUec/AaFHgXy5GkYPgrdXwvaM7UatdNRdPXfCC0qYG7tmbOOcL
u7yjGZ8SvxATEEtC/Fqo5XoS7IZXFfssuWHJR/UXnaXGwIgC/CoXeB7FkjUhsSdM
H2cKfvoqvfIinYMX+GQuPR1rZUOF/Be/QMMB5yOeLV1Sf6SljIabk1ESIbeJAq64
QD2nAIOyFSIPCeHVpFucYa8MRsTs7naFVvz7DgIM+3UF/FAltCKw0TyGzUkE5kXX
YNGO2R9BF8mwspr4LNpnF0gYF5VtAQ8s7Ja4i0wkxkz2Am8dwbAyPNubGTNqgyv/
1JAHiJ7RAMf6VW2jsoiX+sYj7uwMJZByNwV9HruRc4OdGgLDGinhGcvcVcVmuQs/
RjE2h7KofMV0VwFtlOoXZtPKc60MxLoupkuRyYwRBKjkisSMkjIM0SrGopPELc8o
G5wCCtjIOouquqny+jA67F/CHkgNIukR5L7UBoiZiA58wBbWPYh02u20jPPpGxSn
ErqH6feEDJXmgKFDVXxtNWUtBIQh0Qk7GtlvP0K2ISYZFCfd4To=
=/9Nt
-----END PGP SIGNATURE-----

--23sscqkfu6lpnrtc--
