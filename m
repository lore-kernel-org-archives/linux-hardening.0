Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315937B40C
	for <linux-hardening@vger.kernel.org>; Mon, 14 Sep 2026 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364543; cv=none; b=ALo82ej+rHpQCwoP69A6Twzf650dpTmZjltKVu1QWqokVTyJewf5/SIUiHcgS1zvBaj7vckXi0VO3FjHUFGJ2s+pJr9L9s4R2l/WpJYjC9apFRrZIKUizy4rNGdCFokaEmop+e77/0ERvzuPVwTIIJkqZmljEkCOrbvGmOHuJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364543; c=relaxed/simple;
	bh=z0glGIuBNzWKc1iOxR6Z9tZnSi8z1/HHqKj6IpKEYaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUbgGQOCbIZjoezHdIc2g1hag9bPjg06Cg3luHkGgHF/NCrvnl6KqSwt58f0gZhWEIGyIXGHD/Dum1oFopPHxXMTUkVX52FbgB1dqrjmWhYdDamolpqW8/UgzBSnWDYa2lDjGXN7JIGS3G7xk2myjMjlde7BvA2bVrH8HJyc02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=aCW9FG2z; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="aCW9FG2z"
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id 5vzHxyaqTv0nd5zSOxXfVq; Mon, 14 Sep 2026 05:42:20 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 5zSMxOcoOF2DA5zSMxKUJL; Mon, 14 Sep 2026 05:42:19 +0000
X-Authority-Analysis: v=2.4 cv=FaM3xI+6 c=1 sm=1 tr=0 ts=6aa7893b
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VSUqd2-QvgQJ3Wj9IooA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=trdCXU9qDUDUsWDOAU5LiSOzE7DFuDct3tTNYESdXB4=; b=aCW9FG2z4NvY
	R+nSOTVpW0hgplIMbpZNslfcnaB1wjw53rmzTolwUsIKsFpZRXcw84YTAmrVfVxkqdEiMs57LTLLo
	zIVc4oC/pZV7HUQpElXIoYmxLZywaoUN/0uarr6jFxcOftl/Nr35cvxsYPG11iXeMjWXZF3l6oMi6
	rjq5UUysXqCYjcF6lgz3d2EnpV0Nl4mUfQLY466Gn9tqYe8v+EALk9qYPR2bxecAo9s9vl5fWDwhP
	v98C3DhiEoNLu8oVJsHb0p2ZXCqdWE/pedfP/wBXS/OxZJL2BnhAzquY+ww/OMc40BdecTfAbc5Nq
	XiJp7BQiPwYQX781mJQp7Q==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:57896 helo=[10.203.100.11])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x5zSJ-00000003koE-3C5B;
	Mon, 14 Sep 2026 00:42:15 -0500
Message-ID: <fc4e5815-56da-40df-b3f5-dbf6e0470b1b@embeddedor.com>
Date: Mon, 14 Sep 2026 14:42:06 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ip_tunnel: initialize `options_len` before
 referencing options
To: Gris Ge <cnfourt@gmail.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260913090851.468216-1-cnfourt@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260913090851.468216-1-cnfourt@gmail.com>
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
X-Exim-ID: 1x5zSJ-00000003koE-3C5B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.11]) [125.195.69.90]:57896
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI+IkOCr4XpPg89LeDSX4425VZOcuJ/u6elr4Ff66CkRwJLCv2F1zVN7MXZcIlxR+tpTB16zSs1tRXEDFsqj4AVBY7vc807gfrG3cqDcPQuX91N+wHuf
 mDrzs5+i9ahpKpomhN2/MwkUd5Eet8cBCN/Il3xa3I6N2vLvHiitAq7PtV2aTopPbWdSBTi9y8LyPcf4oK3BDhdC80DrvCeLxxnhQUCq+vTgzWKwNLKC1sLo



On 9/13/26 18:08, Gris Ge wrote:
> The following command triggers a kernel panic:
> 
>    ip link add d0 type dummy; ip link set d0 up
>    ip route add 10.30.0.0/16 \
>      encap ip id 300 geneve_opts 4660:66:11223344 dev d0
> 
>    memcpy: detected buffer overflow: 4 byte write of buffer size 0
>    kernel BUG at lib/string_helpers.c:1044!
>    ...
>    ip_tun_parse_opts.part.0.cold+0x10/0x10
>    ip_tun_build_state+0x116/0x2a0
> 
> On kernels built with GCC 15+ and `CONFIG_FORTIFY_SOURCE`, the fortified
> `memcpy()` got 0 sized destination with request of 4 bytes length:
> 
>    static int ip_tun_parse_opts_geneve(...)
>    {
>        ...
>        attr = tb[LWTUNNEL_IP_OPT_GENEVE_DATA];
>        data_len = nla_len(attr); /* == 4 */
> 
>        struct geneve_opt *opt = ip_tunnel_info_opts(info) + opts_len;
>        memcpy(opt->opt_data, nla_data(attr), data_len);
>        /*     ^^^^^^^^^^^^^ 0 since options_len is assigned afterwards */
> 
> Fixed by initializing the counter before the options are referenced.
> Matching what `tunnel_key_opts_set()` already does.
> 
> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gris Ge <cnfourt@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
> v2:
>    - pass opt_len into ip_tun_set_opts() and initialize options_len there,
>      matching tunnel_key_opts_set(), as suggested by Eric Dumazet.
> v1: https://lore.kernel.org/netdev/20260912055304.1415016-1-cnfourt@gmail.com/
> 
>   net/ipv4/ip_tunnel_core.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index 5168d546ea2f..bab42b9e277f 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -680,8 +680,14 @@ static int ip_tun_get_optlen(struct nlattr *attr,
>   }
> 
>   static int ip_tun_set_opts(struct nlattr *attr, struct ip_tunnel_info *info,
> -			   struct netlink_ext_ack *extack)
> +			   int opts_len, struct netlink_ext_ack *extack)
>   {
> +	/* `options_len` is the __counted_by() annotation of the `options`
> +	 * flexible array, it must be initialized before parsing writes
> +	 * into it.
> +	 */
> +	info->options_len = opts_len;
> +
>   	return ip_tun_parse_opts(attr, info, extack);
>   }
> 
> @@ -712,7 +718,8 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
> 
>   	tun_info = lwt_tun_info(new_state);
> 
> -	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, extack);
> +	err = ip_tun_set_opts(tb[LWTUNNEL_IP_OPTS], tun_info, opt_len,
> +			      extack);
>   	if (err < 0) {
>   		lwtstate_free(new_state);
>   		return err;
> @@ -753,7 +760,6 @@ static int ip_tun_build_state(struct net *net, struct nlattr *attr,
>   	}
> 
>   	tun_info->mode = IP_TUNNEL_INFO_TX;
> -	tun_info->options_len = opt_len;
> 
>   	*ts = new_state;
> 
> @@ -1006,7 +1012,8 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,
> 
>   	tun_info = lwt_tun_info(new_state);
> 
> -	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, extack);
> +	err = ip_tun_set_opts(tb[LWTUNNEL_IP6_OPTS], tun_info, opt_len,
> +			      extack);
>   	if (err < 0) {
>   		lwtstate_free(new_state);
>   		return err;
> @@ -1040,7 +1047,6 @@ static int ip6_tun_build_state(struct net *net, struct nlattr *attr,
>   	}
> 
>   	tun_info->mode = IP_TUNNEL_INFO_TX | IP_TUNNEL_INFO_IPV6;
> -	tun_info->options_len = opt_len;
> 
>   	*ts = new_state;
> 
> --
> 2.55.0
> 

