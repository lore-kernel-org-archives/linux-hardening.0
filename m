Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B133A962E
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574785; cv=none; b=rmunoiR9a0l22o34jBZQnTh4YcEqYtoobTf8Q5QesEZb/DMr7AYllEvmKPbCQhimE4mxXj+IUH+ig0WGfOjKlReq9VEAfZiESQn1tWMs2761IzDd01Qld8sEcu7SvHFfi2lo9eJNVhqQsrOk9xy/iuTp8uatLCL4QSsASUkJy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574785; c=relaxed/simple;
	bh=ddg1TiBzfmxYokYD9lx4TN1R+ypHVJGwLdK+JynGg9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwhtadGP8hvIDlkl3b8U1JPX1cpPZHGEhr7Vgxsc6//MAJ9EnhdHLSYCHdxNDU4hqWARQeKmmzYFfkCpeExSLktx49Tt8xSf+2MliqdpLIOkrmeyhmHYyzXaGLh/nX5scfgTaRKzUUN65E4NMZyOuEtaKHq+wJjVpMBBxBVHCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=ub93uWb4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="ub93uWb4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495635a85d2so7059325e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784574780; x=1785179580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J7L2KY4SdHJXgXkR49tG1QlCrSHG7Ro8bzv6kAARvpU=;
        b=ub93uWb4kcyJJ9qow+Ik4pZGYkn1Wq+oRjjXudl6gUXM2azkDoACUuXvgV6E+pE+4F
         OE8mWvU0xjVB2xAoxv6J9IEc9CeTbAtqW5Pm0gzj+AXpM1Oe/7XU2OJIqZkttTWdqaoC
         KHWh7a/JH8SnOo6eBlLvwZg5CjQT2f5itomis/WjztJOvK1w2qYjGJf5tESr/X2hLFoA
         BhJxa/5QYSWF7KaeX3gGs+cIhknm79buWIlkrsFvX2PHluDv6gGDy9l3qI1C/krLfW1i
         vGvmYQ+DFkKSQMbYk2i7GYexDNubBILtAhaQlv2zLbPA4L/UK4MxTt03X95BX/qSTXo8
         PMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574780; x=1785179580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J7L2KY4SdHJXgXkR49tG1QlCrSHG7Ro8bzv6kAARvpU=;
        b=RctVoFkqPOQNLKXZ1vOUC/0gJ4pI2JcJUSz40Y1zeWQnCnnEXMdASpOSoXDB3FZLjJ
         SOT8eRcajKoB34UzDgreEl0tQPmqpQZhmFhjfbC49b4m2h5gIVqGqiCOn/oCxZfPAn9c
         oepnoHt/0wGh1Rs3YjDwIWlNVtuLAhVfULyO3Yncilpgba62P/+kOjr/cYuvor5GkIi/
         wd86YCyfq5HnIlle3/lrMuRtQDitq6FQKZnODPYA9hm22sTYRjb1tAr+Jyai20X3piOF
         onIRrrj1srGZAs1Uo61oiwqcwkRiF7ZPo5eBZhpXgv2i1dPGAB5tacnKYSLEBSsGx8pB
         iSVA==
X-Gm-Message-State: AOJu0YxKeVU/uDM3TTC/rAf9g6sLx5hHw9j3eRlcFVwCnLeTAaZqsebn
	7UHOvCmwrbDBiREA0D26SKuza71uikIls8etQL9Q+RvblvHq6G0lbaNcBRLAeo1HDR/lw2w0vO9
	BCLzm+odT
X-Gm-Gg: AfdE7cnhSeDGjU/NuZyOH3PrIyWGghWK0ZYRsar9f7S81XSEYebEEU02fJxVYa/TdGe
	4RGUFi70a/UIIo9FfcWiSTM05CdqqUs8J9UxID/9R9BjSNW/kRTvp6vMvcXsTxJPQtZyxpqywqO
	n0rnI9leuFQlG0/nBEhdn8O45gq0k+4xPDOIeZ9rmFWQjCt08nYDO2tKcVeqm4Hrzw7qCUKfQEW
	KyqiMo36o/iGsXxMtxO1MP/1IvLWuMzsYeNfLcYZ422yQtqLMPTXYh6p8AZMzFhsUb8F8cYJn9q
	6+Gi5j5C097EOhlDaPzISxJ6qaXckIrLID7nqYiRTyOaP6n2nO4CGrzgzJhWDiTRT4zQ/zh/mtF
	1mRp/gnydp6Fkc7RQBzeuvSLnPmjDUETDnoOCPtiJs569GdFGyOcU61W7obLXTEIl3t0vCtviLU
	Q7wW+e36bx3umRdsjGjrzmIoSZJQ0EZeVKC/44WVjPyg6Jq95xy21JF0b4anK2euN4cCBhIX4UQ
	3+LP1dm321Fgbu7MTs=
X-Received: by 2002:a05:600c:1993:b0:495:64c6:84e9 with SMTP id 5b1f17b1804b1-4956533caf4mr8178815e9.0.1784574779489;
        Mon, 20 Jul 2026 12:12:59 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00c9c364f8ed993120.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:c9c3:64f8:ed99:3120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653d38dbsm9231695e9.15.2026.07.20.12.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:12:59 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v3 2/5] Selfpatch runtime
Date: Mon, 20 Jul 2026 21:12:58 +0200
Message-ID: <20260720191258.21602-1-yjn@yjn-systems.com>
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
 include/linux/spslr.h           |  82 ++++
 include/sanemaker/traps.h       | 135 +++++++
 kernel/Makefile                 |   2 +
 kernel/spslr/Makefile           |   7 +
 kernel/spslr/pinpoint.h         |  76 ++++
 kernel/spslr/sanemaker_traps.c  | 117 ++++++
 kernel/spslr/spslr.c            | 555 +++++++++++++++++++++++++++
 kernel/spslr/spslr_env.c        |  74 ++++
 kernel/spslr/spslr_env.h        |  45 +++
 kernel/spslr/spslr_randomizer.c | 646 ++++++++++++++++++++++++++++++++
 kernel/spslr/spslr_randomizer.h |  29 ++
 11 files changed, 1768 insertions(+)
 create mode 100644 include/linux/spslr.h
 create mode 100644 include/sanemaker/traps.h
 create mode 100644 kernel/spslr/Makefile
 create mode 100644 kernel/spslr/pinpoint.h
 create mode 100644 kernel/spslr/sanemaker_traps.c
 create mode 100644 kernel/spslr/spslr.c
 create mode 100644 kernel/spslr/spslr_env.c
 create mode 100644 kernel/spslr/spslr_env.h
 create mode 100644 kernel/spslr/spslr_randomizer.c
 create mode 100644 kernel/spslr/spslr_randomizer.h

diff --git a/include/linux/spslr.h b/include/linux/spslr.h
new file mode 100644
index 000000000000..2606d66c39f0
--- /dev/null
+++ b/include/linux/spslr.h
@@ -0,0 +1,82 @@
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
+/* Use spslr_target_hash(type) to get a pointer to the 16 byte md5 hash
+   of the target type. If type is not an SPSLR target, NULL is returned. */
+
+extern const unsigned char *__spslr_target_hash(const void *);
+
+#define __SPSLR_CAT2(a, b) a##b
+#define __SPSLR_CAT(a, b) __SPSLR_CAT2(a, b)
+
+#define __spslr_target_hash_impl(T, n)                                      \
+	({                                                                  \
+		extern T __SPSLR_CAT(__spslr_target_hash_type_anchor_, n);  \
+		__spslr_target_hash(                                        \
+			&__SPSLR_CAT(__spslr_target_hash_type_anchor_, n)); \
+	})
+
+#define spslr_target_hash(T) __spslr_target_hash_impl(T, __COUNTER__)
+
+#endif /* CONFIG_SPSLR */
+
+#endif
diff --git a/include/sanemaker/traps.h b/include/sanemaker/traps.h
new file mode 100644
index 000000000000..bcb75198b18b
--- /dev/null
+++ b/include/sanemaker/traps.h
@@ -0,0 +1,135 @@
+#ifndef SANEMAKER_TRAPS_H
+#define SANEMAKER_TRAPS_H
+
+/* Define trap API attributes */
+
+#define SANEMAKER_TRAP_API extern __attribute__((__visibility__("default")))
+
+/* Use sanemaker_target_tag(&obj) to make sanemaker watch memops to that object */
+
+#ifdef CONFIG_SANEMAKER
+
+SANEMAKER_TRAP_API
+void __sanemaker_target_tag_trap(const void *ptr, const unsigned char *target);
+
+#define sanemaker_target_tag(ptr, type) \
+	__sanemaker_target_tag_trap(ptr, spslr_target_hash(type))
+
+#else
+
+#define sanemaker_target_tag(ptr, type)
+
+#endif
+
+/* Use sanemaker_target_untag(&obj) to make sanemaker stop watching memops to that object */
+
+#ifdef CONFIG_SANEMAKER
+
+SANEMAKER_TRAP_API
+void __sanemaker_target_untag_trap(const void *ptr);
+
+#define sanemaker_target_untag(ptr) __sanemaker_target_untag_trap(ptr)
+
+#else
+
+#define sanemaker_target_untag(ptr)
+
+#endif
+
+/* The sanemaker_finish_layout(&fieldarr, &target_hash) should be called
+   by spslr selfpatch when a target layout has been randomized */
+
+#ifdef CONFIG_SANEMAKER
+
+SANEMAKER_TRAP_API
+void __sanemaker_finish_layout_trap(const void *fields,
+				    const unsigned char *target);
+
+#define sanemaker_finish_layout(fields, target) \
+	__sanemaker_finish_layout_trap(fields, target)
+
+#else
+
+#define sanemaker_finish_layout(fields, target)
+
+#endif
+
+/* Use sanemaker_fetch(what, default) to let sanemaker make decisions at runtime */
+
+typedef enum {
+	SANEMAKER_FETCH_SPSLR_ENABLED = 1,
+} sanemaker_fetch_t;
+
+#ifdef CONFIG_SANEMAKER
+
+SANEMAKER_TRAP_API
+int __sanemaker_fetch_trap(sanemaker_fetch_t what, int def);
+
+#define sanemaker_fetch(what, def) __sanemaker_fetch_trap(what, def)
+
+#else
+
+#define sanemaker_fetch(what, def) (def)
+
+#endif
+
+/* Use sanemaker_signal(signal) to control sanemaker behavior */
+
+typedef enum {
+	SANEMAKER_SIGNAL_PATCH_BOUNDARY = 1, /* the image has been patched */
+	SANEMAKER_SIGNAL_PAUSE = 2,
+	SANEMAKER_SIGNAL_RESUME = 3,
+} sanemaker_signal_t;
+
+#ifdef CONFIG_SANEMAKER
+
+SANEMAKER_TRAP_API
+void __sanemaker_signal_trap(sanemaker_signal_t signal);
+
+#define sanemaker_signal(signal) __sanemaker_signal_trap(signal)
+
+#else
+
+#define sanemaker_signal(signal)
+
+#endif
+
+/* Use sanemaker_new_image(name, ptr) and sanemaker_new_image_text(image, begin, end)
+   to allow normalization of program counters inside dynamically loaded text segments */
+
+#ifdef CONFIG_SANEMAKER
+
+SANEMAKER_TRAP_API
+void __sanemaker_new_image_trap(const char *name, const void *base);
+
+SANEMAKER_TRAP_API
+void __sanemaker_new_image_text_trap(const char *image, const void *begin,
+				     const void *end);
+
+SANEMAKER_TRAP_API
+void __sanemaker_drop_image_trap(const char *image);
+
+SANEMAKER_TRAP_API
+void __sanemaker_drop_image_text_trap(const char *image, const void *begin,
+				      const void *end);
+
+#define sanemaker_new_image(name, base) __sanemaker_new_image_trap(name, base)
+
+#define sanemaker_new_image_text(image, begin, end) \
+	__sanemaker_new_image_text_trap(image, begin, end)
+
+#define sanemaker_drop_image(image) __sanemaker_drop_image_trap(image)
+
+#define sanemaker_drop_image_text(image, begin, end) \
+	__sanemaker_drop_image_text_trap(image, begin, end)
+
+#else
+
+#define sanemaker_new_image(name, base)
+#define sanemaker_new_image_text(image, begin, end)
+#define sanemaker_drop_image(image)
+#define sanemaker_drop_image_text(image, begin, end)
+
+#endif
+
+#endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 1e1a31673577..cddfbff9f9f0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -142,6 +142,8 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+obj-$(CONFIG_SPSLR) += spslr/
+
 CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
 CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
 obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
diff --git a/kernel/spslr/Makefile b/kernel/spslr/Makefile
new file mode 100644
index 000000000000..a736d0aab05c
--- /dev/null
+++ b/kernel/spslr/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_SPSLR) += spslr.o spslr_env.o spslr_randomizer.o
+obj-$(CONFIG_SANEMAKER) += sanemaker_traps.o
+
+CFLAGS_REMOVE_spslr.o += $(PINPOINT_PLUGIN_CFLAGS)
+CFLAGS_REMOVE_spslr_env.o += $(PINPOINT_PLUGIN_CFLAGS)
+CFLAGS_REMOVE_spslr_randomizer.o += $(PINPOINT_PLUGIN_CFLAGS)
+CFLAGS_REMOVE_sanemaker_traps.o += $(PINPOINT_PLUGIN_CFLAGS)
diff --git a/kernel/spslr/pinpoint.h b/kernel/spslr/pinpoint.h
new file mode 100644
index 000000000000..39ca81e6491d
--- /dev/null
+++ b/kernel/spslr/pinpoint.h
@@ -0,0 +1,76 @@
+#ifndef SPSLR_PINPOINT_H
+#define SPSLR_PINPOINT_H
+
+#include "spslr_env.h"
+
+/* Field must remain at its original offset during layout randomization. */
+#define SPSLR_FLAG_FIELD_FIXED 1
+
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
+	unsigned char hash[16];
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
diff --git a/kernel/spslr/sanemaker_traps.c b/kernel/spslr/sanemaker_traps.c
new file mode 100644
index 000000000000..63aa1a4b9182
--- /dev/null
+++ b/kernel/spslr/sanemaker_traps.c
@@ -0,0 +1,117 @@
+#include <sanemaker/traps.h>
+
+#define SANEMAKER_TRAP_FN					\
+	__attribute__((__noinline__, __noclone__, __used__,	\
+		__externally_visible__,				\
+		__visibility__("default"), __naked__))
+
+/* Sanemaker reads object pointer from rdi and target hash pointer from rsi */
+SANEMAKER_TRAP_FN
+void __sanemaker_target_tag_trap(const void *ptr, const unsigned char *target)
+{
+	__asm__ volatile(
+		".globl __sanemaker_target_tag_trap_incision\n"
+		".type __sanemaker_target_tag_trap_incision, @notype\n"
+		"__sanemaker_target_tag_trap_incision:\n"
+		"ret\n"
+	);
+}
+
+/* Sanemaker reads object pointer from rdi */
+SANEMAKER_TRAP_FN
+void __sanemaker_target_untag_trap(const void *ptr)
+{
+	__asm__ volatile(
+		".globl __sanemaker_target_untag_trap_incision\n"
+		".type __sanemaker_target_untag_trap_incision, @notype\n"
+		"__sanemaker_target_untag_trap_incision:\n"
+		"ret\n"
+	);
+}
+
+/* Sanemaker reads field pointer from rdi and target hash pointer from rsi */
+SANEMAKER_TRAP_FN
+void __sanemaker_finish_layout_trap(const void *fields, const unsigned char *target)
+{
+	__asm__ volatile(
+		".globl __sanemaker_finish_layout_trap_incision\n"
+		".type __sanemaker_finish_layout_trap_incision, @notype\n"
+		"__sanemaker_finish_layout_trap_incision:\n"
+		"ret\n"
+	);
+}
+
+/* Sanemaker reads name from rdi and overwrites rsi to set a value */
+SANEMAKER_TRAP_FN
+int __sanemaker_fetch_trap(sanemaker_fetch_t what, int def)
+{
+	__asm__ volatile(
+		".globl __sanemaker_fetch_trap_incision\n"
+		".type __sanemaker_fetch_trap_incision, @notype\n"
+		"__sanemaker_fetch_trap_incision:\n"
+		"nop\n"
+		"movl %esi, %eax\n"
+		"ret\n"
+	);
+}
+
+/* Sanemaker reads the signal event from rdi */
+SANEMAKER_TRAP_FN
+void __sanemaker_signal_trap(sanemaker_signal_t signal)
+{
+	__asm__ volatile(
+		".globl __sanemaker_signal_trap_incision\n"
+		".type __sanemaker_signal_trap_incision, @notype\n"
+		"__sanemaker_signal_trap_incision:\n"
+		"ret\n"
+	);
+}
+
+/* Sanemaker reads name from rdi and base from rsi */
+SANEMAKER_TRAP_FN
+void __sanemaker_new_image_trap(const char *name, const void *base)
+{
+	__asm__ volatile(
+		".globl __sanemaker_new_image_trap_incision\n"
+		".type __sanemaker_new_image_trap_incision, @notype\n"
+		"__sanemaker_new_image_trap_incision:\n"
+		"ret\n"
+	);
+}
+
+/* Sanemaker reads image name from rdi, begin from rsi and end from rdx */
+SANEMAKER_TRAP_FN
+void __sanemaker_new_image_text_trap(const char *image, const void *begin, const void *end)
+{
+	__asm__ volatile(
+		".globl __sanemaker_new_image_text_trap_incision\n"
+		".type __sanemaker_new_image_text_trap_incision, @notype\n"
+		"__sanemaker_new_image_text_trap_incision:\n"
+		"ret\n"
+	);
+}
+
+/* Sanemaker reads image name from rdi */
+SANEMAKER_TRAP_FN
+void __sanemaker_drop_image_trap(const char *image)
+{
+	__asm__ volatile(
+		".globl __sanemaker_drop_image_trap_incision\n"
+		".type __sanemaker_drop_image_trap_incision, @notype\n"
+		"__sanemaker_drop_image_trap_incision:\n"
+		"ret\n"
+	);
+}
+
+/* Sanemaker reads image name from rdi, begin from rsi and end from rdx */
+SANEMAKER_TRAP_FN
+void __sanemaker_drop_image_text_trap(const char *image, const void *begin, const void *end)
+{
+	__asm__ volatile(
+		".globl __sanemaker_drop_image_text_trap_incision\n"
+		".type __sanemaker_drop_image_text_trap_incision, @notype\n"
+		"__sanemaker_drop_image_text_trap_incision:\n"
+		"ret\n"
+	);
+}
+
diff --git a/kernel/spslr/spslr.c b/kernel/spslr/spslr.c
new file mode 100644
index 000000000000..5ef36731f75e
--- /dev/null
+++ b/kernel/spslr/spslr.c
@@ -0,0 +1,555 @@
+#include <linux/spslr.h>
+#include <sanemaker/traps.h>
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
+	if (sanemaker_fetch(SANEMAKER_FETCH_SPSLR_ENABLED, 1)) {
+		if (spslr_randomize() < 0)
+			return (struct spslr_status){
+				.viability = viable,
+				.error = SPSLR_ERROR_RANDOMIZE
+			};
+	}
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
+	if (sanemaker_fetch(SANEMAKER_FETCH_SPSLR_ENABLED, 1)) {
+		for (const struct spslr_unit *unit = start_units;
+		     unit != stop_units; unit++) {
+			err = spslr_patch_unit(unit, target_map_buffer,
+					       reorder_buffer);
+			if (err != SPSLR_OK)
+				goto finish;
+		}
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
+	sanemaker_signal(SANEMAKER_SIGNAL_PATCH_BOUNDARY);
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
+	int res = -1;
+	const struct spslr_target *t = &spslr_targets[target];
+
+	sanemaker_signal(SANEMAKER_SIGNAL_PAUSE);
+
+	spslr_env_memset(reorder_buffer, 0, t->layout->size);
+
+	if (reorder_object(reorder_buffer, addr, target) < 0)
+		goto finish;
+
+	if (spslr_env_poke_data(addr, reorder_buffer, t->layout->size) < 0)
+		goto finish;
+
+	res = 0;
+finish:
+	sanemaker_signal(SANEMAKER_SIGNAL_RESUME);
+	return res;
+}
+
+static int spslr_ipin_value_fits(spslr_u64 value, spslr_u64 size)
+{
+	if (size == 0)
+		return 0;
+
+	spslr_u64 bound = (spslr_u64)1 << (8 * size);
+	return value < bound;
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
+		if (value < 0 ||
+		    !spslr_ipin_value_fits((spslr_u64)value, ip->size))
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
index 000000000000..879ead0a2384
--- /dev/null
+++ b/kernel/spslr/spslr_randomizer.c
@@ -0,0 +1,646 @@
+#include "spslr_randomizer.h"
+
+#include "spslr_env.h"
+#include "pinpoint.h"
+
+#include <sanemaker/traps.h>
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
+static struct Field *state_current_field_base(spslr_u64 target);
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
+static struct Field *state_current_field_base(spslr_u64 target)
+{
+	if (target >= spslr_target_cnt)
+		return NULL;
+
+	spslr_u64 field_base_idx = field_base_indices[target];
+	return fields + field_base_idx;
+}
+
+static struct Field *state_current_field(spslr_u64 target, spslr_u64 field)
+{
+	if (target >= spslr_target_cnt)
+		return NULL;
+
+	struct Field *field_base = state_current_field_base(target);
+	const struct spslr_target_layout *layout = spslr_targets[target].layout;
+
+	if (!field_base || field >= layout->field_cnt)
+		return NULL;
+
+	return field_base + field;
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
+		if (finfo.alignment == 0)
+			return -1;
+
+		if (finfo.offset % finfo.alignment != 0)
+			return -1;
+
+		if ((finfo.flags & SPSLR_FLAG_FIELD_FIXED) &&
+		    finfo.offset != finfo.initial_offset)
+			return -1;
+
+		if (finfo.offset > tsize)
+			return -1;
+
+		/* Zero-sized metadata entries occupy no storage. */
+		if (finfo.size == 0)
+			continue;
+
+		if (finfo.offset < cur_end)
+			return -1;
+
+		/* Avoid overflow in offset + size. */
+		if (finfo.size > tsize - finfo.offset)
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
+		/*
+		 * Zero-sized metadata entries occupy no storage, but they still
+		 * mark an ordering boundary. A moved field must neither straddle
+		 * one nor start at one: equal-offset entries have an ordering
+		 * relationship that do_swap() does not preserve while displacing
+		 * fields.
+         */
+		if (of->size == 0) {
+			if (rf->offset >= offset &&
+			    rf->offset < option_would_end)
+				return 0;
+
+			continue;
+		}
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
+		// Zero-sized metadata entries occupy no storage.
+		if (itof->size == 0)
+			continue;
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
+	/* Zero-sized entries are metadata markers, not shuffleable storage. */
+	if (origin_of->size == 0)
+		return;
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
+
+	sanemaker_finish_layout(state_current_field_base(target), t->hash);
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

