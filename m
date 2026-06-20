Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E61C5F13
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962562; cv=none; b=phgPI5I6IORzeCeIbFnf/rkQLol/mLWVUkD+U4ONrf6NTuE+KrNl/7vMvaswnh4zF+2vvZWow6ywlBo7FDavsfcYPjFAJFJbzFlseHlYbkFUQh1Q33uuJ9vJIwLYx1sNR1vwURstSSbUNrv1M4bCvblzxNg8XtDopfAb/Th1z6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962562; c=relaxed/simple;
	bh=0ZOtdpUOGy8fVp5swKi/N73rvY3eaeudndIIAB2dSh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0GpgdETyZeObSLUGwureohFRDzSAtcmbjuK2MucC+HU9qbLNdWRTCzlrsSZtAP/UuQ6ZtKk7Q12W96uC+0/0Lq1oSuCXRlvZ8gqtvWt1X0Lrn1AI7ChbLeNjpg20hx+52tOqKbUpKJ5SSvsIMr/NqsmVy+oW1OiiwEWBEFflrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=IIm9fJle; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="IIm9fJle"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso20765945e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1781962557; x=1782567357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhwDtP2aSP4hztGXXeq15QWH5cSeQ4Wbhq9Tni8Faxs=;
        b=IIm9fJle8RFj2hGqsgaGWMTkNr2MQu5hy+BxPHens/6afpscps4CvLauazMDT5gCPf
         wVYaEV0KJ6UzguC8Se/zTtlMJ5AL82Ht6fz3SUY0si8oXvj1swRhR94+3VZnqa0xJelL
         JMWICfMFFrbaZ5XToZoVl856aK9/V+xEzmpD5bMZKkiGfzpOjcWDBBlRubaDGbXMQQTo
         o2eMB1Gu5ySFeNhq/Rva0xzCL7Wmmqku+qzHTXaJ2ybOqE/1cjl86GnSXBIsUwaNSyq+
         NRlKfNB4NG694Rl1TWmpmpH7ptCrbByrcl66lFHpnWcqQLlUvzxhZPIdfUYodwdGmbnD
         5AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962557; x=1782567357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bhwDtP2aSP4hztGXXeq15QWH5cSeQ4Wbhq9Tni8Faxs=;
        b=l5AaOHfxVhwWDaioOh/s1ZafG6KCRTjsOfe7scJbMhX5XFCHzHTPi1pRG8vUlHNIuD
         gQee6EQ+SMlTJ1Wf62MzRBKNwKq83MDZzLA6W5mw93UJXGbSpDNxuyr/Bee1S1j1QpLX
         VsDDGwko9EJI7WM3tqIXlSvMNc0f3/qwajz2DQLi5RK9yTkG+uBGDRfm0Rti0ytGLYVb
         ahWywoulbdV0RsQtGeFVnNIOIqkfadrJx6vLTg6MW2QBvKtF/Q8vvr0u4QNR9AVoE7lv
         bjbNZmiodOdJfXmzkeXqrxSDk4oHZMX8Wj6/k2QWHjEH+xJ1SZ6t4M0Jj8fsNRemKxMa
         doXA==
X-Gm-Message-State: AOJu0YynSA0S6HK0N6ed2NjQHH22O6+dku3UHc+AuKvgGCZBnTea2H+4
	6bWizJPrfhm4nd55L+ZjpED+3Rh/+/buht1nR87WRPOG6m/7QYU83v5xsE5eZAtHZiF4MfQc5MC
	nH3nXdg==
X-Gm-Gg: AfdE7clFK/rPfRz/tYszt9hKgAanOaPMzhAjAwSiLehvQ9vgjd8MHJTparG8g7N6CIk
	l/OuyRFAbLdu9yzO1n7NksmGIuGzHQatXZ28rjAmoPOKrK+25IN3pgcGiE5bafpDFfrePvHxOIR
	IOyCzy12a0tSgZboPTawblVqqKJcIbHa2dFStapAZAnE4Yyu4CkxWx5ooTT4r7gwm4ymoh8VmCE
	ZF+eTYJJ4PMsNM2cyEQuU7xVd2Oz2p6PDnF4Dl0kMJ/6l6lKLLv3FBkwzDfgOo5qvEtcBbBtVZX
	atvhfNwX3F9ZFCh7DtQ1jiMM6NfLA1RVd71xjV9zUbRmUrQ9RHyA6a6OL+/vKHBTgZAfdG9yI4b
	SzvBlYYuB9yWaCueeRi2MxamY3gxGeDdKodXLmi1Yo9aU9dmOXMFuV6jx2SWSDymsgEoL+xzl/r
	ijiGnUViMnZeIi9+IUvDs066O7evsit5dM8oQr34NUNVT1L1w23gm4ykGOV2Uffn5Q8sVpM0c1/
	I27UR3z1a6Jw5IU9aV1LgTiUBKw
X-Received: by 2002:a05:600c:8010:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-49240e7fd89mr120795665e9.24.1781962556722;
        Sat, 20 Jun 2026 06:35:56 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00ab2024b6c6d10e76.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:ab20:24b6:c6d1:e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm108564455e9.0.2026.06.20.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:35:56 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v2 2/5] SPSLR selfpatch
Date: Sat, 20 Jun 2026 15:35:55 +0200
Message-ID: <20260620133555.95161-1-yjn@yjn-systems.com>
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
 include/linux/compiler_types.h  |  12 +
 include/linux/spslr.h           |  65 ++++
 kernel/Makefile                 |   2 +
 kernel/spslr/Makefile           |   5 +
 kernel/spslr/pinpoint.h         |  89 +++++
 kernel/spslr/spslr.c            | 527 ++++++++++++++++++++++++++++
 kernel/spslr/spslr_env.c        |  74 ++++
 kernel/spslr/spslr_env.h        |  45 +++
 kernel/spslr/spslr_randomizer.c | 598 ++++++++++++++++++++++++++++++++
 kernel/spslr/spslr_randomizer.h |  29 ++
 10 files changed, 1446 insertions(+)
 create mode 100644 include/linux/spslr.h
 create mode 100644 kernel/spslr/Makefile
 create mode 100644 kernel/spslr/pinpoint.h
 create mode 100644 kernel/spslr/spslr.c
 create mode 100644 kernel/spslr/spslr_env.c
 create mode 100644 kernel/spslr/spslr_env.h
 create mode 100644 kernel/spslr/spslr_randomizer.c
 create mode 100644 kernel/spslr/spslr_randomizer.h

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1a957ea2f4fe..167c106574e0 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -374,6 +374,18 @@ struct ftrace_likely_data {
 # define __latent_entropy
 #endif
 
+#if defined(__SPSLR__)
+# define __spslr __attribute__((spslr))
+# define __spslr_field_fixed __attribute__((spslr_field_fixed))
+# define spslr_struct_fields_start struct {
+# define spslr_struct_fields_end   } __spslr;
+#else
+# define __spslr
+# define __spslr_field_fixed
+# define spslr_struct_fields_start
+# define spslr_struct_fields_end
+#endif
+
 #if defined(RANDSTRUCT) && !defined(__CHECKER__)
 # define __randomize_layout __designated_init __attribute__((randomize_layout))
 # define __no_randomize_layout __attribute__((no_randomize_layout))
diff --git a/include/linux/spslr.h b/include/linux/spslr.h
new file mode 100644
index 000000000000..c6156271a8fd
--- /dev/null
+++ b/include/linux/spslr.h
@@ -0,0 +1,65 @@
+#ifndef SPSLR_SELFPATCH_H
+#define SPSLR_SELFPATCH_H
+
+#ifdef CONFIG_SPSLR
+
+#include <linux/types.h>
+
+#define SPSLR_START_UNITS_SYM __start_spslr_units
+#define SPSLR_STOP_UNITS_SYM __stop_spslr_units
+#define SPSLR_START_TARGETS_SYM __start_spslr_targets
+#define SPSLR_STOP_TARGETS_SYM __stop_spslr_targets
+
+extern bool spslr_enabled;
+
+enum spslr_viability { SPSLR_VIABLE, SPSLR_NONVIABLE };
+
+enum spslr_error {
+	SPSLR_OK,
+	SPSLR_ERROR_INCOMPLETE_CTX,
+	SPSLR_ERROR_INCOMPATIBLE_CTX,
+	SPSLR_ERROR_RANDOMIZER_INIT,
+	SPSLR_ERROR_INITIAL_TARGET_LAYOUT,
+	SPSLR_ERROR_RANDOMIZED_TARGET_LAYOUT,
+	SPSLR_ERROR_RANDOMIZE,
+	SPSLR_ERROR_MEMORY,
+	SPSLR_ERROR_UNINITIALIZED,
+	SPSLR_ERROR_ALREADY_PATCHED,
+	SPSLR_ERROR_PATCH_DPINS,
+	SPSLR_ERROR_PATCH_IPINS,
+	SPSLR_ERROR_MAP_TARGETS
+};
+
+struct spslr_status {
+	enum spslr_viability viability;
+	enum spslr_error error;
+};
+
+struct spslr_entry {
+	const void *start_units; // Address of SPSLR_START_UNITS_SYM
+	const void *stop_units; // Address of SPSLR_STOP_UNITS_SYM
+	const void *start_targets; // Address of SPSLR_START_TARGETS_SYM
+	const void *stop_targets; // Address of SPSLR_STOP_TARGETS_SYM
+};
+
+struct spslr_ctx {
+	struct spslr_entry entry;
+	void *workspace; // Temporary buffer of spslr_workspace_size(&entry) bytes
+};
+
+/*
+ * Runtime entry points are intentionally split:
+ *
+ * spslr_init() creates randomized layouts.
+ * spslr_selfpatch() patches the main executable.
+ * spslr_patch_module() patches with module-local metadata using host layouts.
+ */
+
+struct spslr_status spslr_init(void);
+struct spslr_status spslr_selfpatch(void);
+unsigned long spslr_workspace_size(const struct spslr_entry *entry);
+struct spslr_status spslr_patch_module(const struct spslr_ctx *m);
+
+#endif /* CONFIG_SPSLR */
+
+#endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..9014e9573c31 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -132,6 +132,8 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+obj-$(CONFIG_SPSLR) += spslr/
+
 CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
diff --git a/kernel/spslr/Makefile b/kernel/spslr/Makefile
new file mode 100644
index 000000000000..5a8664392b1b
--- /dev/null
+++ b/kernel/spslr/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_SPSLR) += spslr.o spslr_env.o spslr_randomizer.o
+
+CFLAGS_REMOVE_spslr.o += $(PINPOINT_PLUGIN_CFLAGS)
+CFLAGS_REMOVE_spslr_env.o += $(PINPOINT_PLUGIN_CFLAGS)
+CFLAGS_REMOVE_spslr_randomizer.o += $(PINPOINT_PLUGIN_CFLAGS)
diff --git a/kernel/spslr/pinpoint.h b/kernel/spslr/pinpoint.h
new file mode 100644
index 000000000000..3657ccf03f75
--- /dev/null
+++ b/kernel/spslr/pinpoint.h
@@ -0,0 +1,89 @@
+#ifndef SPSLR_PINPOINT_H
+#define SPSLR_PINPOINT_H
+
+#include "spslr_env.h"
+
+/* Field must remain at its original offset during layout randomization. */
+#define SPSLR_FLAG_FIELD_FIXED 1
+
+struct spslr_hdr;
+struct spslr_unit;
+struct spslr_ipin;
+struct spslr_ipin_expr;
+struct spslr_dpin;
+struct spslr_target;
+struct spslr_target_layout;
+struct spslr_target_field;
+
+/* CU-local target reference; points into the global deduplicated target table. */
+typedef const struct spslr_target *spslr_target_ref;
+
+/*
+ * Root metadata header for one linked subject, such as the kernel image or a
+ * module. Emitted in spslr_entry and COMDAT-deduplicated so each subject has
+ * one usable entry point.
+ */
+struct spslr_hdr {
+	const struct spslr_unit *units_start;
+	const struct spslr_unit *units_stop;
+	const struct spslr_target *targets_start;
+	const struct spslr_target *targets_stop;
+} __packed;
+
+/*
+ * Metadata for one compilation unit. The target array is CU-local and maps
+ * unit_target_idx values used by pins to deduplicated global target headers.
+ */
+struct spslr_unit {
+	const char *source; // Source file name
+	spslr_u64 target_cnt;
+	const spslr_target_ref *target_refs; // CU-local target ref array
+	spslr_u64 ipin_cnt;
+	const struct spslr_ipin *ipins;
+	spslr_u64 dpin_cnt;
+	const struct spslr_dpin *dpins;
+} __packed;
+
+/* Instruction patch site: address of patchable immediate/displacement bytes. */
+struct spslr_ipin {
+	void *addr;
+	spslr_u64 size;
+	const struct spslr_ipin_expr *expr;
+} __packed;
+
+/* Data patch site: address of an object/subobject whose layout must be adjusted. */
+struct spslr_dpin {
+	void *addr;
+	spslr_u64 unit_target_idx;
+} __packed;
+
+/* Current simple expression: randomized offset of one field in one CU-local target. */
+struct spslr_ipin_expr {
+	spslr_u64 unit_target_idx;
+	spslr_u64 field_idx;
+} __packed;
+
+/* Deduplicated target type descriptor, keyed by deterministic layout hash. */
+struct spslr_target {
+	char hash[16];
+	const char *name;
+	const struct spslr_target_layout *layout;
+} __packed;
+
+/* Physical layout of a target type before runtime randomization. */
+struct spslr_target_layout {
+	spslr_u64 size;
+	spslr_u64 field_cnt;
+	const struct spslr_target_field *fields;
+} __packed;
+
+/* One randomizable or fixed field/range within a target layout. */
+struct spslr_target_field {
+	const char *name;
+	spslr_u64 size;
+	spslr_u64 offset;
+	spslr_u64 alignment;
+	spslr_u64 flags;
+} __packed;
+
+#endif
diff --git a/kernel/spslr/spslr.c b/kernel/spslr/spslr.c
new file mode 100644
index 000000000000..3ce0f4d72e31
--- /dev/null
+++ b/kernel/spslr/spslr.c
@@ -0,0 +1,527 @@
+#include <linux/spslr.h>
+
+#include "spslr_randomizer.h"
+#include "spslr_env.h"
+#include "pinpoint.h"
+
+/*
+ * Runtime portion of SPSLR.
+ *
+ * This code consumes the metadata emitted by pinpoint, randomizes target
+ * layouts, rewrites static data objects, and patches instruction immediates
+ * that encode structure field offsets.
+ */
+
+#define SPSLR_SANITY_CHECK
+
+struct target_map {
+	spslr_u64 *map;
+	spslr_u64 size;
+};
+
+static void init_spslr_meta(void);
+static int spslr_targets_compatible(const struct spslr_target *begin,
+				    const struct spslr_target *end);
+static enum spslr_error spslr_patch_unit(const struct spslr_unit *unit,
+					 spslr_u64 *tmap_buffer,
+					 void *reorder_buffer);
+static struct spslr_status spslr_patch(const struct spslr_ctx *ctx);
+static spslr_u64 spslr_target_mapping_size(void);
+static spslr_u64 *workspace_target_mapping(void *workspace);
+static void *workspace_reorder_buffer(void *workspace);
+
+static int spslr_patch_dpins(const struct spslr_dpin *dpins, spslr_u64 cnt,
+			     const struct target_map *tmap,
+			     void *reorder_buffer);
+static int spslr_patch_dpin(void *addr, spslr_u64 target, void *reorder_buffer);
+static int spslr_patch_ipins(const struct spslr_ipin *ipins, spslr_u64 cnt,
+			     const struct target_map *tmap);
+
+static int reorder_object(void *dst, const void *src, spslr_u64 target);
+static int spslr_calculate_ipin_value(const struct spslr_ipin_expr *expr,
+				      spslr_s64 *res,
+				      const struct target_map *tmap);
+
+static int spslr_map_target(const struct spslr_target *target, spslr_u64 *idx);
+static int spslr_map_targets(const struct spslr_unit *unit,
+			     struct target_map *tmap);
+
+static int initialized = 0, patched = 0;
+static enum spslr_viability viable = SPSLR_VIABLE;
+
+spslr_u64 spslr_target_cnt = 0;
+const struct spslr_target *spslr_targets = NULL;
+
+/* Host image spslr metadata entry point */
+extern const struct spslr_unit SPSLR_START_UNITS_SYM[];
+extern const struct spslr_unit SPSLR_STOP_UNITS_SYM[];
+extern const struct spslr_target SPSLR_START_TARGETS_SYM[];
+extern const struct spslr_target SPSLR_STOP_TARGETS_SYM[];
+
+/*
+ * Initialize runtime randomization state.
+ *
+ * After this point target layouts are randomized, but code/data does still
+ * contain original-layout offsets until the patching entry points run.
+ */
+
+static void __init init_spslr_meta(void)
+{
+	spslr_target_cnt =
+		(spslr_u64)(SPSLR_STOP_TARGETS_SYM - SPSLR_START_TARGETS_SYM);
+	spslr_targets = SPSLR_START_TARGETS_SYM;
+}
+
+struct spslr_status __init spslr_init(void)
+{
+	if (initialized)
+		return (struct spslr_status){ .viability = viable,
+					      .error = SPSLR_OK };
+
+	init_spslr_meta();
+
+	if (spslr_randomizer_init() < 0)
+		return (struct spslr_status){
+			.viability = viable,
+			.error = SPSLR_ERROR_RANDOMIZER_INIT
+		};
+
+#ifdef SPSLR_SANITY_CHECK
+	for (spslr_u64 tidx = 0; tidx < spslr_target_cnt; tidx++) {
+		if (spslr_randomizer_validate_target(tidx) < 0)
+			return (struct spslr_status){
+				.viability = viable,
+				.error = SPSLR_ERROR_INITIAL_TARGET_LAYOUT
+			};
+	}
+#endif
+
+	if (spslr_randomize() < 0)
+		return (struct spslr_status){ .viability = viable,
+					      .error = SPSLR_ERROR_RANDOMIZE };
+
+#ifdef SPSLR_SANITY_CHECK
+	for (spslr_u64 tidx = 0; tidx < spslr_target_cnt; tidx++) {
+		if (spslr_randomizer_validate_target(tidx) < 0)
+			return (struct spslr_status){
+				.viability = viable,
+				.error = SPSLR_ERROR_RANDOMIZED_TARGET_LAYOUT
+			};
+	}
+#endif
+
+	initialized = 1;
+	return (struct spslr_status){ .viability = viable, .error = SPSLR_OK };
+}
+
+/*
+ * Calculate required workspace buffer size. This includes the reorder
+ * buffer for data pins and the storage for the mapping of local to
+ * global target indices.
+ */
+
+static spslr_u64 spslr_target_mapping_size(void)
+{
+	return spslr_target_cnt * sizeof(spslr_u64);
+}
+
+unsigned long spslr_workspace_size(const struct spslr_entry *entry)
+{
+	if (!entry || !entry->start_units || !entry->stop_units)
+		return 0;
+
+	const struct spslr_unit *start_units =
+		(const struct spslr_unit *)entry->start_units;
+	const struct spslr_unit *stop_units =
+		(const struct spslr_unit *)entry->stop_units;
+
+	spslr_u64 max_dpin_size = 0;
+	for (const struct spslr_unit *unit = start_units; unit != stop_units;
+	     unit++) {
+		for (spslr_u64 dpin = 0; dpin < unit->dpin_cnt; dpin++) {
+			const struct spslr_target *target =
+				unit->target_refs[unit->dpins[dpin]
+							  .unit_target_idx];
+
+			if (target->layout->size > max_dpin_size)
+				max_dpin_size = target->layout->size;
+		}
+	}
+
+	return spslr_target_mapping_size() + max_dpin_size;
+}
+
+/*
+ * Check if the given target space is compatible with that of the
+ * host.
+ */
+
+static int spslr_meta_known_target(const struct spslr_target *t)
+{
+	for (spslr_u64 i = 0; i < spslr_target_cnt; i++) {
+		if (spslr_env_memcmp(t->hash, spslr_targets[i].hash,
+				     sizeof(t->hash)) == 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int spslr_targets_compatible(const struct spslr_target *begin,
+				    const struct spslr_target *end)
+{
+	spslr_u64 cnt = (spslr_u64)(end - begin);
+	if (cnt > spslr_target_cnt)
+		return 0;
+
+	for (spslr_u64 i = 0; i < cnt; i++) {
+		if (!spslr_meta_known_target(begin + i))
+			return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * For each CU, map local target indices to global target indices and then
+ * to host indices. Afterwards, patch ipins and dpins.
+ */
+
+static spslr_u64 *workspace_target_mapping(void *workspace)
+{
+	return (spslr_u64 *)workspace;
+}
+
+static void *workspace_reorder_buffer(void *workspace)
+{
+	return (spslr_u8 *)workspace + spslr_target_mapping_size();
+}
+
+static int spslr_map_target(const struct spslr_target *target, spslr_u64 *idx)
+{
+	for (spslr_u64 i = 0; i < spslr_target_cnt; i++) {
+		if (spslr_env_memcmp(target->hash, spslr_targets[i].hash,
+				     sizeof(target->hash)) == 0) {
+			*idx = i;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static int spslr_map_targets(const struct spslr_unit *unit,
+			     struct target_map *tmap)
+{
+	tmap->size = 0;
+
+	for (spslr_u64 i = 0; i < unit->target_cnt; i++) {
+		if (spslr_map_target(unit->target_refs[i], tmap->map + i) < 0)
+			return -1;
+	}
+
+	tmap->size = unit->target_cnt;
+	return 0;
+}
+
+static enum spslr_error spslr_patch_unit(const struct spslr_unit *unit,
+					 spslr_u64 *tmap_buffer,
+					 void *reorder_buffer)
+{
+	struct target_map tmap = { .map = tmap_buffer, .size = 0 };
+
+	if (spslr_map_targets(unit, &tmap) < 0)
+		return SPSLR_ERROR_MAP_TARGETS;
+
+	if (spslr_patch_dpins(unit->dpins, unit->dpin_cnt, &tmap,
+			      reorder_buffer) < 0)
+		return SPSLR_ERROR_PATCH_DPINS;
+
+	if (spslr_patch_ipins(unit->ipins, unit->ipin_cnt, &tmap) < 0)
+		return SPSLR_ERROR_PATCH_IPINS;
+
+	return SPSLR_OK;
+}
+
+static struct spslr_status spslr_patch(const struct spslr_ctx *ctx)
+{
+	enum spslr_error err = SPSLR_OK;
+	enum spslr_viability via = SPSLR_VIABLE;
+
+	spslr_u64 *target_map_buffer = NULL;
+	void *reorder_buffer = NULL;
+
+	const struct spslr_unit *start_units = NULL;
+	const struct spslr_unit *stop_units = NULL;
+	const struct spslr_target *start_targets = NULL;
+	const struct spslr_target *stop_targets = NULL;
+
+	if (!ctx || !ctx->entry.start_units || !ctx->entry.stop_units ||
+	    !ctx->entry.start_targets || !ctx->entry.stop_targets ||
+	    !ctx->workspace) {
+		err = SPSLR_ERROR_INCOMPLETE_CTX;
+		goto finish;
+	}
+
+	start_units = (const struct spslr_unit *)ctx->entry.start_units;
+	stop_units = (const struct spslr_unit *)ctx->entry.stop_units;
+	start_targets = (const struct spslr_target *)ctx->entry.start_targets;
+	stop_targets = (const struct spslr_target *)ctx->entry.stop_targets;
+
+	target_map_buffer = workspace_target_mapping(ctx->workspace);
+	reorder_buffer = workspace_reorder_buffer(ctx->workspace);
+
+	if (!spslr_targets_compatible(start_targets, stop_targets)) {
+		err = SPSLR_ERROR_INCOMPATIBLE_CTX;
+		goto finish;
+	}
+
+	via = SPSLR_NONVIABLE;
+
+	for (const struct spslr_unit *unit = start_units; unit != stop_units;
+	     unit++) {
+		err = spslr_patch_unit(unit, target_map_buffer, reorder_buffer);
+		if (err != SPSLR_OK)
+			goto finish;
+	}
+
+	via = SPSLR_VIABLE;
+
+finish:
+	return (struct spslr_status){ .viability = via, .error = err };
+}
+
+/*
+ * Patch the main executable.
+ *
+ * Instruction pins rewrite immediate operands in text, while data pins rewrite
+ * existing static objects from original layout into randomized layout.
+ */
+
+struct spslr_status __init spslr_selfpatch(void)
+{
+	enum spslr_error err = SPSLR_OK;
+
+	spslr_u64 host_workspace_size;
+
+	struct spslr_ctx host_ctx;
+	host_ctx.entry.start_units = SPSLR_START_UNITS_SYM;
+	host_ctx.entry.stop_units = SPSLR_STOP_UNITS_SYM;
+	host_ctx.entry.start_targets = SPSLR_START_TARGETS_SYM;
+	host_ctx.entry.stop_targets = SPSLR_STOP_TARGETS_SYM;
+	host_ctx.workspace = NULL;
+
+	struct spslr_status internal_patch_status;
+
+	if (patched) {
+		err = SPSLR_ERROR_ALREADY_PATCHED;
+		goto finish;
+	}
+
+	if (!initialized) {
+		err = SPSLR_ERROR_UNINITIALIZED;
+		goto finish;
+	}
+
+	host_workspace_size = spslr_workspace_size(&host_ctx.entry);
+	host_ctx.workspace = spslr_env_malloc(host_workspace_size);
+
+	if (!host_ctx.workspace) {
+		err = SPSLR_ERROR_MEMORY;
+		goto finish;
+	}
+
+	internal_patch_status = spslr_patch(&host_ctx);
+	if (internal_patch_status.error == SPSLR_OK)
+		patched = 1;
+
+	viable = internal_patch_status.viability;
+	err = internal_patch_status.error;
+
+finish:
+	if (host_ctx.workspace)
+		spslr_env_free(host_ctx.workspace, host_workspace_size);
+
+	return (struct spslr_status){ .viability = viable, .error = err };
+}
+
+/*
+ * Patch metadata belonging to a separately loaded module.
+ *
+ * Modules reuse the target randomization state created by the main executable;
+ * they contribute only their own instruction and data patch sites.
+ */
+
+struct spslr_status spslr_patch_module(const struct spslr_ctx *m)
+{
+	if (!initialized)
+		return (struct spslr_status){
+			.viability = SPSLR_VIABLE,
+			.error = SPSLR_ERROR_UNINITIALIZED
+		};
+
+	if (!m || !m->entry.start_units || !m->entry.stop_units ||
+	    !m->entry.start_targets || !m->entry.stop_targets || !m->workspace)
+		return (struct spslr_status){
+			.viability = SPSLR_VIABLE,
+			.error = SPSLR_ERROR_INCOMPLETE_CTX
+		};
+
+	struct spslr_status s = spslr_patch(m);
+	return (struct spslr_status){ .viability = (s.error == SPSLR_OK ?
+							    SPSLR_VIABLE :
+							    SPSLR_NONVIABLE),
+				      .error = s.error };
+}
+
+/*
+ * Rewrite one object instance from original layout into randomized layout.
+ *
+ * A temporary buffer is used so overlapping source/destination field ranges do
+ * not corrupt data while fields are moved.
+ */
+
+static int reorder_object(void *dst, const void *src, spslr_u64 target)
+{
+	spslr_u64 field_count;
+	if (spslr_randomizer_get_target(target, NULL, &field_count))
+		return -1;
+
+	const spslr_u8 *src_countable = (const spslr_u8 *)src;
+	spslr_u8 *dst_countable = (spslr_u8 *)dst;
+
+	for (spslr_u64 i = 0; i < field_count; i++) {
+		struct spslr_randomizer_field_info finfo;
+		if (spslr_randomizer_get_field(
+			    target, i, SPSLR_RANDOMIZER_FIELD_IDX_MODE_FINAL,
+			    &finfo))
+			return -1;
+
+		spslr_env_memcpy(dst_countable + finfo.offset,
+				 src_countable + finfo.initial_offset,
+				 finfo.size);
+	}
+
+	return 0;
+}
+
+/*
+ * Apply data pin patches.
+ *
+ * Each pin's address already points at an existing object in original layout. Patching
+ * converts that storage in-place to the target's randomized layout.
+ */
+
+static int spslr_patch_dpins(const struct spslr_dpin *dpins, spslr_u64 cnt,
+			     const struct target_map *tmap,
+			     void *reorder_buffer)
+{
+	for (spslr_u64 dpidx = 0; dpidx < cnt; dpidx++) {
+		const struct spslr_dpin *dp = &dpins[dpidx];
+
+		if (dp->unit_target_idx >= tmap->size)
+			return -1;
+
+		if (spslr_patch_dpin((void *)dp->addr,
+				     tmap->map[dp->unit_target_idx],
+				     reorder_buffer) < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+static int spslr_patch_dpin(void *addr, spslr_u64 target, void *reorder_buffer)
+{
+	if (target >= spslr_target_cnt)
+		return -1;
+
+	const struct spslr_target *t = &spslr_targets[target];
+
+	spslr_env_memset(reorder_buffer, 0, t->layout->size);
+
+	if (reorder_object(reorder_buffer, addr, target) < 0)
+		return -1;
+
+	if (spslr_env_poke_data(addr, reorder_buffer, t->layout->size) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int spslr_patch_ipins(const struct spslr_ipin *ipins, spslr_u64 cnt,
+			     const struct target_map *tmap)
+{
+	for (spslr_u64 ipidx = 0; ipidx < cnt; ipidx++) {
+		const struct spslr_ipin *ip = &ipins[ipidx];
+
+		spslr_s64 value;
+		if (spslr_calculate_ipin_value(ip->expr, &value, tmap) < 0)
+			return -1;
+
+		/*
+		 * Text patching is deliberately scoped to the immediate field only.
+		 * The surrounding instruction bytes were fixed by pinpoint/patchcompile and
+		 * must not change at runtime.
+		 */
+
+		switch (ip->size) {
+		case 1:
+			if (spslr_env_poke_text_8((void *)ip->addr,
+						  (spslr_u8)value) < 0)
+				return -1;
+			break;
+		case 2:
+			if (spslr_env_poke_text_16((void *)ip->addr,
+						   (spslr_u16)value) < 0)
+				return -1;
+			break;
+		case 4:
+			if (spslr_env_poke_text_32((void *)ip->addr,
+						   (spslr_u32)value) < 0)
+				return -1;
+			break;
+		case 8:
+			if (spslr_env_poke_text_64((void *)ip->addr,
+						   (spslr_u64)value) < 0)
+				return -1;
+			break;
+		default:
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Interpret one ipin program and compute the replacement immediate value.
+ *
+ * The program describes original target/field references; this function maps
+ * them through the randomized runtime layout and returns the value written into
+ * the instruction stream.
+ */
+
+static int spslr_calculate_ipin_value(const struct spslr_ipin_expr *expr,
+				      spslr_s64 *res,
+				      const struct target_map *tmap)
+{
+	if (!res)
+		return -1;
+
+	*res = 0;
+
+	if (expr->unit_target_idx >= tmap->size)
+		return -1;
+
+	spslr_u64 global_target_idx = tmap->map[expr->unit_target_idx];
+
+	struct spslr_randomizer_field_info finfo;
+	if (spslr_randomizer_get_field(global_target_idx, expr->field_idx,
+				       SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL,
+				       &finfo) != 0)
+		return -1;
+
+	*res = finfo.offset;
+	return 0;
+}
diff --git a/kernel/spslr/spslr_env.c b/kernel/spslr/spslr_env.c
new file mode 100644
index 000000000000..a4a2d2389dcd
--- /dev/null
+++ b/kernel/spslr/spslr_env.c
@@ -0,0 +1,74 @@
+#include "spslr_env.h"
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/random.h>
+#include <linux/memblock.h>
+
+#ifdef CONFIG_X86
+
+#include <asm/text-patching.h>
+
+static __always_inline int spslr_env_poke_text(void *dst, const void *src, size_t n)
+{
+	text_poke_early(dst, src, n);
+	return 0;
+}
+
+#endif
+
+int spslr_env_poke_text_8(void *dst, u8 value)
+{
+	return spslr_env_poke_text(dst, &value, sizeof(value));
+}
+
+int spslr_env_poke_text_16(void *dst, u16 value)
+{
+	return spslr_env_poke_text(dst, &value, sizeof(value));
+}
+
+int spslr_env_poke_text_32(void *dst, u32 value)
+{
+	return spslr_env_poke_text(dst, &value, sizeof(value));
+}
+
+int spslr_env_poke_text_64(void *dst, u64 value)
+{
+	return spslr_env_poke_text(dst, &value, sizeof(value));
+}
+
+/*
+ * Hook runs before slab allocators are available.
+ * memblock_alloc() is the correct early-boot allocator.
+ */
+void* __init spslr_env_malloc(spslr_u64 n) {
+	size_t size = PAGE_ALIGN(n ? n : 1);
+	return memblock_alloc(size, SMP_CACHE_BYTES);
+}
+
+void __init spslr_env_free(void *ptr, spslr_u64 n) {
+	if (ptr)
+		memblock_free(ptr, PAGE_ALIGN(n ? n : 1));
+}
+
+int spslr_env_poke_data(void* dst, const void* src, spslr_u64 n) {
+	memcpy(dst, src, n);
+	return 0;
+}
+
+void spslr_env_memset(void* dst, int v, spslr_u64 n) {
+	memset(dst, v, n);
+}
+
+void spslr_env_memcpy(void* dst, const void* src, spslr_u64 n) {
+	memcpy(dst, src, n);
+}
+
+int spslr_env_memcmp(const void *x, const void *y, spslr_u64 n) {
+	return memcmp(x, y, n);
+}
+
+spslr_u64 __init spslr_env_random_u64(void) {
+	return get_random_u64(); // Hook runs after random_init_early()
+}
+
diff --git a/kernel/spslr/spslr_env.h b/kernel/spslr/spslr_env.h
new file mode 100644
index 000000000000..f48d7e02c57e
--- /dev/null
+++ b/kernel/spslr/spslr_env.h
@@ -0,0 +1,45 @@
+#ifndef SPSLR_ENV_H
+#define SPSLR_ENV_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/init.h>
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#ifndef __init
+#define __init /* only required in kernel */
+#endif
+
+#ifndef __printf
+#define __printf(fmt_pos, arg_pos) \
+	__attribute__((format(printf, fmt_pos, arg_pos)))
+#endif
+
+#ifndef NULL
+#define NULL ((void *)0)
+#endif
+
+typedef uint8_t spslr_u8;
+typedef uint16_t spslr_u16;
+typedef uint32_t spslr_u32;
+typedef uint64_t spslr_u64;
+typedef int32_t spslr_s32;
+typedef int64_t spslr_s64;
+typedef uintptr_t spslr_uintptr;
+
+int spslr_env_poke_text_8(void *dst, spslr_u8 value);
+int spslr_env_poke_text_16(void *dst, spslr_u16 value);
+int spslr_env_poke_text_32(void *dst, spslr_u32 value);
+int spslr_env_poke_text_64(void *dst, spslr_u64 value);
+int spslr_env_poke_data(void *dst, const void *src, spslr_u64 n);
+void *spslr_env_malloc(spslr_u64 n);
+void spslr_env_free(void *ptr, spslr_u64 n);
+void spslr_env_memset(void *dst, int v, spslr_u64 n);
+void spslr_env_memcpy(void *dst, const void *src, spslr_u64 n);
+int spslr_env_memcmp(const void *x, const void *y, spslr_u64 n);
+spslr_u64 spslr_env_random_u64(void);
+
+#endif
diff --git a/kernel/spslr/spslr_randomizer.c b/kernel/spslr/spslr_randomizer.c
new file mode 100644
index 000000000000..48af01bd7975
--- /dev/null
+++ b/kernel/spslr/spslr_randomizer.c
@@ -0,0 +1,598 @@
+#include "spslr_randomizer.h"
+
+#include "spslr_env.h"
+#include "pinpoint.h"
+
+/*
+ * Target layout randomizer.
+ *
+ * The randomizer builds a permutation from original field order to randomized
+ * field order while preserving field size, alignment, and fixed-field
+ * constraints.
+ */
+
+/*
+ * Field tracks both directions of the permutation:
+ *
+ *   original index -> randomized position
+ *   randomized position -> original index
+ *
+ * The runtime needs both: data patching copies from original offsets to new
+ * offsets, while ipin patching maps an original field offset to its randomized
+ * offset.
+ */
+struct Field {
+	spslr_u64 offset; /* Final field offset -> fields[i].offset = offset of field i in final layout */
+	spslr_u64 oidx; /* Original field idx -> fields[i].oidx = original position of field i in final layout */
+	spslr_u64 fidx; /* Final field idx -> fields[i].fidx = randomized/final position of original field i */
+};
+
+extern spslr_u64 spslr_target_cnt;
+extern const struct spslr_target *spslr_targets;
+
+static spslr_u64 *field_base_indices = NULL;
+static struct Field *fields = NULL;
+
+static int init_field_base_indices(void);
+static int init_fields_buffer(void);
+
+static const struct spslr_target_field *meta_original_field(spslr_u64 target,
+							    spslr_u64 field);
+static struct Field *state_current_field(spslr_u64 target, spslr_u64 field);
+
+static int __init init_field_base_indices(void)
+{
+	field_base_indices = (spslr_u64 *)spslr_env_malloc(sizeof(spslr_u64) *
+							   spslr_target_cnt);
+	if (!field_base_indices)
+		return -1;
+
+	spslr_u64 current_field_base_idx = 0;
+	for (spslr_u64 i = 0; i < spslr_target_cnt; i++) {
+		field_base_indices[i] = current_field_base_idx;
+		current_field_base_idx += spslr_targets[i].layout->field_cnt;
+	}
+
+	return 0;
+}
+
+static const struct spslr_target_field *meta_original_field(spslr_u64 target,
+							    spslr_u64 field)
+{
+	if (target >= spslr_target_cnt)
+		return NULL;
+
+	const struct spslr_target_layout *layout = spslr_targets[target].layout;
+
+	if (field >= layout->field_cnt)
+		return NULL;
+
+	return layout->fields + field;
+}
+
+static struct Field *state_current_field(spslr_u64 target, spslr_u64 field)
+{
+	if (target >= spslr_target_cnt)
+		return NULL;
+
+	spslr_u64 field_base_idx = field_base_indices[target];
+	const struct spslr_target_layout *layout = spslr_targets[target].layout;
+
+	if (field >= layout->field_cnt)
+		return NULL;
+
+	return fields + field_base_idx + field;
+}
+
+static int __init init_fields_buffer(void)
+{
+	spslr_u64 total_field_count = 0;
+	for (spslr_u64 i = 0; i < spslr_target_cnt; i++)
+		total_field_count += spslr_targets[i].layout->field_cnt;
+
+	fields = (struct Field *)spslr_env_malloc(sizeof(struct Field) *
+						  total_field_count);
+	if (!fields)
+		return -1;
+
+	for (spslr_u64 i = 0; i < spslr_target_cnt; i++) {
+		spslr_u64 field_base_idx = field_base_indices[i];
+
+		for (spslr_u64 field_idx = 0;
+		     field_idx < spslr_targets[i].layout->field_cnt;
+		     field_idx++) {
+			const struct spslr_target_field *src_field =
+				spslr_targets[i].layout->fields + field_idx;
+			struct Field *dst_field =
+				&fields[field_base_idx + field_idx];
+
+			dst_field->offset = src_field->offset;
+			dst_field->oidx = field_idx;
+			dst_field->fidx = field_idx;
+		}
+	}
+
+	return 0;
+}
+
+int __init spslr_randomizer_init(void)
+{
+	if (init_field_base_indices() != 0)
+		return -1;
+
+	if (init_fields_buffer() != 0)
+		return -1;
+
+	return 0;
+}
+
+int spslr_randomizer_get_target(spslr_u64 target, spslr_u64 *size,
+				spslr_u64 *fieldcnt)
+{
+	if (target >= spslr_target_cnt)
+		return -1;
+
+	const struct spslr_target *t = &spslr_targets[target];
+
+	if (size)
+		*size = t->layout->size;
+
+	if (fieldcnt)
+		*fieldcnt = t->layout->field_cnt;
+
+	return 0;
+}
+
+int spslr_randomizer_get_field(spslr_u64 target, spslr_u64 field,
+			       int field_idx_mode,
+			       struct spslr_randomizer_field_info *info)
+{
+	if (target >= spslr_target_cnt)
+		return -1;
+
+	if (!info)
+		return 0;
+
+	const struct spslr_target *t = &spslr_targets[target];
+
+	if (field >= t->layout->field_cnt)
+		return -1;
+
+	const struct spslr_target_field *of = NULL;
+	const struct Field *rf = NULL;
+
+	switch (field_idx_mode) {
+	case SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL:
+		of = meta_original_field(target, field);
+		rf = state_current_field(
+			target, state_current_field(target, field)->fidx);
+		break;
+	case SPSLR_RANDOMIZER_FIELD_IDX_MODE_FINAL:
+		of = meta_original_field(
+			target, state_current_field(target, field)->oidx);
+		rf = state_current_field(target, field);
+		break;
+	default:
+		return -1;
+	}
+
+	info->size = of->size;
+	info->offset = rf->offset;
+	info->initial_offset = of->offset;
+	info->alignment = of->alignment;
+	info->flags = of->flags;
+
+	return 0;
+}
+
+int __init spslr_randomizer_validate_target(spslr_u64 target)
+{
+	spslr_u64 tsize, fieldcnt;
+
+	if (spslr_randomizer_get_target(target, &tsize, &fieldcnt) < 0)
+		return -1;
+
+	spslr_u64 cur_end = 0;
+
+	for (spslr_u64 i = 0; i < fieldcnt; i++) {
+		struct spslr_randomizer_field_info finfo;
+		if (spslr_randomizer_get_field(
+			    target, i, SPSLR_RANDOMIZER_FIELD_IDX_MODE_FINAL,
+			    &finfo) < 0)
+			return -1;
+
+		if (finfo.offset < cur_end)
+			return -1;
+
+		if (finfo.offset % finfo.alignment != 0)
+			return -1;
+
+		if ((finfo.flags & SPSLR_FLAG_FIELD_FIXED) &&
+		    finfo.offset != finfo.initial_offset)
+			return -1;
+
+		if (finfo.offset + finfo.size > tsize)
+			return -1;
+
+		cur_end = finfo.offset + finfo.size;
+	}
+
+	return 0;
+}
+
+// RANDOMIZATION CODE
+
+struct ShuffleRegion {
+	spslr_u64 begin;
+	spslr_u64 end;
+	spslr_u64 fill_begin;
+	spslr_u64 fill_end;
+};
+
+static spslr_u64 rand_u64(void);
+static void get_origin_region(spslr_u64 target, spslr_u64 final_idx,
+			      struct ShuffleRegion *region);
+static int option_is_valid(spslr_u64 target, spslr_u64 origin_final_idx,
+			   const struct ShuffleRegion *origin,
+			   spslr_u64 offset);
+static int pick_shuffle_option(spslr_u64 target, spslr_u64 origin_final_idx,
+			       const struct ShuffleRegion *origin,
+			       spslr_u64 alignment, spslr_u64 *selected);
+static void do_swap(spslr_u64 target, spslr_u64 origin_final_idx,
+		    const struct ShuffleRegion *origin_region,
+		    spslr_u64 new_offset);
+static void shuffle_one_target(spslr_u64 target);
+static void shuffle_target(spslr_u64 target);
+
+static spslr_u64 __init rand_u64(void)
+{
+	return spslr_env_random_u64();
+}
+
+static void __init get_origin_region(spslr_u64 target, spslr_u64 final_idx,
+				     struct ShuffleRegion *region)
+{
+	const struct spslr_target *t = &spslr_targets[target];
+	const struct Field *rf = state_current_field(target, final_idx);
+	const struct spslr_target_field *of =
+		meta_original_field(target, rf->oidx);
+
+	region->fill_begin = rf->offset;
+	region->fill_end = region->fill_begin + of->size;
+
+	if (final_idx == 0) {
+		region->begin = 0;
+	} else {
+		const struct Field *pred_rf =
+			state_current_field(target, final_idx - 1);
+		const struct spslr_target_field *pred_of =
+			meta_original_field(target, pred_rf->oidx);
+		region->begin = pred_rf->offset + pred_of->size;
+	}
+
+	if (final_idx + 1 >= t->layout->field_cnt) {
+		region->end = t->layout->size;
+	} else {
+		const struct Field *succ_rf =
+			state_current_field(target, final_idx + 1);
+		region->end = succ_rf->offset;
+	}
+}
+
+/*
+ * Check whether a proposed field move preserves layout constraints.
+ *
+ * A move is valid only if displaced fields can be packed into the freed region
+ * without violating alignment or moving fields marked fixed.
+ */
+
+static int __init option_is_valid(spslr_u64 target, spslr_u64 origin_final_idx,
+				  const struct ShuffleRegion *origin,
+				  spslr_u64 offset)
+{
+	const struct spslr_target *t = &spslr_targets[target];
+	const struct spslr_target_field *origin_of = meta_original_field(
+		target, state_current_field(target, origin_final_idx)->oidx);
+
+	// When placed at offset, field will occupy [offset, option_would_end)
+	spslr_u64 option_would_end = offset + origin_of->size;
+	if (option_would_end > t->layout->size)
+		return 0;
+
+	// Field may overlap with origin region. Moving field to offset truly frees:
+	// [true_origin_region_begin, true_origin_region_end)
+	spslr_u64 true_origin_region_begin = origin->begin;
+	spslr_u64 true_origin_region_end = origin->end;
+
+	if (offset <= origin->fill_begin &&
+	    option_would_end > true_origin_region_begin)
+		true_origin_region_begin = option_would_end;
+
+	if (offset >= origin->fill_begin && offset < true_origin_region_end)
+		true_origin_region_end = offset;
+
+	// Iterate over fields in target region [offset, option_would_end] and see if they fit into true origin region
+	spslr_u64 origin_region_ptr = true_origin_region_begin;
+	for (spslr_u64 it = 0; it < t->layout->field_cnt; it++) {
+		const struct Field *rf = state_current_field(target, it);
+		const struct spslr_target_field *of =
+			meta_original_field(target, rf->oidx);
+
+		// The field being moved does not need to go into origin region
+		if (it == origin_final_idx)
+			continue;
+
+		// Field ends before target region -> must not be moved to origin region
+		if (rf->offset + of->size <= offset)
+			continue;
+
+		// Field starts after target region -> must not be moved to origin region
+		if (rf->offset >= option_would_end)
+			break;
+
+		// Fixed fields in target region unconditionally deny option
+		if (of->flags & SPSLR_FLAG_FIELD_FIXED)
+			return 0;
+
+		// Field from target region must be moved to aligned position in origin region
+		if (origin_region_ptr % of->alignment != 0)
+			origin_region_ptr +=
+				of->alignment -
+				(origin_region_ptr % of->alignment);
+
+		origin_region_ptr += of->size;
+
+		// Field does not fit into origin region -> option not possible
+		if (origin_region_ptr > true_origin_region_end)
+			return 0;
+	}
+
+	return 1;
+}
+
+static int __init pick_shuffle_option(spslr_u64 target,
+				      spslr_u64 origin_final_idx,
+				      const struct ShuffleRegion *origin,
+				      spslr_u64 alignment, spslr_u64 *selected)
+{
+	const struct spslr_target *t = &spslr_targets[target];
+	spslr_u64 seen = 0;
+
+	/*
+	Note: Instead of looping over entire field array for each option, loops can be merged into one.
+	*/
+
+	for (spslr_u64 offset = 0; offset < t->layout->size;
+	     offset += alignment) {
+		if (!option_is_valid(target, origin_final_idx, origin, offset))
+			continue;
+
+		// Reservoir sampling -> uniform distribution with O(1) memory consumption
+		seen++;
+		if ((rand_u64() % seen) == 0)
+			*selected = offset;
+	}
+
+	return seen ? 0 : -1;
+}
+
+/*
+ * Move one field into a new slot and repack the fields it displaced.
+ *
+ * This is not a simple pairwise swap: structure layout has byte ranges and
+ * alignment holes, so the displaced region may contain several fields.
+ */
+
+static void __init do_swap(spslr_u64 target, spslr_u64 origin_idx,
+			   const struct ShuffleRegion *origin_region,
+			   spslr_u64 new_offset)
+{
+	const struct spslr_target *t = &spslr_targets[target];
+	int pulled = 0;
+
+	spslr_u64 option_fill_end = new_offset + (origin_region->fill_end -
+						  origin_region->fill_begin);
+
+	spslr_u64 true_origin_region_begin = origin_region->begin;
+	if (new_offset <= origin_region->fill_begin &&
+	    option_fill_end > true_origin_region_begin)
+		true_origin_region_begin = option_fill_end;
+
+	spslr_u64 origin_oidx = state_current_field(target, origin_idx)->oidx;
+
+	spslr_u64 origin_region_ptr = true_origin_region_begin;
+	for (spslr_u64 it = 0; it < t->layout->field_cnt; it++) {
+		struct Field *itf = state_current_field(target, it);
+
+		if (itf->oidx == origin_oidx)
+			continue;
+
+		const struct spslr_target_field *itof =
+			meta_original_field(target, itf->oidx);
+
+		if (itf->offset + itof->size <= new_offset)
+			continue;
+
+		if (itf->offset >= option_fill_end)
+			break;
+
+		spslr_u64 falign = itof->alignment;
+		if (origin_region_ptr % falign != 0)
+			origin_region_ptr +=
+				falign - (origin_region_ptr % falign);
+
+		if (!pulled) {
+			pulled = 1;
+
+			struct Field tmp = *state_current_field(target, it);
+			*state_current_field(target, it) =
+				*state_current_field(target, origin_idx);
+			*state_current_field(target, origin_idx) = tmp;
+
+			state_current_field(target, it)->offset = new_offset;
+
+			state_current_field(target, origin_idx)->offset =
+				origin_region_ptr;
+			origin_region_ptr +=
+				meta_original_field(
+					target,
+					state_current_field(target, origin_idx)
+						->oidx)
+					->size;
+			continue;
+		}
+
+		{
+			struct Field tmp = *state_current_field(target, it);
+
+			if (origin_idx >= it) {
+				for (spslr_u64 pull_it = it + 1;
+				     pull_it <= origin_idx; pull_it++)
+					*state_current_field(target,
+							     pull_it - 1) =
+						*state_current_field(target,
+								     pull_it);
+
+				*state_current_field(target, origin_idx) = tmp;
+				state_current_field(target, origin_idx)->offset =
+					origin_region_ptr;
+				origin_region_ptr +=
+					meta_original_field(
+						target,
+						state_current_field(target,
+								    origin_idx)
+							->oidx)
+						->size;
+
+				it--; // Must still look at the element now at it
+			} else {
+				for (spslr_u64 pull_it = it;
+				     pull_it > origin_idx + (spslr_u64)pulled;
+				     pull_it--)
+					*state_current_field(target, pull_it) =
+						*state_current_field(
+							target, pull_it - 1);
+
+				*state_current_field(
+					target,
+					origin_idx + (spslr_u64)pulled) = tmp;
+				state_current_field(
+					target, origin_idx + (spslr_u64)pulled)
+					->offset = origin_region_ptr;
+				origin_region_ptr +=
+					meta_original_field(
+						target,
+						state_current_field(
+							target,
+							origin_idx +
+								(spslr_u64)
+									pulled)
+							->oidx)
+						->size;
+			}
+		}
+
+		pulled++;
+	}
+
+	/*
+	 * The selected destination may not overlap any other field. It may be an
+	 * empty padding gap, or it may partially overlap the origin field itself
+	 * when the field slides into adjacent padding.
+	 *
+	 * In either case the loop above never displaces another field and
+	 * `pulled` remains zero. We still need to update the origin field's
+	 * offset and reinsert it at the correct position in final-offset order so
+	 * that the field array remains sorted.
+	 */
+	if (!pulled) {
+		struct Field origin = *state_current_field(target, origin_idx);
+		spslr_u64 insert_idx = t->layout->field_cnt;
+
+		for (spslr_u64 it = 0; it < t->layout->field_cnt; it++) {
+			if (it == origin_idx)
+				continue;
+
+			if (state_current_field(target, it)->offset >=
+			    new_offset) {
+				insert_idx = it;
+				break;
+			}
+		}
+
+		if (insert_idx > origin_idx)
+			insert_idx--;
+
+		if (origin_idx < insert_idx) {
+			for (spslr_u64 it = origin_idx + 1; it <= insert_idx;
+			     it++)
+				*state_current_field(target, it - 1) =
+					*state_current_field(target, it);
+		} else if (origin_idx > insert_idx) {
+			for (spslr_u64 it = origin_idx; it > insert_idx; it--)
+				*state_current_field(target, it) =
+					*state_current_field(target, it - 1);
+		}
+
+		*state_current_field(target, insert_idx) = origin;
+		state_current_field(target, insert_idx)->offset = new_offset;
+	}
+
+	/*
+	 * Rebuild original->final mapping for this target.
+	 */
+	for (spslr_u64 final_idx = 0; final_idx < t->layout->field_cnt;
+	     final_idx++) {
+		struct Field *rf = state_current_field(target, final_idx);
+		state_current_field(target, rf->oidx)->fidx = final_idx;
+	}
+}
+
+/*
+Note: final version should not shuffle random fields but try to shuffle each original field idx once
+*/
+static void __init shuffle_one_target(spslr_u64 target)
+{
+	const struct spslr_target *t = &spslr_targets[target];
+	if (t->layout->field_cnt == 0)
+		return;
+
+	spslr_u64 origin_final_idx = rand_u64() % t->layout->field_cnt;
+	struct Field *origin_rf = state_current_field(target, origin_final_idx);
+	const struct spslr_target_field *origin_of =
+		meta_original_field(target, origin_rf->oidx);
+
+	if (origin_of->flags & SPSLR_FLAG_FIELD_FIXED)
+		return;
+
+	struct ShuffleRegion origin_region;
+	spslr_u64 selected_option;
+
+	get_origin_region(target, origin_final_idx, &origin_region);
+
+	if (pick_shuffle_option(target, origin_final_idx, &origin_region,
+				origin_of->alignment, &selected_option) < 0)
+		return;
+
+	do_swap(target, origin_final_idx, &origin_region, selected_option);
+}
+
+static void __init shuffle_target(spslr_u64 target)
+{
+	const struct spslr_target *t = &spslr_targets[target];
+	spslr_u64 shuffle_count = t->layout->field_cnt * 2;
+
+	for (spslr_u64 i = 0; i < shuffle_count; i++)
+		shuffle_one_target(target);
+}
+
+int __init spslr_randomize(void)
+{
+	if (!fields)
+		return -1;
+
+	for (spslr_u64 tidx = 0; tidx < spslr_target_cnt; tidx++)
+		shuffle_target(tidx);
+
+	return 0;
+}
diff --git a/kernel/spslr/spslr_randomizer.h b/kernel/spslr/spslr_randomizer.h
new file mode 100644
index 000000000000..c360750894e7
--- /dev/null
+++ b/kernel/spslr/spslr_randomizer.h
@@ -0,0 +1,29 @@
+#ifndef SPSLR_RANDOMIZER_H
+#define SPSLR_RANDOMIZER_H
+
+#include "spslr_env.h"
+#include "pinpoint.h"
+
+#define SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL 1
+#define SPSLR_RANDOMIZER_FIELD_IDX_MODE_FINAL 2
+
+struct spslr_randomizer_field_info {
+	spslr_u64 size;
+	spslr_u64 offset;
+	spslr_u64 initial_offset;
+	spslr_u64 alignment;
+	spslr_u64 flags;
+};
+
+int spslr_randomizer_init(void);
+int spslr_randomize(void);
+
+int spslr_randomizer_get_target(spslr_u64 target, spslr_u64 *size,
+				spslr_u64 *fieldcnt);
+int spslr_randomizer_get_field(spslr_u64 target, spslr_u64 field,
+			       int field_idx_mode,
+			       struct spslr_randomizer_field_info *info);
+
+int spslr_randomizer_validate_target(spslr_u64 target);
+
+#endif
-- 
2.43.0

