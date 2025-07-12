Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823B28D83E
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348269; cv=none; b=H2vUMi570HaAytgvEh9FPGkE7fgoImo/afNLeiT08nRxtJzl0Kiz5V85MgDnnZMN/YXxzzGsZ9obcyYw4uuil5q1twWyXzR5cc5GO4YKYaIT/K5kCpgFx/7COWgQoatZUYO6qjQYuwsSdu7RFCJ+h9xSyn8+ZyTVmHxtBlO8aCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348269; c=relaxed/simple;
	bh=LbbwpvE4LNPgLr8P1gXF3EvfFlUdZ0jWYXZc4ZOLwG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mg0BeYysLOQypaezW7Hjlr0JR0NCKTEIDYjy/bm0TwdIcfFdQlSI8msM61ZZIaii6u241Zh5R4WNbcP3UPwtG1FeOuWlQR28bHqfMLCBPs3qGUjnuYuW3QVmD6+Q9Dkq74O4JWrD/mQrt8DcFRnqPg4MxCj4qasjixhfMU1Sbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htEt1elX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htEt1elX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234fcadde3eso39675355ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348267; x=1752953067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeLd+W3wCdzkK0sQdKmq4jwMf+Vu1LCOVBnFbzj2tgk=;
        b=htEt1elX2q7ocjNL+sX0DlxRqSXfQ+BwVWBsEtpPHwkq7xJmqKpFY/1WXecu6aSRvg
         E3z11Dxbe0BTe4JY/coLT1YTWhxDRi+xjzgVkLg1qAE0VQp/EBU079uV4ohZSgGJ+6PW
         cQut7BjEZRJP892CnJAKWB1TFWUw25FWII8A1PFz5ZkcJbbaBUatEc50xDh7k+PWbfPd
         G/eV9ftVzIZUcAWcMEc8Eq/JlNhXFt+xvNtBpIP3CsRMAMgNWZiX7uLKN3z1syT2Pn/j
         bllMdhc1V3FvcwLbhb3HhrtnMxgI7rxmkAOI5Xv8P7L/tiO5JS4Js4Xx2C4XApQdt/qU
         khEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348267; x=1752953067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeLd+W3wCdzkK0sQdKmq4jwMf+Vu1LCOVBnFbzj2tgk=;
        b=aAcaty7jmdR8uf31+i93OvFYs9M/HOmohWmdxvmKFukh/mjavIsdJJHVd13kvmdmC3
         KqsMK+rx2/wsY7v//fNNhttMDNzVRIBevfushFr8ZuAxQ3+0CCMzy33WJC1rKmMcS2yr
         vHerWohoMVIlW+7WQGYVWM++EGbf8YWxnyRm1uH2kBeXU2YYLK+a5ggn0dExc7phMrU9
         pWzAKNjyLsaIeprCkvcgIojADmjPsHlnJYvlpyHua6v3JJX1aV/9G7oymS0WkmPCr55w
         UhIBQ7Elk/kn+BsE0fGQSh+CNfsyP5TZztYg8SUg74gVCzkjYcyYmjh60KVPa6R/Rhss
         BjiA==
X-Gm-Message-State: AOJu0YyWZtrQ9rZTQc0rL3uPhEbvcp3FJney0VKgFCC/SxwkMFtQV4c8
	TyLZid7s4IrJ7Zjj1g0vpcCJd38ZN76eU4OALXlemE1w0c7/7lynPvFmwYU2VBOH
X-Gm-Gg: ASbGncvO+yTukrLF1lj1l1f7sYSANin1rxifuTS6LBlfLpafp6rhMgs5CSP23lCTg7c
	qa1BeT4kE9Wh/C1ixHcQCZ29TAyO8B9hHdWeRR96WNIH/21wH0L+mG+kL4z6y/0DSlwj56VUZHk
	LA9LZpS1XUizzO7WOQwGHTSgKFsLNisfNzvMFua0ZrByGH4t3oiy0qopWf/XDldmc5WOUFGNCZ0
	BTnq50AyROM4jK/knGrGLEMCFXg4ckYfsbmYUvBPX/oPQhuuVbDVxZnItitgVMq0LSvwwGPCbAY
	4Y05tj688CafilMDqASnTXN75Eu4CFzNKSP4qZMgyeBdcc1qYvQi3AK1c0RAc94mE8qHhNcT0yU
	E6PIJ7Q9DR0+WOnEZqCd7ci9coOM9Ov+1yghczRquFdk2
X-Google-Smtp-Source: AGHT+IGo/Na84eowa4mfftNOOv/h/tMzkCHOF9dkeITE+qlpxyjDsZ+mtZjIUyzJjPdk4NO4WfeXZQ==
X-Received: by 2002:a17:902:f642:b0:235:f4f7:a633 with SMTP id d9443c01a7336-23dee23846fmr103892695ad.28.1752348267374;
        Sat, 12 Jul 2025 12:24:27 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:26 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 16/17] x86: enable SafeFetch on x86_64 builds
Date: Sat, 12 Jul 2025 19:22:01 +0000
Message-Id: <20250712192202.707192-17-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Disable HAVE_ARCH_AUDITSYSCALL and HAVE_ARCH_SOFT_DIRTY. Both options
are untested with SafeFetch enabled as of right now.
---
 arch/x86/Kconfig | 5 +++--
 init/Kconfig     | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..b31a8a2dea71 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -31,7 +31,7 @@ config X86_64
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
-	select HAVE_ARCH_SOFT_DIRTY
+	# select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
@@ -194,7 +194,7 @@ config X86
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
 	select HAVE_ALIGNED_STRUCT_PAGE
-	select HAVE_ARCH_AUDITSYSCALL
+	# select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
 	select HAVE_ARCH_HUGE_VMALLOC		if X86_64
 	select HAVE_ARCH_JUMP_LABEL
@@ -203,6 +203,7 @@ config X86
 	select HAVE_ARCH_KASAN_VMALLOC		if X86_64
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KMSAN			if X86_64
+	select HAVE_ARCH_SAFEFETCH		if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
diff --git a/init/Kconfig b/init/Kconfig
index 666783eb50ab..5f365fa06fe8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -494,7 +494,7 @@ config HAVE_ARCH_AUDITSYSCALL
 	bool
 
 config AUDITSYSCALL
-	def_bool y
+	def_bool n
 	depends on AUDIT && HAVE_ARCH_AUDITSYSCALL
 	select FSNOTIFY
 
-- 
2.25.1

