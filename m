Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086554;
	b=jwvfQ2GtEA4QNy0XWlYmatpUbf7RaTgKdu/4FH1jq7KR8YrfhydyS/VV61jt9jYFAGN9
	 hUsuN7YubimYxjTZw7oN4OhrEWDZ0zOaSjt5m4HJamPTaifSRXsDn6AdHyXqebQGAcz+C
	 /Wy/HhrguTBXC6ld9U3n6ZkIjvQpDmGGXzQCfbHDYejspQOevcv911bGm8QVP1xFSrtcw
	 yw2Ho/ud0euipoXuJHXKwEmvuCx3tfaygdyYyngIglh/lPNbSFw+KqEfCGHbwzryuX6ss
	 ITKaEsrJLmeL+OFRhbXjtNt8Rfoy5vfi+AU5V9gBCp7JqS+VDlp7a914+NBrUegLkEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=aAleu3PFDaaloUL3fp9TR8UUZq+CL8OXKyhY9njoszw=;
	b=cDC2ji3uER/pvTuQD/u3Qh+i9aEw0bI03IiArWgW7z/dW0UAMjxO+zLXIen6guUQ91Zg
	 yVDpYgjsd3SKL0CmcnsqJ8hZeCjiVeeMA2Eqmfw2NOHaC29cqQsX9ce5hfMihhTHTOvWV
	 M5SM/fCzTzXCnqTNb6jprQ5jKityBbwY8nJ+5o8vOb/E4IXVsNXbsJ/G6yHhJENCtqOAS
	 l2qTC81uz3RjoOtbnJwe8byOhMILE4M0TmdEcytlAK0/O5JfyqxDE+ZuqbloBRDlHcLnH
	 6BGxOWTtSZ6e672gDAjOamHb6maZvCvYDkeD6RDrwlU3AYx7LrPtQhWOwnFKXIKld0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UA+RMIvd;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1841606A31B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 07:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1841606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UA+RMIvd
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso21592405ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 00:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793086553; x=1793691353; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aAleu3PFDaaloUL3fp9TR8UUZq+CL8OXKyhY9njoszw=;
        b=UA+RMIvdJDiDPeX/NjNZrP60ECVkNVdz5unnwoSR8k6neRC99YxJu+tZQ4l6XDJul5
         VKBgjMwFh83zsMth2P6QZMjYAHPFZX1UPTpIjC2sJZXYGp6DhJfmFCQFWoup7+5G35oY
         TzxKVGL7soDKtAjYzTb6jCNU3NgUnmMzEe9ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086553; x=1793691353;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAleu3PFDaaloUL3fp9TR8UUZq+CL8OXKyhY9njoszw=;
        b=0/kW1k2TaP2qO3YtGZ3GO9cdnRGvUI7CV1njCwgyhGaXEsWpAZCDTVXuY38Zvd6oSM
         7uXhxzXL0XpTeCh4atuFlpV311AZA3mIuYeY9CwhLVMnrtU4tWAcTwGvkdVpPoDsZg+C
         xqwAP6dcAb1rtrP7oBq+DxGwaj6iYiHohMEKKt144xN9VOs7i1CUy3OODIvblVximHkf
         4+xgDWr3WJIy3Ds5JqfccqGrIueisuqkFUoXzyXbCTUSAMhU7QRq5oAq8bRMkUdI1jQI
         L390UkmKI1V+6I+Xc7e6SVIzsO0L7vDxG2UcFHmSzENmWZULfLeqyp8IIs6UWCWWHDTG
         R/xQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9+El009Z5J1hoP4GIzI9mHDgcXIbT4UCPQsX6lqy4cEHWUrs7EpD9qY+safxub5Oqfc8mGl7CmOqzuxJTt/Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXvHUYDGBmsElLWbEdJFHVjdWzt13DIv3S4otOEYVvtGhwLgBo
	rLnYkqUMqyvRj1yJP7gDb9riKZLd9dvOP8hD5jy+Q19oSIsZwNc8lpWnvicOuMtEGus=
X-Gm-Gg: AYBFou25XvCnuPyyFJFsiotmogGzdjcE4gN61ToHgeo0mkUINBUsoUxAXDfLfQkdi1N
	u8peTuvGhl+sJX+Hp3EnAFG+dH8bEdeTe6JVSfE+/UMzJX/xTjKWujw/8Ubq9Ln2R/EpzQoLyHZ
	2vpZ/V+sLizgMgwuMVlw65A9i6GfOmC5DBe95sEdoxWCb3pNzc53L+Lc9sZ29cKeyeWS6SLUn4s
	da8i4FaL4Rm3go2avGSUDjT2L9rUcFcokXgi5tZw1mb9HsThOBUiymPjXSqCJkMiokbyKpkcpP7
	5Jody+lcDT7mY5f7cAUEYPZKRNE1IChGocK+yeOzzsWG5IzcD3Xa02aPC0YmSuvxyPv/GznI+jL
	DACCI567JE34zNTyOKho1rK/tm6oyQY1J9SSqlYhsvyYvmBDj3lT+t/xGlMmuOkt4PepQnmnoIO
	Iuncpn0yCZAcX9+Pb3/Z9+BHWpimldqMYQ6VPpWnGQDhj8gKY6nkt3cyuS1hSANy3rk2CkkXO1u
	0NRmpLP7ChKauGQXMzGS54gpPMKCwtjcwO4bAiaTUnRFO9r0cf2OtCdCtIgxdIAqGnIA0rlnivz
	DPSxVmLO9nor55vf0OP7nruVsGCAiwaWS4Hwde4G2A0PO4jhQRGKONiJcogzD6H8cfTmYPZNPAd
	MZnOASva9erE9jpJEdeF1Tmc=
X-Received: by 2002:a17:90b:1652:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3adead4f65fmr8276505a91.41.1793086553098;
        Tue, 27 Oct 2026 00:35:53 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae406506c2sm2520384a91.14.2026.10.27.00.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:35:52 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:35:49 +0800
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
Subject: [PATCH 3/8] mm/slub: Support disabling freelist randomisation at boot
Message-ID: <58f32032f0f5f3828322780aca1847f1cd80cef0.1793086056.git.chris@chrisdown.name>
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

Add a slab_freelist_random= early parameter, enabled by default on
kernels built with CONFIG_SLAB_FREELIST_RANDOM=y.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 mm/Kconfig                                      |  3 +++
 mm/slub.c                                       | 16 ++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ddf2f6fd60be..5c4d784e7786 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7021,6 +7021,13 @@ Kernel parameters
 			without that option.
 			Default: on.
 
+	slab_freelist_random= [MM,EARLY]
+			Format: <bool>
+			Enable or disable slab freelist randomisation on
+			kernels built with CONFIG_SLAB_FREELIST_RANDOM=y.
+			Ignored without that option.
+			Default: on.
+
 	slab_max_order= [MM]
 			Determines the maximum allowed order for slabs.
 			A high setting may cause OOMs due to memory
diff --git a/mm/Kconfig b/mm/Kconfig
index 3ae97fec9946..56c422684b44 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -205,6 +205,9 @@ config SLAB_FREELIST_RANDOM
 	  security feature reduces the predictability of the kernel slab
 	  allocator against heap overflows.
 
+	  The randomisation is enabled by default and can be disabled at
+	  boot with "slab_freelist_random=0".
+
 config SLAB_FREELIST_HARDENED
 	bool "Harden slab freelist metadata"
 	depends on !SLUB_TINY
diff --git a/mm/slub.c b/mm/slub.c
index de4937fcb293..7e9dadda3d10 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3424,12 +3424,23 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 }
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
+static bool slab_freelist_random __ro_after_init = true;
+
+static int __init setup_slab_freelist_random(char *str)
+{
+	return kstrtobool(str, &slab_freelist_random);
+}
+early_param("slab_freelist_random", setup_slab_freelist_random);
+
 /* Pre-initialize the random sequence cache */
 static int init_cache_random_seq(struct kmem_cache *s)
 {
 	unsigned int count = oo_objects(s->oo);
 	int err;
 
+	if (!slab_freelist_random)
+		return 0;
+
 	/* Bailout if already initialised */
 	if (s->random_seq)
 		return 0;
@@ -3456,6 +3467,11 @@ static void __init init_freelist_randomization(void)
 {
 	struct kmem_cache *s;
 
+	if (!slab_freelist_random) {
+		pr_info("SLUB: freelist randomisation disabled\n");
+		return;
+	}
+
 	mutex_lock(&slab_mutex);
 
 	list_for_each_entry(s, &slab_caches, list)
-- 
2.54.0

