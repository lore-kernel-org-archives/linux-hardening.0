Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877143;
	b=X1qg4GI5puUQwRzqH+wxeX94t5KA3UGGb+w6ec27GCxccdPTTlecjzbw4DdTE8FXOMEE
	 p2Y6XHPg0h9djvb3sjGMp/xFCH8Mqz0p4BMIf8sM8fKQdeaqApoCXLHIdaSeSHGiKofOp
	 jQDBCC8PK9wjTP6GGsKfW0GPhXhgv8Oum23EPRs0Ztn49bRjmEd1clnCuDUca+bQCV7jo
	 rToGXNScpwjeAtdBfKZIqyEDXU47YA27lEu+p23Xo7u7uQAxUa8IithWzrrSQz9W0eO52
	 JIrF0Zl0jNAILkEUooWXWdUYrvq8Z6i1FKECTddyOHCY43Y6NWIBjmC2QlRd4kdHN2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877143;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vBz1e/DTkbeVLR+CgZnq/81MF85Dt9/oRuB9tLUw1f4=;
	b=u2cOzSs4Tu1vZDvXijdwMJeIrKEd13y9bm9P2HF+MNRjgtqYoVvDwH+yjPEBzJbGhdmk
	 c3S9s8NBBqIhfGEYl4jQaVCSSudAKLOXRYcafWloUJfhXHTJyWya5uCCmDS7WfkwUDv7B
	 XUOzAob+zo0RPl6x8QlJ+d2GQEecOFQT3fWTryjxqdjutu7jsu5ZixYS1re7C+Zk+lEfV
	 uUJ6DnnGXOVj6sjuMtUvg8djxHdGjt0+JVnhrFqBV2J+wybYqhqmQaNrCYGMDMk4z8H6u
	 g2ZJrqL9S775Td8KBX6uvimlLK90OqfplaKTsiRPgPFnfARwAnIXCmJOqLnHz7YBJDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiKDow4D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A24606A31B;
	Thu,  5 Nov 2026 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiKDow4D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF801F00919;
	Thu,  5 Nov 2026 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877142;
	bh=vBz1e/DTkbeVLR+CgZnq/81MF85Dt9/oRuB9tLUw1f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oiKDow4DVHPcbHYnfnI5K9cDwTYmcgUBZIFceXzoLTmNZKP6qSPC18kUFDy9lhCZD
	 Dk8fzRSdLag5TXKw9HMmJs623EHxPfyCH/O3IgelwQ3Hl/G2U+5t+ULJoO1zpyz7OA
	 TSp7E7ZUmFlLWvw6vzNOn+r+VeEhULraYnnDSQ7YP4bhKVKV9WpDarmsjQIsUwvrZ4
	 eKxR9HqKhDSh/4RnY9kFWo7/6BOEORZxd8sDlblmKYRasnikTEg8SXSyIterYiPpmj
	 Ktthx7Pcd5ooSaFAweMBN5CbosIM4LsNMYmR8t87biKW0HiJUSyk4ffP2eWWfnUn3S
	 Tflu+n9Eoc46A==
Date: Thu, 5 Nov 2026 12:12:14 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/9] device property: fix fwnode_name_eq() for empty node
 names
Message-ID: <auxXdlSWo2zG7iFP@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="l2ze5nypzbxx3qxf"
Content-Disposition: inline
In-Reply-To: <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com>


--l2ze5nypzbxx3qxf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/9] device property: fix fwnode_name_eq() for empty node
 names
Message-ID: <auxXdlSWo2zG7iFP@devuan>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com>

Hi Bartosz,

> Date: 2026-11-04 15:03:43+0100
> From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
> str_has_prefix() returns the prefix length on match and 0 on mismatch,

This is indeed a problem.  str_has_prefix() is a bad design.

> so the mistmatch case can't be told from "empty prefix matched an empty
> string".

Indeed.

The better solution would be to fix str_has_prefix().  In other
projects, I've been using a similar function, but it returns a pointer
to after the prefix, which is more useful *and* doesn't have this bug.

	char *
	strprefix(const char *s, const char *prefix)
	{
		if (strncmp(s, prefix, strlen(prefix)) !=3D 0)
			return NULL;

		return (char *) s + strlen(prefix);
	}

> For instance: the OF root node's name as returned by
> fwnode_get_name() is "" and will return 0 for any name matched against
> it and since len is 0 too, fwnode_name_eq() will return true.
>=20
> Do what OF code already does in of_node_name_eq(): check if the length
> of the expected name matches the length of the actual node name before
> comparing it.
>=20
> Fixes: a9c8c738066b ("device property: Add fwnode_name_eq()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 51109794d7275ddaf4571584d0e77d8573ebb475..a97575ff9199004b4f401f432=
aed6c95e40d0c25 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -700,7 +700,7 @@ bool fwnode_name_eq(const struct fwnode_handle *fwnod=
e, const char *name)
> =20
>  	len =3D strchrnul(node_name, '@') - node_name;
> =20
> -	return str_has_prefix(node_name, name) =3D=3D len;
> +	return len =3D=3D strlen(name) && !strncmp(node_name, name, len);

This would be going back to the stone age, and introducing code that is
prone to bugs.  Please don't.

I'd suggest adding strprefix(), and then simplifying all this into the
following:

	diff --git a/drivers/base/property.c b/drivers/base/property.c
	index 51109794d727..7728116e2968 100644
	--- a/drivers/base/property.c
	+++ b/drivers/base/property.c
	@@ -692,15 +692,12 @@ const char *fwnode_get_name_prefix(const struct fwno=
de_handle *fwnode)
	 bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name)
	 {
		const char *node_name;
	-       ptrdiff_t len;
	=20
		node_name =3D fwnode_get_name(fwnode);
		if (!node_name)
			return false;
	=20
	-       len =3D strchrnul(node_name, '@') - node_name;
	-
	-       return str_has_prefix(node_name, name) =3D=3D len;
	+       return strprefix(node_name, name) =3D=3D strchrnul(node_name, '@');
	 }
	 EXPORT_SYMBOL_GPL(fwnode_name_eq);
	=20


I'll send a pair of patches in a moment.


Have a lovely day!
Alex

>  }
>  EXPORT_SYMBOL_GPL(fwnode_name_eq);
> =20
>=20
> --=20
> 2.47.3
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--l2ze5nypzbxx3qxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsZI0ACgkQ64mZXMKQ
wqlTQA//W1clNm9koD5im1+p/cxNw122A4ZOpbBKWZPs/sZzSx8bQ4B6Wx75n4Yr
4GH4EwpC1263aOxO2wHydCz3+pCbfUL/HvRBw51llAASoKkVhz8UUELO86MmilA2
1jETDaD5nBjmGBiCvpkeSAuirQvGncIbf8gvVcb1lrPOVYY+kHJ5dF+z2LGzPROR
oiSdMHgPVSFo1jUS3egZWje2ImCcqVW1drh/7b2Z0TtGU9ieqEXLnyoftS/zmww8
WV/miGSrWUDDPjvJRZisbp5Owp5RXlO5eCq08lNfdu0cVm7bDj6v9BLZ6gtNTN3v
kt3a5n4kBsHQSUAl99u5Ve/MeMsHieFvfo8QbZIBiRzRqt9sBuW8jo7R3EB0tX2N
JkJtYjrkObFAGo6TEAsMnrIEBJWiR/ArNHqqWMIfywNsk9QTDOz/S6sRJTwJx6+/
HCFVlv9iMTe3UXvoDyz49XZgPYZfX3C9T9iob9iZ4JUM3gzJbGmXWH3G+YQfZ6xd
GFlIRxCn9l/Bihr9VseAnKkLI6EV3ttykDwggL30UIfpWz8oviATlybgAHV1h9uh
AKxPJqFM6w09GUjgsa01ERqYRRUgNiEGa3Sl1UIhX0xgBrLnaMdt7rSFfYNP31gh
r+LjzY76L/iGmZUaBQmVGxHxbqQFJEN9jO5cU8i5L5qgt/cerdg=
=j4iX
-----END PGP SIGNATURE-----

--l2ze5nypzbxx3qxf--
