Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C92AD31
	for <linux-hardening@vger.kernel.org>; Fri, 27 Sep 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430977; cv=none; b=rX3ITCylNzn9f5M6HNBmaixhd2LPQu+txzpBmVeRYlwas3Urs0IHOTzlXVsOt9VgGb94zuqTR1WEfF+LXfA9QoZkvPw0Ik/BeoPafES0qfxOxDRgD1cwOYgMqjYaBjJQE/XAJ1dU6a0AxL5PZys2vsPU+dUhMvrxtSNERVL0oME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430977; c=relaxed/simple;
	bh=TH2P1vacEUzwoEgPUbETg2ADMNbc/3RQ1838A92juA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nsCq29ZkWhAqInrlRTgkCHhDQH1JxS2mYfcln71olGZhai01jsrLNWXgASuRa8/08NgcSU5t++RLDSH0dbKRHf/Eeke/sCgRo2H51iWVdaHer9qrejsGAi42u4jdszcGPdHHCAG4SrC6/8EzPPS0Ca+1RcNy7DAHtu8+uVsn4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XFQlg6n4yzWf0W;
	Fri, 27 Sep 2024 17:53:51 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FCB61401E9;
	Fri, 27 Sep 2024 17:56:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 17:56:09 +0800
Message-ID: <21356a02-c49d-4afe-a14c-f96fdb5342ed@huawei.com>
Date: Fri, 27 Sep 2024 17:56:09 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 01/10] coccinelle: Add rules to find
 str_true_false() replacements
To: Julia Lawall <Julia.Lawall@inria.fr>
CC: <kees@kernel.org>, <andy@kernel.org>, <nicolas.palix@imag.fr>,
	<linux-hardening@vger.kernel.org>, <cocci@inria.fr>
References: <952c42aa-001f-42f0-8ec5-eb7e592b2629@huawei.com>
 <466D6A21-0E18-4FC3-9A92-6B3EA58C273D@inria.fr>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <466D6A21-0E18-4FC3-9A92-6B3EA58C273D@inria.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/23 18:24, Julia Lawall wrote:
> Thanks for testing it. I will see if there is some other way to improve the performance.

May be every rules in the same file are executed sequentially cost a lot?

Thanks,
Hongbo

> Sent from my iPhone
> 
>> On 23 Sep 2024, at 09:01, Hongbo Li <lihongbo22@huawei.com> wrote:
>>
>> ﻿
>>
>>> On 2024/9/19 14:25, Julia Lawall wrote:
>>>> On Wed, 11 Sep 2024, Hongbo Li wrote:
>>>> After str_true_false() has been introduced in the tree,
>>>> we can add rules for finding places where str_true_false()
>>>> can be used. A simple test can find over 10 locations.
>>>>
>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>> ---
>>>>   scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
>>>>   1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
>>>> index 5e729f187f22..6942ad7c4224 100644
>>>> --- a/scripts/coccinelle/api/string_choices.cocci
>>>> +++ b/scripts/coccinelle/api/string_choices.cocci
>>>> @@ -85,3 +85,22 @@ e << str_down_up_r.E;
>>>>   @@
>>>>
>>>>   coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
>>>> +
>>>> +@str_true_false depends on patch@
>>>> +expression E;
>>>> +@@
>>>> +-      ((E) ? "true" : "false")
>>>> ++      str_true_false(E)
>>>> +
>>>> +@str_true_false_r depends on !patch exists@
>>>> +expression E;
>>>> +position P;
>>>> +@@
>>>> +*      ((E@P) ? "true" : "false")
>>> Hello,
>>> The semantic patch is quite slow.  Actually it tests a large number of
>>> cases, eg where the parentheses are present and where they are not.
>>> A small optimization is possible in the non-patch case.  The outer
>>> parentheses are not needed, because you will already get the same
>>> information whether they are there or not.
>>> In contrast, for the patch case, the outer parentheses are needed, because
>>> if they are there we want to remove them, since they are not needed for
>>> the function call.
>>> Could you update the depends on !patch cases to remove the outer
>>> parentheses?
>>
>> You mean in non-patch case, we could just write like the following?:
>>
>> +@str_true_false_r depends on !patch exists@
>> +expression E;
>> +position P;
>> +@@
>> +*      (E@P) ? "true" : "false"
>>
>> I have tested in my machine. The impact of this parenthesis on performance is very minimal.
>>
>> With parentheses, the time on driver/ costs:
>>
>> real    1m41.696s
>> user    85m24.069s
>> sys    1m8.891s
>>
>> Without parentheses, the time on driver/ costs:
>>
>> real    1m40.438s
>> user    85m53.987s
>> sys    1m7.981s
>>
>>
>> Thanks,
>> Hongbo
>>
>>> Also, just one patch would be fine.  There are many changes, but they are
>>> all sort of the same, so it would be easier just to see them all at once.
>>> thanks,
>>> julia
>>>> +
>>>> +@script:python depends on report@
>>>> +p << str_true_false_r.P;
>>>> +e << str_true_false_r.E;
>>>> +@@
>>>> +
>>>> +coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)" % e)
>>>> --
>>>> 2.34.1
>>>>
>>>>
> 
