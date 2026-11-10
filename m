Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309058;
	b=K7kbxmFualncdNNsddAhEgRu/9BOLMXwDPWCbo41CbZq0QV2lB2NvhLZPZzeTf0njqw/
	 SpbCZ5bUrETri4AAMGaYr8p4ykEEJP7CUUwYyyiO0EB+iXWbX0At9EzwewKXW9kojtT2w
	 jd4QiGapSnWH/lLwJixwme3s1oUC7SQ5ispj8cK6SZgK6/5j1P2IIGgHQAalIyk2Aosvp
	 DGaaWnQPnZ3btV2wVQ8fM+HuT/y5q8bgRDkv6/+QaM1/mnbbyI84F6nx7Us0pE75CIhZT
	 +O8gWGt/Mi449umTSJhE0n1yiqDme5uEGx3tls/EoEo/ggy+W9XnFzbc7KMB2J2jyVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wRhstAJRC5xiQsYu+JzyOCa4Dl4h2pV6bk94Dt2C34o=;
	b=VMNZzZjTe2o5eL/6gIKgiqCjQax6EzLYghFpu6Ou/HGWphPXVH0M0/naEjldXX0/MFPx
	 FrnE3T5jj0HSAK3LehLjIyMV9b9mI80M6K6RFmJL35R0dHg4njV+Ap0pRTqsbQMMZ3tnF
	 yeDxW96WHIFc0ZQ4OwHm4Yi8elXSGBuKJBZHxwmf/sqNjGw8pmivd+suiw+weZypd45X8
	 jKuImpSmLioyYl/4K2znI9jEIeULWKGoAgtaPtlU+TtT94SB3UAG+OVYoDYitG+2my5v0
	 pVHQSigV4NqyJRuLsM64vY4576CjfKi/TynrroKErnygp8+420nplXyf2A1bdFDlr7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8ATUDKg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D7606A325;
	Tue, 10 Nov 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8ATUDKg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E141F0089F;
	Tue, 10 Nov 2026 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309057;
	bh=wRhstAJRC5xiQsYu+JzyOCa4Dl4h2pV6bk94Dt2C34o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A8ATUDKgImRjziRxEUdGfa5kpbI1iH73VaS8PDukLfx9Q0rxYXwUVQ3tKA1rdmSDj
	 3Ro+gsTb4g44q/JK8UCxo48n2Ruda48fe+syHxkAbOPfb4yL7oQPfa7S2RGap6kEsh
	 /EbCxOSEjlPq4wQZkPJsdDjzDveSdPcHgA7TG7F2NHuqUc7pVcSRkucNSMnKEUOrVi
	 PikhC+ae7M972Bfbvv+kQeaiW5LMNf3q9vfvCEHWYQrxZ8iHNkkPw4ww+7mBJdRlQC
	 fOPqQkfx2IQveAo+a+dTJYbtq4obh/DOEJ52dBFx1+7SL1JNzRbM3pxMGIaUPRkHgO
	 BCaOyou6gwoEA==
Date: Tue, 10 Nov 2026 12:10:50 +0100
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
Message-ID: <avL4LoCz2wc164zo@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
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
	protocol="application/pgp-signature"; boundary="wx2y6hldnr44vqml"
Content-Disposition: inline
In-Reply-To: <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>


--wx2y6hldnr44vqml
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
Message-ID: <avL4LoCz2wc164zo@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
 <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
MIME-Version: 1.0
In-Reply-To: <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>

Hi Bart,

> Date: 2026-11-10 10:00:42+0100
> From: Bartosz Golaszewski <brgl@kernel.org>
>
[...]
> > > > > +		names[i] =3D kstrdup(prop->name, GFP_KERNEL);
> > > >=20
> > > > Can property be statically defined somewhere? We might want to also=
 optimize
> > > > these duplications with const variant (here or elsewhere, for fwnod=
e generic
> > > > path, I believe).
> > >=20
> > > Please rephrase because I'm not quite following what you're saying.
> >=20
> > Can prop->name come from something that is declared as
> >=20
> > static const ... foo =3D {
> > 	... .name =3D "bar";
> > };
> >
>=20
> You can't know it for every instance of struct fwnode_handle, so the
> answer is: no.
>=20
> PS: is there a way of using match_string() with non-const data?

Given the definition here:

	$ grepc match_string .
	./include/linux/string.h:int match_string(const char * const *array, size_=
t n, const char *string);
	./lib/string_helpers.c:int match_string(const char * const *array, size_t =
n, const char *string)
	{
		int index;
		const char *item;

		for (index =3D 0; index < n; index++) {
			item =3D array[index];
			if (!item)
				break;
			if (!strcmp(item, string))
				return index;
		}

		return -EINVAL;
	}

You should be able to call it with a cast.  It's dangerous, but
technically it works.  I'm not encouraging it, though.  :)

	char **strings;

	...

	i =3D match_string((const char *const *) strings, n, "foo");

This is a historic problem in C, which was solved in C++.  I have
a proposal paper for the C Committee for solving it as in C++:
<https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3987.htm>

This paper will be discussed (and probably voted in) in the next meeting
of the committee (which happens next week), so there's a chance that
this will be solved for C2y, and thus the cast will no longer be
necessary.

The history of why this is not allowed in C but is in C++ is, as far as
I've been told, the following:

Back before C and C++ were standardized, C++ invented const, with rules
slightly more allowing than what they are now.  This was going to be
standardized first in C89.  But very close to the release of C89, they
realized about the danger of converting a const char** to a char**
implicitly.  They were so close to the release, that they opted for the
safest approach: disallow any non-trivial conversions.

Later, while standardizing C++98, they realized we could allow a few
more conversions safely, and so they did.

C could have taken advantage of that, and pick C++ rules in C99 or C11,
but for some reason, nobody proposed that.  I'm proposing it now.  :)

We've already discussed this proposal informally within the committee
for some a year and a half, and there seems to be consensus that we want
it.  We're only being careful about the specific language.  But I think
I finally got it, and it will go in next week.


Have a lovely day!
Alex

>=20
> Bart
>=20

--=20
<https://www.alejandro-colomar.es>

--wx2y6hldnr44vqml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmry+7MACgkQ64mZXMKQ
wqmmXg/+JeY9H4QAyqVc4xKon1zkJm4/P+50FgURTEMAfhalUbXNOhgyHq3QtwPo
RoaqS8aCxAiVqZ3Qqf/qecOpkYoqQqtg8OUV4Np+DNTd6dSuIxlm4nk2frFFLPRR
Bux4w0usdq0kR9M9f4R051z++FzMPV0wX2IhrGaHVArt6igqkoIITR6gh/i+TxBv
8ylPyg6kvREx2OnxliD/mQfrr/3rkyFNhNKJhDsFScjWPYGsyGXLn2GLs8jPhhB4
PbB+r6j/QFkqx/RfrWvLc6XqZhUsdXvAcKo1Ti5Ar7EFBWXzMi9VaDlMWNNtz7dh
CXyErp4TiTRW4w54ZgponS1C0tLN9CFfKEVMbD/J+zYzwJ8yqAoidlCYAfN5ZASY
dam6rZj2W6MjFQx/8dC1+DdWTW6ihy7q6cHUJt2YI4uowd5wquSBdC8EetoU0MlB
o6q4ye5rK94anbe9ydQd7Nkyp4sKjUlZHpzMRB0az3fL8rT0FsiXSz0jIPRQzk7v
qdcaDXnBtUuDgkblQCedfJySBDm9N9Gmh3NJdQtOGk57KQ586yeNPExs3o0SivF5
cJ3ckUERShrT9/bAGrSpjZKGR3yG6S4oNQMY4arUXntsR34sZfKeoGmA7kHSBljk
F0nB+Ypd308lrNHlK4GRc1TrMn+/FxXew2+9N8X4xdTHleGKHLw=
=qslH
-----END PGP SIGNATURE-----

--wx2y6hldnr44vqml--
