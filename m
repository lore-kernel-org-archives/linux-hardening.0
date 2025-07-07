Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4032D8DA0;
	Mon,  7 Jul 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899368; cv=none; b=TX560iaAv2gLv9u7dmwQO5QBi0y8FzuX5zCF3uFAB24m7iAD+Yf6Z7mJCNqaTx2EXxRFV4HiVUj/OFQJu7F8mRwCTqAFJxOrFmBv+4O1NZi+PDDI6HDtuWly/KmjM2DwL8KWtrHockVZEgVSX9tkiNiAZSJ7cHFEFP/zfpTcdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899368; c=relaxed/simple;
	bh=MDzuMRrp2AXCWKZWYbBsCLTTjaSYUNv6L3J0WLWh/vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdHMrp72KZ4+P4QG/XVDQOFxzx5ZyY83OR6FeUnTWxXe8zlWRHefvEJcLmW/IblVrcB4mQ4vw+wjoKbTbZ0BZW+ihUljUn3TNRDxanHUtIZ9MZA9Xy6GZDjW5C5h8TMFyhXWdvGyJTlWRf3qNl6FhMw9aOKJC3BKWY8yqGqNsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4OaCflZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4OaCflZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCBDC4CEE3;
	Mon,  7 Jul 2025 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751899366;
	bh=MDzuMRrp2AXCWKZWYbBsCLTTjaSYUNv6L3J0WLWh/vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4OaCflZjkEO5qWNNtTxP65kPvUz4/hSXVxXXK2dYGHyENjl8f0zGFt6YNIAgsQqe
	 yYsDzE5XADCTX73JfOJrydbNoJyD0mdpxcFFi68fDTEwioDZ1ByKpSR6Yu5fMI98zy
	 hX8aY4MlK6F0kbNd2j8bRL2GFV5Wk9CyW9rNFz62BCd8w24QJZXGSNoz12uDC1fUUf
	 EINc4QmLSd/MpU2QGCSeCHulaU05uY5kIHh0Rmi1lpmLyNgkHT6mAi4Jw0gLiL6aXW
	 4r2EbSTE9u0Z7RFm1NORCO7DavMvrLtqVWWL9YaVjEhJ4vYBk/TtXPiV4VfaCtZ68p
	 ZIYRajREJivIA==
Date: Mon, 7 Jul 2025 16:42:43 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Marco Elver <elver@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v3 5/7] mm: Fix benign off-by-one bugs
Message-ID: <g6kp4vwuh7allqnbky6wcic4lbmnlctjldo4nins7ifn3633u7@lwuenzur5d4u>
References: <cover.1751862634.git.alx@kernel.org>
 <740755c1a888ae27de3f127c27bf925a91e9b264.1751862634.git.alx@kernel.org>
 <CANpmjNNQaAExO-E3-Z83MKfgavX4kb2C5GmefRZ0pXc5FPBazw@mail.gmail.com>
 <aGt8-4Dbgb-XmreV@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tmiwotmrfmdi6oyz"
Content-Disposition: inline
In-Reply-To: <aGt8-4Dbgb-XmreV@tiehlicka>


--tmiwotmrfmdi6oyz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Marco Elver <elver@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v3 5/7] mm: Fix benign off-by-one bugs
References: <cover.1751862634.git.alx@kernel.org>
 <740755c1a888ae27de3f127c27bf925a91e9b264.1751862634.git.alx@kernel.org>
 <CANpmjNNQaAExO-E3-Z83MKfgavX4kb2C5GmefRZ0pXc5FPBazw@mail.gmail.com>
 <aGt8-4Dbgb-XmreV@tiehlicka>
MIME-Version: 1.0
In-Reply-To: <aGt8-4Dbgb-XmreV@tiehlicka>

Hi Michal,

On Mon, Jul 07, 2025 at 09:53:31AM +0200, Michal Hocko wrote:
> On Mon 07-07-25 09:46:12, Marco Elver wrote:
> > On Mon, 7 Jul 2025 at 07:06, Alejandro Colomar <alx@kernel.org> wrote:
> > >
> > > We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
> > > doesn't write more than $2 bytes including the null byte, so trying to
> > > pass 'size-1' there is wasting one byte.  Now that we use seprintf(),
> > > the situation isn't different: seprintf() will stop writing *before*
> > > 'end' --that is, at most the terminating null byte will be written at
> > > 'end-1'--.
> > >
> > > Fixes: bc8fbc5f305a (2021-02-26; "kfence: add test suite")
> > > Fixes: 8ed691b02ade (2022-10-03; "kmsan: add tests for KMSAN")
> >=20
> > Not sure about the Fixes - this means it's likely going to be
> > backported to stable kernels, which is not appropriate. There's no
> > functional problem, and these are tests only, so not worth the churn.
>=20
> As long as there is no actual bug fixed then I believe those Fixes tags
> are more confusing than actually helpful. And that applies to other
> patches in this series as well.

For the dead code, I can remove the fixes tags, and even the changes
themselves, since there are good reasons to keep the dead code
(consistency, and avoiding a future programmer forgetting to add it back
when adding a subsequent seprintf() call).

For the fixes to UB, do you prefer the Fixes tags to be removed too?


Have a lovely day!
Alex

> --=20
> Michal Hocko
> SUSE Labs

--=20
<https://www.alejandro-colomar.es/>

--tmiwotmrfmdi6oyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhr3OMACgkQ64mZXMKQ
wqmhQhAAs+ekX9398aALI01OsOZ18qRcUwUGAgNGOEKzODVWKq+ZfCv5kpLjB8Rx
mz7WZld1t7roGUyTkEE6qInFFtJ9EB2Oc0WqZCBNEHvS7hRiWLbJdaYv3vdT5hl6
++tJ/HhXTGChathW1i4KfKiu5iZdre5B0h36dXQJvU70Xewnca8uY7Vq4u4mfpwU
POUiVLo1FPMx5PfJYILFFMhI8PRWrAwx6wlkbjHBmVaRqG4z286j4FonO8wwwwNt
8E8KmyNt2a8wsc0+ezpmDJ7lgsWpxr3qTp3FGIby9yokzHBUrc4IAlzj9agSPmlT
qWLcFUwdFPzKb4bQCX2zVfjidlbO14g6iS71wINotWZvKhy8e9Wtza78qUFhpGV4
77u0tXXT1dVd3K2P0HYz8AmXtgawUDUA/8DAF25SxfHIodsdJq35OsSGPzfrbIfC
BuT+K4OhfWoODvzcOYFpEyrz2a+YgXRep4GfRDc69PrGhmQk8S68V9vcMft/tzvy
k+ggvc9f1Y1Y1MtXFKV91pGhD5//TnJA1UYduI/HOz+2DeTFk+s62nHjiy/zXdzE
fvsiLzgRkXT8geMyrGRtKxnKKWqWEXrt0kmfr8h6FwjrBjL3hRzsrCCSyqCgmKyJ
isD88CxA4o8wntqCuOxhMtsOVK5jXG6pN56W+eZ/LOfzfz1MSRE=
=mTHU
-----END PGP SIGNATURE-----

--tmiwotmrfmdi6oyz--
