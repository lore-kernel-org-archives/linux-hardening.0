Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420544;
	b=iWVSSqv5DAO/PWmc2Nm503SPBpbhzaiRggUvCtgQ7dI9VUyErg76jpnCHspWBnOrXERr
	 DlD9YH9qnOfcVIQLpUFqg+aTCckixj9PjO63g9EvAvFW0k0E9IV9D15SgD1f+NzM5XsOm
	 YcaxvDWWQyD11vu5dppY7LchTPgyncnioSnTq/2j2b1+2fiG35eQCNCRCfzjOPHFei7AM
	 HtHm9Xvr2PxkHpsO7AAElN3S9D+mgIHL0MHVLZTJCy/AZ+NGecEwXIgCsM8YAqIapvYLs
	 WWSJPtcngH88vavWnsWc9GDMrYALLjjpPro5KEViCvE4PUeLAn2NXtRKBzJBJzE414g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420544;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2R0GYd790JXnb4Y8ot5FR6nSs52IU/ungvwEsnVbrT8=;
	b=VJXZ3+bIYoQ55VHyWglJyjOxKj+IwH9LrL7e49B2AIi/ZtM3ws5DicDZy8hbbzPqINzg
	 ZTeo1OeRQvNKLN5iJB/fOU8+zue8zXpKGXx3Oi1e4feRL0ZHGSCw1HK8cuQ17EccdV3O1
	 XXk7bihIUGH008emoV8GMXCB8WYc6WB5qNuPr/599LO9+7XtlipByU91eX54JNf9cnjZA
	 h9j5djTX67X8VNb+Iwo+GTC8lPlRPdslVaJXL8BrtYp9esQxBKEMj6NpfAYzPOGAillhA
	 UEWYQoj2mUcnIP2dYQY5/LHt+4RwJ7pKTVFPiU0osM1YmDuj+o0nL/SuwwjTEP8S7WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jWF3W+s/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F0606A31A;
	Sat, 31 Oct 2026 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWF3W+s/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9151F000C1;
	Sat, 31 Oct 2026 04:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793420543;
	bh=2R0GYd790JXnb4Y8ot5FR6nSs52IU/ungvwEsnVbrT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jWF3W+s/1UqGh8FCgl+GBRs8Op4RxqFJ9/kFjrGf9PWl7ayKREc36HjsyAtHZEz4x
	 0LxCRfFC8ByNO0yTT0jQgUSuGxBle5jQFmEVaNgleN+8YvQJLNes7EKCkLclRIEkOt
	 0wJLrEQlMiMM6jyXLaLH7JJ44A5kvcJTf3HdXtM0TUBROwL8w2wn8CiP+pW9kk3fW1
	 cnmjcFUwMZaTHcyLBZNef8J9HTpPAEKn1Xf/9ffMR6VSBg8e9N0KO+GpM693LJkNvt
	 yhHZj8ZHJOUdw4u1fzf0XMFjtIC7zXWzBmLDKOBDSWXVur00pMF2pYEBAhmf7cIhC5
	 4DoEM4I5L3LZA==
Date: Fri, 30 Oct 2026 21:22:23 -0700
From: Kees Cook <kees@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 4/6] slub_kunit: Add a test for the slab_buckets boot
 parameter
Message-ID: <202610302117.74D1EB1@keescook>
References: <cover.1793253633.git.chris@chrisdown.name>
 <47c0b11109203640122a9b5b030d3f41bfbac609.1793253633.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c0b11109203640122a9b5b030d3f41bfbac609.1793253633.git.chris@chrisdown.name>

On Thu, Oct 29, 2026 at 02:08:44PM +0800, Chris Down wrote:
> Check that memdup_user() allocates from the memdup_user buckets by
> default, and from the regular kmalloc caches when they're turned off
> with slab_buckets=0.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  lib/tests/slub_kunit.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  mm/slab.h              |  4 ++++
>  mm/slab_common.c       |  4 +++-
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index e3b63f0338d5..670645875b27 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c
> @@ -9,6 +9,8 @@
>  #include <linux/delay.h>
>  #include <linux/perf_event.h>
>  #include <linux/kprobes.h>
> +#include <linux/mman.h>
> +#include <linux/string.h>
>  #include "../mm/slab.h"
>  
>  static struct kunit_resource resource;
> @@ -296,6 +298,41 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
>  	kmem_cache_destroy(s);
>  }
>  
> +#ifdef CONFIG_SLAB_BUCKETS

Please don't ifdef to drop a test. If you have to do any ifdef, use it
for test skipping instead.

> +static void test_slab_buckets(struct kunit *test)
> +{
> +	unsigned long user_addr;
> +	const char *name;
> +	void *p;
> +
> +	if (!slab_buckets_enabled)
> +		KUNIT_EXPECT_NULL(test, kmem_buckets_create("TestSlub_buckets",
> +							    0, 0, INT_MAX, NULL));
> +
> +	if (!IS_ENABLED(CONFIG_MMU))
> +		kunit_skip(test, "userspace allocation needs an MMU");
> +
> +	user_addr = kunit_vm_mmap(test, NULL, 0, PAGE_SIZE,
> +				  PROT_READ | PROT_WRITE,
> +				  MAP_ANONYMOUS | MAP_PRIVATE, 0);
> +	KUNIT_ASSERT_NE_MSG(test, user_addr, 0, "Could not create userspace mm");
> +	KUNIT_ASSERT_LT_MSG(test, user_addr, (unsigned long)TASK_SIZE,
> +			    "Failed to allocate user memory");
> +
> +	p = memdup_user((void __user *)user_addr, 64);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +	name = virt_to_slab(p)->slab_cache->name;
> +	if (slab_buckets_enabled)
> +		KUNIT_EXPECT_TRUE_MSG(test, strstarts(name, "memdup_user-"),
> +				      "allocated from %s", name);
> +	else
> +		KUNIT_EXPECT_TRUE_MSG(test, strstarts(name, "kmalloc-"),
> +				      "allocated from %s", name);
> +	kfree(p);
> +}
> +#endif
> +
>  #if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
>  #define NR_ITERATIONS 1000
>  #define NR_OBJECTS 1000
> @@ -489,6 +526,9 @@ static struct kunit_case test_cases[] = {
>  	KUNIT_CASE(test_kfree_rcu_wq_destroy),
>  	KUNIT_CASE(test_leak_destroy),
>  	KUNIT_CASE(test_krealloc_redzone_zeroing),
> +#ifdef CONFIG_SLAB_BUCKETS
> +	KUNIT_CASE(test_slab_buckets),
> +#endif
>  #ifdef CONFIG_PERF_EVENTS
>  	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_perf),
>  #endif
> @@ -505,5 +545,6 @@ static struct kunit_suite test_suite = {
>  };
>  kunit_test_suite(test_suite);
>  
> +MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
>  MODULE_DESCRIPTION("Kunit tests for slub allocator");
>  MODULE_LICENSE("GPL");
> diff --git a/mm/slab.h b/mm/slab.h
> index e94ac63d10dc..b5b344d6e402 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -390,6 +390,10 @@ extern struct list_head slab_caches;
>  /* The slab cache that manages slab cache information */
>  extern struct kmem_cache *kmem_cache;
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +extern bool slab_buckets_enabled;
> +#endif

This feels messy. Any reason not to just export it entirely and avoid
all the ifdefness?

> +
>  /* A table of kmalloc cache names and sizes */
>  extern const struct kmalloc_info_struct {
>  	const char *name[NR_KMALLOC_TYPES];
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b7a46c368ab1..9fe48da12010 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -29,6 +29,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/stackdepot.h>
>  #include <trace/events/rcu.h>
> +#include <kunit/visibility.h>
>  
>  #include "../kernel/rcu/rcu.h"
>  #include "internal.h"
> @@ -410,7 +411,8 @@ EXPORT_SYMBOL(__kmem_cache_create_args);
>  
>  static struct kmem_cache *kmem_buckets_cache __ro_after_init;
>  
> -static bool slab_buckets_enabled __ro_after_init = IS_ENABLED(CONFIG_SLAB_BUCKETS);
> +VISIBLE_IF_KUNIT bool slab_buckets_enabled __ro_after_init = IS_ENABLED(CONFIG_SLAB_BUCKETS);
> +EXPORT_SYMBOL_IF_KUNIT(slab_buckets_enabled);
>  
>  #ifdef CONFIG_SLAB_BUCKETS
>  static int __init setup_slab_buckets(char *str)
> -- 
> 2.54.0
> 

-- 
Kees Cook
