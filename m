Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603444;
	b=Jd9/XGcwO2iC4hlUU1BpR2zE/PqzGmS4g7UZgNtEvjo4XrS9udjopP5aFJah6Fe+ikPU
	 VG9m75Y1Abc/Db0iBxGIIdNqrFEpsbgnc6K1Znvxo4u02VkuouFwR2+c6+IGlaVQ1JhoW
	 JtNCbAdHTisvtq/DbsGY4587skF8k5nmXzzV7IQG0xC5mpEZo3T+YHdbKSDIRbqmjwMUv
	 6yzhqHNeTe5ar/xk297GhlU6OuJh4JY3RQxOoFjxk0aKX+N6lFzDqt4My/WLsO3wF7sts
	 niPbZdXtYkcr0Z0RdgX7aDOQTPDV00AVemZ9YWzCGWIvMmdjMPCv1gqsU0XexogF6SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603444;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BcEnhktCdND90RNu0qNfZdtATRB2rCMt5Xus7i9XGqk=;
	b=5Qa/v6T7ZnO1Cc1FphdkVbzqJ9Kac98ReV87IZohMNJNsWPfW3lWUVnISLPTRxAY0M/K
	 RZ8NHBiSW5hX2DoKifO29PEGSGEgLe97VoSJkSclR+u/TCVKzlsiR4SEZ1Pm1ewF3rexv
	 2Tbw3EvCPmIHg48VEIYHAnKYkHb/1hiwFwvXWVHE1DRN/i6NwK3uUcG1I0bIFfWaBjjdt
	 BKmUT38EF3rH+6Ytli5OlJUGBc9qvgZUy50YHNprx+K+7i4zw25UHaABknN7A5+3An7+z
	 9OT4xXkEsMbKlc+SWCLhtk7ruJXvx3ri1kfjV3QcRpbcWorZaTXSplRuUY2o+jRwcew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfD7jmHu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A96606A32D;
	Fri, 13 Nov 2026 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kfD7jmHu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3201F000C5;
	Fri, 13 Nov 2026 20:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603444;
	bh=BcEnhktCdND90RNu0qNfZdtATRB2rCMt5Xus7i9XGqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kfD7jmHuyGTUZJH48tL2WW7iDLcbobj01KHq7Im7rXdLDTlodGMOMakZllPB2Yr3e
	 0l0pWHkWl1M6JN6nsWW/7sdR/4K65SNz9XjZGOTk9yPpEBhypEt24Qr7f0x4wX5K/D
	 3GRiPlPe846YMxG4HqmHDPX2pb2Lhc6RNvyHkp5UUBdnfEnmvXaZbe+GbQRpGElsfU
	 jhVQn6m+syAnTbpJ0YP8pbj/UVTWWMcQesqOpmvOqlqNI2GsxfNyzuSHXVPs4hHChD
	 WUxe3YRlzZianxGOeHWAKi6VfyOjGEAO3wCZ2iI1Opk2a73fTVsFMQg2XZ29zLmcfR
	 /jg6hsIWXTZFA==
Date: Fri, 13 Nov 2026 21:57:15 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
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
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avd4XpBivw86pBYh@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
 <avcrlaWDlBVAHpnj@devuan>
 <avc1LK0_Deeh0zZo@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="icarvji2c4hygarz"
Content-Disposition: inline
In-Reply-To: <avc1LK0_Deeh0zZo@ashevche-desk.local>


--icarvji2c4hygarz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
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
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avd4XpBivw86pBYh@devuan>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
 <avciONW-b_WXoetv@ashevche-desk.local>
 <avcj0YbmHRyhFW-Y@devuan>
 <avcntwOjI2i4seyB@ashevche-desk.local>
 <avcrlaWDlBVAHpnj@devuan>
 <avc1LK0_Deeh0zZo@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <avc1LK0_Deeh0zZo@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-13 18:05:00+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Fri, Nov 13, 2026 at 04:39:34PM +0100, Alejandro Colomar wrote:
> > > On Fri, Nov 13, 2026 at 03:59:46PM +0100, Alejandro Colomar wrote:
> > > > > On Fri, Nov 13, 2026 at 02:11:17PM +0100, Alejandro Colomar wrote:
>=20
> ...
>=20
> > > > > >  static inline bool strstarts(const char *str, const char *pref=
ix)
> > > > > >  {
> > > > > > -	return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
> > > > > > +	return strprefix(str, prefix);
> > > > > >  }
> > > > >=20
> > > > > There is no sense to keep strstarts() at this point.
> > > >=20
> > > > I agree.  Actually, it seems my guess that strprefix() would be
> > > > optimized out was wrong, because the kernel builds with
> > > > -fno-delete-null-pointer-checks and other flags that prevent this
> > > > optimization.
> > > >=20
> > > > > Can it be simply redefinition?
> > > >=20
> > > > I was thinking that we could just do a simple search and replace
> > > > s/strstarts/strends/, prepending !! in some cases if needed.
> > > >=20
> > > > By 'redefinition', do you mean making strstarts() return a pointer
> > > > instead of a bool?  A problem with strstarts() is again the function
> > > > name: it doesn't seem to naturally fit with a function that returns=
 a
> > > > pointer to the position.  It also doesn't clarify whether it search=
es
> > > > for a string, or for a list of characters (like for example strspn(=
3)).
> > >=20
> > > We have str_has_*() for that?
> >=20
> > I don't fully understand.  str_has_prefix() --which is the only
> > str_has_*() function, BTW-- is meant to be the same as strprefix(),
> > except for using an offset instead of a pointer.
>=20
> You argued that strstarts() versus strprefix() is a naming problem,
> I answered that str_has_*() is for that kind of ops to solve naming issue.
> So, semantically str_has_*() should be like a boolean checker (or behave =
close
> to it, which it does).
>=20
> > -  strstarts():
> > 	It could be improved by returning a boolean-like pointer,
> > 	instead of a bool, but:
> >=20
> > 	-  We may need to fix some callers, since some of them might
> > 	   need an explicit conversion with !!.  It'd be risky to change
> > 	   the implementation without first verifying that.
>=20
> How many cases do we have that needs special attention? Can you run spatc=
h to
> grep those?

I *think* the only ones I expect this would be necessary are functions
that return a boolean-like int.

	// returns 1:true 0:false -1:error=3D
	int
	foo(...)
	{
		...
		return !!strprefix(...);
	}

>=20
> > 	   To avoid that risk, I prefer adding a new API, and
> > 	   deprecating strstarts() for new code.  Over time, I could
> > 	   slowly migrate users from strstarts() to strprefix().
>=20
> I believe this is unneeded step which may last for a few releases without=
 even
> guarantee that it will be finished. In such a case I would like to see a =
branch
> with full conversion done before you start sending per-subsystem pieces o=
ut.

Okay; I can do that.

> > 	-  The name isn't ideal, since "starts" doesn't specify whether
> > 	   it looks for a string that starts with a given prefix, or if
> > 	   it looks for a string that starts with any of the given
> > 	   characters.
> >=20
> > 	   That is, by the name, I wouldn't be able to know whether
> > 	   strstarts implements
> >=20
> > 		bool strstarts(const char *s, const char *xxx)
> > 		{
> > 			return strspn(s, xxx);
> > 		}
> > 	   or
> > 		bool strstarts(const char *s, const char *xxx)
> > 		{
> > 			return strprefix(s, xxx);
> > 		}
>=20
> I didn't get this. We should not really need an implementation details of
> the API beneath. Documentation what should be read before use. Do we have
> documentation for strstarts()? Is it clear? Maybe that what should be add=
ressed
> first?
>=20
> > -  strends():
> > 	Same as with strstarts() but from the end.
> >=20
> > -  str_has_prefix():
> > 	It was an attempt at strprefix(), but with a problematic
> > 	approach.  It's frozen because of trace code.
> >=20
> > -  strprefix()/strsuffix():
> > 	I'd add them to slowly replace strstarts()/strends().
>=20
> See above about "slowly"...
>=20
> > > > I prefer replacing strstarts()/strends() with strprefix()/strsuffix=
().
> > > >=20
> > > > But if you prefer changing strstarts() to return a pointer, I'm also
> > > > okay-ish with it.  It's not a perfect name, but I can live with it.
> > > >=20
> > > > > However, after looking at the uses in the kernel, I prefer
> > > > > to see the strprefix() be not implemented at all, just optimizati=
on against
> > > > > strstarts()/strends() if required can be performed.
> > > >=20
> > > > I don't understand this last sentence.
> > >=20
> > > It's basically repeats the idea of having only one pair out of two.
> >=20
> > Ok.
> >=20
> > > With this series will be
> > >=20
> > > str_has_previx()
> > > strstarts()
> > > strends()
> > > strprefix()
> > > // potentially strsuffix()
> >=20
> > Yes.  I'd like to replace strstarts()/strends() with
> > strprefix()/strsuffix(), but prefer to do that slowly, to avoid
> > introducing bugs due to missing explicit conversions to bool.
> >=20
> > Should I add notes that the strstarts()/strends() APIs are deprecated?
>=20
> Isn't Steven against that? I already forgot his points.

As far as I understood, he was against deprecating str_has_prefix(), but
we didn't yet talk about strstarts().

> Keeping them
> just as aliases to strprefix()/strsuffix() perhaps the good start
> (see below).

Ok.

> > > To me seems too many for the similar task. I understand that trace us=
er is
> > > special one, but does it use strstarts()/strends()?
> >=20
> > I didn't find any uses:
> >=20
> > 	$ git ls-files | grep kernel/trace/ | xargs grep strstarts
> > 	$ git ls-files | grep kernel/trace/ | xargs grep strends
> >=20
> > > Despite on naming I think we just good to have only str_has*() and on=
e of
> > > strprefix()/strsuffix(), strstarts()/strends().
> >=20
> > In the long term, I agree.  But I think the transition should be
> > careful.  What do you think?
>=20
> Yes, it should take a few phases, first one perhaps to align strstarts() =
to not
> rely on the returned value to be boolean.

Ok.

> In parallel with that, your current series can also be considered. Then
> similar, if even required, to be done against strends().

Agree.

> And one more phase
> is to replace strstarts()/strends() with strprefix()/strsuffix() all over
> the kernel.

Ok.

Thanks!


Have a lovely night!
Alex

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--icarvji2c4hygarz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr3eaQACgkQ64mZXMKQ
wqkNPw//XQhwJ8jwtB/Qtz8hKNEDKjhsYowvYKeAPNQr7hWf2yvnOHltNydwoLZr
C66ScYc9yp2a7i7Uuk33HLJfAMhtdmJXrKTbP+ThLVPvUiUKZ6I43lGelYP2/qDZ
OEDULxq1hfmKwSgq7Kto3+n6TA0umuzVexreCqbxCggcugebIaTcCKzOllQjJQfc
INF34WQucI6mF91DbjFFzzGXX6bCMqZuZXotaypNXRmQNeTBsqASaDIUW0H+WLEC
ZxRIr5geo3jY6GjFyBL7henaYh66gQjEaUOZvrmySFq1uTUJuHAC5xjhX74ryzDS
6gnMFk7xGWRVYVrF4N9uAEXZESveUiYtT6pwR9kQLVhCKA9e4NYHLVf7pm8eFIag
T+qFgiTdWC5lTh+cHoAT7WEHy4Z0oYr8V1Sp5ndyInxuOFI20vUORl2uoMvnt759
M4dQmecWqIqF+qFUtYS4IjFeyq75/1Tl6ablDJMFJwkRN4QyQ4B/3iZcNoJPQOSl
V2XyVmbz1HvPqvzkrvt5xy3x6ix64JzkvziAltaUHL4Q+LWOrx18PmUPyoYGhQID
aY/W6GI4vTkmfR2cj/f1DurNQHDQSG+px5OssTAY6n8m7rN7Rjuk5JK25OpitnXY
RLyrwYzJPd2RPUNzH5tg1wogxbVWmEHTo3E8++Hchci6Okbyd64=
=t16e
-----END PGP SIGNATURE-----

--icarvji2c4hygarz--
