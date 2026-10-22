Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701492;
	b=0kzqp8M+pCmIwpRgoepqXnStfjMuVdz0oIXEoDUMsUjLvxBDNE9+f/X9ZVQXiRQCtL8H
	 +uK+R9EgJGLyjN3q8DTZif7vXp1DDYC1G3AnLPJqkeC5bIrXmCHHu3gcn8RJQKjZP2T82
	 odI8GsaNsU76JhIcVYe5HAw+N9ZfmXZYRR+YekxD7hI7W62brQ1K1QrnsI447U8PKS1Ip
	 i1KwmWUzY/NqJkAxaKkNJfswDMq8JSTRG0dCSnaCLkt4aK1zAlXEPX6SlJkjScB89NRni
	 FghCyxIf23hAt4j452AhO9WH6jnrd5Nui1Oyk3tk9JbDla9h45YxvLg1V7HHq8ksDPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iq0wiKt8UFLsOvEhUJmvw5CQwixTDiwSvy1HoTDMyHA=;
	b=ilqAv8Xgl1hIOGQ2Ndzfdr3fhi7QP6XU1ldnO/88Pg0Q5i80B3lZ6jaidn1LTZRqMCuj
	 2fDrlWK7R1Eq/OfxK3YW59ogaxcMQfaz9wEAX7HzmdPJxUsVXUL30Met8DPSdzeKR2oPw
	 0RdnJYVESqUupvgp2tVtIg9rDFmRzhufym0zA3R+2aV3q+z+K7r7w2o+dky7dx5dL1Py5
	 I5EYBBv0GKr/c1tynYfR6SDt/OUpAfNREBY93Sixv7lc7JqTyzO2s/O02a52DVRYSeBvd
	 f7UHkKnlNUKsQNBYP6MJq9/XFE1NKuFapCkCyJobuqTq7RRONi7VkTdLagjFOndHPdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkGEmigS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB07606A319;
	Thu, 22 Oct 2026 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkGEmigS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47891F01825;
	Thu, 22 Oct 2026 20:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701492;
	bh=iq0wiKt8UFLsOvEhUJmvw5CQwixTDiwSvy1HoTDMyHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lkGEmigSeApGbepC6feBlIy1yKlH5o2VNgHU81nbN06uyrGCrZnYmvShX4fOanBLz
	 +Lm1vIlcG2YvMpEQ8O1JXQEweeiVaFzHlpFOPB/5VKoDJj9hoaZjqN0my1DyZ3EZC7
	 iYsBv0nok3L7heznSPeRrWeK/yGUeKxQQfnAwrWB+rPPY/bU/UQUMVlrMu+ZRbiKJK
	 vddZ9Tq1g9kxUgMV58dXu0REDTt8nuD/hEoxFMAZ2yhQ04mxzcBSLfZMpFok3qyXhU
	 1BoNAjyXbzX1muJMPHWZkYTMxFDkcnWo/dRqjofg8B632Az2vIflBYt1eE9KnC7JlP
	 WRTfMGCUpD97w==
Date: Thu, 22 Oct 2026 22:38:03 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atpyCU3fDyU95hbY@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
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
	protocol="application/pgp-signature"; boundary="6qrjot4rnijap6k5"
Content-Disposition: inline
In-Reply-To: <20261022162000.18aa4162@gandalf.local.home>


--6qrjot4rnijap6k5
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
Message-ID: <atpyCU3fDyU95hbY@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20261022162000.18aa4162@gandalf.local.home>

Hi Steven,

> Date: 2026-10-22 16:20:00-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
> On Thu, 22 Oct 2026 22:11:27 +0200
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> > Agree.
> >=20
> > But still, a better design would do:
> >=20
> > 	static inline void
> > 	seq_buf_set_overflow(struct seq_buf *s)
> > 	{
> > 		s->p =3D NULL;
> > 	}
> >=20
> > This is way more robust, and also easier to understand.  My head is
> > boiling when trying to review this patch set for correctness.  That's
> > not a good sign.
>=20
> But that loses all data. We still want access to what was written.

No, it doesn't lose data.  My proposal is to have this:

	struct my_seq_buf {
		// .buffer points to the start of the buffer
		char  *buffer;

		/* .p points to the current position.  This is the last
		 * '\0' that has been written to the buffer.  On
		 * truncation, it is a NULL pointer.
		 */
		char  *p;

		/* .end always holds ARRAY_END(buffer).  It is a pointer
		 * one-past-the-last character in the buffer.
		 */
		char  *end;
	};

This would be initialized as (of course, wrapper in static inline
functions as needed) this:

	char            buf[100];
	struct seq_buf  b;

	b.buffer =3D buf;
	b.p =3D buf;
	b.end =3D ARRAY_END(buf);

Then, you would write to it as:

	b.p =3D stpecpy(b.p, b.end, "foo");
	b.p =3D stpecpy(b.p, b.end, "bar");
	...
	b.p =3D stpecpy(b.p, b.end, "baz");
	if (b.p =3D=3D NULL)
		goto fail;

Then, at some point, you might want to initialize a new buffer out of
the remainings of it:

	struct seq_buf  b2;

	if (b.p =3D=3D NULL)
		goto fail;
	b2.start =3D b.p;
	b2.p =3D b.p;
	b2.end =3D b.end;

See how simple this becomes?  (So much that you may doubt the necessity
of the set of APIs at all, but they don't hurt much either.)


Cheers,
Alex

>=20
> -- Steve

--=20
<https://www.alejandro-colomar.es>

--6qrjot4rnijap6k5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmradCQACgkQ64mZXMKQ
wqlSWhAAjY/nTCLI9KEjAWELV/CmLv6FgPG5QzR9BlV/vqVLVVkGgcsKM+eJvjxZ
xNXBXWTV5Nz04Qf1zgiv4akL5cKTpsrxD/HmxP3w23ktrONkFliZHbrQFFSqXRVL
Ssr46yfLcj3EO6a9GP/vBNFqEsjtzTjVFABwcCoOKbsTPLfsjMPmrNt5lLzpn5MP
YISWAiGBorLOaGFADDftZrVB7bAvyM48UisAeD7MkfUxTOuGkKgCMvporzu/sFC4
NaoDKK43GncTJ9B2/CxBtr0y/W9yCvF4kgdJdpifXybbAPwpPqGyHQPc3eD04cES
M20BLGucvrg+wz2Ws42ao9Sy/zcI73jeob+8jQUDnTbZ9GjKshIXcEQ7Ffx1hnMA
jcJQ8aotvyn43okBusXE/G/w0067JDprG4WvEm9iKy6z/ipNHeIsu9LYf/PGG55c
2ZkYPKFTh++WzxE8NfqWfkOHfV1zntePRaivit3keSLp4f69tvh7R89MPnmWFKUj
lNXZEZI8PUlNQIcaPRhDcCMb9zZSJkF4Mf9w65e7f+VO2ymHeITTlVzSzGdD4leM
1S5UL5e5SRWOJHYazuKXtYH6EsxmodvAdE8ejEZ6EyTBv5hnxHLkhzgWng77Nd/2
NtBB/MIFCgrBVoxG+OwxMzU3jFT3ZtI5mdiFKT+YCLIUhpRJbM4=
=tZ97
-----END PGP SIGNATURE-----

--6qrjot4rnijap6k5--
