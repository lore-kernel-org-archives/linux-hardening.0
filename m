Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E047CC433C1
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A909F61983
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhCSV27 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhCSV2j (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Mar 2021 17:28:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D32C06175F
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id g10so3539642plt.8
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UG6lpZSAG8t+NfdJici9YkMGF34rxaYTMGPEmVDXXFs=;
        b=MLSHMiMTiB7mt3alhEaLEzXy30yQVGSqjOQaEoJ+fMmm7jXcOgSe4dUYOHBUVtQAoo
         EACGNTJqravRutmaGNxgSKvYygrROsELo2AuEBPiA+eHluemcJRxdgC1exUQhcTw9JAV
         6GiVipDK7YSZ6/397AJn1FL5dldKhzNnrsitI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UG6lpZSAG8t+NfdJici9YkMGF34rxaYTMGPEmVDXXFs=;
        b=niRlQFWhW8oqL4Y/YslAHBzsl5Kuz0UsQusEO/JO4k0yqYEVauLKh248Rd+t4NTJkC
         1nVbZKJcfjzFDMoiRJIOpnghK7+a4y8oajYizDpulTI05p3I5xhlwXCGeBUgRkY1ob2t
         nmXxn6fpw7xc+Yk0aInUFXkDKTRzEjBzstX1iXs+LskSpegYNa4dvB6YzCEVVh1h4Ouc
         OdZKujG37LRBnXZhoD9aLjo1HCEygtYJqOeWWR/1KsfLLP5prF4x+BFMAxCf+gbm5CtG
         u5pdw6GBKbO1c5WA+lVYmAEGWO0VP9dg3WLgqQvWawMh8nVUl9bJNagJL2pwMVGbqa35
         mHIg==
X-Gm-Message-State: AOAM533oOX9OzOzbSpEHHSB0lmCURf7uJYDY4yiSRYHXlLSfBKT1LUGH
        cS+6msHFaitbpf/9ykIfBt62jQ==
X-Google-Smtp-Source: ABdhPJx5p2dC2D9xdAQh+xz6Dqkoe45t2LRG6o6KaMrIiaESFpoqFGsISuGBytSNX81p7ZVAdGHD9w==
X-Received: by 2002:a17:90b:1090:: with SMTP id gj16mr464868pjb.57.1616189318649;
        Fri, 19 Mar 2021 14:28:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d6sm6234615pfq.109.2021.03.19.14.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:28:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/6] init_on_alloc: Optimize static branches
Date:   Fri, 19 Mar 2021 14:28:31 -0700
Message-Id: <20210319212835.3928492-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319212835.3928492-1-keescook@chromium.org>
References: <20210319212835.3928492-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=2f4b59272e09d0180c87e3d8378d95ea375990ec; i=7VrM8Pzr5MGi8vAaDOW4xeiDtVYbjHgJsdLlT/sxDXE=; m=OLLKLAHsfNT1d7+pflxMGJuAvSt8GZaetKIXzfk0ilc=; p=cKq4RSNZSRZ+ASTC07w37jURMQB1hxGsdgqU07adDH0=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBVF4EACgkQiXL039xtwCYLVQ/9Eol fG+MrYlh+iwD9I3wwONWUjypvuh2YfQUdlJ+mPPIR5GBa4jtQXlQiSHRZzT6cobAsmFX9T6mXf1if Cu/ZlrFupyCmBNTjUop4AUd4Iu9yFawJlbp57K6zFzDgjm4W69NufR/AXcNqTcPOFfSgNiLdwS4WD Jgh+o9SPvgt2QtjVjNi6upGgapbhZxkMGPMqZEEUAKaA0eByy606iKAwWwqDf5NoqFa68UO1F18mN fH2OcmxMxuNrR0HIipumCM2+iaLHsY3I2h/KMDuQGoR1wxXh3kbPJDTzwUePUbzZ4h+hgwPSpNPJ/ VWRkF6f7+cD0LnqItF5yfYiluJ59m9SJ4iq3OoE705AjhKpXkGdCLyvSLcEn4FRtvhfNYZ30IyBpx ANM8/85SuSLu2zY6m7bybkFpc58vlXvCcVqlHSFbors+eHtsNgq2XF/CEFuXVs4LVh/naVBS3QGsp Bw1Yv75UvW+SHMswZjH4Izy7DuxikfFeuxQmn3zGXz1gVWLIxgWoY2kQQUfMMJnK3DST7+/MQtgBx 8dxF2t0KO6PzMlrsYYQvIsKwcbt8M314ajqHO4Su66UMQUPCzr+c03JdbXFdFFpIeHeWVhMcsO4J9 1A22dhXFlPunSEVEDpbt6KtnqcJYOZrXD1hEwIoDht8YODbxV8nHpx1NU55LSB1g=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and ...ON_FREE...) did not
change the assembly ordering of the static branches: they were always out
of line. Use the new jump_label macros to check the CONFIG settings to
default to the "expected" state, which slightly optimizes the resulting
assembly code.

Reviewed-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/lkml/5d626b9b-5355-be94-e8e2-1be47f880f30@suse.cz
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 10 ++++++----
 mm/page_alloc.c    |  4 ++--
 mm/slab.h          |  6 ++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..2ccd856ac0d1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2871,18 +2871,20 @@ static inline void kernel_poison_pages(struct page *page, int numpages) { }
 static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 #endif
 
-DECLARE_STATIC_KEY_FALSE(init_on_alloc);
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
-	if (static_branch_unlikely(&init_on_alloc))
+	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc))
 		return true;
 	return flags & __GFP_ZERO;
 }
 
-DECLARE_STATIC_KEY_FALSE(init_on_free);
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
-	return static_branch_unlikely(&init_on_free);
+	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				   &init_on_free);
 }
 
 extern bool _debug_pagealloc_enabled_early;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..267c04b8911d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -167,10 +167,10 @@ unsigned long totalcma_pages __read_mostly;
 
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
-DEFINE_STATIC_KEY_FALSE(init_on_alloc);
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 EXPORT_SYMBOL(init_on_alloc);
 
-DEFINE_STATIC_KEY_FALSE(init_on_free);
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
 static bool _init_on_alloc_enabled_early __read_mostly
diff --git a/mm/slab.h b/mm/slab.h
index 076582f58f68..774c7221efdc 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -601,7 +601,8 @@ static inline void cache_random_seq_destroy(struct kmem_cache *cachep) { }
 
 static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
 {
-	if (static_branch_unlikely(&init_on_alloc)) {
+	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc)) {
 		if (c->ctor)
 			return false;
 		if (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON))
@@ -613,7 +614,8 @@ static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
 
 static inline bool slab_want_init_on_free(struct kmem_cache *c)
 {
-	if (static_branch_unlikely(&init_on_free))
+	if (static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				&init_on_free))
 		return !(c->ctor ||
 			 (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)));
 	return false;
-- 
2.25.1

