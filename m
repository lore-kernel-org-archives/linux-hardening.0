Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED096254AE9
	for <linux-hardening@vger.kernel.org>; Fri,  9 May 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817870; cv=none; b=TJhEPWW78NKoKGYmbC3pE/z2w0Sr/VKdQWIZgI/95OPgKtEhUrchhPwp9rH3YrS6poEX4GmWlat4YHb+jp58Iu47XMq8cMegS+HHYC/Ne7IIR+7PDEPRpGUjXtzVdjROAYevHUKv5Oa6/0V6w5C3WA26/P5xAM9q0n33AWc2Uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817870; c=relaxed/simple;
	bh=3oFbcPq/LmpRi6imEmgZsdbNy/2ZZrBkRnQhQopsbAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gb+8QVEZI+JF+m2ZjuYu6tY+rY0petCxg2plu37DnfZIyL0peq9ue5MrHLTI08i5wbCXRVM22RpJQGNev5oLVFPrtwpa16hoVQIfj+NI8qJGaRjX17RK27juOemjP0ghU8UxTIb1b8Qw77Dk7oRMAf5C49C2qJ6jJVtO7lrFGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jgjuaADv; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jgjuaADv"
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id D1MmuvHjQzZPaDT7ju6pXU; Fri, 09 May 2025 19:11:07 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id DT7jurfEJh9ZxDT7ju9YHs; Fri, 09 May 2025 19:11:07 +0000
X-Authority-Analysis: v=2.4 cv=GODDEfNK c=1 sm=1 tr=0 ts=681e534b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=dZbOZ2KzAAAA:8 a=stkexhm8AAAA:8
 a=GZsA4xnBWax8gLnPL8AA:9 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
 a=pIW3pCRaVxJDc-hWtpF8:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=unaJtBXX3ic/M7Mptke85HD19Mt1Q7wftiHK6u0Qhp0=; b=jgjuaADvBq5PnCf7F7GTxnqZqK
	TZM3oe/5n40OE1mBxnyCqZQFECwsTY5oe7I3uInDIzJinDph/28wo+bENu1lsvj2ppPwq5rf8Viyo
	OP1gsh8KmhTmLFIZ6VxZHhjF3YFJSaHpDS9CHZ4zv4c3+R6WReDbO8x44moCxD2zEf7tnTBt87DkJ
	9U5j15rvWJENBHeeFM+dl9XoKTTP2dM3IjFmTmuNV13FO6MBP3UDYW8CSFL3vJQdOhvoTpDhqEmdC
	v6U4J3TONYO/yIQQZc9ZyNfr/4Y8S/M4x/yY/Al5s7xUstGMGc4oy881wt1dtX1ImmlaEVsV2N0Uw
	tEVCyzmA==;
Received: from [177.238.17.151] (port=60388 helo=[192.168.0.102])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uDT7i-00000004KcA-0hDg;
	Fri, 09 May 2025 14:11:06 -0500
Message-ID: <12490f84-6b0c-41c0-9129-f02ccbeaa24c@embeddedor.com>
Date: Fri, 9 May 2025 13:10:56 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Set n_channels after allocating struct
 cfg80211_scan_request
To: Kees Cook <kees@kernel.org>, Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+4bcdddd48bb6f0be0da1@syzkaller.appspotmail.com,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250509184641.work.542-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250509184641.work.542-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uDT7i-00000004KcA-0hDg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.102]) [177.238.17.151]:60388
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIhAwPNAaSo+8s996WgMvej6B5R3ndjEBCHGw73yDsIpadL1D9WGHEdNzckLwG3oKN1WXTRnAz5Q/27DnR1EmnaUzWANhI3lOoBLsNGaN5FtMJOrMQQH
 07xpD4CVQzk65XZciEKRkfQD+ydAjHELsHJWiDaIC3k/NM0shh2vOT7jt8GLQKaNZK5l4I1zmR5xi0AX7mVcZzLr4014SN0fC/SusMYTwJTCG1VlFV0v7l/o



On 09/05/25 12:46, Kees Cook wrote:
> Make sure that n_channels is set after allocating the
> struct cfg80211_registered_device::int_scan_req member. Seen with
> syzkaller:
> 
> UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:1208:5
> index 0 is out of range for type 'struct ieee80211_channel *[] __counted_by(n_channels)' (aka 'struct ieee80211_channel *[]')
> 
> This was missed in the initial conversions because I failed to locate
> the allocation likely due to the "sizeof(void *)" not matching the
> "channels" array type.
> 
> Reported-by: syzbot+4bcdddd48bb6f0be0da1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/680fd171.050a0220.2b69d1.045e.GAE@google.com/
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Edward Adam Davis <eadavis@qq.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: <linux-wireless@vger.kernel.org>
> ---
>   net/mac80211/main.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 741e6c7edcb7..6b6de43d9420 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1354,10 +1354,12 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   	hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_MONITOR);
>   
>   
> -	local->int_scan_req = kzalloc(sizeof(*local->int_scan_req) +
> -				      sizeof(void *) * channels, GFP_KERNEL);
> +	local->int_scan_req = kzalloc(struct_size(local->int_scan_req,
> +						  channels, channels),
> +				      GFP_KERNEL);
>   	if (!local->int_scan_req)
>   		return -ENOMEM;
> +	local->int_scan_req->n_channels = channels;
>   
>   	eth_broadcast_addr(local->int_scan_req->bssid);
>   

