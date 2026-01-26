Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F878F26
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431722; cv=none; b=qxWC+PV4q4kQ4coHaZAqQmDlu+xMWI/TpkiU6VnFnAXhohMGTDNVrU/4NqGHeNw1PNs/O0str5nMZL4yksBlGwtplG6R7IGx5qLqefIR0HBRYEnNBWzB7ABCORfYpKWsGDDPWoxF7HHgZeXH5fcZrRAaENPx7j2jwxxbmf6Bp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431722; c=relaxed/simple;
	bh=VDwZJ6seCO35oqmCtrLI8EfAU53qtBjx/71UwmYD8aI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LhnIi9JnXniu5tU4/5xowhT3Qzs4W71wDhWXhGuoaKzbS7pRkdd7DyMDs/LBXMQPMXG4DF4yK+AG33Q9u7Lp9pJjy7jjdRdd0JOHOf+oHU+peH6JZrZgnRVEVWNivw29TeBQZQ+SvhP1bpIYE08nzDMn3nxdbi0xfaJKds/r/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1+oWdRB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1+oWdRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BD1C19425;
	Mon, 26 Jan 2026 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431722;
	bh=VDwZJ6seCO35oqmCtrLI8EfAU53qtBjx/71UwmYD8aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C1+oWdRBQYif6uA5AOBqwNCQCNTnsLIHXWzQTv0qzeYLcgTs1DwQsE8axGNYc4MJO
	 tRzwV/qcgotPcWQJffJTCR16uQmLzjyY/ncLFnefrBdSzYaKBigiaPAHMh3ESHF4PJ
	 b543215r2J1QGHbdpzwaRWoWuBntixFGuIZdG9ZbiQXOl+5KF/y9kLb24TLa5UOvEN
	 2xs6EY9LmvKHQqacdiZkHkfU/z0Kkn75t+mXn3kViLZ2nWOM9kMRLJBOOTC/UVqjfZ
	 nlvd8ZNMkmKjc0Y8gRxozm+CkFYDeapTfui2fT0h2NmxhooL7BRszXQO5xVkJo1F+m
	 FfpEc8/8qIP4A==
Date: Mon, 26 Jan 2026 13:48:35 +0100
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
Subject: [RFC v3 2/6] alx-0076r3 - incompatible array parameters
Message-ID: <aXdioPaMhmF3PyZo@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eo3tlrgyr4ndflyt"
Content-Disposition: inline
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>


--eo3tlrgyr4ndflyt
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
Subject: [RFC v3 2/6] alx-0076r3 - incompatible array parameters
Message-ID: <aXdioPaMhmF3PyZo@devuan>
MIME-Version: 1.0
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>

Name
	alx-0076r3 - incompatible array parameters

Principles
	-  Uphold the character of the language.
	-  Codify existing practice to address evident deficiencies.
	-  Avoid quiet changes.
	-  Enable secure programming.

	And from previous charters:

	C23:
	-  APIs should be self-documenting when possible.

Category
	Language; array parameters.

Authors
	Alejandro Colomar <alx@kernel.org>
	Martin Uecker <uecker@tugraz.at>

	Acked-by: Doug McIlroy
	Acked-by: Andrew Clayton <ac@sigsegv.uk>

History
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0076.git/>

	r0 (2026-01-23):
	-  Initial draft.

	r1 (2026-01-24):
	-  Add a principle.
	-  Don't break parameters of function type (but see alx-0077).
	-  Document that this also applies to [static n].
	-  Remove superfluous line in diff.
	-  Clarify that the array type is incomplete.
	-  Add 'See also'.
	-  ffix

	r2 (2026-01-25):
	-  Take the two examples from N2906 (reordered).
	-  Add Martin as co-author.

	r3 (2026-01-26):
	-  Acked-by.
	-  tfix

Abstract
	The following two function prototypes violate a constraint:

		void f(int (*p)[2]);
		void f(int (*p)[2+1]);

	The following two function prototypes should be unacceptable,
	for consistency:

		void g(int a[2]);
		void g(int a[2+1]);

Discussion
	The prototypes above are obviously wrong.  If a program is
	compiled containing the above prototypes for g(), the programmer
	is clearly very confused, and there are high chances that the
	program will eventually overflow a buffer.

	Currently, a program containing

		void g(int a[2]);
		void g(int a[2+1]);

	is a valid program, because the array parameters are adjusted to
	pointers before checking for type compatibility.

	The standard (n3685) says in 6.7.7.4p3:

		Two function types are compatible
		if and only if all of the following hold:
			--  They specify compatible return types.
			--  The parameter type lists
			    agree in the number of parameters
			    and in whether the function is variadic or not.
			--  The corresponding parameters have compatible types.
		In the determination
		of type compatibility
		and of a composite type,
		each parameter declared with function or array type
		is taken as having
		the adjusted type
		and each parameter declared with qualified type
		is taken as having
		the unqualified version of its declared type.

	We could easily tweak that paragraph to say that the
	compatibility is tested before adjustment.  That would need a
	teak to make pointers compatible with arrays, though.  It would
	also need a tweak so that in function calls we still use the
	adjusted type.

    [static n]
	This change also makes the following be not compatible:

		void h(int a[static 2]);
		void h(int a[static 2+1]);

	This is intentional.  A future proposal will propose that
	a function declared with a parameter [static n] is not allowed
	to access more than n elements (and the current proposal already
	kind-of implies this).  Another future proposal will make
	[static n] and [n] equivalent, except for nullability of the
	pointer.

Prior art
	Both GCC and Clang already diagnose such code:

		alx@devuan:~/tmp$ cat ap.c=20
		void g(int a[2]);
		void g(int a[2+1]);
		alx@devuan:~/tmp$ gcc -Wall -S ap.c=20
		ap.c:2:12: warning: argument 1 of type =E2=80=98int[3]=E2=80=99 with mism=
atched bound [-Warray-parameter=3D]
		    2 | void g(int a[2+1]);
		      |        ~~~~^~~~~~
		ap.c:1:12: note: previously declared as =E2=80=98int[2]=E2=80=99
		    1 | void g(int a[2]);
		      |        ~~~~^~~~
		alx@devuan:~/tmp$ clang -Weverything -S ap.c=20
		ap.c:2:12: warning: argument 'a' of type 'int[3]' with
		      mismatched bound [-Warray-parameter]
		    2 | void g(int a[2+1]);
		      |            ^
		ap.c:1:12: note: previously declared as 'int[2]' here
		    1 | void g(int a[2]);
		      |            ^
		1 warning generated.

See also
	N2906 (Uecker; "Consistency of Parameters Declared as Arrays (updates N277=
9)")
	That proposal is superseded by this one, which achieves the same
	goal with significantly less complexity.

	alx-0077r0 - function parameters of function type
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0077.git/>

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

    6.5.3.3  Function calls
	@@ Constraints, p2
	 The number of arguments
	 shall agree with
	 the number of parameters.
	 Each argument shall have a type such that
	 its value may be assigned to
	 an object with
	 the unqualified version of the type of
	-its corresponding parameter.
	+its corresponding adjusted parameter.

    6.7.7.4  Function declarators
	@@ Semantics, p15
	 Two function types are compatible
	 if and only if all of the following hold:
		--  They specify compatible return types.
		--  The parameter type lists
		    agree in the number of parameters
		    and in whether the function is variadic or not.
		--  The corresponding parameters have compatible types.
	 In the determination
	 of type compatibility
	 and of a composite type,
	-each parameter declared with function or array type
	+each parameter declared with array type
	 is taken as having
	-the adjusted type
	+the non-adjusted type,
	+each parameter declared with function type    ## \
	+is taken as having                            ## -} See below.
	+the adjusted type,                            ## /
	+each parameter declared with "pointer to object <i>type</i>"
	+is taken as having incomplete "array of <i>type</i>"
	+(the opposite of adjustment),
	 and each parameter declared with qualified type
	 is taken as having
	 the unqualified version of its declared type.

	## The three lines about function type are to not change
	## anything regarding function types in this proposal, as this
	## proposal intends to be mostly uncontroversial.  However, it
	## is cruft that shouldn't be there.  There's another proposal
	## for removing that: alx-0077.  If that other proposal is
	## accepted before this one (or at the same time), remove these
	## three lines here.

	@@ p21+1
	+EXAMPLE 6
	+The following are all compatible function prototype declarators:
	+	void g(int x[const 5]);
	+	void g(int x[5]);          // composite type
	+	void g(int *restrict x);
	+	void g(int x[*]);
	+	void g(int x[]);

	@@ p21+2
	+EXAMPLE 7
	+The following function prototype declarators
	+are not compatible:
	+	void g(int x[5]);
	+	void g(int x[3]);

--=20
<https://www.alejandro-colomar.es>

--eo3tlrgyr4ndflyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml3YqIACgkQ64mZXMKQ
wql1ThAAi+nUCMx7pYlAPE675EZZ97vB1uSmkpgWVzWhEeZNeOTAyWqSdiDo1teX
nwNXHIbRQkE79wjVoVNupgrVXAhkJV9/oUyFQjSrLrfKMqx8RkreSCsU6XCHRqKK
ttEvYoHd64IyAJMQOZcdYSWeWIGg7Im7dCFI/BR542wJfkifudb4d/tBFDsKDR6i
QSc/o2tir2kAOskUZs6dbJGzjZvJLqzrHHoEkQ+0tcCmJnyNIl0dv16p17sNnJfo
VJ9NgntlCwkOhRBEmoIQYIgkhs3T7S3kmKUN3nWPH5y3Mrv++P47/SVgEp2RrT7l
ScrGIIuqPTEOXMqlMIWgbtlOoE7W29r5dCoS7aX2EPr5gusJN23dc5GQnr3VeR3r
jPV9K5o+odQhWMPiDNAumC2Q8ffbgObE3l0NU0Ywd4Mnm8IUKsroiNe1Qh/EA8ji
9TWnBK3AlIfuWLg5IDG2wVqjr08dtucFnuGMGjccD4kKfKYXZJEMLK1pl8uaxtLB
R5OZsaDuvZzA9p0DRbLj+h2M0bfiXYltWTYzTv+mhWPGzjjYR2QA2XBBv7OIrGeA
A/KDBJOPGnZXFl4732ZC2dlvd4p7+4YTWEa5/eakHemQ1xUO8G7h2ifWe69yyrzW
r1xlvxJDSXPWHBljmlO60w1farb+7cHqFUbrB7WZiPqD34rhFME=
=beW2
-----END PGP SIGNATURE-----

--eo3tlrgyr4ndflyt--
