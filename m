Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8ECC8FD
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707536941; cv=none; b=bGN/RwzjGuTdbV2F8EBJuds/otOd7Zyibe5fG7tKq1W92c7tCb3bVa65sfd88ny0JqJjUmNqx0DSRTDxa9h/olsdAFFLtePlN1dp1cO5f4SbNN1GQ7DjRWicd25t4uf2xoDTQVBKfM7S7bcXbEpmjc4DIAeDg587Bk/s45ZsxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707536941; c=relaxed/simple;
	bh=N5lIWGJSxWQYVGgLG22Dg9ozki3dEHmzpJWQ5H3czUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7XIiv+hk4sOmH7bMPbQCmilG2TZbb6jCAt6Qhem7MwoG8MWTQ63fZUlkscwH8D9ej43A4zQxuP0K+G2CJuLkNUhcP2RzRgtuAzp21tChYF+fhnMEcy5pZc1yoYOgw/bM/m5uPBAdbYLslS0Ny/EkS328hORqWUxg+UZt1pwBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=n+xFz7Nr; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="n+xFz7Nr"
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id Ye8xr7zNOAxAkYeMHrswWO; Sat, 10 Feb 2024 03:48:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id YeMGrC9Axe76AYeMHruIDy; Sat, 10 Feb 2024 03:48:53 +0000
X-Authority-Analysis: v=2.4 cv=WIzcXWsR c=1 sm=1 tr=0 ts=65c6f225
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8
 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W64qZAI3h8NJ4txSVPm6MF/X+ayduigBYWPV+cPrB00=; b=n+xFz7NrN34AhWBnk8Veb7KwtU
	3dDtW8x91tz7n+rUUge8REcm8x8TLDk3WKJjVTtaYpa04THv2tVnEwPFegbM+Ew1OGAJwVwthc9BX
	rwhpwGVK0QKRYjkHH8gEQB6/S4/7GfU4At1uyvA5cXAY3uA4LBj4GB7ZHB2yIrrXh4xbqTrxBycvO
	uNyDB5/dSW+tARJ3Ajyv+7wg/NVPr/foDXFLqcYw1i1o8FB/R2tcCy/QgIXw+Ly4QPQhc8Z0sO0n4
	neKQ9F7W5MSIRynA/L+d2UReES9QZ5YX13E58VsamyYfBDNMDHkgAii7ygd1Lu3Pgir/QB/MMNxHa
	Gz8M/QlA==;
Received: from [201.172.172.225] (port=48392 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rYeMF-0031L3-2h;
	Fri, 09 Feb 2024 21:48:51 -0600
Message-ID: <d6ff85ad-978a-40cb-aeb8-7b12c2dd1425@embeddedor.com>
Date: Fri, 9 Feb 2024 21:48:50 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/ipv4: Annotate imsf_slist_flex with
 __counted_by(imsf_numsrc)
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Dan Williams <dan.j.williams@intel.com>,
 Keith Packard <keithp@keithp.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240210011452.work.985-kees@kernel.org>
 <20240210011643.1706285-2-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240210011643.1706285-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rYeMF-0031L3-2h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:48392
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHH0vGSHNuYIc6w3wsTGdQdeMt9NbEJBInVPZ1RwLDo/HyGpRqKwkBFP9vFQ2LuLdp8uZRurD/Xf62H8MM8KQa4qlttXhRKaAUP02w020ZPqVvA9Pm2G
 fWLipGHYCOJSlPGRHe491a7X/OKhN51UXjMJL5keMjKyzmj0+A4pja+dqo3pJ0GDgTISsHG3RZyk1ANql5M7wJW9y35t5yMw84bF5e7xLSwri3Af+c3db1HQ



On 2/9/24 19:16, Kees Cook wrote:
> The size of the imsf_slist_flex member is determined by imsf_numsrc, so
> annotate it as such.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   include/uapi/linux/in.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> index e682ab628dfa..445f6ae76f1e 100644
> --- a/include/uapi/linux/in.h
> +++ b/include/uapi/linux/in.h
> @@ -199,7 +199,8 @@ struct ip_msfilter {
>   	__u32		imsf_numsrc;
>   	union {
>   		__be32		imsf_slist[1];
> -		__DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
> +		__DECLARE_FLEX_ARRAY_ATTR(__be32, imsf_slist_flex,
> +					  __counted_by(imsf_numsrc));
>   	};
>   };
>   
