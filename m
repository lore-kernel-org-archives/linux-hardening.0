Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46024275AFA
	for <linux-hardening@vger.kernel.org>; Tue, 23 Sep 2025 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660813; cv=none; b=TFn8FJxk0nvShz0c3Mddcnmkg/bV36wrO6EIgUAt7guEVQu8AajUfidA2ZqG9jP15bQcIl93ZuXfqOLcPxmxnWzmBcQpIZ8dgmv4FL6lCdjRsbWr9nlOe2P4qPmIKA9XgiFxgQws9/oDrVNilxne4CcEXyHHAvp4eSKBnHKUFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660813; c=relaxed/simple;
	bh=A9g20I8lseVKXlAh/tg+QgMk7GC67zftnbhm/6Ovfnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ol85DhfYbFoEnpw+nuWWJX29OuEHUtR8Ys+84KvP2dSKudx5m5Tm/cZh4E74ooNQJCVMpWrbcO0xgFYrXdKyKIddoMHazwZf7EHL8ZaZi4RAg/T5E1uCp2zs4t/3M7kX0j/ZTri++KL9VPsJfUZl/bPxEDHccfgZ7IyvOH6VOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=0FwvzxPh; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="0FwvzxPh"
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id 16N6vZVXXKXDJ1A0wvIB8k; Tue, 23 Sep 2025 20:53:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1A0vvfqnv25G71A0vvT2IR; Tue, 23 Sep 2025 20:53:29 +0000
X-Authority-Analysis: v=2.4 cv=LuqSymdc c=1 sm=1 tr=0 ts=68d308c9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=N332or4wHRcdzxpigiEmqg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=gaVSdRgQbUJKjHIfkZ4A:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xR+Ojw/IUQBpUZG1R+fgJRf6pEBM1UY4TV59RRigg/U=; b=0FwvzxPhR3boWRA2R2jjvhqYf6
	Q+1uW31zrwDf2agKemJJdl1COGeQRKC0xFJWGjEkmdijHZDk9uT5cn03tRrO5IQ2SJWPFpmVloKDK
	f0inm9STgU7QCFbrmeVmJrlAO7pp6hBBOWSpt15OZR5oC9gTxBXCzwS8u2FLsTd1aqx9uAr8DAS6F
	rf0NBai9QZIr9gZThB+KniC3pLlxWJlaBaqi01oetGI2Pne+kxKdPZby7kqLUkdsaNVyOOj8v3iGc
	zj6iiuajCRgkiqKxsqxGyKVSxLGqY1E0zE0lwS4qMaguxptZjfx6NRx/KlZwolb4lxqzYF7WdHrs+
	xq2IPNsQ==;
Received: from [83.214.155.155] (port=35596 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1A0r-00000003Mp0-2G1U;
	Tue, 23 Sep 2025 15:53:26 -0500
Message-ID: <a4b598a1-3ad6-4e42-9f48-21db966f0a34@embeddedor.com>
Date: Tue, 23 Sep 2025 22:53:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tls: Avoid -Wflex-array-member-not-at-end warning
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aNFfmBLEoDSBSLJe@kspp> <aNFpZ4zg5WIG6Rl6@krikkit>
 <c9cd2ebb-ecdb-4ba9-8d54-f01e3cd54929@embeddedor.com>
 <aNMCznixxL2veGxK@krikkit>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aNMCznixxL2veGxK@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.155.155
X-Source-L: No
X-Exim-ID: 1v1A0r-00000003Mp0-2G1U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.155.155]:35596
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfITpC3fe6HSisTXWZzv/9iC5IIhmV987GKrGonbNEz3T/euZggmCGokCi1mMssE0zuEFszjm5eBRwXzKact9Enl9HvZLSea2aeicMlBRiEKDTg9QLxYQ
 Fi0FG62vpmApLDMbK4ZJYOUXW5YdgNxbwI8RyRGtaHufkFH9/y8Fss9RIUaACE4eMyDf8tayx/1ZFrr0KSXv3RMh3EyKvGwKBPja7qhBfEQ07APK9D/bwPo5



>>
>> If this (flex array) is not going to be needed in the future, I'm
>> happy to remove it. :)
> 
> I don't see what we'd use it for, aead_request.__ctx contains private
> data from the crypto code (all accesses seem to be through
> aead_request_ctx defined in include/crypto/internal/aead.h, see also
> the kdoc: "Start of private context data").
> And we haven't seen the author of a42055e8d2c3 in a while, so we can't
> ask about the intention behind this field.
> 
> So IMO, tls_rec.aead_req_ctx can simply go away. Would you send the
> patch?
> 

Done: https://lore.kernel.org/linux-hardening/aNMG1lyXw4XEAVaE@kspp/

Thank you for the feedback. :)

-Gustavo
