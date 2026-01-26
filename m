Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54171CF7D5
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431749; cv=none; b=i4BCw6T668ygtKD+YGQXw1K6ixdE334CoxIJsxlk17CEIUWZcNcol/PcaVfGl4OYzogRTLTziQFVuRibRKtVOlesdVYWTQPLUz95ZhPqWZhInPNU3WD3wBMEbtPiiOQX9dCMwVJ9cE4ua1uPLBzvv9nQc8l3+xb2yDjOTXS2ljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431749; c=relaxed/simple;
	bh=tkfidgvNKdYog1r1BepLXII2qXnQTanFjuRPpEHdCUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dZDJ1XtsA9Fyf5tec1NsI3dTWeKfN0v8ooBt6AZYQHeTRaEEv6p243DWJ5DCpqFILIty/BeVWSR+8pa4yjeTjEgkNx5yGDMXJ3dxT+jIEgmNmHWDJMAL79Awq/JE9QSKqX8Ca9AiwIdsSvDI34MA5qkI8FBlNsEePoxN58mDEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEHmQsUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEHmQsUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56CEC116C6;
	Mon, 26 Jan 2026 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431749;
	bh=tkfidgvNKdYog1r1BepLXII2qXnQTanFjuRPpEHdCUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LEHmQsUyi8mu7wJE4mBDtCFxyvNAN7/lKZ6ptVprk5Nc/auC6o6B6bdfQxUeHCAJ2
	 h/VnriN1qAD3b45bGvAHU+7HP/CLQcWyXEp23qgHZMXM4sVpWTWwOb0UemMlM2XS8z
	 jGpqgYlYV8O3kAOH9A3G4/0DQsVQtSToUZztUsPvW+ythAiAUqfjZGACYEhk6XtQ33
	 fs6qMSzNgMOJL6kQ8W3kr91xoJfYUkYN24aqt0eezMgrbopNHH9AdAH2R4/BzaBmyW
	 ITuwDHscM7D/qXyoLan5HW8F1MJz7rIuTJQGEfW7KBKj7WatkwgBVukSHGfHZCL9Q4
	 oFR2jhU1ZGK2g==
Date: Mon, 26 Jan 2026 13:49:02 +0100
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
Subject: [RFC v3 4/6] alx-0079r2 - [static n] == non-null [n]
Message-ID: <aXdiutoeJyV2ZQh_@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7u4gsg2td265virm"
Content-Disposition: inline
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>


--7u4gsg2td265virm
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
Subject: [RFC v3 4/6] alx-0079r2 - [static n] == non-null [n]
Message-ID: <aXdiutoeJyV2ZQh_@devuan>
MIME-Version: 1.0
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>

Name
	alx-0079r2 - [static n] =3D=3D non-null [n]

Principles
	-  Uphold the character of the language.
	-  Codify existing practice to address evident deficiencies.
	-  Enable secure programming.

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

History
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0079.git/>

	r0 (2026-01-25):
	-  Initial draft.

	r1 (2026-01-25):
	-  wfix

	r2 (2026-01-26):
	-  Acked-by.

Abstract
	Everyone who has ever written [2] in an array parameter meant
	what a 10-year-old kid would guess.  Let's acknowledge it.

		void f(int a[2]);

Discussion
	It is a de-facto standard that functions declaring a [n]
	parameter require at least n elements (or NULL), and don't
	access more than n elements.  It is well known that this is not
	required by the standard, but that should be irrelevant.  The
	standard didn't acknowledge it for fear of breaking existing
	code, but

	1)  There should be absolutely no real code that would break by
	    such a change.

	2)  If any code wouldn't comply with this specification, it is
	    deeply broken, and is most likely already overflowing
	    buffers.

	Let's do the Right Thing(tm).

Prior art
	GCC acknowledges this common understanding, and diagnoses such
	code:

		alx@devuan:~/tmp$ cat ap.c=20
		void f(int a[2]);
		int
		main(void)
		{
			int a[1];
			f(a);
		}
		alx@devuan:~/tmp$ gcc -S ap.c
		ap.c: In function =E2=80=98main=E2=80=99:
		ap.c:6:9: warning: =E2=80=98f=E2=80=99 accessing 8 bytes in a region of s=
ize 4 [-Wstringop-overflow=3D]
		    6 |         f(a);
		      |         ^~~~
		ap.c:6:9: note: referencing argument 1 of type =E2=80=98int[2]=E2=80=99
		ap.c:1:6: note: in a call to function =E2=80=98f=E2=80=99
		    1 | void f(int a[2]);
		      |      ^

See also
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0078.git/>
	alx-0078 ("[static n] shouldn't access more than n elements")
	That proposal also changes this paragraph, but in a compatible
	way.

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
	-If the keyword static also appears
	-within the [ and ]
	-of the array type derivation,
	+If the length of such an array is specified,
	 then for each call to the function,
	+if
	 the value of the corresponding actual argument
	+is not a null pointer,
	+it
	 shall provide access to
	 the first element of an array
	 with at least as many elements
	 as specified by the size expression.
	+If the keyword static also appears
	+within the [ and ]
	+of the array type derivation,
	+then for each call to the function,
	+the corresponding actual argument
	+shall not be a null pointer.

--=20
<https://www.alejandro-colomar.es>

--7u4gsg2td265virm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml3Yr4ACgkQ64mZXMKQ
wqkitxAAqDoftS17J4l3CHwLVW+jPIEPZ+gHcvwUKo6a9GajwWbCYo/rwsdvbVLq
muinJiZAYSbc2RKouQMDJM9Sv7X4yXkSRYrh3cO6DSz3T4J9YGIp8YCwdTgGypMg
pcB8k7ExF1X+IMoGuWkzpBQQshUwTocdCMA+in36VTeHvdtJD+smCuhL8qOiDB8y
T2oWfvEKsHtaLCSzZQAyxo/h762Wvpjr5vpjQ010AyVWiZrqJWwHfSheK3mHzWOb
lq8VyVjAgH3b4UdVLDDvcWqb0JwhhAM8NBgJJTXLFjzUjSvpk2ojazBBCkiOZoxI
NFihZKLpby07F1tbHYBhQxvm195ypjR+zQcOTkUU7x8FxsLsI/JI9EK+xAlNkHcC
uajSTuk7AlnK3/IwEexLkLhZSVJjf9vDOLIUc3QoBHMAkKoPcs73mwXKzf6En8be
4FpRbZPbWXNrYEwFjnHuW0i/7Q97mLPm1wtmwieRh8xgpLNGOSX40XZ+jalbSSDS
vi6DSAgHK4iHTdzDzitamhhfBo1PKv+wkpWvmw8r4EG2BsHqk2ZqOC9x2KV5ivIu
wHo6ZQHvXhner2vDAI/Hf8edkbzYgP4wkWGZ8v9opZ0WYCDHhuLfNvDjllmmwuQM
/IWzkN9P1LUYO3+tRLzhYc+5MlwZEzlwE+7BWOtwKvF4ZjpozTs=
=PIl0
-----END PGP SIGNATURE-----

--7u4gsg2td265virm--
