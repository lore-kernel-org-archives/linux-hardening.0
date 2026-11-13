Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559897;
	b=Gi8zLaLo/vFbAHiUoX1j1nnptK77LfX8WSun4rEmCLmPkX1oo2/KbNOmpRlh8I8FFcta
	 l+HbDZVx3MXBR4iUZPRuQSI2G0052hzowa4Hdt1+PYrv1QaGZ+0zecTNwNRGb9mtMgx/V
	 2Mv+MTIiSqMg+jt2iimFdFEG2Kc5f8UFUHn0Kxd3Hg57DxA/Z2EUtWHu8yOELXZoGyg8q
	 wZTohuvuwUj6rbtu3nia8HOSSfjkbaIexzdGnr5z5I0cnIF+h8qbXqxvrOwH9BnFICAJU
	 iwqk7QwDpHiAQMzxEOxjZsySUJDM8blsaUdPQ/14ctJUhACMWYgIb9oTJMvduIC5YgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:In-Reply-To:References:From:Subject:To:Cc:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=UnWUSSllMVMhg7PktgO/3YoCDA/za9YFOUp/rF6lTqM=;
	b=rB9h3AD5hUOHwO0L5a30/75W2J8YRYzrTCqA/rXxYVMX1At1cOmEYSW6gV1sWuqkqzTb
	 t1z8C9LkMcIzD6GP0oo2CQinFhwAEJby6hKMt+NlaZSAAIQNcLHyucT0DnR+UUmJko8rX
	 v0/uCbDjsMJGUOi9wKU2UTNAzjsk0HnZYTwuFNYnWX09kBAqOAoZMTXmEIg2GFmynYqPa
	 /s9NWWUupiuqpMIhGQehNYXbRo0pDftoRLuJS1iF8U4CWLMMIRTtQpBQ6jsQvaSkT+V2t
	 T0MyLjgJfGQ0oJP0ndCNjD3C+ggmXcov80gTfTyR5ZpIzR2mMTPNn2yn11lPdkZqE/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=EYH8iN2h;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06BE606CB1A
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A06BE606CB1A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=EYH8iN2h
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9e53d011eso10221485ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559896; x=1795164696; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UnWUSSllMVMhg7PktgO/3YoCDA/za9YFOUp/rF6lTqM=;
        b=EYH8iN2hkzgAfrtHXuplF1LouLGhOz3dEt5cfTghhvoh7BuMSLeV4tMpXaAl6x62Y1
         MRu3KIfolqdUXq4lDK9GTG+UTI3aI6y0TWtxe4FE8uBDY8D5WKgGTL73DcQfszX1QaiD
         yyr8a85huV/i8IY7fJXfu1cemmwY4fvz2Sc68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559896; x=1795164696;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnWUSSllMVMhg7PktgO/3YoCDA/za9YFOUp/rF6lTqM=;
        b=zi/1fgBcL7vjUH8kvQcDI7PP+J6MIDfMYIp0gYYi4PvjruoAdJQrLuOq3tcgJuev/w
         63DonjjzBgQdBfG3xgrllcnJ7I9tVRBuOr76J3dwheS8DVTXW5wjgi+dUTkSwJmy2vbH
         G7YM6wY+5HCptOd6z3lt/wIYBJuirRTOERYg5BkmMO/Bs1sQu/Qs+mNEtWl9pvaBxVFL
         xiadD3aNV9j/QMHp7tUW3oy++SnlYeQDDj7VV1SpGXcSrf9JMVL4G3/wDFHY14q6jAsH
         NMpXQ37KzqMO+6/tIogXuqB2P0hhCHFCUm+TiDdqGEXkS8cxqyz4MQEULRycXV21fb2s
         QX3A==
X-Forwarded-Encrypted: i=1; AL+hErEcKM9lKcECpVd3079qfaBLUXdhQT0xeX1UER3kL1S+qhbSFJAggeGlVUAqnnXFBri755uVCsfcofgRBwM4S3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1P0JSlFLZyNxSJSIXufRQIpvkDszJqYZXQqqXMBx+AsQ5+xjr
	6/ywUJhOU4MSv7NHJODWNIrLzdA3KUMBFQ/vJH0yxlwCJuLMmpvyO9okztLd5QWEIfc=
X-Gm-Gg: AYBFou3S3aJX3rD27Ehscuy8LF122/xSrrn8nlDORHEXYnFr0Qq154OpZlSXpoDJVOA
	PVFC8pP8BJQrcBdebn14Ftcv8Arqk9Eq4cB4nOR2DOXGEOFO0NLB09p4crtOTka2mjAftCRKaAQ
	r4Ig6S3bCOe2y2SdqHUe1pNW2sahHwmRBQ47Py+RHFcO/xOMjwA6R45IcLDydtnyKbbhD9yfxmM
	6K8iT4252Wtg5Zx3XC2ScnyquQZqexHvoY5Lrizy+DigMojeMlLCzOJYtMSS9i0cXRE3rr6Vy9u
	SKrLecD7/Z3ce7fUUoWFGYxuzbHrtBlI3WdDgiG88GjdBrVE6t8yq3IJWJ0o1l3MmE58JAQbPSv
	aE7wMgvKLTc1f5jPI+TM3JRtqwua+ar4Yl1du7YSFZuFTcEXtxVF33L9xG7/NHo9/RxDW6LgUSg
	zlYceG+GBS8F4qz0OPf+vYF6jYsM2p3ZTu9DTUUrqsyUL25raz/VKrXK+8JloNdQhi6Hz59899y
	1UloA32CNZk+AES65tLDZnOeRAzOh8sdWO0J0mnljM8VOEvSbza1JQkSoUezPI/dVptKE7T5bxV
	hT876EqcHDRf5uaxZ4Y1VQJXjOqojUdJ5D7Y631VNvO2P/ccugaUNVM8xnkScfve8icidUCdaQn
	kBlYZOJ9oQyqHx57BFMDmZ+OQaTq0oaQjNwuB/tWTCYDgyMEW8Kjq9wTvWimMaURBl2UiwvgU8q
	/MJ3YzkmTRZXJ3DacQEF7D30SoJs6T1JYQyl419/RpuPN9110i1BQ65DEYJfk=
X-Received: by 2002:a17:902:e88d:b0:2ed:acb:aa96 with SMTP id d9443c01a7336-2ee0dad0247mr21324925ad.24.1794559895887;
        Fri, 13 Nov 2026 00:51:35 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c86asm7039685ad.23.2026.11.13.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:51:35 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:32 -0800
Message-ID: <843f0f05bbe3ff36efd22d490e83b0260f8d2f81.1794506262.git.chris@chrisdown.name>
In-Reply-To: <cover.1794506262.git.chris@chrisdown.name>
References: <cover.1794506262.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v3 3/6] mm/slab: Support disabling SLAB_BUCKETS at boot
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

SLAB_BUCKETS gives allocations with user-controlled size and contents,
like memdup_user() and msg_msg, their own set of kmalloc caches, at the
cost of the memory for those caches. It can only be chosen at build
time, so hosts which want it and hosts which would rather not pay for it
need separate kernels.

Add a slab_buckets= early parameter, enabled by default on kernels built
with CONFIG_SLAB_BUCKETS=y, so that it can be turned off at boot.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++
 mm/Kconfig                                    |  4 +++
 mm/slab_common.c                              | 26 +++++++++++++++----
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..c27bbe205051 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6990,6 +6990,14 @@ Kernel parameters
 			apic=verbose is specified.
 			Example: apic=debug show_lapic=all
 
+	slab_buckets= [MM,EARLY]
+			Format: <bool>
+			Enable or disable separate kmalloc buckets on kernels
+			built with CONFIG_SLAB_BUCKETS=y. When disabled,
+			allocations use regular kmalloc caches. Ignored
+			without that option.
+			Default: on.
+
 	slab_debug[=options[,slabs][;[options[,slabs]]...]]	[MM]
 			Enabling slab_debug allows one to determine the
 			culprit if slab objects become corrupted. Enabling
diff --git a/mm/Kconfig b/mm/Kconfig
index d174537d941e..e602ebabd6e4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -231,6 +231,10 @@ config SLAB_BUCKETS
 	  of extra pages since the bulk of user-controlled allocations
 	  are relatively long-lived.
 
+	  The separate buckets can be disabled at boot with the
+	  "slab_buckets=0" kernel parameter, in which case these
+	  allocations use the regular kmalloc caches.
+
 	  If unsure, say Y.
 
 config SLUB_STATS
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 01c64ef661e7..272d22f411c2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -410,6 +410,16 @@ EXPORT_SYMBOL(__kmem_cache_create_args);
 
 static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 
+static bool slab_buckets_enabled __ro_after_init = IS_ENABLED(CONFIG_SLAB_BUCKETS);
+
+static int __init setup_slab_buckets(char *str)
+{
+	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
+		return 0;
+	return kstrtobool(str, &slab_buckets_enabled);
+}
+early_param("slab_buckets", setup_slab_buckets);
+
 /**
  * kmem_buckets_create - Create a set of caches that handle dynamic sized
  *			 allocations via kmem_buckets_alloc()
@@ -424,10 +434,12 @@ static struct kmem_cache *kmem_buckets_cache __ro_after_init;
  *
  * Context: Cannot be called within an interrupt, but can be interrupted.
  *
- * Return: a pointer to the cache on success, NULL on failure. When
- * CONFIG_SLAB_BUCKETS is not enabled, ZERO_SIZE_PTR is returned, and
- * subsequent calls to kmem_buckets_alloc() will fall back to kmalloc().
- * (i.e. callers only need to check for NULL on failure.)
+ * Return: a pointer to the cache on success, NULL on failure or when the
+ * separate buckets were disabled with the "slab_buckets=0" boot parameter.
+ * When CONFIG_SLAB_BUCKETS is not enabled, ZERO_SIZE_PTR is returned. In all
+ * of these cases subsequent calls to kmem_buckets_alloc() with the returned
+ * value fall back to kmalloc(), so callers that can live without separate
+ * buckets do not need to check the return value.
  */
 kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 				  unsigned int useroffset,
@@ -448,6 +460,10 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
 		return ZERO_SIZE_PTR;
 
+	/* NULL makes kmalloc_slab() use the regular kmalloc caches. */
+	if (!slab_buckets_enabled)
+		return NULL;
+
 	if (WARN_ON(!kmem_buckets_cache))
 		return NULL;
 
@@ -1059,7 +1075,7 @@ void __init create_kmalloc_caches(void)
 	/* Kmalloc array is now usable */
 	slab_state = UP;
 
-	if (IS_ENABLED(CONFIG_SLAB_BUCKETS))
+	if (IS_ENABLED(CONFIG_SLAB_BUCKETS) && slab_buckets_enabled)
 		kmem_buckets_cache = kmem_cache_create("kmalloc_buckets",
 						       sizeof(kmem_buckets),
 						       0, SLAB_NO_MERGE, NULL);
-- 
2.56.1

