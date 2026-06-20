Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BE285C84
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962610; cv=none; b=mjJr6jQaj+fU3OwcXP30HuQfbETH8VSbrVkKjyBPgMyeMH9Gp59qhRV/CzXHNp18m/H8Xzm5MqpG8OHkkqYa6/Irr/QoYmtRQOhVTSnPjppauIoyhOssE8tDg2lHnbDyGXxHX0jwd2e70O5mkzC7YUVVc4tIElgesz8Q8oKMbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962610; c=relaxed/simple;
	bh=YjoBEx2a/HHu4o3Bg+BWTGNtucT0PFo11dFxku0kI+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8dbAnALKOvIw/zM0yGQmYlde5fGhPNJdMk+MSagkFgnMgmrgSvpQVZzFVljgoAup9TtqywALA2u3MuiHH0gW3lu1tsB66rkGUQHgCLdqYus1qlHq9Zlfg5Ax42mUYS7PYDzvFgkT18efVr49fVxcxCcsLDyIlRTCgZGog8io/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=b7sonk3P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="b7sonk3P"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b9318997so20389375e9.2
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1781962608; x=1782567408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhgLCiK7WXqfymjRQ9sM4LifEbfV89Opl6MYqRlz6Q4=;
        b=b7sonk3PpYCrSdQV7r0i9J7qOVtIp5GFOQW2S3a0P9cB0hfnPmfYJrAZFpU7cJ2Hax
         Pzgp14ZLGoYxsINp81x8vk46pi+Ygs7RgQJxeb6CakUqod7jydKUx6D4Ym3fQki5LcOd
         eF+Qucv4q4clCybzVbYC3VXci4IiPdYoQ8hr81wgy++NYluIyIwZzSIPfmXuzfwHVMdV
         eoRPw+DtqMGnlpGcju/z65HgN03CiUso9JrvksWyMzwobeopXhjvMfzKsNR/Su2iav2d
         NAKYN1F8NEeAPDsS2XfK7LIsAHTVRGeromRF7SSnvWVsWC5nA5JNc7JtPSRCugzSzPCF
         5sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962608; x=1782567408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhgLCiK7WXqfymjRQ9sM4LifEbfV89Opl6MYqRlz6Q4=;
        b=aA0DLBNdN22UWEfzX6B9rH4b9a0u+bvA5hp6oqYR+gGNxqgV5IiN5JFNBxOHOon38Q
         PTVjdxGphl8lWaNW+jbYgPyJmhuLCRQBgpCN2dUe2GCNN1D0HKURhMZk571CyH6qXa9r
         u7eBO5lnFR4dEwVExL142sdVGgzyNorORM9M6rH4Y5b/Gr0CvbxYh1rI238oEKhJOllu
         k3VvnNj3lx/bjLuKX4+hJhQrXtKt4eaMPy0HR5EtfdKX2frrdauzkPSy7XVelKddIJOc
         7pLCaeKaurNCNw2cKUG7P4JgxsgYitDLFxv/MPfDZLmxtbDtbXswGvLi3jwQjNmvtq40
         +5CQ==
X-Gm-Message-State: AOJu0YxWBamsaEN13UEcW8i/1L4NYeGKr+sco8W+Iwy6nx4ZsiRaDm8A
	DLEPOWDwtB0tkwgNPWTC8dLPyKNKZXZ5Jp8atVG9VRs6/4XQEwvJ1FcsZmebxCFio4uoTwSG/Ul
	bd2fjdg==
X-Gm-Gg: AfdE7cneh1eeODe+JjUCwlAl3QEo2aXMcmHBdDvG7N+bT0xE9YexvxQqtsIu2lnS5aT
	uCuvPWU4UwRNYthglH+LCLaICQx/yuKwTPLkv1zDEVMAkXtetYbwU2jJCKenjpnETOI1uiuBwhx
	pbTre63bC+x2E8abd/aA805ndOpSK7y7eu6xKUpc4yWYgL8LkB6PWCuAaLYEDZwCvNOgvM96kb+
	TGQe2UW48iA7grXGpdfnnj9z17P1DvaamTQAt5cQivusTHVl24MYL/QBPrrhrDrX0dSMx5r/zEU
	8GnlNtipLf1YVUDTTx0k77cKRayETiklXq3jthFyTe9q899/Ek5iA1YqndV2ctzs2ldHK/wpyr6
	9jttrOD8B5FFStRE96x7c++Pmj8j3ohrFuFX6w98DsLlaIAHgGld/yVEiHUni6/G5oYP3WLN76u
	3UFK4hTxKQdf4JaVZEUMATzIPiZh0W7m7gsjt+QTIDH+joTlqEwOyRJxoKvhtsUbK2k91IjnSFW
	kAXH82GJ9ze/imV4C21XfnBvVBF
X-Received: by 2002:a05:600c:468c:b0:492:3c7e:57aa with SMTP id 5b1f17b1804b1-4923eeb494emr129000895e9.0.1781962606903;
        Sat, 20 Jun 2026 06:36:46 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00ab2024b6c6d10e76.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:ab20:24b6:c6d1:e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm229633205e9.0.2026.06.20.06.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:36:46 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v2 3/5] SPSLR build integration
Date: Sat, 20 Jun 2026 15:36:45 +0200
Message-ID: <20260620133645.95207-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620133222.94647-1-yjn@yjn-systems.com>
References: <20260620133222.94647-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 Makefile                              | 11 +++++++++++
 arch/x86/boot/compressed/Makefile     |  2 ++
 arch/x86/entry/vdso/Makefile          |  3 ++-
 arch/x86/kernel/vmlinux.lds.S         | 23 +++++++++++++++++++++++
 drivers/firmware/efi/libstub/Makefile |  2 ++
 init/Kconfig                          |  7 +++++++
 scripts/module.lds.S                  | 25 +++++++++++++++++++++++++
 7 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 68a8faff2543..2a080785fa2c 100644
--- a/Makefile
+++ b/Makefile
@@ -796,6 +796,17 @@ include/config/auto.conf:
 endif # may-sync-config
 endif # need-config
 
+# Supress warnings generated by newer gcc-16
+
+KBUILD_CFLAGS += -Wno-address-of-packed-member
+KBUILD_CFLAGS += -Wno-format-truncation
+KBUILD_CFLAGS += -Wno-unused-but-set-variable
+KBUILD_CFLAGS += -Wno-dangling-pointer
+KBUILD_CFLAGS += -Wno-unterminated-string-initialization
+KBUILD_CFLAGS += -Wno-format-overflow
+KBUILD_CFLAGS += -Wno-stringop-truncation
+KBUILD_CFLAGS += -Wno-stringop-overread
+
 KBUILD_CFLAGS	+= -fno-delete-null-pointer-checks
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..bd0685bb1ef3 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -44,6 +44,8 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
+KBUILD_CFLAGS += -std=gnu11
+
 # sev.c indirectly includes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
 # that the compiler finds it even with out-of-tree builds (make O=/some/path).
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1e..1ff6a1702df6 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -62,7 +62,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(PINPOINT_PLUGIN_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 $(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
 
 #
@@ -123,6 +123,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(PINPOINT_PLUGIN_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index feb8102a9ca7..5cedc439dea6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -185,6 +185,29 @@ SECTIONS
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
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ed4e8ddbe76a..cfc99d5a0e80 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,6 +20,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fno-asynchronous-unwind-tables \
 				   $(CLANG_FLAGS)
 
+cflags-$(CONFIG_X86_64) += -std=gnu11 -Wno-address-of-packed-member
+
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
diff --git a/init/Kconfig b/init/Kconfig
index c521e1421ad4..c0cf7fa7a491 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2052,3 +2052,10 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
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
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 3f43edef813c..82ccd1f27417 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -62,6 +62,31 @@ SECTIONS {
 		CODETAG_SECTIONS()
 	}
 #endif
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

