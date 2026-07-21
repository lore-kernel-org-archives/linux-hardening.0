Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAD433BCA
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662298; cv=none; b=Lmny9unC0eOumRT3V/B+vmG0XkbPE8/fbFXH4YFFFDgdqDfjVJ+aJiZxuI/LOiIqzLWiDkCDOZzG0T3y1KPbS3Qops84julFuNAhieYSKcrtXaC5feSfaDZPJInpCuKlsVTzz5kyjQR+vRyYpRyw0PAC5aw/oa8SO79DwbErphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662298; c=relaxed/simple;
	bh=nqw0U761kDglY7egbApdz1vkEQVZFA4+mwk7f/EwRF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+s63sVNFtUdibQijKYThlwkR+7T7MXB7P4IyG5mP8IUiMjYsfFwlbpzTD0cIwKNegAQrl1zDlrg5a0e3cmQMLJWuY+9RQN1O784ZltMjMmUD8oRlES71GYqTRaAbNhT7HTs2gbCojC83iqu26caZO3lfvl3kvSLCBfYA0vGcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=DWTR5HeN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="DWTR5HeN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so24859645e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784662291; x=1785267091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWppgYH7QlHW6b8BaoU8Il2wS7g2X4hOSDayxKjxSQs=;
        b=DWTR5HeNSZSvUYE87UJHDBKZRgstQuhG/rbrKbOfUK/O/fXH639TcqKADyQbefqaZT
         NGHFIaeN32z2TYlGBVtSeUKY6Fs2+Fye9emRZfROZL7qzV6Gx6BPImeibmSlgv5ZawYZ
         5SOVKvnyVxsBL0HHLlffEyiLPtKjVL4SfRPhGuUoMxyBA0vj5Racsr6o34Eco0EQLCcP
         ArbD5RWyxq090Ct1nIf+sEhNZW1eW6Rg2NWqZHNbU/7YFB09LTSmdkkGcZcI9Q6bupjB
         rHJUbRKtghXJnLBhwwu86wmovC6Xx0Lv3nL8A5nrL9InRJNSiObEYMJpXiB1xCgSfucN
         f/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662291; x=1785267091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWppgYH7QlHW6b8BaoU8Il2wS7g2X4hOSDayxKjxSQs=;
        b=GVYAkhKj2cUfry51pa7xBddj+r56R3SquQGdd9MqcanfUlW5pi793W7pJ/8vFyGhhq
         dSVvKhjaY71ddyoF0xJw5zOB63WBfZDYV/AtTp6oGoVVYuV0vSd3OMei4YhyVI07RdUL
         44N/SNBoj9q0BgKCeoXy5Bb8pMNzmQ6gCLgotAatdD36JZxi1JEV9VrD/9Awk9A2Hgx3
         /vuUntaRx1GPRQXfu7dQLsaeGBk59pkNjYESLSFindD+RwIKATQ/psP/vTRVxtXrrqU9
         L2A9cjhK3WzMP7nOMLVLJRYXg4z0zhmOG3VlLvL0iy6D3rdiYOatSCY64IbNWzDX4qwo
         Hrvw==
X-Gm-Message-State: AOJu0Yx8fIstsowtja8cu46NhsyomDdGaaS4S6yR5YpW0WHQhgQRWhP0
	WLFUPuyd7SYKGGpHNuOZzY9wavqWs2i/GwaR6nt72iYkXCrBZMrP0arKDxQasRBJOfj92npnz/P
	nUaoHwOt1
X-Gm-Gg: AfdE7cmfy3gDDeAZ4MzEQnGnsoOu8xCH4Z2VvHwt7yEqSTD0w/0nu9CfO/hfBnGd+gy
	mXWJPnqUuYNpZ/VHz2C6MJFJdF6pNclzjQ8I1JZAiJrR/R3BoNg/HqCvF3HrzUWrzeLvupT+gON
	Ocx1O/hozjnsm+hqOnWCTuZtb7iq9yVicrwO1yv8z+W2NQ1KE4/wy1afm6e5ZnsNSneLCV0AxT9
	usxk9ivuO/rzxE4Obl4OQmO6vwy3YGhIAnbeqxfO5LdwBhmkf4aJt/Je/9r7ZKV56tDC7QsGVfN
	Qn5iWnmv5mYBzfdF+SiXApbRZGD0OSBsNM17pXLaWMTu7foSCO6dodJNjfShzV7wius0Z3iK/Pk
	0bnnfq/9vocWCNNdAIA968oyP6Um7+uTYvFZ9sfDSvYZuCkiyt3Kz8e9mWpBYX3XMoxG+kpGMv6
	TXptOMUIgvr+AoncrYr4+yMtEa6htY8RKmRHXfA7qN2CVQc8aRgUUNmaRbVXnmc0GYJ+HQoUw1m
	9aetDPia2bcC60jDUY=
X-Received: by 2002:a05:600c:1c09:b0:495:4fd4:f7b6 with SMTP id 5b1f17b1804b1-4954fd4fbdbmr200565935e9.37.1784662289476;
        Tue, 21 Jul 2026 12:31:29 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00a6ccab16241b6894.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:a6cc:ab16:241b:6894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653d38dbsm83744015e9.15.2026.07.21.12.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:31:29 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org,
	gregkh@linuxfoundation.org
Subject: [RFC v3 1/5] Pinpoint plugin
Date: Tue, 21 Jul 2026 21:31:28 +0200
Message-ID: <20260721193128.45989-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720191243.21571-1-yjn@yjn-systems.com>
References: <20260720191243.21571-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reposting this patch with a proper commit message following Greg's
comment :) No functional changes.

This patch adds the Pinpoint GCC plugin of the Bootpatch-SLR series. It
is the backing compiler extension that generates the metadata needed to
patch the kernel at boot to reflect randomized structure layouts.

Since new GCC plugins are no longer accepted upstream, this RFC uses a
GCC plugin as a prototype for the compiler-specific functionality. The
long-term implementation would need to live in GCC/LLVM instead.

This plugin necessitates the use of a customized toolchain.
Specifically, a GCC 16.1.0 patch is required to provide Pinpoint access
to offsetof-like expressions that are usually folded into constants by
GCC's C frontend. Additionally, a patch for GAS of binutils 2.46.1 adds
support for instruction immediate/displacement bytes labeling. Both
patches are available at:

    https://github.com/YJN-Systems/Selfpatch-SLR/tree/rfc-v3/toolchain

Pinpoint instruments all COMPONENT_REFs to randomized fields of target
struct types. Targets are marked with __attribute__((spslr)). Individual
fields can be fixed in place using __attribute__((spslr_field_fixed)).
Bit fields are implicitly fixed in this version.

To prevent relevant COMPONENT_REFs from being folded by other compiler
passes, Pinpoint replaces them with unfoldable call expressions at two
points. First, the PLUGIN_BUILD_COMPONENT_REF callback (from the GCC
patch) is used to replace most COMPONENT_REFs right away. For the most
part, this happens during parsing and thus catches offsetof-like
expressions before they can be folded. An additional
separate_offset pass handles the remaining COMPONENT_REFs at the
earliest GIMPLE stage. Especially initializers which only produce
COMPONENT_REFs during lowering are transformed by this pass.

A separated COMPONENT_REF that accesses "field" of some "obj" looks as
follows:

    *(typeof(obj->field) *)((char *)obj +
        __spslr_offsetof(instruction_pin_id))

The only argument of __spslr_offsetof is an identifier with which
metadata is associated (which struct, which field, ...). These calls do
not represent runtime calls and have to be removed by the following
transformations.

Right after offset separation, the asm_offset pass replaces all calls to
__spslr_offsetof with inline assembly placeholders. These placeholders
specify the return location of the replaced calls as the output operand
of the corresponding asm statements. Additionally, the instruction pin
id is attached as a constant input operand. At this point, the asm
template string does not yet contain any actual instructions. By
replacing calls with asm, Pinpoint prevents GCC from adhering to call
ABIs or backing up registers unnecessarily.

Immediately before "final", the rtl_ipin_survival_scan pass iterates
over all RTL looking for the asm placeholders. Each encountered one's
asm template is replaced with actual instruction pin code:

    movq $fieldlabel(offset, .Lspslr_ipin_<id>, .Lspslr_ipin_width_<id>), %0

The instruction pins utilize the fieldlabel feature introduced with the
GAS patch. It makes GAS emit the .Lspslr_ipin_<id> label at the bytes
that actually encode the offset immediate value. Additionally,
.Lspslr_ipin_width_<id> is defined to be the size of the immediate
field. The rtl_ipin_survival_scan pass generates unique ids for each
instruction pin, even if GCC duplicated the asm placeholders earlier.

Note that the current instruction pins are specific to x86_64, like the
GAS patch.

In the end, when compilation for a unit finishes, Pinpoint emits
metadata directly into the output asm stream. The per-ipin metadata
links directly against the fieldlabel symbols to specify exact
patch-site locations.

To support the Sanemaker validation framework's trap library, the
spslr_target_hash pass supports builtin calls to
__spslr_target_hash(const void *). It infers the type of its pointer
argument and returns a pointer to the 16 byte MD5 digest of that type
(as calculated in layout_hash.c). This hash is the stable identity of
each randomized type across Pinpoint, Selfpatch and Sanemaker.

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 scripts/Makefile.gcc-plugins                  |   9 +
 scripts/gcc-plugins/Makefile                  |  18 +
 scripts/gcc-plugins/asm_offset_pass.c         |  79 +++
 scripts/gcc-plugins/dpin_registry.c           | 199 +++++++
 scripts/gcc-plugins/dpin_registry.h           |  22 +
 scripts/gcc-plugins/ipin_registry.c           | 367 +++++++++++++
 scripts/gcc-plugins/ipin_registry.h           |  57 ++
 scripts/gcc-plugins/layout_hash.c             |  61 +++
 scripts/gcc-plugins/layout_hash.h             |   8 +
 scripts/gcc-plugins/on_finish_decl.c          |   8 +
 scripts/gcc-plugins/on_finish_type.c          |  12 +
 scripts/gcc-plugins/on_finish_unit.c          | 336 ++++++++++++
 .../gcc-plugins/on_preserve_component_ref.c   |  99 ++++
 scripts/gcc-plugins/on_register_attributes.c  |  52 ++
 scripts/gcc-plugins/on_start_unit.c           |  11 +
 scripts/gcc-plugins/passes.h                  |  31 ++
 scripts/gcc-plugins/pinpoint.c                | 103 ++++
 scripts/gcc-plugins/pinpoint.h                |  75 +++
 .../gcc-plugins/rtl_ipin_survival_scan_pass.c |  37 ++
 scripts/gcc-plugins/safe-attribs.h            |   9 +
 scripts/gcc-plugins/safe-diagnostic.h         |  10 +
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
 scripts/gcc-plugins/separate_offset_pass.c    | 327 ++++++++++++
 scripts/gcc-plugins/serialize.c               | 303 +++++++++++
 scripts/gcc-plugins/serialize.h               | 115 ++++
 .../gcc-plugins/target_hash_builtin_pass.c    | 167 ++++++
 scripts/gcc-plugins/target_registry.c         | 492 ++++++++++++++++++
 scripts/gcc-plugins/target_registry.h         |  59 +++
 37 files changed, 3162 insertions(+)
 create mode 100644 scripts/gcc-plugins/asm_offset_pass.c
 create mode 100644 scripts/gcc-plugins/dpin_registry.c
 create mode 100644 scripts/gcc-plugins/dpin_registry.h
 create mode 100644 scripts/gcc-plugins/ipin_registry.c
 create mode 100644 scripts/gcc-plugins/ipin_registry.h
 create mode 100644 scripts/gcc-plugins/layout_hash.c
 create mode 100644 scripts/gcc-plugins/layout_hash.h
 create mode 100644 scripts/gcc-plugins/on_finish_decl.c
 create mode 100644 scripts/gcc-plugins/on_finish_type.c
 create mode 100644 scripts/gcc-plugins/on_finish_unit.c
 create mode 100644 scripts/gcc-plugins/on_preserve_component_ref.c
 create mode 100644 scripts/gcc-plugins/on_register_attributes.c
 create mode 100644 scripts/gcc-plugins/on_start_unit.c
 create mode 100644 scripts/gcc-plugins/passes.h
 create mode 100644 scripts/gcc-plugins/pinpoint.c
 create mode 100644 scripts/gcc-plugins/pinpoint.h
 create mode 100644 scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c
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
 create mode 100644 scripts/gcc-plugins/separate_offset_pass.c
 create mode 100644 scripts/gcc-plugins/serialize.c
 create mode 100644 scripts/gcc-plugins/serialize.h
 create mode 100644 scripts/gcc-plugins/target_hash_builtin_pass.c
 create mode 100644 scripts/gcc-plugins/target_registry.c
 create mode 100644 scripts/gcc-plugins/target_registry.h

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b0e1423b09c2..2ae9d571d812 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -8,6 +8,15 @@ ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 endif
 export DISABLE_LATENT_ENTROPY_PLUGIN
 
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
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -DGCC_PLUGINS
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 05b14aba41ef..1ecc9e923b85 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -22,6 +22,24 @@ targets += randomize_layout_seed.h
 #
 # foo-objs := foo.o foo2.o
 
+pinpoint_plugin-objs := \
+	pinpoint.o \
+	asm_offset_pass.o \
+	dpin_registry.o \
+	ipin_registry.o \
+	layout_hash.o \
+	on_finish_decl.o \
+	on_finish_type.o \
+	on_finish_unit.o \
+	on_preserve_component_ref.o \
+	on_register_attributes.o \
+	on_start_unit.o \
+	rtl_ipin_survival_scan_pass.o \
+	separate_offset_pass.o \
+	serialize.o \
+	target_registry.o \
+	target_hash_builtin_pass.o
+
 always-y += $(GCC_PLUGIN)
 
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
diff --git a/scripts/gcc-plugins/asm_offset_pass.c b/scripts/gcc-plugins/asm_offset_pass.c
new file mode 100644
index 000000000000..5a1be25f1f2c
--- /dev/null
+++ b/scripts/gcc-plugins/asm_offset_pass.c
@@ -0,0 +1,79 @@
+#include <unordered_map>
+
+#include <pinpoint.h>
+#include <passes.h>
+#include <ipin_registry.h>
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
+	ipin::handle pin = ipin::identify_gimple_separator(stmt);
+	if (pin == ipin::invalid)
+		return;
+
+	gimple *replacement = ipin::make_gimple_pin(gimple_call_lhs(stmt), pin);
+	if (!replacement)
+		pinpoint_fatal("failed to construct ipin");
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
diff --git a/scripts/gcc-plugins/dpin_registry.c b/scripts/gcc-plugins/dpin_registry.c
new file mode 100644
index 000000000000..415f7befe296
--- /dev/null
+++ b/scripts/gcc-plugins/dpin_registry.c
@@ -0,0 +1,199 @@
+#include <string>
+#include <unordered_set>
+
+#include <pinpoint.h>
+#include <dpin_registry.h>
+#include <target_registry.h>
+
+static std::list<dpin> pins;
+static std::unordered_set<std::string> seen_dpin_symbols;
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	for (const dpin &pin : pins)
+		for (const dpin::component &c : pin.components)
+			PINPOINT_GC_MARK_TREE(c.target);
+}
+
+void dpin::reset()
+{
+	pins.clear();
+	seen_dpin_symbols.clear();
+}
+
+const std::list<dpin> &dpin::inspect()
+{
+	return pins;
+}
+
+static std::list<dpin::component> compile_datapin_components(tree type);
+static std::list<dpin::component> compile_datapin_record_components(tree type);
+static std::list<dpin::component> compile_datapin_array_components(tree type);
+
+/*
+ * Build the list of randomized objects contained in a static object.
+ *
+ * A dpin may describe the object itself, nested target structs, arrays of
+ * targets, or targets embedded inside non-target containers. The level field
+ * records nesting depth so the runtime can patch inner objects before
+ * their containing objects.
+ */
+
+static std::list<dpin::component> compile_datapin_components(tree type)
+{
+	std::list<dpin::component> components;
+
+	tree relevant = target::main_variant(type);
+	if (target::is_target(relevant)) {
+		components.push_back(dpin::component{
+			.offset = 0,
+			.level = 0,
+			.target = relevant,
+		});
+	}
+
+	std::list<dpin::component> sub_components;
+	if (TREE_CODE(type) == RECORD_TYPE)
+		sub_components = compile_datapin_record_components(type);
+	else if (TREE_CODE(type) == ARRAY_TYPE)
+		sub_components = compile_datapin_array_components(type);
+
+	for (const dpin::component &sc : sub_components) {
+		components.push_back(dpin::component{
+			.offset = sc.offset,
+			.level = sc.level + 1,
+			.target = sc.target,
+		});
+	}
+
+	// Note -> should probably make sure that randomized structs are never used in unions!
+	return components;
+}
+
+static std::list<dpin::component> compile_datapin_record_components(tree type)
+{
+	std::list<dpin::component> components;
+
+	if (TREE_CODE(type) != RECORD_TYPE || !COMPLETE_TYPE_P(type))
+		return components;
+
+	for (tree field = TYPE_FIELDS(type); field; field = TREE_CHAIN(field)) {
+		if (TREE_CODE(field) != FIELD_DECL)
+			continue;
+
+		if (!target::field_has_size(field))
+			continue; // flexible array member / dynamic-size trailing array
+
+		if (target::field_is_bitfield(field))
+			continue;
+
+		std::size_t field_offset = target::field_offset(field);
+		tree field_type = TREE_TYPE(field);
+
+		std::list<dpin::component> field_components =
+			compile_datapin_components(field_type);
+
+		for (const dpin::component &fc : field_components) {
+			components.push_back(dpin::component{
+				.offset = field_offset + fc.offset,
+				.level = fc.level,
+				.target = fc.target,
+			});
+		}
+	}
+
+	return components;
+}
+
+static std::list<dpin::component> compile_datapin_array_components(tree type)
+{
+	std::list<dpin::component> components;
+
+	if (TREE_CODE(type) != ARRAY_TYPE)
+		return components;
+
+	tree elem_type = TREE_TYPE(type);
+	if (!elem_type)
+		return components;
+
+	std::list<dpin::component> elem_components =
+		compile_datapin_components(elem_type);
+	if (elem_components.empty())
+		return components;
+
+	tree domain = TYPE_DOMAIN(type);
+	if (!domain)
+		pinpoint_fatal("dpin: failed to get array domain");
+
+	tree min_t = TYPE_MIN_VALUE(domain);
+	tree max_t = TYPE_MAX_VALUE(domain);
+	if (!min_t || !max_t || TREE_CODE(min_t) != INTEGER_CST ||
+	    TREE_CODE(max_t) != INTEGER_CST)
+		pinpoint_fatal("dpin: failed to get constant array bounds");
+
+	HOST_WIDE_INT min_i = tree_to_shwi(min_t);
+	HOST_WIDE_INT max_i = tree_to_shwi(max_t);
+
+	tree elem_size_t = TYPE_SIZE_UNIT(elem_type);
+	if (!elem_size_t || TREE_CODE(elem_size_t) != INTEGER_CST)
+		pinpoint_fatal("dpin: failed to get constant element size");
+
+	std::size_t elem_size = tree_to_uhwi(elem_size_t);
+
+	for (HOST_WIDE_INT i = min_i; i <= max_i; ++i) {
+		std::size_t element_offset =
+			static_cast<std::size_t>(i - min_i) * elem_size;
+
+		for (const dpin::component &ec : elem_components) {
+			components.push_back(dpin::component{
+				.offset = element_offset + ec.offset,
+				.level = ec.level,
+				.target = ec.target,
+			});
+		}
+	}
+
+	return components;
+}
+
+static bool compile_datapin(tree type, dpin &pin)
+{
+	pin.components = compile_datapin_components(type);
+	return !pin.components.empty();
+}
+
+void dpin::consider_static_var(tree var)
+{
+	if (!var || TREE_CODE(var) != VAR_DECL)
+		return;
+
+	if (!TREE_STATIC(var) || DECL_EXTERNAL(var))
+		return;
+
+	tree type = TREE_TYPE(var);
+	if (!type)
+		return;
+
+	tree symbol_tree = DECL_ASSEMBLER_NAME(var);
+	const char *symbol = symbol_tree ? IDENTIFIER_POINTER(symbol_tree) :
+					   nullptr;
+	if (!symbol)
+		pinpoint_fatal("dpin: failed to get static variable symbol");
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
+	dpin pin;
+	if (!compile_datapin(type, pin))
+		return;
+
+	DECL_PRESERVE_P(var) = 1;
+	pin.symbol = sym;
+	pins.emplace_back(std::move(pin));
+}
diff --git a/scripts/gcc-plugins/dpin_registry.h b/scripts/gcc-plugins/dpin_registry.h
new file mode 100644
index 000000000000..500535ce0bf2
--- /dev/null
+++ b/scripts/gcc-plugins/dpin_registry.h
@@ -0,0 +1,22 @@
+#pragma once
+
+#include <cstddef>
+#include <list>
+#include <string>
+
+#include <safe-tree.h>
+
+struct dpin {
+	struct component {
+		std::size_t offset = 0;
+		std::size_t level = 0;
+		tree target = NULL_TREE;
+	};
+
+	std::string symbol;
+	std::list<component> components;
+
+	static void consider_static_var(tree var);
+	static void reset();
+	static const std::list<dpin> &inspect();
+};
diff --git a/scripts/gcc-plugins/ipin_registry.c b/scripts/gcc-plugins/ipin_registry.c
new file mode 100644
index 000000000000..41e2d525a08f
--- /dev/null
+++ b/scripts/gcc-plugins/ipin_registry.c
@@ -0,0 +1,367 @@
+#include <cstring>
+#include <algorithm>
+
+#include <pinpoint.h>
+#include <ipin_registry.h>
+#include <target_registry.h>
+
+#define PINPOINT_SEPARATOR "__spslr_offsetof"
+#define PINPOINT_IPIN_MARKER "spslr_ipin_marker"
+#define PINPOINT_IPIN_SYMBOL_PREFIX "spslr_ipin_" /* suffixed with "<uid>" */
+#define PINPOINT_IPIN_WIDTH_SYMBOL_PREFIX \
+	"spslr_ipin_width_" /* suffixed with "<uid>" */
+
+static ipin::handle next_ipin_handle = 0;
+static std::map<ipin::handle, ipin> ipins;
+
+static tree separator_decl = NULL_TREE;
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	PINPOINT_GC_MARK_TREE(separator_decl);
+
+	for (const auto &[h, pin] : ipins)
+		PINPOINT_GC_MARK_TREE(pin.field);
+}
+
+/*
+ * Separators are compiler-internal marker calls, not runtime calls.
+ *
+ * They carry a unique ID with which metadata is associated. The call is
+ * declared pure/no-vops so GCC treats it as having no memory side effects; a
+ * later pinpoint pass must remove every separator before code generation.
+ */
+
+static tree make_separator_decl()
+{
+	if (separator_decl)
+		return separator_decl;
+
+	tree args = tree_cons(NULL_TREE, sizetype, NULL_TREE);
+	tree type = build_function_type(sizetype, args);
+
+	tree tmp_decl = build_fn_decl(PINPOINT_SEPARATOR, type);
+	if (!tmp_decl)
+		return NULL_TREE;
+
+	DECL_EXTERNAL(tmp_decl) = 1;
+	TREE_PUBLIC(tmp_decl) = 1;
+	DECL_ARTIFICIAL(tmp_decl) = 1;
+
+	/* Prevent VOP problems later when removing calls (VOPs mark memory
+       side-effects, which these calls have none of anyways) */
+	DECL_PURE_P(tmp_decl) = 1;
+	DECL_IS_NOVOPS(tmp_decl) = 1;
+
+	return (separator_decl = tmp_decl);
+}
+
+static ipin *get_pin(ipin::handle pin)
+{
+	auto it = ipins.find(pin);
+	return it == ipins.end() ? nullptr : &it->second;
+}
+
+ipin::handle ipin::make(tree field)
+{
+	handle h = next_ipin_handle++;
+
+	ipin pin;
+	pin.status = state::pending;
+	pin.field = field;
+
+	ipins.emplace(h, std::move(pin));
+	return h;
+}
+
+tree ipin::make_ast_separator(ipin::handle pin)
+{
+	ipin *p = get_pin(pin);
+	if (!p)
+		pinpoint_fatal("ipin: inknown pin in make_ast_separator");
+
+	tree decl = make_separator_decl();
+	if (!decl)
+		return NULL_TREE;
+
+	tree arg0 = size_int(pin);
+	if (!arg0)
+		return NULL_TREE;
+
+	p->status = state::separator;
+	return build_call_expr(decl, 1, arg0);
+}
+
+gimple *ipin::make_gimple_separator(tree lhs, ipin::handle pin)
+{
+	if (!lhs)
+		return nullptr;
+
+	ipin *p = get_pin(pin);
+	if (!p)
+		pinpoint_fatal("ipin: unknown pin in make_gimple_separator");
+
+	tree decl = make_separator_decl();
+	if (!decl)
+		return nullptr;
+
+	tree arg0 = size_int(pin);
+	if (!arg0)
+		return nullptr;
+
+	gimple *call = gimple_build_call(decl, 1, arg0);
+	if (!call)
+		return nullptr;
+
+	gimple_call_set_lhs(call, lhs);
+	p->status = state::separator;
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
+	return strcmp(name, PINPOINT_SEPARATOR) == 0;
+}
+
+ipin::handle ipin::identify_gimple_separator(gimple *stmt)
+{
+	if (!stmt || !is_gimple_call(stmt))
+		return invalid;
+
+	tree fndecl = gimple_call_fndecl(stmt);
+	if (!decl_is_separator(fndecl))
+		return invalid;
+
+	tree arg0 = gimple_call_arg(stmt, 0);
+	if (!arg0 || TREE_CODE(arg0) != INTEGER_CST)
+		pinpoint_fatal("ipin: separator has invalid ipin handle");
+
+	return static_cast<handle>(tree_to_uhwi(arg0));
+}
+
+static bool lhs_type_is_64bit(tree lhs)
+{
+	if (!lhs)
+		return false;
+
+	tree type = TREE_TYPE(lhs);
+	if (!type)
+		return false;
+
+	tree size = TYPE_SIZE(type);
+	if (!size || TREE_CODE(size) != INTEGER_CST)
+		return false;
+
+	return tree_to_uhwi(size) == 64;
+}
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
+/*
+ * The symbol does not denote executable code as a callable function; it denotes
+ * the four-byte immediate field inside the instruction stream.
+ */
+static std::string make_final_x86_64_asm(const std::string &field_symbol,
+					 const std::string &width_symbol,
+					 std::size_t imm)
+{
+	char buf[512];
+
+	std::snprintf(buf, sizeof(buf),
+		      "# %s\n"
+		      " movq $fieldlabel(%zu, %s, %s), %%0",
+		      PINPOINT_IPIN_MARKER, imm, field_symbol.c_str(),
+		      width_symbol.c_str());
+
+	return std::string(buf);
+}
+
+gimple *ipin::make_gimple_pin(tree lhs, ipin::handle pin)
+{
+	if (!lhs)
+		return nullptr;
+
+	ipin *p = get_pin(pin);
+	if (!p)
+		pinpoint_fatal("ipin: unknown pin in make_gimple_pin");
+
+	if (!lhs_type_is_64bit(lhs))
+		pinpoint_fatal("ipin: expected 64-bit destination type");
+
+	/*
+	 * Do not emit the final label here. GCC may duplicate this asm later.
+	 * The original pin id is carried only as an input operand.
+	 */
+	std::string asm_str = "# " PINPOINT_IPIN_MARKER;
+
+	tree arg0 = build_int_cst(size_type_node, pin);
+
+	vec<tree, va_gc> *outputs = NULL;
+	vec<tree, va_gc> *inputs = NULL;
+
+	vec_safe_push(outputs, make_asm_operand("=r", lhs));
+	vec_safe_push(inputs, make_asm_operand("i", arg0));
+
+	gasm *new_gasm = gimple_build_asm_vec(ggc_strdup(asm_str.c_str()),
+					      inputs, outputs, NULL, NULL);
+	if (!new_gasm)
+		return nullptr;
+
+	/*
+	 * Non-volatile is intentional: unused field-offset computations should die
+	 * normally. Only offsets that survive optimization become instruction pins.
+	 */
+	gimple_asm_set_volatile(new_gasm, false);
+
+	p->status = state::pin;
+	return new_gasm;
+}
+
+static bool extract_asm_operands(rtx x, rtx &asm_out)
+{
+	if (!x)
+		return false;
+
+	if (GET_CODE(x) == ASM_OPERANDS) {
+		asm_out = x;
+		return true;
+	}
+
+	if (GET_CODE(x) == SET)
+		return extract_asm_operands(SET_SRC(x), asm_out);
+
+	if (GET_CODE(x) == PARALLEL) {
+		for (int i = 0; i < XVECLEN(x, 0); ++i) {
+			if (extract_asm_operands(XVECEXP(x, 0, i), asm_out))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+ipin::handle ipin::identify_rtl_pin(rtx x)
+{
+	rtx asm_rtx = nullptr;
+	if (!extract_asm_operands(x, asm_rtx))
+		return invalid;
+
+	if (!asm_rtx || GET_CODE(asm_rtx) != ASM_OPERANDS)
+		return invalid;
+
+	const char *templ = ASM_OPERANDS_TEMPLATE(asm_rtx);
+	if (!templ || !std::strstr(templ, PINPOINT_IPIN_MARKER))
+		return invalid;
+
+	if (ASM_OPERANDS_INPUT_LENGTH(asm_rtx) != 1)
+		pinpoint_fatal(
+			"ipin: RTL pin asm has invalid number of inputs");
+
+	rtx in0 = ASM_OPERANDS_INPUT(asm_rtx, 0);
+	if (!CONST_INT_P(in0))
+		pinpoint_fatal("ipin: RTL ipin id is not CONST_INT");
+
+	return static_cast<handle>(INTVAL(in0));
+}
+
+void ipin::mark_live(ipin::handle pin, rtx at)
+{
+	ipin::handle found = identify_rtl_pin(at);
+
+	if (found != pin) {
+		pinpoint_fatal(
+			"ipin: mark_live called with mismatching RTL pin");
+	}
+
+	rtx asm_rtx = nullptr;
+
+	if (!extract_asm_operands(at, asm_rtx) || !asm_rtx ||
+	    GET_CODE(asm_rtx) != ASM_OPERANDS) {
+		pinpoint_fatal(
+			"ipin: mark_live could not recover ASM_OPERANDS");
+	}
+
+	ipin *p = get_pin(pin);
+	if (!p) {
+		pinpoint_fatal("ipin: tried to mark unknown pin live");
+	}
+
+	ipin::handle live_handle = pin;
+	ipin *live_pin = p;
+
+	if (p->status == state::live) {
+		live_handle = next_ipin_handle++;
+
+		ipin clone = *p;
+		clone.status = state::pin;
+		clone.symbol.clear();
+		clone.width_symbol.clear();
+
+		auto inserted = ipins.emplace(live_handle, std::move(clone));
+		live_pin = &inserted.first->second;
+	}
+
+	live_pin->status = state::live;
+
+	const std::string handle_suffix = std::to_string(live_handle);
+
+	live_pin->symbol =
+		".L" + std::string(PINPOINT_IPIN_SYMBOL_PREFIX) + handle_suffix;
+
+	live_pin->width_symbol =
+		".L" + std::string(PINPOINT_IPIN_WIDTH_SYMBOL_PREFIX) +
+		handle_suffix;
+
+	std::size_t offset = target::field_offset(live_pin->field);
+
+	std::string final_asm = make_final_x86_64_asm(
+		live_pin->symbol, live_pin->width_symbol, offset);
+
+	XSTR(asm_rtx, 0) = ggc_strdup(final_asm.c_str());
+}
+
+std::size_t ipin::live_count()
+{
+	std::size_t n = 0;
+
+	for (const auto &[h, pin] : ipins) {
+		if (pin.status == state::live)
+			++n;
+	}
+
+	return n;
+}
+
+const std::map<ipin::handle, ipin> &ipin::inspect()
+{
+	return ipins;
+}
+
+const ipin *ipin::inspect(ipin::handle pin)
+{
+	return get_pin(pin);
+}
+
+void ipin::reset()
+{
+	ipins.clear();
+	next_ipin_handle = 0;
+}
diff --git a/scripts/gcc-plugins/ipin_registry.h b/scripts/gcc-plugins/ipin_registry.h
new file mode 100644
index 000000000000..0fff090ed6e7
--- /dev/null
+++ b/scripts/gcc-plugins/ipin_registry.h
@@ -0,0 +1,57 @@
+#pragma once
+#include <cstddef>
+#include <string>
+#include <limits>
+#include <map>
+
+#include <safe-tree.h>
+#include <safe-gimple.h>
+#include <safe-rtl.h>
+
+struct ipin {
+	enum class state { pending, separator, pin, live };
+
+	state status = state::pending;
+
+	/* Field that the ipin refers to */
+	tree field = NULL_TREE;
+
+	/*
+	 * The field-address and field-width symbols are available once the pin is
+	 * marked live and its final inline assembly has been constructed.
+	 */
+	std::string symbol;
+	std::string width_symbol;
+
+	using handle = std::size_t;
+	static constexpr handle invalid = std::numeric_limits<handle>::max();
+
+	/* Register new ipin to track through compilation */
+	static handle make(tree field);
+
+	/* Construct an AST separator tree refering to an ipin */
+	static tree make_ast_separator(handle pin);
+
+	/* Construct a GIMPLE separator statement refering to an ipin */
+	static gimple *make_gimple_separator(tree lhs, handle pin);
+
+	/* Check if a GIMPLE statement is a separator refering to an ipin */
+	static handle identify_gimple_separator(gimple *stmt);
+
+	/* Construct a GIMPLE ipin - currently as ASM statement */
+	static gimple *make_gimple_pin(tree lhs, handle pin);
+
+	/* Check if an RTL instruction is an ipin */
+	static handle identify_rtl_pin(rtx x);
+
+	/* Mark an ipin as being present in the final asm */
+	static void mark_live(handle pin, rtx at);
+	static std::size_t live_count();
+
+	/* Inspect the state of one or more ipins */
+	static const std::map<handle, ipin> &inspect();
+	static const ipin *inspect(handle pin);
+
+	/* Reset ipin registry */
+	static void reset();
+};
diff --git a/scripts/gcc-plugins/layout_hash.c b/scripts/gcc-plugins/layout_hash.c
new file mode 100644
index 000000000000..6200bd037f54
--- /dev/null
+++ b/scripts/gcc-plugins/layout_hash.c
@@ -0,0 +1,61 @@
+#include <cstdint>
+#include <cstring>
+#include <string>
+
+#include <layout_hash.h>
+#include <target_registry.h>
+
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
+}
+
+std::array<std::byte, 16> compute_layout_hash(tree target_type)
+{
+	std::string buf;
+
+	append_string(buf, "spslr-layout-hash-v2");
+
+	for (const std::string &ctx : target::context_chain(target_type))
+		append_string(buf, ctx);
+
+	append_string(buf, target::name(target_type));
+	append_size(buf, target::size(target_type));
+
+	for (const target::compressed_field &field :
+	     target::compressed_fields(target_type)) {
+		append_string(buf, field.name);
+		append_size(buf, field.size);
+		append_size(buf, field.offset);
+		append_size(buf, field.alignment);
+		append_size(buf, field.fixed ? 1 : 0);
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
diff --git a/scripts/gcc-plugins/layout_hash.h b/scripts/gcc-plugins/layout_hash.h
new file mode 100644
index 000000000000..b4b660bd0b96
--- /dev/null
+++ b/scripts/gcc-plugins/layout_hash.h
@@ -0,0 +1,8 @@
+#pragma once
+
+#include <array>
+#include <cstddef>
+
+#include <safe-tree.h>
+
+std::array<std::byte, 16> compute_layout_hash(tree target_type);
diff --git a/scripts/gcc-plugins/on_finish_decl.c b/scripts/gcc-plugins/on_finish_decl.c
new file mode 100644
index 000000000000..6781d2516e75
--- /dev/null
+++ b/scripts/gcc-plugins/on_finish_decl.c
@@ -0,0 +1,8 @@
+#include <passes.h>
+#include <dpin_registry.h>
+
+void on_finish_decl(void *plugin_data, void *user_data)
+{
+	tree decl = (tree)plugin_data;
+	dpin::consider_static_var(decl);
+}
diff --git a/scripts/gcc-plugins/on_finish_type.c b/scripts/gcc-plugins/on_finish_type.c
new file mode 100644
index 000000000000..023470f8cc8c
--- /dev/null
+++ b/scripts/gcc-plugins/on_finish_type.c
@@ -0,0 +1,12 @@
+#include <passes.h>
+#include <target_registry.h>
+
+void on_finish_type(void *plugin_data, void *user_data)
+{
+	tree t = target::main_variant((tree)plugin_data);
+
+	if (!target::is_target(t))
+		return;
+
+	target::validate(t);
+}
diff --git a/scripts/gcc-plugins/on_finish_unit.c b/scripts/gcc-plugins/on_finish_unit.c
new file mode 100644
index 000000000000..5229dbb53c52
--- /dev/null
+++ b/scripts/gcc-plugins/on_finish_unit.c
@@ -0,0 +1,336 @@
+#include <string>
+#include <filesystem>
+#include <vector>
+#include <algorithm>
+#include <unordered_map>
+
+#include <pinpoint.h>
+#include <passes.h>
+#include <ipin_registry.h>
+#include <dpin_registry.h>
+#include <serialize.h>
+#include <target_registry.h>
+#include <safe-input.h>
+#include <safe-output.h>
+
+/*
+ * Finish-unit emits the per-compilation-unit metadata into the object asm.
+ *
+ * Only information that survived all earlier filtering should be dumped here:
+ * target layouts, data pins for static objects, and live instruction pins
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
+	tree target;
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
+static std::vector<emitted_target> collect_all_targets()
+{
+	std::vector<emitted_target> out;
+	out.reserve(target::target_count());
+
+	target::iterate_targets([&](tree t) {
+		out.push_back({
+			.target = t,
+			.hash = to_hash16(target::layout_hash(t)),
+			.unit_target_idx = out.size(),
+		});
+	});
+
+	return out;
+}
+
+static std::unordered_map<tree, std::size_t>
+make_unit_target_idx_map(const std::vector<emitted_target> &targets)
+{
+	std::unordered_map<tree, std::size_t> out;
+
+	for (const emitted_target &target : targets)
+		out[target.target] = target.unit_target_idx;
+
+	return out;
+}
+
+static std::vector<emitted_dpin>
+collect_dpins(const std::unordered_map<tree, std::size_t> &target_idx)
+{
+	std::vector<emitted_dpin> out;
+
+	for (const dpin &pin : dpin::inspect()) {
+		if (pin.symbol.empty())
+			pinpoint_fatal(
+				"finish-unit: data pin has empty symbol");
+
+		std::vector<dpin::component> components(pin.components.begin(),
+							pin.components.end());
+
+		/*
+		 * Data pins with deeper nesting level must be patched first.
+		 */
+		std::sort(components.begin(), components.end(),
+			  [](const dpin::component &a,
+			     const dpin::component &b) {
+				  return a.level > b.level;
+			  });
+
+		for (const dpin::component &c : components) {
+			const auto target_it = target_idx.find(c.target);
+
+			if (target_it == target_idx.end())
+				pinpoint_fatal(
+					"finish-unit: dpin target not in unit target map");
+
+			out.push_back({
+				.addr_expr =
+					add_offset_expr(pin.symbol, c.offset),
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
+		const std::string target_sym =
+			selfpatch::target_symbol(ut.hash);
+		const std::string hash_sym =
+			selfpatch::target_hash_symbol(ut.hash);
+		const std::string layout_sym =
+			selfpatch::target_layout_symbol(ut.hash);
+		const std::string fields_sym =
+			selfpatch::make_local_label("target_fields");
+
+		const std::string target_name = selfpatch::emit_strtab_entry(
+			out, target::qualified_name(ut.target));
+
+		selfpatch::emit_targets_section(out, ut.hash);
+		selfpatch::emit_hidden_global_label(out, target_sym);
+
+		/* This can only be done here, because the hash is the first
+		 * component of the target metadata. */
+		selfpatch::emit_hidden_global_label(out, hash_sym);
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
+		const std::vector<target::compressed_field> &fields =
+			target::compressed_fields(ut.target);
+
+		selfpatch::target_layout_desc layout_desc{
+			.size = target::size(ut.target),
+			.field_cnt = fields.size(),
+			.fields_symbol = fields_sym,
+		};
+
+		selfpatch::emit_target_layout(out, layout_desc);
+
+		selfpatch::emit_label(out, fields_sym);
+
+		for (const target::compressed_field &field : fields) {
+			const std::string field_name =
+				selfpatch::emit_strtab_entry(out, field.name);
+
+			std::size_t field_flags = field.fixed ? 1 : 0;
+
+			selfpatch::target_field_desc field_desc{
+				.name_label = field_name,
+				.size = field.size,
+				.offset = field.offset,
+				.alignment = field.alignment,
+				.flags = field_flags,
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
+		       const std::unordered_map<tree, std::size_t> &target_idx,
+		       const std::string &ipins_sym)
+{
+	std::map<ipin::handle, std::string> expr_syms;
+
+	selfpatch::emit_ipins_section(out);
+	selfpatch::emit_label(out, ipins_sym);
+
+	for (const auto &[h, pin] : ipin::inspect()) {
+		if (pin.status != ipin::state::live)
+			continue;
+
+		if (pin.symbol.empty() || pin.width_symbol.empty())
+			pinpoint_fatal(
+				"finish-unit: live ipin is missing field symbols");
+
+		std::string expr_sym = selfpatch::make_local_label("ipin_expr");
+		expr_syms.emplace(h, expr_sym);
+
+		selfpatch::ipin_desc desc{
+			.addr_expr = pin.symbol,
+			.size_expr = pin.width_symbol,
+			.expr_symbol = expr_sym,
+		};
+
+		selfpatch::emit_ipin(out, desc);
+	}
+
+	for (const auto &[h, pin] : ipin::inspect()) {
+		if (pin.status != ipin::state::live)
+			continue;
+
+		tree pin_target = target::from_field(pin.field);
+		const auto target_it = target_idx.find(pin_target);
+
+		if (target_it == target_idx.end())
+			pinpoint_fatal(
+				"finish-unit: ipin target not in unit target map");
+
+		auto expr_sym_it = expr_syms.find(h);
+		if (expr_sym_it == expr_syms.end())
+			pinpoint_fatal("finish-unit: lost ipin expr symbol");
+
+		selfpatch::emit_label(out, expr_sym_it->second);
+
+		selfpatch::ipin_expr_desc expr{
+			.unit_target_idx = target_it->second,
+			.field = target::field_index(pin.field),
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
+		.ipin_cnt = ipin::live_count(),
+		.ipins_symbol = ipins_sym,
+		.dpin_cnt = dpins.size(),
+		.dpins_symbol = dpins_sym,
+	};
+
+	selfpatch::emit_unit(out, unit);
+	selfpatch::emit_pop_section(out);
+}
diff --git a/scripts/gcc-plugins/on_preserve_component_ref.c b/scripts/gcc-plugins/on_preserve_component_ref.c
new file mode 100644
index 000000000000..133269438914
--- /dev/null
+++ b/scripts/gcc-plugins/on_preserve_component_ref.c
@@ -0,0 +1,99 @@
+#include <pinpoint.h>
+#include <passes.h>
+#include <ipin_registry.h>
+#include <target_registry.h>
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
+ *     base.field  ->  *(typeof(field) *)((char *)&base + separator(uid))
+ *
+ * Later passes replace the separator with an instruction pin.
+ */
+
+static tree ast_separate_offset(tree ref, ipin::handle pin)
+{
+	tree separator = ipin::make_ast_separator(pin);
+	if (!separator)
+		pinpoint_fatal(
+			"ast_separate_offset failed to generate AST separator");
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
+	tree field;
+	if (!target::component_ref(*ref, &field))
+		return;
+
+	if (target::field_is_fixed(field))
+		return;
+
+	ipin::handle pin = ipin::make(field);
+	tree separated = ast_separate_offset(*ref, pin);
+	if (separated)
+		*ref = separated;
+}
diff --git a/scripts/gcc-plugins/on_register_attributes.c b/scripts/gcc-plugins/on_register_attributes.c
new file mode 100644
index 000000000000..221693a1c465
--- /dev/null
+++ b/scripts/gcc-plugins/on_register_attributes.c
@@ -0,0 +1,52 @@
+#include <pinpoint.h>
+#include <passes.h>
+
+static tree check_spslr_attribute(tree *node, tree name, tree args, int flags,
+				  bool *no_add_attrs)
+{
+	if (!node || !*node || TREE_CODE(*node) != RECORD_TYPE) {
+		*no_add_attrs = true;
+		pinpoint_debug(SPSLR_ATTRIBUTE
+			       " attribute only applies to record types");
+	}
+
+	return NULL_TREE;
+}
+
+static tree check_spslr_field_fixed_attribute(tree *node, tree name, tree args,
+					      int flags, bool *no_add_attrs)
+{
+	if (!node || !*node || TREE_CODE(*node) != FIELD_DECL) {
+		*no_add_attrs = true;
+		pinpoint_debug(SPSLR_FIELD_FIXED_ATTRIBUTE
+			       " attribute only applies to struct fields");
+	}
+	return NULL_TREE;
+}
+
+/*
+ * __attribute__((spslr)) marks a record type as a randomization target.
+ */
+
+static struct attribute_spec spslr_attribute = {
+	SPSLR_ATTRIBUTE,       0,   0, false, false, false, false,
+	check_spslr_attribute, NULL
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
+	SPSLR_FIELD_FIXED_ATTRIBUTE,	   0,	0, false, false, false, false,
+	check_spslr_field_fixed_attribute, NULL
+};
+
+void on_register_attributes(void *plugin_data, void *user_data)
+{
+	register_attribute(&spslr_attribute);
+	register_attribute(&spslr_fixed_field_attribute);
+}
diff --git a/scripts/gcc-plugins/on_start_unit.c b/scripts/gcc-plugins/on_start_unit.c
new file mode 100644
index 000000000000..dc8917209de7
--- /dev/null
+++ b/scripts/gcc-plugins/on_start_unit.c
@@ -0,0 +1,11 @@
+#include <passes.h>
+#include <ipin_registry.h>
+#include <dpin_registry.h>
+#include <target_registry.h>
+
+void on_start_unit(void *plugin_data, void *user_data)
+{
+	target::reset();
+	dpin::reset();
+	ipin::reset();
+}
diff --git a/scripts/gcc-plugins/passes.h b/scripts/gcc-plugins/passes.h
new file mode 100644
index 000000000000..f22949330e80
--- /dev/null
+++ b/scripts/gcc-plugins/passes.h
@@ -0,0 +1,31 @@
+#pragma once
+
+#include <safe-gimple.h>
+#include <safe-rtl.h>
+
+void on_register_attributes(void *plugin_data, void *user_data);
+void on_finish_type(void *plugin_data, void *user_data);
+void on_preserve_component_ref(void *plugin_data, void *user_data);
+void on_finish_decl(void *plugin_data, void *user_data);
+void on_start_unit(void *plugin_data, void *user_data);
+void on_finish_unit(void *plugin_data, void *user_data);
+
+struct separate_offset_pass : gimple_opt_pass {
+	separate_offset_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
+
+struct asm_offset_pass : gimple_opt_pass {
+	asm_offset_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
+
+struct rtl_ipin_survival_scan_pass : rtl_opt_pass {
+	rtl_ipin_survival_scan_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
+
+struct target_hash_builtin_pass : gimple_opt_pass {
+	target_hash_builtin_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
diff --git a/scripts/gcc-plugins/pinpoint.c b/scripts/gcc-plugins/pinpoint.c
new file mode 100644
index 000000000000..619487fdb53f
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint.c
@@ -0,0 +1,103 @@
+#include <filesystem>
+#include <string>
+
+#include <pinpoint.h>
+#include <passes.h>
+#include <safe-gcc-plugin.h>
+#include <safe-plugin-version.h>
+
+int plugin_is_GPL_compatible;
+
+bool pinpoint_verbose_enabled;
+
+void pinpoint_gc_preserve(void *, void *)
+{
+	for (pinpoint_gc_preserve_fn *p = PINPOINT_GC_SECTION_START;
+	     p != PINPOINT_GC_SECTION_END; ++p) {
+		if (*p)
+			(*p)();
+	}
+}
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
+		if (!strcmp(plugin_info->argv[i].key, "verbose"))
+			pinpoint_verbose_enabled = true;
+	}
+
+	/*
+	 * Pinpoint runs as a staged GCC plugin because no single GCC IR level has
+	 * all information SPSLR needs.
+	 *
+	 * Stage 0 runs while COMPONENT_REF trees are built or still available and records
+	 * which structure field offsets are randomization-sensitive.
+	 *
+	 * Stage 1 replaces synthetic separator calls with asm instructions whose immediate
+	 * operands are labeled for runtime patching.
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
+	struct register_pass_info target_hash_builtin_pass_info;
+	target_hash_builtin_pass_info.pass =
+		new target_hash_builtin_pass(nullptr);
+	target_hash_builtin_pass_info.ref_pass_instance_number = 1;
+	target_hash_builtin_pass_info.reference_pass_name = "cfg";
+	target_hash_builtin_pass_info.pos_op = PASS_POS_INSERT_AFTER;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &target_hash_builtin_pass_info);
+
+	struct register_pass_info separate_offset_pass_info;
+	separate_offset_pass_info.pass = new separate_offset_pass(nullptr);
+	separate_offset_pass_info.ref_pass_instance_number = 1;
+	separate_offset_pass_info.reference_pass_name = "spslr_target_hash";
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
+	struct register_pass_info rtl_ipin_survival_scan_pass_info;
+	rtl_ipin_survival_scan_pass_info.pass =
+		new rtl_ipin_survival_scan_pass(nullptr);
+	rtl_ipin_survival_scan_pass_info.ref_pass_instance_number = 1;
+	rtl_ipin_survival_scan_pass_info.reference_pass_name = "final";
+	rtl_ipin_survival_scan_pass_info.pos_op = PASS_POS_INSERT_BEFORE;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &rtl_ipin_survival_scan_pass_info);
+
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_UNIT,
+			  on_finish_unit, NULL);
+
+	return 0;
+}
diff --git a/scripts/gcc-plugins/pinpoint.h b/scripts/gcc-plugins/pinpoint.h
new file mode 100644
index 000000000000..7f88cda32f48
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint.h
@@ -0,0 +1,75 @@
+#pragma once
+#include <cstdio>
+#include <safe-diagnostic.h>
+#include <safe-ggc.h>
+
+#define SPSLR_ATTRIBUTE "spslr"
+#define SPSLR_FIELD_FIXED_ATTRIBUTE "spslr_field_fixed"
+#define SPSLR_TARGET_HASH_BUILTIN "__spslr_target_hash"
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
+#define PINPOINT_GC_MARK(p)          \
+	do {                         \
+		if (p)               \
+			ggc_mark(p); \
+	} while (0)
+
+extern "C" {
+extern pinpoint_gc_preserve_fn PINPOINT_GC_SECTION_START[];
+extern pinpoint_gc_preserve_fn PINPOINT_GC_SECTION_END[];
+}
+
+void pinpoint_gc_preserve(void *, void *);
diff --git a/scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c b/scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c
new file mode 100644
index 000000000000..a30f709f6fb6
--- /dev/null
+++ b/scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c
@@ -0,0 +1,37 @@
+#include <pinpoint.h>
+#include <passes.h>
+#include <ipin_registry.h>
+#include <safe-rtl.h>
+
+static const pass_data rtl_ipin_survival_scan_pass_data = {
+	RTL_PASS,
+	"spslr_rtl_ipin_survival_scan",
+	OPTGROUP_NONE,
+	TV_NONE,
+	PROP_rtl,
+	0,
+	0,
+	0,
+	0,
+};
+
+rtl_ipin_survival_scan_pass::rtl_ipin_survival_scan_pass(gcc::context *ctxt)
+	: rtl_opt_pass(rtl_ipin_survival_scan_pass_data, ctxt)
+{
+}
+
+unsigned int rtl_ipin_survival_scan_pass::execute(function *fn)
+{
+	(void)fn;
+
+	for (rtx_insn *insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
+		if (!NONDEBUG_INSN_P(insn))
+			continue;
+
+		ipin::handle pin = ipin::identify_rtl_pin(PATTERN(insn));
+		if (pin != ipin::invalid)
+			ipin::mark_live(pin, PATTERN(insn));
+	}
+
+	return 0;
+}
diff --git a/scripts/gcc-plugins/safe-attribs.h b/scripts/gcc-plugins/safe-attribs.h
new file mode 100644
index 000000000000..2d62fe75c72b
--- /dev/null
+++ b/scripts/gcc-plugins/safe-attribs.h
@@ -0,0 +1,9 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_ATTRIBS_H
+#define SAFEGCC_ATTRIBS_H
+
+#include <stringpool.h>
+#include <attribs.h>
+
+#endif
diff --git a/scripts/gcc-plugins/safe-diagnostic.h b/scripts/gcc-plugins/safe-diagnostic.h
new file mode 100644
index 000000000000..c58b739d88ed
--- /dev/null
+++ b/scripts/gcc-plugins/safe-diagnostic.h
@@ -0,0 +1,10 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_DIAGNOSTIC_H
+#define SAFEGCC_DIAGNOSTIC_H
+
+#include <c-family/c-common.h>
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
diff --git a/scripts/gcc-plugins/separate_offset_pass.c b/scripts/gcc-plugins/separate_offset_pass.c
new file mode 100644
index 000000000000..9598f1148896
--- /dev/null
+++ b/scripts/gcc-plugins/separate_offset_pass.c
@@ -0,0 +1,327 @@
+#include <functional>
+#include <list>
+
+#include <pinpoint.h>
+#include <passes.h>
+#include <ipin_registry.h>
+#include <target_registry.h>
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
+		tree field = NULL_TREE;
+		ipin::handle pin = ipin::invalid;
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
+		tree field;
+		step.relevant = target::component_ref(ref, &field) &&
+				!target::field_is_fixed(field);
+		if (step.relevant) {
+			step.field = field;
+			step.pin = ipin::make(field);
+			chain.relevant = true;
+		}
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
+				gimple *call_stmt = ipin::make_gimple_separator(
+					return_tmp, step.pin);
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
+				std::size_t field_offset =
+					target::field_offset(field_decl);
+				bool field_bitfield =
+					target::field_is_bitfield(field_decl);
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
+	for (std::size_t i = 0; i < gimple_num_ops(stmt); i++) {
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
diff --git a/scripts/gcc-plugins/serialize.c b/scripts/gcc-plugins/serialize.c
new file mode 100644
index 000000000000..d30e49464aea
--- /dev/null
+++ b/scripts/gcc-plugins/serialize.c
@@ -0,0 +1,303 @@
+#include "serialize.h"
+
+#include <cctype>
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
+	emit_quad_expr(out, ipin.size_expr);
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
+std::string target_hash_symbol(const hash16_t &hash)
+{
+	return "__spslr_target_hash_" + hash_hex(hash);
+}
+
+std::string target_layout_symbol(const hash16_t &hash)
+{
+	return "__spslr_target_layout_" + hash_hex(hash);
+}
+
+} // namespace selfpatch
diff --git a/scripts/gcc-plugins/serialize.h b/scripts/gcc-plugins/serialize.h
new file mode 100644
index 000000000000..7c358dd17645
--- /dev/null
+++ b/scripts/gcc-plugins/serialize.h
@@ -0,0 +1,115 @@
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
+	std::string size_expr;
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
+std::string target_hash_symbol(const hash16_t &hash);
+std::string target_layout_symbol(const hash16_t &hash);
+
+} // namespace selfpatch
diff --git a/scripts/gcc-plugins/target_hash_builtin_pass.c b/scripts/gcc-plugins/target_hash_builtin_pass.c
new file mode 100644
index 000000000000..d35b8df9abbc
--- /dev/null
+++ b/scripts/gcc-plugins/target_hash_builtin_pass.c
@@ -0,0 +1,167 @@
+#include <cstring>
+#include <map>
+#include <string>
+
+#include <pinpoint.h>
+#include <passes.h>
+#include <serialize.h>
+#include <target_registry.h>
+
+#include <safe-gimple.h>
+#include <safe-tree.h>
+
+namespace
+{
+
+static std::map<std::string, tree> hash_symbol_decls;
+
+static selfpatch::hash16_t to_hash16(const target::layout_hash_t &in)
+{
+	selfpatch::hash16_t out{};
+
+	for (std::size_t i = 0; i < out.size(); ++i)
+		out[i] = static_cast<std::uint8_t>(in[i]);
+
+	return out;
+}
+
+static bool called_decl_name_is(tree fndecl, const char *wanted)
+{
+	if (!fndecl || !DECL_NAME(fndecl))
+		return false;
+
+	const char *name = IDENTIFIER_POINTER(DECL_NAME(fndecl));
+	return name && std::strcmp(name, wanted) == 0;
+}
+
+static tree call_argument_pointee_type(gimple *stmt)
+{
+	if (!stmt || !is_gimple_call(stmt) || gimple_call_num_args(stmt) != 1)
+		return NULL_TREE;
+
+	tree arg = gimple_call_arg(stmt, 0);
+	if (!arg)
+		return NULL_TREE;
+
+	/* Case: &__spslr_target_hash_type_anchor_N */
+	if (TREE_CODE(arg) == ADDR_EXPR) {
+		tree obj = TREE_OPERAND(arg, 0);
+		if (obj) {
+			tree obj_type = TREE_TYPE(obj);
+			if (obj_type)
+				return target::main_variant(obj_type);
+		}
+	}
+
+	/* Fallback: argument still has pointer type T *. */
+	tree arg_type = TREE_TYPE(arg);
+	if (arg_type && POINTER_TYPE_P(arg_type))
+		return target::main_variant(TREE_TYPE(arg_type));
+
+	return NULL_TREE;
+}
+
+static tree make_hash_symbol_decl(const std::string &symbol)
+{
+	auto it = hash_symbol_decls.find(symbol);
+	if (it != hash_symbol_decls.end())
+		return it->second;
+
+	tree byte_type =
+		build_qualified_type(unsigned_char_type_node, TYPE_QUAL_CONST);
+	tree array_type = build_array_type_nelts(byte_type, 16);
+
+	tree decl = build_decl(UNKNOWN_LOCATION, VAR_DECL,
+			       get_identifier(symbol.c_str()), array_type);
+
+	DECL_EXTERNAL(decl) = 1;
+	TREE_PUBLIC(decl) = 1;
+	TREE_READONLY(decl) = 1;
+	DECL_ARTIFICIAL(decl) = 1;
+	DECL_IGNORED_P(decl) = 1;
+
+	hash_symbol_decls.emplace(symbol, decl);
+	return decl;
+}
+
+static tree make_hash_pointer_expr(tree target_type, tree result_type)
+{
+	const selfpatch::hash16_t hash =
+		to_hash16(target::layout_hash(target_type));
+
+	const std::string symbol = selfpatch::target_hash_symbol(hash);
+
+	tree decl = make_hash_symbol_decl(symbol);
+	tree addr = build_fold_addr_expr(decl);
+
+	return fold_convert(result_type, addr);
+}
+
+static tree make_null_pointer_expr(tree result_type)
+{
+	return fold_convert(result_type, null_pointer_node);
+}
+
+} // namespace
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	for (const auto &[symbol, decl] : hash_symbol_decls)
+		PINPOINT_GC_MARK_TREE(decl);
+}
+
+static const pass_data target_hash_builtin_pass_data = {
+	GIMPLE_PASS, "spslr_target_hash", OPTGROUP_NONE, TV_NONE, 0, 0, 0,
+	0,	     TODO_update_ssa
+};
+
+target_hash_builtin_pass::target_hash_builtin_pass(gcc::context *ctxt)
+	: gimple_opt_pass(target_hash_builtin_pass_data, ctxt)
+{
+}
+
+unsigned int target_hash_builtin_pass::execute(function *fn)
+{
+	if (!fn)
+		return 0;
+
+	basic_block bb;
+	FOR_EACH_BB_FN(bb, fn)
+	{
+		for (gimple_stmt_iterator gsi = gsi_start_bb(bb);
+		     !gsi_end_p(gsi);) {
+			gimple *stmt = gsi_stmt(gsi);
+
+			if (!is_gimple_call(stmt) ||
+			    !called_decl_name_is(gimple_call_fndecl(stmt),
+						 SPSLR_TARGET_HASH_BUILTIN)) {
+				gsi_next(&gsi);
+				continue;
+			}
+
+			tree lhs = gimple_call_lhs(stmt);
+			if (!lhs) {
+				gsi_remove(&gsi, true);
+				continue;
+			}
+
+			tree result_type = TREE_TYPE(lhs);
+			tree target_type = call_argument_pointee_type(stmt);
+
+			tree rhs = NULL_TREE;
+
+			if (target_type &&
+			    target::is_validated_target(target_type))
+				rhs = make_hash_pointer_expr(target_type,
+							     result_type);
+			else
+				rhs = make_null_pointer_expr(result_type);
+
+			gimple *replacement = gimple_build_assign(lhs, rhs);
+			gsi_replace(&gsi, replacement, true);
+			gsi_next(&gsi);
+		}
+	}
+
+	return 0;
+}
diff --git a/scripts/gcc-plugins/target_registry.c b/scripts/gcc-plugins/target_registry.c
new file mode 100644
index 000000000000..a692520467bd
--- /dev/null
+++ b/scripts/gcc-plugins/target_registry.c
@@ -0,0 +1,492 @@
+#include <algorithm>
+#include <map>
+#include <set>
+#include <vector>
+
+#include <pinpoint.h>
+#include <target_registry.h>
+#include <layout_hash.h>
+
+#include <safe-attribs.h>
+#include <safe-langhooks.h>
+
+struct validated_target {
+	std::vector<target::compressed_field> fields{};
+	std::map<tree, std::size_t> field_indices{};
+	target::layout_hash_t hash{};
+};
+
+static std::map<tree, validated_target> validated_targets;
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	for (const auto &[t, info] : validated_targets)
+		PINPOINT_GC_MARK_TREE(t);
+}
+
+using field_callback = std::function<void(tree field_decl)>;
+
+static void iterate_fields(tree type, const field_callback &cb)
+{
+	type = target::main_variant(type);
+
+	if (!type || !COMPLETE_TYPE_P(type))
+		pinpoint_fatal("target::iterate_fields: incomplete target");
+
+	for (tree f = TYPE_FIELDS(type); f; f = DECL_CHAIN(f)) {
+		if (TREE_CODE(f) == FIELD_DECL)
+			cb(f);
+	}
+}
+
+static void build_compressed_fields(tree type, validated_target &vt)
+{
+	vt.fields.clear();
+
+	std::size_t compressed_idx = 0;
+
+	iterate_fields(type, [&](tree field) {
+		std::string name = target::field_name(field);
+		std::size_t off = target::field_offset(field);
+		std::size_t sz = target::field_size(field);
+		std::size_t end = off + sz;
+		bool fixed = target::field_is_fixed(field);
+
+		if (vt.fields.empty()) {
+			vt.fields.push_back({
+				.name = name,
+				.offset = off,
+				.size = sz,
+				.alignment = target::field_alignment(field),
+				.fixed = fixed,
+			});
+			vt.field_indices[field] = compressed_idx;
+			return;
+		}
+
+		target::compressed_field &prev = vt.fields.back();
+		std::size_t prev_end = prev.offset + prev.size;
+
+		if (off < prev.offset)
+			pinpoint_fatal(
+				"target::build_compressed_fields: invalid field order in target \"%s\"",
+				target::qualified_name(type).c_str());
+
+		if (off >= prev_end) {
+			vt.fields.push_back({
+				.name = name,
+				.offset = off,
+				.size = sz,
+				.alignment = target::field_alignment(field),
+				.fixed = fixed,
+			});
+			vt.field_indices[field] = ++compressed_idx;
+			return;
+		}
+
+		if (!prev.fixed || !fixed) {
+			pinpoint_fatal(
+				"target::build_compressed_fields: overlapping non-fixed field in target \"%s\": \"%s\"",
+				target::qualified_name(type).c_str(),
+				target::field_name(field).c_str());
+		}
+
+		/*
+		 * Fixed overlapping fields are represented as one immovable byte
+		 * range in the runtime metadata. Alignment is irrelevant because
+		 * the randomizer will never move this synthetic field.
+		 */
+		if (end > prev_end)
+			prev.size = end - prev.offset;
+
+		prev.alignment = 1;
+		prev.fixed = true;
+		prev.name = prev.name + "+" + name;
+
+		vt.field_indices[field] = compressed_idx;
+	});
+}
+
+static void remember_target(tree type)
+{
+	type = target::main_variant(type);
+	if (!type)
+		return;
+
+	if (validated_targets.find(type) != validated_targets.end())
+		return;
+
+	auto new_vt = validated_targets.emplace(type, validated_target{});
+	if (!new_vt.second)
+		pinpoint_fatal(
+			"remember_target failed to log new validated target");
+
+	validated_target &vt = new_vt.first->second;
+
+	/* Must build compressed fields before hash, because hash queries them */
+	build_compressed_fields(type, vt);
+	vt.hash = compute_layout_hash(type);
+}
+
+bool target::is_validated_target(tree type)
+{
+	type = main_variant(type);
+	return type && validated_targets.find(type) != validated_targets.end();
+}
+
+const target::layout_hash_t &target::layout_hash(tree type)
+{
+	type = main_variant(type);
+
+	auto it = validated_targets.find(type);
+	if (it == validated_targets.end())
+		pinpoint_fatal(
+			"target::layout_hash: type is not a validated SPSLR target");
+
+	return it->second.hash;
+}
+
+tree target::main_variant(tree type)
+{
+	if (!type || TREE_CODE(type) != RECORD_TYPE)
+		return NULL_TREE;
+
+	return TYPE_MAIN_VARIANT(type);
+}
+
+tree target::from_field(tree field_decl)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		return NULL_TREE;
+
+	return main_variant(DECL_CONTEXT(field_decl));
+}
+
+bool target::is_target(tree type)
+{
+	type = main_variant(type);
+
+	if (!type || TREE_CODE(type) != RECORD_TYPE)
+		return false;
+
+	return lookup_attribute(SPSLR_ATTRIBUTE, TYPE_ATTRIBUTES(type));
+}
+
+std::string target::field_name(tree field_decl)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		return "<error>";
+
+	tree name = DECL_NAME(field_decl);
+	if (!name)
+		return "<anonymous>";
+
+	return IDENTIFIER_POINTER(name);
+}
+
+std::string target::name(tree type)
+{
+	type = main_variant(type);
+	if (!type)
+		return "<error>";
+
+	tree name_tree = TYPE_NAME(type);
+	if (!name_tree)
+		return "<anonymous>";
+
+	if (TREE_CODE(name_tree) == TYPE_DECL && DECL_NAME(name_tree))
+		return IDENTIFIER_POINTER(DECL_NAME(name_tree));
+
+	if (TREE_CODE(name_tree) == IDENTIFIER_NODE)
+		return IDENTIFIER_POINTER(name_tree);
+
+	return "<anonymous>";
+}
+
+static std::string decl_context_name(tree decl)
+{
+	if (!decl)
+		return "<anonymous>";
+
+	tree name = DECL_NAME(decl);
+	if (!name)
+		return "<anonymous>";
+
+	return IDENTIFIER_POINTER(name);
+}
+
+std::vector<std::string> target::context_chain(tree type)
+{
+	std::vector<std::string> out;
+
+	type = main_variant(type);
+	if (!type)
+		return out;
+
+	tree type_name = TYPE_NAME(type);
+	tree ctx = NULL_TREE;
+
+	if (type_name && TREE_CODE(type_name) == TYPE_DECL)
+		ctx = DECL_CONTEXT(type_name);
+
+	if (!ctx)
+		ctx = TYPE_CONTEXT(type);
+
+	for (; ctx;) {
+		if (TREE_CODE(ctx) == TRANSLATION_UNIT_DECL)
+			break;
+
+		if (TREE_CODE(ctx) == RECORD_TYPE) {
+			out.push_back(name(ctx));
+			ctx = TYPE_CONTEXT(ctx);
+			continue;
+		}
+
+		if (DECL_P(ctx)) {
+			out.push_back(decl_context_name(ctx));
+			ctx = DECL_CONTEXT(ctx);
+			continue;
+		}
+
+		if (TYPE_P(ctx)) {
+			out.push_back(name(ctx));
+			ctx = TYPE_CONTEXT(ctx);
+			continue;
+		}
+
+		break;
+	}
+
+	std::reverse(out.begin(), out.end());
+	return out;
+}
+
+std::string target::qualified_name(tree type)
+{
+	std::string out;
+
+	for (const std::string &ctx : context_chain(type)) {
+		if (!out.empty())
+			out += "::";
+		out += ctx;
+	}
+
+	if (!out.empty())
+		out += "::";
+
+	out += name(type);
+	return out;
+}
+
+std::size_t target::size(tree type)
+{
+	type = main_variant(type);
+
+	tree size_tree = type ? TYPE_SIZE(type) : NULL_TREE;
+	if (!size_tree || TREE_CODE(size_tree) != INTEGER_CST)
+		pinpoint_fatal("target::size: non-constant target size");
+
+	HOST_WIDE_INT bits = tree_to_uhwi(size_tree);
+	if (bits < 0 || bits % BITS_PER_UNIT)
+		pinpoint_fatal("target::size: target size is not byte-aligned");
+
+	return static_cast<std::size_t>(bits / BITS_PER_UNIT);
+}
+
+std::size_t target::field_offset(tree field_decl)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		pinpoint_fatal(
+			"target::field_offset can only be applied to FIELD_DECL trees");
+
+	tree field_byte_offset_tree = DECL_FIELD_OFFSET(field_decl);
+	tree field_bit_offset_tree = DECL_FIELD_BIT_OFFSET(field_decl);
+
+	if (!field_byte_offset_tree ||
+	    TREE_CODE(field_byte_offset_tree) != INTEGER_CST)
+		pinpoint_fatal(
+			"target::field_offset was unable to fetch byte offset");
+
+	if (!field_bit_offset_tree ||
+	    TREE_CODE(field_bit_offset_tree) != INTEGER_CST)
+		pinpoint_fatal(
+			"target::field_offset was unable to fetch bit offset");
+
+	HOST_WIDE_INT byte_offset = tree_to_uhwi(field_byte_offset_tree);
+	HOST_WIDE_INT bit_offset = tree_to_uhwi(field_bit_offset_tree);
+	HOST_WIDE_INT bit_offset_bytes = bit_offset / BITS_PER_UNIT;
+
+	return byte_offset + bit_offset_bytes;
+}
+
+bool target::field_has_size(tree field_decl)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		return false;
+
+	tree bit_offset = DECL_FIELD_BIT_OFFSET(field_decl);
+	tree bit_size = DECL_SIZE(field_decl);
+
+	return bit_offset && TREE_CODE(bit_offset) == INTEGER_CST && bit_size &&
+	       TREE_CODE(bit_size) == INTEGER_CST;
+}
+
+std::size_t target::field_size(tree field_decl)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		pinpoint_fatal(
+			"target::field_size can only be applied to FIELD_DECL trees");
+
+	tree field_bit_offset_tree = DECL_FIELD_BIT_OFFSET(field_decl);
+	tree field_bit_size_tree = DECL_SIZE(field_decl);
+
+	if (!field_bit_offset_tree ||
+	    TREE_CODE(field_bit_offset_tree) != INTEGER_CST)
+		pinpoint_fatal(
+			"target::field_size was unable to fetch bit offset");
+
+	if (!field_bit_size_tree ||
+	    TREE_CODE(field_bit_size_tree) != INTEGER_CST)
+		pinpoint_fatal(
+			"target::field_size was unable to fetch bit size");
+
+	HOST_WIDE_INT bit_offset =
+		tree_to_uhwi(field_bit_offset_tree) % BITS_PER_UNIT;
+	HOST_WIDE_INT bit_size = tree_to_uhwi(field_bit_size_tree) + bit_offset;
+
+	HOST_WIDE_INT bit_overhang = bit_size % BITS_PER_UNIT;
+	if (bit_overhang != 0)
+		bit_size += (8 - bit_overhang);
+
+	return static_cast<std::size_t>(bit_size / BITS_PER_UNIT);
+}
+
+std::size_t target::field_alignment(tree field_decl)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		pinpoint_fatal(
+			"target::field_alignment can only be applied to FIELD_DECL trees");
+
+	HOST_WIDE_INT alignment_bits = DECL_ALIGN(field_decl);
+	if (alignment_bits <= 0 && TREE_TYPE(field_decl))
+		alignment_bits = TYPE_ALIGN(TREE_TYPE(field_decl));
+	if (alignment_bits <= 0)
+		alignment_bits = BITS_PER_UNIT;
+
+	std::size_t alignment = static_cast<std::size_t>(
+		(alignment_bits + BITS_PER_UNIT - 1) / BITS_PER_UNIT);
+	if (alignment == 0)
+		alignment = 1;
+
+	return alignment;
+}
+
+bool target::field_is_bitfield(tree field_decl)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		pinpoint_fatal(
+			"target::field_is_bitfield can only be applied to FIELD_DECL trees");
+
+	tree field_bit_offset_tree = DECL_FIELD_BIT_OFFSET(field_decl);
+	tree field_bit_size_tree = DECL_SIZE(field_decl);
+
+	if (!field_bit_offset_tree ||
+	    TREE_CODE(field_bit_offset_tree) != INTEGER_CST)
+		pinpoint_fatal(
+			"target::field_is_bitfield was unable to fetch bit offset");
+
+	if (!field_bit_size_tree ||
+	    TREE_CODE(field_bit_size_tree) != INTEGER_CST)
+		pinpoint_fatal(
+			"target::field_is_bitfield was unable to fetch bit size");
+
+	HOST_WIDE_INT bit_offset =
+		tree_to_uhwi(field_bit_offset_tree) % BITS_PER_UNIT;
+	HOST_WIDE_INT bit_size = tree_to_uhwi(field_bit_size_tree);
+
+	bool decl_bitfield = DECL_BIT_FIELD_TYPE(field_decl) != NULL_TREE;
+	bool extra_bitfield = bit_size % 8 != 0 || bit_offset != 0;
+
+	return decl_bitfield || extra_bitfield;
+}
+
+bool target::field_is_fixed(tree field_decl)
+{
+	return field_is_bitfield(field_decl) ||
+	       lookup_attribute(SPSLR_FIELD_FIXED_ATTRIBUTE,
+				DECL_ATTRIBUTES(field_decl));
+}
+
+const std::vector<target::compressed_field> &
+target::compressed_fields(tree type)
+{
+	type = main_variant(type);
+
+	auto it = validated_targets.find(type);
+	if (it == validated_targets.end())
+		pinpoint_fatal(
+			"target::compressed_fields: type is not a validated SPSLR target");
+
+	return it->second.fields;
+}
+
+void target::iterate_targets(const target_callback &cb)
+{
+	for (const auto &[t, info] : validated_targets)
+		cb(t);
+}
+
+std::size_t target::target_count()
+{
+	return validated_targets.size();
+}
+
+void target::validate(tree type)
+{
+	type = main_variant(type);
+	remember_target(type);
+}
+
+bool target::component_ref(tree ref, tree *field_decl)
+{
+	if (!ref || TREE_CODE(ref) != COMPONENT_REF)
+		return false;
+
+	tree field = TREE_OPERAND(ref, 1);
+	if (!field || TREE_CODE(field) != FIELD_DECL)
+		return false;
+
+	tree type = from_field(field);
+	if (!is_target(type))
+		return false;
+
+	if (field_decl)
+		*field_decl = field;
+
+	return true;
+}
+
+std::size_t target::field_index(tree field_decl)
+{
+	tree type = from_field(field_decl);
+	if (!type)
+		pinpoint_fatal(
+			"target::field_index: field does not belong to a target");
+
+	auto vt = validated_targets.find(type);
+	if (vt == validated_targets.end())
+		pinpoint_fatal(
+			"target::field_index: field does not belong to a validated target");
+
+	auto it = vt->second.field_indices.find(field_decl);
+	if (it == vt->second.field_indices.end())
+		pinpoint_fatal(
+			"target::field_index: field does not belong to a validated target");
+
+	return it->second;
+}
+
+void target::reset()
+{
+	validated_targets.clear();
+}
diff --git a/scripts/gcc-plugins/target_registry.h b/scripts/gcc-plugins/target_registry.h
new file mode 100644
index 000000000000..5531cefffb38
--- /dev/null
+++ b/scripts/gcc-plugins/target_registry.h
@@ -0,0 +1,59 @@
+#pragma once
+
+#include <cstddef>
+#include <functional>
+#include <string>
+#include <vector>
+#include <array>
+
+#include <safe-tree.h>
+
+struct target {
+	struct compressed_field {
+		std::string name{};
+		std::size_t offset{};
+		std::size_t size{};
+		std::size_t alignment{};
+		bool fixed{};
+	};
+
+	static tree main_variant(tree type);
+	static tree from_field(tree field_decl);
+
+	static bool is_target(tree type);
+
+	static std::string name(tree type);
+	static std::vector<std::string> context_chain(tree type);
+	static std::string qualified_name(tree type);
+
+	static std::size_t size(tree type);
+
+	static std::string field_name(tree field_decl);
+	static std::size_t field_offset(tree field_decl);
+	static bool field_has_size(tree field_decl);
+	static std::size_t field_size(tree field_decl);
+	static std::size_t field_alignment(tree field_decl);
+	static bool field_is_bitfield(tree field_decl);
+	static bool field_is_fixed(tree field_decl);
+
+	static bool component_ref(tree ref, tree *field_decl);
+
+	static const std::vector<compressed_field> &
+	compressed_fields(tree type);
+
+	using target_callback = std::function<void(tree target_type)>;
+	static void iterate_targets(const target_callback &cb);
+	static std::size_t target_count();
+
+	static void validate(tree type);
+
+	/* THe field index is into compressed_fields */
+	static std::size_t field_index(tree field_decl);
+
+	using layout_hash_t = std::array<std::byte, 16>;
+
+	static bool is_validated_target(tree type);
+	static const layout_hash_t &layout_hash(tree type);
+
+	static void reset();
+};
-- 
2.43.0

