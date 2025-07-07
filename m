Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF804194C96;
	Mon,  7 Jul 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923623; cv=none; b=sfx+R3XEq7vLYZqusFVARX9Wze634OJwvPWF9kRjEKLkHbq2vCiCOF6HS4pFzWGyRd9QiOyLachbzO0RarDQN2ewsovr+WKooGWLjSlrFct+jwOUWQZDT+VfRETEH3nJA8GaCauIJYX3+1NpmJSxqZVPIFmtxkzDLQZ4gDcGME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923623; c=relaxed/simple;
	bh=PWdIqfq1lShjgNPU1FmwHqSMd26+YTTb1xk5ITmstGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Dk3QcrzqaUPBy6sYxko4ncRO7/Q707VwqLZobVrvZxdUN5muCGrOjsWFae4ngWg8kOnYTFX7kVN+8nq6jXxGxlsMPXv/7x4k+QZ/vuHEn/mzvwfZtWFN2t5cJm8nxIJpNBp6lNt6mBAAAfouo+o0iMjxr0GyT8b2In7iUx/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPeaJUeW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPeaJUeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF7FC4CEE3;
	Mon,  7 Jul 2025 21:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923623;
	bh=PWdIqfq1lShjgNPU1FmwHqSMd26+YTTb1xk5ITmstGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPeaJUeWzFWNndA5+LyG7Cuo6HDkcosyoYsPpgViGWK7zXQ2rx7g2ZZpBZo2V72Iw
	 qfgYCeLtnZltnNM8uD/T9eGCESXdv4SaWbe2aCaZhlNITTjvtaZYMlso72nT4zS5vC
	 dz/YlmeyTsPnY0p/jjWDjcFnETE6qIaIRZSLwx0zGN9EnJ5Ighv+T7VrBZx/MLYiDd
	 5PWKLARp5sZSE45yjwtmnZq09Q5+bE8xJ0Yxx0DHjMc3LjhJX9EeDx2hFyNvystu79
	 NaiVILtUD/+cOgh0Ap5w+svqPiR33Tkg+/LZ8IBns9xA2YwQC+EVJ+tppEZ4F6/9SR
	 GODH7SOS66pGg==
Date: Mon, 7 Jul 2025 23:26:49 +0200
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
Message-ID: <r43lulact3247k23clhbqnp3ms75vykf7yxa526agenq2b4osk@q6qp7hk7efo2>
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
 <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
 <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
 <gjxc2cxjlsnccopdghektco2oulmhyhonigy7lwsaqqcbn62wj@wa3tidbvpyvk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tam3kmtkoib67ue"
Content-Disposition: inline
In-Reply-To: <gjxc2cxjlsnccopdghektco2oulmhyhonigy7lwsaqqcbn62wj@wa3tidbvpyvk>


--4tam3kmtkoib67ue
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
 <gjxc2cxjlsnccopdghektco2oulmhyhonigy7lwsaqqcbn62wj@wa3tidbvpyvk>
MIME-Version: 1.0
In-Reply-To: <gjxc2cxjlsnccopdghektco2oulmhyhonigy7lwsaqqcbn62wj@wa3tidbvpyvk>

On Mon, Jul 07, 2025 at 11:06:06PM +0200, Alejandro Colomar wrote:
> > I stand by my "let's not add random letters to existing functions that
> > are already too confusing".

If the name is your main concern, we can discuss a more explicit name in
the kernel.

I still plan to propose it as seprintf() for standardization, and for
libc, but if that reads as a letter soup to you, I guess we can call it
sprintf_end() or whatever, for the kernel.

Does that sound reasonable enough?  What do you think about the diff
itself ignoring the function name?


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--4tam3kmtkoib67ue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhsO5kACgkQ64mZXMKQ
wqmfxA//c8S1dBGM6C2xdsVSN9VQGixTM+3FYuFDeOMfw3aJA3T74AUqgcqoNktT
PdHNMk63xbAZwzFx3VVNdNVOtUMBuW70OfoOSFzVMwYYxrnVSoZUE95diweHAPvi
hnPR6uvqM4TDiSpC4nI21I/fAuyQ9SI/E5eeUd23yDzAUHeXkNPCSnvAeiHSmZA0
aaFn53PZV9aljWxzwWXI4ybptt+Zl3Y34ic70IFJ2SmBmzigJ3FOnH4LtOf5JvMl
0zpzJkcUc9ZnhLfPt23qm3hoFzO7QSBNFMqzSdYby45I9ggRgE8Q3CNnvJZswzQ3
bqEzuO/xHpKWU/Ost/Di26ckySPVv9LZcMhLThNlXD/iG4HuHeElInBham9vBsS7
96xpy569tpZT6MJtOPpnZ1S/CKpUbsqCg5Bk0WHCyMLxU3c9RK21BPCkKArtMo0U
loc1IW75iUG3Hyegg2vdalX4synsd1OyKZU6saIyP85Nga+gQ1Ou8gLJngq2Q8JR
dZHpILVaJ4avAIjHrcwWnh3IBmQMphV29hLFxJmPM8fPpPHsfNODJLbrjgPP7ydR
MhHsaP545Yx2j1a3X/CWNFNVYv7S31p9QDz694HMPU0Gdik0LYChP6iEgWexlqsF
p23zq/kpLmR3XELdUin0C1ijMXokwxgG49UWy9nSlnW1S/GnPBk=
=WSVf
-----END PGP SIGNATURE-----

--4tam3kmtkoib67ue--
