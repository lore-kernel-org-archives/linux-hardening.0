Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961560;
	b=fMFe95qovvFwUIa+TcFDrELL6dAFCrsf/5hGBqhfLnh6abog/xWdyiOWxgHmRihIs1Jg
	 vtntA34Kr8IgxtFy/Kvuwgtwy1+kFvVjRHAmKWbZhnsLdBSD/kJI1z+kMUYqcCGpQRTNQ
	 /qhRncN6Sa6DDKKqLFvmOi5rulR8lYo3GNyJSm+HrXSzm+z3KxKTCoJdgK1BJdmty2rEc
	 +U/qJCVYKwe2NfrCd9gIBC2Q/TU1lP9NnKCPhgym3oWfOIV7MOpOlEFZVVVv2TGcfYKkP
	 T+a8nAk1cMlShq4REqXP/sXpTqnCa3tV4vLJDeOfXn04Z7UZ0vD5uKQPnvrjSzOEyrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961560;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BwwvAo48JOYLLTzc9WNwZXD+5ptM0E8s9q01W8x4TE4=;
	b=GoQp/sERhO0P+oUuS/gryc568a/MGVE3z5f7Z6KpeXC1OL6Ezhxu5cDNNzb+Y/M4CBHH
	 GwK2pewpxkMAtgHXCkoLDmixHmn2+jqb4lggrsGJl7AmmeKxeimUnRNboT5ffUJPcarJP
	 Zfja33EVmCZHSYukCGdJFf8WtXroD4lFLWLL5DXz0UyLJZAQPK2yJMKdEYZxs9TrwDFNj
	 iLJdgZNNhaW3auveUqKbL54/KeO2j8groJdsdB+8mKBriyaLUQ1xvv1b/GVrwLBA6Sywv
	 wUfdxqhqK6U8ecmGoBZWMcn/6u2DrTSLnT6DHYubKIHsRhwpCa6mzJ6kDcZMR+lVSRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keOrL6Kz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AE606A329;
	Fri,  6 Nov 2026 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keOrL6Kz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264091F008A3;
	Fri,  6 Nov 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793961560;
	bh=BwwvAo48JOYLLTzc9WNwZXD+5ptM0E8s9q01W8x4TE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=keOrL6Kz2bU/G7KBVO2KMtdauhOKy4N+EzLxg0uIfrdL+CJvX5ZJ8M1A0lFJw8lI+
	 dFSjAql8AHOGCt6pzX+ee4VPgBbFdkHnm9Gwofutgmg1O02Yo3k4A8gcyOEPquCBwz
	 /vQnKbdmoV23yA/uog560Ad2ECCZVxG3PxRyk/2loooav/mPhWqUSC/G9JqlNSHWN8
	 nXFft9ClmvcWFbyZA97Pt0VZfIEyvOpiINxoY2Mfm4wDuc2AhIGqCzw56wU56xKioJ
	 B2qrh2q3JghKHnqYymA+45Qic5LkKxRlJ3dm8JiyvoMd74zPV9YED+Xpms9MMKfwVV
	 gGieffLSFsmew==
Date: Fri, 6 Nov 2026 11:39:15 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: hverkuil@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <au2uDjVhB9232IuB@devuan>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
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
	protocol="application/pgp-signature"; boundary="3p7qdtfmdp5yngpy"
Content-Disposition: inline
In-Reply-To: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>


--3p7qdtfmdp5yngpy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: hverkuil@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <au2uDjVhB9232IuB@devuan>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>

Hi Mariia,

> Date: 2026-11-05 23:46:39-0800
> From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
> In preparation for removing the deprecated strlcat() API[1],
> replace the strscpy() and strlcat() calls used to construct
> V4L2 card names in the TEA5777 and TEA575x radio drivers.
>=20
> seq_buf tracks the current write position and remaining capacity
> across appends, avoiding repeated scans of the destination buffer.
> This preserves the resulting strings, including truncation behavior.
>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> ---
>  drivers/media/radio/radio-tea5777.c | 10 ++++++++--
>  drivers/media/radio/tea575x.c       | 10 ++++++++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/radio/radio-tea5777.c b/drivers/media/radio/ra=
dio-tea5777.c
> index fb9de7bbcd19..2b1c7f6ddd60 100644
> --- a/drivers/media/radio/radio-tea5777.c
> +++ b/drivers/media/radio/radio-tea5777.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
> +#include <linux/seq_buf.h>
>  #include <linux/slab.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-dev.h>
> @@ -255,10 +256,15 @@ static int vidioc_querycap(struct file *file, void =
 *priv,
>  					struct v4l2_capability *v)
>  {
>  	struct radio_tea5777 *tea =3D video_drvdata(file);
> +	struct seq_buf s;
> =20
>  	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> -	strscpy(v->card, tea->card, sizeof(v->card));
> -	strlcat(v->card, " TEA5777", sizeof(v->card));
> +
> +	seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> +	seq_buf_puts(&s, (const char *)tea->card);
> +	seq_buf_puts(&s, " TEA5777");
> +	seq_buf_terminate(&s);
> +

Why are the casts needed?


Have a lovely day!
Alex

>  	strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
>  	return 0;
>  }
> diff --git a/drivers/media/radio/tea575x.c b/drivers/media/radio/tea575x.c
> index c37315226c42..e49228eb7c46 100644
> --- a/drivers/media/radio/tea575x.c
> +++ b/drivers/media/radio/tea575x.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/seq_buf.h>
>  #include <linux/sched.h>
>  #include <asm/io.h>
>  #include <media/v4l2-device.h>
> @@ -221,10 +222,15 @@ static int vidioc_querycap(struct file *file, void =
 *priv,
>  					struct v4l2_capability *v)
>  {
>  	struct snd_tea575x *tea =3D video_drvdata(file);
> +	struct seq_buf s;
> =20
>  	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> -	strscpy(v->card, tea->card, sizeof(v->card));
> -	strlcat(v->card, tea->tea5759 ? " TEA5759" : " TEA5757", sizeof(v->card=
));
> +
> +	seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> +	seq_buf_puts(&s, (const char *)tea->card);
> +	seq_buf_puts(&s, tea->tea5759 ? " TEA5759" : " TEA5757");
> +	seq_buf_terminate(&s);
> +
>  	strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
>  	return 0;
>  }
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--3p7qdtfmdp5yngpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrtrkYACgkQ64mZXMKQ
wqlT8g//f3NZDvoQVpI2Aw9DfPje8gah3Ujc2CYMbHUmYlfiRNNnq94R9DZXgsM8
WV5/dKP+r+WEZwJ5pY45KlKY9vTky/Dk6E2w8gHDBFQG37jrPEyNb+DUVGMLz5ky
l4IjLyjNeP74YMjiCY2wY8zopBR8dmoMe2ICY06CmM3h7DKynDL7XW5nILrCWnPu
K6GVvgON9dUUco1+NuSRta0DBDKWBxtT+lBbbyxubvQx8TANo2qRR/gmFi6Ex7qn
hDfbQyP7tsfwXo4IxYwixMewwbLQ8Qw3+yVaDlL9mijdnm5ON+zXsNbv2EhHkodK
Xe0l6CmqIY01nqXL2GaR5wH7XqP/qDD8+O8xjwblySbWHNu2kaDkJWVvmNalnkLG
nJNMRHiuA2KPBupa8fk/fEZccR7pS7TgOhfD4HCECVLRoiJjqSHjBT8BAQz591HO
sX8bNIHQXv8zstQKLwY3ilDwzLHlG5qKP2G5QhKVI3hSpvXx91paf9BOybkfN+Cc
dvbxI1UmDDrUTbwXOdSEGSlPiCRFtDdrgeTTNBKRV7p/M3+6mAunHdIdK8WUG29R
m2yiB/ZPJDDv8BcyvjYyIzwUHUvylraQgp7jxEM6GZTNzrvPFH7xHp8Er0WgBlWG
oRYpgAfVQUW1PxmYSPecMtcznGOoeVq5VPzZZdka7EJj15xyFFw=
=c77U
-----END PGP SIGNATURE-----

--3p7qdtfmdp5yngpy--
