Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12855264A8C
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419121; cv=none; b=nygqn3O4KE8j2zfCte4gLtQMYMPLamB9bJOGp8fQUCKkebJn0VFOuL8fGE+jxGOB0gAC1xONxk+VGvDrpQMK30ROSmuHloWPgUn6R43IWv2gINuInCmkEyUvgKtmzAAifEw3ZYX9Ip9WfkesQDcNg+eQpo5W1hBi2L7esDMNWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419121; c=relaxed/simple;
	bh=MByr1qSJf4aiThtlCgoHWdU9O7TLM5j5t1IkQC3pHcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhYSN/NonZRQFWfJA5nsLVewcEdDabKVe98Jg3kPm1KJtdBcawVtU77EGWQZbGe7RLRema43jB0YGzSLLY3e7Ny5KJvqTpiVHesgjVE+kSsgvvjdch36xjZBg0MSFgY0mu9+cGIcBQJsAFymVSiNCWJ0Ro+gKkIdcxCkQsLrgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WSi85Eo9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSi85Eo9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c3e25658so11171745ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419119; x=1741023919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83PJNkO9JARY6UfrwtNSh9B3t1cYA+bhOuyhuOOAsAw=;
        b=WSi85Eo9Heuy3mg+Asys2Hhzic5ARjz0b/ai3X/rEnGpBKTID93bAWzBRMLWiRhEe9
         jJbADMmvQlD02TBu6vKXxx+wNsIoGNBOx5/wPyv9SnDGyMb97UCrHwmcJOx29dx6xYt9
         5M+UyfzgfGV+Dcx6Zzxnx1wcIys8ynk8MFmrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419119; x=1741023919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83PJNkO9JARY6UfrwtNSh9B3t1cYA+bhOuyhuOOAsAw=;
        b=bvWSROD4uqsh1+p0GqbSxTT0PeHJUQ7hqTpXW+LRuUJV2/LKs+7nth2QMLCtK8o6UK
         xIrS3MAe1APteSPumEau6OjbtOrEOcMPjbPn2h85PBPXa47LgYLcz4Y9zjm7qFqqDgY9
         kZNolAvBMSSzE934iSBZIMcuvZXt5SNCjn1xmJm2Fq3EFehkIdRToekIK215K3fceB2K
         ZrT+7dBB9JExsd86vrfw7gfF0bcdZpHEIxCXmp4pA6OQq3tELNcrPAriw/lFwZzc2suK
         ewRcaT+mDZB9QpqI4WyvLNvR+bwalSwTayf6xBR8ZMzixENZvbJ/G1VS+5IqIJ33bnYE
         HsQw==
X-Forwarded-Encrypted: i=1; AJvYcCX05/ozyzp+YGsVJAdtI6tKd92hoJAYZSZcNXQo72qEjn0wjf7Fw06IIkTM77qQ11fKeWhI5yIizH6RoMAhX6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnXk/ka54WJ7UQIhrGFkllwz+3mVZMC94V5dbaRuK8B9DlBHc
	SnmLfuAf5yCnnCtkElN7I83K3EojMgf211HPZCX1njQt1t3t+rlx01tp5cmTEA==
X-Gm-Gg: ASbGncvgGnMwjFkOOHEvHZqiqFMdSM0uyG+7AiBuyVkBelyBPL2Vsc69qfWcHuagNgD
	WprhRe9aIUsw+YewBetmWveaNO03ZyZ/6XxgVQJpcM8M9tBnVqIJkzTfd0yroxjracxYx8tkex0
	H55sNjV1M2gNieOYrS4HsG2RTwBGqE+imxENYbBAojN88L72/aPZqO7+xlPGGOJpQ3TlqfOnRoI
	DyMJT+h0n+vuDkDF4r5AwP0ICuKiaBmSE3HMdYhUPwLBCqF3Uy7B1ISGF15TiDVWHuaFO32izT4
	1/OiXD6dw7FpTsfxyEDiwOCUOaWJLTC8AtWCJ4BREofGYaylDa2CpipiblBo
X-Google-Smtp-Source: AGHT+IENcuh0GalF98aZHKN5+tl8yLBoqJnSu897mR97ZSdm7iKR5lpyIJSzEx3gH73SJaU8KQn4bw==
X-Received: by 2002:a17:903:22c6:b0:21f:f02:4154 with SMTP id d9443c01a7336-2219ffe0dbdmr89037615ad.11.1740419119262;
        Mon, 24 Feb 2025 09:45:19 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d55850f5sm180508385ad.208.2025.02.24.09.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:18 -0800 (PST)
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
Subject: [PATCH v6 4/7] mseal, system mappings: enable arm64
Date: Mon, 24 Feb 2025 17:45:10 +0000
Message-ID: <20250224174513.3600914-5-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224174513.3600914-1-jeffxu@google.com>
References: <20250224174513.3600914-1-jeffxu@google.com>
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
index e8ed8e5b713b..fa3b85b7ff01 100644
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
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
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
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
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
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
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
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ | VM_EXEC | VM_MAYREAD |
-				       VM_MAYWRITE | VM_MAYEXEC,
+				       vm_flags,
 				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
 	if (IS_ERR(ret))
 		goto out;
-- 
2.48.1.601.g30ceb7b040-goog

