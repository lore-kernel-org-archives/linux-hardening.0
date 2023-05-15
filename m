Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33E5C7EE22
	for <linux-hardening@archiver.kernel.org>; Mon, 15 May 2023 13:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbjEONGs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 May 2023 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbjEONGg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 May 2023 09:06:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D5213E
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 06:06:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab032d9266so117727465ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 06:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684155962; x=1686747962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQS98FLuUxt8kfip9Nk8O1hVfeuWAt0sl7+06c/6tso=;
        b=lVLtpSynI8nMT2aDpFG0AwTYGHG10mCOzf2uMVGaztPOf63EnxTkd4eJJVNqJlr8C5
         g4595V6nKOPML2z8/lcW1UhNkQhkCyXDVgAutORAhmXktQaBwlD2yr8BPgV8UP/5LyyG
         byJlw9BmRMYbGWCADO6h/aSqv0KiIADjBwCC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155962; x=1686747962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQS98FLuUxt8kfip9Nk8O1hVfeuWAt0sl7+06c/6tso=;
        b=bI9B4t+0LIXD9DQkTZvTdsQnIMDOnd1QjaAK7bwQH4oDzOgSygl8i49HI0xG2RipZm
         nFq9Tru5/xnC9Qk0SH1qRKi/WMIOuCXfTa4Z2YdfVWYShoIzQrqdRjvD5steVQk67V5Y
         FPEZr392T36VVSdTwDLdpX8tKzHQ4KuI1kHIdjk06idyj2zV3yFgHH+2RYGsoZyivsTO
         0kaPz2oEiJN6x6sLVycvbHJfdhEOaQs1jWGG8m67He+qGmLcnZR70lP9KDg0DQf2DHOg
         qX6DR5/Sn+iwr/GcGP4eSas1pVYD7yOebS5vsCPn75CZl5Y0I+BQIkiguFIX/ClO5lPq
         L+nQ==
X-Gm-Message-State: AC+VfDxuCXvcP2rfrH31h9xpewRiioILe2tE9aooj2QxsLYBox/vp5lK
        6a6g04LfcdtGtaZCYS+6QUNBVQ==
X-Google-Smtp-Source: ACHHUZ5LvI01D49NaxlHJHiG9oq5TunRXuf9uX9R4zcylWjAPhk6R7RxfjFf6bkyuvAy6sflWATEYg==
X-Received: by 2002:a17:902:788d:b0:1ac:8215:623d with SMTP id q13-20020a170902788d00b001ac8215623dmr24516585pll.0.1684155961805;
        Mon, 15 May 2023 06:06:01 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id nn4-20020a17090b38c400b0024df7d7c35esm1095703pjb.43.2023.05.15.06.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:06:01 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/6] PKEY: Add arch_check_pkey_enforce_api()
Date:   Mon, 15 May 2023 13:05:48 +0000
Message-ID: <20230515130553.2311248-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515130553.2311248-1-jeffxu@chromium.org>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This patch adds an architecture-independent function,
arch_check_pkey_enforce_api(), that checks whether the calling thread
has write access to the PKRU for a given range of memory. If the
memory range is protected by PKEY_ENFORCE_API, then the thread must
have write access to the PKRU in order to make changes to the memory
mapping (such as mprotect/munmap).

This function is used by the kernel to enforce the
PKEY_ENFORCE_API flag.

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 arch/powerpc/include/asm/pkeys.h |  8 +++++
 arch/x86/include/asm/pkeys.h     | 50 ++++++++++++++++++++++++++++++++
 include/linux/pkeys.h            |  9 ++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 943333ac0fee..24c481e5e95b 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -177,5 +177,13 @@ static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
 	return true;
 }
 
+static inline int arch_check_pkey_enforce_api(struct mm_struct *mm,
+					      unsigned long start,
+					      unsigned long end)
+{
+	/* Allow by default */
+	return 0;
+}
+
 extern void pkey_mm_init(struct mm_struct *mm);
 #endif /*_ASM_POWERPC_KEYS_H */
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index ecadf04a8251..8b94ffc4ca32 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -161,4 +161,54 @@ static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
 
 	return true;
 }
+
+static inline int __arch_check_vma_pkey_for_write(struct vm_area_struct *vma)
+{
+	int pkey = vma_pkey(vma);
+
+	if (mm_pkey_enforce_api(vma->vm_mm, pkey)) {
+		if (!__pkru_allows_write(read_pkru(), pkey))
+			return -EACCES;
+	}
+
+	return 0;
+}
+
+/*
+ * arch_check_pkey_enforce_api is used by the kernel to enforce
+ * PKEY_ENFORCE_API flag.
+ * It checks whether the calling thread  has write access to the PKRU
+ * for a given range of memory. If the  memory range is protected by
+ * PKEY_ENFORCE_API, then the thread must  have write access to the
+ * PKRU in order to make changes to the memory  mapping, such as
+ * mprotect/munmap.
+ */
+static inline int arch_check_pkey_enforce_api(struct mm_struct *mm,
+					      unsigned long start,
+					      unsigned long end)
+{
+	int error;
+	struct vm_area_struct *vma;
+
+	if (!arch_pkeys_enabled())
+		return 0;
+
+	while (true) {
+		vma = find_vma_intersection(mm, start, end);
+		if (!vma)
+			break;
+
+		error = __arch_check_vma_pkey_for_write(vma);
+		if (error)
+			return error;
+
+		if (vma->vm_end >= end)
+			break;
+
+		start = vma->vm_end;
+	}
+
+	return 0;
+}
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 81a482c3e051..7b00689e1c24 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -53,6 +53,15 @@ static inline bool arch_check_pkey_alloc_flags(unsigned long flags)
 		return false;
 	return true;
 }
+
+static inline int arch_check_pkey_enforce_api(struct mm_struct *mm,
+					      unsigned long start,
+					      unsigned long end)
+{
+	// Allow by default.
+	return 0;
+}
+
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 #endif /* _LINUX_PKEYS_H */
-- 
2.40.1.606.ga4b1b128d6-goog

