Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103857;
	b=zLq4wIF2S+a272rg+10JRe0WuDzKS3ShBxu+MyPMGPt/b/QY1AKt3EBruy7A1mBiBe65
	 fDn54Xhavx5Wv/MUW9IIAiboky4DIXk8dqOK8NNoS86slsSi8fCvMLLikmah3q9SU6qhV
	 fW8LA8ygc87CqONwZY7UfLtYjmOLaz77RtPNM6H0jKtPv94H0HX9dTM7pW9kgq8MUAkKF
	 lIscexH30+CZQpGgcp6Wd9hC5A3rleZkwz1dBUyJ/kaBm5UyN3fjDDYPYJVCzVUN6AecH
	 ajnf2SRgyv/PB3b0KMfSJJpf4eXFdCLlA49NzfdJVtIgmVxHzk2p1ailT9pHIEow2Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103857;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=sNN1731RXRr0vyB+I+4Vk0Kb65E7JyUhQG5+tsFjqJg=;
	b=gDuQ+M2ag8c6eTx9RxGh8vvBaQJUOs1mMpTwznE8BN5I0y+aRFJhAr5ogwNaN/iP+3ZM
	 4sqoDpAxYJ12Yn1rSyfwOf6UnzVLB6m3BTizdCNt6IDmmqzqKcwF3bEss1GBnSdTmfGFG
	 gRaK/fn0zXdCaGbc0p5wA5PH9+GPWe/9t0tcI7NCvbF99RX1taej/UpL4q3gCl5ztMWu0
	 bqVnXqfo3qTyjMwMx0g2eyJBMMOGhLa6zNjcATc2IlB2pHCcSs6exhgPlbmNKwDyZPYkE
	 OYRqGkQYXYADkl/uUgIsSRnw0GyDSTtr/3kAQOzHdzlhnfO1wEYPz1yPT07deanX4dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tgaFkcWP;
	arc=none smtp.remote-ip=95.215.58.192
Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF95606A32A
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 15:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF95606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tgaFkcWP
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E1Mtv6PwMAjNgu+Yqi3TMm4tWjlWRE3n2A0rfbbvK3Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795103854; v=1; x=1795708654;
 b=tgaFkcWPzhiH88uxNrb8BDATZnFgWbgpInWy1MXUj2VR8nMoVFYxquGWP43wvIFfDRg0u7wk
 +VFC7wqWFujvC+Y0BoQiXJmLwTrmzfOBrHTxzKyX6CEwfmMksI9NbXHIFBpM8SfBeTnVzwsOP1l
 9sQUMP8FlyRcgT+pFU+mX41g=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79771307de0e0cf3;
	Thu, 19 Nov 2026 15:57:34 +0000
X-Mizu-Trace-ID: 79771307de0e0cf3
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 19 Nov 2026 15:57:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <6b898ffecaa5b82e06613c60ed0bda6c7df292f0@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 02/18] mm/swap: clean up hibernation error
 handling
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <2951eed4feabbf1a72dbcaedfc011782d9885604.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <2951eed4feabbf1a72dbcaedfc011782d9885604.1794666741.git.lianux.mm@gmail.com>

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20Restructure the error paths in pin_hibernation_swap_type() using a
> goto out pattern to avoid repeated spin_unlock() calls and simplify
> the return flow. Also simplify unpin_hibernation_swap_type() by
> making the si NULL check inline, and clean up find_first_swap() to
> avoid an early return inside the loop.
>=20
>=20Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
>=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c41c4d26a7e6..c69a924acb74 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2331,21 +2331,18 @@ static int __find_hibernation_swap_type(dev_t d=
evice, sector_t offset)
>  */
>  int pin_hibernation_swap_type(dev_t device, sector_t offset)
>  {
> - int type;
> + int ret;
>  struct swap_info_struct *si;
>=20=20
>=20 spin_lock(&swap_lock);
> + ret =3D __find_hibernation_swap_type(device, offset);
> + if (ret < 0)
> + goto out;
>=20=20
>=20- type =3D __find_hibernation_swap_type(device, offset);
> - if (type < 0) {
> - spin_unlock(&swap_lock);
> - return type;
> - }
> -
> - si =3D swap_type_to_info(type);
> + si =3D swap_type_to_info(ret);
>  if (WARN_ON_ONCE(!si)) {
> - spin_unlock(&swap_lock);
> - return -ENODEV;
> + ret =3D -ENODEV;
> + goto out;
>  }
>=20=20
>=20 /*
> @@ -2354,14 +2351,15 @@ int pin_hibernation_swap_type(dev_t device, sec=
tor_t offset)
>  * the same session.
>  */
>  if (WARN_ON_ONCE(si->flags & SWP_HIBERNATION)) {
> - spin_unlock(&swap_lock);
> - return -EBUSY;
> + ret =3D -EBUSY;
> + goto out;
>  }
>=20=20
>=20 si->flags |=3D SWP_HIBERNATION;
>=20=20
>=20+out:
>  spin_unlock(&swap_lock);
> - return type;
> + return ret;
>  }
>=20=20
>=20 /**
> @@ -2441,11 +2439,8 @@ void unpin_hibernation_swap_type(int type)
>=20=20
>=20 spin_lock(&swap_lock);
>  si =3D swap_type_to_info(type);
> - if (!si) {
> - spin_unlock(&swap_lock);
> - return;
> - }
> - si->flags &=3D ~SWP_HIBERNATION;
> + if (si)
> + si->flags &=3D ~SWP_HIBERNATION;
>  spin_unlock(&swap_lock);
>  }
>=20=20
>=20@@ -2480,7 +2475,7 @@ int find_hibernation_swap_type(dev_t device, se=
ctor_t offset)
>=20=20
>=20 int find_first_swap(dev_t *device)
>  {
> - int type;
> + int type, ret =3D -ENODEV;
>=20=20
>=20 spin_lock(&swap_lock);
>  for (type =3D 0; type < nr_swapfiles; type++) {
> @@ -2489,11 +2484,11 @@ int find_first_swap(dev_t *device)
>  if (!(sis->flags & SWP_WRITEOK))
>  continue;
>  *device =3D sis->bdev->bd_dev;
> - spin_unlock(&swap_lock);
> - return type;
> + ret =3D type;
> + break;
>  }
>  spin_unlock(&swap_lock);
> - return -ENODEV;
> + return ret;
>  }
>=20=20
>=20 /*
>

Thanks!

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
