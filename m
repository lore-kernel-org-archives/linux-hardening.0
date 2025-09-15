Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661228BA83
	for <linux-hardening@vger.kernel.org>; Mon, 15 Sep 2025 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977640; cv=none; b=mxQzkdxdieEsVQSBA0t2JwuiUZZeOO5BkdiMBDr+JJ6TX+WtgFVXx2JImu1eaaXf0FHI0BNA923ZlhzEKLQ06AndI+/94z1dueBxJ3kguOaDAAeerWff9ypqyzwsG7hFCqbsfjRQ2DUKOffsrT9YYMRx3dE4Ktq5/JvlBcdqJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977640; c=relaxed/simple;
	bh=LN2djmX+oWBpW9P0SQsUvr3K6xqKGvT+SBfNb5FBCfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RroR36kkWB6WBnfTnYxeDBylOsCFDJjMZXW2k9gHruHg8z3hXxpQetms6aMACMRrHpxU+mret/p/bPko5zNcJGvLL7R7shpM8Tfmbr4741NdHZXTpeSe477W26cNDBzUlQtECIO+eb/IEWwR2wHvg5N7T0kD/a9WJ/dd0DrfMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nd5wlmFr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nd5wlmFr"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-80b7a6b2b47so448997685a.0
        for <linux-hardening@vger.kernel.org>; Mon, 15 Sep 2025 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757977637; x=1758582437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntdt+Fw1ooyH2+q0/xC8jx4AecQq6NmyBnAlPcFGaz8=;
        b=nd5wlmFrv+QWCLNeQpAFa30x8xxgTg85lWSc3loFOF8iGXWG1GN5el05+kBBnPDc1D
         UbK6AMmer7L5dP9PU8vta7nGOOnnTo6uZgDIEw/wfD+8xrqwiFE25jB9y58uuvE2iABe
         7kDWZpqRLPY6PV6o80+NJttu9XHmhc4gpH5fhlefcmeVDqNiL8xoQyYl4nzYjQr4L134
         VifwvWpvShK4EvbuYWvss8GSsRLG6GjTvBYx5qy7ub2GD57eun5PWtJQD6gxFXzvpPmH
         0jde8OLmPHaR8Sl+rvq/q2ih4JY9RLdNviWkqQB8utmrd2bm0dpv8czg0svlFiOhcHld
         g4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977637; x=1758582437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntdt+Fw1ooyH2+q0/xC8jx4AecQq6NmyBnAlPcFGaz8=;
        b=jaLCKObYGbegXFj0Gy1wvtO1piIRtHPrLBZKNol1c9aFZrbzmcJ5lRxQ1wAAOLIRQD
         mhZnUHbKSm4UhzR6ye1vpyo5teIchk0xe4RKjuiIM1z+U0BMWEPAgwWXeuVQXIR7vayo
         453DYEmVHucwCuTiXzicvSakicLvlj+Y3MecRlCN4aegaDqBCapxX7d4LaKaNlkUND6t
         GMODhsK3NMSLODCKqdhTNbB2xrmjx00Q9cxAb/uOTHcwKuOyLTlz/gx3HSrQvpTGQ17B
         GZZmqx9M9JM6sbyuPAPVi8Ghm+3BJXugr47PuyM7uUsKpUnpzFr8eyZBS7/GBGcHRSFp
         IlOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxUzGQ7eUjAExUDhocgMwxmsbQzmwhcw88Snj67zpji6wYDCwFu9aBVCqynL4b4bAZF6Amb0siQ7El6d/Ibyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mM9SzSkdyesD+H82NmKjh4MBR+/9kQylXVDyxW82bflPjtY+
	UkNPrzxdJ0HmukeU0v7zbhJ7Po1/LEItjrhHGKYl+MKbRi6IkpfsC7sJWK6FIgA71OluER6yFwv
	V0g9qjg==
X-Gm-Gg: ASbGncvW3QTkwx2m9ifqFMpTVLj+BeBnmEiv6uAyZkqVzwaIUr3L1UTZ4TnbysHbake
	zRVVOkD8swSuxxp0kC9WqUy38Iu4t48DTJsNoF7BKIEjQtA1Uh1t19H7LOHLv0DCWEvaR58+x7G
	IAQpEEtpkkdy1HNz8OYTjRbHFHRri9t/XKFdZV2y/fS9r3Kp5jATq7PqlzVL7b/LOjdARKrbccS
	bcNZAbPCxpmcn3Ouhq7rlpK+PBMZF/Az0QiUJHNH1GVrIMnHQ1DFi/Sb/JBqYfCJgg+9Rnkv0pS
	EMeqrvUkjQl/fYsHU/UwRBgAjlXuYV4Na/WpgxJQC3Iqjy983cWF8QSakG0/VS1o5/O5D++mswI
	ZkDPIzl9sUlZDpNdreb4iy0vOfDMRe/mDGl5izHUJ6pS5DrprNz7pSAuZJxweJ7RtmQ1OsjWXrm
	1lWAIm0A==
X-Google-Smtp-Source: AGHT+IEoi1lVcF4aPi9zcBQfqqjlIJGn2T6EJO2nM/jlo5+f9d6XecVONNJlc1ldgD3Xd7nmpRVVIA==
X-Received: by 2002:a05:6e02:12c7:b0:418:4323:921f with SMTP id e9e14a558f8ab-420a568c3a9mr147338935ab.32.1757977624725;
        Mon, 15 Sep 2025 16:07:04 -0700 (PDT)
Received: from google.com (138.243.29.34.bc.googleusercontent.com. [34.29.243.138])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-423f9383029sm37354345ab.32.2025.09.15.16.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:07:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:06:59 -0700
From: Justin Stitt <justinstitt@google.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] drm/nouveau: fifo: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <fksv7eprcqnb55n5zllfyhk7ynx6zgbeuqtuoimbpgamguyodh@niwjdhicah2j>
References: <aJ17oxJYcqqr3946@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ17oxJYcqqr3946@kspp>

Hi,

On Thu, Aug 14, 2025 at 03:01:07PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> drivers/gpu/drm/nouveau/nvif/fifo.c:29:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I took a look at the modified structure layout with the union from the
macro using pahole and found the layouts and sizes to be equivalent --
all the while fixing the warning you demonstrated.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> Changes in v3:
>  - Use the new TRAILING_OVERLAP() helper.

There's really starting to be a lot of these helper macros!

> 
> Changes in v2:
>  - Adjust heap allocation.
> 
>  drivers/gpu/drm/nouveau/nvif/fifo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
> index a463289962b2..b0ab80995d98 100644
> --- a/drivers/gpu/drm/nouveau/nvif/fifo.c
> +++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
> @@ -25,13 +25,12 @@ static int
>  nvif_fifo_runlists(struct nvif_device *device)
>  {
>  	struct nvif_object *object = &device->object;
> -	struct {
> -		struct nv_device_info_v1 m;
> +	TRAILING_OVERLAP(struct nv_device_info_v1, m, data,
>  		struct {
>  			struct nv_device_info_v1_data runlists;
>  			struct nv_device_info_v1_data runlist[64];
>  		} v;
> -	} *a;
> +	) *a;
>  	int ret, i;
>  
>  	if (device->runlist)
> -- 
> 2.43.0
> 
>

Thanks
Justin
