Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58313D617
	for <linux-hardening@vger.kernel.org>; Tue, 26 Mar 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472695; cv=none; b=mjT7LJR1d4OcyZNXS7dH7xZzLA4DJueo7+uvUw4gBSzoIf/gWZ0goGzTWH+VETymk4CN7DLhEvoRBWsZdZimilNeo0X6zKFGYBUgMoaRwAgq+WV1FO3EVzrMYax+1jXj5abOIQ2OX1oWRK0uv5021QxXFCx/sOgxjb7w8ZIZbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472695; c=relaxed/simple;
	bh=Cpri5PjjryFGqOusLKvKrIGD54oxva3AYCd9WDfkwGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pORx/0G5UX26mdyPMoEjq07dt5aLWaXgtMvS7iS1dDeUpq2QFLrma7nOjPhONOHoVY5m//7Qfgj1213F26ZUrmdHG8Y6mT8DY9yFSnm9wc/5toFZlXhPWsl3sHAT59mSJvYljrTVEjM7PBJDQZvBmKc4AC3ezrAYCEiB3PB5Tn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=kMIvgWJ2; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kMIvgWJ2"
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id p9lirSFOsPM1hpAEDriYwH; Tue, 26 Mar 2024 17:04:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pAE7rVFJZHHoApAE7rOBAB; Tue, 26 Mar 2024 17:04:43 +0000
X-Authority-Analysis: v=2.4 cv=dskQCEg4 c=1 sm=1 tr=0 ts=6603002b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ZDQiqXMRDEc8gDlBFqcA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bq50C7r03mnPJYQbLMi3W08WnGxg7WKBeQErjDo/ugk=; b=kMIvgWJ2boyXB4ghiNPGW96f4C
	44Ptkhnr261b39hK52RZ0L/qFt2M4sRPsdENgHU0l4ulpRmO5WrintQqesdwraO36ZkCjzrcBByPg
	32ZxOKEFfvrGNzVx3cNqpXgLNFq4YJJs9+9T37UHx5EdhRV8KNvkXg2h+cRMMC8qlWE2v2+1owTcv
	fo+AeQp6kggywBVoNKGDNc3Rr0UIa0SQw0PORbzrxAGatiJjnaUqsVoo1eUNX9pjQDLNXqGqADJuJ
	fLKX33ZUj9AP6UN+jywF/V7l3WXu+pfnHf0zuP/YpFCO29cQw6hfxflG3lI9oyCzGGOXnSg0Awa2j
	gbayfK4Q==;
Received: from [201.172.173.147] (port=44416 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpADz-001bkE-2T;
	Tue, 26 Mar 2024 12:04:35 -0500
Message-ID: <4e0980bd-2de7-470f-ad71-f7ed28bb0173@embeddedor.com>
Date: Tue, 26 Mar 2024 11:04:34 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] idpf: make virtchnl2.h self-contained
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Simon Horman <horms@kernel.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326164116.645718-1-aleksander.lobakin@intel.com>
 <20240326164116.645718-3-aleksander.lobakin@intel.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240326164116.645718-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpADz-001bkE-2T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:44416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHXVbeFf2CIfXLq4UEgHnI6UyEl1Btn7TFnSjElCT5BQQp/RrVN53X/z9Ogloy/L66tBloJ9+9OctquXcSHuPhjpsPhmDdL2lGgGjSeUaWKvomsy2RqD
 LtHnI2D56x1xrW+YkmlMaWwgGWnK4Lj5mlHp8GrFHGrtTwtbxjlsgQ2mc9Qo149iP+9vkFiXOW4Jm5p6V3cwnkLEHZdMkKNWtUpLWJo4yF+djmNAqiheBSkZ



On 3/26/24 10:41, Alexander Lobakin wrote:
> To ease maintaining of virtchnl2.h, which already is messy enough,
> make it self-contained by adding missing if_ether.h include due to
> %ETH_ALEN usage.
> At the same time, virtchnl2_lan_desc.h is not used anywhere in the
> file, so remove this include to speed up C preprocessing.
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/net/ethernet/intel/idpf/virtchnl2.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> index 4a3c4454d25a..29419211b3d9 100644
> --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> @@ -4,6 +4,8 @@
>   #ifndef _VIRTCHNL2_H_
>   #define _VIRTCHNL2_H_
>   
> +#include <linux/if_ether.h>
> +
>   /* All opcodes associated with virtchnl2 are prefixed with virtchnl2 or
>    * VIRTCHNL2. Any future opcodes, offloads/capabilities, structures,
>    * and defines must be prefixed with virtchnl2 or VIRTCHNL2 to avoid confusion.
> @@ -17,8 +19,6 @@
>    * must remain unchanged over time, so we specify explicit values for all enums.
>    */
>   
> -#include "virtchnl2_lan_desc.h"
> -
>   /* This macro is used to generate compilation errors if a structure
>    * is not exactly the correct length.
>    */
