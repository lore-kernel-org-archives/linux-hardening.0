Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5B3803DB;
	Sat, 10 Oct 2026 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620360; cv=none; b=IWoYOyqhnwvOXjWlATtGNNyVPzhogMVKS1aQXhBzuPwcBPnAELp05OksFd7vRhtTFqb+YE2qx9nIYVUP85gare/tP29bTY4rZ8vRrWPNo0YpcqFPzDfKm7YOFsOGq4e095/QeEq56DY3K22YSWHdjH/e4ZqHUJb9mvJxcuVL77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620360; c=relaxed/simple;
	bh=3dxAy3XxqoV0kIjJ+fejECq8Xr3Ui5Qy2JhhBHUeqPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEbIwjKMFtAoDhOEZFYjDFoNqmzmq7MyaGtkfvz1PpgAmUXgqRCjITE99nHe5tvUueO7X5QpD6tSWpKiNaSlh/j7DJF8M7LjwkX95udPDQznaQsSYXmk+Wf8RFDmcR74VGiH5LwZdo4BxN8zZ/SLRILiRnrv25ov9ZMXemUelmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8eI0fuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8eI0fuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D495D1F000FF;
	Sat, 10 Oct 2026 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791620354;
	bh=jbrxToL9h+mh+x8TvDBXiXTUfIGGsVunMTIPlJq7gv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8eI0fuhzMmBMrkKQhKreHm77JjUWrFNiT1Zu1MBhoCalLeDw3nvvzWYWO95fsRA1
	 gfn93b0jKOUJ9/LQFcTYqcwHvJ9UAdafX9D4GStRt8RK3E9MVm1ZdazpM9UFcLOjX8
	 R+vUxa5hj9XHpwdRIINeGpxDNF2nrMAKvcbLCgiNLfFC7qTIAFyj3/4oodi0OGk8RS
	 JyCq2cIf4+VcBUxjYfLV8MFYdx3YHpRgHFvavZ8G+EnX3jamljdXrmwwFmbFc6nz3T
	 x2oMof/YKHNqqdXRMgeKvfsUcuNqmbELvLGF8OtiMB/+S9mbIWp+YNCeei3ovLaw8G
	 XYWayMa3uTuKw==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kbuild@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nicolas Schier <n.schier@fritz.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] kbuild: Mark the gzip recipes as recursive
Date: Sat, 10 Oct 2026 01:19:10 -0700
Message-ID: <20261010081914.540611-1-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010081910.stay.092-kees@kernel.org>
References: <20261010081910.stay.092-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13636; i=kees@kernel.org; h=from:subject; bh=3dxAy3XxqoV0kIjJ+fejECq8Xr3Ui5Qy2JhhBHUeqPI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFknv/xj27R58btzF36/4tV6NeHysvksD2sL/x15sKw0f Q0/X8G8DR2lLAxiXAyyYoosQXbucS4eb9vD3ecqwsxhZQIZwsDFKQATUTnDyHBY897qZSJiZprP 5BN220q53iiW22vUFVY+05y78xbvztWMDHvnrL2vd/ry9+fFvVVsQiuK/v/vSY5gKBT4cT3j/o/ y2dwA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since commit 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if
available"), cmd_gzip runs pigz through scripts/jobserver-exec, which
takes the job slots make has free. GNU Make passes the jobserver pipe
only to recipes it treats as recursive, but leaves --jobserver-auth in
MAKEFLAGS for all of them. The make 4.3 in CentOS Stream 9 also hides
the pipe in sub-makes (a backport of the fix for GNU Make bug 58232), so
jobserver-exec cannot open it, runs pigz on one thread, and prints:

  WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')

Mark every recipe that can run cmd_gzip as recursive with "+", as
commit ecab4115c44cc ("kbuild: mark `rustc` (and others) invocations as
recursive") did for rustc. Besides the $(call if_changed,gzip) rules,
this covers those that choose gzip through a variable: the built-in
initramfs in usr/Makefile (which rcutorture's kvm.sh builds), the EFI
zboot image, and the arm, csky, and mips compressed images. As with
rustc, "make -n" now runs these recipes, including those that choose
through a variable when they select another compressor. Also update the
gzip entry in Documentation/kbuild/makefiles.rst, as suggested in
review.

Tested with GNU Make 4.3 plus CentOS Stream 9's make-4.3-cloexec.patch,
GCC 16.2.0, and -j64, on ARCH=x86_64, arm64, and arm defconfig, and
ARCH=x86_64 defconfig with a built-in initramfs: none of them prints the
warning, and pigz gets the free job slots (-p 54, 64, and 50 for the
kernel image). Without this change, the x86_64 builds print it for the
kernel image and for the initramfs.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Closes: https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/
Fixes: 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if available")
Assisted-by: LLM
Reviewed-by: Nicolas Schier <n.schier@fritz.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/alpha/boot/Makefile                    | 4 ++--
 arch/arc/boot/Makefile                      | 2 +-
 arch/arm/boot/compressed/Makefile           | 2 +-
 arch/arm64/boot/Makefile                    | 2 +-
 arch/csky/boot/Makefile                     | 2 +-
 arch/microblaze/boot/Makefile               | 2 +-
 arch/mips/boot/Makefile                     | 2 +-
 arch/mips/boot/compressed/Makefile          | 2 +-
 arch/nios2/boot/Makefile                    | 2 +-
 arch/parisc/boot/compressed/Makefile        | 2 +-
 arch/riscv/boot/Makefile                    | 2 +-
 arch/s390/boot/Makefile                     | 2 +-
 arch/sh/boot/Makefile                       | 2 +-
 arch/sh/boot/compressed/Makefile            | 2 +-
 arch/sparc/boot/Makefile                    | 4 ++--
 arch/x86/boot/compressed/Makefile           | 2 +-
 arch/xtensa/boot/Makefile                   | 2 +-
 usr/Makefile                                | 2 +-
 drivers/firmware/efi/libstub/Makefile.zboot | 2 +-
 Documentation/kbuild/makefiles.rst          | 7 +++++--
 20 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/alpha/boot/Makefile b/arch/alpha/boot/Makefile
index d8dba85e606c..b050753e9015 100644
--- a/arch/alpha/boot/Makefile
+++ b/arch/alpha/boot/Makefile
@@ -40,7 +40,7 @@ endif
 
 # Compressed kernel image
 $(obj)/vmlinux.gz: $(obj)/vmlinux FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 	@echo '  Kernel $@ is ready'
 
 $(obj)/main.o: $(obj)/ksize.h
@@ -85,7 +85,7 @@ $(obj)/vmlinux.nh: vmlinux $(OBJSTRIP) FORCE
 	$(call if_changed,objstrip)
 
 $(obj)/vmlinux.nh.gz: $(obj)/vmlinux.nh FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 $(obj)/tools/lxboot: $(obj)/bootloader $(OBJSTRIP) FORCE
 	$(call if_changed,objstrip)
diff --git a/arch/arc/boot/Makefile b/arch/arc/boot/Makefile
index 5a8550124b73..8a44c3e7ff3e 100644
--- a/arch/arc/boot/Makefile
+++ b/arch/arc/boot/Makefile
@@ -23,7 +23,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 $(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzma)
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index e3f550d62857..5f0a1a2e915a 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -153,7 +153,7 @@ $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.o \
 	@$(check_for_bad_syms)
 
 $(obj)/piggy_data: $(obj)/../Image FORCE
-	$(call if_changed,$(compress-y))
+	+$(call if_changed,$(compress-y))
 
 $(obj)/piggy.o: $(obj)/piggy_data
 
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index b5a08333bc57..d42d07667822 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -26,7 +26,7 @@ $(obj)/Image.bz2: $(obj)/Image FORCE
 	$(call if_changed,bzip2)
 
 $(obj)/Image.gz: $(obj)/Image FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 $(obj)/Image.lz4: $(obj)/Image FORCE
 	$(call if_changed,lz4)
diff --git a/arch/csky/boot/Makefile b/arch/csky/boot/Makefile
index c3cfde28f8e6..5d88dc31877b 100644
--- a/arch/csky/boot/Makefile
+++ b/arch/csky/boot/Makefile
@@ -12,7 +12,7 @@ compress-$(CONFIG_KERNEL_XZ)   = xzkern
 compress-$(CONFIG_KERNEL_LZ4)  = lz4
 
 $(obj)/zImage:  $(obj)/Image FORCE
-	$(call if_changed,$(compress-y))
+	+$(call if_changed,$(compress-y))
 	@echo '  Kernel: $@ is ready'
 
 UIMAGE_ARCH		= sandbox
diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index 2b42c370d574..e3df3a64808a 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -14,7 +14,7 @@ $(obj)/linux.bin.ub: $(obj)/linux.bin FORCE
 	$(call if_changed,uimage)
 
 $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 quiet_cmd_strip = STRIP   $< $@$2
 	cmd_strip = $(STRIP) -K microblaze_start -K _end -K __log_buf \
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 8473c4671702..996bf41b78de 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -63,7 +63,7 @@ $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,bzip2)
 
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 $(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzma)
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index e0b8ec9a9516..2684540758a8 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -69,7 +69,7 @@ tool_$(CONFIG_KERNEL_ZSTD)    = zstd22_with_size
 targets += vmlinux.bin.z
 
 $(obj)/vmlinux.bin.z: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,$(tool_y))
+	+$(call if_changed,$(tool_y))
 
 targets += piggy.o dummy.o
 
diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
index 29c11a06b750..1381e6e428a8 100644
--- a/arch/nios2/boot/Makefile
+++ b/arch/nios2/boot/Makefile
@@ -18,7 +18,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 $(obj)/vmImage: $(obj)/vmlinux.gz FORCE
 	$(call if_changed,uimage)
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 14eefb5ed5d1..a7fc7d424c00 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -55,7 +55,7 @@ suffix-$(CONFIG_KERNEL_LZO)  := lzo
 suffix-$(CONFIG_KERNEL_XZ)  := xz
 
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,bzip2_with_size)
 $(obj)/vmlinux.bin.lz4: $(obj)/vmlinux.bin FORCE
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 4a2d75b7e42d..b80a077a8e8f 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -23,7 +23,7 @@ $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/Image.gz: $(obj)/Image FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 $(obj)/loader.o: $(src)/loader.S $(obj)/Image
 
diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 10b75e053a6f..e8e43ae80dd5 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -117,7 +117,7 @@ suffix-$(CONFIG_KERNEL_XZ)  := .xz
 suffix-$(CONFIG_KERNEL_ZSTD)  := .zst
 
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,bzip2_with_size)
 $(obj)/vmlinux.bin.lz4: $(obj)/vmlinux.bin FORCE
diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index 1f5d2df3c7e0..cf63e319b786 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -66,7 +66,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,bzip2)
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 58df491778b2..b85aa5f0d616 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -39,7 +39,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,bzip2_with_size)
 $(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 339c42d35089..b53cf596611e 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -23,7 +23,7 @@ ifeq ($(CONFIG_SPARC64),y)
 # Actual linking
 
 $(obj)/zImage: $(obj)/image FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 	@$(kecho) 'Kernel: $@ is ready' '(#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
 
 $(obj)/vmlinux.aout: vmlinux FORCE
@@ -45,7 +45,7 @@ $(obj)/image.bin: $(obj)/image FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/image.gz: $(obj)/image.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 UIMAGE_LOADADDR = $(CONFIG_UBOOT_LOAD_ADDR)
 UIMAGE_ENTRYADDR = $(CONFIG_UBOOT_ENTRY_ADDR)
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6ec5e031db1d..680ad803cba7 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -133,7 +133,7 @@ vmlinux.bin.all-y := $(obj)/vmlinux.bin
 vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
 
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,bzip2_with_size)
 $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index d8b0fadf429a..934f9015b15f 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -36,7 +36,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,gzip)
+	+$(call if_changed,gzip)
 
 boot-elf: $(obj)/vmlinux.bin
 boot-redboot: $(obj)/vmlinux.bin.gz
diff --git a/usr/Makefile b/usr/Makefile
index 5b97ee66c00a..975c68e5b6b6 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -76,7 +76,7 @@ $(obj)/initramfs_data.cpio: $(srctree)/scripts/gen_initramfs.sh scripts/gen_init
 endif
 
 $(obj)/initramfs_inc_data: $(cpio-data) FORCE
-	$(call if_changed,$(compress-y))
+	+$(call if_changed,$(compress-y))
 
 targets += initramfs_data.cpio initramfs_inc_data
 
diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 832deee36e48..52baacf3e9d9 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -24,7 +24,7 @@ zboot-method-$(CONFIG_KERNEL_ZSTD)	:= zstd22_with_size
 zboot-size-len-$(CONFIG_KERNEL_ZSTD)	:= 4
 
 $(obj)/vmlinuz: $(obj)/vmlinux.bin FORCE
-	$(call if_changed,$(zboot-method-y))
+	+$(call if_changed,$(zboot-method-y))
 
 # avoid eager evaluation to prevent references to non-existent build artifacts
 OBJCOPYFLAGS_vmlinuz.o = -I binary -O $(EFI_ZBOOT_BFD_TARGET) $(EFI_ZBOOT_OBJCOPY_FLAGS) \
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 7521cae7d56f..535d30eef59a 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1452,13 +1452,16 @@ objcopy
   OBJCOPYFLAGS_$@ may be used to set additional options.
 
 gzip
-  Compress target. Use maximum compression to compress target.
+  Compress target. Use maximum compression to compress target. Prefix the
+  recipe line with '+' so that GNU Make passes it the jobserver, which
+  scripts/jobserver-exec needs to run pigz (if available) on the free job
+  slots.
 
   Example::
 
     #arch/x86/boot/compressed/Makefile
     $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
-            $(call if_changed,gzip)
+            +$(call if_changed,gzip)
 
 dtc
   Create flattened device tree blob object suitable for linking
-- 
2.55.0

