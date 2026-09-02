Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA645BD4B
	for <linux-hardening@vger.kernel.org>; Wed,  2 Sep 2026 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392035; cv=none; b=NylWAfjrE0GG9dEzISP0BIqkAw2n6c2Yn3PeA/GBFJ53XoTvnYv0uRNGZSHntPc0KlbDQ9r579eFTUwF5NwmaPNiLfxUSKb4NXT6Kf54d/Hr4FKEHiD55+qC2MFbYS0dX41y4n3XmBx9lgh534V2tzsgltVvM4ub0gzdLUjYzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392035; c=relaxed/simple;
	bh=ceqf1fq+wV+vKOfz631SJu9+oTCKbUgRro2cFJzIrYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tq/JV6LOKiqa4u0nFvBbD1JWXWgFmlEm5StkzD3b7qnvfpk9ahWwLA1Jnien/ZNNHtiJS6jfRIwMPpJRAkMvZ77tZYO14hHK3qDgfHRhPycscCahA90WHx6vXpwFydbTUWy6F9F4fu8Z4xUDy3rehuv8zuY3WAkvu78l8C/LKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzRKWPtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzRKWPtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CF31F00A3D;
	Wed,  2 Sep 2026 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788392029;
	bh=G5yE3EECuA1PnvUBoxwYY0HntfFobErRu2zWM6rawsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MzRKWPtYNcZTUHcA/22/R+wx9eI5SEA3yHoYRaPIqn/+faUti44YCsHAvbpA9mIv/
	 Kkb0ZWphOQgLQn6TThy1WEKkOoiSYBCvLhjeT8sQFQf1zcWjx12Pxc35PTs4TSMDc6
	 y4Nj2iusp1NTDIKw6UAGEjCuzugUD/qzBtqHJdG+FapUteW0LtMmNdCduT92f7zbPg
	 jifbBKPTElExBq97qMry67szQQlSxCW3nIoJH4sugPSZaO3TwH7dOeOh6nfKSMimRe
	 KbVvYa9o8vKQu4efbY0qo9FcU1xwUNqcskApNBIcPTmXOLC4Hq7uP3Cgvj4q9CLKHH
	 Vmi7IKAJA9dVA==
From: Kees Cook <kees@kernel.org>
To: York Jasper Niebuhr <yjn@yjn-systems.com>
Cc: Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	franzen@sec.in.tum.de,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] gcc-plugins: pinpoint: use quoted includes for internal headers
Date: Wed,  2 Sep 2026 16:33:41 -0700
Message-Id: <20260902233349.1996922-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902233338.i.375-kees@kernel.org>
References: <20260902233338.i.375-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17874; i=kees@kernel.org; h=from:subject; bh=ceqf1fq+wV+vKOfz631SJu9+oTCKbUgRro2cFJzIrYM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkzNoXtE/mY1bG4e8U6vXKrpVLOL4TdtrRO6Lzi+KG/d l+r2gepjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIloRTL8DxDX7TjZMlWTZWNd dljK5L1XF2+q3FcqOb+EoSr0vzCnHCPDSQX5C2V2Gv3FfRfYpPbc+O24f0aB0r9Pu+SiS2yeXLj ACQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Pinpoint includes its own headers with angle brackets:

	#include <pinpoint.h>
	#include <passes.h>

Angle brackets search only the -I paths. This happens to work because
plugin_cxxflags carries -I $(obj), and for an in-tree build $(obj) is
the same directory as $(src). For an O= build it is not, and the plugin
fails to compile:

  scripts/gcc-plugins/asm_offset_pass.c:3:10: fatal error: pinpoint.h:
    No such file or directory

That -I $(obj) exists for randstruct's *generated* randomize_layout_seed.h,
which really does live in the build tree; pinpoint's headers are ordinary
source files.

Switch the 19 headers pinpoint owns to quoted includes, which search the
including file's directory first and therefore need no -I at all. GCC's
own plugin headers (tree.h, ssa.h, ...) keep angle brackets.

Build tested ARCH=x86_64 defconfig+CONFIG_SPSLR=y with the patched
GCC 16.1.0 / GAS 2.46.1 toolchain: scripts/gcc-plugins/ now builds with
O= (out-of-tree), which it did not before. A full kernel build still
needs the following patch, for an unrelated reason.

Assisted-by: Claude:claude-opus-5[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 scripts/gcc-plugins/asm_offset_pass.c            |  6 +++---
 scripts/gcc-plugins/dpin_registry.c              |  6 +++---
 scripts/gcc-plugins/dpin_registry.h              |  2 +-
 scripts/gcc-plugins/ipin_registry.c              |  6 +++---
 scripts/gcc-plugins/ipin_registry.h              |  6 +++---
 scripts/gcc-plugins/layout_hash.c                |  6 +++---
 scripts/gcc-plugins/layout_hash.h                |  2 +-
 scripts/gcc-plugins/on_finish_decl.c             |  4 ++--
 scripts/gcc-plugins/on_finish_type.c             |  4 ++--
 scripts/gcc-plugins/on_finish_unit.c             | 16 ++++++++--------
 scripts/gcc-plugins/on_preserve_component_ref.c  | 10 +++++-----
 scripts/gcc-plugins/on_register_attributes.c     |  4 ++--
 scripts/gcc-plugins/on_start_unit.c              |  8 ++++----
 scripts/gcc-plugins/passes.h                     |  4 ++--
 scripts/gcc-plugins/pinpoint.c                   |  8 ++++----
 scripts/gcc-plugins/pinpoint.h                   |  4 ++--
 .../gcc-plugins/rtl_ipin_survival_scan_pass.c    |  8 ++++----
 scripts/gcc-plugins/safe-attribs.h               |  2 +-
 scripts/gcc-plugins/safe-diagnostic.h            |  2 +-
 scripts/gcc-plugins/safe-ggc.h                   |  2 +-
 scripts/gcc-plugins/safe-gimple.h                |  4 ++--
 scripts/gcc-plugins/safe-input.h                 |  2 +-
 scripts/gcc-plugins/safe-langhooks.h             |  2 +-
 scripts/gcc-plugins/safe-md5.h                   |  2 +-
 scripts/gcc-plugins/safe-output.h                |  2 +-
 scripts/gcc-plugins/safe-plugin-version.h        |  2 +-
 scripts/gcc-plugins/safe-rtl.h                   |  2 +-
 scripts/gcc-plugins/safe-tree.h                  |  2 +-
 scripts/gcc-plugins/separate_offset_pass.c       |  8 ++++----
 scripts/gcc-plugins/target_hash_builtin_pass.c   | 12 ++++++------
 scripts/gcc-plugins/target_registry.c            | 10 +++++-----
 scripts/gcc-plugins/target_registry.h            |  2 +-
 32 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/scripts/gcc-plugins/asm_offset_pass.c b/scripts/gcc-plugins/asm_offset_pass.c
index 5a1be25f1f2c..1e9b864e6df2 100644
--- a/scripts/gcc-plugins/asm_offset_pass.c
+++ b/scripts/gcc-plugins/asm_offset_pass.c
@@ -1,8 +1,8 @@
 #include <unordered_map>
 
-#include <pinpoint.h>
-#include <passes.h>
-#include <ipin_registry.h>
+#include "pinpoint.h"
+#include "passes.h"
+#include "ipin_registry.h"
 
 /*
  * gsi_replace() changes the statement, but SSA names that were defined by the
diff --git a/scripts/gcc-plugins/dpin_registry.c b/scripts/gcc-plugins/dpin_registry.c
index 415f7befe296..1c24e1049fa9 100644
--- a/scripts/gcc-plugins/dpin_registry.c
+++ b/scripts/gcc-plugins/dpin_registry.c
@@ -1,9 +1,9 @@
 #include <string>
 #include <unordered_set>
 
-#include <pinpoint.h>
-#include <dpin_registry.h>
-#include <target_registry.h>
+#include "pinpoint.h"
+#include "dpin_registry.h"
+#include "target_registry.h"
 
 static std::list<dpin> pins;
 static std::unordered_set<std::string> seen_dpin_symbols;
diff --git a/scripts/gcc-plugins/dpin_registry.h b/scripts/gcc-plugins/dpin_registry.h
index 500535ce0bf2..35eebde04fa2 100644
--- a/scripts/gcc-plugins/dpin_registry.h
+++ b/scripts/gcc-plugins/dpin_registry.h
@@ -4,7 +4,7 @@
 #include <list>
 #include <string>
 
-#include <safe-tree.h>
+#include "safe-tree.h"
 
 struct dpin {
 	struct component {
diff --git a/scripts/gcc-plugins/ipin_registry.c b/scripts/gcc-plugins/ipin_registry.c
index 41e2d525a08f..533eab7e7ebd 100644
--- a/scripts/gcc-plugins/ipin_registry.c
+++ b/scripts/gcc-plugins/ipin_registry.c
@@ -1,9 +1,9 @@
 #include <cstring>
 #include <algorithm>
 
-#include <pinpoint.h>
-#include <ipin_registry.h>
-#include <target_registry.h>
+#include "pinpoint.h"
+#include "ipin_registry.h"
+#include "target_registry.h"
 
 #define PINPOINT_SEPARATOR "__spslr_offsetof"
 #define PINPOINT_IPIN_MARKER "spslr_ipin_marker"
diff --git a/scripts/gcc-plugins/ipin_registry.h b/scripts/gcc-plugins/ipin_registry.h
index 0fff090ed6e7..528b877f06da 100644
--- a/scripts/gcc-plugins/ipin_registry.h
+++ b/scripts/gcc-plugins/ipin_registry.h
@@ -4,9 +4,9 @@
 #include <limits>
 #include <map>
 
-#include <safe-tree.h>
-#include <safe-gimple.h>
-#include <safe-rtl.h>
+#include "safe-tree.h"
+#include "safe-gimple.h"
+#include "safe-rtl.h"
 
 struct ipin {
 	enum class state { pending, separator, pin, live };
diff --git a/scripts/gcc-plugins/layout_hash.c b/scripts/gcc-plugins/layout_hash.c
index 6200bd037f54..de939c6d10c0 100644
--- a/scripts/gcc-plugins/layout_hash.c
+++ b/scripts/gcc-plugins/layout_hash.c
@@ -2,10 +2,10 @@
 #include <cstring>
 #include <string>
 
-#include <layout_hash.h>
-#include <target_registry.h>
+#include "layout_hash.h"
+#include "target_registry.h"
 
-#include <safe-md5.h>
+#include "safe-md5.h"
 
 namespace
 {
diff --git a/scripts/gcc-plugins/layout_hash.h b/scripts/gcc-plugins/layout_hash.h
index b4b660bd0b96..213654f77043 100644
--- a/scripts/gcc-plugins/layout_hash.h
+++ b/scripts/gcc-plugins/layout_hash.h
@@ -3,6 +3,6 @@
 #include <array>
 #include <cstddef>
 
-#include <safe-tree.h>
+#include "safe-tree.h"
 
 std::array<std::byte, 16> compute_layout_hash(tree target_type);
diff --git a/scripts/gcc-plugins/on_finish_decl.c b/scripts/gcc-plugins/on_finish_decl.c
index 6781d2516e75..c451b0156830 100644
--- a/scripts/gcc-plugins/on_finish_decl.c
+++ b/scripts/gcc-plugins/on_finish_decl.c
@@ -1,5 +1,5 @@
-#include <passes.h>
-#include <dpin_registry.h>
+#include "passes.h"
+#include "dpin_registry.h"
 
 void on_finish_decl(void *plugin_data, void *user_data)
 {
diff --git a/scripts/gcc-plugins/on_finish_type.c b/scripts/gcc-plugins/on_finish_type.c
index 023470f8cc8c..0722931a9532 100644
--- a/scripts/gcc-plugins/on_finish_type.c
+++ b/scripts/gcc-plugins/on_finish_type.c
@@ -1,5 +1,5 @@
-#include <passes.h>
-#include <target_registry.h>
+#include "passes.h"
+#include "target_registry.h"
 
 void on_finish_type(void *plugin_data, void *user_data)
 {
diff --git a/scripts/gcc-plugins/on_finish_unit.c b/scripts/gcc-plugins/on_finish_unit.c
index 5229dbb53c52..3504ad0b8482 100644
--- a/scripts/gcc-plugins/on_finish_unit.c
+++ b/scripts/gcc-plugins/on_finish_unit.c
@@ -4,14 +4,14 @@
 #include <algorithm>
 #include <unordered_map>
 
-#include <pinpoint.h>
-#include <passes.h>
-#include <ipin_registry.h>
-#include <dpin_registry.h>
-#include <serialize.h>
-#include <target_registry.h>
-#include <safe-input.h>
-#include <safe-output.h>
+#include "pinpoint.h"
+#include "passes.h"
+#include "ipin_registry.h"
+#include "dpin_registry.h"
+#include "serialize.h"
+#include "target_registry.h"
+#include "safe-input.h"
+#include "safe-output.h"
 
 /*
  * Finish-unit emits the per-compilation-unit metadata into the object asm.
diff --git a/scripts/gcc-plugins/on_preserve_component_ref.c b/scripts/gcc-plugins/on_preserve_component_ref.c
index 133269438914..93e69ab804ec 100644
--- a/scripts/gcc-plugins/on_preserve_component_ref.c
+++ b/scripts/gcc-plugins/on_preserve_component_ref.c
@@ -1,8 +1,8 @@
-#include <pinpoint.h>
-#include <passes.h>
-#include <ipin_registry.h>
-#include <target_registry.h>
-#include <safe-tree.h>
+#include "pinpoint.h"
+#include "passes.h"
+#include "ipin_registry.h"
+#include "target_registry.h"
+#include "safe-tree.h"
 
 static tree materialize_c_rvalue(location_t loc, tree expr)
 {
diff --git a/scripts/gcc-plugins/on_register_attributes.c b/scripts/gcc-plugins/on_register_attributes.c
index 221693a1c465..9e2ae6104d57 100644
--- a/scripts/gcc-plugins/on_register_attributes.c
+++ b/scripts/gcc-plugins/on_register_attributes.c
@@ -1,5 +1,5 @@
-#include <pinpoint.h>
-#include <passes.h>
+#include "pinpoint.h"
+#include "passes.h"
 
 static tree check_spslr_attribute(tree *node, tree name, tree args, int flags,
 				  bool *no_add_attrs)
diff --git a/scripts/gcc-plugins/on_start_unit.c b/scripts/gcc-plugins/on_start_unit.c
index dc8917209de7..59b9de9a8178 100644
--- a/scripts/gcc-plugins/on_start_unit.c
+++ b/scripts/gcc-plugins/on_start_unit.c
@@ -1,7 +1,7 @@
-#include <passes.h>
-#include <ipin_registry.h>
-#include <dpin_registry.h>
-#include <target_registry.h>
+#include "passes.h"
+#include "ipin_registry.h"
+#include "dpin_registry.h"
+#include "target_registry.h"
 
 void on_start_unit(void *plugin_data, void *user_data)
 {
diff --git a/scripts/gcc-plugins/passes.h b/scripts/gcc-plugins/passes.h
index f22949330e80..cd32cc6bb1e9 100644
--- a/scripts/gcc-plugins/passes.h
+++ b/scripts/gcc-plugins/passes.h
@@ -1,7 +1,7 @@
 #pragma once
 
-#include <safe-gimple.h>
-#include <safe-rtl.h>
+#include "safe-gimple.h"
+#include "safe-rtl.h"
 
 void on_register_attributes(void *plugin_data, void *user_data);
 void on_finish_type(void *plugin_data, void *user_data);
diff --git a/scripts/gcc-plugins/pinpoint.c b/scripts/gcc-plugins/pinpoint.c
index 619487fdb53f..7245f079989e 100644
--- a/scripts/gcc-plugins/pinpoint.c
+++ b/scripts/gcc-plugins/pinpoint.c
@@ -1,10 +1,10 @@
 #include <filesystem>
 #include <string>
 
-#include <pinpoint.h>
-#include <passes.h>
-#include <safe-gcc-plugin.h>
-#include <safe-plugin-version.h>
+#include "pinpoint.h"
+#include "passes.h"
+#include "safe-gcc-plugin.h"
+#include "safe-plugin-version.h"
 
 int plugin_is_GPL_compatible;
 
diff --git a/scripts/gcc-plugins/pinpoint.h b/scripts/gcc-plugins/pinpoint.h
index 7f88cda32f48..52a72e587057 100644
--- a/scripts/gcc-plugins/pinpoint.h
+++ b/scripts/gcc-plugins/pinpoint.h
@@ -1,7 +1,7 @@
 #pragma once
 #include <cstdio>
-#include <safe-diagnostic.h>
-#include <safe-ggc.h>
+#include "safe-diagnostic.h"
+#include "safe-ggc.h"
 
 #define SPSLR_ATTRIBUTE "spslr"
 #define SPSLR_FIELD_FIXED_ATTRIBUTE "spslr_field_fixed"
diff --git a/scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c b/scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c
index a30f709f6fb6..a9c88d456a46 100644
--- a/scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c
+++ b/scripts/gcc-plugins/rtl_ipin_survival_scan_pass.c
@@ -1,7 +1,7 @@
-#include <pinpoint.h>
-#include <passes.h>
-#include <ipin_registry.h>
-#include <safe-rtl.h>
+#include "pinpoint.h"
+#include "passes.h"
+#include "ipin_registry.h"
+#include "safe-rtl.h"
 
 static const pass_data rtl_ipin_survival_scan_pass_data = {
 	RTL_PASS,
diff --git a/scripts/gcc-plugins/safe-attribs.h b/scripts/gcc-plugins/safe-attribs.h
index 2d62fe75c72b..0b99515c41a8 100644
--- a/scripts/gcc-plugins/safe-attribs.h
+++ b/scripts/gcc-plugins/safe-attribs.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_ATTRIBS_H
 #define SAFEGCC_ATTRIBS_H
diff --git a/scripts/gcc-plugins/safe-diagnostic.h b/scripts/gcc-plugins/safe-diagnostic.h
index c58b739d88ed..d52589b87379 100644
--- a/scripts/gcc-plugins/safe-diagnostic.h
+++ b/scripts/gcc-plugins/safe-diagnostic.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_DIAGNOSTIC_H
 #define SAFEGCC_DIAGNOSTIC_H
diff --git a/scripts/gcc-plugins/safe-ggc.h b/scripts/gcc-plugins/safe-ggc.h
index 5df62ad492e8..d5a129e365b7 100644
--- a/scripts/gcc-plugins/safe-ggc.h
+++ b/scripts/gcc-plugins/safe-ggc.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_GGC_H
 #define SAFEGCC_GGC_H
diff --git a/scripts/gcc-plugins/safe-gimple.h b/scripts/gcc-plugins/safe-gimple.h
index 2eb0bae2f0a4..e2981947822a 100644
--- a/scripts/gcc-plugins/safe-gimple.h
+++ b/scripts/gcc-plugins/safe-gimple.h
@@ -1,5 +1,5 @@
-#include <safe-gcc-plugin.h>
-#include <safe-tree.h>
+#include "safe-gcc-plugin.h"
+#include "safe-tree.h"
 
 #ifndef SAFEGCC_GIMPLE_H
 #define SAFEGCC_GIMPLE_H
diff --git a/scripts/gcc-plugins/safe-input.h b/scripts/gcc-plugins/safe-input.h
index fe24435830fe..0ff64a012bab 100644
--- a/scripts/gcc-plugins/safe-input.h
+++ b/scripts/gcc-plugins/safe-input.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_INPUT_H
 #define SAFEGCC_INPUT_H
diff --git a/scripts/gcc-plugins/safe-langhooks.h b/scripts/gcc-plugins/safe-langhooks.h
index 3fbea6ccb579..b62bad0b770f 100644
--- a/scripts/gcc-plugins/safe-langhooks.h
+++ b/scripts/gcc-plugins/safe-langhooks.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_LANGHOOKS_H
 #define SAFEGCC_LANGHOOKS_H
diff --git a/scripts/gcc-plugins/safe-md5.h b/scripts/gcc-plugins/safe-md5.h
index 8341cb193467..0140b0a4df24 100644
--- a/scripts/gcc-plugins/safe-md5.h
+++ b/scripts/gcc-plugins/safe-md5.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_MD5_H
 #define SAFEGCC_MD5_H
diff --git a/scripts/gcc-plugins/safe-output.h b/scripts/gcc-plugins/safe-output.h
index 5da7fec494be..fc0a2bbe8ec0 100644
--- a/scripts/gcc-plugins/safe-output.h
+++ b/scripts/gcc-plugins/safe-output.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_OUTPUT_H
 #define SAFEGCC_OUTPUT_H
diff --git a/scripts/gcc-plugins/safe-plugin-version.h b/scripts/gcc-plugins/safe-plugin-version.h
index e43a1689da8c..2fd308b7e19a 100644
--- a/scripts/gcc-plugins/safe-plugin-version.h
+++ b/scripts/gcc-plugins/safe-plugin-version.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_PLUGIN_VERSION_H
 #define SAFEGCC_PLUGIN_VERSION_H
diff --git a/scripts/gcc-plugins/safe-rtl.h b/scripts/gcc-plugins/safe-rtl.h
index f89decdb1d18..7720bf57ef0d 100644
--- a/scripts/gcc-plugins/safe-rtl.h
+++ b/scripts/gcc-plugins/safe-rtl.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_RTL_H
 #define SAFEGCC_RTL_H
diff --git a/scripts/gcc-plugins/safe-tree.h b/scripts/gcc-plugins/safe-tree.h
index d968f8b9675a..9b4851ec3afa 100644
--- a/scripts/gcc-plugins/safe-tree.h
+++ b/scripts/gcc-plugins/safe-tree.h
@@ -1,4 +1,4 @@
-#include <safe-gcc-plugin.h>
+#include "safe-gcc-plugin.h"
 
 #ifndef SAFEGCC_TREE_H
 #define SAFEGCC_TREE_H
diff --git a/scripts/gcc-plugins/separate_offset_pass.c b/scripts/gcc-plugins/separate_offset_pass.c
index 9598f1148896..cbb4d8a68c3a 100644
--- a/scripts/gcc-plugins/separate_offset_pass.c
+++ b/scripts/gcc-plugins/separate_offset_pass.c
@@ -1,10 +1,10 @@
 #include <functional>
 #include <list>
 
-#include <pinpoint.h>
-#include <passes.h>
-#include <ipin_registry.h>
-#include <target_registry.h>
+#include "pinpoint.h"
+#include "passes.h"
+#include "ipin_registry.h"
+#include "target_registry.h"
 
 /*
  * AccessChain flattens nested COMPONENT_REF / ARRAY_REF expressions from
diff --git a/scripts/gcc-plugins/target_hash_builtin_pass.c b/scripts/gcc-plugins/target_hash_builtin_pass.c
index d35b8df9abbc..bf1f61a0d342 100644
--- a/scripts/gcc-plugins/target_hash_builtin_pass.c
+++ b/scripts/gcc-plugins/target_hash_builtin_pass.c
@@ -2,13 +2,13 @@
 #include <map>
 #include <string>
 
-#include <pinpoint.h>
-#include <passes.h>
-#include <serialize.h>
-#include <target_registry.h>
+#include "pinpoint.h"
+#include "passes.h"
+#include "serialize.h"
+#include "target_registry.h"
 
-#include <safe-gimple.h>
-#include <safe-tree.h>
+#include "safe-gimple.h"
+#include "safe-tree.h"
 
 namespace
 {
diff --git a/scripts/gcc-plugins/target_registry.c b/scripts/gcc-plugins/target_registry.c
index a692520467bd..dc41cec197e3 100644
--- a/scripts/gcc-plugins/target_registry.c
+++ b/scripts/gcc-plugins/target_registry.c
@@ -3,12 +3,12 @@
 #include <set>
 #include <vector>
 
-#include <pinpoint.h>
-#include <target_registry.h>
-#include <layout_hash.h>
+#include "pinpoint.h"
+#include "target_registry.h"
+#include "layout_hash.h"
 
-#include <safe-attribs.h>
-#include <safe-langhooks.h>
+#include "safe-attribs.h"
+#include "safe-langhooks.h"
 
 struct validated_target {
 	std::vector<target::compressed_field> fields{};
diff --git a/scripts/gcc-plugins/target_registry.h b/scripts/gcc-plugins/target_registry.h
index 5531cefffb38..e58a9fab1c5b 100644
--- a/scripts/gcc-plugins/target_registry.h
+++ b/scripts/gcc-plugins/target_registry.h
@@ -6,7 +6,7 @@
 #include <vector>
 #include <array>
 
-#include <safe-tree.h>
+#include "safe-tree.h"
 
 struct target {
 	struct compressed_field {
-- 
2.34.1

