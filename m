Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C1C7EE2C
	for <linux-hardening@archiver.kernel.org>; Mon, 15 May 2023 13:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbjEONGt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 May 2023 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242196AbjEONGh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 May 2023 09:06:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF07E269E
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 06:06:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab267e3528so90728475ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 06:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684155963; x=1686747963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ujRp+fUzXaEUmgqKvUj1r8AuZXVhmdz7uVnxDSzpYA=;
        b=Rt5yYfm0CK8EUUQDrYdxuqMd3n+YNkZzNsjoe7Sh2TMU94iFWNQ9XbZV1szPVs7im8
         +tqDWyCl21fUMShhLNa9cxw1wcdjPBpuZrvT2b9Xhnfk8Tltierjd6QqsJqZl2irCBNZ
         75n9PT1i0yFsyihOnR4+Se6E/rdRMjFhTYgCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155963; x=1686747963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ujRp+fUzXaEUmgqKvUj1r8AuZXVhmdz7uVnxDSzpYA=;
        b=XDFeREzZcKk+YtrSg2cSULsjZHwyIgBHEKy43fQ9cA4d/DIlx1MqoZ/8mF+etvEw47
         hsULJurSFNqLNx93WGG/EWaidoBiUoGzMURTqVnLCpLHlwHOAOWRdSa+n8uZ9QIumkRz
         P8guMomm/rEjbESEY16n/eg2veDEWB4RU25c4gvUSnNhvgGst8jrGERtSKgq7Z5456+X
         RKysfXtA7w6vT2F/O0TlTi0gvT7OYP1ULvrhorUlgxOQtBURobnUJwaV9MlPE3rsTBa2
         Z6s/NkIOWiQ4atgLaYL5HFKzSRgvHxaAT8PnTGC0kK9Fu94NvT80BzYyVNt073epRPKx
         +ljQ==
X-Gm-Message-State: AC+VfDwDz53ssZcILu4QnRut6cjS+WR39ivW8ZGz40oQ4TPljLsghFyp
        qaJ/4GuzvyKhyvT9ohZGSlwHDg==
X-Google-Smtp-Source: ACHHUZ6kGDKbByWmlumIW033viVHhT0CSCqBtVBlJ4yzye+I6JDMWWkia59K77zKHw/c/xUVQ4KIpw==
X-Received: by 2002:a17:902:ce84:b0:1ac:a030:c30a with SMTP id f4-20020a170902ce8400b001aca030c30amr28883712plg.19.1684155962938;
        Mon, 15 May 2023 06:06:02 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id i2-20020a170902c94200b001a988a71617sm13474160pla.192.2023.05.15.06.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:06:02 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
Date:   Mon, 15 May 2023 13:05:49 +0000
Message-ID: <20230515130553.2311248-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515130553.2311248-1-jeffxu@chromium.org>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
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
 mm/mprotect.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8a68fdca8487..1378be50567d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -727,9 +727,13 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 
 /*
  * pkey==-1 when doing a legacy mprotect()
+ * syscall==true if this is called by syscall from userspace.
+ * Note: this is always true for now, added as a reminder in case that
+ * do_mprotect_pkey is called directly by kernel in the future.
+ * Also it is consistent with __do_munmap().
  */
 static int do_mprotect_pkey(unsigned long start, size_t len,
-		unsigned long prot, int pkey)
+		unsigned long prot, int pkey, bool syscall)
 {
 	unsigned long nstart, end, tmp, reqprot;
 	struct vm_area_struct *vma, *prev;
@@ -794,6 +798,21 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+	/*
+	 * When called by syscall from userspace, check if the calling
+	 * thread has the PKEY permission to modify the memory mapping.
+	 */
+	if (syscall &&
+	    arch_check_pkey_enforce_api(current->mm, start, end) < 0) {
+		char comm[TASK_COMM_LEN];
+
+		pr_warn_ratelimited(
+			"munmap was denied on PKEY_ENFORCE_API memory, pid=%d '%s'\n",
+			task_pid_nr(current), get_task_comm(comm, current));
+		error = -EACCES;
+		goto out;
+	}
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
@@ -878,7 +897,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot)
 {
-	return do_mprotect_pkey(start, len, prot, -1);
+	return do_mprotect_pkey(start, len, prot, -1, true);
 }
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -886,7 +905,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot, int, pkey)
 {
-	return do_mprotect_pkey(start, len, prot, pkey);
+	return do_mprotect_pkey(start, len, prot, pkey, true);
 }
 
 SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
-- 
2.40.1.606.ga4b1b128d6-goog

