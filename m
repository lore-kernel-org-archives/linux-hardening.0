Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBE4D8C8;
	Sun, 26 Jan 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737875893; cv=none; b=jSrf1WiHki3LZNOTF3B0+5JuyoT+7+RlWPqvETanjPk0IxoGi4yp8kEAomtmoM+vCWLbE4Lj6yO2vcAeClyLzNMyyxs9nMd9WrTsmQlyv7l2uYEoB5LCJzLHWs/CT5U/NHytEcG/bJ4mDi4eJ5XUWlsGS8ggctmMprzCjtUIhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737875893; c=relaxed/simple;
	bh=cifKj7r/S3xNJEKDYgEHQjsGRGqn+jx1+bwQiCuUAEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K3cyVeBLT709WmImpeWjXQtnOn2nyCBLPoJHqv8aDU38xBC5OdDE65Ez1Tdd/qsNh7rmF7IK9dupNSvTPwaqvxJgWMz66xykzlu5w36N0jAY5YIbOHXCBVzkmxjdN8BIaaJrT4ITp3tRn/IH/+W+6t5YMw7RSaD5bJc8wmPbmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YgjVB65B5z1l090;
	Sun, 26 Jan 2025 15:14:42 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C0F78180042;
	Sun, 26 Jan 2025 15:18:06 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 26 Jan
 2025 15:18:05 +0800
Message-ID: <b64c6a55-bc27-443e-b2e2-8f6b8e2d1060@huawei.com>
Date: Sun, 26 Jan 2025 15:17:52 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: Achieve better kmalloc caches randomization in
 kvmalloc
To: Vlastimil Babka <vbabka@suse.cz>, "Christoph Lameter (Ampere)"
	<cl@gentwo.org>
CC: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Tamas Koczka
	<poprdi@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo
	<42.hyeyoo@gmail.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
	<linux-mm@kvack.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <20250122074817.991060-1-gongruiqi1@huawei.com>
 <a424b98e-87dc-4f1a-e18b-28ed28b555ef@gentwo.org>
 <62044279-0c56-4185-97f7-7afac65ff449@suse.cz>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <62044279-0c56-4185-97f7-7afac65ff449@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg100016.china.huawei.com (7.202.181.57)



On 2025/01/24 23:19, Vlastimil Babka wrote:
> On 1/22/25 17:02, Christoph Lameter (Ampere) wrote:
>> On Wed, 22 Jan 2025, GONG Ruiqi wrote:
>>
>>>
>>> +void *__kmalloc_node_inline(size_t size, kmem_buckets *b, gfp_t flags,
>>> +				int node, unsigned long caller);
>>> +
>>
>>
>> Huh? Is this inline? Where is the body of the function?
>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index c2151c9fee22..ec75070345c6 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4319,6 +4319,13 @@ void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flag
>>>  }
>>>  EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
>>>
>>> +__always_inline void *__kmalloc_node_inline(size_t size, kmem_buckets *b,
>>> +					    gfp_t flags, int node,
>>> +					    unsigned long caller)
>>> +{
>>> +	return __do_kmalloc_node(size, b, flags, node, caller);
>>> +}
>>> +
>>
>> inline functions need to be defined in the header file AFAICT.
> 
> Yeah, this could possibly inline only with LTO (dunno if it does). But the
> real difference is passing __kvmalloc_node_noprof()'s _RET_IP_ as caller.
> 
> Maybe instead of this new wrapper we could just move
> __kvmalloc_node_noprof() to slub.c and access __do_kmalloc_node() directly.
> For consistency also kvfree() and whatever necessary dependencies. The
> placement in util.c is kinda weird anyway and IIRC we already moved
> krealloc() due to needing deeper involvement with slab internals. The
> vmalloc part of kvmalloc/kvfree is kinda a self-contained fallback that can
> be just called from slub.c as well as from util.c.

Thanks for the advice!

I will send a V2 based on moving __kvmalloc_node_noprof() and kvfree()
to slub.c as soon as possible.

BR,
Ruiqi
