Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541E238D53;
	Tue,  8 Jul 2025 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974624; cv=none; b=sqRE42KbpFo7/71wsvwOXBts2BGe1T9wOEWxYIYu0+EDBdcRu3aQuKWcQ9cDQtUyBWk930RUpGIkeNH1Ec2Ls6QaAL1fil24PR53jNkfGZK5HhDb4MUgYq/zhCjefwsh9hsXuVH8hq6k7GkxTtNBOKIlBZ5mC7W+RvT7jVhWtPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974624; c=relaxed/simple;
	bh=n3haqzgSRmOkXk1/RvygLKwBN0/aRPw/ajN4WwagC/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krAB6uIYirYN9PNxSF9lbYXSuBe9pMIuMKPNcTV8VgqJANZEY+h2xaP2htBLhr/zK8GixVyfq/PLZVS35SBMzMa/Qf8NUAsQCWKIelsGsc6UoEIRXcKWDAkKVvaiPMEnIxPVg5UHbhywVyz7p+JI2SljtQ9HXr1eOQPd49x60PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqh+LDrT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqh+LDrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0B9C4CEED;
	Tue,  8 Jul 2025 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751974623;
	bh=n3haqzgSRmOkXk1/RvygLKwBN0/aRPw/ajN4WwagC/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kqh+LDrTX8vmlPiu0dSU4XVCSG1H/+BAR2RDhcuxNjula+E1Q6xw+lWctd/p6lzc1
	 wgqrDtDdTcqo/+2YJBYvkMuWTz0SCn45uDc8IoJ2k4xcURavwOll26jakawnXPzvmM
	 rL35mfNF+dXGu77oy9hM3bLm6hRfgM27df8iSvZaV5ElY9JQcig0XMtRpECPJuLStR
	 bikZJDUgfm7n1wDKa7xEYVb8rBNKDvmQhftW53Yik42QVlEpQ9dPe0sFmU4Owoptjh
	 N/Z3Yj3DHdlg/cjhx4RSodl2d8qtzMhQbh86MzCDagxAvjd8+4TlP2vlIGqdEEoL+I
	 wbzA32gJOeUNA==
Date: Tue, 8 Jul 2025 13:36:57 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC v1 0/3] Add and use seprintf() instead of less ergonomic
 APIs
Message-ID: <ez7yty6w7pe5pfzd64mhr3yfitvcurzsivjibeabnkg457xu7x@tkompzcytwcj>
References: <cover.1751747518.git.alx@kernel.org>
 <87a55fw5aq.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yu7ixni4xjxoijgm"
Content-Disposition: inline
In-Reply-To: <87a55fw5aq.fsf@prevas.dk>


--yu7ixni4xjxoijgm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC v1 0/3] Add and use seprintf() instead of less ergonomic
 APIs
References: <cover.1751747518.git.alx@kernel.org>
 <87a55fw5aq.fsf@prevas.dk>
MIME-Version: 1.0
In-Reply-To: <87a55fw5aq.fsf@prevas.dk>

Hi Rasmus,

On Tue, Jul 08, 2025 at 08:43:57AM +0200, Rasmus Villemoes wrote:
> On Sat, Jul 05 2025, Alejandro Colomar <alx@kernel.org> wrote:
>=20
> > On top of that, I have a question about the functions I'm adding,
> > and the existing kernel snprintf(3): The standard snprintf(3)
> > can fail (return -1), but the kernel one doesn't seem to return <0 ever.
> > Should I assume that snprintf(3) doesn't fail here?
>=20
> Yes. Just because the standard says it may return an error, as a QoI
> thing the kernel's implementation never fails. That also means that we
> do not ever do memory allocation or similar in the guts of vsnsprintf
> (that would anyway be a mine field of locking bugs).

All of that sounds reasonable.

> If we hit some invalid or unsupported format specifier (i.e. a bug in
> the caller), we return early, but still report what we wrote until
> hitting that.

However, there's the early return due to size>INT_MAX || size=3D=3D0, which
results in no string at all, and there's not an error code for this.
A user might think that the string is reliable after a vsprintf(3) call,
as it returned 0 --as if it had written ""--, but it didn't write
anything.

I would have returned -EOVERFLOW in that case.

I think something similar is true of strscpy(): it returns -E2BIG on
size=3D=3D0 || size>INT_MAX but it should be a different error code, as
there's no string at all.

I'll propose something very close to strscpy() for standardization, but
the behavior for size=3D=3D0 will either be undefined, or errno will be
EOVERFLOW.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--yu7ixni4xjxoijgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhtAtIACgkQ64mZXMKQ
wqmtvxAAmdw883CZToXhH1TBnZ2W4hbKBzvMaF3mq84wKNfBB/CyJKTfWfVNRW9k
yAG58nel0gHuklLCVK2BMCuG7JfNXNIKdUG7bQTGEr8t//QYcx4haFut+xlfph/M
R+lwiw1q4yy3Q/0q97e2WJ/c4eBbWo5D0A6Ggy1bbYYsVY7AagO1ZHnglzVIHf4j
95IiyR5BFCEtVjmaU8gEACNQIVeC6OnpSw385YlumOiXFX+KFBsiipbew0kXre8M
tv+hyM2u3MR7YSWoMsyAheqSZBKz+puMVS4BGhwg8aAdsRSMoUbTRiszW5GJgSmN
iHxFecIMKkyN3pdKm1Ca4MBbBTe7iYQuALQq0I0bZiP/qhkQMFbxSn0ldBL/tsAU
qkB36CF/S784nfKJ4wDKy1UFUQZBdgMVDLuRH/VWxahijzBhsBF/qnIDdmqEEP3q
un7+CRbi8WkPanq8lVYiiixE/BmOrw95LcrYIycQfwxjShQizzDLCSVXA6NN+lVu
Qae7GlLpZ2vmw+vX50Jq76DzpwspOsIbzpypuXy/Y4f36UBeoqfzI/XtUIZ9CNmS
B0bDgV1z094QTghOi7pZSaWqK8FFpb6lUd0a9fRAKihqEoPPj+Xgg1fagOULkLiO
gor9ti3mUbSyRbeVwQAp/kVVMIrnDZSPtFp945FmBvVVjR7XerI=
=UstB
-----END PGP SIGNATURE-----

--yu7ixni4xjxoijgm--
