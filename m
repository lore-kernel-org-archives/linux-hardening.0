Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6DF1BC9E6
	for <linux-hardening@vger.kernel.org>; Fri, 13 Sep 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215417; cv=none; b=n+wlPIgjjyPjxifLxlZQHLsVWWmqb9tAxZ05PYZLqEcGM3gl3/dHVjQnevmwGcetdzO9tioAiRCWTT0R5Iet3t1hnjsoKAMy9xb27MJ1jPoVSxUYekmthhsFbslgsEYYVouiF3IkOGkxPKYd3WLKzbZc0AjqY6I3tkOpOFuuw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215417; c=relaxed/simple;
	bh=YJxOJ7GqMAQsQiiZjzTpVxcn795lOk4vZL56EQI/7MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdhiqs5AyC3cyOwUPoA5FYYWHdVRjf0HSJp/NtEjD017Wt3KolFeuxe0r/jsS10+h4vhH+7/XaUTHE2t87N1hRyu+y7AOWQ+khODypNzQhjgB5vXqY+WOSQh4NB8VV6n7kxER3sLpniJdZwUQbiLfLmyMMGAgjRBjxHsRgzUYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=n2lQr8BV; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="n2lQr8BV"
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id ozkssGDgJumtXp1U8saT5Q; Fri, 13 Sep 2024 08:16:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id p1U7ssRfVz2cCp1U7sFmcU; Fri, 13 Sep 2024 08:16:55 +0000
X-Authority-Analysis: v=2.4 cv=Dd4RqOtW c=1 sm=1 tr=0 ts=66e3f4f7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10
 a=UWiDY137rChLUBZtjNEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Sp7eKii8hwE9TMjnTOQoSBvNTxcsXnko4qRV4csTKc=; b=n2lQr8BVcESXKzes5CJ6MPYRWa
	cVimG41wISMNnxtrCH/3aTGe7sQiVgvKUwZZu3R9Ctyb5cKxgX61Lh49By3UmOVHPu/95NEo/nY5h
	E3ovmbx0l1fVJ3ao+Va7ihLsun6sYGbcjbQ72xS163E5MXk2QCxbj6Nt9TFHTlSiRKae8w2Qzyj1j
	As4jd0O80vEmai8wCW8OOawytZBi/raJJZEpZ/7sMXy3XvD2pcfaIV32fFT0H/A3b5m46xGuRQdwO
	nVooGUMyXYdoBMRf5Olr6SdpVvURZ3f0hYqxkAuth56K7yXbxapTm6gQVufcs5AJQnOr2fKeV0GC0
	9nd81otw==;
Received: from [185.44.53.103] (port=57790 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sp1U6-003rlv-2J;
	Fri, 13 Sep 2024 03:16:54 -0500
Message-ID: <ecbcc7d5-7ba1-4d3a-85d5-20c583b59766@embeddedor.com>
Date: Fri, 13 Sep 2024 10:16:50 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] xen/pci: Avoid -Wflex-array-member-not-at-end
 warning
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZsU58MvoYEEqBHZl@elsanto>
 <9fabe73e-23ea-49f2-9c06-17766a07fe9d@embeddedor.com>
 <4b1004d5-a8f6-4f3a-b17d-79d354a23f6a@suse.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <4b1004d5-a8f6-4f3a-b17d-79d354a23f6a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sp1U6-003rlv-2J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:57790
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 37
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP29dN+DIvuojub6eSIYYPWq8LnuJFZEe6IbHvxQJIjT+7AUnTYSmYLZGjVOks9TEyeX//F4tkEfE53ZfU4zQasWxwj9gufBiXh+XeKnPwKhsawswWt5
 412Ins4bQFPGvge8UrcNGtEwDdhDDLnSlVxmpCPk0dnaCnK4SHnMRwdPwvyXt7hVFgOTISCa/L+ShKsmV8dCt9pNfKC4RfuU1cFtGfFZ44IUJDcNAqY6cYtM



On 13/09/24 10:12, Jürgen Groß wrote:
> On 13.09.24 10:07, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping: who can take this, please? 🙂
> 
> I can carry it via the Xen tree.

Sounds good. :)

Thank you!
--
Gustavo
