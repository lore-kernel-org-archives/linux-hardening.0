Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086565;
	b=zQx9DwNLtCuBg7DTfkFn43DmFwA8tPNe+00srZBEwxqtlPfOjIxHBM5aAP2r/efXEKuX
	 9zm/ogaM9ZjW/M2pSh8wXcDWNch61xtFP0O+D06eChaTpub4o26uZXrHN6rpLjtDHGIN8
	 QIUvDkzPBCaV47b4bjOkXzcpHqRFjqbLa1XyqVMoJqlcqXfNL0s9ZuFMhLPH4eTW2Vz5s
	 cRkTdfoWoYzCy+Xyl6McqwTElGR9Cn9Hf4Xd8u0VLQBAgqNCon2k5pzHDMwE2G+d2w2cJ
	 WaqzcFpuMjlFdbo22LIh93oelKqojyUL4k2aDKGKagAudfcojq24eMZSas/pWYST26w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=TeuNf51TxMDPa7xvpxS6POY5MbCscFG1kBCUI4jUNC8=;
	b=VD6OdrmoPt1pb33U4t2LhPN+8hToh8uUnqyDpPJm5isLda8a+fBqBneQTn3QW+kl+26Q
	 12bf95vpRaLGH8tQ2jftIoPcucZWYzv4pgWrAQh0ghHhmQJW6PK8QgpAUIfnC/aNH54AZ
	 Ofc41wNuxSrb8SB9D10fHzwZWlgAmbQjf13UcHsU4XM9tWvakJP787gdm8WgQ+0FSQeZT
	 j3XNlknGX1FVELrk6a4Ii4ptEDomBQ8m2G7Sxjzi/EJWLBU4f6fJcN261ap6HX22+diaW
	 tG7aijG/lXv/2p8e3afA+7ke+WPuaDg5Jfge3nO2eRSx3vCbCglFch4wjEuwwM2NDZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4sIvf2W;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790BD606A320
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 07:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 790BD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4sIvf2W
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8246b13cbso33775665ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 00:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793086565; x=1793691365; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TeuNf51TxMDPa7xvpxS6POY5MbCscFG1kBCUI4jUNC8=;
        b=t4sIvf2W+qLD3CqixmNHF0jnDEYkWaLv3ueAF9jTKdiJ8+KHNWlRKPFIoTJ7z195sY
         rls9+daC9CvtMAIjT2Avi6img8Qy0ImQ222XCWXDZP7l9SwTQIYRrFQoAqb4HcNOT6d+
         4UDhL0yFtHTxYVz/Mn6Htvuo3fj1IELxkYP+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086565; x=1793691365;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TeuNf51TxMDPa7xvpxS6POY5MbCscFG1kBCUI4jUNC8=;
        b=ofxIroVlPEh18Ii2rkFrm+4VRcnSHrFHOF7gLTN7oDI7E2+T9Pqk8vud0wFBGgT2Ff
         LEx/1rzCs4WfURCCpTVozUaIB080wTBm15J+m1zxTcWlNpIoC/EImdv646UANcQxY2m3
         rZGm0bCBePaxI8O1cYjCnD27vAJSYJLhRvA6tRFKCzR0jZWxvAtI6cBACLjbrMQ/oNBu
         bhH2JfawFUC2zTncK3IQIS4i3VJY0AKIXAyuKKBreSqvyHbeFWEosErhuTWg7IocL006
         R93DZG/+WdOOvwcuTXkAIdCcl3yTqxADqmI7mBoqfYaU6pMg32e0NrPfMyD3AQQ1RMsq
         VofA==
X-Forwarded-Encrypted: i=1; AKwUvBwp/8oMko5hLiZ7bDQ/YnX39csGgr6G+gDW+H5fRbGgUBOuXkeLL+NeVPzeXfZ5vGBvfi5Q/0gA35EefBOK+JQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjrbm2RvDeZqpr8jpcY4AJ60t5Leek8pmT4jzveq/cwURFeaOx
	R8Wdvw9xJMHkbTz6d5pwmJNHNpPe5d2I52kQPdPgFx3katKUx6y2Z352HtUjlvtoZ9U=
X-Gm-Gg: AYBFou1J2LBS+Yxa0/Au9CA7K5+NH3pWTNkp5bO0JntEmERxpXt5TiejqUj8irQUVkw
	MCM+EJHlXTlyll2YSNmB9n3zqakhjNd6pc4etfOTOmzLYLLW0IyCvzUCUvvu0G3xeIytQRGWXWn
	8EryAgVb9NZBruFrRzFZ8pe3QjotCWksBQr45W1HF2zqWx3NFUJ12zFSunwDjyy0v3rfI4tYax1
	cql5ZPkJ7qE4oLhL0ARljNg1jEddJdkB5RTS63lVYFyHDYfGVz3If2HEkaplPEkCvtMwyt4ZYt+
	ZOSwCrO1iWvL2u3qkdLyHfztFZRWuHlb/o/b9R9darkb0kIT5aX/+zEgyGHprMsMzyvdhxpRhk+
	OvqDKAgCfbW+3vIBPUG3sCDxWqzybswRHzHMWSIw2j6cB19FZbld0iPHqy+ZK5ggQsOavm7VdLB
	QD04rJ58KHIDyiPWHQl4jhdyrB403gHkfiXvVHM9/vbfeOAE15RJLCEnHvfjQiqC1GavKPLQ/kv
	7WHxfO35XBi+v3Cxt+oR8AtGcmApQ84zcrjReI9IOimretCMGlTak4Jt7dT4S3fOaoK9JfkUgfq
	EosJyjCU3fKGRzJHxbQOrhOftEeBTmHrHO35ESwzP6O0RrsvA3Bb66BWAVXhaDyXTz0uzYdEh8l
	jumlzSsOCvQyvfkpJ4tfSBo4=
X-Received: by 2002:a17:902:cccf:b0:2e3:598:75b8 with SMTP id d9443c01a7336-2ea9c67507bmr74148095ad.27.1793086564825;
        Tue, 27 Oct 2026 00:36:04 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce5912sm5015185ad.71.2026.10.27.00.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:36:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:35:59 +0800
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
Subject: [PATCH 5/8] mm/slab: Support disabling SLAB_BUCKETS at boot
Message-ID: <11c73e97a9a8a2a532b3637c290657f99dd6a69f.1793086056.git.chris@chrisdown.name>
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

Add a slab_buckets= early parameter, enabled by default on kernels built
with CONFIG_SLAB_BUCKETS=y.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++
 mm/Kconfig                                    |  4 +++
 mm/slab_common.c                              | 26 +++++++++++++++----
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5c4d784e7786..20710d6ccd1f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7001,6 +7001,14 @@ Kernel parameters
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
index 56c422684b44..ebdf14a87c71 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -235,6 +235,10 @@ config SLAB_BUCKETS
 	  of extra pages since the bulk of user-controlled allocations
 	  are relatively long-lived.
 
+	  The separate buckets can be disabled at boot with the
+	  "slab_buckets=0" kernel parameter, in which case these
+	  allocations use the regular kmalloc caches.
+
 	  If unsure, say Y.
 
 config SLUB_STATS
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e66c0778ee98..b7a46c368ab1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -410,6 +410,16 @@ EXPORT_SYMBOL(__kmem_cache_create_args);
 
 static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 
+static bool slab_buckets_enabled __ro_after_init = IS_ENABLED(CONFIG_SLAB_BUCKETS);
+
+#ifdef CONFIG_SLAB_BUCKETS
+static int __init setup_slab_buckets(char *str)
+{
+	return kstrtobool(str, &slab_buckets_enabled);
+}
+early_param("slab_buckets", setup_slab_buckets);
+#endif
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
2.54.0

