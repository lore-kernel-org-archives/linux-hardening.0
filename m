Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571559;
	b=2IcOGyX7scSefHPowG5fs6H3f8PfZgpy0vOLy7omThSLya2JJ29Cr9kVyI6uFlJRcP/Z
	 oashYN6RPWOuuWYcTtcq39m6T6hcXlp+XB07ixNma4O/rs/LxhYum3y1rXkzU4Eo4kr+Y
	 UqALI2QH/qm47WIKX6J/3KO7siABEv0/tOeVSBM/l0fyKlLiuqZf3m86scR1up6CRZpeR
	 qtkMHxWBJ3/CjMVFpl6L0w+d6oI3vrftktqLVM5duKbRRf8EMLXlW1Q6947K5NCHOoUl6
	 AQ/XQNzatYv6KiPuMWRQhmu+dQLb4Wp9faTI1cEAsVw6j9CMUGGJz/c+XmJuDCQzqcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571559;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ew8hOC13o9wfy+m40ApTMAeA1rhG3tv6pgX/NAGeWFg=;
	b=G6S5OznqkerFBM+M0+nL/r3MF7nWDNSftmWsDDuRg4R7uInfQRsw1zZXM4Lw/GbX/iJL
	 OhEHy0vsujJrmF6Wj5MjeG0sKrhCKKRTjZTP8utFgwXzefN9YxW2EshRDUMCw+MhHeMSW
	 3/+OWlAEfCs9IJAUrwiWze2nawXF+hfTix0lDEIsQ9Evu3OU0oipnj4es1zvNXsZnqy2E
	 AqjlZQaqncJFJnUenE0dweGVgjeDEKfI+9WxYb9SS0s9EhSeTPskG7j6cT9BmY5WuNF+G
	 4tpHM0co6XAszwDTvJcMFK5Yzxja82vMTpiIy6gQ7Igkjty14DVlqWmg67JviiWNLTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu99j7RL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6F606A88F;
	Fri, 13 Nov 2026 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu99j7RL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9A61F000C4;
	Fri, 13 Nov 2026 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794571559;
	bh=ew8hOC13o9wfy+m40ApTMAeA1rhG3tv6pgX/NAGeWFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mu99j7RLydX3ZksQxHNiqiV8a9C3HGC7C1B9GQzP3i7C2+X8JW5Nsl3ld9KFTB67b
	 rTQi6bipXdld3U/uSYywJut+ua83KWwKn6KOM6cBbQ9OazBf9YJBKXJOG9raq88INl
	 6748FiobUagmQyYCWbJzCZjOYLV+iqHT4vmAdGQoY1QFh/4D3MvGnzABWwgyfZZ8nC
	 qc/PYUysfEen/3hzq4svDwJ/RgFoGqU9AMuqKy2lrFD2S6tqSL9RYtMASWBjIQDY4d
	 YydpyRu0sSvtrB/5rpTSYMdQ5Eh2XX5FTmVV3wKdx/zsKDlnmB+0OS7/K3AkwYAiXw
	 nHkUQpXGCnGXw==
Date: Fri, 13 Nov 2026 13:05:49 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
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
Subject: Re: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <avb862Pr0NKPVPQg@devuan>
References: <cover.1794425425.git.alx@kernel.org>
 <avTIWshl9klX0obF@devuan>
 <avXYmk5sZKS0rm92@ashevche-desk.local>
 <vjuf6ritphyrfi2befwf4pwrujrl3pmjjkutr2ccsvta3jjcep@5mpgr3dc7263>
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
	protocol="application/pgp-signature"; boundary="l2hgnnxajsc5hpxz"
Content-Disposition: inline
In-Reply-To: <vjuf6ritphyrfi2befwf4pwrujrl3pmjjkutr2ccsvta3jjcep@5mpgr3dc7263>


--l2hgnnxajsc5hpxz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
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
Subject: Re: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <avb862Pr0NKPVPQg@devuan>
References: <cover.1794425425.git.alx@kernel.org>
 <avTIWshl9klX0obF@devuan>
 <avXYmk5sZKS0rm92@ashevche-desk.local>
 <vjuf6ritphyrfi2befwf4pwrujrl3pmjjkutr2ccsvta3jjcep@5mpgr3dc7263>
MIME-Version: 1.0
In-Reply-To: <vjuf6ritphyrfi2befwf4pwrujrl3pmjjkutr2ccsvta3jjcep@5mpgr3dc7263>

Hi Bart,

> Date: 2026-11-13 10:25:00+0100
> From: Bartosz Golaszewski <brgl@kernel.org>
>
[...]
> > Are you sure that it's okay to use asm/bug.h APIs in string.h?
> > The include/linux/string.h along with the backed C implementations is r=
eally
> > special in the kernel. Hint: check which stages of kernel boot use it.
> >
>=20
> Agreed. I'd just move the implementation into lib/string.c and not do a
> static inline function here.

Hmm, thanks!  I'll do that.


Have a lovely day!
Alex

>=20
> Bart

--=20
<https://www.alejandro-colomar.es>

--l2hgnnxajsc5hpxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr2/RMACgkQ64mZXMKQ
wqmNSw/+NhDKyBjn0lq0zuI2m5yLY3P6tSCdyIBSR8OKvV5HIUio9mh8ljNal/ym
Sz0hjW4t9OVFiCg4UARs3vPAujQq7jO/vSAa3C2PWQT46VE9RK8aNskYMmFWXuWd
/DcT6X54849AYkHr7FP5+q+l8Q2HFMnXGV+Delvdb/82rKB04/wRMBbFefcJMi92
Z9Ks9wf1Y0JsCjcLHYZIgXD0w3RhzLM33+Cq5jdJtVeTOiBSPLZYywEDeFEBwrJ+
dPkGu2/yKZbN3db4knaI8n8NYmcAYrVehn2XaD0PcYigSCt4IryJjkodh54Z7BOL
fsod+nYMQt6xTt4nE6+g2UgHFhAjxnIjsgr8Rd3josxeqnQJCheCcMUgNIiZR1SA
GFo/CmMtE9IMtffygFSkSt86VQRpSIH49pkeSNwdb40izuxkLmahKBTfUW4tRiYm
NQcO7je5MPGGnM3qSOZSq2EebLlpck0CohvFJvzAKJ7od11NiOIISgnFQ6DuUSqX
zUUTaJt+q2Mt+DcHQj0RFxgWs8xUuacQhaItoGcljBZSM1t5GoamUxGzQqpT6Jp5
0/Im57WXfZxwYbLBbm71EGkOdaNOfb/Gf3g+N34lBjCn7/bxd642ooo4FD2Rq61Q
Y8jtSDFA9KFhFTV/Q2NPiBI48xDhzabFoQguGK28sPybiAZK4Uk=
=BE9Y
-----END PGP SIGNATURE-----

--l2hgnnxajsc5hpxz--
