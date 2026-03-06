Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F15371CE2
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824233; cv=none; b=kwBMuZ+K1OrPlLN6drQNW654k/O8FLwR3TZ+h6ZW64J6bxhyNdtwB5Vt/9HaNNuc1cPn+j28sUf18zURKpaPi2rG5uXEWscJYqYwe/Q5TU2JAhw1TUVu+JxdQPqlKRnYh4QGNoBPzvc3vVDozmeWT7aUzyCdi6EAhf2a0hkNEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824233; c=relaxed/simple;
	bh=EvLAbBJDiD/n1DJ8+nYOK8OWTOwbGeEvKzgqWoKkX/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYc0hBGx2GpdRj92m7eXyfiemR2hbQ0GZMADotRNIM9OotdWRnaQNZeo100gwynlJDlZ/LAtetARhis+Ehp5b4Hq9j0m0gKs1o5k25+MAmKE8DjgnC8UlLxozDFeT4cj+No9XvAKHs9gyVuRJQaB4nODrwRm5lATh2VvLYPzkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=my6AsidB; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="my6AsidB"
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id yZF7vRZlbaPqLyaXgvC6Ix; Fri, 06 Mar 2026 19:08:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id yaXYvgz9lK8vzyaXYvlczg; Fri, 06 Mar 2026 19:08:49 +0000
X-Authority-Analysis: v=2.4 cv=cJDgskeN c=1 sm=1 tr=0 ts=69ab2647
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=0yR4CDxtN3si-e87978A:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H9EbkxOhimqfk3l0qwEGtPXK1UaquMIBZmS0s0qP6OI=; b=my6AsidB7LeVirLGay0lpPNp2o
	znIOXq53VwKjX4WiX9lbvWHiXRIvPhwh+kCmFh776QSqapB+/lxWyMTUotyobpqJ6FxCM4x01azfb
	ci1lFQfFhgrM0c4o8QttFoRRg05Xme1HmTmacHtz1Qw6TmIGFXP5fo8Sscqx3+KIh4EJpzVTn+7nF
	0McGYwFiNcSH+KPh+bCsXcUW9PBogQNug1JWioHcIPuuEitgv0X68Hy+HPy8rZzo3OJYtjuodU/2d
	6sX0WV5R211/9P1RyhYivG1OoP4T+LEV1OzmoTp2T3LswLDJsiDkMjwe5reIkD1+dnim5A7IJgYkI
	HoJVMD5Q==;
Received: from [177.238.16.13] (port=37112 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vyaXX-00000001137-1zAG;
	Fri, 06 Mar 2026 13:08:48 -0600
Message-ID: <9555e8df-5455-418a-b93f-2693aa19b849@embeddedor.com>
Date: Fri, 6 Mar 2026 13:08:14 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk-lpc18xx-ccu: kzalloc + kcalloc to kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "moderated list:ARM/LPC18XX ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260306032540.47815-1-rosenp@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260306032540.47815-1-rosenp@gmail.com>
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
X-Exim-ID: 1vyaXX-00000001137-1zAG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:37112
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKftRAxrnK88dfzkXd7m7VFnauUWAi+8WXd9WYDNEyFEuzKukCFdlQPRSh2eE37/eZ0UVBaINkRXAlrnPmcZAjOiDO5i/Haf6vlLsLXk9eP+Xr4uAzvw
 d/ZRhTdwQQTWl/OxRwLPHpL6NlsfolaKqfT1XwKCV+T6Q4vMvFqhKFxBpgL0wvKCTSX4MA1MWNeRA0Q6Ebv849DX0wQvrdGzNgjL2AIxGM8mNrqp8NvTt7wJ



On 3/6/26 12:25, Rosen Penev wrote:
> Simplifies allocation by using a flexible array member.
> 
> Also allows using __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   drivers/clk/nxp/clk-lpc18xx-ccu.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/nxp/clk-lpc18xx-ccu.c b/drivers/clk/nxp/clk-lpc18xx-ccu.c
> index dcb6d0c0b41a..3793e701835f 100644
> --- a/drivers/clk/nxp/clk-lpc18xx-ccu.c
> +++ b/drivers/clk/nxp/clk-lpc18xx-ccu.c
> @@ -27,8 +27,8 @@
>   #define CCU_BRANCH_HAVE_DIV2	BIT(1)
>   
>   struct lpc18xx_branch_clk_data {
> -	const char **name;
>   	int num;
> +	const char *name[] __counted_by(num);
>   };
>   
>   struct lpc18xx_clk_branch {
> @@ -266,6 +266,7 @@ static void __init lpc18xx_ccu_init(struct device_node *np)
>   {
>   	struct lpc18xx_branch_clk_data *clk_data;
>   	void __iomem *reg_base;
> +	size_t size;
>   	int i, ret;
>   
>   	reg_base = of_iomap(np, 0);
> @@ -274,19 +275,14 @@ static void __init lpc18xx_ccu_init(struct device_node *np)
>   		return;
>   	}
>   
> -	clk_data = kzalloc_obj(*clk_data);
> +	size = of_property_count_strings(np, "clock-names");
> +	clk_data = kzalloc_flex(*clk_data, name, size);
>   	if (!clk_data) {
>   		iounmap(reg_base);
>   		return;
>   	}
>   
> -	clk_data->num = of_property_count_strings(np, "clock-names");
> -	clk_data->name = kcalloc(clk_data->num, sizeof(char *), GFP_KERNEL);
> -	if (!clk_data->name) {
> -		iounmap(reg_base);
> -		kfree(clk_data);
> -		return;
> -	}
> +	clk_data->num = size;
>   
>   	for (i = 0; i < clk_data->num; i++) {
>   		ret = of_property_read_string_index(np, "clock-names", i,

