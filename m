Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202BD1898ED
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141049; cv=none; b=fKvlU1TTndBVSWvZJozLRZkjEepWOtiyEvhV8T9lRtOaPeQAaXSc/Qt+LQmC9uxVNVWwG7VuSctWlKhxLoVUPkT5PrYY4KuB1DDr5DVWs9LJHjbUmDMkanWhwG5FdRaDbxbGY/65/hx+wNQ9htl2SN0YnZUUHpSZr4O5/dmjaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141049; c=relaxed/simple;
	bh=ZAnJcNAE0RBecudUUh8uu90jecNEuyMqoLyI4jqjchU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ45xb2ajTTT7IQNHEgE9kR2R+5G5XjjQEoBd4VsKM1iFvRRMV3RNOK1x28+VcT312DoT1Ce7ju/JbH1N4IWuroj5UT/dTEYdfK1T7Rh6XEgMjEuWlqtKEY5ELFVYzoI8ASBZqHEykgpaIS0Dcqt5ulDxVLSBDc4NvOPXMHEzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X1TBFy6f; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1TBFy6f"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e064eff5daso941208a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 04 Mar 2025 18:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141046; x=1741745846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAD8cO652vqhuw2yI/B0NaFEiQTnRzt1qnI3Rgts5M4=;
        b=X1TBFy6fyOIykD4hhqQObvcmUdGxA77ViAdfT3UQK8Laiceh9ngOpbBE5xSJEzZ2Vj
         6ScPU9eime5XGq0LeuPbm5aE01MatSd0Gr8Qup3+BX/0HhE7GyVk1NFUjKPgFJ8d6TC5
         wdWxxQbEAQj3gLNFSnllWYprrFpjVN6dXRyeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141046; x=1741745846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAD8cO652vqhuw2yI/B0NaFEiQTnRzt1qnI3Rgts5M4=;
        b=UMQmXa/tCWuicl049t4uh/fEiMpVo14SGkv2h2j4qwBfPc4AkjWeaQCLCXMXM1lXga
         +rJQbcmzTsMsz0eSKV8ThFt5kJ7dkdzLiyq0keJbnNm4piYQR3ddKEwdekWtrb1ExtUj
         VKXNSg4JikceCiDC/q7WmO4Gb2ma6IEWzSEXeRC/n36K47B/uAn5EP2C8LNJgL09q/MT
         loigh/KR1YAkjaTxhOe5YrfHv4Ff79FEKDxWeR+gO7MTJF4hKbmgd14nGnVnYkDs9KLU
         kxiBIblf+UT6gDbCOt+mDZjlvJu05gVkND1VcjwED7jb+msZRszxy5M7zvV5cqNdRnvY
         D0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpmHk1SsE79nFnowAYPk/WXel8963CEsB/dYNuBP9USeG/0HxaHSEx41QROmEjeg9bVb7CvOFti2c+eu47/Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcHrAU6LZ73XGks7NZS7qkynJhuPncsIw+QOoVBHPh/iqNY2X
	3K+puxD0fzRz2H1mXqROfR1eU7qIheUQ0re9HJDZ9JsdL/fF1fU3/NmF1Num7g==
X-Gm-Gg: ASbGncuuNLSZWfZNhk3nZDG4jbS8DJko3I05e8uDt6qKFoRXQlLjJLdpez8Ft4g4EZV
	ONB7sjxQcicjicS+mnBEzgjuf0oFO5Yhtex/Vo6upht5dxPAkXKI9IiGfB5fYZqyTaa1mrYLHGV
	/bwaVPp9n3unkYu/eeZ6+jNXfuFR0GlrTXD60QeCD2i4GcwOObv1S92isp8MyZ//NdgQG8RdEu/
	4k0OTjz68I+CQu8cdWm1uM4ZxrkvtTFpzdjZuXoIHdekDMseBtHErzvfiHtqT2F3+lVtYr6Frc9
	4iJf2884Us+C/vm0umXj4p7Fu3eJsA+QJXUyobzxuYx/iTNmp8A6G7HDW9at9w4TAjHU24vCxYr
	j
X-Google-Smtp-Source: AGHT+IG5pY9ZWt/x42cTmKktAWQXU77r3g1NJ93PY1cEg+ZgzNoMnGCHYfwW1EvcG+ghtIB8aggB5g==
X-Received: by 2002:a05:6402:5214:b0:5e0:e335:2f08 with SMTP id 4fb4d7f45d1cf-5e59f38b512mr484401a12.2.1741141046235;
        Tue, 04 Mar 2025 18:17:26 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:25 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
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
	Jeff Xu <jeffxu@chromium.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v9 4/7] mseal sysmap: enable arm64
Date: Wed,  5 Mar 2025 02:17:08 +0000
Message-ID: <20250305021711.3867874-5-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
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
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/vdso.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..282d6cb13cfb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
+	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8ed8e5b713b..69d2b5ceb092 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -198,7 +198,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	}
 
 	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
+				       VM_READ|VM_MAYREAD|VM_PFNMAP|
+				       VM_SEALED_SYSMAP,
 				       &vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -210,7 +211,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				       VM_SEALED_SYSMAP,
 				       vdso_info[abi].cm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -336,7 +338,8 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	 */
 	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
 				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYEXEC,
+				       VM_MAYREAD | VM_MAYEXEC |
+				       VM_SEALED_SYSMAP,
 				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
 
 	return PTR_ERR_OR_ZERO(ret);
@@ -359,7 +362,8 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	 */
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
 				       VM_READ | VM_EXEC | VM_MAYREAD |
-				       VM_MAYWRITE | VM_MAYEXEC,
+				       VM_MAYWRITE | VM_MAYEXEC |
+				       VM_SEALED_SYSMAP,
 				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
 	if (IS_ERR(ret))
 		goto out;
-- 
2.48.1.711.g2feabab25a-goog

