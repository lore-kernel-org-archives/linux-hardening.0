Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE7FC7EE32
	for <linux-hardening@archiver.kernel.org>; Fri, 19 May 2023 01:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjESBTf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 May 2023 21:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjESBTb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 May 2023 21:19:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F94E4C
        for <linux-hardening@vger.kernel.org>; Thu, 18 May 2023 18:19:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64384c6797eso2123266b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 18 May 2023 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684459169; x=1687051169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlYfhs3BTQ2EJ5c00OoF7xAAokRQfPc4lQTpfzHm9OE=;
        b=JWIfslA4UKDBw1Mp583btzlGGK8G9E6xpS7M8yt3iOyE0agyVlu+KO5Lxq4vpucXSU
         HH1YA4BQeb7OL6OLVkoix4UxlcxXNVOrDy2c5gWBw82vyYqfMb8tY9sDkBb9j+Na0b8j
         0kO3Cd+a0jrUOyQcvN7J2vDvvbkTYN/CiGCqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684459169; x=1687051169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlYfhs3BTQ2EJ5c00OoF7xAAokRQfPc4lQTpfzHm9OE=;
        b=aPQJECkOx4lF6hs9USwZYMyo2Y3hn7JSnB/9+kbijcIo7ndb26mDfZk1RETJcu2TXw
         jJG6+4Ge8PEmiEgRN5eIQ4cuh4H8776V61J+ItVzw4Uql3thuSnt2M3ehGCKMC82QtX7
         +Gd5g9kvpWh8ZYwm86lPkW3RUpTQ1GZ/p60hYLHbpnicS56Sm3zrkaa53/EqMK3xSZff
         J4jKiUcRxFEO+Sg3flPr7Ru3vtjMmKMa+RXnAj09HNdtKF0n2JVBLVb6XF891YZM/47J
         bxo9Fh9gJAuJdOejhb9R6NwIshx/P621ImQTr/JYaGPWHpniEpKU+tmkSDlaBEOMOVxG
         U5dA==
X-Gm-Message-State: AC+VfDzWjznMEs0G7G5DeWXFrvVPCRMm4K5yEfUu0YoYhjUGdFCx1ty6
        24GiXkoPLqGjU81csaVRCpoEcA==
X-Google-Smtp-Source: ACHHUZ65BMUPG6NH0sSEE5yDD+qKd1DPXj0Iug+5r1nNE9fAXNvkKS48swgrqtg3LFDKz96p8HSxUA==
X-Received: by 2002:a05:6a20:8422:b0:ef:205f:8184 with SMTP id c34-20020a056a20842200b000ef205f8184mr425525pzd.13.1684459169739;
        Thu, 18 May 2023 18:19:29 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id c24-20020a62e818000000b00643864d03dfsm1960424pfi.171.2023.05.18.18.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:19:29 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v1 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
Date:   Fri, 19 May 2023 01:19:11 +0000
Message-ID: <20230519011915.846407-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519011915.846407-1-jeffxu@chromium.org>
References: <20230519011915.846407-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This patch enables PKEY_ENFORCE_API for the mprotect and
mprotect_pkey syscalls.

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 mm/mprotect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8a68fdca8487..1db30b8baac3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -794,6 +794,17 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	/*
+	 * arch_check_pkey_enforce_api checks if current thread
+	 * has the PKEY permission to modify the memory mapping.
+	 * Note: this should only apply to the cases that do_mprotect_pkey
+	 * is called from syscall entry. Ref. to munmap for other cases.
+	 */
+	if (arch_check_pkey_enforce_api(current->mm, start, end) < 0) {
+		error = -EACCES;
+		goto out;
+	}
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-- 
2.40.1.606.ga4b1b128d6-goog

