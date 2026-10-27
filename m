Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086571;
	b=RuVC9usRbt0WqS7IU7MWWTJKhlSRCuYwFX9hHWgtnqmWWs4StolepAcOssdH81RN5pC5
	 nVzMhX+4Bg2k93xJSuv9rs3blRrIUvo2PWhq/W1B3CfUw6FwrLsjWLnvPJd0h8rUbF9oF
	 Ev8hEx+PxSt08duEgUYbGn8wvcsKInAfWy7rdGWq/aqGp6B+AO3TKJ8ZuEb+MdTZnap4K
	 YcNTOATqRUaE7aFHJmG1LNZwI/EMb76orpG2FDUecHF0dbAc4NaGY9B3K08p0a6bUnOfL
	 phhz682dWS9es6FB3TRlVTl62FJsl5TQXM5mfhOdmmD3T7pf22Uz9T0eSKdVRFLmpOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=NjMmv6pm0tIRvcDaHQJ8L51He0Pq3qbg9jRbmDfBhFY=;
	b=4DFQJKgz0/gao6hJ4rlLn5VJphoxpz3rsr1Vz8y7lTqFnr2cZWUB7IXiovI0ccDesbul
	 RWGnwYTpKWme3CKJXqH7VJ4tciChxZ+SRB6Yc21oZcFY9vtpFAvUp1ywF7eHuVINXTTKz
	 fgGOJi0EodVXtT0Ec2kTSEzf71Pak4X52YVq2hm2+CIS2ziqFd9k3HPyM2y0nG+InTbEw
	 aKsS3fP2kqRMr8/uNWcDdvP1jtkqOifeznP7AD+KZ9XCpRsPU877BF1CLw/YyGjpEgNC+
	 fGYqvChw5teWa9moahTu6xWfKP1UmJm/XIg8eAKMDjKhH+d/rGVHsUM33Tujj0OC9Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=TXVGWLxh;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF54606A321
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 07:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFF54606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=TXVGWLxh
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ccca948203aso1188370a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793086570; x=1793691370; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NjMmv6pm0tIRvcDaHQJ8L51He0Pq3qbg9jRbmDfBhFY=;
        b=TXVGWLxhSB+Gb9nT63eM3MKUj//nPu0qw/Is2VaTnaKtdgIY2B2xrhKI49AsLoPREN
         HWaWxakSBSdsj1awp/r1EAWprRg9ltlHF4Pvbi9idT7sXLkJNd1U26ZELH/DMaDT0ThL
         2e2GoUAl8WKn20EnkkTZYx+VCRCQWoc0HwsDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086570; x=1793691370;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjMmv6pm0tIRvcDaHQJ8L51He0Pq3qbg9jRbmDfBhFY=;
        b=brdmM9EzBSvkWDCGroxMTNauvP05b7G4D/ITE/SIuSuCuheUUqnFmaXkDKgtdrvTk/
         Z7bzZil+D4Qh+Aik6miTOizFGZdx76/D08708o+j1qfb3zNOw8z2LjcTqqWzVkTh1NGI
         CDt1xlq+XSb+PBpvouqOjT39twRGAb/DtPkQBrDzO0a+Gadd4chm45ILCKtvZonTSRL8
         TKmVrJBtIoX1+3OGKx0XjUPE2A72MJyyKFjizakUIfhbW2C64CowaF+uRomilkFg8Khh
         aWUBKYn0nUIVFK8gC/jPrwHYLQZqQdE6iUYrQvcsLI5Wkvzzsxacpnsi0fl5OWlF3Rca
         irFg==
X-Forwarded-Encrypted: i=1; AKwUvBx9+N15R0tM0ROD0xYid5uhxgbA/LLUKscOLiyg3NpSAh+BcgivbJkz+rJYJoCOCDODwkDgyQwVxnnVzz0B24o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKujRw0FbnUIJbA8zVqAiVfmQZVJM2NcKB9VATVFPTtN2k5AxZm
	QqywB/DSTZ1xfI9GcrxM4so4MnUrhWitFfU81Lr0rjXL5uTCAKV83bHbDtVeOKYuKAo=
X-Gm-Gg: AYBFou0LyKrhELD00/9KUoDY2+1MZc3g8rmQxjQJ224QvoZAtVRyQHc2JyFiK/QwdjB
	jeonxZPpi6vaxnEGmK6Zxi6Tei88wkkUNw3c1wUdhCnbLmm0XguJ1J1cIr9HarM5yugE+IvAbhg
	aksTilsXs2JiD8qrUsMd4RLn5qz8jZA4eJxs1TDhdaSUUxWXnmo1mTCkIRx7CoJFHDhLSulnPty
	bBBKNBQ5cTYlN5+L6gxCQ5NdFoLHVrWvpjCY0IPwk8w4ktzNIuaaAVWo4rzimU+QHVyCEJkVnDV
	vypWUCSOptZfrrnh9tKYaeZfFjrlNj8OhqzQcwjDHv9Hu+NIYmw1d3M2Hz9I7/qvdkMRuT7vkjM
	MyYDcdh2dvmQAQQE1zwEO0UIeBGfunfJnj47cQwYrjGYdczkqwpq1egAG5j6Ouk3NeeqsCQ+aOA
	AlOJBMv9GCQHcy7MjLdMkeQgj1Q7pACDUaUlJmMWfsOGNFkludpElNj22rLLlZY4NpwVgQTfPNB
	lEP5L8pCQoaz3td67/CPHydJ21nkqPE0y/cAoSwqEOgiG+4DgPyRgyfOA0hV11c5/EUZrHJ/TXm
	oy7X706h6n9wbhk9ZAHlVG6kTUEXNIcK+ADJ5l9tMpzrK8R7MErimNpKC6imr7YqHVjTafmbUNw
	JsvRp0g62JW3zMTuRUp/x5f8=
X-Received: by 2002:a17:90b:4c92:b0:3a6:fc30:ce16 with SMTP id 98e67ed59e1d1-3adeafc7dd4mr7341488a91.51.1793086570089;
        Tue, 27 Oct 2026 00:36:10 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adf8f3f22csm6639832a91.3.2026.10.27.00.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:36:09 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:36:05 +0800
From: Chris Down <chris@chrisdown.name>
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH 6/8] slub_kunit: Add a test for the slab_buckets boot
 parameter
Message-ID: <92d3b7ad95c9b7cdc76eb8f361cc2b374c018edb.1793086056.git.chris@chrisdown.name>
References: <cover.1793086056.git.chris@chrisdown.name>
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
In-Reply-To: <cover.1793086056.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 lib/tests/slub_kunit.c | 37 +++++++++++++++++++++++++++++++++++++
 mm/slab.h              |  4 ++++
 mm/slab_common.c       |  4 +++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index 49b9942bc564..646596663b33 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -11,6 +11,8 @@
 #include <linux/kprobes.h>
 #include <linux/string_choices.h>
 #include <linux/swab.h>
+#include <linux/mman.h>
+#include <linux/string.h>
 #include "../mm/slab.h"
 
 static struct kunit_resource resource;
@@ -396,6 +398,38 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
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
@@ -591,6 +625,9 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_kfree_rcu_wq_destroy),
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
+#ifdef CONFIG_SLAB_BUCKETS
+	KUNIT_CASE(test_slab_buckets),
+#endif
 #ifdef CONFIG_PERF_EVENTS
 	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_perf),
 #endif
diff --git a/mm/slab.h b/mm/slab.h
index b648b33f25c3..185df5e68419 100644
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

