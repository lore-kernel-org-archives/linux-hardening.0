Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD32136349;
	Sat,  5 Jul 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751748053; cv=none; b=IRo9gET7D8qed739Qc7vpO4qTBGRbyqUIWwMNyk1hCQMYj4ANStTBnTT69Ar8kW+n7IlepXXL5gNNn36Vp3B3jTq6CcOpp+RHOaMOOiAI6jyobYjQyjDFagIFngRO2cu9UfC1Rc15NFbXiCOEP45iaoYQNJZ1esuq7uATYpJ+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751748053; c=relaxed/simple;
	bh=Sl88YxxAaHd/YsR1z8G/2KOwRYt4vN4CacwFtopcZqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWq8PsDewFdrM7V5knw2BzAG6ImsfsU2w4Szdj3T/RRn/qfRnTxqx2X8gA4iQ3GitrT52oFmPNDEvpWJ2BUvval0Oj9G//VXXV8HefaFWutK3OtKCP9uTDWRDaIPhHuXlYNPlOYumlIXgvWEVeN3EtmOSpnv+PgS6mg3i5StM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgrxJfBR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgrxJfBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39231C4CEE7;
	Sat,  5 Jul 2025 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751748052;
	bh=Sl88YxxAaHd/YsR1z8G/2KOwRYt4vN4CacwFtopcZqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgrxJfBRzSt4wG/yzG73d0f7M37donQF4ZMFIkIT+ZRDhejetUQsHAIQ9G0NKT6Yo
	 3gWiK0arnp72MgVQLrFuImZYpiedLXUK9kKy+Oq+9O2XBeB6iZD+/4ljIZh7kbzoQb
	 SRTAXr5+ztQYXzpmxu4wuiwg2hI0Kt5iT24pf4m0BvFqPUPHPchryFecT/jEsl9zr2
	 ZgIEmX/vPmCpmL7nAoZSeS/pDksABqq1k183zx4qXMd4x6JsC2nYq5iuFily4d4bxm
	 YL5oApUICgIDFSjfQ3dVsmFSIUyZ7MQjbXfePnUtSoKdI23oceOvTjLvCH56legkjn
	 R0AgKkiqkIpKQ==
Date: Sat, 5 Jul 2025 22:40:49 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC v1 1/3] vsprintf: Add [v]seprintf(), [v]stprintf()
Message-ID: <nx6vj5qqcgkts4pmefzux3ee4kuumwyjh6vlwsdltf56ayq33e@kyf25zkic2rk>
References: <cover.1751747518.git.alx@kernel.org>
 <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pgtmvcnqaimzwfi6"
Content-Disposition: inline
In-Reply-To: <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>


--pgtmvcnqaimzwfi6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [RFC v1 1/3] vsprintf: Add [v]seprintf(), [v]stprintf()
References: <cover.1751747518.git.alx@kernel.org>
 <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <2d20eaf1752efefcc23d0e7c5c2311dd5ae252af.1751747518.git.alx@kernel.org>

On Sat, Jul 05, 2025 at 10:33:49PM +0200, Alejandro Colomar wrote:
> seprintf()
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> seprintf() is a function similar to stpcpy(3) in the sense that it
> returns a pointer that is suitable for chaining to other copy
> operations.
>=20
> It takes a pointer to the end of the buffer as a sentinel for when to
> truncate, which unlike a size, doesn't need to be updated after every
> call.  This makes it much more ergonomic, avoiding manually calculating
> the size after each copy, which is error prone.
>=20
> It also makes error handling much easier, by reporting truncation with
> a null pointer, which is accepted and transparently passed down by
> subsequent seprintf() calls.  This results in only needing to report
> errors once after a chain of seprintf() calls, unlike snprintf(3), which
> requires checking after every call.
>=20
> 	p =3D buf;
> 	e =3D buf + countof(buf);
> 	p =3D seprintf(p, e, foo);
> 	p =3D seprintf(p, e, bar);
> 	if (p =3D=3D NULL)
> 		goto trunc;
>=20
> vs
>=20
> 	len =3D 0;
> 	size =3D countof(buf);
> 	len +=3D snprintf(buf + len, size - len, foo);
> 	if (len >=3D size)
> 		goto trunc;
>=20
> 	len +=3D snprintf(buf + len, size - len, bar);
> 	if (len >=3D size)
> 		goto trunc;
>=20
> And also better than scnprintf() calls:
>=20
> 	len =3D 0;
> 	size =3D countof(buf);
> 	len +=3D scnprintf(buf + len, size - len, foo);
> 	len +=3D scnprintf(buf + len, size - len, bar);
> 	if (len >=3D size)
> 		goto trunc;

Oops, this error handling is incorrect, as scnprintf() doesn't report
truncation.  I should have compared

	p =3D buf;
	e =3D buf + countof(buf);
	p =3D seprintf(p, e, foo);
	p =3D seprintf(p, e, bar);

vs

	len =3D 0;
	size =3D countof(buf);
	len +=3D scnprintf(buf + len, size - len, foo);
	len +=3D scnprintf(buf + len, size - len, bar);

>=20
> It seems aparent that it's a more elegant approach to string catenation.
>=20
> stprintf()
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> stprintf() is a helper that is needed for implementing seprintf()
> --although it could be open-coded within vseprintf(), of course--, but
> it's also useful by itself.  It has the same interface properties as
> strscpy(): that is, it copies with truncation, and reports truncation
> with -E2BIG.  It would be useful to replace some calls to snprintf(3)
> and scnprintf() which don't need chaining, and where it's simpler to
> pass a size.
>=20
> It is better than plain snprintf(3), because it results in simpler error
> detection (it doesn't need a check >=3Dcountof(buf), but rather <0).
>=20
> Cc: Kees Cook <kees@kernel.org>
> Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  lib/vsprintf.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>=20
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 01699852f30c..a3efacadb5e5 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2892,6 +2892,37 @@ int vsnprintf(char *buf, size_t size, const char *=
fmt_str, va_list args)
>  }
>  EXPORT_SYMBOL(vsnprintf);
> =20
> +/**
> + * vstprintf - Format a string and place it in a buffer
> + * @buf: The buffer to place the result into
> + * @size: The size of the buffer, including the trailing null space
> + * @fmt: The format string to use
> + * @args: Arguments for the format string
> + *
> + * The return value is the length of the new string.
> + * If the string is truncated, the function returns -E2BIG.
> + *
> + * If you're not already dealing with a va_list consider using stprintf(=
).
> + *
> + * See the vsnprintf() documentation for format string extensions over C=
99.
> + */
> +int vstprintf(char *buf, size_t size, const char *fmt, va_list args)
> +{
> +	int len;
> +
> +	len =3D vsnprintf(buf, size, fmt, args);
> +
> +	// It seems the kernel's vsnprintf() doesn't fail?
> +	//if (unlikely(len < 0))
> +	//	return -E2BIG;
> +
> +	if (unlikely(len >=3D size))
> +		return -E2BIG;
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(vstprintf);
> +
>  /**
>   * vscnprintf - Format a string and place it in a buffer
>   * @buf: The buffer to place the result into
> @@ -2923,6 +2954,36 @@ int vscnprintf(char *buf, size_t size, const char =
*fmt, va_list args)
>  }
>  EXPORT_SYMBOL(vscnprintf);
> =20
> +/**
> + * vseprintf - Format a string and place it in a buffer
> + * @p: The buffer to place the result into
> + * @end: A pointer to one past the last character in the buffer
> + * @fmt: The format string to use
> + * @args: Arguments for the format string
> + *
> + * The return value is a pointer to the trailing '\0'.
> + * If @p is NULL, the function returns NULL.
> + * If the string is truncated, the function returns NULL.
> + *
> + * If you're not already dealing with a va_list consider using seprintf(=
).
> + *
> + * See the vsnprintf() documentation for format string extensions over C=
99.
> + */
> +char *vseprintf(char *p, const char end[0], const char *fmt, va_list arg=
s)
> +{
> +	int len;
> +
> +	if (unlikely(p =3D=3D NULL))
> +		return NULL;
> +
> +	len =3D vstprintf(p, end - p, fmt, args);
> +	if (unlikely(len < 0))
> +		return NULL;
> +
> +	return p + len;
> +}
> +EXPORT_SYMBOL(vseprintf);
> +
>  /**
>   * snprintf - Format a string and place it in a buffer
>   * @buf: The buffer to place the result into
> @@ -2950,6 +3011,30 @@ int snprintf(char *buf, size_t size, const char *f=
mt, ...)
>  }
>  EXPORT_SYMBOL(snprintf);
> =20
> +/**
> + * stprintf - Format a string and place it in a buffer
> + * @buf: The buffer to place the result into
> + * @size: The size of the buffer, including the trailing null space
> + * @fmt: The format string to use
> + * @...: Arguments for the format string
> + *
> + * The return value is the length of the new string.
> + * If the string is truncated, the function returns -E2BIG.
> + */
> +
> +int stprintf(char *buf, size_t size, const char *fmt, ...)
> +{
> +	va_list args;
> +	int len;
> +
> +	va_start(args, fmt);
> +	len =3D vstprintf(buf, size, fmt, args);
> +	va_end(args);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(stprintf);
> +
>  /**
>   * scnprintf - Format a string and place it in a buffer
>   * @buf: The buffer to place the result into
> @@ -2974,6 +3059,30 @@ int scnprintf(char *buf, size_t size, const char *=
fmt, ...)
>  }
>  EXPORT_SYMBOL(scnprintf);
> =20
> +/**
> + * seprintf - Format a string and place it in a buffer
> + * @p: The buffer to place the result into
> + * @end: A pointer to one past the last character in the buffer
> + * @fmt: The format string to use
> + * @...: Arguments for the format string
> + *
> + * The return value is a pointer to the trailing '\0'.
> + * If @buf is NULL, the function returns NULL.
> + * If the string is truncated, the function returns NULL.
> + */
> +
> +char *seprintf(char *p, const char end[0], const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	p =3D vseprintf(p, end, fmt, args);
> +	va_end(args);
> +
> +	return p;
> +}
> +EXPORT_SYMBOL(seprintf);
> +
>  /**
>   * vsprintf - Format a string and place it in a buffer
>   * @buf: The buffer to place the result into
> --=20
> 2.50.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--pgtmvcnqaimzwfi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhpjcsACgkQ64mZXMKQ
wqmVzQ/+KqUYH2RJ6XCFWIsqgzQlHWhF5QOxlPi3CwpP/HjdGT+EmXEM1eNot1aX
OMIiUD26IZTG9icnCMdPoUXUmIQ4k5GalCWxTP8iKbwE+LuREW/AEeF+qO5eiu58
LG0FsQbVZjOfFmGWRy55Wga0RnAGZH/jCn4qbroS+mlrpgXDyl+tdwtUNCMuQGiZ
y0HUPpJqG8jh0e4LDdCvGyVVLWcpqgqG/eN/SrSM7w5SDZs7yRiqrT0DkeAJ4quI
x34tG+smh4wRXUqHfcuhPyUXYUkC5M6jUPsrWoX1Gf0W8tGTzwHMs9K0Gvj0Oj/r
uXAMGoCq/Z82kCxjCCngmFs1feJUc7DYis5gzWZivz2atf0SqYnOp9Je3X3tRp83
tBALc/mAPJCCmdgP5nTFQWdu1SLjysCf66zM+DU3xnbt8KasIVfRUVk5ElUafb/5
7ss6uDTymwU0wO9rDqsV4mBYcd2jdf/ozH9bSaePj9TEmpoBNY+aMNC20nF0bin6
lbOS3z/hITZE6+pdSlxgfY66s/Dld6atXBrBD8rphQ9JwBwBN0QoKhbcRbbj8eNO
kcaJhLcMM7B58fjqJqnnsQRlITuMPfVgTv5BfFHlbmNvKC4WYaGNNWNgwAzfaKeU
7Qou5dxKwQorPHQriDuTMtkozWaW2hk02dsGE0ic7kUmBSJi3LY=
=AQZ1
-----END PGP SIGNATURE-----

--pgtmvcnqaimzwfi6--
