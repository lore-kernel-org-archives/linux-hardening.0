Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086581;
	b=KFV8lOKDDWimjQ0+KDLp2YPW7eeCzgiDkTroIi7lDVJLevFTAyAl1zf6q+XCZktxfbQN
	 mqopMeG2VL86IoECrKbg3b/8BKKuvfQ69FCbYDtkyS9ndknbigpX/P3lS6TeVPj7BE4gQ
	 ZzA/HeyMNrld+RaIBTUJ6chEW9J19OMU1hIQOwmYP+nFdV8ZXIlmfwe/j3VhUXJUaJiKA
	 PTOwAUJfqYIaX+Gw8riOJkL5HlJL/26a69y0/QuSs8/KgunjlXd4GS0P1WNBkjkkifdTY
	 LV9sm3OSqTHcsCQ1Fj9bq2aCWLQlDU+oKUQ0MnavLliQQbBXp+BKCykXrBv9RAMh4lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=WsDVlDiCyeeoi6YHVgqDovvrMD/IKVknSNFW9xBDDdM=;
	b=kth/MFZG28VHGz4pYzn/FQFBd28vH/oHhDRIz+EfPTNSzIP+eq6yAkwelu6QyQpb36XC
	 /cAvEcLOO6nOtbZOkPt35irj9hhFQGbZso2scXcztf4F5dLB2tCpRWsjDdwaR/xXAIIKJ
	 sq0pp2ctON2fsFZPYg3C3r6cRrLYirTlqXpuDQIbslRr09ONH/PgTAHCca58f4cKh5C4K
	 +wqKoH1zSNENkLPvbZTioAExxIlbJPk2wfb3VjtCBGG186OOUj+gtF59FGv4TVB4UlC3s
	 e9X9OZrHH05ZbbecMPaf7wHe26gKwQgyn2Kil1sksGRiwKQ0Lljk/aZoh26AiQy4UcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=oXS3sM3f;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493D60A261D
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 07:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5493D60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=oXS3sM3f
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9eb579c0eso21701125ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793086581; x=1793691381; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WsDVlDiCyeeoi6YHVgqDovvrMD/IKVknSNFW9xBDDdM=;
        b=oXS3sM3fj2XUadb1vc02xfYY7JbNUjMzEB1ySQjFATcVV+4RJ6CNOqYCN+U9s9XxSP
         si6YHQT30AZD9j6WiJrWoLTheN6jeOPZ5ePo8ir8ejCjumrJJtV83vfg56+xUpAoOkT6
         5qjOKS1SP2re90ySQ0wAQXmiVC9h3nJ/zmoyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086581; x=1793691381;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsDVlDiCyeeoi6YHVgqDovvrMD/IKVknSNFW9xBDDdM=;
        b=22kiTivFMqaFPEzsGsc8KaCSZ5xfIMu9Z+IUNuU4L1v7bOgsgbilyj9fBUhaFJFZA9
         DEsTneFTiV4zoUtLp7uhRK/p4ZcCoEBgqEQfuwhav/YzigkiZW9icDMaqctzG75aorqr
         ohaTHaZoKJOGQKATSuZP9FVjfoHyEyhiuxJkTu6zx6wQz39uH2BTSmvhoGHb+/yEW0LV
         cn/o2J7FHirloEbsSoFyyt/K7HSDBGmg6dv735t0593GnyIRkoxeucVWOGAwQVl50utP
         LdcaEl5o9RN91dPWAc4ukQ5PdJPrv91w8MoD8wqrsybsqAdBiuPEqj4Zui9ykx1OrZtN
         Rquw==
X-Forwarded-Encrypted: i=1; AKwUvBynXJo/1oIy/bDK2NE5ZQaa+wWlLd2r5mhtUERe77OiMJvyH4OlisCsc75dE9QcGUF31DHk6VjZzPFL3SZjBDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAD1v6oUEheyaRvqkoEY44BtQ5+yVjpZ+4LgporED23wwesmgj
	nGHgqUrdYyW3W1jQ7WjO8H/6NAaQOy5KKHObDnoaw9I07fkx30afc6QofVJ2KdvwktA=
X-Gm-Gg: AYBFou1380miDVLSyNA151aIMLh4D88Ph/WwqudRusQUAQXZMrq/FSmtyfmCWYm+/e+
	dD1jps/6OAIhi2Wj01ItNBXVg4vQaHr98+nkVhmKWKKB6/My6Dy8wdxfuxzs1G81CKmAxRQ0VIA
	KQa7q6+fm1wprg5TuLj0SdxuZ5w6WhaC4YRsbChlBFJ1Rn1/gwMXDLuyA74j6j/7/qg9SEvZSyW
	Rv97BGSYdJUUMEsRfyV7H5e/Sg4225rAkLu8t/fbHGfMFbenA9Qo1ODqQoLo5ctZECsXTmYcsXY
	lsJAFFHq28Yn5bzdNTytBk1RggVVGcTrqKR/TRQmhcOJz7hU9Tf3MRv7KLOElQmgLrDDuFnCRAP
	Sj7Jq23cL9BQVqywTU19il5yasPydtUgE6vYG4Yyzi7l0k1gq98mbVIjOu/UJViWk1hyQMO1jyb
	/eWzBCkMlZGtncdOIbt7lMGjoh1SNXi5cVLo3SUuvf7ZweQ07tUf3CO6d/xFqKhMwvO9LuIB3dy
	OrCipxH2pNYRiGIjBmw1jkikcWgI0Z3yZHt2hiGfsnlAViSsFLHpYzHoBn30Ix5mHePtZqoeOSv
	+dn4RFl5mnWNWCAXo++obSryCcUI/V47YHZcFvnIFa/tN5VKMW0GfJaCTdpU7OD9V7xwXgpEobk
	eSiaWv3oMWKsnZeTBP/stpKk=
X-Received: by 2002:a17:90b:35c6:b0:3ad:a17d:f46c with SMTP id 98e67ed59e1d1-3adeb194872mr6931650a91.62.1793086580701;
        Tue, 27 Oct 2026 00:36:20 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40614d7dsm2480038a91.3.2026.10.27.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:36:20 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:36:16 +0800
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
Subject: [PATCH 8/8] slub_kunit: Add a test for the kmalloc_partition boot
 parameter
Message-ID: <7c619e0ff37d83b825549ee257bb60a82bc8006f.1793086056.git.chris@chrisdown.name>
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
 lib/tests/slub_kunit.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 mm/slab.h              |  4 ++++
 mm/slab_common.c       |  3 ++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index 646596663b33..0fe10cbfc83d 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -430,6 +430,49 @@ static void test_slab_buckets(struct kunit *test)
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
@@ -628,6 +671,9 @@ static struct kunit_case test_cases[] = {
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
index 185df5e68419..934b9db1ef6b 100644
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

