Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F8BC433E0
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Mar 2021 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4328964ED6
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Mar 2021 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhCIVn1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhCIVnK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 9 Mar 2021 16:43:10 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FF4C061762
        for <linux-hardening@vger.kernel.org>; Tue,  9 Mar 2021 13:43:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n10so9722909pgl.10
        for <linux-hardening@vger.kernel.org>; Tue, 09 Mar 2021 13:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QchGfDa9Ang9HjVlU1RQNYIjoI3tEPOfhu9LIBI5D+M=;
        b=AAchEITQdw6OW0zYEsb+JMW1vwYgaTwlwzk7fiKypJWjhEQgoK92EG8oQj/4Tq88SF
         zwG5DspDifkgXW3HuJUgs4F3dISckAhmF8SPrLQMssyCJX95lcs5zaG5CrPPPGeb+HSO
         dWyEMq2T8jbT0sDAA79Mlwjm4ookDIWPgIkLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QchGfDa9Ang9HjVlU1RQNYIjoI3tEPOfhu9LIBI5D+M=;
        b=Pj/D2r0WYtaqSssx3OIVlwyQMDIGsf/BZtGsf4y/SH60U7TsY6ZU/kOQ08U7+E1ueu
         ZPyiWxHx3txX3yjMxy9aPVv9nhYCzHysQOs388ikkDUr5HNUrA5at1dYQV2YlkQ4gXma
         yAd4nrx5FFbqpXcWqwtnIW6AE66KM8d1Tu4A982bEMTjaS91KYe3kuLtcpBRZxgxBeiN
         RnMiJp+h8aW7wjMPBX/2OpvkCoKok+umT8JkDexW1joHH3QMQyR0CeHurw6bHWlbgoY2
         w2iVAa0u9euaLoXTLpL2E7gS843JkqIqwj3l8/ME1E28dqXocUBrWAELmluEsOjlZxYG
         7lEA==
X-Gm-Message-State: AOAM533nddbW7+47vTXxiptCujpUnz38OOQRteDg7K9wNiiUFlorWLPL
        b/cR1bA7zjt+M5vnoyedUWR/cQ==
X-Google-Smtp-Source: ABdhPJzcdsp6YYQ3RJHVjDIyR4wddA7Ee7emO+fBuKmY/97M5tY6wZi5jJxb+krjkrH7lCrJYsY4vg==
X-Received: by 2002:a63:4241:: with SMTP id p62mr26586949pga.453.1615326189986;
        Tue, 09 Mar 2021 13:43:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm15163590pfe.36.2021.03.09.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:43:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v5 3/7] init_on_alloc: Unpessimize default-on builds
Date:   Tue,  9 Mar 2021 13:42:57 -0800
Message-Id: <20210309214301.678739-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309214301.678739-1-keescook@chromium.org>
References: <20210309214301.678739-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=0180538bd89f892d9a7cb5912f57764dd4574e64; i=FGm2eJrFhO36W3pokRKQXJ/1lCJEdw+Xji0AZWdKldw=; m=vArMoxGjWi+hJ/sQRlVkEVurD6o0k4s1dF+QIrjNXSc=; p=UIEnT5JyleN0fGLkjBMkQSBdyQITBdVfP87yTFfx7Kg=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBH6+QACgkQiXL039xtwCZhGQ//cU9 87sq54cQfs8uAKxVAHV77yHdW6J6AftBwhrqAq+1M0C1IoOLVi+Uvz1cWTM7C6G672FEhYPM8aZvd 31/s3taFnCDyvmBhh9HUBBsYUk7Hhwi+V7r5EvVHAxBw1jyUByiPVHV6FWRcSDFOZHv9iKXNEFC7O iKSWVZ4V6X0u98fHeVq2MA3000qbRbBtef8DMgWd5rq3d+1IJQKEWRi/ws2e3bW82oHj1a7+KPOv4 X1J5M9A/OStaOcbwJ76LyVjtjizbvJMYsUDfIwUkH2Ouj84CYuWxK5AflU8Wf8690EOKQ6XGAvCXA 2tcD81q96YPjYRgGy1QoC4cqyGHQf52FCkGDjrZd4LIHJjPLxc8C7OAemJ8ofvZNIZDwRF9u07y4D qUKVUYEjWSwsP03gVJB7kc6gYALIB5AX3qNNQkMAGKgiyrLXML5eBay0b9+G6DrlXQO2uEwQ6ocni JoXsEVBoz0zZRetbT2/TXK6Nqk9DV4p8bkO7R26Ut6wAEn8jZSHgyBk3GrJg+6d1pOzsj761vvjya NK/0w2VQYOsrjdciOEQR/Xd2ZGCaFPfQY41b5nEjmBC+YS8l0GSHFqG1ce4mPDlQeuNmYOgu8+k/B 1hTaHBXrEPHJbO69gYEpIn/T7M1Tb4pYIlHnvmvDlMkPoUrznzLJonVQIk5rqeX8=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Right now, the state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and
...ON_FREE...) did not change the assembly ordering of the static branch
tests. Use the new jump_label macro to check CONFIG settings to default
to the "expected" state, unpessimizes the resulting assembly code.

Reviewed-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf341a9bfe46..2ccd856ac0d1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2874,7 +2874,8 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
 DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
 static inline bool want_init_on_alloc(gfp_t flags)
 {
-	if (static_branch_unlikely(&init_on_alloc))
+	if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc))
 		return true;
 	return flags & __GFP_ZERO;
 }
@@ -2882,7 +2883,8 @@ static inline bool want_init_on_alloc(gfp_t flags)
 DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
-	return static_branch_unlikely(&init_on_free);
+	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
+				   &init_on_free);
 }
 
 extern bool _debug_pagealloc_enabled_early;
-- 
2.25.1

