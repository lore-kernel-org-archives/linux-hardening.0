Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086542;
	b=xWFUg74kEkCVIdJLTFUmU4aoTZXZ33XXNls7qulOY4seav9LkDQzI7ozrfw0HVSgxARl
	 3l5kCPjtx2crXSXs+2eZEGCoCJrM8h8qpuMfgz1uEvSc5C11SkTy/q1/higRShJ1Bzgxk
	 KU1/qv34hYjR4PovcOa5UV8dSxK7G7ifANQ5C9j0VqeQfeRdW9wjd/xhS0zauk6eWPLyc
	 bkq5bFM3wnT20+z6evI6rgxx+/WhBKTHscc64TPUL6HZb+KEbaulMI3p/dYPbk+02LCyT
	 EbsXRSpsM9PYzXx/+M8Uc7VV/LQtYIhA8S52YEiToDpGE2XZOGYzOB31C//nX7oGSwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=HiOeizALgL+htPryz91jPJKAKWQ4nNVAQkQrkPjqDpY=;
	b=HTMX7IjWYWZdmqd06DnphpoWv+A2wEByvurqV0gpM+UdwPCyrmR7hgM7HtICXPpDhtZt
	 pQGiQcLq6HTr+PqojpzUYSd4gy6OhbgYMfMFtT/Fg6lFN5D4iaRadsF/9oyjucAYKIF2y
	 WkhO4cGTQ19iBpP7ve+x3naQ0z8G5naxso1hzaG3gsnMMvh0ItZrRQ1FFzlDgYfo5DgoW
	 bmYnihsj+AQS5x/Q3EKjILkSzsqDZAI6WE4DKWFVTQOuCMB7haua31XQ5PR6oCmeLgW9e
	 tp6Cdx0TJXDCqy8QfLfjJP1/NHCWhEvypqVtOpufAnkiQAtTUbU+Gpabfqn6C0z+GUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=jzfqJxMi;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C0606A31B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 07:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E5C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=jzfqJxMi
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1987827a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 00:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793086540; x=1793691340; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HiOeizALgL+htPryz91jPJKAKWQ4nNVAQkQrkPjqDpY=;
        b=jzfqJxMiyzjoTvcRto6vUwLyT33Ld/PNM/3tkguq4PFX+DIggDYGi6V6flUSLkahdj
         6ZmvHrWdlWHCmg8BKTXgS6EQhe4iVzvsfVlyweCJp8pE6sBO9tMUHrMDVTZzAlqH1rVv
         NElchlsi/IxicXGawloh114Wnh52mXfgGhKek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086540; x=1793691340;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HiOeizALgL+htPryz91jPJKAKWQ4nNVAQkQrkPjqDpY=;
        b=tiYIXQJYVq/CzpoGJIpZSzqqkDS7jOjXLnNtuICpJ/4luCgV8C64k4Rl09r72Z5x54
         FT/OXUOtGg7z5jwseqghRzCOOdXeCmtCLkoRRjn26XX2IP1pCsIKJqPLEM8KnYj9i56l
         ZsTa0xAzm9iv7S9ASxEiCbXXtPcJIP+BVr+FZ9X3in1aehBhxObVnE3++M/nlmaaKubi
         hR5fJlR0wLNpYkKFMPxfK1PqDWMo4RiaTuP+p5pCWRjVHAx6QC6B+IHR14j4h8xGlHl/
         f9B8KBuN/7l1PoPka5xrrqJUbNAvqIMYRElwObrSbtf4aO9LcTCVEB4ki2/OVvwL0RHx
         Q83g==
X-Forwarded-Encrypted: i=1; AKwUvBwJwDyfsrmSE+j7mGb602qlL/GDnXxwnPWTXrENTmWXGFnm3bVx0+bSouIvk13IuhDJYmCpp8sE3MKb7svPMk0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjbg+NSrAQ+dR19zFMS8LwaREk3xFWMmbs2+guiSkVXeaat0Nj
	ahkejMmb/QPD9Ivg6KuA/9xHaFTgvoUxVVg3GOyDGSrlYNitIyqvZ+XB9Gj8pjGpprw=
X-Gm-Gg: AYBFou1wJ7KIzhrzK8g5kd6eyEQkvhmyr4B7uelZU1fxiTARGyysF9qaRV03CntQIiQ
	y56mVQoITM156oZzsN/TcLZi+aSYjCgOc4WLFId3KYDh6h08u2WFm9iQdPIySzt1wx41wKrc/ts
	BGd7ak9Y4RTONWekMDPe7uM5866GYenLtnpeFgC8GeSD2wWDW32o6zGFkS1zCZlVQy/ZMzEnFd+
	7nblTQNQLBLQqqers+GQe8gij8qz1jwoojDvPhKS5j5LK134HfIo+c812MOh1ps03Tps7Li/pEQ
	tkl/SpUrGNRmZqzRkO7ibGyRhyzpo5+DknS5aivm6j0CUsETHPllHn5pa9dSzxNbRfKDGl33gUm
	Skv6SgNRFT22923EpBvqhAl4jQo5cWI1w+RRWqN5C28Roq1vk+qxPfnFQfRIgA9E7M4uhZ6C70I
	c1mQfAfpclgOZ7kZU9oIPSFQjWMacWVjnjEbPSsopW+QWZ0HDZcpMBqDKVpMRMGq9/ZsrCs6pTh
	HbvneojAxmsXop7zBrCrpVRRjcl13sC+iBlrlA8QVXc2Yn6BhYkVV2ugqLOBEFkDLFL+S5nrUAb
	iOod6vAua/VPJeuO7oPJccK6ukHXSN7Ke2uV0ytK2UZVN85Tn90bNrUflVJFQBXFph93cfwPDab
	BPg2sZL31jcJC1m7ASSCjLcA=
X-Received: by 2002:a17:90b:3b45:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3ade9b2cff5mr8340964a91.1.1793086540437;
        Tue, 27 Oct 2026 00:35:40 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb06c57sm7546810a91.3.2026.10.27.00.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:35:39 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:35:35 +0800
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
Subject: [PATCH 1/8] mm/slub: Support disabling freelist hardening at boot
Message-ID: <d244124ec287b576470a405c828432df69b4e9cb.1793086056.git.chris@chrisdown.name>
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

Add the slab_freelist_hardened= early parameter, enabled by default on
kernels built with CONFIG_SLAB_FREELIST_HARDENED=y.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++
 mm/Kconfig                                    |  3 ++
 mm/slab.h                                     | 13 +++++
 mm/slub.c                                     | 49 +++++++++++++++----
 scripts/gdb/linux/slab.py                     |  8 ++-
 5 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..ddf2f6fd60be 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7014,6 +7014,13 @@ Kernel parameters
 			option which can be undone by adding the
 			"hash_pointers=always" option.
 
+	slab_freelist_hardened= [MM,EARLY]
+			Format: <bool>
+			Enable or disable slab freelist hardening on kernels
+			built with CONFIG_SLAB_FREELIST_HARDENED=y. Ignored
+			without that option.
+			Default: on.
+
 	slab_max_order= [MM]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory
diff --git a/mm/Kconfig b/mm/Kconfig
index 604c58199acb..3ae97fec9946 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -214,6 +214,9 @@ config SLAB_FREELIST_HARDENED
 	  sacrifices to harden the kernel slab allocator against common
 	  freelist exploit methods.
 
+	  The hardening is enabled by default and can be disabled at boot
+	  with "slab_freelist_hardened=0".
+
 config SLAB_BUCKETS
 	bool "Support allocation from separate kmalloc buckets"
 	depends on !SLUB_TINY
diff --git a/mm/slab.h b/mm/slab.h
index e94ac63d10dc..8187ddb2face 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -540,6 +540,19 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
 	return false;
 }
 
+#ifdef CONFIG_SLAB_FREELIST_HARDENED
+DECLARE_STATIC_KEY_TRUE(slab_freelist_hardened);
+#endif
+
+static inline bool slab_freelist_hardened_enabled(void)
+{
+#ifdef CONFIG_SLAB_FREELIST_HARDENED
+	return static_branch_likely(&slab_freelist_hardened);
+#else
+	return false;
+#endif
+}
+
 #if IS_ENABLED(CONFIG_SLUB_DEBUG) && IS_ENABLED(CONFIG_KUNIT)
 bool slab_in_kunit_test(void);
 #else
diff --git a/mm/slub.c b/mm/slub.c
index 8fbc6bf8ebc5..c82bc626b657 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -214,6 +214,32 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 static DEFINE_STATIC_KEY_FALSE(strict_numa);
 #endif
 
+#ifdef CONFIG_SLAB_FREELIST_HARDENED
+/*
+ * Free pointers stored inside free objects are encoded according to this key,
+ * so it must not change once the first slab has been populated.
+ */
+DEFINE_STATIC_KEY_TRUE_RO(slab_freelist_hardened);
+static bool slab_freelist_hardened_early __initdata = true;
+
+static int __init setup_slab_freelist_hardened(char *str)
+{
+	return kstrtobool(str, &slab_freelist_hardened_early);
+}
+early_param("slab_freelist_hardened", setup_slab_freelist_hardened);
+
+static void __init init_freelist_hardening(void)
+{
+	if (slab_freelist_hardened_early)
+		return;
+
+	static_branch_disable(&slab_freelist_hardened);
+	pr_info("SLUB: freelist hardening disabled\n");
+}
+#else
+static inline void init_freelist_hardening(void) { }
+#endif
+
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			slab_obj_ext_has_codetag_key);
@@ -565,10 +591,10 @@ static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
 {
 	unsigned long encoded;
 
-#ifdef CONFIG_SLAB_FREELIST_HARDENED
-	encoded = (unsigned long)ptr ^ s->random ^ swab(ptr_addr);
-#else
 	encoded = (unsigned long)ptr;
+#ifdef CONFIG_SLAB_FREELIST_HARDENED
+	if (slab_freelist_hardened_enabled())
+		encoded ^= s->random ^ swab(ptr_addr);
 #endif
 	return (freeptr_t){.v = encoded};
 }
@@ -578,10 +604,10 @@ static inline void *freelist_ptr_decode(const struct kmem_cache *s,
 {
 	void *decoded;
 
-#ifdef CONFIG_SLAB_FREELIST_HARDENED
-	decoded = (void *)(ptr.v ^ s->random ^ swab(ptr_addr));
-#else
 	decoded = (void *)ptr.v;
+#ifdef CONFIG_SLAB_FREELIST_HARDENED
+	if (slab_freelist_hardened_enabled())
+		decoded = (void *)(ptr.v ^ s->random ^ swab(ptr_addr));
 #endif
 	return decoded;
 }
@@ -601,9 +627,9 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
 {
 	unsigned long freeptr_addr = (unsigned long)object + s->offset;
 
-#ifdef CONFIG_SLAB_FREELIST_HARDENED
-	BUG_ON(object == fp); /* naive detection of double free or corruption */
-#endif
+	/* naive detection of double free or corruption */
+	if (slab_freelist_hardened_enabled())
+		BUG_ON(object == fp);
 
 	freeptr_addr = (unsigned long)kasan_reset_tag((void *)freeptr_addr);
 	*(freeptr_t *)freeptr_addr = freelist_ptr_encode(s, fp, freeptr_addr);
@@ -6730,7 +6756,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 
 	slab = virt_to_slab(x);
 
-	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) ||
+	if (slab_freelist_hardened_enabled() ||
 	    kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
 
 		/*
@@ -8766,6 +8792,9 @@ void __init kmem_cache_init(void)
 	if (debug_guardpage_minorder())
 		slub_max_order = 0;
 
+	/* Must be settled before any free pointer is written. */
+	init_freelist_hardening();
+
 	/* Inform pointer hashing choice about slub debugging state. */
 	hash_pointers_finalize(__slub_debug_enabled());
 
diff --git a/scripts/gdb/linux/slab.py b/scripts/gdb/linux/slab.py
index ddde25aeca8d..eab6cf44b54b 100644
--- a/scripts/gdb/linux/slab.py
+++ b/scripts/gdb/linux/slab.py
@@ -96,8 +96,14 @@ def swab64(x):
     ((x & 0xff00000000000000) >> 56))
     return result
 
+def freelist_hardened():
+    if not constants.LX_CONFIG_SLAB_FREELIST_HARDENED:
+        return False
+    key = gdb.parse_and_eval("slab_freelist_hardened")
+    return int(key['key']['enabled']['counter']) > 0
+
 def freelist_ptr_decode(cache, ptr, ptr_addr):
-    if constants.LX_CONFIG_SLAB_FREELIST_HARDENED:
+    if freelist_hardened():
         return ptr['v'] ^ cache['random'] ^ swab64(int(ptr_addr))
     else:
         return ptr['v']
-- 
2.54.0

