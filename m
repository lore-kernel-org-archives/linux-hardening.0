Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877183;
	b=oWPWyhCzWXEGlRRDkN0rNvPmR73bmhxPaxJja9uEJJRyZzK1QzQjuzkG9PvKfO6877bH
	 urpgiM8gQ025oNj51X8pl1Bzx9f69efkiqwyzHrqgHjiSF3fwTV9Ip0jOWn0zGolNd3xV
	 Okw5FXWBhscmAxpvkmv8SA5LQEV7/wAkkHmUrcZs4/GQeg58lWNpUOJglX0RlJk+s2lFg
	 vHKv69D8w2oZD2k/KuIhuYvHapZnKibm3HLuGKv2f9H9Y5fk0BY7ALJz+NPCDDgJC2RqU
	 24QIFN2+GZqDKCg9wbEEbZ0PvnT+p7tWBiYjL5dR4RtjVBo6+Ycwal/wAsjNo4DBkRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877183;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Disposition;
	bh=zwhdkb/FX7XgqeOXnGWlh03jUQFZ+bFCBVltb+Toynw=;
	b=uoOxotYFe4WOEY1UTsx6PRdirDs7Nb6Ts5Ejwa7tU54hxuDHK5JKnXaHg5zrw6iAE3Vf
	 JD/S1SnZkaq+YQqk2YO+ynV0rGa8d/6gk+3qd329CsytlTPVOHL48lKyKLJhRnomnomkp
	 q7sJ0eQlR64znT4hZ59/RLeMacesPGRSq8gV62v1y9Egcs05n3ox+uiqBW+wMtN48vhDt
	 ff6WTsnfnokyy71/Kl/C5s9jiAo7dWJ5ev8JVa00P9zwooaTiWdaoZKJWiIV9dNUmNbjB
	 hwX8Mbayx8Yaoev/4bfNh151CCexLHcfuhAhFIclklFdqiGGXNgwklGXkGudgOqdqQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIkevbHs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57971606A338;
	Thu,  5 Nov 2026 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIkevbHs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330D71F00919;
	Thu,  5 Nov 2026 11:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877183;
	bh=zwhdkb/FX7XgqeOXnGWlh03jUQFZ+bFCBVltb+Toynw=;
	h=Date:From:To:List-Id:Cc:Subject;
	b=XIkevbHsIuFatnIQvUdyH53B34yzxrvtzro+0Jrutc5WWjZ0Fd8SodiGTmVObLFpy
	 UOgs9oxsOwC+eF0Z8ntKi31nw/tJA1INR336g9pVLRBv6k8JigcEiH6gUMG70bIzAc
	 ZSS7h/YcV+tOrx3v+op+ycSZ+n7hBVihOw3KS80tTHJqIY5uH45XtiKE7GgsLda5s1
	 UUpOTTf58b6XZYH5qB3f6J8J6jOiRIprGwwHGNDTNHvW9CuyaKYJwYzm30+3YjL1B0
	 QssZ/OxFQfFf80LiyYFbXCr5km+40fwyEXqKfLspFXgAuJojjrkYgiveCNATAlvHYw
	 HvtVmHsjW+cZg==
Date: Thu, 5 Nov 2026 12:12:55 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: alx+linux-hardening@kernel.org, Alejandro Colomar <alx@kernel.org>, 
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
Subject: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <cover.1793876837.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
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
	protocol="application/pgp-signature"; boundary="r6xff2usp7bnktkk"
Content-Disposition: inline


--r6xff2usp7bnktkk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.lore.kernel.org>
Cc: alx+linux-hardening@kernel.org, Alejandro Colomar <alx@kernel.org>, 
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
Subject: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <cover.1793876837.git.alx@kernel.org>
MIME-Version: 1.0

Hi!

str_has_prefix() is based on sizes and lengths, which means it must
overload the valid length 0 to mean not found.  This is a typical
consequence of choosing to design an API around sizes and lengths, and
vanishes when moving to pointer-based similar APIs.

This patch set adds strprefix(), deprecates str_has_prefix(), and uses
strprefix() in one place to fix a bug reported by Bartosz.

We can later work on replacing the other uses of str_has_prefix(), which
might hide similar bugs.

Testing
~~~~~~~

I've built this patch set with 'allmodconfig'.  I've not run the
resulting kernel, though.


Have a lovely day!
Alex

Alejandro Colomar (2):
  string: Add strprefix(), and deprecate str_has_prefix()
  device property: Fix fwnode_name_eq() for empty node names

 drivers/base/property.c |  5 +----
 include/linux/string.h  | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

Range-diff against v0:
-:  ------------ > 1:  9c81f6f62fd0 string: Add strprefix(), and deprecate =
str_has_prefix()
-:  ------------ > 2:  37eafcd682b0 device property: Fix fwnode_name_eq() f=
or empty node names
--=20
2.55.0


--r6xff2usp7bnktkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsZLcACgkQ64mZXMKQ
wqmjpg/+K1xFGAApGF5BLfzlRzVRpA+1k5MiUCC49l6XlbXGUB2uQKu+OojHxCCc
Gh7JfPJFn9abea3K2Ym4d9yrDgPCn9e6lf+GLP44VAUqoSC+mLlLhKicIut7CBYx
aCXDUIgSofgmLiMyt83mQnhzdtbAWxRfA/Nyh4HEhxMH9CpCbtyycYRt23c67St4
VJSUM1G5arNmAB1Qfsq3r+3q8eUGXIeeIDwN3bLIwIfzT9I0MZdo0xOlRDQuLmRZ
e5UU1Zx1TL1LGU1Mtw8axmw5hA9k/+hB5NsihuT0mJblpNMOmEAQ+7VdKfDwi5/F
8w+2nxlDVp0w7h0q9lVi9L281Fkx4sjoyjtYfBf7ArAb9Gl0KQWFzKNVQnTPn9z5
Q0BB/9mTqeH9qdnPOQMx6d76YMYEUaDiWGdsuYRL/wZO3mNv9iAGPPG7vKdcfvLw
uMg3WRPQJg/oxhGdixM2srF1tqG7onvf75YxMH0D0Ph31KN15F8BOxxwskWYuOmp
i1hIhcXfxTVoKSBQiPCetc1n8Bpf944Foe2vloqgM7vxrT/XP+nj7opx6kcDK6ch
fhtQhHSIGevflJO4xRWJVg/I0mGYs2aJE/1WvnQ1vPDizW0r/k7mAKIVrlUghPF/
8q5WI9ZpWUuvlT8Vf8YMpaF+vMI94Idp9BsqBiE+c3XhRm6pfAg=
=0/kl
-----END PGP SIGNATURE-----

--r6xff2usp7bnktkk--
