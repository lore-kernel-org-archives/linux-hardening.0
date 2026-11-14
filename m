Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685770;
	b=0cfBeR2ndFs2z/+qMe+rVj9rF3SuQOoJmDReXYBA6QlAPCsY2dr18TwLNUtwk3l2UoVd
	 ZG+36Y3pVMNwZPSSoq7t3xJqFLmtrDiNon8A08ZiGPCWMjClqO2jA3Tcc/AAHLX2PAykL
	 NnpTM7OHa15XQle7YThb2Kxv3NX5Yu4HIckI1diowJLVOMawREou4dfjXBTJb68bU0pvk
	 F+nlqk6V1VkkM9CqqNRXstmzKTH449/teQQmODxjrkmB+QoEPJXxbxaozuG4VMyKb8pPL
	 4++6a5LjIgdIQ4af7xs0wQSq4m6Jercx9Q4oZTUaNuzawmMxD9+tpsfgoY2Y5hdraig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685770;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+i5vfUNEuREbfhD/vTTdKxtwJJjI4Spi6fBQPs8xNP4=;
	b=GCLM/jg4kXOixLrudSNT0I/xB/13i/6D5lYpmAvOS8iibdL2HMGnIMVCFnGCINyu0+M1
	 guLehEUMPaqR18EVKZj+lZoMZF0QYEv37QRGWFkLfvodY2QgIkKaQJlcM84KYoRhCW6+C
	 nzmXna5xPS5HoCUZVbu66gDiTD3LiwnD7ofFWVNO1/1qGzLt/hTN1kSFxgKkeLt8bwr4S
	 kbUM32anWkJ9fvujI4s90gX19LmxTVDRa0BBDAFpI3xFapfzuz8WZnma+sSmJu7V+p246
	 oXeqsZXG3/ADh9fKFI9c4QUsOAsKrkbV89h0ufx/GgwoVHCRJQ+A75A58ObiEuz5NOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otY8nTnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78F606A329;
	Sat, 14 Nov 2026 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=otY8nTnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF551F000C4;
	Sat, 14 Nov 2026 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794685770;
	bh=+i5vfUNEuREbfhD/vTTdKxtwJJjI4Spi6fBQPs8xNP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=otY8nTnLe/3TyqJ1DMc6IvhNSaTnS5QPd5VEtkyQ5ydGqleXpsM2+Uw6dnp/95UqD
	 fSe5LewETi6VWlXb3scDtzRK9ws33bzAlzkAAiu9mPeJILDCdFzkzwJk58WqGybilI
	 2llxmepWI3m8W5zfSrJk6lFBjtmmQ+HVneUVRDVhzy4BIQxEaDB2uCgyrlsIrsQk6F
	 wqzf3+2VNsAh3cRUk08CnWb8Q6Ic1beRRXTF9iGgK36AA5rXVmHYC4fnsJwfPji3Af
	 pVYUD1vkR5DpqKuEcZooGgjAvVSSkqwj/0jmsRQYcltRfuEblwZvRAqFfZM9REVL0L
	 r6zygl3Aoq58g==
Date: Sat, 14 Nov 2026 20:49:21 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, 
	Joe Perches <joe@perches.com>, Alejandro Colomar <alx@kernel.org>, 
	linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Off-by-one in arch/mips/bcm47xx/time.c (was: [PATCH v6 02/19]
 string: Add strprefix())
Message-ID: <avi54hgKgovNHfKy@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
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
	protocol="application/pgp-signature"; boundary="psztgxc2iosdbtjc"
Content-Disposition: inline
In-Reply-To: <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>


--psztgxc2iosdbtjc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, 
	Joe Perches <joe@perches.com>, Alejandro Colomar <alx@kernel.org>, 
	linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Off-by-one in arch/mips/bcm47xx/time.c (was: [PATCH v6 02/19]
 string: Add strprefix())
Message-ID: <avi54hgKgovNHfKy@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>

Hi Hauke,

> Date: 2026-11-14 07:53:25-0800
> From: Joe Perches <joe@perches.com>
>
[...]
> And these are all candidates for converted uses to
> whatever is the function name or steq:
>=20
> $ git grep -P '[^w]strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s*\)'=
 -- '*.[ch]' | wc -l
> 946

Looking at those, I've seen a bug in BCM47XX, introduced in 2224de9d152b
(2013-10-29; "MIPS: BCM47XX: Fix clock detection for BCM5354 with 200MHz
 clock").

Look at this line of code:

	$ grep strncmp arch/mips/bcm47xx/time.c
			if (len >=3D 0 && !strncmp(buf, "200", 4))

That strncmp(3) call is wrong, as it's really behaving as strcmp(3),
since the 4 is off-by-one.  I'd like to know what was the intention.
Was it meant to be !strncmp(buf, "200", 3)?  Or was it meant to be just
!strcmp(buf, "200")?


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--psztgxc2iosdbtjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4uzkACgkQ64mZXMKQ
wqnPmxAAqT7UmP76O2Mq/J5Sa/uqqP5eSBhdUMsMoPaJ9FCc8DOJZJlQptoSNFP8
WvoQpWn2WYGTI24yXj3+Ag5dUrCKcfBeGZqZBPpYsx7anZFcbWPwp40W9A3WgGme
TkpkcAZwyrnWlwzrKJ9lKEOh25m6AJXXzntLr59yQB6JwzXTQMCcfgCyaJdw/xH4
27jqSFHyq5DeFOHrhlXs289J9sfJJpluh5YiQhmmS2sk/lZJwRGEcpZ0y0FB+Lsx
4UkarFSJsYbdZEF2Bmz3+oVNQFIEiYIslmPntRvaqvtOD85vFYJW4oKmp7yDw/QD
4XZvO6a1EkYNFhN8/dGWjj5ju5/kk6TfXsbJJzlXsaXP2zH9gwAJlsHda6AAfKNs
t9Cr+97aGMrnNGDucM6v2dUhEb7wu1I5FIeIEY2H+XdFX8zZXP5TiG10ji3Lo4KW
96SkNumWGfOTvfSPuvG4uVMX6AP7Nl7/CLD6QwkLLvONwhXtsYsaokMHFD/Uiu3A
DOSyfiYNoYTwL4MXm9rgQDKJr3pZqCHhl9JqnOVlbhTs4KjEV+yrPLGq9GyC4H2M
i+T5SGijShofKVgxqnIDCMhQulRthbwhX/36331pru8maHR6bSXorDQiQwUXKPRN
DW2Fm8RrdXVd+xdU0n7wBonsthXSFJ7adi1+lv7ZyKcUasBglv8=
=jCr6
-----END PGP SIGNATURE-----

--psztgxc2iosdbtjc--
