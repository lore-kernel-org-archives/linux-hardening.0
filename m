Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3521CA0A;
	Thu, 10 Jul 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172259; cv=none; b=pDhaCvUfQsyHvvGjm7PYefX0WmnLJ44YsnBRaUpZIzxr5mJMt8nI7L+h5s8S/2oK5gnN3bnEmrmwwmAE+NgiNwesGkUZXTpS0/hJ+E7lIhWTcneXy6p2AXmcbonct0vdNC54fnGtzXR2X6t+BkG2GFZ9ujJ6jFbe6wKsZdKNKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172259; c=relaxed/simple;
	bh=YzVPXkrWcC89iLuTuFsldR1NCSylHyBNV4ySFkjnvaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clhm0qICW0Ej10n2Y0GupE66Xi8bX0l7IDvUSfyzTbq17V3Jd1wcZBqTpxk/22MhePs6FSMyZZ+tIAwLnoTQktkwmi+ZVwvahJEloIXYa/p5WIBan3yJCy5WmtYrIiqvKWU5dJ14yVXGVxh0sV7p+AcM7943KGA0kf7FUUvLMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMXbP2GH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMXbP2GH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7FEC4CEE3;
	Thu, 10 Jul 2025 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752172259;
	bh=YzVPXkrWcC89iLuTuFsldR1NCSylHyBNV4ySFkjnvaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMXbP2GHCcgHhusslX+Beh7WW1fk8dvET/CVI07Rw63ApetuO/mFNyW+TmKYZOBL6
	 /a8S2Wkh4a50yoc26Lt1L7qpGGrlVIuj0ywErcqj2hTOQb7WMjP6gv2hg9FZ/FRVV+
	 0Vt2MHj+IRfV61UhugK3i41bhmURgs9T7noW87KEIqL4mACKIsSMtXGvRyCiPQnmuT
	 Z4mDEv7uFarwzKT5WIWQc71igRgrv1ubQXGNH2nMIXg1d3N5d9mmRlwNxC1zMffckP
	 ehqVGE7Z+Y1e0p2kg3a7Q+Ae7pRBJVF6R9BnEb3IdJ8UOgd/xb5ZeO0PWRLQ2d9cUh
	 tiiZlIv++ExDA==
Date: Thu, 10 Jul 2025 20:30:52 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
Message-ID: <svune35mcrnaiuoz4xtzegnghojmphxulpb2jdgczy3tcqaijb@dskdebhbhtrq>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752113247.git.alx@kernel.org>
 <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
 <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fodiyed7jhvlrxi3"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>


--fodiyed7jhvlrxi3
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
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752113247.git.alx@kernel.org>
 <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
 <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>

Hi Linus,

On Thu, Jul 10, 2025 at 08:52:13AM -0700, Linus Torvalds wrote:
> On Wed, 9 Jul 2025 at 19:49, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > +#define SPRINTF_END(a, fmt, ...)  sprintf_end(a, ENDOF(a), fmt, ##__VA=
_ARGS__)
> > +#define VSPRINTF_END(a, fmt, ap)  vsprintf_end(a, ENDOF(a), fmt, ap)
>=20
> So I like vsprintf_end() more as a name ("like more" not being "I love
> it", but at least it makes me think it's a bit more self-explanatory).

:-)

> But I don't love screaming macros. They historically scream because
> they are unsafe, but they shouldn't be unsafe in the first place.
>=20
> And I don't think those [V]SPRINTF_END() and ENDOF() macros are unsafe
> - they use our ARRAY_SIZE() macro which does not evaluate the
> argument, only the type, and is safe to use.

Yup, it's safe to use.

> So honestly, this interface looks easy to use, but the screaming must sto=
p.
>=20
> And none of this has *anything* to do with "end" in this form anyway.

That same thing happened through my head while doing it, but I didn't
think of a better name.

In shadow, we have many interfaces for which we have an uppercase macro
version of many functions that gets array sizes and other extra safety
measures where we can.  (So there, the uppercase versions are indeed
extra safety, instead of the historical "there be dragons".  I use the
uppercase to mean "this does some magic to be safer".)

> IOW, why isn't this just
>=20
>   #define sprintf_array(a,...) snprintf(a, ARRAY_SIZE(a), __VA_ARGS__)

Agree.  This is a better name for the kernel.

> which is simpler and more direct, doesn't use the "end" version that
> is pointless (it's _literally_ about the size of the array, so
> 'snprintf' is the right thing to use),

I disagree with snprintf(3), but not because of the input, but rather
because of the output.  I think an API similar to strscpy() would be
better, so it can return an error code for truncation.  In fact, up to
v2, I had a stprintf() (T for truncation) that did exactly that.
However, I found out I could do the same with sprintf_end(), which would
mean one less function to grok, which is why I dropped that part.

I'll use your suggested name, as I like it.  Expect v5 in a few minutes.

> doesn't scream, and has a
> rather self-explanatory name.
>=20
> Naming matters.

+1


Have a lovely day!
Alex

>=20
>                 Linus

--=20
<https://www.alejandro-colomar.es/>

--fodiyed7jhvlrxi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhwBtYACgkQ64mZXMKQ
wqmOQA//bIEhEXLVgwS7mz/jBLQAGT4v53a5yhA1vSbBvckl7+P/z4tYOhS7drGu
KipZBsVxwdBQhN097m1zOT1T1T9q4vbqFOVX1uNVL7Q2R/0WyYC5APIKDHO1ijNF
uXc0HmMSM7Lm0CrY0nvPsI6ZGVagYdXm7QuQ9+GfBc2NAoiJU9fGRPBOjzllradR
3ALXe1Y5c2lgE4sEPPHmAAQNK7LGIX17yx/+YlMDtbZ9/F8fYQrIyW6nkWLgoid9
BmaQ1be4FK7NNbemif5QzHXxaLiwe3OgJrEsgEEAB7cmAvSc+bTloPpFv7UErAsq
BRAv7ivc/Saq5S7779xS5e4GDq8MjdCG2qSMvMnUtfAuhNB90zarK5cXAdCPKvAB
oD+7JptOjM1LHBvjK+Y7ZUIZ1JzP2/4NFtam9ioZUE+Drb5iLSGdwTYjOHzfF+Pi
FLmGbNNQzBMl1b8kjXnOxvmMfYeYM39/eNWUxYXxrhfZGIiRnIdh3ezJreD8t5Rp
AvqHuTbMKRbZmExHJ5sQFJ+MYH1/dOwkgpXvmhFnO78EgLJQSbW05CdDnGvlCNpj
NvcOhy5N+fVmC64ytcS/ALIWJk6XG/Tadns1r2Dn44oDlm1po+tt5k5nT81+cL9t
8gyc+6tp4He6Q4/zznnOCaQytRCja4eJcji3hvW3q2loFPWpzTw=
=kDfd
-----END PGP SIGNATURE-----

--fodiyed7jhvlrxi3--
