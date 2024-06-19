Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D279B84
	for <linux-hardening@vger.kernel.org>; Wed, 19 Jun 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832417; cv=none; b=Fmp/k4Nizo2S0uMpTifIQCpflOagcltMYT3/LRuGPMlB9J+BuXb4OciKeTOYuMKOCTX22QVBCTRl0TmohnCjPwJ99KgILqQFnpV+jnoXx00hNpDOjvo5CkctFpO6seeHFNiDD2UmFPgITp97CBGZ7XTYLJ2T7qUunfeaXMauc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832417; c=relaxed/simple;
	bh=//iyxzZIVr6QAres699JGFf8ftXcPIb7yWo2DMzEqKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9kaU2kkSCYWC1xXJF4ZPrMMLTY+tSD64GUMUxZhvtL3+/lbZU99JT68+BHhR8bG25/0v89TA2IxRNFdnsTdH3jtLwvKCfhrZPBHhUJh9WY2D4l2z7P912eZFIaFhIl/xJukM30nrEZcjOTBgUT0CfZ85uLcwtEo79VnarVVwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jXDFp7T9; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jXDFp7T9"
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id JxLysstgLSqshK2pTsAK17; Wed, 19 Jun 2024 21:26:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id K2pRsIgl269m4K2pSsyvML; Wed, 19 Jun 2024 21:26:54 +0000
X-Authority-Analysis: v=2.4 cv=QONuRBLL c=1 sm=1 tr=0 ts=66734d1e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=JCK2di_1bi8deQwruN4A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i1/F0fvsqi40siO6o8D5Pzhw1FyW/BXIpxZTgXo3ZAA=; b=jXDFp7T9rL3o9tAW94e5rceoId
	wQHGW2Pk12tmGoJ9ne4mwscdmYw3t0G7vPuMOG6gU5tpBHRF2l+EjcBx+TKNmtYmg9UNVFz/N+BYL
	HQoxySOW1QR0a9hsYjsO8EvFG/e60KslKqTBFaModChvd/9BKGz6ZchqXuZjfFb2n7OQATgoZ+ft4
	pY4aWE46EFbLQ2OE+wog2NNJDysXUi0ustGaoNaJInzY2QcY1y/jS9YouVWDkcY3hIyZsNF+jVHvs
	ZQcDLeF/4apCloM0zZvmPFU2CDomf0tBtiVVOPPr7TXz2pMju+g3zVPgtwSY0+yVua/P/9OTVVgiC
	6eS87OeQ==;
Received: from [201.172.173.139] (port=41446 helo=[192.168.99.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sK2pR-002Nki-1R;
	Wed, 19 Jun 2024 16:26:53 -0500
Message-ID: <26028fee-8043-4f81-a062-bbff12f4c904@embeddedor.com>
Date: Wed, 19 Jun 2024 15:26:51 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Input: ims-pcu - annotate struct ims_pcu_flash_fmt
 with __counted_by
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240619-ims-pcu-counted_by-v1-0-3ee0ead2e57d@gmail.com>
 <20240619-ims-pcu-counted_by-v1-1-3ee0ead2e57d@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240619-ims-pcu-counted_by-v1-1-3ee0ead2e57d@gmail.com>
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
X-Exim-ID: 1sK2pR-002Nki-1R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.99.44]) [201.172.173.139]:41446
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCgzzT7Z6LL887JpTJs9Y0xXy6Ddne/RTWHZol2MTObj33AjJMN+vGi8J2jmvG1T5ZpjvBxKHaYkIeBlZvqjJw5FlxsbaowRYofBmLq8xoWzx3hqRXrw
 aD+WTL1enQAIhWwo440XSKu5jgLnmf930ZUcLqJphAEKxlEZQ+TQ/yDJmrujztr5pWwkcIQTh9PJ872Ji90QZv62HcjGUz8MHA7KQAwecbdJlZZVu4/dLMZZ



On 19/06/24 23:13, Javier Carrasco wrote:
> Use the __counted_by compiler attribute for the data[] flexible array
> member to improve the results of array bound sanitizers.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/input/misc/ims-pcu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 408a586f8c36..91f8ad826238 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -761,7 +761,7 @@ static int ims_pcu_switch_to_bootloader(struct ims_pcu *pcu)
>   struct ims_pcu_flash_fmt {
>   	__le32 addr;
>   	u8 len;
> -	u8 data[];
> +	u8 data[] __counted_by(len);
>   };
>   
>   static unsigned int ims_pcu_count_fw_records(const struct firmware *fw)
> 
