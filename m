Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB131AA3D6
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364925; cv=none; b=XLUWmlvhIBsIMF7oCNTOpjfulkKxxGlW6YCys6K52oydfm5onRpsWxzVvkiQ0aZbuaS2RixfDq/fM3AVuBtrtaU1dl+9+xCxHHUijS2wx8rDalRLM5FNvTyuO5IVeZpmWOluD5aGk2YzJN/FKhAMEjK+lpF5/f8HFjxrKrxs7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364925; c=relaxed/simple;
	bh=M23pmonqcjOUrvL5y+TUUAfYQF/lbr+wZG7oz08/Le8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnsoyHI4ay/rYxMDAj9Zb41EX9ug1TRlMiu6jPibjrJAynnfbVDhbM185cP8K8Zvf3PIHbhvSWa9ID29LbHNwVr3NkbkWBLqZWeeol281X3qvBV9t0+nRFSbj7GfsvUSTTYOERHxsq5dKj2tY9pXgTu67X9GP5lJNBX3XTIB8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=SYIkSHKy; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SYIkSHKy"
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id YraLsvtpZiA19YrnPsuSfU; Tue, 30 Jul 2024 18:42:03 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id YrnOsWGsZX56wYrnOsfNvp; Tue, 30 Jul 2024 18:42:02 +0000
X-Authority-Analysis: v=2.4 cv=MY6nuI/f c=1 sm=1 tr=0 ts=66a933fa
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=vaJtXVxTAAAA:8 a=VwQbUJbxAAAA:8
 a=mDV3o1hIAAAA:8 a=_i8g6-15bEtif-cgzOIA:9 a=QEXdDO2ut3YA:10 a=t_mPKkL_zAAA:10
 a=ZG_C2GzNMVAA:10 a=AjGcO6oz07-iQ99wixmX:22 a=_FVE-zBwftR9WsbkzFJk:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KVw1p3AtOQeK622V4mNQ6qCUbtClJE1ilcPgfcCQq08=; b=SYIkSHKyau7rGe7ScXR06X5LA8
	I89GzU1+CttTwd3c4Vj4jul59SixB/S30joSSnyDuqBx8q87mx2JkskxPpGSvG5Fl7lKqlyG6SwzO
	MqK8qR92N4jfAvyx5/y0GoltbnZtI8T2M4e/18GAj8aTGkeAuZTWjaXcVgrN6WTIJwGj0YidXpIRR
	zwHJCGIAVw4QLJtL2sBRo+a4xT7ZSLz+1mPVBVwzDqkQ3FGJr1asIgFcNdWZRSCE7GXAR8knoFJyc
	Ku1jbL7hmizTyO8/5t4Br2cK1QdEWPQ0dkAjLf+6b0v5rSBLQuvirN1MvSd7yk60dRcJaDwMVwFH4
	HWVu2q9Q==;
Received: from [201.172.173.139] (port=59656 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sYrnN-001GIE-0j;
	Tue, 30 Jul 2024 13:42:01 -0500
Message-ID: <c815078e-67f9-4235-b66c-29f8bdd1a9e0@embeddedor.com>
Date: Tue, 30 Jul 2024 12:41:56 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: core: use __counted_by for trailing VLA of struct
 sock_reuseport
To: Dmitry Antipov <dmantipov@yandex.ru>, Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240730160449.368698-1-dmantipov@yandex.ru>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240730160449.368698-1-dmantipov@yandex.ru>
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
X-Exim-ID: 1sYrnN-001GIE-0j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:59656
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKHcZ5djg3zCdlygjW9tJKgbHXY/SX11fydQUFg9E6BLwMw1fk1uTW3hP4PuOLSK3gxN/r0QQSG5zXgRSWSt7r4ahLHL0O7/+VUl2bNM5vphQBIvQQEH
 Rua+hsDr4DZzxGV69O2O6kvY8mVwGqnrfGD7unCAsh09pWnIIliQW6FiBhYKB8PGNUxs5R3aNfA8d/HBcmCAbMj2Z+xdw0CBxVTSXh7Cq8sgQ7iOrp79IStJ



On 30/07/24 10:04, Dmitry Antipov wrote:
> According to '__reuseport_alloc()', annotate trailing VLA 'sock' of

`socks` is a flexible-array member[1], not a VLA[2].

> 'struct sock_reuseport' with '__counted_by()' and use convenient
> 'struct_size()' to simplify the math used in 'kzalloc()'. >
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Looks correct.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

> ---
>   include/net/sock_reuseport.h | 2 +-
>   net/core/sock_reuseport.c    | 7 +++----
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
> index 6ec140b0a61b..6e4faf3ee76f 100644
> --- a/include/net/sock_reuseport.h
> +++ b/include/net/sock_reuseport.h
> @@ -26,7 +26,7 @@ struct sock_reuseport {
>   	unsigned int		bind_inany:1;
>   	unsigned int		has_conns:1;
>   	struct bpf_prog __rcu	*prog;		/* optional BPF sock selector */
> -	struct sock		*socks[];	/* array of sock pointers */
> +	struct sock		*socks[] __counted_by(max_socks);
>   };
>   
>   extern int reuseport_alloc(struct sock *sk, bool bind_inany);
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index 5a165286e4d8..5eea73aaeb0f 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -173,11 +173,10 @@ static bool __reuseport_detach_closed_sock(struct sock *sk,
>   
>   static struct sock_reuseport *__reuseport_alloc(unsigned int max_socks)
>   {
> -	unsigned int size = sizeof(struct sock_reuseport) +
> -		      sizeof(struct sock *) * max_socks;
> -	struct sock_reuseport *reuse = kzalloc(size, GFP_ATOMIC);
> +	struct sock_reuseport *reuse =
> +		kzalloc(struct_size(reuse, socks, max_socks), GFP_ATOMIC);
>   
> -	if (!reuse)
> +	if (unlikely(!reuse))
>   		return NULL;
>   
>   	reuse->max_socks = max_socks;
Thanks
--
Gustavo

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://gcc.gnu.org/onlinedocs/gcc/Variable-Length.html
