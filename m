Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9593F8D0
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945915; cv=none; b=ncJJ13lF2+mkZkzB7LQSTy/WwNt/n0vkJbm3d8s5wysQNYU2OmQQFf7NEr1uX6GLz+CbhG0VBHWdmrZ4Y/EXWdN8bGaTkFqxRDHJtzgSOFWZyzBnKSy5O7RMiG1h529otmnaSzvT9KtlMyPB1Vb2Ml7YGz5MSqTWFFyJilshJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945915; c=relaxed/simple;
	bh=owMXn5/UTsrMQS2BtQGc3ge2yqhtI0C0ELbKT3M/yjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8oxN7NZNgslGK1MjJ+SFjmwn8E22BECUnvLT5z6JLuh2RR+eIiI1wHf3bH5ptQqMlkCv3Foz/2pb/BtnzKn3i2OJIt5ggtoYOoL5QZ1PP8Ap4RoCPRyR2gYWpJuo+HO138pV8y6Gy8U/nEib2G9hlRPZlwqbUrLWG+3rkpgzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=pd3bElU0; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pd3bElU0"
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id RwiUr0aUgoMN9RySfrsNtQ; Mon, 22 Jan 2024 17:51:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RySerFbwLfs4hRySfr1UTb; Mon, 22 Jan 2024 17:51:53 +0000
X-Authority-Analysis: v=2.4 cv=Q6TBXq6a c=1 sm=1 tr=0 ts=65aeab39
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=ej3Yaj9vPbnurUtvnZYA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7hCmgKmn2q+Ph8u4I5kiPW/QetBMHfbxFqikOfCMiAE=; b=pd3bElU0BAm2/39AGANe0PiTc0
	OhNGobE9XqvPCsMwyrqLqvUo3RQO6xB689iEI7Jq2NTWlyqKaFLLbtMT46u+nl54mLSHE/GNZXuX2
	ok6qICo5VjRiPM+kbNxQuinW5jII5XuD5FDucvC+fJBjncPdmHBdng41Q8XDHyEEnocrjxo2E3A3c
	HvSZ3IupNdeiPCLPDBzp+qAUzAgU5TB/yCRNmI1DSmsWipYppFJk0pSmkbGsPdpC6ZMcv12fIQAf6
	/6r0HwMhGjE3lwNd5G7ZOrEk2wMqBV7lUKVBCvgcRF4UV4uL272niC+vNIePtiyNVjeczzJJW9zIn
	BWv8I1SA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:40442 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rRySc-001JMH-35;
	Mon, 22 Jan 2024 11:51:50 -0600
Message-ID: <b21d9eb5-eeb7-460f-99c1-9878532be148@embeddedor.com>
Date: Mon, 22 Jan 2024 11:51:49 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: hisilicon: Use devm_kcalloc() instead of
 devm_kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Heiko Stuebner <heiko@sntech.de>, Dinh Nguyen <dinguyen@kernel.org>,
 Rob Herring <robh@kernel.org>, Nick Alcock <nick.alcock@oracle.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240121142946.2796-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240121142946.2796-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rRySc-001JMH-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:40442
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 26
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMIj0qczrFQdoeAiDUJHSe3MkGX1/itL9F4YAWNI353ub9pDdCdt9F4SJ/hxacSfBlVPuKvBNOizR6R1P07gXNstZ2lbLai8YIuaH2hVcc5TUb5CdWVu
 2RmyJo4wkmTfNQf6aY++SD/zX0uvJdqb1j2LoAEO5gMkCzABFfvlocmneZaxD96yz4UgtgPRfx/7V1morqAcGfNYtNryE6PFBcpOs6F4Jw+SMnYefOsztERi



On 1/21/24 08:29, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific devm_kcalloc() function instead of the
> argument size * count in the devm_kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/clk/hisilicon/clk-hi3559a.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
> index ff4ca0edce06..da476f940326 100644
> --- a/drivers/clk/hisilicon/clk-hi3559a.c
> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> @@ -461,8 +461,7 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
>   	struct clk_init_data init;
>   	int i;
> 
> -	p_clk = devm_kzalloc(dev, sizeof(*p_clk) * nums, GFP_KERNEL);
> -
> +	p_clk = devm_kcalloc(dev, nums, sizeof(*p_clk), GFP_KERNEL);
>   	if (!p_clk)
>   		return;
> 
> --
> 2.25.1
> 
> 
