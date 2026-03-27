Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705A31A56C;
	Fri, 27 Mar 2026 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611507; cv=none; b=iWdddXqJBGibw+OmcGFWEXI62BlwTEIDqSNCcuwooTDIvmRCCFatfZ6m8F3csMBVCN4wZh4fCjWLQv4JBej6Qniz5IL6qgKyITWaXTbP6wj0pM7gsvZKjT1nCmA4AP29QWe7OC1zCer5ibmNbVnqJvWfy39T3pbNPjRFBq3EYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611507; c=relaxed/simple;
	bh=rFxrfCUG8HWuOw4hfJtA6Lk5lYN4M9wjR1dICvHHwSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBDBT9y36+FoF1kehgC5k7hXsDwsE0VTtPeRUgSKB5MPivCl/yZHnWzHEipZga8v66MtiFpresyHrrrDVU9vTaICdBK7V1UnkRa+b9GifhwYlnFRotPlarum4XU+HInSX+1lHkRsvJjw2AJAXCT0rZehZjvbf7tR/YlXqWJiQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNbsNd1E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNbsNd1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1207C19423;
	Fri, 27 Mar 2026 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774611507;
	bh=rFxrfCUG8HWuOw4hfJtA6Lk5lYN4M9wjR1dICvHHwSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNbsNd1EOywV+PDMPEJgCsMxTqkk1leAx44TEdD25edN/nlR1bULuIiHJwxsFnuKK
	 6FJUZqtBb520eUTn2nDGeeD/TRZOwyhxIMlvGj3gl1NXqcdgiC9nfyHbxCynZhkYFC
	 QbC5jbBmr8EU7QT6A58fqwhdZUSO/e2OFa3+qQxeQ8sR1Db8D05UAH3+IiJUJ1IECv
	 73oEDPaoheN9R2nNGVy5Cp6jNyaWOxZb2jQeV09aWZ3Qf673bhfD7hHRhoF4Mx5sS+
	 sodjOVwOHQ3Df8Tk8VWwU0Ya6b5MPTj/HzLDY3jSAn9m5+AYirPf73Nn6RBJBNgsqp
	 tKB5F2Vo4FRMQ==
Date: Fri, 27 Mar 2026 11:38:23 +0000
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-atm-general@lists.sourceforge.net,
	Chas Williams <3chas3@gmail.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:ATM" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] atm: nicstar: simplify allocation
Message-ID: <20260327113823.GA580109@horms.kernel.org>
References: <20260326053539.336831-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326053539.336831-1-rosenp@gmail.com>

On Wed, Mar 25, 2026 at 10:35:39PM -0700, Rosen Penev wrote:
> Use a flexible array member with kzalloc_flex to combine allocations
> into one.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment to right after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: use kzalloc_flex
>  drivers/atm/nicstar.c | 17 +++++------------
>  drivers/atm/nicstar.h |  4 ++--
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
> index 24e51343df15..b01c6cfdcc87 100644
> --- a/drivers/atm/nicstar.c
> +++ b/drivers/atm/nicstar.c
> @@ -867,23 +867,17 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
>  	if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
>  		return NULL;
> 
> -	scq = kmalloc_obj(*scq);
> +	scq = kzalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
>  	if (!scq)
>  		return NULL;
> -        scq->org = dma_alloc_coherent(&card->pcidev->dev,
> -				      2 * size,  &scq->dma, GFP_KERNEL);
> +
> +	scq->num_entries = size / NS_SCQE_SIZE;
> +
> +	scq->org = dma_alloc_coherent(&card->pcidev->dev, 2 * size, &scq->dma, GFP_KERNEL);

Networking still prefers code that is 80 columns wide or less:

	scq->org = dma_alloc_coherent(&card->pcidev->dev,
				      2 * size, &scq->dma, GFP_KERNEL);

But maybe just leave this line as it was?

...

> diff --git a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
> index 1b7f1dfc1735..ba45be53d40e 100644
> --- a/drivers/atm/nicstar.h
> +++ b/drivers/atm/nicstar.h
> @@ -667,14 +667,14 @@ typedef struct scq_info {
>  	ns_scqe *next;
>  	volatile ns_scqe *tail;	/* Not related to the nicstar register */
>  	unsigned num_entries;
> -	struct sk_buff **skb;	/* Pointer to an array of pointers
> -				   to the sk_buffs used for tx */
>  	u32 scd;		/* SRAM address of the corresponding
>  				   SCD */
>  	int tbd_count;		/* Only meaningful on variable rate */
>  	wait_queue_head_t scqfull_waitq;
>  	volatile char full;	/* SCQ full indicator */
>  	spinlock_t lock;	/* SCQ spinlock */
> +	struct sk_buff *skb[] __counted_by(num_entries);	/* Pointer to an array of pointers
> +								   to the sk_buffs used for tx */

Likewise, 80 columns wide here too.

>  } scq_info;
> 
>  typedef struct rsq_info {

-- 
pw-bot: cr
