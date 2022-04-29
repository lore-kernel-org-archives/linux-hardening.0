Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A8C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 20:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381033AbiD2Ulb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380966AbiD2UlG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD98CC534
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w133-20020a25c78b000000b0064847b10a22so8371158ybe.18
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c3P0Hz4r3G9OpLG/quSc8J3HkB5RqmI/gpWW3ubqRHw=;
        b=L3b4tsGo9U6EKhT1enH+lnwRGBAriMT04pxJOWGmkTh/LOTTSEf7+ZnnodamgedxF/
         0cwAbqdA5BTRqaVaWO9cIk3CrgrGdAh+jueAcHfV8Bg8TTAZ+khVx+B8eXyacA4mY4Xx
         K3TQUEqnaXw1lY5l03iwoFMiQRQsJmRAKWpBy5VlbUJzdl8A2l7wvJu19Rol8flqku9I
         WNZ/yUORvsGxlp+SHTywXjv/cQ3+dFZB9Bv+ISu7Xf8nMdBe2LwKPup9v4pkWEFDDPFS
         kaimPMTLgDV3p2dFB9fsB4bsR6Vkc62TMrM/JjgmNdYT0fQUUEBM5oeL8rAQdxi3N/ib
         ZNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c3P0Hz4r3G9OpLG/quSc8J3HkB5RqmI/gpWW3ubqRHw=;
        b=rIrVZikXuXexWP3jMRtRZHjFqhtICc3cD3F1ju0FoTMwj7DszbFs0/1KngW5Exv6xf
         9SOJxDAF49nGyXx+LiD2soQ9wjpT2QldJ/zfajiUe75/TNkVaBnbCzc5RZpMPuRHLbsB
         pRFOPP6NDF3R8N1Nb86ge9M97hOx3Ln012BCdaZXO3pjhJYWr1h0+/BpZEbYFJ6WQ++k
         iUKh6gQimqqGY8vu46WB0ti9CppCEzlhkNPKfsUmjqOOaBQ9KHcQQIDsHIhGwnB+3sNW
         zCDhnJwitW7O0Ma/nL4GQq5rnWz0pnZgFL0WH9Rd21Y0DYE1N3nPDBEDtQCpRTpgvzNX
         8Icg==
X-Gm-Message-State: AOAM530MnGABhCUPCSYmmJmo0rHhTgGvqLq3lMfhgeLxQDO5Ezu1drr+
        0FE1/SCofVZL/FAYIg7n+TrGvWZLgea/mwsRqKM=
X-Google-Smtp-Source: ABdhPJy48Ta9ddvMIF4e+65DRSdxotM1XKnrKu3boCyUAK2XttelwSr/WCmbVBiS9zrXdXlk0V9aV262+2v6W6Pe/+Y=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a81:8493:0:b0:2f7:d7c3:15f8 with SMTP
 id u141-20020a818493000000b002f7d7c315f8mr1216311ywf.196.1651264655480; Fri,
 29 Apr 2022 13:37:35 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:43 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; h=from:subject;
 bh=qwzizA85BcxzgY6DCPbuVyLVCg+lMcvwRT1NDXtCdLs=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExYM8ehL1/+o0aCrhRJzqnXsps5M4p21c1LQlC3
 sSVsl4WJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMWAAKCRBMtfaEi7xW7tTEDA
 CIw6jCzNraux3uPsdGgkoAmjqy1E308ymvORumKcO9YZjpCWgxUG+wrt+QoMZR3WsGxUe2zWhOF83/
 GBMcbJoiHwlX4DbEEk02ZUts9xuqk851PS5XPj4XupWl8F+kbRnXqWj7hSkLGOAkDS71i8n4fC9xr0
 6Ez6wHIz/0fvbvzjy2pHl3vX2S1oouofjPnfB6+NNmsyEb/K8pceL8f2CcR6jIzAd/J0QmzZTj76WT
 O4AwX/0ZNLkWjMQpGtuKzzGFHozskjUdwKRyIsCMnHGCm2py2s1oLV/ZY9mk7yD4IoRB3MrC0v0FDM
 Fl8hcWy38RiLdiG2OvGkUee959W0eF+qPDLNNpHfpiSB1J1t43APoJLX+iPYsGLObYHe9DGTllVo0x
 kt56P/u268sda8zQK7JrAuU3qLye5d96mt/FiDL13+rXzBZuloXyNLx7trQLbxVhiAQkGYOvGEGt2D
 lY6u8L5nEHbyCOCMu0kfKXPQzqa6gVH7sa1innsuiCfcA=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 20/21] x86/vdso: Disable CFI
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

CC_FLAGS_LTO no longer includes CC_FLAGS_CFI, so filter these flags
out as well.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 693f8b9031fb..abf41ef0f89e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -91,7 +91,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -151,6 +151,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_CFI),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.36.0.464.gb9c8b46e94-goog

