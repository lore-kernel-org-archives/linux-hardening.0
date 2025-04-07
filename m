Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F781A8F84
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067514; cv=none; b=iEV2PFfJjNvZRrd/e3LPlQN0wxEI5KAggKGZz0qWyjwfDNXCO/Gis/XtXnsheleB8H01A78nFEMQiq54VI3otXd+gletio99sN/mDqD/B4smsrCXHgwavaEA69XP3Bxk++kUHY/1WIQdfBGiw3THK+4YB0fDlA12PgYbfpsrQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067514; c=relaxed/simple;
	bh=DyfkzHNaCLk5BrsigApA5Tn7gIVqUxs4a11J1ccvnzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjQ3FyPG8hgfbVY6KWLwswiL89buBGMimiABSp6iX9vEYX884moonxgleyNNr7OaRGZ4j3B1d/lgOuWya1WiRiZ799qW//X+YX4krlXCEKCDM+HW4XrC5GrkNW5PPHg5Mg1bw1/nOEaotLh+6yStgZS+9EQvXhasaGzATvsO2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=EzScG7cA; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="EzScG7cA"
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id 1rTLuFDy7METl1vd9uScTb; Mon, 07 Apr 2025 23:11:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1vd8uHOIx1vNy1vd9u7qnW; Mon, 07 Apr 2025 23:11:51 +0000
X-Authority-Analysis: v=2.4 cv=VMQWnMPX c=1 sm=1 tr=0 ts=67f45bb7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=GjqoV8KzObx_hdbUdTgA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bjzMiuiu1gDDSU1k3HJRMsaY2GZgvKUeAPV/ny0Wq8E=; b=EzScG7cAEgnu2cdpTOmdg7caQQ
	fxF2AG47Ar1p6wFmllJ169cyzE3+q08mQozTXWCv8X9HkLBOHyY6nYOm9vO5R7rHfbGHo8chsSDBh
	tx91fpo7KHqOuaj2p6lkDpVZkrPhwg/ejue89YTmxOBaivQNyiaWrqdn7JFHgEbV5L1tUXp/umEl8
	09lXe0MgJegNBWfe/eMk1BLY68tlHzFxzd+DIcp+c9kVfJ/GVX9P0o1Yhs6c3GGUZ9aUUcxAUiAGz
	Q/p+0/bjtZ4dwI1kh7WwDpWHqy6BE8NDt+XXsYQAbUpN4lXoPEQYCAACkKDhAp+7iQ0sO+5/IhYTf
	Zqlr7cnQ==;
Received: from [201.172.174.147] (port=34070 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u1vd8-00000003Pbm-0muh;
	Mon, 07 Apr 2025 18:11:50 -0500
Message-ID: <95ae8a4e-c8d5-441e-84b9-b27655f68641@embeddedor.com>
Date: Mon, 7 Apr 2025 17:11:41 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] w1: Avoid -Wflex-array-member-not-at-end
 warnings
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z_QpOlDTvyfRs4Su@kspp> <202504071326.564A591@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202504071326.564A591@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u1vd8-00000003Pbm-0muh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.174.147]:34070
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKpv+monY7MjfsIAqWcFnQJrxeqOBitNp7K/aHZdYOX5oAzIJ+gTD1eCApC1nOxfYuX8WvnD4AIuJH/jojtbhUooS3d6MT3sCSeB+oX6ycRhuRbNB191
 rEqYI8Eqtk6hZfBsZj8mznoSup+upUVrSkfWi1oITipsvxMagP+GC9j0SW1cra33gFoMih/b3VDUkCiVVlPWzpMqPDRu8jG0V8lLxdX365W5JxrDtosL12c2



On 07/04/25 14:26, Kees Cook wrote:
> On Mon, Apr 07, 2025 at 01:36:26PM -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
>> a flexible structure where the size of the flexible-array member
>> is known at compile-time, and refactor the rest of the code,
>> accordingly.
>>
>> So, with these changes, fix the following warnings:
>>
>> drivers/w1/w1_netlink.c:198:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/w1/w1_netlink.c:219:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v2:
>>   - Fix memcpy() instance - use new pointer `pkg_msg`, instead of `packet`. (Kees)
> 
> Thanks! You didn't want to use object assignments? Those are type
> checked. :)

Mmh... you're so persuasive :p - OK, I'll respin!

> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 

Thanks!
--
Gustavo
