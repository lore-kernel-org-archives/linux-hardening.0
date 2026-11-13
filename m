Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559909;
	b=ZSCbDRivjq1k3Decidi7YQmXje/4pjmEusWPPrbnaR6Zcj1pzIXLEHjRHtV3J7BIO/Pl
	 UvlQwQEi7sTwnW1Wx9o02TSsqTTNVDDeL8vgTW8Jd5gVff+H1o+7VnI1vOu+CGCNE00o/
	 EfmcYi/LmaOmu0J5Jj5CQkPnzFPPJGJbvaOCdGvMTLB9zeNRFKF3xxkEXcS2nMFcIG7eC
	 XOAyG85tavEYDVo+J5x4uLK/GPWV1o7xahJvpqR81i+82z6iDg/KVO9Q46Xxjpup0dzdN
	 kyyEMnABJ5FG+FSOKf1F2NrFlP5afP5u8r9YOsz0JFh40MgmQ5pgtHa5F5kOckFfn1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:In-Reply-To:References:From:Subject:To:Cc:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=lYzK3//iA/GrlqyqFKm7zb2MSKDdJnrLMa2XfcjD5wg=;
	b=ACNTBoD7ZmAs2tPmmKaDzuonvRf7FLrCgUedNUvfy45Qww2V1935eTFaqeINfUPopGsl
	 2ZRfJq3Tb/LrmMB/c0KJyNQiZ0qDd5neSOjUAmAEmEjMstdTiQKGGJVW4DWyz5gLSheoB
	 Gv4E3oWveCzqcrkA9qBSXafMNMrsTeGWMI7Ao+nIEkm6LYGHoKscwNlKpp4dCPPZbs+Zw
	 mSR38IHzd8EL1yF1XiXGzi6W5dGu7aS/rg74wof5Ftq9K3KpwQnetCqJhQH/HZKmtEU1d
	 ROeQuiSeArn1qFMkDJpFyRykwUtQLiuGk8D9SJNM/j6xYu9jZcm/9TGEdL4ns4m5zIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=qAxpPyJV;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB24606C185
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDB24606C185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=qAxpPyJV
Received: by mail-pj2-f6.google.com with SMTP id d9443c01a7336-2ee1c8e6fecso463125ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559908; x=1795164708; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lYzK3//iA/GrlqyqFKm7zb2MSKDdJnrLMa2XfcjD5wg=;
        b=qAxpPyJVdu3Eo1gikOQIp3VEgu6evI6bjx90G+83OTZYzs/tWWWCzokW+VgZygsbPQ
         /KQVTxfv1tD2R/lcDTf6g1dTBF3SL3in/BCuo/OPJ94eh/Lko7ICKpGWDq1/QATgDBjA
         xyz1+ZZxef3f3a4jG7EbDh5j6bYOucCm696vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559908; x=1795164708;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lYzK3//iA/GrlqyqFKm7zb2MSKDdJnrLMa2XfcjD5wg=;
        b=CDfHldOyjcaW956VJ5CjjIaVXxmSbd5VF4URf/rt5LR7BmVaWr3Rq4OtaMTT7EvO05
         05HN67MZpO0DJ2Ft8yxbaJewSkfqD9kqRJBGPQ77Jf+RdmWb0NgWTG1Q6CMxsU9DIZId
         r13StNnIikf+t3/7RFLXkLa27VqmR69QFZgusjwOb+8434Le5ZnhwAhOlEYXGT+jCj/x
         qQ73vozoGJKWlCG6sCeUGUkHNupofR1VP6XxaEaSWTRYM089OthLFAHF0f3lHZJOOJII
         0ZwNYIOEiF4Lhr9FJgYl/G1n4SVI9c7ZKZW1l4MEplZASYJqM+RbbP8gMAHNwVmlxAVC
         wkHQ==
X-Forwarded-Encrypted: i=1; AL+hErFaSNtCQg0DWC8E6OHFkGPw5wjwnua0A3C/c+qDbNXxcp/1FTe4zvkvG/tsZMRi61FiY7LenF23PSL6kNS1RoM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Iv6PPo0AXE6tss4o8i3QpAGLI4gm9HSZcQzXCXRRGG2CrwhNc
	VMt2dw5/s99D+uIf1kzbx9/QI5ecPw8RGcfQEQ0ZZyb4JrPyuAYTff6ZBMds4z8IYTw=
X-Gm-Gg: AYBFou0JTbx66gs4qxzc8kGwZNo8KqSTEpvmulThNsxRFSY910xdtYLVme4g4fNYfim
	5QFnLpKcFwiLQ+XxpK69+x+3hGmNWt1RvjfbHNYADTEy3jKw/q8oeVDazYw+opcEEP/lTwQ/q76
	XsAAtGF3XBgYtVL005zblfAQmd6mflLTz2x49HSYiG7ifIDlciHDKnDxIKjYGQto/ZdV9GTE2qo
	vgKiXFeRdsq3zDcbVbltPbFXA0M7KClep1hqz3w+dCsNB6nWlTrlq/7m+VyokEsDCj08O71Tsim
	wOizV24x9zYUW1LvVT1Oad3iD+oNpmAGCT/MdBfUH6yUS5zUaNQM5Q0kBldbuZ5M+xZH2BEmBXC
	VeDQYIkxeNHJ6tOwEi94VmXj8AWq7rrf4p+/RpNcz1mJXvN+W+jpQ50W8p+Qs53aOOv7uSqvM/Z
	EwRAVnW6vvLrqxFcjKw3gG6aH+5iFgjHggfGVTib2mrh0UjX+zajCODkOhDeJZpmLEB40ki6wBW
	Oyhv/6Pkp74Ez/ceM5GuGC9SQIiMI8zHNiDfWPDBJppp5plt7pcMK4CboCD6YXzQU4T5aaY+hyG
	EnSOJ+t3lV1OpJSUFKTDnEjbqMDh1UVGyqHqcyt8Pp/bDQtRGSaAfQXPBlbH/TU0EnHS9FpZnhA
	v0LG/AIXSQf7VIeWl4HOnLpQHefG2dcWlktmcGCVyMKYyoqBU9qGI2idcNLhvUFCS5zGZhBrxAo
	mq5+H2RUb3DhkWYFp60U7AFUaxV4ypzdVwOzJnDtbcCBHPPddT1BV4AotwpJzde9Ej1neItR4yT
	bGC5IoG
X-Received: by 2002:a17:90b:584c:b0:3a4:b8dd:1447 with SMTP id 98e67ed59e1d1-3b1b0b5f9a7mr1634952a91.34.1794559907971;
        Fri, 13 Nov 2026 00:51:47 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35ac2sm8778891a91.17.2026.11.13.00.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:51:46 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:41 -0800
Message-ID: <9a4caff0336c78a7adc746786c81c9c01f89c40b.1794506262.git.chris@chrisdown.name>
In-Reply-To: <cover.1794506262.git.chris@chrisdown.name>
References: <cover.1794506262.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v3 5/6] mm/slab: Support disabling KMALLOC_PARTITION_CACHES at
 boot
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

KMALLOC_PARTITION_CACHES creates several copies of each normal kmalloc
cache and spreads allocations across them. That costs a fair bit of
memory: Harry measured about 18 MiB more slab memory after boot on a 64
CPU, 64 GiB VM, mostly from under-used slabs [1]. Like SLAB_BUCKETS, it
can only be chosen at build time.

Add a kmalloc_partition= early parameter, enabled by default on kernels
built with CONFIG_KMALLOC_PARTITION_CACHES=y. When it's off, the copies
alias the normal caches rather than being created.

Let's leave kmalloc_type() unchanged since each index simply resolves to
the same cache when partitioning is off.

Link: https://lore.kernel.org/r/179312451613.474906.1475329637924619088@kernel.org [1]
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++++
 mm/Kconfig                                    |  5 ++++
 mm/slab_common.c                              | 23 +++++++++++++++----
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c27bbe205051..91caeef33c3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3045,6 +3045,13 @@ Kernel parameters
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
 
+	kmalloc_partition= [MM,EARLY]
+			Format: <bool>
+			Enable or disable kmalloc cache partitioning on
+			kernels built with CONFIG_KMALLOC_PARTITION_CACHES=y.
+			Ignored without that option.
+			Default: on.
+
 	kmemleak=	[KNL,EARLY] Boot-time kmemleak enable/disable
 			Valid arguments: on, off
 			Default: on
diff --git a/mm/Kconfig b/mm/Kconfig
index e602ebabd6e4..5bb6e33fab49 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -266,6 +266,11 @@ config KMALLOC_PARTITION_CACHES
 	  limited degree of memory and CPU overhead that relates to hardware
 	  and system workload.
 
+	  The partitioning can be disabled at boot with the
+	  "kmalloc_partition=0" kernel parameter, in which case the copies
+	  are not created and all normal kmalloc allocations use the
+	  regular kmalloc caches.
+
 choice
 	prompt "Partitioned slab cache mode"
 	depends on KMALLOC_PARTITION_CACHES
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5575706b8938..20b066d61703 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -781,6 +781,17 @@ unsigned long random_kmalloc_seed __ro_after_init;
 EXPORT_SYMBOL(random_kmalloc_seed);
 #endif
 
+static bool kmalloc_partition_enabled __ro_after_init =
+	IS_ENABLED(CONFIG_KMALLOC_PARTITION_CACHES);
+
+static int __init setup_kmalloc_partition(char *str)
+{
+	if (!IS_ENABLED(CONFIG_KMALLOC_PARTITION_CACHES))
+		return 0;
+	return kstrtobool(str, &kmalloc_partition_enabled);
+}
+early_param("kmalloc_partition", setup_kmalloc_partition);
+
 /*
  * Conversion table for small slabs sizes / 8 to the index in the
  * kmalloc array. This is necessary for slabs < 192 since we have non power
@@ -1012,10 +1023,14 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
 		flags |= SLAB_CACHE_DMA;
 	}
 
-#ifdef CONFIG_KMALLOC_PARTITION_CACHES
-	if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END)
-		flags |= SLAB_NO_MERGE;
-#endif
+	if (kmalloc_partition_enabled) {
+		if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END)
+			flags |= SLAB_NO_MERGE;
+	} else if (type > KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
+		/* Use the normal caches, which have already been created. */
+		kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
+		return;
+	}
 
 	/*
 	 * If memcg_kmem is enabled and this is a KMALLOC_NORMAL cache and not
-- 
2.56.1

