Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCE2C08D4
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918340; cv=none; b=ry1EwXuzHjwRKEoBRqgLjFLgQVk7/FI76FyffQMQ1pOmMzD7amU0r/0YnNIL3C6Prm66rocByJrR8AiMM+5xKRYQTgvTNxFrsdIwx9IQ2g1xx9zoEq3rZShkzlAwaqdekrq6JYZ+crJYDoevQ2MK8lKO2Tb07lnkfMRRfVIE1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918340; c=relaxed/simple;
	bh=v4spxuzpf6zkGjarYezY7T+F8nrvptDEqHIeGCd9ypc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHKoEuXyLjHmgT+8+Ca7s4L73tjXdJvTRF1aHzh22Z7sFkoNaHCkPQym1Ck8OyluDc5RWX7LDwIwDojO8kmcq8R7rbg4fjA/J/Wn3a7cAnpVr+ap6UIQhcPtZxNY2pxqTJQoJBxyDRfut4evPhBe+ZuUlpm+10IkVr04zRKyrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=SrbXkw/0; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SrbXkw/0"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id 7JiOwkXDiObRf7NL3wSJfC; Tue, 31 Mar 2026 00:52:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7NL2wnsHveVHC7NL3w1utX; Tue, 31 Mar 2026 00:52:13 +0000
X-Authority-Analysis: v=2.4 cv=TfSWtQQh c=1 sm=1 tr=0 ts=69cb1abd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7T7KSl7uo7wA:10
 a=8nCX5qW_8wIiqptpIdUA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qPBTmWA2iyDxau001Y18REJbXYG14dqlLlHfbpR0TE0=; b=SrbXkw/0A2i/exVb9RzomTHJXJ
	q3tr1cstPpLeMymJe0/YRlZlW8XaRoBWJjRkmquRs+qcPZVO3d4sW7DfT/3PnxftbA29WGpa8l+dw
	MQ2tuLPi6EWUNARJn1R38cC2EaDHH8t/vG0gQDqUiFfFAQwKEqt1eEDSqJTH9tBHQ3w7Y7OwWmT2p
	uUVl/Zx35NBpCyQEtQj9GwTWJyibO7y8kd5CKBCtr2NeH2feW9TRVt2Naqr1fAkxM1gOChFwfHrGi
	4qYrIR1JszqAYypvlg3EtFkOfV10NiGHz3OE+nsGft1sfoqyFJ3VxGtuMIiUTfP6Q9ujFGlJw89CF
	08MurN4w==;
Received: from [177.238.16.13] (port=47112 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1w7NL2-00000003HJj-0P80;
	Mon, 30 Mar 2026 19:52:12 -0500
Message-ID: <e5207fad-2235-4849-b238-c85ee62508bf@embeddedor.com>
Date: Mon, 30 Mar 2026 18:51:01 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>
References: <20260326023747.54485-1-rosenp@gmail.com>
 <20260330161933.6471d473@shazbot.org>
 <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com>
 <37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com>
 <CAKxU2N_o=x=wSjiQqyB68VvhxP_ZoGoSyQagKm=0BdKkgrmPnw@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAKxU2N_o=x=wSjiQqyB68VvhxP_ZoGoSyQagKm=0BdKkgrmPnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1w7NL2-00000003HJj-0P80
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.16.13]:47112
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHVbbF1lAGpbjdTe1yLI+9kLg3cPz8Zb+HFSM5RHrn36SrCcGH+msgF4J2svY8evq3lxKdcEAIdTEbItGXhv5naQAS5q5BzQ1ULsqwJY4zaQdWAwroCU
 go7ABsqPV+Vo8ISzYfuz97lKz8H8QCUgS5WUbF+dk0hXv+kMRMw+k4rSeKTWKJdwFXCgCL836rW8ht7VkEnL7z3ONRvQhLiannI05N1py2BRmbBG7TEqIKAC


>>>>> Use __counted_by for extra runtime analysis. Move assignment to after
>>>>> allocation as required by __counted_by.
>>>>
>>>> I don't understand this statement, nr_ranges was previously set after
>>>> the allocation of phys_vec.  The only reordering was relative to
>>>> setting vdev, but that appears arbitrary.
>>> Yes that one. My understanding is __counted_by mandates immediate
>>> assignment after allocation. Otherwise UBSAN complains.
>>
>> Not true. However, it's best practice.
>>
>> The requirement is that the _counter_ must be initialized before
>> the first reference to the flexible-array member.
> OTOH kzalloc_flex automatically sets it for GCC15 and above. Useful to

That's what the "it's best practice." comment above alludes to.

-Gustavo
