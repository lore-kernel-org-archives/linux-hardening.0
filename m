Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5B2038C2
	for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277729; cv=none; b=EdfF0m8fr4JBYYFkdza5bACUsIq2+DUgG2oDoZDx7buHmFbL50wVf79790iUwtZaMcZSkBjjuhHRUfV8pxtvUcYWF1Di9lO3HsOAlLNSwo+qoQqNk500DsJvcP4j6Q7hJRFv5FQ7v979Ypo7C700zFPObDeq7Nbcn5GNL96o4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277729; c=relaxed/simple;
	bh=FyxG8L0kTeJMBvFZ2TqpR7bCfzlRoydYJ1KvWJsuPAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tD7w+yXTFxaixLhHNOznSqUKyg3gRF03ZanfWZIDATZ0YCshb4IhLBDpzj0ybJTksNHS+veKsVACEJZp94P/Vwn6dWOumlYQAOI06RNswzBjP7oSooWgdcLin6iFhxRqk+bhR7dpS7oiFDJoYTMTaXgJy4lcA7EBv2P/C9bGtb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=sZGQoEts; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="sZGQoEts"
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id 1pKktUti9iA191s88twjjn; Fri, 18 Oct 2024 18:55:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1s87tIfswjcdm1s87tiRNG; Fri, 18 Oct 2024 18:55:19 +0000
X-Authority-Analysis: v=2.4 cv=DrWd+3/+ c=1 sm=1 tr=0 ts=6712af17
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=1cCw6Q031rO_cLs8eM8A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KrrHr3IraN34Z7RX5pMYVY2PbGjQrd0P+774MqXGDuM=; b=sZGQoEtsG0vy1dYKYMPwugisEF
	6RFiB5MLfeCqdEgdeLf6elPw+zhdYUUFYR7g2xW7vi6MIQvzvngqrEHhEKC1yHicB+fqEKOsh2HYK
	zdyy/Cv6DxRnSNE7mdCF0KJKfkDRalzdRGW3AGAx91xeMnX36z59pq+9b9jDaUKiaxowEoSEW+6HB
	RGqUzVywxRLkD/4HbdA7eStG/bze7zndB8rWKS902vb1aGeoLxIC7DXv6RAdwal1S2OP286Qf5+Eq
	cLg5LZQQKACAOHMTnjyx6fOMbl52j32doIYDiQeXbXHEaRDhbLFL2TPS8frIVVE1hrWKuLBHk1m9h
	41rQWJ3g==;
Received: from [201.172.173.7] (port=46946 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t1s84-001YNE-32;
	Fri, 18 Oct 2024 13:55:16 -0500
Message-ID: <7bef8129-55b4-40e4-80c2-d319b8d6c251@embeddedor.com>
Date: Fri, 18 Oct 2024 12:55:10 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5][next] uapi: net: arp: Avoid
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <cover.1729037131.git.gustavoars@kernel.org>
 <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>
 <ac2ea738-09fb-4d03-b91c-d54bcfb893c6@lunn.ch>
 <202410160942.000495E@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202410160942.000495E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t1s84-001YNE-32
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.7]:46946
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE8RwkkabMeXM51aSKYzFQQelLBI1mCpqsx21Iq77yciJHBucx9gEuJBB2lv7EW350L9gzBrBQbv7XzWuw4j/35Z6GZ9veoCy5M0aQhbcQMH/8EGFBl6
 TCwWIHR2zBhz9HnU8pP0FQHdLsIq7Lrg87V/02LoPXYvbf6wKxaf9U6Z3HzXZH8gsGROvVX1WVhwwSedx7u79iDAwdU80J6sDZXC6OZ7v9Bg2Mv/PRbrRLkL


>> These are clearly UAPI files. It would be good to state in the commit
>> message why this is a safe change, at the source level.

Yes, I'll update it!

> 
> I think we can avoid complicating UAPI by doing something like this in
> include/uapi/linux/socket.h:
> 
> #ifdef __KERNEL__
> #define __kernel_sockaddr_legacy        sockaddr_legacy
> #else
> #define __kernel_sockaddr_legacy        sockaddr
> #endif
> 
> And then the UAPI changes can use __kernel_sockaddr_legacy and userspace
> will resolve to sockaddr (unchanged), and the kernel internals will
> resolve to sockaddr_legacy (fixing the warnings).

Here are a couple of test patches (Don't mind the changelog text):

https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20241015-2&id=c3b631a5036cbf45b3308d563bf74a518490f3e6
https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20241015-2&id=66db096a530b95ce0ac33f9fdec66401ec5f2204

__kernel_sockaddr_legacy seems a bit too long, but at the same time
it makes it quite clear what's going on.

Thanks
--
Gustavo
