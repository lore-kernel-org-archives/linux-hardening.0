Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDC26B098
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860642; cv=none; b=GBdB2aFd4Sc9oico/JVqVjyQQxLjRS0dvhGBJFfUrNMzeSqS1Fdir++lAxRsinBofHJ4ojdQEORVmlmll35w4afjxgq8NhoWRuEjruivI4khZDZEqT35YXH8YHF1FZD2K7QFqFTDPtOtuCqFxaLTvrj9BC3t03NBDqAUHp6rddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860642; c=relaxed/simple;
	bh=YqoA01vkzIt3VnFZN/HuOG9XtAMXOx/Vm2Rgu548RH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uttzae6mV8hj85c5XL+AZwF70g5AEW4jO678b784q09l+k3i76j/DVoBGnm4kXXHJoTXX91hubJTUSHNvm8UuiR3YB44eiK6V+t9nb33BrM4t5o5Irj+xm/ezpRCTf9Fd/znG22j1/xrd06qMxJlNPFnuskb6wb7PXTWaWFuoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gdVzr2qh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gdVzr2qh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 246FBC40683;
	Mon, 30 Mar 2026 08:51:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20C5B5FFA8;
	Mon, 30 Mar 2026 08:50:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A7F5104509E8;
	Mon, 30 Mar 2026 10:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774860637; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hoaPy3dAemrLrovkm6cSEOV1da82kQ0m4RB5ivCVSjY=;
	b=gdVzr2qhnctCSO+B9viP6ihTGVuw2/RVKgBvPjcD7EErM80k7MVshjt/AVFjTNKwaEcHwF
	Hr/dgBcLpyuy/xZhoNhrjK7M+i533lHcataoJcDR3qnQ+BmfXOyjoRFyo3l+Y5VzD5vFDE
	zs7eXJ/9TPhxBnavZipTqkJ8MuOYB+rQMnBw0LHdpZrxylNBKGLO3D6p8bmqXWk24JN/uy
	HerdQAWp3RXYClM37ZTR098pOD160BqXJnrScN5R0OVEcrSFMfgyRjcQiKEiU6MearN79V
	QCr7A1EkxH8IwvNtOy/AJE+ZlS7sqWIKTDLdIt/LzAIiDi2ihmDsvZ+d3P/Uug==
From: Romain Gantois <romain.gantois@bootlin.com>
To: linux-i2c@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL HARDENING (not covered by other
 areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
Date: Mon, 30 Mar 2026 10:50:30 +0200
Message-ID: <10827295.nUPlyArG6x@fw-rgant>
In-Reply-To: <20260313002308.119343-1-rosenp@gmail.com>
References: <20260313002308.119343-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2346479.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2346479.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: linux-i2c@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
Date: Mon, 30 Mar 2026 10:50:30 +0200
Message-ID: <10827295.nUPlyArG6x@fw-rgant>
In-Reply-To: <20260313002308.119343-1-rosenp@gmail.com>
References: <20260313002308.119343-1-rosenp@gmail.com>
MIME-Version: 1.0

Hello Rosen,

On Friday, 13 March 2026 01:23:08 CEST Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
> 
>  drivers/i2c/i2c-atr.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
> index f9fcb4793aaf..b0aedcf0bf71 100644
> --- a/drivers/i2c/i2c-atr.c
> +++ b/drivers/i2c/i2c-atr.c
> @@ -58,8 +58,8 @@ struct i2c_atr_alias_pool {
> 
>  	/* Protects aliases and use_mask */
>  	spinlock_t lock;
> 
> -	u16 *aliases;
> 
>  	unsigned long *use_mask;
> 
> +	u16 aliases[] __counted_by(size);
> 
>  };
>  
>  /**
> 
> @@ -137,22 +137,16 @@ static struct i2c_atr_alias_pool
> *i2c_atr_alloc_alias_pool(size_t num_aliases, b struct i2c_atr_alias_pool
> *alias_pool;
> 
>  	int ret;
> 
> -	alias_pool = kzalloc_obj(*alias_pool);
> +	alias_pool = kzalloc_flex(*alias_pool, aliases, num_aliases);
> 
>  	if (!alias_pool)
>  	
>  		return ERR_PTR(-ENOMEM);
>  	
>  	alias_pool->size = num_aliases;
> 
> -	alias_pool->aliases = kcalloc(num_aliases, sizeof(*alias_pool->aliases),
> GFP_KERNEL); -	if (!alias_pool->aliases) {
> -		ret = -ENOMEM;
> -		goto err_free_alias_pool;
> -	}
> -
> 
>  	alias_pool->use_mask = bitmap_zalloc(num_aliases, GFP_KERNEL);
>  	if (!alias_pool->use_mask) {
>  	
>  		ret = -ENOMEM;
> 
> -		goto err_free_aliases;
> +		goto err_free_alias_pool;
> 
>  	}
>  	
>  	alias_pool->shared = shared;
> 
> @@ -161,8 +155,6 @@ static struct i2c_atr_alias_pool
> *i2c_atr_alloc_alias_pool(size_t num_aliases, b
> 
>  	return alias_pool;
> 
> -err_free_aliases:
> -	kfree(alias_pool->aliases);
> 
>  err_free_alias_pool:
>  	kfree(alias_pool);
>  	return ERR_PTR(ret);
> 
> @@ -171,7 +163,6 @@ static struct i2c_atr_alias_pool
> *i2c_atr_alloc_alias_pool(size_t num_aliases, b static void
> i2c_atr_free_alias_pool(struct i2c_atr_alias_pool *alias_pool) {
> 
>  	bitmap_free(alias_pool->use_mask);
> 
> -	kfree(alias_pool->aliases);
> 
>  	kfree(alias_pool);
>  
>  }

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>


--nextPart2346479.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmnKOVcACgkQKCYAIARz
eA5n2A/+O2yG6k55E9nGEFOxJ9z88VjUzLAwn1qtxGQqGufghL1jtKyWJp4momXp
W/ACN4d4r0Svid23nm+am0lH8+9IW0iBacpA3RichH3lUKOqlUzcQes7tLHiSgO+
pbXny0hhb0OFpv9EqHJbA0+Ft+zdOQ14eNSeSxZodyX4fcLqVxdynv2HHt3RltFh
PJyv77x/BYSfixyFaaYPIPzKcunonKeMTBFwTdXdWS0ch6dwkW/Kl2rWPkxiWkXp
rz0JsVdKdtCQZtXh9Pt81ApkQ6bDtW6onGvmA/wqTGiBfHvnBrik61wTZEhZBef/
vww2zSMgfo9chf3XPP/fmmoVdE/JTKZA4ByrUoot7DD042KgCU+VjwNJkihh5vPO
t4g5yt0qMFcHvGFBPJuBeGm2NfkGUmzo64BocOLzckBCdVNdymZgdZDfhwJf6Oex
W4GrdPaU9Sgr6J/tcqltG0vbSBEyI8AunSaqi+hWmiKSpRpyBeaVfMkznGGBCttG
tbCxsVkBwq9lDrKX2iY6Cqok4ArJQSkE6xycRVmNKNDxRHUz0ckED98hzTvpoXEU
8OpicjwbSzadmo1SsVWZwH3NgNLZdPV9z1Yo4X7AABiQ6L9ww99HVcERWmZhUeGT
oS1ulIadESDhKa5gcKZGJ++pSwOsBJKr5sY6NWtrkfZi4v7vyrc=
=GWH0
-----END PGP SIGNATURE-----

--nextPart2346479.iZASKD2KPV--



