Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633715;
	b=tmo8CI9Jexu4ZfSEySoo+yWXoAXaoRQ1QgD/fjFOf6QLQlFdPwDnRkciuooUoD7fBWij
	 OH5sLil2mXE/HO14HHmcCpdrhe2aU+GTvMwNZZM3KmDy0cKHB2IUNQCI5yCK8hcBw+ru9
	 UUjjB1o8N4um2fALCDPV9Dm6HoEVqgF8gYm9Aazqmf4xI2rrEb4j1OiBl1Caqx6qWPW09
	 CLReE86ic3KcRP00meAOv9vxToVO/fDhzop4sS2iSHo2YH5io9z5z1qAHGtaZn22eoYl5
	 g8XW5UDub3xUbmHpraW8j62vcAY4gYyjv1r2N9JaWFhk9Ktxe+nQRhtc2ochzm1yUow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633715;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=NVNJrIzcuWif81P4W//j/vpY/+OaqwbLVhPZoFVyud0=;
	b=htB3SNNVOMwbdofAszRK3iP9f+xtzxBiWy0E8SGBytPAxTTl0qtO25jEPuWwwJZQRMqa
	 WaLtCo3ffnBmZqEovQ1G1E1By/19cZbKBWFtcu8E1e9qoX82prAyZ4H+Q4NCV229u6Rvl
	 s1Igu8voRNIbCL4Z4/H0Qn4CqgSeIyjte9T0Xu3lUaQST+gf0OLLTjHjI/ZoN84I6M9Tj
	 OTdHYhqtMebbUZJqvHafs5WEkqXTJ42zv3G2Jqupb/HW6cPYh97OxA0od1z6kv3BSsavY
	 baUriSxgC5u1HPCggeAVzJ762EOJvZpq54MrUGZU4JTN33HjzpJBtHIWMqXGdWg48EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l37AVLGj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDF606A329;
	Wed, 25 Nov 2026 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l37AVLGj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28C81F000C0;
	Wed, 25 Nov 2026 19:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633715;
	bh=NVNJrIzcuWif81P4W//j/vpY/+OaqwbLVhPZoFVyud0=;
	h=Date:From:To:Cc:Subject;
	b=l37AVLGjIxfs/cNQHnFijiyoRa7MDrepZrqmZTpHIh2XMhv1D6bg5dq601mURIAXJ
	 vzFO/B/Kk66YHaGE9cDuUewT4jvJomsPdnwXDvF7lBwzlSCBXBtUM/9I5msRbtBAUd
	 vajpyGS0ZZFbVuFXgKZSAP1c5FmzYIO8auq27PCFL5lemgM4/kG0zYrjbSm4AV8GIa
	 CIQA/yTfyeFJ2WgCoHrwloz8HtcPH/NOsiUrYmd3atCH6ihp9XSPRly9Vp7cxSG43c
	 pkuQACU76cQtqJrHd99ztemBjNLl+PkPq6b8s5psWjznWLo7jQxDYEyeCVlHZHZRxE
	 e9M6m/jvTRd3w==
Date: Wed, 25 Nov 2026 20:08:31 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org
Subject: Writing through const-qualified pointer in next_arg() from
 recomp_algorithm_store()
Message-ID: <awcpkJD6K1xtx_Pe@devuan>
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
	protocol="application/pgp-signature"; boundary="dlacbuulu6wrf5l6"
Content-Disposition: inline


--dlacbuulu6wrf5l6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org
Subject: Writing through const-qualified pointer in next_arg() from
 recomp_algorithm_store()
Message-ID: <awcpkJD6K1xtx_Pe@devuan>
MIME-Version: 1.0

Hi!

I'm working on preserving the const qualifier in some <linux/string.h>
APIs.  That uncovered some places where we are currently discarding the
const qualifier.

Here's one of the cases I've found:

	$ grepc recomp_algorithm_store drivers/block/zram/zram_drv.c \
	| grep -e '^\S' -e '\<buf\>' -e '\<args\>';
	drivers/block/zram/zram_drv.c:static ssize_t recomp_algorithm_store(struct=
 device *dev,
					      const char *buf,
	{
		char *args, *param, *val;
		args =3D skip_spaces(buf);
		while (*args) {
			args =3D next_arg(args, &param, &val);
	}

The function above takes 'buf' as a 'const char *', and then derives the
'args' pointer from it, but discards const (because skip_spaces()
doesn't currently preserve const in the return type).

The non-const 'args' pointer is then passed to next_arg().

	$ git ls-files \
	| grep '\.[ch]$' \
	| xargs grepc next_arg \
	| grep -e '^\S' -e '\<args\>.* =3D ';
	include/linux/string.h:extern char *next_arg(char *args, char **param, cha=
r **val);
	lib/cmdline.c:char *next_arg(char *args, char **param, char **val)
	{
			args[equals] =3D '\0';
					args[i-1] =3D '\0';
			args[i-1] =3D '\0';
			args[i] =3D '\0';
	}

But next_arg() takes it as a non-const pointer, and actually writes to
it.  So, we're writing to a string to which we promised to not write
(in the caller).

In other cases, the fix was trivial, by adding const in one or a few
places, since we didn't write to it.  But in this case, I don't know
what's the appropriate fix.  Should we make the 'buf' parameter of
recomp_algorithm_store() non-const?  Or is there a bug somewhere?

The same thing happens in a few more functions in the same file.
Here's the full list of issues I've found in this file:

	  CC [M]  drivers/block/zram/zram_drv.o
	drivers/block/zram/zram_drv.c: In function =E2=80=98writeback_store=E2=80=
=99:
	drivers/block/zram/zram_drv.c:1274:14: error: assignment discards =E2=80=
=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
	 1274 |         args =3D skip_spaces(buf);
	      |              ^
	drivers/block/zram/zram_drv.c: In function =E2=80=98algorithm_params_store=
=E2=80=99:
	drivers/block/zram/zram_drv.c:1755:14: error: assignment discards =E2=80=
=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
	 1755 |         args =3D skip_spaces(buf);
	      |              ^
	drivers/block/zram/zram_drv.c: In function =E2=80=98recomp_algorithm_store=
=E2=80=99:
	drivers/block/zram/zram_drv.c:1875:14: error: assignment discards =E2=80=
=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
	 1875 |         args =3D skip_spaces(buf);
	      |              ^
	drivers/block/zram/zram_drv.c: In function =E2=80=98recompress_store=E2=80=
=99:
	drivers/block/zram/zram_drv.c:2571:14: error: assignment discards =E2=80=
=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
	 2571 |         args =3D skip_spaces(buf);
	      |              ^

If we change those functions to take a non-const, it requires many
changes in a few places, so I think it's better if someone more familiar
with that code does that.

Please use
	Reported-by: Alejandro Colomar <alx@kernel.org>
if you fix that.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--dlacbuulu6wrf5l6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHMikACgkQ64mZXMKQ
wqm6axAAmqle+ZU2UeOSPziNlero1q9EAnetNnFUTzHGzbSEwifaOakO6hk27RJ9
sUqE1BC4B0t29GqPdbsgM+e8VNKvoCAkXob3k5Pp57m8daA91nMZ9PHrMBkLy2gn
DQsZyNuduvi+QWY0EcA9Ddwxsvbz7KAlDE3ff1VC4nGfafNWhl7mfrnZQqdt/nWh
Gdw2zNMWr5KE0x5av3YJeq0pQlCH4xy5DeJ4ZLu3uI1AoEjTA7GcLJdZ/JSZi28C
4LskmlWek/Dmf/TEigaefQxJXdv0PhZ3KYz8UWfktcS19WMjv4Oyh8oFEOwkBTZp
4uIsjs3pS/fGnexFy/Acw+KOMwu//wycD/ioc0fD4R9QySvCXF9lDnnrhZGssLaH
wfg24pqQbjzpeLmqsRQlPAPrsc53L/ZmzZIy2asTTY3YU2sI2zA0FR9zJCrTES2i
QXOaesP1hLF1IR7jQ4/PBEbmOOjsQZLtW7N/VG6IxzDAOU3vF1TNjmGQvR7OXXTW
M56ZMEILxtb8wE1pLBEmVO00zenxCWKjHrstYQp3JtJLRBLFO1HKAvoucq8jenwv
UFavInFXk9MeDl46osHoc5I/XbT5B4andTETUOmEi/zNyuRwLvOmY8Gqxi9AZOhI
mQDaq8EM6MLnJIWK86wp0Dp+i2iAjMp+cDrYvJxSWqEFBeW5fsY=
=50GX
-----END PGP SIGNATURE-----

--dlacbuulu6wrf5l6--
