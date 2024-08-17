Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0633E8;
	Sat, 17 Aug 2024 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723858265; cv=none; b=WdM7PKeu3k8P5FFGcehrbclmZ/au3ktT3prMmekCYwmaaEvg6UTfZtAJ0yo6Sd/WyxtQA6rlKA5+gEtTTUx6019sK5ILOCyoTUVT9FtymN9jkUSOrUWWcqPuZiwjGWSHyz2/k9udvjzPov1cgbD5bqEZIVt15OqmG5Q82mQOwDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723858265; c=relaxed/simple;
	bh=eCz1qgGD7M3l4pwI5OuTdSjUMQm+4S3nWZ++hnwv5jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwLrJCOGqv9BzOPB+YiViGeaGzUS79SRXHS7mcINwzsi13Gz0bDrpu2rXPuOCyMTI3eidf4+Q3Q7AnqHi11zjamkXJb3PJlmp7SVglwGDrrfO30yfOxjyXvEbME0tv7L+CwRv1z0OLpLARIPLsatl7aeT0XTBIGo6sJvlFdh1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wm1X56fWlz4f3js9;
	Sat, 17 Aug 2024 09:30:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D064B1A058E;
	Sat, 17 Aug 2024 09:30:59 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP4 (Coremail) with SMTP id gCh0CgAnmoBS_b9mcaGdBw--.32124S2;
	Sat, 17 Aug 2024 09:30:59 +0800 (CST)
Message-ID: <1ddb539a-79ed-d992-76cf-061acb4df11e@huaweicloud.com>
Date: Sat, 17 Aug 2024 09:30:58 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 5/5] slab: Allocate and use per-call-site caches
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Christoph Lameter
 <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 "GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Jann Horn <jannh@google.com>,
 Matteo Rizzo <matteorizzo@google.com>, jvoisin <julien.voisin@dustri.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240809072532.work.266-kees@kernel.org>
 <20240809073309.2134488-5-kees@kernel.org>
Content-Language: en-US
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <20240809073309.2134488-5-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnmoBS_b9mcaGdBw--.32124S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW5Xw4xZF18KFWrCrW5GFg_yoWrJw4UpF
	WxWa15GFs5XFy7Ca9xt348WrySqayrGFy5Jayaq3s5ZF1Yqr18WFn7GrWIvrWkAry5CF40
	gF9YyasI93WUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

Hi Kees,

On 2024/8/9 15:33, Kees Cook wrote:
> Use separate per-call-site kmem_cache or kmem_buckets. These are
> allocated on demand to avoid wasting memory for unused caches.
> 
> A few caches need to be allocated very early to support allocating the
> caches themselves: kstrdup(), kvasprintf(), and pcpu_mem_zalloc(). Any
> GFP_ATOMIC allocations are currently left to be allocated from
> KMALLOC_NORMAL.
> 
> With a distro config, /proc/slabinfo grows from ~400 entries to ~2200.
> 
> Since this feature (CONFIG_SLAB_PER_SITE) is redundant to
> CONFIG_RANDOM_KMALLOC_CACHES, mark it a incompatible. Add Kconfig help
> text that compares the features.
> 
> Improvements needed:
> - Retain call site gfp flags in alloc_tag meta field to:
>   - pre-allocate all GFP_ATOMIC caches (since their caches cannot
>     be allocated on demand unless we want them to be GFP_ATOMIC
>     themselves...)
>   - Separate MEMCG allocations as well
> - Allocate individual caches within kmem_buckets on demand to
>   further reduce memory usage overhead.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/alloc_tag.h |   8 +++
>  lib/alloc_tag.c           | 121 +++++++++++++++++++++++++++++++++++---
>  mm/Kconfig                |  19 +++++-
>  mm/slab_common.c          |   1 +
>  mm/slub.c                 |  31 +++++++++-
>  5 files changed, 170 insertions(+), 10 deletions(-)
> 

[...]

> diff --git a/mm/slub.c b/mm/slub.c
> index 3520acaf9afa..d14102c4b4d7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4135,6 +4135,35 @@ void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
>  }
>  EXPORT_SYMBOL(__kmalloc_large_node_noprof);
>  
> +static __always_inline
> +struct kmem_cache *choose_slab(size_t size, kmem_buckets *b, gfp_t flags,
> +			       unsigned long caller)
> +{
> +#ifdef CONFIG_SLAB_PER_SITE
> +	struct alloc_tag *tag = current->alloc_tag;

There is a compile error here if CONFIG_MEM_ALLOC_PROFILING is disabled
when I test this patchset.

mm/slub.c: In function ‘choose_slab’:
mm/slub.c:4187:40: error: ‘struct task_struct’ has no member named
‘alloc_tag’
 4187 |         struct alloc_tag *tag = current->alloc_tag;
      |                                        ^~
  CC      mm/page_reporting.o

maybe CONFIG_SLAB_PER_SITE should depend on CONFIG_MEM_ALLOC_PROFILING


> +
> +	if (!b && tag && tag->meta.sized &&
> +	    kmalloc_type(flags, caller) == KMALLOC_NORMAL &&
> +	    (flags & GFP_ATOMIC) != GFP_ATOMIC) {
> +		void *p = READ_ONCE(tag->meta.cache);
> +
> +		if (!p && slab_state >= UP) {
> +			alloc_tag_site_init(&tag->ct, true);
> +			p = READ_ONCE(tag->meta.cache);
> +		}
> +
> +		if (tag->meta.sized < SIZE_MAX) {
> +			if (p)
> +				return p;
> +			/* Otherwise continue with default buckets. */
> +		} else {
> +			b = p;
> +		}
> +	}
> +#endif
> +	return kmalloc_slab(size, b, flags, caller);
> +}
> +
>  static __always_inline
>  void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
>  			unsigned long caller)
> @@ -4152,7 +4181,7 @@ void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
>  	if (unlikely(!size))
>  		return ZERO_SIZE_PTR;
>  
> -	s = kmalloc_slab(size, b, flags, caller);
> +	s = choose_slab(size, b, flags, caller);
>  
>  	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
>  	ret = kasan_kmalloc(s, ret, size, flags);

