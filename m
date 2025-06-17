Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBFC2EF9D9
	for <linux-hardening@vger.kernel.org>; Tue, 17 Jun 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187678; cv=none; b=hWvPG5qn0evMZ9ubn/eUcEmH8zitv6hysE+S+b4W0NqItJDDISya25epQ6hPBbitefHWe1hjXL3PO+o3xrAWIu7aeeQJXU4QXt0rK87cJjny0BevhKyyD5fL/4zNXJ53yWogyBh7TIhQBcZnsd56fiit5YJd5wYlVIS+lGxBS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187678; c=relaxed/simple;
	bh=YZQsR/vrm9KwNtY9qhhnv6KAi9m5QWxGrRlriI9aHjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwUKsVYsjEHG1NEVg84g+GF7EU4Of6804PZC6rlpg/c1O9qp/8Sqtus/5U7qlXPU9NgMcCnpLaX4WMH1IJI1gd0JF9GcYbHAfIlj1MwJ9BewhTCs8fEf/57mdFFu6cmTE+vsAwzVrH7JTj7DwVLLE17PoWw0pVC8upHTcY9wi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=KwKo1FOS; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KwKo1FOS"
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id ROQXuT2jqbmnlRblNu5gde; Tue, 17 Jun 2025 19:14:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RblMuzgUAgFaXRblMu2WW5; Tue, 17 Jun 2025 19:14:28 +0000
X-Authority-Analysis: v=2.4 cv=DbzcqetW c=1 sm=1 tr=0 ts=6851be94
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=y7jUFFJD1EYPe7d4fIfORw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7T7KSl7uo7wA:10
 a=s59UEcVVmHqeHvMsZSAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ml2cmUz1N0aegwv2OFWm6Cc4XAe9xVhUfpcEF1NMAkM=; b=KwKo1FOSScYpU222dDvwRVZtQ3
	at5J1dW6mkQLxY5Mdy/kE5lod9IJ/7GhDnbIRi1rVqv8TWxfaZBpFUkUKVTZpg/4pVyYJwY2pIiAH
	iHBfPItS6t6t+CA2GJBcxzDl5/Gd3LQ6jiaTOG7zG6zZdt7UtqvSWdqn0GgHvK8evr57/S9EhaKLV
	AMTw93q8qqHdeSodT/SoQ+nLMCCj8NTeCPiP+XJYpnsTSb2QCntVUvfxrvufwsC7EWpSsdJwuzgzz
	aJQHe1vvipHYOvQmAEcHwp0/pkEvP23Jlp/6gPlUUTGHM75nBW1SllvWJCamUZO9WUE5YmAkrCQcv
	hp+5HEHA==;
Received: from [177.238.16.137] (port=52432 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uRblJ-00000002Kme-3VPm;
	Tue, 17 Jun 2025 14:14:26 -0500
Message-ID: <1717f455-a38e-4df6-8b4a-284ed48c110a@embeddedor.com>
Date: Tue, 17 Jun 2025 13:14:08 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] NFSD: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aFCbJ7mKFOzJ8VZ6@kspp>
 <175016808512.336273.15483620286888395120.b4-ty@oracle.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <175016808512.336273.15483620286888395120.b4-ty@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.137
X-Source-L: No
X-Exim-ID: 1uRblJ-00000002Kme-3VPm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.16.137]:52432
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLC3YTQO+H5J4nI8QgBsDckdQqCdVyqMJA1gvjmWaX8tpkvYUtr3xnBQ3b/jCy2VUaBoV2mLB2nTzQ1GtayIDFgE8CTW2Hnf4QF5J+jDZQnHUZ8n8wNP
 IyBHLUse/swMMwmou1/Z21NV7NEi5oR4TOjdm9zd8bpb3e/7bojR6lGwKGnsHBggir4gHg5c4CgAGx8XV0paQFMTPY3hNlAmPyD1W9bSka1MHJ9FKmsLXN23


> Applied to nfsd-testing, thanks!
> 
> [1/1] NFSD: Avoid multiple -Wflex-array-member-not-at-end warnings
>        commit: 9aa83533d2e694c84d7d09f9c8eab29ad9f2adef
> 

Thank you, folks! :)

-Gustavo
