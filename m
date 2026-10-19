Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6373F7AAC;
	Mon, 19 Oct 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394395; cv=none; b=Ld+CIE/C52Afw9jy9v2s/Moz4kSlxtUUS67lML4nPGMw0E2NTtEgS+oziVQNlaubNMwlwPBrQaQwZOkhZvHdvZUckwHraEWHQjtEzbZNIVySkgW4e60l192F4k85aowuV44nsauXpgCD6nXQHBtxyc70FCiARPH4FalXdNkzp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394395; c=relaxed/simple;
	bh=X8VHIr51Q3eJOWpF/LhXJx0/7iNxyaqY1pU7380tdnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM6LOWnHkmyVdd4rDhXuOybRZU8CeLsgDFmZbkVLBsnZnLodkxWH/qiOY95Dh95ncTbjJqwIZELhK9M7O9AcuoxNzvTh1IfNPlgiGQ3ktqSFXGM9A4O4YaFHOWVCZxoP5K+CJnP+D5wHlDSjFBr4osvxKapXBq0pHUj03aZC1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D07YgRwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D07YgRwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8F51F000C4;
	Mon, 19 Oct 2026 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394394;
	bh=daX9sX15P/KMXP1Bmy3X8p+3DDaxkC96hlWwTodhy34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D07YgRwiGM80JtRd6S5CmAHS/DuFBK5r0lI2tQrRHijKa8alEjREeD6DQ7ukzujAy
	 PvpwKEdYDafTMlp+AL0zzvQ7Twl5cNrKe0S7TNdXWDfp5iJGyyAH+7fnO/f4JXNVUZ
	 5aunfZEKtWySRjkdVm6fuJow4xpi3/rjXOhD8gIaZ1hGAVUSEr2T9YnlNMLCYQia5D
	 jek4PqqZnVQe9bkrzKmTfFA+Na+VdZbYhlbugfrvN9eds+Q9pwIShnAHawxCc+qhs1
	 PtRcX/pv0wWubLFPUu+vJ3p3OteiiEt5JBWJtgYBvuo+iedxe60ue37ZzpUVoH99z9
	 /SiP5bKlhSANA==
Date: Mon, 19 Oct 2026 09:19:48 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Iurii Trukhin <yuri@trukhin.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: add vmalloc() and vzalloc() to alloc with
 multiplies check
Message-ID: <atXD1bP8NqDfnaoE@debian>
References: <CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ff7hxtbwsljtdcm"
Content-Disposition: inline
In-Reply-To: <CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com>


--4ff7hxtbwsljtdcm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Iurii Trukhin <yuri@trukhin.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: add vmalloc() and vzalloc() to alloc with
 multiplies check
Message-ID: <atXD1bP8NqDfnaoE@debian>
References: <CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOx7e9K707oLMN94TC=FBBZYKnwACsN-8mDVjsL+N+BBCmWTOA@mail.gmail.com>

Hi Iurii, Kees,

> Date: 2026-10-14 20:20:06-0400
> From: Iurii Trukhin <yuri@trukhin.com>
>
> vmalloc() and vzalloc() have 2-factor multiplication argument forms
> vmalloc_array() and vcalloc() in <linux/vmalloc.h> that protect against
> integer overflow during size calculation.
>=20
> Commit 070580b0b174 ("checkpatch: Suggest kmalloc_obj family for sizeof
> allocations") updated ALLOC_WITH_MULTIPLY for the (kv|k)[mz]alloc()
> family to suggest kmalloc_objs(type, count, gfp), while vmalloc_array()
> and vcalloc() retain the (count, size) signature.
>=20
> Extend ALLOC_WITH_MULTIPLY to warn when vmalloc() or vzalloc() is called
> with a 2-factor sizeof() multiplication and suggest vmalloc_array() or
> vcalloc() respectively, including --fix support. Also include the 'v'
> prefix in ALLOC_ARRAY_ARGS so swapped sizeof() first arguments to
> vmalloc_array() and vcalloc() are flagged.
>=20
> Link: https://github.com/KSPP/linux/issues/342
> Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
> ---
>  scripts/checkpatch.pl | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 8a7787d228a6..651a46f1fc40 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7355,10 +7355,11 @@ sub process {
>  		}
>=20
>=20
> -# check for (kv|k)[mz]alloc with multiplies that could be
> kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs
> +# check for (kv|k|v)[mz]alloc with multiplies that could be
> +# kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs/vmalloc_array/vc=
alloc
>  		if ($perl_version_ok &&
>  		    defined $stat &&
> -		    $stat =3D~
> /^\+\s*($Lval)\s*\=3D\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\=
s*($FuncArg)\s*\*\s*($FuncArg)\s*,/)
> {
> +		    $stat =3D~
> /^\+\s*($Lval)\s*\=3D\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\=
(\s*($FuncArg)\s*\*\s*($FuncArg)\s*(?:,|\))/)
> {
>  			my $oldfunc =3D $3;
>  			my $a1 =3D $4;
>  			my $a2 =3D $10;
> @@ -7366,6 +7367,8 @@ sub process {
>  			$newfunc =3D "kvmalloc_objs" if ($oldfunc eq "kvmalloc");
>  			$newfunc =3D "kvzalloc_objs" if ($oldfunc eq "kvzalloc");
>  			$newfunc =3D "kzalloc_objs" if ($oldfunc eq "kzalloc");
> +			$newfunc =3D "vmalloc_array" if ($oldfunc eq "vmalloc");
> +			$newfunc =3D "vcalloc" if ($oldfunc eq "vzalloc");
>  			my $r1 =3D $a1;
>  			my $r2 =3D $a2;
>  			if ($a1 =3D~ /^sizeof\s*\S/) {
> @@ -7381,9 +7384,13 @@ sub process {
>  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
>  				    $cnt =3D=3D 1 &&
>  				    $fix) {
> -					my $sized =3D trim($r2);
> -					$sized =3D~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
> -					$fixed[$fixlinenr] =3D~
> s/\b($Lval)\s*\=3D\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*(=
$FuncArg)\s*\*\s*($FuncArg)/$1
> . ' =3D ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
> +					if ($oldfunc =3D~ /^v/) {
> +						$fixed[$fixlinenr] =3D~
> s/\b($Lval)\s*\=3D\s*(?:$balanced_parens)?\s*(v[mz]alloc)\s*\(\s*($FuncAr=
g)\s*\*\s*($FuncArg)/$1
> . ' =3D ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> +					} else {
> +						my $sized =3D trim($r2);
> +						$sized =3D~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
> +						$fixed[$fixlinenr] =3D~
> s/\b($Lval)\s*\=3D\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*(=
$FuncArg)\s*\*\s*($FuncArg)/$1
> . ' =3D ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
> +					}

Could the suggested fix add a typeof() to the first parameter?  The only
reason (AFAIK) Kees avoided adding typeof() in the first parameter was
to minimize churn, but if someone is going to fix new code, it would be
better if they do it good.  The good thing about using types explicitly
is that it's safer.

That is, it should suggest
	kmalloc_objs(typeof(*p), count, gfp)
instead of
	kmalloc_objs(*p, count, gfp)


What do you think?


Have a lovely day!
Alex

>  				}
>  			}
>  		}
> @@ -7397,7 +7404,7 @@ sub process {
>  		}
>=20
>  # check for alloc argument mismatch
> -		if ($line =3D~
> /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b=
/)
> {
> +		if ($line =3D~
> /\b((?:devm_)?((?:k|kv|v)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof=
\b/)
> {
>  			WARN("ALLOC_ARRAY_ARGS",
>  			     "$1 uses number as first arg, sizeof is generally wrong\n" .
> $herecurr);
>  		}
> --=20
> 2.56.0
>=20

--=20
<https://www.alejandro-colomar.es>

--4ff7hxtbwsljtdcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrVxJQACgkQ64mZXMKQ
wqnVnBAApUtNGBp60jKC0BMuYxaCCIdn4mwOdOGLXpExE48hZvSCLdd7DNi4FQWo
6TygKtQlpR7iwUf5vaR/3Mca83rRr+ahnpW4AoHoHTd1mxb6GU69X4nvXItNGypT
A3eObnJP0Mnc1gw1JfzzPbc5B1FVwGe2Y9Ox9kgy7eEWsfIsqiYpcLJy/3L/6S2+
4a5QiAVyPamI5yFnhxJei3LhRaFxz03fm+s+kF0/h7/kuZs++0T6Ah0+ZpXEKsIn
pczhvn1Hlh1s9b5gixSFlVid7r8AvDe6PfIIzepavou67qxHoaj8uFRJNRCGVr6o
DBBAS6aovZHoVcZTEzD8h5zoe1t5UjwCDxpncydZTfsgoA4ydYDEU9gDo5Z6Ec2y
rFdqpTpLCiUujSDs21skn9Gd+C6nySDeLqEXtG6XdsUgF3jkb4bWAnsbhBIbvMy1
G40pKhKBVVCTCXjt6NVj3fg6Z4NkeptGudPZUOXvONKQAmGaPUF8kUV3jZ4GfwZh
ROH+VDZcNNdNODZI6ngHMqgsMvIuFEQmuLAp4pWlTFoDqfdGDwODk6CAXOvqGtdG
TSYUyd0kQEa6dViBBuIYTKlgdnSQ7ftnxNE+cYBScIH+GpCw7Qij9RvuaWfqnYc6
qWTOly0KobE3APerL2WmJbEOEjgm3jHyE55n0EJ2pay2J1wGkCw=
=bHVP
-----END PGP SIGNATURE-----

--4ff7hxtbwsljtdcm--
