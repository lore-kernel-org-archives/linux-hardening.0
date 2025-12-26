Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E1156237
	for <linux-hardening@vger.kernel.org>; Fri, 26 Dec 2025 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729649; cv=none; b=rhPZrD/sak/f9EySzDrFiUZ65PldlV6m01yWZsbGBzvbm58Cb5pvTismv0pgnUR9e8uC19JZd6NGGba1EGMjxgIg0unL2aSCshELM6demJjGT1meUgSBhdrOI5vwHTrf861Tvk2DnVjf+1JfQvjkzBQBfoQsuBZHWKQngePuxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729649; c=relaxed/simple;
	bh=535xoqcKcYrPQXsntCWwNVnjVyQ4BpkcbelfQpPn0bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZt/bVjWQYHWHcFtpdQgyVmX8xEceV7s3JPda3P5gZeDOnk7sPa75xw5PhyD0DK01kF0NWy0bcQwRH+BICxqsPi1UJwXcUbekK9rJ5ZBjl8TkK7JD8WTocaPpEzjdtU3265UdEOTH5h87WRMhm7P++MfWpycWsGSxT2z5g9hbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a/kpibou; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a/kpibou"
Message-ID: <fa979d2f-150d-4e9b-80dc-b6a34191da08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766729644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfYE72kf/YHok1dgp72c9MA+z2NRqHpakm9XDgwtvRw=;
	b=a/kpibouIisaP/WAgPGwZdHT+JJBsAdBmJF6HIXUZ8pe/8WeB0MCxfXLQK6JiGJmGa0zC1
	38ImyqTCgjZV+oaSwC3txF2BZJ7rx3guXdqtcpf87ZIwJuU6e+xCG1j3AF3yloVo1cTiVg
	wMtUPKhVLFt2uR7M0rSP8azmHzZHXXI=
Date: Thu, 25 Dec 2025 22:13:56 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Leon Romanovsky <leon@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
 <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
 <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
 <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>
 <20251218155623.GC400630@unreal>
 <5d950681-7f16-4b1e-a512-b118c747ffd7@linux.dev>
 <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
 <20251219142600.GC254720@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251219142600.GC254720@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/19 6:26, Jason Gunthorpe 写道:
> On Fri, Dec 19, 2025 at 11:51:54AM +0900, Gustavo A. R. Silva wrote:
> 
>>>>> Any update? If this looks good to you, I will send out an official commit
>>>>> based on the following commit.
>>>> You are RXE maintainer, send the official patch.
>>>
>>> Will do. I will send it out very soon.
>>
>> I don't see how this addresses the flex-array in the middle issue that
>> originated this discussion.
> 
> ??
> 
> It moved it to the end of every struct it is part of?

Any update?

Yanjun.Zhu

> 
> Jason

