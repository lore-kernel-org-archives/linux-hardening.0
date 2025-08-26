Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67620551C;
	Tue, 26 Aug 2025 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756184364; cv=none; b=qGlafg58DEnWvDhB5QNT08lNGhbF7XK0YxM9TZcRBm0CvIeN3ZKn7Guvz7s57zZcqc9FTSRlPCZcIXin1DGiJK3FX9K7AkNoaWXDjR2+WhToPBOVa+XZu/JKN5NWx64+SWFAQgPnWMD/FWq2uG0k6l1ZkiI+zUKTq8MdnvyxP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756184364; c=relaxed/simple;
	bh=vtWZCqxOns3+V4/9Z1Du/nZLNLGy4uCskUYcOMcpDp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BjXqUC4MGXhrMV4Y2ZLECHPYBfwZi9xmcntr4Ea0+NyPxaQ7/mNgYnjOoK91BvX60K+ysWbBQEyxYdhrbcHXOFOFvT5nzafTYQVckPKBMv2B+0hgr2sUm/1KegKyhw89SLQTHPlLpcpF5FOjsJotitBtHZIZ1dkVOkTIgSgcJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c9wMs74THz13NLV;
	Tue, 26 Aug 2025 12:55:37 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B38881402CF;
	Tue, 26 Aug 2025 12:59:18 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemk100018.china.huawei.com
 (7.202.194.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 12:59:17 +0800
Message-ID: <97dca868-dc8a-422a-aa47-ce2bb739e640@huawei.com>
Date: Tue, 26 Aug 2025 12:59:17 +0800
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
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <20250825154505.1558444-1-elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100018.china.huawei.com (7.202.194.66)


On 8/25/2025 11:44 PM, Marco Elver wrote:
> ...
> 
> Introduce a new mode, TYPED_KMALLOC_CACHES, which leverages Clang's
> "allocation tokens" via __builtin_alloc_token_infer [1].
> 
> This mechanism allows the compiler to pass a token ID derived from the
> allocation's type to the allocator. The compiler performs best-effort
> type inference, and recognizes idioms such as kmalloc(sizeof(T), ...).
> Unlike RANDOM_KMALLOC_CACHES, this mode deterministically assigns a slab
> cache to an allocation of type T, regardless of allocation site.
> 
> Clang's default token ID calculation is described as [1]:
> 
>    TypeHashPointerSplit: This mode assigns a token ID based on the hash
>    of the allocated type's name, where the top half ID-space is reserved
>    for types that contain pointers and the bottom half for types that do
>    not contain pointers.
> 

Is a type's token id always the same across different builds? Or somehow
predictable? If so, the attacker could probably find out all types that
end up with the same id, and use some of them to exploit the buggy one.

-Ruiqi
