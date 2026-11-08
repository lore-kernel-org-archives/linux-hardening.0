Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138573;
	b=myx/ycoNwjQ3WUpxpGzca2dblD+baCOd02ja4X3YblML55DdnEMxwV/uZPYI2yRfEBZh
	 o2l+ZD+tk+Q5yOa7fd3kcqgbGTCc09ncDRbydWI/BK+78sbkKFCBHyLJW41m6xl1wvLdo
	 dQxZx8t0TRyT56ONHxGzx+2gs316vb8gMqYvlz3qyZY8lw7lNf67aMFnk5Qqes3EpQmcF
	 ka/QMLKSd5/oJ2DDG3IyEgFiqT8roDSygr8uzvDOEIIoxytqTkY5qc+EXijSEmNKVUqio
	 cooTPcbRxx/eTMoXRN1RUDiV/gGdI4u3SDTrBBE48qm0H8zGzMzJ98/OvT43Ffd+Rew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138573;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zvxQB2We17Pd9AVGxDxc0HxbcCZhbdPDH3x64E2+vEI=;
	b=T+js0GVfZbSUaXtkyc9YgYP4dsizFmUdNrAnhJd81mFBWwCnrKZ0tawaglpxe5Oa0cfW
	 hnwKBqguHlzVlhanzZexoOKRE2Hz8QRckcKUyJziaUQ+UMXdQkiC4DxdykQs1topT4Iau
	 juV8HF3mS9iMjvgxda8kSAzh13QHULe5yTrqfkNFM6b2RvdoK0r9ei5eUQJcxbYi3WuJl
	 fqGuyazu9TnMciRW299ecq+LN83y3lv0u9rvZmWJKGyr7w5a0z9n8czGhea/6VSwYTIbp
	 oDmuGb43Nv0ipP1HCjSnlg418i6T1mdJSjYkvzL7Y4jv6bmqjHlVul3TzPX3oqdMtIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dshvpHJt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81663606A31C;
	Sun,  8 Nov 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dshvpHJt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401DA1F0089F;
	Sun,  8 Nov 2026 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794138573;
	bh=zvxQB2We17Pd9AVGxDxc0HxbcCZhbdPDH3x64E2+vEI=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=dshvpHJt/uRIqLO6GrNL1j2pq6r7gm46b+jZytxPhLgCE/u+VL6n3ZEY3+BTxHH8S
	 shxmmbgBPRIDhr/tyVnu6VkUynGd3ht01QXb7LYRo6XRb4otAO2G2ISGNx0/FcjZPN
	 e3+rZ78n4EdjFMJz7sd2bpHCGugpZUt/dZ6ICgiccg2mln2ahjLHyoULU2IO0/Nr6V
	 af9qC4zT0Uc5C2jY1+rSVMkyeuu1aymZ7D59a9he+kTKP08bR+Q+Cz3xIu7HDhLETA
	 uFLBSW9ScjwbXteQ/tXLYK3tLsK9buzaLtJ9kjxLppuAwH6JWlKj1P46+ig4amIVQZ
	 e1jKEohLhxNMA==
Date: Sun, 8 Nov 2026 12:49:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, andy@kernel.org, bartosz.golaszewski@oss.qualcomm.com, 
	brgl@kernel.org, dakr@kernel.org, devicetree@vger.kernel.org, djrscally@gmail.com, 
	driver-core@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	heikki.krogerus@linux.intel.com, hverkuil-cisco@xs4all.nl, joe@perches.com, johan@kernel.org, 
	kees@kernel.org, laurent.pinchart@ideasonboard.com, lenb@kernel.org, 
	linusw@kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org, 
	rafael@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	sakari.ailus@linux.intel.com, saravanak@kernel.org, schwab@linux-m68k.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avBglVuXPjbKnWwl@debian>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
 <aux8LYQkGSNjCGHv@devuan>
 <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>
 <au7TvMP0YhW2e_oM@debian>
 <alpine.DEB.2.21.2611071115110.17804@angie.orcam.me.uk>
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
	protocol="application/pgp-signature"; boundary="syfb4cjgbu7o5clx"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2611071115110.17804@angie.orcam.me.uk>


--syfb4cjgbu7o5clx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, andy@kernel.org, bartosz.golaszewski@oss.qualcomm.com, 
	brgl@kernel.org, dakr@kernel.org, devicetree@vger.kernel.org, djrscally@gmail.com, 
	driver-core@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	heikki.krogerus@linux.intel.com, hverkuil-cisco@xs4all.nl, joe@perches.com, johan@kernel.org, 
	kees@kernel.org, laurent.pinchart@ideasonboard.com, lenb@kernel.org, 
	linusw@kernel.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org, 
	rafael@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	sakari.ailus@linux.intel.com, saravanak@kernel.org, schwab@linux-m68k.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, zanussi@kernel.org
Subject: Re: [PATCH v2 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avBglVuXPjbKnWwl@debian>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
 <aux8LYQkGSNjCGHv@devuan>
 <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>
 <au7TvMP0YhW2e_oM@debian>
 <alpine.DEB.2.21.2611071115110.17804@angie.orcam.me.uk>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2611071115110.17804@angie.orcam.me.uk>

Hi Maciej,

> Date: 2026-11-08 11:05:51+0000
> From: "Maciej W. Rozycki" <macro@orcam.me.uk>
>
> On Sat, 7 Nov 2026, Alejandro Colomar wrote:
>=20
> > Hi Maciej,
> >=20
> > > Date: 2026-11-07 02:44:23+0000
> > > From: "Maciej W. Rozycki" <macro@orcam.me.uk>
> > >
> > > On Thu, 5 Nov 2026, Alejandro Colomar wrote:
> > >=20
> > > > Do you think strafterprefix() would be better?  Do you have any oth=
er
> > > > suggestions?
> > >=20
> > >  FWIW strsuffix() seems an obvious choice to me.  After all what the =
API=20
> > > does is request the string's suffix beyond the specified leading part.
> >=20
> > Actually, strsuffix() is something else:
> >=20
> > 	char *
> > 	strsuffix_(const char *str, const char *suffix)
> > 	{
> > 		ptrdiff_t  off;
> >=20
> > 		off =3D strlen(str) - strlen(suffix);
> > 		if (off < 0)
> > 			return NULL;
> >=20
> > 		if (!streq(str + off, suffix))
> > 			return NULL;
> >=20
> > 		return str + off;
> > 	}
> >=20
> > It finds the start of a suffix in a string.  That is:
> >=20
> > 	strcmp(strsuffix("foobar", "bar"), "bar") =3D=3D 0;
>=20
>  Hmm, I'd have called that strskipto().  If that's not possible for some=
=20
> reason (I can't see it used in Linux), then strskip() or strskipover()=20
> could be used for this API.

strsuffix() exists in many projects, and in all of them it seems to have
these semantics (or very similar ones).

Just look at a Debian code search of those names.

The strprefix() and strsuffix() pair of functions are widely
implemented, and while the exact details of the return value differ
slightly (some return just a boolean, others return a pointer that can
be used as a boolean too), the overall semantics of them are quite
consistent.  strsuffix() has less drift than strprefix().

If we added strsuffix() here with the semantics commonly attributed to
strprefix(), and then had strskipto() with the semantics commonly
attributed to strsuffix(), I'd expect programmers to eventually get
confused and use the wrong one.=20


Have a lovely day!
Alex

>=20
>  FWIW,
>=20
>   Maciej

--=20
<https://www.alejandro-colomar.es>

--syfb4cjgbu7o5clx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrwYacACgkQ64mZXMKQ
wqkRchAAk7Ihn4b58E/Hn3+rnKnyWcl3yUktkNoXv57jaatoQ4k4UdEM8+n6lv54
QPtw5GlkOCKy01lMhcqoGtQEiBwVUg4ehBAF/wlu2GmylbPKY9B8sVbI6y7BNa3l
p5uVeMjzWnfat12d0kvtvnZhGQ6cyWA6o3cv68TICTzzxUtkj+Xw8L/+8B+xDClD
XcCL7EGTKiQ4b4mPEozYVptgJttcFEKLs+RzqjWsWYtF8JvTc0S27Q1R1dKwjd0U
daI90XK6pQUnhbKft+x/YsyFPmbedGOBIuocJmIxWuOTPTpU5aFSFWLJCy+oDI1Y
FEeXQGkoyXvemC2CfE5fRWByj0ME88MXhgrIh+Oo+/x85ue1oMaMutI7IqRyLlQs
aeQLqElEQoyfIJyrQK03tdGb6hAp2epHQfu5dEHDr4BcQTsBaC0V9CHy/q5gxaby
X77WtUiarWePT4aZ3BwBtRMZoFWc7+3VLPJMIjiLiEGkS8wBJOnhZQmm9TdEQlUf
Q3AnOHpMPA/zsNjck/YNrV3yqKeMSvt5TMud9dctRrFfTvIzw0rZDlAxO5/KE+RT
xt2B3MckutS7bOqdTe3b+eMUqByUxT/dnT1i7/GfPDFfR9Zc6F6qR3XNb3UALJ8f
sBvfXHrS8kbeJoyolzOgxRijRzFBhteZAmDR8BV5ekkeSpOHYDw=
=W23Q
-----END PGP SIGNATURE-----

--syfb4cjgbu7o5clx--
