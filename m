Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671144;
	b=M44vsbhcly8JQ2VsO39pHbLkd86CSpRqJUiCfC/zS8qQMA2n7eFUHcW4Gg+bcfXBpISE
	 Zg4p2Qa51g3O3q6xXRPoH9HLh6SzUQNhsIdpSHqMfFlyb3PRz4G5oaCL+vKoEMfD6HI/B
	 QWYMxwcrHJhPOcGGv3Z1ugEYNa5ubSCALMh4x9nPVBecVGtH6fDxkkbVoTLMQHbNHcFkJ
	 c6YwGS2108u+ZZ1ljvuDGVAEF64IgMVE6kPSy7c7MuI3aQO++e+3NlG1oS1/C4IPvWl6J
	 Q//RsruCM7wb1UA+kTnTvxDpnWPprKGjHBs6FqHdHKHAlfU0AM3r1hkqynMndrO92gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671144;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Pos+4LZ+lPL+smIFd903waB4mVMfUVmT009+WWRP66M=;
	b=eO1T1UC8n/8ibZqF7Fdnt5s1uBmB/BE4fN96hXfyX2rA/oSKAm5a4IgvyVzV98hFQNfa
	 mNkQLt9hi/JJDXZCxPSwWinvlB7ANUaHV7rrhX2S5pvkLRpH/jLjBW2mtk1Blx9amjTu+
	 ebP9rB9VBqXMOp+EzFuiE6tAWGaN5TtIURJT0AvT+LjLQeUNOxl4w8nKynm6UqJFuZ7sD
	 0m10sA1ZBE6qWhIDnhVzA9locnjcZxUmo94ZtAux0HO1qnjUN9nC/9Cx5v4ItnNP1N7Sp
	 dTTQCtGKeeRxVGI/F4abNps4siAfcARWb/WcG4ayr2uVbbWOAwONKW1JVlSSHKEuSmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVaXMFy0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29372606A329;
	Sat, 14 Nov 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVaXMFy0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BE71F000C4;
	Sat, 14 Nov 2026 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794671143;
	bh=Pos+4LZ+lPL+smIFd903waB4mVMfUVmT009+WWRP66M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVaXMFy0JMUDGn5Xzjrii4NssDNrPW+WP38K7xc8J2FGTMDhwsLgDsQfbuGgWd+aN
	 b6fCYNE1JbuW6++Qwu2tiKBbGI0Vwtm2dGbmKPHnedjjM+yVQ2QBWk9SBOAf2oEHJ4
	 9S5FgIobte6w3KN4DuHffELuM4/4p+5ea1BOjqayWk/yd3uX8MmZp8FunB6vL6GQQY
	 4yvJ88UogHGXeM7kK7vasVAcgv8+RYcwpt/KveYLLOXULt7IwPHE6dHBEfx6PXjuG2
	 Ehkd6ueWd5N2filPoVNH/G1aIFAEiW0YwRmUmpD2rChyKzy2gIP9Du3Gteb8vbELav
	 /tsHJzInZglcg==
Date: Sat, 14 Nov 2026 16:45:39 +0100
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 12/19] string: Remove strstarts()
Message-ID: <aviBqFFmIsW_FQK5@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <cabc673b9ac73c137ad6f7dea52f8566c5821675.1794667407.git.alx@kernel.org>
 <sashiko-outbox-214710@kernel.org>
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
	protocol="application/pgp-signature"; boundary="gexdib6emlqwhcjx"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-214710@kernel.org>


--gexdib6emlqwhcjx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 12/19] string: Remove strstarts()
Message-ID: <aviBqFFmIsW_FQK5@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <cabc673b9ac73c137ad6f7dea52f8566c5821675.1794667407.git.alx@kernel.org>
 <sashiko-outbox-214710@kernel.org>
MIME-Version: 1.0
In-Reply-To: <sashiko-outbox-214710@kernel.org>

> Date: 2026-11-14 15:29:50+0000
> From: sashiko-bot@kernel.org
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] string: removing strstarts() breaks build in
>   xe_sysctrl_mailbox_write()
> --
>=20
> commit e1746880c54dd32f27fc7343468741cdc4b05246
> Author: Alejandro Colomar <alx@kernel.org>
>=20
> string: Remove strstarts()
>=20
> This commit removes the legacy strstarts() macro alias for strprefix() fr=
om
> include/linux/string.h.
>=20
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 0a466360dbb39..6b0de932e23a8 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -609,7 +609,6 @@ static inline const char *strprefix(const char *s, =
const char *prefix)
> >  	return strncmp(s, prefix, len) =3D=3D 0 ? s + len : NULL;
> >  }
> >  #define strprefix(s, pfx)  const_cast(CQChar_of(s) *, strprefix(s, pfx=
))
> > -#define strstarts(s, pfx)  strprefix(s, pfx)  // legacy alias
>=20
> [Severity: High]
> Does removing strstarts() break the build when CONFIG_DRM_XE is enabled?
> drivers/gpu/drm/xe/xe_sysctrl_debugfs.c:xe_sysctrl_mailbox_write() still

What?!  I don't see this file or function.

	$ ls drivers/gpu/drm/xe/xe_sysctrl_debugfs.c;
	ls: cannot access 'drivers/gpu/drm/xe/xe_sysctrl_debugfs.c': No such file =
or directory
	$ git ls-files | grep '\.[ch]$' | xargs grep xe_sysctrl_mailbox_write;
	$

> calls strstarts(token, "timeout=3D") and strstarts(token, "resplen=3D"), =
which
> now fail with an implicit function declaration error.
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794667407.=
git.alx@kernel.org?part=3D12

--=20
<https://www.alejandro-colomar.es>

--gexdib6emlqwhcjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4gh0ACgkQ64mZXMKQ
wqmSSQ/9FcKywo1ETmsbzu8mqteQf/xrmUn1Z3Vw87On/4wsjhbNNzYdFf6bDJhj
T8kND3E058Im9fd1y65ckJ6ZVUVlPXOBHvubYqUb+KOSYmM+FIMQ5zdX1sBclwUq
KeCsJOjIXuviIAMns840P+7AKsRpEBbzfSo6ppjYFJvravPaCNylsiQmCg41DmLr
qzMRP5O0G+7rnhHkbbvRHGsiuup0bWayBpVhBPDFL+7Y6RBxLzRBR3IGsRZ9NF16
Br17CFm3I3N/AQ3BWOVl3VKxxN9JsuInXmFumrP0PJ+BlJZUuiYOh9zcDLWY9krG
5uQF/9z8rPh9KT0FaddSVYuUsD3n/jc0SvL0VMoafUtPRr46FOcP9SwSGHNdg3/G
gFTUVSgwqz1GaFdRESMBnQD+sF3vw4DuUNMZ/G0bUJU+TUnACMpLVyUMt/0blKtB
/DEr44qVvmrlwU5IFlRYeZFygarbGLTkwUEoBHqk4RaJHzl9CaMM0ARcwUGcBU6N
dcdSHoJyY25maSfwQGY8a60K2Thb6cUid9L1ff9VmRTUUtnMbUv3yccjzZMoHnSD
FEGsp4U+cXe95xZYBaVGKMAyw+jTaHOQmQwOe8CSpujlGMtyr+K09c+uLtBNST3o
DLRRowCRn+bZWk4Rka3PV/lQqM22BijKyScwKEaP7J7tYJFICxQ=
=zh6u
-----END PGP SIGNATURE-----

--gexdib6emlqwhcjx--
