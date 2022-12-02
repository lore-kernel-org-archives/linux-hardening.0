Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DF9C3A5A7
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 01:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLBBfp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiLBBfn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 20:35:43 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECAAD2DAC
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 17:35:42 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k7so3324353pll.6
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 17:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKvOSTS2b6VDSFBkCr00yngSZIwFKUNQNHkXo09hZmA=;
        b=UItq22eTvou88l9SCVXNaNsYoaOY9tw3+2M7EbNGiX2xZq2K//Xz1mtQHjpjfA/i1u
         Fy5TVWpp7cRYhpc6qBj0wqXiQH0GmOtyo0/xiEzUgNrylUsAkDT59VZVha/4ZqUcQAZc
         42UGiUeVciD+24zLL+Vawl2Fhzu21OK6hqpvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKvOSTS2b6VDSFBkCr00yngSZIwFKUNQNHkXo09hZmA=;
        b=JX0VVRuPMgxkc1gjRPNcdpte/yWdxGSnCqvmP8eIwcCKda1sNqeHL4xNLUqKbZWuag
         m0Sikd71HOdMiYJhHzfQUMN1IjcGhqOq6iyCcHkgTvdOYyWf8X9AJFZAWejQ6nsSMVWM
         oiRZCyOcYFjsnlvsaSjGb/hMH74MaUKLEmP0zxvRYF/JpNdv6CdWXHqBFd4svh0Wiq0r
         +/uBquR5VkGK+paHf6NT0VvfJSp9GTrFKJwCO64myenYDEMCPQYWr1P1EEmaxErkwwlz
         wt5wPjbepd1yd+oxPw91iqutDFsekGPW3wGsld9Nv8KKrcI6koHvI236EFbFr/VcGQeN
         h8bA==
X-Gm-Message-State: ANoB5pmNa3wLFREwxB3MqoYzDUhTHMK9LcgQ46TdUbvK5oFKwXW7Dxs4
        8vhkj/IYPygIyOG4u4yfv9xTbg==
X-Google-Smtp-Source: AA0mqf5bHzwa/ElDZCKIpK/4+xmNfX+iN1A4igcHuqUWIpmUT6iLMCmjQf7z8hzdyxTwbQ9xG+E2dw==
X-Received: by 2002:a17:902:bf01:b0:186:8bca:1d50 with SMTP id bi1-20020a170902bf0100b001868bca1d50mr51764880plb.158.1669944942307;
        Thu, 01 Dec 2022 17:35:42 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id s13-20020a65690d000000b00477fb27eaddsm3074241pgq.63.2022.12.01.17.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:35:41 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3] mm/memfd: add F_SEAL_EXEC
Date:   Fri,  2 Dec 2022 01:33:59 +0000
Message-Id: <20221202013404.163143-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221202013404.163143-1-jeffxu@google.com>
References: <20221202013404.163143-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Daniel Verkamp <dverkamp@chromium.org>

The new F_SEAL_EXEC flag will prevent modification of the exec bits:
written as traditional octal mask, 0111, or as named flags, S_IXUSR |
S_IXGRP | S_IXOTH. Any chmod(2) or similar call that attempts to modify
any of these bits after the seal is applied will fail with errno EPERM.

This will preserve the execute bits as they are at the time of sealing,
so the memfd will become either permanently executable or permanently
un-executable.

Co-developed-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 include/uapi/linux/fcntl.h | 1 +
 mm/memfd.c                 | 2 ++
 mm/shmem.c                 | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..e8c07da58c9f 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,7 @@
 #define F_SEAL_GROW	0x0004	/* prevent file from growing */
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
+#define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 08f5f8304746..4ebeab94aa74 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -147,6 +147,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 }
 
 #define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_EXEC | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
 		     F_SEAL_WRITE | \
@@ -175,6 +176,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 	 *   SEAL_SHRINK: Prevent the file from shrinking
 	 *   SEAL_GROW: Prevent the file from growing
 	 *   SEAL_WRITE: Prevent write access to the file
+	 *   SEAL_EXEC: Prevent modification of the exec bits in the file mode
 	 *
 	 * As we don't require any trust relationship between two parties, we
 	 * must prevent seals from being removed. Therefore, sealing a file
diff --git a/mm/shmem.c b/mm/shmem.c
index c1d8b8a1aa3b..e18a9cf9d937 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1085,6 +1085,12 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 	if (error)
 		return error;
 
+	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
+		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
+			return -EPERM;
+		}
+	}
+
 	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

