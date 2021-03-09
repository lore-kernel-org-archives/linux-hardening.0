Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1152C43381
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Mar 2021 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8177C64ED6
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Mar 2021 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhCIVn1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhCIVnK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 9 Mar 2021 16:43:10 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E113C06175F
        for <linux-hardening@vger.kernel.org>; Tue,  9 Mar 2021 13:43:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id jx13so1618381pjb.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Mar 2021 13:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJhcYxfyQggjoFPfbV3IBwgqNX6derqJ/0OIfES3kng=;
        b=jL8KGxLZpq6kPeT9F+1qoL3DOavcSq+bJ2zvXDYPWXl+6YiuZBCwwRfCE7vfScpXYo
         JLjeD2AAKSyeha5oGCTqtO44VFZbSaDU8csNlwFLUVsaobMtQxYqvBKu4ZTMPr3ykAR6
         o5hUKHMrDsMF1SIVJQ8Kd1W1dLLgNv1pQqr3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJhcYxfyQggjoFPfbV3IBwgqNX6derqJ/0OIfES3kng=;
        b=dWG0oHmy148JSKgIxoLLeYTCpZJV8hDBNXMVsReMOuH8tvyZ29HByUbyx4FXx62u9R
         Rcro5rHIdaYPl+x6LnIFPFfqql0olZdYi6CLT3o37D7KLMDosg6D9X4EdfbsNZBgU5Lo
         Vs9yw3hUatWmJfM4WsG9vX6niHCi9ufGQmyjfSu/CJMNUUmwn/hM1wJqQp51azZwGyYS
         n4DBrGRSF5ShSToNTwkOCYHrazh8n4SlomCO2Jd9Km7AleVlzSVBWTokPJ1D2k0xz80K
         S4uXVsh5hScGbSOyStlZV00alKvpKeeFViQpiNwv+XWbvtvouNx8kAFk56sJEQXMmUY8
         K4gQ==
X-Gm-Message-State: AOAM533Jx+V7Jf4z3YzoviuuGW4s2qHTHT98Xw6wfRnpwZod6biO313z
        9fhRXwUNK9bFHj/evs6KrW0Gxg==
X-Google-Smtp-Source: ABdhPJzbrDwJvtujX+Yvv98LI2Jlt3lOh8R9CznfILmERfEu/fMLAFatr8X7tXLsHQfwfaOl+hu6bQ==
X-Received: by 2002:a17:902:ec83:b029:e3:ec1f:9def with SMTP id x3-20020a170902ec83b02900e3ec1f9defmr107248plg.11.1615326189697;
        Tue, 09 Mar 2021 13:43:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm3872315pjv.47.2021.03.09.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:43:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 1/7] mm: Restore init_on_* static branch defaults
Date:   Tue,  9 Mar 2021 13:42:55 -0800
Message-Id: <20210309214301.678739-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309214301.678739-1-keescook@chromium.org>
References: <20210309214301.678739-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=28f3f839c24b05670130f4ff25d00e52971fd524; i=F1m1wEnux/IiRlF/sb2Zhr2mAPnBBAdImHuXCXK/7kg=; m=obdLQlMNg29JMC3GLL05bs7+HEYTRXfdcOPcqLYs1G0=; p=5DbOxVDVK+l3oSqEiw8KVTN/ODiEU3l6O/gw4X79jro=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBH6+MACgkQiXL039xtwCZfHA//cAa PLXroyUxGbCfvAX2WTtwU6C5LPDtgM2cyDkhcMFkbY7jpjetZH58AgmsDVICQO5Gr1o6pcLanTaCu g9wn5kl+oYBuX+AM6N/RBjx2uuFb9H8vxS1sbup+S68TfmMPoa+8iLJYnDdQ5FeUCLzgIgdIoWyGC 1ebqyiytd8kEuZ54soVilY8JhdJ9Uyy2lj2CNuLncTdTZpB30J86I1fpIp8kG/1EqzwfOsrfK5WNE PlLp/tQYnPZw2LAxJg4fxq1OPvdXYXjOY6kVcx/tCaY3k4sEZjf+CA+N5ubqNZNQrcPo6yoUCuP34 iJpjSPR6EpsPimnEBVqI5dOnKcRbrQO/B96RbgbSqdGJckEiZk+/3x98oHJ7x0ZtQW/IDK82joRRf ZufV3KvwN1iLF2M0I1POqcKAk+9OF8mG/RA6pVK16vJmCA1iHTfLbz2JDUfWSu5rhFOYPCYs806V7 K8BpUEJz//Q38t6OXtzd/NuChkoMeEokmktZlFzmzLlk9qbAIWUrFHp8ECIbjYPNmaQ16YtU79tl6 qyAIlTkn5odVmnJxSTIKCZr7RwyszaDRBqPdPFSymmS/YdTKm+85L4N+AFtvX4V0NSjnSsYd5F0K3 q/LmHpjXj0aH6bVSWXXL2ifyidh60bHGGtZiwcWsIgkXi2mW0iYpkirvlgZc3gz4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Choosing the initial state of static branches changes the assembly layout
(if the condition is expected to be likely, inline, or unlikely, out of
line via a jump). The _TRUE/_FALSE defines for CONFIG_INIT_ON_*_DEFAULT_ON
were accidentally removed. These need to stay so that the CONFIG controls
the pessimization of the resulting static branch NOP/JMP locations.

Fixes: 04013513cc84 ("mm, page_alloc: do not rely on the order of page_poison and init_on_alloc/free parameters")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 8 ++++++++
 mm/page_alloc.c    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..b3317d91ee8e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2871,7 +2871,11 @@ static inline void kernel_poison_pages(struct page *page, int numpages) { }
 static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 #endif
 
+#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
+DECLARE_STATIC_KEY_TRUE(init_on_alloc);
+#else
 DECLARE_STATIC_KEY_FALSE(init_on_alloc);
+#endif
 static inline bool want_init_on_alloc(gfp_t flags)
 {
 	if (static_branch_unlikely(&init_on_alloc))
@@ -2879,7 +2883,11 @@ static inline bool want_init_on_alloc(gfp_t flags)
 	return flags & __GFP_ZERO;
 }
 
+#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
+DECLARE_STATIC_KEY_TRUE(init_on_free);
+#else
 DECLARE_STATIC_KEY_FALSE(init_on_free);
+#endif
 static inline bool want_init_on_free(void)
 {
 	return static_branch_unlikely(&init_on_free);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e4b29ee2b1e..f2d474a844cf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -167,10 +167,18 @@ unsigned long totalcma_pages __read_mostly;
 
 int percpu_pagelist_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
+#ifdef CONFIG_INIT_ON_ALLOC_DEFAULT_ON
+DEFINE_STATIC_KEY_TRUE(init_on_alloc);
+#else
 DEFINE_STATIC_KEY_FALSE(init_on_alloc);
+#endif
 EXPORT_SYMBOL(init_on_alloc);
 
+#ifdef CONFIG_INIT_ON_FREE_DEFAULT_ON
+DEFINE_STATIC_KEY_TRUE(init_on_free);
+#else
 DEFINE_STATIC_KEY_FALSE(init_on_free);
+#endif
 EXPORT_SYMBOL(init_on_free);
 
 static bool _init_on_alloc_enabled_early __read_mostly
-- 
2.25.1

