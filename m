Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AE320A1F
	for <linux-hardening@vger.kernel.org>; Tue, 23 Sep 2025 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620294; cv=none; b=QZs8YqE02qFNsDlxRALlMEpuOIPmNc3rre4pjF1Mz3qII4xx8IFDIT5Z4+tB2HRdE85umggZNQRngUR6uHC6oq93lJe/iAPD5gYZ+D9K0Gtq+lnrcxKjRA5oVhUESvhXs0dJVW8GmFtNp8Izr3TMAYiJfpNIy48fOGLgnn0DPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620294; c=relaxed/simple;
	bh=ibQFUfWgjlrRh6K0i5rnkYWrfmjyVOaaxdim7ktNBj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2iKpK3V+O5P5V7hTig83sahq9pWam3iUPouwKsQrOA1hCM4AIQ0pXZNUG9ieBW9iuloRxX2F7nPjSV5WB+27S53jUZnc8cAtRzN0+TPySowLuOn/JHopX5LS6IfUfHBjOL8St2Xg/YQ8ybIGSCLDjyk53Bb/9YFO8PlkZwViCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=cZcOBnsa; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cZcOBnsa"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id 0jq6ve0f9v7240zTJvRCGt; Tue, 23 Sep 2025 09:38:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 0zTHvpqLGfhew0zTIvhqnD; Tue, 23 Sep 2025 09:38:04 +0000
X-Authority-Analysis: v=2.4 cv=Q+TS452a c=1 sm=1 tr=0 ts=68d26a7c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=YFVba0b8p+FN4MzmaWosng==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10
 a=8Vd6GBVApGGO7YSmZGYA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZY1494lZCKLAGhYiwMqyD720As0K42qBB8WHh+Ldudk=; b=cZcOBnsa1Ssm9jkMVx+Vf6ZVBb
	DA8xlpCFryl594CBOIOju0oLqGKOBzBpx0cQ9B0Xz1oXRME7A4p8zYNYhX889Rra5rDMwKPrazyQq
	ItCZtRbV7nX4ICn2Dy66jhJn49ht4FePiJ39eU7BVxVn3hfSAAiYT1LcRJUS0qpiWP+Ox7+vGy+qK
	6GoHa+Zz/ovS+rdzzTf9wLil0Sw11jBHZf6nYd7Xz4M2W+q2HgM9MJxtpHkfYF+9bKk+7DLrPWTsD
	N2L7y4jqQ7HtvGF7pqibxfmkjii+lPTsgvA4ef9wDVcxx4K02fwOFQmNufShHBusxyXTSRs4kDZrq
	76nqKYRw==;
Received: from [83.214.156.71] (port=40424 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v0zTE-00000000QEZ-3hjY;
	Tue, 23 Sep 2025 04:38:01 -0500
Message-ID: <c9cd2ebb-ecdb-4ba9-8d54-f01e3cd54929@embeddedor.com>
Date: Tue, 23 Sep 2025 11:37:55 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tls: Avoid -Wflex-array-member-not-at-end warning
To: Sabrina Dubroca <sd@queasysnail.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aNFfmBLEoDSBSLJe@kspp> <aNFpZ4zg5WIG6Rl6@krikkit>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aNFpZ4zg5WIG6Rl6@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.156.71
X-Source-L: No
X-Exim-ID: 1v0zTE-00000000QEZ-3hjY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.156.71]:40424
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA2BMJg+DqOqHIWJTInHAVvRiSwnszk3HjYw9ieZndsU2uNV8o5j12lHM9fnCedlat9XHiMbH/t9dEHt/qIdFMDkUujYtJG3dC6H/K4aufhWlJd4+B4o
 lGYsbtz0ASZiu9GEZMmCZ7fcCEOAewahmlbndS6yfp5a319kpqZhZ1lqx/pIOmYWbmA1hbkhYT3GM/JbSieBcLIZ+al5b6qhU/Vw0Xb+4kpwpPvPWktTSyDd



On 9/22/25 17:21, Sabrina Dubroca wrote:
> 2025-09-22, 16:39:20 +0200, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>
>> net/tls/tls.h:131:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> This helper creates a union between a flexible-array member (FAM)
>> and a set of members that would otherwise follow it. This overlays
>> the trailing members onto the FAM while preserving the original
>> memory layout.
> 
> Do we need to keep aead_req_ctx in tls_rec? It doesn't seem to be
> used, and I don't see it ever being used since it was introduced in
> commit a42055e8d2c3 ("net/tls: Add support for async encryption of
> records for performance").

If this (flex array) is not going to be needed in the future, I'm
happy to remove it. :)

Thanks
-Gustavo
