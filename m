Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504781;
	b=IidayTP6r/nsrmyUSndiQ26Ik4MTE1fJLDC4/feqXxEPT1ywrxyVdIYSUiF6msPFuRIm
	 BDuvpgKNlkCd/34JRl0jeg0GFFzZAWVcrfO7HwJbQn+4zTgiyQ+v/ERJElyxFRIRQR4bN
	 fro4c1TMvUyodcPUUaKOgljK3Y521yo8R8gYrE5BQhBPQHwQAnsme1VgTo3kTIHoeogFs
	 77cB5Tz62nesh3kz9NqXwXftW2fT5Bg8+7OiJJ34inWT/cmtC5bxVbufe+VrZssDSkVDa
	 ehPZRjN0MIccGBtLP5/GT1cAvlLXQ8aexZEumZenPKCybmCbsJ+LLF7KMDqI4zirr8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504781;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ijLAFKTpy2rO1cmzfktYDhNmrdiTCs2qOQ9IyeBu0gU=;
	b=PK/JuRQ3CXlmSwj53eiL9c+8+ItVscobnswe/FvognsuqrRWOXHmoxGwGU11eh1taPoa
	 agyNj+IpKybW1A7J3qVEIIiK831xERAi1V00li5oKQOVv791Ptrl8w9qMt1Jo4DlZz0ef
	 aiB4S4TWyeJRHL9T34vi78gbKX7QyFq71+J+Bv8TJ3fj7sZGo3R5pRIYep6TPLMaFboPu
	 +KvOUhmJlNuV74e6ATa725SJPev+se1OmDzy3y20Gv3RSdYdwFmlsCNpH4Atm+S6HwO5E
	 6n99tyFeMgkquR/kDGTWLoAlOMolJUy3Z9rRwrgQkhf1NSu+6NROM77esWK/vIqZYxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elhci1b6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75574606A883;
	Thu, 12 Nov 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elhci1b6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE9A1F000C4;
	Thu, 12 Nov 2026 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504781;
	bh=ijLAFKTpy2rO1cmzfktYDhNmrdiTCs2qOQ9IyeBu0gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=elhci1b6GnKtBWt0nQTZvjUTh92Tkc0Atzo7j8Uh/tHub/ME65zeo1xQsu/jIpVp8
	 5IJ/EkDpmZ7RUIaOyASBzPSETZCCEWYV5ZcE6YlUymvq6CVKiBSoHYE2l4QOYdjen+
	 53LJsT1qg38aLYwSdA8k3QDgypHmRMmasM6uGKYCo06YUiVUQt8SK4b+DQF1kZ3Uha
	 tpHmLS6jsp1PvpcklB4To0trHT7m70w3vUlpaSWJvNSCRoNIypW1bho53PTEbdYrpg
	 C5FiY50vSOtCQKOBkAn0E5jzUUTLNPXpkEYW1MclJlLcpRSkKAs0s2GWQb6e7FNs+Y
	 pZQL8t+07nmAg==
Date: Thu, 12 Nov 2026 18:32:54 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, driver-core@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
Message-ID: <avX3Y08tF8Z0C4LH@devuan>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com>
 <avWNCC3_Ff0knO6J@devuan>
 <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="o4pnicbxuhqys6k7"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>


--o4pnicbxuhqys6k7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, driver-core@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
Message-ID: <avX3Y08tF8Z0C4LH@devuan>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com>
 <avWNCC3_Ff0knO6J@devuan>
 <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com>

Hi Linus,

> Date: 2026-11-12 08:34:13-0800
> From: Linus Torvalds <torvalds@linuxfoundation.org>
>
> On Thu, 12 Nov 2026 at 02:13, Alejandro Colomar
> <alx+linux-hardening@kernel.org> wrote:
> >
> > I suggest removing kmalloc_obj() entirely, and using kmalloc_objs()
> > always, with a second argument of 1 when we want a single object.  This
> > would remove the risk of that typo.
> >
> > I also suggest having default arguments without variadic macros.  The
> > way to do that is using empty arguments.  Linus complained that it hurts
> > his eyes, but it really makes these macros much safer.
>=20
> No to both. These are both "make the code worse to catch errors that
> the compiler should have been able to catch anyway".

I don't agree that the code is worse.  It's _different_, just like Rust
forces one to write different code in order to make certain bugs trivial
to reject.  But I don't think having to write malloc_objs(T, 1) is
objectively worse than malloc_obj(T).

But let's agree to disagree.

> If you *really* want to catch them, make "gfp_t" be a 'struct'. That
> way even compilers without things like the restricted types that
> sparse has will catch at least that one.

Yes, that's a third alternative, which Kees and I discussed some months
ago in Prague as a mitigation.

> I did that many many years (argh, decades - I'm old) ago to catch all
> the 'pte_t' etc issues when rewriting the MM layer, and it works very
> well.
>=20
> It's going to be somewhat painful, but ti might be worth it. People
> who only use GFP_xyz flags to pass them around wouldn't notice.

Indeed, I don't volunteer for writing this patch.  :)
But yeah, it would also work.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--o4pnicbxuhqys6k7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr1+EYACgkQ64mZXMKQ
wqlMCw/8D8u1QGJxQwMLy0ohBNrNNSiwG+9uYTovzBcTZNUribjecgVSktGCQgCd
o+kAvS4NRBmheiua/UIF9dZ1UV7Vdn1tzPIV8EQj7/mRvQy88KKwrrZXy1DCUTuo
sNDTbAcOzuRnrTIBl1TkQvPo4zc6YbWeDh+v+ZMkelU8jU/lx5tj0XtC1LPgnI5w
vrkXOSgyCWO9OnljQL8A68U5u3vsSdbXt9wHXyOjmFUAo8Pfu8dvhT+gv7bKAJrt
PE9W4sMXLWaYMDjpbCSHS/4t6REVcSspzh7g9YkVXGXAKDkps5YQrJbH5eeGMG0k
6iTxucLbzRrNck24w662nPeGWwYA6b6pn0JW4riCZfxKHTpMBY/XdlrcOWT8RBn8
PQNSJH9/txKdRQghBIK4yCxhW+y1x1slic57adqPizBJAW6AdzVPlYVaTZOeKE4E
ppg+JQ77XLA2BTtd+ROkTJdDAycc9fwrhY5bnpAzEzQeuojymLW3bYQZ54jxTmXc
k5qFDyKnNKtvIVCNfelZtmExZpPBFozOr5BYZ2lo0xounJKyu+j2ynNUZeH45oxj
+ZQBvzb7NEPFMee/5zkcb9odWebSaZ468E10YYPH51AkNtFmoN2SOSyVpzmmbT/w
fShkHI5qPzCw/J+mGgtPOmMgQN8BvD/kZTsr+SFo1Y0GDEmNWnA=
=GL7T
-----END PGP SIGNATURE-----

--o4pnicbxuhqys6k7--
