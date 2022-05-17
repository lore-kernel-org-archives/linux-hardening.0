Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F66C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 21:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiEQVsm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 May 2022 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiEQVsm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 May 2022 17:48:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B72D52B20
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 14:48:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ev18so115384pjb.4
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0Z8qje4K0QTzYUpRNMwBOVtmOTsji77xZBv0BluXhQ=;
        b=WnAkLjd1rQkNEoxZ4eEbkLGqsHE1zlXRmuLo6CigBq+Exs81iTZNdgq1vp2esdTT73
         ++NJDD6ds7gRUeyf86VZC/nyvxR/IriYVDbAp7uEuvp+dvIZpg/8eeuDrqWXNnrTPIM8
         Jn/CU8fuW3nVAzQBbts1YUu8/lMcDXdHqgaLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B0Z8qje4K0QTzYUpRNMwBOVtmOTsji77xZBv0BluXhQ=;
        b=sYHnmjK4Yap1eTwuqSOI2F/C73mpbAzkm/Qu/+jGru4J9p36QxwVg41fSRy7itRAbw
         ZiLGDAHKyKIl2nUslDs5icpUKRHltW2vHOME8v/iVXtWOsnMHWVer2QUEsBUJQHOXdsQ
         IqDFqlLBaWbzpN5+s+rCp8SEltzKDblsjHrXjFKQUPLRVQdfbIVebQam/Sn9gqe/5iMO
         a2TfNc+ypxOlCVcEMxaIJVOE7DySFroMFNWJEtmZDAT3GOG0DbO6ELx68J64CMJBtm1V
         8AbexesrsiXDqm1cb4SGnVNQmYq731iVg3QyCv+/C/3h3vbtLECLlbQGqQKChCpDa2d9
         tU9Q==
X-Gm-Message-State: AOAM531k6LXWRMnIpaNVieO5qPDhLmfdiY1+OkGOGFPrmZQKuswWTKch
        x0yRLyxFIlkJLSMrrf02K3yAeQ==
X-Google-Smtp-Source: ABdhPJzTuE9TAjQU08ieN1Dl6s3PAFg07MAbn45QB1uCfx5RYCe93gt7m9EFwFWROLd0kSiun21p5g==
X-Received: by 2002:a17:902:b588:b0:161:64fe:af8c with SMTP id a8-20020a170902b58800b0016164feaf8cmr14552040pls.26.1652824120653;
        Tue, 17 May 2022 14:48:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik19-20020a170902ab1300b0015e8d4eb2ccsm73762plb.278.2022.05.17.14.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:48:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm/usercopy: Rename "heap" to "slab"
Date:   Tue, 17 May 2022 14:48:38 -0700
Message-Id: <20220517214838.878058-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3666; h=from:subject; bh=LN8v26DnF+tRW/V4fGkZeqbtRtGnjHihliWqv+vZkmg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihBg2VvyA5Kov1gcLauuPlWqWVcXe7VVhoOP+c1Pk zd02JqqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQYNgAKCRCJcvTf3G3AJrr4D/ 40cSDPakluAzCs5V7tDR+Vv5V32E27wyAUs+mDWx6vJjrcvRge1cgmpD/HYZK1J4sbtwkv8OmdcAkW YyCC+4I9F7cXneSSD4qydoB3+AdNQYC/LbxyG3b+06x6SESxizVg2AXUKe7EGqNufEYwvKPrb0W8fi GoxjrwXDBkF50IoMg1+hJathXKt4k8xuzSHSUXeMpamy7tObBaFFOiu8C+VIvD0nU27f/u21oNC2Ot STmYNHhs87c5mc/CJce0aj7Y/Wo4SVppp7yX2I/Eb1+SxGTcy8/7eDZTMe8jJATyF738pZzbNpM3JC flTERWJRugf47m6J30pXfweRK25BqCJPjDeD8fkIBQbppCdW0wPvEwYKVLwRKjWj7T3QKw6+kfPsc6 DrCC17oLKygwH8lKVRDBNPdk1z7+pfv5Umb91PnSFDojTVZfMtIZrd2bwnq4GHQoIthKGmE/xzdecr zp9S6l2eOjOUagcomzse0DYzFet6bw7UciAI+OcWeH5i7Ot4fbG1fht9TuYdHB9atWxTuJtUkZ88sw vXZOeyuPrvnZTs0fFbCawHaaTghkso0404HfxxcKGKcjH/Av0zeBypZYRvB4QZZTSXc75EsBonzzVr +cry1uprKVwuezRNqLNQGUZnintUlXJ6X9JZ9sN/Xm0N4sK/wnbiQo/c08eA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

To more clearly distinguish between the various heap types, rename the
slab tests to "slab".

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c           | 30 ++++++++++++-------------
 tools/testing/selftests/lkdtm/tests.txt |  8 +++----
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 7852b9fc7c47..945806db2a13 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -130,7 +130,7 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
  * This checks for whole-object size validation with hardened usercopy,
  * with or without usercopy whitelisting.
  */
-static void do_usercopy_heap_size(bool to_user)
+static void do_usercopy_slab_size(bool to_user)
 {
 	unsigned long user_addr;
 	unsigned char *one, *two;
@@ -196,9 +196,9 @@ static void do_usercopy_heap_size(bool to_user)
 
 /*
  * This checks for the specific whitelist window within an object. If this
- * test passes, then do_usercopy_heap_size() tests will pass too.
+ * test passes, then do_usercopy_slab_size() tests will pass too.
  */
-static void do_usercopy_heap_whitelist(bool to_user)
+static void do_usercopy_slab_whitelist(bool to_user)
 {
 	unsigned long user_alloc;
 	unsigned char *buf = NULL;
@@ -272,24 +272,24 @@ static void do_usercopy_heap_whitelist(bool to_user)
 }
 
 /* Callable tests. */
-static void lkdtm_USERCOPY_HEAP_SIZE_TO(void)
+static void lkdtm_USERCOPY_SLAB_SIZE_TO(void)
 {
-	do_usercopy_heap_size(true);
+	do_usercopy_slab_size(true);
 }
 
-static void lkdtm_USERCOPY_HEAP_SIZE_FROM(void)
+static void lkdtm_USERCOPY_SLAB_SIZE_FROM(void)
 {
-	do_usercopy_heap_size(false);
+	do_usercopy_slab_size(false);
 }
 
-static void lkdtm_USERCOPY_HEAP_WHITELIST_TO(void)
+static void lkdtm_USERCOPY_SLAB_WHITELIST_TO(void)
 {
-	do_usercopy_heap_whitelist(true);
+	do_usercopy_slab_whitelist(true);
 }
 
-static void lkdtm_USERCOPY_HEAP_WHITELIST_FROM(void)
+static void lkdtm_USERCOPY_SLAB_WHITELIST_FROM(void)
 {
-	do_usercopy_heap_whitelist(false);
+	do_usercopy_slab_whitelist(false);
 }
 
 static void lkdtm_USERCOPY_STACK_FRAME_TO(void)
@@ -358,10 +358,10 @@ void __exit lkdtm_usercopy_exit(void)
 }
 
 static struct crashtype crashtypes[] = {
-	CRASHTYPE(USERCOPY_HEAP_SIZE_TO),
-	CRASHTYPE(USERCOPY_HEAP_SIZE_FROM),
-	CRASHTYPE(USERCOPY_HEAP_WHITELIST_TO),
-	CRASHTYPE(USERCOPY_HEAP_WHITELIST_FROM),
+	CRASHTYPE(USERCOPY_SLAB_SIZE_TO),
+	CRASHTYPE(USERCOPY_SLAB_SIZE_FROM),
+	CRASHTYPE(USERCOPY_SLAB_WHITELIST_TO),
+	CRASHTYPE(USERCOPY_SLAB_WHITELIST_FROM),
 	CRASHTYPE(USERCOPY_STACK_FRAME_TO),
 	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
 	CRASHTYPE(USERCOPY_STACK_BEYOND),
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 9dace01dbf15..65e53eb0840b 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -64,10 +64,10 @@ REFCOUNT_DEC_AND_TEST_SATURATED Saturation detected: still saturated
 REFCOUNT_SUB_AND_TEST_SATURATED Saturation detected: still saturated
 #REFCOUNT_TIMING timing only
 #ATOMIC_TIMING timing only
-USERCOPY_HEAP_SIZE_TO
-USERCOPY_HEAP_SIZE_FROM
-USERCOPY_HEAP_WHITELIST_TO
-USERCOPY_HEAP_WHITELIST_FROM
+USERCOPY_SLAB_SIZE_TO
+USERCOPY_SLAB_SIZE_FROM
+USERCOPY_SLAB_WHITELIST_TO
+USERCOPY_SLAB_WHITELIST_FROM
 USERCOPY_STACK_FRAME_TO
 USERCOPY_STACK_FRAME_FROM
 USERCOPY_STACK_BEYOND
-- 
2.32.0

