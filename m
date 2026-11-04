Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791522;
	b=Hz58wOFP4hnZ6mXPcn3hyDxoqQINhP5AdNjyNMJJvnodkWX6hTrsP7ru0T0DG6RnocSn
	 7qYWmQVnPj88XGEZRThr6nk6M7D2k6Q3uztCfxFVzRcYoe8oCG/d6jGClB8Fbf5RL+kAr
	 KYDLfYZwjwGGCegbHDIqA6pLc+gP9tiEOJRNnv+Q7b3jshfA59MxDdZVbr6cRvTo+WPRm
	 kY3F1SbRIpJFqoSABP6vCqDgcla2mw/Ftb9Kp8Q8MfhsyDlXVfgA7JcWd4H3Vfnq67ozo
	 3gHomumnWJToMVjvPBCHlHHMDj1IYDUxSxp58MjvE9XSmM2JIRjo+S0LKhFAe7cwWTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791522;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+C2XbHpLqK8DQTw8gaAqePPNFIDKaUXWFXYTZBtyER8=;
	b=N1PEffBzYheMjWgJDHt213xQgaTK2kCZla1pUxWxEdCE0mrWbsfwQ24xWwBBqalthHBi
	 VdfUpt7zRwG7kG4I5rKQduL2moVsTSGifbIV4NC8M4RyDwjdekQWHcV9FXNoR3weA/laW
	 /QHYEB2FaQr6yLF+QDneAVDB1LWE7G0Ql5VjQ6ISmYe0bIPxfxhEyoJqDi70dp6moBw2H
	 VZrEs40AG3ackvKhKsAivOutI8POC8aIh83ikEvYOqF3hBXJ0qdEfp0FICDgeRWbL7+Zv
	 UxfihLiJw+lRWlbQ9YWcg6N/WNfyg7auGafbTuq+g07qbltHDEPQELKqkZ5ssRUgoxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJGBMiAl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD22606A31B;
	Wed,  4 Nov 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJGBMiAl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72481F000C1;
	Wed,  4 Nov 2026 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793791521;
	bh=+C2XbHpLqK8DQTw8gaAqePPNFIDKaUXWFXYTZBtyER8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gJGBMiAlOl01q3GsTgziQ5qdj8GUN4UCJW9S34pWhM0E5ZS0Cd4/O3i/jAqQQhTRh
	 ESTFm2nEUFoYMDN/4DyAHp3+2TuDrlo1HwxFIhEyHe8Uf0YuVUUaBqu4KbVK1W5n7l
	 Ydrs6MguiZYpxxLVpobSsF6yar0kZlqmzss42hS+eb0wbbiZvLIYjZwKmhimvv179K
	 Vxr/XgHjMdN9wlGSXn7TkIHfaK4mFkdRp3ohGI26BMgA6ICOJ4FZzTXt/mCuY8gkDt
	 YBLOwz5bkoRbyDwzj9aI+OD6PnZSajGKdGuLC4fXJyQz38f8j1M3L0ZTdN4cHR11zY
	 F0jot1F72uDhQ==
Date: Wed, 4 Nov 2026 12:25:17 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: siano: Replace strlcat() with snprintf() in
 sms_ir_init()
Message-ID: <ausVkYs1-3rJ5Fj0@devuan>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
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
	protocol="application/pgp-signature"; boundary="ofeojnjmg3d27igu"
Content-Disposition: inline
In-Reply-To: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>


--ofeojnjmg3d27igu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: siano: Replace strlcat() with snprintf() in
 sms_ir_init()
Message-ID: <ausVkYs1-3rJ5Fj0@devuan>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>

Hi Mariia,

> Date: 2026-11-04 01:02:39-0800
> From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
> In preparation for removing the deprecated strlcat() API[1],
> replace the strscpy() and strlcat() calls with a single snprintf()
> call to construct the IR device path.
>=20
> Both the source and destination buffers have the same capacity,

The line above seems irrelevant, and potentially confusing.
The size of the input is not important, because since we're appending
stuff after it, truncation may actually happen.

> and the return values are unused. This preserves the resulting
> string, including truncation behavior.
>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Except for the small comment above,

Reviewed-by: Alejandro Colomar <alx@kernel.org>


Cheers,
Alex

> ---
>  drivers/media/common/siano/smsir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/common/si=
ano/smsir.c
> index 283770d583d5..636ff228108b 100644
> --- a/drivers/media/common/siano/smsir.c
> +++ b/drivers/media/common/siano/smsir.c
> @@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
>  	snprintf(coredev->ir.name, sizeof(coredev->ir.name),
>  		 "SMS IR (%s)", sms_get_board(board_id)->name);
> =20
> -	strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.phys));
> -	strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
> +	snprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
> +		 "%s/ir0", coredev->devpath);
> =20
>  	dev->device_name =3D coredev->ir.name;
>  	dev->input_phys =3D coredev->ir.phys;
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--ofeojnjmg3d27igu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrrFhwACgkQ64mZXMKQ
wqmhyxAAn5l/sw/fVAK7OMWX6jxqedrOeQFFscoBRgFUNE/LcFtqZwfS7E2QlYgb
5BrwzjlG8yGElowXvEzEhjR6O9EZRa3lHl4utBAGeQklT3MabBZQHbmcC+AWbt1l
Zpho7yZcSMl232IpuLX/qWa1r6c3h4Go7leYxgicY8OlKAHd0UooMjuRiO62Byna
tpg3PjMjvNisAy5/66GAlmSWM05BprppUAzSviTaz8b6htuUT9Nh7hH0z7mZGZIh
13BVKH/RwX6x/gz16ovTtgZopMcxA1HUfGnX+/EVOhBXmFzBdSI/nOB+oZY32ls8
HG6kzK/yneDwJ8Nd0vQyW3k0xsh8UFrBBXFmSNHCr0tA0NE/ZzDIluBHLDREmC02
4iLIZ+6fe9RTo1DGYSQm+MuMbDsdji/cGUnbanq07evuXlLxm9iFWuWJzCtQrXR7
tcR56a6deUbRBjs49GD3IvLYN38RYz9k+Q9l1w2hegfh4J/cBIrtM8D4k6FD5+TQ
VMyGrnbPTcg6ZanQuadVjRIa7mKcNm2Cl9tEC9Wco6UQu0nRefIS32HaOBZj3HUK
KeEN0GudrKXHc/G7Na+vleLjz923k7zNpu+cZ+5Y1UinBww86iubAleraGTniUjc
A6D8BrfaBtESXgZkUS/Qp47QdrYh4eSFeh6N1WLO6/5RtiRDvLU=
=DdC9
-----END PGP SIGNATURE-----

--ofeojnjmg3d27igu--
