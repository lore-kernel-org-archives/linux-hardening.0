Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695442;
	b=eoMIiZ07TXz7/2XzD6Nx6SnGW5dJPwOz8NBVpWBoseXS9RwTQIMIFrjmWMOgOm7Vvnls
	 aqTms7oc0VtOZ73fJbT21KLLxOT+ufZMXlLkrjCbcYn3lAdL2wruGlCNbgRy0o0c1xJsE
	 r0RsdPqTIL12eHWxO4G6UzM+9w7E49LidE/eUcVQMWU4EhRegkdY/GGGNXL8To9Z9EDdR
	 7mP+RLLzXFO6Py0KkD1itsMenBOSfseHUv2pPVeP3Ka/9rLR1M9yJKUIfi1Avu1xbbfDD
	 xHj+n9bMJeLowkL1W88blMKvNjkox18GFDvKk8ZoJU4MIUjSwBUpjPLeJwhIHfX41Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695442;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:X-Mailer:
	 Alx-In-Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=hafFXAutGx2P5qfUXeVs2wpCzaq/c3/3n8ujaYS8fcE=;
	b=BO/xPSgfA9ZKtGdfQnJZR4TWqTQ+180x+8Zhw9sLqRzIsuKjfBj5Dt/VSFTxVSbDxDYC
	 hc2pdB7o5veN2QQAipUb3o0EdmfD7otzGbLhNG9J8A7iNNHkg2bghqGmp+0sR44tLfx98
	 +13WYVgxkTI5YVMyDERLxLyX+D0xLiZuzzeb0BAZWOsoWrG0uCvjfBOA7q0nvCQC3AVZJ
	 OAQVc2wsGcmSqxQVeSzLbIE6EZxMqQl/j9KgGpd2CgdG0PEpD8OUnJNnbIQliNbE/xZ3Y
	 Eyy3R+iXYUhwsqRYmf+9E0AWscZuK2Pddv7i7KtnKnKjkhQNuSXmCbHtC5ROuq1usIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njZmbj+7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C693606A31C;
	Thu, 26 Nov 2026 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njZmbj+7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B1A1F000C0;
	Thu, 26 Nov 2026 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795695441;
	bh=hafFXAutGx2P5qfUXeVs2wpCzaq/c3/3n8ujaYS8fcE=;
	h=Date:From:To:Cc:Subject;
	b=njZmbj+7j24SVaRSv//hfuQ9xp9yvl3+1GOyNIwrzZmoyJlRHteTx30R4V97+Cuhm
	 rTx1Y8wqPGpNGl54W9/29aXWvGQeC0FvYQBJTMnUZ74ZuAuQ0RAQPw0VnYFhcVAgaw
	 +vlFl7jZolRY4/mnHGe0ZS9bzeN20jgHTqb8LU69cCAbMZ3mPCVH4gxw+YHEyVM8xM
	 IcEx7Dhw7RORZeroi4tN5D7hAcb4y+SkUZu0r4ZVz7I/Hdyr80v1mbNkupIZksmYCA
	 //2I520m8ymFhnIqQd6+ec8YbeVTCVAO6ua5TzCj+/7VwKAZBL2YpH0I+pWb5zUvj2
	 k9dc+DTCXAxKA==
Date: Thu, 26 Nov 2026 13:17:12 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org
Subject: [PATCH v8 0/4] Add strprefix() and fix a bug with it
Message-ID: <cover.1795695151.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
Alx-In-Reply-To: <cover.1793876837.git.alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="f3pjldnlt7gzzsxn"
Content-Disposition: inline


--f3pjldnlt7gzzsxn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
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
	linux-gpio@vger.kernel.org, alx+linux-hardening@kernel.org
Subject: [PATCH v8 0/4] Add strprefix() and fix a bug with it
Message-ID: <cover.1795695151.git.alx@kernel.org>
MIME-Version: 1.0

Hi!

str_has_prefix() is based on sizes and lengths, which means it must
overload the valid length 0 to mean not found.  This is a typical
consequence of choosing to design an API around sizes and lengths, and
vanishes when moving to pointer-based similar APIs.

According to its author (Steven R.), str_has_prefix() was never meant to
accept an empty prefix, but that's not documented, and there's no
obvious reason why that would be acceptable for a generic string
function (as opposed to a function very specific to its original use).
Anyway, as suggested by Steven, I've added a WARN_ON_ONCE() to catch
such uses, and also added documentation stating this limitation.

If the function had been named something like strprefix_len(), that
design would have made sense, but being called str_has_prefix(), the
obvious way to call it will result in bugs, because the name contradicts
its intended use.

Users of strings need a function whose behavior extends naturally to the
empty string, and we can do better, by returning a pointer.  And indeed,
users have ended up using str_has_prefix() with empty prefix, expecting
it to work (as is natural of a generic string API with that name).

This patch set adds strprefix(), and uses strprefix() in one place to
fix a bug reported by Bartosz.

It also adds streq(3), just because it simplifies the tests, and is also
a nice interface.

This patch set doesn't include the sibling strsuffix(), and also doesn't
replace any other cases which would benefit from strprefix(), to allow
merging it quickly.  I'll work on a follow-up patch, including the
patches from v6 that have been dropped in this v7, after this has been
applied.


Have a lovely day!
Alex


Changes in v8
~~~~~~~~~~~~~

-  [*/4]
   -  Add Tested-by and Reviewed-by tags.
-  [4/4]
   -  Remove Message-ID tags.  [Andy, Geert, Bartosz]

See the range-diff and interdiff below.

v1: <https://lore.kernel.org/linux-hardening/cover.1793876837.git.alx@kerne=
l.org/>
v2: <https://lore.kernel.org/linux-hardening/cover.1793882260.git.alx@kerne=
l.org/>
v3: <https://lore.kernel.org/linux-hardening/cover.1794323750.git.alx@kerne=
l.org/>
v4: <https://lore.kernel.org/linux-hardening/cover.1794425425.git.alx@kerne=
l.org/>
v5: <https://lore.kernel.org/linux-hardening/cover.1794574496.git.alx@kerne=
l.org/>
v6: <https://lore.kernel.org/linux-hardening/cover.1794667407.git.alx@kerne=
l.org/>
v7: <https://lore.kernel.org/linux-hardening/cover.1795639368.git.alx@kerne=
l.org/>

Testing
~~~~~~~

Since there are no code changes since v7, I haven't tested again.
See the link for v7 above to see the testing of v7.  Bartosz also
tested v7.


Alejandro Colomar (4):
  string: Add streq()
  string: Add strprefix()
  string: Document corner-case misbehavior in str_has_prefix() for empty
    prefix
  device property: Fix fwnode_name_eq() for empty node names

 drivers/base/property.c            |  5 +---
 drivers/clk/socfpga/clk-gate-a10.c |  2 --
 drivers/clk/socfpga/clk.h          |  1 -
 include/linux/string.h             | 42 +++++++++++++++++++++++++++---
 lib/tests/string_kunit.c           | 22 ++++++++++++++++
 5 files changed, 61 insertions(+), 11 deletions(-)

Interdiff against v7:
Range-diff against v7:
1:  ad8500a6eb0a ! 1:  8f3840fa232e string: Add streq()
    @@ Commit message
    =20
         This removes some driver-specific definitions of streq(3).
    =20
    +    Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.c=
om>
    +    Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## drivers/clk/socfpga/clk-gate-a10.c ##
2:  b32d70163fb4 ! 2:  a688f0a1c20a string: Add strprefix()
    @@ Commit message
    =20
         Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    +    Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.c=
om>
    +    Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
3:  c4131a109098 ! 3:  fb24c7a543f8 string: Document corner-case misbehavio=
r in str_has_prefix() for empty prefix
    @@ Commit message
    =20
         Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    +    Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.c=
om>
    +    Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## include/linux/string.h ##
4:  396395e1d02c ! 4:  5c23d229235a device property: Fix fwnode_name_eq() f=
or empty node names
    @@ Commit message
         Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-fo=
r-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
         Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
         Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    -    Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
         Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm=
=2Ecom>
    -    Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf=
63j4lb3flk>
         Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.c=
om>
    -    Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf=
63j4lb3flk>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    =20
      ## drivers/base/property.c ##
--=20
2.55.0


--f3pjldnlt7gzzsxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsII0cACgkQ64mZXMKQ
wql7FRAAkr/lSr6+m4oTo+bBZcKBUalA4juB3aKvEJM39TgDsZgfF7FAPVOpwFFi
/iI7sQnqEJnzfr+08LJHy9T1kVp5UfT5a4+La3DFus0Fj9MyIcQTTgNYQjjRQ5Ql
QvA14x/+73Wmt5LA1jgAdLijWfXH3YiH+O9/vx8CAB8/lxY9br8SodpFNACgrVRc
nvXqiMwnHwFSQrioZvNtoG/a5yM3VmTuSIrzjPtS7+UYr0M2znPdw9u7JyynNBza
r/vapzOkiVIh5y50jTOydbkfe9CtgKgiFDLCQhntEkQAFu4JtSNcdGE+mWyrpCbD
bxXEGhJHP1rxhupq6+xCKgq41/OoAMsLHg4G0hVFKCXd0MkuXVItTrkl7uuvKAm6
Wu+Csh2TkC4G5Z9NqcIeQM9HbQbfIRlzikCAza4O7wC1n7F8FGYLQleKlDjRSMwC
cDx+ivljfLIFAJXgM3dyQG5/N7d066leCq319RgjRkYO7Vd7GhEUuO0Fzhajws/p
JjUv0hVCodrBX8cZxPXvNspX6ucDGBB1KVWxoD4qdCaQ9l4FJhlyrSdXPs29yo2u
6LKbTtD0YHt9s+bsxVM9vjjzZ9kqbcMRrqBzgg+qf23uOSAoDeZ56l0ny38JR+sD
dAwuaf7y+c/0fR/Xiw8XIvtAlODIJxDD15xETwUCtw+w0COq6Mo=
=UMdp
-----END PGP SIGNATURE-----

--f3pjldnlt7gzzsxn--
