Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD237107B
	for <linux-hardening@vger.kernel.org>; Fri,  3 Apr 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222972; cv=none; b=NL9tqthQgtgYwE/NrpA/fJGZxBytbO2IyN3c9V1WbyeBKqpuFmOi0qptmKcgE+mrUkDnd9kKB89vyhnB1J3f3Bdyglk3EzYWS62dXaTTCwc4eBBJDFJBUlYw2wUXG69N+ps+OrUP15C3hoHM1wdM1G3WDeYa2PaI+YHRg153JZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222972; c=relaxed/simple;
	bh=blHK4KzH5lgN9+DZFvRNfi2lm0KKMuYwwQPYPh1mRlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BCKxljqB9dI67GasPAXzDv7Xnta3H2iTekXG5mydupBSTMgEZmuw3Ft/RVgwEla3Su8hnjK2zVQmGeFTmvkuBeEapTaCXFz8iyCjuys9IHxMGfqwk1S4IfyqvNnEk2LKYUKmh4H9F8UH6tuB0Yhu4Prw/Hon78RUfNIMZ5NX0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWM7nKIc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWM7nKIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775222970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3TgrwVgeoZcZASDHDP/iFsOkmG4q/7olBpiPeQBlYk=;
	b=IWM7nKIchRdQTtzs2/2MJmMLN5J7DFgRpEXcnuhImOXTVk/QNuk5tUtrXd1mfWlEvrJFG9
	D+RGKIplfJXafe5fckIqbEhH8EfIlFHhGlrJkvz87xfZXVodg8LIjGAE6Zp9wtR9clW+o4
	ISwIduyjiYhfJ17OLWn1FsVSD57IaNs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-vvhHTpqjMEWLPrhtE6m4Sg-1; Fri, 03 Apr 2026 09:29:29 -0400
X-MC-Unique: vvhHTpqjMEWLPrhtE6m4Sg-1
X-Mimecast-MFC-AGG-ID: vvhHTpqjMEWLPrhtE6m4Sg_1775222969
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5aa81907so35924841cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 03 Apr 2026 06:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775222969; x=1775827769;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3TgrwVgeoZcZASDHDP/iFsOkmG4q/7olBpiPeQBlYk=;
        b=crFZb/b154VF8wc+812LZKrNh+Qo/DweMQwXxu4Vs/KfLGeqAcMwdJ0V9ZwtJFWzMJ
         Joidv9cPhWNe/vAxRngcQLRxqQ+Zwef5yV+8Q8FgHiknqnqyIMj+VuhCjfQsOEWgNT38
         YSqm1fVe1QM0JYCFPlZxrGR9Q2j06KTAr8h7ZwrMPNHKC/WduA0hLJzbM5qf9kE2QXUW
         SZMjCOlSZ7KCAuPgihHtC0R5xy7b4C1aHRQAIinOXO74Zbsb8r29h8qfXs5WfJHuliFh
         48ueq9vOcg6RK16/4aXgLr3qZ7gyFQYO3DOJLLgcjGiLLBTaupasJJOFZpIl9mIOQa+S
         yDiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE+1sdbE/A6U3oWgjO7QZwkxIPngQdZgJWehAG37z7/ETRWgLdtl2q0JliaGSML0L44w19bnDrap1CS6PMiPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTxj9/6KOhl6Vcm2peOoUzSMG4arzVkQF91v02Td5ZWARGh+q
	eVH9u60Ue0ELhFXTgDKCPfhaM34C7sqP6P+9jsgzNxTiChqZgM+3cxyQ0GJ/blKPH+jzFumGys1
	FK1yYzUvkFOOJ+nGiboGZ1cxWPc8ziwMAOkVw4sTejxjMg6sVcdM6CKjPZi+MkdDpeRWtAg==
X-Gm-Gg: ATEYQzx6jRzT43YnAD79y3jrB5u1ura+s0QZt+d3YTHIvIuLwR4hXfajelLYii3W2vf
	JAd/4mzsIU6/LNQavtEE4ncAdwLT/U40jsp3zDcvKvaTEHW95S+dsY3Xwv08318KkfuG9noFhkN
	jk6JjES9BQCAITur5ALoFdb4rucGjk9hOa28PdAjSpgP0PXp7iT+GiYUaG7B99AF7LMG4xmAXxQ
	AF6erKIaf5wg/A3HEgCVN32INUSYelckI7aFgy0znvNjHzKbqlS/zQ8puuT9ip3f1xpNHYEC3l1
	jjBbxyfttKWiszBPkk8WZ2bsAzYKV1JbjvgFA00S0QpGZgLx93vT7/ppn1zGBdC1+93mYSeBzGN
	zTConJNhwabWVNWQVex2rld7JNeOkvn9vzKoaWHQ3pIkz7GPBLFMLsIJA
X-Received: by 2002:ac8:7f88:0:b0:50b:37ff:727e with SMTP id d75a77b69052e-50d62a95729mr48480101cf.44.1775222969005;
        Fri, 03 Apr 2026 06:29:29 -0700 (PDT)
X-Received: by 2002:ac8:7f88:0:b0:50b:37ff:727e with SMTP id d75a77b69052e-50d62a95729mr48479561cf.44.1775222968488;
        Fri, 03 Apr 2026 06:29:28 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d63962c30sm17886441cf.10.2026.04.03.06.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:29:27 -0700 (PDT)
Date: Fri, 3 Apr 2026 09:29:26 -0400
From: Brian Masney <bmasney@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] clk: mvebu: use kzalloc_flex
Message-ID: <ac_AtoG1j_I2m9Ja@redhat.com>
References: <20260402002011.89926-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260402002011.89926-1-rosenp@gmail.com>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fWNOkHlrq5Cseg7TfkjIfihRwtorZke_uHrTBXe7CPk_1775222969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rosen,

On Wed, Apr 01, 2026 at 05:20:11PM -0700, Rosen Penev wrote:
> Use a flexible array member to combine kzalloc and kcalloc in one
> allocation so they can be freed together.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment right after allocation as done by kzalloc_flex with GCC >=
> 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/clk/mvebu/common.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
> index 28f2e1b2a932..4129690fcae0 100644
> --- a/drivers/clk/mvebu/common.c
> +++ b/drivers/clk/mvebu/common.c
> @@ -189,10 +189,10 @@ DEFINE_SPINLOCK(ctrl_gating_lock);
>  
>  struct clk_gating_ctrl {
>  	spinlock_t *lock;
> -	struct clk **gates;
>  	int num_gates;
>  	void __iomem *base;
>  	u32 saved_reg;
> +	struct clk *gates[] __counted_by(num_gates);
>  };
>  
>  static struct clk_gating_ctrl *ctrl;
> @@ -257,24 +257,21 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
>  		clk_put(clk);
>  	}
>  
> -	ctrl = kzalloc_obj(*ctrl);
> +	/* Count, allocate, and register clock gates */
> +	for (n = 0; desc[n].name;)
> +		n++;
> +
> +	ctrl = kzalloc_flex(*ctrl, gates, n);
>  	if (WARN_ON(!ctrl))
>  		goto ctrl_out;
>  
> +	ctrl->num_gates = n;
> +
>  	/* lock must already be initialized */
>  	ctrl->lock = &ctrl_gating_lock;
>  
>  	ctrl->base = base;
>  
> -	/* Count, allocate, and register clock gates */
> -	for (n = 0; desc[n].name;)
> -		n++;
> -
> -	ctrl->num_gates = n;
> -	ctrl->gates = kzalloc_objs(*ctrl->gates, ctrl->num_gates);
> -	if (WARN_ON(!ctrl->gates))
> -		goto gates_out;

The gates_out label and kfree() needs to be removed.

Brian

> -
>  	for (n = 0; n < ctrl->num_gates; n++) {
>  		const char *parent =
>  			(desc[n].parent) ? desc[n].parent : default_parent;
> -- 
> 2.53.0
> 

