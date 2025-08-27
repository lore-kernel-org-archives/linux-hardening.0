Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC82A308F37;
	Wed, 27 Aug 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283651; cv=none; b=rFxMICcV6CPgq6v9Rm+0D7GbSojmn54MyIppwKBVKXnh2EHle+HwuYIfqvbPqMSCLpFVu5sqcwoEi6o5H/FGrvNizJMXtj/tbpBKY2d37rjAONbR1xirNnkW/xKcC1SJ8o747FUVIvDsgVLEGvsq5HTvRXyVlhnazMMS96nA9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283651; c=relaxed/simple;
	bh=cYXm2wzUticeSHl8KY5RrAc5GvUgt52uWImcdrJUEtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VlgUbckuNBvZMsieYymToxoDXEoMZUZwouYeEQGffVZdEu17jq8QBEiBhs83rIgvqmns1owFmTqRaKjIfhlgCVvJJ/bBRVn5fT+rgFCIeFtR9NYmdx+1Kf7K1i5FbMqhtoqSsmLdlsO/KETRtE/eUunKkDvC1KrUUB/IQEWRcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cBd492l4szFrnD;
	Wed, 27 Aug 2025 16:29:29 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E97814011F;
	Wed, 27 Aug 2025 16:34:05 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemk100018.china.huawei.com
 (7.202.194.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 Aug
 2025 16:34:04 +0800
Message-ID: <0f718809-9efc-44a3-b45e-a0297f456f7d@huawei.com>
Date: Wed, 27 Aug 2025 16:34:04 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Marco Elver <elver@google.com>
CC: <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Alexander Potapenko <glider@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>,
	David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Florent Revest <revest@google.com>, Harry
 Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>, Kees Cook
	<kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matteo Rizzo
	<matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
	<rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, Vlastimil
 Babka <vbabka@suse.cz>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20250825154505.1558444-1-elver@google.com>
 <97dca868-dc8a-422a-aa47-ce2bb739e640@huawei.com>
 <CANpmjNMkU1gaKEa_QAb0Zc+h3P=Yviwr7j0vSuZgv8NHfDbw_A@mail.gmail.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <CANpmjNMkU1gaKEa_QAb0Zc+h3P=Yviwr7j0vSuZgv8NHfDbw_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100018.china.huawei.com (7.202.194.66)



On 8/26/2025 7:01 PM, Marco Elver wrote:
> On Tue, 26 Aug 2025 at 06:59, GONG Ruiqi <gongruiqi1@huawei.com> wrote:
>> On 8/25/2025 11:44 PM, Marco Elver wrote:
>>> ...
>>>
>>> Introduce a new mode, TYPED_KMALLOC_CACHES, which leverages Clang's
>>> "allocation tokens" via __builtin_alloc_token_infer [1].
>>>
>>> This mechanism allows the compiler to pass a token ID derived from the
>>> allocation's type to the allocator. The compiler performs best-effort
>>> type inference, and recognizes idioms such as kmalloc(sizeof(T), ...).
>>> Unlike RANDOM_KMALLOC_CACHES, this mode deterministically assigns a slab
>>> cache to an allocation of type T, regardless of allocation site.
>>>
>>> Clang's default token ID calculation is described as [1]:
>>>
>>>    TypeHashPointerSplit: This mode assigns a token ID based on the hash
>>>    of the allocated type's name, where the top half ID-space is reserved
>>>    for types that contain pointers and the bottom half for types that do
>>>    not contain pointers.
>>
>> Is a type's token id always the same across different builds? Or somehow
>> predictable? If so, the attacker could probably find out all types that
>> end up with the same id, and use some of them to exploit the buggy one.
> 
> Yes, it's meant to be deterministic and predictable. I guess this is
> the same question regarding randomness, for which it's unclear if it
> strengthens or weakens the mitigation. As I wrote elsewhere:
> 
>> Irrespective of the top/bottom split, one of the key properties to
>> retain is that allocations of type T are predictably assigned a slab
>> cache. This means that even if a pointer-containing object of type T
>> is vulnerable, yet the pointer within T is useless for exploitation,
>> the difficulty of getting to a sensitive object S is still increased
>> by the fact that S is unlikely to be co-located. If we were to
>> introduce more randomness, we increase the probability that S will be
>> co-located with T, which is counter-intuitive to me.

I'm interested in such topic. Let's discuss multiple situations here.

If S doesn't contains a pointer member, then your pointer-containing
object isolation completely separates S against T. No problem, and
nothing to do with randomness.

If S does, then whether they co-locate is completely based on the token
algorithm, which has two problems: 1. The result is deterministic and so
can be known by everyone including the attacker, so the attacker could
analyze the code and try to find out an S suitable for being exploited.
And 2. once such T & S exist, we can't interfere in the algorithm, and
the defense fails for all builds (of the same or nearby kernel versions
at least).

Here I think randomness could help: its value is not just about
separating things based on probability, but more about blinding the
attacker. In this scenario, with randomness we could let the attacker
unable to find out the suitable S, so they couldn't exploit it even
though such S & T exist. As you mentioned (somewhere else), the attacker
might still be able to "take off the eye mask" and locate S & T by some
other methods, e.g. analyzing the resource information at runtime, but
that's not randomness to blame. We could do something else about that
(e.g. show less for random-candidate slab caches), and that's another story.

> 
> I think we can reason either way, and I grant you this is rather ambiguous.
> 
> But the definitive point that was made to me from various security
> researchers that inspired this technique is that the most useful thing
> we can do is separate pointer-containing objects from
> non-pointer-containing objects (in absence of slab per type, which is
> likely too costly in the common case).

Isolating pointer-containing objects is the key point indeed. And for me
it's orthogonal with randomness, and they can be combined to achieve
better hardening solutions.

