Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8E20458A
	for <linux-hardening@vger.kernel.org>; Tue, 23 Dec 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456182; cv=none; b=dA9+g1y6KpYKKZreREyfn4I4CHXgUFWRGA7UiIm6XbfXowdcbF0iFRRNsKyaGajFwlI7o26EJoLOMC+9cUMnuWe0MTSDpgUcjcW7+uw4Qzc2iny3lYwpeQ8CDLJT7DC2rQH1frxdlmQkFuQVgxb782O9rVQoN1OUDhJySvDSI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456182; c=relaxed/simple;
	bh=sqfXUpecnkz9leVPTMROxMBsEpSSzepYYI2wFRZVQ9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdA6O3BQ97fkzFI5yVYEM8oy36yWjk6tpy8VlgSqdVCXGnbBzcYHTq/N5updZkac3lKpdi3wIYJXa31+Y3P0GIiB0PGKGOII1dTJE1vWAUus8JQgTB+WJUWjx61mCu5KaIdka3AavcZLyIDwuxvQGKrCU3MRJHpQ9WDk7BdUXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=iDMjRWa4; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="iDMjRWa4"
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id XoowvSMGVKjfoXrwcvyq3v; Tue, 23 Dec 2025 02:16:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id XrwbvJVgAcu11XrwbvltIK; Tue, 23 Dec 2025 02:16:13 +0000
X-Authority-Analysis: v=2.4 cv=bKYWIO+Z c=1 sm=1 tr=0 ts=6949fb6d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=-cfKi4IEpZHxV7FLFHoA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BDzzqhMgRlf/SepYLBY7ybmCUGIfzjWfLnATsuDUCz4=; b=iDMjRWa4jjWZkKL5dTqG85YFlV
	Vd9bPWXZWcW5DSCF9iUvTZF3bxtc8pTJQs3YwDpPnasgXajSH9ok/3PyhhhQrbQXHt+jGR0MipGZQ
	vkSt4qcZb32FXu7r9wzYiWg/XY71EmrfQP//5EDHSvxriTQuMr1CahKfO7aOh3mJ8HQi462MtjBYG
	kE2WLUrrnJLxdXsZGR/6+iDxzR+0OYTiQub8OU7Ofz1lFDuDwvII0mIhy50pFrLvQDlFtpo6lgahQ
	umDIIMvW/1rRmiD5jIBEEmWCR4qcFbyaWcMSq4k8zCfZyNsr+F8WCBOpPJ12mOXShs3hW+IYOkbK1
	nlHeaueQ==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:63188 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vXrwa-00000000SNN-0yTj;
	Mon, 22 Dec 2025 20:16:13 -0600
Message-ID: <5d144d3a-d02d-4c7b-9360-29aea0705137@embeddedor.com>
Date: Tue, 23 Dec 2025 11:15:52 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UBSAN: array-index-out-of-bounds
To: Kees Cook <kees@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
References: <90e419ad-4036-4669-a4cc-8ce5d29e464b@infradead.org>
 <202512221526.451D1BE1B@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202512221526.451D1BE1B@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vXrwa-00000000SNN-0yTj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:63188
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN+RcxU9Y5xhEGyjnhoUmdK47i9olimCCKx/MMzBrIkIleUxiNFQ+bOkcBpdoHG16LVBk87fTN4voBboMpSjcBONSUUxs3jScTEl8K+HAioZM36xE126
 GzpAF1YtpWhDM6V1tt7BemPOSjVdIr/3NCr7qVP0xDov+oDbUdSrajLAe6G+2ct1mHCbkBMtZL0ic+C0Xqc9YxNdCIkqTTo7FuaC3Fke1pCKLf7gqAqjZYY2



On 12/23/25 08:28, Kees Cook wrote:
> On Fri, Dec 19, 2025 at 08:20:13PM -0800, Randy Dunlap wrote:
>>
>> from kernel bugzilla:
>> https://bugzilla.kernel.org/show_bug.cgi?id=220823
>>
>>
>> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15
>>
>>
>> (from drivers/mtd/devices/mtd_intel_dg.c:)
>>
>> 	nvm = kzalloc(struct_size(nvm, regions, nregions), GFP_KERNEL);
> 
> Yes, this needs to be immediately followed with:
> 
> 	nvm->nregions = nregions;
> 

I submitted a fix for this that day:

https://lore.kernel.org/linux-hardening/aUZFLezigzZQVt55@kspp/

It seems someone had submitted a patch in Nov, but it was
never applied upstream.

-Gustavo
