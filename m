Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB33C433E0
	for <linux-hardening@archiver.kernel.org>; Sun, 21 Feb 2021 22:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAD664FC8
	for <linux-hardening@archiver.kernel.org>; Sun, 21 Feb 2021 22:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhBUW5k (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhBUW5f (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 21 Feb 2021 17:57:35 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278DC061574;
        Sun, 21 Feb 2021 14:56:54 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id s107so10377449otb.8;
        Sun, 21 Feb 2021 14:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=BMlieb6U92lcNjW+CkztzeL1c/s8InuHgyvsXFn4OdU=;
        b=M6zz+wIGsyJlgsoKsvT4r/K3OJ8vIXbnyCFPE3jaoMGfzQkiqpBu1bVZnoalTdAG/O
         ZW9JYNkCTSzQ8MRd9Ue69ZgnMZGhWwkHtnvoIhSgW+OwZevtCcf3E5PUr66swHfZ3Tvy
         HBKuWY8SoMhrO1tymK3VQz3nJ9qjVrh6jNPs1rHsj/Orz+9UT1BLKaGROuJwsIcnGMm5
         HcbVx3shiTUyPpx49XIK2s4QsJL0QndbK6/rCH9Ois1HPGU9M6gAU4BQ7xD8mLJmwf66
         7rHjzT9md3venlK3wYG/9SIMx4OpL45Y82Nt4OET0rhhq4auABqr6ssnwxwP3J1Z/8IZ
         8ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=BMlieb6U92lcNjW+CkztzeL1c/s8InuHgyvsXFn4OdU=;
        b=XFZ5jvTQx27l54rYEUUvOd7yw0KLfOERM+aFFG+d4pPHyRYzpte2SMbCgJvwn6fHZ9
         oLDkLh8PJ2jnPppQ1cHRvxLu9AfethntYgfsJNpsZkl5oRRcuVrV9yyz0y+5OtzJKLxk
         TITxBawu15QhnHJlQw4ZjjDMPwTpsjKJ7MGAsiywf5IzG316GtA/Hl4rxAnWib6wAWbm
         WXCe6BbnOme/JPY53bM1M7Vy+yyrUk96VUXbENw1NPZ6qXTsLGhNva3IQJtPt7l60TS9
         R12Dle5X/P0E1m0Wtgzq1RH8d5G6EnLFgkSBgLCUgL8SYTvAPbcXCVb3pUUMJUJUd4Xo
         bRnw==
X-Gm-Message-State: AOAM531u1mru/0gqEoTbZnJ1UxzTDsTYZIobrV46F1VNnLnAboV138ej
        tgWxaLCTe1bZuy97pzys62O3CyS00mc=
X-Google-Smtp-Source: ABdhPJy1k//MXUUCfVO+EN2AqRi7nyNt9DUiG/3U8QkFMX/7/Gu+QRCLWtK6J6eCy4tVc7hLAkHA9A==
X-Received: by 2002:a05:6830:1ac2:: with SMTP id r2mr5915387otc.80.1613948214142;
        Sun, 21 Feb 2021 14:56:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i23sm3383705oik.10.2021.02.21.14.56.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Feb 2021 14:56:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
Date:   Sun, 21 Feb 2021 14:56:50 -0800
Message-Id: <20210221225650.33134-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Commit 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390") disabled
COMPILE_TEST for s390. At the same time, "make allmodconfig/allyesconfig" for
s390 is still supported. However, it generates thousands of compiler
messages such as the following, making it highly impractical to run.

Cyclomatic Complexity 1 scripts/mod/devicetable-offsets.c:main
Cyclomatic Complexity 1 scripts/mod/devicetable-offsets.c:_GLOBAL__sub_I_00100_0_main

Since GCC_PLUGIN_CYC_COMPLEXITY is primarily used for testing, disable it
when building s390 images.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Fixes: 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 scripts/gcc-plugins/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index ab9eb4cbe33a..5e9bb500f443 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -21,7 +21,7 @@ if GCC_PLUGINS
 
 config GCC_PLUGIN_CYC_COMPLEXITY
 	bool "Compute the cyclomatic complexity of a function" if EXPERT
-	depends on !COMPILE_TEST	# too noisy
+	depends on !COMPILE_TEST && !S390	# too noisy
 	help
 	  The complexity M of a function's control flow graph is defined as:
 	   M = E - N + 2P
-- 
2.17.1

