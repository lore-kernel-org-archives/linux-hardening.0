Received: from mail-wr2-f39.google.com (mail-wr2-f39.google.com [74.125.225.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC13E3DB8
	for <linux-hardening@vger.kernel.org>; Wed, 30 Sep 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755105; cv=none; b=OYkrbT00PhdLRhq3BXN6G2yHLuZSqhPlhHwMMRxMLY84jv7ziZ3rFX945g+1tn8iCZwf9gyZf5B9pvCUf5eDY7kBXXtuK13WiGmYpqVBEx7rLH7iAUAa0MTOqUHCsl6pcLVa9NSQXglxmWv5wP6yPUd5oqKA/+KFLEI04IW1hhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755105; c=relaxed/simple;
	bh=lvXf3tpQM3sE0rI68tmiWzWdjaHzxfLtaXOKMtVK6QA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uMTSUzvYcVaCFvEXqKUGrZ/FRTYGsLD0EkaFCws2mVQdYhKTIFp0lSo0jdXNNOLg1Ehsgc7z3yaCsqZssr0JU33dhW22wxE9HbvoCAcVChzAqbOpwo+B24PManPEwQQ8lpl7yS2kUSSk8a2kGy4U8N8NSCQ/DH0XJnQrve2vGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Aw/cfMFU; arc=none smtp.client-ip=74.125.225.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Aw/cfMFU"
Received: by mail-wr2-f39.google.com with SMTP id ffacd0b85a97d-48af929e59dso883933f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Sep 2026 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790755099; x=1791359899; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWn2iPXvCs6SWNk89OK5OvlJgb4Z2dWAtqxQeryEwx0=;
        b=Aw/cfMFUz1EHQqySg/QqFUtjautV5Wijb88vTfz9nHiysjQpxB+H7cNKGyvjvx0j3A
         soXarMRbu9eql/0AQgSnGqmgu0riDm9vWHeyIy2qC4xtD1VR8lXb8Az1DxHFyCHo3N6z
         /b2qLXNW0Eexnsn8UUBktyqYl9AMAerMkLhVzuewo4dEvHQFaVbjhxj9YvVrOquBLZ0Y
         qnX3fLjeCrLEDt/8wWXrv3boC9uDH7bfAFg60AJFCuZiUrqAw7sQSrnTIpIh8rOHFCnp
         HnhAj5KkSSBTuyWxg146iK/W3WXjGEjr2xn703avD82/Jl+FKargSUDdOyoER7Oglk/i
         Nbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790755099; x=1791359899;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jWn2iPXvCs6SWNk89OK5OvlJgb4Z2dWAtqxQeryEwx0=;
        b=IZ57eo/VtEAeRJn2zpmnDK01+9Izb0lN5I2aY63S5e3Lx1+H1H6UDpLENba0Xwt8Jd
         5radCdhlIZkVeah3PmXfkAFgcSgr/hb3J8FoaMzrcp6EgFEwz7yeWuRkxH6LP/sF5PHe
         xGXiIyZkA5ofos9dMKSS2VP0N8QMrBjwT0zmNzRPuYekpbUjNNI4bayLK5kPOZ0ZKox0
         N7RwOfvMHeF0/veXv/1HA3stcWN68YEqF28FL3enW7TlxdNIJryhlIDYOQZSY8KrAZTY
         +Gyhm4H8yuytDLOKSaouhdMB2y6qdnBEUqYT7yF4ZRuH53EvG1GMal2/FDb5MqRrl3Tv
         huYA==
X-Forwarded-Encrypted: i=1; AKwUvBx2T22HUr13tlso4ESVWjpIPFItUJPCnkMxC1t3s9LzY+HrD+1+nOmgmQlArIJdw0PqzfxqWRAC7qaUmVRO6ZI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUCof1WNnmHYXvGJC+3n20bxQD1POuR19l1aBIYw2MT1Pqmjr6
	hic1AXjhPG9T9EEuqrD2KQGGkSrl/07B+yY3Yw2MMIwf+hlyH7LmJlliuSTTi6y0SzI=
X-Gm-Gg: AYBFou2cQ0JcUI5agz6UMBu2XPzY5r6UIUTaz36y4XZ51fmibHrHEUw4sihTX0s9Uyz
	P0olZjfh4Mj0sRFQ1JDMAsEoyK3v0/b6ZmDgOD0hik65ZMZiYq8Lc464u/SHI0sG8C2teSf7k4M
	Tzrvwj0Mebom5MlkubxYCI6SwJv48cJl+u6S7BQsIJBlQ6N1cBO+aT8nzJc0pzIQUugpOVxpRI4
	m6oTKSeZVd1ZEnnrMSpK+DP2sf9cTd1nisxyDm9rW8zHeSIrnoAOo4Ya5BLpwje8+U/fW4JyBMj
	Ur7B5mj4xtkMrbtIesZ/AU1dOhGwRSys+xBGKdedfeaIf05N4oZwi/7RUv8AaCFZdfrfqJlBAGF
	wk9f5kqAzplBUJtJzSDSHdusMkyHLmPMJ2BD80Bf1N/XYzlK8N30BPsqGvH67N2jXdnJyztKBAx
	1cn7acqrOPv62p/xllDaRT8i5LpSsZ/M8tWPm0E1Zlh2eAI27s6L+wKFfh37sZdoOtHkhoPJzZX
	8+7l3dwVvA8+WwXUQ==
X-Received: by 2002:a05:6000:310d:b0:485:8c16:a32d with SMTP id ffacd0b85a97d-48b0250afc2mr1187154f8f.34.1790755099585;
        Wed, 30 Sep 2026 00:58:19 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b028b237esm1738200f8f.0.2026.09.30.00.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:58:19 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Rosen Penev <rosenp@gmail.com>, linux-clk@vger.kernel.org
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
 <jbrunet+clk@baylibre.com>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, "open list:TEGRA
 ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered
 by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH RESEND] clk: tegra: bmp: remove kcalloc
In-Reply-To: <20260929192437.27775-1-rosenp@gmail.com>
References: <20260929192437.27775-1-rosenp@gmail.com>
Date: Wed, 30 Sep 2026 09:58:18 +0200
Message-ID: <1jwls32msl.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On mar. 29 sept. 2026 at 12:24, Rosen Penev <rosenp@gmail.com> wrote:

> Use a flexible array member to avoid allocating separately.
>
> Use __counted_by for extra runtime analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/clk/tegra/clk-bpmp.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
> index 067a8555c4e7..15b976162b59 100644
> --- a/drivers/clk/tegra/clk-bpmp.c
> +++ b/drivers/clk/tegra/clk-bpmp.c
> @@ -32,7 +32,7 @@ struct tegra_bpmp_clk {
>  	unsigned int id;
>  
>  	unsigned int num_parents;
> -	unsigned int *parents;
> +	unsigned int parents[] __counted_by(num_parents);
>  };
>  
>  static inline struct tegra_bpmp_clk *to_tegra_bpmp_clk(struct clk_hw *hw)
> @@ -518,20 +518,14 @@ tegra_bpmp_clk_register(struct tegra_bpmp *bpmp,
>  	unsigned int i;
>  	int err;
>  
> -	clk = devm_kzalloc(bpmp->dev, sizeof(*clk), GFP_KERNEL);
> +	clk = devm_kzalloc(bpmp->dev, struct_size(clk, parents, info->num_parents), GFP_KERNEL);
>  	if (!clk)
>  		return ERR_PTR(-ENOMEM);
>  
> +	clk->num_parents = info->num_parents;
>  	clk->id = info->id;
>  	clk->bpmp = bpmp;
>  
> -	clk->parents = devm_kcalloc(bpmp->dev, info->num_parents,
> -				    sizeof(*clk->parents), GFP_KERNEL);
> -	if (!clk->parents)
> -		return ERR_PTR(-ENOMEM);
> -
> -	clk->num_parents = info->num_parents;
> -

What is the benefit of doing this ? It looks like you are just trading
one alloc for another here ?

>  	/* hardware clock initialization */
>  	memset(&init, 0, sizeof(init));
>  	init.name = info->name;
> -- 
> 2.55.0
>

-- 
Jerome
