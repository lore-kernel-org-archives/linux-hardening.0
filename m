Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EF421880
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971271; cv=none; b=RBAhy1SajR0k8M8evpT27KP8u9ajRi4vQ5v63b0eNbiJBO/Q/kFBAi9SzhSl3x7BrjdXdqXaXwgaLhMZb5BfP6LJCFIcx1XqnR6U9scuF+c0Zr5Dbvg/matnPsWtLpFVB2S1E4ma+rYmbuXZvh+/kaawcdNBeAEvfPcztsOu93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971271; c=relaxed/simple;
	bh=mDgEr/ixLijAZanOerr9IGXX884q8KiAbK6fspfxvIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoL7aPtrKap8OLg5jXEzz0SqEuE2wvNOePx9hBJiodQ7ikqE6SUNutNnk6zAKUPkdhB16SY/4hFtEtjg6LSQi+qg4NMrxylGktTi3aBq+BzqQ3ix25VEzWzyHZYAM8rpP+LNaeZ3K0tZXjY4swNq30DGVTUiWiru4ci4vdUm/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=rXbLle0o; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="rXbLle0o"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id 7ZQJwZpaIc9KC7b6mwsfmN; Tue, 31 Mar 2026 15:34:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7b6lwXsrsOPYd7b6lwU69r; Tue, 31 Mar 2026 15:34:24 +0000
X-Authority-Analysis: v=2.4 cv=QbNmvtbv c=1 sm=1 tr=0 ts=69cbe980
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=pGLkceISAAAA:8 a=auZ1cPAoFAK5FwhZLi8A:9 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y4PSqneLUEeDkfVln3s0jyhbu/p+YZWIvMlwoMvls4c=; b=rXbLle0oz15n47ZuK/Ep5LfG1u
	dcboqrirz2TozQ3a+ojvSI9eh6MqLSjy7+4Dv7lsJ8grfQN7dTya4KV0ILn5RR3LntJxTD7UnGnep
	1rAK/+57tP3dzCy5aSP7c67m3lWKb4B5F1bnOuT2oa+IVw5YVBspbb1BU+kumQo9F/LlIyNjuiimx
	j5PYOZP0EtaH6ZcXipf9KnjssRO9+oQR+fdHQqGo/xwTgFX1YZTO+zmR5zUBBelnmvG42wphe/MYI
	C2bY4coCqRTAR/hdEY2sjFRAf3eUtgtPMQHBxU6sd5JuYcMmknmAZUwu9MY+4dtq8hBqNKCcysg+Y
	GyftIu2w==;
Received: from [177.238.16.13] (port=53228 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w7b6k-00000002IL2-1iz2;
	Tue, 31 Mar 2026 10:34:23 -0500
Message-ID: <5977a259-a7ae-43be-ad09-d09115268854@embeddedor.com>
Date: Tue, 31 Mar 2026 09:33:13 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: st_fdma: simplify allocation
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM/STI ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260330211555.13974-1-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260330211555.13974-1-rosenp@gmail.com>
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
X-Exim-ID: 1w7b6k-00000002IL2-1iz2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:53228
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDpC/1xcYvaV/fNKIeTyGfES5JZsu9UjuBbaLuIPBKKtqcSu40O/yOWaeazoHGFUC2E49/KhU41zpDAsOOxbAe99ooDykqqsJq4Q5XRhbSRf0LC4kg1j
 SS88ygX37GFizYNdc78sdLpfLH+z47jJDpHdaIeSyMT4I9qvXrclIkg5650HTO9g7crFBs1eE0uOpgjokqwfz18w0WapPUZwiVwBXP0V8zPdAPmAr3mgRLiU



On 3/30/26 15:15, Rosen Penev wrote:
> Use a flexible array member to combine kzalloc and kcalloc to a single
> allocation.
> 
> Add __counted_by for extra runtime analysis. 

Assign counting variable
> after allocation as required by __counted_by.

This is misinformation and should be phrased differently[1]

-Gustavo

[1] https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com/

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/dma/st_fdma.c | 27 ++++++++-------------------
>   drivers/dma/st_fdma.h |  4 ++--
>   2 files changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
> index d9547017f3bd..3ec0d6731b8d 100644
> --- a/drivers/dma/st_fdma.c
> +++ b/drivers/dma/st_fdma.c
> @@ -710,16 +710,6 @@ static const struct of_device_id st_fdma_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, st_fdma_match);
>   
> -static int st_fdma_parse_dt(struct platform_device *pdev,
> -			const struct st_fdma_driverdata *drvdata,
> -			struct st_fdma_dev *fdev)
> -{
> -	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf",
> -		drvdata->name, drvdata->id);
> -
> -	return of_property_read_u32(pdev->dev.of_node, "dma-channels",
> -				    &fdev->nr_channels);
> -}
>   #define FDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
>   				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
>   				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
> @@ -742,27 +732,26 @@ static int st_fdma_probe(struct platform_device *pdev)
>   	struct st_fdma_dev *fdev;
>   	struct device_node *np = pdev->dev.of_node;
>   	const struct st_fdma_driverdata *drvdata;
> +	u32 nr_channels;
>   	int ret, i;
>   
>   	drvdata = device_get_match_data(&pdev->dev);
>   
> -	fdev = devm_kzalloc(&pdev->dev, sizeof(*fdev), GFP_KERNEL);
> -	if (!fdev)
> -		return -ENOMEM;
> -
> -	ret = st_fdma_parse_dt(pdev, drvdata, fdev);
> +	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels", &nr_channels);
>   	if (ret) {
>   		dev_err(&pdev->dev, "unable to find platform data\n");
> -		goto err;
> +		return ret;
>   	}
>   
> -	fdev->chans = devm_kcalloc(&pdev->dev, fdev->nr_channels,
> -				   sizeof(struct st_fdma_chan), GFP_KERNEL);
> -	if (!fdev->chans)
> +	fdev = devm_kzalloc(&pdev->dev, struct_size(fdev, chans, nr_channels), GFP_KERNEL);
> +	if (!fdev)
>   		return -ENOMEM;
>   
> +	fdev->nr_channels = nr_channels;
>   	fdev->dev = &pdev->dev;
>   	fdev->drvdata = drvdata;
> +	snprintf(fdev->fw_name, FW_NAME_SIZE, "fdma_%s_%d.elf", drvdata->name, drvdata->id);
> +
>   	platform_set_drvdata(pdev, fdev);
>   
>   	fdev->irq = platform_get_irq(pdev, 0);
> diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
> index f1e746f7bc7d..27ded555879f 100644
> --- a/drivers/dma/st_fdma.h
> +++ b/drivers/dma/st_fdma.h
> @@ -136,13 +136,13 @@ struct st_fdma_dev {
>   
>   	int irq;
>   
> -	struct st_fdma_chan *chans;
> -
>   	spinlock_t dreq_lock;
>   	unsigned long dreq_mask;
>   
>   	u32 nr_channels;
>   	char fw_name[FW_NAME_SIZE];
> +
> +	struct st_fdma_chan chans[] __counted_by(nr_channels);
>   };
>   
>   /* Peripheral Registers*/

