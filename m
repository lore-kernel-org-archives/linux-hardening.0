Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708511;
	b=IaNKYiG/2N3fOTThByP6/q/5Vt9mUaAhpTNUkkvNuLyFPbatJmuDxyKqm046w8zlyRr2
	 o0xWFePZCsIEghZAShEG+bP7/Pr/zSNeeJKW0wsoz3uPzba7zosC2NMXu0kO38D8LLaDM
	 EL4gd6qnT7dHr69Z8VkgcKjNwwdd8eZ6vWE5cihH6F/m/VD9IMe/Gk1l0D7lb1+yQsJHV
	 LUPB4kb+OHZZ0/KKZLJHRmsftuzifYaA4zF36KFoVgMicGZcMQ0UqEwfR+zTk04DaRHXr
	 P6923KI1WsgV2g80jnRzukO+cjAxx4AfowwrfdcOqCnic+x778jxTsh7M7aGgp1h4eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708511;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q3gAoHWLYDHTRnE731e1zotsd1kR8LZw3EShqPsUYcI=;
	b=XU5XdMP7DWuQS6um9QdCnSbUda68jdonEtoSzvnMyZA/DGatFzOaB/oEL1ZckdY8EtUL
	 341TG1P3Q/1BJ1PbnFqe3hgoGefN+wpiJDAkXHEyEDXiDlm/B7hvCqVkCHFaOtCoElbp7
	 ss+sAbemnH3vSuXUG50qTcTjvMMJyfMB7XJTkYFvtYFl/Wf2grN/ssM7Vd5R5RoWwnVGa
	 X4ogieMkMCjp/+k1dOyazKa7YgtIkE3vL8FUwk5aTb5BeWESyDgphAlIu8WSRifeUWyoK
	 GdPTweRe02rFAubbyBNywhGsx80XpP9OC2uYsHN10OW84VHg2LJ1fGhgb4XkHsacLJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqMc2Vjl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F86606A31C
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqMc2Vjl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8C41F000CA;
	Thu, 26 Nov 2026 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795708510;
	bh=q3gAoHWLYDHTRnE731e1zotsd1kR8LZw3EShqPsUYcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UqMc2Vjlax6fXVeqx77QsDQo4g5Bsd6POQ3jYcqE1UhfF6AZqP4i381+AegIPRqlo
	 0LPJ0b6bEXXCkTJSwNvR3jTc9sYep6rHOqh4LORpHvaXFx94KQzeC0IouAiOI3L2yL
	 YnMRb9fkspvD0zUpbaFHSmdgjxejD1Yt6g+RQ9eX7bgVxMFtAnrHpfb0Zf81wv8vaz
	 r3lhaN3FtaWMQ/c4Fg+/FaST5jneng5u9ZHfAGBoAzaq/zk+PXaeUgBmwvqsfE/GoQ
	 i4uj9kZnGTVBaMlx7qhukoE3WrlLBfr/zYoj7xlQJOKOyd4gececddUqPY65ilfN3+
	 pbi38US23gzVg==
Date: Thu, 26 Nov 2026 16:55:07 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] string: Add missing const
Message-ID: <awhWDGMVswTMHjzo@devuan>
References: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
 <awhOK6BFK6Rj0ytu@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="xs7njw4cqfmxpriw"
Content-Disposition: inline
In-Reply-To: <awhOK6BFK6Rj0ytu@ashevche-desk.local>


--xs7njw4cqfmxpriw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] string: Add missing const
Message-ID: <awhWDGMVswTMHjzo@devuan>
References: <9331ce2afba1a44bb84f371581478a9ac5ee7380.1795631164.git.alx@kernel.org>
 <awhOK6BFK6Rj0ytu@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <awhOK6BFK6Rj0ytu@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-26 17:20:11+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Wed, Nov 25, 2026 at 07:26:38PM +0100, Alejandro Colomar wrote:
> > This pointer is derived from other const pointers.
>=20
> Constification almost always is a good thing, if this builds and works as
> expected,

Yup, I built it as part of a larger branch.  I didn't run the tests,
but this should be a compile-time-only thing, so I don't think it's
necessary.

>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks!


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--xs7njw4cqfmxpriw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsIVlUACgkQ64mZXMKQ
wqnQihAAhXudXYWU8qdkfk0xxUEn6jTj/mejPIboKwpvrEW8zSPBqVPsKO44T9jl
XIXELcS2fvVyoiR5YSPoR7YF4pmI0BxLGOvPIdV6VY93uJDDo6ABAehDTu5hl3N3
9TLFOUFZpzEW5IBCwXoIo4nvnwQygNPMYtnmarfVnzocjqaufy4aI4sCj9c2SjQf
VWU8e+j75JJgk98e7vtff6qOyPGHG9nhG3GtNt7PAoh7kxBc1oH/1XJJFlbIDBoy
EcCi7BSguVe+RiIGBPjCl71obUYCVzVURKYUL4rVPg8lnLwoMrbk/zSD9QQ7vT6M
z9ZXG0sth2q0HlPehTH7iOxm+mwaya4Kxu1d+v9ueilfSujkwl7gMfIWwC6uqsva
ooLIN0vcRMaEn6sb3Guqo/g6/4YLSlU+Son/rmH0x0QW9AB5d2qqj1e9nc9PiI8N
YB5JNd6zzF6XXOqOG1K7H6iFCegMjmB+snLtN5IYt4oY35sMgdZbzHJe/OEVY57N
//fnnhvwqoCXNznlGXkjokbL2bAc/V3X7tcB4GsF9/gqczhGunhOo3YqdxQhlcYt
rubmDB/cjoUypRrfDmgF+mseun+jvZ8Wh5yebYEEbaM0W6r5AMe9yT5/kXpeb2Fy
cZYgFgpfQNstL/OR/y8zPuWemQ5m/maaq+hSbFeWz31pC06h/C0=
=KupW
-----END PGP SIGNATURE-----

--xs7njw4cqfmxpriw--
