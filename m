Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748199;
	b=SzQb6P6GNJDCbEomYF3iCgdMQQYaQEubxCUv/u5Do4+nlJxJoohTRPaavUo6wXxBu9bm
	 Bpfw1hBHouFhHxiAZ6ki/r0AUqu9MHgkoltMJnT0REFC25r+zICzWO8/FUUxgKXHuN3t9
	 haNeTM8wEIZoZ5LBARnKK4KXO1+yTGW4Kqwiot+lmC+SdQhDUcW/ndIPtXfxCRLWYcv2/
	 EJ7DmLKCf2tZavpQdOX7QrZEVqlQnMKoBNPESSDwFb0X4XQtSpyrQrGPYHGYu0z8evMkB
	 N2nrnVn2Dv8Jijv6j4/PDr6q61bRD0CujEReJ8MNfUUb+3+32mun8vbtCn1dZMR2OtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748199;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U3e4WMfbvQYovUA5zAlkpvDtB90rZb5xthdO1DMW/Pw=;
	b=5pbhoGp1owKwbeeupih0l+Pb6lVljiRedoeuJj7AKmryrj3OAguHmdb25CCmtv6ollx8
	 AEc7qNjpnjmewF5WuKGjM9TKN1S9b/7qjn70RDEVGjvzz24kB5uRaMfN1fpd9TWcqoD+y
	 0uU061QZ7wuOibDbJi3iI4oYOWDGxMJcPNVY6PKaIpQtj3hBYHFbiipzejtnlmZr+X/oO
	 bsv17Vmepq1LPcOpkcuWZ3GR7r5UaXgANYPd5BW8NNzZK6FRx4AFkyc+BTI57lxwjUhjO
	 5jfTzyIGBfKPeOVM/04EOMF5UrjGTUZ3c3yyzvVF6zn72SP/NPqwDreS3CY+eT0fPBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYEZBGwp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33064606A31A;
	Fri, 23 Oct 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYEZBGwp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6068E1F01828;
	Fri, 23 Oct 2026 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748198;
	bh=U3e4WMfbvQYovUA5zAlkpvDtB90rZb5xthdO1DMW/Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AYEZBGwphiwRoylJjOMlAdNPZNavBpK/THkwpND5MsHG/lOn+CbfFAmjocILT5XwN
	 6AMaKn1YYLo9IbdSaHDlKj/amxFdzc2MLhl0Zp2lCqRufZna37gIK30cLjO/beu3vR
	 iECB/gSrcZbvEojwjzYi5xvxTjLVxF6ug5ckrBgumy8nwZZUhZjBN5m2Q5IfG0AojW
	 jsmgyIO0h5nMFP9BlWEiNpWDUoNoA223aovkX4e4F5NTj960nyFYVKzoDGrkW+Uqvl
	 Tqvai5XrhE3SMVAt5FG91PaxLmLm+5lJ7tbP1a0llksLOCl8c9BCEEkYBVggNpa2tE
	 Ui40alN8Y8H/w==
Date: Fri, 23 Oct 2026 11:36:30 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atsqQqzDwHazkUpL@debian>
References: <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
 <atpyCU3fDyU95hbY@debian>
 <20261022165336.3100a5be@gandalf.local.home>
 <atp4vVMyX65qYcAt@debian>
 <20261022203713.1adce485@fedora>
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
	protocol="application/pgp-signature"; boundary="zsjp26ojlrv6u6zv"
Content-Disposition: inline
In-Reply-To: <20261022203713.1adce485@fedora>


--zsjp26ojlrv6u6zv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, 
	Shuvam Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <atsqQqzDwHazkUpL@debian>
References: <20261016145928.16eddc9a@gandalf.local.home>
 <202610221058.C5626C5172@keescook>
 <atpmAQ932J3_8IvJ@debian>
 <20261022155726.7f20c4cb@gandalf.local.home>
 <atptYsHyS6YGtzPV@debian>
 <20261022162000.18aa4162@gandalf.local.home>
 <atpyCU3fDyU95hbY@debian>
 <20261022165336.3100a5be@gandalf.local.home>
 <atp4vVMyX65qYcAt@debian>
 <20261022203713.1adce485@fedora>
MIME-Version: 1.0
In-Reply-To: <20261022203713.1adce485@fedora>

Hi Steven,

> Date: 2026-10-22 20:37:13-0400
> From: Steven Rostedt <rostedt@goodmis.org>
>
[...]
> > 	struct seq_buf {
> > 		char    *buffer;
> > 		size_t  size;
> > 		size_t  len;
> > 	};
> >=20
> > 	struct alx_seq_buf {
> > 		char  *buffer;
> > 		char  *p;
> > 		char  *end;
> > 	};
>=20
> OK, I was thinking you were adding another pointer.
>=20
> >=20
> > 	int
> > 	main(void)
> > 	{
> > 		printf("%zu\n", sizeof(struct seq_buf));
> > 		printf("%zu\n", sizeof(struct alx_seq_buf));
> > 	}
> > 	alx@debian:~/tmp$ gcc -Wall -Wextra seq_buf_size_comparison.c=20
> > 	alx@debian:~/tmp$ ./a.out=20
> > 	24
> > 	24
> >=20
> > size_t and pointers should always have the same size, so this doesn't
> > change the size.
> >=20
> > Am I missing something?
> >=20
> >=20
> > Cheers,
> > Alex
> >=20
> > > Yes the seq_buf code can be complex, but it's in one location where i=
t can
> > > be highly tested and verified. The point of seq_buf is to do the comp=
lexity
> > > so that other places in the kernel doesn't need to.
>=20
> We could look into updating it to pointers later, but right now I
> rather keep what we have. Let's focus first on the new stuff. It's not
> that hard to validate.

I agree to doing that later.  But I want to do that later.  :-)


Have a lovely day!
Alex

>=20
> -- Steve

--=20
<https://www.alejandro-colomar.es>

--zsjp26ojlrv6u6zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrbKpUACgkQ64mZXMKQ
wqmj2g//ZgaNcpMe1IwPzGwZfKQoe914qKdnedl5yDSYSolRspEbdX2b/CD3Isx1
FnP+ysXQB7yGyOi96xaCuJAhA8Wg+JR8Ueev/HTfHUyJf2L27r64lZA0JT8cm9Pn
s83GPB2dLAPi5h0HtIziznvWv9sKljSONSCY1LdHV1JefhmoaQW8RIXTLCcuyMCp
xgIw++a2OgwEOldLQotCGX6pEJGl2tvCaD4SLb6AqkXQs2+s9I/NTel918Xq0uYI
gkWlJRocxpraQ4LUaexyZgeHdVRdaI+/NJeiyJZQVVD2ExP6Lzbx/9NZ9prdtEmU
2HadryP4xqiyRCH7M44Smibu0mlThsXUQL2dZF9riQBDk99FzF6oh64il/Z2cwip
eyAbyR3JaDxcqath8iitr7VaLl+hy3ePZTqOe8gdQxkDVTp9Ut7fEzFC8JhKqU7N
DntfKdaK93RmW9I0jdnHHSjOpPYwvORJG8ObBujIpBpSohUWQCC3by1BFbOivBci
/gfW7rICOzlwMb7Cc29x+1IpoFG5DrAIZ+nq0XY/dgXKFeBs2cCdH0SU+L7CSMrG
nB4oE5gn4ArQ/hJPf9Omx0iRSKNTEKT+cyWjRGwV0ldaywxG/lfkX3OxhmvYog7r
YSqspcxkYx294SfqEqew3Le+99kC1wOBNV6rp4FZbnFqAfEjF+k=
=eCEg
-----END PGP SIGNATURE-----

--zsjp26ojlrv6u6zv--
