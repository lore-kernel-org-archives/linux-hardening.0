Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C83154BFC
	for <linux-hardening@vger.kernel.org>; Fri,  1 Nov 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494029; cv=none; b=qld2B4AaXPcQnqhHYozzo+BFGs3bT1CzQUqyTNEvWVc8KDlingOBNBsWgorl6Ji4vv2aV8oiKr4NrIEWTNDWMKepQ53B/I3Q0Xsv4zvFdHJIRtBopmLX1Ytbi7sGHrPHl3ktqzQrkItT3r74S5a9w+qN57QaKfEqpwJQV5mBGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494029; c=relaxed/simple;
	bh=YjrdHHWPygCe3Tc91Skobz0JFEZpvAIk6PPlQqladDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M33FAGjVcfGpIT6mh9RH06sMV3rv9efhHwjtZYggXD5shCEJ9IkvGcIvb38aCPMRmngfpsvjSKpHz2aTi4h/Op1cVvCBeEavLpppQ+GFACE6wRda2fOpc22ueVkY1VtFxJYwqSDahjMgxbNCaGavC7yDqo20ckpH1LLuBnr6HWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=za8byT+J; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="za8byT+J"
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id 6nVktqER9umtX6yXttfDOh; Fri, 01 Nov 2024 20:47:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 6yXstTcsY2Zy06yXstzsIu; Fri, 01 Nov 2024 20:47:00 +0000
X-Authority-Analysis: v=2.4 cv=Q4EZ4J2a c=1 sm=1 tr=0 ts=67253e44
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=wK7pc38KeiHN8xZw7ncA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xkm1nD8TrvBAERDn/msYL9E1SOOvU/GM4tbcKD0/Xvo=; b=za8byT+JHW/OuZ3qlgIE7q+J5H
	XM0IdHIEEaEzP9eWLq7jLmsLp0GUCflqfKs5YAkBhwB75NBoZLgVQCNNxUIz3S+vANpzqrFSzCKuy
	mQSXGAHZBEwPMo7B3T744Y0JgZTsCOyhxgHaHFtK2e5d6Gpmd1f/xNoIsuB7NSw0icDqLcnQBH5OM
	F0T7bsq6EczEWJ7A9cxd2pAtT0mrnbO9npQZrxQiUmp/T863zc4ryRCDOM6Z5JsVc4VUV6UMrEs9/
	lJw5roOdcGKfJZhj8TMS1r10kOIaPLZqa1QLIHyIsIZasjEGyV7Y1/0vQPI9ELE6CRVvIlbVxs2ba
	0KjimPTQ==;
Received: from [177.238.21.80] (port=22208 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t6yXr-003xjs-1M;
	Fri, 01 Nov 2024 15:46:59 -0500
Message-ID: <cc312432-bc9b-4dea-8f99-9c2ebf0d47a7@embeddedor.com>
Date: Fri, 1 Nov 2024 14:46:56 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] jbd2: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
To: Jan Kara <jack@suse.cz>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZxvyavDjXDaV9cNg@kspp> <20241031123313.dfcuttwzzs5f5i7a@quack3>
 <fe0e9c86-fa44-425e-a955-aa9e401b6334@embeddedor.com>
 <20241031213208.gzr5jv2kg5eobjuo@quack3>
 <ca7be9f4-3f33-48ba-b61a-0a40ea1f17a6@embeddedor.com>
 <20241101101512.eee2nkaqgffsoxe3@quack3>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241101101512.eee2nkaqgffsoxe3@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1t6yXr-003xjs-1M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.21.80]:22208
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFDFlu+iY1w6UcUN5t1zJISJ0R8A5YD6swe9MacUtD9kefm4abzeYleQQSFoTMc+A9B8qLnZPEKRgje1+n0Sq860tQZJlGT8G5qr2hjZDFrfnehENS7c
 fqmYlSeSLrZyMTNa/MDZ2rKPPInUQKM2qgDc57a/Nef9d1MgyCALZ1x22MB//H/Hw6zTPTjKKmqkEd8EopoUJSJaMxPJLjuE6WMBn4fDkXFJUkMjspckGtP6



On 01/11/24 04:15, Jan Kara wrote:
> On Thu 31-10-24 17:31:34, Gustavo A. R. Silva wrote:
>> On 31/10/24 15:32, Jan Kara wrote:
>>>
>>>> `sizeof(ctx) == 4` when `char ctx[JBD_MAX_CHECKSUM_SIZE];`
>>>>
>>>> To maintain the same size, we tell `DEFINE_RAW_FLEX()` to allocate `1`
>>>> element for the flex array, as in 32-bit `sizeof(void *) == 4`.
>>>
>>> So I agree we end up allocating enough space on stack but it is pretty
>>> subtle and if JBD_MAX_CHECKSUM_SIZE definition changes, we have a problem.
>>> I think we need something like (JBD_MAX_CHECKSUM_SIZE + sizeof(*desc->__ctx)
>>> - 1) / sizeof(*desc->__ctx))?
>>
>> I see. Well, in that case it'd be something more like:
>>
>> -       struct {
>> -               struct shash_desc shash;
>> -               char ctx[JBD_MAX_CHECKSUM_SIZE];
>> -       } desc;
>> +       DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
>> +                       (JBD_MAX_CHECKSUM_SIZE +
>> +                        sizeof(*((struct shash_desc *)0)->__ctx)) /
>> +                        sizeof(*((struct shash_desc *)0)->__ctx));
>>
>> Notice that `desc` is created inside `DEFINE_RAW_FLEX()`
>    Right. Thanks for fixing this. The cleanest option then probably is:
> 
> 	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
> 		DIV_ROUND_UP(JBD_MAX_CHECKSUM_SIZE,
> 			     sizeof(*((struct shash_desc *)0)->__ctx)))

OK. There you go v2:

https://lore.kernel.org/linux-hardening/ZyU94w0IALVhc9Jy@kspp/

Thanks a lot for the feedback. :)
--
Gustavo

