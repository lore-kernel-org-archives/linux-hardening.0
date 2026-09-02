Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F5463B7B
	for <linux-hardening@vger.kernel.org>; Wed,  2 Sep 2026 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392033; cv=none; b=nGIzGe4NqFfXMTwVFHneNZTdClhNAItcsujy1ZPJ8ydP6i1EUm6z+U6yUwRWQuuuLz36wPahL1Jy0tlls/L7zbv1LYQQFdm/tOGp8R2+qsY7xI3Jo5e1dSLFPK9hRxm97TUJVtiviQ/szVIvFlrKqZjSPJCYjutnAyJGDcj/PQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392033; c=relaxed/simple;
	bh=YBBqoNGwSBN6aJDBkx1543WZpG1V9ijXD+xuliG1uqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0WVmjlAdY4wBUZg5RY0g+OOW5Bq5RAi5Vg98H7sCP8uq+xjLUHLvbhv5SNP96kycpMwKy2SQpjvYGuF9IVjw/F2rVpmr0nDkNthQR9TP5yf2/TPZ3rofWXmPMkHhZSn4XsIE/bS84wbQr5x5D02drlFozpFvk08Dba/i+KsojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crxgzxuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crxgzxuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669851F00A3E;
	Wed,  2 Sep 2026 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788392029;
	bh=SA3sQLykc6YKvN6xpkpvopzgs1/vPOIToNcvtdewKKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crxgzxuSJL5ClEjZijzrfjpauVsfZsHc1/qM5imojPIvCwv+CQIIB16EGPMkZGqET
	 5MSVJyRUEoAbdldiNYDHLeE31FrKr3i/VrhOs/c6wzi4i5NUFFj2HYOzKcNggC01BX
	 kAJszZrgoVm4hxzOCw1S9NjH2YzphnYlcFmGvSNCCL9XTRq1uaq1Brtw9XJnKzlDKx
	 tBD4WoSPEJGOLKK1iCTtcY23bCepnEvyS0y1SvWTFVSufyujyNF/ONHXFNgHXZcwIS
	 QeP1Um9Ue+KdEOzMvPFgqTQSv5+pPWwrhCILtUHNNCd8e3vTnEKO4+sYglIB2msLhB
	 KMFlXtaL9/HYQ==
From: Kees Cook <kees@kernel.org>
To: York Jasper Niebuhr <yjn@yjn-systems.com>
Cc: Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	franzen@sec.in.tum.de,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] gcc-plugins: pinpoint: move to subdirectory
Date: Wed,  2 Sep 2026 16:33:43 -0700
Message-Id: <20260902233349.1996922-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902233338.i.375-kees@kernel.org>
References: <20260902233338.i.375-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14428; i=kees@kernel.org; h=from:subject; bh=YBBqoNGwSBN6aJDBkx1543WZpG1V9ijXD+xuliG1uqI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkzNoVzmUVHPOyarrMsIu3C9FtdvQvue909KXfJN/OYH zP7/r1SHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABMR/c3IMGuWeHTpzthza5Yb zeLik3DavjzFXnSOxZb7b+S5IryZExkZdu7+bhDTK5F8f77viU3xc2RvBpnIX5ny0jV0k/vPFw+ O8gAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Pinpoint adds 35 files directly to scripts/gcc-plugins/, a directory
shared with the other plugins, using generic names such as serialize.c,
passes.h, layout_hash.c and target_registry.c, plus twelve safe-*.h
wrappers. Move them into scripts/gcc-plugins/pinpoint/ so they no longer
crowd the shared namespace, matching how the rest of the series is laid
out (kernel/spslr/, samples/spslr/tasklist/).

Build tested ARCH=x86_64 defconfig+CONFIG_SPSLR=y with the patched
GCC 16.1.0 / GAS 2.46.1 toolchain, using O= (out-of-tree). Boot tested
under QEMU to a busybox userspace: two randomized boots and one
"nospslr" control all reach userspace and complete a task_struct
exercise (ps, /proc/self/{stat,status}, 200 fork+execs, signals, pipes,
timers) with zero oops/BUG/WARNING.

Assisted-by: Claude:claude-opus-5[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 scripts/gcc-plugins/Makefile                  | 32 +++++++++----------
 .../{ => pinpoint}/asm_offset_pass.c          |  0
 .../{ => pinpoint}/dpin_registry.c            |  0
 .../{ => pinpoint}/dpin_registry.h            |  0
 .../{ => pinpoint}/ipin_registry.c            |  0
 .../{ => pinpoint}/ipin_registry.h            |  0
 .../gcc-plugins/{ => pinpoint}/layout_hash.c  |  0
 .../gcc-plugins/{ => pinpoint}/layout_hash.h  |  0
 .../{ => pinpoint}/on_finish_decl.c           |  0
 .../{ => pinpoint}/on_finish_type.c           |  0
 .../{ => pinpoint}/on_finish_unit.c           |  0
 .../on_preserve_component_ref.c               |  0
 .../{ => pinpoint}/on_register_attributes.c   |  0
 .../{ => pinpoint}/on_start_unit.c            |  0
 scripts/gcc-plugins/{ => pinpoint}/passes.h   |  0
 scripts/gcc-plugins/{ => pinpoint}/pinpoint.c |  0
 scripts/gcc-plugins/{ => pinpoint}/pinpoint.h |  0
 .../rtl_ipin_survival_scan_pass.c             |  0
 .../gcc-plugins/{ => pinpoint}/safe-attribs.h |  0
 .../{ => pinpoint}/safe-diagnostic.h          |  0
 .../{ => pinpoint}/safe-gcc-plugin.h          |  0
 scripts/gcc-plugins/{ => pinpoint}/safe-ggc.h |  0
 .../gcc-plugins/{ => pinpoint}/safe-gimple.h  |  0
 .../gcc-plugins/{ => pinpoint}/safe-input.h   |  0
 .../{ => pinpoint}/safe-langhooks.h           |  0
 scripts/gcc-plugins/{ => pinpoint}/safe-md5.h |  0
 .../gcc-plugins/{ => pinpoint}/safe-output.h  |  0
 .../{ => pinpoint}/safe-plugin-version.h      |  0
 scripts/gcc-plugins/{ => pinpoint}/safe-rtl.h |  0
 .../gcc-plugins/{ => pinpoint}/safe-tree.h    |  0
 .../{ => pinpoint}/separate_offset_pass.c     |  0
 .../gcc-plugins/{ => pinpoint}/serialize.c    |  0
 .../gcc-plugins/{ => pinpoint}/serialize.h    |  0
 .../{ => pinpoint}/target_hash_builtin_pass.c |  0
 .../{ => pinpoint}/target_registry.c          |  0
 .../{ => pinpoint}/target_registry.h          |  0
 36 files changed, 16 insertions(+), 16 deletions(-)
 rename scripts/gcc-plugins/{ => pinpoint}/asm_offset_pass.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/dpin_registry.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/dpin_registry.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/ipin_registry.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/ipin_registry.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/layout_hash.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/layout_hash.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_finish_decl.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_finish_type.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_finish_unit.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_preserve_component_ref.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_register_attributes.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/on_start_unit.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/passes.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/pinpoint.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/pinpoint.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/rtl_ipin_survival_scan_pass.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-attribs.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-diagnostic.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-gcc-plugin.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-ggc.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-gimple.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-input.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-langhooks.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-md5.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-output.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-plugin-version.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-rtl.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/safe-tree.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/separate_offset_pass.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/serialize.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/serialize.h (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/target_hash_builtin_pass.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/target_registry.c (100%)
 rename scripts/gcc-plugins/{ => pinpoint}/target_registry.h (100%)

diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 1ecc9e923b85..71f605875647 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -23,22 +23,22 @@ targets += randomize_layout_seed.h
 # foo-objs := foo.o foo2.o
 
 pinpoint_plugin-objs := \
-	pinpoint.o \
-	asm_offset_pass.o \
-	dpin_registry.o \
-	ipin_registry.o \
-	layout_hash.o \
-	on_finish_decl.o \
-	on_finish_type.o \
-	on_finish_unit.o \
-	on_preserve_component_ref.o \
-	on_register_attributes.o \
-	on_start_unit.o \
-	rtl_ipin_survival_scan_pass.o \
-	separate_offset_pass.o \
-	serialize.o \
-	target_registry.o \
-	target_hash_builtin_pass.o
+	pinpoint/pinpoint.o \
+	pinpoint/asm_offset_pass.o \
+	pinpoint/dpin_registry.o \
+	pinpoint/ipin_registry.o \
+	pinpoint/layout_hash.o \
+	pinpoint/on_finish_decl.o \
+	pinpoint/on_finish_type.o \
+	pinpoint/on_finish_unit.o \
+	pinpoint/on_preserve_component_ref.o \
+	pinpoint/on_register_attributes.o \
+	pinpoint/on_start_unit.o \
+	pinpoint/rtl_ipin_survival_scan_pass.o \
+	pinpoint/separate_offset_pass.o \
+	pinpoint/serialize.o \
+	pinpoint/target_registry.o \
+	pinpoint/target_hash_builtin_pass.o
 
 always-y += $(GCC_PLUGIN)
 
diff --git a/scripts/gcc-plugins/asm_offset_pass.c b/scripts/gcc-plugins/pinpoint/asm_offset_pass.c
similarity index 100%
rename from scripts/gcc-plugins/asm_offset_pass.c
rename to scripts/gcc-plugins/pinpoint/asm_offset_pass.c
diff --git a/scripts/gcc-plugins/dpin_registry.c b/scripts/gcc-plugins/pinpoint/dpin_registry.c
similarity index 100%
rename from scripts/gcc-plugins/dpin_registry.c
rename to scripts/gcc-plugins/pinpoint/dpin_registry.c
diff --git a/scripts/gcc-plugins/dpin_registry.h b/scripts/gcc-plugins/pinpoint/dpin_registry.h
similarity index 100%
rename from scripts/gcc-plugins/dpin_registry.h
rename to scripts/gcc-plugins/pinpoint/dpin_registry.h
diff --git a/scripts/gcc-plugins/ipin_registry.c b/scripts/gcc-plugins/pinpoint/ipin_registry.c
similarity index 100%
rename from scripts/gcc-plugins/ipin_registry.c
rename to scripts/gcc-plugins/pinpoint/ipin_registry.c
diff --git a/scripts/gcc-plugins/ipin_registry.h b/scripts/gcc-plugins/pinpoint/ipin_registry.h
similarity index 100%
rename from scripts/gcc-plugins/ipin_registry.h
rename to scripts/gcc-plugins/pinpoint/ipin_registry.h
diff --git a/scripts/gcc-plugins/layout_hash.c b/scripts/gcc-plugins/pinpoint/layout_hash.c
similarity index 100%
rename from scripts/gcc-plugins/layout_hash.c
rename to scripts/gcc-plugins/pinpoint/layout_hash.c
diff --git a/scripts/gcc-plugins/layout_hash.h b/scripts/gcc-plugins/pinpoint/layout_hash.h
similarity index 100%
rename from scripts/gcc-plugins/layout_hash.h
rename to scripts/gcc-plugins/pinpoint/layout_hash.h
diff --git a/scripts/gcc-plugins/on_finish_decl.c b/scripts/gcc-plugins/pinpoint/on_finish_decl.c
similarity index 100%
rename from scripts/gcc-plugins/on_finish_decl.c
rename to scripts/gcc-plugins/pinpoint/on_finish_decl.c
diff --git a/scripts/gcc-plugins/on_finish_type.c b/scripts/gcc-plugins/pinpoint/on_finish_type.c
similarity index 100%
rename from scripts/gcc-plugins/on_finish_type.c
rename to scripts/gcc-plugins/pinpoint/on_finish_type.c
diff --git a/scripts/gcc-plugins/on_finish_unit.c b/scripts/gcc-plugins/pinpoint/on_finish_unit.c
similarity index 100%
rename from scripts/gcc-plugins/on_finish_unit.c
rename to scripts/gcc-plugins/pinpoint/on_finish_unit.c
diff --git a/scripts/gcc-plugins/on_preserve_component_ref.c b/scripts/gcc-plugins/pinpoint/on_preserve_component_ref.c
similarity index 100%
rename from scripts/gcc-plugins/on_preserve_component_ref.c
rename to scripts/gcc-plugins/pinpoint/on_preserve_component_ref.c
diff --git a/scripts/gcc-plugins/on_register_attributes.c b/scripts/gcc-plugins/pinpoint/on_register_attributes.c
similarity index 100%
rename from scripts/gcc-plugins/on_register_attributes.c
rename to scripts/gcc-plugins/pinpoint/on_register_attributes.c
diff --git a/scripts/gcc-plugins/on_start_unit.c b/scripts/gcc-plugins/pinpoint/on_start_unit.c
similarity index 100%
rename from scripts/gcc-plugins/on_start_unit.c
rename to scripts/gcc-plugins/pinpoint/on_start_unit.c
diff --git a/scripts/gcc-plugins/passes.h b/scripts/gcc-plugins/pinpoint/passes.h
similarity index 100%
rename from scripts/gcc-plugins/passes.h
rename to scripts/gcc-plugins/pinpoint/passes.h
diff --git a/scripts/gcc-plugins/pinpoint.c b/scripts/gcc-plugins/pinpoint/pinpoint.c
similarity index 100%
rename from scripts/gcc-plugins/pinpoint.c
rename to scripts/gcc-plugins/pinpoint/pinpoint.c
diff --git a/scripts/gcc-plugins/pinpoint.h b/scripts/gcc-plugins/pinpoint/pinpoint.h
similarity index 100%
rename from scripts/gcc-plugins/pinpoint.h
rename to scripts/gcc-plugins/pinpoint/pinpoint.h
diff --git a/scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c b/scripts/gcc-plugins/pinpoint/rtl_ipin_survival_scan_pass.c
similarity index 100%
rename from scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c
rename to scripts/gcc-plugins/pinpoint/rtl_ipin_survival_scan_pass.c
diff --git a/scripts/gcc-plugins/safe-attribs.h b/scripts/gcc-plugins/pinpoint/safe-attribs.h
similarity index 100%
rename from scripts/gcc-plugins/safe-attribs.h
rename to scripts/gcc-plugins/pinpoint/safe-attribs.h
diff --git a/scripts/gcc-plugins/safe-diagnostic.h b/scripts/gcc-plugins/pinpoint/safe-diagnostic.h
similarity index 100%
rename from scripts/gcc-plugins/safe-diagnostic.h
rename to scripts/gcc-plugins/pinpoint/safe-diagnostic.h
diff --git a/scripts/gcc-plugins/safe-gcc-plugin.h b/scripts/gcc-plugins/pinpoint/safe-gcc-plugin.h
similarity index 100%
rename from scripts/gcc-plugins/safe-gcc-plugin.h
rename to scripts/gcc-plugins/pinpoint/safe-gcc-plugin.h
diff --git a/scripts/gcc-plugins/safe-ggc.h b/scripts/gcc-plugins/pinpoint/safe-ggc.h
similarity index 100%
rename from scripts/gcc-plugins/safe-ggc.h
rename to scripts/gcc-plugins/pinpoint/safe-ggc.h
diff --git a/scripts/gcc-plugins/safe-gimple.h b/scripts/gcc-plugins/pinpoint/safe-gimple.h
similarity index 100%
rename from scripts/gcc-plugins/safe-gimple.h
rename to scripts/gcc-plugins/pinpoint/safe-gimple.h
diff --git a/scripts/gcc-plugins/safe-input.h b/scripts/gcc-plugins/pinpoint/safe-input.h
similarity index 100%
rename from scripts/gcc-plugins/safe-input.h
rename to scripts/gcc-plugins/pinpoint/safe-input.h
diff --git a/scripts/gcc-plugins/safe-langhooks.h b/scripts/gcc-plugins/pinpoint/safe-langhooks.h
similarity index 100%
rename from scripts/gcc-plugins/safe-langhooks.h
rename to scripts/gcc-plugins/pinpoint/safe-langhooks.h
diff --git a/scripts/gcc-plugins/safe-md5.h b/scripts/gcc-plugins/pinpoint/safe-md5.h
similarity index 100%
rename from scripts/gcc-plugins/safe-md5.h
rename to scripts/gcc-plugins/pinpoint/safe-md5.h
diff --git a/scripts/gcc-plugins/safe-output.h b/scripts/gcc-plugins/pinpoint/safe-output.h
similarity index 100%
rename from scripts/gcc-plugins/safe-output.h
rename to scripts/gcc-plugins/pinpoint/safe-output.h
diff --git a/scripts/gcc-plugins/safe-plugin-version.h b/scripts/gcc-plugins/pinpoint/safe-plugin-version.h
similarity index 100%
rename from scripts/gcc-plugins/safe-plugin-version.h
rename to scripts/gcc-plugins/pinpoint/safe-plugin-version.h
diff --git a/scripts/gcc-plugins/safe-rtl.h b/scripts/gcc-plugins/pinpoint/safe-rtl.h
similarity index 100%
rename from scripts/gcc-plugins/safe-rtl.h
rename to scripts/gcc-plugins/pinpoint/safe-rtl.h
diff --git a/scripts/gcc-plugins/safe-tree.h b/scripts/gcc-plugins/pinpoint/safe-tree.h
similarity index 100%
rename from scripts/gcc-plugins/safe-tree.h
rename to scripts/gcc-plugins/pinpoint/safe-tree.h
diff --git a/scripts/gcc-plugins/separate_offset_pass.c b/scripts/gcc-plugins/pinpoint/separate_offset_pass.c
similarity index 100%
rename from scripts/gcc-plugins/separate_offset_pass.c
rename to scripts/gcc-plugins/pinpoint/separate_offset_pass.c
diff --git a/scripts/gcc-plugins/serialize.c b/scripts/gcc-plugins/pinpoint/serialize.c
similarity index 100%
rename from scripts/gcc-plugins/serialize.c
rename to scripts/gcc-plugins/pinpoint/serialize.c
diff --git a/scripts/gcc-plugins/serialize.h b/scripts/gcc-plugins/pinpoint/serialize.h
similarity index 100%
rename from scripts/gcc-plugins/serialize.h
rename to scripts/gcc-plugins/pinpoint/serialize.h
diff --git a/scripts/gcc-plugins/target_hash_builtin_pass.c b/scripts/gcc-plugins/pinpoint/target_hash_builtin_pass.c
similarity index 100%
rename from scripts/gcc-plugins/target_hash_builtin_pass.c
rename to scripts/gcc-plugins/pinpoint/target_hash_builtin_pass.c
diff --git a/scripts/gcc-plugins/target_registry.c b/scripts/gcc-plugins/pinpoint/target_registry.c
similarity index 100%
rename from scripts/gcc-plugins/target_registry.c
rename to scripts/gcc-plugins/pinpoint/target_registry.c
diff --git a/scripts/gcc-plugins/target_registry.h b/scripts/gcc-plugins/pinpoint/target_registry.h
similarity index 100%
rename from scripts/gcc-plugins/target_registry.h
rename to scripts/gcc-plugins/pinpoint/target_registry.h
-- 
2.34.1

