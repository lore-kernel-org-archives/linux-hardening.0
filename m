Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6309FECAAD4
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiH3Xd7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiH3Xdb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:33:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02862844DA
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dbfb6d2a3so190482017b3.11
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=lxwsXrI3Mz5fmQ5/zOX86abUuUXDGoEtutr5sfPTzdM=;
        b=ICOfaU59KFOn1u8tj+jNF7yA54b5eS6xOe+IMHATV8lUzWB/2X2Z7ndebW8SuDJbZp
         zZExhr0GX7vlb+myJsY4FJfR80s0uELf0QyRcIe5XQhj9GRlUZuBufvTnZ4HaOz+pmTg
         vdL2ZN5DasdfM+e3GGko29L8VL3IBBrhWSRT/JGEm5aRqwEo0EICXQTYqdYDldYAvxbY
         zspss2WPicINxssrlAuMaj3Ax9CPJPHBxNEmMh5eqte/8VwVdXlsUnYo+zxaeu9trZcF
         4XfnE3V82BgHAMxrXG3UrzKWzoe8+mEiXwyVd+uAnUcEZPy39B6xZ9xV+vlP87uDR5ke
         kJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=lxwsXrI3Mz5fmQ5/zOX86abUuUXDGoEtutr5sfPTzdM=;
        b=CveHGH4uH0wXvNjcbdBz+MBvLzAX3dZjdrbw8pnpjb09V8CV9iSqdkSt/FNW1s5plY
         KlGD9dZ3IZsY86VPt8hfLxQ5bqH6uigjjYoWEfXZeHmJ8P3OOqrotMSbLqrADa2mFkyl
         PtXDqkE6cUxU3TaAPkZD3y0fzBZkIqDxT5D8isSfyejnzYxTESCkR2snHklp8sIyZqb8
         9/a1piUHIwTG8XeCR6zCUEmcmlGH6vWnlyi3jj9tqnSOyIz+dd9JdzQbNUxu0X5wZBFq
         rT1reeC3SusvMPujkvi96I0qz1BCy/NaE4Kr3xon8p/LVlPBYtoCQzu7IK7aUlEvzNs8
         FIuQ==
X-Gm-Message-State: ACgBeo2rmEqlzsAr+6k5BOrO4uUfK4QNrGXmS5oyuC49qAUAEIK7/W5x
        Yxcp90CXQjKFYO6AaZ61Td432gFA8pAEhYCP1dc=
X-Google-Smtp-Source: AA6agR4fE6Gg8awQx2KS9WtJeU46JESb48vItR61XAln2KMXiSf46hjOiUeXjrEcWkyckSPoadljKPgTp5O6PLcizdU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a25:5986:0:b0:694:f850:223f with SMTP
 id n128-20020a255986000000b00694f850223fmr13658199ybb.491.1661902345267; Tue,
 30 Aug 2022 16:32:25 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:27 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=samitolvanen@google.com;
 h=from:subject; bh=j+dRbdVg7Q78Lk00de2uzEaCRhsdMEDN+wU7yhAtB6I=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3PCTTAdV8Hk1XXJcZvSvg5+O6k1Ozq2feAV3JZ
 bXDWub2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzwAKCRBMtfaEi7xW7uJqC/
 9g0WEa/wq7GPSj/jsZkwP+eo20vbuIdBILQjyKx6g3zSYpJxIRdSTMe/Ft9rn+C6apdUFx310uNdbM
 629LRshuNEW20b98k/SIj+1wQBpmaF3JtY0zXTo91YeKUtGNRxbQqIDLdHbnE8iyAM3byp4uwuIQXi
 62aPeT8h8d1R6FQXR/WCSNJ6FoyOhql2RVeaYgoEmWccYItjnIVyldJJ3ahwyvu+RHqZzqz5Jm4uW3
 Gq8MD/T/GZ5ZLuipErCj1iOaif8sJ1q2jjAQbsvNRcYvv6V600Vz9ABIcvr24nYx5sk2i/u7A6KU9/
 gvrGM0vh9P1e1gyTjGQF2puMGcf1PHLlUosOGkL7cslheQRw6lVU5hdOW8NKEBpfjpYUSY+41+V6zZ
 7ph644d9uMXOQS8kUtyAtiegxWqdCYYCY4EDa/ooM/v+1or9C+V8CFquTZnOFKmbfjbRYgc9b8iUp7
 lfdI5ThNkCnogOoZJn6A5Br9rWg1myT1DLEMipq1Dxs4k=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 19/21] x86: Add types to indirectly called assembly functions
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

With CONFIG_CFI_CLANG, assembly functions indirectly called from C code
must be annotated with type identifiers to pass CFI checking. Add types
to indirectly called functions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/blowfish-x86_64-asm_64.S | 5 +++--
 arch/x86/lib/memcpy_64.S                 | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/blowfish-x86_64-asm_64.S b/arch/x86/crypto/blowfish-x86_64-asm_64.S
index 802d71582689..4a43e072d2d1 100644
--- a/arch/x86/crypto/blowfish-x86_64-asm_64.S
+++ b/arch/x86/crypto/blowfish-x86_64-asm_64.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 .file "blowfish-x86_64-asm.S"
 .text
@@ -141,7 +142,7 @@ SYM_FUNC_START(__blowfish_enc_blk)
 	RET;
 SYM_FUNC_END(__blowfish_enc_blk)
 
-SYM_FUNC_START(blowfish_dec_blk)
+SYM_TYPED_FUNC_START(blowfish_dec_blk)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -332,7 +333,7 @@ SYM_FUNC_START(__blowfish_enc_blk_4way)
 	RET;
 SYM_FUNC_END(__blowfish_enc_blk_4way)
 
-SYM_FUNC_START(blowfish_dec_blk_4way)
+SYM_TYPED_FUNC_START(blowfish_dec_blk_4way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index d0d7b9bc6cad..e5d9b299577f 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -2,6 +2,7 @@
 /* Copyright 2002 Andi Kleen */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
@@ -27,7 +28,7 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START(__memcpy)
+__SYM_TYPED_FUNC_START(__memcpy, memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
-- 
2.37.2.672.g94769d06f0-goog

