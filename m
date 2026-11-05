Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878737;
	b=RIrOSuXo+Y0naCT/vaYk4q84at8b/m7RBRVSYiwp28VGUH8s9PNSUxLG0mlx7jCcJ+eL
	 /wsNESy233p4PLeNxbuYkQJ0G2VwApmS9ueuQwXPbnCzZqlOvlhicfgUIk9xLLra7Powu
	 aJDdQzr30RnFZT5usmaa8crmJE6gfBp47CLFkLGge63t/yIlx8mMbn/bwowQhAKYdxUrB
	 POxlvOOEoKtCO44sKQiEzs3LWCjzRmiY3Pjy97M6M7XSTBOtFhMSPJUBbP1eogYx+ekK9
	 WQgj5cyqzijntZVXmNcSc4pCHvI4wnE681leCU4lls3+6SYUr1T8HyiMnbizeE950CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878737;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iuAuq2ID5TGFzn2pe0VJ1GBuLXTQHkhjD0pbehz9mLo=;
	b=f9IiegzVA7HZ5sKA0Ycig0Nu6VotEbP+W0WvjyKu1So7t8Ss/krYWwfo6XAczxGRDM8i
	 M/3tlXhuilUiWS/o/D/xkihSG8KP1v/sl1wK5l0exgb/1Vlg9YHXzNi5yAETekPouTkOg
	 iH2z+h++wK/Rd2J3JTRoX31rqnN+bS6xefG0Mo1Z/WF0eJeJMoYwH0Cs+F7vAr4EsoNjb
	 Cb8p0RmMxF3x4IkAwMmHnO6gpQ6Oa0dBOYOpGu1hIVSSbdu+uuzTzGqucdEfysOGhRAXd
	 iUC1wUKqWq+0WPlmVt2V7lheJdycBMMQC6xSMKxv2nEsod6QdztWMHqjtZGCRQlhO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKsbFlx8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA220606A335;
	Thu,  5 Nov 2026 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKsbFlx8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F1A1F000C1;
	Thu,  5 Nov 2026 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878736;
	bh=iuAuq2ID5TGFzn2pe0VJ1GBuLXTQHkhjD0pbehz9mLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MKsbFlx8167Xt68/FdC4AGG+0FAoLxd96i0SMW6DYf1Rp9REAm71JsCQK64LXDfmD
	 jpQIFxb8Ljs+dtF4hCQ/J1SH4KWevWOD31InLwMOA50QmzkxVFoluVhfd3A7+h3STZ
	 05rOnfFDuaxSVd0sstW+I76xhw0/RFbI6uhBJfujzHjG7C9sqCPTV3OdBm3XqHLER7
	 +vop+yVrDaDhHo/gUpdEEj1gnzpiH+lZgCkS4+2bl48d/XaHjeFbe29HfC2zih8t6s
	 Wxx9UZwCgE7j7t3xTYS1fATgSwwd4D4elFQ74zzj1PrVCpl9NqB65HOSzGHKBeLEkQ
	 Fh/jNGj55+tcQ==
Date: Thu, 5 Nov 2026 12:38:47 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <auxn9fKsOKeIFIJa@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <CAHp75VdFH146fNhw1ysUbgCPbpv+K++kWvbyZxU=V7tDh0T88Q@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="rgj25ae5zgxkqfls"
Content-Disposition: inline
In-Reply-To: <CAHp75VdFH146fNhw1ysUbgCPbpv+K++kWvbyZxU=V7tDh0T88Q@mail.gmail.com>


--rgj25ae5zgxkqfls
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <auxn9fKsOKeIFIJa@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <CAHp75VdFH146fNhw1ysUbgCPbpv+K++kWvbyZxU=V7tDh0T88Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHp75VdFH146fNhw1ysUbgCPbpv+K++kWvbyZxU=V7tDh0T88Q@mail.gmail.com>

Hi Andy,

> Date: 2026-11-05 13:24:18+0200
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> On Thu, Nov 5, 2026 at 1:13=E2=80=AFPM Alejandro Colomar <alx@kernel.org>=
 wrote:
> >
> > str_has_prefix() is based on sizes and lengths, which means it must
> > overload the valid length 0 to mean not found.  This is a typical
> > consequence of choosing to design an API around sizes and lengths, and
> > vanishes when moving to pointer-based similar APIs.
> >
> > This patch set adds strprefix(), deprecates str_has_prefix(), and uses
> > strprefix() in one place to fix a bug reported by Bartosz.
> >
> > We can later work on replacing the other uses of str_has_prefix(), which
> > might hide similar bugs.
> >
> > Testing
> > ~~~~~~~
> >
> > I've built this patch set with 'allmodconfig'.  I've not run the
> > resulting kernel, though.
>=20
> No, all lib/ new code should be accompanied with new (Kunit) test
> cases. Update the respective lib/tests/* for that or if not yet
> converted to Kunit something in lib/*test*.c

Thanks!  Does this sound good to you?

	diff --git i/lib/tests/string_kunit.c w/lib/tests/string_kunit.c
	index 0819ace5b027..702030dbb93b 100644
	--- i/lib/tests/string_kunit.c
	+++ w/lib/tests/string_kunit.c
	@@ -287,6 +287,14 @@ static void string_test_strspn(struct kunit *test)
		}
	 }
	=20
	+static void string_test_strprefix(struct kunit *test)
	+{
	+       KUNIT_ASSERT_EQ(test, strcmp(strprefix("foobar", "foo"), "bar"), 0=
);
	+       KUNIT_ASSERT_EQ(test, strcmp(strprefix("foobar", ""), "foobar"), 0=
);
	+       KUNIT_ASSERT_EQ(test, strcmp(strprefix("foobar", "foobar"), ""), 0=
);
	+       KUNIT_ASSERT_NULL(test, strprefix("foobar", "bar"));
	+}
	+
	 static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
	 static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
	=20

BTW, I don't see any existing tests of str_has_prefix() --the API I'm
replacing-- under lib/.

	$ grep -rn str_has_prefix lib/
	$=20


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--rgj25ae5zgxkqfls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsasEACgkQ64mZXMKQ
wqk9Qg/+OQAqxdYzvH5vd6JAN205T5MzqQ/i65YlKf7EUl2HRQyrb2LYH5Hih1M9
NwzT6aHOK2UtZhMmHBp7tqqWKDinP2l5MS8OyFX5E67DsK2OMzxlxk/mHqoAwjsH
PrVOHXTVU5DYQr8+qnEtkNcHVk0eCR9+rlp26DKymdDv/qRdIsIYfYx0UiFV0t7g
TSBmvl0Ys/VswxpEcZmDKybM0PB7zCjG9w/aTYKS6UW7v6soSyTkZfjKJvntk5H7
DBZVjLbN4dyrIQcs0QCP4Q1Prto1xHAaXHI0AFNvRzW0wf4MMaY9GzXHu5NZ2aO9
SNvjSVkgwtY3AN8DBEucqt3zC/q1c2dwY2G7WmAOR6T3AS/pw4ME/rLOnJgiLP4n
5qbO2a8ozXnJkp4XYdLefBWreYgkVxmHkSDzd5XL8Z1ymtAKu623HeXGxLkGsuwc
nIxoMfFVV6YsMvDXKFnwYj8jZoXAB4iYXxzUuRJRX38FBY0YtS+ZTTSxkg3orl6i
PNx5buOyY9SUvMaj0kW07uWBNSFMeUgjcE1GOFnLvTRTGVOFW3VACpCdUx5jtpqv
tRu2pi6+7rQJfaoT0m6vvy84m9qHrFnWbh5dfgZK2WH2MO9zuU2/ma2zIy+m+t1K
BwtfkKVuv4DAapnOpA08RMO79tt6dtnO217R7F2ffvNHTr8Ix3A=
=29ag
-----END PGP SIGNATURE-----

--rgj25ae5zgxkqfls--
