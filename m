Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6B41C2EB
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971387; cv=none; b=IdpPnlCwEWzKuooA/QkndnrnTPEQNKxp8O/LQj0j9l88qcLJH33Zu/YmgdIPhqbSRIlPo8EIP4BB79jdRzYVFBdNOF9sPSkMc3VEdU8y1y2DaJV0RJPQvcppxcBxWL0qbWxwus0B3Jh76QH9n8C4nxbX6EcFzYiJt54oK32Cm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971387; c=relaxed/simple;
	bh=g1etV1cSaF1CLKLwroH2Otgkb2vKs+5Py45hjgAK/o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UX7cXpUoi19Sb2Wg3p3lxszZb1skipV+NmBisk/SuRPf+7OIu80vHodvXmcJw0cE7PHnVqd50ffOSHN9tNWXAM++0Fc2aRgVHCEZzKSEzGjXDi0nAuHrkritgBRtSdZ/izH/ochwfiw90J2hCKfwLvUeHKU8GC2KqkxrLVk/onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=iowfm5iF; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="iowfm5iF"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id 7aaXwzS3Kjw8Y7b8kw6WEK; Tue, 31 Mar 2026 15:36:26 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7b8hw9VdiHtqh7b8hwsJNh; Tue, 31 Mar 2026 15:36:23 +0000
X-Authority-Analysis: v=2.4 cv=AtXu3P9P c=1 sm=1 tr=0 ts=69cbe9fa
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=pGLkceISAAAA:8 a=cTJmZftdM5iI3n9nPlYA:9 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gPSiibnnkaj7DpyikZYTE/USxJvNbpGxOj64z/kQRZk=; b=iowfm5iFnDEeJ1Hpg3V8sI41Jc
	ZHrY11TWLlbsmX1yWaZ1D3OG42uvidLzJ825vTHKDil6WOmGmdVoVK9gswamXg/I6uW+a5fjtjnv/
	WhirNst8ZDoSenFXVfn6EQ0ONZEnG1pr+A79EPa0wt8QkXKS5gIGYF5juC4pbyQ0NPp9XR9u80u9K
	5sf90N/08DwvypFEphRvRIw4++M2KkOxHooWHLCJyF0d9IX4cTo46Qrcq+liUU+lW7+fUdzju0ZJL
	LwPSQIGS2ZjFTvN1cc7GSEC3PpiU+BstMBiBWDZi1p2zADlXUrgaBMT1vtk5Y8vyTSpO0dqzQLfWM
	o6m/Sz7A==;
Received: from [177.238.16.13] (port=60182 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w7b8g-00000002Jss-1lMG;
	Tue, 31 Mar 2026 10:36:23 -0500
Message-ID: <ddb5961b-02f9-4956-b618-31aab836fce7@embeddedor.com>
Date: Tue, 31 Mar 2026 09:35:14 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] atm: nicstar: simplify allocation
To: Rosen Penev <rosenp@gmail.com>, linux-atm-general@lists.sourceforge.net
Cc: Chas Williams <3chas3@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:ATM" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260327192407.365369-1-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260327192407.365369-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w7b8g-00000002Jss-1lMG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:60182
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 41
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJm2mrZJrt8DtqcLhZN3ew6qLXNCa9y6okwdfsRyLbXjAT4FoU4sgAWQo1WlXVb2Sgx0GjAWp2bw3n0UqyiZGxRfxLmZh29pF3/T6cM0f8F5dQzByWc1
 lvzL2xkl/+0u0q3o/ckUX2qdRRjueBBtKS6KZ46Q/oa4xtfxNiDPbrqX7A+1SXwbSSg1j7lBY3XRgw2hS8nuZ4yfvvrlluZgeVixGZ+j7rJ8x65256mbulDn



On 3/27/26 13:24, Rosen Penev wrote:
> Use a flexible array member with kzalloc_flex to combine allocations
> into one.
> 
> Add __counted_by for extra runtime analysis. 

Move counting variable
> assignment to right after allocation as required by __counted_by.

This is misinformation and should be phrased differently[1]

-Gustavo

[1] https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com/

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v3: reduce to 80 columns
>   v2: use kzalloc_flex
>   drivers/atm/nicstar.c | 18 ++++++------------
>   drivers/atm/nicstar.h |  5 +++--
>   2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
> index 24e51343df15..c0bed85daf96 100644
> --- a/drivers/atm/nicstar.c
> +++ b/drivers/atm/nicstar.c
> @@ -867,23 +867,18 @@ static scq_info *get_scq(ns_dev *card, int size, u32 scd)
>   	if (size != VBR_SCQSIZE && size != CBR_SCQSIZE)
>   		return NULL;
> 
> -	scq = kmalloc_obj(*scq);
> +	scq = kzalloc_flex(*scq, skb, size / NS_SCQE_SIZE);
>   	if (!scq)
>   		return NULL;
> -        scq->org = dma_alloc_coherent(&card->pcidev->dev,
> -				      2 * size,  &scq->dma, GFP_KERNEL);
> +
> +	scq->num_entries = size / NS_SCQE_SIZE;
> +
> +	scq->org = dma_alloc_coherent(&card->pcidev->dev, 2 * size, &scq->dma,
> +				      GFP_KERNEL);
>   	if (!scq->org) {
>   		kfree(scq);
>   		return NULL;
>   	}
> -	scq->skb = kzalloc_objs(*scq->skb, size / NS_SCQE_SIZE);
> -	if (!scq->skb) {
> -		dma_free_coherent(&card->pcidev->dev,
> -				  2 * size, scq->org, scq->dma);
> -		kfree(scq);
> -		return NULL;
> -	}
> -	scq->num_entries = size / NS_SCQE_SIZE;
>   	scq->base = PTR_ALIGN(scq->org, size);
>   	scq->next = scq->base;
>   	scq->last = scq->base + (scq->num_entries - 1);
> @@ -928,7 +923,6 @@ static void free_scq(ns_dev *card, scq_info *scq, struct atm_vcc *vcc)
>   				}
>   			}
>   	}
> -	kfree(scq->skb);
>   	dma_free_coherent(&card->pcidev->dev,
>   			  2 * (scq->num_entries == VBR_SCQ_NUM_ENTRIES ?
>   			       VBR_SCQSIZE : CBR_SCQSIZE),
> diff --git a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
> index 1b7f1dfc1735..76635d46016e 100644
> --- a/drivers/atm/nicstar.h
> +++ b/drivers/atm/nicstar.h
> @@ -667,14 +667,15 @@ typedef struct scq_info {
>   	ns_scqe *next;
>   	volatile ns_scqe *tail;	/* Not related to the nicstar register */
>   	unsigned num_entries;
> -	struct sk_buff **skb;	/* Pointer to an array of pointers
> -				   to the sk_buffs used for tx */
>   	u32 scd;		/* SRAM address of the corresponding
>   				   SCD */
>   	int tbd_count;		/* Only meaningful on variable rate */
>   	wait_queue_head_t scqfull_waitq;
>   	volatile char full;	/* SCQ full indicator */
>   	spinlock_t lock;	/* SCQ spinlock */
> +	struct sk_buff *skb[] __counted_by(num_entries);
> +	/* Pointer to an array of pointers
> +	   to the sk_buffs used for tx */
>   } scq_info;
> 
>   typedef struct rsq_info {
> --
> 2.53.0
> 
> 

