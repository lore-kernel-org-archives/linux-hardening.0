Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403818DF6E;
	Fri, 11 Jul 2025 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261724; cv=none; b=mN59ptfbEWB+oQclfTFnS1WE4HQKchoO2uMS9DKqTzkIHq882uHmAEQuhY24MCQf/kU4Cg8NvuG9eETn0y9ZKcumer6TfIdrk6XTZ1NrHyvjbkb+cGSTVdj+KtG7pHrAumvu1hOIMZBg17UmryHSKoL9WWWiZosE90+mtdJY1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261724; c=relaxed/simple;
	bh=BOzxv2tpSJT1JDhpZa5c0Me9/LPODOuGi4cZnOgJor0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy7mMC5EWNcBoqd5ILnbYt68+RmpSVLM3zlLnQfO0zLScgy+i/iq1VURF/DIbz/FDgIqiBM3LcSgWZ+msqvov//MyMuimnPqDnMRXWHDRpS7rcHAQ6hIs+YlqmPSLNGEE1mBZHEuFBNqJuYvmeZGFSfTqcBAIAGvue7KJMqHnD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcx+bn6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcx+bn6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CE8C4CEED;
	Fri, 11 Jul 2025 19:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752261723;
	bh=BOzxv2tpSJT1JDhpZa5c0Me9/LPODOuGi4cZnOgJor0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lcx+bn6N6lEfc5XZg1fzBx7VADUil0DXHy4s50tvVqrmGMGsSjIqo3M6L0bQa5XV/
	 xFvGVOs/pI75K+xJRWPBWiKcI5X6WOkKVYtbt4XFDipL7rn+4pGvzY7D9vTXduoEUO
	 l1CjS73Z08hNsPgX2bg7u7/KlQoIFpoo43z18BXhUPq6kpWh6c6XPZvqlZw24yZZt9
	 n7GBIwADblBRgFsSd11cUfIZ3Yo2BYgoMCNffUzHA4Wik3eOfN0Mpocku64I1r6aVp
	 d+OlOxmxb/tQjZF8fuGC3gfzURmi50bodPAMIjqUGvb+FHWBIxqSaDSg0brLrhzD+t
	 VDKPVHwjVAeDw==
Date: Fri, 11 Jul 2025 21:21:56 +0200
From: Alejandro Colomar <alx@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <327bas45h6nu7jsrod2qnekijq4xrztddzb4wbl7avkquwvwrs@xpwtrozq5o6z>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
 <20250711184343.5eabd457@pumpkin>
 <uipobgcwwyzsq5dtq3wf6haoae7zgwjfefokbwx5nx6wfx5uq2@vgpl36ryhkel>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c5hzqt4435udh3dp"
Content-Disposition: inline
In-Reply-To: <uipobgcwwyzsq5dtq3wf6haoae7zgwjfefokbwx5nx6wfx5uq2@vgpl36ryhkel>


--c5hzqt4435udh3dp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
 <20250711184343.5eabd457@pumpkin>
 <uipobgcwwyzsq5dtq3wf6haoae7zgwjfefokbwx5nx6wfx5uq2@vgpl36ryhkel>
MIME-Version: 1.0
In-Reply-To: <uipobgcwwyzsq5dtq3wf6haoae7zgwjfefokbwx5nx6wfx5uq2@vgpl36ryhkel>

On Fri, Jul 11, 2025 at 09:17:28PM +0200, Alejandro Colomar wrote:
> Hi David,
>=20
> On Fri, Jul 11, 2025 at 06:43:43PM +0100, David Laight wrote:
> > On Fri, 11 Jul 2025 01:23:49 +0200
> > Alejandro Colomar <alx@kernel.org> wrote:
> >=20
> > > Hi Linus,
> > >=20
> > > [I'll reply to both of your emails at once]
> > >=20
> > > On Thu, Jul 10, 2025 at 02:58:24PM -0700, Linus Torvalds wrote:
> > > > You took my suggestion, and then you messed it up.
> > > >=20
> > > > Your version of sprintf_array() is broken. It evaluates 'a' twice.
> > > > Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> > > > argument. =20
> > >=20
> > > An array has no issue being evaluated twice (unless it's a VLA).  On =
the
> > > other hand, I agree it's better to not do that in the first place.
> > > My bad for forgetting about it.  Sorry.
> >=20
> > Or a function that returns an array...
>=20
> Actually, I was forgetting that the array could be gotten from a pointer
> to array:
>=20
> 	int (*ap)[42] =3D ...;
>=20
> 	ENDOF(ap++);  // Evaluates ap++

D'oh!  That should have been ENDOF(*ap++).

> Anyway, fixed in v6.
>=20
>=20
> Cheers,
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--c5hzqt4435udh3dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhxZFQACgkQ64mZXMKQ
wqnkGBAAjriK3UgFz2uAsA2nQ5DSYgg16hTsoy9M6VaKntUP8JFaRNe4TB4xm5UA
/BrfAEO0CKqsO3bz9YLPzmvUlTTwoCDA05ywKnX19tG+DW5Ir0Dar9yqjqid5i8T
GuC7z6Y7xujsmcqTBb/6xu7o9g7Ac6dMrRdfSBDlWuIhRtczjpJTzazu6+ONmcdM
twvcEs4qftRs5JNls9bfCQfrkemdDR4SKNEQdlwk6tRRBnQgEMUlqfxMxuXNelvX
FmKgytE3bSPjRiZRi3zLIBcs7n3XgLMCdzF8UGIbtVq724Gr2CQ7sr/apwbrjGbp
Nj16mXhdDg5kroRpnOnQ0rT5nP7PzXpcK1IeAlUCozPilCrZ9K0esN7COdzdJBEx
03r9f22R0Z4PXCbwMmQ12gCbNbMzFiLH5urJe1N14vBGHdx5TihXP0PuUlmKNm4e
yaCqb2qwCQKvInTgogO9xnhU5DwPAso8h6gBAidNmUYW5nLL1EHoHWexH0rYC0BB
44yFitPtS7ig1l6XY9I4bIewN7WI6YKLz7ywe57y1cbC5uiTcRXY8U3K/dNmztHn
OW60sRMFBdaKWAYfSUMHMIvQwGNPp9LZGrDMLZYsSr4mg7A2/ZjXOevL8MK9AhrL
2oWZjrjrAa+ZT3srhAcQwpZUYRoonAVTgzi6rHWaUa/Vnm1MrTM=
=OO/t
-----END PGP SIGNATURE-----

--c5hzqt4435udh3dp--
