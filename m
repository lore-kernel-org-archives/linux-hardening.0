Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC213D63D
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166659; cv=none; b=UJA/2qdZFfaCHaw2ntmt26tvSlw7SbQaDBlQt+w6L7gaf4jfr/R8BjSB6kAnv8XZGvqZotUAc3U/vLP3emWkQOXaqWgvnajUmU9BPJz8ZxG51lro0ab2djPOTW8VJz7F1DIoLjcIZ7nKVHP4XjIGNYrqKdT33ZEZbsVeUYClnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166659; c=relaxed/simple;
	bh=7+bLyyIzjcCJX8P+DeTmSz/bfqrHBTbtFoh5Qa44mLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSUy+mgC6GcaSJFNVY+spKrq9MpmEpaFcMbV1c61lZZm7f/HI7gtsiyR76iSj31dGlT+BLeHiJ51wxBTrv1ySSNmdcFfgXh7/yWwsBLXngQITwntoDtbq9D6mEP5Fu93cOmTFLfWDy33PdXqB9A03nm+vi6rJyhN4CxXZmFe83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=nWWw3AsN; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="nWWw3AsN"
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id TSyIsv3tIumtXTq4Ssogxj; Tue, 16 Jul 2024 21:50:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Tq4RsemT6Tt82Tq4Rs2UPX; Tue, 16 Jul 2024 21:50:51 +0000
X-Authority-Analysis: v=2.4 cv=R7oFG8RX c=1 sm=1 tr=0 ts=6696eb3b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=pGLkceISAAAA:8 a=phlkwaE_AAAA:8 a=JfrnYn6hAAAA:8 a=JL3bU382AdGQ-euulaEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=uKTQOUHymn4LaG7oTSIC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3mp/A7TaFk3Rm+5hz/oA89u2tO8OZ6IeOjXYptKzMt8=; b=nWWw3AsNeT8xCnxDTnHxVfhfKi
	uAZrezVdeRZRnDJ3QNYxxUKbK9ZqCtU1NMBi4JruljXXz/eeQAJscchCGSUfhUte2rhY0iDjUyOvS
	54CaQEsRO/6vxDZoICqMWqgRTqoi5oDJaHPYLYEPsB1ZLhTmq8/jCkUBURoVXf7VuWPzGA47EEOPd
	56mYqCxjpYKFlfIhwU9nAqiR6HLg4u0g8ersIZxfPBp7fykgdKOdkr+cowP+1JXUJmfqqeADqQSvy
	PnrzqG07TqDqTq0wITNuK6WA38iqgmnuXmMc7OzPNY+N7MN7pFq8X8lVkfYqCYcL9tZfXFF/a9CSd
	2i5ksAvA==;
Received: from [201.172.173.139] (port=56504 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sTq4P-000Te1-2I;
	Tue, 16 Jul 2024 16:50:49 -0500
Message-ID: <d1a9d59f-00cc-4878-9cf4-eb58e9dd1562@embeddedor.com>
Date: Tue, 16 Jul 2024 15:50:48 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: stm32-dma3: Set lli_size after allocation
To: Kees Cook <kees@kernel.org>, =?UTF-8?Q?Am=C3=A9lie_Delaunay?=
 <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, dmaengine@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240716213830.work.951-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240716213830.work.951-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sTq4P-000Te1-2I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:56504
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLgtUgHW/bzuTMfQzCEoZqZXmSFt5RSgsAIE+ZuyK+Y9kIM6BCThdWpk4Q92cg8HDm7XNsG2D24Elw/R5zAN08WAYCyP2r4BDcAnjOxIK+jK1eE8gLaQ
 vIMw9lShFDh5uopUqgzlZlNdlm16Iz5N+qFq2gLp84RbRrywEGyuxu2+RNHgELXxEoceKXoO4Zh7dnasWz9ATFqlvBToAr0SF5/9UDgD/UXm+SIwbCvnduZk



On 16/07/24 15:38, Kees Cook wrote:
> With the new __counted_by annotation, the "lli_size" variable needs to
> valid for accesses to the "lli" array. This requirement is not met in
> stm32_dma3_chan_desc_alloc(), since "lli_size" starts at "0", so "lli"
> index "0" will not be considered valid during the initialization for loop.
> 
> Fix this by setting lli_size immediately after allocation (similar to
> how this is handled in stm32_mdma_alloc_desc() for the node/count
> relationship).
> 
> Fixes: f561ec8b2b33 ("dmaengine: Add STM32 DMA3 support")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: "Amélie Delaunay" <amelie.delaunay@foss.st.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/dma/stm32/stm32-dma3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 4087e0263a48..0be6e944df6f 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -403,6 +403,7 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
>   	swdesc = kzalloc(struct_size(swdesc, lli, count), GFP_NOWAIT);
>   	if (!swdesc)
>   		return NULL;
> +	swdesc->lli_size = count;
>   
>   	for (i = 0; i < count; i++) {
>   		swdesc->lli[i].hwdesc = dma_pool_zalloc(chan->lli_pool, GFP_NOWAIT,
> @@ -410,7 +411,6 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
>   		if (!swdesc->lli[i].hwdesc)
>   			goto err_pool_free;
>   	}
> -	swdesc->lli_size = count;
>   	swdesc->ccr = 0;
>   
>   	/* Set LL base address */
