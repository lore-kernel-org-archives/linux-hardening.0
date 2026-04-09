Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7102D2496;
	Thu,  9 Apr 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752167; cv=none; b=TPUGnbfRd3K9/2QJiaNC2upknedjFx6zcH6zcXbTJ4YTjnbx2D2+DO+UIQR2jnh777IqXhnh0Rr9KK0pOwwLTF7YNrW7GldlXYGUTFnq3ix5HZkAniB9BON5P2wXELKjtNfKofZSbALcXj0WJxe6oZzmHH1eXt9WYjbz2LV7dQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752167; c=relaxed/simple;
	bh=0PYLzHiQW4t3ziI2iibnh/BE/gLcKoKFZi9FCjfOoYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm9dbuIDFuN+lmtBlTiQJwnVivbHx0Y7+6yh36HiDCpc2yDY+v0j+6GYvjiYn0nrRtbuO82DlpuiRerC0tg1Q7UTD1ZvAqwcLDDRfAswmtz+sYiUSeM0Dsn1l2GtftquI8pBse5pnzqRTYQg5Arjz1MDWR4wWXX8UQbozEfLqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrKuwMii; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrKuwMii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989BDC4CEF7;
	Thu,  9 Apr 2026 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775752167;
	bh=0PYLzHiQW4t3ziI2iibnh/BE/gLcKoKFZi9FCjfOoYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrKuwMiiVK0wH2SSeSYHrFn8Cc6LXHpns6aSQLfsAWCUahBmAgLkoHmMwTJp30APz
	 zF+/SkrRQGbLMF9pKSgOgQfKjFwCPENVUgIDvT2IJyvcs06Hgz3/5ZtX3TkzKqJnzJ
	 batiAo9M9Fd1F8sAJ0yNluNfOMnRu3reGJEtDBRN5cCgLlWqfCv/JpznEJ9GwjD9Pn
	 QwbPKqva2q0LdwAoL8+0MXq/5pAJ6ubY0KSBLfrfek75i/onxcbzBxOhmvfK1TJX/G
	 JneiE1qSu5t/6M6JZyO0xRfQ4eDCdJluX+9oXB1ehhGlYtnjgoUvHbBuAvqoqD7XF9
	 yvysEfg0FVAAw==
Date: Thu, 9 Apr 2026 18:29:22 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-i2c@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
Message-ID: <adfTdfty7q0nygeo@zenone.zhora.eu>
References: <20260327030310.8502-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327030310.8502-1-rosenp@gmail.com>

Hi Rosen,

along with Luca's comments, I will ask you for one more change:

...

>  	/* Protects aliases and use_mask */
>  	spinlock_t lock;
> -	u16 *aliases;
>  	unsigned long *use_mask;
> +	u16 aliases[] __counted_by(size);

...

> -	alias_pool = kzalloc_obj(*alias_pool);
> +	alias_pool = kzalloc_flex(*alias_pool, aliases, num_aliases);
>  	if (!alias_pool)
>  		return ERR_PTR(-ENOMEM);
>  
>  	alias_pool->size = num_aliases;

this line is not needed anymore because kzalloc_flex will resolve
to alias_pool size and will set it tu num_aliases.

We can remove it.

Thanks,
Andi

> -	alias_pool->aliases = kcalloc(num_aliases, sizeof(*alias_pool->aliases), GFP_KERNEL);
> -	if (!alias_pool->aliases) {
> -		ret = -ENOMEM;
> -		goto err_free_alias_pool;
> -	}
> -
