Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61976386C1C
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574797; cv=none; b=TgmhR9qphMJsUv64bj/HcFHIMUChRwfUZDCdtuTMxjIE6wfQRg0/LCGckwLAYviNoe8vhYNc0wVlLbikiNqZr1EkB35ZVPAnqAatqBJ08c8mLH0RFPcfgWXc8mzr2bkoNjsv69drDT7si7UvSGws8b3XApLmuuCRQe08bKR6DS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574797; c=relaxed/simple;
	bh=N3MHexzpZGb34a2VrVrJbevD3q35nOnf2KzdfaFS0mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfqXZ/wo1ruyJHURlJDmCCTzwjXbhld+2t1HshDoK1z5OK0SaGyomDwbiFthYVWDvtbpWspWqQyUa1QosZhkfb2kGvJ/20y6/ckGewka+g7UwpqgFD2AWSZeVm2CQxJ82AoCRmjOXpGZ6VH7vUJmjaxU578cGxknOXA7X5Yvfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=gbSiG6V8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="gbSiG6V8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso12844675e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784574792; x=1785179592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ke8s+Qt7PFdWHYg6VNVwDsTCuUnKvOxYTBtLz7+F8fI=;
        b=gbSiG6V8wd8tAb+DijDe6ZurzcOOLbLOcG68VjApf7xOO0GLc173XaPJjkXdlgpgvP
         tcAk6RFQNG5KKOev4xS1ZFY9wb0VuT0qbh79Z2VcicOhDeRJTvuVqtYxYzhLWiFUUmuy
         4Rigx5MIYmIgtieTeXN/5smaR25lPv5As2aU2ZoGS7IAswacFgK90CuoXq7m6hdC5/nO
         ni8fx3PNto/JwUC1Kg2pWS/e2oKySoVaF5W2Mt8SCSdJYnDHGpkBIpt3na34LDrYNW/y
         kIdiEMalbuDOO5cBWMzyOupZTWCgErWqvAqtHtsNzoN4hnm8pnd6AngzQvM+JCCb6JI0
         3Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574792; x=1785179592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ke8s+Qt7PFdWHYg6VNVwDsTCuUnKvOxYTBtLz7+F8fI=;
        b=LSifZ+TyU2ZWt+OcNeQIZfM6f/nNQzMPvmvanmT/ejpkYN2VlBWWqFqLjvnWF/ViW9
         SnqMYxacyvcU0AEYRUGM7g0ESR5Ki8t0Nvc0H2dWPHfA/IOlAy8BZAMMt3tFx4UjG2Nl
         oOWm7KIAoPhuhL9tc330PB0qAVSefgb5qGGMGF95S5OjPx703EqotJ5i2pf/j+puqmz3
         fYSTHgFDPlVLWO4mlN9xgY/09d+XpcKVUDCvufTBOXTFaktXS54q+RTbXMuoEER6ZsbP
         a2l1+j3I6JckzwZ3h2DKa4UjcX52/71PMR6XjDUlFPg4PmaBzatLMdW2y1+jIk8GMMGB
         8h3w==
X-Gm-Message-State: AOJu0YyP7g+/DHau2eeNAx4XHXVYv50dK9UDMk0xTDwek3nA1a1nP6wS
	iFuu70xJjn/q7QY2vQmOaS0bb4bvHHqwhuXLkDXSclEx5ofXDQBEvAPlamJCu835I2D53dkk6Ju
	ZwtBvsqwT
X-Gm-Gg: AfdE7clI43gZ4yXcScVoTbnZeAaXVUElwBOzZT/1nbe4mNAdsSKB4yphCSVkNnURb8T
	bwq5MLqIrsZ2h2NNV1xfmKXYdPm/0M6dXbS+gUaA1Na2tStq1XYEUTbZx/vGwCOlzdaiQxBUhxw
	Y+Y/+Yln35sbLHruaGHDztlqOYFTkNJxrs/p3wA4FG39xe/oL2mWNw3LRbKmdoPLEfhTwynKddY
	ljGlKZZ1QT99TqGzWB1WdwQkb1WV6Zq39hKgl8X9AdJkWaJaH2y8AY2S11mZpm8DXRemCt5zfyL
	zUkj370sDqEB7XruJKrAdTFcOdUGzAFGcKsBmz2SPIO2JVQulpO00aH8n9fgZxhYXxyMbxiX85x
	1g8YCx3pbkSypicHMdwZre2mzUyADKe22l9AL4JxFwvRKqyIL4gP1Ds1tH6D4PKvT9lGBeo6k/O
	4TD8PXeZUBxexhcKYcPciJc4NLp5zC6u8/mL107mkChi/rkogixrg2c2WbLrP7+stLqmoAxwx74
	zXRGzywTxVxWkhsg28=
X-Received: by 2002:a05:600c:c10c:b0:495:56d4:3077 with SMTP id 5b1f17b1804b1-49556d432b4mr120347025e9.17.1784574792592;
        Mon, 20 Jul 2026 12:13:12 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00c9c364f8ed993120.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:c9c3:64f8:ed99:3120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547323bsm8754025e9.4.2026.07.20.12.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:13:12 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v3 3/5] SPSLR build integration
Date: Mon, 20 Jul 2026 21:13:11 +0200
Message-ID: <20260720191311.21619-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720191146.21473-1-yjn@yjn-systems.com>
References: <20260720191146.21473-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

