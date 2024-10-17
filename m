Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE118E3F
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126275; cv=none; b=MbIw22QLk4VX0cnf5JRDHPYzw0v6NJ5b3qLgEE3IhKQKEzdnN2MSTXfYwoUHL/8EcOOEH0RcwuVjZQh/FDsrlla8YxZ5f2MdkgouJhlqqnCOAce6wz+hnuYRuCK/8XNE1RDpN1paipVzHnOJ0QhPO+lPIwitiUk5hsiQagJyZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126275; c=relaxed/simple;
	bh=IxD+p5GKEBnqW9bnHP0WW6feXUZp/DU4SEQgGZ6gu7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bidGm/UrOi9NU6lcoTwx1GLU49FsA9qOgRlJF094yjBkt0BfZrpRzWyEJlHO5PKRZyfvOYag0MNKV2b08z/yT2AkEi8Oaqqn4X9HZPUiljNuA8GQ0ArcXW9fkeF7cDJcSNfYV/9y8nwkoT1JuajedzpeCyFp4d/uhFcrHQwpoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YmcQoIeM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YmcQoIeM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2b93d2da6so47442a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Oct 2024 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729126272; x=1729731072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjKlw80hPOriNww9p0Da79oYC5cYurJRNqRcXEepGpg=;
        b=YmcQoIeMX4SB/eIIlH/U0Do61TzJ88np1flWOZqqF7z1iMdH6pF+EV9EogNJt+duHF
         rhr391nLukQ429h3dIysyitz0bbXnIovwknBf+5/vHQmIvxFblbuMlvJYFUiMr//hYP1
         jlsQgSX2g61csAxjUR/xhmSGD9k9fSPg+KB5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729126272; x=1729731072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjKlw80hPOriNww9p0Da79oYC5cYurJRNqRcXEepGpg=;
        b=P14Gz18m7G+vORh/qvs8lZww5APFi9PZAlEfp2+PFSIvWBgY13bEzxhki2wNfaaYCV
         /L0jBa/yxHeHtd9jYMTabeEwQZYj01QuX5/8roZJB8d0/iwevrUeSYRxsNaXs99xogZq
         nfxcbY2o9rsWEBA8sHQhkVcgWDCdTR3AuDKJipiI9yPkzPtnMTdeYekhXmi4NnxqoHqL
         Ck63OaVEwnSF2BQODxIuvcQPaUlgfaQP/p4RPIEZOIjGJS2xoWCk76Qai5N5LnKXszq8
         0E+eVMt6I3ExJ1Vtm0CGMFeJfSVl3PrIo2+MZQ8OqekJLVLFZkjJTp4HdUUbwj7Gs05C
         mCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBluwoiTADu3MGVOVfWdpc6OfDU5Jz+8ecqb/wWOd/YPWOkqrUtnxvS6KgeT988GKdxigGteJIl2xcoy6xpjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIySNH2JiPKVKp4fDQS5kjNVWzGdRxeKwQ0UgVbUCbFiMqAQ+
	LgXXgRLOqHau03as04TqQZeZBGUbEB/p19tb8jqTBv4rDQ+l9sf7PFhNd+mgeg==
X-Google-Smtp-Source: AGHT+IG+nZEmIFxEMebL8zJk/ulSdARWGAMWNOvXhzs7CcDij4L3o5BGAmBhyFvsZhnXUwj/YuMYiQ==
X-Received: by 2002:a17:903:32c4:b0:205:723f:23d4 with SMTP id d9443c01a7336-20d47e69b07mr7460455ad.5.1729126270776;
        Wed, 16 Oct 2024 17:51:10 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20d1804c050sm34102105ad.216.2024.10.16.17.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 17:51:10 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	deraadt@openbsd.org,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
Date: Thu, 17 Oct 2024 00:51:04 +0000
Message-ID: <20241017005105.3047458-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241017005105.3047458-1-jeffxu@chromium.org>
References: <20241017005105.3047458-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Two fixes for madvise(MADV_DONTNEED) when sealed.

For PROT_NONE mappings, the previous blocking of
madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibits
memory access, madvise(MADV_DONTNEED) should be allowed to proceed in
order to free the page.

For file-backed, private, read-only memory mappings, we previously did
not block the madvise(MADV_DONTNEED). This was based on
the assumption that the memory's content, being file-backed, could be
retrieved from the file if accessed again. However, this assumption
failed to consider scenarios where a mapping is initially created as
read-write, modified, and subsequently changed to read-only. The newly
introduced VM_WASWRITE flag addresses this oversight.

Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
Link:https://lore.kernel.org/all/CABi2SkW2XzuZ2-TunWOVzTEX1qc29LhjfNQ3hD4Nym8U-_f+ug@mail.gmail.com/
Fixes: 8be7258aad44 ("mseal: add mseal syscall")
Cc: <stable@vger.kernel.org> # 6.11.y: 4d1b3416659b: mm: move can_modify_vma to mm/vma.h
Cc: <stable@vger.kernel.org> # 6.11.y: 4a2dd02b0916: mm/mprotect: replace can_modify_mm with can_modify_vma
Cc: <stable@vger.kernel.org> # 6.11.y: 23c57d1fa2b9: mseal: replace can_modify_mm_madv with a vma variant
Cc: <stable@vger.kernel.org> # 6.11.y
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/mm.h |  2 ++
 mm/mprotect.c      |  3 +++
 mm/mseal.c         | 42 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4c32003c8404..b402eca2565a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -430,6 +430,8 @@ extern unsigned int kobjsize(const void *objp);
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
 #define VM_SEALED	_BITUL(63)
+/* VM was writable */
+#define VM_WASWRITE	_BITUL(62)
 #endif
 
 /* Bits set in the VMA until the stack is in its final location */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..6397135ca526 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -821,6 +821,9 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}
 
+		if ((vma->vm_flags & VM_WRITE) && !(newflags & VM_WRITE))
+			newflags |= VM_WASWRITE;
+
 		error = security_file_mprotect(vma, reqprot, prot);
 		if (error)
 			break;
diff --git a/mm/mseal.c b/mm/mseal.c
index ece977bd21e1..28f28487be17 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -36,12 +36,8 @@ static bool is_madv_discard(int behavior)
 	return false;
 }
 
-static bool is_ro_anon(struct vm_area_struct *vma)
+static bool anon_is_ro(struct vm_area_struct *vma)
 {
-	/* check anonymous mapping. */
-	if (vma->vm_file || vma->vm_flags & VM_SHARED)
-		return false;
-
 	/*
 	 * check for non-writable:
 	 * PROT=RO or PKRU is not writeable.
@@ -53,6 +49,22 @@ static bool is_ro_anon(struct vm_area_struct *vma)
 	return false;
 }
 
+static bool vma_is_prot_none(struct vm_area_struct *vma)
+{
+	if ((vma->vm_flags & VM_ACCESS_FLAGS) == VM_NONE)
+		return true;
+
+	return false;
+}
+
+static bool vma_was_writable_turn_readonly(struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_WRITE) && vma->vm_flags & VM_WASWRITE)
+		return true;
+
+	return false;
+}
+
 /*
  * Check if a vma is allowed to be modified by madvise.
  */
@@ -61,7 +73,25 @@ bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
 	if (!is_madv_discard(behavior))
 		return true;
 
-	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
+	/* not sealed */
+	if (likely(can_modify_vma(vma)))
+		return true;
+
+	/* PROT_NONE mapping */
+	if (vma_is_prot_none(vma))
+		return true;
+
+	/* file-backed private mapping */
+	if (vma->vm_file) {
+		/* read-only but was writeable */
+		if (vma_was_writable_turn_readonly(vma))
+			return false;
+
+		return true;
+	}
+
+	/* anonymous mapping is read-only */
+	if (anon_is_ro(vma))
 		return false;
 
 	/* Allow by default. */
-- 
2.47.0.rc1.288.g06298d1525-goog

