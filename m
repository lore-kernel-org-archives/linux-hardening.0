Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4214B064
	for <linux-hardening@vger.kernel.org>; Tue, 10 Sep 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934989; cv=none; b=pEf1eqKIxvu7B+drQf9zwvFMFzCrprouImQObiCR1nQa/xfSkMUuqqkawIZHkuSfw/X1AHV7kJDPimZ8eMGSi2D0QLFJtsc4R1m8zTSLUjcyUAOhUL7pT7UUEc3OysLkf+yrAQItAfy+px8FHvoOWFZ9FDxRG3xPFTiQJ1CUNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934989; c=relaxed/simple;
	bh=BCviys0YNsx849tfvILUmOLM0u638WanwNSohxqJVkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N7XnidB7e1vjTtDH5l63Qqq+hV5w630c7qpEQwGzx0fuKkx/mWW+p+l7zYlbmrpdbwIIEJt1WJcnsA1AFfGjV1UskQgN3COSlAmgVE72rWnugDKNI0bHyjev98CXKA+/5/JfotsxIVLQzXSZcJv4m5Nr/CWGM+5nnimn53UoBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X2nTG1hb8z1HJJy;
	Tue, 10 Sep 2024 10:19:30 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E4EC61A016C;
	Tue, 10 Sep 2024 10:23:03 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 10:23:03 +0800
Message-ID: <95846cbd-c0a0-433d-95d2-82792a664e3d@huawei.com>
Date: Tue, 10 Sep 2024 10:23:02 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 1/9] coccinelle: Add rules to find
 str_true_false() replacements
To: Julia Lawall <julia.lawall@inria.fr>
CC: <kees@kernel.org>, <andy@kernel.org>, <nicolas.palix@imag.fr>,
	<linux-hardening@vger.kernel.org>, <cocci@inria.fr>
References: <20240904091451.3328272-1-lihongbo22@huawei.com>
 <20240904091451.3328272-2-lihongbo22@huawei.com>
 <71436945-5386-ff6e-8e8c-b513d4509241@inria.fr>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <71436945-5386-ff6e-8e8c-b513d4509241@inria.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/10 0:00, Julia Lawall wrote:
> 
> 
> On Wed, 4 Sep 2024, Hongbo Li wrote:
> 
>> After str_true_false() has been introduced in the tree,
>> we can add rules for finding places where str_true_false()
>> can be used. A simple test can find over 10 locations.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
>> index 5e729f187f22..50329c4c8acd 100644
>> --- a/scripts/coccinelle/api/string_choices.cocci
>> +++ b/scripts/coccinelle/api/string_choices.cocci
>> @@ -85,3 +85,26 @@ e << str_down_up_r.E;
>>   @@
>>
>>   coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
>> +
>> +@str_true_false depends on patch@
>> +expression E;
>> +@@
>> +(
> 
> There is no need for the above.  That is only needed if there is a
> disjunction, ie a set of possible changes.  Likewise no need for the ),
> and the same in the next rule.

Do you mean str_true_false_r is enough, not need for str_true_false? I 
noticed it was written this way before, so I've kept consistent with the 
previous writing style.

Thanks,
Hongbo

> 
> julia
> 
>> +-      ((E) ? "true" : "false")
>> ++      str_true_false(E)
>> +)
>> +
>> +@str_true_false_r depends on !patch exists@
>> +expression E;
>> +position P;
>> +@@
>> +(
>> +*      ((E@P) ? "true" : "false")
>> +)
>> +
>> +@script:python depends on report@
>> +p << str_true_false_r.P;
>> +e << str_true_false_r.E;
>> +@@
>> +
>> +coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
>> --
>> 2.34.1
>>
>>
