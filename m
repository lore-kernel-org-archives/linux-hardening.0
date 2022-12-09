Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36CFC4708E
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Dec 2022 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLIQFF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Dec 2022 11:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLIQFC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Dec 2022 11:05:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E551324
        for <linux-hardening@vger.kernel.org>; Fri,  9 Dec 2022 08:05:01 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 142so3826513pga.1
        for <linux-hardening@vger.kernel.org>; Fri, 09 Dec 2022 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z0pNLRJ0HO6mEsQsP4xR7y3AzecdWz1BUkrTkkGBPM=;
        b=NKb1GAp4o6SR8RAwURjuFDuN+zxhqHMcW5ssGhcZ+DU+PFAx+LUcL7yPaq/lio2rqx
         gsbeokPy4gQONsYdB+99EBxJJNsHClsPC4BjpU3IrUyEzRti9qGuEoFDz7cNCZF8sD6t
         PVp5eg0FzAb2GvkkjoCUfSPMbbq/LQxGCDCUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z0pNLRJ0HO6mEsQsP4xR7y3AzecdWz1BUkrTkkGBPM=;
        b=MDdX8ONE5NvJNsrAIa56mIp2CqGkdrjOVO1dVGiFr1+kx8dEq+CUH0LBE6unmAp9f0
         aQlKqBeHc5+WDb5Dp/f1wtHMAAxXZoHyiw/VoZawzPTR75QUn5JRKFn66Ul6+Z+kF7g5
         QCx9M7Sg/QjlsGidtOygv3mZy7PAfXGPQvcIPC9pKW7574+zbsFaz/pMPMhbXKr25tqA
         cQkVsWbvH3ZzluZKpw+GF46r0GQb9pNhyD8dm5nBlURyDhht+ZkSzNHKut7rPr1er5iB
         EK6CmsLIa3CGUGQvpKz2wYBxSRJpSAw3OAwlLi3vclmFW7vh11DXuQulJpHBVniun9/7
         vVLA==
X-Gm-Message-State: ANoB5pllj85LmB3ywoz4e3PpHXSeTs2Mm+Aj4VWKnuloMeSjXfZXEZOQ
        +jtf+/Gi/lpAsWoyfvjC3rk9qA==
X-Google-Smtp-Source: AA0mqf5BhSaI4B1HavFtMOzgaozxUp8kZMp6B4wPBmpQlZhHLUVPz4Q5h2MTnqDgyswRXpmM2N7lIQ==
X-Received: by 2002:a62:870d:0:b0:576:f02e:d0ef with SMTP id i13-20020a62870d000000b00576f02ed0efmr5609008pfe.4.1670601900690;
        Fri, 09 Dec 2022 08:05:00 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a15-20020aa795af000000b00576670cc170sm1460504pfk.93.2022.12.09.08.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:05:00 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v7 1/6] mm/memfd: add F_SEAL_EXEC
Date:   Fri,  9 Dec 2022 16:04:48 +0000
Message-Id: <20221209160453.3246150-2-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209160453.3246150-1-jeffxu@google.com>
References: <20221209160453.3246150-1-jeffxu@google.com>
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

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Co-developed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
2.39.0.rc1.256.g54fd8350bd-goog

