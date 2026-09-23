Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BD3A839B
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142569; cv=none; b=R6LIOGft0SAZlDPR48mAfeGqI4gGAazufx981VXgZNukwDJA4TiomocrNvb3p98e2uncBMAUDMIwyubBNtmsmC1Err6VupEBVkAcbDeIiQo1yKcQbtMHSOBbvdH2Quvgc8ezDmght65xk0dGevU1jkfTkoBJvrI/M9GYDHDSlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142569; c=relaxed/simple;
	bh=704PCO9tRpHwADqRFHO79/OKnaRn28gjGpJwbyPjrWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5JQs7iuEw/u99qU4f1Agi3Djpaz/XBSpbIYXPsBq3mR5tXJeJVKKJKgCUMklKy1uqUI/SUtTWx+97fRz3IxnhBV0eGSoEV/vNfC9YhhYR0+H/6oBmhLyH/dJTcO8A++Uiw2RSmcaMzWHpXfqNOiooFgz3uPoyW72N/H1L06MXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=yzsHqYwq; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="yzsHqYwq"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id 95ilxaalpv0nd9FrDxnHRT; Wed, 23 Sep 2026 05:49:27 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9FrCxyzjEZOPw9FrDxIffD; Wed, 23 Sep 2026 05:49:27 +0000
X-Authority-Analysis: v=2.4 cv=H8Xbw/Yi c=1 sm=1 tr=0 ts=6ab36867
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=iSKem9uEHTndPMaPadgA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Bhfb9Y56ZxdKLlIuR0TJG5mzD8QYu4ucWDxna8mxNeI=; b=yzsHqYwqKzfy
	IT3QL6oSRSVzzTy7ooK6YA8F9tfn+4JgPBwIbjXHrZRdyajEaCcyh4OiQjIgDiQnszPBevMuV2FnF
	TLhlmXj8ioQVCsKDILzIE3vfpVPO2KFK5Ha7iJEhMXYNV0kod8Y230S5zFWeQ6cNA2hR8EpWfYBpD
	5aSbpt2I80Vr9EQ4JJnIA5LYU3lAPAyfC/mb2OQHZILFyw4NyESr+VNgjQ1AjEJUzbmdh7Qa7lfgj
	dYIa925lxYUCLxmIwoeV5yBKwaUfEJ6vN8YsMB1MeI9uznlzOtaggxP2DXtOeF7UAD1RktWnNKnWA
	BmzeeOJT6rZ0P3Ik9bD6vg==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:56274 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9FrC-0000000257W-0dyp;
	Wed, 23 Sep 2026 00:49:26 -0500
Message-ID: <fa45cff7-162e-4ad4-9485-da45690044ca@embeddedor.com>
Date: Wed, 23 Sep 2026 14:49:21 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ieee80211: annotate struct s1g_tim_enc_block with
 __counted_by_ptr
To: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Bryam Vargas <hexlabsecurity@proton.me>,
 Lachlan Hodges <lachlan.hodges@morsemicro.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, codemender-patching+linux@google.com
References: <20260923045233.2579591-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260923045233.2579591-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x9FrC-0000000257W-0dyp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:56274
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 77
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCo7LkQoHyIsOaBVGhFO5x2bLjTrkXtGY8+L5Ws3+tbupO/wAVGIWLnxXkTzvfqxFxv5vLUq0o6S0ApKWnSq0FCkvfL3zzbxoZmm6GDI34+GnJJxQR9w
 i3YZ0IgJjHwULUK4ezs3K4utIVNDNvQhq42h17aBnVNhMMujbi5xfjUrezi/Kl1O1kcN4eANiWHsz4eBYkh5EtMQckG8hBzXeSCYQxUQq/ZCa9vXSxMUWZqb



On 9/23/26 13:52, Bill Wendling wrote:
> The GCC and Clang compilers support the "__counted_by_ptr" attribute on
> pointer fields to associate them with an element count in the same
> struct. This enables KASAN and UBSan bounds checking to detect
> out-of-bounds accesses to the pointer.
> 
> In "include/linux/ieee80211-s1g.h", "struct s1g_tim_enc_block" has a
> pointer member "ptr" of type "const u8 *" whose size is described by the
> "len" member, which is correctly populated with the size of the buffer
> before any pointer dereferences.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   include/linux/ieee80211-s1g.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ieee80211-s1g.h b/include/linux/ieee80211-s1g.h
> index 3f9626ad3d97..8f6107782c38 100644
> --- a/include/linux/ieee80211-s1g.h
> +++ b/include/linux/ieee80211-s1g.h
> @@ -349,7 +349,7 @@ struct s1g_tim_aid {
>   struct s1g_tim_enc_block {
>   	u8 enc_mode;
>   	bool inverse;
> -	const u8 *ptr;
> +	const u8 *ptr __counted_by_ptr(len);
>   	u8 len;
>   
>   	/*

