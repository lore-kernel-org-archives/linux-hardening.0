Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9692BB17
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962512; cv=none; b=OZ3HjpqGbpOwPnP292YFAN7TsKaJtuIV9qKFI8eBvO9qJylog4C0SFC/GEec9ljz6+wkqiU/7dqB1npC51ihWVEZ3+wUW6Z4dVC/NBCSrtBpCneNBNPZrr3MHKdxCGXtPtvDVTBnOPN++RIf+aQz3cio1qOyIwngt94mEgcPBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962512; c=relaxed/simple;
	bh=r4M7r2IVdOm7w8d4Njd5vNxFn4LUAc0AVNabt1BzV9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFzQK8j5cTm7DpjlBh+AkS4akc7eFRo0TXETIpWqNBYZuqOJy38Q3lYbV825pPZiauEaziU0/TUnpkLvjQpXD42wG4ciFL4YRo6zeYsGcH6Hh9HvZiFWXQLI79bJeWAxWZSXHGb1Rnoyr9z16XnQCKKFOo4fa3hjeh7HrCsEarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=Ewi9R7Zg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="Ewi9R7Zg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4908b92904fso39017615e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1781962506; x=1782567306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9btpXvc5iiLYKgwn3i/9UrvqtJEqeXHtOL+lQfGdF3M=;
        b=Ewi9R7ZgmjSIO9svzvVDuzO4Q9iV5XS2yXleI+fFHILHlRLwnlHLcUU7rGkRoc2DN5
         FijLNh+scsoaC/LJS4AUlVEkaBxtB+Yvp09vy4WFyffiUcmK3XMGysjtVx25enEVtk3x
         LBArWUwflF/oCvw9rfqHUTiWJcwNVI9gSklrVQE+P2+V5SmyrIHQcVJYkTEA9hH07ExH
         1VbZod+Pwim9zB/zub8BcMZ+9ycDn+LswJjXiH8VuhcwFrAmH1fSmodRSb888nxdwtKO
         bFj4lCxd5mXlu3jF+hZbmixmnUTKYs2r9WAcOY5UU1awXUNzZIgE836STCIut9DWgyxv
         VLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962506; x=1782567306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9btpXvc5iiLYKgwn3i/9UrvqtJEqeXHtOL+lQfGdF3M=;
        b=NCe9mlHR2m6FxZY8Ux7lGEVBxnL5b0qdnMdHsfo8lVjpJxLzhYPUi2SQbzsj2d0SV5
         mLXkRuwowD6Ep6oKe+tULMrV57+R+d5EGlxDTgoYgU4MHm+niWrSvyPEsN+5R2doYqGX
         XhzkD9TZ4gqT087b6+/MNQ09c3RediTQ3ZZQUjiGAZT4TrQi63uxett9f/4hMjwdi28P
         tEvFQUCWKNnDsOj9BMNx/+raU0F38U4+2K62E0S32iVSQT9zjemFA6vnDkI+Dtbpbp38
         I1LlIe9Ic7PXBq2l5o+3wzfWdGhZt+ojtivRu+av5Fwtg++vvLHEfxQ0GT5vStB6Z9Ej
         rhPQ==
X-Gm-Message-State: AOJu0YxHAm1UHI1tTHYklJtcjQqccRA5HIL1+vkBc8rO5D3Y7h/uO545
	ouhokgSygWnbSzDgZWOwXNbL2MYaGaW5qTvapnHdq9u2bfAnLj8cbfAFqWrrf26faTYyKExZvYl
	bCXOrDA==
X-Gm-Gg: AfdE7cmPMfX4Aif8Wlr4OTP5yxLGClpKv1O+YeehdUehSokf+0eUpf9E4oduZHVqeT9
	wdR3EkH3Ua0+NvdrrdeygIddTgNaBn7FBct7oUcALzRuKj2mxjaYEZKVH5nTt208ZU5+V9pMpDh
	Zr6uTmx1FhYNHJnHWsKxw2kndZDUckY/SaQn37/cNUsJiGM1TU0ixcc19QupeNLM0AR9zgxGDKn
	z9wGoJ7cQ+15fFfEx/0Q+inrtnZjruvYF/6bDge8IMtFwZ9oK4ikT6zszH6Pky03xdT/Q8J+4Nv
	u/JU5+8U87q3TO0tzN//OV3PYDK+8ytdWXG2LWGdNi0BohoQjAohtRVMW3FkFoPpm0pH8YYUCDT
	1HjgTXsqSHFvnIoF/FySOQlpX/SS0BN8zNeGcefO8ShfoKNkOf85HSSvOBHIMbnimceDijxiW+F
	MN7AbQ3RGXaaKISLoGENbClTvYaQJqs3osaxdPskmI5d4inoZlblUPQ27cpi4vFYbdmL86LlMEL
	1pNrSiw4f7pSSbQBLy3vOPbTTme
X-Received: by 2002:a05:600c:c4b7:b0:492:418b:b5e1 with SMTP id 5b1f17b1804b1-49242591d68mr92246635e9.37.1781962505648;
        Sat, 20 Jun 2026 06:35:05 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00ab2024b6c6d10e76.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:ab20:24b6:c6d1:e76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57ba0sm8811992f8f.32.2026.06.20.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:35:05 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v2 1/5] SPSLR pinpoint plugin
Date: Sat, 20 Jun 2026 15:35:04 +0200
Message-ID: <20260620133504.95123-1-yjn@yjn-systems.com>
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
 scripts/Makefile.gcc-plugins                  |   9 +
 scripts/gcc-plugins/Makefile                  |  17 +
 scripts/gcc-plugins/pinpoint.c                |  94 ++++
 .../gcc-plugins/pinpoint_asm_offset_pass.c    | 133 +++++
 scripts/gcc-plugins/pinpoint_config.h         |   7 +
 scripts/gcc-plugins/pinpoint_error.h          |  28 ++
 scripts/gcc-plugins/pinpoint_final.h          |   3 +
 scripts/gcc-plugins/pinpoint_gc_preserve.c    |  10 +
 scripts/gcc-plugins/pinpoint_gc_preserve.h    |  39 ++
 scripts/gcc-plugins/pinpoint_layout_hash.c    |  55 +++
 scripts/gcc-plugins/pinpoint_layout_hash.h    |   8 +
 scripts/gcc-plugins/pinpoint_on_finish_decl.c | 205 ++++++++
 scripts/gcc-plugins/pinpoint_on_finish_type.c |  21 +
 scripts/gcc-plugins/pinpoint_on_finish_unit.c | 346 +++++++++++++
 .../pinpoint_on_preserve_component_ref.c      |  95 ++++
 .../pinpoint_on_register_attributes.c         |  53 ++
 scripts/gcc-plugins/pinpoint_on_start_unit.c  |  11 +
 .../gcc-plugins/pinpoint_rtl_pin_lower_pass.c | 278 +++++++++++
 .../pinpoint_separate_offset_pass.c           | 324 ++++++++++++
 scripts/gcc-plugins/pinpoint_separator.c      | 123 +++++
 scripts/gcc-plugins/pinpoint_serialize.c      | 298 ++++++++++++
 scripts/gcc-plugins/pinpoint_serialize.h      | 114 +++++
 scripts/gcc-plugins/pinpoint_stage0.h         | 105 ++++
 scripts/gcc-plugins/pinpoint_stage1.h         |  11 +
 scripts/gcc-plugins/pinpoint_stage2.h         |  22 +
 scripts/gcc-plugins/pinpoint_target.c         | 460 ++++++++++++++++++
 scripts/gcc-plugins/safe-attribs.h            |   8 +
 scripts/gcc-plugins/safe-diagnostic.h         |   9 +
 scripts/gcc-plugins/safe-gcc-plugin.h         |   6 +
 scripts/gcc-plugins/safe-ggc.h                |   8 +
 scripts/gcc-plugins/safe-gimple.h             |  14 +
 scripts/gcc-plugins/safe-input.h              |   9 +
 scripts/gcc-plugins/safe-langhooks.h          |   8 +
 scripts/gcc-plugins/safe-md5.h                |   8 +
 scripts/gcc-plugins/safe-output.h             |   8 +
 scripts/gcc-plugins/safe-plugin-version.h     |   8 +
 scripts/gcc-plugins/safe-rtl.h                |  17 +
 scripts/gcc-plugins/safe-tree.h               |  10 +
 38 files changed, 2982 insertions(+)
 create mode 100644 scripts/gcc-plugins/pinpoint.c
 create mode 100644 scripts/gcc-plugins/pinpoint_asm_offset_pass.c
 create mode 100644 scripts/gcc-plugins/pinpoint_config.h
 create mode 100644 scripts/gcc-plugins/pinpoint_error.h
 create mode 100644 scripts/gcc-plugins/pinpoint_final.h
 create mode 100644 scripts/gcc-plugins/pinpoint_gc_preserve.c
 create mode 100644 scripts/gcc-plugins/pinpoint_gc_preserve.h
 create mode 100644 scripts/gcc-plugins/pinpoint_layout_hash.c
 create mode 100644 scripts/gcc-plugins/pinpoint_layout_hash.h
 create mode 100644 scripts/gcc-plugins/pinpoint_on_finish_decl.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_finish_type.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_finish_unit.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_preserve_component_ref.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_register_attributes.c
 create mode 100644 scripts/gcc-plugins/pinpoint_on_start_unit.c
 create mode 100644 scripts/gcc-plugins/pinpoint_rtl_pin_lower_pass.c
 create mode 100644 scripts/gcc-plugins/pinpoint_separate_offset_pass.c
 create mode 100644 scripts/gcc-plugins/pinpoint_separator.c
 create mode 100644 scripts/gcc-plugins/pinpoint_serialize.c
 create mode 100644 scripts/gcc-plugins/pinpoint_serialize.h
 create mode 100644 scripts/gcc-plugins/pinpoint_stage0.h
 create mode 100644 scripts/gcc-plugins/pinpoint_stage1.h
 create mode 100644 scripts/gcc-plugins/pinpoint_stage2.h
 create mode 100644 scripts/gcc-plugins/pinpoint_target.c
 create mode 100644 scripts/gcc-plugins/safe-attribs.h
 create mode 100644 scripts/gcc-plugins/safe-diagnostic.h
 create mode 100644 scripts/gcc-plugins/safe-gcc-plugin.h
 create mode 100644 scripts/gcc-plugins/safe-ggc.h
 create mode 100644 scripts/gcc-plugins/safe-gimple.h
 create mode 100644 scripts/gcc-plugins/safe-input.h
 create mode 100644 scripts/gcc-plugins/safe-langhooks.h
 create mode 100644 scripts/gcc-plugins/safe-md5.h
 create mode 100644 scripts/gcc-plugins/safe-output.h
 create mode 100644 scripts/gcc-plugins/safe-plugin-version.h
 create mode 100644 scripts/gcc-plugins/safe-rtl.h
 create mode 100644 scripts/gcc-plugins/safe-tree.h

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index e4deaf5fa571..275b06f1920e 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -42,6 +42,15 @@ ifdef CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK
 endif
 export DISABLE_ARM_SSP_PER_TASK_PLUGIN
 
+PINPOINT_PLUGIN_CFLAGS := \
+	-fplugin=$(objtree)/scripts/gcc-plugins/pinpoint_plugin.so \
+	-D__SPSLR__
+
+gcc-plugin-$(CONFIG_SPSLR) += pinpoint_plugin.so
+gcc-plugin-cflags-$(CONFIG_SPSLR) += -D__SPSLR__
+
+export PINPOINT_PLUGIN_CFLAGS
+
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 320afd3cf8e8..2007d8a1e12e 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -22,6 +22,23 @@ targets += randomize_layout_seed.h
 #
 # foo-objs := foo.o foo2.o
 
+pinpoint_plugin-objs := \
+	pinpoint.o \
+	pinpoint_asm_offset_pass.o \
+	pinpoint_gc_preserve.o \
+	pinpoint_layout_hash.o \
+	pinpoint_on_finish_decl.o \
+	pinpoint_on_finish_type.o \
+	pinpoint_on_finish_unit.o \
+	pinpoint_on_preserve_component_ref.o \
+	pinpoint_on_register_attributes.o \
+	pinpoint_on_start_unit.o \
+	pinpoint_rtl_pin_lower_pass.o \
+	pinpoint_separate_offset_pass.o \
+	pinpoint_separator.o \
+	pinpoint_serialize.o \
+	pinpoint_target.o
+
 always-y += $(GCC_PLUGIN)
 
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
diff --git a/scripts/gcc-plugins/pinpoint.c b/scripts/gcc-plugins/pinpoint.c
new file mode 100644
index 000000000000..139766d7167e
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint.c
@@ -0,0 +1,94 @@
+#include <filesystem>
+#include <string>
+
+#include <safe-gcc-plugin.h>
+#include <safe-plugin-version.h>
+
+#include <pinpoint_stage0.h>
+#include <pinpoint_stage1.h>
+#include <pinpoint_stage2.h>
+#include <pinpoint_final.h>
+
+#include <pinpoint_gc_preserve.h>
+#include <pinpoint_error.h>
+
+int plugin_is_GPL_compatible;
+
+bool pinpoint_verbose_enabled;
+
+int plugin_init(struct plugin_name_args *plugin_info,
+		struct plugin_gcc_version *version)
+{
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		plugin_print_early_error(
+			"incompatible GCC/plugin versions: plugin built for GCC %s, loaded by GCC %s",
+			gcc_version.basever, version->basever);
+		return 1;
+	}
+
+	pinpoint_verbose_enabled = false;
+
+	for (int i = 0; i < plugin_info->argc; ++i) {
+		if (!strcmp(plugin_info->argv[i].key, "verbose")) {
+			pinpoint_verbose_enabled = true;
+		}
+	}
+
+	/*
+	 * Pinpoint runs as a staged GCC plugin because no single GCC IR level has
+	 * all information SPSLR needs.
+	 *
+	 * Stage 0 runs while COMPONENT_REF trees are built or still available and records
+	 * which structure field offsets are randomization-sensitive.
+	 *
+	 * Stage 1 replaces synthetic separator calls with asm markers so GCC keeps
+	 * the offset value as a real data dependency through later optimization.
+	 *
+	 * Stage 2 runs on final RTL and lowers those markers into concrete architecture-specific
+	 * instructions whose immediate operands are labeled for runtime patching.
+	 *
+	 * The final callback emits the collected metadata for patchcompile.
+	 */
+
+	register_callback(plugin_info->base_name, PLUGIN_START_UNIT,
+			  on_start_unit, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_ATTRIBUTES,
+			  on_register_attributes, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_TYPE,
+			  on_finish_type, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_BUILD_COMPONENT_REF,
+			  on_preserve_component_ref, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_DECL,
+			  on_finish_decl, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_GGC_MARKING,
+			  pinpoint_gc_preserve, NULL);
+
+	struct register_pass_info separate_offset_pass_info;
+	separate_offset_pass_info.pass = new separate_offset_pass(nullptr);
+	separate_offset_pass_info.ref_pass_instance_number = 1;
+	separate_offset_pass_info.reference_pass_name = "cfg";
+	separate_offset_pass_info.pos_op = PASS_POS_INSERT_AFTER;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &separate_offset_pass_info);
+
+	struct register_pass_info asm_offset_pass_info;
+	asm_offset_pass_info.pass = new asm_offset_pass(nullptr);
+	asm_offset_pass_info.ref_pass_instance_number = 1;
+	asm_offset_pass_info.reference_pass_name = "separate_offset";
+	asm_offset_pass_info.pos_op = PASS_POS_INSERT_AFTER;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &asm_offset_pass_info);
+
+	struct register_pass_info rtl_pin_lower_pass_info;
+	rtl_pin_lower_pass_info.pass = new rtl_pin_lower_pass(nullptr);
+	rtl_pin_lower_pass_info.ref_pass_instance_number = 1;
+	rtl_pin_lower_pass_info.reference_pass_name = "final";
+	rtl_pin_lower_pass_info.pos_op = PASS_POS_INSERT_BEFORE;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &rtl_pin_lower_pass_info);
+
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_UNIT,
+			  on_finish_unit, NULL);
+
+	return 0;
+}
diff --git a/scripts/gcc-plugins/pinpoint_asm_offset_pass.c b/scripts/gcc-plugins/pinpoint_asm_offset_pass.c
new file mode 100644
index 000000000000..fb5f54740f83
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_asm_offset_pass.c
@@ -0,0 +1,133 @@
+#include <unordered_map>
+
+#include <pinpoint_stage1.h>
+#include <pinpoint_error.h>
+#include <pinpoint_config.h>
+
+/*
+ * Stage1 marker asm is a carrier for target/offset constants.
+ *
+ * It intentionally does not contain final machine code yet. GCC still needs
+ * freedom to allocate the destination register, and stage2 later observes the
+ * final RTL register choice before emitting bytes with a labeled immediate.
+ */
+
+const char *s1_ipin_marker = "/*spslr_s1_ipin_marker*/";
+
+static tree make_asm_operand(const char *constraint_text, tree operand_tree)
+{
+	tree constraint_str =
+		build_string(strlen(constraint_text) + 1, constraint_text);
+	tree inner_list = build_tree_list(NULL_TREE, constraint_str);
+	tree outer_list = build_tree_list(inner_list, operand_tree);
+	return outer_list;
+}
+
+static gimple *make_stage1_pin(tree lhs, UID target, std::size_t offset)
+{
+	if (!lhs)
+		return nullptr;
+
+	const char *asm_str =
+		s1_ipin_marker; // Asm is inserted at a later stage
+
+	tree arg0 = build_int_cst(size_type_node, target);
+	tree arg1 = build_int_cst(size_type_node, offset);
+
+	vec<tree, va_gc> *outputs = NULL;
+	vec<tree, va_gc> *inputs = NULL;
+
+	vec_safe_push(outputs, make_asm_operand("=r", lhs));
+	vec_safe_push(inputs, make_asm_operand("i", arg0));
+	vec_safe_push(inputs, make_asm_operand("i", arg1));
+
+	gasm *new_gasm = gimple_build_asm_vec(ggc_strdup(asm_str), inputs,
+					      outputs, NULL, NULL);
+	if (!new_gasm)
+		return nullptr;
+
+	/*
+	 * Non-volatile is intentional: unused field-offset computations should die
+	 * normally. Only offsets that survive optimization become instruction pins.
+	 */
+	gimple_asm_set_volatile(new_gasm, false);
+
+	return new_gasm;
+}
+
+/*
+ * gsi_replace() changes the statement, but SSA names that were defined by the
+ * separator call still point at the old def statement. Retarget those SSA defs
+ * so later GCC passes see the asm marker as the producer of the offset value.
+ */
+
+static void pin_update_ssa_def(function *fn, gimple *old_def, gimple *new_def)
+{
+	if (!fn || !old_def)
+		return;
+
+	// Stage 0 separator call was definition statement of temporary variable
+
+	unsigned i;
+	tree name;
+	FOR_EACH_SSA_NAME(i, name, fn)
+	{
+		if (!name)
+			continue;
+
+		if (SSA_NAME_DEF_STMT(name) != old_def)
+			continue;
+
+		SSA_NAME_DEF_STMT(name) = new_def;
+	}
+}
+
+static void pin_assemble_maybe(function *fn, gimple_stmt_iterator *gsi)
+{
+	if (!gsi)
+		return;
+
+	gimple *stmt = gsi_stmt(*gsi);
+	if (!stmt)
+		return;
+
+	UID target;
+	std::size_t offset;
+
+	if (!is_stage0_separator(stmt, target, offset))
+		return;
+
+	gimple *replacement =
+		make_stage1_pin(gimple_call_lhs(stmt), target, offset);
+	if (!replacement)
+		pinpoint_fatal("failed to construct stage 1 pin");
+
+	gsi_replace(gsi, replacement, true);
+	pin_update_ssa_def(fn, stmt, replacement);
+}
+
+static const pass_data asm_offset_pass_data = {
+	GIMPLE_PASS, "asm_offset",   OPTGROUP_NONE, TV_NONE, 0, 0, 0,
+	0,	     TODO_update_ssa
+};
+
+asm_offset_pass::asm_offset_pass(gcc::context *ctxt)
+	: gimple_opt_pass(asm_offset_pass_data, ctxt)
+{
+}
+
+unsigned int asm_offset_pass::execute(function *fn)
+{
+	if (!fn)
+		return 0;
+
+	basic_block bb;
+	FOR_EACH_BB_FN(bb, fn)
+	{
+		for (gimple_stmt_iterator gsi = gsi_start_bb(bb);
+		     !gsi_end_p(gsi); gsi_next(&gsi))
+			pin_assemble_maybe(fn, &gsi);
+	}
+
+	return 0;
+}
diff --git a/scripts/gcc-plugins/pinpoint_config.h b/scripts/gcc-plugins/pinpoint_config.h
new file mode 100644
index 000000000000..330bdb940fcd
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_config.h
@@ -0,0 +1,7 @@
+#pragma once
+
+#define SPSLR_ATTRIBUTE "spslr"
+#define SPSLR_FIELD_FIXED_ATTRIBUTE "spslr_field_fixed"
+#define SPSLR_PINPOINT_STAGE0_SEPARATOR "__spslr_offsetof"
+#define SPSLR_PINFILE_EXTENSION ".spslr"
+#define SPSLR_PINPOINT_STAGE2_PIN "spslr_ipin_" /* suffixed with "<uid>" */
diff --git a/scripts/gcc-plugins/pinpoint_error.h b/scripts/gcc-plugins/pinpoint_error.h
new file mode 100644
index 000000000000..7d4bcba735df
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_error.h
@@ -0,0 +1,28 @@
+#pragma once
+
+#include <cstdio>
+#include <safe-diagnostic.h>
+
+extern bool pinpoint_verbose_enabled;
+
+#define plugin_print_early_error(fmt, ...)                                 \
+	do {                                                               \
+		std::fprintf(stderr, "[spslr::pinpoint] error: " fmt "\n", \
+			     ##__VA_ARGS__);                               \
+	} while (0)
+
+#define pinpoint_debug_loc(loc, fmt, ...)                       \
+	do {                                                    \
+		if (pinpoint_verbose_enabled)                   \
+			inform((loc), "[spslr::pinpoint] " fmt, \
+			       ##__VA_ARGS__);                  \
+	} while (0)
+
+#define pinpoint_debug(fmt, ...) \
+	pinpoint_debug_loc(UNKNOWN_LOCATION, fmt, ##__VA_ARGS__)
+
+#define pinpoint_fatal_loc(loc, fmt, ...) \
+	fatal_error((loc), "[spslr::pinpoint] " fmt, ##__VA_ARGS__)
+
+#define pinpoint_fatal(fmt, ...) \
+	pinpoint_fatal_loc(UNKNOWN_LOCATION, fmt, ##__VA_ARGS__)
diff --git a/scripts/gcc-plugins/pinpoint_final.h b/scripts/gcc-plugins/pinpoint_final.h
new file mode 100644
index 000000000000..1ce4fd733d31
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_final.h
@@ -0,0 +1,3 @@
+#pragma once
+
+void on_finish_unit(void *plugin_data, void *user_data);
diff --git a/scripts/gcc-plugins/pinpoint_gc_preserve.c b/scripts/gcc-plugins/pinpoint_gc_preserve.c
new file mode 100644
index 000000000000..1f23e90e5dc4
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_gc_preserve.c
@@ -0,0 +1,10 @@
+#include <pinpoint_gc_preserve.h>
+
+void pinpoint_gc_preserve(void *, void *)
+{
+	for (pinpoint_gc_preserve_fn *p = PINPOINT_GC_SECTION_START;
+	     p != PINPOINT_GC_SECTION_END; ++p) {
+		if (*p)
+			(*p)();
+	}
+}
diff --git a/scripts/gcc-plugins/pinpoint_gc_preserve.h b/scripts/gcc-plugins/pinpoint_gc_preserve.h
new file mode 100644
index 000000000000..d8ee25367e13
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_gc_preserve.h
@@ -0,0 +1,39 @@
+#pragma once
+#include <safe-ggc.h>
+
+using pinpoint_gc_preserve_fn = void (*)();
+
+#define PINPOINT_GC_CONCAT2(a, b) a##b
+#define PINPOINT_GC_CONCAT(a, b) PINPOINT_GC_CONCAT2(a, b)
+
+#define PINPOINT_GC_USED __attribute__((used))
+
+#define PINPOINT_GC_SECTION "pinpoint_gc_mark"
+#define PINPOINT_GC_SECTION_START __start_pinpoint_gc_mark
+#define PINPOINT_GC_SECTION_END __stop_pinpoint_gc_mark
+
+#define PINPOINT_GC_SECTION_ATTRIB __attribute__((section(PINPOINT_GC_SECTION)))
+
+#define PINPOINT_GC_PRESERVE_CALLBACK() \
+	PINPOINT_GC_PRESERVE_CALLBACK_IMPL(__COUNTER__)
+
+#define PINPOINT_GC_PRESERVE_CALLBACK_IMPL(id)                          \
+	static void PINPOINT_GC_CONCAT(pinpoint_gc_preserve_cb_, id)(); \
+	static pinpoint_gc_preserve_fn PINPOINT_GC_CONCAT(              \
+		pinpoint_gc_preserve_reg_, id)                          \
+	PINPOINT_GC_USED PINPOINT_GC_SECTION_ATTRIB =                   \
+		PINPOINT_GC_CONCAT(pinpoint_gc_preserve_cb_, id);       \
+	static void PINPOINT_GC_CONCAT(pinpoint_gc_preserve_cb_, id)()
+
+#define PINPOINT_GC_MARK_TREE(t)      \
+	do {                          \
+		if ((t) != NULL_TREE) \
+			ggc_mark(t);  \
+	} while (0)
+
+extern "C" {
+extern pinpoint_gc_preserve_fn PINPOINT_GC_SECTION_START[];
+extern pinpoint_gc_preserve_fn PINPOINT_GC_SECTION_END[];
+}
+
+void pinpoint_gc_preserve(void *, void *);
diff --git a/scripts/gcc-plugins/pinpoint_layout_hash.c b/scripts/gcc-plugins/pinpoint_layout_hash.c
new file mode 100644
index 000000000000..dd2b006e95a1
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_layout_hash.c
@@ -0,0 +1,55 @@
+#include <cstdint>
+#include <cstring>
+#include <string>
+
+#include <pinpoint_layout_hash.h>
+#include <safe-md5.h>
+
+namespace
+{
+
+void append_u64(std::string &buf, std::uint64_t v)
+{
+	for (unsigned i = 0; i < 8; i++)
+		buf.push_back(static_cast<char>((v >> (i * 8)) & 0xff));
+}
+
+void append_size(std::string &buf, std::size_t v)
+{
+	append_u64(buf, static_cast<std::uint64_t>(v));
+}
+
+void append_string(std::string &buf, const std::string &s)
+{
+	append_size(buf, s.size());
+	buf.append(s);
+}
+
+} // namespace
+
+std::array<std::byte, 16> layout_hash(const TargetType &target)
+{
+	std::string buf;
+
+	append_string(buf, "spslr-layout-hash-v1");
+
+	append_string(buf, target.name());
+	append_size(buf, target.size());
+
+	for (const auto &[off, field] : target.fields()) {
+		append_string(buf, field.name);
+		append_size(buf, field.size);
+		append_size(buf, field.offset);
+		append_size(buf, field.alignment);
+		append_size(buf, field.flags);
+	}
+
+	unsigned char digest[16];
+	md5_buffer(buf.data(), buf.size(), digest);
+
+	std::array<std::byte, 16> out;
+	for (std::size_t i = 0; i < out.size(); i++)
+		out[i] = static_cast<std::byte>(digest[i]);
+
+	return out;
+}
diff --git a/scripts/gcc-plugins/pinpoint_layout_hash.h b/scripts/gcc-plugins/pinpoint_layout_hash.h
new file mode 100644
index 000000000000..66c1cffe45c0
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_layout_hash.h
@@ -0,0 +1,8 @@
+#pragma once
+
+#include <array>
+#include <cstddef>
+
+#include <pinpoint_stage0.h>
+
+std::array<std::byte, 16> layout_hash(const TargetType &target);
diff --git a/scripts/gcc-plugins/pinpoint_on_finish_decl.c b/scripts/gcc-plugins/pinpoint_on_finish_decl.c
new file mode 100644
index 000000000000..93bd7bb5ff7c
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_on_finish_decl.c
@@ -0,0 +1,205 @@
+#include <unordered_set>
+#include <string>
+
+#include <pinpoint_stage0.h>
+#include <pinpoint_error.h>
+#include <pinpoint_config.h>
+
+static std::list<DataPin> pins;
+static std::unordered_set<std::string> seen_dpin_symbols;
+
+void DataPin::reset()
+{
+	pins.clear();
+}
+
+const std::list<DataPin> &DataPin::all()
+{
+	return pins;
+}
+
+static std::list<DataPin::Component>
+compile_datapin_record_components(tree type);
+static std::list<DataPin::Component>
+compile_datapin_array_components(tree type);
+
+/*
+ * Build the list of randomized objects contained in a static object.
+ *
+ * A dpin may describe the object itself, nested target structs, arrays of
+ * targets, or targets embedded inside non-target containers. The level field
+ * records nesting depth so patchcompile/runtime can patch inner objects before
+ * their containing objects.
+ */
+
+static std::list<DataPin::Component> compile_datapin_components(tree type)
+{
+	std::list<DataPin::Component> components;
+
+	const TargetType *relevant = TargetType::find(type);
+	if (relevant) {
+		components.push_back(DataPin::Component{
+			.offset = 0, .level = 0, .target = relevant->uid() });
+	}
+
+	std::list<DataPin::Component> sub_components;
+	if (TREE_CODE(type) == RECORD_TYPE) {
+		sub_components = compile_datapin_record_components(type);
+	} else if (TREE_CODE(type) == ARRAY_TYPE) {
+		sub_components = compile_datapin_array_components(type);
+	}
+
+	for (const DataPin::Component &sc : sub_components) {
+		components.push_back(DataPin::Component{ .offset = sc.offset,
+							 .level = sc.level + 1,
+							 .target = sc.target });
+	}
+
+	// Note -> should probably make sure that randomized structs are never used in unions!
+	return components;
+}
+
+std::list<DataPin::Component> compile_datapin_record_components(tree type)
+{
+	std::list<DataPin::Component> components;
+
+	if (TREE_CODE(type) != RECORD_TYPE)
+		return components;
+
+	if (!COMPLETE_TYPE_P(type))
+		return components;
+
+	for (tree field = TYPE_FIELDS(type); field; field = TREE_CHAIN(field)) {
+		if (TREE_CODE(field) != FIELD_DECL)
+			continue;
+
+		std::size_t field_offset;
+		bool field_bitfield;
+
+		if (!field_info(field, &field_offset, nullptr, nullptr,
+				&field_bitfield)) {
+			// pinpoint_fatal("compile_datapin_record_components failed to get field info");
+			continue; // NOTE -> Happens e.g. on trailing arrays of dynamic size (allowed only in non-target structs)
+		}
+
+		if (field_bitfield)
+			continue;
+
+		tree field_type = TREE_TYPE(field);
+
+		std::list<DataPin::Component> field_components =
+			compile_datapin_components(field_type);
+		for (const DataPin::Component &fc : field_components) {
+			components.push_back(DataPin::Component{
+				.offset = field_offset + fc.offset,
+				.level = fc.level,
+				.target = fc.target });
+		}
+	}
+
+	return components;
+}
+
+std::list<DataPin::Component> compile_datapin_array_components(tree type)
+{
+	std::list<DataPin::Component> components;
+
+	if (TREE_CODE(type) != ARRAY_TYPE)
+		return components;
+
+	tree elem_type = TREE_TYPE(type);
+	if (!elem_type)
+		return components;
+
+	std::list<DataPin::Component> elem_components =
+		compile_datapin_components(elem_type);
+	if (elem_components.empty())
+		return components;
+
+	tree domain = TYPE_DOMAIN(type);
+	if (!domain)
+		pinpoint_fatal(
+			"compile_datapin_array_components failed to get domain for relevant element type");
+
+	tree min_t = TYPE_MIN_VALUE(domain);
+	tree max_t = TYPE_MAX_VALUE(domain);
+	if (!min_t || !max_t || TREE_CODE(min_t) != INTEGER_CST ||
+	    TREE_CODE(max_t) != INTEGER_CST)
+		pinpoint_fatal(
+			"compile_datapin_array_components failed to get array dimensions for relevant element type");
+
+	HOST_WIDE_INT min_i = tree_to_shwi(min_t);
+	HOST_WIDE_INT max_i = tree_to_shwi(max_t);
+
+	tree elem_size_t = TYPE_SIZE_UNIT(elem_type);
+	if (!elem_size_t || TREE_CODE(elem_size_t) != INTEGER_CST)
+		pinpoint_fatal(
+			"compile_datapin_array_components failed to get constant element size for relevant element type");
+
+	std::size_t elem_size = tree_to_uhwi(elem_size_t);
+
+	for (HOST_WIDE_INT i = min_i; i <= max_i; ++i) {
+		std::size_t element_offset =
+			(std::size_t)(i - min_i) * elem_size;
+
+		for (const DataPin::Component &ec : elem_components) {
+			components.push_back(DataPin::Component{
+				.offset = element_offset + ec.offset,
+				.level = ec.level,
+				.target = ec.target });
+		}
+	}
+
+	return components;
+}
+
+static bool compile_datapin(tree type, DataPin &pin)
+{
+	pin.components = compile_datapin_components(type);
+	return !pin.components.empty();
+}
+
+static void on_static_var(tree var)
+{
+	tree type = TREE_TYPE(var);
+	if (!type)
+		return;
+
+	tree symbol_tree = DECL_ASSEMBLER_NAME(var);
+	const char *symbol;
+	if (!symbol_tree || !(symbol = IDENTIFIER_POINTER(symbol_tree)))
+		pinpoint_fatal(
+			"on_static_var failed to get symbol of static variable");
+
+	std::string sym{ symbol };
+
+	/*
+	 * Multiple VAR_DECLs can name the same emitted object, for example through
+	 * export or alias machinery. Emit at most one dpin per assembler symbol.
+	 */
+	if (!seen_dpin_symbols.insert(sym).second)
+		return;
+
+	DataPin pin;
+	if (!compile_datapin(type, pin))
+		return;
+
+	DECL_PRESERVE_P(var) = 1;
+	// pin.global = static_cast<bool>(TREE_PUBLIC(var));
+
+	pin.symbol = sym;
+	pins.emplace_back(std::move(pin));
+}
+
+void on_finish_decl(void *plugin_data, void *user_data)
+{
+	tree decl = (tree)plugin_data;
+
+	if (TREE_CODE(decl) != VAR_DECL)
+		return;
+
+	if (!TREE_STATIC(decl) || DECL_EXTERNAL(decl))
+		return;
+
+	on_static_var(decl);
+}
diff --git a/scripts/gcc-plugins/pinpoint_on_finish_type.c b/scripts/gcc-plugins/pinpoint_on_finish_type.c
new file mode 100644
index 000000000000..c726c9b60995
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_on_finish_type.c
@@ -0,0 +1,21 @@
+#include <pinpoint_stage0.h>
+#include <pinpoint_error.h>
+
+void on_finish_type(void *plugin_data, void *user_data)
+{
+	tree t = (tree)plugin_data;
+
+	TargetType *type = TargetType::find_mutable(t);
+	if (!type)
+		return;
+
+	/*
+	 * Flexible array members or other special cases that can not (yet) be handled
+	 * for SPSLR targets may cause fetch_fields() to fail. Since this code is only
+	 * run for structs marked as SPSLR targets, compilation should fail.
+	 */
+	if (!type->fetch_fields())
+		pinpoint_fatal(
+			"on_finish_type failed to fetch fields of target \"%s\" or the field composition is not (yet) supported",
+			type->name().c_str());
+}
diff --git a/scripts/gcc-plugins/pinpoint_on_finish_unit.c b/scripts/gcc-plugins/pinpoint_on_finish_unit.c
new file mode 100644
index 000000000000..4e954b3ac2ad
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_on_finish_unit.c
@@ -0,0 +1,346 @@
+#include <string>
+#include <filesystem>
+#include <vector>
+#include <algorithm>
+
+#include <pinpoint_final.h>
+#include <pinpoint_stage0.h>
+#include <pinpoint_stage2.h>
+
+#include <safe-input.h>
+#include <safe-output.h>
+#include <pinpoint_config.h>
+#include <pinpoint_error.h>
+
+#include <pinpoint_layout_hash.h>
+#include <pinpoint_serialize.h>
+
+
+
+/*
+ * Finish-unit emits the per-compilation-unit metadata into the object asm.
+ *
+ * Only information that survived all earlier filtering should be dumped here:
+ * target layouts, data pins for static objects, and stage2 instruction pins
+ * whose immediates exist in the final object.
+ */
+
+namespace
+{
+
+static std::string src_filename()
+{
+	namespace fs = std::filesystem;
+
+	if (!main_input_filename)
+		return {};
+
+	return fs::weakly_canonical(main_input_filename).generic_string();
+}
+
+using selfpatch::hash16_t;
+
+struct emitted_target {
+	UID uid;
+	const TargetType *target;
+	hash16_t hash;
+	std::size_t unit_target_idx;
+};
+
+struct emitted_dpin {
+	std::string addr_expr;
+	std::size_t unit_target_idx;
+};
+
+static hash16_t to_hash16(const std::array<std::byte, 16> &in)
+{
+	hash16_t out{};
+
+	for (std::size_t i = 0; i < out.size(); ++i)
+		out[i] = static_cast<std::uint8_t>(in[i]);
+
+	return out;
+}
+
+static std::string add_offset_expr(const std::string &symbol, std::size_t off)
+{
+	if (off == 0)
+		return symbol;
+
+	return symbol + " + " + std::to_string(off);
+}
+
+static std::size_t field_index_for_offset(const TargetType &target,
+					  std::size_t field_offset)
+{
+	std::size_t idx = 0;
+
+	for (const auto &[off, field] : target.fields()) {
+		if (off == field_offset)
+			return idx;
+		++idx;
+	}
+
+	pinpoint_fatal("finish-unit: field offset not found in target");
+}
+
+static std::vector<emitted_target> collect_all_targets()
+{
+	std::vector<emitted_target> out;
+	out.reserve(TargetType::all().size());
+
+	for (const auto &[uid, target] : TargetType::all()) {
+		if (!target.valid())
+			continue;
+
+		if (!target.has_fields())
+			pinpoint_fatal(
+				"finish-unit: target has incomplete fields");
+
+		out.push_back({
+			.uid = uid,
+			.target = &target,
+			.hash = to_hash16(layout_hash(target)),
+			.unit_target_idx = out.size(),
+		});
+	}
+
+	return out;
+}
+
+static std::unordered_map<UID, std::size_t>
+make_unit_target_idx_map(const std::vector<emitted_target> &targets)
+{
+	std::unordered_map<UID, std::size_t> out;
+
+	for (const emitted_target &target : targets)
+		out[target.uid] = target.unit_target_idx;
+
+	return out;
+}
+
+static std::vector<emitted_dpin>
+collect_dpins(const std::unordered_map<UID, std::size_t> &target_idx)
+{
+	std::vector<emitted_dpin> out;
+
+	for (const DataPin &dpin : DataPin::all()) {
+		if (dpin.symbol.empty())
+			pinpoint_fatal(
+				"finish-unit: data pin has empty symbol");
+
+		std::vector<DataPin::Component> components(
+			dpin.components.begin(), dpin.components.end());
+
+		/*
+		 * Data pins with deeper nesting level must be patched first.
+		 */
+		std::sort(components.begin(), components.end(),
+			  [](const DataPin::Component &a,
+			     const DataPin::Component &b) {
+				  return a.level > b.level;
+			  });
+
+		for (const DataPin::Component &c : components) {
+			const auto target_it = target_idx.find(c.target);
+
+			if (target_it == target_idx.end())
+				pinpoint_fatal(
+					"finish-unit: dpin target not in unit target map");
+
+			out.push_back({
+				.addr_expr =
+					add_offset_expr(dpin.symbol, c.offset),
+				.unit_target_idx = target_it->second,
+			});
+		}
+	}
+
+	return out;
+}
+
+static void emit_target_metadata(FILE *out,
+				 const std::vector<emitted_target> &targets)
+{
+	for (const emitted_target &ut : targets) {
+		const TargetType &target = *ut.target;
+
+		const std::string target_sym =
+			selfpatch::target_symbol(ut.hash);
+		const std::string layout_sym =
+			selfpatch::target_layout_symbol(ut.hash);
+		const std::string fields_sym =
+			selfpatch::make_local_label("target_fields");
+
+		const std::string target_name =
+			selfpatch::emit_strtab_entry(out, target.name());
+
+		selfpatch::emit_targets_section(out, ut.hash);
+		selfpatch::emit_hidden_global_label(out, target_sym);
+
+		selfpatch::target_desc target_desc{
+			.hash = ut.hash,
+			.name_label = target_name,
+			.layout_symbol = layout_sym,
+		};
+
+		selfpatch::emit_target(out, target_desc);
+		selfpatch::emit_pop_section(out);
+
+		selfpatch::emit_target_layouts_section(out, ut.hash);
+		selfpatch::emit_hidden_global_label(out, layout_sym);
+
+		selfpatch::target_layout_desc layout_desc{
+			.size = target.size(),
+			.field_cnt = target.fields().size(),
+			.fields_symbol = fields_sym,
+		};
+
+		selfpatch::emit_target_layout(out, layout_desc);
+
+		selfpatch::emit_label(out, fields_sym);
+
+		for (const auto &[off, field] : target.fields()) {
+			const std::string field_name =
+				selfpatch::emit_strtab_entry(out, field.name);
+
+			selfpatch::target_field_desc field_desc{
+				.name_label = field_name,
+				.size = field.size,
+				.offset = field.offset,
+				.alignment = field.alignment,
+				.flags = field.flags,
+			};
+
+			selfpatch::emit_target_field(out, field_desc);
+		}
+
+		selfpatch::emit_pop_section(out);
+	}
+}
+
+static void emit_unit_target_refs(FILE *out,
+				  const std::vector<emitted_target> &targets,
+				  const std::string &target_refs_sym)
+{
+	selfpatch::emit_cu_target_refs_section(out);
+	selfpatch::emit_label(out, target_refs_sym);
+
+	for (const emitted_target &target : targets) {
+		selfpatch::target_ref_desc ref{
+			.target_symbol = selfpatch::target_symbol(target.hash),
+		};
+
+		selfpatch::emit_target_ref(out, ref);
+	}
+
+	selfpatch::emit_pop_section(out);
+}
+
+static void emit_ipins(FILE *out,
+		       const std::unordered_map<UID, std::size_t> &target_idx,
+		       const std::string &ipins_sym)
+{
+	std::vector<std::string> expr_syms;
+	expr_syms.reserve(s2_pins().size());
+
+	for (std::size_t i = 0; i < s2_pins().size(); ++i)
+		expr_syms.push_back(selfpatch::make_local_label("ipin_expr"));
+
+	selfpatch::emit_ipins_section(out);
+	selfpatch::emit_label(out, ipins_sym);
+
+	std::size_t i = 0;
+	for (const auto &[uid, ipin] : s2_pins()) {
+		selfpatch::ipin_desc desc{
+			.addr_expr = ipin.symbol,
+			.size = ipin.imm_size,
+			.expr_symbol = expr_syms[i++],
+		};
+
+		selfpatch::emit_ipin(out, desc);
+	}
+
+	i = 0;
+	for (const auto &[uid, ipin] : s2_pins()) {
+		const auto target_it = target_idx.find(ipin.target);
+
+		if (target_it == target_idx.end())
+			pinpoint_fatal(
+				"finish-unit: ipin target not in unit target map");
+
+		const TargetType *target = TargetType::find(ipin.target);
+		if (!target)
+			pinpoint_fatal("finish-unit: ipin target missing");
+
+		selfpatch::emit_label(out, expr_syms[i++]);
+
+		selfpatch::ipin_expr_desc expr{
+			.unit_target_idx = target_it->second,
+			.field = field_index_for_offset(*target, ipin.offset),
+		};
+
+		selfpatch::emit_ipin_expr(out, expr);
+	}
+
+	selfpatch::emit_pop_section(out);
+}
+
+static void emit_dpins(FILE *out, const std::vector<emitted_dpin> &dpins,
+		       const std::string &dpins_sym)
+{
+	selfpatch::emit_dpins_section(out);
+	selfpatch::emit_label(out, dpins_sym);
+
+	for (const emitted_dpin &pin : dpins) {
+		selfpatch::dpin_desc desc{
+			.addr_expr = pin.addr_expr,
+			.unit_target_idx = pin.unit_target_idx,
+		};
+
+		selfpatch::emit_dpin(out, desc);
+	}
+
+	selfpatch::emit_pop_section(out);
+}
+
+} // namespace
+
+void on_finish_unit(void *plugin_data, void *user_data)
+{
+	FILE *out = asm_out_file;
+
+	const std::vector<emitted_target> targets = collect_all_targets();
+	const auto target_idx = make_unit_target_idx_map(targets);
+	const std::vector<emitted_dpin> dpins = collect_dpins(target_idx);
+
+	const std::string source_label =
+		selfpatch::emit_strtab_entry(out, src_filename());
+
+	const std::string target_refs_sym =
+		selfpatch::make_local_label("target_refs");
+	const std::string ipins_sym = selfpatch::make_local_label("ipins");
+	const std::string dpins_sym = selfpatch::make_local_label("dpins");
+
+	selfpatch::emit_comment(out, "SPSLR runtime metadata");
+
+	emit_target_metadata(out, targets);
+	emit_unit_target_refs(out, targets, target_refs_sym);
+	emit_ipins(out, target_idx, ipins_sym);
+	emit_dpins(out, dpins, dpins_sym);
+
+	selfpatch::emit_units_section(out);
+
+	selfpatch::unit_desc unit{
+		.source_label = source_label,
+		.target_ref_cnt = targets.size(),
+		.target_refs_symbol = target_refs_sym,
+		.ipin_cnt = s2_pins().size(),
+		.ipins_symbol = ipins_sym,
+		.dpin_cnt = dpins.size(),
+		.dpins_symbol = dpins_sym,
+	};
+
+	selfpatch::emit_unit(out, unit);
+	selfpatch::emit_pop_section(out);
+}
diff --git a/scripts/gcc-plugins/pinpoint_on_preserve_component_ref.c b/scripts/gcc-plugins/pinpoint_on_preserve_component_ref.c
new file mode 100644
index 000000000000..956d22227d79
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_on_preserve_component_ref.c
@@ -0,0 +1,95 @@
+#include <pinpoint_stage0.h>
+#include <pinpoint_error.h>
+#include <safe-tree.h>
+
+static tree materialize_c_rvalue(location_t loc, tree expr)
+{
+	gcc_assert(!lvalue_p(expr));
+
+	tree type = TREE_TYPE(expr);
+
+	tree tmp = build_decl(loc, VAR_DECL, create_tmp_var_name("spslr_rval"),
+			      type);
+
+	DECL_CONTEXT(tmp) = current_function_decl;
+	DECL_ARTIFICIAL(tmp) = 1;
+	DECL_IGNORED_P(tmp) = 1;
+	TREE_USED(tmp) = 1;
+	TREE_ADDRESSABLE(tmp) = 1;
+	DECL_CHAIN(tmp) = NULL_TREE;
+
+	// layout_decl(tmp, 0); - not available to plugins
+
+	tree init = build2_loc(loc, INIT_EXPR, type, tmp, expr);
+
+	tree body = build2(COMPOUND_EXPR, type, init, tmp);
+
+	SET_EXPR_LOCATION(body, loc);
+
+	tree bind = build3(BIND_EXPR, type, tmp, body, NULL_TREE);
+
+	SET_EXPR_LOCATION(bind, loc);
+	TREE_SIDE_EFFECTS(bind) = 1;
+
+	return bind;
+}
+
+/*
+ * Preserve an early COMPONENT_REF before GCC folds it into a plain constant
+ * offset.
+ *
+ * The custom GCC hook calls this while the frontend still knows that an
+ * expression is "base.field". We rewrite it into pointer arithmetic whose
+ * offset comes from a synthetic separator call:
+ *
+ *     base.field  ->  *(typeof(field) *)((char *)&base + separator(target, off))
+ *
+ * Later passes replace the separator with an instruction pin.
+ */
+
+static tree ast_separate_offset(tree ref, UID target, std::size_t offset)
+{
+	tree separator = make_stage0_ast_separator(target, offset);
+	if (!separator)
+		pinpoint_fatal(
+			"ast_separate_offset failed to generate AST separator for target %u at offset %u",
+			(unsigned)target, (unsigned)offset);
+
+	tree base = TREE_OPERAND(ref, 0);
+
+	// ADDR_EXPR can never be a valid base, but such trees can happen during parsing before checks
+	if (TREE_CODE(base) == ADDR_EXPR)
+		pinpoint_fatal(
+			"ast_separate_offset encountered ADDR_EXPR as COMPONENT_REF base");
+
+	// Turn rvalue objects into adressable lvalues
+	if (!lvalue_p(base))
+		base = materialize_c_rvalue(EXPR_LOCATION(base), base);
+
+	tree base_ptr = build_fold_addr_expr(base);
+
+	tree field_type = TREE_TYPE(
+		ref); // Type of COMPONENT_REF is type of the accessed field
+	tree field_ptr_type = build_pointer_type(field_type);
+	tree field_ptr =
+		build2(POINTER_PLUS_EXPR, field_ptr_type, base_ptr, separator);
+
+	tree field_ref = build1(INDIRECT_REF, field_type, field_ptr);
+	return field_ref;
+}
+
+void on_preserve_component_ref(void *plugin_data, void *user_data)
+{
+	tree *ref = (tree *)plugin_data;
+	if (!ref)
+		return;
+
+	UID target;
+	std::size_t offset;
+	if (!TargetType::reference(*ref, target, offset))
+		return;
+
+	tree separated = ast_separate_offset(*ref, target, offset);
+	if (separated)
+		*ref = separated;
+}
diff --git a/scripts/gcc-plugins/pinpoint_on_register_attributes.c b/scripts/gcc-plugins/pinpoint_on_register_attributes.c
new file mode 100644
index 000000000000..9e46399782b6
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_on_register_attributes.c
@@ -0,0 +1,53 @@
+#include <cstdio>
+
+#include <pinpoint_stage0.h>
+#include <pinpoint_config.h>
+
+static tree log_new_target(tree *node, tree name, tree args, int flags,
+			   bool *no_add_attrs)
+{
+	if (node)
+		TargetType::add(*node);
+
+	return NULL_TREE;
+}
+
+static tree check_field_fixed_attribute(tree *node, tree name, tree args,
+					int flags, bool *no_add_attrs)
+{
+	if (!node || !*node || TREE_CODE(*node) != FIELD_DECL) {
+		*no_add_attrs = true;
+		fprintf(stderr,
+			"%qs attribute only applies to struct/union fields",
+			SPSLR_FIELD_FIXED_ATTRIBUTE);
+	}
+	return NULL_TREE;
+}
+
+/*
+ * __attribute__((spslr)) marks a record type as a randomization target.
+ * The attribute only registers the type here; fields are fetched later once
+ * GCC has completed the type.
+ */
+
+static struct attribute_spec spslr_attribute = {
+	SPSLR_ATTRIBUTE, 0, 0, false, false, false, false, log_new_target, NULL
+};
+
+/*
+ * __attribute__((spslr_field_fixed)) marks a field as layout-sensitive.
+ * Fixed fields remain part of the target, but are treated as dangerous so
+ * instruction/data pins are not generated for offsets that would become
+ * ambiguous after randomization.
+ */
+
+static struct attribute_spec spslr_fixed_field_attribute = {
+	SPSLR_FIELD_FIXED_ATTRIBUTE, 0,	  0, false, false, false, false,
+	check_field_fixed_attribute, NULL
+};
+
+void on_register_attributes(void *plugin_data, void *user_data)
+{
+	register_attribute(&spslr_attribute);
+	register_attribute(&spslr_fixed_field_attribute);
+}
diff --git a/scripts/gcc-plugins/pinpoint_on_start_unit.c b/scripts/gcc-plugins/pinpoint_on_start_unit.c
new file mode 100644
index 000000000000..7926df8da265
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_on_start_unit.c
@@ -0,0 +1,11 @@
+#include <pinpoint_stage0.h>
+#include <pinpoint_stage1.h>
+#include <pinpoint_stage2.h>
+#include <pinpoint_error.h>
+
+void on_start_unit(void *plugin_data, void *user_data)
+{
+	TargetType::reset();
+	DataPin::reset();
+	s2_pins_reset();
+}
diff --git a/scripts/gcc-plugins/pinpoint_rtl_pin_lower_pass.c b/scripts/gcc-plugins/pinpoint_rtl_pin_lower_pass.c
new file mode 100644
index 000000000000..d24fdb2f08c0
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_rtl_pin_lower_pass.c
@@ -0,0 +1,278 @@
+#include <unordered_map>
+#include <string>
+#include <cstring>
+#include <cstdio>
+
+#include <pinpoint_stage2.h>
+#include <pinpoint_stage1.h>
+#include <pinpoint_config.h>
+#include <pinpoint_error.h>
+#include <safe-rtl.h>
+
+static UID next_stage2_pin_uid = 0;
+static std::unordered_map<UID, S2InstructionPin> pins;
+
+const std::unordered_map<UID, S2InstructionPin> &s2_pins()
+{
+	return pins;
+}
+
+void s2_pins_reset()
+{
+	pins.clear();
+	next_stage2_pin_uid = 0;
+}
+
+/*
+ * Stage2 pins are the bridge from compiler metadata to runtime patching:
+ * target + original offset describe what to compute, while symbol points at
+ * the immediate bytes that must be rewritten.
+ */
+
+UID s2_pin_allocate(const S2InstructionPin &pin)
+{
+	UID uid = next_stage2_pin_uid++;
+	pins.emplace(uid, pin);
+	return uid;
+}
+
+static bool read_marker_inputs(rtx src, UID &target, std::size_t &offset)
+{
+	rtx in0 = ASM_OPERANDS_INPUT(src, 0);
+	rtx in1 = ASM_OPERANDS_INPUT(src, 1);
+
+	if (!CONST_INT_P(in0) || !CONST_INT_P(in1))
+		return false;
+
+	target = (UID)INTVAL(in0);
+	offset = (std::size_t)INTVAL(in1);
+	return true;
+}
+
+static bool extract_set_from_pat(rtx pat, rtx &set_out)
+{
+	if (!pat)
+		return false;
+
+	if (GET_CODE(pat) == SET) {
+		set_out = pat;
+		return true;
+	}
+
+	if (GET_CODE(pat) == PARALLEL) {
+		int len = XVECLEN(pat, 0);
+		for (int i = 0; i < len; ++i) {
+			rtx elem = XVECEXP(pat, 0, i);
+			if (elem && GET_CODE(elem) == SET) {
+				set_out = elem;
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+static bool get_regno_from_dest(rtx dest, unsigned &regno)
+{
+	if (!dest)
+		return false;
+
+	if (REG_P(dest)) {
+		regno = REGNO(dest);
+		return true;
+	}
+
+	if (GET_CODE(dest) == SUBREG) {
+		rtx inner = SUBREG_REG(dest);
+		if (inner && REG_P(inner)) {
+			regno = REGNO(inner);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * Recognize the RTL form of a stage1 marker.
+ *
+ * At this point GCC has selected the destination register. That register
+ * choice determines the exact x86_64 encoding we must emit so the immediate
+ * operand can be labeled and patched later.
+ */
+
+static bool is_stage1_marker_insn(rtx_insn *insn, rtx &set_rtx, rtx &asm_src,
+				  UID &target, std::size_t &offset,
+				  unsigned &regno)
+{
+	if (!insn || !INSN_P(insn))
+		return false;
+
+	rtx pat = PATTERN(insn);
+	if (!extract_set_from_pat(pat, set_rtx))
+		return false;
+
+	rtx dest = SET_DEST(set_rtx);
+	rtx src = SET_SRC(set_rtx);
+
+	if (!src || GET_CODE(src) != ASM_OPERANDS)
+		return false;
+
+	const char *templ = ASM_OPERANDS_TEMPLATE(src);
+	if (!templ)
+		return false;
+
+	/* safer than exact strcmp */
+	if (!std::strstr(templ, s1_ipin_marker))
+		return false;
+
+	if (!read_marker_inputs(src, target, offset))
+		return false;
+
+	if (!get_regno_from_dest(dest, regno))
+		return false;
+
+	asm_src = src;
+	return true;
+}
+
+static const pass_data rtl_pin_lower_pass_data = {
+	RTL_PASS, /* type */
+	"spslr_rtl_pin_lower", /* name */
+	OPTGROUP_NONE, /* optinfo_flags */
+	TV_NONE, /* tv_id */
+	PROP_rtl, /* properties_required */
+	0, /* properties_provided */
+	0, /* properties_destroyed */
+	0, /* todo_flags_start */
+	0 /* todo_flags_finish */
+};
+
+struct EncodedReg {
+	unsigned rex;
+	unsigned modrm;
+};
+
+/*
+ * Encode "mov imm32, r64" for the hard register selected by GCC.
+ *
+ * The immediate is deliberately four bytes: the final asm labels exactly that
+ * immediate field, and runtime selfpatch overwrites those bytes with the
+ * randomized offset value.
+ */
+static bool x86_64_encode_mov_imm32_to_reg(unsigned regno, EncodedReg &out)
+{
+	if (!HARD_REGISTER_NUM_P(regno))
+		return false;
+
+	const char *name = reg_names[regno];
+	if (!name)
+		return false;
+
+	struct RegMapEntry {
+		const char *name;
+		unsigned rex;
+		unsigned rm;
+	};
+
+	static const RegMapEntry regmap[] = {
+		{ "ax", 0x48, 0 },  { "cx", 0x48, 1 },	{ "dx", 0x48, 2 },
+		{ "bx", 0x48, 3 },  { "sp", 0x48, 4 },	{ "bp", 0x48, 5 },
+		{ "si", 0x48, 6 },  { "di", 0x48, 7 },
+
+		{ "r8", 0x49, 0 },  { "r9", 0x49, 1 },	{ "r10", 0x49, 2 },
+		{ "r11", 0x49, 3 }, { "r12", 0x49, 4 }, { "r13", 0x49, 5 },
+		{ "r14", 0x49, 6 }, { "r15", 0x49, 7 },
+	};
+
+	for (const auto &e : regmap) {
+		if (std::strcmp(name, e.name) == 0) {
+			out.rex = e.rex;
+			out.modrm = 0xC0 | e.rm; /* mod=11, /0, rm=e.rm */
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * Emit the final instruction bytes manually so the immediate operand can be
+ * exposed as an object symbol.
+ *
+ * The symbol does not denote executable code as a callable function; it denotes
+ * the four-byte immediate field inside the instruction stream.
+ */
+
+static std::string make_final_x86_64_asm(const std::string &sym,
+					 const EncodedReg &enc, std::size_t imm)
+{
+	char buf[512];
+	std::snprintf(buf, sizeof(buf),
+		      ".byte 0x%02x, 0xC7, 0x%02x\n"
+		      "%s:\n"
+		      ".type %s, @object\n"
+		      ".size %s, 4\n"
+		      ".long %zu",
+		      enc.rex, enc.modrm, sym.c_str(), sym.c_str(), sym.c_str(),
+		      imm);
+	return std::string(buf);
+}
+
+static bool lower_stage1_marker_insn(rtx_insn *insn)
+{
+	rtx set_rtx = nullptr;
+	rtx asm_src = nullptr;
+	UID target = 0;
+	std::size_t offset = 0;
+	unsigned regno = 0;
+
+	if (!is_stage1_marker_insn(insn, set_rtx, asm_src, target, offset,
+				   regno))
+		return false;
+
+	EncodedReg enc{};
+	if (!x86_64_encode_mov_imm32_to_reg(regno, enc)) {
+		pinpoint_fatal(
+			"stage2: unsupported hard register for ipin lowering: regno=%u",
+			(unsigned)regno);
+		return false;
+	}
+
+	S2InstructionPin pin;
+	pin.target = target;
+	pin.offset = offset;
+	pin.imm_size = 4;
+
+	UID pin_uid = s2_pin_allocate(pin);
+
+	auto it = pins.find(pin_uid);
+	if (it == pins.end())
+		pinpoint_fatal("stage2: internal error after s2_pin_allocate");
+
+	it->second.symbol = ".L" + std::string(SPSLR_PINPOINT_STAGE2_PIN) +
+			    std::to_string(pin_uid);
+
+	std::string final_asm =
+		make_final_x86_64_asm(it->second.symbol, enc, offset);
+
+	ASM_OPERANDS_TEMPLATE(asm_src) = ggc_strdup(final_asm.c_str());
+	return true;
+}
+
+rtl_pin_lower_pass::rtl_pin_lower_pass(gcc::context *ctxt)
+	: rtl_opt_pass(rtl_pin_lower_pass_data, ctxt)
+{
+}
+
+unsigned int rtl_pin_lower_pass::execute(function *fn)
+{
+	(void)fn;
+
+	for (rtx_insn *insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
+		(void)lower_stage1_marker_insn(insn);
+	}
+
+	return 0;
+}
diff --git a/scripts/gcc-plugins/pinpoint_separate_offset_pass.c b/scripts/gcc-plugins/pinpoint_separate_offset_pass.c
new file mode 100644
index 000000000000..e1faeee57118
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_separate_offset_pass.c
@@ -0,0 +1,324 @@
+#include <functional>
+#include <list>
+
+#include <pinpoint_stage0.h>
+#include <pinpoint_error.h>
+
+/*
+ * AccessChain flattens nested COMPONENT_REF / ARRAY_REF expressions from
+ * outer base to inner access.
+ *
+ * This lets the pass rebuild the expression one step at a time while replacing
+ * only SPSLR-relevant field offsets with separator calls. Non-target offsets
+ * stay as ordinary constant pointer arithmetic.
+ */
+
+struct AccessChain {
+	struct Step {
+		enum Kind { STEP_COMPONENT, STEP_ARRAY } kind = STEP_COMPONENT;
+
+		tree t = NULL_TREE;
+
+		/* COMPONENT_REF data */
+		bool relevant = false;
+		UID target = UID_INVALID;
+		std::size_t offset = 0;
+	};
+
+	bool relevant = false;
+	std::list<Step> steps;
+	tree base = NULL_TREE;
+};
+
+static tree walk_tree_contains_component_ref(tree *tp, int *walk_subtrees,
+					     void *data)
+{
+	int *found_flag = (int *)data;
+
+	if (!tp || !*tp)
+		return NULL_TREE;
+
+	if (TREE_CODE(*tp) == COMPONENT_REF)
+		*found_flag = 1;
+
+	return NULL_TREE;
+}
+
+static bool tree_contains_component_ref(tree ref)
+{
+	int found_flag = 0;
+	walk_tree(&ref, walk_tree_contains_component_ref, &found_flag, NULL);
+	return found_flag != 0;
+}
+
+static bool access_chain(tree ref, AccessChain &chain)
+{
+	if (!ref)
+		return false;
+
+	switch (TREE_CODE(ref)) {
+	case COMPONENT_REF: {
+		AccessChain::Step step;
+		step.kind = AccessChain::Step::STEP_COMPONENT;
+		step.t = ref;
+		step.relevant =
+			TargetType::reference(ref, step.target, step.offset);
+		if (step.relevant)
+			chain.relevant = true;
+		chain.steps.push_front(step);
+		return access_chain(TREE_OPERAND(ref, 0), chain);
+	}
+
+	case ARRAY_REF:
+	case ARRAY_RANGE_REF: {
+		AccessChain::Step step;
+		step.kind = AccessChain::Step::STEP_ARRAY;
+		step.t = ref;
+		chain.steps.push_front(step);
+		return access_chain(TREE_OPERAND(ref, 0), chain);
+	}
+
+	default:
+		/*
+		 * Access chain construction needs to reach all COMPONENT_REFs. Further
+		 * implementation may be required to cover all possible AST scenarios.
+		 */
+		if (tree_contains_component_ref(ref))
+			return false;
+
+		chain.base = ref;
+		return true;
+	}
+}
+
+/*
+ * Rewrite a relevant field-access chain into explicit pointer arithmetic.
+ *
+ * The resulting MEM_REF has offset zero; all interesting byte offsets have
+ * either become separator calls or fixed constants. This makes the later asm
+ * marker pass independent of GCC's original COMPONENT_REF tree shape.
+ */
+
+static tree separate_offset_chain_maybe(tree ref, gimple_stmt_iterator *gsi)
+{
+	AccessChain chain;
+	if (!access_chain(ref, chain)) {
+		pinpoint_fatal(
+			"separate_offset_chain_maybe encountered invalid access chain: top=%s base=%s",
+			get_tree_code_name(TREE_CODE(ref)),
+			TREE_OPERAND(ref, 0) ? get_tree_code_name(TREE_CODE(
+						       TREE_OPERAND(ref, 0))) :
+					       "<null>");
+	}
+
+	if (!chain.relevant)
+		return NULL_TREE;
+
+	tree cur_expr = chain.base;
+
+	// NOTE -> Could fold into single call here (needs to track what offsets contribute, +irrelevant combined)
+
+	for (const AccessChain::Step &step : chain.steps) {
+		if (step.kind == AccessChain::Step::STEP_COMPONENT) {
+			if (TREE_CODE(cur_expr) == ADDR_EXPR)
+				pinpoint_fatal(
+					"separate_offset_chain_maybe encountered ADDR_EXPR as base of COMPONENT_REF");
+
+			tree cur_ptr = build_fold_addr_expr(cur_expr);
+
+			tree field_ptr_type =
+				build_pointer_type(TREE_TYPE(step.t));
+			tree field_ptr;
+
+			if (step.relevant) {
+				tree return_tmp =
+					create_tmp_var(size_type_node, NULL);
+				gimple *call_stmt = make_stage0_gimple_separator(
+					return_tmp, step.target, step.offset);
+				if (!call_stmt)
+					pinpoint_fatal(
+						"separate_offset_chain_maybe failed to make gimple separator");
+
+				gsi_insert_before(gsi, call_stmt,
+						  GSI_SAME_STMT);
+				field_ptr = build2(POINTER_PLUS_EXPR,
+						   field_ptr_type, cur_ptr,
+						   return_tmp);
+			} else {
+				tree field_decl = TREE_OPERAND(step.t, 1);
+
+				std::size_t field_offset;
+				bool field_bitfield;
+				if (!field_info(field_decl, &field_offset,
+						nullptr, nullptr,
+						&field_bitfield))
+					pinpoint_fatal(
+						"separate_offset_chain_maybe failed to get field info of non-target access");
+				if (field_bitfield)
+					pinpoint_fatal(
+						"separate_offset_chain_maybe encountered bitfield access in relevant COMPONENT_REF chain");
+
+				field_ptr = build2(POINTER_PLUS_EXPR,
+						   field_ptr_type, cur_ptr,
+						   build_int_cst(sizetype,
+								 field_offset));
+			}
+
+			tree ptr_tmp = create_tmp_var(field_ptr_type, NULL);
+
+			tree ptr_val = force_gimple_operand_gsi(
+				gsi, field_ptr,
+				true, // require simple result
+				ptr_tmp, // target temp
+				true, // insert before current stmt
+				GSI_SAME_STMT);
+
+			tree offset0 = fold_convert(TREE_TYPE(ptr_val),
+						    build_int_cst(sizetype, 0));
+
+			cur_expr = build2(MEM_REF, TREE_TYPE(step.t), ptr_val,
+					  offset0);
+
+			continue;
+		}
+
+		if (step.kind == AccessChain::Step::STEP_ARRAY) {
+			tree idx = TREE_OPERAND(step.t, 1);
+			tree low = TREE_OPERAND(step.t, 2);
+			tree elts = TREE_OPERAND(step.t, 3);
+
+			cur_expr = build4(TREE_CODE(step.t), TREE_TYPE(step.t),
+					  cur_expr, idx, low, elts);
+			continue;
+		}
+	}
+
+	return cur_expr;
+}
+
+static void dispatch_separation_maybe(const std::list<tree *> &path,
+				      gimple_stmt_iterator *gsi,
+				      unsigned &cancel_levels)
+{
+	if (path.empty() || !gsi)
+		return;
+
+	tree ref = *path.back();
+	if (!ref || TREE_CODE(ref) != COMPONENT_REF)
+		return;
+
+	cancel_levels = 1;
+
+	tree instrumented_ref = separate_offset_chain_maybe(ref, gsi);
+	if (!instrumented_ref)
+		return;
+
+	gimple_set_modified(gsi_stmt(*gsi), true);
+	*path.back() = instrumented_ref;
+
+	// At this point, instrumented_ref is a MEM_REF node (off=0). A wrapping ADDR_EXPR cancels it out.
+
+	if (path.size() < 2)
+		return;
+
+	tree *parent = *(++path.rbegin());
+
+	if (TREE_CODE(*parent) == ADDR_EXPR) {
+		// Note -> the base of the MEM_REF is expected to have the same type as the ADDR_EXPR
+		*parent = TREE_OPERAND(instrumented_ref, 0);
+		cancel_levels++;
+	}
+}
+
+static const pass_data separate_offset_pass_data = {
+	GIMPLE_PASS, "separate_offset", OPTGROUP_NONE, TV_NONE, 0, 0, 0,
+	0,	     TODO_update_ssa
+};
+
+separate_offset_pass::separate_offset_pass(gcc::context *ctxt)
+	: gimple_opt_pass(separate_offset_pass_data, ctxt)
+{
+}
+
+struct TreeWalkData {
+	std::list<tree *> path;
+	gimple_stmt_iterator *gsi;
+	unsigned cancel_levels;
+	std::function<void(const std::list<tree *> &, gimple_stmt_iterator *,
+			   unsigned &)>
+		callback;
+};
+
+static tree walk_tree_level(tree *tp, int *walk_subtrees, void *data)
+{
+	TreeWalkData *twd = (TreeWalkData *)data;
+	if (!twd)
+		return NULL_TREE;
+
+	if (!twd->path.empty() && twd->path.back() == tp)
+		return NULL_TREE; // root of this level
+
+	if (walk_subtrees)
+		*walk_subtrees = 0;
+
+	twd->cancel_levels = 0;
+	twd->path.push_back(tp);
+
+	twd->callback(twd->path, twd->gsi, twd->cancel_levels);
+
+	if (twd->cancel_levels == 0)
+		walk_tree(tp, walk_tree_level, data, NULL);
+
+	twd->path.pop_back();
+
+	if (twd->cancel_levels > 0)
+		twd->cancel_levels--;
+
+	// Cancel current level if there are still cancel_levels due
+	return twd->cancel_levels == 0 ? NULL_TREE : *tp;
+}
+
+static bool
+walk_gimple_stmt(gimple_stmt_iterator *gsi,
+		 std::function<void(const std::list<tree *> &,
+				    gimple_stmt_iterator *, unsigned &)>
+			 callback)
+{
+	if (!gsi || gsi_end_p(*gsi) || !callback)
+		return false;
+
+	gimple *stmt = gsi_stmt(*gsi);
+
+	for (int i = 0; i < gimple_num_ops(stmt); i++) {
+		tree *op = gimple_op_ptr(stmt, i);
+		if (!op || !*op)
+			continue;
+
+		TreeWalkData twd;
+		twd.gsi = gsi;
+		twd.callback = callback;
+
+		walk_tree_level(op, NULL, &twd);
+	}
+
+	return true;
+}
+
+unsigned int separate_offset_pass::execute(function *fn)
+{
+	if (!fn)
+		return 0;
+
+	basic_block bb;
+	FOR_EACH_BB_FN(bb, fn)
+	{
+		for (gimple_stmt_iterator gsi = gsi_start_bb(bb);
+		     !gsi_end_p(gsi); gsi_next(&gsi)) {
+			if (!walk_gimple_stmt(&gsi, dispatch_separation_maybe))
+				pinpoint_fatal(
+					"separate_offset pass failed to walk gimple statement");
+		}
+	}
+
+	return 0;
+}
diff --git a/scripts/gcc-plugins/pinpoint_separator.c b/scripts/gcc-plugins/pinpoint_separator.c
new file mode 100644
index 000000000000..be753712a57a
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_separator.c
@@ -0,0 +1,123 @@
+#include <pinpoint_stage0.h>
+#include <pinpoint_config.h>
+#include <pinpoint_error.h>
+#include <pinpoint_gc_preserve.h>
+
+static tree separator_decl = NULL_TREE;
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	PINPOINT_GC_MARK_TREE(separator_decl);
+}
+
+/*
+ * Stage0 separators are compiler-internal marker calls, not runtime calls.
+ *
+ * They carry two constants: target UID and original field offset. The call is
+ * declared pure/no-vops so GCC treats it as having no memory side effects; a
+ * later pinpoint pass must remove every separator before code generation.
+ */
+
+static tree make_separator_decl()
+{
+	if (separator_decl)
+		return separator_decl;
+
+	tree args = tree_cons(NULL_TREE, sizetype,
+			      tree_cons(NULL_TREE, sizetype, NULL_TREE));
+	tree type = build_function_type(sizetype, args);
+
+	tree tmp_decl = build_fn_decl(SPSLR_PINPOINT_STAGE0_SEPARATOR, type);
+	if (!tmp_decl)
+		return NULL_TREE;
+
+	DECL_EXTERNAL(tmp_decl) = 1;
+	TREE_PUBLIC(tmp_decl) = 1;
+	DECL_ARTIFICIAL(tmp_decl) = 1;
+
+	/* Prevent VOP problems later when removing calls (VOPs mark memory
+	   side-effects, which these calls have none of anyways) */
+	DECL_PURE_P(tmp_decl) = 1;
+	DECL_IS_NOVOPS(tmp_decl) = 1;
+
+	return (separator_decl = tmp_decl);
+}
+
+tree make_stage0_ast_separator(UID target, std::size_t offset)
+{
+	tree decl = make_separator_decl();
+	if (!decl)
+		return NULL_TREE;
+
+	tree arg0 = size_int(target);
+	tree arg1 = size_int(offset);
+
+	if (!arg0 || !arg1)
+		return NULL_TREE;
+
+	return build_call_expr(decl, 2, arg0, arg1);
+}
+
+gimple *make_stage0_gimple_separator(tree lhs, UID target, std::size_t offset)
+{
+	if (!lhs)
+		return nullptr;
+
+	tree decl = make_separator_decl();
+	if (!decl)
+		return nullptr;
+
+	tree arg0 = size_int(target);
+	tree arg1 = size_int(offset);
+
+	if (!arg0 || !arg1)
+		return nullptr;
+
+	gimple *call = gimple_build_call(decl, 2, arg0, arg1);
+	if (!call)
+		return nullptr;
+
+	gimple_call_set_lhs(call, lhs);
+	return call;
+}
+
+static bool decl_is_separator(tree fndecl)
+{
+	if (!fndecl)
+		return false;
+
+	tree name_tree = DECL_NAME(fndecl);
+	if (!name_tree)
+		return false;
+
+	const char *name = IDENTIFIER_POINTER(name_tree);
+	if (!name)
+		return false;
+
+	return strcmp(name, SPSLR_PINPOINT_STAGE0_SEPARATOR) == 0;
+}
+
+bool is_stage0_separator(gimple *stmt, UID &target, std::size_t &offset)
+{
+	if (!stmt || !is_gimple_call(stmt))
+		return false;
+
+	tree fndecl = gimple_call_fndecl(stmt);
+	if (!decl_is_separator(fndecl))
+		return false;
+
+	tree arg0 = gimple_call_arg(stmt, 0);
+	tree arg1 = gimple_call_arg(stmt, 1);
+
+	if (!arg0 || TREE_CODE(arg0) != INTEGER_CST)
+		pinpoint_fatal(
+			"is_state0_separator failed to get target UID from separator");
+
+	if (!arg1 || TREE_CODE(arg1) != INTEGER_CST)
+		pinpoint_fatal(
+			"is_state0_separator failed to get field offset from separator");
+
+	target = static_cast<UID>(tree_to_uhwi(arg0));
+	offset = static_cast<std::size_t>(tree_to_uhwi(arg1));
+	return true;
+}
diff --git a/scripts/gcc-plugins/pinpoint_serialize.c b/scripts/gcc-plugins/pinpoint_serialize.c
new file mode 100644
index 000000000000..db73c911faf2
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_serialize.c
@@ -0,0 +1,298 @@
+#include <cctype>
+
+#include <pinpoint_serialize.h>
+
+namespace selfpatch
+{
+
+namespace
+{
+
+constexpr std::string_view section_entry = "spslr_entry";
+constexpr std::string_view section_units = "spslr_units";
+constexpr std::string_view section_targets = "spslr_targets";
+constexpr std::string_view section_target_layouts = "spslr_target_layouts";
+constexpr std::string_view section_ipins = "spslr_ipins";
+constexpr std::string_view section_dpins = "spslr_dpins";
+constexpr std::string_view section_strtab = "spslr_strtab";
+constexpr std::string_view section_cu_target_refs = "spslr_cu_target_refs";
+
+std::size_t next_local_label_id = 0;
+
+std::string quote_asm_string(std::string_view s)
+{
+	std::string out;
+	out.reserve(s.size() + 8);
+	out.push_back('"');
+
+	for (unsigned char c : s) {
+		switch (c) {
+		case '\\':
+			out += "\\\\";
+			break;
+		case '"':
+			out += "\\\"";
+			break;
+		case '\n':
+			out += "\\n";
+			break;
+		case '\r':
+			out += "\\r";
+			break;
+		case '\t':
+			out += "\\t";
+			break;
+		case '\0':
+			out += "\\000";
+			break;
+		default:
+			if (std::isprint(c)) {
+				out.push_back(static_cast<char>(c));
+			} else {
+				char buf[5];
+				std::snprintf(buf, sizeof(buf), "\\%03o", c);
+				out += buf;
+			}
+			break;
+		}
+	}
+
+	out.push_back('"');
+	return out;
+}
+
+} // namespace
+
+void emit_comment(FILE *out, std::string_view text)
+{
+	std::fprintf(out, "\n/* %.*s */\n", static_cast<int>(text.size()),
+		     text.data());
+}
+
+void emit_push_section(FILE *out, std::string_view name)
+{
+	/* Future implementation should differentiate between module and host
+	 * section permissions. Module relocations may cause DT_TEXTREL issues
+	 * if the metadata sections are read-only.  */
+	std::fprintf(out, ".pushsection %.*s,\"aw\",@progbits\n",
+		     static_cast<int>(name.size()), name.data());
+}
+
+void emit_push_comdat_section(FILE *out, std::string_view name,
+			      std::string_view group_symbol)
+{
+	/* Future implementation should differentiate between module and host
+	 * section permissions. Module relocations may cause DT_TEXTREL issues
+	 * if the metadata sections are read-only.  */
+	std::fprintf(out, ".pushsection %.*s,\"awG\",@progbits,%.*s,comdat\n",
+		     static_cast<int>(name.size()), name.data(),
+		     static_cast<int>(group_symbol.size()),
+		     group_symbol.data());
+}
+
+void emit_pop_section(FILE *out)
+{
+	std::fprintf(out, ".popsection\n");
+}
+
+void emit_units_section(FILE *out)
+{
+	emit_push_section(out, section_units);
+}
+
+void emit_targets_section(FILE *out, const hash16_t &hash)
+{
+	emit_push_comdat_section(out, section_targets,
+				 comdat_target_symbol(hash));
+}
+
+void emit_target_layouts_section(FILE *out, const hash16_t &hash)
+{
+	emit_push_comdat_section(out, section_target_layouts,
+				 comdat_target_symbol(hash));
+}
+
+void emit_ipins_section(FILE *out)
+{
+	emit_push_section(out, section_ipins);
+}
+
+void emit_dpins_section(FILE *out)
+{
+	emit_push_section(out, section_dpins);
+}
+
+void emit_strtab_section(FILE *out)
+{
+	emit_push_section(out, section_strtab);
+}
+
+void emit_cu_target_refs_section(FILE *out)
+{
+	emit_push_section(out, section_cu_target_refs);
+}
+
+void emit_label(FILE *out, std::string_view label)
+{
+	std::fprintf(out, "%.*s:\n", static_cast<int>(label.size()),
+		     label.data());
+}
+
+void emit_hidden_global_label(FILE *out, std::string_view label)
+{
+	std::fprintf(out, ".globl %.*s\n", static_cast<int>(label.size()),
+		     label.data());
+	std::fprintf(out, ".hidden %.*s\n", static_cast<int>(label.size()),
+		     label.data());
+	emit_label(out, label);
+}
+
+std::string make_local_label(std::string_view stem)
+{
+	std::string out = ".Lspslr_";
+	out.append(stem);
+	out.push_back('_');
+	out.append(std::to_string(next_local_label_id++));
+	return out;
+}
+
+std::string emit_strtab_entry(FILE *out, std::string_view value)
+{
+	const std::string label = make_local_label("str");
+
+	emit_strtab_section(out);
+	emit_label(out, label);
+	emit_c_string(out, value);
+	emit_pop_section(out);
+
+	return label;
+}
+
+void emit_unit(FILE *out, const unit_desc &unit)
+{
+	emit_quad_symbol(out, unit.source_label);
+	emit_quad(out, unit.target_ref_cnt);
+	emit_quad_symbol(out, unit.target_refs_symbol);
+	emit_quad(out, unit.ipin_cnt);
+	emit_quad_symbol(out, unit.ipins_symbol);
+	emit_quad(out, unit.dpin_cnt);
+	emit_quad_symbol(out, unit.dpins_symbol);
+}
+
+void emit_target(FILE *out, const target_desc &target)
+{
+	emit_bytes(out, target.hash.data(), target.hash.size());
+	emit_quad_symbol(out, target.name_label);
+	emit_quad_symbol(out, target.layout_symbol);
+}
+
+void emit_target_layout(FILE *out, const target_layout_desc &layout)
+{
+	emit_quad(out, layout.size);
+	emit_quad(out, layout.field_cnt);
+	emit_quad_symbol(out, layout.fields_symbol);
+}
+
+void emit_target_field(FILE *out, const target_field_desc &field)
+{
+	emit_quad_symbol(out, field.name_label);
+	emit_quad(out, field.size);
+	emit_quad(out, field.offset);
+	emit_quad(out, field.alignment);
+	emit_quad(out, field.flags);
+}
+
+void emit_target_ref(FILE *out, const target_ref_desc &target)
+{
+	emit_quad_symbol(out, target.target_symbol);
+}
+
+void emit_ipin(FILE *out, const ipin_desc &ipin)
+{
+	emit_quad_expr(out, ipin.addr_expr);
+	emit_quad(out, ipin.size);
+	emit_quad_symbol(out, ipin.expr_symbol);
+}
+
+void emit_dpin(FILE *out, const dpin_desc &dpin)
+{
+	emit_quad_expr(out, dpin.addr_expr);
+	emit_quad(out, dpin.unit_target_idx);
+}
+
+void emit_ipin_expr(FILE *out, const ipin_expr_desc &expr)
+{
+	emit_quad(out, expr.unit_target_idx);
+	emit_quad(out, expr.field);
+}
+
+void emit_quad(FILE *out, std::size_t value)
+{
+	std::fprintf(out, ".quad %zu\n", value);
+}
+
+void emit_quad_symbol(FILE *out, std::string_view symbol)
+{
+	emit_quad_expr(out, symbol);
+}
+
+void emit_quad_expr(FILE *out, std::string_view expr)
+{
+	std::fprintf(out, ".quad %.*s\n", static_cast<int>(expr.size()),
+		     expr.data());
+}
+
+void emit_bytes(FILE *out, const void *data, std::size_t size)
+{
+	const auto *bytes = static_cast<const std::uint8_t *>(data);
+
+	for (std::size_t i = 0; i < size; ++i) {
+		if (i % 16 == 0)
+			std::fprintf(out, ".byte ");
+		else
+			std::fprintf(out, ",");
+
+		std::fprintf(out, "0x%02x", bytes[i]);
+
+		if (i % 16 == 15 || i + 1 == size)
+			std::fprintf(out, "\n");
+	}
+}
+
+void emit_c_string(FILE *out, std::string_view value)
+{
+	const std::string quoted = quote_asm_string(value);
+	std::fprintf(out, ".asciz %s\n", quoted.c_str());
+}
+
+std::string hash_hex(const hash16_t &hash)
+{
+	static constexpr char digits[] = "0123456789abcdef";
+
+	std::string out;
+	out.resize(hash.size() * 2);
+
+	for (std::size_t i = 0; i < hash.size(); ++i) {
+		out[i * 2] = digits[(hash[i] >> 4) & 0x0f];
+		out[i * 2 + 1] = digits[hash[i] & 0x0f];
+	}
+
+	return out;
+}
+
+std::string comdat_target_symbol(const hash16_t &hash)
+{
+	return "__comdat_spslr_target_" + hash_hex(hash);
+}
+
+std::string target_symbol(const hash16_t &hash)
+{
+	return "__spslr_target_" + hash_hex(hash);
+}
+
+std::string target_layout_symbol(const hash16_t &hash)
+{
+	return "__spslr_target_layout_" + hash_hex(hash);
+}
+
+} // namespace selfpatch
diff --git a/scripts/gcc-plugins/pinpoint_serialize.h b/scripts/gcc-plugins/pinpoint_serialize.h
new file mode 100644
index 000000000000..218225c65fa5
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_serialize.h
@@ -0,0 +1,114 @@
+#pragma once
+
+#include <array>
+#include <cstddef>
+#include <cstdint>
+#include <cstdio>
+#include <string>
+#include <string_view>
+
+namespace selfpatch
+{
+
+using hash16_t = std::array<std::uint8_t, 16>;
+
+/*
+ * Entry point is:
+ *   __start_spslr_units
+ *   __stop_spslr_units
+ *   __start_spslr_targets
+ *   __stop_spslr_targets
+ */
+
+struct unit_desc {
+	std::string source_label;
+	std::size_t target_ref_cnt = 0;
+	std::string target_refs_symbol;
+	std::size_t ipin_cnt = 0;
+	std::string ipins_symbol;
+	std::size_t dpin_cnt = 0;
+	std::string dpins_symbol;
+};
+
+struct target_desc {
+	hash16_t hash{};
+	std::string name_label;
+	std::string layout_symbol;
+};
+
+struct target_layout_desc {
+	std::size_t size = 0;
+	std::size_t field_cnt = 0;
+	std::string fields_symbol;
+};
+
+struct target_field_desc {
+	std::string name_label;
+	std::size_t size = 0;
+	std::size_t offset = 0;
+	std::size_t alignment = 0;
+	std::uint64_t flags = 0;
+};
+
+struct target_ref_desc {
+	std::string target_symbol;
+};
+
+struct ipin_desc {
+	std::string addr_expr;
+	std::size_t size = 0;
+	std::string expr_symbol;
+};
+
+struct dpin_desc {
+	std::string addr_expr;
+	std::size_t unit_target_idx = 0;
+};
+
+struct ipin_expr_desc {
+	std::size_t unit_target_idx = 0;
+	std::size_t field = 0;
+};
+
+void emit_comment(FILE *out, std::string_view text);
+
+void emit_push_section(FILE *out, std::string_view name);
+void emit_push_comdat_section(FILE *out, std::string_view name,
+			      std::string_view group_symbol);
+void emit_pop_section(FILE *out);
+
+void emit_units_section(FILE *out);
+void emit_targets_section(FILE *out, const hash16_t &hash);
+void emit_target_layouts_section(FILE *out, const hash16_t &hash);
+void emit_ipins_section(FILE *out);
+void emit_dpins_section(FILE *out);
+void emit_strtab_section(FILE *out);
+void emit_cu_target_refs_section(FILE *out);
+
+void emit_label(FILE *out, std::string_view label);
+void emit_hidden_global_label(FILE *out, std::string_view label);
+
+std::string make_local_label(std::string_view stem);
+std::string emit_strtab_entry(FILE *out, std::string_view value);
+
+void emit_unit(FILE *out, const unit_desc &unit);
+void emit_target(FILE *out, const target_desc &target);
+void emit_target_layout(FILE *out, const target_layout_desc &layout);
+void emit_target_field(FILE *out, const target_field_desc &field);
+void emit_target_ref(FILE *out, const target_ref_desc &target);
+void emit_ipin(FILE *out, const ipin_desc &ipin);
+void emit_dpin(FILE *out, const dpin_desc &dpin);
+void emit_ipin_expr(FILE *out, const ipin_expr_desc &expr);
+
+void emit_quad(FILE *out, std::size_t value);
+void emit_quad_symbol(FILE *out, std::string_view symbol);
+void emit_quad_expr(FILE *out, std::string_view expr);
+void emit_bytes(FILE *out, const void *data, std::size_t size);
+void emit_c_string(FILE *out, std::string_view value);
+
+std::string hash_hex(const hash16_t &hash);
+std::string comdat_target_symbol(const hash16_t &hash);
+std::string target_symbol(const hash16_t &hash);
+std::string target_layout_symbol(const hash16_t &hash);
+
+} // namespace selfpatch
diff --git a/scripts/gcc-plugins/pinpoint_stage0.h b/scripts/gcc-plugins/pinpoint_stage0.h
new file mode 100644
index 000000000000..2c15c2ccce88
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_stage0.h
@@ -0,0 +1,105 @@
+#pragma once
+#include <cstddef>
+#include <map>
+#include <map>
+#include <string>
+#include <list>
+#include <limits>
+
+#include <safe-tree.h>
+#include <safe-gimple.h>
+
+using UID = std::size_t;
+constexpr UID UID_INVALID = std::numeric_limits<UID>::max();
+
+class TargetType {
+    public:
+	struct Field {
+		static constexpr std::size_t FLAG_DANGEROUS = 1;
+		static constexpr std::size_t FLAG_OVERLAP = 2;
+
+		std::string name;
+		std::size_t offset;
+		std::size_t size;
+		std::size_t alignment;
+		std::size_t flags;
+	};
+
+    private:
+	static constexpr std::size_t FLAG_MAIN_VARIANT = 1;
+	static constexpr std::size_t FLAG_FIELDS = 2;
+
+	UID m_uid;
+	std::size_t m_flags;
+	tree m_main_variant;
+	std::size_t m_size;
+
+	// Fields are identified by their offsets
+	std::map<std::size_t, Field> m_fields;
+
+    public:
+	TargetType(const TargetType &other) = default;
+	TargetType &operator=(const TargetType &other) = default;
+	TargetType(TargetType &&other) = default;
+	TargetType &operator=(TargetType &&other) = default;
+
+	TargetType(tree t); // Does NOT fetch fields
+	~TargetType();
+
+	bool valid() const;
+	bool has_fields() const;
+	const std::map<std::size_t, Field> &fields() const;
+	std::string name() const;
+	const Field *field(std::size_t off, bool exact = true) const;
+	UID uid() const;
+	std::size_t size() const;
+	void gc_preserve() const;
+
+	static void add(tree t);
+	static std::size_t count();
+	static const TargetType *find(tree t); // O(n)
+	static const TargetType *find(UID uid); // O(1)
+	static bool reference(tree ref, UID &target, std::size_t &offset);
+	static const std::map<UID, TargetType> &all();
+	static void reset();
+
+    private:
+	friend void on_finish_type(void *, void *);
+	bool fetch_fields(bool redo = false);
+	static TargetType *find_mutable(tree t);
+};
+
+bool field_info(tree field_decl, std::size_t *offset, std::size_t *size,
+		std::size_t *alignment, bool *bitfield);
+
+/* Stage 0 offsetof separators are function calls, such as:
+   SPSLR_PINPOINT_STAGE0_SEPARATOR(target, member offset) */
+
+tree make_stage0_ast_separator(UID target, std::size_t offset);
+gimple *make_stage0_gimple_separator(tree lhs, UID target, std::size_t offset);
+bool is_stage0_separator(gimple *stmt, UID &target, std::size_t &offset);
+
+struct DataPin {
+	struct Component {
+		std::size_t offset;
+		std::size_t level;
+		UID target;
+	};
+
+	std::string symbol; // potentially local object symbol
+	std::list<Component> components;
+
+	static void reset();
+	static const std::list<DataPin> &all();
+};
+
+void on_register_attributes(void *plugin_data, void *user_data);
+void on_finish_type(void *plugin_data, void *user_data);
+void on_preserve_component_ref(void *plugin_data, void *user_data);
+void on_finish_decl(void *plugin_data, void *user_data);
+void on_start_unit(void *plugin_data, void *user_data);
+
+struct separate_offset_pass : gimple_opt_pass {
+	separate_offset_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
diff --git a/scripts/gcc-plugins/pinpoint_stage1.h b/scripts/gcc-plugins/pinpoint_stage1.h
new file mode 100644
index 000000000000..5190ad3543ef
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_stage1.h
@@ -0,0 +1,11 @@
+#pragma once
+
+#include <pinpoint_stage0.h>
+#include <safe-gimple.h>
+
+extern const char *s1_ipin_marker;
+
+struct asm_offset_pass : gimple_opt_pass {
+	asm_offset_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
diff --git a/scripts/gcc-plugins/pinpoint_stage2.h b/scripts/gcc-plugins/pinpoint_stage2.h
new file mode 100644
index 000000000000..b6dbf61a7ed2
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_stage2.h
@@ -0,0 +1,22 @@
+#pragma once
+#include <unordered_map>
+#include <string>
+
+#include <pinpoint_stage0.h>
+#include <safe-rtl.h>
+
+struct S2InstructionPin {
+	UID target;
+	std::size_t offset;
+	std::size_t imm_size;
+	std::string symbol;
+};
+
+const std::unordered_map<UID, S2InstructionPin> &s2_pins();
+void s2_pins_reset();
+UID s2_pin_allocate(const S2InstructionPin &pin);
+
+struct rtl_pin_lower_pass : rtl_opt_pass {
+	rtl_pin_lower_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
diff --git a/scripts/gcc-plugins/pinpoint_target.c b/scripts/gcc-plugins/pinpoint_target.c
new file mode 100644
index 000000000000..94599251d550
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint_target.c
@@ -0,0 +1,460 @@
+#include <functional>
+#include <cstring>
+
+#include <pinpoint_stage0.h>
+
+#include <safe-langhooks.h>
+#include <safe-attribs.h>
+
+#include <pinpoint_config.h>
+#include <pinpoint_error.h>
+#include <pinpoint_gc_preserve.h>
+
+/*
+ * TargetType is the compiler-side model of an SPSLR-randomized record type.
+ *
+ * A target is keyed by GCC's main record variant, not by spelling alone, so
+ * typedefs and compatible variants resolve to the same SPSLR target. The UID
+ * is local to this compilation unit; patchcompile later merges compatible
+ * targets across objects.
+ */
+
+static UID next_uid = 0;
+static std::map<UID, TargetType> targets;
+
+static tree get_record_main_variant(tree t)
+{
+	if (!t || TREE_CODE(t) != RECORD_TYPE)
+		return NULL_TREE;
+
+	return TYPE_MAIN_VARIANT(t);
+}
+
+static std::string field_decl_name(tree field_decl)
+{
+	tree name = DECL_NAME(field_decl);
+
+	if (!name)
+		return "<anonymous>";
+
+	return IDENTIFIER_POINTER(name);
+}
+
+static std::string merge_field_names(const std::string &a, const std::string &b)
+{
+	if (a.empty())
+		return b;
+
+	if (b.empty())
+		return a;
+
+	return a + "," + b;
+}
+
+TargetType::TargetType(tree t)
+	: m_uid{ UID_INVALID }
+	, m_flags{ 0 }
+	, m_size{ 0 }
+{
+	if (!(m_main_variant = get_record_main_variant(t)))
+		return;
+
+	m_flags |= FLAG_MAIN_VARIANT;
+}
+
+TargetType::~TargetType()
+{
+}
+
+bool TargetType::valid() const
+{
+	return (m_flags & FLAG_MAIN_VARIANT) != 0;
+}
+
+bool TargetType::has_fields() const
+{
+	return (m_flags & FLAG_FIELDS) != 0;
+}
+
+const std::map<std::size_t, TargetType::Field> &TargetType::fields() const
+{
+	return m_fields;
+}
+
+std::string TargetType::name() const
+{
+	const char *error_name = "<error>";
+	const char *anonymous_name = "<anonymous>";
+
+	if (!valid())
+		return { error_name };
+
+	tree name_tree = TYPE_NAME(m_main_variant);
+	if (!name_tree)
+		return { anonymous_name };
+
+	if (TREE_CODE(name_tree) == TYPE_DECL && DECL_NAME(name_tree))
+		return { IDENTIFIER_POINTER(DECL_NAME(name_tree)) };
+	else if (TREE_CODE(name_tree) == IDENTIFIER_NODE)
+		return { IDENTIFIER_POINTER(name_tree) };
+
+	return { anonymous_name };
+}
+
+const TargetType::Field *TargetType::field(std::size_t off, bool exact) const
+{
+	if (!valid() || !(m_flags & FLAG_FIELDS))
+		return nullptr;
+
+	auto it = m_fields.upper_bound(off); // Next element
+	if (it == m_fields.begin())
+		return nullptr;
+
+	--it; // Element of interest
+
+	const TargetType::Field &maybe = it->second;
+
+	if (off >= maybe.offset + maybe.size)
+		return nullptr;
+
+	if (exact && maybe.offset != off)
+		return nullptr;
+
+	return &maybe;
+}
+
+UID TargetType::uid() const
+{
+	return m_uid;
+}
+
+std::size_t TargetType::size() const
+{
+	if (!valid() || !(m_flags & FLAG_FIELDS))
+		return 0;
+
+	return m_size;
+}
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	for (const auto &[uid, target] : targets)
+		target.gc_preserve();
+}
+
+void TargetType::gc_preserve() const
+{
+	PINPOINT_GC_MARK_TREE(m_main_variant);
+}
+
+void TargetType::add(tree t)
+{
+	if (find(t) != nullptr)
+		return;
+
+	TargetType tmp{ t };
+	if (!tmp.valid())
+		return;
+
+	tmp.m_uid = next_uid++;
+	targets.emplace(tmp.m_uid, tmp);
+}
+
+std::size_t TargetType::count()
+{
+	return targets.size();
+}
+
+const TargetType *TargetType::find(tree t)
+{
+	tree main_variant = get_record_main_variant(t);
+	if (!main_variant)
+		return nullptr;
+
+	for (const auto &[uid, target] : targets) {
+		if (lang_hooks.types_compatible_p(main_variant,
+						  target.m_main_variant))
+			return &target;
+	}
+
+	return nullptr;
+}
+
+TargetType *TargetType::find_mutable(tree t)
+{
+	tree main_variant = get_record_main_variant(t);
+	if (!main_variant)
+		return nullptr;
+
+	for (auto &[uid, target] : targets) {
+		if (lang_hooks.types_compatible_p(main_variant,
+						  target.m_main_variant))
+			return &target;
+	}
+
+	return nullptr;
+}
+
+const TargetType *TargetType::find(UID uid)
+{
+	auto it = targets.find(uid);
+	if (it == targets.end())
+		return nullptr;
+
+	return &it->second;
+}
+
+/*
+ * Convert GCC's byte + bit field layout into the byte-oriented layout model
+ * used by SPSLR metadata.
+ *
+ * Bitfields and sub-byte/overlapping storage are marked dangerous because the
+ * current runtime randomizer can only move independently addressable byte ranges.
+ */
+
+bool field_info(tree field_decl, std::size_t *offset, std::size_t *size,
+		std::size_t *alignment, bool *bitfield)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		return false;
+
+	tree field_off_t = DECL_FIELD_OFFSET(field_decl);
+	if (!field_off_t || TREE_CODE(field_off_t) != INTEGER_CST)
+		return false;
+
+	tree field_bit_off_t = DECL_FIELD_BIT_OFFSET(field_decl);
+	if (!field_bit_off_t || TREE_CODE(field_bit_off_t) != INTEGER_CST)
+		return false;
+
+	tree field_size_t = DECL_SIZE(field_decl);
+	if (!field_size_t || TREE_CODE(field_size_t) != INTEGER_CST)
+		return false;
+
+	HOST_WIDE_INT tmp_byte_offset = tree_to_uhwi(field_off_t);
+	HOST_WIDE_INT tmp_bit_offset = tree_to_uhwi(field_bit_off_t);
+	HOST_WIDE_INT tmp_bit_size = tree_to_uhwi(field_size_t);
+
+	HOST_WIDE_INT bit_offset_bytes = tmp_bit_offset / 8;
+	tmp_byte_offset += bit_offset_bytes;
+	tmp_bit_offset -= bit_offset_bytes * 8;
+
+	bool tmp_bitfield = (DECL_BIT_FIELD_TYPE(field_decl) != NULL_TREE);
+	tmp_bitfield |= !(tmp_bit_size % 8 == 0 && tmp_bit_offset == 0);
+
+	tmp_bit_size += tmp_bit_offset;
+
+	HOST_WIDE_INT tmp_bit_overhang = tmp_bit_size % 8;
+	if (tmp_bit_overhang != 0)
+		tmp_bit_size += (8 - tmp_bit_overhang);
+
+	HOST_WIDE_INT tmp_align_bits = DECL_ALIGN(field_decl);
+	if (tmp_align_bits <= 0 && TREE_TYPE(field_decl))
+		tmp_align_bits = TYPE_ALIGN(TREE_TYPE(field_decl));
+	if (tmp_align_bits <= 0)
+		tmp_align_bits = BITS_PER_UNIT;
+
+	std::size_t tmp_alignment = static_cast<std::size_t>(
+		(tmp_align_bits + BITS_PER_UNIT - 1) / BITS_PER_UNIT);
+	if (tmp_alignment == 0)
+		tmp_alignment = 1;
+
+	if (offset)
+		*offset = static_cast<std::size_t>(tmp_byte_offset);
+
+	if (size)
+		*size = static_cast<std::size_t>(tmp_bit_size / 8);
+
+	if (alignment)
+		*alignment = tmp_alignment;
+
+	if (bitfield)
+		*bitfield = tmp_bitfield;
+
+	return true;
+}
+
+bool TargetType::reference(tree ref, UID &target, std::size_t &offset)
+{
+	if (!ref || TREE_CODE(ref) != COMPONENT_REF)
+		return false;
+
+	tree base = TREE_OPERAND(ref, 0);
+	if (!base)
+		return false;
+
+	tree base_type = TREE_TYPE(base);
+	if (!base_type)
+		return false;
+
+	const TargetType *base_target = TargetType::find(base_type);
+	if (!base_target)
+		return false;
+
+	target = base_target->uid();
+
+	tree field_decl = TREE_OPERAND(ref, 1);
+
+	if (!field_info(field_decl, &offset, nullptr, nullptr, nullptr))
+		return false;
+
+	const Field *f = base_target->field(offset, false);
+	if (!f || (f->flags & Field::FLAG_DANGEROUS))
+		return false;
+
+	return true;
+}
+
+const std::map<UID, TargetType> &TargetType::all()
+{
+	return targets;
+}
+
+void TargetType::reset()
+{
+	targets.clear();
+	next_uid = 0;
+}
+
+static bool
+foreach_record_field(tree t,
+		     std::function<bool(const TargetType::Field &)> callback)
+{
+	if (!t || TREE_CODE(t) != RECORD_TYPE)
+		return false;
+
+	if (!COMPLETE_TYPE_P(t))
+		return false;
+
+	for (tree field_decl = TYPE_FIELDS(t); field_decl;
+	     field_decl = DECL_CHAIN(field_decl)) {
+		if (TREE_CODE(field_decl) != FIELD_DECL)
+			continue;
+
+		TargetType::Field field;
+		bool is_bitfield;
+
+		if (!field_info(field_decl, &field.offset, &field.size,
+				&field.alignment, &is_bitfield))
+			return false;
+
+		tree attrs = DECL_ATTRIBUTES(field_decl);
+		bool is_fixed = lookup_attribute(SPSLR_FIELD_FIXED_ATTRIBUTE,
+						 attrs) != NULL_TREE;
+
+		field.flags = ((is_fixed || is_bitfield) ?
+				       TargetType::Field::FLAG_DANGEROUS :
+				       0);
+
+		field.name = field_decl_name(field_decl);
+
+		if (!callback(field))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Merge overlapping fields into one dangerous region.
+ *
+ * GCC can expose fields that overlap through bitfields, zero-sized members,
+ * padding-sensitive constructs, or frontend-specific layout artifacts. SPSLR
+ * keeps the containing byte range fixed rather than pretending those pieces
+ * can be randomized independently.
+ */
+
+static bool field_map_add(std::map<std::size_t, TargetType::Field> &map,
+			  const TargetType::Field &field)
+{
+	TargetType::Field tmp_field;
+	tmp_field.name = field.name;
+	tmp_field.offset = field.offset;
+	tmp_field.size = (field.size == 0 ? 1 : field.size);
+	tmp_field.alignment = (field.alignment == 0 ? 1 : field.alignment);
+	tmp_field.flags =
+		(field.size == 0 ? TargetType::Field::FLAG_DANGEROUS : 0) |
+		field.flags;
+
+	// Overlaps are dangerous -> remove and integrate into member
+	auto overlap_end = map.lower_bound(tmp_field.offset + tmp_field.size);
+	for (auto it = std::make_reverse_iterator(overlap_end);
+	     it != map.rend();) {
+		const TargetType::Field &existing_field = it->second;
+
+		if (existing_field.offset + existing_field.size <=
+		    tmp_field.offset)
+			break;
+
+		auto combined_end = std::max<decltype(tmp_field.offset)>(
+			tmp_field.offset + tmp_field.size,
+			existing_field.offset + existing_field.size);
+
+		auto combined_offset = std::min<decltype(tmp_field.offset)>(
+			tmp_field.offset, existing_field.offset);
+		auto combined_size = combined_end - combined_offset;
+
+		tmp_field.flags |= (existing_field.flags |
+				    TargetType::Field::FLAG_DANGEROUS |
+				    TargetType::Field::FLAG_OVERLAP);
+		tmp_field.offset = combined_offset;
+		tmp_field.name =
+			merge_field_names(tmp_field.name, existing_field.name);
+
+		std::size_t required_alignment =
+			std::max(tmp_field.alignment, existing_field.alignment);
+
+		if (tmp_field.offset % required_alignment != 0)
+			pinpoint_fatal(
+				"encountered invalid overlapping fields");
+
+		tmp_field.alignment = required_alignment;
+		tmp_field.size = combined_size;
+
+		// Erase overlapping member
+		auto tmp_forward = std::prev(it.base());
+		tmp_forward = map.erase(tmp_forward);
+		it = std::make_reverse_iterator(tmp_forward);
+	}
+
+	map.emplace(tmp_field.offset, tmp_field);
+	return true;
+}
+
+bool TargetType::fetch_fields(bool redo)
+{
+	if (!valid())
+		return false;
+
+	if ((m_flags & FLAG_FIELDS) != 0 && !redo)
+		return true;
+
+	m_flags &= ~FLAG_FIELDS;
+	m_fields.clear();
+
+	std::map<std::size_t, Field> tmp_fields;
+
+	auto per_field_callback = [&tmp_fields](const Field &field) -> bool {
+		return field_map_add(tmp_fields, field);
+	};
+
+	if (!foreach_record_field(m_main_variant, per_field_callback))
+		return false;
+
+	// Get struct size
+
+	tree size_tree = TYPE_SIZE(m_main_variant);
+	if (!size_tree || TREE_CODE(size_tree) != INTEGER_CST)
+		return false;
+
+	HOST_WIDE_INT size_bits = tree_to_uhwi(size_tree);
+	if (size_bits < 0 || size_bits % 8 != 0)
+		return false;
+
+	m_size = static_cast<std::size_t>(size_bits / 8);
+
+	// Everything done
+
+	m_fields = std::move(tmp_fields);
+	m_flags |= FLAG_FIELDS;
+	return true;
+}
diff --git a/scripts/gcc-plugins/safe-attribs.h b/scripts/gcc-plugins/safe-attribs.h
new file mode 100644
index 000000000000..0881abc2598d
--- /dev/null
+++ b/scripts/gcc-plugins/safe-attribs.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_ATTRIBS_H
+#define SAFEGCC_ATTRIBS_H
+
+#include <attribs.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-diagnostic.h b/scripts/gcc-plugins/safe-diagnostic.h
new file mode 100644
index 000000000000..3577020c880b
--- /dev/null
+++ b/scripts/gcc-plugins/safe-diagnostic.h
@@ -0,0 +1,9 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_DIAGNOSTIC_H
+#define SAFEGCC_DIAGNOSTIC_H
+
+#include <diagnostic.h>
+#include <diagnostic-core.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-gcc-plugin.h b/scripts/gcc-plugins/safe-gcc-plugin.h
new file mode 100644
index 000000000000..fcd111636a1c
--- /dev/null
+++ b/scripts/gcc-plugins/safe-gcc-plugin.h
@@ -0,0 +1,6 @@
+#ifndef SAFEGCC_GCC_PLUGIN_H
+#define SAFEGCC_GCC_PLUGIN_H
+
+#include <gcc-plugin.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-ggc.h b/scripts/gcc-plugins/safe-ggc.h
new file mode 100644
index 000000000000..5df62ad492e8
--- /dev/null
+++ b/scripts/gcc-plugins/safe-ggc.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_GGC_H
+#define SAFEGCC_GGC_H
+
+#include <ggc.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-gimple.h b/scripts/gcc-plugins/safe-gimple.h
new file mode 100644
index 000000000000..2eb0bae2f0a4
--- /dev/null
+++ b/scripts/gcc-plugins/safe-gimple.h
@@ -0,0 +1,14 @@
+#include <safe-gcc-plugin.h>
+#include <safe-tree.h>
+
+#ifndef SAFEGCC_GIMPLE_H
+#define SAFEGCC_GIMPLE_H
+
+#include <gimple.h>
+#include <gimplify.h>
+#include <gimple-iterator.h>
+#include <gimple-pretty-print.h>
+#include <gimplify-me.h>
+#include <ssa.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-input.h b/scripts/gcc-plugins/safe-input.h
new file mode 100644
index 000000000000..fe24435830fe
--- /dev/null
+++ b/scripts/gcc-plugins/safe-input.h
@@ -0,0 +1,9 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_INPUT_H
+#define SAFEGCC_INPUT_H
+
+#include <input.h>
+#include <libiberty.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-langhooks.h b/scripts/gcc-plugins/safe-langhooks.h
new file mode 100644
index 000000000000..3fbea6ccb579
--- /dev/null
+++ b/scripts/gcc-plugins/safe-langhooks.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_LANGHOOKS_H
+#define SAFEGCC_LANGHOOKS_H
+
+#include <langhooks.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-md5.h b/scripts/gcc-plugins/safe-md5.h
new file mode 100644
index 000000000000..8341cb193467
--- /dev/null
+++ b/scripts/gcc-plugins/safe-md5.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_MD5_H
+#define SAFEGCC_MD5_H
+
+#include <md5.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-output.h b/scripts/gcc-plugins/safe-output.h
new file mode 100644
index 000000000000..5da7fec494be
--- /dev/null
+++ b/scripts/gcc-plugins/safe-output.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_OUTPUT_H
+#define SAFEGCC_OUTPUT_H
+
+#include <output.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-plugin-version.h b/scripts/gcc-plugins/safe-plugin-version.h
new file mode 100644
index 000000000000..e43a1689da8c
--- /dev/null
+++ b/scripts/gcc-plugins/safe-plugin-version.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_PLUGIN_VERSION_H
+#define SAFEGCC_PLUGIN_VERSION_H
+
+#include <plugin-version.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-rtl.h b/scripts/gcc-plugins/safe-rtl.h
new file mode 100644
index 000000000000..f89decdb1d18
--- /dev/null
+++ b/scripts/gcc-plugins/safe-rtl.h
@@ -0,0 +1,17 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_RTL_H
+#define SAFEGCC_RTL_H
+
+#include <rtl.h>
+#include <rtl-iter.h>
+#include <memmodel.h>
+#include <emit-rtl.h>
+#include <function.h>
+#include <expr.h>
+#include <hard-reg-set.h>
+
+#undef toupper
+#undef tolower
+
+#endif
diff --git a/scripts/gcc-plugins/safe-tree.h b/scripts/gcc-plugins/safe-tree.h
new file mode 100644
index 000000000000..d968f8b9675a
--- /dev/null
+++ b/scripts/gcc-plugins/safe-tree.h
@@ -0,0 +1,10 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_TREE_H
+#define SAFEGCC_TREE_H
+
+#include <tree.h>
+#include <tree-pass.h>
+#include <c-tree.h>
+
+#endif
-- 
2.43.0

