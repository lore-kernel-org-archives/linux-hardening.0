Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42513B2B8
	for <linux-hardening@vger.kernel.org>; Tue, 10 Sep 2024 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935869; cv=none; b=mGy4NhfiDg7Q6buOmbXeFtZd41OiIAajkCw//8Bpq4KWWvvk5ZP/Ud4gRD9ln8/xgDTRxWo0w7XB0wB5X9+7aP//1kENEe1sMBBjn3KlOkfHEhGXDcQZK3Y89M16Nh09IpLflciZo8ObIWllC4KqG7Z4Bjc49T0U19g1IkWvJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935869; c=relaxed/simple;
	bh=9+er11clAjV0D05tH2HsEIh6W9u3IqXTAYgvBikZ9pQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=UkKGLf4y9e1dSGZ/YM02XUASU8fcBKBM65/7PCIEnCOdmMjP9Ol/1ZcaQeU4nmsO2K2NmNIJb9hP2OZA91IC6b3MHfWzv0dZppMCg1uAoERFNVndVXOdHakssABObDOF51zpF8rZn8AUt7TOVpuu8DLdUkBDGgNP8pQ8lgkv92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X2nt4709pz69Ml;
	Tue, 10 Sep 2024 10:37:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AFF38180100;
	Tue, 10 Sep 2024 10:37:37 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 10:37:37 +0800
Message-ID: <af6e5dfd-3b39-4520-895e-a88a38c69ada@huawei.com>
Date: Tue, 10 Sep 2024 10:37:36 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 1/9] coccinelle: Add rules to find
 str_true_false() replacements
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: <kees@kernel.org>, <andy@kernel.org>, <nicolas.palix@imag.fr>,
	<linux-hardening@vger.kernel.org>, <cocci@inria.fr>
References: <20240904091451.3328272-1-lihongbo22@huawei.com>
 <20240904091451.3328272-2-lihongbo22@huawei.com>
 <71436945-5386-ff6e-8e8c-b513d4509241@inria.fr>
 <95846cbd-c0a0-433d-95d2-82792a664e3d@huawei.com>
In-Reply-To: <95846cbd-c0a0-433d-95d2-82792a664e3d@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/10 10:23, Hongbo Li wrote:
> 
> 
> On 2024/9/10 0:00, Julia Lawall wrote:
>>
>>
>> On Wed, 4 Sep 2024, Hongbo Li wrote:
>>
>>> After str_true_false() has been introduced in the tree,
>>> we can add rules for finding places where str_true_false()
>>> can be used. A simple test can find over 10 locations.
>>>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>>   scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>>
>>> diff --git a/scripts/coccinelle/api/string_choices.cocci 
>>> b/scripts/coccinelle/api/string_choices.cocci
>>> index 5e729f187f22..50329c4c8acd 100644
>>> --- a/scripts/coccinelle/api/string_choices.cocci
>>> +++ b/scripts/coccinelle/api/string_choices.cocci
>>> @@ -85,3 +85,26 @@ e << str_down_up_r.E;
>>>   @@
>>>
>>>   coccilib.report.print_report(p[0], "opportunity for 
>>> str_down_up(%s)" % e)
>>> +
>>> +@str_true_false depends on patch@
>>> +expression E;
>>> +@@
>>> +(
>>
>> There is no need for the above.  That is only needed if there is a
>> disjunction, ie a set of possible changes.  Likewise no need for the ),
or, you mean the parentheses are unnecessary?

Thanks,
Hongbo
>> and the same in the next rule.
> 
> Do you mean str_true_false_r is enough, not need for str_true_false? I 
> noticed it was written this way before, so I've kept consistent with the 
> previous writing style.
> 
> Thanks,
> Hongbo
> 
>>
>> julia
>>
>>> +-      ((E) ? "true" : "false")
>>> ++      str_true_false(E)
>>> +)
>>> +
>>> +@str_true_false_r depends on !patch exists@
>>> +expression E;
>>> +position P;
>>> +@@
>>> +(
>>> +*      ((E@P) ? "true" : "false")
>>> +)
>>> +
>>> +@script:python depends on report@
>>> +p << str_true_false_r.P;
>>> +e << str_true_false_r.E;
>>> +@@
>>> +
>>> +coccilib.report.print_report(p[0], "opportunity for 
>>> str_true_false(%s)" % e)
>>> -- 
>>> 2.34.1
>>>
>>>
