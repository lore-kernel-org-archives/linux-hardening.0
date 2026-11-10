Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310522;
	b=HbowaCFyvZMO6frs1W7AdIar5Iu9icl8fwXOOZI7XUOv2wsMQohfls+KOzCyNv+nryxX
	 Y36NsMJjiLsyCKcTgBDrJ0Ebz1OC41BXDh0OinOdwxTO3P+5tHhPkbZ6vgSeEohvcX/IA
	 Uu82uVjfqYC2EB5SQ3xcdZhOVxVDNtMs3iVXoUBASARnBbGBVuHZCbvi1mEjTf+lZGFYS
	 Bo3j6fp2e+wVo+dLf4rhxZ69FDVxaPzkjF1+a9OFkq8pSauZg/M8yhUCJR8zm4xBZXBDV
	 mrPxJXNfwOhngFK+MgYf4Sk9Jqhf7uydxPyIPU5BgJciXogRhQxzykfbwgvDhDx6VVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310522;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BbpERa55+bAqGoKd07R6gWLaZO/6XQcmtI/WmnBnKK0=;
	b=omzX3QaZu4BJTbKWqASAKatBZlrx2UDvzFIrIGtXu7frByFC5+67Sc9JIMA59T2gKbuv
	 jPeIhDjvYQ2w1S6HoUbqaUfgK2vPdtYvSVBP2nxN0a1AcWnmt29Je31lmxzcZMrb/u4W5
	 sw+BWjriz29ptVoGt4PYeXv9R+zBCY6jpln7+hAq38f5xtUdH6T4aFFGnXIhQMJV6uOS+
	 Sx1mXRHytj0Oa+65CcUe8+4PwMCgo7th8ZNxuI+BlKpfqoUNiKX1Udz4UfcXpBem6bW0u
	 MZq2aqfraVCkV3mcxC3wJUymIrraE1wZi7gSxaqq07G3aWP9jIgv+Gu9n7PGKPMcFYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HQJT/BMO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59566606A325;
	Tue, 10 Nov 2026 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQJT/BMO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8388E1F0089F;
	Tue, 10 Nov 2026 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310522;
	bh=BbpERa55+bAqGoKd07R6gWLaZO/6XQcmtI/WmnBnKK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HQJT/BMOysNk2pBuRiNkoHZMo5RU/FWxxT7T64FMMsKnYjIpK9fnEphlbftVYkezl
	 U6W1DegmBEpaTiFZVdAQSNMC92VHMUWvj+PPtWUBHq8VbkTNETA6ugEMhpSIIudyhC
	 qV2aA7Bw07ex9Cc50hyTOLKk7O+OgKwR7KFjPPdp6cqXqa3Pv6rCMCTpdn4SUS6ehh
	 yYHCTnVtKETDRWPYDryI7fvVqAM2Ry6qDc+mguJbP1tiR/SaA2kCvdLMaIEDBPFNTQ
	 7mFkpp+as+jal0yDw7xqEkbG2R5PxJUYNy2W8UiZ/eyyyj8TBhLbGQ4kYyqgt1nft5
	 2H7bulKQqSbEw==
Date: Tue, 10 Nov 2026 12:35:15 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <avMBNUEL9_V7WnK-@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <avL4LoCz2wc164zo@devuan>
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
	protocol="application/pgp-signature"; boundary="4kcwff6zv5lgihta"
Content-Disposition: inline
In-Reply-To: <avL4LoCz2wc164zo@devuan>


--4kcwff6zv5lgihta
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <avMBNUEL9_V7WnK-@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
 <avL4LoCz2wc164zo@devuan>
MIME-Version: 1.0
In-Reply-To: <avL4LoCz2wc164zo@devuan>

> Date: 2026-11-10 12:10:57+0100
> From: Alejandro Colomar <alx+linux-hardening@kernel.org>
>
> Hi Bart,
>=20
> > Date: 2026-11-10 10:00:42+0100
> > From: Bartosz Golaszewski <brgl@kernel.org>
> >
> [...]
> > > > > > +		names[i] =3D kstrdup(prop->name, GFP_KERNEL);
> > > > >=20
> > > > > Can property be statically defined somewhere? We might want to al=
so optimize
> > > > > these duplications with const variant (here or elsewhere, for fwn=
ode generic
> > > > > path, I believe).
> > > >=20
> > > > Please rephrase because I'm not quite following what you're saying.
> > >=20
> > > Can prop->name come from something that is declared as
> > >=20
> > > static const ... foo =3D {
> > > 	... .name =3D "bar";
> > > };
> > >
> >=20
> > You can't know it for every instance of struct fwnode_handle, so the
> > answer is: no.
> >=20
> > PS: is there a way of using match_string() with non-const data?
>=20
> Given the definition here:
>=20
> 	$ grepc match_string .
> 	./include/linux/string.h:int match_string(const char * const *array, siz=
e_t n, const char *string);
> 	./lib/string_helpers.c:int match_string(const char * const *array, size_=
t n, const char *string)
> 	{
> 		int index;
> 		const char *item;
>=20
> 		for (index =3D 0; index < n; index++) {
> 			item =3D array[index];
> 			if (!item)
> 				break;
> 			if (!strcmp(item, string))
> 				return index;
> 		}
>=20
> 		return -EINVAL;
> 	}
>=20
> You should be able to call it with a cast.  It's dangerous, but
> technically it works.  I'm not encouraging it, though.  :)
>=20
> 	char **strings;
>=20
> 	...
>=20
> 	i =3D match_string((const char *const *) strings, n, "foo");
>=20
> This is a historic problem in C, which was solved in C++.

BTW, self-correction:  it is solved for char *const *, but char** is not
convertible to const char *const *, neither in C++ nor in future C.


Cheers,
Alex

>  I have
> a proposal paper for the C Committee for solving it as in C++:
> <https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3987.htm>
>=20
> This paper will be discussed (and probably voted in) in the next meeting
> of the committee (which happens next week), so there's a chance that
> this will be solved for C2y, and thus the cast will no longer be
> necessary.
>=20
> The history of why this is not allowed in C but is in C++ is, as far as
> I've been told, the following:
>=20
> Back before C and C++ were standardized, C++ invented const, with rules
> slightly more allowing than what they are now.  This was going to be
> standardized first in C89.  But very close to the release of C89, they
> realized about the danger of converting a const char** to a char**
> implicitly.  They were so close to the release, that they opted for the
> safest approach: disallow any non-trivial conversions.
>=20
> Later, while standardizing C++98, they realized we could allow a few
> more conversions safely, and so they did.
>=20
> C could have taken advantage of that, and pick C++ rules in C99 or C11,
> but for some reason, nobody proposed that.  I'm proposing it now.  :)
>=20
> We've already discussed this proposal informally within the committee
> for some a year and a half, and there seems to be consensus that we want
> it.  We're only being careful about the specific language.  But I think
> I finally got it, and it will go in next week.
>=20
>=20
> Have a lovely day!
> Alex
>=20
> >=20
> > Bart
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--4kcwff6zv5lgihta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrzAXMACgkQ64mZXMKQ
wqn4jA/+Nrjt3oAo7ab82L0PwByaKld2tiUanIh5j9GnTXUIvFhJ1Fzha4b1DL1/
F31kpq3MdXc3dB+R5Q+MkyYGvGOysxAmn9LzyJ0yJ+L8AkIHKBgogLdkcINvw2+1
AOVVJLFEffs07j2zedSkQYDwQWMi8p60Mfo+qL6ZE3TxoTGv8I8vYeYMEgY1lTai
c46jn3KHvn8xZdV9rU5097tSPg6jhikn68+IK2mL51Im93fceRJ41jpkKA17Qrwx
bJm0psSpancqH6pLWveNR+3iuyJ966tU7nP5sDlOIBB0/vbsYUuuYwg4q1YCakOZ
duPcdG9L3JYLfqdg+v2pHcrCSWsw2ae+tUivZVd/g+pYf0jzd6m8Yujp+HzhIC7S
uazeu8telgKmOlvy3ETLSb2tdMy4/6Gze7qVTO4PVSAoGPLyPLk+XwRb0nvzxIeF
sBShqOUMxlnVbAOIxWPp5h+ks8Deakq6W4qdDhdlW8dzvUyHovoSZDThED9mrKw2
tn1b4AZ93P39gIAR+oFBKx/wMQW/i0hCMyAhd6zdnMTj1wmFyOdWjdNu7lkGObhM
hJ/Lg8856jNfMaGtT59Uq/1MDbxy4IAMNyfXty5JFRWeU2ZR8zdDEQ4El0kOKdmU
cBe9ucoZvZrH4TJt39ztQZhRFQbos3mNe1SIlUjE6S64GC3SIcE=
=HIIa
-----END PGP SIGNATURE-----

--4kcwff6zv5lgihta--
