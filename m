Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEC13CFA3
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721171270; cv=none; b=OtELG9E9ZNgUhWWaSholCHzzNo26t2AMyIIUPKxTIxeABFpHcX3sDjcYPwdlZ64yHXAc5Vk4Gkf11yFj5w1bFKonu6UIRMfHG4GbHg/nV8ADLkcRSzGfwTIFcdaAVuC/AlVnREl8s9SxhkzvEeyYXSTHGTBrajm6HeQ8KByRGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721171270; c=relaxed/simple;
	bh=PgkJeXK711q9T5jHZ93Vvs5bA7ZheF6cfbiibchQyuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zy3qQR1+xUtQYz6T9dluw2sA7o1ZXt1Tzpib8rQ0fx+VXZWvzL3T0sWlEaK5uXRU6JJi6ioGp1aWalULE0B1hlu7Noa5Gh1fl44OBuK2bNIAqQAS7AkB3qbFHAFyAcRFleCf+vz4I1g7IPyacfSES4Xmlw4bBFrnyDoCy1snsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qfE6cpkz; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qfE6cpkz"
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id TnPBsqZB9iA19TrGtspc2q; Tue, 16 Jul 2024 23:07:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id TrGsshkNbO7CrTrGssmoqe; Tue, 16 Jul 2024 23:07:47 +0000
X-Authority-Analysis: v=2.4 cv=Pco0hThd c=1 sm=1 tr=0 ts=6696fd43
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=L4V35b6CUpzR6yRTVgwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xn9sRu2G2ukLaoOA+BdHT4+T5um7wUVenOr+ww+zBLM=; b=qfE6cpkzNJZF+EntMnHE4A70Q+
	3kriP5k/X5v2J9JCREmmF5KDWnYFhdk/+Y/7U25eQRymh1L2kaSpDqmqktcXXB8kZGiaak9WmSd63
	GakxxOs3bKWJ3u8fjT1x2iYiywsKIw3YiR0RLgrkiT1CG6lLvzqRcPp3wTGwWM7VDDH1JUWrPyA4R
	Q1QcXMzYO2tq7GkptCLhUQpgEVIbhqDTUzPRz2tQxgHUWoNIBzqovEAJtR4kXGyvI9NqztKSLvPD3
	FZBh1AktSu7LbwygnpXbpayTIveDyaFY1QCz5512A50gzxAfyS+OZylRD+8JvWEAVM1RrqjQGH9SV
	+Kb+25Ug==;
Received: from [201.172.173.139] (port=37628 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sTrGr-001eKJ-1e;
	Tue, 16 Jul 2024 18:07:45 -0500
Message-ID: <e6d67fca-55c0-4f16-8433-9328e928bbed@embeddedor.com>
Date: Tue, 16 Jul 2024 17:07:44 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Initialize sglen after
 allocation
To: Kees Cook <kees@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240716215702.work.802-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240716215702.work.802-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sTrGr-001eKJ-1e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:37628
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBBR9QnmAUX6o7ld68EGQdhGIdqk8JCmL3uU1KuVIfY9XKPwx7dXUoFtMUgu1QTBeDxTlpybe8KfSy6pvg6qlRC0tzq8UwpH8W1soxAz9PnA3ULkOUsy
 1xPuyXcltzSD9W4RmbuNHJHMpaCf8NRrCY0HDrY3uniO7IIqV4vB6a7d70fy47EjgwJRYwBzjqdY4xFZ8OkCLusf9fhbWIQxTh9QVN3arPOaw15BQeMVYqdf



On 16/07/24 15:57, Kees Cook wrote:
> With the new __counted_by annocation, the "sglen" struct member must
> be set before accessing the "sg" array. This initialization was done in
> other places where a new struct omap_desc is allocated, but these cases
> were missed. Set "sglen" after allocation.
> 
> Fixes: b85178611c11 ("dmaengine: ti: omap-dma: Annotate struct omap_desc with __counted_by")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> ---
>   drivers/dma/ti/omap-dma.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 7e6c04afbe89..6ab9bfbdc480 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1186,10 +1186,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
>   	d->dev_addr = dev_addr;
>   	d->fi = burst;
>   	d->es = es;
> +	d->sglen = 1;
>   	d->sg[0].addr = buf_addr;
>   	d->sg[0].en = period_len / es_bytes[es];
>   	d->sg[0].fn = buf_len / period_len;
> -	d->sglen = 1;
>   
>   	d->ccr = c->ccr;
>   	if (dir == DMA_DEV_TO_MEM)
> @@ -1258,10 +1258,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
>   	d->dev_addr = src;
>   	d->fi = 0;
>   	d->es = data_type;
> +	d->sglen = 1;
>   	d->sg[0].en = len / BIT(data_type);
>   	d->sg[0].fn = 1;
>   	d->sg[0].addr = dest;
> -	d->sglen = 1;
>   	d->ccr = c->ccr;
>   	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
>   
> @@ -1309,6 +1309,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
>   	if (data_type > CSDP_DATA_TYPE_32)
>   		data_type = CSDP_DATA_TYPE_32;
>   
> +	d->sglen = 1;
>   	sg = &d->sg[0];
>   	d->dir = DMA_MEM_TO_MEM;
>   	d->dev_addr = xt->src_start;
> @@ -1316,7 +1317,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
>   	sg->en = xt->sgl[0].size / BIT(data_type);
>   	sg->fn = xt->numf;
>   	sg->addr = xt->dst_start;
> -	d->sglen = 1;
>   	d->ccr = c->ccr;
>   
>   	src_icg = dmaengine_get_src_icg(xt, &xt->sgl[0]);
