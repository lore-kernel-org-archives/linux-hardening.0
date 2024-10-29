Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B24AEE0
	for <linux-hardening@vger.kernel.org>; Tue, 29 Oct 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225944; cv=none; b=ANSxqgA/qCjT70jttSn6ovYF9EotKy1yvt7FRucBzusF7oVmlXKGuLYEjEe3gENDCVcB5WVY8eY7cfzO8EeQRgbSMHU/hH3xz9k5ptgnWrypWeqbMk+Q7Ll1H92Pg6i2YghU7E8nONoq+18dlVpCg3H4AlzTGa6T/BemAFxWETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225944; c=relaxed/simple;
	bh=M8nO+24c9/sZhugffBVh2gB7Qf7X5ZyZC5VgqDZszkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuFTA9J4ISXpWecek6yupVLoNtH6RO7thYwgqQRx5+CA10rRU75dVXMJASyeACyX0Q6mClujczPvHl5KyGYq1vrdKJs5Z7TbS/IsP2jdADWMf3JtG8N1V9e3OJr+A1i/O9WxMkpZBIizYDZQNoeRJfv7g6UXpKUZJuFF5S4VQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=IanhAO3t; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="IanhAO3t"
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id 5p3xt5hSGVpzp5qo1tka6L; Tue, 29 Oct 2024 18:19:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5qo1tfIgITqCN5qo1tEoIO; Tue, 29 Oct 2024 18:19:01 +0000
X-Authority-Analysis: v=2.4 cv=VsQlAf2n c=1 sm=1 tr=0 ts=67212715
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=wqSJOHIl3oKZLvA0N8AA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jkh7Hynmmo6OPSDIRiGWaJAeeoUHiaxp4T+/5j2nWx4=; b=IanhAO3tP6edf9QOzhxnJ+FDd8
	ybDz6AXbLyojyNdGWTeRCH0gnA8ZwV2PBJ9FlIEMpV4ICU4Qy6FjSkaYVCKdBX4Z4NRxB9t8Qmtjk
	0IJsWTj/xzVIXLdEG7c6EDF/Nb6PldmC4aBopgW4e2cdYCxSf1kTUk1rt0b2xRtRsFZasqUKVFlzp
	Zltj2I8aqSS9wuaGV/OXTIWlFqQMnXzQJq+NWV4E/7vp+X/FUzkG5Rr5BoyEKv7jPHvRgXMo+z+rM
	jAypxKT7um8X3FjYwj7H+LDs9bIe21NFLlRJagmIvsbQqMntFVXcj9wFKtnI3r6ZeuiRUS7XMm1Ry
	EOfPsGyA==;
Received: from [201.172.173.7] (port=59846 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5qnz-000DaP-1W;
	Tue, 29 Oct 2024 13:18:59 -0500
Message-ID: <7d227ced-0202-4f6e-9bc5-c2411d8224be@embeddedor.com>
Date: Tue, 29 Oct 2024 12:18:56 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1729536776.git.gustavoars@kernel.org>
 <f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
 <20241029065824.670f14fc@kernel.org>
 <f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
 <20241029110845.0f9bb1cc@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241029110845.0f9bb1cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t5qnz-000DaP-1W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:59846
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLgEevXtq7LRyXKt78EWp5w0oMS0HhKD0UKenx9PxTKkQnUus0t/wfJ/OnRM57y0/5RTAKl07vu+9aPs3Rlwur8238TpnR44uZhk7H2EIYJQ27LQpkoS
 vxmgmmGF6vIcdttM8VdJ386o6QZf7Cw2NvsEbD8IUU6f6wS3ibu1V0o/yCyQ3cS6vFqg4xfcUxjd8MnHT70NFmwBA3lnv16tkeK2HuX+Jhx8in9EcN3KwqJp



On 29/10/24 12:08, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 10:55:14 -0600 Gustavo A. R. Silva wrote:
>> On 29/10/24 07:58, Jakub Kicinski wrote:
>>> On Mon, 21 Oct 2024 13:02:27 -0600 Gustavo A. R. Silva wrote:
>>>> @@ -3025,7 +3025,7 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
>>>>    {
>>>>    	struct bnxt *bp = netdev_priv(dev);
>>>>    	struct bnxt_link_info *link_info = &bp->link_info;
>>>> -	const struct ethtool_link_settings *base = &lk_ksettings->base;
>>>> +	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
>>>
>>> Please improve the variable ordering while at it. Longest list first,
>>> so move the @base definition first.
>>
>> OK. This would end up looking like:
>>
>> 	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
>> 	struct bnxt *bp = netdev_priv(dev);
>> 	struct bnxt_link_info *link_info = &bp->link_info;
> 
> Correct, one step at a time.
> 
>>>> @@ -62,7 +62,7 @@ static int linkmodes_reply_size(const struct ethnl_req_info *req_base,
>>>>    {
>>>>    	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
>>>>    	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
>>>> -	const struct ethtool_link_settings *lsettings = &ksettings->base;
>>>> +	const struct ethtool_link_settings_hdr *lsettings = &ksettings->base;
>>>
>>> here it was correct and now its not
>>
>> I don't think you want to change this. `lsettings` is based on `ksettings`. So,
>> `ksettings` should go first. The same scenario for the one below.
> 
> In which case you need to move the init out of line.

So, the same applies to the case below?

	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
	struct bnxt *bp = netdev_priv(dev);
	struct bnxt_link_info *link_info = &bp->link_info;

Is this going to be a priority for any other netdev patches in the future?

--
Gustavo
