Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701882;
	b=2nxy1Xi+9Mr3DhOGWWGrrD/n51J4E79/gBBvJj1lVex7qcJRB7IF0FDRrWi03RPTYyB1
	 EqPO4lT2DoOBbczrmzphoDhltw/x14bnjY1xNPOrkey/0ddKpW26AtDkKGYKi/F2xB0Yh
	 kJyPs68PjH7lV+jobHBDKkditEUaxL+Lkytyl40mGeyiE6K/kiJ0xgGjdtqwzSY2xOz6+
	 +q9JG3Z9SD7As2Jceo3nQrhQ3R6A5CDYucG1uTAJscfR+1dBl3DLF74JHo1HQhztR/Ps4
	 Fzpue2s4G3uosHW9FhLLW0o5Q9KE/zng0PlxchgfKMOzGDvjB3MkKVejO/j5Npr0uew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701882;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jlxncGVxFpDK01Emwf1U5Zgiqw0FwYi9EULoLejK12k=;
	b=UlO9lEdhXt0NC4lYcA97/GHSz3e2HwyrT9YiMYW5JNfC4KkXye28zioT/KjwQ6dIsTj7
	 S8eS1twz0ADhgiI7EQSCPz2UKefRggHbYEce+9eg+eB4m5Mz8Ivo7x60kM7muHo3mtJra
	 PuqgSjwxi3leHJTBMEWVn87jZ9aHh75hIye7I/utW9lJf8oGfxSukavCADGoco6Uc4SR9
	 G2g8EVPliKvmjoagSmevGZ0MdRMlwfqa/EWXWxl8VpWyc2g4/nHmDATtE4m/AXQKe636e
	 bvR9Wd3mY/9JJ12dr3pbzRW6HFhNi72nb7LwAQy4TCTCSrA1lU5pJFW/hqoqgkpLuHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJyr09h1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBD6606A31B;
	Thu, 22 Oct 2026 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJyr09h1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A531F01829;
	Thu, 22 Oct 2026 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701882;
	bh=jlxncGVxFpDK01Emwf1U5Zgiqw0FwYi9EULoLejK12k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CJyr09h1dL75Ikg9c1ncuVXJFgFKylIswGGHvDKqT/RjSgnB7qNhYNwzEicodYYA3
	 nBknJPS46IQZ+DS/Yas3bOx/ps8Ds6cMOEG7DXVxbaSfi0VaKcgTvXdU2eNE+6YV0s
	 CimepLsxhxhDy/hT76eN0VLq3wbRjhavCjSXFwzjh318WDkMmpiiYZQ1Ibs42U1WiE
	 y2ZM7+ZtcuGg1reNDoj8cWZ63Im7NJGDoYBqIsJcJbh5ec6JMD7tY06PCQx3HOXL3n
	 FMg9WHHM3DCmFnDKsrZxJwsQwqGi5VL3gX9ToU68hQTBPPu9aOKnlhkNwMdt0lpqB9
	 Pe7kutQkpFlRA==
Date: Thu, 22 Oct 2026 22:44:32 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atp1fpREBhWiytaH@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
 <atpyCU3fDyU95hbY@debian>
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
	protocol="application/pgp-signature"; boundary="33adycpuwhpuz37o"
Content-Disposition: inline
In-Reply-To: <atpyCU3fDyU95hbY@debian>


--33adycpuwhpuz37o
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
Message-ID: <atp1fpREBhWiytaH@debian>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
 <atpyCU3fDyU95hbY@debian>
MIME-Version: 1.0
In-Reply-To: <atpyCU3fDyU95hbY@debian>

> Date: 2026-10-22 22:38:12+0200
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> Hi Steven,
>=20
> > Date: 2026-10-22 16:20:00-0400
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > On Thu, 22 Oct 2026 22:11:27 +0200
> > Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
> >=20
> > > Agree.
> > >=20
> > > But still, a better design would do:
> > >=20
> > > 	static inline void
> > > 	seq_buf_set_overflow(struct seq_buf *s)
> > > 	{
> > > 		s->p =3D NULL;
> > > 	}
> > >=20
> > > This is way more robust, and also easier to understand.  My head is
> > > boiling when trying to review this patch set for correctness.  That's
> > > not a good sign.
> >=20
> > But that loses all data. We still want access to what was written.
>=20
> No, it doesn't lose data.  My proposal is to have this:
>=20
> 	struct my_seq_buf {
> 		// .buffer points to the start of the buffer
> 		char  *buffer;
>=20
> 		/* .p points to the current position.  This is the last
> 		 * '\0' that has been written to the buffer.  On
> 		 * truncation, it is a NULL pointer.
> 		 */
> 		char  *p;
>=20
> 		/* .end always holds ARRAY_END(buffer).  It is a pointer
> 		 * one-past-the-last character in the buffer.
> 		 */
> 		char  *end;
> 	};
>=20
> This would be initialized as (of course, wrapper in static inline
> functions as needed) this:
>=20
> 	char            buf[100];
> 	struct seq_buf  b;
>=20
> 	b.buffer =3D buf;
> 	b.p =3D buf;
> 	b.end =3D ARRAY_END(buf);
>=20
> Then, you would write to it as:
>=20
> 	b.p =3D stpecpy(b.p, b.end, "foo");
> 	b.p =3D stpecpy(b.p, b.end, "bar");
> 	...
> 	b.p =3D stpecpy(b.p, b.end, "baz");
> 	if (b.p =3D=3D NULL)
> 		goto fail;
>=20
> Then, at some point, you might want to initialize a new buffer out of
> the remainings of it:
>=20
> 	struct seq_buf  b2;
>=20
> 	if (b.p =3D=3D NULL)
> 		goto fail;
> 	b2.start =3D b.p;

s/start/buffer/

> 	b2.p =3D b.p;
> 	b2.end =3D b.end;
>=20
> See how simple this becomes?  (So much that you may doubt the necessity
> of the set of APIs at all, but they don't hurt much either.)

I didn't mention it, but I think it's obvious: you can still read the
string by reading 's.buffer'.


Cheers,
Alex

>=20
>=20
> Cheers,
> Alex
>=20
> >=20
> > -- Steve
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--33adycpuwhpuz37o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmradbAACgkQ64mZXMKQ
wqmSZQ//exn/b6LJ5pZotM1Ld0/oThPZEK0iZZrF2VSlfy0HWZy507IwDSNzrFG/
XvFjkByM/dlvHzIHW34EKPK/5PGGUm8Yk9yv1ecPhcr+GiukQrgvHEshFSmz8+kN
NxCrB9Sb3FTE6QqA11P1eayg3N4FA45tn0ogpigi0l0CrWgPXeEmzKjIJnez05OP
NgBG8wjWp/wmbKLr96oEYvAr8/fG0xah6mKewplwLZ42/A75XJ2/N9wZLvnZ0gr+
/pMOW+mUwxopF/aVsvFkzdUJxQ1wCls1Y1S5C3lEhF95e3Ht5Gqm7cjfjbHQelhy
ka8Ld1aLl2E7txHwsGKvDFZr8JN8C0ErsblYHCHaZqc4YMEFjxChHgyul2LvZ3wj
yvhZCkzMd4D+IAvhAdPNqKrTT+EPn9kmnAaYQztccOE1dYF9LoLTgMSKfGd0DUn0
cSKWGRT+wBFTXwIGbWz8DZmK1Wu06phqkk8y4hrj5NJw1iXcjpt92OGm/fm7mCJ3
KbkqQvhxnXLXnuLChbvuDCRWT6YT2DWE3YNfSjxb2kcaDC5GNVPg4gl1HOT00+OT
6jYiFkSISx9SK3EAah+j4M4r2HVXUDdFaMO7sl7jVpi9T74b8/5HIfRvQ5V/KKps
QmujfAnkDemG4mAb5yakkY00VIe6Wz0ftw09m3DhuFfyZvbUFXs=
=I9WC
-----END PGP SIGNATURE-----

--33adycpuwhpuz37o--
