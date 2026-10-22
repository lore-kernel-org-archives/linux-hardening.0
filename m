Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702966;
	b=nyK2BXe6gkCvcDmtiLaJ1OYwccnlBtUNBvmnxnpYctpEDoeBrSfBlXOmFrD7nk4awzwh
	 2d8mp/E9GpGMCK60YPP1tswRA44Jj3U/2rrMtc81N4GerQ7ViTK5cwr5ghREH6bKVU3kf
	 Y8BwrtpkBYuqKeTJGPrhw8mqwebmBx6r2fykXrV52+70pB6T9hJj6gNQOG0HT+m9hDJHY
	 g2G8fJeLX97k+GiVrRwySsH4gFrEa8hSW6ez0g0sEh6grKQDFlKTFSDul2tYD640AySMD
	 4O9PI8ZsnRAv/W2Jsx2MR+qG/Qqwjgcto1gFJEu7gTqzNqhimI2KIZHv2vZwjoPvm2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702966;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Tj37OmA+fKNRhE1Yis70rKCpc+GQO8jtJOfAeK4DI24=;
	b=qGMTGCC3kuDWrouz2MDM6AsmM01Vv7oybZ8mY3rU7qw0a8KCWcegvIUl/A6jFGYOBV1k
	 Zw9Gr5llWIGMtuxJSqQ+9oKU/zSoHi68JqwQBTGIWVWiVzs4uOM2Kshlz6AujZVW2SENP
	 cDaAGpkbZWndyCJOahkLgAztCigW6glJn1r8m+A09tYzOHQfYIn1l9Msi5i04zpRMkRCr
	 Nl4PtaqTU+0r5cIgrx1lmXJ0lLDKWJOuf5ZKqJQ712tvZP9d2gdSPwmGhYakVeUOJAcj1
	 /TeLCx0z2augivdq2PTr6PJNSPUwzwaHqxUZ3gbVCg5e6VmRJZ8BJIAyfFhBeIE1C0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAquE23J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA95606A31A;
	Thu, 22 Oct 2026 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jAquE23J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049CB1F01825;
	Thu, 22 Oct 2026 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702966;
	bh=Tj37OmA+fKNRhE1Yis70rKCpc+GQO8jtJOfAeK4DI24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jAquE23J1qKmy9gw4YNOQvQ8blj+GO1/UfILYA3orebphMxHa++Fj+H1EWQ007chh
	 oOcWf+Rz5eplf8HuGz3GTmlqoR1+oq5APAgjLvV/3EOYOxgTdnKAV7545npyLtGYei
	 pBnNvSNli3CZJ/x0QpsF6MNpqLZwj5rrAaRqtPBr9VW9ryG7shuMfZGz//KstmaUFt
	 6EPAND4+ETavC7bLqUs5/Hjo0bGlnRewTARfgS6xpXiBnNEZw8LexUSzkMskFfDeW1
	 tl+CawI0Pxa6BQgRYoXLtPGNTbwMct+A6rXRc8kWuO2ZPeRzpozIQEhVfFh2w0x+uQ
	 BAA73Wlqv505g==
Date: Thu, 22 Oct 2026 23:02:36 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atp4vVMyX65qYcAt@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
 <atpyCU3fDyU95hbY@debian>
 <20261022165336.3100a5be@gandalf.local.home>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nwadrhiqndqcdlwt"
Content-Disposition: inline
In-Reply-To: <20261022165336.3100a5be@gandalf.local.home>


--nwadrhiqndqcdlwt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atp4vVMyX65qYcAt@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
 <atpyCU3fDyU95hbY@debian>
 <20261022165336.3100a5be@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261022165336.3100a5be@gandalf.local.home>

Hi Steven,

> Date: 2026-10-22 16:53:36-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
[...]
> > 	struct my_seq_buf {
> > 		// .buffer points to the start of the buffer
> > 		char  *buffer;
> >=20
> > 		/* .p points to the current position.  This is the last
> > 		 * '\0' that has been written to the buffer.  On
> > 		 * truncation, it is a NULL pointer.
> > 		 */
> > 		char  *p;
> >=20
> > 		/* .end always holds ARRAY_END(buffer).  It is a pointer
> > 		 * one-past-the-last character in the buffer.
> > 		 */
> > 		char  *end;
> > 	};
> >=20
[...]
>=20
> I rather not increase its size. It is embedded in the trace_seq.

The size shouldn't change:

	alx@debian:~/tmp$ cat seq_buf_size_comparison.c=20
	#include <stddef.h>
	#include <stdio.h>

	struct seq_buf {
		char    *buffer;
		size_t  size;
		size_t  len;
	};

	struct alx_seq_buf {
		char  *buffer;
		char  *p;
		char  *end;
	};

	int
	main(void)
	{
		printf("%zu\n", sizeof(struct seq_buf));
		printf("%zu\n", sizeof(struct alx_seq_buf));
	}
	alx@debian:~/tmp$ gcc -Wall -Wextra seq_buf_size_comparison.c=20
	alx@debian:~/tmp$ ./a.out=20
	24
	24

size_t and pointers should always have the same size, so this doesn't
change the size.

Am I missing something?


Cheers,
Alex

> Yes the seq_buf code can be complex, but it's in one location where it can
> be highly tested and verified. The point of seq_buf is to do the complexi=
ty
> so that other places in the kernel doesn't need to.
>=20
> -- Steve
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--nwadrhiqndqcdlwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmraeewACgkQ64mZXMKQ
wql3NA/+J2kecD0AF8NgnxOuKJBkL6tW7SHIExPHo7ltr04Has8hMB0XCSRA83W9
k8S89DHv6ChbLZ/ubST01VPhdRFlUJIKG4Vw2UFpK4ejbWwI8V5Bqf1A5muKHXm3
AEmTVxbGgJmqdZmbYKTnpkYpbc8x9Czvg77j6jWQaPXq8lE39b8kCCNwrIYHfki1
Z7J3cYuOP10wzC3vb7cwDpmwSuveGl1KmMYDDngeufU99h0A6r6iG5i3qyJKAbID
pl2yK/i61vHGKVwieh+zT0dXfQU9Mh+Kjd+4X9f6UqLlJEreNPocJR+5M3uDByoT
6NGFsBjKngtllmmF+43cJISwGwFIPPmIxcue/WPgXM0hsQar2oyk3TRm4BWViswX
dqDt20Q0Bmhw5cps6jmCvGsMGtMUlD6t2/tICMgukjt4+Gsa8YddRMt+jFucN6c5
nIJA2Z+Vc/U3r0+2pDYaX+Qk8U23zVarsS2CGF9W5vYAsWEeJo76a/L4AgE9wYaP
CQhBJ6krYcuI45JP/Bz7A9DJEe3L2s/caQjb+TdmBwaZ2ARLnkKbzRKNUWeb0DFG
Y/NcQYn7LZrnFaOI8nx7XWDflFthzKFD3CfsETu5V7ur6nVQDd1bitMZrzK6s6Cu
8aUmZwMCydAdpaLhFclr18aKIR5dkebk90FV+FkpyccJ5XCCoNI=
=BPHW
-----END PGP SIGNATURE-----

--nwadrhiqndqcdlwt--
