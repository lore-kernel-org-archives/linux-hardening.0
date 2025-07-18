Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC03128816;
	Fri, 18 Jul 2025 00:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752800187; cv=none; b=tRIH+JKHikbIQz4M9TRkc5d/LTJhqhClxwR06F4EAEcFySZahzF4NpDlwEdOvPfTVzqFWObRoJtiT8wSrD6+77VWm5loAmmDIjqjezZwfjgk9a68n0wbNe33USvu1t/GGQeQvJ7h1+ovvZAg6oOrDvJrZ80q6DK6uq5ThqISLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752800187; c=relaxed/simple;
	bh=SY6veYEenY3ETaNp90Fgi3oqpoAKdNxhIi+bTZtizDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZeK0S6gjgQbQN4waDGHoi/Rgorgt+1hjov90woc0VbTe5VE9hLsPJusqTxYrtDb6usiGHFK4ff1qHr9fuZ6q9cF3jK2REcF4wXeIU04JxDY3L/kmd8/3VU5SS3D2fBBKZJ+SVmnebOYVwr2EtWbIWqyxJRounVyoBcZxHH+S0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcIWXRcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcIWXRcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23233C4CEE3;
	Fri, 18 Jul 2025 00:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752800186;
	bh=SY6veYEenY3ETaNp90Fgi3oqpoAKdNxhIi+bTZtizDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcIWXRcnolHN2gWY2+iymLVYl3JeOO7lUYBB1V/8/qccbb7Cs1UveUcs6vLq4s+kH
	 JVddSr4+Aeyg/mmnDdBJhhZc2vxv81Drd97qre9tgQtxP2GDXen0YXRnY5AmXBD4ap
	 9hf0RAvYDwH9mz9feeH7pB87wljMljAvVtB6hUZ2QNAe0P6aT0jyStJfcTNzMWVxir
	 2yIQEL1k2Wv5SNrhLDFPaDk0sT78S40EhHJD/6y2fjzhEQzipxERScHsd/77irjhK9
	 QNRiD3LCHw29wcKAkxTe977EJSX8EHSjeII0tlPeJKhZnqIh1eK/Yi+oXXqwXQRP2k
	 w7SnrRkqiZAqQ==
Date: Fri, 18 Jul 2025 02:56:19 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Martin Uecker <ma.uecker@gmail.com>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <p2gl2w7gntydz4lpoyrazha2hqswwoggykdxo2un7us5wsc3lp@ij5my4epi3ot>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
 <20250711184541.68d770b9@pumpkin>
 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
 <202507142211.F1E0730A@keescook>
 <3o3ra7vjn44iey2dosunsm3wa4kagfeas2o4yzsl34girgn2eb@6rnktm2dmwul>
 <202507171644.7FB3379@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k63pphsxoo2hl7dh"
Content-Disposition: inline
In-Reply-To: <202507171644.7FB3379@keescook>


--k63pphsxoo2hl7dh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Martin Uecker <ma.uecker@gmail.com>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
 <20250711184541.68d770b9@pumpkin>
 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
 <202507142211.F1E0730A@keescook>
 <3o3ra7vjn44iey2dosunsm3wa4kagfeas2o4yzsl34girgn2eb@6rnktm2dmwul>
 <202507171644.7FB3379@keescook>
MIME-Version: 1.0
In-Reply-To: <202507171644.7FB3379@keescook>

Hi Kees,

On Thu, Jul 17, 2025 at 04:47:04PM -0700, Kees Cook wrote:
> On Tue, Jul 15, 2025 at 09:08:14AM +0200, Alejandro Colomar wrote:
> > Hi Kees,
> >=20
> > On Mon, Jul 14, 2025 at 10:19:39PM -0700, Kees Cook wrote:
> > > On Fri, Jul 11, 2025 at 10:58:56AM -0700, Linus Torvalds wrote:
> > > >         struct seq_buf s;
> > > >         seq_buf_init(&s, buf, szie);
> > >=20
> > > And because some folks didn't like this "declaration that requires a
> > > function call", we even added:
> > >=20
> > > 	DECLARE_SEQ_BUF(s, 32);
> > >=20
> > > to do it in 1 line. :P
> > >=20
> > > I would love to see more string handling replaced with seq_buf.
> >=20
> > The thing is, it's not as easy as the fixes I'm proposing, and
> > sprintf_end() solves a lot of UB in a minimal diff that you can dumbly
> > apply.
>=20
> Note that I'm not arguing against your idea -- I just think it's not
> going to be likely to end up in Linux soon given Linus's objections.

It would be interesting to hear if Linus holds his objections on v6.

> My
> perspective is mainly one of pragmatic damage control: what *can* we do
> in Linux that would make things better? Currently, seq_buf is better
> than raw C strings...

TBH, I'm not fully convinced.  While it may look simpler at first
glance, I'm worried that it might bite in the details.  I default to not
trusting APIs that hide the complexity in hidden state.  On the other
hand, I agree that almost anything is safer than snprintf(3).

But one good thing of snprintf(3) is that it's simple, and thus
relatively obvious to see that it's wrong, so it's easy to fix (it's
easy to transition from snprintf(3) to sprintf_end()).  So, maybe
keeping it bogus until it's replaced by sprintf_end() is a better
approach than using seq_buf.  (Unless the current code is found
exploitable, but I assume not.)


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--k63pphsxoo2hl7dh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmh5m60ACgkQ64mZXMKQ
wqkLwBAAhgrJrpnkhBACfYY0eDqJcZh5qz8L/7W6xPGCf46NZSmjG/xJiYD2Ystf
j2+6m1UM6ynUzTMKK0hUo2nMhmBqqd3mmgFpTgWO6iwOt+Am5C7+RuLtBhCNrAh+
kYBPjichLntIH4Di6kHYlGevuH2NCR5zh5ImDK/fbBl56V6p0YTJCFGKqqWeiKo6
UI/SXQgqL1leL6clVP18x0WTaPfslnoZ9SlbGT2FpVIkhs/fLzcfJm+sXDQTzGff
1ccwyUPLGSJoiAD8jlrAxPson+KND8FtjU582aK/JwX05VVZSPzcKJLHm3Vu36j0
ye+DL97kD00ebWjS+w2u9F2Xfl5mc1cNqGJUHhmaK2jJV1JTlus1HhWgQp9rNe/K
49FWUIhnfqG2rz1kFzpGyTJY0zEXRmctcmm35K+qiGKnFHpO3DikvtBbgTPlOO2/
+8ODvnlfr0ffTLHZ3Zh0x+vvKqCXm/OI7Wm9H3utA9X3GvSeDIYHfYjtTuJFyO8F
Hw82ItMzcbi9h2mOgUQtVliLtxskzOxt+1jN+QgUfcRRQbV4K21MTQ/HzBioIKk1
JUQZbyYIaXqS1RsJ308A4fuDA+XR5zah2Zn7WiIbVmnU7/xt72UQ3Jrq/jr3f0aW
pXJ8aI2ggPuQXwUaF1pN3yHwlAXdAVziskVxXFiOXPTp7WXtC/c=
=mSgQ
-----END PGP SIGNATURE-----

--k63pphsxoo2hl7dh--
