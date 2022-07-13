Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2BC43334
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jul 2022 21:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiGMVbj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGMVbi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Jul 2022 17:31:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D252494C
        for <linux-hardening@vger.kernel.org>; Wed, 13 Jul 2022 14:31:37 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so11588367pgs.3
        for <linux-hardening@vger.kernel.org>; Wed, 13 Jul 2022 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=faovg0APXwsBZurX2E7/mhKATFIwpSIytN1XAZxfjKw=;
        b=i4VExXfcxatbto9dlBTX5BnONNJL9cje1H5VnhnKVeIxAYF3UOeA0gvTx0rfr0lVoo
         +0SDB6+elYwaqdbF9OeP/dIAjWKP8TiVMpgbUWfSwbvIvtITt9eqbalnYaEbMhUCoFMk
         QCTu6uOGqeGfnQYFM3gMpQHVoMHREkqk5JtIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=faovg0APXwsBZurX2E7/mhKATFIwpSIytN1XAZxfjKw=;
        b=jRyRl2ZgaTqqBT3Fpyj38RMzgXSUkrX+6oxavG2pTE8AGMb2S6a/Q9e2ySRVMaT27s
         KOQO3b6hAzfOsuCqYOzFsTsa2kB26AWHmXlqU1gr6fgCL0LweEfdYS3I6Ss/WYsQRt4s
         Oyoqzo9DVGLNEuH6Bl6MKsA7LqU1GmUNlKbq4FMtFArCnZiJZjVRIy5FZsFzeGX2gOkX
         Sdn6s82zozLmEzXS7jKSBKjMhyIUgvgb64yfEdcaEz6cIlsTTnwKVJih9d7+wf+vprxJ
         f5Sloxo+dFU0ut9TMhpqSyctXFMaSy+mNEFUO2zrrjjEXewfSV9Ujtf/IFPZY4aObleS
         YkPA==
X-Gm-Message-State: AJIora/y+PUEtSGUrgS9f+jEbculsK3pK6ZqDq8JhmcR9VjJEYp+Pre8
        jJntIwp2AVjaVY/Xb4bW+82URRP54hLZ3w==
X-Google-Smtp-Source: AGRyM1uc/6Ttnj7h1DTVK+hDssQD8GFzCqJaWlnKT5UZwIa636VX5xkmzUmO9kDI7dtgBcmE24k12g==
X-Received: by 2002:a63:195d:0:b0:412:50b8:c410 with SMTP id 29-20020a63195d000000b0041250b8c410mr4373873pgz.520.1657747896992;
        Wed, 13 Jul 2022 14:31:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709026ac500b0015f2b3bc97asm9313209plt.13.2022.07.13.14.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:31:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86: Allow for exclusions in checking RETHUNK
Date:   Wed, 13 Jul 2022 14:31:33 -0700
Message-Id: <20220713213133.455599-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; h=from:subject; bh=nO5LJoKss5jfm9QauonmCnKJHsgnROyl7K2WMaRujUk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBizzm1Ea1/Ygk7y0PBrqVq9uV0qdgGqdUf/sxK/Lqv H1702OuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYs85tQAKCRCJcvTf3G3AJt9sEA CF5JHhveuc4pye5WU7x5vXTjLx0VDQ/GExZCJszMeSjOLgmjCYTXHt7Qu++issRGgLfHLfdDi08A8o hbe5Km4c1CB//5jjm/1VTnb8/OAtUAXNZgabLDGA6dFgcGfgnxnn9Uql425TiC93UAw0gfs6iISjP+ VeetRaAFDyaMOEwZrHOOv4wJgX/dWOEpSmW630srgX1S5eG50sEn82mvpX/t6deCRt8gm9xjLTOeOx P9mBkRVnEEelQ831fqPBFyGTSkOcr4AFDeWCBEDVYob76cEJetAg0IB1IOG7q9lt34MvRXBv5qVglZ +7E6jeK0XxplQHMX7kEmI9VttTPukJWB7SbMKv5rQ5s6bt8xa/XOIPw+8MLJBJ5pxEv/ZHKeziiPbB 0n+FL+DFXjxCBrTqVab0PV0QiB9oCBDhHA4hahfEVfrglDi9nvCMW8iCb5PL4dUM8VXIcFNvIJw/Jl GtRuLFNqlFm8dz0UpKCkv2126ZeDIZCjYXz7Ar8nZdU2oyHo4cgq2idwpeTgcp1TOXKfacSvOiD8IM am16Wz0mqB0KDX+Duny3qkzi+re1JzF/967G2wwJy1JlAEXn3Ndm7FTKcas8pVSeHsLe8DSlkiRXza y1XUL0bi0Z0o2xH0PDuxND2kM1HWK8m0rBvwPfaMxnC6lLTgdmfBqnME9f4w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

LKDTM builds a "just return" function that lives in .rodata, but this
creates problems when validating alternatives in the face of RETHUNK.
Export RETHUNK_CFLAGS so they can be disabled for the LKDTM function,
and ask objtool to ignore this function. (Use of STACK_FRAME_NON_STANDARD
here seems to generate a non-.rela section, that needed to be adjusted.)

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/lkml/Ys58BxHxoDZ7rfpr@xsang-OptiPlex-9020/
Debugged-by: Peter Zijlstra <peterz@infradead.org>
Fixes: ee88d363d156 ("x86,static_call: Use alternative RET encoding")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile           | 1 +
 drivers/misc/lkdtm/Makefile | 2 +-
 drivers/misc/lkdtm/rodata.c | 4 ++++
 tools/objtool/check.c       | 4 +++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1f40dad30d50..7854685c5f25 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -27,6 +27,7 @@ RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
 endif
 
+export RETHUNK_CFLAGS
 export RETPOLINE_CFLAGS
 export RETPOLINE_VDSO_CFLAGS
 
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 2e0aa74ac185..fd96ac1617f7 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -16,7 +16,7 @@ lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
 KASAN_SANITIZE_rodata.o		:= n
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
-CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
diff --git a/drivers/misc/lkdtm/rodata.c b/drivers/misc/lkdtm/rodata.c
index baacb876d1d9..708a2558a7ac 100644
--- a/drivers/misc/lkdtm/rodata.c
+++ b/drivers/misc/lkdtm/rodata.c
@@ -4,8 +4,12 @@
  * (via objcopy tricks), to validate the non-executability of .rodata.
  */
 #include "lkdtm.h"
+#include <linux/objtool.h>
 
 void noinstr lkdtm_rodata_do_nothing(void)
 {
 	/* Does nothing. We just want an architecture agnostic "return". */
 }
+
+/* This is a lie, but given the objcopy, we need objtool to ignore it. */
+STACK_FRAME_NON_STANDARD(lkdtm_rodata_do_nothing);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b341f8a8c7c5..c1b58a682ace 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -902,6 +902,8 @@ static void add_ignores(struct objtool_file *file)
 	struct reloc *reloc;
 
 	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
+	if (!sec)
+		sec = find_section_by_name(file->elf, ".discard.func_stack_frame_non_standard");
 	if (!sec)
 		return;
 
@@ -3719,7 +3721,7 @@ static int validate_retpoline(struct objtool_file *file)
 		    insn->type != INSN_RETURN)
 			continue;
 
-		if (insn->retpoline_safe)
+		if (insn->retpoline_safe || insn->ignore)
 			continue;
 
 		/*
-- 
2.32.0

