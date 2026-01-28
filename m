Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C436A015
	for <linux-hardening@vger.kernel.org>; Wed, 28 Jan 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613277; cv=none; b=hT3oDyW3hg248i8YSMjhWF+F0RifBJgI9a75bTwbcx3tL8M54A+mks2EyeWOZoASHlbBTPT17wgut465BlSI20ZcghtAqn8E0cgaR76SUVDehXkpcx6glaJ14QTeHJOnlW8HHBkQV4cP6lNr8XZ57az1DfP2RYzFmOHSW6dr3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613277; c=relaxed/simple;
	bh=MOLQXDzUZkqjdUtCDHkMs77lzzbvmC2r52puoaX6bG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uynrisAHQItQu6i8EQlEvkz5ZswFfLiLOycB+xp1OngxwlR+zJXAieQcqereEl+siJypR0OrPEvmKdjOXxKFhLMEP0QuWZI0+7RBhr7RudaArDzOfjrQwKYPV3XElly8lj+BbQHIU0DW3/MdXSgoUa6SOLe9fYXvMYVwlD+pQYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWmC9drD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWmC9drD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B573C4CEF1;
	Wed, 28 Jan 2026 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613277;
	bh=MOLQXDzUZkqjdUtCDHkMs77lzzbvmC2r52puoaX6bG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWmC9drDfGqFKPS0VS0b9+VUMnZJHfkf/qh9FmOC5h8uFLIG4pzNH/sxrb3PYbLKi
	 vXNcx2HXjjSV52dimXkMNg/cH1JJJHmKawDIIqezHz9bD8XUY8lMGGY3/Sfubq4WA2
	 MYK85npwvyIxx4zvLAHk04IQ4hj4HZaFwgEC7uwR6WRCmmUgJANX1hK+2BzlWwaEDe
	 8xTWO+41HYJxe0JSq74v2cdJ2Y8w4Ub9lBNPtZ66e193M9mztdzvIg6ba342hRQjzS
	 ND1K8DNa2wKsp1KEvfek7Y/dRK+tiZ4RB7+c622yzwX2kMMqxwJeaiwK1bunwTUlxF
	 colK4QYHUEOcg==
Date: Wed, 28 Jan 2026 16:14:30 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Martin Uecker <uecker@tugraz.at>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Alex Celeste <alexg.nvfp@gmail.com>, 
	Joseph Myers <josmyers@redhat.com>, Aaron Ballman <aaron@aaronballman.com>, 
	Douglas McIlroy <douglas.mcilroy@dartmouth.edu>, Bruno Haible <bruno@clisp.org>, Paul Eggert <eggert@cs.ucla.edu>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Daniel Lundin <daniel.lundin.mail@gmail.com>, 
	"Valentin V. Bartenev" <vbartenev@gmail.com>, Andrew Clayton <andrew@digital-domain.net>, 
	"Brian W. Kernighan" <bwk@cs.princeton.edu>, "G. Branden Robinson" <branden@debian.org>, 
	"Basil L. Contovounesios" <basil@contovou.net>, "Jason A. Donenfeld" <jason@zx2c4.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, onf <onf@disroot.org>, Rich Felker <dalias@libc.org>, 
	linux-hardening@vger.kernel.org
Subject: Re: [RFC v3 3/6] alx-0078r2 - [static n] shouldn't access more than
 n elements
Message-ID: <aXokQWyS2dfm3K2A@devuan>
References: <aXdhh1r7ePA5SrIE@devuan>
 <aXdirEZVgj8PKPxM@devuan>
 <aXnc3aeRq045FWZy@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dsemwwf2nhlzanwn"
Content-Disposition: inline
In-Reply-To: <aXnc3aeRq045FWZy@aspen.lan>


--dsemwwf2nhlzanwn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Martin Uecker <uecker@tugraz.at>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Alex Celeste <alexg.nvfp@gmail.com>, 
	Joseph Myers <josmyers@redhat.com>, Aaron Ballman <aaron@aaronballman.com>, 
	Douglas McIlroy <douglas.mcilroy@dartmouth.edu>, Bruno Haible <bruno@clisp.org>, Paul Eggert <eggert@cs.ucla.edu>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Daniel Lundin <daniel.lundin.mail@gmail.com>, 
	"Valentin V. Bartenev" <vbartenev@gmail.com>, Andrew Clayton <andrew@digital-domain.net>, 
	"Brian W. Kernighan" <bwk@cs.princeton.edu>, "G. Branden Robinson" <branden@debian.org>, 
	"Basil L. Contovounesios" <basil@contovou.net>, "Jason A. Donenfeld" <jason@zx2c4.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, onf <onf@disroot.org>, Rich Felker <dalias@libc.org>, 
	linux-hardening@vger.kernel.org
Subject: Re: [RFC v3 3/6] alx-0078r2 - [static n] shouldn't access more than
 n elements
Message-ID: <aXokQWyS2dfm3K2A@devuan>
References: <aXdhh1r7ePA5SrIE@devuan>
 <aXdirEZVgj8PKPxM@devuan>
 <aXnc3aeRq045FWZy@aspen.lan>
MIME-Version: 1.0
In-Reply-To: <aXnc3aeRq045FWZy@aspen.lan>

Hi Daniel,

On 2026-01-28T09:54:37+0000, Daniel Thompson wrote:
> On Mon, Jan 26, 2026 at 01:48:49PM +0100, Alejandro Colomar wrote:
> > Name
> > 	alx-0078r2 - [static n] shouldn't access more than n elements
> >

[...]
> > Abstract
> > 	The following function prototype requires an input with at least
> > 	2 elements:
> >
> > 		void f(int a[static 2]);
> >
> > 	It should not use more than 2 elements, as those are not
> > 	guaranteed to be available.  That is, the following function
> > 	definition should be unacceptable:
> >
> > 		void f(int a[static 2])
> > 		{
> > 			a[7] =3D 0;
> > 		}
> >
> > Discussion
> > 	It is a de-facto standard that functions declaring a [static n]
> > 	parameter require at least n elements, and don't access more
> > 	than n elements.  Most programmers that don't know the fine
> > 	letter of the standard would assume that.  This has its roots in
> > 	the older syntax, [n], which is not acknowledged by the
> > 	standard, but has been historically used to document this as
> > 	part of the API.
> >
> > 	Without this, [static n] is only useful for optimizations, but
> > 	not for writing safe code, as the specification of [static n]
> > 	doesn't provide the compiler with enough information to know
> > 	whether array bounds will be violated.  This makes it a terrible
> > 	UB foot-gun.
> >
> > 	Let's change the specification to make it safe.
>=20
> I don't see how the proposed wording change makes C safer, see below.
>=20
>=20
> >     <snip>
> >     6.7.7.4  Function declarators
> > 	@@ Semantics, p7
> > 	 A declaration of a parameter as "array of type"
> > 	 shall be adjusted to "qualified pointer to type",
> > 	 where the type qualifiers (if any)
> > 	 are those specified
> > 	 within the [ and ]
> > 	 of the array type derivation.
> > 	 If the keyword static also appears
> > 	 within the [ and ]
> > 	 of the array type derivation,
> > 	 then for each call to the function,
> > 	 the value of the corresponding actual argument
> > 	 shall provide access to
> > 	 the first element of an array
> > 	 with at least as many elements
> > 	-as specified by the size expression.
> > 	+as specified by the array length expression,
> > 	+and the function definition
> > 	+shall not access an element
> > 	+beyond the specified number of elements.
>=20
> By limiting what the function definition may do, we are reducing the set
> of valid programs. Won't that *increase* the level of undefined
> behaviour in the language?

Yes, this proposal increases --at least theoretically-- the amount of
undefined in the language.  See below for why I say "theoretically".

> That will allow compilers to perform more aggressive local optimizations
> (which is probably good) but I don't see how it will make things safer.

Yes, that's true.  On the other hand, nobody is forcing compilers to
abuse UB to perform aggresive optimizations.  They may choose to refrain
=66rom certain optimizations, and instead use the information exclusively
for diagnostics.

> To make things safe would mean compilers changing their diagnostics, and
> the prior art suggests compilers already warn on this.

GCC has partial support for this, precisely because it ignores the
specification of the standard, and de-facto considers this to be the
meaning of [static n] (and also of [n], FWIW).  GCC support for this is
incomplete at the moment, though.  But in the long term, yes, GCC
intends to diagnose like this.

On the other hand, Clang implements this per the C standard, which makes
it a quite bad implementation regarding array bounds.

	alx@devuan:~/tmp$ cat ap.c=20
	void f(int a[static 2]);
	void f(int a[static 2])
	{
		a[1] =3D 0;
		a[2] =3D 0;  // UB
		a[3] =3D 0;  // UB
	}
	alx@devuan:~/tmp$ gcc -S ap.c -Wall -Wextra
	alx@devuan:~/tmp$ clang -S ap.c -Weverything
	ap.c:4:2: warning: unsafe buffer access [-Wunsafe-buffer-usage]
	    4 |         a[1] =3D 0;
	      |         ^
	ap.c:5:2: warning: unsafe buffer access [-Wunsafe-buffer-usage]
	    5 |         a[2] =3D 0;  // UB
	      |         ^
	ap.c:6:2: warning: unsafe buffer access [-Wunsafe-buffer-usage]
	    6 |         a[3] =3D 0;  // UB
	      |         ^
	3 warnings generated.

-Wunsafe-buffer-access is just noise.  Nothing is diagnosing the case
shown in the abstract.

The case shown in the 'Prior art' section is only diagnosed by GCC.

So, this proposal would force Clang to diagnose what GCC already
diagnoses.

About why this increase in UB is only theoretical: programs violating
this *already* have UB (with 99.99% certainty).  The UB is just not
visible to the compiler, but the program is already overflowing buffers
most likely.  By making that UB visible to the compiler, we increase the
chances that it will be diagnosed.  So, I'd say I'm not adding UB, but
rather moving it around to show up earlier.


Have a lovely day!
Alex

> Daniel.

--=20
<https://www.alejandro-colomar.es>

--dsemwwf2nhlzanwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml6J9AACgkQ64mZXMKQ
wqmqxhAAj7pCVHhDs2eZBHro3GSc3J5UW/s1DLjiO6WWGCm3Ytq6CXHWNWUbVtns
48JkAod9b9Yc21TMgssvXNl3Bmp5Vqs7LG/h7939iHMeWzy1nVF4AH5BkqWA/MIk
56YZJVyFbitbp7N+GqfV9IcCbwrbHZXGm2pC8S+WP3Il5O9CxmH5m6c6k/p8NlXS
HRd5DvsYv8tE+TDfHILGJ8H0byL/CLbJ1RcqVx9U3boVoHJBaVsSvWBtG4BcbT/i
WRPFuY36PoIZtCp9M72ejYmuF/nf63rGqqBLH91w8fMFXZ+TbwDGHjWYpLqyqFBv
mQAFwGY3ZZUdOL5Kx5Hvt0QzptqV4mWYD6VJcFZZgA8vs81Xf1MInO566LquhmBZ
LOMs1Lw5ZdPtWn41q+sXh4UCJSCOohKgXzuc5a7yRkKxbLBgGPyB65o+GsA5rNxn
RAXiyhNR9EMfDITwrb2cwoSW70KwQ3OIFqij3UyF20oLYqCm6Z7D+JNrSffzXbB+
oKspwBm5N7F0/SIiU2p9lpM7e776ddUfBUC9Jdw4496RJZkCx8A8Mu8gzgSCzidn
micGN4+xvwjq+pbLknj3HoLXwb1QTLFRCnANiF8r041E/pMZK5EyGRrYlB+4tcbx
FB25KFeNenCbmWdVLjs8bkZ2RYXquIXvPyQqvUWJsXgH0kPhXbM=
=M8WY
-----END PGP SIGNATURE-----

--dsemwwf2nhlzanwn--
