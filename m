Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA012B17C
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166616; cv=none; b=a6aq5jRPFaHRftVAepYU3HZtILCvNLp8Bg3XS6ujw4GF5w9sOh4o1LOPS22hkBGeBvSzlYt/oLgmUuBS688TcADIUVCGRMIU6HPybuGU21qmJ9KX1K188ZSX4/3dwy4NgIDgeYYxQ03fmXp2SEG45Z4jND1jAGdV/PEXE7fjmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166616; c=relaxed/simple;
	bh=ES+1TDr/sbNTkoVacm/sCF6i8CHyawoo3YvHc5C4Ows=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7yweGABP5A85L/fz95vISVIivkH99Lph7IsLE8wigDO+E/rhYMl53v+Svil1G+Y3moQA/tkcce/bgp58eV44Dfd3Fmwpuqo8DP5tejq2w4G4bT13oWMRfQPq1pTEfvn0liBDwO63NQkbY+qNj8WME9XGak2kxRfzUBeEM9ygsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=zqPLkAU3; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="zqPLkAU3"
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id TgD2sWg1HVpzpTq3ksKOEq; Tue, 16 Jul 2024 21:50:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Tq3isrmQjVDZXTq3jsi5Ge; Tue, 16 Jul 2024 21:50:07 +0000
X-Authority-Analysis: v=2.4 cv=JJ89sdKb c=1 sm=1 tr=0 ts=6696eb0f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=FHQ-AbbR0piQ7ekRdqQA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=La4xFbJIpCI1JgV/wHqNQudSRHkW2nTQqdjuDd6IA/w=; b=zqPLkAU3t9u9XsrSNyZKZz/tVG
	IeEQSuJytO+sGNAU3SakYdFNAR95cE2bPTfSOXDc6lkj0r/dX7quGkXvTHkuNDP+FT8AmNPredfLq
	ZVUOXc3XjEgkPGWtgpb87lHVqn93xJIEhlqkOd3ZnsoxEAIi4ubrxUbLrrOX8sh3i33IM/Ztd4eMG
	BYXiSbGYqJ0jXw++eEPHBQy26vZTQpQnfFJRUMCszhc7Nj+7f/d1sIQd/l8+C3WCDxIn3OOKfcQ3s
	+e/RpuyDMZETjkovbraP33+Gau6TTZ34wfmUXA4mIeXQiPozlPac2l8QIIRhGHuGu+lQ9uDEmQrka
	I/4AnLFQ==;
Received: from [201.172.173.139] (port=48410 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sTq3h-000T4q-2W;
	Tue, 16 Jul 2024 16:50:05 -0500
Message-ID: <c16715ff-1e47-4a73-8fcb-87462069b5ca@embeddedor.com>
Date: Tue, 16 Jul 2024 15:50:04 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: gpio: Set num_leds after allocation
To: Kees Cook <kees@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240716212455.work.809-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240716212455.work.809-kees@kernel.org>
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
X-Exim-ID: 1sTq3h-000T4q-2W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.139]:48410
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCCCfnkIsGs/zTqS12j0siJS/ofvvdqVLtYLn1Bw4nDBBgh7LYnvMgTXFvq+2ZBVEgtRKiP68bxwqTS5AQIPlW71M7UFteICpQycETLZi2YN21L0xuSm
 pnsLyiOMZhoH5GR4rt+rOe/B1wpB1Kti5jyRqf40t9oA1duYXt7IY0WpU/WCtdJam654Hr3fgMA5BuT8cD7HTpRQQbaEpam2i3eY8C12ZnkwoLkqI6P9NUgH



On 16/07/24 15:24, Kees Cook wrote:
> With the new __counted_by annotation, the "num_leds" variable needs to
> valid for accesses to the "leds" array. This requirement is not met in
> gpio_leds_create(), since "num_leds" starts at "0", so "leds" index "0"
> will not be considered valid (num_leds would need to be "1" to access
> index "0").
> 
> Fix this by setting the allocation size after allocation, and then update
> the final count based on how many were actually added to the array.
> 
> Fixes: 52cd75108a42 ("leds: gpio: Annotate struct gpio_leds_priv with __counted_by")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: Lee Jones <lee@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-leds@vger.kernel.org
> ---
>   drivers/leds/leds-gpio.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index 83fcd7b6afff..4d1612d557c8 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -150,7 +150,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
>   {
>   	struct fwnode_handle *child;
>   	struct gpio_leds_priv *priv;
> -	int count, ret;
> +	int count, used, ret;
>   
>   	count = device_get_child_node_count(dev);
>   	if (!count)
> @@ -159,9 +159,11 @@ static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
>   	priv = devm_kzalloc(dev, struct_size(priv, leds, count), GFP_KERNEL);
>   	if (!priv)
>   		return ERR_PTR(-ENOMEM);
> +	priv->num_leds = count;
> +	used = 0;
>   
>   	device_for_each_child_node(dev, child) {
> -		struct gpio_led_data *led_dat = &priv->leds[priv->num_leds];
> +		struct gpio_led_data *led_dat = &priv->leds[used];
>   		struct gpio_led led = {};
>   
>   		/*
> @@ -197,8 +199,9 @@ static struct gpio_leds_priv *gpio_leds_create(struct device *dev)
>   		/* Set gpiod label to match the corresponding LED name. */
>   		gpiod_set_consumer_name(led_dat->gpiod,
>   					led_dat->cdev.dev->kobj.name);
> -		priv->num_leds++;
> +		used++;
>   	}
> +	priv->num_leds = used;
>   
>   	return priv;
>   }
