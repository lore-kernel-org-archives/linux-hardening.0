Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8F78F26
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431763; cv=none; b=BMsTtDP3xfSbVLaE0gkPCEAsivZ9/KDpkSbpV/4QoeBpXc0fxJyfXZNINL2O2vgA91H09cqakp12fM2tjNtb1Yd2w7qdXA8mrBWw6XfUL60pu72+YUGFS3jt/qCxuswbKWXI51Taj44eFxnjEDS8tnJADKTfmkwPQvlOoqgIf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431763; c=relaxed/simple;
	bh=9HtGqLlKfftZYVzcBlczjBJD+WQHkJvDWpySMdmD6eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rF5oeyBwlFqeUwV0Zh3pRIbODzjsvgysE9pxSnwagipE6FxT3OqqBF3CvBapGVvpURpbSATGZJHpyGbKdAUTjo0DDB1x1f86XiN5vlfiM+M6RSflL1reZn/QdR9DBkSDD8nij45xe4M1WJCUG9QsOxEauToGDnckLKeE7HBlcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCrVoHqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCrVoHqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABB9C116C6;
	Mon, 26 Jan 2026 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431763;
	bh=9HtGqLlKfftZYVzcBlczjBJD+WQHkJvDWpySMdmD6eQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lCrVoHqCf8QUmMOTgZhQ+UTSO1XfW4phQqRqA4vayXhS6gmjjIXuwAwS2NW+kHkYy
	 0bFNIoLIAdbhlSehBlidH6ACO2DCcxaGKtawT3vEckmqSOXiD2dNREWtYVDNoXTF4y
	 8FImXK4GPZEvbPypeSJTs7Bv3PPSRGvED+SPDSu2sD9dnBElrs6lLoQwFPx7ZWJK01
	 IjbfwoBA6k+ThkvjjiUGpIBTaRYF39MB8wTp6/lJAE15TKWaqqjMx8REUPktMJvV3e
	 tQj3UkRB9emdEA0PULQjMw5lMOwPBk4mXjx/5+cV7g1u9UowyjktJXZzLortV27IBk
	 Ic9sdeFYbgDjw==
Date: Mon, 26 Jan 2026 13:49:16 +0100
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
Subject: [RFC v3 5/6] alx-0081r2 - array parameters of 0 elements
Message-ID: <aXdiyLn3vxV2P807@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="njsnpqzzxxn5y6r3"
Content-Disposition: inline
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>


--njsnpqzzxxn5y6r3
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
Subject: [RFC v3 5/6] alx-0081r2 - array parameters of 0 elements
Message-ID: <aXdiyLn3vxV2P807@devuan>
MIME-Version: 1.0
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>

Name
	alx-0081r2 - array parameters of 0 elements

Principles
	-  Uphold the character of the language
	-  Codify existing practice to address evident deficiencies
	-  Enable secure programming

	And from previous charters:

	C23:
	-  APIs should be self-documenting when possible.

Category
	Language; array parameters.

Author
	Alejandro Colomar <alx@kernel.org>

	Cc: Martin Uecker <uecker@tugraz.at>
	Acked-by: Doug McIlroy
	Acked-by: Andrew Clayton <ac@sigsegv.uk>
	Cc: Alex Celeste <alexg.nvfp@gmail.com>

History
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0081.git/>

	r0 (2026-01-25):
	-  Initial draft.

	r1 (2026-01-25):
	-  Array length expressions shall be nonnegative.

	r2 (2026-01-26):
	-  Acked-by.
	-  Remove 'See also'.

Abstract
	Function parameters that have zero elements are common and safe.
	Let's acknowledge this, and allow array syntax for them.

Discussion
	The following code is valid:

		static inline wchar_t
		my_wmemset(size_t n, wchar_t *wcs, wchar_t wc)
		{
			return wmemset(wcs, wc, n);
		}

		wchar_t  a[42];

		my_wmemset(0, a + 42, L'x');

	It would be natural to be able to declare my_wmemset() as

		wchar_t my_wmemset(size_t n, wchar_t wcs[static n], wchar_t);

	However, that would result in UB for the call above, as the
	number of elements isn't allowed to be zero.  That restriction
	is superfluous, and harmful; let's remove it.

Future directions
	I'd like to allow any arrays of zero elements, but that needs
	to be more careful than for array parameters.  A future proposal
	will address that.

Comments
	On 2026-01-25T18:19:02-0500, Douglas McIlroy wrote:
	> All six proposals look eminently reasonable.  They simplify
	> the language and remove surprises.  I suspect these proposals
	> will invalidate very few existing programs.  In any event, the
	> required corrections will improve the legibility and
	> maintainability of such programs.
	>
	> Doug McIlroy

	---

	On 2026-01-26T02:01:16+0000, Alex Celeste wrote:
	> Like Martin - these all seem eminently reasonable to me.

Proposed wording
	Based on N3685.

    6.7.7.3  Array declarators
	@@ Constraints, p1
	 In addition to optional type qualifiers and the keyword static,
	 the [ and ] can delimit an expression or *.
	 If they delimit an expression,
	 called the array length expression,
	 the expression shall have an integer type.
	 If the expression is a constant expression,
	-it shall have a value greater than zero.
	+it shall have a nonnegative value.
	+An array length expression
	+that is a constant expression with value zero
	+shall appear only in
	+a declaration of a function parameter with an array type,
	+and then only in the outermost array type derivation.
	 The element type shall not be an incomplete or function type.
	 The optional type qualifiers and the keyword static
	 shall appear only in
	 a declaration of a function parameter with an array type,
	 and then only in the outermost array type derivation.

	@@ Semantics, p5
	 If the array length expression
	 is not an integer constant expression:
	 if it occurs in a declaration
	 at function prototype scope
	 or in a type name of a generic association (as described above),
	 it is treated as if it were replaced by *;
	 otherwise,
	 each time it is evaluated,
	-it shall have a value greater than zero.
	+it shall have a value greater than zero,
	+unless in the outermost array type derivation
	+of a function parameter with an array type,
	+in which case it shall have a nonnegative value.
	 The size of each instance of a variable length array type
	 does not change during its lifetime.
	 Where an array length expression
	 is part of the operand of the typeof or sizeof operators
	 and changing the value of the array length expression
	 would not affect the result of the operator,
	 it is unspecified
	 whether or not the array length expression is evaluated.
	 Where an array length expression is part of
	 the operand with a _Countof operator
	 and changing the value of the array length expression
	 would not affect the result of the operator,
	 the array length expression is not evaluated.
	 Where an array length expression is part of
	 the operand of an alignof operator,
	 that expression is not evaluated.

--=20
<https://www.alejandro-colomar.es>

--njsnpqzzxxn5y6r3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml3YssACgkQ64mZXMKQ
wqlb/w/+Ot+NfZMH31Pf2BQoW70wpiu8fTvHx4tgiRO6UEntbqpt3v2ML0fPcbKE
85e2cEyLM98fwAWlrogOPDWJmRSme1w53tWn9g/atrCIBh0Vlx9Z4dAMeRchubM2
sgD17QKA/KtLnCEy/9czAMo/0wnGoohRGJcmUeIE0oBp86uvBmy1ZbdPX+sKVJrf
mmeLRm+WdmX2mmuiTPDzps0bqxygJLXKf2TfCxU0yQg6nQm67dUbuq56NiWFllPG
WflZGljsNfBu3vxjVuH61AFWHhaaWjNSgLTX/y8sU/8J39kZQJHaQp41xI+s15pj
4VcCFXhNIsWfFnHu/FsLErqVMZPO/XYqMVY1IXE8obZezQlpxS8faaJi4eJAOWGy
1QRoQSfS0STuGtJxPsDfGVDvue2kBi9wd/FqgnsHvNE1FgQpvohoEc0XDrt1JgcY
MU4fnXH7tB26q/zzSpa9sZShH5Xv7QFZOMYX1cTt/804w56JN3iGKWul1v5pylcK
3yghLg2I91FQLMp8kGrzzdciXrAy2f1t6DO1V22Wu/KKT+unYZ0vTL5Ccl5YT7zy
4qsUssZGoXnbL8h7payi6t/sApCb1nkozdXgVGAh0o2amvqAz53whsMvJw/PnIK8
TBYez6GxxcG2zxK0cZtKAOafDTyYlET2GclmSGldFs3ftvqXVjE=
=aBNm
-----END PGP SIGNATURE-----

--njsnpqzzxxn5y6r3--
