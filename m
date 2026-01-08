Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28542E4A6;
	Thu,  8 Jan 2026 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864499; cv=none; b=MUw+VTqh4rigXUiRc5ht3sqhEZu6t+tyNg11zZrCSdQ7R9jolNlT7893RRUSnTD5EcIGLDX6AJ1w/nv6yJCB2ZRFHUrqGHLcu90C6jLaLk9Ulb7Bt14MKT2Jl1nBoTC2oMgj+c75wil1Xm/xldliEb5MbM+JAOJnIcAlCtueo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864499; c=relaxed/simple;
	bh=f6s1uGXgrLK4vHXBiwNDDu102di+RfxKjHrwVzEXwQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmXNjExi4rE/DuIi13rBBtT5W7ztIEBHwx3KZWvct3tKU5IiRvvK+9HCbvTH9uXEwHn1klu4Bdsd6cqwuS+dElamd9HuO6sGZrVP3eDkKLdLIrYG6sCwqKNA53cLoyVKsZOlAqCe1sFUYwS+xMtJEJKb7AU6V3W+RbR5dH7DDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7KLSjEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7KLSjEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71ADC19425;
	Thu,  8 Jan 2026 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864498;
	bh=f6s1uGXgrLK4vHXBiwNDDu102di+RfxKjHrwVzEXwQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7KLSjEpUPCl/lKRdXv4EotSILrcnFh121Vq7ws+NSkm4qWwC7lOFhfDMcPKl/uM+
	 1qQaG+RDzGRhP5Qpdarxzy/Vw944TSZ/2PX8BTVN2wF33H7HAfQ0uWWkLNzzgKq8oa
	 +Rj4nQbRjWbBS2OydQOgFaoSZbnh5wvDNfbAd/Iuy6/oYFEXXDNl935djYttSZ7+LY
	 dIbnX6ff2/CE6wn/R3IY8W5ybctXQ8PhYFXQBpr/KonpSehd+6x2DQoWM7c/MJPWza
	 XH6Kf1UhScSmnBEIbQs1k6aS7Z/4gLoMn85C9VPm254NATDkCCzy5MAYenA4HqCvdy
	 Aqk7q2jslNW9Q==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC/RFT PATCH 08/19] x86: Use PIE codegen for the relocatable 64-bit kernel
Date: Thu,  8 Jan 2026 09:25:35 +0000
Message-ID: <20260108092526.28586-29-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6428; i=ardb@kernel.org; h=from:subject; bh=f6s1uGXgrLK4vHXBiwNDDu102di+RfxKjHrwVzEXwQk=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+QjAvz8bnqdE/XfuSFV9v3Wz8uPSuqO7qOo2IHUs/P qjfbMfYUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyYTbDX1mzpujgI+nLV32f fVP5e6zGKSelMxJr2DtkjJNWlkjdEGRkWF+illm6mnuP6zG2F2sNdM+07+Ju/Kcb0fH4yYM1L29 e4AYA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

As an intermediate step towards enabling PIE linking for the x86_64
KASLR kernel, enable PIE codegen for all C and Rust objects that are
linked into the kernel proper. Add a Kconfig option RELOCATABLE_PIE for
this, depending on RELR support in the linker, as the relocation tables
will blow up the kernel image otherwise.

This results in a code size increase of between 0.2% (clang) and 0.5%
(gcc). Performance (hackbench) appears to be unaffected across several
different uarchs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kconfig                  |  4 ++++
 arch/x86/Makefile                 | 19 ++++++++++++++++++-
 arch/x86/boot/Makefile            |  1 +
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/entry/vdso/Makefile      |  1 +
 arch/x86/realmode/rm/Makefile     |  1 +
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/hidden.h            |  2 ++
 8 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bf51e17d5813..b3a64cfe04cf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2067,6 +2067,7 @@ config PHYSICAL_START
 config RELOCATABLE
 	bool "Build a relocatable kernel" if X86_32
 	default X86_32
+	select RELOCATABLE_PIE if TOOLS_SUPPORT_RELR
 	help
 	  This builds a kernel image that retains relocation information so it
 	  can be placed someplace besides the default PAGE_OFFSET + 1MB. This
@@ -2087,6 +2088,9 @@ config RELOCATABLE
 	  it has been loaded at and the compile time physical address
 	  (CONFIG_PHYSICAL_START) is used as the minimum location.
 
+config RELOCATABLE_PIE
+	bool
+
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image (KASLR)"
 	select RELOCATABLE
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1d403a3612ea..b211d6c950aa 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -89,6 +89,8 @@ ifdef CONFIG_CC_IS_GCC
 CC_FLAGS_FPU += -mhard-float
 endif
 
+rustflags-nojumptables := $(if $(call rustc-min-version,109300),-Cjump-tables=n,-Zno-jump-tables)
+
 ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #
 # Kernel IBT has S_CET.NOTRACK_EN=0, as such the compilers must not generate
@@ -100,7 +102,7 @@ ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104816
 #
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
-KBUILD_RUSTFLAGS += -Zcf-protection=branch $(if $(call rustc-min-version,109300),-Cjump-tables=n,-Zno-jump-tables)
+KBUILD_RUSTFLAGS += -Zcf-protection=branch $(rustflags-nojumptables)
 else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
@@ -178,6 +180,21 @@ endif
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
 
         percpu_seg := gs
+
+        pie-ccflags-$(CONFIG_CC_IS_GCC) += $(call cc-option.-mdirect-extern-access)
+        pie-ccflags-$(CONFIG_CC_IS_CLANG) += -fdirect-access-external-data
+
+        # objtool gets confused by unannotated PIC flavor jump tables
+        pie-ccflags-y += $(call cc-option,-fannotate-jump-tables,-fno-jump-tables)
+
+        pie-cflags-$(CONFIG_RELOCATABLE_PIE) := $(pie-ccflags-y) -fpie -mcmodel=small \
+                                -include $(srctree)/include/linux/hidden.h
+        pie-rustflags-$(CONFIG_RELOCATABLE_PIE) := -Crelocation-model=pie \
+                                -Ccode-model=small -Zdirect-access-external-data=yes \
+                                $(rustflags-nojumptables)
+
+        KBUILD_CFLAGS_KERNEL    += $(pie-cflags-y)
+        KBUILD_RUSTFLAGS_KERNEL += $(pie-rustflags-y)
 endif
 
 ifeq ($(CONFIG_STACKPROTECTOR),y)
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 3f9fb3698d66..491b3b2a9a02 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -55,6 +55,7 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
+KBUILD_CFLAGS_KERNEL :=
 
 $(obj)/bzImage: asflags-y  := $(SVGA_MODE)
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index bc071bdcd11e..96099b5d1064 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -76,7 +76,7 @@ LDFLAGS_vmlinux += -T
 hostprogs	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDGRSTtVW] \(_text\|__data_segment_start\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
+sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABbCDdGRSTtVW] \(_text\|__data_segment_start\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
 quiet_cmd_voffset = VOFFSET $@
       cmd_voffset = $(NM) $< | sed -n $(sed-voffset) > $@
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index f247f5f5cb44..bf4221a0fc08 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -143,6 +143,7 @@ endif
 endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
+$(obj)/vdso32.so.dbg: KBUILD_CFLAGS_KERNEL :=
 
 $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso_and_check)
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index a0fb39abc5c8..70bf0a26da91 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -67,3 +67,4 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
 		   -I$(srctree)/arch/x86/boot
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS_KERNEL :=
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8ca130af301f..1782b6b87b2d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -373,6 +373,7 @@
 	*(DATA_MAIN)							\
 	*(.data..decrypted)						\
 	*(.ref.data)							\
+	*(.data.rel*)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	*(.data..unlikely)						\
 	__start_once = .;						\
diff --git a/include/linux/hidden.h b/include/linux/hidden.h
index 49a17b6b5962..2ad764c0ca18 100644
--- a/include/linux/hidden.h
+++ b/include/linux/hidden.h
@@ -16,4 +16,6 @@
  * giving them 'hidden' visibility.
  */
 
+#ifndef __BINDGEN__
 #pragma GCC visibility push(hidden)
+#endif
-- 
2.47.3

