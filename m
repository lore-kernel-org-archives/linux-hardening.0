Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B2FECAAD5
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiH3Xbi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiH3Xbg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:31:36 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33629807
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:31:36 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i1-20020a170902cf0100b001730caeec78so8739852plg.7
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=L25uLgv5hznFOW8C65x6whtc7Tn9BJysM2Vvz8HWyDE=;
        b=GlyX/udszzm3ETI6dGBsinPgbb2zH2Sx7UXYz/1vjC/nGY+/X7ZLW46uqN3etLOPT0
         gV1SaWu+mT9dOl7PKHrdCe9i+XWpddw8gn1LLlyKiAiZDyL18nKBWphU62pG+hJKxRmM
         u+uoRGf2SWIvXTlojSYkQR+2T7yMZdfaE77HWRA76cmFOBZRkZN023sEPCVRGdvc5u7V
         WBxTSYiDyS+PUfPxQvu0l+seugBhnhEOip5lzg5qUgw3A6gDkzqA0gqRlSgn+YUgNTBq
         ekG0EJpcTzqD+Y4jhU0JnnShqvo1JQRejynQVVRjwAZ9ll4kYjRhz7z/Zm+n5si+aKge
         f35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=L25uLgv5hznFOW8C65x6whtc7Tn9BJysM2Vvz8HWyDE=;
        b=jzLJh0/Fg/R0f1Kc9EJyWV8H0n/2OF8VZfRiCovy2u6U/w1NNYOyuSbi0pF896DTY7
         ukBEUpLfJnYq66zJTizAF6WHHzlb5MGC5FWgagtF5N7DI+QhXw7ofD3zAn4C6Pj/G+3D
         75vimn4keLpbx+sJfIUtEJmSvI1yV7j/sCfQSzNtu/I4sWGK5NprKlyFGCJ2ckE7m3xb
         CfLKhtbwYM7cQt1AMCIXyRJLqkOfTc4l5Cz3Of8FIK4c9cxB3hG0kwwnytyHFpeWkFEh
         MNIkp/F/0HcdAnMNqS6njGuybd/3t6Xro9wToei5DP5CEFB11ITIUvAUqbpxY6/lgPoL
         DsSg==
X-Gm-Message-State: ACgBeo1dalBrVuM8nl4YC8AYEs4l7Yr/RO94Ad1TQFzd106nRLV8H/zv
        AcKpFlp1AoyuyS+y49G1PPIB0dbQC0FpUR1V8XQ=
X-Google-Smtp-Source: AA6agR6t6+RmUgXGfCDMkXtgpmsLFiEpc19Ih8//1Ts8Vdoix/62fuolHALxDz5NswEPkfsF2/qhJD8nw7h8pAHo2gs=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with
 SMTP id t9-20020a17090a024900b001e0a8a33c6cmr14044pje.0.1661902295271; Tue,
 30 Aug 2022 16:31:35 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:09 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=samitolvanen@google.com;
 h=from:subject; bh=Y2KllNLLe5W3ojqZsH1L8RGIJ3+vQcqt1B34SGCIoIw=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3LFZnyR8Aq9IX9f3NCTQfZ9PLKXxM9T7+t9pe6
 XCRRtGeJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dywAKCRBMtfaEi7xW7vF8C/
 0Q2tFR9IU/s09oK/aPYzy2OnR4Fl7grWpQwG8dbDwI9bQFdE58qu5aKvOkH1n5LoPMnx1oiPeKAua8
 Xbr93KRYEltkTaD58AlXyUTQVb8W/+WK4z5r0qhm6P2JWbCqvDwg4StkJRSB7vDn+lmR/PA0lfUQob
 tOp1QJGiNuDLFc0TbTSfqkK/xMXR6a0+FdfMXg20QKWShLiYE7bYKvgl6pguSour1sba5xcznBLxV3
 M+9Ri4Nnvzd0QnR7bku4sNbS59EpdZ9c5D6eJjbsmZwIrBklT2i9BvcfHx4n6HCM+M0pWiFtQTUUXK
 ZDwfY8tjUVanTK7afJi3m5XLWkUlmJhaxk1YjwGK1wpbf+kcj9ykRivZnnU/eqNPtW/jP1Tk3ixLUv
 ceQHLD74GD+/xpPl9+6/1b0LWdDFc2ephQ2+kiVVS5zMGX+bRduupKomCFdvdHgAf1GrFAJb7iKA9R
 JE6m9yMp4f9no/FyLoJGQiPKz1klAidmbOixNOnCretWc=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 01/21] treewide: Filter out CC_FLAGS_CFI
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

In preparation for removing CC_FLAGS_CFI from CC_FLAGS_LTO, explicitly
filter out CC_FLAGS_CFI in all the makefiles where we currently filter
out CC_FLAGS_LTO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vdso/Makefile       | 3 ++-
 arch/x86/entry/vdso/Makefile          | 3 ++-
 drivers/firmware/efi/libstub/Makefile | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index bafbf78fab77..619e2dc7ee14 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -40,7 +40,8 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 # kernel with CONFIG_WERROR enabled.
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
-				$(CC_FLAGS_LTO) -Wmissing-prototypes -Wmissing-declarations
+				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+				-Wmissing-prototypes -Wmissing-declarations
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 12f6c4d714cd..381d3333b996 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -91,7 +91,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 $(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
 
 #
@@ -153,6 +153,7 @@ KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_CFI),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..234fb2910622 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,6 +39,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable CFI
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
-- 
2.37.2.672.g94769d06f0-goog

