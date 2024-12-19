Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCF2AD16
	for <linux-hardening@vger.kernel.org>; Thu, 19 Dec 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622929; cv=none; b=BAWqzuZGkIg7nWr8bi7F4GsU6iR3/jPumkFY2YO9OMmAOtQr2rj5fBBrFtqFN5lPHAVHKfcto+9PZXafklEHBv16TaFNFw+KBsBoIEX9XlYL1YHIuDnyis3U8xSI2I2wpk3u2LyMDULFE8o42xRCaNxiUIlK9Ok258EwKCYM2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622929; c=relaxed/simple;
	bh=Y0ovFQwwsrui7DXugyN18m5l/uhRF8+HeOHZSWhYjXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckk2LLE4cOvP2rlDxrE4O8dIkMCEwjiWXanIQUrFbQpvvRNquXxg0xi5KW2Dnoi3TJ7BecpQ+BumPOQTHNQAtSzZJny92lowbLEANauU61UDWEaU8zxG9U3cQXAAlaARGfSts1ufI8RV4CUqghYVqdqQMIFN7WTnZ5TI8C/sH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=nxtJAVZb; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="nxtJAVZb"
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id OCCPtD1KGqvuoOIf3tFgKM; Thu, 19 Dec 2024 15:42:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id OIf2t8Ygu65gFOIf2t92Mc; Thu, 19 Dec 2024 15:42:01 +0000
X-Authority-Analysis: v=2.4 cv=Z58nH2RA c=1 sm=1 tr=0 ts=67643ec9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8 a=gC4Mv4LYc3ckQaHmDRUA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iirsJHLoAB+GXg9F7Qq1XwgdQloHauJINOynHEONtik=; b=nxtJAVZb1fCi0iWKCexjklhvgh
	aC5rSkaUmWpaJKEtGm2eQl0YJSn8mWQE/qCKCMIHiA/ydPKAz06DVAnM/uZUuq8aGiwkN0iZu5hCy
	AUGQuGYJYFaiz2E4AVecv+bL7oE3rsQhBN0vzizOTdAOgrgd68XFm5G/ySd4JaAQJw8sLI6bkGCln
	aWZsM1ovR3GpdeecOrPizI7mDwnnmg3EGiOeRgB1B0NvwhB2YCUFmNQTI9knrB38U1YC3oHT3RByI
	mM2J+cgoKjHywLpjuZBKzRprwyW842+PASq2I7gm/l3AF2vAANEO7B7qRPLMqJxc1cdlSg+cJAzZz
	A7/l8PeA==;
Received: from [177.238.21.80] (port=35104 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tOIf1-001GqX-1A;
	Thu, 19 Dec 2024 09:41:59 -0600
Message-ID: <57428517-33ee-4f5a-a8a2-7a016ce5eba8@embeddedor.com>
Date: Thu, 19 Dec 2024 09:41:52 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] stddef: make __struct_group() UAPI C++-friendly
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kees Cook <kees@kernel.org>
Cc: Christopher Ferris <cferris@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@outlook.com>, Keith Packard <keithp@keithp.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241219135734.2130002-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241219135734.2130002-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tOIf1-001GqX-1A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:35104
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFlmOhEJ+gaEfTIzpRToHEeIXsjuoIdarrvGTSEQPQx0Q7Vbq/xsCcV/neoSp9g6clmgCjBN/JdiftbedVnfY6IpHYZS4lT7nEPIoWrEiQHgNT3MvZ7I
 UmpoDM27k5mBbqeDkhylMT4ZRiKH4KC0ZIzbon41sufCsYJWRC0hPqv79j7FS2pVXbhab7xfoBTeAe2Sy7qK+WqC+tcRn5u3650KjwbJ1+N436Gkt4UP7nM9



On 19/12/24 07:57, Alexander Lobakin wrote:
> For the most part of the C++ history, it couldn't have type
> declarations inside anonymous unions for different reasons. At the
> same time, __struct_group() relies on the latters, so when the @TAG
> argument is not empty, C++ code doesn't want to build (even under
> `extern "C"`):
> 
> ../linux/include/uapi/linux/pkt_cls.h:25:24: error:
> 'struct tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,' invalid;
> an anonymous union may only have public non-static data members
> [-fpermissive]
> 
> The safest way to fix this without trying to switch standards (which
> is impossible in UAPI anyway) etc., is to disable tag declaration
> for that language. This won't break anything since for now it's not
> buildable at all.
> Use a separate definition for __struct_group() when __cplusplus is
> defined to mitigate the error, including the version from tools/.
> 
> Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
> Reported-by: Christopher Ferris <cferris@google.com>
> Closes: https://lore.kernel.org/linux-hardening/Z1HZpe3WE5As8UAz@google.com
> Suggested-by: Kees Cook <kees@kernel.org> # __struct_group_tag()
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
>  From v1[0]:
> * wrap @TAG into __struct_group_tag() (Kees).
> 
> [0] https://lore.kernel.org/linux-hardening/20241218145758.701008-1-aleksander.lobakin@intel.com
> ---
>   include/uapi/linux/stddef.h       | 13 ++++++++++---
>   tools/include/uapi/linux/stddef.h | 15 +++++++++++----
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 58154117d9b0..a6fce46aeb37 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -8,6 +8,13 @@
>   #define __always_inline inline
>   #endif
>   
> +/* Not all C++ standards support type declarations inside an anonymous union */
> +#ifndef __cplusplus
> +#define __struct_group_tag(TAG)		TAG
> +#else
> +#define __struct_group_tag(TAG)
> +#endif
> +
>   /**
>    * __struct_group() - Create a mirrored named and anonyomous struct
>    *
> @@ -20,13 +27,13 @@
>    * and size: one anonymous and one named. The former's members can be used
>    * normally without sub-struct naming, and the latter can be used to
>    * reason about the start, end, and size of the group of struct members.
> - * The named struct can also be explicitly tagged for layer reuse, as well
> - * as both having struct attributes appended.
> + * The named struct can also be explicitly tagged for layer reuse (C only),
> + * as well as both having struct attributes appended.
>    */
>   #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
>   	union { \
>   		struct { MEMBERS } ATTRS; \
> -		struct TAG { MEMBERS } ATTRS NAME; \
> +		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
>   	} ATTRS
>   
>   #ifdef __cplusplus
> diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
> index bb6ea517efb5..c53cde425406 100644
> --- a/tools/include/uapi/linux/stddef.h
> +++ b/tools/include/uapi/linux/stddef.h
> @@ -8,6 +8,13 @@
>   #define __always_inline __inline__
>   #endif
>   
> +/* Not all C++ standards support type declarations inside an anonymous union */
> +#ifndef __cplusplus
> +#define __struct_group_tag(TAG)		TAG
> +#else
> +#define __struct_group_tag(TAG)
> +#endif
> +
>   /**
>    * __struct_group() - Create a mirrored named and anonyomous struct
>    *
> @@ -20,14 +27,14 @@
>    * and size: one anonymous and one named. The former's members can be used
>    * normally without sub-struct naming, and the latter can be used to
>    * reason about the start, end, and size of the group of struct members.
> - * The named struct can also be explicitly tagged for layer reuse, as well
> - * as both having struct attributes appended.
> + * The named struct can also be explicitly tagged for layer reuse (C only),
> + * as well as both having struct attributes appended.
>    */
>   #define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
>   	union { \
>   		struct { MEMBERS } ATTRS; \
> -		struct TAG { MEMBERS } ATTRS NAME; \
> -	}
> +		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
> +	} ATTRS
>   
>   /**
>    * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union

