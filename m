Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470A2E3708;
	Tue,  8 Jul 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991266; cv=none; b=qDiQHfUaW4VT4CsjD4xIaYdIMPuNTnrYFQ0ANhCPC0/mZ1ihP9hQfqHdJ9Zif8HPezahTYLIzeA50Ez3nY9OL5DUU8bBDTlZIAIMBWFItmirfiDQGhQV/jISeT6IOrSHUjz6WJzB4uULLWfxArAdZhK8ImkFAmPw2OY8g3Mf6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991266; c=relaxed/simple;
	bh=9VJ1nAIku89khtvQrVlc23Y/ORI9Fv5eKjw3C6IpwGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0/omBgFoRuRkwbahtTfGV9KFgJl2bu0ns6IZCRoPg5JlSRig7HG0r3erw3GGZO0MRpNtggmvtryQyY29Oi4p0p1OGOPUMbvdMIQ0rTzULMTjUEIES9FrNsTu0XcUZHSzv3eV+E41GWjzIBrGALLNCgbyL8FEEymWJseD8fKHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q48En5Xx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q48En5Xx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED1C4CEED;
	Tue,  8 Jul 2025 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991266;
	bh=9VJ1nAIku89khtvQrVlc23Y/ORI9Fv5eKjw3C6IpwGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q48En5XxhxAXTUKM8v+dgVwYZ7UEEkh8gDOJHzjAw07He9s6U4Gy1G8wyS2VeF5IL
	 e6Pc0kVolCufQz4buTOCAwcdkRLWrKVhrAOlnAlrRjh1Ao9KLuLBiio1hgTEygHetO
	 TdRKVlHU6j6DeTWcXlJPKj8KzMPHCxLULlYL+DJDWjkKWGlhAgu3OlLmOBJGyXMe/S
	 Khou6QGPq/vKenLJI0vPZ84XFLx53flf4NGBBtHolBEa9drGlbvycXU0gmHgV9Bz1F
	 NljBr7BpiKC2xqt7WideBwOprEhtQ1p/PbwGrG6hC42BzKGb6mnrCHg0p+jUcS11OZ
	 TAJY3gUZDPtzg==
Date: Tue, 8 Jul 2025 18:14:19 +0200
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
Message-ID: <xmrrnnvhipkhfs6xk743nczeuze6hegjihtdhdcougkuzsnv73@qgmtmjntsd7r>
References: <cover.1751747518.git.alx@kernel.org>
 <87a55fw5aq.fsf@prevas.dk>
 <ez7yty6w7pe5pfzd64mhr3yfitvcurzsivjibeabnkg457xu7x@tkompzcytwcj>
 <871pqqx035.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uc53hol6uccylkwy"
Content-Disposition: inline
In-Reply-To: <871pqqx035.fsf@prevas.dk>


--uc53hol6uccylkwy
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
 <ez7yty6w7pe5pfzd64mhr3yfitvcurzsivjibeabnkg457xu7x@tkompzcytwcj>
 <871pqqx035.fsf@prevas.dk>
MIME-Version: 1.0
In-Reply-To: <871pqqx035.fsf@prevas.dk>

Hi Rasmus,

On Tue, Jul 08, 2025 at 03:51:10PM +0200, Rasmus Villemoes wrote:
> > However, there's the early return due to size>INT_MAX || size=3D=3D0,
> > which
>=20
> First of all, there's no early return for size=3D=3D0, that's absolutely
> supported and the standard way for the caller to figure out how much to
> allocate before redoing the formatting - as userspace asprintf() and
> kernel kasprintf() does. And one of the primary reasons for me to write
> the kernel's printf test suite in the first place, as a number of the %p
> extensions weren't conforming to that requirement.

Yup, sorry, I was talking from memory, and forgot about the size=3D=3D0.
I've introduced the check of size=3D=3D0 for seprintf(), but snprintf(3) is
okay with it.  My bad.  The issue with INT_MAX holds.

> > results in no string at all, and there's not an error code for this.
> > A user might think that the string is reliable after a vsprintf(3) call,
> > as it returned 0 --as if it had written ""--, but it didn't write
> > anything.
>=20
> No, because when passed invalid/bogus input we cannot trust that we can
> write anything at all to the buffer. We don't return a negative value,
> true, but it's not exactly silent - there's a WARN_ON to help find such
> bogus callers.

Yup, I know.  It's silent to the caller, I meant.

> So no, there's "no string at all", but nothing vsnprint() could do in
> that situation could help - there's a bug in the caller, we point it out
> loudly. Returning -Ewhatever would not remove that bug and would only
> make a difference if the caller checked for that.
>=20
> We don't want to force everybody to check the return value of snprintf()
> for errors, and having an interface that says "you have to check for
> errors if your code might be buggy", well...
>=20
> In fact, returning -Ewhatever is more likely to make the problem worse;
> the caller mismanages buffer/size computations, so probably he's likely
> to just be adding the return value to some size_t or char* variable,
> making a subsequent use of that variable point to some completely
> out-of-bounds memory.

That's why seprintf() controls that addition, and gives a pointer
directly to the user, which doesn't need to add anything.  I think this
is easier to handle.  There, I can report NULL for bad input, instead of
adding 0.


Have a lovely day!
Alex

>=20
> Rasmus

--=20
<https://www.alejandro-colomar.es/>

--uc53hol6uccylkwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhtQ9UACgkQ64mZXMKQ
wqmXexAAoMKhj1wyGjvhsWQvcONm/dFCQQmigbvdvZel7D+KJfQQSiN8AHuDL0WI
+NP0JRsmbOqvnvrc8RW6w4rtmWyoRpsyJjCOCneNiw35EWmUcBbJTCXfD/A8TF9B
Idf453FE2u5B4QWJ+7X2s9ee4rxKiL3MzF4iEpZ/afDa7DA4FSYBuK7bv16YfTn5
KssCG9JEH91cMLqjOuv7YgnVrHfYburjuKt9GzK5QyLinlzNvBDYl+OHRPG4OOWb
1arsLTPccpfnM0CCu2iLaCWfTDEz5W8n4ml2kwmctACzzEFUOXVm8CjC4CiRLzBu
STVoHGKKn8S5KdjUxx7VdkgJmO+2a3L+J4Yq6/xP3ywlMEfXeZi3iEP/7AcBaqSo
5PR/LMx113ftA9M4/KMesyL4aB7U0EME2a0lLspvtSU64puOLa9eAcq71FcuxdQH
DWRLjkLrck7s39Kwrzk/JsQO0OuAmwTqs0zV2M6aBRUCBnjfyRDrqY+PDQ1C+47z
F+g8xt57alY6tN/tJFWAymozBl+6UMmI+4O8z4gL0Urso2juh1YWuH4XD5sN69iT
V5ft+sw2G9VPd5T1OZYIrB8ySSgZLl3mKs0AfZr99XJsU/onPVL27ZLDfSTkEFKm
NEDOPx1Ojv8NIDyKXUYid1NaofXjKbWfKF7lKsGtLanOdGYLJbU=
=sxYf
-----END PGP SIGNATURE-----

--uc53hol6uccylkwy--
