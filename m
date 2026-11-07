Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794036805;
	b=jDPqb3Y2LuB4XOnCtpoG5ahaJy33YbE0iimu1bdW+69Iy593PzGrzMiqWdb2xvY8NmDE
	 PT1IlSGFFQUF1I9D5siuw+NxBPOkMiFAIvT452xsy4+lgU9Jty8Yoxo7VzuYo50FbLEHu
	 Mw8V52S1jfYKaxfn7WqMSkeemtBXKMBXNiAW0nbax83+6S+25lgVa7bMoCigZbFB33GDt
	 U5NYo0NJTnLgWYmPmhB9bJTXzWuDdK0s+v/MRtelNZeDztrvs+fn/jIMPL3jfpYbjYDtm
	 ksAxQLf7WQhmssndl7ScO8fsJjVzYINlzRHIpsTFuVRFKd0lcwtxH06gaGZuodNPt5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036805;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RqcMsUowjiasOdRKT6/n1tz64a/KAgMWOjxLOv2ccbk=;
	b=vR0K1tJ1sn+egcFsudbNalcMzqWt/R5q9o6RCg+X3QisWCFf7s/LqfYL2CIY1HSFWg+N
	 SrkvIcHoTFm/MS1iYfxV4d4sZ9e79W4Grj7VLuXLdlsPTQ1Ara+1CDzCHeiIOxG/lcAmt
	 S8DTK6fdmlc0t8n81pfLmiKj9ShBTsZY6vDqxqxIyC/T8GfYEcHkhNl09pFXQsEeSIk/c
	 DC5EOw72ye3aMKLjRDkaUx/Aia+bqm9QLgEw50IPQH+W6Y1taHuJ6mRXNUEjC2cqx8DRU
	 PP6PEREplYCMFOoUI/80DsZDnT68kuQukAkPgmDyPRUbKTDCLcGmQVvj1YvyYCDAf7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7BMVbPW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A862606A326;
	Sat,  7 Nov 2026 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7BMVbPW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3E61F0089F;
	Sat,  7 Nov 2026 07:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794036804;
	bh=RqcMsUowjiasOdRKT6/n1tz64a/KAgMWOjxLOv2ccbk=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=M7BMVbPW6X5rsGfsZmA9wkvAxPkJ5ypVXRYiBkJWHdWmkli06NP3bw2Zt+tSzIKSl
	 /m357etyPyHcmOOTB8rak7PiWr+yzbxx+nJH+eJ2zckRSl92wDXxSiNVuSsTTr9/6d
	 9i5pyNR/97/pebPXbVIVmDeFacFlroNjc0B2ipUelgGEBYJ1xu14hFo8CswvcRXaDf
	 TFtcE2cfRziRWhlNDXqctpvRV4b1NcOlOFlrkZJLQAxS9BzWx50R5ExIrUvdq1rAfv
	 bU7lICdRpvm5BAvVeOppiXjSLwNxqFxlpzVdTfuA3SwiNMhH25cmCLywdcT9CjxHgu
	 MPGP+4aKDsOFQ==
Date: Sat, 7 Nov 2026 08:33:02 +0100
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
Message-ID: <au7TvMP0YhW2e_oM@debian>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
 <aux8LYQkGSNjCGHv@devuan>
 <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>
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
	protocol="application/pgp-signature"; boundary="dul5zpskzyut57vy"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>


--dul5zpskzyut57vy
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
Message-ID: <au7TvMP0YhW2e_oM@debian>
References: <d3b325ecefd1d991ca25a4de2a859353f3ad7cfb.1793882260.git.alx@kernel.org>
 <20261105125154.83478-1-geert@linux-m68k.org>
 <aux8LYQkGSNjCGHv@devuan>
 <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2611070223510.17804@angie.orcam.me.uk>

Hi Maciej,

> Date: 2026-11-07 02:44:23+0000
> From: "Maciej W. Rozycki" <macro@orcam.me.uk>
>
> On Thu, 5 Nov 2026, Alejandro Colomar wrote:
>=20
> > Do you think strafterprefix() would be better?  Do you have any other
> > suggestions?
>=20
>  FWIW strsuffix() seems an obvious choice to me.  After all what the API=
=20
> does is request the string's suffix beyond the specified leading part.

Actually, strsuffix() is something else:

	char *
	strsuffix_(const char *str, const char *suffix)
	{
		ptrdiff_t  off;

		off =3D strlen(str) - strlen(suffix);
		if (off < 0)
			return NULL;

		if (!streq(str + off, suffix))
			return NULL;

		return str + off;
	}

It finds the start of a suffix in a string.  That is:

	strcmp(strsuffix("foobar", "bar"), "bar") =3D=3D 0;


Have a lovely day!
Alex

>=20
>   Maciej

--=20
<https://www.alejandro-colomar.es>

--dul5zpskzyut57vy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmru1C4ACgkQ64mZXMKQ
wqm7rA//SurddKJhcpcYSVF08Ab2FAhfNpH0ioW7Yb/l+oX0VEpkWj3qqra1tx55
Z1UFA8Zc2S23a2zgGIVgckruLAScw3TgH56+01s0K2rHCab1CAG6jhPnj2SrdRDd
3r1e/bTSwdBBaL3YjGLE8QJ6Ovr4k4QIfx4hrJDEoc1Bd8d/kX4hP5ck/UvUQRps
uxgukH/uuh069/6RuDrbqyZNTYaII3QF5In16FORibSjdYhJ3zk6jSHglRU2c2RK
rdB3UhGgvmRwioMK6O8uvjAvh+8Uh25hUkodhUwK5zrL/R7KD6hcJ4Qzgs5f3UC/
eFCzJpR+vV4VgOfmxBzJ5B6iZiXbMgXPuYmIw6MtXddrQMKZYV6pmSy8EEUODC/G
PGynmMkcNOcSxnAy4LX7my5c1ilQ6eVlnQ5mdPR6QUIzKIhC7QL0V9B8UUFGgJ+C
CX19+pefdS4MdHB5A0NTMPdp/kzdw8LbHsPz5EcumrjxvhFl+m6xfo9wYmkRD+2m
VJF6uwqVpJ9rP8zJNT2qonLoTk6sbT5Kc8SRSOCsfOOXVkci1C7Y6ZC8ynE4Xyrf
/G3gpTejPyd+cYuZkOBrRv9NGBaDx/Ioh6ZExvc2hoVh+LaIctAwYoLhxLaU7neV
ElYN26nlmyCnrZ82m7JphVIFX5IQerK6gzXdIOg4PEXNRNs8l5o=
=gJHo
-----END PGP SIGNATURE-----

--dul5zpskzyut57vy--
