Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3A396B68;
	Wed, 18 Mar 2026 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834618; cv=pass; b=Vjc/zJ1shjW3fZqBjNN/bAzVTCK2oyEexmaevBei+E5dkkizbonD2NTmvfJoDE6IWmZd8lPeORGIWBqFJHapQeKve/hXWjNJh/MnsKQhxLz96It3QvBwnw//ge6mTyCbn9vPXyZslwtmtPvtjo9tq1x5r8iHkhcreOsEQwWSM4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834618; c=relaxed/simple;
	bh=vB4y0a1BIhvNPNLUNB9O+aD7a52kYC55AkV9UUTWmTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7E4bvRJW4Qkalcsw75BxA0FQrhfRgdKFD6kK28C6KywOGSnecn2chc/l+/ajjfvgQQpr3LYZvl/H858kM3rN6Rtw6CvYNuvZr6TR6dfeKV75cNxPoiVvJw4SAEx9rkDrcXfvU6pM08xgHey4qsZx5G2KWkCDNQg6WPm4QUbgQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=De4udURb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="De4udURb"
ARC-Seal: i=1; a=rsa-sha256; t=1773834612; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lvXrg1GaizTCMbsJgY1+aDxWPWfe4I8M/W1uT3wcDZNI+2z1PaCIEHXSXZD9EiRM57rnhoDNP1Jez9M/cjnhvs3RBCf01vqxqDi3zGFN3gYnwVZuw9OEjUxu6RkcfIvLZ3ruYnU+s8724HcUEFYM53MYO4hQI0dk9n0JLxsrD8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773834612; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e8F+2DqcGf3LVCVzo3GZFgWqvCTNNDDcukvayJcf7gQ=; 
	b=hmHZVl5Fb2fZvQcxqhEO5X/oovO5imcOi0BqpUqCbqJy7Kg2jQeKrAGaLP1XfL9avTTvXqcH+80dFJ6XycGG+i6eql67ESiWcVDWA1WN9znUUbZZ1YzFm4bz6RR22axP6LwWHnVDGtCC+VKxR1NmvlPsdbsAEO5yTDdNM+Omui4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773834611;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=e8F+2DqcGf3LVCVzo3GZFgWqvCTNNDDcukvayJcf7gQ=;
	b=De4udURbtTD+gsITfcRl0lWOyyBxQ988PsT1UBbF5ANFIoohwqOaPWGEb+RMpPw7
	/NbRtA0E5NhMF+6QRrNHvzMmGRJwq07Ksr0dPglIlfAy3+nv/A+fj8qootcgKnavdYG
	bwkb95hHmDk24T0RzrqGmKy65ejI0pGaYTwpo5lA=
Received: by mx.zohomail.com with SMTPS id 1773834609487541.4103756305765;
	Wed, 18 Mar 2026 04:50:09 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 9BDAE18044A; Wed, 18 Mar 2026 12:50:06 +0100 (CET)
Date: Wed, 18 Mar 2026 12:50:06 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCHv2] hsi: hsi_core: use kzalloc_flex
Message-ID: <abqGdAgB_WwaC6dx@venus>
References: <20260317195819.15496-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6up7iiq2dosrhznu"
Content-Disposition: inline
In-Reply-To: <20260317195819.15496-1-rosenp@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/273.807.15
X-ZohoMailClient: External


--6up7iiq2dosrhznu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv2] hsi: hsi_core: use kzalloc_flex
MIME-Version: 1.0

Hi,

On Tue, Mar 17, 2026 at 12:58:19PM -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
>=20
> Add __counted_by to get extra runtime analysis.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: remove wrong null check
>  drivers/hsi/hsi_core.c  | 38 +++++++++++++++-----------------------
>  include/linux/hsi/hsi.h |  2 +-
>  2 files changed, 16 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
> index 7cb2dcb30fdb..001bcadf4b8e 100644
> --- a/drivers/hsi/hsi_core.c
> +++ b/drivers/hsi/hsi_core.c
> @@ -342,13 +342,11 @@ static void hsi_controller_release(struct device *d=
ev)
>  {
>  	struct hsi_controller *hsi =3D to_hsi_controller(dev);
>=20
> -	kfree(hsi->port);
>  	kfree(hsi);
>  }
>=20
>  static void hsi_port_release(struct device *dev)
>  {
> -	kfree(to_hsi_port(dev));

Why is this free being removed? This is freeing hsi->port[i], which
still has an extra allocation after your patch.

FWIW - it should be possible to further simplify things (in a
potential follow-up patch) that also drops this extra
allocation/free by simply embedding an array of 'struct hsi_port'
instead of a pointer array in 'struct hsi_controller'.

Greetings,

-- Sebastian

>  }
>=20
>  /**
> @@ -446,7 +444,7 @@ void hsi_put_controller(struct hsi_controller *hsi)
>  		return;
>=20
>  	for (i =3D 0; i < hsi->num_ports; i++)
> -		if (hsi->port && hsi->port[i])
> +		if (hsi->port[i])
>  			put_device(&hsi->port[i]->device);
>  	put_device(&hsi->device);
>  }
> @@ -462,39 +460,33 @@ EXPORT_SYMBOL_GPL(hsi_put_controller);
>  struct hsi_controller *hsi_alloc_controller(unsigned int n_ports, gfp_t =
flags)
>  {
>  	struct hsi_controller	*hsi;
> -	struct hsi_port		**port;
>  	unsigned int		i;
>=20
>  	if (!n_ports)
>  		return NULL;
>=20
> -	hsi =3D kzalloc_obj(*hsi, flags);
> +	hsi =3D kzalloc_flex(*hsi, port, n_ports, flags);
>  	if (!hsi)
>  		return NULL;
> -	port =3D kzalloc_objs(*port, n_ports, flags);
> -	if (!port) {
> -		kfree(hsi);
> -		return NULL;
> -	}
> +
>  	hsi->num_ports =3D n_ports;
> -	hsi->port =3D port;
>  	hsi->device.release =3D hsi_controller_release;
>  	device_initialize(&hsi->device);
>=20
>  	for (i =3D 0; i < n_ports; i++) {
> -		port[i] =3D kzalloc_obj(**port, flags);
> -		if (port[i] =3D=3D NULL)
> +		hsi->port[i] =3D kzalloc_obj(**hsi->port, flags);
> +		if (hsi->port[i] =3D=3D NULL)
>  			goto out;
> -		port[i]->num =3D i;
> -		port[i]->async =3D hsi_dummy_msg;
> -		port[i]->setup =3D hsi_dummy_cl;
> -		port[i]->flush =3D hsi_dummy_cl;
> -		port[i]->start_tx =3D hsi_dummy_cl;
> -		port[i]->stop_tx =3D hsi_dummy_cl;
> -		port[i]->release =3D hsi_dummy_cl;
> -		mutex_init(&port[i]->lock);
> -		BLOCKING_INIT_NOTIFIER_HEAD(&port[i]->n_head);
> -		dev_set_name(&port[i]->device, "port%d", i);
> +		hsi->port[i]->num =3D i;
> +		hsi->port[i]->async =3D hsi_dummy_msg;
> +		hsi->port[i]->setup =3D hsi_dummy_cl;
> +		hsi->port[i]->flush =3D hsi_dummy_cl;
> +		hsi->port[i]->start_tx =3D hsi_dummy_cl;
> +		hsi->port[i]->stop_tx =3D hsi_dummy_cl;
> +		hsi->port[i]->release =3D hsi_dummy_cl;
> +		mutex_init(&hsi->port[i]->lock);
> +		BLOCKING_INIT_NOTIFIER_HEAD(&hsi->port[i]->n_head);
> +		dev_set_name(&hsi->port[i]->device, "port%d", i);
>  		hsi->port[i]->device.release =3D hsi_port_release;
>  		device_initialize(&hsi->port[i]->device);
>  	}
> diff --git a/include/linux/hsi/hsi.h b/include/linux/hsi/hsi.h
> index 6ca92bff02c6..ea6bef9b6012 100644
> --- a/include/linux/hsi/hsi.h
> +++ b/include/linux/hsi/hsi.h
> @@ -271,7 +271,7 @@ struct hsi_controller {
>  	struct module		*owner;
>  	unsigned int		id;
>  	unsigned int		num_ports;
> -	struct hsi_port		**port;
> +	struct hsi_port		*port[] __counted_by(num_ports);
>  };
>=20
>  #define to_hsi_controller(dev) container_of(dev, struct hsi_controller, =
device)
> --
> 2.53.0
>=20

--6up7iiq2dosrhznu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmm6kWoACgkQ2O7X88g7
+pq32A/8CfzzWjdnrrhX32wiJiMY8UvUI+3LOMX717xyKt5mS8mQB7KPrxmfHxmB
XZ9InFgwUPou/C94F1bltyGxV9Qci4qEAnfa+aTvl9Eo0lzWGgewEiR2ki0ju/K7
HGxW1CTuUjjEANtwt74BXwzTj1KDXOwczqoTiOSNx7KgVNHvHYGXochezcRn4QaV
Qiku9UeF+TUNLg6XiK4KetFz4OLj/crpYg+h1dO4tWQJsqVI3+KilVeg08NwWm2/
quERLdboIg2sGT8tLp/Ap/I7lgpRmaCINmNG7E9+uzPEr9rCiVDz5HHJBZb4md5f
WdLqf85p3PhSQfX6e/8oPNPlAtrLmEpyBx21nVI7eOFByznwcj+NVgrgR7l0mVHc
CXZPw0UrGgZPP71CIvJOgUwbP7+Sgvo9wKMZ8iHJJadQmKSbKhzl45GlAacFde7Y
iTD3gkpYtWpgdOHfK1r1O0ooLVmmBu0FXdN74bbhSq2oVz7PiD9ZbAfz3AO6zA2L
viLLnE/JIvo+QVSeyGK5Y9UqcwNGTSpJq2utXlfA2OUr/rY7qc0NCIntakPBglKY
zXaAwiMJQQdfuxCu+w58aE7fiJmSSOhRMhw26blriMa0KuGJ5HEpt2P57bfdCBAs
nQIkxPfuBzIYUNkuoBtg4Vr/Q9Gl+X1j2C16LxKzdZ3HhqXvS14=
=r+cu
-----END PGP SIGNATURE-----

--6up7iiq2dosrhznu--
