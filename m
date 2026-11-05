Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891218;
	b=WgI0OcO1NIXSm6FAHKG6X8/rrbesDssU4/hK3Bd1CQiUX1oM5/P+9Y12QCYHu03IsqKg
	 ty3cYRsSrwMY6PWAwRBQoNi9XTF/iYeHNWdrszZrFfhWvWth2J0tu51cwq94HBOBbo2Nl
	 OAOKfn3k2I47aZHY2XKM51SWWYYaPOHD1sHAvkdXmfpiKfEsTYkArd0DwbAKnXNgyeSC4
	 S4/bWLLejVHk4fOEZc7CxTR+on8nNyAfk5nqlc6cmF6hJtRv6Vhy8pIoyamdHuKNdni94
	 sOqVi+V3eUoreYOUQLa8AX1EN1mEPibyGaf2y7H31RNloH6VZ6Yyx2kof4CtlfJb06A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891218;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6cAL6r8QQzEft1u86gabuPPWB/y7spYhNu37XkYd50Y=;
	b=o1g+oA99iaNoVT47gPUnZ/28ep62i3m0pMVaQdCZvZ6IkihH1tVMMApjRMjKXT93KEor
	 vRJUN45HlrSMq/bMAs9WZFHUeii8YjJ8KGGecGLQPM7N1loFSx38TnzTR07bB030LcPnd
	 vEpeXUBOTZFXN03EADyahQ0PSpPoZe+2hC8HuF8/Q5PsQH/mT2P01oG669B+VSB/myayt
	 Fjp87BxCHvRrBvJjXP5LjUJadVNhSynVa/rJg0oCo8G5iYcDsyeSRnEiiKyNYuEWd6Nu+
	 f4wm+r53Mjl+WkpoRp9pBPCELIzH5ScFhBJ7pjh9ETLkDpg6M4UdwY39WAs1ikxTnWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HrgQd/ds";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32934606A326;
	Thu,  5 Nov 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrgQd/ds
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408551F000C1;
	Thu,  5 Nov 2026 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891217;
	bh=6cAL6r8QQzEft1u86gabuPPWB/y7spYhNu37XkYd50Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HrgQd/dsCi3Ma85IVLzL4vude7xoT3QcW99egomnDZI+mvhtw4zYEoaL/XC6TfkAD
	 YFhWRebOvNYFFM0Nm1G7ScUXQEj5IpIEOE7P1t7sUjWvTNPN0yKgKQj4trYAxqb5MG
	 bM3aYiGGcnP5g17JXXZHqQmG1PJWzkdehDQSKf4kq20OwgvjeUqKgZzpYzpjuvTLM4
	 FyNHRYO8N93jN/B0f4LQv4qrrMd87Cnr7uNJcR37atuX7Pdu0xUmdgmqFjzWtj5uJd
	 9ajpURToUXg0OTVxqnJep8adfqCMBdemBzf/MvWV6S3wJahbVoesgfcbleyHRkrmVc
	 Q2aObvhIA4yRg==
Date: Thu, 5 Nov 2026 16:06:48 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <auyZMjHue2lUzOT9@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan>
 <auyV47xUCr1EJ7A3@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="63nmargg22lh3d7z"
Content-Disposition: inline
In-Reply-To: <auyV47xUCr1EJ7A3@ashevche-desk.local>


--63nmargg22lh3d7z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
Message-ID: <auyZMjHue2lUzOT9@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan>
 <auyV47xUCr1EJ7A3@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <auyV47xUCr1EJ7A3@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-05 16:42:43+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
[...]
> >=20
> > We do this in the Linux man-pages, as it helps me keep track of all
> > revisions of a patch set easily in mutt(1), without having to follow
> > links or use more-complex tools like b4(1).
>=20
> Exactly the same reason on my side to *not* put everything into a single
> thread!
>=20
> > > Don't do this. Each new iteration must be a separate thread. Please u=
se
> > > b4 to manage patch series.
> >=20
> > I won't use b4(1); I like bare git-send-email(1) and git-format-patch(1=
).
> > But yeah, I can send them as separate threads, if that's the preference
> > here.
>=20
> Yes, in Linux kernel majority of the maintainers (a bit of speculation,
> I haven't counted, but it feels like this to me) do want separate threads.
> IIO with a huge traffic is one of them, tty/serial IIRC also does because
> it's how Greg's workflow is set up.
>=20
> > Out of curiosity, what's the benefit of having separate threads?
>=20
> ^^^ See above.
>=20
> > (Or the converse question: what's the main problem of using a single
> >  thread?)
>=20
> In mutt for tracking I often delete the old email threads when they are
> considered closed to me (or archive, if you wish), I don't want a blast
> from the past for this. It's like starting fresh on each Monday :-)
>=20
> > They're morally a continuation of the previous threads, which is why it
> > makes sense to me to have them as subthreads.
>=20
> The email thread with big patch-series and discussions looks awful
> in such a setup (my opinion).

Hmmm, I have some two-or-three-years-long threads (with hundreds of
mails) in some GCC patch sets, and I find it very convenient that I can
look at all the revisions in mutt(1), because sometimes I want to look
for a comment that happened in some earlier revision, but I don't
remember in which one, so the single block makes it easy to search and
review the history.

When I receive patches in the man-pages, I also find it very nice to get
new revisions as replies, because it bumps the old subthreads next to
it, and so I can check what I said in earlier revisions, to check that
it has been addressed (I don't necessarily remember what I said in
previous reviews, so a patch claiming to have solved my reviews is not
enough information; I want to compare what I said with what the new
patch says).

I never archive email, but rather rely on unread mail being the
"non-archived" mail, and when it's read, it's as-if-archived to me.
Indeed, the reason is that it allows me tracking the whole thread in the
same maildir, including relies from now, and old messages from two years
ago.  I've been wondering for a long time what people do to be able to
follow old threads with new replies, but I guess the answer is "they
don't".  :)

But I understand your setup, and can solve this.  I'll send email
without In-Reply-To, and then can add it manually by editing my local
copy so that I'm able to keep track of the threads, without affecting
your threads.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--63nmargg22lh3d7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsm4IACgkQ64mZXMKQ
wqnNTw//e0l8SLoSSAEq44FGq5CdgxEiU+hX1MvBTmDcqSyg3ZcF+OhW5lIp+LiV
SHXzp/ExBt18TKew7drqU3EmUNgZgwJIMn+FWUyVdBK+JHFujiSfK5HeXqKU07w6
ks0mB/kNEnG00avAOHh1NiPQMz+XcPc+vgVoBK983iHFUuwSAzBatGH6q3RVc9Cs
8Pe0Zzr25nerHZEqRAgQYUVq1IvVyVaoyi1c8vhS7ydbHEbg7YOJigKreFj4ycZ9
vKsHKRYPSQbBxttBZ2nk7mJ42EJU96g60iHHMWk9k5F+QLhvaaHO/fQchRKJBfNK
FwusnL7hETLZGefhvhrHw+0cysJ2V9KaF/VELCPpPp7jDlbZSC7+sZPx5GQS3Hd9
/E2oye251dTkYsakY2FYUy/3mZwesPUHOUrWjFBMPvGRj2P84szBEwB5H5ZufkST
IPxQIaGnWDZ0tRETvpelNq9W8nCFlNgAgSiEOTH+HDWAJDg9uz49KDu16sm0ZA14
gSNmz3wb2AbsqPfhNstoW6LZZ1SOWJrP6C1dt2gok2UnFc562cb16g99s4JYvCbE
PdGszPcyM4aOqIFwFQamJKx3WIsEr2KmnDXngWxO4TYUUSPbmt0YAxJRvzV8JMGh
Dzk4572eLmQlE7B/RvFLPnN8/NTdGQAjqrMYjtIypLzef8QmeuQ=
=GDM+
-----END PGP SIGNATURE-----

--63nmargg22lh3d7z--
