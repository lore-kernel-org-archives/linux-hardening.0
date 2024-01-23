Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7915B998
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969758; cv=none; b=NMW4Bi5hpVhIz0ODa7SYhK0MwUPib/uIvOvkYmihLX5Udx5zmv3P9ceq2wy3+jPAdFZ6XcWsoC3OG5p+HOYA/FdHoc/GxnKjoBzBTpTBsTx6fMqUjZve4tJddFgT5x7WwtPV+NVjoyoQMfgxFyDxsGV4T+gXRS43JmRoC0VIWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969758; c=relaxed/simple;
	bh=IXC9gHJS+Pnry0+OD6RifuKC5iruziQtcHdroYUu0NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GyMSXWnvPXvWwkkWn8e6vDJABi/Tmhc+WVV5TYQiGiIM7jebx013UILFoUrw8BebiHajvGIxZYBC8TxPoR68BDJqQ4i4PMZxnJdVJ3L2m91VSy6k4vaUdBmeQr8s6CDWSKs2FQvdTSg1+POLWmSdnm4dccHvZHVfK6jvXi3CrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SJQaGBFy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJQaGBFy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbcdbe13e1so1649155b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969756; x=1706574556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R+UH41sqIFBEg2yHgSz9fASiwRmxO8UrEbFS39w0BY=;
        b=SJQaGBFyaHQfX8ipErQPchtmgreagwEZD2Ajm7xOsT53ZYHhkdP+g1QHTIkxLJgiGo
         2c7zlIAoka+I4U6gIDnQCLVsPEgnzUlxaHCCjq+S0sX8Ya4h9UDEd/NGrTAgqv2/cCYt
         p6o1/RBfIP+SRbcyntIEYmRXiptwsFa5E1AoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969756; x=1706574556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4R+UH41sqIFBEg2yHgSz9fASiwRmxO8UrEbFS39w0BY=;
        b=r7fr5IIKfifzWFnZwcOXZbv5bCxY11wqBNeWXM6P6lG04KGdM+xZIgcSjKbqJCodar
         NergGbjXmEMBotLW4PqRVpGOiIybFhtn+jXl6V7Rq/KfkYswakccLECC7NWV/8YAhwGN
         jS9arz00eLen0A82eLc2g7hV0DHWJyuV3fUZTWzUSlLgAPgevA/HvGEbqjpfqWzpXUac
         hfJh+x2ryHTQ0CDg7BQSiCKyi2F0F/Ot/WVQjhHU8c0GVWENd7xqDSPZmBptq+GkMtd9
         lGBuwoY43RrsNN89muh9OgrGWGSob/WqcZ9FPVLicPL6wslmoZob7SrJRutjUp6LP6bt
         IO4g==
X-Gm-Message-State: AOJu0YwnqJhBGqAkwuxox97CV2r2vtQocEChmupc7lJiO0Jpwe6UYf5w
	8A7aGeLtEHJowHiMcF3jpYBD4swTgtAUBRmS58MJSbtstflfy26yU6CVEkJeJA==
X-Google-Smtp-Source: AGHT+IEOQPxBrxeTVknuQ85iWItECd3oDMC0wKeLvQMG9XfT1svGRvJdDWYE3hUC2zG+qCIX3weiSw==
X-Received: by 2002:a05:6a20:1446:b0:19c:5821:1d6b with SMTP id a6-20020a056a20144600b0019c58211d6bmr373911pzi.71.1705969756091;
        Mon, 22 Jan 2024 16:29:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090302c200b001d707987ce3sm7513949plk.194.2024.01.22.16.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 63/82] mm: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:38 -0800
Message-Id: <20240123002814.1396804-63-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4403; i=keescook@chromium.org;
 h=from:subject; bh=IXC9gHJS+Pnry0+OD6RifuKC5iruziQtcHdroYUu0NY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKGl7sIklkp9DpywnYDLBMy17rUJMlBDpuZ
 IF1ZnQBhjmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 JiG2D/9PRn4Y/k1W4IyELDW0vMaP8RPiiJfMCcL4ThXwWsfGmaqGLqfV1zQEvJXDHSGEjV3qA6f
 1QWoI9IwuKjfA6OfO0JlksQZDvV/d4C1mTWzdQrRY2/LthSJBzsCK5VbReL0TpTAcFMajuY0JUk
 y79Nm7lQVGIPVT5kz9GE4HegEGGPsCk202fOQjGOid1P2FXfyctaxE7AC8A1oTmzBr7B6go6pES
 ZTzR/Z2fyNRTV4EbHBr9C3U447jLgO+uGVXj5FYunn/XaHZoFkbicu5CWTluotmM8My6vrUQc+R
 OVe3VQn2KHnuQsPPgENWLrMitHmaACD3nc3KGOQ5Nq6c9iVKKDGGSDopVfAm0cnC4JZNZssedWq
 QpeBszRZxgPbM6k0GMuCe73qgQg1GJuz4XqNNsDbrPNFJfH5ZXInUZt7+xx3wQ05371PA60Z8t0
 tmCrWOgNSP9F1389si16h87Pzo/PvgvSF70Hbml6OUR4kU8xvA5OMHvggCQlwJG4zIykjLq9Ggu
 inHAl1IReCphEG4kev2pugmVlUlmGGkFAeg2uA4m/PbIKGl61suJep0mr5S3biRpHUZh/FVpWS0
 dBLSKvx/lkw1jpHcmaLhj8srWr/oF+71hPZ7pLlb7R43ZReS0qw78SWDbOAttKIb6nPhBw9l//1 jTPSgii2rrZymlQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/memory.c | 4 ++--
 mm/mmap.c   | 2 +-
 mm/mremap.c | 2 +-
 mm/nommu.c  | 4 ++--
 mm/util.c   | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..d47acdff7af3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2559,7 +2559,7 @@ int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long
 	unsigned long vm_len, pfn, pages;
 
 	/* Check that the physical memory area passed in looks valid */
-	if (start + len < start)
+	if (add_would_overflow(start, len))
 		return -EINVAL;
 	/*
 	 * You *really* shouldn't map things that aren't page-aligned,
@@ -2569,7 +2569,7 @@ int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long
 	len += start & ~PAGE_MASK;
 	pfn = start >> PAGE_SHIFT;
 	pages = (len + ~PAGE_MASK) >> PAGE_SHIFT;
-	if (pfn + pages < pfn)
+	if (add_would_overflow(pfn, pages))
 		return -EINVAL;
 
 	/* We start the mapping 'vm_pgoff' pages into the area */
diff --git a/mm/mmap.c b/mm/mmap.c
index b78e83d351d2..16501fcaf511 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3023,7 +3023,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		return ret;
 
 	/* Does pgoff wrap? */
-	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
+	if (add_would_overflow(pgoff, (size >> PAGE_SHIFT)))
 		return ret;
 
 	if (mmap_write_lock_killable(mm))
diff --git a/mm/mremap.c b/mm/mremap.c
index 38d98465f3d8..efa27019a05d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -848,7 +848,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	/* Need to be careful about a growing mapping */
 	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
-	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
+	if (add_would_overflow(pgoff, (new_len >> PAGE_SHIFT)))
 		return ERR_PTR(-EINVAL);
 
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
diff --git a/mm/nommu.c b/mm/nommu.c
index b6dc558d3144..299bcfe19eed 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -202,7 +202,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 {
 	/* Don't allow overflow */
-	if ((unsigned long) addr + count < count)
+	if (add_would_overflow(count, (unsigned long)addr))
 		count = -(unsigned long) addr;
 
 	return copy_to_iter(addr, count, iter);
@@ -1705,7 +1705,7 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
 {
 	struct mm_struct *mm;
 
-	if (addr + len < addr)
+	if (add_would_overflow(addr, len))
 		return 0;
 
 	mm = get_task_mm(tsk);
diff --git a/mm/util.c b/mm/util.c
index 5a6a9802583b..e6beeb23b48b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -567,7 +567,7 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
 	unsigned long flag, unsigned long offset)
 {
-	if (unlikely(offset + PAGE_ALIGN(len) < offset))
+	if (unlikely(add_would_overflow(offset, PAGE_ALIGN(len))))
 		return -EINVAL;
 	if (unlikely(offset_in_page(offset)))
 		return -EINVAL;
-- 
2.34.1

