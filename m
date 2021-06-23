Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC70AC49EA7
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B191A610C7
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Jun 2021 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFWUmM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFWUmK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC47C061283
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b3so1793369plg.2
        for <linux-hardening@vger.kernel.org>; Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CbW/Yfm4YOVx5TLgcAG255DFJHXdYOCCgKp2CMgl9c=;
        b=dunBoi+rvP55ibjO4aMmp3PEcqi6plGzD3RKUIy2JY6icM4NLoCwMdjkH3bSpJGEZL
         rXBy87J/BsJRIb8BKC6N9nIa5pdSEtVsj9Jt2Eu2c7ibgdf7VysPOSGq2GGofBeJdmkV
         iHok836cmLjkdFjQnvhcnR9i+SLiV5yPdY7UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CbW/Yfm4YOVx5TLgcAG255DFJHXdYOCCgKp2CMgl9c=;
        b=pLMHdsOi6J7wFbsQFqD3Y4p/dn/UKI8hWdXO6TTcGC+E9kzvyXpVMCtWf6KRrbdt2f
         uPbMbHVx0UFtrWS4YTQO3163XJjDOs12TDuhZGigMJs2JJhhjSJRZ1HIkOt2yP+cDEEE
         9BQ5sx5aYX+3WmxtlFh1RnZR7UVYStbBuwn3NdUjCOVnuWzOtIB2Ch+egPxYOOmvA+EX
         5inDfZE7ViFXE7FR0FTVLkUxjaVAycCJmbr/WMhBy2V1G/cihwpoBx/JtHR/HB/tPdYI
         /i271LnmZ2VcmOCldbdNtXNn4pzFHJM5QiNAhhEFl11oVhhynhCUHX52KwSWQuw4Vw/F
         L5oA==
X-Gm-Message-State: AOAM532KxkaRhqCh5+hDDIzKeNqHbG6AsSzi28l39CVQHleY0IaNiWTg
        FNM189nSpZ99gmiPxu0c4kKXZg==
X-Google-Smtp-Source: ABdhPJwt4bDW3fWxEAD6L43dOhtIQeD8GcbmXS575cFZ1n3sB6Aw0rEr0X01RYvfSmd5imUhk+B7Xw==
X-Received: by 2002:a17:90a:4410:: with SMTP id s16mr1427889pjg.25.1624480791179;
        Wed, 23 Jun 2021 13:39:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u1sm630574pfu.160.2021.06.23.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 9/9] lkdtm/heap: Add init_on_alloc tests
Date:   Wed, 23 Jun 2021 13:39:36 -0700
Message-Id: <20210623203936.3151093-10-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4448; h=from:subject; bh=kzB2kajsXBcnoqdrRcymGnm8fdce7wFUEweva8HvKLM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wH5VR4lDW7Qn91KFyY0Hf6dSvabN6SXZM7fu6f PsdQeJCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBwAKCRCJcvTf3G3AJrtiEA CoREcu/vUQ2ed0GVO1Y3dypJDMih0UI4I5eduqeIitcrzItlcyUt0VyMnXcja+eI5KhvKJre/DEV6N JAmsX7/8fMHcIlJvDAVMxb5mzgFTyAQcwIOMVW9W+3r+UUHZS6kGdX0In5GjM0oGTDphSkDw7LVQbY wxTSCuoFvaX6JGRwtwTKCmf0yOxkYuSUmjJHP3vbzw8rycqrSTvpffy2vHVdG5lfncP2QvUbJhkroR YqXt+Y08bdkpdIS99ztaIPadsdcCWvdRG1KoGTSmnFHwfm11MhRoZPD2AzUKCn99c2adU25UgJoQQu IfWiqZ/0JUuO4YJACqa63gUv3lttKXM6Y0RLOyzPSZrdfG6fMJRbyK2BDNNBneDaeJOogvG+FWcLkT yX9ISCyG4xyhfgsPYQ37Dzftv2T9rWsCzn6IQbFefHbwjFbUTlG27if6rc8uiaQbPCh7g50faN26Kq OSqEkA5KwA251CpX+KiNd2JlxtXfTFtnSQKbVawsGGExVvDlLeuE+uZU9gps0EYtL4Rx8vGAiCMyOM 7kaI1WNW2RzpRc+2bK5fHt8rVn0HI3LFcHoX2pTX1ee//VbjPmF4EWsZsI7fVrgoTto7tM+Z+mOTU4 aF8WROfsOAjSNjtvkwi9P3oHmKdtILwXEN+5HFG/zWLAj0/J+i31bg6ZSiig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add SLAB and page allocator tests for init_on_alloc. Testing for
init_on_free was already happening via the poisoning tests.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/core.c               |  2 +
 drivers/misc/lkdtm/heap.c               | 65 +++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h              |  2 +
 tools/testing/selftests/lkdtm/config    |  1 +
 tools/testing/selftests/lkdtm/tests.txt |  2 +
 5 files changed, 72 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index c185ae4719c3..9dda87c6b54a 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -127,6 +127,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(READ_AFTER_FREE),
 	CRASHTYPE(WRITE_BUDDY_AFTER_FREE),
 	CRASHTYPE(READ_BUDDY_AFTER_FREE),
+	CRASHTYPE(SLAB_INIT_ON_ALLOC),
+	CRASHTYPE(BUDDY_INIT_ON_ALLOC),
 	CRASHTYPE(SLAB_FREE_DOUBLE),
 	CRASHTYPE(SLAB_FREE_CROSS),
 	CRASHTYPE(SLAB_FREE_PAGE),
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index a3bb0577ed8b..3d9aae5821a0 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -174,6 +174,71 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void)
 	kfree(val);
 }
 
+void lkdtm_SLAB_INIT_ON_ALLOC(void)
+{
+	u8 *first;
+	u8 *val;
+
+	first = kmalloc(512, GFP_KERNEL);
+	if (!first) {
+		pr_info("Unable to allocate 512 bytes the first time.\n");
+		return;
+	}
+
+	memset(first, 0xAB, 512);
+	kfree(first);
+
+	val = kmalloc(512, GFP_KERNEL);
+	if (!val) {
+		pr_info("Unable to allocate 512 bytes the second time.\n");
+		return;
+	}
+	if (val != first) {
+		pr_warn("Reallocation missed clobbered memory.\n");
+	}
+
+	if (memchr(val, 0xAB, 512) == NULL) {
+		pr_info("Memory appears initialized (%x, no earlier values)\n", *val);
+	} else {
+		pr_err("FAIL: Slab was not initialized\n");
+		pr_expected_config_param(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, "init_on_alloc");
+	}
+	kfree(val);
+}
+
+void lkdtm_BUDDY_INIT_ON_ALLOC(void)
+{
+	u8 *first;
+	u8 *val;
+
+	first = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!first) {
+		pr_info("Unable to allocate first free page\n");
+		return;
+	}
+
+	memset(first, 0xAB, PAGE_SIZE);
+	free_page((unsigned long)first);
+
+	val = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!val) {
+		pr_info("Unable to allocate second free page\n");
+		return;
+	}
+
+	if (val != first) {
+		pr_warn("Reallocation missed clobbered memory.\n");
+	}
+
+	if (memchr(val, 0xAB, PAGE_SIZE) == NULL) {
+		pr_info("Memory appears initialized (%x, no earlier values)\n", *val);
+	} else {
+		pr_err("FAIL: Slab was not initialized\n");
+		pr_expected_config_param(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, "init_on_alloc");
+	}
+	free_page((unsigned long)val);
+}
+
 void lkdtm_SLAB_FREE_DOUBLE(void)
 {
 	int *val;
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index e491bc571808..6a30b60519f3 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -86,6 +86,8 @@ void lkdtm_WRITE_AFTER_FREE(void);
 void lkdtm_READ_AFTER_FREE(void);
 void lkdtm_WRITE_BUDDY_AFTER_FREE(void);
 void lkdtm_READ_BUDDY_AFTER_FREE(void);
+void lkdtm_SLAB_INIT_ON_ALLOC(void);
+void lkdtm_BUDDY_INIT_ON_ALLOC(void);
 void lkdtm_SLAB_FREE_DOUBLE(void);
 void lkdtm_SLAB_FREE_CROSS(void);
 void lkdtm_SLAB_FREE_PAGE(void);
diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 849799bcfa95..013446e87f1f 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -5,3 +5,4 @@ CONFIG_FORTIFY_SOURCE=y
 CONFIG_HARDENED_USERCOPY=y
 # CONFIG_HARDENED_USERCOPY_FALLBACK is not set
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
+CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 30080cc15623..846cfd508d3c 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -21,6 +21,8 @@ VMALLOC_LINEAR_OVERFLOW
 READ_AFTER_FREE call trace:|Memory correctly poisoned
 #WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
 READ_BUDDY_AFTER_FREE call trace:|Memory correctly poisoned
+SLAB_INIT_ON_ALLOC Memory appears initialized
+BUDDY_INIT_ON_ALLOC Memory appears initialized
 SLAB_FREE_DOUBLE
 SLAB_FREE_CROSS
 SLAB_FREE_PAGE
-- 
2.30.2

