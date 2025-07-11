Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BA2AEF1;
	Fri, 11 Jul 2025 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261448; cv=none; b=t0MoG2/p+A2WY3teTwZnJCP9EznbV6uh4rh6SfYlBhzf6YKLHHQKJynRBCDlfos7d6uWO/6pROWHQKgLT5NDpREuPkYaeAYgTDIg9fvpe1M/Kz2TVVJZPYAm8BxyddpqlreEJ0Ptrdze9cnkWwvkA9WO2ccj9oJeJoMZ+ZILgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261448; c=relaxed/simple;
	bh=cnwXPm+/VNTBwjjvNe6tPqkD4dF66c733bbdlBZZNUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECXrJtPRppgjGzD3ZyXk6bNOLkQm6zgscr3PqO3b3eveLgvMdiDhnpsHh3Yj+Rk0Vgc97Yc4sGz9gvr1hkMM4D8WFFdasE8mzQkQcHFF0pbt7kfEKa2S1IW+Kz1Kyo3m9sNVY/dmxuaqWMlT36147xCaAYDJLaVqmSFxPYlK8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqcQoHXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqcQoHXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C1DC4CEED;
	Fri, 11 Jul 2025 19:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752261448;
	bh=cnwXPm+/VNTBwjjvNe6tPqkD4dF66c733bbdlBZZNUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqcQoHXnKdfggPdW7n5guANWD5ndb/jrsaz0GwPn5c+oGfLUKx+9N7vGNViLnCx5N
	 F7BUqiwvDjP8Zzpee2lr+F859rAMzUuuAgSbqTAkv0T2d9QD3Rb4kFpWpOTIHdjYm8
	 s0iOvroIM2aLuCx0Eg1Ed9ScxbfgrTexwAq0T/waNzFZCjp5LzYaRx+YT1At69tAQg
	 JJ4ujuJGGiJiTedoUkN2tjfeM6cnKF7bq1h0AsFw4dBVd1/PtZmHbnCLLFgxIxc928
	 rszWuN431xni2f8dJtz31gaRi3voyVeL3TIX9OFFv5fPrulYxjYYgh3/Z6SUu1Cn0i
	 0gKNswrayJzuw==
Date: Fri, 11 Jul 2025 21:17:20 +0200
From: Alejandro Colomar <alx@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <uipobgcwwyzsq5dtq3wf6haoae7zgwjfefokbwx5nx6wfx5uq2@vgpl36ryhkel>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
 <20250711184343.5eabd457@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="744n7ojxglqyswg3"
Content-Disposition: inline
In-Reply-To: <20250711184343.5eabd457@pumpkin>


--744n7ojxglqyswg3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
 <20250711184343.5eabd457@pumpkin>
MIME-Version: 1.0
In-Reply-To: <20250711184343.5eabd457@pumpkin>

Hi David,

On Fri, Jul 11, 2025 at 06:43:43PM +0100, David Laight wrote:
> On Fri, 11 Jul 2025 01:23:49 +0200
> Alejandro Colomar <alx@kernel.org> wrote:
>=20
> > Hi Linus,
> >=20
> > [I'll reply to both of your emails at once]
> >=20
> > On Thu, Jul 10, 2025 at 02:58:24PM -0700, Linus Torvalds wrote:
> > > You took my suggestion, and then you messed it up.
> > >=20
> > > Your version of sprintf_array() is broken. It evaluates 'a' twice.
> > > Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> > > argument. =20
> >=20
> > An array has no issue being evaluated twice (unless it's a VLA).  On the
> > other hand, I agree it's better to not do that in the first place.
> > My bad for forgetting about it.  Sorry.
>=20
> Or a function that returns an array...

Actually, I was forgetting that the array could be gotten from a pointer
to array:

	int (*ap)[42] =3D ...;

	ENDOF(ap++);  // Evaluates ap++

Anyway, fixed in v6.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--744n7ojxglqyswg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhxYzoACgkQ64mZXMKQ
wqkjfQ/7B1Jy0fUNlWDy/S4747BI6FB8QvtJDXSmUh+9JUnYeA3/UC+7bZqstMwk
GNhbO5oX4r84xDPdJIpjEtKv7qkA9VkBWVG13PS6irDPYfqXblRyzEV6U9bissR2
Qc+WUC7mmpZvUXCjQXyVTsw4SHsfot41d2A+45wpof5Nc3lZXgzQD4Z56iH9PV6Z
/iyu8MGKu+eiso+/DaPStdC7xXj3acrjZK2L+JUuVmq28TBJnRcl6cUsvZITFg69
rq/XCYTJGjMEa9tLrn51Q2/TNTV+okSrLJl+0txHm1vCsVZ9L+GJ8VTIMkhAZft6
m3nYday4EgSz7QXrXYvj/LcpVfwrMRosgiEfHY4zL/7V55sObXyhrukHIpyaUfxu
q9E2T9FertPMmgKdNSadfJSht+uoRR8evxf8Xtry13aUqi7E3tIGL8/tCymdZAPq
6nANf7I8A8m/FBAMVtyg0mZS233L0oRG4hhWcG+umzzH6wwX9fDdNpB4X0FQMRJG
32U3uJbXK6GKcKU+igB9QpTW1DZlqXIGpT3rfLMweKoXOtfyNzZs51g7DMzVoYWh
Gl2Y0AO/rvYjwKhQydwVxukWpdtqJ9j3wiegSl2EKQx+4nZH0z7eKiRvOaG1N0TO
wEFZe8rebmqPxSLrJX6mKcTvOfvU4+5y/tStHrgRZ2ONh5BiGsg=
=Ka9G
-----END PGP SIGNATURE-----

--744n7ojxglqyswg3--
