Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675566;
	b=rx/gu1Eoc5P13ls1owndYiAxI+vMmZcaGb7glihRqiC0G5fuGCEABedbBOQIAgY4HNMN
	 VUY62Gpiemu7tied9eDTrnJFpxMkz3lZX7LwQ8F+S8IpTg03bi7YPk2cd2+C+N31EyZUP
	 DQF66itGTqGelrKHDCyobRM89OSaVouYH30pn4Y5iRyK7tqzxSU9c4MT+3pLNonOLwfUm
	 v0xKQIJM6hGQX/Y4sRZ+QD3tPVtmYXDO673qtGdLiBIyd7gYPEAHjKR8PuQICnUtExy9l
	 215yAI576GSuNwh8gTKUV38QQsv7t2C/I7Qxa/zvnMn5N5bYKUujPppf2YEzrNgyoOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675566;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w3uijtsTKDIV8rvVbRYQEcqIU5c8ua+g/vs766KkkYk=;
	b=ap+p/tbTTUJD6Y/1ZzZyiY3zmrgrA03pKbxdq7bmjHMHQOlBLzzQ4ZWOckqmWyCeiu3U
	 Neic/bk04GstamPC6GMTX+InkN1rgt8HPgUoyfga3g1isUT9uawJ94A17vYA+mC5krBuG
	 fcGPa1S9Lf+yq2go82sJoS2mQoBPrE8AMslDlCUhWvF9lLIvp2Vv5oWK5IOmYi9SfzbBD
	 MvjBs0Ypb0+gxek0uxbwHKk+f2T/K3obleak+1FqixhNlaZUVmYVn4vSLexcXEc0SyaE6
	 zAANNTfafaCOcRXNdIF/ujRIHvtM37MxEzDTuEga8Un3poOBFdpv3Y5J/UUNHDJCDFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6Q+9ulL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955C606A327;
	Sat, 14 Nov 2026 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6Q+9ulL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593651F000C4;
	Sat, 14 Nov 2026 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794675566;
	bh=w3uijtsTKDIV8rvVbRYQEcqIU5c8ua+g/vs766KkkYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k6Q+9ulLsLWdf75YymqnHPCwPj3SYib9hSbW0EVistwwBjEJvpfRKl11djbYQ+SD4
	 u4roJ/p5McZqNWXhpnfDIgRRX30S7wILWe0RFoAsVSnF1IC/1SLsp9To9BT66efhjA
	 fvoj+8aq+bFM5tiJ0mCEvbiSqGS9rgbk2u/IPJY8QTLX4XXb3LKy8AARL7PT5DT8yc
	 jxmbIPQJRKSBTjkiK3kPBx9PmIkR0WSqpyu0aJ2ZAIcT6EJlDd0E9tXFwYo7/T6BDu
	 BCoLGAftSOhbme7kwmXvvHxAuWIy0XmRWlMIcn3ipc+LP9BHUQULAkk6UY4L1UWP2A
	 eSMbDGJUqOEXA==
Date: Sat, 14 Nov 2026 17:59:18 +0100
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
Message-ID: <aviOPo6bZ-WGsndf@devuan>
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
	protocol="application/pgp-signature"; boundary="esyunen5whdvkvls"
Content-Disposition: inline
In-Reply-To: <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>


--esyunen5whdvkvls
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
Message-ID: <aviOPo6bZ-WGsndf@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
MIME-Version: 1.0
In-Reply-To: <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>

Hi Joe,

> Date: 2026-11-14 07:53:25-0800
> From: Joe Perches <joe@perches.com>
>
[...]
> > +/**
> > + * strprefix - string prefix
> > + * @s: The string to be tested
> > + * @prefix: The string to see if @s starts with
> > + *
> > + * A common way to test a prefix of a string is to do:
> > + *  strncmp(s, prefix, sizeof(prefix) - 1)
> > + *
> > + * But this can lead to bugs due to typos, or if prefix is a pointer
> > + * and not a constant.  Instead use strprefix().
> > + *
> > + * Returns:
> > + * *  @s + strlen(@prefix) if @s starts with @prefix
> > + * *  NULL if @s does not start with @prefix
> > + */
> > +__attribute__((nonnull(1, 2)))
>=20
> __nonnull_args(1, 2)

Thanks!

> A negative of this is that it implies the return should
> always be tested even though it can be known that the
> return is effectively bool.

I'm not sure I follow.  The attribute is about the arguments, not the
return value.  Perhaps I don't understand what you mean by "this".

>=20
> Also the block
>=20
> > + * A common way to test a prefix of a string is to do:
> > + *  strncmp(s, prefix, sizeof(prefix) - 1)
>=20
> IMO isn't useful

I tend to agree.  I think that is just one example of code this API
replaces, but there are many more.  I think I'd prefer a description of
the API, without comparing it to existing patterns (because there might
be too many).

> and the description doesn't say what happens
> when prefix is an empty string (which IMO should match).

It doesn't, because the general behavior naturally extends to that
extreme.  That is, it's the non-surprising result.

For any non-empty prefix, the function succeeds if all the non-null
characters from the prefix are found sequentially at the begining of the
string.  In other words, it matches if and only if strstr(s,prefix)=3D=3Ds.

For the empty prefix, it still behaves like that.  If all the non-null
characters from the prefix are found sequentially at the begining of the
string, it succeeds.  This always happens, of course, so strprefix(s,"")
always succeeds.  Similarly, strstr(s,"")=3D=3Ds.

Since there's nothing different, I don't see a strong reason to document
it at all.  And that's also the reason why I think the issue in
str_has_prefix() is not just a different design decision, but rather
a bug.  If the name of str_has_prefix() had been strprefix_len() --which
BTW, I'm tempted to rename in this patch set--, then it would be just a
design decision, as it would behave correctly for what the name implies,
and it would be an incorrect use if one tries to use it for determining
whether a strings starts with a possibly-empty prefix or not.  But the
function is called str_has_prefix(), which implies a boolean behavior,
and that boolean behavior is wrong for the case of the empty string.
That is, while any string starts with an empty string, str_has_prefix()
returns false, and that is wrong.

> And the name strprefix could be confused with a function
> that actually prefixes a string to another string.

This would be a stretch.  <string.h> functions, with the exception of
the *dup() functions, do not allocate memory.  They're a collection of
functions that only perform byte operations on strings, or in general,
on character arrays.

Prefixing a string to another string would require either knowing the
size of the buffer (and thus have a size_t parameter), or allocate new
memory.  Since this function doesn't have a size_t, the former can be
ruled out.  And allocating memory would be very weird, so we can also
discard that.

> maybe strprefixed or str_is_prefixed ?

strprefixed() might be okay-ish.  I still prefer strprefix(), because
common sense can rule those interpretations out, and also because it's
widely implemented with that name.

> And these are all candidates for converted uses to
> whatever is the function name or steq:
>=20
> $ git grep -P '[^w]strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s*\)'=
 -- '*.[ch]' | wc -l
> 946

Yup, there's a lot of code that could be converted.  For now, I find it
more pressing to transform the existing calls to strstarts(), and as
many of str_has_prefix() as reasonable, to minimize drift, but I can
also work later on converting the strncmp(3) calls.

> [^w] because of prom_strncmp

Since there's no anchor before the 's', that doesn't change anything:

$ git grep -P '[^w]strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s*\)' -=
- '*.[ch]' | wc -l
946
$ git grep -P 'strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s*\)' -- '*=
=2E[ch]' | wc -l
946

>=20

--=20
<https://www.alejandro-colomar.es>

--esyunen5whdvkvls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4k2AACgkQ64mZXMKQ
wqkdxg//SdRA9p00Jkuq67BLQajOYOyjG5U493j/pF/mKIAsPOjbR1Sy+f+5sryL
Be2REepkyc9Wv4+Mthma+gM3FcOAxeY4DS5IGrqDIGmX6mJ+hBCVz0qBSdQGV/H/
ECwMzjP7ineQfECfCNJyRAvUCybVh0Ns9OXH/V1wKmaK+ki6zGZ8Y4opGz/gAk+q
RnNelwK4LRPzwCkdK9aaiZX4iEqjuwzYoSlyVHaj86NRKoerYKYU/ClZrhFmjxT4
/KUGXEF4jyjUhxUHeHaoagt3LK25WZulAKHIptPG4N5EAGWUsX1G2JMhnrH0goaq
aIwc1z+yZHf/h0/KKX2CGNU6RPTM4W3bCWohqja1P3o9EuZ0wjgoKaettx61K2oV
RR+6BIfqDktwiCj5uNR6sGTmkg/n06Ekqcsm/hTFNoDl3OsMgjfi52QIzrSApxNq
fbIgG9LppQVrHwK5fwuqYHXrChwVX5hoYhS817eSLmDL7UCIEXwtPU3bXBFxt7L5
TBHdDg2Ny09acWZhHiAv7IVgIXLRDKe1lcqgf2539goe9ieG43VUYTwPTpfcfX5f
Gov2r394GXxaYFK2Q0lGFDjcoIjt2kOb17AShEEBEb5mzmEwJgsYLMHAYgoV2RbG
aOepMOAr/zhuh9zbDltLQ/MhN5LNfF7VXOQBD9uW5+JL/FabycI=
=LqWK
-----END PGP SIGNATURE-----

--esyunen5whdvkvls--
