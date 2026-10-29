Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254168;
	b=fTKk2klVxWLWBFCbtICd8djmFF/CEbBeJDlKHUlN5VPiotgw0xuluQar/AHAHvVdqDjo
	 jBG2oMPqg7+yxa//8NbeZoQwI7c9fc/rIeO4CfewZazXt3NtzcXE5xcGV5WqPbZxQCCD6
	 NDJPJ33t3oLZXxRFfe/JxhTaZCJjSai6WtGrPpcYfdA8l3uCxo1wOxDjzn1nevc/p4IIK
	 BbVxn8CdeI5jGDCtOYtKGJBlh7dJDlKj2R4HY3kG/NTfx+90bsRO4oDAkj+JMDBYsgci2
	 V9bcOMTiMzj1MJ0vZn2kHsnshA4j6Jo3/81vkisS8HOnTc33IFL4ktXd5hPAIV+NDcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=kJG/RgFaRLdMkGdKAhf/ALFLkcE1J6knB1UbEQSKpbg=;
	b=K+zoXNzFf+f9erPnxeBbQmKifHsa2H+s6LNMJQ+Oy6hY4KFfrHPP7Y01X2FCBAUJ19bR
	 EWBfGBxcpPnUPgG5cT0zOhzmYPaieVmjGw5JSdhyb3WkKP70stSo1fpnzEUgw9Arod3AZ
	 xrN2XcvZICER8KKFSbq8v1b0JGOaOMQAnrBEma8c+zKspnPgEOVeEvB19vj9fHYgPevF6
	 iuvUPnsU6ve4U/aP9i456FM+GMPVzSKvCwF1C8LKFSpMbZKI1WxdsOWlnevWncDyQZ6ch
	 erUCQe/abQnfE/6XQH2hAR8NjUtTcfkvfkieJvvM6XwqqQFSbvAX94Ld5i0hKVL688g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=pMUDAr53;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B6606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 06:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A98B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=pMUDAr53
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so859120b3a.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 23:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793254167; x=1793858967; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kJG/RgFaRLdMkGdKAhf/ALFLkcE1J6knB1UbEQSKpbg=;
        b=pMUDAr53zakRhaLJRVoGZnpBNpg+AvPmFK3NgAImketf4vC+bXEYoxFmM2aSzlfvqc
         WNysp2JFWyGstElcXHyq5UvOTgNKsjOswBALDB782GOi+X6llgskMhqceVSNVE/AThMc
         B5UTBEchSVKgfYwES5o33SSemWTSUzV7Nnzxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254167; x=1793858967;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJG/RgFaRLdMkGdKAhf/ALFLkcE1J6knB1UbEQSKpbg=;
        b=uukKHdWlzYgl6xNdoLK6oAqAfdKSnkTknVIwKO6mW9t7dsqJN3hNprFNzGZQTJPeT0
         W7r8M9MEcn/mbf58VoMuTQuUtr4ra4uAYLAYiLGw8mIOU5RZgG9qvMKb2N1LSfV2EJXW
         w7en+wjYaAZcJ0HBMRK5qikQjPhIw6rjkbMJe6CLxvKT8oeZE3gf6uDOxU28VS0PF63/
         LYFQBxdNtiB7gwweDQrE3XzputNrftT+VpV3YMatzo9WytxEiJwsSTJ6RAcl8kjmOvfq
         wmbe6VD7/B2i+06eh95o3PAPpv8bZWvCKapp69U0s0+hDyNSm3iKPFAplWdHvP47HPR3
         g74g==
X-Forwarded-Encrypted: i=1; AKwUvByD6q0MeNjs53k3hJQZZ7x8ccEAjjM2meGD0JD/EamffKuhvr0NrdYZfNK44xFNByi+rjZu7OE80ICBI8EiBcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTTsRchz9Q8O6cH/MNlhxFZtFolOpZR0YEDeD8mi+v0aOT30U2
	5C5CLhEj8UewDE11VJ6ns+hG1MOTAkzyerjKz9Z5NR+77Wfhtt3WZjluc8OH3FzVVJk=
X-Gm-Gg: AYBFou1YAh3ViXThQfN8iSRMUPhXIGDenkyRYh+2zKWQaAMbbg1HoBBxeOOUaPKlYsF
	LW2U94wFjUpkFCiuZGVWCBx5vqXIVA8FSz5QcxqqzjG5OrZr7ehCEN+RXR0hv0v7a+VuUsPDH0c
	kYkQZsSd+7rCq3Fy4L1a7AlUaB+fXz4eAZ9989XOnngKFZEhF0TdaaXTdKPCwZ/3Pk+owVU5Lxz
	cqESZy/eGHSvWRGOr3VL1IJmWab8CiYNDdRgSp82U9g69AOoDpgYJaL/v0sBef5msrsldMhAWbo
	lZDLprY5B18JLOoKF05owXUtTTWadK+ivAc26nYKx9QHcaFyfKADoTh2W7XtcjLYiW7USop08T3
	I1EDo0VmHo71YGRmyKjAVqNJiFmONSRmBd1kYad3MlKwjOk6TjH/yY+HFroRpMHTCsprCh1cfPq
	WNH0zzXxKbPHemR9YbCVrkWxU4EZC0Cm9NKaF2yqKIw6Ee6hLIVJNzS0UxNXCES/znPZgmsa2D3
	s9KcrAeH15CO6vaTJOMSMR7ifjtRTDPBKsMm6JzGY7upIj85iNxvrJDTD2CsKUkQPOjLcoYRC27
	6A67XKWW4UTEolgYZr2V2qZi5VkM0sEArvYiAWIQXvKq0Men754kgavGvRpqll1HNhvrdDxkJnR
	5N6ufvTL65T2yGq7X3fRN8XTVyqryVmjqCase8ltOrAIPs+EFr8vXVm0vc+4fJt2WfkWA8InHN7
	+Z3fapF7kIstgIznXeRR8=
X-Received: by 2002:a17:90b:4cd2:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3ae57f96d53mr3126592a91.9.1793254167010;
        Wed, 28 Oct 2026 23:09:27 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9bc6f7sm2447023a91.16.2026.10.28.23.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:09:26 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:09:21 +0800
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
Subject: [PATCH v2 6/6] slub_kunit: Add a test for the kmalloc_partition boot
 parameter
Message-ID: <66f981ce04dfb01d02d1683bb18ba6db1c4eabd1.1793253633.git.chris@chrisdown.name>
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

Check that the kmalloc partitions are separate caches by default, and
alias the normal kmalloc caches when they're turned off with
kmalloc_partition=0.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 lib/tests/slub_kunit.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 mm/slab.h              |  4 ++++
 mm/slab_common.c       |  3 ++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index 670645875b27..e3035864577d 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -333,6 +333,49 @@ static void test_slab_buckets(struct kunit *test)
 }
 #endif
 
+#ifdef CONFIG_KMALLOC_PARTITION_CACHES
+/*
+ * Each partition copy is a separate cache, unless the copies were disabled
+ * with kmalloc_partition=0: then they alias the KMALLOC_NORMAL caches.
+ */
+static void test_kmalloc_partition(struct kunit *test)
+{
+	enum kmalloc_cache_type type;
+	struct kmem_cache *s;
+	unsigned int idx;
+	bool found;
+	void *p;
+
+	for (type = KMALLOC_PARTITION_START + 1; type <= KMALLOC_PARTITION_END; type++) {
+		for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[type]); idx++) {
+			struct kmem_cache *normal = kmalloc_caches[KMALLOC_NORMAL][idx];
+			struct kmem_cache *part = kmalloc_caches[type][idx];
+
+			if (!kmalloc_partition_enabled) {
+				KUNIT_EXPECT_PTR_EQ(test, part, normal);
+			} else if (normal) {
+				KUNIT_EXPECT_NOT_NULL(test, part);
+				KUNIT_EXPECT_PTR_NE(test, part, normal);
+			}
+		}
+	}
+
+	p = kmalloc(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, p);
+	s = virt_to_slab(p)->slab_cache;
+	idx = kmalloc_index(64);
+	if (!kmalloc_partition_enabled) {
+		KUNIT_EXPECT_PTR_EQ(test, s, kmalloc_caches[KMALLOC_NORMAL][idx]);
+	} else {
+		found = false;
+		for (type = KMALLOC_PARTITION_START; type <= KMALLOC_PARTITION_END; type++)
+			found |= s == kmalloc_caches[type][idx];
+		KUNIT_EXPECT_TRUE_MSG(test, found, "allocated from %s", s->name);
+	}
+	kfree(p);
+}
+#endif
+
 #if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
 #define NR_ITERATIONS 1000
 #define NR_OBJECTS 1000
@@ -529,6 +572,9 @@ static struct kunit_case test_cases[] = {
 #ifdef CONFIG_SLAB_BUCKETS
 	KUNIT_CASE(test_slab_buckets),
 #endif
+#ifdef CONFIG_KMALLOC_PARTITION_CACHES
+	KUNIT_CASE(test_kmalloc_partition),
+#endif
 #ifdef CONFIG_PERF_EVENTS
 	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_perf),
 #endif
diff --git a/mm/slab.h b/mm/slab.h
index b5b344d6e402..8e1e5a3f044b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -394,6 +394,10 @@ extern struct kmem_cache *kmem_cache;
 extern bool slab_buckets_enabled;
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT) && defined(CONFIG_KMALLOC_PARTITION_CACHES)
+extern bool kmalloc_partition_enabled;
+#endif
+
 /* A table of kmalloc cache names and sizes */
 extern const struct kmalloc_info_struct {
 	const char *name[NR_KMALLOC_TYPES];
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5391149a2eed..406e8688ee0e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -782,7 +782,8 @@ EXPORT_SYMBOL(random_kmalloc_seed);
 #endif
 
 #ifdef CONFIG_KMALLOC_PARTITION_CACHES
-static bool kmalloc_partition_enabled __ro_after_init = true;
+VISIBLE_IF_KUNIT bool kmalloc_partition_enabled __ro_after_init = true;
+EXPORT_SYMBOL_IF_KUNIT(kmalloc_partition_enabled);
 
 static int __init setup_kmalloc_partition(char *str)
 {
-- 
2.54.0

