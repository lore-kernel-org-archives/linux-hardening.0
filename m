Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381103FFAAF
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825311; cv=none; b=PXVGh/yTgBaznxnsD3JYzFs7lyT/897AWxpl3ctLc7kZfvkRZFyMKD3PAt6pQhPysVyoTq35uV68F0xGJ68430Zi64Q47wOFOxgC5MFPBxRY/JTM4Ky7oYqnldOk5uv8CSqGhuqd8SJBTnF+KdCoEYGmqKSSGBDeV/MItAbiALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825311; c=relaxed/simple;
	bh=RAbE/qSDE3hsC38/B8lVHyLhIm2P0o2grNBnSkIL430=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLJyFbmu7NcJaFCm5mn2bha6eGCHfrJRZeVwBsl+XHWQXKMOearZAGJ1PQ9Ez6L61Z+IcUp3RNtE2I9NABhdEdg/lumKeVI/smT7YnG6pbPiLJ8a3wXAMgsSkPGTJyfbOrP9Rxt7unGCA1Sylp/2ztoO/4vsrm5c7v7pszRvKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dH8FEDR+; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dH8FEDR+"
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id yW0EvjeMsJ9SZyaqWvzIV3; Fri, 06 Mar 2026 19:28:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yaqVvcNG5PL32yaqWviINE; Fri, 06 Mar 2026 19:28:24 +0000
X-Authority-Analysis: v=2.4 cv=MqhS63ae c=1 sm=1 tr=0 ts=69ab2ad8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=pGLkceISAAAA:8
 a=mRCR8zNIrG22jyqt1SMA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qjqp+nzVkHY5IgyvI5b4YAv0FzCMSJoruY9g4RVtXLk=; b=dH8FEDR+0dFGLSuOOlBK3tq2AZ
	YmFQ8JxdWT6KjQcmWXkCY8wiP40rfVYI3Y2z+lYk/1ju7xQD8hMnrZcq7bW8k6Xc7JEJss+kJbSbN
	AAlCndnTO1ss5a7fTD15Ycd+GldybKPVNCwCbc+jOwznsF+a1JKTGfEHrOgeVLiYH2TNEWEJY95b3
	HS9fe77LTET6Be75UgbfEKLVINFSsxkXokN/m7rbZ4t3E6uOM4PtoizI0Jvv0SZ62a/htY4Ui0vPR
	4+cdKI1RzSOR41DdFckRUxrOWoe1JfKfYtUAXI1ZouKwAfjikmgo3pZ5on4Wwd6rFBP/s20Cfu1m/
	lwEQIERA==;
Received: from [177.238.16.13] (port=44592 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vyaqU-00000001RPb-39v6;
	Fri, 06 Mar 2026 13:28:23 -0600
Message-ID: <72e8b51c-4dcc-4c42-9e26-8ad8f9299c76@embeddedor.com>
Date: Fri, 6 Mar 2026 13:27:49 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: miphy28lp: kzalloc + kcalloc to single kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-phy@lists.infradead.org
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM/STI ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260304232848.469446-1-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260304232848.469446-1-rosenp@gmail.com>
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
X-Exim-ID: 1vyaqU-00000001RPb-39v6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:44592
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 33
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOMzyDQ8mZ+3m0ErJkvxmBJ42qIXg2L2FQPuALTKDTeTgHz2AFdXAkczEuCQBa+8ly8IbDRlVB/f4uHRAv1LvQ6WGC1lM13ig/Q4RyC+I+TlW71W67hz
 i/xwq19JQ07b4/jjPtxJmhy9sLMbvJDGvLcTmGrKhyE3kkdSCaeWPq94S2bjdvNe4Pf/2QXn51hPbKLEmlOPp56+Q0ngM/mvw84Nl/3o6eClx+7PnFCsm1C7



On 3/5/26 08:28, Rosen Penev wrote:
> Use flex array to simplify allocation.
> 
> Allows using __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/phy/st/phy-miphy28lp.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
> index 43cef89af55e..fd931ede7162 100644
> --- a/drivers/phy/st/phy-miphy28lp.c
> +++ b/drivers/phy/st/phy-miphy28lp.c
> @@ -224,8 +224,8 @@ struct miphy28lp_dev {
>   	struct device *dev;
>   	struct regmap *regmap;
>   	struct mutex miphy_mutex;
> -	struct miphy28lp_phy **phys;
>   	int nphys;
> +	struct miphy28lp_phy *phys[] __counted_by(nphys);
>   };
>   
>   enum miphy_sata_gen { SATA_GEN1, SATA_GEN2, SATA_GEN3 };
> @@ -1168,16 +1168,14 @@ static int miphy28lp_probe(struct platform_device *pdev)
>   	struct phy_provider *provider;
>   	struct phy *phy;
>   	int ret, port = 0;
> +	size_t nphys;
>   
> -	miphy_dev = devm_kzalloc(&pdev->dev, sizeof(*miphy_dev), GFP_KERNEL);
> +	nphys = of_get_child_count(np);
> +	miphy_dev = devm_kzalloc(&pdev->dev, struct_size(wiphy_dev, phys, nphys) ,TGFP_KERNEL);

This is bad... it looks like you didn't build any of these patches.

-Gustavo

>   	if (!miphy_dev)
>   		return -ENOMEM;
>   
> -	miphy_dev->nphys = of_get_child_count(np);
> -	miphy_dev->phys = devm_kcalloc(&pdev->dev, miphy_dev->nphys,
> -				       sizeof(*miphy_dev->phys), GFP_KERNEL);
> -	if (!miphy_dev->phys)
> -		return -ENOMEM;
> +	miphy_dev->nphys = nphys;
>   
>   	miphy_dev->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
>   	if (IS_ERR(miphy_dev->regmap)) {

