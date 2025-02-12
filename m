Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757A1DDA1B
	for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330523; cv=none; b=rncRt1l2HP7EAU70XE3PONWvIRobthTtHJLkwmQ7skH6MyM5BJppG3qa4nve200X6Tyv4AjO8rf27HRw/OUNuTmuh9WIdGTdrvDyFRzNxt79eDTX9L4ogf8gq7uYvYYYlb+slE74SL86atw2eoNhkQuUG5P043BIl6HdbLbVOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330523; c=relaxed/simple;
	bh=rbKCgrhSnltAq4HphfqxDQL2WDHmk7Ibm7vobAi6Ezk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXboqkF8BacApswKnH3PjdUgXuojx7uViDqYU/aMhJS94lObLtEiogadKADd1FYzMk06TE3+mznI+qzGLx8WTDudaeLpcrgNh11YBP1BKiRdqUrie2o2+4wzGtsViq8Vx7kzsQCjTASdT5JUCpbt9J6c4kvfJKdUQJsb4deqLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZxpavU03; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZxpavU03"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa1a428f6aso1403308a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 19:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330521; x=1739935321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7pPl+80co4+z7JP7yvzolDYDYVYpoOhsDUrxcZkGCI=;
        b=ZxpavU03xFkpCelm5FYcB82bogOeN93OZfk0WyvdJHXoBuBCLZcjLWeCKYOquRgSQ2
         Gzn45gr/KMF1DbDg2DSJIFeFHITzgy4KFc4zq7Ta2rPlOTkNPrdjXRSKI7zK3Jvl2KgN
         l9UM4N3k9cQ7wWtg86ODmAvy8RmOWO65QKhFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330521; x=1739935321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7pPl+80co4+z7JP7yvzolDYDYVYpoOhsDUrxcZkGCI=;
        b=Xe542+OKV08f5mISwthX31gT/NMPdXlI3Kvbv435TnlbLmLRmt26VHRLHfdLPR8zbm
         lU+i54D9sW6u7tNjN5W2mNti5akOdflhEij9AugON1o6DTAxQ3R8e9M4aQj1NnUs7A1w
         kTFeCwbovBkojgWlkSOpcNPem9GZiRU63Ld4oh7arxsLaSurjcZDZv3M+3GuxLLHEEao
         xPemoPzGRJplCrJIEpsjyrKwjqb+qjs/dhVawrAtKP/BEf5OzmmJ75dz8/T06NW7yvG+
         S+drX8TTEhmk/Nnfe9oNxxhVjpaq+y+TtQdfNdQ3so0oKQ4uGSqf7x1zHoAIbSwfGsjI
         lR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNmD+UwJcjh+3j1UYtqmaC5tY5UuOJp6dOQUrKqQJIVlbslz77RF5rZZD6d97ZMnQpZ0iFIO947sc7/XaNPU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eO6IQ2IVVWrODIzPuFRbE+EwSI7VISwJ0znvBiuSMrHBFoPj
	G7u61MLnjnmozhJfXHZ8xhync7aZHtoXeRWN6cfqD8BSbx8p8ZV3RWbQ5h66zA==
X-Gm-Gg: ASbGncvcb7DUxh28ZyPGufx2RGvBzBxxICmgwXOI1XMr+RCTu683FhJ2SZs5oc4mEmJ
	6VziixifM6msoMmvsnmnJPAbwszuCza8+VSyuaQ3qltzxMjbDKoadyOWc17DlHUHI2BQDheNAZ9
	UvTIa8KSGQbFLtPlPhUHeI06qv0iWW29VBB5HLczXKCD7OLVwwKwX2S0yq62lIjflWly25teJ3+
	zhg3qyM2Lv5KtzfSMDG1aGbiK3sgzDi7EjbNLv80EaYfvSf5s2XUJZHhBPn6yOpxkF/Y2Dq9j4w
	V03Qf/7ld8tzGU9Gwp0CmPH8Q1ZtBFa5rRtJSYFMwgOSH6Kayg==
X-Google-Smtp-Source: AGHT+IEQjI3mXwIsERllpCdgEEkG55fGZ2UKV6IZsw6M1hblfR3OjmOt9QtTdXsaFePhUPJi1BBTqA==
X-Received: by 2002:a05:6a00:ac06:b0:725:46cc:719a with SMTP id d2e1a72fcca58-7322c3780fdmr864380b3a.1.1739330520652;
        Tue, 11 Feb 2025 19:22:00 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7309569d6efsm4018014b3a.92.2025.02.11.19.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:22:00 -0800 (PST)
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
Subject: [RFC PATCH v5 4/7] mseal, system mappings: enable arm64
Date: Wed, 12 Feb 2025 03:21:52 +0000
Message-ID: <20250212032155.1276806-5-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
References: <20250212032155.1276806-1-jeffxu@google.com>
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
 arch/arm64/kernel/vdso.c | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

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
index e8ed8e5b713b..cfe2f5b344c4 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/userprocess.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
@@ -183,6 +184,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
 {
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	unsigned long gp_flags = 0;
+	unsigned long vm_flags;
 	void *ret;
 
 	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
@@ -197,8 +199,10 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_PFNMAP;
+	vm_flags |= mseal_system_mappings();
 	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
+				       vm_flags,
 				       &vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -208,9 +212,10 @@ static int __setup_additional_pages(enum vdso_abi abi,
 
 	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
 	mm->context.vdso = (void *)vdso_base;
+	vm_flags = VM_READ|VM_EXEC|gp_flags|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= mseal_system_mappings();
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
-				       VM_READ|VM_EXEC|gp_flags|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vm_flags,
 				       vdso_info[abi].cm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -326,6 +331,7 @@ arch_initcall(aarch32_alloc_vdso_pages);
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
 	void *ret;
+	unsigned long vm_flags;
 
 	if (!IS_ENABLED(CONFIG_KUSER_HELPERS))
 		return 0;
@@ -334,9 +340,10 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	 * Avoid VM_MAYWRITE for compatibility with arch/arm/, where it's
 	 * not safe to CoW the page containing the CPU exception vectors.
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC;
+	vm_flags |= mseal_system_mappings();
 	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
-				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYEXEC,
+				       vm_flags,
 				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
 
 	return PTR_ERR_OR_ZERO(ret);
@@ -345,6 +352,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
+	unsigned long vm_flags;
 	void *ret;
 
 	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
@@ -357,9 +365,10 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	 * VM_MAYWRITE is required to allow gdb to Copy-on-Write and
 	 * set breakpoints.
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= mseal_system_mappings();
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ | VM_EXEC | VM_MAYREAD |
-				       VM_MAYWRITE | VM_MAYEXEC,
+				       vm_flags,
 				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
 	if (IS_ERR(ret))
 		goto out;
-- 
2.48.1.502.g6dc24dfdaf-goog

