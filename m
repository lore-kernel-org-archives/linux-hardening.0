Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584383;
	b=QXGPryYDwGzMw6mhKNlYkTf1RKQ+XozhvPFxQw4fovFNV7ECXytkdwbyO8zMcSBsDyJt
	 UM3J9D/mzIE1S896+5A3+arURCWDsCUU4rO6SuwgZzM5KscWZQp18u/WE/YxjnULq2+3t
	 s4TTePk7jRSREorNVAtSXh85TRiTQTkS3496vVrQ0eFjHv/5ZxSiiokMgUqfs7VGkC52/
	 EGBIZWiU2blndZfHYB3JCAfrEMTF/G5gGGQ2JTos6QpBRsR3fIiqLH6D4PTtFTM6AM2nR
	 Sn+AdbeuFy1bjO367NkX85nUF5z27coGfCCm+PJArJIpWxfR3k1VUvRUgISQkNtWamQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584383;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WTYbhOQb0nbXf5t2IZCat65pMPi3J4tXZO3ZqFrLRAI=;
	b=1qpvsB1XOHrNPo5ox4dPdJ9QER0LLZKSL/uVsP2KdlrOcb8QCnBfZdLWJ46XEXdAjHXE
	 b3dJoGEde6OdmVGQ01vZd6/I39SakLlac383zOh2tLhHXU2/bXtjB4/Xw9YzFoXX9oe2g
	 I54Whgj/emQMduR9PMjj3l87Kz4P8Ca3+V3N5J7P1/jFZPDOckKicTZlbG6Xq/latz7AD
	 n1c6lA381u/lgkOhaau5E9lQhebi0XZS+d8WouLDONtYhHUMuHNnr9rlTL5g0x/8ic3Dt
	 mege9LIzcgeLZmxgIEzBYoasd91CEjELEVumxl6nQNCosqqCsOFcrXHqzsodD1ZoDeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mscDjltS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8722606A323;
	Fri, 13 Nov 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mscDjltS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CA41F000C4;
	Fri, 13 Nov 2026 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584382;
	bh=WTYbhOQb0nbXf5t2IZCat65pMPi3J4tXZO3ZqFrLRAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mscDjltSDITSat8S9wUj+2TJnbQm+X07N/08IrqdSpooq7IEfs67cHVxETyHL5mZM
	 JOFZgZtHpFjZ5dyXhzoWFPPh6mtfFxYp9vmVyiRttPN5hHZVOUC8pz+MzPuV8sjYMm
	 uGmcB981N1rV9L+fZwkMetkWSxpLxmD6KRmNMY6dSLVdQNZZIVJdewD3PLmRedWF9V
	 t7HAdAmo35nhEdhFABfph/jI3mVuRZHLOkCfAQT3pNSWhguk+K7TX4hPDwYxEHHDPA
	 zR+gQrwhDs8Sd7gF1SCeoy9e8fyf9ngXwc7DeTjgvKVFo+ZQVMT3e3OuXggwLJXUF2
	 iSyqXpUpzVLsQ==
Date: Fri, 13 Nov 2026 16:39:34 +0100
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
Message-ID: <avcrlaWDlBVAHpnj@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="onvsso5rgalquyac"
Content-Disposition: inline
In-Reply-To: <avcntwOjI2i4seyB@ashevche-desk.local>


--onvsso5rgalquyac
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
Message-ID: <avcrlaWDlBVAHpnj@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <avcntwOjI2i4seyB@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-13 17:07:35+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Fri, Nov 13, 2026 at 03:59:46PM +0100, Alejandro Colomar wrote:
> > > On Fri, Nov 13, 2026 at 02:11:17PM +0100, Alejandro Colomar wrote:
>=20
> ...
>=20
> > > >  static inline bool strstarts(const char *str, const char *prefix)
> > > >  {
> > > > -	return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
> > > > +	return strprefix(str, prefix);
> > > >  }
> > >=20
> > > There is no sense to keep strstarts() at this point.
> >=20
> > I agree.  Actually, it seems my guess that strprefix() would be
> > optimized out was wrong, because the kernel builds with
> > -fno-delete-null-pointer-checks and other flags that prevent this
> > optimization.
> >=20
> > > Can it be simply redefinition?
> >=20
> > I was thinking that we could just do a simple search and replace
> > s/strstarts/strends/, prepending !! in some cases if needed.
> >=20
> > By 'redefinition', do you mean making strstarts() return a pointer
> > instead of a bool?  A problem with strstarts() is again the function
> > name: it doesn't seem to naturally fit with a function that returns a
> > pointer to the position.  It also doesn't clarify whether it searches
> > for a string, or for a list of characters (like for example strspn(3)).
>=20
> We have str_has_*() for that?

I don't fully understand.  str_has_prefix() --which is the only
str_has_*() function, BTW-- is meant to be the same as strprefix(),
except for using an offset instead of a pointer.

-  strstarts():
	It could be improved by returning a boolean-like pointer,
	instead of a bool, but:

	-  We may need to fix some callers, since some of them might
	   need an explicit conversion with !!.  It'd be risky to change
	   the implementation without first verifying that.

	   To avoid that risk, I prefer adding a new API, and
	   deprecating strstarts() for new code.  Over time, I could
	   slowly migrate users from strstarts() to strprefix().

	-  The name isn't ideal, since "starts" doesn't specify whether
	   it looks for a string that starts with a given prefix, or if
	   it looks for a string that starts with any of the given
	   characters.

	   That is, by the name, I wouldn't be able to know whether
	   strstarts implements

		bool strstarts(const char *s, const char *xxx)
		{
			return strspn(s, xxx);
		}
	   or
		bool strstarts(const char *s, const char *xxx)
		{
			return strprefix(s, xxx);
		}

-  strends():
	Same as with strstarts() but from the end.

-  str_has_prefix():
	It was an attempt at strprefix(), but with a problematic
	approach.  It's frozen because of trace code.

-  strprefix()/strsuffix():
	I'd add them to slowly replace strstarts()/strends().

>=20
> > I prefer replacing strstarts()/strends() with strprefix()/strsuffix().
> >=20
> > But if you prefer changing strstarts() to return a pointer, I'm also
> > okay-ish with it.  It's not a perfect name, but I can live with it.
> >=20
> > > However, after looking at the uses in the kernel, I prefer
> > > to see the strprefix() be not implemented at all, just optimization a=
gainst
> > > strstarts()/strends() if required can be performed.
> >=20
> > I don't understand this last sentence.
>=20
> It's basically repeats the idea of having only one pair out of two.

Ok.

> With this series will be
>=20
> str_has_previx()
> strstarts()
> strends()
> strprefix()
> // potentially strsuffix()

Yes.  I'd like to replace strstarts()/strends() with
strprefix()/strsuffix(), but prefer to do that slowly, to avoid
introducing bugs due to missing explicit conversions to bool.

Should I add notes that the strstarts()/strends() APIs are deprecated?

> To me seems too many for the similar task. I understand that trace user is
> special one, but does it use strstarts()/strends()?

I didn't find any uses:

	$ git ls-files | grep kernel/trace/ | xargs grep strstarts
	$ git ls-files | grep kernel/trace/ | xargs grep strends

> Despite on naming I think we just good to have only str_has*() and one of
> strprefix()/strsuffix(), strstarts()/strends().

In the long term, I agree.  But I think the transition should be
careful.  What do you think?


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

--onvsso5rgalquyac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3LywACgkQ64mZXMKQ
wqnZ6A//bHweRCQEI+Ep4ar2zK96tVtAoU9xoCT9dHWvPjP+CjHCxG5XJbmBGN2d
QJJE+ZfLf8/d4dCnpyQbnhnWEWyiCHUlCjmU8JIiI47kX0uAm4kXzc7717dW1Gz2
VmOGBV6uB3XSxba7NYx7nQc4MDkF5FVpFSvEUXz5ePhWsnazwNx/fM5vTa56ICWL
wWsEu2wVIvkn1HTrhIiKrnFX7OVinrYEeECsqdg/1lDkLDJGNWPP6920xp8243Eb
fiewCQqdovnMJu2MZOcceXWrZZi2OSPgzDUGRa+zkpjfhN4h4nptR+RfWdTLRd4B
7sjQQ0xgI8JlodC9d0IW4Hr4lM3v8GxQCa/cjA1XGWkvwZ7Yw3XNVMgHfgu0M2qS
Rm4B3ApgQGHuRpUzVhesWg/BhxIQG4Clp/u3ZFwtIS7+l0f68oDpTCO/4RRifUSJ
0n+f571JH44hP0a++YbcYioDI1Vs/zivRCGUPwq/dcDg6db4eMZyVXBNFxZr1ZG7
pIe7+UhTlNptfDa1HDVXEE8fmwZYQbyeyYDpz46ApXZXyd5pWqn1nmm030ddVHOK
aB1e0knvHo1ZYqJ6oCsAzTf5WT4Kh+gwjlWQigeKXdQUr3vmzHHs4T9AK8LrNUi9
C7xA5/ing4t1Ay2Y+30vsER3sWWMMPIp3v9C+yLlopgRAqOdXEc=
=Srfb
-----END PGP SIGNATURE-----

--onvsso5rgalquyac--
