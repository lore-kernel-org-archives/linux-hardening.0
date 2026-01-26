Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2B3EBF33
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431736; cv=none; b=Uz2IpEqJCnmXEro+ZWWtcjkTy4vuw7P0RyJATB6+uE6XVS4WrXkedH0VpxsZlmKrfyxAl1jcmIg2wQpFs2LZ9ub6Jjd5vz/mhSwUzrsKWg2M1QlquktnnDLITRBUyOOvDWkXVqmBWB/4nS/lb8gsKZ1MBFnfDA2Toexnr52uXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431736; c=relaxed/simple;
	bh=EcGxqrQvmDGHDaB1QLdm/Pk6eBPLYmA8/buek3nYD2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A+Yh9TcovI9Pu2F5PTy+KCG/ISt8GPpY32nq7pcQF2SXjsdLo5dm4n5Vtj86Zv2SfNoONTJx6e4ebGKXQ8RVk2Vac7gp1IjKENTcHHVclD7s8uMD97STBYZrQDy8/cE1HE7hoq2EnKjW5khGPi5f7UgIxO4DHOCpYq7nD/UKM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH0h0V70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH0h0V70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AE6C16AAE;
	Mon, 26 Jan 2026 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431735;
	bh=EcGxqrQvmDGHDaB1QLdm/Pk6eBPLYmA8/buek3nYD2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UH0h0V70FGRv2E+NZc2eAVzAaFd3tt1/fsvr55nhpwqG8bPme0fo2PDy3g8bS8ftz
	 C9SSsIHmK3PX0gevWAhms5oq4nmWbgippkRGx8hg0RNVh16f0Qs2ddotigGkWdQmxT
	 Er9CnF1FnMQV2C/bJUO9rXxdh4dCBSyp06Pjr7c4DndiRr8f0ZKfsgVCYTPnjyJrjg
	 nLcSNepN6EpyjyNmDugx6zPZYUTgZwKkF9xoqwyvAIH1228+Vl7eX5j5PyrajAf87Y
	 AZ4hIQReKkQzmfzVOl9NrpKcWVxxlCmOlFliqpSlQ5lMpnM5LKrsie7Jt5zWqgjVjK
	 af4Q5JYpQsdsw==
Date: Mon, 26 Jan 2026 13:48:49 +0100
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
Subject: [RFC v3 3/6] alx-0078r2 - [static n] shouldn't access more than n
 elements
Message-ID: <aXdirEZVgj8PKPxM@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fxbwk2srfh2utjpy"
Content-Disposition: inline
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>


--fxbwk2srfh2utjpy
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
Subject: [RFC v3 3/6] alx-0078r2 - [static n] shouldn't access more than n
 elements
Message-ID: <aXdirEZVgj8PKPxM@devuan>
MIME-Version: 1.0
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>

Name
	alx-0078r2 - [static n] shouldn't access more than n elements

Principles
	-  Uphold the character of the language.
	-  Codify existing practice to address evident deficiencies.
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
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0078.git/>

	r0 (2026-01-25):
	-  Initial draft.

	r1 (2026-01-25):
	-  wfix.
	-  Co-authored by Martin.

	r2 (2026-01-26):
	-  Acked-by.
	-  tfix

Abstract
	The following function prototype requires an input with at least
	2 elements:

		void f(int a[static 2]);

	It should not use more than 2 elements, as those are not
	guaranteed to be available.  That is, the following function
	definition should be unacceptable:

		void f(int a[static 2])
		{
			a[7] =3D 0;
		}

Discussion
	It is a de-facto standard that functions declaring a [static n]
	parameter require at least n elements, and don't access more
	than n elements.  Most programmers that don't know the fine
	letter of the standard would assume that.  This has its roots in
	the older syntax, [n], which is not acknowledged by the
	standard, but has been historically used to document this as
	part of the API.

	Without this, [static n] is only useful for optimizations, but
	not for writing safe code, as the specification of [static n]
	doesn't provide the compiler with enough information to know
	whether array bounds will be violated.  This makes it a terrible
	UB foot-gun.

	Let's change the specification to make it safe.

Prior art
	GCC acknowledges this common understanding, and diagnoses such
	code:

		alx@devuan:~/tmp$ cat ap.c=20
		void g(int a[static 3]);
		void f(int a[static 2])
		{
			g(a);
		}
		alx@devuan:~/tmp$ gcc -S ap.c=20
		ap.c: In function =E2=80=98f=E2=80=99:
		ap.c:4:9: warning: =E2=80=98g=E2=80=99 accessing 12 bytes in a region of =
size 8 [-Wstringop-overflow=3D]
		    4 |         g(a);
		      |         ^~~~
		ap.c:4:9: note: referencing argument 1 of type =E2=80=98int[3]=E2=80=99
		ap.c:1:6: note: in a call to function =E2=80=98g=E2=80=99
		    1 | void g(int a[static 3]);
		      |      ^

Future directions
	[n] should have the same properties regarding array bounds,
	thereby acknowledging the common understanding of what [n]
	means.  This will be addressed by a future proposal.

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

    6.7.7.4  Function declarators
	@@ Semantics, p7
	 A declaration of a parameter as "array of type"
	 shall be adjusted to "qualified pointer to type",
	 where the type qualifiers (if any)
	 are those specified
	 within the [ and ]
	 of the array type derivation.
	 If the keyword static also appears
	 within the [ and ]
	 of the array type derivation,
	 then for each call to the function,
	 the value of the corresponding actual argument
	 shall provide access to
	 the first element of an array
	 with at least as many elements
	-as specified by the size expression.
	+as specified by the array length expression,
	+and the function definition
	+shall not access an element
	+beyond the specified number of elements.

	## Editorially replace s/size/array length/ while at this.

--=20
<https://www.alejandro-colomar.es>

--fxbwk2srfh2utjpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml3YrAACgkQ64mZXMKQ
wqmOyw/+K0C5qoKrdzF2wKkrrchLLy32XqvUYaAr1yTz4blp/91Rn8zHnABhExe0
tp4TpAgf5KYOkXO1DHJyNGfickB5mLS2icO+Bg1BhY42DQyTDnP4chNh/oXCgeVP
USdqdjefYfX3+QMRsX00zKPPpJkfPqoSRjU9X9xIvgCmcWEXAHa0Z172uYC/tA4w
gPOJaEZmPlNpOhwLWQZqfaGnsHvnoLnxTTk2BD6SPZ35iG+oZfKm9mIOu0v9FBMr
X8aHHLvQo+Vkkd9w6U45DWz/gmkpbs8f/0ZnaVwWSVV9px0FAlLrX5jnOb4haCV8
FzCO0V9LiofgFOxUt2ZvzjJbFocUrLU4Dlugls9n1S5MQnPyGSNMQS7XhgrYotx1
nkAIReAi9DZ3CsVB/XwESbjAq7rBl0+HezueWwqN2MNxrSP+hotdtzNPdyXj8uRk
YI+Fz/4dOQY5EviWLdeHUSxPTceXJOjty8RXNHjkickmgVJehM+HVvM8uYg/ui2s
wYG3c0E69fJUsEWCQvcSnRCKFsdBIie86r3hxyu1+oZhkZWP+mzcxj5RMv/60feA
JtyVEm7Xwlom6CTxCl81DbbqEb5G2zM5akMhFJY8EtF2CJq1EDkVUsF099VvwEj5
nxFVH8bc/YmY6wlkvz1gvtvFwGSe7HfoctJfG3+ysl2LfGPHXkY=
=VA1B
-----END PGP SIGNATURE-----

--fxbwk2srfh2utjpy--
