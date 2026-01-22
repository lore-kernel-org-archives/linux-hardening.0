Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476537996C
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 02:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048104; cv=none; b=gLJYyG7TtgUEnjsDixfSpVQ8afVMiB2bFP/fnzHc1v1ot2Maeurc2HluCz+2Fey5ofdBTIIZ5DTzQE+PlYrb+hwCzTQB+QcUuaCRmtWQLNwz7Mltx27D3pJKupyzwqEicvvjti9WGT7I2SfCx/RU5+wWSxyMYpU0N14ZfGz3sqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048104; c=relaxed/simple;
	bh=h9M9iejN2fNw9L397Nklz5vHxUPILS2WL8w6Xt8gB9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPhmoOKTOEYMQlnUUpR559JTBe0x834LJchtFCcrT1900u99pGtjSFcD9d8O5KODZ+aJc5FDmpC/aLsS2w5xJxcNpoh2EAip94s2uF1I4Sa8ex5VokcO3es3bqQqhj0FhOF1Chiaoy/+JPdGOmQFUS9Q3ge0xpLnXK2uDPRGzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=cCM2dTBh; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cCM2dTBh"
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id ig9OvNQxhKjfoikDpvpsnT; Thu, 22 Jan 2026 02:14:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ikDpvZS7eh8QWikDpvwuYY; Thu, 22 Jan 2026 02:14:57 +0000
X-Authority-Analysis: v=2.4 cv=Mcdsu4/f c=1 sm=1 tr=0 ts=69718821
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=aEbNOhhS7pL/zVeD3/sqyA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7T7KSl7uo7wA:10 a=_Wotqz80AAAA:8
 a=mjzrLmHcpWlQMXoV4ikA:9 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EJjitEleMxbmwXm5E0QeOux0F1n5t7iK35YezCN8Gzc=; b=cCM2dTBhIkc0LvIKmXqeooENE7
	4eMWtUqSxl1aNPU8EqYmrX8P/Q3/6BNo8dgd3jihO8d3sfP2BKMFLCSUTu41JB9QGULcdA/S1eSEv
	EPC77KDmnZuyYxtTSUx1Oah6NTrstVZxLkQ1LLSpK6d00fT6emmBFPFsuu+kYvWQYnhEJka/1QYGx
	o5o6+iXFdS9KVEFbKgwhPxuPZAHjf8fohvaVYP5Ci0PJhGIDfScy2FfvobqnmJMheRAiS09NBCYCK
	YGF8bUpyWMdAsjxYEyH2v+jX7nveltdgUM5r2G8Zqse8rtdH27/DX5Aozlm7G7ZfyUGVr1E9GFZ31
	jMAnq8JQ==;
Received: from m014013038128.v4.enabler.ne.jp ([14.13.38.128]:20643 helo=[10.79.109.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vikDm-00000002iYL-3kYy;
	Wed, 21 Jan 2026 20:14:55 -0600
Message-ID: <09efbade-24ce-4e11-ab4e-782eab4f1a71@embeddedor.com>
Date: Thu, 22 Jan 2026 11:14:41 +0900
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
 <2fc0de60-6450-4ea3-957b-5de465a2313d@embeddedor.com>
 <1eb019f4.1033.19be352bf0c.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <1eb019f4.1033.19be352bf0c.Coremail.slark_xiao@163.com>
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
X-Exim-ID: 1vikDm-00000002iYL-3kYy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: m014013038128.v4.enabler.ne.jp ([10.79.109.44]) [14.13.38.128]:20643
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIo6+nN36fkoOJCXB1UkR4u8iMRh6wFm9HU7IViQ6AUHaz33z4vVmboQQITsx43fs8caYIazOhsYxno7ykUwkAAFzZ1Y7f9a1ZqNaRpZ8/25hfuL+egt
 wK8eJXCio6a/9xj3zHNRnwTuc+NAxRES6lwDkhGhtU3LswKTq43kS/7bNGXuwT9fGkHJN9ACQzwxO/URlNzD+0xqUts9vX0B7oh8lS43PzmrT6aJfIvxImAo



On 1/22/26 10:30, Slark Xiao wrote:
> 
> 
> At 2026-01-20 17:28:42, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>
>>
>> On 1/20/26 18:16, Slark Xiao wrote:
>>>
>>>
>>> At 2026-01-20 15:51:57, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>>> Hi Slark,
>>>>
>>>> On 1/20/26 16:20, Slark Xiao wrote:
>>>>> This reverts commit eeecf5d3a3a484cedfa3f2f87e6d51a7390ed960.
>>>>>
>>>>> This change lead to MHI WWAN device can't connect to internet.
>>>>> I found a netwrok issue with kernel 6.19-rc4, but network works
>>>>> well with kernel 6.18-rc1. After checking, this commit is the
>>>>> root cause.
>>>>
>>>> Thanks for the report.
>>>>
>>>> Could you please apply the following patch on top of this revert,
>>>> and let us know if the problem still manifests? Thank you!
>>>>
>>>> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
>>>> index 1d7e3ad900c1..a271a72fed63 100644
>>>> --- a/drivers/net/wwan/mhi_wwan_mbim.c
>>>> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
>>>> @@ -78,9 +78,12 @@ struct mhi_mbim_context {
>>>>
>>>>    struct mbim_tx_hdr {
>>>>           struct usb_cdc_ncm_nth16 nth16;
>>>> -       struct usb_cdc_ncm_ndp16 ndp16;
>>>> -       struct usb_cdc_ncm_dpe16 dpe16[2];
>>>> +       __TRAILING_OVERLAP(struct usb_cdc_ncm_ndp16, ndp16, dpe16, __packed,
>>>> +               struct usb_cdc_ncm_dpe16 dpe16[2];
>>>> +       );
>>>>    } __packed;
>>>> +static_assert(offsetof(struct mbim_tx_hdr, ndp16.dpe16) ==
>>>> +             offsetof(struct mbim_tx_hdr, dpe16));
>>>>
>>>>    static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim,
>>>>                                                      unsigned int session)
>>> This patch won't introduce previous problem.
>>>
>>
>> Thanks for confirming this.
>>
>> I'll turn it into a proper patch.
>>
>> -Gustavo
> Hi,
> Are you planing to add this revert commit to your coming patch?

No. I think the revert should be applied by the maintainers, first.

Thanks
-Gustavo

> Actually it's urgent to revert this change since the release deadline of v6.19 is coming soon
> and all my MHI WWAN device have been impacted.
> I don't know why this commit has been tagged as "Not Applicable" and who did this.
> 
> I hope we can fix it regression before the official v6.19 release.
> 
> Thanks

