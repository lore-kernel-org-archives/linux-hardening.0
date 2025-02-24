Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCA20A5E7
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437573; cv=none; b=ZZ20VbcHyOAd9dYtLa+xjW1ZKVUzaSCuKNkm6QQwjXbhDGZuWkEE5XsAleGiPwp/t079Mbi0Csb1Ey42wNkckqRup5TtnIwbhKgl8gNXaWbSqGKUiQ0oc4tHWZEBhWJ10xnpZxVRoW7rJDg4153puBsk3aaMtEkklp2nX94OHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437573; c=relaxed/simple;
	bh=2yuHBoSnd2wsgNcC3esf33ETF3rGpThxv2gH4bJQmiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKwh/JR5nB1RX2JVwbvSa2qjUo16uKLiukxUz0MbBNvw5DjnTY1cv63h1yquguSyBsl6twL6V8xn0s/D5h8VQCY1Ev9s4O7pIZeD0oZjkXFnrT6QYPYYQsma2WMyxZJxIkOvDBXy1VjrhGvXNqNhuWjDFUFI/MhxcnjYy94v040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IDPl1vdA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IDPl1vdA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f8f3bd828so10884155ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 14:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437571; x=1741042371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnbYZdR9Dsd6yNbIvKX9KQDi82tgjieU0sfh+fobVnA=;
        b=IDPl1vdAmpECLAazI2fkrXYit69k3Jve3/sfCNR00wk10ijuWTNZ+5ft07t/oxQ8Qd
         868Ki7udGM22zjbMdgliMUrhxUZXLpsqpoxMEKwAxTV2kPOslCLB5+GTNwbqQRCe8awA
         HRoyMARA3SWVB2rxF5Nib3dL3zo+/3U6aYuEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437571; x=1741042371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnbYZdR9Dsd6yNbIvKX9KQDi82tgjieU0sfh+fobVnA=;
        b=CJFobP0mjyaya1VOQ3MsHkx6r9okmu/aE53lvLfxvU/WXj7rsdwSIvRpU+Ae0HJpK7
         EQK7hIB7LRaOdpv8VhfEyNELbsz5rLVzyKKo/B01FvDqXo8myrKrhzHmvhyJzziYJSyA
         6dtkKVYStnQklhy9LmtTH0iK3aYhpv3OHGHbM5FQqL+GvyBnZbIaSwNdMSOENjvPysyg
         SC2FXToz0EUe7cxYRCpCq1vgZlj8YdHBPXKPIvXWz+hun15I4sPPj8HFXdsQKMit/zXR
         gy+HHvY7GPmHANnz7DxIT5F37pIoELHhonRTztaHTmLNFTFN+FGc/fRNmk64dkSUp8m4
         Z2AA==
X-Forwarded-Encrypted: i=1; AJvYcCWct4F1SYcc/So6q8Jhs+Cj+8sxXR4/ybKnnQ/wElMFkdc28Fw3hzdkp7amiY1Ypz35PUXKddg3/KfyGHLprss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2j94bsTtAVE64IAq20ifEJEFWuLLZPE0jSxIjnPFQdG1CFV7
	1YL6GVNrGRBG1B57POCZrYzmpCiyMaWlXQABUFr95KKGYUNem8GvqqnizcbYgw==
X-Gm-Gg: ASbGncubTm96QzJt4IN0zD6EXEg+3TfaiOevAHVolNrP7ZFlmFy+Wg025urRfOcfcAX
	wu5bQC3ijYuxlGxEzeRm4609a3kjLSZVeyK+KmgxBN4mU1/s8D2Am+az1Nncl9dwny3SMSbN4Zk
	zUd9zIyX3KB/mUj46QPwnLOwGJjjR3EVW4MoqfOOT6AKAUg9zzFZIGTYCImU73xlQyuibnGqhfU
	P1CPhDIl2tqNLa3iu/JgQGpSW+S5O3NPI1f4ZJqAKlcRmzgdSGGYI3LKFszWgAK+8aPTUTpdIlk
	KueO7yl5yFFxQ9KHjmiE+fa/vrneukM4RDqr1bbw/137gABpBWxr2SwaXOWh
X-Google-Smtp-Source: AGHT+IEhSKFRCZXsG2Zy3hOdxapBXQNVpwEKFfeiuGKe7NPaKl+bBQmXHsBtgSBl5DplToMs80po9g==
X-Received: by 2002:a17:902:cec6:b0:215:aa88:e142 with SMTP id d9443c01a7336-2219ff6e82amr92327965ad.7.1740437571460;
        Mon, 24 Feb 2025 14:52:51 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a000536sm1358685ad.45.2025.02.24.14.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:50 -0800 (PST)
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
Subject: [PATCH v7 4/7] mseal, system mappings: enable arm64
Date: Mon, 24 Feb 2025 22:52:43 +0000
Message-ID: <20250224225246.3712295-5-jeffxu@google.com>
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

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
the vdso, vvar, and compat-mode vectors and sigpage mappings.

Production release testing passes on Android and Chrome OS.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/vdso.c | 22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8..39202aa9a5af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
+	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8ed8e5b713b..12e6ab396018 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -183,6 +183,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
 {
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	unsigned long gp_flags = 0;
+	unsigned long vm_flags;
 	void *ret;
 
 	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
@@ -197,8 +198,10 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_PFNMAP;
+	vm_flags |= VM_SEALED_SYSMAP;
 	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
+				       vm_flags,
 				       &vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -208,9 +211,10 @@ static int __setup_additional_pages(enum vdso_abi abi,
 
 	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
 	mm->context.vdso = (void *)vdso_base;
+	vm_flags = VM_READ|VM_EXEC|gp_flags|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= VM_SEALED_SYSMAP;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
-				       VM_READ|VM_EXEC|gp_flags|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vm_flags,
 				       vdso_info[abi].cm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -326,6 +330,7 @@ arch_initcall(aarch32_alloc_vdso_pages);
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
 	void *ret;
+	unsigned long vm_flags;
 
 	if (!IS_ENABLED(CONFIG_KUSER_HELPERS))
 		return 0;
@@ -334,9 +339,10 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	 * Avoid VM_MAYWRITE for compatibility with arch/arm/, where it's
 	 * not safe to CoW the page containing the CPU exception vectors.
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC;
+	vm_flags |= VM_SEALED_SYSMAP;
 	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
-				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYEXEC,
+				       vm_flags,
 				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
 
 	return PTR_ERR_OR_ZERO(ret);
@@ -345,6 +351,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
+	unsigned long vm_flags;
 	void *ret;
 
 	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
@@ -357,9 +364,10 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	 * VM_MAYWRITE is required to allow gdb to Copy-on-Write and
 	 * set breakpoints.
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= VM_SEALED_SYSMAP;
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ | VM_EXEC | VM_MAYREAD |
-				       VM_MAYWRITE | VM_MAYEXEC,
+				       vm_flags,
 				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
 	if (IS_ERR(ret))
 		goto out;
-- 
2.48.1.658.g4767266eb4-goog

