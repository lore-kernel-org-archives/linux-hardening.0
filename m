Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1D1E7C16
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978580; cv=none; b=DdZbIgqhmkBCIR6kXag9AjRH/2hhBt31YJ/b5D8OQ8DF8N38UDg7SxYA7MXKchqev3F6onYnOp379+54j/eqGxvE9bwsxt+7hbc4Z1Yag2huj0qWKc0LUcij7XdCSfgo9FQ3staqq+VHVz59hWFiAUjGWmOdfLeBx4w5ve5Xz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978580; c=relaxed/simple;
	bh=7zDlhtsN6IWTCHgfTa5SxUNOg/lpgS1kgV2r6nWpBoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOxTuWwKVAogO/7arV9M0QJBk+v4gG9rdumRgEKkAfLI/dxS9Q2V8tSByExy9zvqVNCsziANoAZI4gOalPMTitzlJCQMe4NMvyLuNKIW2b1nf5fVuZIFOVqmvZrbmxnUhiwx+Bq2QzYlxu/hVa77BpMn4fuDVnY2q3TShUUlRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dV79NVOz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dV79NVOz"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc191ca8baso774635a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 02 Mar 2025 21:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978577; x=1741583377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAoQrXrn6YJEh9Pobcge+uaEegOFqqBxGl0PnC+cOhU=;
        b=dV79NVOzTKjE5tvz08UdV11IDOtFZLcWwi5/rkKV6JB8ZxXdklyWHyDyfMSls1XuhU
         Q88K8700NktNr2kU7aQCeVqu73Fa04I3WT8SM0J+p5MIHutkw1jqbA12Ry7EGNMaubmn
         01ATJs+zmJh4M5w+RizP0roKiW7IUKF0g9H7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978577; x=1741583377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAoQrXrn6YJEh9Pobcge+uaEegOFqqBxGl0PnC+cOhU=;
        b=Aqh+iFO3ErOGYss8+5tOE8ft80qyUUuxQF59gggOLCLG1AsjiNHsG3huAJ7s1PrNZt
         424dFEUOV474fhJ6DTkneafjMnG6UkTdxoDxx37CvRaXMDUqYj2ovUFQhIe3Kma4hPdS
         P375HZhaHtIq/X5IfkIwhryBHM3ZL0tnejj0VRLeahge42kV76rUhtzv1kU98bPbn0yZ
         1YwWUyhtgecMlcHiRv0KZEdJQVgsANO8SaTpy+KCYbmmAQq3FEgxtjU5dEe6Sh7GvJEs
         ri+Uh3xHwbqMoEWqfufsUYZzm9x2HYbVwTbxE/B8ZH/y+mJlZvbCzXIUf2lpEuL2qbQK
         Y+iA==
X-Forwarded-Encrypted: i=1; AJvYcCXZyxYw4VCGK7+pxdxUslzijzwwV9GhkOL+OH3FKz4TA40pqj7hshI0lRQt8kGjzbYjLceqkJ5zJ5pf6xAGpXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+LvNWXNmrGTGahGXHizLYLw6M88p5S5iFGZCPU+8ZsMalAs6C
	y6rpsjMHtKk6eqFnxqdoabixY/wfqqMQ4m35yE9iOnHMBq//qbkGBUZ7GitRKg==
X-Gm-Gg: ASbGncucFypfD/n7ARmmFHqhA9Yq1zKyw0KBJEildgf0RRrypYM8r28Gi/+PGNg3CFV
	LTtxNO6wZlOrodDp2UMHivf8IbLoNbiCfTnNSbBK6EO8Qo2RZtdZQsqWkoqbzKhrXMmmPxE0UWl
	E5YF5cbe65Lky6zT980PJBpdF+2DIp9NEeLpN3uWMZGjGv17+ycWxAi3c4yd7oKQnRu/1j3xOru
	qPgoLYyFIOsUehivw5oYyhZG40xKgzpHcaiN7GqPHtzt6UWBdiErhfkWOOLdCmhTe9MqcuYDrxJ
	Ctqu7HDbdtKFPYPkn1Jh3rd68lDct3T0YoNk0Tzkxhr5C2m59fQq/hhloSPxW7dSegwfs7u05EH
	F
X-Google-Smtp-Source: AGHT+IFFf+CduNG846GcfkCLdAht/QDxEug4xx+ZimxDfLRqsASOv0BOjbMGqDHYYZSfdkiJ8c/g8Q==
X-Received: by 2002:a05:6402:35d2:b0:5e0:7ffd:a6ef with SMTP id 4fb4d7f45d1cf-5e4d6b42c58mr5147613a12.5.1740978577006;
        Sun, 02 Mar 2025 21:09:37 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:35 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v8 4/7] mseal sysmap: enable arm64
Date: Mon,  3 Mar 2025 05:09:18 +0000
Message-ID: <20250303050921.3033083-5-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
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

