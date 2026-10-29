Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254131;
	b=T3MNvy+PvYTUxDe3zBWzlBD9i8Q6mQ32ndplxUQYeOm1YD1h6GPI5bE3kTRsqyJdYXQO
	 BpSpeqgaKk6/KbOL6ZxlR3DHfOwbuwZooVIpBWeexCHM50UV67DktAVCKLYic6RMhfq+2
	 Ib1FqHTOFurFfWknu767xRSbNaK0gsQgihg6XD2E5mpLD5o8dCxzdcjB0vOysgpCKhSoe
	 d55cIEwGVVm+7bAS/s1zR/VM4RjqWzghEZv/02sqEcJ57JQGYgBcfzogCJqDHUxrvKy9X
	 4tuhRkVG708UzXwvqQmgRcxf2RD8sPc5iPSkgkWXIIRsV+wMacsmV0oUItUy2ERe5fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=fr6lsRVu7pKC2uMXBLAv6yVcpzLAtilFokqfHYV3ttU=;
	b=Ye5KAuf1IspCiIsUxDVk6RKD4qu5C/uNBqKSDkwItE5vmFxhyK++aftNKzw1U1DIPsGj
	 0OMrE+ZJkOAc4KacHAdUtjOYGwvHC8ki5FbIzs4NWiot+yYPkKB07zC5yK4DyDaXGsDYt
	 nijGisEz7mG7ZgcIpRxuczworQzYtDFIA8JiceJVP75l8jFMh3DtpmrONOlLZyfDQY+Su
	 HUk5I1RUGWfzlFhB53sN2RIyzmSgM9c2ygHwZtoZ7WEw9W3ZokHckBVOtpMqbdL6I6opL
	 qdp+D+O7BIzcluWjS9Uf14r1UnAIRBLK8TqfCD9Jr1RQ4E4KJpC65z7gsFDIR7F8JkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=T+1CdUOF;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5A606A321
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 06:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93D5A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=T+1CdUOF
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a01cac8733so1391949b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 23:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793254130; x=1793858930; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fr6lsRVu7pKC2uMXBLAv6yVcpzLAtilFokqfHYV3ttU=;
        b=T+1CdUOF2S0zxP6AiHPqpBdu2vLU9BYmhx/gn9gkkhvXAQRAAiXpd6gZNfA/d/qjQN
         FLOXc0F5to357dYDzGiDJ4x4fCpUKnNpYaYd0tHwiuVzMV4Q1xyrAkCPwKfaSAGENrsJ
         YIMaHUc99k4pzEnBCSEzWenp/JPCpyPrHl8pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254130; x=1793858930;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fr6lsRVu7pKC2uMXBLAv6yVcpzLAtilFokqfHYV3ttU=;
        b=aa+9ODAdLQx9Vht5AniVfPnNVC+TAuUvLylXKuvqTUS2M/27sHvUfZfyclfNawJ2yM
         mL4BHYjuVw20cDdQOGGVWE9xDZtvWd6YyZ7E5XQf5zMYGoOzFg6v4c7jYRPJ7Z9zBKGW
         h7LkIQtT5S4SdhuQRvv177XaqK429/rkc7U98KvCTOmurZcjHDqOaVaCf07KL83naLPp
         ZVWJjvZy2Ic9smQQgEaby3Lnx+CEGVw+dI+groRbMriIOniQS2o/+tKRqZba4CBQ1PIu
         w4La8+RfYUrEbWlybpkhZdN/UC/ay0ma7QHCZJUuQfW1xZdTq0B1Yi8g7OMtGIhSE7pY
         TCvA==
X-Forwarded-Encrypted: i=1; AKwUvBz//FUUz4TCkBEY1MJ0j8vGwACK3Ks8qOX6rYCISWpvYg0V2iJKVPFjV04S07hgf4iD4w8JHMTw6QAieGw/i/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdRFmVYJJ8MMR3abpWtFgbwvLNkZhlXhdXvpKfqbb637EqDFOB
	xfp92eQ8lb2vfoJMLYKOZNK25gZmDGvF4O5QeYt8dRUZfZhRgJhv1NeBPPcoC5ZRuKM=
X-Gm-Gg: AYBFou0x8GTKHNJqSuiAkpJHIgZbakBnWSDkCvYCplCGKlFy0wzJl5q4H+RfLK3+7E9
	4W9+a7qShyKlBjjTOYs0Bmw5USE4HWy+WYF9ljDZC7oTDzWj9zoFnbrYhYo1FkG0JYOMdUOMUi5
	Vk8TaU/5q8JuEj4AH1HxRB8hzqOolZsPmm6yZ+M1zOYhAWADIGyOpyC4IUZh62/MUYPHEkPc1Z9
	hcJiHUZ2F0aMco4SLaq/FKyiJt+gqdLrUiDwBHFV1vpxatHj2vs5XiE66wEbJy+dDh8OzdmYLoZ
	TMAaACTqPMyWCPu7CE0L2Plhzhs1ily0FiaYs5GdJ4vSYA+P48Z14kbrn/dY+dwUlJvKVzycJIU
	u6/ZiSSEf+HEMcp5zPbr6+WDiBiVDSJmTZdVBhDJ4/v/xPfCYQYnny0Lc36PJXMMGcry94sLiJe
	JMleryE3fhKYyvfcCjblPubmCmll5nn5ZNFkF/aza9nM84QodeQQq5KsLZyhCWZUhtiVYAOpcWp
	QjngGpvktZ8hij0S03iC2+ekbvCCFmSOPEQaMua578F3RoLDfGTCDmaQF7G5zu/2+e6QqAB7U71
	9dRudq6UZfLtAUYwulKpIV76kH3eRU2Csiu21iJofPcajqUrn73xx0lk8nZ/AZgkyYe5jbrdugb
	BZvPV39E+faFTVzqfHotp8sFcewKenAR21MW5UZm4YLROa+6huhADyPfnd42yCZfB04RiF+Fy1d
	xdpgyRfRzvFs7TmUm1Ig==
X-Received: by 2002:a05:6a00:4518:b0:89e:37b1:b81e with SMTP id d2e1a72fcca58-8a6e71e1b92mr3812208b3a.31.1793254130054;
        Wed, 28 Oct 2026 23:08:50 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a6df0b52sm1840758b3a.43.2026.10.28.23.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:08:49 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:08:44 +0800
From: Chris Down <chris@chrisdown.name>
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 4/6] slub_kunit: Add a test for the slab_buckets boot
 parameter
Message-ID: <47c0b11109203640122a9b5b030d3f41bfbac609.1793253633.git.chris@chrisdown.name>
References: <cover.1793253633.git.chris@chrisdown.name>
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
In-Reply-To: <cover.1793253633.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Check that memdup_user() allocates from the memdup_user buckets by
default, and from the regular kmalloc caches when they're turned off
with slab_buckets=0.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 lib/tests/slub_kunit.c | 41 +++++++++++++++++++++++++++++++++++++++++
 mm/slab.h              |  4 ++++
 mm/slab_common.c       |  4 +++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index e3b63f0338d5..670645875b27 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -9,6 +9,8 @@
 #include <linux/delay.h>
 #include <linux/perf_event.h>
 #include <linux/kprobes.h>
+#include <linux/mman.h>
+#include <linux/string.h>
 #include "../mm/slab.h"
 
 static struct kunit_resource resource;
@@ -296,6 +298,41 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
 	kmem_cache_destroy(s);
 }
 
+#ifdef CONFIG_SLAB_BUCKETS
+static void test_slab_buckets(struct kunit *test)
+{
+	unsigned long user_addr;
+	const char *name;
+	void *p;
+
+	if (!slab_buckets_enabled)
+		KUNIT_EXPECT_NULL(test, kmem_buckets_create("TestSlub_buckets",
+							    0, 0, INT_MAX, NULL));
+
+	if (!IS_ENABLED(CONFIG_MMU))
+		kunit_skip(test, "userspace allocation needs an MMU");
+
+	user_addr = kunit_vm_mmap(test, NULL, 0, PAGE_SIZE,
+				  PROT_READ | PROT_WRITE,
+				  MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	KUNIT_ASSERT_NE_MSG(test, user_addr, 0, "Could not create userspace mm");
+	KUNIT_ASSERT_LT_MSG(test, user_addr, (unsigned long)TASK_SIZE,
+			    "Failed to allocate user memory");
+
+	p = memdup_user((void __user *)user_addr, 64);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
+
+	name = virt_to_slab(p)->slab_cache->name;
+	if (slab_buckets_enabled)
+		KUNIT_EXPECT_TRUE_MSG(test, strstarts(name, "memdup_user-"),
+				      "allocated from %s", name);
+	else
+		KUNIT_EXPECT_TRUE_MSG(test, strstarts(name, "kmalloc-"),
+				      "allocated from %s", name);
+	kfree(p);
+}
+#endif
+
 #if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
 #define NR_ITERATIONS 1000
 #define NR_OBJECTS 1000
@@ -489,6 +526,9 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_kfree_rcu_wq_destroy),
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
+#ifdef CONFIG_SLAB_BUCKETS
+	KUNIT_CASE(test_slab_buckets),
+#endif
 #ifdef CONFIG_PERF_EVENTS
 	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_perf),
 #endif
@@ -505,5 +545,6 @@ static struct kunit_suite test_suite = {
 };
 kunit_test_suite(test_suite);
 
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("Kunit tests for slub allocator");
 MODULE_LICENSE("GPL");
diff --git a/mm/slab.h b/mm/slab.h
index e94ac63d10dc..b5b344d6e402 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -390,6 +390,10 @@ extern struct list_head slab_caches;
 /* The slab cache that manages slab cache information */
 extern struct kmem_cache *kmem_cache;
 
+#if IS_ENABLED(CONFIG_KUNIT)
+extern bool slab_buckets_enabled;
+#endif
+
 /* A table of kmalloc cache names and sizes */
 extern const struct kmalloc_info_struct {
 	const char *name[NR_KMALLOC_TYPES];
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b7a46c368ab1..9fe48da12010 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -29,6 +29,7 @@
 #include <linux/memcontrol.h>
 #include <linux/stackdepot.h>
 #include <trace/events/rcu.h>
+#include <kunit/visibility.h>
 
 #include "../kernel/rcu/rcu.h"
 #include "internal.h"
@@ -410,7 +411,8 @@ EXPORT_SYMBOL(__kmem_cache_create_args);
 
 static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 
-static bool slab_buckets_enabled __ro_after_init = IS_ENABLED(CONFIG_SLAB_BUCKETS);
+VISIBLE_IF_KUNIT bool slab_buckets_enabled __ro_after_init = IS_ENABLED(CONFIG_SLAB_BUCKETS);
+EXPORT_SYMBOL_IF_KUNIT(slab_buckets_enabled);
 
 #ifdef CONFIG_SLAB_BUCKETS
 static int __init setup_slab_buckets(char *str)
-- 
2.54.0

