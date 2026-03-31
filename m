Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9F405ACE
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971001; cv=none; b=oQ8A5aosYUmcFpoJ3UspQehPsWndEUm0lUockZRt8NP68VqOGITmQscfw/NqhigXspSsYJ+qAsuKPHHI6G5NSXlvM42rJh522XqiIXTw4rXTtHv8UE6Z+xASuGK//mmGMhbiccdIVHMfsHJCUyznWAIN1iYSc6RvolCrilnDhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971001; c=relaxed/simple;
	bh=4zvTdkJ+ue0OPEN1WPGkL40/gZzvh05e8A3J8AoRR2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FH9F+YIm7erq5szmCfR32JVFZdqGEDc3pWDRJaZa/nW653U58lFpO3NJw5te8E78O4RZLFUwVxEw7aL5gy2NpIbEuaA7IaEtQ59/P903pw7FjyeUhDFzGqpRD69wmDDc6YGr6MoFwx2ndqtJSe+1Z7YvbAeKO39+iuEzennbrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=wzAO04eb; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wzAO04eb"
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id 7YTIwyoxnjw8Y7b2Uw6RXY; Tue, 31 Mar 2026 15:29:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7b2SwJwcGFeDM7b2SwtvyZ; Tue, 31 Mar 2026 15:29:56 +0000
X-Authority-Analysis: v=2.4 cv=aq2yCTZV c=1 sm=1 tr=0 ts=69cbe875
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=_XBNVHeI-bNlzRn20y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Uzf0RmuT8FttVaXBcqx6BFPjQHDDGzkISS5bDvZtWU=; b=wzAO04ebB2kO0Hi92SxtvM7VaX
	WGANDeMO4cORK0MFWol77Yqot/FvqG1SRb+8etqP7Et5vqLKKSc03w2jIOHxAU06VocMBu8NC247D
	LutqlnUrlC7LwZTcEws50yI4sFZLaqrjYZ8+6OFBNEc19mPIZ5Wq6UFksDZN/yUMmqKLBt8GMr/gv
	HBqZywe2tP4oasSjJVRkrQf3Pwlj9WQuhFeGgOct/0+PbE38fB5p6CgyMrwgNbl76ndj9u9uR8s/V
	cD2dVAuWNnGS1loWz7+8OEGuoyiiZnN9woTntN++NN6AVY3ZwMYEpM7QSZ/GTWsWX2OGkc4u8qEYb
	RxR/UtsQ==;
Received: from [177.238.16.13] (port=60440 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w7b2R-00000002Dpq-1fB9;
	Tue, 31 Mar 2026 10:29:56 -0500
Message-ID: <4ce84891-3449-478e-990a-eb77f53a956d@embeddedor.com>
Date: Tue, 31 Mar 2026 09:28:47 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
To: Borislav Petkov <bp@alien8.de>, Rosen Penev <rosenp@gmail.com>
Cc: linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260327024828.7377-1-rosenp@gmail.com>
 <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
 <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com>
 <20260330211123.GHacrm-03xUU_3yX66@fat_crate.local>
 <CAKxU2N__gE-bWBU6EkJmEK2gR7VE=Va+oN6EB2hpJoHbUiYVxg@mail.gmail.com>
 <20260330223222.GJacr59uiTZzPRYbWX@fat_crate.local>
 <CAKxU2N_H4mvrJh+zgoikY8J9-u3nnWK-1dQwZanDNksoE75hvg@mail.gmail.com>
 <20260331121840.GBacu7oF3AjjkLtcBZ@fat_crate.local>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260331121840.GBacu7oF3AjjkLtcBZ@fat_crate.local>
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
X-Exim-ID: 1w7b2R-00000002Dpq-1fB9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:60440
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 23
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIHEXIKv0lMOpEjl0PBCaZDyS8fdeyOh+x3PiUGlpVLbTKzpXAj6UqK+qMdfktl0KX1DnCa6uYSUrAsbOQvr8d/kO9L0psESrtgdc7bgmaQorlZEo8jB
 1onsVJlqsxr5ie7FUDfbHe4FfZTutsB2+Z6QMqrY/LgMNarMjpVr8nkWeKcysaQhOdBLeWZ7uirUuKWsAz6Y9+HcBY/Ko97Dj7rVMCAbUivS4ajx8K2lAB+e



On 3/31/26 06:18, Borislav Petkov wrote:
> On Mon, Mar 30, 2026 at 04:25:26PM -0700, Rosen Penev wrote:
>> On Mon, Mar 30, 2026 at 3:32 PM Borislav Petkov <bp@alien8.de> wrote:
>>>
>>> On Mon, Mar 30, 2026 at 02:26:10PM -0700, Rosen Penev wrote:
>>>>> Oh, hypothetical what-if. Yeah, pls drop all that gunk from commit messages
>>>>> pls and simply concentrate on why the patch exists.
>>>> Not sure what you mean.
>>>
>>> I mean this: a commit message should simply state why a patch exists. Here's
>>> what I did with yours:
>>>
>>>      Convert struct mem_ctl_info to use flex array and use the new flex array
>>>      helpers to enable runtime bounds checking, including annotating the array
>>>      length member with __counted_by() for extra runtime analysis when requested.
>>>
>>>      Move counter assignment immediately after allocation as required by
>>>      __counted_by().

This is misinformation and should be phrased differently[1]

-Gustavo

[1] https://lore.kernel.org/linux-hardening/37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com/

>>>
>>>      Move memcpy() after the counter assignment so that it is initialized before
>>>      the first reference to the flex array, as the new attribute requires.
>> Looks great.
>>>
>>> The idea is that when one reads the commit message months, or even years from
>>> now - something we all have to do on a daily basis - it should have all the
>>> necessary information why the change was done.
>>>
>>> And nothing else. The emphasis being on the latter part. In this case, what
>>> this should have been and what some tools can do when lines are magically
>>> ordered doesn't really matter. The change must be worth to exist for itself.
>>> In this case, runtime bounds checking, which is something we all want.
> 
> Applied, thanks.
> 

