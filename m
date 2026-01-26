Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718A78F26
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431690; cv=none; b=HdK+G7rRZ3DBctUgoeU43oizOrXRB6joQGjdqdjWUDpuZH5HBDN4dAy6mOgb/jcKiybP4NZbIgeGeRrCri7E+wHz/H/jzg00KjNmBmTvV+5xKEvDWvaVoG7tk/BLLtJfEmBI34wiuNg6sLpuciE9/In9MDsN/FF3pePBCECSGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431690; c=relaxed/simple;
	bh=4rTmA9C70hSbbMSdodcOUVf+U4uuXcOs5Q2flQQs0xw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l7TPOAASqmBPUBXq4HhA9uGoD2usKThf6Ej6cjATmnjo6seJhzQnBLnwJjJcpEJqUjQMQmz7mg08q57/FpHBEMlu7LyKewIWzbYuGqq6scSz/9isd8tGJCjijz4NJwnx5zL8S2ZRIAhe1C15xdMJ8WZVOBbC9oljjW6y6LAlM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oav+05fg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oav+05fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBA6C116C6;
	Mon, 26 Jan 2026 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431690;
	bh=4rTmA9C70hSbbMSdodcOUVf+U4uuXcOs5Q2flQQs0xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Oav+05fgF+rDxbDtymgz7hUOCAcAvw2xqcbiAcLyZEl8eXnWjjarnSBW+37YxYB7o
	 eBRBB87ARsnj2bwvDENAeplf86KxXykQIQk2jHVsIcvOaXM7rsnRqbmvJ9Co7MR+iy
	 93yUbHyxkQjGHuNYrxxOCk+ADiVga5rNdmTCNsHubT3/IDnp7KEMF5rgaf+k8wV+E3
	 aaoy5XIjSpzeFkdphELmY9zOByRosG9UKDSeQKlJ2umqp9VSil4YY/qSPnfWfmolM7
	 Hdq/nwSJHBkuCxOF9J55AHfB3mr/zTDxtEWyjgUr/NYz0rk28bUXLEfDS3j/o28SqQ
	 h2w3qOh4Sw6vQ==
Date: Mon, 26 Jan 2026 13:48:03 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Martin Uecker <uecker@tugraz.at>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Alex Celeste <alexg.nvfp@gmail.com>, 
	Joseph Myers <josmyers@redhat.com>, Aaron Ballman <aaron@aaronballman.com>
Cc: Douglas McIlroy <douglas.mcilroy@dartmouth.edu>, 
	Bruno Haible <bruno@clisp.org>, Paul Eggert <eggert@cs.ucla.edu>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Daniel Lundin <daniel.lundin.mail@gmail.com>, 
	"Valentin V. Bartenev" <vbartenev@gmail.com>, Andrew Clayton <andrew@digital-domain.net>, 
	"Brian W. Kernighan" <bwk@cs.princeton.edu>, "G. Branden Robinson" <branden@debian.org>, 
	"Basil L. Contovounesios" <basil@contovou.net>, "Jason A. Donenfeld" <jason@zx2c4.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, onf <onf@disroot.org>, Rich Felker <dalias@libc.org>, 
	linux-hardening@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
Subject: [RFC v3 0/6] Improve function parameters in ISO C2y
Message-ID: <aXdhh1r7ePA5SrIE@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kehseianhzdrhkv2"
Content-Disposition: inline
In-Reply-To: <aXZM5O2mU2e3LJBJ@devuan>


--kehseianhzdrhkv2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Martin Uecker <uecker@tugraz.at>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Alex Celeste <alexg.nvfp@gmail.com>, 
	Joseph Myers <josmyers@redhat.com>, Aaron Ballman <aaron@aaronballman.com>
Cc: Douglas McIlroy <douglas.mcilroy@dartmouth.edu>, 
	Bruno Haible <bruno@clisp.org>, Paul Eggert <eggert@cs.ucla.edu>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Daniel Lundin <daniel.lundin.mail@gmail.com>, 
	"Valentin V. Bartenev" <vbartenev@gmail.com>, Andrew Clayton <andrew@digital-domain.net>, 
	"Brian W. Kernighan" <bwk@cs.princeton.edu>, "G. Branden Robinson" <branden@debian.org>, 
	"Basil L. Contovounesios" <basil@contovou.net>, "Jason A. Donenfeld" <jason@zx2c4.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, onf <onf@disroot.org>, Rich Felker <dalias@libc.org>, 
	linux-hardening@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
Subject: [RFC v3 0/6] Improve function parameters in ISO C2y
Message-ID: <aXdhh1r7ePA5SrIE@devuan>
MIME-Version: 1.0
In-Reply-To: <aXZM5O2mU2e3LJBJ@devuan>

Hi!

I've written a set of drafts for proposals for ISO C2y.  Each of them is
minimal, and they all together vastly improve the specification of
function parameters (especially those declared with array type), with
the purpose of increasing the safety of the C language.

Please review these proposals, and comment any feedback (including any
other related proposals you'd suggest).  I'll try to incorporate
feedback before publishing these as N-documents (in a week or so).  Feel
free to publicly express approval with tags such as 'Acked-by:' or
'Reviewed-by:', which I'll incorporate in the proposals, which will
signal the committee that users are interested in the changes.

This 3rd revision is posted in the linux-hardening@ mailing list
(previous iterations were offlist).

I'll send the proposals as replies to this email, as if it were a usual
patch set.  List of draft proposals:

	[RFC v3 1/6] alx-0077r3 - disallow function parameters of function type
	[RFC v3 2/6] alx-0076r3 - incompatible array parameters
	[RFC v3 3/6] alx-0078r2 - [static n] shouldn't access more than n elements
	[RFC v3 4/6] alx-0079r2 - [static n] =3D=3D non-null [n]
	[RFC v3 5/6] alx-0081r2 - array parameters of 0 elements
	[RFC v3 6/6] alx-0080r1 - [static] without array length expression


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--kehseianhzdrhkv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml3YnwACgkQ64mZXMKQ
wqmrGxAAnB2CaY3XqxCqspOC9whu+JWv0PlojtlegZV/BVeh8ykHSc+IzUL0kCZB
Sd8jiPPFGpqNQblzGHAM+pifeaoEUsupAsmF6hpxcCn2eOOwGPBtWT2PPNR49rLH
E+5Ct0nlsu358PRbYZQI3uGrXSNFc5mz41JCP1AbRHKOL0P4CmcUgGc9zMB/7Ofr
uObtPYAVHAAR6qkdwNRBQ05PeOOjwrX5ADPFZm33iV/j2+rREwDpyTvOy6vXSXf8
5QxlLdK94ukD7HaB+sPWD0Woq7JHwKTQtp7j/iHdnt026NK0ttp57vvZStr7HTJf
/CfxJgXP6YueT6qOaOO1USkMrIA1ZhbAYhDLrqL/vuAeP59yUMXirVavKG3F9GZc
Zx0bviMA6Teo2EECNO87z9ET3y1YLp2W4yhczjtRBOAQ8xPydKGekTchg3SBAbS9
qsEM1UdYDFeEAH2pTehXPTR9fhgIleCcqBCJHDWxFvRJkrj3FJG+lcNtm74LyJTC
qohxktHo2D6RBeu539zkm5COBB/g4/b+6GciOemM+dOcowgh4YwqmyLurh+QyoeO
TPyO6IV8d2aFMLVQY6HHXDb3cPlhO0UuBJDFIt6ZFZCFfWIcqI4nMaJmV97fb1Na
/jfi64HwSwDwWVgCblTSF0Gq0mjdEOdJlFe4Bg7sP+aLdStKKrs=
=tkko
-----END PGP SIGNATURE-----

--kehseianhzdrhkv2--
