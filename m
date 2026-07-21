Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72310433BD1
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662454; cv=none; b=BnVPP4s+RGd58vevokKaGC2Zd4+532wf+B3H75N/PK8I44zaZplef+JAcs04gHHz9bWt45BtrqM8aYB5aUtdY5sFlFW1RrIqs/qjKgGht5uaiNPUl/gAYPmYLYhKuggpuAUeMFh8ArwQaOGeXxP42FDX42DuMKz8g67fepv36UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662454; c=relaxed/simple;
	bh=q9tKasJODhxuamqMbLuwA6eb7eF64uPMIhBsY/ef0YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVjfZ7wjSqJ9EViZwukla9sMoqOS2Fu8S8bjteq0b5Giw6XctI7UN7AM/Mwk6JTeAHxaU+R+H1p3s/hMA5WxKE6oCSZjBaG1X5OAPiVU9++VBr76KBNi1xNjzSCl+NHapAo6gd/BdYOIUjTZoOsBAD7lt3we6eCR744zfjSG130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=e7MGRmaZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="e7MGRmaZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so84769055e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784662450; x=1785267250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siCct2qjGKGUsGGrOHYqLXtqNVkHZzXvzf5ktvpWkms=;
        b=e7MGRmaZNuRgIlZlivK8jIGW2JO9xvSGyOR+m7YKkYRVyhQqsONeeADE5QDr7ufSGC
         pf0pp6q3tsN2Q6DAHaVnX96WFGJAAPi/h9XleQLifNx78HpOZRQcslzmLsjFngwQs0nS
         27+A+zU4F9KFNkyJUok6d/LF9xLj6EEKp20UqqI5jEs4Bs01rO+l49fMgES5a6K9MoO5
         w62xJXrxNmcaoN2A+IVV0TMbvxAunVYmcBizBkD4jumHbVwfbSexmrxfegAsbCIAhA4V
         iiDox73lywetLO7uVQMo8uSDz34RFrUdCH6G+WpZVzRv9tKfxMt07DKu90DFHDZxJVbr
         wGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662450; x=1785267250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=siCct2qjGKGUsGGrOHYqLXtqNVkHZzXvzf5ktvpWkms=;
        b=YZ70qD//EY7glgU1FuhUvJawhqEL11ZJ91fDMBYoWWCAFxoU05WDGRdMGlPZfAP3x0
         i3WP210jNifaQD2l9Uy5NokuxdRzaeRZgJRnZc+YwNFFlscPDKiqXOfT7btCJQTG/0Lz
         ypR/5p5f8kup7rwTYnC5oCL8hlQYtVZzx+inltBtx93nYEX0bvvA8CXClWASKsntWjoQ
         hbKRy7BriHROQjXYqwsv4ckghk1VsH2P46Lje9qWxRCLTprF5bTBWGDkqIeiQlO3btsZ
         j2JHBfYV+z77VhqWQRphkwZkqI3HmIj7D2neQejpCEI99tSlYLh79Ue5YthFs4phB79j
         d7Pg==
X-Gm-Message-State: AOJu0Yzh8ociF/Zb8JNrb5HKE0/r/V9cJz8zHDtcdaFBDQyElwQqoi+Q
	EhaUv90P8g0V6VcwbBGKuj6c/yp+xi2gj2XiZ0m5U+uVNqoDqkrUWWiFCuNMy+c32zByd3GLqqn
	sQJhpauKo
X-Gm-Gg: AfdE7clcBxmU6S+8KPaefcrMhJwxwKlDJbtILflBn5gyNIs1afvIGcjZr0Quzqy+7sK
	nXa8ce+cn0m+pjFYd2a8dYpaVu5FCQLfEUxMtfDGXty7C+km924p8Ptg+ohjmb1us2fpYqsgIMj
	kA1Qql1RjJUjMdcok8sBfQuJm+3VxfuEDzaW//SdqiCsavC2hc+IKPd76jk5E23FPqzAjT4iv22
	69KuYzbIK3yGRl5lfi+B810HLhheQ4mBdRGKxOIM8zrIqPxXVSzPj2am+U23cY/OkyVrBSi/OAS
	fcDaGGwTWgD7sYkIj5beXr6AqjVuHj3cT9lTDhVVTy56yy1MZ1+HlVD0gvRtBZG7h28fi1Qr7K6
	JWef60EUZFf7TeMkgUFiFYEdmrrmCUvZP7Nr8HZZnNiZX/QmBwsymaTToK0JIiUVBI9eVaCYCPt
	CusnibW7caspEV8qdAfnnOKGYV7mrZQw7BTzZGLX3GLiQN1f0k9cNAxgcl4Bx8wwM4ewBoMvUGS
	FzzU37wlfW9uCrtotA=
X-Received: by 2002:a05:600c:45d5:b0:495:4056:9473 with SMTP id 5b1f17b1804b1-4954a40d0c3mr220932055e9.28.1784662449693;
        Tue, 21 Jul 2026 12:34:09 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00a6ccab16241b6894.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:a6cc:ab16:241b:6894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a6354a3sm22368195e9.10.2026.07.21.12.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:34:09 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org,
	gregkh@linuxfoundation.org
Subject: [RFC v3 3/5] SPSLR build integration
Date: Tue, 21 Jul 2026 21:34:08 +0200
Message-ID: <20260721193408.46477-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720191311.21619-1-yjn@yjn-systems.com>
References: <20260720191311.21619-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reposting this patch with a proper commit message following Greg's
comment. No functional changes.

This patch integrates the Bootpatch-SLR prototype into the kernel build
system.

It introduces the CONFIG_SPSLR and CONFIG_SANEMAKER options, adds the
linker script support required to retain and locate the metadata emitted
by Pinpoint, and defines the linker symbols consumed by the Selfpatch
runtime.

The early x86 startup code and the vDSO are excluded from Pinpoint
instrumentation. Startup code executes before Selfpatch has applied the
runtime patches, while the vDSO is intentionally kept independent of the
kernel image.

Together these changes provide the build-time integration required for
the compiler-generated metadata to reach the runtime patching
infrastructure.

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 arch/x86/boot/startup/Makefile              |  4 ++++
 arch/x86/entry/vdso/common/Makefile.include |  2 +-
 arch/x86/kernel/vmlinux.lds.S               | 23 +++++++++++++++++++
 init/Kconfig                                | 13 +++++++++++
 scripts/module.lds.S                        | 25 +++++++++++++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index 5e499cfb29b5..1fa601781546 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -12,6 +12,10 @@ KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 # disable ftrace hooks and LTO
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+
+# Startup code executes before Bootpatch-SLR applies its runtime patches.
+KBUILD_CFLAGS	:= $(filter-out $(PINPOINT_PLUGIN_CFLAGS),$(KBUILD_CFLAGS))
+
 KASAN_SANITIZE	:= n
 KCSAN_SANITIZE	:= n
 KMSAN_SANITIZE	:= n
diff --git a/arch/x86/entry/vdso/common/Makefile.include b/arch/x86/entry/vdso/common/Makefile.include
index 687b3d89b40d..d8cc53cd9560 100644
--- a/arch/x86/entry/vdso/common/Makefile.include
+++ b/arch/x86/entry/vdso/common/Makefile.include
@@ -27,7 +27,7 @@ flags-remove-y += \
 	-mfentry -pg \
 	$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
 	$(RETPOLINE_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
-	$(PADDING_CFLAGS)
+	$(PADDING_CFLAGS) $(PINPOINT_PLUGIN_CFLAGS)
 
 #
 # Don't omit frame pointers for ease of userspace debugging, but do
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 74e336d7f9dd..aa71c2c2a756 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -200,6 +200,29 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+#ifdef CONFIG_SPSLR
+		__spslr_start = .;
+
+		. = ALIGN(8);
+		__start_spslr_units = .;
+		KEEP(*(spslr_units))
+		__stop_spslr_units = .;
+
+		. = ALIGN(8);
+		__start_spslr_targets = .;
+		KEEP(*(spslr_targets))
+		__stop_spslr_targets = .;
+
+		. = ALIGN(8);
+		KEEP(*(spslr_target_layouts))
+		KEEP(*(spslr_cu_target_refs))
+		KEEP(*(spslr_ipins))
+		KEEP(*(spslr_dpins))
+		KEEP(*(spslr_strtab))
+
+		__spslr_end = .;
+#endif
+
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c..2110aff8a5c8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2316,3 +2316,16 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
+
+config SPSLR
+	bool "Selfpatch SLR prototype"
+	depends on X86_64
+	depends on CC_IS_GCC
+	help
+	  Experimental structure layout randomization prototype.
+
+config SANEMAKER
+	bool "Selfpatch SLR validation tooling"
+	depends on SPSLR
+	help
+	  Experimental validation tooling for Selfpatch-SLR.
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index b62683061d79..e366be317115 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -62,6 +62,31 @@ SECTIONS {
 	}
 
 	MOD_SEPARATE_CODETAG_SECTIONS()
+
+#ifdef CONFIG_SPSLR
+	.spslr : ALIGN(8) {
+		__spslr_start = .;
+
+		. = ALIGN(8);
+		__start_spslr_units = .;
+		KEEP(*(spslr_units))
+		__stop_spslr_units = .;
+
+		. = ALIGN(8);
+		__start_spslr_targets = .;
+		KEEP(*(spslr_targets))
+		__stop_spslr_targets = .;
+
+		. = ALIGN(8);
+		KEEP(*(spslr_target_layouts))
+		KEEP(*(spslr_cu_target_refs))
+		KEEP(*(spslr_ipins))
+		KEEP(*(spslr_dpins))
+		KEEP(*(spslr_strtab))
+
+		__spslr_end = .;
+	}
+#endif
 }
 
 /* bring in arch-specific sections */
-- 
2.43.0

