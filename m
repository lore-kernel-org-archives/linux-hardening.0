Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5978F26
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431776; cv=none; b=U/IC+VjEBDmraUN+QAyj6YcZYYCAFflqJixJD9i1zZ1Wi85UNE6lupXlgkzW5DROHsX2/A313qYD073FUTs/2Q6UQdk0dUqEoApzKta7nilIS7RuiS+4nSPPm9pFqmn0T9l8TqzBI+BJ6T56ZI+nSM2Lmw/We3BeOVqlJI9tKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431776; c=relaxed/simple;
	bh=k0mib85hOBmpFUagG96UR19CoyUQFqA62etwYe2fwSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pxfDAukY9WmqumFHm1VsHz5GxrpxBJrZqtQucJMxQk9BntG2fxsb2x/kqFUd5YLYm/GUnQ6l3IGs5Qw/vABCW1mP+ePtWN+dxBVtctGMEFNHqWQa5IB5m8lW9nC3qpsqZLQKZs+nsQnlmbmKbSRmzjVtLe6lwBLjuRF0/dfkTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6U0RbTP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6U0RbTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6044CC116C6;
	Mon, 26 Jan 2026 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431776;
	bh=k0mib85hOBmpFUagG96UR19CoyUQFqA62etwYe2fwSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t6U0RbTPYxd89LlcF3tyuKr/tZrdueLp7OwD+EgWeqxg5jGpXHj567ogiSfAPYKTn
	 ZdXLjPN9nv9g8pGK5KENHgK+ZtwTixCqh5MRMsh7DSWyWBJswDaFvaVkVZdqE5epr8
	 Id6LNz23GBtpeC3VKlMkKhJy7P/McglDmNoo6/AEedrTFfeVWR64sqMhqjWUuTLOZi
	 FaH4NvXYJB9HACDiLUeI+RFZag6b6+9dbhb/WD/VBkW+A9ZZ+3G+fwU9pdK1OQZpV+
	 7n1WagNCydhmFnxyhzs59283W8VYDdW24S+tmRk5r637odhXvwObUwkMsYgTsHBzxZ
	 th8HaU4UhuU8w==
Date: Mon, 26 Jan 2026 13:49:29 +0100
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
Subject: [RFC v3 6/6] alx-0080r1 - [static] without array length expression
Message-ID: <aXdi1kl_wHMFJRFQ@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m62rqarc6oh64aib"
Content-Disposition: inline
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>


--m62rqarc6oh64aib
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
Subject: [RFC v3 6/6] alx-0080r1 - [static] without array length expression
Message-ID: <aXdi1kl_wHMFJRFQ@devuan>
MIME-Version: 1.0
In-Reply-To: <aXdhh1r7ePA5SrIE@devuan>

Name
	alx-0080r1 - [static] without array length expression

Principles
	-  Keep the language small and simple

Category
	Language; array parameters.

Author
	Alejandro Colomar <alx@kernel.org>

	Cc: Martin Uecker <uecker@tugraz.at>
	Acked-by: Doug McIlroy
	Acked-by: Andrew Clayton <ac@sigsegv.uk>

History
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0080.git/>

	r0 (2026-01-25):
	-  Initial draft.

	r1 (2026-01-26):
	-  Acked-by.
	-  tfix

Abstract
	'static' in [static n] means that the argument shall be
	non-null.  That is entirely independent of the length of the
	array parameter, so it doesn't make sense requiring the length
	to be specified.  Lift that restriction.

Discussion
	While the standard, for a long time, claimed that 'static' in
	[static n] was about the length of the array, it is well known
	that this is only true in paper.  In practice, programmers use
	[n] with that meaning.

	'static' in [static n] has a different meaning (see also
	alx-0079): it says that the argument shall be non-null.

See also
	<https://www.alejandro-colomar.es/src/alx/alx/std/wg14/alx-0079.git/>
	alx-0079 ("[static n] =3D=3D non-null [n]")
	alx-0079 should be applied before alx-0080.  Otherwise, the
	semantics would be undefined.

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

    6.7.7.1  Declarators :: General
	@@ Syntax, p1
	+array-qualifier-list:
	+	<b>static</b>(opt) type-qualifier-list
	+	type-qualifier-list <b>static</b>
	+
	+array-length-declarator:
	+	assignment-expression
	+	<b>*</b>
	+
	 array-declarator:
	-	direct-declarator <b>[</b> type-qualifier-list(opt) assignment-expressio=
n(opt) <b>]</b>
	-	direct-declarator <b>[ static</b> type-qualifier-list(opt) assignment-ex=
pression <b>]</b>
	-	direct-declarator <b>[</b> type-qualifier-list <b>static</b> assignment-=
expression <b>]</b>
	-	direct-declarator <b>[</b> type-qualifier-list(opt) <b>* ]</b>
	+	direct-declarator <b>[</b> array-qualifier-list(opt) array-length-declar=
ator(opt) <b>]</b>

--=20
<https://www.alejandro-colomar.es>

--m62rqarc6oh64aib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAml3YtkACgkQ64mZXMKQ
wqlobRAAtLfpMUfbViLdQJpZAUIiAbxUmk/QIluIVOpJ3aJozQ6DBAmWKhsAyEF0
lAzYetoUSak8CYIpR+O5/YfC6QuhqwhPbrC2LQGNi0d43c4xGYDKeSF97fC093It
yIvPo7Co2gOeywh2ujvr/zpTwLM7sOyQlRET1Oi5mdCHV+gwZ5/qv+Bf0kHKWuRz
Sje8mxDUZIfwolOIin69Hc18THjliZ8vAC6NRsqHS/rM6X+Ju8DKZX7y89vg1xaN
9FRxp7DTjGvMtxRoDet9m3oBNSc80AgvYDhHEFObLVlxtnO4xmtnpXjOf9VKwea7
ieTi+KYyNPrWqX0R1Mw/FR47kROVelHfpeIVItrh51zQFMQGlAdbSrHvCGbvwn1c
OalxNqQ/93zCZJf50WT9k7OVnlVCRpA1BjV/bUI5ftVo51ZWNHctI7YkwQeHTbXR
MERz0LHx1prEbh+/UUU1M8LuEurN7ukFlecTYVfcK2S2x4VS6YgMt+6aAUvQQKxc
/3Yz3Bw6mvkerFOV1aldjIyr0/X31s0iOwgLDqpYK2X37/E+lcsVC5P322fz9Tdd
9WC0maeJSMdU9aVygTi81TGZ/kxWj1txBpfYGV+anc8XseFYtJ4mDNMQQSGMf8tn
kvMw6WrqJ/hnzaOmKlCfF1AjiZay3I3E0/t9K/MA9dMeGxeoMeQ=
=ZRBE
-----END PGP SIGNATURE-----

--m62rqarc6oh64aib--
