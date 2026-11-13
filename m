Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559903;
	b=tuCLiKuuieq0ZG+ovPzC9/+/o6P5x9Pk9JY8aAL7cWq/yMGrnNoXAyBBvmMJHumqmDTY
	 XJTF2Bn/kjUx42PNcAzpLy7NtUbXWEBJI9y3tKeqT85WuUwFzPH02kJs30cChdwc+gvfE
	 NHbXLkxojPdauy64UAWZ+DhxrqzGecqJrrabsB9DuQIHFXvGSbxa/Exta0TljKCwxdXz0
	 ZnYwfqDd/QK2qojJPiu/TAJIi4T9+CpO1TbTflyRn30FlqWqRbCNYKi00takw/UY5lly8
	 FQ2hp6Kiw2mHaUEXZ3QIxNLzWnqsU+RpBSEruk3jc/VuY1jyM0A3v9rT5lDd/pKAytQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:In-Reply-To:References:From:Subject:To:Cc:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=E7JpIOJtGBaq2Xw74Bm81qRvbnlUv386MdM8N1c/N3M=;
	b=LT+rjxjjPsoDj5EGFtuWRte5I11/fjqIFM692C6uvQtgrgWu5NLCL7Q2IZtl0oSgZlw2
	 SKIz28b0eNmbn3bKCXLJkc9sm4BrKVl+pvzJoONsabieq/UkmOSFwt7RavoWtpMPcL6e+
	 NNKQs6FD6H8Qm6yN6fRGdWjUzXHhVstkVh1+ogN/sqJ2EE/9xZ5nETRPUoRc2L1Jv2s5R
	 tvwOIvzH+bRHZKULBaSE1c82TClRcsx4hw8DonNfOy60Cr8d32WLtjuVL1nPoreZNXsp5
	 +VHAU+Sm2mOhDPuKCSLWWic39W/OK/F4NSxBIefaf6WLqevE0nzHe6TBcikc7xe4daA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=F2hxiijA;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB8606B36F
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3BB8606B36F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=F2hxiijA
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9eb579c0eso3940045ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559902; x=1795164702; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E7JpIOJtGBaq2Xw74Bm81qRvbnlUv386MdM8N1c/N3M=;
        b=F2hxiijAHc7/Pg4AdpkMlrYeYxAwjZK74A017Lebaba7WHeuuzb4ZzzOMb3jv1zmio
         HN3k8edj6s73igqBm+a9yIqc4gJqKWrSjXjrxJUJzJ/V20am6KJgqzAO4fwzJ+lNKOzq
         thi7zPurlLWgN00Qx7rWaJcabUXlFAxq0KVgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559902; x=1795164702;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7JpIOJtGBaq2Xw74Bm81qRvbnlUv386MdM8N1c/N3M=;
        b=vAGDbVGmYeQEv3G5WTAVpaRrF0LAzRb8M7lr4qRAWgu6eR6UIXyEd6JhajyxHjuMaT
         7gOelN36+0VDEH+RATz59d0puyUhS2+hS+z8YoRc3CuzU3fXF3U0cUEH/qcrmcWqr+lZ
         hiU6wPk4Cl4JdkBV264+gp/lK4XsWK5pgiHxkZjvxI6bZC5IFLtFmMwcp8vZjxEXTSsa
         g2949TTgrWatU/lsM463ZhqWpKiZKKXY5MBAC7maPlyyLIY+QY/RwhSNRNKo7vOt912V
         Odiaw5SXFAQ2ZMJ63/ZygdPyG5PSstMUZAnw0bqpVV6qAO+QczCAs2rZBbGCfIRgNbSt
         YocQ==
X-Forwarded-Encrypted: i=1; AL+hErH80PIu2ujO4vfxIdGrH1B4GDuRBOCEG3dKxGcMXBgNnmpsPNPKMptdNxnQWq4KH0+u0fytmIs6qoKrhyJ0My8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m+LYxBwaujPjcZKG2CFzrVI1GJs5xuwXdmukBxlnSXq48C96F
	/EaCwlv8Q9DWD9hPR8PYmBz+n8vd16Dp0WKbqlnRpd2OrLepTDmcOojGCGAaxu6nLF0=
X-Gm-Gg: AYBFou0y0uDz+FdvZzZYdNuTQANu8AO5u6+HsHxji0dFnzkoBqqHXt8EX4hzrky6x/x
	kpR7EkzkNub9kRxJjDt9wPfgul0lII/k0Mu9flKxFOGh69bPU5Q5sJH2UdG2ZUHtVmZNDlv3TcB
	8HyeNXr/TD0yUTCjrrDnHJAG6TA0jBbTmwwB0SBWXdgGt+vpQ5g4zLnVO7LVnb3y1+uAHSGFvb1
	6cw4TiY3dFgTuQxAV5U55bl9oA+YHLDPmgq84NiAz7ZsS7oxcvhykfzSh2552VsUiB4k/HnVc1X
	Fa2G/f/lLA6m/iiQrWaSH4dH5IU0HlOGeZcnRgiDwljZCgvmLGjyaNgLf5KcZDtpnJdZ1JxlNEn
	9OFQFCyE96PoHXlRjiBqRFIjffF2GTlQguo1bh07mbEX1Kp9Qczt48puuYIQQzl+iCzF7atzm1d
	pBE0l4QShw4aMupLAXwXofz7N1D/gaAox7qt+ribeb1iSO8hwI/5/QMYlT53xPX28BQ92iGRGcG
	U3kYvyZwCcWwv8MctNGltAZ//OYNdCAg69dPgGlPu1kawyuQKO43sy97i+9pqlSt1+yJmRggsF3
	WloL6kT/YWBBYfvLOjrYtrx8cpFN69Ps4av8fQ6B00KtImPNQrpipr+Gs/sIWR4QPKuZmAktrRf
	kZXbwC7QtWEMyFTFD4xdMujSmDmIy2HxVI1TNETgKwaGuT+ZfiNWo+3G3JuE4axM797238jV7tJ
	i2nu7yeTwnI9ReuGpz1dJZbymUzr4hoybxu1hfnbEqZFI2qpJuN4DX0m09j9MX7i7tUWDdFGiFt
	+7sKdmX
X-Received: by 2002:a17:903:3d10:b0:2ed:a8bc:6d48 with SMTP id d9443c01a7336-2ee0dc06844mr17927715ad.43.1794559902021;
        Fri, 13 Nov 2026 00:51:42 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7d9971sm6839925ad.34.2026.11.13.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:51:41 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:35 -0800
Message-ID: <14d2fcd42e3e8aa20ac8dcb736a9411cbfc9bcd0.1794506262.git.chris@chrisdown.name>
In-Reply-To: <cover.1794506262.git.chris@chrisdown.name>
References: <cover.1794506262.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v3 4/6] slub_kunit: Add a test for the slab_buckets boot
 parameter
To: Vlastimil Babka <vbabka@kernel.org>,
    Harry Yoo <harry@kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>,
    Christoph Lameter <cl@gentwo.org>,
    David Rientjes <rientjes@google.com>,
    Roman Gushchin <roman.gushchin@linux.dev>,
    Kees Cook <kees@kernel.org>,
    Marco Elver <elver@google.com>,
    GONG Ruiqi <gongruiqi@huaweicloud.com>,
    Jonathan Corbet <corbet@lwn.net>,
    linux-mm@kvack.org,
    linux-hardening@vger.kernel.org,
    linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    kernel-team@meta.com
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
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Check that memdup_user() allocates from the memdup_user buckets by
default, and from the regular kmalloc caches when they're turned off
with slab_buckets=0. The test is skipped on kernels built without
CONFIG_SLAB_BUCKETS.

Make slab_buckets_enabled global and export it to KUnit so that the
test can see it.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 lib/tests/slub_kunit.c | 40 ++++++++++++++++++++++++++++++++++++++++
 mm/slab.h              |  2 ++
 mm/slab_common.c       |  4 +++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index e3b63f0338d5..1af3f087134f 100644
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
@@ -296,6 +298,42 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
 	kmem_cache_destroy(s);
 }
 
+static void test_slab_buckets(struct kunit *test)
+{
+	unsigned long user_addr;
+	const char *name;
+	void *p;
+
+	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
+		kunit_skip(test, "requires CONFIG_SLAB_BUCKETS");
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
+
 #if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
 #define NR_ITERATIONS 1000
 #define NR_OBJECTS 1000
@@ -489,6 +527,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_kfree_rcu_wq_destroy),
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
+	KUNIT_CASE(test_slab_buckets),
 #ifdef CONFIG_PERF_EVENTS
 	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_perf),
 #endif
@@ -505,5 +544,6 @@ static struct kunit_suite test_suite = {
 };
 kunit_test_suite(test_suite);
 
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_DESCRIPTION("Kunit tests for slub allocator");
 MODULE_LICENSE("GPL");
diff --git a/mm/slab.h b/mm/slab.h
index e94ac63d10dc..6a28951f6d5d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -390,6 +390,8 @@ extern struct list_head slab_caches;
 /* The slab cache that manages slab cache information */
 extern struct kmem_cache *kmem_cache;
 
+extern bool slab_buckets_enabled;
+
 /* A table of kmalloc cache names and sizes */
 extern const struct kmalloc_info_struct {
 	const char *name[NR_KMALLOC_TYPES];
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 272d22f411c2..5575706b8938 100644
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
+bool slab_buckets_enabled __ro_after_init = IS_ENABLED(CONFIG_SLAB_BUCKETS);
+EXPORT_SYMBOL_IF_KUNIT(slab_buckets_enabled);
 
 static int __init setup_slab_buckets(char *str)
 {
-- 
2.56.1

