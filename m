Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25E3D34B3
	for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901347; cv=none; b=tS+BbJF6N23LK/4xX79lVUcAiXwgzqD7k6LekB3p1OJQHuXxdeIzxIJqgVu17Q48NNpT5E2HL7VGU6Et5ZaVT7Mbyr8oorjfgUesi2sq4T4oc3Nhjmt0jbVz3OKk3xKMITGkr/Y8sskm2r9PMtrUri0G6CypNJC3NBcXKdjV4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901347; c=relaxed/simple;
	bh=q49/hLcChwG3b34NnM1NrMFs9uNrYgCvyJaPZCLegSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/pxAs+nMyFTW6sEflMS6voTRRyMpbfS81pssdlsh2HW/3eNprEGOxd++Ni9Vk25eKMXIuM6nSge1a9HxOHJseDqSFauTz+zI5qtU8AIANVcX6MsbGB/RHrctwCcH412fvYVcq99hNHBjc86buatAE9xa7tkuxWEOnamIX/DCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hmxXo8az; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hmxXo8az"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id i5idvnzNjCxrGi82qvPSW3; Tue, 20 Jan 2026 09:29:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id i82qvblFhhoT4i82qvpT3P; Tue, 20 Jan 2026 09:29:04 +0000
X-Authority-Analysis: v=2.4 cv=XZyJzJ55 c=1 sm=1 tr=0 ts=696f4ae0
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=aEbNOhhS7pL/zVeD3/sqyA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7T7KSl7uo7wA:10 a=_Wotqz80AAAA:8
 a=M72KT9Zcp4FLkctT-M4A:9 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MCPkJs+BA/PeK7/336jSUCsPNsuRzDTuTeOM75tvA+E=; b=hmxXo8azTstiWRshB4JILuPjl3
	KYieHqqhRlimxobtiE+T9qj0tG7N4jvr4KE/8QCYnJXoWZxVrzPWtsoDJwongP4Vu4Ztp+qw3+WUa
	lK84E4VJO+R1EZDP/INslQDIespP3GtJOd5RqxfWIBF5jV5g5u75BdAejRaS83n4HGwfbLSRlvikD
	2Od8yvrGtXwVgBLoLEUo+qjmuFYG2QyRtyzJ50xKIJu7CrUCk/eK4fcpC8RFAYJ5bFAooH5OuCNJy
	4asLMv1/083OH6tlFLvubq08xwQ3urGPa1mEV3MgtSMPxxU3zFpXaU7d740+wiwHeVH1uULqeMDdE
	vJWqSfWQ==;
Received: from m014013038128.v4.enabler.ne.jp ([14.13.38.128]:41128 helo=[10.79.109.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vi82o-00000001Bv2-0xbN;
	Tue, 20 Jan 2026 03:29:02 -0600
Message-ID: <2fc0de60-6450-4ea3-957b-5de465a2313d@embeddedor.com>
Date: Tue, 20 Jan 2026 18:28:42 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net] Revert "net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning"
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gustavoars@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260120072018.29375-1-slark_xiao@163.com>
 <1228d107-4a60-4c33-a763-1a199c0b0961@embeddedor.com>
 <5e012074.84f7.19bdab162e4.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <5e012074.84f7.19bdab162e4.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 14.13.38.128
X-Source-L: No
X-Exim-ID: 1vi82o-00000001Bv2-0xbN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: m014013038128.v4.enabler.ne.jp ([10.79.109.44]) [14.13.38.128]:41128
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMWW9SILHUGqewNI5FCP5trPLw1yeaDqS1797BwdEmvdLFKOXundSd+yuDRBO1d+IrVjSaBEPVkXGn7j3HU5fuCqRcxus+Mw6lYdJrfuUJOL2Me+b9VN
 DiGKqrAO+yE9h/3sCbHdhEYYTYQcRl01I0u3ukZF2BQQNCGF8OvbvSb6lqg7xARCswXm8HP0SIza+mTpEdxwzT87wde1W+VY0/mw358DbQYuxLhRZL7Slcow



On 1/20/26 18:16, Slark Xiao wrote:
> 
> 
> At 2026-01-20 15:51:57, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>> Hi Slark,
>>
>> On 1/20/26 16:20, Slark Xiao wrote:
>>> This reverts commit eeecf5d3a3a484cedfa3f2f87e6d51a7390ed960.
>>>
>>> This change lead to MHI WWAN device can't connect to internet.
>>> I found a netwrok issue with kernel 6.19-rc4, but network works
>>> well with kernel 6.18-rc1. After checking, this commit is the
>>> root cause.
>>
>> Thanks for the report.
>>
>> Could you please apply the following patch on top of this revert,
>> and let us know if the problem still manifests? Thank you!
>>
>> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
>> index 1d7e3ad900c1..a271a72fed63 100644
>> --- a/drivers/net/wwan/mhi_wwan_mbim.c
>> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
>> @@ -78,9 +78,12 @@ struct mhi_mbim_context {
>>
>>   struct mbim_tx_hdr {
>>          struct usb_cdc_ncm_nth16 nth16;
>> -       struct usb_cdc_ncm_ndp16 ndp16;
>> -       struct usb_cdc_ncm_dpe16 dpe16[2];
>> +       __TRAILING_OVERLAP(struct usb_cdc_ncm_ndp16, ndp16, dpe16, __packed,
>> +               struct usb_cdc_ncm_dpe16 dpe16[2];
>> +       );
>>   } __packed;
>> +static_assert(offsetof(struct mbim_tx_hdr, ndp16.dpe16) ==
>> +             offsetof(struct mbim_tx_hdr, dpe16));
>>
>>   static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim,
>>                                                     unsigned int session)
> This patch won't introduce previous problem.
> 

Thanks for confirming this.

I'll turn it into a proper patch.

-Gustavo

