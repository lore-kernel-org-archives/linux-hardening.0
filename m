Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87291C6FA83
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiIHV40 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIHVz4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B9D21E3
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 62-20020a250341000000b006a93b57e2daso31089ybd.2
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=7KCsYNBshzyqwz+l0HUO/3yj7Ulbak1Wm5CokVvWHxw=;
        b=DIhHROG1myYjjEhpDDuovfl12YIR789djqDBc/0u/J1mp/jTmDj1ZA274AXNCs0wnQ
         lmt14cCOg5xAV7lpluAZTs012V2TcViqt6Fd409oZVvFj0p9wbyvt/LLFB+NybSwk91K
         u+9M7YxBEfhfH2yyQGo/p6f85J2cc94NIvHZ/LuVGNYFFtuYWd5VHEkjDRPgyPNMunJi
         e/ovvDDwGfEoxULnywfqVplYbYMPNWVdNE3/YMVhdGKHwKfEZzBXlGUkX/CD3xlhu3Gm
         oMSNueVp741XRM009sKhSfbf+/5jCQGMUjjw7oSD0hz+mRDipd5luQd+9JHtoAWUa3OS
         yXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=7KCsYNBshzyqwz+l0HUO/3yj7Ulbak1Wm5CokVvWHxw=;
        b=cdXA/JXLqH8+7Wvz0/3l8HA96/KWG+tcOT8nZoaU11s651HTS04yMgE9pNFzdC1oNg
         ESao1UZOE4fcFzlQ1I4ksek0NvzENQjOajj9l0eQy5WJTdQVzRXvbIIPcJrrTi0q4GjS
         yppdkGxFYDiwGgp4DvVEr/0BDRaKjpEnyWaM+czx2BYtemNLlA+vA3W6uq3/67lDkgv2
         ofVpTrSlwZxbM6xLxGLVBw9svZvRwOn6f+UdKlalH+Kt8k/JGhm3HSr/IEA9pSEFdHgu
         9Q4UYE2jdbvEYpEvMwII+Uh8HokrMzMEMjEp9gVsmC62i+KdNHjqCczkWrcsCurFbv4q
         ZY6A==
X-Gm-Message-State: ACgBeo1R8jVNWsVesQX2yBKj+jP/cZuBMzGy8VEGoDk4CWiGDy1atYlA
        2Be5fqlKScRFBcvD7Sx1nbj3mYPrIaNPynyHN6A=
X-Google-Smtp-Source: AA6agR5oVGKtFANNU7ak0LdUo3bvPwshuUK58VUOg3cK732UV0PIyD9J8Zk0uzMLvmO6Ic7KKJZaWyMaNzKdVNVUY2c=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1004:b0:6ad:aa9e:9116 with
 SMTP id w4-20020a056902100400b006adaa9e9116mr7779751ybt.559.1662674136099;
 Thu, 08 Sep 2022 14:55:36 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:53 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2488; i=samitolvanen@google.com;
 h=from:subject; bh=m1Q5lb7FoUHpFsHkDA6V80I7lJPiOUDvsppC/5IlC90=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS0+ybYcokQLe7u09cDWs1pssmZveUQDbXyShfl
 0qFpXlqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktAAKCRBMtfaEi7xW7kQbC/
 0WWiPP1mHnTVz7t1OngMVyaUyb9neZlJ7OpbOI0EfIIimSACkarT2JkjTEAgQ6++DdZZqsf36LWQd+
 0ZWcdl0DBqmyCCGe+5XV0PpYBYXczvoQ1yR3TSanBdkj6bZLiHubjFuVvagyLlXgC3wgh3wVHSOf11
 vQKDFRyM5YiUNuhYYzdUCRvP3PbSenGg7miRaKoQxsZJUaCp4emo5/1BwLM55BH9gh8SHH2yiy08Pm
 csUoyf2U9XeAmXvcEjeBRb5lRlkPpbrSR8lTtXSd32UpGpxjuH2+nJS78hEgDLEB9jgYYmE7lITsFQ
 M942EAKeJ5oZPGNa/DuLNOHA17MEfry/ZhOJZm2s69FLdlWIlLJwYt5LsJ291JgMTbfgIzcLoeeW3G
 +Ar89i8WELO94059y9xGW8R0mQnXUoZrUspfi+/WBxox0/tqZseCbvv3RC0dIHL8rt+Z22cvOZk1z0
 SqsrbinWt5ANVjNqClElsYpuxViZTY7OFOaXinxzeJHeU=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 11/22] arm64: Drop unneeded __nocfi attributes
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With -fsanitize=kcfi, CONFIG_CFI_CLANG no longer has issues
with address space confusion in functions that switch to linear
mapping. Now that the indirectly called assembly functions have
type annotations, drop the __nocfi attributes.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/alternative.c      | 2 +-
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c7ccd82db1d2..bba0e630c8bc 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -147,7 +147,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
+static inline void cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 9bcaa5eacf16..d2c66507398d 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,7 +133,7 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __nocfi __apply_alternatives(struct alt_region *region, bool is_module,
+static void __apply_alternatives(struct alt_region *region, bool is_module,
 				 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af4de817d712..ca6e5ca7104e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1685,7 +1685,7 @@ static phys_addr_t kpti_ng_pgd_alloc(int shift)
 	return kpti_ng_temp_alloc;
 }
 
-static void __nocfi
+static void
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
-- 
2.37.2.789.g6183377224-goog

