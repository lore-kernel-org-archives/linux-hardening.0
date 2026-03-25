Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC92F3C18;
	Wed, 25 Mar 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459659; cv=none; b=ZmRaWlAoJp0V7CtQeDr2Pi6jEelyZp36bBjSnoEGMDAjP1tgGkAC8bBtLTj2CeQt2NTY8UkZE/SYX29Srsz4/DlE3J/vGQxbaoCop5SXopLjYz1aqcbAjejQqHaOQny3mDVc5RQoW0uUfSmT2mn1hbl0JQ40qDy217YD7h71H3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459659; c=relaxed/simple;
	bh=8D0qiHwmmjHvb8SeystR2mv+/7nC+vaVWV+hwdICHhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhdsMDAHZKrhDLjjBGmsEFarUMdMdGeImZKUDcGhJlBMJkskaMR/iYTAFGVVc3mB+aNt9XrbuJVyf7Qf2YvmMY3c/4IjNi5wWtCdHviWIYO4347a/wQ9Og7efdcH4NqmuLavi6S88Yz8anxA7dE5w8J/iVNKJWO3AgnwtvxnK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UigdTlUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UigdTlUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D715C4CEF7;
	Wed, 25 Mar 2026 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774459659;
	bh=8D0qiHwmmjHvb8SeystR2mv+/7nC+vaVWV+hwdICHhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UigdTlUq3VTSBsrqrSgXiPV9LC26U4A0VXJnfPBeZglP1B/gsqdFO3yyOWT5iD0GD
	 TlI86425boz41sc1/yhKz0IUtuKlbqROJLW41cTfEjTgJlcSDUmDdHX4GexwdZCiOn
	 smC7vgtpPh3PTL+ldPYD9UUU6MWoaY14yqizZgtUgKVw+WM7aZzNVbmFwHb4Plh2ui
	 +SJhRQd+NdwRhGgofAUXAU7AIghSSQhNeLurTLSMTQkr8lnJ1ZIpe6aIJ2QIQmkhzY
	 3QrNTHXIYcYXiNRyBzmdhODrbvyF1Ie+9uFu5o03VUfCupBSmBu7Q6yMWzUlCQR+Dg
	 5Sq03GZmp1Mcw==
Date: Wed, 25 Mar 2026 17:27:34 +0000
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chas Williams <3chas3@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ATM" <linux-atm-general@lists.sourceforge.net>,
	"open list:ATM" <netdev@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] atm: nicstar: simplify allocation
Message-ID: <20260325172734.GA334461@horms.kernel.org>
References: <20260324032243.26387-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324032243.26387-1-rosenp@gmail.com>

On Mon, Mar 23, 2026 at 08:22:43PM -0700, Rosen Penev wrote:
> Use a flexible array member with kzalloc_flex to combine allocations
> into one.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment to right after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

To be honest I'd prefer that we discussed deprecating and removing ATM
rather than cleaning it up. Is anyone using it?

> ---
>  drivers/atm/nicstar.c | 17 +++++------------
>  drivers/atm/nicstar.h |  4 ++--
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
> index 24e51343df15..2f6a3637aeab 100644
> --- a/drivers/atm/nicstar.c
> +++ b/drivers/atm/nicstar.c
> @@ -867,23 +867,17 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
>  	if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
>  		return NULL;
>  
> -	scq = kmalloc_obj(*scq);
> +	scq = kmalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
>  	if (!scq)
>  		return NULL;
> -        scq->org = dma_alloc_coherent(&card->pcidev->dev,
> -				      2 * size,  &scq->dma, GFP_KERNEL);
> +
> +	scq->num_entries = size / NS_SCQE_SIZE;
> +
> +	scq->org = dma_alloc_coherent(&card->pcidev->dev, 2 * size, &scq->dma, GFP_KERNEL);
>  	if (!scq->org) {
>  		kfree(scq);
>  		return NULL;
>  	}
> -	scq->skb = kzalloc_objs(*scq->skb, size / NS_SCQE_SIZE);
> -	if (!scq->skb) {
> -		dma_free_coherent(&card->pcidev->dev,
> -				  2 * size, scq->org, scq->dma);
> -		kfree(scq);
> -		return NULL;
> -	}
> -	scq->num_entries = size / NS_SCQE_SIZE;

AI review points out that previously the skb array was zeroed on allocation,
which is relied on by the code. But that is no longer the case.

-- 
pw-bot: changes requested
