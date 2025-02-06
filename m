Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4953237705
	for <linux-hardening@vger.kernel.org>; Thu,  6 Feb 2025 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738884231; cv=none; b=W9mPdy9TQsq4QHZ7UlaKluR1Ins7lE1F86dDyVpSkxMn+1lpRBT0rLDXx4CBWlIszIgwst0HL34lrQhTyIH348cydL7SaeGYxVK3NvgwLc1W05x7AxbqG4op+hIj/qFHABcskTS10czhATLqar9F4ivsMsZLpxLMJuUx2Y27P/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738884231; c=relaxed/simple;
	bh=V2hDQVZfXi10myODsQHJDr1PrZbrGGSvhhbd4aHROEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k72qdoitqqSui5N7kVbqCg1VUHm0smde9LxLwm7D8AV+sAE/cjhdl5sr6pVy3mL6ga+eQy7uc9EB7DcSbhFY3/+SVAnDAfxBNVp3cTgWmQWxJWf4iMcwi8yeyWrVIh3hRW/Lh7HLzv4Z6Ko9nANddvBKREcS5fBX5Z2y47g2L+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=oUlCs0qD; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="oUlCs0qD"
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id g6ActHwlViuzSgBDjtZS4M; Thu, 06 Feb 2025 23:23:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id gBDitP94Gh3xvgBDitgSnq; Thu, 06 Feb 2025 23:23:42 +0000
X-Authority-Analysis: v=2.4 cv=F+ZRdLhN c=1 sm=1 tr=0 ts=67a5447e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=KZ9MsSxUvLdQbKA6SOoA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mfsvnhoslxgxndnAvhSW95+TCDLQ1GuITfG+HDlgT28=; b=oUlCs0qDbMdKAYj2+6uqMqJRrx
	MsZZvofjojXYWNPk8Z9owrj4Z14wf5sSw7Qkb7NTbyTQkcGkiIJB7o/f8MoSaoJcPVRUkF4qf0ayz
	EFlEHL9GgxMa+g6NQQlRFlEcgv771zEKpm1Ec3LerlutSiy3FhhR0SNtxY5TlMB4aJUwrcNBZqH5S
	XM/unbiol57DAa9ErB4zxTiA8rBEV+WvffsFtnrg11k1GbHmrTGVMvKeoXSyEYv0EHrp+NOQnimQH
	FTXrnEi42x9+5lxm6g52j5Dhf9S5R6jFnXxmfqiq2e67gDhZLU099ELKkF/TdUs1rErgH0lQ8bUso
	z3eaR1GA==;
Received: from [45.124.203.140] (port=54722 helo=[192.168.0.152])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tgBDg-0025YQ-2y;
	Thu, 06 Feb 2025 17:23:41 -0600
Message-ID: <7c396d56-a2ea-4cb5-8a10-a2b78cebfaeb@embeddedor.com>
Date: Fri, 7 Feb 2025 09:53:30 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6QvAZxiQusdaDkH@kspp>
 <2025020633-irritate-boogieman-4c35@gregkh>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <2025020633-irritate-boogieman-4c35@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tgBDg-0025YQ-2y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.152]) [45.124.203.140]:54722
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEuZrbVVd4LE3jW3HnQZQqziDBacVwLutCz0v72n/h+WFoK7gcc54c8RxAadhudqnAqV8fg94qqW05THeW1KdQS3QU5jk4TGxK5q5KJoBjq9nEtQNeRo
 17Ek+GyFG0MD5GTL9HasWK4iqFG2u8BS86HSKEZ+KKLS8Js5Yvb8ooad6RNLQCXmPjau0Km3YTZ7gE9kAYf90f9xDwltA/a7yiXXoUUv3AD0hMtihGaHo9T4


>>   	unsigned int used;
>>   	unsigned int size;
>>   	unsigned int commit;
>> -	unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
>> +	unsigned int lookahead; /* Lazy update on recv, can become less than "read" */
> 
> Coding style change?

(Whaa? for some reason your response didn't reach my inbox until today)

It seems I got a bit too proactive.

What do you think about the rest of the patch?

Thanks!
-Gustavo

