Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913855;
	b=tUa99nzE9QU9ynbodx7GayVs8SItia7M7NmC9RN5Vdescq3CceTALvc2ZUn0zHIRgb3T
	 vZtipEq+D0eRiZrHs95B8D4zwmqccpSRKNhFWtUnwsx8ZGLOoE1t/XemL5ZXlCDZmy09f
	 9okDcQZjlwQNzUgygaM22+kiVQxUkkavmKUkz+CcIKtVWSnfL30x/FJYpzsZdrurNGVRF
	 9i/qrRJ80DGCEma8BcCmg29oA8CImjlwhlC8DY+cdYS3NzXdUQzKzazhNk1Oh93vdBav6
	 YWw0SyrrUWrw398x472DPYxutcfTTvvxIj+ayj/Pd1Ehu29TtvWqhNU0n8KB4AHB5pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913855;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RL5BhiqJaN/kv+lpAW+VL6m3SxBczrfzmnRexU7rIck=;
	b=jw8MPSG46GMNemrSIt2DOgEJJnIOyYkaJJSZOjjzZZIdlgIbnjiNjgwitgSYkcAmM4b3
	 4p+Bno2wM3+9o8pSHPPr/E3rJncbZBdLkrvK4xOBIAuVy+BbI9g7sh7Zax/dyHE1YNim4
	 WjdHilj8rO9Hz3x3gHkiXXVlLnOYTwgveHsUu3zu5CFWXVZwQjU0DFaY7wLrzgREAmxyn
	 0fDC80CzlZR3Ad2yYoNDChWcPQBn9t2L8QgAo0FUqEp6v/YVLZczSVjqFC+9U3CYiQJ0f
	 YWzl3J6RLD0Mn0TMhpJTOnCNmKqbVq0x67MEDekPr61hTqHRI9CF/HruzCQv2N0/sdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbsA1GaX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8103606A31B;
	Thu,  5 Nov 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbsA1GaX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52121F0089F;
	Thu,  5 Nov 2026 21:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913854;
	bh=RL5BhiqJaN/kv+lpAW+VL6m3SxBczrfzmnRexU7rIck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gbsA1GaXPI4QnttpwObOJr6cz6NiyjV4gcFXP4+DlrAX21vVmLOwHoUY34gJ1eBiD
	 lDCjiaD5XNdUK6sslw7T/y+IsTWrf+XXg+RT+XqQ4FvmnInd6GhmqjFxwwrAIe505T
	 taveJhHFkKCknGncsIH2+Zt/xTD7nTwtOUWP3ds07tEz6fDYCkA/UbnXjdt7yjykkd
	 a0E5SE/Ly92P2mgvV8IRxG0WA7QGSkscPWWMBb7/4Y1gSlAKnMPyNfR1CHuZgbhIHo
	 CJOsXZCbj3PrR60qpdWkvaayVoQ/5EMbY4X0JPtz76slazQ+0HSfyhV7XGyk7qG5jN
	 wbT9FSJVPA7JQ==
Date: Thu, 5 Nov 2026 22:24:06 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auzxXyAU6zyHtMtn@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
 <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local>
 <auzHFRzd86iV4-RA@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="2jm3oxexb27di5hk"
Content-Disposition: inline
In-Reply-To: <auzHFRzd86iV4-RA@ashevche-desk.local>


--2jm3oxexb27di5hk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <auzxXyAU6zyHtMtn@devuan>
References: <cover.1793876837.git.alx@kernel.org>
 <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
 <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local>
 <auzHFRzd86iV4-RA@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <auzHFRzd86iV4-RA@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-05 20:12:37+0200
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> On Thu, Nov 05, 2026 at 08:08:57PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 05, 2026 at 06:46:18PM +0100, Alejandro Colomar wrote:
> > > > Date: 2026-11-05 11:50:19-0500
> > > > From: Steven Rostedt <rostedt@goodmis.org>
>=20
> [...]
>=20
> > > > Oops, typo, I meant trace_event_filter.c
> > >=20
> > > Still not found.
> > >=20
> > > 	alx@devuan:~/src/linux/linux/master$ find | grep trace_event_filter.c
> > > 	alx@devuan:~/src/linux/linux/master$ find | grep trace.event.filter
> > > 	alx@devuan:~/src/linux/linux/master$=20
>=20
> Besides that the above is yet another "Useless use of grep".

See below (spoiler: not so useless).

> > Oh, you are an oldschool guy :-)

In this sense, yep.  :-)

> >=20
> > I can't believe people with Git index available are using `find`
> > and not `git ls-files`. `find` is too slow...
>=20
> $ time find . -name trace_events_filter.c
> ./kernel/trace/trace_events_filter.c
>=20
> real    0m0.081s
> user    0m0.028s
> sys     0m0.053s
>=20
> $ time git ls-files \*trace_events_filter.c
> kernel/trace/trace_events_filter.c
>=20
> real    0m0.014s
> user    0m0.010s
> sys     0m0.005s
>=20
> $ time git ls-files \*trace_events_filter.c
> kernel/trace/trace_events_filter.c
>=20
> real    0m0.014s
> user    0m0.004s
> sys     0m0.010s
>=20
> $ time find . -name trace_events_filter.c
> ./kernel/trace/trace_events_filter.c
>=20
> real    0m0.083s
> user    0m0.021s
> sys     0m0.063s
>=20
> (with IPC to `grep` it will be even slower)

Actually, IPC to grep(1) makes it faster, not slower.  :)
Not only that, but I get to use a regex, which is more comfortable than
a glob for finding stuff.

Even if only for the regex, I find it already worth it, but the better
performance makes it even better.

	$ time find . -name trace_events_filter.c
	./kernel/trace/trace_events_filter.c

	real	0m0.064s
	user	0m0.025s
	sys	0m0.040s
	$ time find . | grep trace_events_filter.c
	./kernel/trace/trace_events_filter.c

	real	0m0.059s
	user	0m0.023s
	sys	0m0.043s
	$ time find . | grep trace_events_filter.c
	./kernel/trace/trace_events_filter.c

	real	0m0.058s
	user	0m0.033s
	sys	0m0.032s
	$ time find . -name trace_events_filter.c
	./kernel/trace/trace_events_filter.c

	real	0m0.070s
	user	0m0.020s
	sys	0m0.050s

About why, I'm not sure if find(1) is slow at filtering, or if having
a separate CPU working on the filtering makes it more powerful (perhaps
both).

I think it might indeed be that find(1) is slow at filtering, because
using git-ls-files(1) is faster without piping to grep(1):

	$ time git ls-files | grep trace_events_filter.c
	kernel/trace/trace_events_filter.c

	real	0m0.023s
	user	0m0.018s
	sys	0m0.010s
	$ time git ls-files \*trace_events_filter.c
	kernel/trace/trace_events_filter.c

	real	0m0.016s
	user	0m0.012s
	sys	0m0.004s
	$ time git ls-files \*trace_events_filter.c
	kernel/trace/trace_events_filter.c

	real	0m0.011s
	user	0m0.011s
	sys	0m0.000s
	$ time git ls-files | grep trace_events_filter.c
	kernel/trace/trace_events_filter.c

	real	0m0.023s
	user	0m0.017s
	sys	0m0.012s

Still, the fact that grep(1) is easier to remember than git-ls-files(1)
means that it's worth it for me to pipe to grep(1).  But indeed, using
git-ls-files(1) in this pipeline to replace find(1) might be reasonable.
After all, I don't want to search in temporary files.

BTW, on top of all this, the interface of find(1) is so badly designed
that I can never remember how to use it properly.  Compare that to
piping to grep(1), which everyone knows how to do with eyes closed.

Necessary link when discussing about find(1):
<https://doc.cat-v.org/unix/find-history>
(it's quite fun; recommended read!)


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--2jm3oxexb27di5hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrs8+4ACgkQ64mZXMKQ
wqkiFhAAqFKamchoNDNeTetmiCh3yJp6GUbHyaX2RrrE5EdmqnhkEX4NQk0+JaXn
1ImkNyzgBAAOwyJaDxo7nnveXmK9DzPk8aIMt7ciqhb5d2O5sZJ3PLxNMl4Fzuoe
lGjop+rtjDb69AMcqOuPdlDqxwh8uiinyVeCqP0hqwN7OmOjajGSlQr11buRLI+d
pgMJZGiws5vKtInNzV1/weIgBQtgM6fqpWiS40XQlgyALWl/h2d+5wT7veje8quA
VtCLbm+Wgv/WUyAEcVd88h8U/M/8B7YGq3tD8LXinuDvXf02/crJn6eHn4bWBnPS
XRQunxLUeSL0xmiFZHYYOzIaVbJHr4Gc3c3mzqiGPJlXFvmyPMwKjJza1Ix7WKij
I06KwMkQSj9rSFi69ppg5TJ4KgAg99lGEV8eJH4M5Itxcvd6LmTkYktnBfWTrVDm
btA8iOPm94SE3RGW+LLQS6Ozz/lvGsIytydiwnMJ+8c66x70PNHSkIaWJ1wj38HR
uXdg1EhLTpAzVvJ+nSzx4Bz7o3HxsYkc/XdwKdlzCriAj2rPHc26AYhCv6ES9XCw
yY3UO8+D56tuq/bM5SBi51bIFpch6ATnPpo2FuYVvNqoD/e/DR2G1ruK3iRkEtlD
mpz+6bnkWoaknK3xeyJXiS5YuoSfFWeM8sE+gfUmjTZ7Ett3iRA=
=oZOp
-----END PGP SIGNATURE-----

--2jm3oxexb27di5hk--
