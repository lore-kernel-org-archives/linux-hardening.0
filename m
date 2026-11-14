Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682830;
	b=WdQq+QN62ZQz50e0GLA7SprPEya4ShIY8tq/LFpPSO7qSf9zgKq988c3LZgT7jYRRLHP
	 6jFWsy28Lej/JIwkWlJV/2KNsXi7ssD/zAyvDP6Iyu3KLOXUmRTaTeArlnWhuawkOndmb
	 rrsl33Vp/5dOLon/GK673vWyli9hp5TZeAvRONZd/0U7l+l35y48yxmKuo6Yhm4fhkdxe
	 JwL6NZ7WCUGSZKhEgkI1gOihdGsKxpQDItJOM7d13ORTorpGLCng691wswNi0d1dHh271
	 ikImBOzqAsQdf4AF7VYN3gbpfFJ5aWV6FfXLSi4bWxi3cXRGI8aSN6q8PyiC6mEI6FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682830;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ykOliHYisYLBLFi//mbVDidPMVZQXccME0RpNUmjbYw=;
	b=4OIdeg1NFWgjD13W9996t1foyvMhdP+Eym5eeI3mcpD0AripfaAzoBCOuMR0hW6yIbi5
	 IK0sfVCKA/ZJdE13eePO/H7rip2/YPJv0OFE0IRad3QwC/YCRHo3XJyGB8lVFNWPFarLK
	 M/2AxT6/ILbDG4j/jkFexUv0bgJ+z0MiM1i23FtCSojyGLaaftCsy4XqosfkNkl6ImAPW
	 9DEidL+vu/+iG/x0RSm5nQSDWektzPO6jp7sN2WTO9j3xauWpDFqrOJURl82b0w9d8VJJ
	 zvcshHIC2A3nv8YYI26jnZm7LVWqOMnjSu2IXx5zUlZPHuTXiPJgleS9aZz+WvwOhIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rfg0/1Pk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30936606A334;
	Sat, 14 Nov 2026 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rfg0/1Pk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001B61F000C5;
	Sat, 14 Nov 2026 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682830;
	bh=ykOliHYisYLBLFi//mbVDidPMVZQXccME0RpNUmjbYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rfg0/1Pk8suTUhXDA0y90Ui/FXQ4F06sERFWjW4pyC83dFj8izLJwUt7QzrrMFNSD
	 ql02v31bmtjF8ZR2YRHnahby7K2E6o11BVCT3FxRQB5JRjSO9UPLAsrQmkyAXmxIxF
	 3CBMYWmhQ8oNeyiaEoEaEgdsShOFnvbCBLpTckOIoErmebq8wvG4f6h5Ey11vHlWRc
	 NRJD7ylckfHUYWfHmH9DdnC5aUgBSOrwgc1H1JYVNImibEi5ELw3xbDgj+d0BYBj5v
	 cDIJNe0+wwVKhNrh8gT6BWrLRsSxMKT20yN5fX8fonNWqvshzQl/ifdqQ6nFhte+BJ
	 OIY+K2eSyrv5Q==
Date: Sat, 14 Nov 2026 20:00:22 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
Message-ID: <avitCbGKfZgrfh3e@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
 <aviOPo6bZ-WGsndf@devuan>
 <32e7bdb5b8a4a522566b00763ba13974733290dd.camel@perches.com>
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
	protocol="application/pgp-signature"; boundary="35i2uj2e65774ccj"
Content-Disposition: inline
In-Reply-To: <32e7bdb5b8a4a522566b00763ba13974733290dd.camel@perches.com>


--35i2uj2e65774ccj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 02/19] string: Add strprefix()
Message-ID: <avitCbGKfZgrfh3e@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
 <aviOPo6bZ-WGsndf@devuan>
 <32e7bdb5b8a4a522566b00763ba13974733290dd.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <32e7bdb5b8a4a522566b00763ba13974733290dd.camel@perches.com>

Hi Joe,

> Date: 2026-11-14 10:24:26-0800
> From: Joe Perches <joe@perches.com>
>
> On Sat, 2026-11-14 at 17:59 +0100, Alejandro Colomar wrote:
> > > A negative of this is that it implies the return should
> > > always be tested even though it can be known that the
> > > return is effectively bool.
> >=20
> > I'm not sure I follow.  The attribute is about the arguments, not the
> > return value.  Perhaps I don't understand what you mean by "this".
>=20
> 'this' is the return of the strprefix function itself.
>=20
> It returns either a const char * or a char * or NULL.
>=20
> Because it can return NULL, then the return value
> could/should be tested.

Yes, it must be tested, when not used as a boolean.
The usual replacement of
	s +=3D str_has_prefix(s, prefix);
would be
	s =3D strprefix(s, prefix) ?: s;

The boolean use remains trivial:

	-       return strstarts(name, ".init") ||
	-               strstarts(name, ".ARM.extab.init") ||
	-               strstarts(name, ".ARM.exidx.init");
	+       return strprefix(name, ".init") ||
	+               strprefix(name, ".ARM.extab.init") ||
	+               strprefix(name, ".ARM.exidx.init");
and
	-       if (!str_has_prefix(p, "console=3D") && !strstr(p, " console=3D"))=
 {
	+       if (!strprefix(p, "console=3D") && !strstr(p, " console=3D")) {

The non-boolean use would look like this (actual diffs from the patch
set):

	-       prefix_len =3D str_has_prefix(name, PDSC_FW_COMPONENT_PREFIX);
	-       if (prefix_len)
	-               name +=3D prefix_len;
	+       name =3D strprefix(name, PDSC_FW_COMPONENT_PREFIX) ?: name;

(the old code, actually, didn't need that test, and could have been
 simply 'name +=3D str_has_prefix(name, PDSC_FW_COMPONENT_PREFIX);')

and
	-       len =3D str_has_prefix(*str, "brl,");
	-       if (len) {
	+       p =3D strprefix(*str, "brl,");
	+       if (p) {
			*brl_options =3D "";
	-               *str +=3D len;
	+               *str =3D p;
			return 0;
		}

and
		cmp =3D strstrip(option);
	=20
	-       len =3D str_has_prefix(cmp, "no");
	-       if (len)
	+       p =3D strprefix(cmp, "no");
	+       if (p) {
			neg =3D 1;
	-
	-       cmp +=3D len;
	+               cmp =3D p;
	+       }


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--35i2uj2e65774ccj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4r8UACgkQ64mZXMKQ
wqlfkg//V7LVhwRC67R3K+HVDesilnNmhBhL9ma7hlpnjFIiV+UwBz+EYDH02pVT
POFfgIzuRWM09i/+cn/scMVxlUr0slXUWWzJ4BTX2cpaMFVay+zefnbfRJ83+fcL
0koUgrp24/dDHTF5u1XgaqrXpRmehSHWRCOPkVknoLKtpTh72YeAIFlJPRvgBtYi
+mt+rEsnbPZRarv1i/T/Gf+ymSLkNWFPEDVJ2/thk6aEFUewMMQFLOntut8+eBcl
ENUHgp3KsnlSvYafsGKCVczTpxFhjWQJidlRGjTPWjdPeWVEbO1BsQvjLJmo+9Tn
s2FbjVOo/gLX5RgE07ojZA3ZS4oQ2mXjHSW0GxSKdLLoyB0K4++ib3MqbekqcUA2
+ZZK84OudamjbhYAnJFhgeAJ9OIuoKP8bA0yG3977nGMQkaLv3+FEQKrXLVeI/K6
ehRXT3Gs6s2RSbX7BFZWZpwQ/Fo8duTc4+fum4f0rQqjr59WU57RZlY4xtVg2elE
8YobEAPhZDlh1Xkj4aL69SR20dx14MUPfMN5XTZki43dUZqup8LGTuPYO6wvnUdd
X2271H5JQ4NmXvQfjfVWHFaWWG1fqJewD9fKXRjUSanHhUeTR/NLXPJiDN5SY7rK
upWO1K7/qWdEWjkv3G7M/vKPBAI1VsDKUEj13IJzb9HUYJGtZxU=
=rAzI
-----END PGP SIGNATURE-----

--35i2uj2e65774ccj--
