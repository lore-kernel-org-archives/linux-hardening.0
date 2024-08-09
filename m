Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042A198E6D
	for <linux-hardening@vger.kernel.org>; Fri,  9 Aug 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216897; cv=none; b=gL6MDZRNCsTckHpVxTV+oFQDIsXBQyIG/VRRh8kiQKQT0wgdHda8DdcXVC7UYXotwElkFWHu+howwKnbXjs2e0FvMgpUVlp94Q6M+/uDKO4rSYxTiCfZ1xCFgajg3ISxsky5lUDFa4WXr5Djl8d1ZVTYTHOQZ1zV72Gxa8nV5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216897; c=relaxed/simple;
	bh=YF2j1+300pl2tJxsYrUBAqHlJ5+NsKgS1Kx7u3KmH5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyigqNeZAPZbMnOlM5JQ3f1y4MRSntiDQAivGRVUukKgwwWf9pMO05Ok2cLb+lud6v+TsNQz3mmuHFUd/RHa3lcFo9iYVgjsuiYxRmMkG5x6J5Hd43FLOwp9PUBStWXfXlDmtuo2e1M+j7AwSxXMKOMPuDiCsvA23qqTmGWX/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qJznsSdi; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qJznsSdi"
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id cOHts5qr2g2lzcRQmsg3Ta; Fri, 09 Aug 2024 15:21:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id cRQms3K1h0K4ncRQmsn1sh; Fri, 09 Aug 2024 15:21:28 +0000
X-Authority-Analysis: v=2.4 cv=RsjDLjmK c=1 sm=1 tr=0 ts=66b633f8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=T-l7Lcn7wvsJkd90kOwA:9
 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ahVHeUMbhgnB+4j25dq8VaYi1sZLU1wW+FemcJlE7HA=; b=qJznsSdiEPtuO2wrUGnlBQKaGZ
	yk58PbqpzGYOPOD62nYNFmqLHJohRgT9AdyvnzFTD+XsyxvR0adWHccEXXLdOLJVjb81UXG3qXHAL
	mxnGSOiNVZTVdve7q/fCKEPhFA5cUkoQALBXkjSpIx0dF322hdy+pywWD2m7bv+tIGNx348LnV3Y6
	oM6qbYHM64w33S2wwl3hMWJcZZ2jfsQinBAdGLjDABBLkPqUlvS8IALblA1b5aWRMMJOdbjz4vVvk
	g4hrDEJZ1+rZ7+t4ZKjOTe6UR+Yzij+kasVhBgUQYb9kZ6QlOqrWgAV88jB+r/COqmpKbS/QvfuxH
	eXyu14vg==;
Received: from [201.172.173.139] (port=54138 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1scRQk-002rcf-2B;
	Fri, 09 Aug 2024 10:21:26 -0500
Message-ID: <cc27ae84-e759-480b-a1ff-2fac4494307b@embeddedor.com>
Date: Fri, 9 Aug 2024 09:21:25 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] sched: act_ct: avoid -Wflex-array-member-not-at-end
 warning
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZrDxUhm5bqCKU9a9@cute> <20240808194655.6bd39d2e@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240808194655.6bd39d2e@kernel.org>
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
X-Exim-ID: 1scRQk-002rcf-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:54138
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGF3sx7FL83iPV2z1lWafsJ4+ZjF5+igXQUAZmGcOy3CJkIB0/8Yus/WyF7Wz7BumaRt4ZOrZc0lMfhfM1+T6VWLQCZz+xf9QXw/oVYKOlXGvaT/tzBw
 HbGX89czv/dkNHcyP0jYDkRWFHsrMHeRqfnOT5iPePoGg49rRsS3A/rFKWPRJP4f8bAiO5oqgBULHFXQd2CtZANx69gRZtIsb4ctmVjbQJWPUNBrwAypsNYb



On 08/08/24 20:46, Jakub Kicinski wrote:
> On Mon, 5 Aug 2024 09:35:46 -0600 Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the structure. Notice
>> that `struct zones_ht_key` is a flexible structure --a structure that
>> contains a flexible-array member.
> 
> I think the flex member is there purely to mark the end of the struct.
> You can use offsetofend(zone) instead of offsetof(pad), and delete pad.

Nice! I'll send v2, shortly.

Thanks
--
Gustavo
