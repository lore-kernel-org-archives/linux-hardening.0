Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6301F09A5;
	Mon,  7 Jul 2025 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902155; cv=none; b=g66f+4WyEARGhDzgeGmH9MsJBjKNEhVqKyjAYp8lraIvMOwiXDyvzFdgC6HI6l/o6pTUR6J3FggELCdRzpUgxab39HjS7Ayq5Tv45gLhVVWaCttB/1NaBVm9XVcyHMneY1o6NqF5EixymurjXTRojw6lTkC/pRIVzhn9GoNlPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902155; c=relaxed/simple;
	bh=AdLbot/hnAJAN6GFE+kGXh2wA0pLt+QKlv08iDvj1QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZXFnppKNWLYRp7kheZd4byHm44JNh4WruZVMvF9/WRnJQPZGJs1ZyzsHhPREc7ro7KS3Uwkru+8lgDJq+OX0aHPJ8x+Hq2TaIuUz4+abEHq6qIClGE9iDVeHWkxdRmlqwkkTmqOGcBYV2XAjJM1plwWJHAFq57zIG7pL+ztGUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsZpo71K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsZpo71K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F08DC4CEF1;
	Mon,  7 Jul 2025 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751902155;
	bh=AdLbot/hnAJAN6GFE+kGXh2wA0pLt+QKlv08iDvj1QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsZpo71KuM2i7sesxsQq+1Cwk7tPr+apqbY/hgHH5McCiUZSCWfoit/I/JPnFXLMs
	 R+YzAoLpz30EZvEvcAlf05tlkBw31GOk/60PGjQvDrM8oco3kF0s0OVO+mVOnbOxp8
	 1LqghmNz1y8vOYE4xdj9Oc8ml01nfrW1X/NhmrbgzQoAlBMqb2obcf1H1Zpc1Sz/NM
	 Mb5qGGD87z6n5fuWDbQUrqv6vziqbfVxfLwoy7gzYXJrfFnEKEIPBLTC18AA1X8LKm
	 WIICs5Db/c6KQtCVYnCCdPr1aN/SZ/l0UX+Z3h4qpc8z1g6dn09d6zRDFiUspLVtEg
	 ru7noj4gUyVtA==
Date: Mon, 7 Jul 2025 17:29:11 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Marco Elver <elver@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v3 5/7] mm: Fix benign off-by-one bugs
Message-ID: <gqv533xpsrup3w5zsx7cy22kso2gaooupiuv76y6yonng3qwzl@5rw3ct5gfndo>
References: <cover.1751862634.git.alx@kernel.org>
 <740755c1a888ae27de3f127c27bf925a91e9b264.1751862634.git.alx@kernel.org>
 <CANpmjNNQaAExO-E3-Z83MKfgavX4kb2C5GmefRZ0pXc5FPBazw@mail.gmail.com>
 <aGt8-4Dbgb-XmreV@tiehlicka>
 <g6kp4vwuh7allqnbky6wcic4lbmnlctjldo4nins7ifn3633u7@lwuenzur5d4u>
 <aGvjwDqRP1cPaIvX@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbhruxyunokpupvz"
Content-Disposition: inline
In-Reply-To: <aGvjwDqRP1cPaIvX@tiehlicka>


--fbhruxyunokpupvz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Marco Elver <elver@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v3 5/7] mm: Fix benign off-by-one bugs
References: <cover.1751862634.git.alx@kernel.org>
 <740755c1a888ae27de3f127c27bf925a91e9b264.1751862634.git.alx@kernel.org>
 <CANpmjNNQaAExO-E3-Z83MKfgavX4kb2C5GmefRZ0pXc5FPBazw@mail.gmail.com>
 <aGt8-4Dbgb-XmreV@tiehlicka>
 <g6kp4vwuh7allqnbky6wcic4lbmnlctjldo4nins7ifn3633u7@lwuenzur5d4u>
 <aGvjwDqRP1cPaIvX@tiehlicka>
MIME-Version: 1.0
In-Reply-To: <aGvjwDqRP1cPaIvX@tiehlicka>

Hi Michal,

On Mon, Jul 07, 2025 at 05:12:00PM +0200, Michal Hocko wrote:
> > For the dead code, I can remove the fixes tags, and even the changes
> > themselves, since there are good reasons to keep the dead code
> > (consistency, and avoiding a future programmer forgetting to add it back
> > when adding a subsequent seprintf() call).
> >=20
> > For the fixes to UB, do you prefer the Fixes tags to be removed too?
>=20
> Are any of those UB a real or just theoretical problems? To be more
> precise I do not question to have those plugged but is there any
> evidence that older kernels would need those as well other than just in
> case?

No, I haven't done any checks to verify that this is exploitable in any
way.  I personally wouldn't backport any of this.

About the Fixes: tags, I guess if they are interpreted as something to
be backported, I'll remove them all, as I don't want to backport this.

I guess having them listed in the mailing list archives would be good
enough for speleology purposes (e.g., for someone interested in what
kinds of issues this API fixes).

I'll remove them all.


Cheers,
Alex

>=20
> --=20
> Michal Hocko
> SUSE Labs

--=20
<https://www.alejandro-colomar.es/>

--fbhruxyunokpupvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhr58cACgkQ64mZXMKQ
wqki9BAAvHQwrHaCcDiSxI+2THA4Jsg/vj21yBLhCZwpJ665Fn9zdi+14iteStzZ
mqIseo44SZgGrHHsPB7dnBbSD1nj8P1DY494tgV39/+7Dy+evUvbB9zTvGu8CXGx
Qw64VUZEUhpQtS4Sml+jivrdZAROQJTOc/J6yF/LOVjBQW5mT2mg6ENyUEgsHMse
bVox0YUAo5RhZ+2DThulCBQB0qHwFXnF4askanGgBv+nMYe+se23pDO6mrj1l0Tq
1CoIbUGiM5GSZy1TYOQ1dEBMp7JgKCoqeFzXU2KmlIrHrzOepKF8dDYVO3NckVBE
pIsO+M05rXJEPBu1hGAClXQLzOXbasyB+Vp52xla7H3w6BKxaKWHQXglFNkxraZR
gN+GABYRoft0CsWuMMn+Aj3XhC98CjrskYaLglmFpDihpWC56D11zvL3+bKhIUQ7
2rcEqY1t8C00DEhB/e+YdTEfRoAVwMbX2nyU55Nh3Rxo+ZOvF4gWbZMbat0radx/
in5zVJ1LzQZoCgtapxE49ISu+IsxjM9GCuZvZHd+JXIBp4LwQ8HHKF/76bQ3DsBn
dQE5GDHAv7mX/PQR7jkmmcS3FB3yf6liTltATONX4QfAT4qj3fEHEL0/2GrjCoqc
x9vf5ihsa0Krbj3EQjXQ/8IFBXwaIakMfJklw9PLeEfyuSNOWcQ=
=W8Je
-----END PGP SIGNATURE-----

--fbhruxyunokpupvz--
