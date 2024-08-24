Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B58494
	for <linux-hardening@vger.kernel.org>; Sat, 24 Aug 2024 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465259; cv=none; b=Prkfhn6VFXBSPnCE2udWtSkj2V31jMMY7A3jn30ELEgDJs9jetXIWCExHizREvkFjcipeSwntDtI96kNz/JiZZdGI2Y7Mb+Fs2jspndb4OGppENbg5m3mCXcoz7x5GJgZK8dJXICMB5vUknpsPiTe80Z1Cpy4IayJbOduCw8VQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465259; c=relaxed/simple;
	bh=QnlmR2zJ5cSeb3B0803JJuhmZ79BO5V+cQx4UTCf0Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EqDoLqDuLcG4yLnJb6+Rk0Aj5RE2wsVgfx0aRmPLV5wc0LY0Xk2p6lZrGsfnpidayjBD9PRCUohHpntRY2cNkTGjFLRcVF6cz6pjrxDYGYiRACipu2emo9//+uhdOjeDLnepFYC120CQ70RUBtIk8Lphmg2jcsimMbfH2aiHJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WrKvr1KcFzQqT2;
	Sat, 24 Aug 2024 10:02:48 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 320ED140137;
	Sat, 24 Aug 2024 10:07:33 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 24 Aug 2024 10:07:32 +0800
Message-ID: <1deb2bc4-0cd1-41a0-9434-65c02eef77ed@huawei.com>
Date: Sat, 24 Aug 2024 10:07:32 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/2] Add str_true_false()/str_false_true() helper
To: Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko
	<andy.shevchenko@gmail.com>
CC: <kees@kernel.org>, <andy@kernel.org>, <linux-hardening@vger.kernel.org>
References: <20240823062046.3323694-1-lihongbo22@huawei.com>
 <CAHp75VdYbG32auRF3KgP15wA-5bDgTMTO24itTu1tdjdW3CqXQ@mail.gmail.com>
 <2024082311-unaltered-grumbly-5c94@gregkh>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2024082311-unaltered-grumbly-5c94@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/23 21:38, Greg KH wrote:
> On Fri, Aug 23, 2024 at 04:22:32PM +0300, Andy Shevchenko wrote:
>> On Fri, Aug 23, 2024 at 9:13 AM Hongbo Li <lihongbo22@huawei.com> wrote:
>>>
>>> Add str_true_false()/str_false_true() helper to "true" or "false"
>>> string literal. And we found more than 10 cases currently exist
>>> in the tree. So these helpers can be used for these cases.
>>
>> Squash them into a single patch. There is no need to split these.
> 
> And let's see some patches that change existing code to use them, we
> can't add new functions that are never used in the tree.
> 

After this helper being added, I will add the coccinelle rules and do 
some replacements on the existing code to use them. Now there are many 
existing codes have use like this way (just use grep -rn "\"true\" : 
\"false\"" . to lookup):

fs/ceph/debugfs.c:360  seq_printf(s, "blocklisted: %s\n", 
fsc->blocklisted ? "true" : "false");

./net/sunrpc/backchannel_rqst.c:233 list_empty(&xprt->bc_pa_list) ? 
"true" : "false");

./crypto/drbg.c:1415  drbg->pr ? "true" : "false"

./sound/soc/intel/skylake/skl-debug.c:133 mconfig->pipe->passthru ? 
"true" : "false");

./mm/memory-tiers.c:925 numa_demotion_enabled ? "true" : "false");

etc.


> thanks,
> 
> greg k-h
