Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581994;
	b=Sq/jdx1QMam4bB/9hY8kHveDbusDRRaJ+pLXSA+IVU6F0K4TshZw00VAov5bZe4VpNco
	 70QNL/swG9x8RiQ8idwqXBl/Ffpf409u9sZJKH+7x2hDPRgy7/GvrdKBYF7lzv9r4vdbQ
	 oVVqaJDXaYJRqCIZmFUuT1wKDGFub1tmI/cxgHLzizoqBREqYKv+8Dw8QMOIphGdkUUAN
	 cy6VParj2S6Fkssi9Zxs9BRU975kmqMegYxlJcVh84nQE60Sv9dq5A3Umw4UwN1NxkVj7
	 z3ZV8/XFK04RznAJWtlUF5xK51brpCQ4ie2EA0mcnnH2nOuQkUn6NqPkuf+5O8Jdjuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NWteE/08MwHlops8bfJTUXbzdPiFJLBUkCNvLFgyFZE=;
	b=c90yjftKX+SC9Sb7ncufZBJSelHF4AhTRW8/6mH0P57pqiP9Fjp+QnwTBirxxJVfXKpm
	 ZMS5y9NpV0ULhUvmSHy+CoReIkt1l87FbVd+ALKcqWKBPWui95yeIb/aU1rTNE/JbXcpN
	 i6Fso7kdUGyeIUUgQyB9gkEqRD9ChibFLclraacCb9vlW7LIppnp1eHz4f6m30Oekrr6Z
	 jJofUTqefV86oBAMaSpFTnUSO4AFadhhmhpNTmqXOvjgiWdoOLDZ4+e5GjTcvvfLCPqyQ
	 xNme5+cfs4pOfFstLiPIoW3/kxv4WspPkvLvjgE7s5721BVWYJ3lNaDtDhEH9YbGfqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bshjOMX6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6E606A327;
	Fri, 13 Nov 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bshjOMX6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE19A1F000C4;
	Fri, 13 Nov 2026 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581994;
	bh=NWteE/08MwHlops8bfJTUXbzdPiFJLBUkCNvLFgyFZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bshjOMX6CCIKXapb5AnhJMBZva46OXuKiB0mFoVOBk43y+VzRfsIYKXBQrcKIF5Uf
	 Q6p6hsqxxxo+Go9zzw3tM8ggANymZBmf3k89jfPuHJpDBkUiW/+iFqUB4vbPzKcjwb
	 pnIDWVsbJPVB27EvhTw+cmoXfO44EY/vemqJZWy/mZwDEKTvPi7cGEqYt2twe8uU+E
	 H3tDCIdF4WpK3wZq2MRDQX5LGjAuqwiQHaw4pfCfcPCc63lug8Q/LNlzb3C8zrIeKY
	 I5uzoDxbaiP1jr2BGvtImE4D9NX82RcznEtSG5fgfTo8LBL3J1tAJQmHdoKkvlywPs
	 Wjf72Evo7pB7Q==
Date: Fri, 13 Nov 2026 15:59:46 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
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
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avcj0YbmHRyhFW-Y@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="cqatwox3rg2h647t"
Content-Disposition: inline
In-Reply-To: <avciONW-b_WXoetv@ashevche-desk.local>


--cqatwox3rg2h647t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
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
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avcj0YbmHRyhFW-Y@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <avciONW-b_WXoetv@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-13 16:44:08+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Fri, Nov 13, 2026 at 02:11:17PM +0100, Alejandro Colomar wrote:
> > The compiler should be able to optimize out the unused pointer
> > arithmetic done at the end, so performance-wise this shouldn't change
> > anything.
>=20
> If strprefix() is not inline how would it be done? Or I missed the point?

But strprefix() is inline.

> > This change de-duplicates the almost-identical implementations,
> > and better shows the relationship between the two functions.
>=20
> ...
>=20
> >  static inline bool strstarts(const char *str, const char *prefix)
> >  {
> > -	return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
> > +	return strprefix(str, prefix);
> >  }
>=20
> There is no sense to keep strstarts() at this point.

I agree.  Actually, it seems my guess that strprefix() would be
optimized out was wrong, because the kernel builds with
-fno-delete-null-pointer-checks and other flags that prevent this
optimization.

> Can it be simply redefinition?

I was thinking that we could just do a simple search and replace
s/strstarts/strends/, prepending !! in some cases if needed.

By 'redefinition', do you mean making strstarts() return a pointer
instead of a bool?  A problem with strstarts() is again the function
name: it doesn't seem to naturally fit with a function that returns a
pointer to the position.  It also doesn't clarify whether it searches
for a string, or for a list of characters (like for example strspn(3)).

I prefer replacing strstarts()/strends() with strprefix()/strsuffix().

But if you prefer changing strstarts() to return a pointer, I'm also
okay-ish with it.  It's not a perfect name, but I can live with it.

> However, after looking at the uses in the kernel, I prefer
> to see the strprefix() be not implemented at all, just optimization again=
st
> strstarts()/strends() if required can be performed.

I don't understand this last sentence.


Cheers,
Alex

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--cqatwox3rg2h647t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3JdwACgkQ64mZXMKQ
wqnYfhAAo9e0lxQm5468m70Dq8nzu2AfrgEkt+LHu2SC+9LVhgycikLV0CJeT1pH
8i2DmpOXLqVeEFRcLxR+fPcaL3uI5wVq1+VuOjW/At/kN7ovrin++/hbwr7mU1m8
222J96qDTP9lcDl6aXn/Spx8GOlc3L/AgXxwPRvLq3Cxnamnwf8sUORFYEwuvxuX
MZjL9Gg0CHvFlXDtt1XKeWhfN78n6KCl30K9GibZ6EzsTZfJjaV/FYVJnMEbKYGS
z7xAUuOkeLrEkgMOLIri94UDrqDuUHbd6M8KLo5x2fkKYK2VhKncaLWla+2zrPtR
DKeaoAcDuH+dmdyxJS0g45FsieZi7dPNlaB54Yowt8KQ/Uk7lRjbFguBs59B/Ijk
woKMoHSwGQG491RKP4sJ7BbKA+QvRDYRTz34ULIAg5d7JmDfnzDURgewr7ouVt1I
sTsjq/ofomdrAaC5lGbu086k6zePjIJfnCMhLc24MnADuNgUVqtESXQwq9hp4VEc
OoTzVgUyI6gbIJY5HdkTKJgeMoOJZi7H28XT2IGF44C3TXjqjweG9mSfYTMSuu1w
UfIy/AhkipBpYXuMOxCNTX9qFdwj91hz2BN5IRpca9WRUvZriX17FN9yK88+BQnw
o/HjgWErN2MD/K4DIxp3D58oTPDXsB+zFU8XqOpsPLMUursQUaI=
=lSvS
-----END PGP SIGNATURE-----

--cqatwox3rg2h647t--
