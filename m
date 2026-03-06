Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEB3D34AD
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824459; cv=none; b=Zw8ispJcsOUtA+3W5jMRd3UsV+aV/OwNpJtdjVrEVYqLRweqjd9NbxBULUWAiHWGJJ9+ustfvK/JgrwoXUGD8IQd7R8tRdFJHyEQlZHm9eg2bucGYA/96eLZxIPDzgWS3VktWNsl4KDJeCEcrMe9KiLdzDVGdgYnADRCaQqcet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824459; c=relaxed/simple;
	bh=IDhr2Ebb2b2qZTLe5TRuCnNBOYcnVLmyAusvRz/t6es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQnssOKPnTugH0/jd9G7ijJafkL/4Pxsv1tuoVnJ+ZxgZXrNqFS7CKwRum2rzjomtYZeEI47PBs+GjS2MIdOHIt2EAH5eTrcvc7xX/KtVnEOzt1zKQZpAyJhVPMLWM5liGHdaQ8qrCpWvXrwcfm0omqfrzItsAiSQ8W8HtEvAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=tscGF14g; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tscGF14g"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id yXucv2iHyCxrGyacrvx5YG; Fri, 06 Mar 2026 19:14:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yacpvGV7N2l0kyacpvIciE; Fri, 06 Mar 2026 19:14:16 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=69ab2789
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=4KyMBbRfhRQTWuXm2KoA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UX70eqTPldRVlnp6TbQSbemdGWZN5RJN1ptIeYYKtG8=; b=tscGF14g6RrBEKmnC12nH+q23r
	Saqh4tVvRYVfYwGG4W9VhMRiHBWi0hqEEUGmgZC8Ukq0nxhBVO+eQTUWRCYyOkOkzBY86UKY7JmcT
	xeYajce0NP1LNBRReeW4AOK+oU5cHpOHowWYex2w0ckcKWT7blQZrrp2Sd7VuTPXM6/TKUcqvzsXG
	9GT/bFcd2K8QFTC86ivNaAq+YrQrK2bZxAuXgqZQx+r/iSx35D+TU2Wur7+pnN99AWbYsBnUN9E8j
	71MyrgfhpLgiq+QMZaG8wU73aJmO8mSCyREaynLGLrekKMTE6Ce01pPEMXZxukz7m4imiwkcpTuio
	Y5vRmDcA==;
Received: from [177.238.16.13] (port=46342 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vyacn-000000018a0-0TQQ;
	Fri, 06 Mar 2026 13:14:13 -0600
Message-ID: <1b50b40e-6682-4156-a60a-c2725527d648@embeddedor.com>
Date: Fri, 6 Mar 2026 13:13:43 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: mediatek: xsphy: reduce main allocation
To: Rosen Penev <rosenp@gmail.com>, linux-phy@lists.infradead.org
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM/Mediatek USB3 PHY DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek USB3 PHY DRIVER"
 <linux-mediatek@lists.infradead.org>,
 "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260304043420.14151-1-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260304043420.14151-1-rosenp@gmail.com>
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
X-Exim-ID: 1vyacn-000000018a0-0TQQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:46342
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOQmRHWPvHMGQPiQwl/RPlv+iWb1I3ejiQTpMZomPVQLI5YlXSQ3015GWYesUfPB7mt9NOdmytfN7Wp9cpRg5o6cIblW2Z7P4ZFnxIObcOakeWv90UdG
 h1H5v6xs3AN/nlwODnbNEaQfetV6EBMyIsqTpF1YsRjNZi99eeVURo6V9XqjrN3eq/iKeWLTXTl/letS4G+M9Yy5J9Ufa/7wnQP/BONPgG08agGTGDYcrcls



On 3/4/26 13:34, Rosen Penev wrote:
> Instead of kzalloc and kcalloc, we can use a flex array to reduce to a
> single allocation.
> 
> Also added __counted_by() for extra possible analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   drivers/phy/mediatek/phy-mtk-xsphy.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
> index c0ddb9273cc3..cc1d66954212 100644
> --- a/drivers/phy/mediatek/phy-mtk-xsphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-xsphy.c
> @@ -112,10 +112,10 @@ struct xsphy_instance {
>   struct mtk_xsphy {
>   	struct device *dev;
>   	void __iomem *glb_base;	/* only shared u3 sif */
> -	struct xsphy_instance **phys;
> -	int nphys;
>   	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
>   	int src_coef;    /* coefficient for slew rate calibrate */
> +	int nphys;
> +	struct xsphy_instance *phys[] __counted_by(nphys);
>   };
>   
>   static void u2_phy_slew_rate_calibrate(struct mtk_xsphy *xsphy,
> @@ -515,18 +515,15 @@ static int mtk_xsphy_probe(struct platform_device *pdev)
>   	struct resource *glb_res;
>   	struct mtk_xsphy *xsphy;
>   	struct resource res;
> +	size_t nphys;
>   	int port;
>   
> -	xsphy = devm_kzalloc(dev, sizeof(*xsphy), GFP_KERNEL);
> +	nphys = of_get_child_count(np);
> +	xsphy = devm_kzalloc(dev, struct_size(xsphy, phys, nphys), GFP_KERNEL);
>   	if (!xsphy)
>   		return -ENOMEM;
>   
> -	xsphy->nphys = of_get_child_count(np);
> -	xsphy->phys = devm_kcalloc(dev, xsphy->nphys,
> -				       sizeof(*xsphy->phys), GFP_KERNEL);
> -	if (!xsphy->phys)
> -		return -ENOMEM;
> -
> +	xsphy->nphys = nphys;
>   	xsphy->dev = dev;
>   	platform_set_drvdata(pdev, xsphy);
>   

