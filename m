Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792897968;
	b=bEK0o+ez+st7suP4Ynw+4PfeqlkcgHZyT6RV8GHLOII9Ktmqj3Byk1iZL1OIaDmVKQCH
	 glsq74A4KQBH8bCoCBglpcveLi6BL6fxcK7lBaIhv/vy9JvNzws+H2cu4U+BoWxbkrc2P
	 2K6LdWjEJDtRzBSQFEONFz+Mg+Iyiwv6WUdEQjh3T+AT7SROKWj+Z2EA6hYWR5aKb31Cr
	 esXmx0UOfRkJUEaaonj+ztnofjV+qXAe7Uay9O/cXwBqoRqBH0A4hK8hzrXfqQUOXRWVJ
	 uV8nh20DTougMX3yScfR6UpmAJOtWF+C0bKV/C+582MXriXNY6AZkbpdPxLc2KOixTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792897968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+3bzy77F5RXjJHl6Sh6fHDAn/HRxDXt2R9S6iQiHHtU=;
	b=y5F7S7FJWWgkkTUaV8rN9yJcHdMmlMLYnctsNPxEPGO7L7HVoFF1rusp0lah2M5K2wqu
	 9hRSUbVusogKEpGvRhUnj7bGOX810I9mkEYw0yjODv+Aa6ssBV/cQKtzMQLPkHiTScS2w
	 jCJKsojrIZ28tA9Z8mX93T4ZB8123W4XX/iGSOo0vqVx2wypIuGCp6BwWptr7dOHns9gT
	 g9Yxwmovt+IxkqwW7GCoWFdpn5c4/F1n8uPPQ/pVg06MhYS4z0bMIkzZVjiowLpB7gP5B
	 Zo2dnNnyVaOxKKL2U9eetmIGN/wVhvHIzY4XFjGnhMvuyrVzomPKxfcBnN0NYNpJAlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yjn-systems.com;
	spf=none smtp.mailfrom=yjn-systems.com;
	dkim=pass header.d=yjn-systems.com header.i=@yjn-systems.com header.a=rsa-sha256 header.s=google header.b=xAfUVivy;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9A606A31A
	for <linux-hardening@vger.kernel.org>; Sun, 25 Oct 2026 03:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yjn-systems.com header.i=@yjn-systems.com header.a=rsa-sha256 header.s=google header.b=xAfUVivy
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so10887575e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 24 Oct 2026 20:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1792897965; x=1793502765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3bzy77F5RXjJHl6Sh6fHDAn/HRxDXt2R9S6iQiHHtU=;
        b=xAfUVivyEWlWtVF27su+NQgaMQZPC+7ZvRAjZ1kgH3rmnfTRL3Xl8HEALh1VYoloJ8
         T/5DHgWyg/tOUxWUn287l6FRbikZwu70guc87BNcbB8NcC3FFpD+iSG8lAmcYE5tCMHV
         bphjmaQqgo6n8acU27pAt5GTgLMESOnRbAIeHp+njrKRrHer4UrdFl/2D0F+kQm4neKp
         3HsRdAvP7X0bXesAutgiqC0QRegLfiE+VbTupbZA8fvQPuhBNVJ2llEthuXOICBneKT2
         uo84AALzw5jjYD1NBqh9uYMHyEyBNZXavEaO3sFIMsmcIfpFu+DSftkjk2RlIym6Ma+b
         R7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792897965; x=1793502765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+3bzy77F5RXjJHl6Sh6fHDAn/HRxDXt2R9S6iQiHHtU=;
        b=bTfU8ThKtzZhcBGdDDcIxDxopDYHK05HSrgBvdbCsE5eUqFxT/5dMqUNWP9xNAaLPX
         Kf3bdz/c08XnwrSG3tbB7PDd11sDUPXLyl355zf6AZFupJr5ZCAqHkpu44GgwGymI20u
         dk+OIIefXnxtmszVn1h3AlReevim5GxyVDcNCcBhaTNQJ+fKBoQz97NEhCf/+EHJyy5g
         wXqvyTdz5a2WTqiGqwhXQD+7Sd2j0A7yXQQxl97957e+kNlyleuV+7KmV+rJ6yn+oP1K
         hvXknlKE1u8mUYtlzCxONSS5NAMPYJwPT6uI7pJOqfg4KkFp7blYx+M3SSbiBQ9OGxHF
         Vf7Q==
X-Gm-Message-State: AFq9FYKkWR89RRz55Q/QI+uMQP1srZJv1enH+549wtu/Tl28TDHeuu+1
	zJ+T+avXslDvARuyZHgST/Iqv9Na1I9f4AVrnFbKMlgZpbKxEKR6Tl5IFl7lm4bBTbITlnysAV8
	sfNkSoAVQ
X-Gm-Gg: AYBFou3CFfaGBugvqxAzCwUB1LsuIOXAqbAwHTgFpmXYBTQMMefzb1TCxZPpmm4R14A
	VaQ/v56HEpRXg9RoNpodXqqlbCXXfImYvHKHRZ3KrJNY604MuyAQFpqvG9Jxe3GmiWZfk/0XqoG
	2PGe2ysjmY1dyiExkoQW9U01VCIiDIh7I5zSrBPGglF6JMJL6plbh9uwgpB/HDAZr7KvxEnqEnO
	egIv0WggyUxgCxsK/AFb+lziDwWk+rHENYx5f6CL5F3RIg3gd2HPKBS0S3rDf+0zo4VryjyTbIR
	PPat2QRwxEhuOSi94jw/mgz+ED0ToxKd04tKkGhO5GXegUI9QBCvoLc7OnBJeLWeERt4HFLEipr
	AACMHNBE3YWrE/l/peq1o3B557uW6nI7xpy6hJDtmyEL0COaAPTDr3BOV2YRqXAA73lQyidfb9W
	30eyB1S4oFTJd8O3IzfGzVgOC54HG3fHLshMCbGasTmrk5W5Dei6rzA38rQm3Ak56G5TxWCpAGt
	V/jtfXicOBfId5XdimuRmQDNcFEk1PxsLRAw6mMrusBPNRyksJT9hY3AKArLEmB2RTHTSxqr/VI
	81DsMSINkx7Un7SDUwYzqzJD0XJJqEDsE9AfDoUvlOb/o7Qnl9UIJtGt/gj/ZqrWixD4rg==
X-Received: by 2002:a05:600c:3544:b0:49f:fd40:80fa with SMTP id 5b1f17b1804b1-4a35acc6b74mr57869625e9.34.1792897964560;
        Sat, 24 Oct 2026 20:12:44 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf1819005b3565a866058f95.dip0.t-ipconnect.de. [2003:dc:bf18:1900:5b35:65a8:6605:8f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a0e2sm113521785e9.13.2026.10.24.20.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:12:44 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	gregkh@linuxfoundation.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org,
	York Jasper Niebuhr <yjn@yjn-systems.com>
Subject: [RFC v4 1/3] Selfpatch-SLR pinpoint plugin
Date: Sun, 25 Oct 2026 04:12:30 +0100
Message-ID: <20261025031230.183808-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025031011.183364-1-yjn@yjn-systems.com>
References: <20261025031011.183364-1-yjn@yjn-systems.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the Pinpoint GCC plugin of the Selfpatch-SLR series. It
is the backing compiler extension that generates the metadata needed to
patch the kernel at boot to reflect randomized structure layouts.

Since new GCC plugins are no longer accepted upstream, this RFC uses a
GCC plugin as a prototype for the compiler-specific functionality. The
long-term implementation would need to live in GCC/LLVM instead.

This plugin necessitates the use of a customized toolchain.
Specifically, a GCC patch is required to preserve expressions which
depend on randomized field offsets instead of folding them into
constants in the C frontend. A binutils patch is additionally required
to identify the immediate/displacement bytes of instructions which are
later patched by Selfpatch-SLR. The toolchain patches are available
at:

  https://github.com/YJN-Systems/Selfpatch-SLR/tree/rfc-v4/toolchain/gcc_16_1_0
  https://github.com/YJN-Systems/Selfpatch-SLR/tree/rfc-v4/toolchain/gas_2_46_1

Pinpoint instruments accesses to fields of randomized target structure
types. Targets are marked with __attribute((spslr))__. Structures
consisting entirely of function pointers are selected implicitly as
targets.

Expressions whose values depend on randomized field offsets cannot be
allowed to become ordinary compile-time constants. The patched GCC
frontend therefore represents such values using DEFERRED_CST_EXPR and
DEFERRED_CST_COMPONENT_REF tree nodes. Field offsets within deferred
expressions are represented by IFN_DEFERRED_CST_FIELD_OFFSET. These
nodes preserve the original expression until Pinpoint has enough
information to decide how the dependency must be represented at
runtime.

Pinpoint consumes these nodes in its IPA pass. Deferred component
references are lowered first. An access to a randomized field is
rewritten as pointer arithmetic whose byte offset is represented by a
deferred field-offset expression. Bit-field accesses use the containing
representative field for the byte offset and reconstruct the original
bit-field access on top of it.

In a second phase, complete DEFERRED_CST_EXPR boundaries are lowered.
Integral subexpressions which depend on randomized field offsets become
instruction pins (ipins). Pinpoint keeps the expression's original
compile-time value for the initial kernel image and generates a small
calculator function which can reevaluate the expression using the
runtime field offsets selected during boot.

Each calculator has an interface equivalent to:

int calculator(spslr_offset_getter get_offset, uint64_t *result);

Calls to get_offset() identify a target and field and obtain that
field's randomized byte offset. A calculator can therefore reproduce
the value of an offset-dependent expression without embedding knowledge
of the randomized layout into the generated code.

Pinpoint associates the calculator, initial value and integer type with
an ipin. The ipin is carried through the remaining compiler pipeline,
and an RTL pass immediately before final emission ensures that the
corresponding patch site survives code generation. The emitted metadata
identifies the instruction bytes which Selfpatch-SLR must replace with
the calculator's result at boot.

Static data requires two additional forms of metadata.

Data pins (dpins) describe static instances of randomized target
structures. They allow the runtime to rearrange the object's contents
from the compiler's original layout into the randomized layout selected
during boot.

Refresh pins (rpins) handle static initializer values which themselves
depend on randomized field offsets. Pinpoint leaves the initializer
with its valid compile-time value and generates a refresh function which
recomputes and stores the value using runtime offsets. Aggregate
initializers are traversed recursively so that only affected scalar
leaves require refresh pins.

For example, an initializer containing an offset-dependent value remains
valid in the linked kernel image, but its rpin records the affected
object range and a function capable of restoring the corresponding
value after layouts have been randomized.

Target descriptions contain the original physical field layout and a
hash identifying the target type. The hash gives equivalent target
types emitted by different compilation units a common identity.
Target-reference symbols allow generated calculator and refresh
functions to refer to those targets without depending on the runtime
representation of the target metadata.

At the end of compilation, Pinpoint serializes target descriptions,
target references, original layouts, and ipin, dpin and rpin metadata
into dedicated ELF sections. Target metadata is emitted in COMDAT
sections so duplicate descriptions of the same type from different
compilation units can be coalesced by the linker.

The resulting kernel therefore still contains the compiler's original
structure layout and values when it is linked. Pinpoint's metadata gives
the Selfpatch-SLR runtime the information and generated code needed to
choose new layouts and transform those dependencies consistently during
boot.

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 scripts/Makefile.gcc-plugins                  |   11 +
 scripts/gcc-plugins/Makefile                  |   15 +
 .../gcc-plugins/pinpoint/deferred_pin_pass.c  | 1437 +++++++++++++++++
 scripts/gcc-plugins/pinpoint/dpin_registry.c  |  212 +++
 scripts/gcc-plugins/pinpoint/dpin_registry.h  |   25 +
 scripts/gcc-plugins/pinpoint/ipin_registry.c  |  363 +++++
 scripts/gcc-plugins/pinpoint/ipin_registry.h  |   58 +
 scripts/gcc-plugins/pinpoint/layout_hash.c    |   71 +
 scripts/gcc-plugins/pinpoint/layout_hash.h    |   15 +
 scripts/gcc-plugins/pinpoint/on_finish_type.c |   32 +
 scripts/gcc-plugins/pinpoint/on_finish_unit.c |  221 +++
 .../pinpoint/on_register_attributes.c         |   61 +
 scripts/gcc-plugins/pinpoint/on_start_unit.c  |   17 +
 scripts/gcc-plugins/pinpoint/passes.h         |   21 +
 scripts/gcc-plugins/pinpoint/pinpoint.c       |   75 +
 scripts/gcc-plugins/pinpoint/pinpoint.h       |   78 +
 scripts/gcc-plugins/pinpoint/rpin_registry.c  |   45 +
 scripts/gcc-plugins/pinpoint/rpin_registry.h  |   22 +
 .../pinpoint/rtl_ipin_survival_scan_pass.c    |   47 +
 scripts/gcc-plugins/pinpoint/serialize.c      |  287 ++++
 scripts/gcc-plugins/pinpoint/serialize.h      |  114 ++
 .../gcc-plugins/pinpoint/target_registry.c    |  541 +++++++
 .../gcc-plugins/pinpoint/target_registry.h    |   59 +
 security/Kconfig.hardening                    |    9 +-
 24 files changed, 3835 insertions(+), 1 deletion(-)
 create mode 100644 scripts/gcc-plugins/pinpoint/deferred_pin_pass.c
 create mode 100644 scripts/gcc-plugins/pinpoint/dpin_registry.c
 create mode 100644 scripts/gcc-plugins/pinpoint/dpin_registry.h
 create mode 100644 scripts/gcc-plugins/pinpoint/ipin_registry.c
 create mode 100644 scripts/gcc-plugins/pinpoint/ipin_registry.h
 create mode 100644 scripts/gcc-plugins/pinpoint/layout_hash.c
 create mode 100644 scripts/gcc-plugins/pinpoint/layout_hash.h
 create mode 100644 scripts/gcc-plugins/pinpoint/on_finish_type.c
 create mode 100644 scripts/gcc-plugins/pinpoint/on_finish_unit.c
 create mode 100644 scripts/gcc-plugins/pinpoint/on_register_attributes.c
 create mode 100644 scripts/gcc-plugins/pinpoint/on_start_unit.c
 create mode 100644 scripts/gcc-plugins/pinpoint/passes.h
 create mode 100644 scripts/gcc-plugins/pinpoint/pinpoint.c
 create mode 100644 scripts/gcc-plugins/pinpoint/pinpoint.h
 create mode 100644 scripts/gcc-plugins/pinpoint/rpin_registry.c
 create mode 100644 scripts/gcc-plugins/pinpoint/rpin_registry.h
 create mode 100644 scripts/gcc-plugins/pinpoint/rtl_ipin_survival_scan_pass.c
 create mode 100644 scripts/gcc-plugins/pinpoint/serialize.c
 create mode 100644 scripts/gcc-plugins/pinpoint/serialize.h
 create mode 100644 scripts/gcc-plugins/pinpoint/target_registry.c
 create mode 100644 scripts/gcc-plugins/pinpoint/target_registry.h

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b0e1423b09c2..713f13580185 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -8,6 +8,17 @@ ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 endif
 export DISABLE_LATENT_ENTROPY_PLUGIN
 
+PINPOINT_PLUGIN_CFLAGS := \
+	-fplugin=$(objtree)/scripts/gcc-plugins/pinpoint_plugin.so \
+	-fdeferred-cst-static \
+	-fdeferred-cst-barrier-hard \
+	-D__SPSLR__
+
+gcc-plugin-$(CONFIG_SPSLR) += pinpoint_plugin.so
+gcc-plugin-cflags-$(CONFIG_SPSLR) += -fdeferred-cst-static -fdeferred-cst-barrier-hard -D__SPSLR__
+
+export PINPOINT_PLUGIN_CFLAGS
+
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -DGCC_PLUGINS
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 05b14aba41ef..bf190d2ded57 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -22,6 +22,21 @@ targets += randomize_layout_seed.h
 #
 # foo-objs := foo.o foo2.o
 
+pinpoint_plugin-objs := \
+	pinpoint/pinpoint.o \
+	pinpoint/deferred_pin_pass.o \
+	pinpoint/layout_hash.o \
+	pinpoint/on_start_unit.o \
+	pinpoint/dpin_registry.o \
+	pinpoint/rtl_ipin_survival_scan_pass.o \
+	pinpoint/on_finish_type.o \
+	pinpoint/serialize.o \
+	pinpoint/ipin_registry.o \
+	pinpoint/on_finish_unit.o \
+	pinpoint/on_register_attributes.o \
+	pinpoint/rpin_registry.o \
+	pinpoint/target_registry.o
+
 always-y += $(GCC_PLUGIN)
 
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
diff --git a/scripts/gcc-plugins/pinpoint/deferred_pin_pass.c b/scripts/gcc-plugins/pinpoint/deferred_pin_pass.c
new file mode 100644
index 000000000000..97199497484e
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/deferred_pin_pass.c
@@ -0,0 +1,1437 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <stringpool.h>
+#include <tree-iterator.h>
+#include <tree-pass.h>
+#include <gimple.h>
+#include <gimplify.h>
+#include <gimple-iterator.h>
+#include <gimplify-me.h>
+#include <cgraph.h>
+#include <deferred-cst.h>
+#include <function.h>
+#include <internal-fn.h>
+#include <tree-cfg.h>
+#include <diagnostic.h>
+#include <ggc.h>
+#include <gimple-pretty-print.h>
+
+#include <cstdint>
+#include <string>
+#include <map>
+
+#include "pinpoint.h"
+#include "passes.h"
+#include "serialize.h"
+#include "rpin_registry.h"
+#include "dpin_registry.h"
+#include "ipin_registry.h"
+#include "target_registry.h"
+
+static const pass_data deferred_pin_pass_data = { SIMPLE_IPA_PASS,
+						  "spslr-deferred-pin",
+						  OPTGROUP_NONE,
+						  TV_NONE,
+						  0,
+						  0,
+						  0,
+						  0,
+						  0 };
+
+deferred_pin_pass::deferred_pin_pass(gcc::context *ctxt)
+	: simple_ipa_opt_pass(deferred_pin_pass_data, ctxt)
+{
+}
+
+/*
+ * Generated calculator/refresh functions are queued here rather than
+ * immediately added to the call graph.  They are constructed while the pass
+ * is walking existing functions/static initializers, then gimplified and
+ * registered with the call graph after all lowering is complete.
+ */
+static std::vector<tree> pending_generated_functions;
+
+static unsigned HOST_WIDE_INT next_calculator_id;
+static unsigned HOST_WIDE_INT next_refresh_id;
+
+static tree const_void_pointer_type = NULL_TREE;
+static tree uint64_pointer_type = NULL_TREE;
+static tree offset_getter_function_type = NULL_TREE;
+static tree offset_getter_pointer_type = NULL_TREE;
+
+static std::map<std::string, tree> target_ref_decls;
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	PINPOINT_GC_MARK_TREE(const_void_pointer_type);
+	PINPOINT_GC_MARK_TREE(uint64_pointer_type);
+	PINPOINT_GC_MARK_TREE(offset_getter_function_type);
+	PINPOINT_GC_MARK_TREE(offset_getter_pointer_type);
+
+	for (const auto &[_, decl] : target_ref_decls)
+		PINPOINT_GC_MARK_TREE(decl);
+
+	for (tree fn : pending_generated_functions)
+		PINPOINT_GC_MARK_TREE(fn);
+}
+
+static void ensure_generated_function_abi()
+{
+	if (offset_getter_pointer_type)
+		return;
+
+	tree const_void_type =
+		build_qualified_type(void_type_node, TYPE_QUAL_CONST);
+
+	const_void_pointer_type = build_pointer_type(const_void_type);
+
+	uint64_pointer_type = build_pointer_type(uint64_type_node);
+
+	/*
+	 * int get_offset(
+	 *     const void *target_ref,
+	 *     uint64_t field_index,
+	 *     uint64_t *offset);
+	 */
+	offset_getter_function_type = build_function_type_list(
+		integer_type_node, const_void_pointer_type, uint64_type_node,
+		uint64_pointer_type, NULL_TREE);
+
+	offset_getter_pointer_type =
+		build_pointer_type(offset_getter_function_type);
+}
+
+static void reset_deferred_function_abi()
+{
+	const_void_pointer_type = NULL_TREE;
+	uint64_pointer_type = NULL_TREE;
+	offset_getter_function_type = NULL_TREE;
+	offset_getter_pointer_type = NULL_TREE;
+	target_ref_decls.clear();
+}
+
+/*
+ * Create a symbolic reference to the target's runtime descriptor.  The
+ * declaration's C type is intentionally irrelevant: generated code never
+ * accesses the object itself, only takes its address and passes that address
+ * to the runtime offset getter.
+ */
+static tree target_ref_decl_for_field(tree field)
+{
+	tree target_type = target::from_field(field);
+	const target *target_info = target::inspect(target_type);
+
+	if (!target_info) {
+		pinpoint_fatal_loc(DECL_SOURCE_LOCATION(field),
+				   "runtime-offset field does not belong "
+				   "to a registered target");
+	}
+
+	const std::string symbol =
+		selfpatch::target_ref_symbol(target_info->hash);
+
+	auto it = target_ref_decls.find(symbol);
+	if (it != target_ref_decls.end())
+		return it->second;
+
+	/*
+	 * Only the address of this declaration is used. GCC does not need
+	 * to know the actual struct spslr_target_ref representation.
+	 */
+	tree decl = build_decl(UNKNOWN_LOCATION, VAR_DECL,
+			       get_identifier(symbol.c_str()),
+			       unsigned_char_type_node);
+
+	DECL_EXTERNAL(decl) = 1;
+	TREE_PUBLIC(decl) = 1;
+	DECL_ARTIFICIAL(decl) = 1;
+	DECL_IGNORED_P(decl) = 1;
+	TREE_USED(decl) = 1;
+
+	SET_DECL_ASSEMBLER_NAME(decl, get_identifier(symbol.c_str()));
+
+	target_ref_decls.emplace(symbol, decl);
+	return decl;
+}
+
+/*
+ * Construction state for a generated calculator/refresh function.
+ *
+ * Runtime field-offset lowering may append failure checks and introduce
+ * addressable offset temporaries, so expression lowering builds the function
+ * body incrementally through this object.
+ */
+struct generated_body {
+	tree function = NULL_TREE;
+	tree result_decl = NULL_TREE;
+	tree getter_parameter = NULL_TREE;
+
+	tree locals = NULL_TREE;
+	tree statements = NULL_TREE;
+};
+
+static tree make_parameter(tree function, location_t loc, const char *name,
+			   tree type)
+{
+	tree parameter = build_decl(loc, PARM_DECL, get_identifier(name), type);
+
+	DECL_ARG_TYPE(parameter) = type;
+	DECL_CONTEXT(parameter) = function;
+	DECL_ARTIFICIAL(parameter) = 1;
+	DECL_IGNORED_P(parameter) = 1;
+
+	return parameter;
+}
+
+static tree make_status_return(location_t loc, tree result_decl, int status)
+{
+	tree assignment = build2_loc(loc, MODIFY_EXPR, integer_type_node,
+				     result_decl,
+				     build_int_cst(integer_type_node, status));
+
+	return build1_loc(loc, RETURN_EXPR, void_type_node, assignment);
+}
+
+static tree add_uint64_local(generated_body *body, location_t loc,
+			     const char *name)
+{
+	tree local = build_decl(loc, VAR_DECL, get_identifier(name),
+				uint64_type_node);
+
+	DECL_CONTEXT(local) = body->function;
+	DECL_ARTIFICIAL(local) = 1;
+	DECL_IGNORED_P(local) = 1;
+	TREE_USED(local) = 1;
+	TREE_ADDRESSABLE(local) = 1;
+
+	TREE_CHAIN(local) = body->locals;
+	body->locals = local;
+
+	return local;
+}
+
+/*
+ * Lower a deferred field offset inside a generated function.
+ *
+ * Emit:
+ *
+ *     uint64_t offset;
+ *     if (get_offset(&target_ref, field_index, &offset) != 0)
+ *         return -1;
+ *
+ * and return OFFSET converted to RESULT_TYPE for use in the expression
+ * currently being constructed.
+ */
+static tree build_runtime_field_offset(location_t loc, tree field,
+				       tree result_type, generated_body *body)
+{
+	if (!body || !body->getter_parameter)
+		pinpoint_fatal_loc(loc, "runtime field-offset lowering has "
+					"no offset getter");
+
+	tree target_ref_decl = target_ref_decl_for_field(field);
+
+	tree target_ref_address = build_fold_addr_expr(target_ref_decl);
+
+	target_ref_address = fold_convert_loc(loc, const_void_pointer_type,
+					      target_ref_address);
+
+	tree field_index =
+		build_int_cst(uint64_type_node, target::field_index(field));
+
+	tree offset = add_uint64_local(body, loc, "spslr_runtime_offset");
+
+	tree offset_address = build_fold_addr_expr(offset);
+
+	tree arguments[] = {
+		target_ref_address,
+		field_index,
+		offset_address,
+	};
+
+	tree call = build_call_array_loc(loc, integer_type_node,
+					 body->getter_parameter, 3, arguments);
+
+	/*
+	 * if (get_offset(...) != 0)
+	 *     return -1;
+	 */
+	tree failed = build2_loc(loc, NE_EXPR, boolean_type_node, call,
+				 build_int_cst(integer_type_node, 0));
+
+	tree failure_return = make_status_return(loc, body->result_decl, -1);
+
+	tree check = build3_loc(loc, COND_EXPR, void_type_node, failed,
+				failure_return, build_empty_stmt(loc));
+
+	append_to_statement_list(check, &body->statements);
+
+	return fold_convert_loc(loc, result_type, offset);
+}
+
+static bool integer_pin_type_p(tree type)
+{
+	if (!type || !INTEGRAL_TYPE_P(type))
+		return false;
+
+	switch (TYPE_PRECISION(type)) {
+	case 8:
+	case 16:
+	case 32:
+	case 64:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static ipin::kind ipin_kind_for_type(tree type)
+{
+	if (!integer_pin_type_p(type))
+		pinpoint_fatal("cannot create ipin for unsupported type");
+
+	const bool is_unsigned = TYPE_UNSIGNED(type);
+
+	switch (TYPE_PRECISION(type)) {
+	case 8:
+		return is_unsigned ? ipin::kind::u8 : ipin::kind::s8;
+	case 16:
+		return is_unsigned ? ipin::kind::u16 : ipin::kind::s16;
+	case 32:
+		return is_unsigned ? ipin::kind::u32 : ipin::kind::s32;
+	case 64:
+		return is_unsigned ? ipin::kind::u64 : ipin::kind::s64;
+	default:
+		gcc_unreachable();
+	}
+}
+
+/*
+ * These helpers may only be used while processing the contents of a known
+ * DEFERRED_CST_EXPR.
+ */
+static bool field_offset_call_p(tree expr)
+{
+	return expr && TREE_CODE(expr) == CALL_EXPR &&
+	       CALL_EXPR_IFN(expr) == IFN_DEFERRED_CST_FIELD_OFFSET;
+}
+
+static tree field_from_offset_call(tree call)
+{
+	if (!field_offset_call_p(call) || call_expr_nargs(call) != 1) {
+		pinpoint_fatal_loc(
+			EXPR_LOCATION(call),
+			"malformed deferred field-offset expression");
+	}
+
+	tree field =
+		deferred_cst_ifn_field_offset_field(CALL_EXPR_ARG(call, 0));
+
+	if (!field || TREE_CODE(field) != FIELD_DECL) {
+		pinpoint_fatal_loc(EXPR_LOCATION(call),
+				   "deferred field-offset token has no field");
+	}
+
+	return field;
+}
+
+enum class substitute_mode { initial, runtime };
+
+/*
+ * EXPR is known to be inside a DEFERRED_CST_EXPR.
+ *
+ * In initial mode, replace each field-offset IFN with the original
+ * compile-time byte offset.
+ *
+ * In runtime mode, replace each field-offset IFN with a load from the
+ * target's runtime-offset array.
+ */
+static tree substitute_field_offsets(tree expr, substitute_mode mode,
+				     generated_body *body = nullptr)
+{
+	if (!expr)
+		return NULL_TREE;
+
+	if (CONSTANT_CLASS_P(expr))
+		return expr;
+
+	if (TREE_CODE(expr) == DEFERRED_CST_EXPR) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expr),
+				   "nested DEFERRED_CST_EXPR");
+	}
+
+	if (field_offset_call_p(expr)) {
+		tree field = field_from_offset_call(expr);
+
+		if (mode == substitute_mode::initial) {
+			return fold_convert_loc(EXPR_LOCATION(expr),
+						TREE_TYPE(expr),
+						byte_position(field));
+		}
+
+		return build_runtime_field_offset(EXPR_LOCATION(expr), field,
+						  TREE_TYPE(expr), body);
+	}
+
+	if (!deferred_cst_operator_p(TREE_CODE(expr))) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expr),
+				   "unsupported operation %qs inside "
+				   "DEFERRED_CST_EXPR",
+				   get_tree_code_name(TREE_CODE(expr)));
+	}
+
+	tree copy = copy_node(expr);
+
+	for (int i = 0; i < TREE_OPERAND_LENGTH(expr); ++i) {
+		TREE_OPERAND(copy, i) = substitute_field_offsets(
+			TREE_OPERAND(expr, i), mode, body);
+	}
+
+	return mode == substitute_mode::initial ? fold(copy) : copy;
+}
+
+/*
+ * Return whether EXPR, which is known to be inside a
+ * DEFERRED_CST_EXPR, depends on at least one deferred field offset.
+ */
+static bool deferred_inner_depends_p(tree expr)
+{
+	if (!expr || CONSTANT_CLASS_P(expr))
+		return false;
+
+	if (TREE_CODE(expr) == DEFERRED_CST_EXPR) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expr),
+				   "nested DEFERRED_CST_EXPR");
+	}
+
+	if (field_offset_call_p(expr))
+		return true;
+
+	if (!deferred_cst_operator_p(TREE_CODE(expr))) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expr),
+				   "unsupported operation %qs inside "
+				   "DEFERRED_CST_EXPR",
+				   get_tree_code_name(TREE_CODE(expr)));
+	}
+
+	for (int i = 0; i < TREE_OPERAND_LENGTH(expr); ++i) {
+		if (deferred_inner_depends_p(TREE_OPERAND(expr, i))) {
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void set_local_function_assembler_name(tree function,
+					      const std::string &name)
+{
+	gcc_assert(function);
+	gcc_assert(TREE_CODE(function) == FUNCTION_DECL);
+
+	/*
+	 * GNU as normally removes symbols whose names begin with ".L".
+	 * References from SPSLR metadata are resolved to the containing
+	 * section symbol plus the function's section-relative offset.
+	 */
+	std::string assembler_name = ".L" + name;
+
+	SET_DECL_ASSEMBLER_NAME(function,
+				get_identifier(assembler_name.c_str()));
+}
+
+/*
+ * Build the runtime calculator associated with one deferred instruction pin.
+ *
+ * The calculator reconstructs the original expression using runtime field
+ * offsets and writes the resulting value through RESULT.  Thus, the patcher
+ * can call the calculator to produce a patch-site's value.
+ */
+static tree make_calculator(tree expression)
+{
+	location_t loc = EXPR_LOCATION(expression);
+
+	ensure_generated_function_abi();
+
+	std::string name = "__spslr_deferred_calculator_" +
+			   std::to_string(next_calculator_id++);
+
+	/*
+	 * int calculator(
+	 *     spslr_offset_getter get_offset,
+	 *     uint64_t *result);
+	 */
+	tree fn_type = build_function_type_list(integer_type_node,
+						offset_getter_pointer_type,
+						uint64_pointer_type, NULL_TREE);
+
+	tree fn = build_fn_decl(name.c_str(), fn_type);
+
+	set_local_function_assembler_name(fn, name);
+
+	TREE_PUBLIC(fn) = 0;
+	DECL_EXTERNAL(fn) = 0;
+	DECL_ARTIFICIAL(fn) = 1;
+	DECL_IGNORED_P(fn) = 1;
+	TREE_USED(fn) = 1;
+	DECL_PRESERVE_P(fn) = 1;
+	DECL_UNINLINABLE(fn) = 1;
+	DECL_CONTEXT(fn) = NULL_TREE;
+
+	set_decl_section_name(fn, ".spslr.calc.text");
+
+	tree getter_parameter = make_parameter(fn, loc, "get_offset",
+					       offset_getter_pointer_type);
+
+	tree output_parameter =
+		make_parameter(fn, loc, "result", uint64_pointer_type);
+
+	TREE_CHAIN(getter_parameter) = output_parameter;
+	DECL_ARGUMENTS(fn) = getter_parameter;
+
+	tree result_decl =
+		build_decl(loc, RESULT_DECL, NULL_TREE, integer_type_node);
+
+	DECL_ARTIFICIAL(result_decl) = 1;
+	DECL_IGNORED_P(result_decl) = 1;
+	DECL_CONTEXT(result_decl) = fn;
+	DECL_RESULT(fn) = result_decl;
+
+	generated_body body;
+	body.function = fn;
+	body.result_decl = result_decl;
+	body.getter_parameter = getter_parameter;
+	body.statements = alloc_stmt_list();
+
+	tree value = substitute_field_offsets(expression,
+					      substitute_mode::runtime, &body);
+
+	value = fold_convert_loc(loc, uint64_type_node, value);
+
+	tree output = build_simple_mem_ref(output_parameter);
+
+	TREE_TYPE(output) = uint64_type_node;
+
+	tree store =
+		build2_loc(loc, MODIFY_EXPR, uint64_type_node, output, value);
+
+	append_to_statement_list(store, &body.statements);
+	append_to_statement_list(make_status_return(loc, result_decl, 0),
+				 &body.statements);
+
+	tree block = make_node(BLOCK);
+	TREE_USED(block) = 1;
+	BLOCK_SUPERCONTEXT(block) = fn;
+	DECL_INITIAL(fn) = block;
+
+	DECL_SAVED_TREE(fn) = build3_loc(loc, BIND_EXPR, void_type_node,
+					 body.locals, body.statements, block);
+
+	pending_generated_functions.push_back(fn);
+	return fn;
+}
+
+static void materialize_pending_generated_functions()
+{
+	for (tree fn : pending_generated_functions) {
+		push_struct_function(fn, false);
+		pop_cfun();
+
+		gcc_assert(cfun == NULL);
+		gcc_assert(current_function_decl == NULL_TREE);
+		gcc_assert(DECL_STRUCT_FUNCTION(fn));
+
+		gimplify_function_tree(fn);
+		cgraph_node::add_new_function(fn, false);
+	}
+
+	pending_generated_functions.clear();
+}
+
+static std::uint64_t initial_integer_value(tree expression)
+{
+	tree initial =
+		substitute_field_offsets(expression, substitute_mode::initial);
+
+	initial = fold(initial);
+
+	/*
+	 * Require an actual integer constant, rather than accepting any
+	 * CONSTANT_CLASS_P node.
+	 */
+	if (!initial || TREE_CODE(initial) != INTEGER_CST) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expression),
+				   "deferred instruction pin did not "
+				   "evaluate to an integer");
+	}
+
+	initial = fold_convert(size_type_node, initial);
+
+	if (!initial || TREE_CODE(initial) != INTEGER_CST) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expression),
+				   "could not normalize deferred "
+				   "instruction pin");
+	}
+
+	return static_cast<std::uint64_t>(tree_to_uhwi(initial));
+}
+
+static tree materialize_integer_pin(tree expression, gimple_stmt_iterator *gsi)
+{
+	tree expression_type = TREE_TYPE(expression);
+
+	if (!integer_pin_type_p(expression_type)) {
+		pinpoint_fatal_loc(
+			EXPR_LOCATION(expression),
+			"instruction pin must have a signed or "
+			"unsigned 8, 16, 32, or 64-bit integer type");
+	}
+
+	ipin::kind patch_kind = ipin_kind_for_type(expression_type);
+	tree calculator = make_calculator(expression);
+	std::uint64_t initial = initial_integer_value(expression);
+
+	ipin::handle handle =
+		ipin::make_deferred(calculator, initial, patch_kind);
+
+	/*
+	 * The output temporary retains the expression's exact signedness and
+	 * width. GCC will insert any required extension or conversion at its
+	 * use sites.
+	 */
+	tree value = create_tmp_var(expression_type, "spslr_deferred_value");
+
+	gimple *pin_stmt = ipin::make_gimple_pin(value, handle);
+
+	if (!pin_stmt) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expression),
+				   "failed to construct instruction pin");
+	}
+
+	gsi_insert_before(gsi, pin_stmt, GSI_SAME_STMT);
+	return value;
+}
+
+struct lowered_expr {
+	tree value;
+	bool deferred;
+};
+
+/*
+ * Lower one subtree inside a known DEFERRED_CST_EXPR.
+ *
+ * A maximal integral subtree that depends on a deferred field offset becomes
+ * one ipin. Non-integral operations are rebuilt as ordinary runtime
+ * operations.
+ *
+ * If an integral subtree itself contains floating-point operations, those
+ * operations remain inside its calculator.
+ */
+static lowered_expr lower_deferred_inner(tree expr, gimple_stmt_iterator *gsi)
+{
+	if (!expr)
+		return { NULL_TREE, false };
+
+	if (TREE_CODE(expr) == DEFERRED_CST_EXPR) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expr),
+				   "nested DEFERRED_CST_EXPR");
+	}
+
+	if (!deferred_inner_depends_p(expr)) {
+		return { expr, false };
+	}
+
+	/*
+	 * This is the maximal integral deferred subtree. Do not descend into
+	 * it: the entire expression belongs in one calculator.
+	 */
+	if (integer_pin_type_p(TREE_TYPE(expr))) {
+		return { materialize_integer_pin(expr, gsi), true };
+	}
+
+	/*
+	 * Field-offset IFNs have sizetype, so reaching this condition would
+	 * indicate a malformed deferred expression.
+	 */
+	if (field_offset_call_p(expr)) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expr),
+				   "deferred field-offset IFN has "
+				   "non-integral type");
+	}
+
+	if (!deferred_cst_operator_p(TREE_CODE(expr))) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expr),
+				   "unsupported non-integral operation %qs "
+				   "inside DEFERRED_CST_EXPR",
+				   get_tree_code_name(TREE_CODE(expr)));
+	}
+
+	tree copy = copy_node(expr);
+	bool deferred = false;
+
+	for (int i = 0; i < TREE_OPERAND_LENGTH(expr); ++i) {
+		lowered_expr operand =
+			lower_deferred_inner(TREE_OPERAND(expr, i), gsi);
+
+		TREE_OPERAND(copy, i) = operand.value;
+
+		deferred |= operand.deferred;
+	}
+
+	if (!deferred) {
+		pinpoint_fatal_loc(EXPR_LOCATION(expr),
+				   "lost deferred dependency while lowering "
+				   "DEFERRED_CST_EXPR");
+	}
+
+	return { copy, true };
+}
+
+/*
+ * This is the sole entry point into deferred-expression lowering.
+ */
+static tree lower_deferred_wrapper(tree wrapper, gimple_stmt_iterator *gsi)
+{
+	if (!wrapper || TREE_CODE(wrapper) != DEFERRED_CST_EXPR) {
+		pinpoint_fatal("lower_deferred_wrapper called without "
+			       "DEFERRED_CST_EXPR");
+	}
+
+	tree inner = TREE_OPERAND(wrapper, 0);
+
+	if (!deferred_inner_depends_p(inner)) {
+		pinpoint_fatal_loc(EXPR_LOCATION(wrapper),
+				   "DEFERRED_CST_EXPR contains no "
+				   "deferred field offset");
+	}
+
+	lowered_expr lowered = lower_deferred_inner(inner, gsi);
+
+	if (!lowered.deferred) {
+		pinpoint_fatal_loc(EXPR_LOCATION(wrapper),
+				   "failed to lower DEFERRED_CST_EXPR");
+	}
+
+	/*
+	 * The result can contain ordinary runtime floating-point operations or
+	 * conversions from normalized 64-bit ipin values.
+	 */
+	return lowered.value;
+}
+
+/* Breaks a DEFERRED_CST_COMPONENT_REF REF apart into pointer
+   arithmetic.  The field offset in the resulting expression is
+   represented by a call to IFN_DEFERRED_CST_FIELD_OFFSET.  That
+   call is additionally wrapped in a DEFERRED_CST_EXPR.  For bit-
+   fields, the expression is represented by a BIT_FIELD_REF
+   around the pointer arithmetic that accesses the field's
+   representative.  The base of REF must be addressable.  */
+static tree deferred_cst_lower_component_ref(tree ref,
+					     gimple_stmt_iterator *gsi)
+{
+	gcc_assert(ref);
+	gcc_assert(TREE_CODE(ref) == DEFERRED_CST_COMPONENT_REF);
+
+	location_t loc = EXPR_LOCATION(ref);
+	tree type = TREE_TYPE(ref);
+	tree base = TREE_OPERAND(ref, 0);
+	tree field = TREE_OPERAND(ref, 1);
+
+	gcc_assert(field);
+	gcc_assert(TREE_CODE(field) == FIELD_DECL);
+
+	tree randomized_field = NULL_TREE;
+	if (DECL_BIT_FIELD(field))
+		randomized_field = DECL_BIT_FIELD_REPRESENTATIVE(field);
+	else
+		randomized_field = field;
+
+	gcc_assert(randomized_field);
+	gcc_assert(TREE_CODE(randomized_field) == FIELD_DECL);
+	gcc_assert(!DECL_BIT_FIELD(randomized_field));
+
+	tree randomized_field_type = TREE_TYPE(randomized_field);
+	tree randomized_field_ptr_type =
+		build_pointer_type(randomized_field_type);
+
+	tree base_ptr = build_fold_addr_expr(base);
+	tree offset = deferred_cst_build_expr(
+		deferred_cst_call_ifn_field_offset(loc, randomized_field));
+
+	tree randomized_field_ptr =
+		fold_build_pointer_plus_loc(loc, base_ptr, offset);
+	randomized_field_ptr = fold_convert_loc(loc, randomized_field_ptr_type,
+						randomized_field_ptr);
+
+	/*
+	 * Materialize the computed address immediately.  This keeps the
+	 * replacement MEM_REF itself in GIMPLE form instead of embedding
+	 * pointer arithmetic underneath it.
+	 */
+	tree address_tmp = create_tmp_var(randomized_field_ptr_type,
+					  "spslr_deferred_addr");
+
+	gimple *address_stmt =
+		gimple_build_assign(address_tmp, randomized_field_ptr);
+	gimple_set_location(address_stmt, loc);
+	gsi_insert_before(gsi, address_stmt, GSI_SAME_STMT);
+
+	tree randomized_field_ref = build_simple_mem_ref(address_tmp);
+	SET_EXPR_LOCATION(randomized_field_ref, loc);
+
+	TREE_READONLY(randomized_field_ref) = TREE_READONLY(ref);
+	TREE_THIS_VOLATILE(randomized_field_ref) = TREE_THIS_VOLATILE(ref);
+	TREE_SIDE_EFFECTS(randomized_field_ref) = TREE_SIDE_EFFECTS(ref);
+
+	if (!DECL_BIT_FIELD(field)) {
+		TREE_TYPE(randomized_field_ref) = type;
+		return randomized_field_ref;
+	}
+
+	/* Reconstruct the bit-field over the representative storage.
+	   Operand 2 of BIT_FIELD_REF is the field width in bits; operand
+	   3 is its bit position relative to operand 0.  */
+	tree field_position = bit_position(field);
+	tree representative_position = bit_position(randomized_field);
+
+	gcc_assert(field_position);
+	gcc_assert(representative_position);
+	gcc_assert(TREE_CODE(field_position) == INTEGER_CST);
+	gcc_assert(TREE_CODE(representative_position) == INTEGER_CST);
+	gcc_assert(tree_fits_uhwi_p(field_position));
+	gcc_assert(tree_fits_uhwi_p(representative_position));
+
+	unsigned HOST_WIDE_INT field_bit_position =
+		tree_to_uhwi(field_position);
+	unsigned HOST_WIDE_INT representative_bit_position =
+		tree_to_uhwi(representative_position);
+
+	gcc_assert(field_bit_position >= representative_bit_position);
+
+	unsigned HOST_WIDE_INT relative_bit_position =
+		field_bit_position - representative_bit_position;
+
+	tree bit_size = DECL_SIZE(field);
+
+	gcc_assert(bit_size);
+	gcc_assert(TREE_CODE(bit_size) == INTEGER_CST);
+
+	tree bit_ref = build3_loc(loc, BIT_FIELD_REF, type,
+				  randomized_field_ref, bit_size,
+				  bitsize_int(relative_bit_position));
+
+	TREE_READONLY(bit_ref) = TREE_READONLY(ref);
+	TREE_THIS_VOLATILE(bit_ref) = TREE_THIS_VOLATILE(ref);
+	TREE_SIDE_EFFECTS(bit_ref) = TREE_SIDE_EFFECTS(ref);
+
+	return bit_ref;
+}
+
+struct lowering_walk_context {
+	gimple_stmt_iterator *gsi;
+	bool changed;
+};
+
+/*
+ * Phase one: lower only DEFERRED_CST_COMPONENT_REF.
+ *
+ * This callback does not inspect or lower DEFERRED_CST_EXPR nodes. The
+ * component-ref helper may introduce such nodes around field-offset IFNs;
+ * those wrappers are left for phase two.
+ */
+
+static tree lower_component_ref_tree(tree *tp, int *walk_subtrees, void *data)
+{
+	tree node = *tp;
+
+	if (!node)
+		return NULL_TREE;
+
+	if (TYPE_P(node) || DECL_P(node)) {
+		*walk_subtrees = 0;
+		return NULL_TREE;
+	}
+
+	/*
+	 * Phase one must not enter a deferred constant boundary.  Any
+	 * DEFERRED_CST_COMPONENT_REF below this wrapper belongs to the
+	 * expression represented by the wrapper and is handled in the
+	 * next phase.
+	 */
+	if (TREE_CODE(node) == DEFERRED_CST_EXPR) {
+		*walk_subtrees = 0;
+		return NULL_TREE;
+	}
+
+	auto *context = static_cast<lowering_walk_context *>(data);
+
+	if (TREE_CODE(node) != DEFERRED_CST_COMPONENT_REF)
+		return NULL_TREE;
+
+	/* Lower nested component accesses before lowering the current access. */
+	*walk_subtrees = 0;
+
+	walk_tree(&TREE_OPERAND(node, 0), lower_component_ref_tree, context,
+		  NULL);
+
+	/*
+	 * The base is now free of deferred component references, so it is safe
+	 * to construct its address and lower the current access.
+	 */
+	*tp = deferred_cst_lower_component_ref(node, context->gsi);
+	context->changed = true;
+	return NULL_TREE;
+}
+
+/*
+ * Phase two: find only complete DEFERRED_CST_EXPR wrappers.
+ *
+ * Outside such a wrapper, this callback does not recognize field-offset IFNs
+ * or component references.
+ */
+static tree lower_deferred_expr_tree(tree *tp, int *walk_subtrees, void *data)
+{
+	tree node = *tp;
+
+	if (!node)
+		return NULL_TREE;
+
+	if (TYPE_P(node) || DECL_P(node)) {
+		*walk_subtrees = 0;
+		return NULL_TREE;
+	}
+
+	if (TREE_CODE(node) != DEFERRED_CST_EXPR)
+		return NULL_TREE;
+
+	auto *context = static_cast<lowering_walk_context *>(data);
+
+	*tp = lower_deferred_wrapper(node, context->gsi);
+
+	/*
+	 * The complete deferred boundary has been consumed. Do not enter the
+	 * original expression or the generated replacement through the generic
+	 * walker.
+	 */
+	*walk_subtrees = 0;
+	context->changed = true;
+
+	return NULL_TREE;
+}
+
+static void walk_gimple_trees_in_function(function *fn,
+					  tree (*callback)(tree *, int *,
+							   void *))
+{
+	basic_block bb;
+
+	FOR_EACH_BB_FN(bb, fn)
+	{
+		for (gimple_stmt_iterator gsi = gsi_start_bb(bb);
+		     !gsi_end_p(gsi); gsi_next(&gsi)) {
+			gimple *stmt = gsi_stmt(gsi);
+
+			lowering_walk_context context{ .gsi = &gsi,
+						       .changed = false };
+
+			for (unsigned i = 0; i < gimple_num_ops(stmt); ++i) {
+				tree *operand = gimple_op_ptr(stmt, i);
+
+				if (!operand || !*operand)
+					continue;
+
+				walk_tree(operand, callback, &context, NULL);
+			}
+
+			if (context.changed)
+				gimple_regimplify_operands(stmt, &gsi);
+		}
+	}
+}
+
+static bool initializer_has_deferred(tree expr)
+{
+	if (!expr || DECL_P(expr) || TYPE_P(expr))
+		return false;
+
+	if (TREE_CODE(expr) == DEFERRED_CST_EXPR ||
+	    TREE_CODE(expr) == DEFERRED_CST_COMPONENT_REF)
+		return true;
+
+	if (TREE_CODE(expr) == CONSTRUCTOR) {
+		unsigned HOST_WIDE_INT i;
+		tree index, value;
+
+		FOR_EACH_CONSTRUCTOR_ELT(CONSTRUCTOR_ELTS(expr), i, index,
+					 value)
+		{
+			if (initializer_has_deferred(value))
+				return true;
+		}
+
+		return false;
+	}
+
+	for (int i = 0; i < TREE_OPERAND_LENGTH(expr); ++i) {
+		if (initializer_has_deferred(TREE_OPERAND(expr, i)))
+			return true;
+	}
+
+	return false;
+}
+
+enum class initializer_mode { initial, runtime };
+
+static tree transform_initializer_expr(tree expr, initializer_mode mode,
+				       generated_body *body = nullptr)
+{
+	if (!expr || DECL_P(expr) || TYPE_P(expr) || CONSTANT_CLASS_P(expr))
+		return expr;
+
+	location_t loc = EXPR_LOCATION(expr);
+
+	if (TREE_CODE(expr) == DEFERRED_CST_EXPR) {
+		tree value = substitute_field_offsets(
+			TREE_OPERAND(expr, 0),
+			mode == initializer_mode::initial ?
+				substitute_mode::initial :
+				substitute_mode::runtime,
+			body);
+
+		return mode == initializer_mode::initial ? fold(value) : value;
+	}
+
+	if (TREE_CODE(expr) == DEFERRED_CST_COMPONENT_REF) {
+		tree base = transform_initializer_expr(TREE_OPERAND(expr, 0),
+						       mode, body);
+		tree field = TREE_OPERAND(expr, 1);
+
+		if (mode == initializer_mode::initial) {
+			tree ref = build3_loc(loc, COMPONENT_REF,
+					      TREE_TYPE(expr), base, field,
+					      NULL_TREE);
+
+			TREE_READONLY(ref) = TREE_READONLY(expr);
+			TREE_THIS_VOLATILE(ref) = TREE_THIS_VOLATILE(expr);
+			TREE_SIDE_EFFECTS(ref) = TREE_SIDE_EFFECTS(expr);
+			return ref;
+		}
+
+		if (DECL_BIT_FIELD(field)) {
+			pinpoint_fatal_loc(
+				loc, "cannot take the address of a deferred "
+				     "bit-field in a static initializer");
+		}
+
+		tree base_address = build_fold_addr_expr(base);
+		tree offset = build_runtime_field_offset(loc, field,
+							 size_type_node, body);
+
+		tree address =
+			fold_build_pointer_plus_loc(loc, base_address, offset);
+		address = fold_convert_loc(
+			loc, build_pointer_type(TREE_TYPE(expr)), address);
+
+		tree ref = build_simple_mem_ref(address);
+		TREE_TYPE(ref) = TREE_TYPE(expr);
+		TREE_READONLY(ref) = TREE_READONLY(expr);
+		TREE_THIS_VOLATILE(ref) = TREE_THIS_VOLATILE(expr);
+		return ref;
+	}
+
+	if (TREE_CODE(expr) == CONSTRUCTOR) {
+		pinpoint_fatal_loc(
+			loc, "nested aggregate expression must be handled "
+			     "as constructor elements");
+	}
+
+	if (!initializer_has_deferred(expr))
+		return expr;
+
+	tree copy = copy_node(expr);
+
+	for (int i = 0; i < TREE_OPERAND_LENGTH(expr); ++i) {
+		TREE_OPERAND(copy, i) = transform_initializer_expr(
+			TREE_OPERAND(expr, i), mode, body);
+	}
+
+	return mode == initializer_mode::initial ? fold(copy) : copy;
+}
+
+static tree make_refresh_function(tree object, tree destination_type,
+				  std::size_t original_offset,
+				  tree original_value)
+{
+	location_t loc = DECL_SOURCE_LOCATION(object);
+
+	ensure_generated_function_abi();
+
+	std::string name =
+		"__spslr_refresh_" + std::to_string(next_refresh_id++);
+
+	/*
+	 * int refresh(spslr_offset_getter get_offset);
+	 */
+	tree fn_type = build_function_type_list(
+		integer_type_node, offset_getter_pointer_type, NULL_TREE);
+
+	tree fn = build_fn_decl(name.c_str(), fn_type);
+
+	set_local_function_assembler_name(fn, name);
+
+	TREE_PUBLIC(fn) = 0;
+	DECL_EXTERNAL(fn) = 0;
+	DECL_ARTIFICIAL(fn) = 1;
+	DECL_IGNORED_P(fn) = 1;
+	TREE_USED(fn) = 1;
+	DECL_PRESERVE_P(fn) = 1;
+	DECL_UNINLINABLE(fn) = 1;
+	DECL_CONTEXT(fn) = NULL_TREE;
+
+	set_decl_section_name(fn, ".spslr.calc.text");
+
+	tree getter_parameter = make_parameter(fn, loc, "get_offset",
+					       offset_getter_pointer_type);
+
+	DECL_ARGUMENTS(fn) = getter_parameter;
+
+	tree result_decl =
+		build_decl(loc, RESULT_DECL, NULL_TREE, integer_type_node);
+
+	DECL_ARTIFICIAL(result_decl) = 1;
+	DECL_IGNORED_P(result_decl) = 1;
+	DECL_CONTEXT(result_decl) = fn;
+	DECL_RESULT(fn) = result_decl;
+
+	generated_body body;
+	body.function = fn;
+	body.result_decl = result_decl;
+	body.getter_parameter = getter_parameter;
+	body.statements = alloc_stmt_list();
+
+	tree value = transform_initializer_expr(
+		original_value, initializer_mode::runtime, &body);
+
+	tree object_address = build_fold_addr_expr(object);
+
+	tree byte_address = fold_build_pointer_plus_loc(
+		loc, object_address, size_int(original_offset));
+
+	tree writable_type = build_qualified_type(
+		TYPE_MAIN_VARIANT(destination_type), TYPE_QUAL_VOLATILE);
+
+	tree pointer_type = build_pointer_type(writable_type);
+
+	tree typed_address = fold_convert_loc(loc, pointer_type, byte_address);
+
+	tree destination = build_simple_mem_ref(typed_address);
+
+	TREE_TYPE(destination) = writable_type;
+
+	TREE_THIS_VOLATILE(destination) = 1;
+
+	value = fold_convert_loc(loc, TYPE_MAIN_VARIANT(destination_type),
+				 value);
+
+	tree store = build2_loc(loc, MODIFY_EXPR, TREE_TYPE(destination),
+				destination, value);
+
+	append_to_statement_list(store, &body.statements);
+	append_to_statement_list(make_status_return(loc, result_decl, 0),
+				 &body.statements);
+
+	tree block = make_node(BLOCK);
+	TREE_USED(block) = 1;
+	BLOCK_SUPERCONTEXT(block) = fn;
+	DECL_INITIAL(fn) = block;
+
+	DECL_SAVED_TREE(fn) = build3_loc(loc, BIND_EXPR, void_type_node,
+					 body.locals, body.statements, block);
+
+	pending_generated_functions.push_back(fn);
+	return fn;
+}
+
+static std::size_t constant_size(tree type)
+{
+	tree size = TYPE_SIZE_UNIT(type);
+
+	if (!size || TREE_CODE(size) != INTEGER_CST || !tree_fits_uhwi_p(size))
+		pinpoint_fatal("rpin: destination has no constant byte size");
+
+	return tree_to_uhwi(size);
+}
+
+static std::size_t constructor_element_offset(tree container_type, tree index)
+{
+	if (!container_type)
+		pinpoint_fatal("rpin: constructor has no container type");
+
+	if (TREE_CODE(container_type) == RECORD_TYPE) {
+		if (!index || TREE_CODE(index) != FIELD_DECL)
+			pinpoint_fatal(
+				"rpin: unsupported record constructor index");
+
+		if (DECL_BIT_FIELD(index))
+			pinpoint_fatal("rpin: deferred bit-field initializer "
+				       "cannot be refreshed with a byte store");
+
+		return target::field_offset(index);
+	}
+
+	if (TREE_CODE(container_type) == UNION_TYPE ||
+	    TREE_CODE(container_type) == QUAL_UNION_TYPE) {
+		if (!index || TREE_CODE(index) != FIELD_DECL)
+			pinpoint_fatal(
+				"rpin: unsupported union constructor index");
+
+		if (DECL_BIT_FIELD(index))
+			pinpoint_fatal_loc(
+				DECL_SOURCE_LOCATION(index),
+				"rpin: deferred union bit-field initializer "
+				"cannot be refreshed with a byte store");
+
+		/*
+		 * Every union member starts at the beginning of the union.
+		 * The containing constructor's original_offset already locates
+		 * the union itself.
+		 */
+		return 0;
+	}
+
+	if (TREE_CODE(container_type) == ARRAY_TYPE) {
+		if (!index || TREE_CODE(index) != INTEGER_CST)
+			pinpoint_fatal(
+				"rpin: unsupported array constructor index");
+
+		tree domain = TYPE_DOMAIN(container_type);
+		tree lower = domain ? TYPE_MIN_VALUE(domain) : NULL_TREE;
+
+		if (!lower || TREE_CODE(lower) != INTEGER_CST)
+			pinpoint_fatal(
+				"rpin: array has no constant lower bound");
+
+		tree difference = fold_build2(MINUS_EXPR, sizetype,
+					      fold_convert(sizetype, index),
+					      fold_convert(sizetype, lower));
+
+		if (TREE_CODE(difference) != INTEGER_CST ||
+		    !tree_fits_uhwi_p(difference))
+			pinpoint_fatal("rpin: array index is not constant");
+
+		return tree_to_uhwi(difference) *
+		       constant_size(TREE_TYPE(container_type));
+	}
+
+	pinpoint_fatal("rpin: unsupported constructor type");
+}
+
+static bool record_or_union_type_p(tree type)
+{
+	if (!type)
+		return false;
+
+	switch (TREE_CODE(type)) {
+	case RECORD_TYPE:
+	case UNION_TYPE:
+	case QUAL_UNION_TYPE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * Remove deferred expressions from a static initializer.
+ *
+ * Aggregate constructors are recursively rebuilt while ORIGINAL_OFFSET tracks
+ * each element's byte offset within OBJECT.  A scalar element containing a
+ * deferred expression gets a refresh function/rpin for its storage range and
+ * is replaced in the static initializer by its compile-time initial value.
+ */
+static tree process_initializer(tree object, tree value, tree value_type,
+				std::size_t original_offset)
+{
+	if (!value)
+		return value;
+
+	if (TREE_CODE(value) == CONSTRUCTOR) {
+		vec<constructor_elt, va_gc> *elements = NULL;
+		unsigned HOST_WIDE_INT i;
+		tree index, element;
+
+		FOR_EACH_CONSTRUCTOR_ELT(CONSTRUCTOR_ELTS(value), i, index,
+					 element)
+		{
+			if (index && TREE_CODE(index) == RANGE_EXPR &&
+			    initializer_has_deferred(element))
+				pinpoint_fatal_loc(
+					DECL_SOURCE_LOCATION(object),
+					"deferred constructor ranges "
+					"are unsupported");
+
+			tree element_type;
+
+			if (record_or_union_type_p(value_type)) {
+				if (!index || TREE_CODE(index) != FIELD_DECL)
+					pinpoint_fatal_loc(
+						DECL_SOURCE_LOCATION(object),
+						"rpin: record or union constructor has "
+						"a non-field index");
+
+				element_type = TREE_TYPE(index);
+			} else if (TREE_CODE(value_type) == ARRAY_TYPE) {
+				element_type = TREE_TYPE(value_type);
+			} else {
+				pinpoint_fatal(
+					"rpin: unsupported initializer constructor");
+			}
+
+			std::size_t offset = original_offset;
+
+			if (initializer_has_deferred(element))
+				offset += constructor_element_offset(value_type,
+								     index);
+
+			tree clean = process_initializer(object, element,
+							 element_type, offset);
+
+			CONSTRUCTOR_APPEND_ELT(elements, index, clean);
+		}
+
+		tree clean = build_constructor(value_type, elements);
+		TREE_CONSTANT(clean) = TREE_CONSTANT(value);
+		TREE_STATIC(clean) = TREE_STATIC(value);
+		return clean;
+	}
+
+	if (!initializer_has_deferred(value))
+		return value;
+
+	if (TREE_CODE(value_type) == RECORD_TYPE ||
+	    TREE_CODE(value_type) == ARRAY_TYPE ||
+	    TREE_CODE(value_type) == UNION_TYPE ||
+	    TREE_CODE(value_type) == QUAL_UNION_TYPE)
+		pinpoint_fatal_loc(DECL_SOURCE_LOCATION(object),
+				   "deferred aggregate initializer needs "
+				   "individual constructor elements");
+
+	std::size_t size = constant_size(value_type);
+	tree refresh = make_refresh_function(object, value_type,
+					     original_offset, value);
+
+	rpin::add(refresh, object, original_offset, size);
+
+	return transform_initializer_expr(value, initializer_mode::initial);
+}
+
+static void make_deferred_static_mutable(tree decl)
+{
+	gcc_assert(decl && TREE_CODE(decl) == VAR_DECL);
+
+	/*
+	 * Although this object may have been declared const in the source,
+	 * the deferred-constant runtime can rewrite its contents.
+	 *
+	 * Do not let later optimization passes treat loads from it as
+	 * invariant or replace them with DECL_INITIAL. Propagation of the
+	 * initial value after deferred cst extraction would produce
+	 * unpatched users.
+	 */
+	TREE_READONLY(decl) = 0;
+}
+
+static void process_static_variables()
+{
+	varpool_node *vnode;
+
+	FOR_EACH_VARIABLE(vnode)
+	{
+		tree decl = vnode->decl;
+
+		if (!decl || TREE_CODE(decl) != VAR_DECL ||
+		    DECL_EXTERNAL(decl) || !TREE_STATIC(decl))
+			continue;
+
+		tree init = DECL_INITIAL(decl);
+
+		if (init && initializer_has_deferred(init)) {
+			make_deferred_static_mutable(decl);
+
+			tree clean = process_initializer(decl, init,
+							 TREE_TYPE(decl), 0);
+
+			DECL_INITIAL(decl) = clean;
+
+			if (initializer_has_deferred(clean))
+				pinpoint_fatal_loc(
+					DECL_SOURCE_LOCATION(decl),
+					"deferred node remains in static initializer");
+		}
+
+		dpin::consider_static_var(decl);
+	}
+}
+
+unsigned int deferred_pin_pass::execute(function *fn)
+{
+	(void)fn;
+
+	reset_deferred_function_abi();
+
+	process_static_variables();
+
+	/*
+	 * Phase one: lower deferred component lvalues. This phase may introduce
+	 * DEFERRED_CST_EXPR nodes containing field-offset IFNs.
+	 */
+	cgraph_node *node;
+
+	FOR_EACH_FUNCTION_WITH_GIMPLE_BODY(node)
+	{
+		function *body = DECL_STRUCT_FUNCTION(node->decl);
+
+		if (!body)
+			continue;
+
+		push_cfun(body);
+		walk_gimple_trees_in_function(body, lower_component_ref_tree);
+		pop_cfun();
+	}
+
+	/*
+	 * Phase two: consume complete DEFERRED_CST_EXPR boundaries. Only the
+	 * helpers reached through such a wrapper may inspect a deferred
+	 * field-offset IFN.
+	 */
+	FOR_EACH_FUNCTION_WITH_GIMPLE_BODY(node)
+	{
+		function *body = DECL_STRUCT_FUNCTION(node->decl);
+
+		if (!body)
+			continue;
+
+		push_cfun(body);
+		walk_gimple_trees_in_function(body, lower_deferred_expr_tree);
+		pop_cfun();
+	}
+
+	/* Sanity check: is everything valid gimple? */
+	FOR_EACH_FUNCTION_WITH_GIMPLE_BODY(node)
+	{
+		function *body = DECL_STRUCT_FUNCTION(node->decl);
+
+		if (!body)
+			continue;
+
+		push_cfun(body);
+		verify_gimple_in_cfg(body, true);
+		pop_cfun();
+	}
+
+	materialize_pending_generated_functions();
+
+	return 0;
+}
diff --git a/scripts/gcc-plugins/pinpoint/dpin_registry.c b/scripts/gcc-plugins/pinpoint/dpin_registry.c
new file mode 100644
index 000000000000..183a7583613a
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/dpin_registry.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <diagnostic.h>
+#include <ggc.h>
+#include <cgraph.h>
+
+#include <string>
+#include <unordered_set>
+
+#include "pinpoint.h"
+#include "dpin_registry.h"
+#include "target_registry.h"
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
+	dpin pin;
+	if (!compile_datapin(type, pin))
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
+	TREE_USED(var) = 1;
+	DECL_PRESERVE_P(var) = 1;
+
+	varpool_node *vnode = varpool_node::get_create(var);
+	vnode->force_output = 1;
+
+	pin.symbol = sym;
+	pins.emplace_back(std::move(pin));
+}
diff --git a/scripts/gcc-plugins/pinpoint/dpin_registry.h b/scripts/gcc-plugins/pinpoint/dpin_registry.h
new file mode 100644
index 000000000000..4be52efb475d
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/dpin_registry.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PINPOINT_DPIN_REGISTRY_H
+#define PINPOINT_DPIN_REGISTRY_H
+
+#include <cstddef>
+#include <list>
+#include <string>
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
+
+#endif
diff --git a/scripts/gcc-plugins/pinpoint/ipin_registry.c b/scripts/gcc-plugins/pinpoint/ipin_registry.c
new file mode 100644
index 000000000000..554d13b7b8fe
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/ipin_registry.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <gimple.h>
+#include <rtl.h>
+#include <diagnostic.h>
+#include <ggc.h>
+
+#include <cstring>
+#include <algorithm>
+#include <cinttypes>
+
+#include "pinpoint.h"
+#include "ipin_registry.h"
+#include "target_registry.h"
+
+#define PINPOINT_IPIN_MARKER "spslr_ipin_marker"
+#define PINPOINT_IPIN_SYMBOL_PREFIX "spslr_ipin_" /* suffixed with "<uid>" */
+#define PINPOINT_IPIN_WIDTH_SYMBOL_PREFIX \
+	"spslr_ipin_width_" /* suffixed with "<uid>" */
+
+static ipin::handle next_ipin_handle = 0;
+static std::map<ipin::handle, ipin> ipins;
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	for (const auto &[h, pin] : ipins)
+		PINPOINT_GC_MARK_TREE(pin.calculator);
+}
+
+static ipin *get_pin(ipin::handle pin)
+{
+	auto it = ipins.find(pin);
+	return it == ipins.end() ? nullptr : &it->second;
+}
+
+std::size_t ipin::kind_size_bytes(kind patch_kind)
+{
+	switch (patch_kind) {
+	case kind::s8:
+	case kind::u8:
+		return 1;
+
+	case kind::s16:
+	case kind::u16:
+		return 2;
+
+	case kind::s32:
+	case kind::u32:
+		return 4;
+
+	case kind::s64:
+	case kind::u64:
+		return 8;
+	}
+
+	gcc_unreachable();
+}
+
+static bool kind_signed_p(ipin::kind patch_kind)
+{
+	switch (patch_kind) {
+	case ipin::kind::s8:
+	case ipin::kind::s16:
+	case ipin::kind::s32:
+	case ipin::kind::s64:
+		return true;
+
+	case ipin::kind::u8:
+	case ipin::kind::u16:
+	case ipin::kind::u32:
+	case ipin::kind::u64:
+		return false;
+	}
+
+	gcc_unreachable();
+}
+
+ipin::handle ipin::make_deferred(tree calculator, std::uint64_t initial,
+				 kind patch_kind)
+{
+	if (!calculator || TREE_CODE(calculator) != FUNCTION_DECL)
+		pinpoint_fatal("ipin: calculator is not a function");
+
+	const std::size_t width = ipin::kind_size_bytes(patch_kind);
+
+	if (width < sizeof(std::uint64_t)) {
+		const unsigned bits = width * 8;
+		const std::uint64_t mask = (std::uint64_t{ 1 } << bits) - 1;
+
+		initial &= mask;
+	}
+
+	handle h = next_ipin_handle++;
+
+	ipin pin;
+	pin.calculator = calculator;
+	pin.initial = initial;
+	pin.patch_kind = patch_kind;
+
+	ipins.emplace(h, std::move(pin));
+	return h;
+}
+
+static bool lhs_matches_kind(tree lhs, ipin::kind patch_kind)
+{
+	if (!lhs)
+		return false;
+
+	tree type = TREE_TYPE(lhs);
+	if (!type || !INTEGRAL_TYPE_P(type))
+		return false;
+
+	const unsigned precision = TYPE_PRECISION(type);
+	const unsigned expected_precision =
+		ipin::kind_size_bytes(patch_kind) * 8;
+
+	if (precision != expected_precision)
+		return false;
+
+	const bool type_signed = !TYPE_UNSIGNED(type);
+	return type_signed == kind_signed_p(patch_kind);
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
+static const char *x86_instruction(ipin::kind patch_kind)
+{
+	switch (ipin::kind_size_bytes(patch_kind)) {
+	case 1:
+		return "movb";
+	case 2:
+		return "movw";
+	case 4:
+		return "movl";
+	case 8:
+		return "movabsq";
+	default:
+		gcc_unreachable();
+	}
+}
+
+static const char *x86_output_modifier(ipin::kind patch_kind)
+{
+	switch (ipin::kind_size_bytes(patch_kind)) {
+	case 1:
+		return "%b0";
+	case 2:
+		return "%w0";
+	case 4:
+		return "%k0";
+	case 8:
+		return "%0";
+	default:
+		gcc_unreachable();
+	}
+}
+
+/*
+ * The symbol does not denote executable code as a callable function; it denotes
+ * the patchable immediate field inside the instruction stream.
+ */
+static std::string make_final_x86_64_asm(const std::string &field_symbol,
+					 const std::string &width_symbol,
+					 ipin::kind patch_kind,
+					 std::uint64_t imm)
+{
+	const std::size_t expected_width = ipin::kind_size_bytes(patch_kind);
+	const char *insn = x86_instruction(patch_kind);
+	const char *output = x86_output_modifier(patch_kind);
+
+	char buf[1024];
+
+	std::snprintf(buf, sizeof(buf),
+		      "# %s\n"
+		      "%s $fieldlabel(%" PRIu64 ", %s, %s), %s\n"
+		      ".if %s != %zu\n"
+		      ".error \"SPSLR ipin fieldlabel has unexpected size\"\n"
+		      ".endif",
+		      PINPOINT_IPIN_MARKER, insn, imm, field_symbol.c_str(),
+		      width_symbol.c_str(), output, width_symbol.c_str(),
+		      expected_width);
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
+	if (!lhs_matches_kind(lhs, p->patch_kind))
+		pinpoint_fatal("ipin: output type does not match ipin kind");
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
+	const std::string width_symbol =
+		".L" + std::string(PINPOINT_IPIN_WIDTH_SYMBOL_PREFIX) +
+		handle_suffix;
+
+	std::string final_asm =
+		make_final_x86_64_asm(live_pin->symbol, width_symbol,
+				      live_pin->patch_kind, live_pin->initial);
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
diff --git a/scripts/gcc-plugins/pinpoint/ipin_registry.h b/scripts/gcc-plugins/pinpoint/ipin_registry.h
new file mode 100644
index 000000000000..4d53d55046ae
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/ipin_registry.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PINPOINT_IPIN_REGISTRY_H
+#define PINPOINT_IPIN_REGISTRY_H
+
+#include <cstddef>
+#include <cstdint>
+#include <string>
+#include <limits>
+#include <map>
+
+struct ipin {
+	enum class state { pin, live };
+
+	enum class kind { s8, u8, s16, u16, s32, u32, s64, u64 };
+
+	state status = state::pin;
+
+	/* The function that calculates the pins value at runtime and
+	   the initial pin value.  */
+	tree calculator = NULL_TREE;
+	std::uint64_t initial = 0;
+	kind patch_kind = kind::u64;
+
+	/*
+	 * The field-address symbol are available once the pin is marked
+	 * live and its final inline assembly has been constructed.
+	 */
+	std::string symbol;
+
+	using handle = std::size_t;
+	static constexpr handle invalid = std::numeric_limits<handle>::max();
+
+	/* Register new ipin to track through compilation */
+	static handle make_deferred(tree calculator, std::uint64_t initial,
+				    kind patch_kind);
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
+	static std::size_t kind_size_bytes(kind patch_kind);
+
+	/* Inspect the state of one or more ipins */
+	static const std::map<handle, ipin> &inspect();
+	static const ipin *inspect(handle pin);
+
+	/* Reset ipin registry */
+	static void reset();
+};
+
+#endif
diff --git a/scripts/gcc-plugins/pinpoint/layout_hash.c b/scripts/gcc-plugins/pinpoint/layout_hash.c
new file mode 100644
index 000000000000..c4702856e1a9
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/layout_hash.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <md5.h>
+
+#include <cstdint>
+#include <cstring>
+
+#include "target_registry.h"
+#include "layout_hash.h"
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
+std::string hash_hex(const unsigned char *data, std::size_t n)
+{
+	static constexpr char digits[] = "0123456789abcdef";
+
+	std::string out;
+	out.resize(n * 2);
+
+	for (std::size_t i = 0; i < n; ++i) {
+		out[i * 2] = digits[(data[i] >> 4) & 0x0f];
+		out[i * 2 + 1] = digits[data[i] & 0x0f];
+	}
+
+	return out;
+}
+
+}
+
+std::string
+compute_layout_hash(const std::string &qname, std::size_t size,
+		    const std::vector<target::physical_field> &fields)
+{
+	std::string buf;
+
+	append_string(buf, "spslr-layout-hash-v2");
+
+	append_string(buf, qname);
+	append_size(buf, size);
+
+	for (const target::physical_field &field : fields) {
+		append_string(buf, field.name);
+		append_size(buf, field.size);
+		append_size(buf, field.offset);
+		append_size(buf, field.alignment);
+	}
+
+	unsigned char digest[16];
+	md5_buffer(buf.data(), buf.size(), digest);
+
+	return hash_hex(digest, 16);
+}
diff --git a/scripts/gcc-plugins/pinpoint/layout_hash.h b/scripts/gcc-plugins/pinpoint/layout_hash.h
new file mode 100644
index 000000000000..1925f306264d
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/layout_hash.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PINPOINT_LAYOUT_HASH_H
+#define PINPOINT_LAYOUT_HASH_H
+
+#include <array>
+#include <vector>
+#include <string>
+#include <cstddef>
+
+std::string
+compute_layout_hash(const std::string &qname, std::size_t size,
+		    const std::vector<target::physical_field> &fields);
+
+#endif
diff --git a/scripts/gcc-plugins/pinpoint/on_finish_type.c b/scripts/gcc-plugins/pinpoint/on_finish_type.c
new file mode 100644
index 000000000000..15f6b74bc63b
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/on_finish_type.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <tree-pass.h>
+#include <stringpool.h>
+#include <attribs.h>
+
+#include "passes.h"
+#include "target_registry.h"
+
+static void add_deferred_cst_access(tree type)
+{
+	if (!lookup_attribute("deferred_cst_access", TYPE_ATTRIBUTES(type))) {
+		TYPE_ATTRIBUTES(type) =
+			tree_cons(get_identifier("deferred_cst_access"),
+				  NULL_TREE, TYPE_ATTRIBUTES(type));
+	}
+}
+
+void on_finish_type(void *plugin_data, void *user_data)
+{
+	tree t = target::main_variant((tree)plugin_data);
+
+	if (!target::is_target(t))
+		return;
+
+	/* All spslr targets require deferred cst accesses.  */
+	add_deferred_cst_access(t);
+
+	target::validate(t);
+}
diff --git a/scripts/gcc-plugins/pinpoint/on_finish_unit.c b/scripts/gcc-plugins/pinpoint/on_finish_unit.c
new file mode 100644
index 000000000000..995c633cd7de
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/on_finish_unit.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <tree-pass.h>
+#include <output.h>
+#include <gimple.h>
+#include <diagnostic.h>
+#include <ggc.h>
+
+#include <string>
+#include <filesystem>
+#include <vector>
+#include <algorithm>
+#include <unordered_map>
+#include <unordered_set>
+
+#include "pinpoint.h"
+#include "passes.h"
+#include "ipin_registry.h"
+#include "dpin_registry.h"
+#include "rpin_registry.h"
+#include "serialize.h"
+#include "target_registry.h"
+
+/*
+ * Finish-unit emits the per-compilation-unit metadata into the object asm.
+ *
+ * Only information that survived all earlier filtering should be dumped here:
+ * target layouts, data/refresh pins for static objects, and live instruction pins
+ * whose immediates exist in the final object.
+ */
+
+static std::string add_offset_expr(const std::string &symbol, std::size_t off)
+{
+	if (off == 0)
+		return symbol;
+
+	return symbol + " + " + std::to_string(off);
+}
+
+static void emit_targets(FILE *out)
+{
+	/* Identical anonymous types can occur in multiple places and
+	   cause symbol redefinition errors if emitted twice.  */
+	std::unordered_set<std::string> emitted_hashes;
+
+	for (const auto &[_, ut] : target::inspect()) {
+		if (!emitted_hashes.insert(ut.hash).second) {
+			pinpoint_debug(
+				"finish-unit: target \"%s\" with hash %s "
+				"was already emitted",
+				ut.qname.c_str(), ut.hash.c_str());
+			continue;
+		}
+
+		const std::string target_sym =
+			selfpatch::target_symbol(ut.hash);
+		const std::string layout_sym =
+			selfpatch::target_layout_symbol(ut.hash);
+		const std::string fields_sym =
+			selfpatch::make_local_label("target_fields");
+
+		const std::string target_name =
+			selfpatch::emit_strtab_entry(out, ut.qname);
+		const std::string target_hash =
+			selfpatch::emit_strtab_entry(out, ut.hash);
+
+		selfpatch::emit_targets_section(out, ut.hash);
+		selfpatch::emit_hidden_global_label(out, target_sym);
+
+		selfpatch::target_desc target_desc{
+			.hash_label = target_hash,
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
+			.size = ut.size,
+			.field_cnt = ut.fields.size(),
+			.fields_symbol = fields_sym,
+		};
+
+		selfpatch::emit_target_layout(out, layout_desc);
+
+		selfpatch::emit_label(out, fields_sym);
+
+		for (const target::physical_field &field : ut.fields) {
+			const std::string field_name =
+				selfpatch::emit_strtab_entry(out, field.name);
+
+			selfpatch::target_field_desc field_desc{
+				.name_label = field_name,
+				.size = field.size,
+				.offset = field.offset,
+				.alignment = field.alignment,
+			};
+
+			selfpatch::emit_target_field(out, field_desc);
+		}
+
+		selfpatch::emit_pop_section(out);
+
+		selfpatch::emit_target_refs_section(out, ut.hash);
+		selfpatch::emit_target_ref(out, ut.hash);
+		selfpatch::emit_pop_section(out);
+	}
+}
+
+static void emit_ipins(FILE *out)
+{
+	selfpatch::emit_ipins_section(out);
+
+	for (const auto &[h, pin] : ipin::inspect()) {
+		if (pin.status != ipin::state::live)
+			continue;
+
+		if (pin.symbol.empty())
+			pinpoint_fatal(
+				"finish-unit: live ipin is missing field symbol");
+
+		tree asm_name = DECL_ASSEMBLER_NAME(pin.calculator);
+
+		if (!asm_name || TREE_CODE(asm_name) != IDENTIFIER_NODE)
+			pinpoint_fatal(
+				"finish-unit: calculator has no assembler name");
+
+		selfpatch::ipin_desc desc{
+			.addr_expr = pin.symbol,
+			.size = ipin::kind_size_bytes(pin.patch_kind),
+			.calculator_symbol = IDENTIFIER_POINTER(asm_name),
+		};
+
+		selfpatch::emit_ipin(out, desc);
+	}
+
+	selfpatch::emit_pop_section(out);
+}
+
+static void emit_dpins(FILE *out)
+{
+	selfpatch::emit_dpins_section(out);
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
+			const target *t = target::inspect(c.target);
+			if (!t)
+				pinpoint_fatal(
+					"finish-unit: data pin does not refer to target type");
+
+			selfpatch::dpin_desc desc{
+				.addr_expr =
+					add_offset_expr(pin.symbol, c.offset),
+				.target_ref_symbol =
+					selfpatch::target_ref_symbol(t->hash),
+			};
+
+			selfpatch::emit_dpin(out, desc);
+		}
+	}
+
+	selfpatch::emit_pop_section(out);
+}
+
+static void emit_rpins(FILE *out)
+{
+	selfpatch::emit_rpins_section(out);
+
+	for (const rpin &pin : rpin::inspect()) {
+		tree name = DECL_ASSEMBLER_NAME(pin.refresh_function);
+
+		if (!name || TREE_CODE(name) != IDENTIFIER_NODE)
+			pinpoint_fatal(
+				"finish-unit: refresh function has no assembler name");
+
+		selfpatch::rpin_desc desc{
+			.addr_expr = add_offset_expr(pin.object_symbol,
+						     pin.original_offset),
+			.size = pin.patch_size,
+			.refresh_symbol = IDENTIFIER_POINTER(name),
+		};
+
+		selfpatch::emit_rpin(out, desc);
+	}
+
+	selfpatch::emit_pop_section(out);
+}
+
+void on_finish_unit(void *plugin_data, void *user_data)
+{
+	FILE *out = asm_out_file;
+
+	selfpatch::emit_comment(out, "SPSLR runtime metadata");
+
+	emit_targets(out);
+	emit_ipins(out);
+	emit_dpins(out);
+	emit_rpins(out);
+}
diff --git a/scripts/gcc-plugins/pinpoint/on_register_attributes.c b/scripts/gcc-plugins/pinpoint/on_register_attributes.c
new file mode 100644
index 000000000000..db19ee7b6017
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/on_register_attributes.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <tree-pass.h>
+#include <diagnostic.h>
+#include <ggc.h>
+#include <stringpool.h>
+#include <attribs.h>
+
+#include "pinpoint.h"
+#include "passes.h"
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
+/*
+ * __attribute__((spslr)) marks a record type as a randomization target.
+ */
+
+static struct attribute_spec spslr_attribute = {
+	SPSLR_ATTRIBUTE,       0,   0, false, false, false, false,
+	check_spslr_attribute, NULL
+};
+
+static tree check_no_spslr_attribute(tree *node, tree name, tree args,
+				     int flags, bool *no_add_attrs)
+{
+	if (!node || !*node || TREE_CODE(*node) != RECORD_TYPE) {
+		*no_add_attrs = true;
+		pinpoint_debug(NO_SPSLR_ATTRIBUTE
+			       " attribute only applies to record types");
+	}
+
+	return NULL_TREE;
+}
+
+/*
+ * __attribute__((no_spslr)) marks a record type to not be a
+ * randomization target.
+ */
+
+static struct attribute_spec no_spslr_attribute = {
+	NO_SPSLR_ATTRIBUTE,	  0,   0, false, false, false, false,
+	check_no_spslr_attribute, NULL
+};
+
+void on_register_attributes(void *plugin_data, void *user_data)
+{
+	register_attribute(&spslr_attribute);
+	register_attribute(&no_spslr_attribute);
+}
diff --git a/scripts/gcc-plugins/pinpoint/on_start_unit.c b/scripts/gcc-plugins/pinpoint/on_start_unit.c
new file mode 100644
index 000000000000..7e8c4753b4a0
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/on_start_unit.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <tree-pass.h>
+
+#include "passes.h"
+#include "ipin_registry.h"
+#include "dpin_registry.h"
+#include "target_registry.h"
+
+void on_start_unit(void *plugin_data, void *user_data)
+{
+	target::reset();
+	dpin::reset();
+	ipin::reset();
+}
diff --git a/scripts/gcc-plugins/pinpoint/passes.h b/scripts/gcc-plugins/pinpoint/passes.h
new file mode 100644
index 000000000000..7c5c0c01a854
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/passes.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PINPOINT_PASSES_H
+#define PINPOINT_PASSES_H
+
+void on_register_attributes(void *plugin_data, void *user_data);
+void on_finish_type(void *plugin_data, void *user_data);
+void on_start_unit(void *plugin_data, void *user_data);
+void on_finish_unit(void *plugin_data, void *user_data);
+
+struct deferred_pin_pass : simple_ipa_opt_pass {
+	deferred_pin_pass(gcc::context *);
+	unsigned int execute(function *) override;
+};
+
+struct rtl_ipin_survival_scan_pass : rtl_opt_pass {
+	rtl_ipin_survival_scan_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
+
+#endif
diff --git a/scripts/gcc-plugins/pinpoint/pinpoint.c b/scripts/gcc-plugins/pinpoint/pinpoint.c
new file mode 100644
index 000000000000..93968745cd8a
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/pinpoint.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <plugin-version.h>
+#include <tree.h>
+#include <tree-pass.h>
+#include <gimple.h>
+#include <diagnostic.h>
+#include <ggc.h>
+
+#include <string>
+
+#include "pinpoint.h"
+#include "passes.h"
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
+	register_callback(plugin_info->base_name, PLUGIN_START_UNIT,
+			  on_start_unit, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_ATTRIBUTES,
+			  on_register_attributes, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_TYPE,
+			  on_finish_type, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_GGC_MARKING,
+			  pinpoint_gc_preserve, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_UNIT,
+			  on_finish_unit, NULL);
+
+	struct register_pass_info deferred_pin_pass_info;
+	deferred_pin_pass_info.pass = new deferred_pin_pass(nullptr);
+	deferred_pin_pass_info.ref_pass_instance_number = 1;
+	deferred_pin_pass_info.reference_pass_name = "deferred-cst-barrier";
+	deferred_pin_pass_info.pos_op = PASS_POS_INSERT_BEFORE;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &deferred_pin_pass_info);
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
+	return 0;
+}
diff --git a/scripts/gcc-plugins/pinpoint/pinpoint.h b/scripts/gcc-plugins/pinpoint/pinpoint.h
new file mode 100644
index 000000000000..52226d9e3cce
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/pinpoint.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PINPOINT_H
+#define PINPOINT_H
+
+#include <cstdio>
+
+#define SPSLR_ATTRIBUTE "spslr"
+#define NO_SPSLR_ATTRIBUTE "no_spslr"
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
+
+#endif
diff --git a/scripts/gcc-plugins/pinpoint/rpin_registry.c b/scripts/gcc-plugins/pinpoint/rpin_registry.c
new file mode 100644
index 000000000000..a16c114bc9aa
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/rpin_registry.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <diagnostic.h>
+#include <ggc.h>
+
+#include "pinpoint.h"
+#include "rpin_registry.h"
+
+static std::list<rpin> rpins;
+
+PINPOINT_GC_PRESERVE_CALLBACK()
+{
+	for (const rpin &pin : rpins)
+		PINPOINT_GC_MARK_TREE(pin.refresh_function);
+}
+
+void rpin::reset()
+{
+	rpins.clear();
+}
+
+const std::list<rpin> &rpin::inspect()
+{
+	return rpins;
+}
+
+void rpin::add(tree function, tree object, std::size_t offset, std::size_t size)
+{
+	tree name = DECL_ASSEMBLER_NAME(object);
+
+	if (!name || TREE_CODE(name) != IDENTIFIER_NODE)
+		pinpoint_fatal("rpin: static object has no assembler name");
+
+	if (!size)
+		pinpoint_fatal("rpin: refresh destination has zero size");
+
+	DECL_PRESERVE_P(object) = 1;
+
+	rpins.push_back(rpin{ .refresh_function = function,
+			      .object_symbol = IDENTIFIER_POINTER(name),
+			      .original_offset = offset,
+			      .patch_size = size });
+}
diff --git a/scripts/gcc-plugins/pinpoint/rpin_registry.h b/scripts/gcc-plugins/pinpoint/rpin_registry.h
new file mode 100644
index 000000000000..801ae8b377c5
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/rpin_registry.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PINPOINT_RPIN_REGISTRY_H
+#define PINPOINT_RPIN_REGISTRY_H
+
+#include <cstddef>
+#include <list>
+#include <string>
+
+struct rpin {
+	tree refresh_function = NULL_TREE;
+	std::string object_symbol;
+	std::size_t original_offset = 0;
+	std::size_t patch_size = 0;
+
+	static void add(tree function, tree object, std::size_t offset,
+			std::size_t size);
+	static const std::list<rpin> &inspect();
+	static void reset();
+};
+
+#endif
diff --git a/scripts/gcc-plugins/pinpoint/rtl_ipin_survival_scan_pass.c b/scripts/gcc-plugins/pinpoint/rtl_ipin_survival_scan_pass.c
new file mode 100644
index 000000000000..e401893e658d
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/rtl_ipin_survival_scan_pass.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <tree-pass.h>
+#include <rtl.h>
+#include <memmodel.h>
+#include <emit-rtl.h>
+#include <diagnostic.h>
+#include <ggc.h>
+
+#include "pinpoint.h"
+#include "passes.h"
+#include "ipin_registry.h"
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
diff --git a/scripts/gcc-plugins/pinpoint/serialize.c b/scripts/gcc-plugins/pinpoint/serialize.c
new file mode 100644
index 000000000000..4a9157f86302
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/serialize.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <cctype>
+
+#include "serialize.h"
+
+namespace selfpatch
+{
+
+namespace
+{
+
+constexpr std::string_view section_targets = "spslr_targets";
+constexpr std::string_view section_target_refs = "spslr_target_refs";
+constexpr std::string_view section_target_layouts = "spslr_target_layouts";
+constexpr std::string_view section_ipins = "spslr_ipins";
+constexpr std::string_view section_dpins = "spslr_dpins";
+constexpr std::string_view section_rpins = "spslr_rpins";
+constexpr std::string_view section_strtab = "spslr_strtab";
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
+void emit_push_section(FILE *out, std::string_view name, const char *flags)
+{
+	/* Future implementation should differentiate between module and host
+	 * section permissions. Module relocations may cause DT_TEXTREL issues
+	 * if the metadata sections are read-only.  */
+	std::fprintf(out, ".pushsection %.*s,\"%s\",@progbits\n",
+		     static_cast<int>(name.size()), name.data(), flags);
+}
+
+void emit_push_comdat_section(FILE *out, std::string_view name,
+			      std::string_view group_symbol, const char *flags)
+{
+	/* Future implementation should differentiate between module and host
+	 * section permissions. Module relocations may cause DT_TEXTREL issues
+	 * if the metadata sections are read-only.  */
+	std::fprintf(out, ".pushsection %.*s,\"%sG\",@progbits,%.*s,comdat\n",
+		     static_cast<int>(name.size()), name.data(), flags,
+		     static_cast<int>(group_symbol.size()),
+		     group_symbol.data());
+}
+
+void emit_pop_section(FILE *out)
+{
+	std::fprintf(out, ".popsection\n");
+}
+
+void emit_targets_section(FILE *out, const std::string &hash)
+{
+	emit_push_comdat_section(out, section_targets,
+				 comdat_target_symbol(hash), "aw");
+}
+
+void emit_target_refs_section(FILE *out, const std::string &hash)
+{
+	emit_push_comdat_section(out, section_target_refs,
+				 comdat_target_ref_symbol(hash), "aw");
+}
+
+void emit_target_layouts_section(FILE *out, const std::string &hash)
+{
+	emit_push_comdat_section(out, section_target_layouts,
+				 comdat_target_symbol(hash), "aw");
+}
+
+void emit_ipins_section(FILE *out)
+{
+	emit_push_section(out, section_ipins, "aw");
+}
+
+void emit_dpins_section(FILE *out)
+{
+	emit_push_section(out, section_dpins, "aw");
+}
+
+void emit_rpins_section(FILE *out)
+{
+	emit_push_section(out, section_rpins, "aw");
+}
+
+void emit_strtab_section(FILE *out)
+{
+	std::fprintf(out, ".pushsection %.*s,\"aMS\",@progbits,1\n",
+		     static_cast<int>(section_strtab.size()),
+		     section_strtab.data());
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
+void emit_target(FILE *out, const target_desc &target)
+{
+	emit_quad_symbol(out, target.hash_label);
+	emit_quad_symbol(out, target.name_label);
+	emit_quad_symbol(out, target.layout_symbol);
+}
+
+void emit_target_ref(FILE *out, const std::string &hash)
+{
+	emit_hidden_global_label(out, target_ref_symbol(hash));
+	emit_quad_symbol(out, target_symbol(hash));
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
+}
+
+void emit_ipin(FILE *out, const ipin_desc &ipin)
+{
+	emit_quad_expr(out, ipin.addr_expr);
+	emit_quad(out, ipin.size);
+	emit_quad_symbol(out, ipin.calculator_symbol);
+}
+
+void emit_dpin(FILE *out, const dpin_desc &dpin)
+{
+	emit_quad_expr(out, dpin.addr_expr);
+	emit_quad_symbol(out, dpin.target_ref_symbol);
+}
+
+void emit_rpin(FILE *out, const rpin_desc &rpin)
+{
+	emit_quad_expr(out, rpin.addr_expr);
+	emit_quad(out, rpin.size);
+	emit_quad_symbol(out, rpin.refresh_symbol);
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
+std::string comdat_target_symbol(const std::string &hash)
+{
+	return "__comdat_spslr_target_" + hash;
+}
+
+std::string comdat_target_ref_symbol(const std::string &hash)
+{
+	return "__comdat_spslr_target_ref_" + hash;
+}
+
+std::string target_symbol(const std::string &hash)
+{
+	return "__spslr_target_" + hash;
+}
+
+std::string target_ref_symbol(const std::string &hash)
+{
+	return "__spslr_target_ref_" + hash;
+}
+
+std::string target_layout_symbol(const std::string &hash)
+{
+	return "__spslr_target_layout_" + hash;
+}
+
+} // namespace selfpatch
diff --git a/scripts/gcc-plugins/pinpoint/serialize.h b/scripts/gcc-plugins/pinpoint/serialize.h
new file mode 100644
index 000000000000..6a9c595b2441
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/serialize.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PINPOINT_SERIALIZE_H
+#define PINPOINT_SERIALIZE_H
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
+/*
+ * Entry point is:
+ *   __start_spslr_targets
+ *   __stop_spslr_targets
+ *   __start_spslr_target_refs
+ *   __stop_spslr_target_refs
+ *   __start_spslr_ipins
+ *   __stop_spslr_ipins
+ *   __start_spslr_dpins
+ *   __stop_spslr_dpins
+ *   __start_spslr_rpins
+ *   __stop_spslr_rpins
+ */
+
+struct target_desc {
+	std::string hash_label;
+	std::string name_label;
+	std::string layout_symbol;
+};
+
+struct target_ref_desc {
+	std::string ref_label;
+	std::string target_label;
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
+};
+
+struct ipin_desc {
+	std::string addr_expr;
+	std::size_t size = 0;
+	std::string calculator_symbol;
+};
+
+struct dpin_desc {
+	std::string addr_expr;
+	std::string target_ref_symbol;
+};
+
+struct rpin_desc {
+	std::string addr_expr;
+	std::size_t size = 0;
+	std::string refresh_symbol;
+};
+
+void emit_comment(FILE *out, std::string_view text);
+
+void emit_push_section(FILE *out, std::string_view name);
+void emit_push_comdat_section(FILE *out, std::string_view name,
+			      std::string_view group_symbol);
+void emit_pop_section(FILE *out);
+
+void emit_targets_section(FILE *out, const std::string &hash);
+void emit_target_refs_section(FILE *out, const std::string &hash);
+void emit_target_layouts_section(FILE *out, const std::string &hash);
+void emit_ipins_section(FILE *out);
+void emit_dpins_section(FILE *out);
+void emit_rpins_section(FILE *out);
+void emit_strtab_section(FILE *out);
+
+void emit_label(FILE *out, std::string_view label);
+void emit_hidden_global_label(FILE *out, std::string_view label);
+
+std::string make_local_label(std::string_view stem);
+std::string emit_strtab_entry(FILE *out, std::string_view value);
+
+void emit_target(FILE *out, const target_desc &target);
+void emit_target_ref(FILE *out, const std::string &hash);
+void emit_target_layout(FILE *out, const target_layout_desc &layout);
+void emit_target_field(FILE *out, const target_field_desc &field);
+void emit_ipin(FILE *out, const ipin_desc &ipin);
+void emit_dpin(FILE *out, const dpin_desc &dpin);
+void emit_rpin(FILE *out, const rpin_desc &rpin);
+
+void emit_quad(FILE *out, std::size_t value);
+void emit_quad_symbol(FILE *out, std::string_view symbol);
+void emit_quad_expr(FILE *out, std::string_view expr);
+void emit_bytes(FILE *out, const void *data, std::size_t size);
+void emit_c_string(FILE *out, std::string_view value);
+
+std::string comdat_target_symbol(const std::string &hash);
+std::string comdat_target_ref_symbol(const std::string &hash);
+std::string target_symbol(const std::string &hash);
+std::string target_ref_symbol(const std::string &hash);
+std::string target_layout_symbol(const std::string &hash);
+
+} // namespace selfpatch
+
+#endif
diff --git a/scripts/gcc-plugins/pinpoint/target_registry.c b/scripts/gcc-plugins/pinpoint/target_registry.c
new file mode 100644
index 000000000000..92a1bd0370ac
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/target_registry.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <gcc-plugin.h>
+#include <tree.h>
+#include <diagnostic.h>
+#include <ggc.h>
+#include <stringpool.h>
+#include <attribs.h>
+
+#include <algorithm>
+#include <map>
+#include <set>
+#include <vector>
+
+#include "pinpoint.h"
+#include "target_registry.h"
+#include "layout_hash.h"
+
+static std::map<tree, target> validated_targets;
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
+/* For bit fields, only the representative containers are randomized.  */
+static tree field_layout_decl(tree field)
+{
+	if (!field || TREE_CODE(field) != FIELD_DECL)
+		return NULL_TREE;
+
+	if (!DECL_BIT_FIELD(field))
+		return field;
+
+	tree repr = DECL_BIT_FIELD_REPRESENTATIVE(field);
+	if (repr)
+		return repr;
+
+	/*
+	 * An unnamed bit-field may merely reserve bits or impose an
+	 * alignment boundary:
+	 *
+	 *     unsigned int : 3;
+	 *     unsigned int : 0;
+	 *
+	 * It cannot be referenced and therefore needs no field-index entry.
+	 */
+	if (!DECL_NAME(field))
+		return NULL_TREE;
+
+	std::string name = target::field_name(field);
+	pinpoint_fatal("bit-field \"%s\" has no representative", name.c_str());
+}
+
+static void build_physical_fields(tree type, target &vt)
+{
+	vt.fields.clear();
+
+	iterate_fields(type, [&](tree field) {
+		tree layout_field = field_layout_decl(field);
+		if (!layout_field)
+			return;
+
+		/* Take name of field itself, not e.g. the representative
+		   of a bit field.  */
+		std::string name = target::field_name(field);
+
+		auto existing = vt.field_indices.find(layout_field);
+		if (existing != vt.field_indices.end()) {
+			vt.field_indices[field] = existing->second;
+
+			target::physical_field &cf =
+				vt.fields[existing->second];
+			cf.name = cf.name + "+" + name;
+			return;
+		}
+
+		std::size_t off = target::field_offset(layout_field);
+		std::size_t sz = target::field_size(layout_field);
+		std::size_t align = target::field_alignment(layout_field);
+
+		if (!vt.fields.empty()) {
+			const target::physical_field &last = vt.fields.back();
+
+			if (off < last.offset)
+				pinpoint_fatal(
+					"build_physical_fields: "
+					"invalid field order in target \"%s\"",
+					target::qualified_name(type).c_str());
+
+			bool overlap = (off < last.offset + last.size);
+			bool zero_overlap = (off == last.offset &&
+					     (sz == 0 || last.size == 0));
+
+			if (overlap && !zero_overlap)
+				pinpoint_fatal(
+					"build_physical_fields: "
+					"overlapping non-fixed fields in target \"%s\": \"%s\" and \"%s\"",
+					target::qualified_name(type).c_str(),
+					last.name.c_str(), name.c_str());
+		}
+
+		size_t idx = vt.fields.size();
+
+		target::physical_field desc{ .name = name,
+					     .offset = off,
+					     .size = sz,
+					     .alignment = align };
+
+		vt.fields.push_back(desc);
+
+		vt.field_indices[layout_field] = idx;
+		vt.field_indices[field] = idx;
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
+	auto new_vt = validated_targets.emplace(type, target{});
+	if (!new_vt.second)
+		pinpoint_fatal(
+			"remember_target failed to log new validated target");
+
+	target &vt = new_vt.first->second;
+
+	vt.qname = target::qualified_name(type);
+	vt.size = target::type_size(type);
+
+	build_physical_fields(type, vt);
+
+	vt.hash = compute_layout_hash(vt.qname, vt.size, vt.fields);
+}
+
+bool target::is_validated_target(tree type)
+{
+	type = main_variant(type);
+	return type && validated_targets.find(type) != validated_targets.end();
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
+std::size_t target::field_index(tree field_decl)
+{
+	tree layout_field = field_layout_decl(field_decl);
+	tree type = from_field(layout_field);
+	const target *info = inspect(type);
+
+	if (!info)
+		pinpoint_fatal(
+			"target::field_index: field target was not registered");
+
+	auto it = info->field_indices.find(layout_field);
+	if (it == info->field_indices.end())
+		pinpoint_fatal("target::field_index: field was not registered");
+
+	return it->second;
+}
+
+static bool is_function_pointer(tree type)
+{
+	if (!type || TREE_CODE(type) != POINTER_TYPE)
+		return false;
+
+	tree pointee_type = TREE_TYPE(type);
+
+	/* If expanded to C++ later, may need to consider METHOD_TYPE.  */
+	return pointee_type && TREE_CODE(pointee_type) == FUNCTION_TYPE;
+}
+
+static bool is_function_pointer_only_record(tree type)
+{
+	type = target::main_variant(type);
+
+	if (!type || !COMPLETE_TYPE_P(type))
+		return false;
+
+	bool saw_field = false;
+
+	for (tree field = TYPE_FIELDS(type); field; field = DECL_CHAIN(field)) {
+		if (TREE_CODE(field) != FIELD_DECL)
+			continue;
+
+		saw_field = true;
+
+		/* Technically, pure-ops structs may have members that
+		   are themselves pure-ops structs. However, handling
+		   those correctly may require further attention, so
+		   do not make them targets yet.  */
+
+		if (!is_function_pointer(TREE_TYPE(field)))
+			return false;
+	}
+
+	/* Don't classify an empty struct as an SPSLR target. */
+	return saw_field;
+}
+
+bool target::is_target(tree type)
+{
+	type = main_variant(type);
+
+	if (!type || TREE_CODE(type) != RECORD_TYPE)
+		return false;
+
+	tree attrs = TYPE_ATTRIBUTES(type);
+
+	/* Explicit opt-out always wins. */
+	if (lookup_attribute(NO_SPSLR_ATTRIBUTE, attrs))
+		return false;
+
+	/* Explicit opt-in. */
+	if (lookup_attribute(SPSLR_ATTRIBUTE, attrs))
+		return true;
+
+	/* Structs consisting only of function pointers are implicit
+	   targets.  */
+	if (is_function_pointer_only_record(type))
+		return true;
+
+	return false;
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
+std::size_t target::type_size(tree type)
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
+	std::string sname = qualified_name(DECL_CONTEXT(field_decl));
+	std::string fname = field_name(field_decl);
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
+			"target::field_size was unable to fetch bit size of \"%s.%s\"",
+			sname.c_str(), fname.c_str());
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
+const std::map<tree, target> &target::inspect()
+{
+	return validated_targets;
+}
+
+const target *target::inspect(tree t)
+{
+	auto it = validated_targets.find(t);
+	return it == validated_targets.end() ? nullptr : &it->second;
+}
+
+void target::reset()
+{
+	validated_targets.clear();
+}
diff --git a/scripts/gcc-plugins/pinpoint/target_registry.h b/scripts/gcc-plugins/pinpoint/target_registry.h
new file mode 100644
index 000000000000..be159a4a032d
--- /dev/null
+++ b/scripts/gcc-plugins/pinpoint/target_registry.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef PINPOINT_TARGET_REGISTRY_H
+#define PINPOINT_TARGET_REGISTRY_H
+
+#include <cstddef>
+#include <functional>
+#include <string>
+#include <vector>
+#include <map>
+#include <array>
+
+struct target {
+	struct physical_field {
+		std::string name{};
+		std::size_t offset{};
+		std::size_t size{};
+		std::size_t alignment{};
+	};
+
+	std::string qname; // includes context
+	std::size_t size;
+	std::vector<physical_field> fields{};
+	std::map<tree, std::size_t> field_indices{};
+	std::string hash{};
+
+	static tree main_variant(tree type);
+	static tree from_field(tree field_decl);
+	static std::size_t field_index(tree field_decl);
+
+	static bool is_target(tree type);
+
+	static std::string name(tree type);
+	static std::vector<std::string> context_chain(tree type);
+	static std::string qualified_name(tree type);
+
+	static std::size_t type_size(tree type);
+
+	static std::string field_name(tree field_decl);
+	static std::size_t field_offset(tree field_decl);
+	static bool field_has_size(tree field_decl);
+	static std::size_t field_size(tree field_decl);
+	static std::size_t field_alignment(tree field_decl);
+	static bool field_is_bitfield(tree field_decl);
+
+	static bool component_ref(tree ref, tree *field_decl);
+
+	static void validate(tree type);
+
+	static bool is_validated_target(tree type);
+
+	/* Inspect the state of one or more targets */
+	static const std::map<tree, target> &inspect();
+	static const target *inspect(tree t);
+
+	static void reset();
+};
+
+#endif
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 81c81ad983ad..9348e1f50abf 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -331,10 +331,17 @@ choice
 		  groups of members. It will further not randomize bitfields
 		  in structures. This reduces the performance hit of RANDSTRUCT
 		  at the cost of weakened randomization.
+
+	config SPSLR
+		bool "Selfpatch SLR prototype"
+		depends on GCC_PLUGINS
+		depends on X86_64
+		help
+		  Experimental boot-time structure layout randomization.
 endchoice
 
 config RANDSTRUCT
-	def_bool !RANDSTRUCT_NONE
+	def_bool !RANDSTRUCT_NONE && !SPSLR
 
 config GCC_PLUGIN_RANDSTRUCT
 	def_bool GCC_PLUGINS && RANDSTRUCT
-- 
2.43.0

