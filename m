Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12280C4320E
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8857610CF
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 17:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhHRRto (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhHRRtn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 13:49:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F641C0617A8
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 18so2907724pfh.9
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VAhCQA3MkM6rsCTMJO3M3k3MNEZtb/Tb2JXEPR3wc8=;
        b=SNCXq/5oc+O/tePHpiIlGQK1Jx7CqAUD8e5IdHI683aauQpDfGujbae9TjWFhkU046
         rLBkgjvQvx/rHbQXy9+zJe3cKrHceKrSA2AvGMxpnpE5p7VwcgX7ak86HeWswH40YbTw
         G64ACPxE1o2scPWySFI7B8j/z0C8bzgR+gr6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VAhCQA3MkM6rsCTMJO3M3k3MNEZtb/Tb2JXEPR3wc8=;
        b=ngUseS/ix7FPll+s30XjbFNM3uIfs6ncUww1SGprSfnTlZUMHD3z6dF4OYdx9O4HAz
         qMYpyhPfsh/9Ia1pMXtHAOhy4g7/+ZmLF2UnyPYj2JUA/+FTSp7eIKst44zHIiRFJ16T
         LTH6AEfovAuK2NoZFrZDumyXbBmEB/afTa6UmmUsP+w7YfpEAC0AY+Ej0WHFVuCRJ9k9
         hnzaDCgus/Z1g9k7SuWV2NkIVHjJgjhSTC5k+BTCfR1VFpL5GmR/8Mn5AiGsWDxrM90G
         ujeI4iSmDqA8Jgg/3a6GoJgRKCbmHfGe8k1oR+iQydhGt898I0Dt3gXSvdvMdaWmSBQc
         AdDw==
X-Gm-Message-State: AOAM531ghSW4Old8BskmQWIiG7pt1VpFnpj+7fsWF7XNfkW/FtGPd/7K
        BDFAedECcVZEfn2T2dip0JgDZg==
X-Google-Smtp-Source: ABdhPJzWo9rtC4QhANM5t54ZDvpGyVJ01qR9Trm8ucGnt71I36aBkBxsezedVbtcTSSr5oPNubf9dQ==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr9989573pgk.231.1629308938931;
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm5784525pjq.10.2021.08.18.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        linux-kernel@vger.kernel.org, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 4/4] lkdtm/heap: Avoid __alloc_size hint warning for VMALLOC_LINEAR_OVERFLOW
Date:   Wed, 18 Aug 2021 10:48:55 -0700
Message-Id: <20210818174855.2307828-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818174855.2307828-1-keescook@chromium.org>
References: <20210818174855.2307828-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; h=from:subject; bh=hEHwsjZSD/SYU1VoaQ5mTXOJ9xQG9V/0cWsn/qe6UfM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHUgGBUS/d6eL8MtIKgEouR7CqPpSrnry2WnQbOoB MJRkKMuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1IBgAKCRCJcvTf3G3AJq2QEA CYtjA8ExIWPk7JvqRI/61/kE99RMnZcDBn7KzqjP0m7JW5yqwlWBUMIz+ye1hV21EL2F5arOPH8BvR 3V9TjF+7swg9wtnWeIWdkurG6SE0wnSv9XECt+FpJzNKxsa9TsUw9OzP94iXOX0lhLJtiS5hbbDzvm 1xWlOJh9WnUVQVNHoQ0SWthtBbKyUGXh/xmr3ASedX9L6Ue100evlIwHgSaY4HK18yKW2oxesg9vRq 2nfod7QFT4T2wsrMrNBcPKnaillIzxm4xYIHVZ64iXPKFsSoxJAppeZ25QJS8u431AEsh7QC1vzUHN mYYvmqS5lBlfI4JWTTS2kh/l+646Yw6u2XmBhYm/auAnyQo6Y7uDXi4YZ0qxInN+fMocEm6/SG2Ts0 q+eQTj7eahrc7dPrq34ZqReM3Anssp+dl3jbBZ4qlHzyoL8i4QUkwHKBalsUDUu0AXanwZvIuUpVRE Xspwci5AKkP3cZFW92NW3seSikRnhZFP+SnAUf9FouV5pMfGgDfGEtAe+KcNGwOiaWjjArhEqeIHzt fiQFAZHI6CJUhJ+OdyXbeFfQfR/d0PG0GUn67vyUiVMF6oqs24HnZ7vRHm5paxs7yDRBfvhx+RD1sk 77kNe3nsroN6hhYbzbAgtAbYjR89fEwFvL1eLnnR4NI6p2wq7155My+YT1IA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Once __alloc_size hints have been added, the compiler will (correctly!)
see this as an overflow. We are, however, trying to test for this
condition at run-time (not compile-time), so work around it with a
volatile int offset.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/heap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 3d9aae5821a0..8a92f5a800fa 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -12,6 +12,13 @@ static struct kmem_cache *double_free_cache;
 static struct kmem_cache *a_cache;
 static struct kmem_cache *b_cache;
 
+/*
+ * Using volatile here means the compiler cannot ever make assumptions
+ * about this value. This means compile-time length checks involving
+ * this variable cannot be performed; only run-time checks.
+ */
+static volatile int __offset = 1;
+
 /*
  * If there aren't guard pages, it's likely that a consecutive allocation will
  * let us overflow into the second allocation without overwriting something real.
@@ -24,7 +31,7 @@ void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
 	two = vzalloc(PAGE_SIZE);
 
 	pr_info("Attempting vmalloc linear overflow ...\n");
-	memset(one, 0xAA, PAGE_SIZE + 1);
+	memset(one, 0xAA, PAGE_SIZE + __offset);
 
 	vfree(two);
 	vfree(one);
-- 
2.30.2

