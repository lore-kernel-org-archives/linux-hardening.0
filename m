Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244920AF88
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437572; cv=none; b=iYv3N6+BZGU2z+tCxbbyp7DR9aESdrBgYJ1pTp+YbG6QHGhNh4t1Ql4T4cato1hDsZMjVv1vDCTk4HAa8PDogoNoZXkOPef8Xx34qtOc6E0+9rXTxa4t+pmG0XCptljkjFdPsmkzhH3W3i5ntgEQLQ933sL/lw+5IuiT3JUefAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437572; c=relaxed/simple;
	bh=+Jr8v23L6iLuA3vKByURp4sY8Lw7JmuAhQkX6WPaKi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbwI2B0gJzD8uf2MRDQ/bIGWNhQrl2F5uFUtacf3JnluRVUGbwIcB5ZyzAuLX/AyqnhNQTrZX5om2ZJC98jWJGaBbhRDMQjbxAEI0HABUPkbgIcQ0OHxTdmaoadXATm2YDrs4VOut8tvWENNgIFQnwChcTzlmmy84Iw8qiPneaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CTTnKtLX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CTTnKtLX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d47b035fso11398515ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 14:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437570; x=1741042370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HehPKH2HS0HzCH0hQSNM2QcWWpZkmDJGAEgO0vW2y+g=;
        b=CTTnKtLXmoh3kaOxgzwg3JZWtzFl/idk1bBoNuAQ6NXCggCqH4HVe3KLwZJKcb12AS
         MQOE+M1daTl0e7yVoP9i/yIL1spM6i4Z6/dPkNziFMlCCFmWyDJhmz5RAxJomewLQHEA
         eI6IMsVoP9yZT3ljT15ZY8BVKjo7TvTpEjDaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437570; x=1741042370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HehPKH2HS0HzCH0hQSNM2QcWWpZkmDJGAEgO0vW2y+g=;
        b=aLauYGRBON1FntXg0FmrdnskKdFfGBXIdRta+5nhc/0B7yCQ/XoETdMppHLmBuiZ5k
         9tNAB76vde7YenK9H8ZMpyDXAY5JH3inyIZATKZhmtAm0WycLP4Nzh9JUoOg6Wdafhp9
         88zRGBKDR1AP3vORcCWehx8LGMXQxZF7AWRYEnIZBjs22vZExPB9AzdSaA2NOhcdsYRS
         sh+JbJkPS9jG+/+PIJUZ7wQTnCk9J+ob8eq1+WT2EQUIOm4LiSkgTdOw0Kxj56zaGk2u
         pJFIZxfGzbSnVXRaDk5fScc7I2ciEU/BCxv6i/oe4l+19fEI8/xvB09CMfZ9v2sFvSwF
         uuQA==
X-Forwarded-Encrypted: i=1; AJvYcCU7eo89L8gU0FGCPqihKTQiwI/yn/gnFsvADKLGXU9ZGtECdSK2q6mcebvc8s7Om6WSnBk2TsMBm9CJjBqhhM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CxvCEMsQmjDNXK+x9YowV1i2h2t5VleAGOFCZPL8X4Oo8//r
	kdz+9xiPNrI0QGin4YWZznRYYCtMZdQz7qEh4/y1BhLqDrjl3IV683OVqJhJ6w==
X-Gm-Gg: ASbGnctkKqS8vW/9fLkZIdlYqA1MLg2jCag94zwZA4jyHq0NQ+R/BteBaBTUHgoGrUy
	iKiX+bGv2xo+gzt7NWmvEwMO7l2FLqHI3We9/VaVXgfAyoNYK//O4QLt4RjdFWazQCSQH7ANRqv
	ESRHOGliFvcpwcYAVXXHsKiv4QOmMxFfamCElTkZOoFSGZyspTjMz9Gw5J2QKndgnqc1ZnSRO5I
	E+YXMtULlMPCP96m4DVuO+SttH6G5g/HiyCcdFrQHCst8n/exdt/5Ah5+O7/IRS90HrawpXLGDv
	iW9MKIoJLsXM7Z3hcMW1etcr7WILB4BobeBvWx5uLu9cmktofzx3qsUGRyHO
X-Google-Smtp-Source: AGHT+IHvxyCpkXXkYjTLWWPzvLXpjBHCjYNwj83VFoOFzg3xddNwivdcqHIMBcGsWOCoYPcqKcpgHA==
X-Received: by 2002:a17:902:e5d0:b0:215:9a73:6c4f with SMTP id d9443c01a7336-2219ff50d56mr94813075ad.6.1740437570374;
        Mon, 24 Feb 2025 14:52:50 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0ae9acsm1300615ad.225.2025.02.24.14.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:49 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v7 3/7] mseal, system mappings: enable x86-64
Date: Mon, 24 Feb 2025 22:52:42 +0000
Message-ID: <20250224225246.3712295-4-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
covering the vdso, vvar, vvar_vclock.

Production release testing passes on Android and Chrome OS.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 arch/x86/Kconfig          |  1 +
 arch/x86/entry/vdso/vma.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d957e2f..8fa17032ca46 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,6 +26,7 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39e6efc1a9ca..1b1c009f20a8 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long text_start;
+	unsigned long vm_flags;
 	int ret = 0;
 
 	if (mmap_write_lock_killable(mm))
@@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= VM_SEALED_SYSMAP;
 	vma = _install_special_mapping(mm,
 				       text_start,
 				       image->size,
-				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vm_flags,
 				       &vdso_mapping);
 
 	if (IS_ERR(vma)) {
@@ -276,11 +278,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
+	vm_flags |= VM_SEALED_SYSMAP;
 	vma = _install_special_mapping(mm,
 				       addr,
 				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       vm_flags,
 				       &vvar_mapping);
 
 	if (IS_ERR(vma)) {
@@ -289,11 +292,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
+	vm_flags |= VM_SEALED_SYSMAP;
 	vma = _install_special_mapping(mm,
 				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       vm_flags,
 				       &vvar_vclock_mapping);
 
 	if (IS_ERR(vma)) {
-- 
2.48.1.658.g4767266eb4-goog

