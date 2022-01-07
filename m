Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E722C433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Jan 2022 23:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiAGX1u (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jan 2022 18:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiAGX1u (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jan 2022 18:27:50 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E28C061574
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jan 2022 15:27:49 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id y9so6925330pgr.11
        for <linux-hardening@vger.kernel.org>; Fri, 07 Jan 2022 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Gm2/5HnEXFIxSdkPzjXZQKOU+LWmT6qpXAHCEvGO7U=;
        b=bYLC3+tD1xZ8RuuhpF8gh7ly6f8+HHlRPcRcwotINN7eSLgj+T+hk7koQtcheiDVZe
         ENtIZEZ7FmtoC2rkmYPOUJM086bRcykmjhqPCKpM0fV2FrHtTr9PFhtej3PrLM4beYdQ
         llM/shaf8FknoJfeSOrUrv7+VM7iLQOc7pVVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Gm2/5HnEXFIxSdkPzjXZQKOU+LWmT6qpXAHCEvGO7U=;
        b=5Io3+ep8A8fXuYHUBc22tlthxzVdm5r/cX73n54uwrMOT+J7Y7TiEs0ssMNOr9nRpK
         biyj/MLWXJN8bcXCH5YCI6i1/EXhiPRCy2XYE6ANIl9rH25yhqc/6wTGequaMgyTt/2C
         YNLYlA/Bj991fsgYouIgl3xxz94/NESO44DpCTPbuUet/ba7uxTq4EpEypuV5NMUttMy
         bKetWMuvg+v0vqRwL6aCViHf/xlHTGJDi9zMspLT/kxql8dpiRiEGrw5S2/gTeQVygyP
         8wbskNtJwI825FAjv2c9yQ2xlNrhshBbJ2qX63Q5Zwfpd5YCvmKslwaBMbXkA0Ici7ne
         pPnQ==
X-Gm-Message-State: AOAM531JgFBoEcpjMUrahF9uq3dHtH0C0fSPtZ9VrpF5SCFRp4ecskZ4
        St8GY1wN7E6uz+oEGxqIBhh9xn6QHQExnA==
X-Google-Smtp-Source: ABdhPJxkDgZCqGiDKCf+UvMXdHbCz0HH/CZI6YKoT+aZI04YLxIT48GaCscg6c62MbkVCjQEd4hQWA==
X-Received: by 2002:a62:8f51:0:b0:4bb:9d8:86cf with SMTP id n78-20020a628f51000000b004bb09d886cfmr66061197pfd.55.1641598069056;
        Fri, 07 Jan 2022 15:27:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k9sm23343pgr.47.2022.01.07.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:27:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] arm64: atomics: Dereference matching size
Date:   Fri,  7 Jan 2022 15:27:46 -0800
Message-Id: <20220107232746.1540130-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016; h=from:subject; bh=47ond1j5oGNg2bOUtQPmTXc41W+OJBUy48YiocxEN4U=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh2MxxvccpCaBRI64wFu4HGOYd1RAGYXBxjWnsjXy5 R2rn/yGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYdjMcQAKCRCJcvTf3G3AJryvD/ 9sp7vs3pCbVfOzxQ7kLuD+kKELqKNUVCexpGQpaRgthUhlpLMkl4o/uCUdhMl/8vFmoj+trO/gg2ri U2nAztuCZRepyX55YXnD9oP9a91Lj0yUuEC+QBdFqEpzf4vZpWtuzSlVSdvCs0m687FxhhDoOAGrRb DwQeZsnpHSHKCYSr4TXVqXWN/+sU/QjOYShyGXirFcDyJc2oiqfmfwtTcIfjqHHJmWVh2g5bszWkca JJ+8tfXnb25k5CfBP6CX32ltb2OfTUZA5k6PGODdLQoGyR/wstI5izT3Nj6K2CJBLcxiMoxYCzk+jw M1rj0lO4940pou6msREP+yejU4zsqF6asUmFTSDEzr8gSRVyB0ucovrkAwwcd5NA//o2VloyJEgOLz Ie7sP0j0Zo1VAzOGCPOmASBHEGLRHi6yqC9bAsdLLUNCcAArW0M8XKyTptmjQKf3O7nCKh4DrDqyiy KmACPWY5vP6j3FdK94iaYm7JO9QoGbpSLAZ3LQ9L0eOcCmpv29zvGQ7pP2UGCIofiq9my6R+y6WbED 3t0uJb6Ssgy8Y8XVwmakBhmIvA8D2zUuQi80BZcdAO33q9bZDLTSnnoUTDdIESOPH7FqR+9dacRaUF IDbsjMCLcE1xplrSEuaxzIdXt0/59nKJdJaAPohTH59jmZE3FOkOeKr6arEw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When building with -Warray-bounds (which is desired to be enabled
globally), the following warning is generated:

In file included from ./arch/arm64/include/asm/lse.h:16,
                 from ./arch/arm64/include/asm/cmpxchg.h:14,
                 from ./arch/arm64/include/asm/atomic.h:16,
                 from ./include/linux/atomic.h:7,
                 from ./include/asm-generic/bitops/atomic.h:5,
                 from ./arch/arm64/include/asm/bitops.h:25,
                 from ./include/linux/bitops.h:33,
                 from ./include/linux/kernel.h:22,
                 from kernel/printk/printk.c:22:
./arch/arm64/include/asm/atomic_lse.h:247:9: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'atomic_t[1]' [-Warray-bounds]
  247 |         asm volatile(                                                   \
      |         ^~~
./arch/arm64/include/asm/atomic_lse.h:266:1: note: in expansion of macro '__CMPXCHG_CASE'
  266 | __CMPXCHG_CASE(w,  , acq_, 32,  a, "memory")
      | ^~~~~~~~~~~~~~
kernel/printk/printk.c:3606:17: note: while referencing 'printk_cpulock_owner'
 3606 | static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
      |                 ^~~~~~~~~~~~~~~~~~~~

This is due to the compiler seeing an unsigned long * cast against
something (atomic_t) that is int sized. Replace the cast with the
matching size cast. This results in no change in binary output.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/atomic_lse.h | 2 +-
 arch/arm64/include/asm/cmpxchg.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index d955ade5df7c..5d460f6b7675 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -249,7 +249,7 @@ __lse__cmpxchg_case_##name##sz(volatile void *ptr,			\
 	"	mov	%" #w "[tmp], %" #w "[old]\n"			\
 	"	cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"	\
 	"	mov	%" #w "[ret], %" #w "[tmp]"			\
-	: [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr),		\
+	: [ret] "+r" (x0), [v] "+Q" (*(u##sz *)ptr),			\
 	  [tmp] "=&r" (tmp)						\
 	: [old] "r" (x1), [new] "r" (x2)				\
 	: cl);								\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index f9bef42c1411..497acf134d99 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -243,7 +243,7 @@ static inline void __cmpwait_case_##sz(volatile void *ptr,		\
 	"	cbnz	%" #w "[tmp], 1f\n"				\
 	"	wfe\n"							\
 	"1:"								\
-	: [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)		\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
 	: [val] "r" (val));						\
 }
 
-- 
2.30.2

