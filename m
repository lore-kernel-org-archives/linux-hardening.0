Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C66155316
	for <linux-hardening@vger.kernel.org>; Thu,  8 Aug 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142500; cv=none; b=nBOjr2ACpMIyvDBKYda4WXCZrIYnszUck8tPsRziwigKzPLimWVNVFMfsQdzwKajZ9ykb/VGBF/v9FkuM3ps/bCXqPb7Jo1K7cd6mVra7Yf8ob5Anz+QT71lmgVpS/2nRwtLA8WLNVLxv8LhNxr5whyW7o6cyrEdicmsQQsfvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142500; c=relaxed/simple;
	bh=mc2b2wnvSswdd9bGNTJz3ThvN6deTuY2z1veO6hhceI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1H2McjP9j0mRORjKDfE9jXJRbAyJ6WmuPLI7u1LTuXhEp15yMASf2iHVrJ7m3/KhoW/NNIziECXX+cmOPeoEyznwvsZ9EYqz0vxKHiz0wZxH4iDVcQeou18t+ldrU1t+GanixAUeBO8Vhj1BdQ60k+1bZdphxTWw5j2Jr1SZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Gn2yR5A2; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Gn2yR5A2"
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id c5vZseOxyiA19c84vsI1Hj; Thu, 08 Aug 2024 18:41:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id c84usXcaP5D6dc84uskKnK; Thu, 08 Aug 2024 18:41:37 +0000
X-Authority-Analysis: v=2.4 cv=I6GuR8gg c=1 sm=1 tr=0 ts=66b51161
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=bf4sMg6fRU9RvZfKRQcA:9
 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Hy7G8KZGHDNlJ3507GxEirDfB3P09Yp8UX4cEgxCNo=; b=Gn2yR5A2DkEODa9mYfOrJzjBvR
	jRsU0kedD/5yUEgWmNV2GKMzrEserzkqo5e49WwxpMcuYfEnyRAapQ9V372V0U7MVFMryABH8+c7R
	vvCVCxf2zLD/CAJNO6nv0W9ff3iQMm04HZoLjjYyp+KwKLrOfor+m2KK7u5bZ0CPhKm5a6wKMU/tn
	nHOirqXdhkU97zocmxXTRBS7vjS/hKp/TRggipSVHyKM7ezFkTrGmYfp93ekqvi+6S8ZCwNSkug6r
	qlg1k9yr+N8sTDfyTpnbsyzXz1XnX+pda8nwbLr5iB7DAZqN0oKgYS/xyIWbSFsL0KRxkZaaLEmIA
	Lnaz3bWQ==;
Received: from [201.172.173.139] (port=57980 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sc84s-00417g-1x;
	Thu, 08 Aug 2024 13:41:34 -0500
Message-ID: <111cc058-a681-4aec-ace4-cd6bc19699f7@embeddedor.com>
Date: Thu, 8 Aug 2024 12:41:32 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] cxgb4: Avoid -Wflex-array-member-not-at-end warning
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZrD8vpfiYugd0cPQ@cute> <20240807200522.2caba2dc@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240807200522.2caba2dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sc84s-00417g-1x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:57980
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBWtVqqbcI0QX13PQiEEKJK+1a5EVnvwYI45kzUO8aVVOoU8oin+rg9CdzgqvrjnHf8vkAWp7ETgAGDs8zAOF2vYfxN53HpUvJtu75qDKQ3S6XxtdaIS
 65SnZSz0zCQZ+fDMpYWFI29+OSwavsiG+Pn0uVzCz3E8ejMwIfvrCEJL5hIfufV0Ye2Ew6RSkb4qJnOTKAgA9gHsE04c82pUWGQcThUlx6sZNU/ydtPLGFJw


>>   .../chelsio/cxgb4/cxgb4_tc_u32_parse.h        |  2 +-
>>   include/uapi/linux/pkt_cls.h                  | 23 +++++++++++--------
> 
> Took me a minute to realize you're changing uAPI.
> Please fix the subject.

What would be a preferred subject?

--
Gustavo
