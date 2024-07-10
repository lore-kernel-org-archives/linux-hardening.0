Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAB1527A7
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jul 2024 23:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653912; cv=none; b=LWqeRRKp82bS/VjCMxSoCRSBqhQaGHt8PkFBE2fcF0Z9QRTASR1RU00G6QMdn/x8UDYbxPD5FpLK0usG5Rrz1Pd6xyw0orP8oAyrPcDAaagoRqQIYUJPVJUCdUyjMaxtT9RqGjJI36hZhim6MYVFVx6EXEoJb4CYTZ04PRxnqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653912; c=relaxed/simple;
	bh=gw/MLm2hIT4+Tpb2VM+DAxnSIDoNHKfcf/mPwPe0CAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7OaYHJMyi0vkHeSPmBYa23utMD4ALeI5UO+hUdiR8pDPw7jxhsLCyyyqfUj+8RRAlrnlowckKo1FnoUcAYmsTAyWSJZu9uomrOp4bCrfYkmYWaznNu+G8iJ9dAAJhBgfFanae8ethC2HVbRYsR83sAViDHmJrOtfp23zL8I6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=PKXF+f4s; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="PKXF+f4s"
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id RcXWs4D2AVpzpRggQsRuDB; Wed, 10 Jul 2024 23:25:10 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RggPsPp1xeieBRggQsjKPb; Wed, 10 Jul 2024 23:25:10 +0000
X-Authority-Analysis: v=2.4 cv=BoBWwpX5 c=1 sm=1 tr=0 ts=668f1856
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=vS7kxI9omEbEOQks6BwA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5JTzYDV8HuQdO+rGyaS9OUcGkFAqlJYU3lF427AyccY=; b=PKXF+f4sBIZSdXNIUYQIXOOBsS
	XUytasohbtpTlT2vQc53it49tKfEgdptJRsoOyQTjMTaAzVj1cTETqrhldXCGKy6T6iIxXVUdYDL7
	z5Qn9EZrVqFi27IuD0nty6XwCCPFf8asS00sx4KUNlpM1n4690aA8zd7rBnN9shBVhe2fTbErJyd5
	JfZYy1ZyXTjrr5HRTfz4FGKCOrvqMmfDlmWkvzZrHZLLf7hGOQ8wdMzIfLyUOl/jfYrrxis5kkCJK
	2TU7uRLpJA7EhtNU9LDzJxnhVaXvpB+N4RhvXUp2OJgSnQyb+abVqmqsXXtFNhEdB/iPGQ0MsH4vA
	E2KdXE2A==;
Received: from [201.172.173.139] (port=36682 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRggP-004LFD-0j;
	Wed, 10 Jul 2024 18:25:09 -0500
Message-ID: <ee3b7adb-0f11-4650-ad1f-afc9dceedc8a@embeddedor.com>
Date: Wed, 10 Jul 2024 17:25:08 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/affs: struct affs_data_head: Replace 1-element array
 with flexible array
To: Kees Cook <kees@kernel.org>, David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240710225725.work.409-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240710225725.work.409-kees@kernel.org>
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
X-Exim-ID: 1sRggP-004LFD-0j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:36682
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 33
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPNYqyCKDx1EmJOemG3worAG/dp1nnjrsaqoHEEHcoRLfF4Brc74H7lh0W7oK5lbbV1/+Zl3cL9VrJg/xMxax6m45S0HkufgqSx/81nObN70fVh6wF65
 RPlozD6r2NXZiGoblXxQeKehFyOEuNUYnT5PRBQYFGm8nAlpVO03omQErHwCfzunuur2ylnKyPiKESVrRvkDI1gFn2oFycE4A4dfQGXLDMjj2hbjlwxKxjZu



On 10/07/24 16:57, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct affs_data_head with a modern flexible array.
> 
> No binary differences are present after this conversion.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/affs/amigaffs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
> index 09dc23a644df..1b973a669d23 100644
> --- a/fs/affs/amigaffs.h
> +++ b/fs/affs/amigaffs.h
> @@ -119,7 +119,7 @@ struct affs_data_head
>   	__be32 size;
>   	__be32 next;
>   	__be32 checksum;
> -	u8 data[1];	/* depends on block size */
> +	u8 data[];	/* depends on block size */
>   };
>   
>   /* Permission bits */
