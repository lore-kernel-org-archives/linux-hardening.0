Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254156;
	b=VqYTNgekZVlKZNQkACCwr9fumS+TKxOeWVK6ANy1uQFCeL5R5H8Uz4gdpfKNrpoOHO5l
	 suDrTm9FCi9aaGqXWVas6N7O1evcKzIHzUn5yJ8ANIXp0UOdXxSzCBH/h1h61QvImb8ES
	 ivtn7Z4wOr0HQBDtFWs1tFGC/0+X/oDeMvqIaYaZLphnMbAPttZCr56Gq3IG8Yp8CTCdf
	 T4zQ+u4R4OkRrKvswJDTwV+3dYr94OXZjQ8IQ75FuFZUlNJsxqd91EOQhfJMEIoUoY3Cl
	 FUgJ2hiNyoYCHmuSF7w3v2PhQhkEMLv38U2xVxWcTJeX7izU0oGbZlNZryR0YhXk4hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=TnENC99p6Lehtk+q2wiObbhSP6H/cGEPWJzdL6TBkdc=;
	b=ACjdkHJHmhtGmdU8XzZz2ubTGa4M/xeYdhC7dUqBK3ZwBWqQDnRuXBoColmdJbgQwtJ5
	 SWC9vKiyB/2WwExkqRhFLCBOXY/uHd3M5huFSqBjXON1/kWWqLaqm9yDrekDhaaYLzUov
	 REz2bLFqUuT6o/nyvV5rHxoGbq6T/Y8bSHe0aTI3GRjA9m32LrEhpM8e+l12wRTxOIiQY
	 FlVRTb7MaV2Z7T2nhgxGyr+qwkGNYa8vOEBuoWleS/VwRGXWtTgX2CmttA1TYm1E3ZaUi
	 M135B48w7K43bLYvu2evWrZBfouw1pfLnFl73CXUJXwDW/2Yk/ObmFd7BVn4q6FCXsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=G2oXuuMZ;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F4606A323
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 06:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F29F4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=G2oXuuMZ
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso1477972a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793254155; x=1793858955; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TnENC99p6Lehtk+q2wiObbhSP6H/cGEPWJzdL6TBkdc=;
        b=G2oXuuMZx27T7MTdteDxVRZzx91gBkxgG+OWKgozn9T+tELcU3T4zLqvl4C1Pv4YUo
         Q+L0vWHYoy6UEsBnfZNS30p440w5hc97l5DWbBQ/puezPRvYABOkSes28YH4SxkOAt6m
         VKZU4n3Rn+QkCH2ncZS2bwX4FWyeChexJBRLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254155; x=1793858955;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnENC99p6Lehtk+q2wiObbhSP6H/cGEPWJzdL6TBkdc=;
        b=Oh6/m8XR/1Uz1ThYy+3AKls0V6n9MNp6jwrSAyGw3mDr/aw1Hg43/s5yVHr0Jvl/Hl
         S8ZKOU6Ut9Iuq+1tQ2cZ2FexLg8Iapk0Y3uRQUPQDPH8354F4zGUPBsqSVJu3YqcGUVo
         P16SH8u/5koRiML8gijgwg7lkGcZyHeiVUc3Z1Ms7umENA+ipQ0oD4EjPiLEf5+icO2e
         0iZEM1bIdxIMnlgA97c8Ic0ZQJkynORtXL6nCdT7nf30WKc8rikJnP1BPXZ1Lj1Xsw9f
         63s75Ag9RGvxQe3YCfsjHzTrQqHRn2kMKBdKAgxWkZYM/vEpoZ3oXj4Zc77qm3aoAuWl
         4VSA==
X-Forwarded-Encrypted: i=1; AKwUvBx+g7lSHPXefV8rosuRskznwISaw0hI8bkX/f9A2ElRCfnjQzxyij4/hrsRt2OL0mPON4q1Yt1AhW6HhoxwIFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhrq0S2j/Gc3hudt4SxqSXhmML2FJIWPfy0k/lXqObWK7yrp6Q
	Tk5LyaInHN+EsBIobwSOt8n3qAAuyD70tHvO+xSFb8PMVLbXYIC2GU4UkoUEXur762E=
X-Gm-Gg: AYBFou12Gz0DrLkvYRMJF382qwz9DmXiI8yW8Zk4NvlF5jRP6gzzFvpDpBo4NAz3R9c
	4qx8wA19+So4C22azXNbCyguLENbbGaos5Kjzlsg7993XPGim2fqgVqwraaYBAspa9E96kaCOSJ
	n82Gx1gRtXhAc+SsdYTBNxhO4BknoeMIelSq0jB++nmq+jREXVV2a2AR4ZCgAdOtrTRmx6ZjmAG
	jnNJ9X3ortWSESrQPmNAtYRLVFHC1yPCwSd5UynbbV8ftYRlWkNduPgYR7xV3kGgYcHG5w/fyL5
	GzTuhnz0D8J6ng+y32R6iSJSEwIGponX/qoourHpEUkrTuZxMLOGTPiWNun0Wjeo4umIcaG5Wvm
	erhbFCqidjCCGaZVFb2ooQXQQFKyBvyBgUMScS6DWiFyYFHlOUFt330gHgODXUK9HG+KFZR0ZW2
	NCik1ROOEq+A3vHFz3sttXqZc4BdHDfkkdTKwfv9CuPfgoO0p4HZaZqv3B5DWEZPyhkuape6Agj
	Nc54syrBwJqMd4oTB6or9AphR0gOf13oQJW3EFhTptTxelySvAzroXa4ZWefrrGjg9MAPE7swrf
	ZTaF35KmnijQb6SwVZ5Tu8NmGjYAhGaGIb1Yd+2dVAARsPXS4gspbxPM2w8XloIEG9jqgjUYUh7
	FKeGLRsPJh5tL9vcYJaVwf0/soOsHfO+OsOM9ZKpRLs9JaPFK7RF72q2e8lDM7TNEg/BGM6RX
X-Received: by 2002:a17:90b:590d:b0:3ab:2d46:1dd6 with SMTP id 98e67ed59e1d1-3ae57e401aemr3777671a91.4.1793254155497;
        Wed, 28 Oct 2026 23:09:15 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7fe923sm2789462a91.8.2026.10.28.23.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:09:14 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:09:09 +0800
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
Subject: [PATCH v2 5/6] mm/slab: Support disabling KMALLOC_PARTITION_CACHES
 at boot
Message-ID: <617bbfdce4fb2689c2510f0cd7f9adbb3ab8edfa.1793253633.git.chris@chrisdown.name>
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
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 mm/Kconfig                                    |  5 +++++
 mm/slab_common.c                              | 19 ++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index de2fd6963a16..6633a553a79c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3054,6 +3054,13 @@ Kernel parameters
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
index 48078c1fd26f..b90b3915fcd5 100644
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
index 9fe48da12010..5391149a2eed 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -781,6 +781,16 @@ unsigned long random_kmalloc_seed __ro_after_init;
 EXPORT_SYMBOL(random_kmalloc_seed);
 #endif
 
+#ifdef CONFIG_KMALLOC_PARTITION_CACHES
+static bool kmalloc_partition_enabled __ro_after_init = true;
+
+static int __init setup_kmalloc_partition(char *str)
+{
+	return kstrtobool(str, &kmalloc_partition_enabled);
+}
+early_param("kmalloc_partition", setup_kmalloc_partition);
+#endif
+
 /*
  * Conversion table for small slabs sizes / 8 to the index in the
  * kmalloc array. This is necessary for slabs < 192 since we have non power
@@ -1013,8 +1023,15 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
 	}
 
 #ifdef CONFIG_KMALLOC_PARTITION_CACHES
-	if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END)
+	if (!kmalloc_partition_enabled) {
+		/* Use the normal caches, which have already been created. */
+		if (type > KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
+			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
+			return;
+		}
+	} else if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
 		flags |= SLAB_NO_MERGE;
+	}
 #endif
 
 	/*
-- 
2.54.0

