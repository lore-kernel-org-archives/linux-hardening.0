Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C817823A
	for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336960; cv=none; b=dwMUOn24+fh91EkrnOIaqeXJR7eJzy0n8xWYXU/kVteKBosXsnMEixfB/hdKERa0H0oLYZU/gN1v7PcPNeKW+TRalbvfQ02KQq9cB64fEKaHUeiNn4nItPHvmeKRvNaqgjDhwhP9T0tsWbMN8KkCy8D7vKWTQtedrN6pN7/uVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336960; c=relaxed/simple;
	bh=orRwZ9kcZJC8yMO1NEBXxCXq9LAMQc3UsRDQLy0IaM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEY0bSD57gmxvby6510Y9w8wh5L/lMEsb6gR70S0dISohHW8JR2C8/ihksPwN6U9YTDEnOW4q6/bgn1BJ/j/b8ygwd6sCnai9jewAh7OO6fqhiAwOdS1fLnzifX66fvUf0EzbfPV7Wqb9imV1De/IkRTHcfs4kZsW4TUOaIWFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dcdZTaXJ; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dcdZTaXJ"
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id oR12r3FGMtf2QoauurXgQs; Mon, 25 Mar 2024 03:22:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id oautrj2ZYsT9BoautryexF; Mon, 25 Mar 2024 03:22:31 +0000
X-Authority-Analysis: v=2.4 cv=LIutQ4W9 c=1 sm=1 tr=0 ts=6600edf7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=eNdQz-wj4_MDoatRon4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YOuO9JEjJXNfSgBKj1LiPw0cso3zHCBPu7p7n4bAXp8=; b=dcdZTaXJ8UBns8wJ+bl2v7r+xW
	VdKDUnj4KW5zlC97s1jUwbzElWLM5xGk2O9qdQGPasJpGAYd4gUpZugXwP+a8l4IdFch4qEYj86FR
	tOGFx+0+ANM3Bw14KItjkJwzmWCa9ZpaB6xxEleK83WCRRa4UAhisI8BxS2VWYx7s5ynzxE18tAqd
	z/IJ68wCybmXGM3ux20DolVcY+xGD6rA+CagFMU+YilXW6gmyDyHVztPGIspEY0ozdOwXx3q4bj2z
	2LLRWHE9PL9hNauhbEmxdBDEYbZtWrHcDy3IIZIzuCCLKggZ8QiuA4dXXMhiDigwfdVzltvgI940N
	fofVanyw==;
Received: from [201.172.174.229] (port=50482 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1roaur-0034lI-0F;
	Sun, 24 Mar 2024 22:22:29 -0500
Message-ID: <4064c408-3d73-4361-98f0-718f4f5e54a2@embeddedor.com>
Date: Sun, 24 Mar 2024 21:22:25 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: Wen Gu <guwen@linux.alibaba.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <ZfCXBykRw5XqBvf0@neat>
 <f504328f-1fd2-4c85-a657-a14b272c321e@linux.alibaba.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <f504328f-1fd2-4c85-a657-a14b272c321e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1roaur-0034lI-0F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.229]:50482
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDfQzLyGvhBIYfOpvmQfItSLP1kcr3wzkZ5eL4OSBDJ5Qr41C+Fpf2bkqD6igTqwQYVARZEtFrCqmINoDBfIJdzNO2rvh9iDom0ppcFIGn09lqHM/alI
 cXBdHsN9nmB1Sh83FYsItC0yMg0qjDWNO1ZZABEvoDfhZNleHbxol02IAivHzz7OKtuyOo5Rdw/NQWS4tr2GnDXBd4OFMeU4FxT64Uu6ceufi+idREDy8FKq


>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>> index e55026c7529c..63bb5745ab54 100644
>> --- a/net/smc/smc_clc.c
>> +++ b/net/smc/smc_clc.c
>> @@ -853,8 +853,9 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>>       pclc_smcd = &pclc->pclc_smcd;
>>       pclc_prfx = &pclc->pclc_prfx;
>>       ipv6_prfx = pclc->pclc_prfx_ipv6;
>> -    v2_ext = &pclc->pclc_v2_ext;
>> -    smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
>> +    v2_ext = container_of(&pclc->pclc_v2_ext, struct smc_clc_v2_extension, fixed);
> checkpatch complained 'WARNING: line length of 86 exceeds 80 columns' here.

I could probably change this.

> 
> It can be reproduced by:
> 
> ./scripts/checkpatch.pl --strict --max-line-length=80 
> --ignore=COMMIT_LOG_LONG_LINE,MACRO_ARG_REUSE,ALLOC_SIZEOF_STRUCT,NO_AUTHOR_SIGN_OFF,GIT_COMMIT_ID,CAMELCASE xxx.patch
> 
>> +    smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
>> +                   struct smc_clc_smcd_v2_extension, fixed);
>>       gidchids = pclc->pclc_gidchids;
>>       trl = &pclc->pclc_trl;
>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>> index 7cc7070b9772..2bfb51daf468 100644
>> --- a/net/smc/smc_clc.h
>> +++ b/net/smc/smc_clc.h
>> @@ -134,12 +134,14 @@ struct smc_clc_smcd_gid_chid {
>>                */
>>   struct smc_clc_v2_extension {
>> -    struct smc_clnt_opts_area_hdr hdr;
>> -    u8 roce[16];        /* RoCEv2 GID */
>> -    u8 max_conns;
>> -    u8 max_links;
>> -    __be16 feature_mask;
>> -    u8 reserved[12];
>> +    struct_group_tagged(smc_clc_v2_extension_fixed, fixed,
>> +        struct smc_clnt_opts_area_hdr hdr;
> 
> checkpatch: 'CHECK: Alignment should match open parenthesis'

I think the code looks better as is --without aligning to match the parenthesis.

--
Gustavo
