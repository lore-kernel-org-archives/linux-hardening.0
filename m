Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C52D8DA8;
	Mon,  7 Jul 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900376; cv=none; b=ebU4P1bRofLYx8o0kSOUnljc+WVfY68YxGd8+HsQmdyTp9AvIj/G4wdgZN5NQYz488nCIAbwmthIzlR9JLMkknHGGfx4kbvm7d+ej0k8k2wZuq9etdNikEEuz8pud0ZQ79ET+YCHh3HWl6OZ0lzr2Of61aLE1QGv+0R2bbhfkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900376; c=relaxed/simple;
	bh=AWC2+QrGGPhLVXZSYH0uztW+sd6LA96IpxcDRobGl9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZKe1JFYOM28pDNZD2mRDuWCM/kSaZEZ7cxiitgIhY1XURAkTGt4g4ZswclaoSf1tqiG289+FD3MMbB1Y7FVdeubsPgb2BmTSQBUdJWV4ypHmsexRKmB0iRyZNM6r28/A6btyM3QaF/HIGhip9nc3K6UpLdy66UqpE2Re0OKiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvUGVCWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvUGVCWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9B6C4AF0B;
	Mon,  7 Jul 2025 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751900375;
	bh=AWC2+QrGGPhLVXZSYH0uztW+sd6LA96IpxcDRobGl9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvUGVCWnNmAO7W75Rs5AQJ2G0//FEvucDQ7gqxUQ/y4B8Yo3GiF+faeaf3/k9+Tyq
	 ODyO0zPgv8p2wRTSg3dnHc89kMCjYD7XsJ0lQIyaIAd6PBjOpwG3cKHrKVe63ofmM3
	 /Q6Tl1qysl/uuTjH/KyDoorCG9Q62QGUY8PgT5e4v1IJl2uLNSdwmyv6Pk0HdyD3h/
	 NuWVN9teFs3JLpCn4BuUkiztcuER+3A47aOx6ykJMUhbAvAbJPtcruE8g05rhqHT0k
	 xW0n2lMOoATxPZrYEcMOfWTWWSGB/pJBkm4uv6J3aiHaILT0dkT2rpijVBhPjkMMEv
	 7qdS8BViWInbA==
Date: Mon, 7 Jul 2025 16:59:32 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Alexander Potapenko <glider@google.com>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC v1 1/3] vsprintf: Add [v]seprintf(), [v]stprintf()
Message-ID: <a3f7i56s5fmg2kcc2j2yledsyxfgepvf62jquqhjzckvg2ojwp@nokqxjgqpman>
References: <cover.1751747518.git.alx@kernel.org>
 <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>
 <CAG_fn=UG3O-3_ik0TY_kstxzMVh4Z9noTP1cYfAiWvCnaXQ-6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ltlrnmdc5i3ybtlp"
Content-Disposition: inline
In-Reply-To: <CAG_fn=UG3O-3_ik0TY_kstxzMVh4Z9noTP1cYfAiWvCnaXQ-6A@mail.gmail.com>


--ltlrnmdc5i3ybtlp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Alexander Potapenko <glider@google.com>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC v1 1/3] vsprintf: Add [v]seprintf(), [v]stprintf()
References: <cover.1751747518.git.alx@kernel.org>
 <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>
 <CAG_fn=UG3O-3_ik0TY_kstxzMVh4Z9noTP1cYfAiWvCnaXQ-6A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAG_fn=UG3O-3_ik0TY_kstxzMVh4Z9noTP1cYfAiWvCnaXQ-6A@mail.gmail.com>

Hi Alexander,

On Mon, Jul 07, 2025 at 11:47:43AM +0200, Alexander Potapenko wrote:
> > +/**
> > + * vseprintf - Format a string and place it in a buffer
> > + * @p: The buffer to place the result into
> > + * @end: A pointer to one past the last character in the buffer
> > + * @fmt: The format string to use
> > + * @args: Arguments for the format string
> > + *
> > + * The return value is a pointer to the trailing '\0'.
> > + * If @p is NULL, the function returns NULL.
> > + * If the string is truncated, the function returns NULL.
> > + *
> > + * If you're not already dealing with a va_list consider using seprint=
f().
> > + *
> > + * See the vsnprintf() documentation for format string extensions over=
 C99.
> > + */
> > +char *vseprintf(char *p, const char end[0], const char *fmt, va_list a=
rgs)
> > +{
> > +       int len;
> > +
> > +       if (unlikely(p =3D=3D NULL))
> > +               return NULL;
> > +
> > +       len =3D vstprintf(p, end - p, fmt, args);
>=20
> It's easy to imagine a situation in which `end` is calculated from the
> user input and may overflow.
> Maybe we can add a check for `end > p` to be on the safe side?

That would technically be already UB at the moment you hold the 'end'
pointer, so the verification should in theory happen much earlier.

However, if we've arrived here with an overflown 'end', the safety is in
vsnprintf(), which has

        /* Reject out-of-range values early.  Large positive sizes are
           used for unknown buffer sizes. */
        if (WARN_ON_ONCE(size > INT_MAX))
                return 0;

The sequence is:

-  vseprintf() calls vstprintf() where end-p =3D> size.
-  vstprintf() calls vsnprintf() with size.
-  vsnprintf() would return 0, and the contents of the string are
   undefined, as we haven't written anything.  It's not even truncated.

Which, indeed, doesn't sound like a safety.  We've reported a successful
copy of 0 bytes, but we actually failed.

Which BTW is a reminder that this implementation of vsnprintf() seems
dangerous to me, and not conforming to the standard vsnprintf(3).

Maybe we should do the check in vstprintf() and report an error as
-E2BIG (which is later translated into NULL by vseprintf()).  This is
what sized_strscpy() does, so sounds reasonable.  I'll add this test.

Thanks!


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--ltlrnmdc5i3ybtlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhr4M4ACgkQ64mZXMKQ
wqmu/w//WwZs9mMUUpehQAZpcLdKgHxOjWIoVERVVix9JXaMkRjvecmLbMcM09Gq
VaIcLpSsccjhDCyz1HKOgvnjIXR/s7bDsy13cjIDwQ7LA8dcT15srw5TAFJhdIlB
LgXQLbewhPidtpcqQBlZavyw2bhL6qhr/1RsI9vaRv6+fpz/TunEP6No1PogIwHB
jTtats/jSKw+PwMukd2a7ZAuBsuopcP+vehDSgr5C+L6v2bG7adoFaiyZT6w3zLS
Tp21Q1bZpQGtD2O6dHWcyn+mrr6i5XP/jKT9r0KQP/HEa28uHSEm/R4oi2RDtr7G
PgJokX5UT8Jfj1YOOebpi0gp30hHEpyWNDPIoLxTqxRYhUja4yJQr//qrSxI++ec
ZXEr4WNNMFDBiVLSfzan8TSJqxEL2KuexQbk89WfPdUw0xEV5bXbIRdIJAjoEM9o
ZWpD61Fsk5vhiB++H4vHK7xVKvlbbdydWGr4/gEhw2Fb6TTUeR7yw24aBXjUSvWh
TyDvLRfKpEy5GDmpzt3goQddiF3T4yP8mrcRXvvnJkyOyqJBX0TsMyLh32zTYoF/
GvrcWFlZvMYB6HuW470wsTDDmQR4NfMdvlD5S/8gBOsIdmjLOMhyViZgYDsb5S5G
xkvPd/+crvso450yOEVkbQMRMgQnx2IexlfON3fHYrQZ2EuSNi4=
=2l/v
-----END PGP SIGNATURE-----

--ltlrnmdc5i3ybtlp--
