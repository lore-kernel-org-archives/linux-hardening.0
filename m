Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B5E1F8690
	for <linux-hardening@vger.kernel.org>; Mon, 21 Jul 2025 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124720; cv=none; b=md5HCZYLV7fDiywGGAnAR+NV/B1rw2HMpG5hotNDlFZhjiCSYcrqDwGK+dnkKVjEE4BSKDsUmzFTtpTgqFmup21BOpXsWPnuenxuwrff5Xw4LuuKV4+5RDMcmwHBMBn9KR0QuZyi2a9CmaUlBGc6wGNKYPBHwhp/w2+1nQuxKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124720; c=relaxed/simple;
	bh=AI9EcMyXH2NqQn7pn/7lI+3/dZr4645CtGDIQIk10To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFsYUZLnviMdqP3qXVsI4BhEVZ5aU3E1ukhotUiRYOpC+gTRjy7G/83ejIfbiM8WydL1XKJwV3JqUkSQii+hss/edSnm+lGVbx5YGst+6BpjEbKGLXhZ3EYk9GCcRwA9UqRop7saFouQeuwVk9gWcQthlVsyVRly1Daw52pMrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=EhMu0TmI; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="EhMu0TmI"
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id dvIcu5zPJOFUadvnaud0rH; Mon, 21 Jul 2025 19:03:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id dvnWuGRLAnxtxdvnXuQ1L2; Mon, 21 Jul 2025 19:03:39 +0000
X-Authority-Analysis: v=2.4 cv=HKLFFJtv c=1 sm=1 tr=0 ts=687e8f0e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=elAakMZAzsQyfqpwiXQzJA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=bUQKSiCPAAAA:8 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8
 a=PW-KNzBFAAAA:8 a=xzhjGNMdqhMncFuJsFsA:9 a=QEXdDO2ut3YA:10
 a=-fHZXUhsFbuwFN3fwQAr:22 a=84zbTXrhsdUYOv-GFPQN:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GCiLCi7Cr1qi66PR1V2dUYh9RHKXTknJEBYAIn6dHjM=; b=EhMu0TmI3OOqbXwnwDEqp0bXIZ
	J5gQ6BlFra6K9I+PEv+IxagOfJ6DdTvSs6EKKZpFlz1yOtii1VlknJdy/AurXhlCEDPFiy16WqcCv
	XwYx1Ft/l0Wt8tqTqFRTLTtOishxlpzsFzmmXYmzdHG6gMftbM8lUlyEWtgHflhHhQYiF5Y2ZAuCS
	OZaLvy5xMnK7OXTab2urJ5mFiilLv0ytVT421qaTMMDeBLMPzRH2SsQiSiLjd3SyBP+P28KmnNrqv
	kRcLHUUxw5+1PqA8oSd6anpiiH4BgsSNYYdbWpcZ6HNWW54aEbXcABAwsbWBTN10l4sSzrIrUnFDz
	gqFkzIAA==;
Received: from [177.238.16.239] (port=35216 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1udvnU-000000027hi-1RNt;
	Mon, 21 Jul 2025 14:03:36 -0500
Message-ID: <54478268-48d1-4163-9bcb-d576cc93f7ce@embeddedor.com>
Date: Mon, 21 Jul 2025 13:03:23 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cyw: Fix __counted_by to be LE variant
To: Kees Cook <kees@kernel.org>, Johannes Berg <johannes.berg@intel.com>
Cc: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>,
 James Prestwood <prestwoj@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ting-Ying Li <tingying.li@cypress.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721181810.work.575-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250721181810.work.575-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.239
X-Source-L: No
X-Exim-ID: 1udvnU-000000027hi-1RNt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.239]:35216
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMFdsRlLTy6NYmq6hi/u/t135RVWC2nyvWr0Ds43MUZnQcPWWAHZ4gUmLRVNWlFO81o7BLEAaKwyp7oGo/S1gIpgaabXh1Ark6xX739rLw5c6+oP+h66
 7ZYYj2q520Jp3aLdXdxbFL+QDE1EoO9EdvBcwZeYbBheIPpK19S62XnTZM7hhbYD1a+7b04J+j0gA6N+2hv7HWFIbXckrlbvyQmSrm36S0p+etGQ3n/78Q/i



On 21/07/25 12:18, Kees Cook wrote:
> In brcmf_cyw_mgmt_tx() the "len" counter of the struct
> brcmf_mf_params_le::data flexible array is stored as little-endian via
> cpu_to_le16() so the __counted_by_le() variant must be used:
> 
> 	struct brcmf_mf_params_le *mf_params;
> 	...
> 	mf_params_len = offsetof(struct brcmf_mf_params_le, data) +
> 			(len - DOT11_MGMT_HDR_LEN);
> 	mf_params = kzalloc(mf_params_len, GFP_KERNEL);
> 	...
>          mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
> 
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: James Prestwood <prestwoj@gmail.com>
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Ting-Ying Li <tingying.li@cypress.com>
> Cc: <linux-wireless@vger.kernel.org>
> Cc: <brcm80211@lists.linux.dev>
> Cc: <brcm80211-dev-list.pdl@broadcom.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> index 08c69142495a..669564382e32 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
> @@ -80,7 +80,7 @@ struct brcmf_mf_params_le {
>   	u8 da[ETH_ALEN];
>   	u8 bssid[ETH_ALEN];
>   	__le32 packet_id;
> -	u8 data[] __counted_by(len);
> +	u8 data[] __counted_by_le(len);
>   };
>   
>   #endif /* CYW_FWIL_TYPES_H_ */

