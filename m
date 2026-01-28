Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B723F26A
	for <linux-hardening@vger.kernel.org>; Wed, 28 Jan 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613671; cv=none; b=HgbOtca/JWiiOIr51l1EvReq+LqYrCL0P5eI9zHxdVCceHi1JjAUUQhx77S+RHMs4LRA0PhBWLEI8NcjhvLRoUzQG44J1Yzd5vIKn1n/MT2b+1kjqSXVWX27ba0jDgh3/J7DKw8yReMGzT6+WMLwWpOMba5xk2XC5EjCIvAkIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613671; c=relaxed/simple;
	bh=fi2Lg3B5iuJoikewkJvbVtY7PqbXsf35y/loGOxJF/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFopHrcZjCRa2aTKy2GV4bHUVf858Y2MXuk9JXXRt/ZYF3ZGiUao8w9iYDaWO/LIgc02MMSp5qLWvkhQ15MWUuBCv5a1au2V8T1GfLQlIIbQ5GJR1OOnGn+zupBzpA5Ziu4qRGPqOVBUmSNCsbvH04PN768yBffe+zzuiJfwsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owPUep1q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owPUep1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56019C4CEF1;
	Wed, 28 Jan 2026 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613670;
	bh=fi2Lg3B5iuJoikewkJvbVtY7PqbXsf35y/loGOxJF/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owPUep1qRgu/HvnIAt0c9l6NbEhIg4CsqcbeDPgQKouW8s/beiBQPIwvFT/HOkbEi
	 Ww/n2b0+/5CuGLPNRurAwTADm8bP7YrBbpC5a7agVzyvrwEJI3cinXkX963Wvavg4o
	 LDT3krAGmM+h8p0IVwSgKATMqco5gLTyZ2KLyFd/bcOlfGe9Zh3tcMSqYspZWXirLM
	 Y7uR0Rugtu2tRVcjOhal0Y5oU7qL6KxG8y/6K/LjKJU+oVohk78vAxg/xNKxXVpiYp
	 M7ynWIe0KFCsizz0A8eC8ubnoyTe+Xf9o4lnf84BDDjvhb/y3QkIrXE9iJRZC/zRUR
	 2nGupyUlM0I5w==
Date: Wed, 28 Jan 2026 16:21:03 +0100
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
Subject: Re: [RFC v3 5/6] alx-0081r2 - array parameters of 0 elements
Message-ID: <aXooSDxHbpewFzgQ@devuan>
References: <aXdhh1r7ePA5SrIE@devuan>
 <aXdiyLn3vxV2P807@devuan>
 <aXnhf9uAvyJbQfcn@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v5rvizuwledlu5qd"
Content-Disposition: inline
In-Reply-To: <aXnhf9uAvyJbQfcn@aspen.lan>


--v5rvizuwledlu5qd
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
Subject: Re: [RFC v3 5/6] alx-0081r2 - array parameters of 0 elements
Message-ID: <aXooSDxHbpewFzgQ@devuan>
References: <aXdhh1r7ePA5SrIE@devuan>
 <aXdiyLn3vxV2P807@devuan>
 <aXnhf9uAvyJbQfcn@aspen.lan>
MIME-Version: 1.0
In-Reply-To: <aXnhf9uAvyJbQfcn@aspen.lan>

Hi Daniel,

On 2026-01-28T10:14:23+0000, Daniel Thompson wrote:
> On Mon, Jan 26, 2026 at 01:49:16PM +0100, Alejandro Colomar wrote:
> > Proposed wording
> > 	Based on N3685.
> >
> >     6.7.7.3  Array declarators
> > 	@@ Constraints, p1
> > 	 In addition to optional type qualifiers and the keyword static,
> > 	 the [ and ] can delimit an expression or *.
> > 	 If they delimit an expression,
> > 	 called the array length expression,
> > 	 the expression shall have an integer type.
> > 	 If the expression is a constant expression,
> > 	-it shall have a value greater than zero.
> > 	+it shall have a nonnegative value.
> > 	+An array length expression
> > 	+that is a constant expression with value zero
> > 	+shall appear only in
> > 	+a declaration of a function parameter with an array type,
> > 	+and then only in the outermost array type derivation.
>=20
> This change did not have any motivating example within the discussion.
> Providing a motivational example showing why it is useful to allow array
> parameters whose constant length is zero would be good.

Makes sense; I'll add that.

Here's a function that I use in shadow-utils:

	char *
	stpecpy(char dst[], const char end[];
	    char dst[dst?end-dst:0], const char end[0], const char *restrict src)
	{
		ssize_t  dlen;

		if (dst =3D=3D NULL)
			return NULL;

		dlen =3D strtcpy(dst, src, end - dst);
		if (dlen =3D=3D -1)
			return NULL;

		return dst + dlen;
	}

It's essentially the same as Plan9's strecpy(2), except that Plan9's
API has an important bug.

Here's a GCC bug that shows such a use case:
<https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108036>


Have a lovely day!
Alex

> Daniel.

--=20
<https://www.alejandro-colomar.es>

--v5rvizuwledlu5qd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml6KV4ACgkQ64mZXMKQ
wqmf5Q/8DICFnoM8AJshKZo8ERLY+0Vy8QvKC/4pgr4Wz5k2TjpnNIFbInNPvzzD
Rh+susKpP3wZu/kA62GPAZ4ouq9+U4WZjM2RV/lOrreHAsKxOQqkrW6uaAYTR3nq
VmyZR/7DomckIULff+LQVx/qkHM4NYT9U+wxA+V82SPDL1vvEe4a6O3NkHXjiAV0
Pxv+SRvXnNTTGlnI5QbzWsRJ/bUgSbc+p6xZfGTNU2r4IhOSZh9qbZkfcDxx/otn
+m/F5sCf/buXea2SDc8XtXNdK1mLkqGkLiwF3g/g8btNKUMPNU39yxIKzGXyPyiC
MOLEnEqPLUg4Xhwr469B1wUIkW4XxHwiqzozdg/QgEdO3a2b9w9G2Z8e8bFQ7pBe
FG5bHw9aXKI/gHFK9Oq4AVOdRLOj+Rfefxvk5I9qZJYiQvO95x/ansCw156BGbFT
t4TvXzKPBjaJr5ZtNKSf3OPXiuresG2OAGQl1h7KvxSlj6NbqujfAl5JVpVO9LZ0
K76useaashS8O4wbyLIzigJRSaX4nwH+HVlBsfuA4HfAeX1ICvbO2DMJMpq4NHKU
aTiXLS6Ci7oW4IRrI5TPbWfC2DaR2gxnqYrAyYkQhD7qOFKe+sBoEgU7CoprqTWn
6zruZY+zsTh5kd/15sDSG9sWxYk2U88HD/6IwksSKElp6GV9bSM=
=Hzg2
-----END PGP SIGNATURE-----

--v5rvizuwledlu5qd--
