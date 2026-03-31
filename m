Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326B3E6DF1
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970956; cv=none; b=Xt2nguqMNX+gj+XXJmjlddwKXTIu1IWKOOroRDdVhrsciA/V/NKjdwMTmtHjAFbAc3lfvLoGJLfkvq5NDBSnMZ7KWkmOrlCwYAG8bVn/5DtePgDr7Y0pTgOWMPLvD2XIsEe+bOd0UfN2qU1PUu+fkaHsXlxOJ+BCCFqLEOotSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970956; c=relaxed/simple;
	bh=RvEdGH+UJoVrxm36N9XAux0IN/uZpmAIECSJo8IBuUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvgTB1xAG1+l3DStAJUOOrXnWeHE7GqWTT45xlGTylzrxQA595UtP3mM9KlpDmby6lyOSjd9hJGtys4KFkeSWABYzHlGQOTdFIB9ZAGqhNptx2+r5e6VYcMmF76U3b7TdPADbYdG7aoEA126C2hq2BDMEuzXpLmUJxfVBbpN9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=mLayMzLa; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mLayMzLa"
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id 7X8jwyUypjw8Y7b0Fw6Q8B; Tue, 31 Mar 2026 15:27:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7b0BwKxqM4p0i7b0BwH2w3; Tue, 31 Mar 2026 15:27:35 +0000
X-Authority-Analysis: v=2.4 cv=WpUrMcfv c=1 sm=1 tr=0 ts=69cbe7ea
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=WxC1ixH7BDqxZmdiPmQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vNdfNPn3y9GGLrW0/FYykPrSh0asIY4xY2PcSkUuxfk=; b=mLayMzLahV6TVw1nLMGPsBSxAi
	inMdParYfmRN8ZeN+7C9pgijiZEqkOhK61QaCo2NGLPTn0atIKAb3wCQWnplahFpFI97RLjtwMCTq
	c+Nv4kJoDjQtsEEWtAU2Q7GDk6EkEbUmzdDY7bo3HAX1bu3rUtfiCA5jDDe/xRbbQuplS0JEBPLOh
	r4EF2E1C93iEadBan5vSJmuGQWSCjZTrNzaAuekb7HQjTQc0/B4s5TzaBi8f5+jAMzSaV9GtsAd4l
	YOT7vcZwtyKGarA1TxFvu5w/AVjwNbLLhgXKyBUGoaQo4mxngUank4/BObn19Awecd0Hd0fE1KUXz
	q4wg00Vg==;
Received: from [177.238.16.13] (port=35684 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w7b0A-00000002Acx-0FyA;
	Tue, 31 Mar 2026 10:27:34 -0500
Message-ID: <ee68ff4e-27b5-4373-86dc-3b7a5ad7f7b5@embeddedor.com>
Date: Tue, 31 Mar 2026 09:26:18 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] platform/x86: panasonic-laptop: simplify allocation of
 sinf
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Kenneth Chan <kenneth.t.chan@gmail.com>, Hans de Goede
 <hansg@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260326024525.63258-1-rosenp@gmail.com>
 <177496937487.10314.4187390108669622962.b4-ty@linux.intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <177496937487.10314.4187390108669622962.b4-ty@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w7b0A-00000002Acx-0FyA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:35684
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMcfTDpEGLyhe4LZQ8Q6Q1B1KSVFugBMh6reYodFBSaKVVWF9CAMbklgHf5KijbpUD7rMUZSaLkTX1aRBE/QQai5rSoJcxsPGnXFcTpzrXwDqapzFsqa
 iTs5cSBJsU/FYrxcwHFu6ikgiwBNEEG28CWniIatn/83EzP/78SYvTUxWwZyFboB2s7uuabMe9AlWPX+kTk2Fmo+F1cU0fsMy7j+wu3weFfrWUO2ZSMYvlo2



On 3/31/26 09:02, Ilpo Järvinen wrote:
> On Wed, 25 Mar 2026 19:45:25 -0700, Rosen Penev wrote:
> 
>> Change to a flexible array member to allocate once instead of twice.
>>
>> Allows using __counted_by for extra runtime analysis. Move the counting
>> variable assignment to right after allocation as required by
>> __counted_by.

This is misinformation and should be phrased differently[1]

-Gustavo

[1] https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com/

>>
>> Remove + 1 to allocation. It's already done in the previous line.
>>
>> [...]
> 
> 
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.
> 
> The list of commits applied:
> [1/1] platform/x86: panasonic-laptop: simplify allocation of sinf
>        commit: e75869527c720c4ed1458cfbe25e92186950e43a
> 
> --
>   i.
> 
> 

