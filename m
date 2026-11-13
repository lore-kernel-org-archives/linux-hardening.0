Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559915;
	b=fBaSV7LWx2DRSKofHFO2B4WBpAYgOWvC09ll1nNMot3hP5OlHvpHS7Kv4uBxRvQ5K3NF
	 cQQVUlZDqDUF3qHr+DY9YhUW2MnZqIRPj7N7Yder3Ymk7EMN39LAvv4Zv8PytT0nPlZD8
	 hBVg659dsCbChUDAw1kgr2j5TD3i6sVlhvdapefZVVwuEyt96ypWtNyPdtvL8LJtJtTSo
	 h9Uigq5RGN6nAb2WhZHLBQkTq5wnAJR4tBOMAKUySllry33GJ0tPBBmzn0X3SEn9UYToz
	 MHkQ8ra7Z7Bhga62/LEW5+pERIuQ1TzpmECO8ulEbuCFCpkeWsfr7UGaj61WUYbxJoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:In-Reply-To:References:From:Subject:To:Cc:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=+SHVtZshJgR7EfVrq7tFY+459hSuxkLyCsM2otXIkPk=;
	b=3+Kcc9HtwcYVWxdyZSXjorf0yc1NkpLKFIBk77rsVpuPIhVFuFm4yXyPSbRgZs1Ywwkq
	 FObnn4CAafktTY6m1WScBrbaKeCWeBEBIc9G0JXp3Hh+M0HIjQ1434UgxCvj2VQefH9gs
	 1nG09qlef2CbQJy8PDXoBadwM2ntvFKFxUZfj/eQHvqyzdubBjnVYbGXFeLMfcrboNbOv
	 bEMDYJMuMvvos5E9aKFCCpHsRgpRlcH+zOopkSDB5tAo7vn8duct3yRkPO9viNV0GXM0N
	 lSuKSeonu4V8RT35tLM7/68+biWnBcElIRRJuS2CE8uzmQotMn0gk3yL/3ePk79zJ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UZ6Lxa1P;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11A606A331
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE11A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UZ6Lxa1P
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso538934a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559914; x=1795164714; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+SHVtZshJgR7EfVrq7tFY+459hSuxkLyCsM2otXIkPk=;
        b=UZ6Lxa1PUPFlQVfHsq8c4m+2pmWrQpf5qKptnm6fWXQtGzJ1GxA+h4RU1RifcD8L+F
         3o0oYyP6cZbGmcMPFFUXPBM191qbaSnV2nR4Hd8iU0y/zl367LGLUboXN1ozRQM7gDCn
         ONv0EgoF0C36SeCQU2kBjmyW3a8AwTaLcjI9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559914; x=1795164714;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+SHVtZshJgR7EfVrq7tFY+459hSuxkLyCsM2otXIkPk=;
        b=Lxb0oKWvSXIFpTCOgP16EGe5vHDsN6YZF/WkWRnB/fG0ZS6iYgfOKSq9vvyQtgXQRf
         Tr2g/+NmN61KVXFgsEHyCSPqgyMjvHEa9gsAQ69BEVvkmz04ggsPsWgQ602il9Y9Up53
         SBwxOOYguwKjE4+8U0/6+R0QbzxhCLaMKf5jc0VPQP/fY83p4HsFM1InOXnk3HQ5dfnu
         btiGFxFgESzVvkoYpf55FlrHJF4cSror9oVdbHAzh6zf7C8l0p5vKS+3uq7lfBJwKdah
         O3WbQCC7CzWKJ2H5/SRbDeFnydEYn08kvE15fBkEgpympX2OgktUiOAYO7vHgoj3gyDH
         B3Cw==
X-Forwarded-Encrypted: i=1; AL+hErG4ZGZur0iRWZSZ6dxVfLfSqdozfK/3aw779M4rRjk6qUjXQjgQA/xq1WEuoSh4YwY26q5KenY0NcvVXsiXIn0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TOV6iCyWZh1BWlAniBHROwYbS25CZpJzxbO9Pu6MRDY6pJm46
	uBgeXgb3bSoK7NAUoxQwB9x1rNgpsINbvBeL1/XJ0+TD02gP0W7p8kYFT2owH8dxuy0=
X-Gm-Gg: AYBFou0cuzzWQiNNlYjLCh+hoG3FQr9NFoAr7tNJoYDHP859WgRSMTVYVNu0zAWDyjm
	zvV559d/E75wmuAYf+/rYTIDXwZTLg3MI0NIuNVAXWpRcCcNdC5VozXRdWQgjVz5+pzW04Il7eB
	vJFPdtd5XdbejnqMSaYvmqpoqtxXMBzPwpn/ntSr1odachOmWdGxUgyayYlSh1qfMKooBDn8/Qt
	FjV1lPaHe4Ty4KKPgS4tJTHGEqktkgYDogXJz+8fMLEUA+gbfbZJ9sImWZidtVfpVTPMNYwGHM4
	RMGE6rzwBKtDDllXtrZDQgkuFmhPoAhiCsPvB9Q0gqVAQRvBmGVSUaOEOf2vmGCRGwnE6a+z3JC
	i1nKATiKasTnc6FkCaB5paW3ZzxmoVZs6XxFuWvLNVBbOtyMySo7ig0KcZYijP/a+Ktq71M8Ry+
	/roLDwKCHJQ1VlEsx+fPR/H24nDZqylzfyrQHo2M8BWuEQyEY9VqvFZemIm4rxiGoYnFb6xQrwI
	HaCYJvxv+E7meZQrfIRRL8g3OQxOjcr7Yp07sJCoN3URJlXupix5Xk7P8lmpj/fJCvpMj2vnJNA
	gxyLTvKH09h4thT2ukVDsT4EPcPQvPmm4v8DJULtg8lka8qbBkN2sA4xLVVwVRuEhOtoDwLT73N
	Ypl/2cF3tf9iEIdA2QYcd/pfz0wb8h6OFd/dG2enAVNuNy67ATvdMJ2o7MtoiQXJzXVax1A1xHC
	VOWqjXEcy6IHgn6jRzKrqePMKcwPG2lqnLpvUYDHWI0SnXVoemVVuPHHw3OM0=
X-Received: by 2002:a17:90b:37cf:b0:3ac:9e76:aa76 with SMTP id 98e67ed59e1d1-3b1b09f3b85mr1586733a91.13.1794559914380;
        Fri, 13 Nov 2026 00:51:54 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b708adsm1115279a91.4.2026.11.13.00.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:51:53 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:47 -0800
Message-ID: <ef93230b8a053d234bcb02392f505ae4b0968e6f.1794506262.git.chris@chrisdown.name>
In-Reply-To: <cover.1794506262.git.chris@chrisdown.name>
References: <cover.1794506262.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v3 6/6] slub_kunit: Add a test for the kmalloc_partition boot
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

Check that the kmalloc partitions are separate caches by default, and
alias the normal kmalloc caches when they're turned off with
kmalloc_partition=0. The test is skipped on kernels built without
CONFIG_KMALLOC_PARTITION_CACHES.

Make kmalloc_partition_enabled global and export it to KUnit so that
the test can see it.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 lib/tests/slub_kunit.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 mm/slab.h              |  1 +
 mm/slab_common.c       |  3 ++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index 1af3f087134f..61227c242ae2 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -334,6 +334,50 @@ static void test_slab_buckets(struct kunit *test)
 	kfree(p);
 }
 
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
+	if (!IS_ENABLED(CONFIG_KMALLOC_PARTITION_CACHES))
+		kunit_skip(test, "requires CONFIG_KMALLOC_PARTITION_CACHES");
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
+
 #if defined(CONFIG_PERF_EVENTS) || (defined(CONFIG_KPROBES) && defined(CONFIG_SMP))
 #define NR_ITERATIONS 1000
 #define NR_OBJECTS 1000
@@ -528,6 +572,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
 	KUNIT_CASE(test_slab_buckets),
+	KUNIT_CASE(test_kmalloc_partition),
 #ifdef CONFIG_PERF_EVENTS
 	KUNIT_CASE_SLOW(test_kmalloc_nolock_and_friends_perf),
 #endif
diff --git a/mm/slab.h b/mm/slab.h
index 6a28951f6d5d..2a9d6a9a9948 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -391,6 +391,7 @@ extern struct list_head slab_caches;
 extern struct kmem_cache *kmem_cache;
 
 extern bool slab_buckets_enabled;
+extern bool kmalloc_partition_enabled;
 
 /* A table of kmalloc cache names and sizes */
 extern const struct kmalloc_info_struct {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 20b066d61703..d0695e4d2ab6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -781,8 +781,9 @@ unsigned long random_kmalloc_seed __ro_after_init;
 EXPORT_SYMBOL(random_kmalloc_seed);
 #endif
 
-static bool kmalloc_partition_enabled __ro_after_init =
+bool kmalloc_partition_enabled __ro_after_init =
 	IS_ENABLED(CONFIG_KMALLOC_PARTITION_CACHES);
+EXPORT_SYMBOL_IF_KUNIT(kmalloc_partition_enabled);
 
 static int __init setup_kmalloc_partition(char *str)
 {
-- 
2.56.1

