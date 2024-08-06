Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CD16F824
	for <linux-hardening@vger.kernel.org>; Tue,  6 Aug 2024 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980981; cv=none; b=aJR/9J/tNKF94MVUy2Rn+YHa7Kq7eceyu6bac6Cy0r3ZcKneVa26p2o1IhHq4S8NoTjyLJLvOIW6f60wDDEgM7NKMr1pzJ35q1yjewdN0yv6OUEJD6GDAK49Md9E8UnSg6ZSawzB4aaKg9Raq+yJACnU8J6Thur4cf2MTWeRqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980981; c=relaxed/simple;
	bh=8qoQAfw+S/BqrZ655ssfoOu1yM4rBw2R1ToXpjPzEpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pw3AaJB0WB1u6Clo+v/zyusX0lkOyRIr4R3bDKIcD98qoDdNgIqOx4rTpYGJLuf1sJto11EbfVZWLg3a0a1go56+8xfPFHWdGobzkW1XAoCX/ob/ohnr8Mw5fDSc8G02o8LGtX5M/G+pvnQuOvSWXjS/txjwrOt6hdr68IC1tA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TFfRWvWu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFfRWvWu"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cfec641429so930190a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 06 Aug 2024 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722980980; x=1723585780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sha3HMsUUnd+rWOJjoYfnPxcq+K0fuD2wUT+1pcBfNI=;
        b=TFfRWvWumEkj22CJfHNF9L6fMsOtjiuNxPxSpdDUPoiDhYxigNWQonaGS5yWezIOH6
         iBGp7nRz92ZB0iptK+bOAoPafGlCg4G4RtEoC2JSlDcDJWXc0F+HNfguTZ353NGtR55Q
         +CWKy+x2j1dHRUgCRMfaeI3899lGmLmCK2OGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980980; x=1723585780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sha3HMsUUnd+rWOJjoYfnPxcq+K0fuD2wUT+1pcBfNI=;
        b=BW11Atwe49H4wy6qG7nJ6xt3ybxPNekjA5LBCtoAZ/jaz27+HYGvWLc5c/rhyO4Gi6
         bUSi8RiB35LpcZAGmnbGOU97nR4f6tFY8JXxRbG4NZa/aHeIssGVLnlHbFV78B9K0O49
         tpvuWNlbaH5/OptRS1BJCWqF0D7q7xtW11QV0KqFQ1DB7ay+YqdSsqhNJ23LwBcz7+h7
         Po6CadGL7NWLVqPSl4vfl2EmT8cBUB0jlF5/BtEF//WSkJh2Q+CJ3aG6FcHnQQR2AIaT
         aa9ivVOkFJ231Fl4auQbn6h8XZC6Y/is+14pO9+LYA3WfDoJx+GW4KwFzEqAXo8+ZENT
         D1ag==
X-Forwarded-Encrypted: i=1; AJvYcCUu6sdcuhITc+H01AbkH/eUKI9S8Zm5DQn0jfwv2ohcqG8Ztddxzhr3exrjcXHpMC168pJUgSX54HzsgK97EDWwBHV/q9ffm7dKxKQ5L2BS
X-Gm-Message-State: AOJu0YwNSbicBGekfNfgUKFg6T4VaimCBEaQLBSJ9ySJGlbPUPRyHzKg
	pSt/Dne8Pl919NOHDTFs70if99D5Yi7BvUhSApLpeMm4SmNfIdAfCP6k6bL7ww==
X-Google-Smtp-Source: AGHT+IGPCAUWD6UyKahBE++19PLIR2gew8Mc8CNEmhMvYBxgpUiK2RhJcATmImQMATI//9TyR4m5tw==
X-Received: by 2002:a17:90a:2ec9:b0:2c9:784b:4a49 with SMTP id 98e67ed59e1d1-2cff956d33cmr16045945a91.38.1722980979410;
        Tue, 06 Aug 2024 14:49:39 -0700 (PDT)
Received: from localhost (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d1b36c00e3sm3895a91.13.2024.08.06.14.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 14:49:39 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	adhemerval.zanella@linaro.org,
	ojeda@kernel.org,
	adobriyan@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	linux-hardening@vger.kernel.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 1/1] binfmt_elf: mseal address zero
Date: Tue,  6 Aug 2024 21:49:27 +0000
Message-ID: <20240806214931.2198172-2-jeffxu@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806214931.2198172-1-jeffxu@google.com>
References: <20240806214931.2198172-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Some legacy SVr4 apps might depend on page on address zero
to be readable, however I can't find a reason that the page
ever becomes writeable, so seal it.

If there is a compain, we can make this configurable.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 fs/binfmt_elf.c    |  5 +++++
 include/linux/mm.h | 10 ++++++++++
 mm/mseal.c         |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 19fa49cd9907..f839fa228509 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1314,6 +1314,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		   emulate the SVr4 behavior. Sigh. */
 		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
+
+		retval = do_mseal(0, PAGE_SIZE, 0);
+		if (retval)
+			pr_warn("pid=%d, couldn't seal address 0, ret=%d.\n",
+					task_pid_nr(current), retval);
 	}
 
 	regs = current_pt_regs();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..a178c15812eb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4201,4 +4201,14 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
 
+#ifdef CONFIG_64BIT
+int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
+#else
+static inline int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
+{
+	/* noop on 32 bit */
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/mseal.c b/mm/mseal.c
index bf783bba8ed0..7a40a84569c8 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -248,7 +248,7 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
  *
  *  unseal() is not supported.
  */
-static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
+int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 {
 	size_t len;
 	int ret = 0;
-- 
2.46.0.rc2.264.g509ed76dc8-goog

