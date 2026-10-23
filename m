Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755550;
	b=AJKawfTw3bK72akZh3GYI9MWuCAzyrN+mv0iqCRhWi3ZzlO/W/5hG59FW5SeUMOf0HW6
	 npcItC4txikJ/K5oN9yvOthtxAQ4VF2mUEnxbMwhcVv7Gf04RQ+FkhxVst1HdK3ruqXz6
	 FHI7+yDB7FW0P+0wEsWTIHO8x//s5TcBrmJRQErEQVBztO9l9B36IpIpyWj57KLmh+dea
	 s4mUHO4KL6E9AVFxPvmPoeWCJgdPSOgN1I1WBOWYV5MT+YW2jXCSPn0gH93jl6Sl6QdIo
	 HrmzsuhNI85eRxRhptj8DyIh1nBK2Ks9dNqjweNsAzwzaqtEu4pAUUuW+eYQ9M/lPUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755550;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IcSLyYnQnVyiersjjKF/SvZDVy3Kk6BBMwm4jll+NFM=;
	b=N4gQT/kd8nfe4YWpB3zLMLIj9yyYIIWPavZvMSsgJ+KU+5EqSLjj6HQEJPGOlbmq1WPg
	 l65eC73rQP+UN1T0eRAL2C++hrNswCRh//7I3heTP8wnF0OUQtQ/iFHcnbquYKQM9tpkm
	 NuqMwYkbMO46AkVCzEZ3U4z2I3zxT1C/EZ+Xf0G6MpuIPoZ7hIlYmHNKBXKipmDGnMBP1
	 gWD1zZPHsCouKhvkcWpzuM1MadFY1JpizoaYQXodoxywZNRAqdfSJF5ZSY6aBLyvjpXx0
	 Q15HlLqh3qOai3B/rAUzEphu7P6+4DIO6JdeGM1KXfiV7eyrt9C3+9HP92og67Y2x3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iT2XDmJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD60606A31A;
	Fri, 23 Oct 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iT2XDmJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFB71F01825;
	Fri, 23 Oct 2026 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792755550;
	bh=IcSLyYnQnVyiersjjKF/SvZDVy3Kk6BBMwm4jll+NFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iT2XDmJOTrOslyxlmZQJ2xXPDNOm2a5z0VR+f0VocZzmfZbT8jHV9Q1k6RMeCLhxY
	 BvEs510wyZYFwIbspVuTC2+qjbbZteazKZE2NqsLK5EidxtZhWo/IrgEkM46vIAMKD
	 gQuV1AvmlVpcKEJTInttXEIruFKVShC480Kp/mB5TYLpzFj6FuBGJZ+5ZXJt89Qhdy
	 N61ySVT0MBJj/hpUsMam2QRb4u3p8MP0KJ3vNlSnDGpvsf2vjR8sZNHznvY3y3vScZ
	 J2JmsKBsZqofVetvePmTrjTarPf/A1ChoWeDNQEA+FPJJIifEroQVujGO8NAN6NMVY
	 bm52xkHtPkUBg==
Date: Fri, 23 Oct 2026 13:38:59 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <attGeq4iGoQ_i9dQ@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
 <atpyCU3fDyU95hbY@debian>
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
	protocol="application/pgp-signature"; boundary="oqugeyshl7gyv6bo"
Content-Disposition: inline
In-Reply-To: <atpyCU3fDyU95hbY@debian>


--oqugeyshl7gyv6bo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <attGeq4iGoQ_i9dQ@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
 <atpyCU3fDyU95hbY@debian>
MIME-Version: 1.0
In-Reply-To: <atpyCU3fDyU95hbY@debian>

> Date: 2026-10-22 22:38:12+0200
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
[...]
> No, it doesn't lose data.  My proposal is to have this:
>=20
> 	struct my_seq_buf {
> 		// .buffer points to the start of the buffer
> 		char  *buffer;
>=20
> 		/* .p points to the current position.  This is the last
> 		 * '\0' that has been written to the buffer.  On
> 		 * truncation, it is a NULL pointer.
> 		 */
> 		char  *p;
>=20
> 		/* .end always holds ARRAY_END(buffer).  It is a pointer
> 		 * one-past-the-last character in the buffer.
> 		 */
> 		char  *end;
> 	};
>=20
> This would be initialized as (of course, wrapper in static inline
> functions as needed) this:
>=20
> 	char            buf[100];
> 	struct seq_buf  b;
>=20
> 	b.buffer =3D buf;
> 	b.p =3D buf;
> 	b.end =3D ARRAY_END(buf);
>=20
> Then, you would write to it as:
>=20
> 	b.p =3D stpecpy(b.p, b.end, "foo");
> 	b.p =3D stpecpy(b.p, b.end, "bar");
> 	...
> 	b.p =3D stpecpy(b.p, b.end, "baz");
> 	if (b.p =3D=3D NULL)
> 		goto fail;
>=20
> Then, at some point, you might want to initialize a new buffer out of
> the remainings of it:
>=20
> 	struct seq_buf  b2;
>=20
> 	if (b.p =3D=3D NULL)
> 		goto fail;
> 	b2.start =3D b.p;

We can actually avoid this error by setting up the new buffer to have an
empty string if the parent buffer overflowed:

	b2.start =3D b.p ?: b.end-1;

This is probably related to that empty string that has been showing
in seq_buf when the string had overflowed, except that here we don't
need to point to a new string, but can reuse the old buffer always.

b.end-1 is guaranteed to exist and point to an empty string if b.p=3D=3DNULL
because b.buffer must come from a real array with at least 1 element,
and the last element must be a '\0' if the string has overflowed
(actually, truncated).


Have a lovely day!
Alex

> 	b2.p =3D b.p;
> 	b2.end =3D b.end;
>=20
> See how simple this becomes?  (So much that you may doubt the necessity
> of the set of APIs at all, but they don't hurt much either.)
>=20
>=20
> Cheers,
> Alex
>=20
> >=20
> > -- Steve
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--oqugeyshl7gyv6bo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrbR0wACgkQ64mZXMKQ
wqn8wg/+JwZwbgZHdogknBMXq+EuRjfkfHcqy3EWKgEz18VoLqyjFjAnCyIp3Efs
67ZkySiDjeV8dXvdfQvwUuVYiaLEa/bCdDzcDxSbdqpWrvX1K9Cy7Y/CWm6W4hTq
SPm4liiM6PQdc5hdrsruB5vxfyYhTYoNWGPdmgzknsntB/kHqL+5Q05UtG8sY/7b
ERvdobT7pNV0GmF5x/x01YSq67Y63W1kO54iAlz+dGrwVeP1qhA5X1ly8tjXuHOK
ocg5ws0yyIx+HLJLVAbDD3OAouQKclDHNK1sObl7U9OsQ6yqQaWSaT0SQV1uIwqB
/Tg0tnZ9NWGw2dImmyQ/1dEvH+7J9d/6GeAT/7B/PJdK9bYnhZaYVLifvxhmiifd
xAgFbacE8498YTkrmeSrFI1lh/7sYYUItnUJgDMDWVskOVLXktT+LPb1Zrs6CeM0
SjCxSHB2d2VollqWVev2Aee5EvvOCVmeDSPviqpv1S6lVgW8nTE/tzqIR6gUrSiq
bLczAPkqn6kPb/0/2gg9M4KJv9OOqXu3Ej2R4oHcGekUU4rKOadUxoQqmMbzFGI9
rijhqs7JseeWlzTPxy9JzcaoL/Hj2CyXA55iLD+IOoK/I2uyD0TLmNEIV/yJLpfl
iLsw7Bv8YitAQOr2qYTfRPt0i3fVyQQfL6vkBjB0RsaiGHuujdE=
=U7V2
-----END PGP SIGNATURE-----

--oqugeyshl7gyv6bo--
