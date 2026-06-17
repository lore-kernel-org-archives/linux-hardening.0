Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A73379C34
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jun 2026 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726996; cv=none; b=RyAoyY1h3a972mGjTdqaT9aElAGlmGUdOdGlRbQgyay2ib45kjPQ8WAw6BBOwxaCIc8pNdlLYDtk51XBcWy1Uu7vxKQYyfCzW96bsQyGftGqFBSQEAQUFUEBPkXceBKDaDq47d5SCRj+gvYSTpi1kX8yOTgeDwU/kIf0fUmsfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726996; c=relaxed/simple;
	bh=36+PfgVOCJz9I5g25FTpnJjvcwXaWyeCjgldF1a0y7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHv/XvzCB+v0qbS3P6kvVqB9Lu0qSagktBdYn3LVNEo413k2EC1MZ3fAJX7svacYrBDYk2G+rCwdnZOR1/C338BQ/lqLCxmohjoBpO77ATmIpABHrdh44rIy3bBKF0NoqBVGlO7c6Ax4C+l+iXmwiosqnOaESvVeKcRmng8EeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=StymiaLZ; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="StymiaLZ"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id ZvYUw7sIiKSRRZwa5w0f2E; Wed, 17 Jun 2026 20:09:49 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id Zwa3wKShB5zk0Zwa4wYung; Wed, 17 Jun 2026 20:09:48 +0000
X-Authority-Analysis: v=2.4 cv=GPEIEvNK c=1 sm=1 tr=0 ts=6a32ff0c
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=P8mRVJMrAAAA:8 a=mo7Kl4tTlkleSoc0kBUA:9 a=QEXdDO2ut3YA:10
 a=Vc1QvrjMcIoGonisw6Ob:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qt2TBGgT0bGtpqlS+Vx9gxbeasYa2lJIaTGRkbloxyg=; b=StymiaLZM5OJYxj7Rg11G9QXlQ
	OsiofZK7qxxwbZEeTH/JdyMTD1O5/SkowgUfUYaAR8WwXqgNN9CMicQleDqZUQf67uSyW4ZPO9TMQ
	wfj8fMN+OYSr+OlSKOgiMyC1DR3ffPT1h5dI4LTw1tZf6UxDu7lZ5gbjsjyWYw5YkJJcHaJJf+Hsf
	2aMRdwDBirbpUiOMgH1KkVVlNCklxLBMudhDYVAtYeoV+BHP1w9PJJnT55wuFlPtwobDcZ2mGIPND
	UoSpEaj8GcYePyxS5g/6HsVjc8P4ixO7hYV3YRg8aBn4+j/8tkVk87PXAC6phzFohtL16g8xHa1o+
	eUo3umTg==;
Received: from [177.238.16.65] (port=57678 helo=[192.168.0.12])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wZwYb-000000037XB-2Mbf;
	Wed, 17 Jun 2026 15:08:17 -0500
Message-ID: <9e941b82-23d4-44e6-a240-b7949ace76ab@embeddedor.com>
Date: Wed, 17 Jun 2026 14:08:07 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow
 in tun_dst_unclone
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, Johan Thomsen <write@ownrisk.dk>
References: <20260616100332.1308294-1-i.maximets@ovn.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260616100332.1308294-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.65
X-Source-L: No
X-Exim-ID: 1wZwYb-000000037XB-2Mbf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.12]) [177.238.16.65]:57678
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK4msBJyydVch8upwR9K5P5DscTLJwFG6MkdAeGEGnNpJzf1fwEJOnJiEq1X+R3ivlJUpQ0oqgsnziBGByWEnWsIc4ioqA/dRjmvu7gn92PX0e/FQpn3
 86DrIs/SlNWxui2rAgukvKJSX9TQa8rD6BWzHREhAAkfJUCJcTUsBr0oEcas2rN7FdT+znlfx6ymrsSTx7zKSMAaervdG0I8Pif1KV5meOc+PGAUZBAn120U

Hi,

On 6/16/26 04:03, Ilya Maximets wrote:
> kmalloc_flex() in metadata_dst_alloc() sets __counted_by for the
> structure to the options_len, which is then initialized to zero.
> Later, we're initializing the structure by copying the tunnel info
> together with the options, and this triggers a warning for a potential
> memcpy overflow, since the compiler estimates that the options can't
> fit into the structure, even though the memory for them is actually
> allocated.
> 
>   memcpy: detected buffer overflow: 104 byte write of buffer size 96
>   WARNING: CPU: X PID: Y at lib/string_helpers.c:1036 __fortify_report
>    skb_tunnel_info_unclone+0x179/0x190
>    geneve_xmit+0x7fe/0xe00

This warning has nothing to do with counted_by. See below for more
comments.

> 
> The issue is triggered when built with clang and source fortification.
> 
> Fix that by doing the copy in two stages: first - the main data with
> the options_len, then the options.  This way the correct length should
> be known at the time of the copy.
> 
> It would be better if the options_len never changed after allocation,
> but the allocation code is a little separate from the initialization
> and it would be awkward and potentially dangerous to return a struct
> with options_len set to a non-zero value from the metadata_dst_alloc().
> 
> Another option would be to use ip_tunnel_info_opts_set(), but it is
> doing too many unnecessary operations for the use case here.
> 
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Reported-by: Johan Thomsen <write@ownrisk.dk>
> Closes: https://lore.kernel.org/netdev/CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com/
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
> 
> Johan, if you can test this one in your setup as well, that would
> be great.  Thanks.
> 
>   include/net/dst_metadata.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 1fc2fb03ce3f..f45d1e3163f0 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>   	if (!new_md)
>   		return ERR_PTR(-ENOMEM);
>   
> -	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> -	       sizeof(struct ip_tunnel_info) + md_size);

What's going on here is that, internally, fortified memcpy() retrieves
the destination size via __builtin_dynamic_object_size() in mode 1.

That is:

__builtin_dynamic_object_size(&new_md->u.tun_info, 1)

For the above case, Clang returns sizeof(new_md->u.tun_info) == 96.

So the warning is reporting that 104 bytes don't fit in an object of
size 96 bytes, regardless of any counted_by annotation or allocation.

Of course, in this case, the write of 104 bytes into new_md->u.tun_info
is intentional and controlled, but what if it weren't?

On the other hand, for this same case, GCC currently returns SIZE_MAX,
which translates to -1 inside fortified memcpy(). Thus, bounds-checking
is bypassed, which is why this warning doesn't show up with GCC.

However, this is a bug in GCC. We're already looking into that.

I think we've had just a handful of cases like this across the whole
kernel tree. We can deal with them as you did here (by directly copying
the composite structure first, and then using memcpy() to copy into the
flexible-array member). If these cases ever become more common, we
could create some kind of helper to do both things at once. :)

> +	/* Copy in two stages to keep the __counted_by happy. */

So based on my comments above, this code comment is not correct.

> +	new_md->u.tun_info = md_dst->u.tun_info;

This is fine.

> +	memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
> +	       ip_tunnel_info_opts(&md_dst->u.tun_info), md_size);

Is ip_tunnel_info_opts() really needed here?

Probably this works just fine:

memcpy(new_md->u.tun_info.options, md_dst->u.tun_info.options, md_size);

-Gustavo
