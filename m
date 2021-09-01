Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84737C432BE
	for <linux-hardening@archiver.kernel.org>; Wed,  1 Sep 2021 23:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5657A60F42
	for <linux-hardening@archiver.kernel.org>; Wed,  1 Sep 2021 23:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhIAXfI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 1 Sep 2021 19:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhIAXfH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 1 Sep 2021 19:35:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E994C061757
        for <linux-hardening@vger.kernel.org>; Wed,  1 Sep 2021 16:34:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fz10so174842pjb.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Sep 2021 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAZb7qLxUYT4Fe2O0uuEIQIiXkq7ty4ylRhyt/AW8ok=;
        b=fkAH8AIhaURLK4tC4/v7F1W3imn5PFCMAiK4EJyXnoNQ7jYal3lXaO4V9y0uArW9vk
         ubO+Si3NUEZQ+EKRfsrkwBGHlAWHKX4eci8jKlADMYZmecqjcrRgu5TwA7XfKnbBG79Z
         5yKDK16mVqyFJJuuwfwMkMFk0S26ZvvxPz4vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAZb7qLxUYT4Fe2O0uuEIQIiXkq7ty4ylRhyt/AW8ok=;
        b=P+td5Ang8FV11GqMrWwWFRThaaEfhBMK5dG1ApoJJ6/WbSYFPnnSQ98sX+ElQ1qn7Z
         7iI9mhRw0Jd9zJOupUvr0X56dH9BnO81Umtxo9mBl3/V5HfAVPKYiMAmFXRTB1+0Bctu
         CgXLYOc071mT8htQvQnOjcC+NeQoUT09q3gE1gNiuJZbLWlZVDnijnEklqAe1R6DJGwv
         AkzcxvbbmuovJC+k1MJAObRcPxrQzxaJRZOWrTJPvW4cCZRA2GVheParKeF4yMnJHlrq
         7PTrVTTlNrzI2ol95Lh77uCy1CvKjo85DRKM1nnxQn086hWy/e9njUJ531tkGA5bHFqC
         xG/A==
X-Gm-Message-State: AOAM530/5kHQlev9ywPNuqaTudfrCDbKJQC3Xir8m4XoC0R8Bpvtm33W
        /Klp7YznQmQBbxepyNnym6xdLBe4QHI8Mg==
X-Google-Smtp-Source: ABdhPJz3KkQwUq02tAFAzUPmcSRWFLd1cMATvDvh/uNurZMHRxxXsH18PT8fBymxO/MUjGGepyJ7eA==
X-Received: by 2002:a17:90a:bc8d:: with SMTP id x13mr355600pjr.66.1630539249542;
        Wed, 01 Sep 2021 16:34:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p3sm71807pjt.0.2021.09.01.16.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:34:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm: Use init_uts_ns.name instead of macros
Date:   Wed,  1 Sep 2021 16:34:06 -0700
Message-Id: <20210901233406.2571643-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4861; h=from:subject; bh=Ndjrs2+10O1WjniUeDpx1ZVnLXF20+3EFHnegJ79q2w=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMA3ulRpJUBbLPKoBJ068T/QFhLJH/HBw/ab04fnf V1tOowWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAN7gAKCRCJcvTf3G3AJvl5EA Cmt3T8PjrR5ylcHlXe9uyfP/c2Ll2HRT6QIE7/adogfnk+ISJ1s7vpxCslYGaSZd3cUPYuHTaPZA3g 0zzUodoHKq/w+rfUjNRg1PbCBmJrHogongdK24zLSNJk8hLCbTETviaFa2G8ERFZS92P3OUftsWuXX rGURGhBl00YEX9PIfUeAzTn3wDPCEdbRPkrOB8/7+ot9vGe5QkzPUAVh3t7pd7Ij9HFWeN5j9N4ASL eRE0ZOsd3ywRg5GuQ+WfCczJ+OEbXcHs55k7xyYIl5RPNpeUparHG5GxsxoqYG6C3TYzp9fNg9sppU FGzuNlUjmcj/JKMv28Tmy17EMkKDbbOZUMyMPJxuY8zCaYy3SPsypRQ/WaAWPeRBgidbCkbBYXYr/o XQoc9O5B9hENO8AFVAdyYz6U94ESVRT0uv2pvUxTRASaZweZkq4H20KvIKi9mWNHyDVcrFui7Xt/qT EvHYrb1WElKsw5u5SQ0ZTddSBIA5ZCUrV23UlcD4KP7v9R5mB7PQOth9BBpKCTrfzo2d6bjSYqqb3v D13YY8cE7SEUmnW1PE2HGL8rMICBVsW02fOmpB0kLhePRjx8hPEhdDtG+9Sfos9TlvnbzcDLWxCQSD oHyvHYA8qui6p0/PN3ZpHjHB7Ryi1teZwN9bVQIQtkLObHbEGzlbazDKHbog==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Using generated/compile.h triggered a full LKDTM rebuild with every
build. Avoid this by using the exported strings instead.

Fixes: b8661450bc7f ("lkdtm: Add kernel version to failure hints")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/core.c  | 10 ++++++++++
 drivers/misc/lkdtm/lkdtm.h | 28 +++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 95b1c6800a22..fe6fd34b8caf 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
+#include <linux/utsname.h>
 
 #define DEFAULT_COUNT 10
 
@@ -210,6 +211,8 @@ module_param(cpoint_count, int, 0644);
 MODULE_PARM_DESC(cpoint_count, " Crash Point Count, number of times the "\
 				"crash point is to be hit to trigger action");
 
+/* For test debug reporting. */
+char *lkdtm_kernel_info;
 
 /* Return the crashtype number or NULL if the name is invalid */
 static const struct crashtype *find_crashtype(const char *name)
@@ -490,6 +493,11 @@ static int __init lkdtm_module_init(void)
 	crash_count = cpoint_count;
 #endif
 
+	/* Common initialization. */
+	lkdtm_kernel_info = kasprintf(GFP_KERNEL, "kernel (%s %s)",
+				      init_uts_ns.name.release,
+				      init_uts_ns.name.machine);
+
 	/* Handle test-specific initialization. */
 	lkdtm_bugs_init(&recur_count);
 	lkdtm_perms_init();
@@ -538,6 +546,8 @@ static void __exit lkdtm_module_exit(void)
 	if (lkdtm_kprobe != NULL)
 		unregister_kprobe(lkdtm_kprobe);
 
+	kfree(lkdtm_kernel_info);
+
 	pr_info("Crash point unregistered\n");
 }
 
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index d7d64d9765eb..c212a253edde 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -5,17 +5,17 @@
 #define pr_fmt(fmt) "lkdtm: " fmt
 
 #include <linux/kernel.h>
-#include <generated/compile.h>
-#include <generated/utsrelease.h>
 
-#define LKDTM_KERNEL "kernel (" UTS_RELEASE " " UTS_MACHINE ")"
+extern char *lkdtm_kernel_info;
 
 #define pr_expected_config(kconfig)				\
 {								\
 	if (IS_ENABLED(kconfig)) 				\
-		pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y\n"); \
+		pr_err("Unexpected! This %s was built with " #kconfig "=y\n", \
+			lkdtm_kernel_info);			\
 	else							\
-		pr_warn("This is probably expected, since this " LKDTM_KERNEL " was built *without* " #kconfig "=y\n"); \
+		pr_warn("This is probably expected, since this %s was built *without* " #kconfig "=y\n", \
+			lkdtm_kernel_info);			\
 }
 
 #ifndef MODULE
@@ -25,24 +25,30 @@ int lkdtm_check_bool_cmdline(const char *param);
 	if (IS_ENABLED(kconfig)) {				\
 		switch (lkdtm_check_bool_cmdline(param)) {	\
 		case 0:						\
-			pr_warn("This is probably expected, since this " LKDTM_KERNEL " was built with " #kconfig "=y but booted with '" param "=N'\n"); \
+			pr_warn("This is probably expected, since this %s was built with " #kconfig "=y but booted with '" param "=N'\n", \
+				lkdtm_kernel_info);		\
 			break;					\
 		case 1:						\
-			pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y and booted with '" param "=Y'\n"); \
+			pr_err("Unexpected! This %s was built with " #kconfig "=y and booted with '" param "=Y'\n", \
+				lkdtm_kernel_info);		\
 			break;					\
 		default:					\
-			pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y (and booted without '" param "' specified)\n"); \
+			pr_err("Unexpected! This %s was built with " #kconfig "=y (and booted without '" param "' specified)\n", \
+				lkdtm_kernel_info);		\
 		}						\
 	} else {						\
 		switch (lkdtm_check_bool_cmdline(param)) {	\
 		case 0:						\
-			pr_warn("This is probably expected, as this " LKDTM_KERNEL " was built *without* " #kconfig "=y and booted with '" param "=N'\n"); \
+			pr_warn("This is probably expected, as this %s was built *without* " #kconfig "=y and booted with '" param "=N'\n", \
+				lkdtm_kernel_info);		\
 			break;					\
 		case 1:						\
-			pr_err("Unexpected! This " LKDTM_KERNEL " was built *without* " #kconfig "=y but booted with '" param "=Y'\n"); \
+			pr_err("Unexpected! This %s was built *without* " #kconfig "=y but booted with '" param "=Y'\n", \
+				lkdtm_kernel_info);		\
 			break;					\
 		default:					\
-			pr_err("This is probably expected, since this " LKDTM_KERNEL " was built *without* " #kconfig "=y (and booted without '" param "' specified)\n"); \
+			pr_err("This is probably expected, since this %s was built *without* " #kconfig "=y (and booted without '" param "' specified)\n", \
+				lkdtm_kernel_info);		\
 			break;					\
 		}						\
 	}							\
-- 
2.30.2

