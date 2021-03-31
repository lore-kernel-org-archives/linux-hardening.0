Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3D7C433ED
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 21:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E0461076
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 21:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhCaV2N (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Mar 2021 17:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhCaV1e (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Mar 2021 17:27:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78012C061765
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 14:27:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v186so3653142ybe.5
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lJzARyoTFHSeDeqATvX4eu9oF56GjO0aovkcTYMeCXE=;
        b=EkwKQyMZdT5HfDUmkAZVrW7DWLH3qdU+R/FHZTPqq5IKj3NSExJ7rO5G826Zfp25Du
         4SeLWwQdtvXJZTK7h4ZZ28yesbAdVRYaYD0+nkzkzzHCLmsSAl5G+DxlpNEm8A2HbV14
         tjDJKbgnnBAN8zUjWqqu5EfJrrMMTPcc3Vp3MbyGSfKz3w+5QkjRKPTYJiaUHVyIfGAH
         Uw2KSLbyUziDQJrTtbRd5qayoZXfFGV/ul1u7MZ+aVnD/YxBbkoVM8AG04ixf/ZBdxFM
         lnSgkOrXFZ4W6piai3EFaSnpzVwD5YS8KMAEeWGT9UwcCv3eo8BVkIjR90//1hltbdO1
         WtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lJzARyoTFHSeDeqATvX4eu9oF56GjO0aovkcTYMeCXE=;
        b=POgvmdga52pmzwW3j7/A1w8vkfeIrLV62EJKI/rgCBaLNROt3AqNglEmwW3YdT0brj
         iF5m+ZXpG/UPRW330ITSRuOXHMfR0RPq0Wz7bo52PEdQ6BALASvi6WUFVo50+tWD6m9A
         Cbz8qcYfCCLyU6XAeMsbsHHQazsRUgdzkTpCXTQrYaxTNjYie+YYqNlgtGi1k7/fOpW/
         pSyFJbBMDfY2bD5V7puCQ9PC55DGRhu/iMqkYV4cGiDQAkdmZaTb0IDuKueH3GBk42Ay
         UbfVjiHDslMNsX6Q1eT/Nti/32Icps2MOZE+xvMEzAl0G/m/b9hotB6D+xAML0f2QEpp
         AAFQ==
X-Gm-Message-State: AOAM530xYzHeCRTGVXiFTqrn/snCLxwodwmo/DiDFPLFOkRZaJO5Hgnz
        /HgKsHO/hhnRK/O6qIn4EwYC8Re0tfAl1t+Zai4=
X-Google-Smtp-Source: ABdhPJyd8HcE5E535kHQ1N5nE+6FNp3+tY1VY7IhXOwntRLaet3Jq1vErDdNDQFRye3uE6pJ+4BkgjDjLB/yQDl1VBo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a25:5006:: with SMTP id
 e6mr7725488ybb.109.1617226051633; Wed, 31 Mar 2021 14:27:31 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:08 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 04/17] module: ensure __cfi_check alignment
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
aligned and at the beginning of the .text section. While Clang would
normally align the function correctly, it fails to do so for modules
with no executable code.

This change ensures the correct __cfi_check() location and
alignment. It also discards the .eh_frame section, which Clang can
generate with certain sanitizers, such as CFI.

Link: https://bugs.llvm.org/show_bug.cgi?id=46293
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
---
 scripts/module.lds.S | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..2ba9e5ce71df 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,10 +3,21 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+#include <asm/page.h>
+
+#ifdef CONFIG_CFI_CLANG
+# define ALIGN_CFI 		ALIGN(PAGE_SIZE)
+# define SANITIZER_DISCARDS	*(.eh_frame)
+#else
+# define ALIGN_CFI
+# define SANITIZER_DISCARDS
+#endif
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
+		SANITIZER_DISCARDS
 	}
 
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -40,7 +51,14 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
-	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+	/*
+	 * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
+	 * of the .text section, and is aligned to PAGE_SIZE.
+	 */
+	.text : ALIGN_CFI {
+		*(.text.__cfi_check)
+		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
+	}
 }
 
 /* bring in arch-specific sections */
-- 
2.31.0.291.g576ba9dcdaf-goog

