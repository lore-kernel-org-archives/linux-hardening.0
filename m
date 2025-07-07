Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCCE28507E;
	Mon,  7 Jul 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751922366; cv=none; b=b7gpsQ/wNJsmQRN5OJpAHzEx+ETD3rkqCypDne5YS9DW+i4J+BUSj/bR8kMaVHeMgrISMpmOayGUs4bYYsm96JNPAW6natC/wpehxMxmMkJ2cK/19lloGFDyztDyIX/jsD4d+dCp/l0D1bhFSVfdij/fw9eWonFQAZxJaxvAeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751922366; c=relaxed/simple;
	bh=QkW1aiHP0NVpsrzGt8fVbIRYg7YfdAj+v9Qot7Jf2tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg6RvWQbOK2csql1d4oMHtqoLC0K0FezLHOGKsk/nYQqlxQ7l7IvXTfW/Lmi9sRU0Mw/2/tUp9e8sfxVo5S741mhICjHDbLkl3UwV/Yj/w6k2pn0MuH5/503XbH5PebbgQiSFr0KcFSqGpCEwns3Y9LhHCnIIdK5pl5+bPpqkT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvKG/PDe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvKG/PDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B346C4CEE3;
	Mon,  7 Jul 2025 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751922366;
	bh=QkW1aiHP0NVpsrzGt8fVbIRYg7YfdAj+v9Qot7Jf2tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvKG/PDewjeuSt9IUMciZqQ1yEcp5aclexa+R+dA/1sMXrcuoLv7mLLFkJ3DQnm8I
	 nAdInF13toY5N+rGJ6NIdDae+CuE4fUyOEXUXTlq5HwplCm1cVmk762AGVYvy1sD5R
	 JDJwcFaeSQdZXJ9h/WTxfdOboNJepEKSbQLdvQAef+ZbCLPS3BrV+cNtyxA4zOlzzx
	 KcfMrXrq7bYPbn0rSWpVhWxw/TRZmDTQESwzG4ntFWA5sIF8gpMA4bpVekSBN0MxBc
	 I48iUaz0rqWiq4Bnb1v3pDtIClT18yqp/kKkuJKHND+/BtZZDzsA5kBUe4za6Q+Jqd
	 CXhg5/k7a4OyA==
Date: Mon, 7 Jul 2025 23:05:57 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
Message-ID: <gjxc2cxjlsnccopdghektco2oulmhyhonigy7lwsaqqcbn62wj@wa3tidbvpyvk>
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
 <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
 <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rxu64vcup7p4zp6"
Content-Disposition: inline
In-Reply-To: <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>


--3rxu64vcup7p4zp6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
 <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
 <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>

Hi Linus,

On Mon, Jul 07, 2025 at 01:49:20PM -0700, Linus Torvalds wrote:
> On Mon, 7 Jul 2025 at 13:29, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > I am in the C Committee, and have proposed this API for standardization.
> > I have a feeling that the committee might be open to it.
>=20
> Honestly, how about fixing the serious problems with the language instead?

I'm doing some work on that.  See the new _Countof() operator?  That was
my first introduction in the standard, last year.

I'm working on an extension to it that I believe will make array
parameters safer.

> Get rid of the broken "strict aliasing" garbage.

I don't feel qualified to comment on that.

> Get rid of the random "undefined behavior" stuff that is literally
> designed to let compilers intentionally mis-compile code.

We're indeed working on that.  The last committee meeting removed a
large number of undefined behaviors, and turned them into mandatory
diagnostics.  And there's ongoing work on removing more of those.

> Because as things are, "I am on the C committee" isn't a
> recommendation. It's a "we have decades of bad decisions to show our
> credentials".

I joined in 2024 because I was fed up with the shit they were producing
and wanted to influence it.  You don't need to convince me.

> In the kernel, I have made it very very clear that we do not use
> standard C, because standard C is broken.

I agree.  I personally use GNU C and tend to ignore the standard.  But
I'm still working on improving the standard, even if just to avoid
having to learn Rust (and also because GCC and glibc don't accept any
improvements or fixes if they don't go through the standard, these
days).


Have a lovely day!
Alex

> I stand by my "let's not add random letters to existing functions that
> are already too confusing".
>=20
>               Linus

--=20
<https://www.alejandro-colomar.es/>

--3rxu64vcup7p4zp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhsNq8ACgkQ64mZXMKQ
wqk41w//ZtMNK1v7cKQ0lZlTUqTrnD/HJrjpT73G+qAbUCgmMraH4Xk+LYomGqUq
XJ5sCg2eHN76EUVvTNOVWQHCSLlmdMEheQSoIN9mpesMkPmmCMuvQpZ27WKvYUIR
y4yEZ4BWlX9kVxpacTa50QHVIg/BVEloY3lcUodp5rVvlqi6QWSp15/wzf6spfc1
l1PV/nmntBAq9XUv3XgNZ3T8nxNtBmaYW+PKdqQyi2xnt5TNOBff/E4sf4K+HUn+
T2eHsOg8VPHZ4Nz9/cAHNFb7ZHjXAIkCWzjwayQrPyBPP2zL6GaFkKYGmPNcDz2U
qmB0mJ6OQOk/lIuRr2K1CskmqUxRY0Ejt/5TIuzRQBR6Z1Dxaixp/DusKD/pcVlm
E9lTV/NR0E0OLGXRCuCqC3BmOBQC6sZJPDoNObStAjSSlhA5PVBGc5O0AtWGn/NO
7xX5gNtFWW4Yth0Reqd0HsZS3R5u5HaRI9q9KVEgVPKvSbizuSbKTEi4jRABdZ6s
ekfxn3t2f3l8F+yWPZ2QFyPf5/c6xADdvLe5iYQgbkbCHPgRKzdfQV/pY3jgds7c
Ct8TbV95pYM0xDnmS1P3FpyRfTrfkscJTfdilRdx8V0g/P9pG6A+rKDRJX3dFwG6
HsA2MA0KFcYR43mRRKXNBvzAGdMHWZfqumHJlaW1s67BIqeLn8Q=
=VDh/
-----END PGP SIGNATURE-----

--3rxu64vcup7p4zp6--
