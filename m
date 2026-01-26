Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E15334C1C
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431709; cv=none; b=QV/J9szxmf7WQbHKoQ3xR/f7TAjQkkuH0c0GzJV5bWTJhVbFxVKqfjU5RdHNvfDfcPoT0cwM/ThNlEShON4UFcJHNTadfLNrOBikKei/OptT1w6gcqXfdSzisx7fK5Hk5etBr7HZWYfXzpk75N3FtXIYv9xqFBdLz8eJG1oRvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431709; c=relaxed/simple;
	bh=oNFwz7g9pr39oEEJOlcRuUXbtpfzJDhMn8N1UqeIrNY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PVXDAMmLhH2rM8QoI9BBssbF3TXCKMFWFnVSET+qoTgrM1StErQ+F/YACAHc1zhBiVHRkbc1IgeqfXBGusoarPw25uP3EdjNw8HGLWcw+kPRTEL2Bl1vpEnZkLFbctuda4AwvsB9WZ/lUND3LwOYmbOiFW7qvclq364vWE92d50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spNao844; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spNao844"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA2FC116C6;
	Mon, 26 Jan 2026 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431709;
	bh=oNFwz7g9pr39oEEJOlcRuUXbtpfzJDhMn8N1UqeIrNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=spNao844F9Dx9df9nZ2COPcFF53hiX4uSjI/JXZDbhZg16Z3HHVkxcImz4kJfCzd4
	 j6ztVjLXZakn3YWOtyO6Rs27L3MwRvDLXtWydgfgLBsElp4YjYT5cUfWQypFJWoQWV
	 G0WaAhVbOw+cJjyNnkIGjQXNJ6Qtik/q7IhBtyw2EguXzNPSbrjT52PpBWqlwLKv6C
	 yZKDYe7DbaXorGU/zwCy4pe2pib1llbECtbEaIzG7zt363MzuP5FcKC910XE//1+Y2
	 Yn/drRB/raTFr1B+z5Soo1keruKJtv3ocEVrI53bztMq7nVhBui0BM2KReWTvkYaQg
	 S0qlJ+3HM1cGA==
Date: Mon, 26 Jan 2026 13:48:22 +0100
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
Subject: [RFC v3 1/6] alx-0077r3 - disallow function parameters of function
 type
Message-ID: <aXdijei6-wLu4IUB@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awvy5v6wtbbiudbg"
Content-Disposition: inline
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>


--awvy5v6wtbbiudbg
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
Subject: [RFC v3 1/6] alx-0077r3 - disallow function parameters of function
 type
Message-ID: <aXdijei6-wLu4IUB@devuan>
MIME-Version: 1.0
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>

Name
	alx-0077r3 - disallow function parameters of function type

Principles
	-  Uphold the character of the language.
	-  Avoid quiet changes.

	And from previous charters:

	C23:
	-  APIs should be self-documenting when possible.

Category
	Language; function parameters.

Authors
	Alejandro Colomar <alx@kernel.org>
	Alex Celeste <alexg.nvfp@gmail.com>

	Cc: Martin Uecker <uecker@tugraz.at>
	Acked-by: Bruno Haible <bruno@clisp.org>
	Acked-by: Doug McIlroy
	Acked-by: Andrew Clayton <ac@sigsegv.uk>

History
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0077.git/>

	r0 (2026-01-24):
	-  Initial draft.

	r1 (2026-01-25):
	-  Re-title.

	r2 (2026-01-25):
	-  Acked-by Bruno.
	-  Add Comments section.

	r3 (2026-01-26):
	-  Acked-by.
	-  Tweak the constraint in p3 instead of adding a new one.
	-  Co-authored-by Alex Celeste.
	-  ffix
	-  Add Celeste's comment about the C89/C90 rationale and K&R.

Abstract
	A function parameter of function type is adjusted to a pointer:

		void f(void fp(void));

	is adjusted to

		void f(void (*fp)(void));

	This is unnecessary and confusing; let's disallow it.

Discussion
	I've never seen any code written declaring a function parameter
	of function type.  Unlike array parameters, this adjustment
	seems to be seldom used, if at all.

	We can turn this into a constraint violation, which will
	require that the few users of this quirk of C to tweak their
	declarations to declare a pointer type (which is what these
	parameters have always been).

	I've tried finding such uses with a search engine, but didn't
	find anything; it could be that there are no uses, or it could
	be that it's hard to write a regex that would find this.  FWIW,
	the standard has one example, just to document this weird
	allowance, and uses the usual pointer to function syntax
	elsewhere.

	Apart from resulting in more explicit code, this simplifies the
	wording, which would get more complex with other proposals that
	will modify compatibility rules regarding adjustment (it would
	require specifying some exceptions).

Comments
	On 2026-01-25T19:48:04+0100, Bruno Haible wrote:
	> I saw such a function parameter of function type once in 25 years of
	> C programming, and I found it confusing.
	>
	> This is an incompatible change to the language. But the impact on
	> existing code is so small that it's worth it.

	---

	On 2026-01-25T18:19:02-0500, Douglas McIlroy wrote:
	> All six proposals look eminently reasonable.  They simplify
	> the language and remove surprises.  I suspect these proposals
	> will invalidate very few existing programs.  In any event, the
	> required corrections will improve the legibility and
	> maintainability of such programs.
	>
	> Doug McIlroy

	---

	On 2026-01-26T02:27:02+0000, Alex Celeste wrote:
	> I was surprised not to find any comment in the C90 Rationale
	> about this.
	>
	> KnR1 says that 'since a reference to an array in any context
	> (in particular as an actual parameter) is taken to mean a
	> pointer to the first element of the array, declarations of
	> formal parameters declared =E2=80=98=E2=80=98array of...=E2=80=99=E2=80=
=99 are adjusted to
	> read =E2=80=98=E2=80=98pointer to ...=E2=80=99=E2=80=99.' There's no men=
tion of functions in
	> this part, even though the KnR1 language does explicitly
	> describe using "bare" function identifiers to decay to
	> function pointers.
	>
	> This honestly feels like something that was added for
	> stylistic consistency.  Function pointers were already
	> well-developed before this became a language feature.
	> Combined with the fact that you _can't_ use a function type in
	> a definition of a thing with that type, and using it in an
	> external declaration creates something incompatible with an
	> object of function pointer type, and I think this was an
	> attempt at consistency that ended up creating an inconsistency
	> instead.
	> The [...] example does look unintentional to me for that
	> reason.

Proposed wording
	Based on N3685.

    6.7.7.4  Function declarators
	@@ Constraints, p3
	 After adjustment,
	 the parameters in a parameter type list
	 in a function declarator
	 that is part of a definition of that function
	-shall not have incomplete type.
	+shall have complete object type.

	@@ Semantics, p8
	-A declaration of a parameter
	-as "function returning type"
	-shall be adjusted
	-to "pointer to function returning type",
	-as in 6.3.3.1.

	@@ p15
	 In the determination
	 of type compatibility and of a composite type,
	 each parameter declared with
	-function or array type
	+array type
	 is taken as having the adjusted type
	 and each parameter declared with qualified type
	 is taken as having the unqualified version of its declared type.

    6.9.2  Function definitions
	@@ Semantics, p15
	 EXAMPLE 2 To pass one function to another, one can say
		int f(void);
		/* ... */
	-	g(f);
	+	g(f);  /* or g(&f); */
	 Then the definition of g can read
		void g(int (*funcp)(void))
		{
			/* ... */
			(*funcp)();  /* or funcp(); */
		}
	-or, equivalently,
	-	void g(int func(void))
	-	{
	-		/* ... */
	-		func();  /* or (*func)(); */
	-	}

	## I added 'g(&f)' for consistency with comments that show
	## alternate valid syntax; it seems an accidental omission that
	## could be fixed editorially.

--=20
<https://www.alejandro-colomar.es>

--awvy5v6wtbbiudbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml3YpUACgkQ64mZXMKQ
wqkidxAAq5RlZiAmW/3O5czPnp4U4hqdxUJ8X0IT1tjRaA+dQWxIYQEBlC5R86Q3
WUeH8nMOuNBPQKY40CdhKlIaZwI15gFOGTYgTc892RAAi7Nx2tzzxeEndgPUzYK2
Sr0A4cx4784k0tMYVzI9EYFDUrq3UxfgzN0tegF7I6IIwpMWjNlyVshtqJI3Hwr2
DRsZhMi9VKYAGfoFaeT/nd9i2R1qntV2gOAXtlb6rYRJspsyqhlSXCb8pAvCOkbi
fcvgJbqqfglmCPaWVfR3B0oqvGkct6rtlnnAd8XITvTnu8J7gxVGz5YBVAXMVM6Z
8OLZcYZAlnCXXiZxnux1AP4trcjquDk2kIoI76Cc+i8aBORhu2JVn85CriR08De2
lUlpgG1zHauHNQwQ0k8WbLmc0HGpEen9f+xfy+53wUVZpJ95hX9GuA77H8x/kFbz
DbXr6fl2TylL/4a5ILbnxSavpVmg1qjV3InwzBZk6pDVYRw51tiX9eqceOGVbgU1
g/gpJwt4l3kEED1CUNgexyfNbP/atbGhs6CHECzcuKoRdq3qssQFhyrgS4aBqctB
bCkdDGewAocgZlzfEBPGkP82EqWGVmraeeXhd9w/fOzK1FBUNoNhBAWclNLA2R7S
YpkWS4S8Ieq4FzpXniwv0M0nqwx2ihKqjtb0l3agNw8Vq6X8URQ=
=NKdK
-----END PGP SIGNATURE-----

--awvy5v6wtbbiudbg--
