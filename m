Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81322338;
	Thu, 10 Jul 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182495; cv=none; b=O/9DB5ewPNVYabaiBFrVfPGv0chpjfIOmlgvik6EvDasNVwD5dgP39n8OAW/ct4gQAFwKck2GocK6fSX5PwrbBQi5aaur/mn7pmLMYcR/ufV/1JkAlYl7t8rw7zvA6C0s4cV5zkw10BK2YeRsHa7F6UnJV6I0PN9yTzG3DvxcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182495; c=relaxed/simple;
	bh=f4dUVXALsAYXTk+NKQ03a6GOt4JCMgbf8SSf+frc2Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGjPeXbdhXGl6BN8h8iELxx8IkOPKaglomQdVi5bpqQWc8CkJ+XBOcYghgGcvVk11hdLUogQd3/NHzmwopItDT430DsYbVN0SaMVSKGWmbant7oV6BP9GTxqRblvFWqBhwm5oWfciMDoqbZ8pUwIjqB5MlEV2s4necCMuR3qmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj450Crq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj450Crq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213A6C4CEED;
	Thu, 10 Jul 2025 21:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752182495;
	bh=f4dUVXALsAYXTk+NKQ03a6GOt4JCMgbf8SSf+frc2Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gj450CrqRm1IIoaIZ6Ao9BQGP3GXe2Ay3WiAmPp7j3VkZxQ/GWD2Pe8ctq4sv4tKT
	 vnD7/mJjWXKUag5QerCCfnVpFIkjODzwV023Y9rUj8WVad8afw6zOa5bCW/U4LOea5
	 aRH2eIh3XSsqOY9TFgRxlaXUax4fRE3gAAlZJI4zVU6SqiQtqSyZTR0F/nL7jXS/LF
	 KfK+iykaKTDSODNqzmHsO/pPbmLuwnYA5t4EIJmzBJdvxNpm0BspuJ1PqW3wA3LFS/
	 3LqmuRvkzkRfmnOOEi8Ndjw+2e8kasECXxt2pqQTaIi2PNznXOds/WDYNsHapsq1mM
	 VoQe+suzA6P2A==
Date: Thu, 10 Jul 2025 23:21:28 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
Message-ID: <yxa4mb4tq4uamjc5atvhfefvxyu6fl6e6peuozd5j5cemaqd2t@pfwybj4oyscs>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752113247.git.alx@kernel.org>
 <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
 <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
 <svune35mcrnaiuoz4xtzegnghojmphxulpb2jdgczy3tcqaijb@dskdebhbhtrq>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7rucxqy6jxtw6lim"
Content-Disposition: inline
In-Reply-To: <svune35mcrnaiuoz4xtzegnghojmphxulpb2jdgczy3tcqaijb@dskdebhbhtrq>


--7rucxqy6jxtw6lim
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752113247.git.alx@kernel.org>
 <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
 <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
 <svune35mcrnaiuoz4xtzegnghojmphxulpb2jdgczy3tcqaijb@dskdebhbhtrq>
MIME-Version: 1.0
In-Reply-To: <svune35mcrnaiuoz4xtzegnghojmphxulpb2jdgczy3tcqaijb@dskdebhbhtrq>

Hi Linus,

On Thu, Jul 10, 2025 at 08:30:59PM +0200, Alejandro Colomar wrote:
> > IOW, why isn't this just
> >=20
> >   #define sprintf_array(a,...) snprintf(a, ARRAY_SIZE(a), __VA_ARGS__)
>=20
> Agree.  This is a better name for the kernel.

Oops, I misread.  I thought you were implementing it as

	#define sprintf_array(a, ...)  sprintf_end(a, ENDOF(a), __VA_ARGS__)

So, I prefer my implementation because it returns NULL on truncation.
Compare usage:

	if (linus_sprintf_array(a, "foo") >=3D ARRAY_SIZE(a))
		goto fail;

	if (alex_sprintf_array(a, "foo") =3D=3D NULL)
		goto fail;

Another approach would be to have

	if (third_sprintf_array(a, "foo") < 0)  // -E2BIG
		goto fail;

Which was my first approach, but since we have sprintf_end(), let's just
reuse it.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--7rucxqy6jxtw6lim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhwLtMACgkQ64mZXMKQ
wqlldw/9G3vuwHK1ltksLTZk/bAMY1df2lNT+Tnvbn1O60dXRLNSLE1uslMMtt5m
Ch9ME1lm4Z3rjU+EvgVg+CTTUXjmwPBMwC54IX4d55SJPLERcYcjrftC7AkDiaqA
+lHnVLrZzGgcdypVU7sADXi4efbbA2ju7Z9vpmvAivQr8bpP49dsahV/DjjVGOqT
t9ZPfx6FbbGkGbceyVrYVVGdPt+2xRQ1lWAmmNxHvw2s4FPsbX3qTjFzCi3py3jr
YfMncGwTyfeaivqCtayzi4w32hYDAsP6zigcf3ZPv2coww51DP1dnvY8c6CqabF4
SBTYZPtTfbByr/COPxdNvJKqszwUKnuMpbLK0nSXe+zKUJsNGeQfFbg8SWG/AK+P
miRh99ztSOhn13wqYqkJZEpVhPfjDgurEYVN1DeOMMLkvjEThtTF5A5gQebKAe0a
nVxc+0UBwZyJflXngUvrwazrM+20tt+YK992Mgus+1tOcdF3RpphzR6umUkiv6de
pesBSrzjVFdb81e1slMHaPpuouaIcTGHh+wuDSamjx/7Tfi/dUpz1ifa19UdUeWR
4LJMN2FPIW+41OM8WwAppQXwehXlE2gKssUEa6tln4k8Pi/dn6ZZTxh25TPYI0Lc
1O7lU+hNeS52MnpJRCpZpRhhZB0CAfGIFVBGT2EKIFdHWTbT1ho=
=0kpp
-----END PGP SIGNATURE-----

--7rucxqy6jxtw6lim--
