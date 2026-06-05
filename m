Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86D2F7EF2
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691120; cv=none; b=NncJtWo2Xmmr+tpUA384v/4JlXGl9lnEYsARyH4VgPNRZlD+oHd02RXQXZxOTFKoYpH9l1fjsUM0UVhFlaMxbrVZzWm5JwGJQK7ynPJ6DY8l4Oz9VrROqYlqM9FKwWJk9udPZOTYFjZ5J17TCL95ZlexFmhh9uZp4iYiUEeKfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691120; c=relaxed/simple;
	bh=MlVewEa8g7qvd7k6RgUiNDdqII++vE0Qn6ZRNJ2lRmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9YMVXOpeYVYpNQk2ieTxxcuK2RQ+Q0TCcXGkQnOkBhjlkNTEMeENamd2LU2tCIeJDOltfnT/qaZhW+aHGyqqysj5oBpGPLQKxjXBB4NOaz0s5LbM2RzA/3+clhVkI0b9phtqTNa5TzzJZnIHpRApbE6xNItkdbqnVB5ruCX/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=qFoWRuoA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="qFoWRuoA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490af320e2aso26874145e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691117; x=1781295917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quCYK+2YFNvWgr7luvOpyg+asN2D6kwCMjWknQnQ5k0=;
        b=qFoWRuoAU60QmA/3GUzsnLP8J9ZGFoZrD3xQhuCns/LZ2kcR7t1XZyC/qxMvpHAtcA
         HoZwfXxVyo6Yr76/e6iVKfa9X7i9DSYrlQSpXEbYL0XyWH5qm6gDm5mNIE31PVRyFvUi
         oiDXiFeazps136Q24rHVg8642HUW3N/O7IEqOb8wcdrWAX2VGsuoMWpGfQh7jNXRZgVH
         S7Yjmb6xZHlwRSxDedEkTEWgThs71StvQ/PjjRGnBtaUOIWx8gEyfHFktYZBWqXIm/Xv
         KZDJHdJpeaUh4LK3xRIfS+tEGxBmgXjUN9e0+xrzs5beZ8QCatHefwRPZverqv6Vt7mx
         3vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691117; x=1781295917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=quCYK+2YFNvWgr7luvOpyg+asN2D6kwCMjWknQnQ5k0=;
        b=NMvlG9wPu9R1aXC62SqxkmisV0Co7TCWcI5iB4/3QUCwhB2aDEoML9wtftSRMkPkrR
         V/xIM4Ig+VNo0C/qoqA5DDTs8bBHmLffYINSOKp53RwtxzEIUOw7LznsWL3HdO86bzpd
         KhYfBe1JZNU8vUWDNI2qQXGCijclwLqAdutKAKylOjLFTmCvzkfFyveBsagqdtS0s69Q
         f7lJgpwO4kwZOEPy5cnZ14CQh5tvIVc7HNsct/c5lXqbpY3uQcij4u9hfkXLWbMbHnxk
         mnJd4GtUZqbGcko5lVz93mcnO8Oh1y60gLaKFVI8rT5Vm/rk6qrPp16hLkAcMI7dGyiX
         nfKQ==
X-Gm-Message-State: AOJu0Yy7U/y7blod0AP23/g7dYnGmzaSNYoVnlsNEuD3zeVCidZzgumC
	2SfFNOT/9YwFg18uxLQ0G7WJc39jAD+e5U5kS0rDh68jXUVq4v03w80cNcB7lzpgF7f5E6lmeCp
	1FAycMm12
X-Gm-Gg: Acq92OGZT4qiWwDJNM13HjH03VWUWyt3VYFnPYZMUszeFkDPF5GoKqLC13VbWPnkr80
	ifukV7mC2BUqmARLaorqLeTslFhLNu5YyQv1f0+AVymMqeA/eb5sJnlvOXdc7JhXigi5qh+tjCI
	8NSxJRlx6aksyDH2pf5fj+YBPZLLJqs5TVgYHWRQZzmUJkwMrDghf/fNQGCtC2GFCBWMnGx3BCV
	5RMBg1mx8PgCl1aurXm8AFNiD7a82mDurhEaxfoAlfWNHDD8Saeg52IN2YWLV3kOIpCaxVy877y
	vBCzE55OBk/xQ+0TWnANYyBsF3mvz0cMiU3Ov5SCv7K6/MAaOHOWX0Wtud3l5MuBaNRbKWk5666
	nrov+YmYU+3r84vZ+b3/ig231dYVznTnfVnjVBjkEGaDI2CHkXPyUSKxxErOdEz8FsDEGuQriQO
	JeR+vtISZC6RnQAAGZ2hpzwnZkfGz/cth5uX204SFaydZ4/HDsGJAlsuQpU4bMwIq1ngtz9TqWm
	3Vw+XqcmzZD/US2L3T25PWlTYsUwXOmoKS4LSYGBct3tA/p9A==
X-Received: by 2002:a05:600c:35d4:b0:490:b8d3:5dcc with SMTP id 5b1f17b1804b1-490c25e4634mr91131915e9.19.1780691116615;
        Fri, 05 Jun 2026 13:25:16 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm168442995e9.7.2026.06.05.13.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:25:16 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de
Subject: [RFC 4/7] SPSLR selfpatch
Date: Fri,  5 Jun 2026 22:25:08 +0200
Message-ID: <20260605202511.79272-5-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605202511.79272-1-yjn@yjn-systems.com>
References: <20260605202511.79272-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 include/linux/spslr.h           |  48 ++++
 kernel/Makefile                 |   2 +
 kernel/spslr/Makefile           |   5 +
 kernel/spslr/spslr.c            | 267 ++++++++++++++++++++++
 kernel/spslr/spslr_env.c        |  74 +++++++
 kernel/spslr/spslr_env.h        |  42 ++++
 kernel/spslr/spslr_list.h       |  63 ++++++
 kernel/spslr/spslr_list_link.h  |  21 ++
 kernel/spslr/spslr_randomizer.c | 382 ++++++++++++++++++++++++++++++++
 kernel/spslr/spslr_randomizer.h |  26 +++
 10 files changed, 930 insertions(+)
 create mode 100644 include/linux/spslr.h
 create mode 100644 kernel/spslr/Makefile
 create mode 100644 kernel/spslr/spslr.c
 create mode 100644 kernel/spslr/spslr_env.c
 create mode 100644 kernel/spslr/spslr_env.h
 create mode 100644 kernel/spslr/spslr_list.h
 create mode 100644 kernel/spslr/spslr_list_link.h
 create mode 100644 kernel/spslr/spslr_randomizer.c
 create mode 100644 kernel/spslr/spslr_randomizer.h

diff --git a/include/linux/spslr.h b/include/linux/spslr.h
new file mode 100644
index 000000000000..2609bd06aae4
--- /dev/null
+++ b/include/linux/spslr.h
@@ -0,0 +1,48 @@
+#ifndef SPSLR_SELFPATCH_H
+#define SPSLR_SELFPATCH_H
+
+#define SPSLR_MODULE_SYM_IPIN_CNT "spslr_ipin_cnt"
+#define SPSLR_MODULE_SYM_IPINS "spslr_ipins"
+#define SPSLR_MODULE_SYM_IPIN_OP_CNT "spslr_ipin_op_cnt"
+#define SPSLR_MODULE_SYM_IPIN_OPS "spslr_ipin_ops"
+#define SPSLR_MODULE_SYM_DPIN_CNT "spslr_dpin_cnt"
+#define SPSLR_MODULE_SYM_DPINS "spslr_dpins"
+
+enum spslr_viability {
+	SPSLR_VIABLE,
+	SPSLR_NONVIABLE
+};
+
+enum spslr_error {
+	SPSLR_OK,
+	SPSLR_ERROR_RANDOMIZER_INIT,
+	SPSLR_ERROR_INITIAL_TARGET_LAYOUT,
+	SPSLR_ERROR_RANDOMIZED_TARGET_LAYOUT,
+	SPSLR_ERROR_RANDOMIZE,
+	SPSLR_ERROR_REORDER_BUFFER,
+	SPSLR_ERROR_UNINITIALIZED,
+	SPSLR_ERROR_ALREADY_PATCHED,
+	SPSLR_ERROR_PATCH_DPINS,
+	SPSLR_ERROR_PATCH_IPINS,
+	SPSLR_ERROR_META_INCOMPLETE
+};
+
+struct spslr_status {
+	enum spslr_viability viability;
+	enum spslr_error error;
+};
+
+struct spslr_module {
+	const void* ipin_cnt;
+	const void* ipins;
+	const void* ipin_op_cnt;
+	const void* ipin_ops;
+	const void* dpin_cnt;
+	const void* dpins;
+};
+
+struct spslr_status spslr_init(void);
+struct spslr_status spslr_selfpatch(void);
+struct spslr_status spslr_patch_module(const struct spslr_module* m);
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
index 000000000000..c67c7b1295ca
--- /dev/null
+++ b/kernel/spslr/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_SPSLR) += spslr.o spslr_env.o spslr_randomizer.o
+
+CFLAGS_REMOVE_spslr.o += $(SPSLR_PLUGIN_FLAGS)
+CFLAGS_REMOVE_spslr_env.o += $(SPSLR_PLUGIN_FLAGS)
+CFLAGS_REMOVE_spslr_randomizer.o += $(SPSLR_PLUGIN_FLAGS)
diff --git a/kernel/spslr/spslr.c b/kernel/spslr/spslr.c
new file mode 100644
index 000000000000..89c3c79f3aa1
--- /dev/null
+++ b/kernel/spslr/spslr.c
@@ -0,0 +1,267 @@
+#include <linux/spslr.h>
+
+#include "spslr_randomizer.h"
+#include "spslr_env.h"
+#include "spslr_list_link.h"
+
+#define SPSLR_SANITY_CHECK
+
+static int spslr_patch_dpins(const struct spslr_dpin* dpins, spslr_u32 cnt);
+static int spslr_patch_dpin(void* addr, spslr_u32 target);
+static int spslr_patch_ipins(const struct spslr_ipin* ipins, spslr_u32 cnt,
+	const struct spslr_ipin_op* ipin_ops, spslr_u32 op_cnt);
+
+static int reorder_object(void* dst, const void* src, spslr_u32 target);
+static int spslr_calculate_ipin_value(const struct spslr_ipin_op* ipin_ops, spslr_u32 op_cnt, spslr_u32 start, spslr_s64* res);
+
+static void* reorder_buffer = NULL;
+
+static int allocate_reorder_buffer(void);
+
+static int initialized = 0, patched = 0;
+static enum spslr_viability viable = SPSLR_VIABLE;
+
+struct spslr_status __init spslr_init(void) {
+	if (initialized)
+		return (struct spslr_status) { .viability = viable, .error = SPSLR_OK };
+
+	if (spslr_randomizer_init() < 0)
+		return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_RANDOMIZER_INIT };
+
+#ifdef SPSLR_SANITY_CHECK
+	for (spslr_u32 tidx = 0; tidx < spslr_target_cnt; tidx++) {
+		if (spslr_randomizer_validate_target(tidx) < 0)
+			return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_INITIAL_TARGET_LAYOUT };
+	}
+#endif
+
+	if (spslr_randomize() < 0)
+		return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_RANDOMIZE };
+
+#ifdef SPSLR_SANITY_CHECK
+	for (spslr_u32 tidx = 0; tidx < spslr_target_cnt; tidx++) {
+		if (spslr_randomizer_validate_target(tidx) < 0)
+			return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_RANDOMIZED_TARGET_LAYOUT };
+	}
+#endif
+
+	if (allocate_reorder_buffer() < 0)
+		return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_REORDER_BUFFER };
+
+	initialized = 1;
+	return (struct spslr_status) { .viability = viable, .error = SPSLR_OK };
+}
+
+struct spslr_status __init spslr_selfpatch(void) {
+	if (patched)
+		return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_ALREADY_PATCHED };
+
+	if (!initialized)
+		return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_UNINITIALIZED };
+
+	viable = SPSLR_NONVIABLE;
+
+	if (spslr_patch_dpins(spslr_dpins, spslr_dpin_cnt) < 0)
+		return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_PATCH_DPINS };
+
+	if (spslr_patch_ipins(spslr_ipins, spslr_ipin_cnt, spslr_ipin_ops, spslr_ipin_op_cnt) < 0)
+		return (struct spslr_status) { .viability = viable, .error = SPSLR_ERROR_PATCH_IPINS };
+
+	viable = SPSLR_VIABLE;
+
+	patched = 1;
+	return (struct spslr_status) { .viability = viable, .error = SPSLR_OK };
+}
+
+struct spslr_status spslr_patch_module(const struct spslr_module* m) {
+	if (!initialized)
+		return (struct spslr_status) { .viability = SPSLR_VIABLE, .error = SPSLR_ERROR_UNINITIALIZED };
+
+	if (!m || !m->ipin_cnt || !m->ipins || !m->ipin_op_cnt || !m->ipin_ops || !m->dpin_cnt || !m->dpins)
+		return (struct spslr_status) { .viability = SPSLR_VIABLE, .error = SPSLR_ERROR_META_INCOMPLETE };
+
+	spslr_u32 module_ipin_cnt = *(const spslr_u32*)m->ipin_cnt;
+	const struct spslr_ipin* module_ipins = (const struct spslr_ipin*)m->ipins;
+	spslr_u32 module_ipin_op_cnt = *(const spslr_u32*)m->ipin_op_cnt;
+	const struct spslr_ipin_op* module_ipin_ops = (const struct spslr_ipin_op*)m->ipin_ops;
+	spslr_u32 module_dpin_cnt = *(const spslr_u32*)m->dpin_cnt;
+	const struct spslr_dpin* module_dpins = (const struct spslr_dpin*)m->dpins;
+
+	if (spslr_patch_dpins(module_dpins, module_dpin_cnt) < 0)
+		return (struct spslr_status) { .viability = SPSLR_NONVIABLE, .error = SPSLR_ERROR_PATCH_DPINS };
+
+	if (spslr_patch_ipins(module_ipins, module_ipin_cnt, module_ipin_ops, module_ipin_op_cnt) < 0)
+		return (struct spslr_status) { .viability = SPSLR_NONVIABLE, .error = SPSLR_ERROR_PATCH_IPINS };
+
+	return (struct spslr_status) { .viability = SPSLR_VIABLE, .error = SPSLR_OK };
+}
+
+static int __init allocate_reorder_buffer(void) {
+	if (reorder_buffer)
+		return 0;
+
+	spslr_u32 max_target_size = 0;
+	for (spslr_u32 i = 0; i < spslr_target_cnt; i++) {
+		if (spslr_targets[i].size > max_target_size)
+			max_target_size = spslr_targets[i].size;
+	}
+
+	reorder_buffer = spslr_env_malloc(max_target_size);
+	if (!reorder_buffer)
+		return -1;
+
+	return 0;
+}
+
+static int spslr_patch_dpins(const struct spslr_dpin* dpins, spslr_u32 cnt) {
+	for (spslr_u32 dpidx = 0; dpidx < cnt; dpidx++)  {
+		const struct spslr_dpin* dp = &dpins[dpidx];
+		if (spslr_patch_dpin((void*)dp->addr, dp->target) < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+static int reorder_object(void* dst, const void* src, spslr_u32 target) {
+	spslr_u32 field_count;
+	if (spslr_randomizer_get_target(target, NULL, &field_count))
+		return -1;
+
+	const spslr_u8* src_countable = (const spslr_u8*)src;
+	spslr_u8* dst_countable = (spslr_u8*)dst;
+
+	for (spslr_u32 i = 0; i < field_count; i++) {
+		struct spslr_randomizer_field_info finfo;
+		if (spslr_randomizer_get_field(target, i, SPSLR_RANDOMIZER_FIELD_IDX_MODE_FINAL, &finfo))
+			return -1;
+
+		spslr_env_memcpy(dst_countable + finfo.offset, src_countable + finfo.initial_offset, finfo.size);
+	}
+
+	return 0;
+}
+
+static int spslr_patch_dpin(void* addr, spslr_u32 target) {
+	if (target >= spslr_target_cnt)
+		return -1;
+
+	const struct spslr_target* t = &spslr_targets[target];
+
+	spslr_env_memset(reorder_buffer, 0, t->size);
+
+	if (reorder_object(reorder_buffer, addr, target) < 0)
+		return -1;
+
+	if (spslr_env_poke_data(addr, reorder_buffer, t->size) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int spslr_patch_ipins(const struct spslr_ipin* ipins, spslr_u32 cnt,
+		const struct spslr_ipin_op* ipin_ops, spslr_u32 op_cnt) {
+	for (spslr_u32 ipidx = 0; ipidx < cnt; ipidx++) {
+		const struct spslr_ipin* ip = &ipins[ipidx];
+
+		spslr_s64 value;
+		if (spslr_calculate_ipin_value(ipin_ops, op_cnt, ip->program, &value) < 0)
+			return -1;
+
+		switch (ip->size) {
+			case 1:
+				if (spslr_env_poke_text_8((void*)ip->addr, (spslr_u8)value) < 0)
+					return -1;
+				break;
+			case 2:
+				if (spslr_env_poke_text_16((void*)ip->addr, (spslr_u16)value) < 0)
+					return -1;
+				break;
+			case 4:
+				if (spslr_env_poke_text_32((void*)ip->addr, (spslr_u32)value) < 0)
+					return -1;
+				break;
+			case 8:
+				if (spslr_env_poke_text_64((void*)ip->addr, (spslr_u64)value) < 0)
+					return -1;
+				break;
+			default:
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int spslr_calculate_ipin_value(const struct spslr_ipin_op* ipin_ops, spslr_u32 op_cnt, spslr_u32 start, spslr_s64* res) {
+	if (!res)
+		return -1;
+
+	*res = 0;
+
+	spslr_u32 pc = start;
+	while (1) {
+		if (pc >= op_cnt)
+			return -1;
+
+		int end_flag = 0;
+
+		const struct spslr_ipin_op* op = &ipin_ops[pc++];
+		switch (op->code) {
+			case SPSLR_IPIN_OP_PATCH:
+				end_flag = 1;
+				break;
+			case SPSLR_IPIN_OP_ADD_INITIAL_OFFSET:
+				{
+					struct spslr_randomizer_field_info finfo;
+					if (spslr_randomizer_get_field(op->op0.add_initial_offset_target,
+							op->op1.add_initial_offset_field, SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL, &finfo))
+						return -1;
+
+					*res += finfo.initial_offset;
+				}
+				break;
+			case SPSLR_IPIN_OP_ADD_OFFSET:
+				{
+					struct spslr_randomizer_field_info finfo;
+					if (spslr_randomizer_get_field(op->op0.add_offset_target,
+							op->op1.add_offset_field, SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL, &finfo))
+						return -1;
+
+					*res += finfo.offset;
+				}
+				break;
+			case SPSLR_IPIN_OP_SUB_INITIAL_OFFSET:
+				{
+					struct spslr_randomizer_field_info finfo;
+					if (spslr_randomizer_get_field(op->op0.sub_initial_offset_target,
+							op->op1.sub_initial_offset_field, SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL, &finfo))
+						return -1;
+
+					*res -= finfo.initial_offset;
+				}
+				break;
+			case SPSLR_IPIN_OP_SUB_OFFSET:
+				{
+					struct spslr_randomizer_field_info finfo;
+					if (spslr_randomizer_get_field(op->op0.sub_offset_target,
+							op->op1.sub_offset_field, SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL, &finfo))
+						return -1;
+
+					*res -= finfo.offset;
+				}
+				break;
+			case SPSLR_IPIN_OP_ADD_CONST:
+				*res += op->op0.add_const_value;
+				break;
+			default:
+				return -1;
+		}
+
+		if (end_flag)
+			break;
+	}
+
+	return 0;
+}
+
diff --git a/kernel/spslr/spslr_env.c b/kernel/spslr/spslr_env.c
new file mode 100644
index 000000000000..d4a79d532c06
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
+void* __init spslr_env_malloc(spslr_u32 n) {
+	if (!n)
+		n = 1;
+
+	/*
+	 * Hook runs before slab allocators are available.
+	 * memblock_alloc() is the correct early-boot allocator.
+	 * Reserve the memory to ensure it is not freed when handed to later allocator.
+	 */
+	void* res = memblock_alloc(n, SMP_CACHE_BYTES);
+
+	if (!res)
+		return res;
+
+	memblock_reserve(__pa(res), n);
+	return res;
+}
+
+int spslr_env_poke_data(void* dst, const void* src, spslr_u32 n) {
+	memcpy(dst, src, n);
+	return 0;
+}
+
+void spslr_env_memset(void* dst, int v, spslr_u32 n) {
+	memset(dst, v, n);
+}
+
+void spslr_env_memcpy(void* dst, const void* src, spslr_u32 n) {
+	memcpy(dst, src, n);
+}
+
+spslr_u32 __init spslr_env_random_u32(void) {
+	return get_random_u32(); // Hook runs after random_init_early() 
+}
+
diff --git a/kernel/spslr/spslr_env.h b/kernel/spslr/spslr_env.h
new file mode 100644
index 000000000000..09260dcb2192
--- /dev/null
+++ b/kernel/spslr/spslr_env.h
@@ -0,0 +1,42 @@
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
+#define __printf(fmt_pos, arg_pos) __attribute__((format(printf, fmt_pos, arg_pos)))
+#endif
+
+#ifndef NULL
+#define NULL ((void*)0)
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
+int spslr_env_poke_text_8(void* dst, spslr_u8 value);
+int spslr_env_poke_text_16(void* dst, spslr_u16 value);
+int spslr_env_poke_text_32(void* dst, spslr_u32 value);
+int spslr_env_poke_text_64(void* dst, spslr_u64 value);
+int spslr_env_poke_data(void* dst, const void* src, spslr_u32 n);
+void* spslr_env_malloc(spslr_u32 n);
+void spslr_env_memset(void* dst, int v, spslr_u32 n);
+void spslr_env_memcpy(void* dst, const void* src, spslr_u32 n);
+spslr_u32 spslr_env_random_u32(void);
+
+#endif
diff --git a/kernel/spslr/spslr_list.h b/kernel/spslr/spslr_list.h
new file mode 100644
index 000000000000..baf713e8e893
--- /dev/null
+++ b/kernel/spslr/spslr_list.h
@@ -0,0 +1,63 @@
+#ifndef SPSLR_LIST_H
+#define SPSLR_LIST_H
+
+#include "spslr_env.h"
+
+#define SPSLR_IPIN_OP_PATCH 1
+#define SPSLR_IPIN_OP_ADD_INITIAL_OFFSET 2
+#define SPSLR_IPIN_OP_SUB_INITIAL_OFFSET 3
+#define SPSLR_IPIN_OP_ADD_OFFSET 4
+#define SPSLR_IPIN_OP_SUB_OFFSET 5
+#define SPSLR_IPIN_OP_ADD_CONST 6
+
+#define SPSLR_FLAG_FIELD_FIXED 1
+
+struct spslr_target {
+	spslr_u32 size;
+	spslr_u32 fieldcnt;
+	spslr_u32 fieldoff; // Offset into spslr_target_field array
+} __packed;
+
+struct spslr_target_field {
+	spslr_u32 offset;
+	spslr_u32 size;
+	spslr_u32 alignment;
+	spslr_u32 flags;
+} __packed;
+
+struct spslr_ipin {
+	spslr_u64 addr;
+	spslr_u32 size;
+	spslr_u32 program; // Index in spslr_ipin_op array
+} __packed;
+
+struct spslr_ipin_op {
+	spslr_u32 code;
+
+	union {
+		spslr_u32 patch_unused;
+		spslr_u32 add_initial_offset_target;
+		spslr_u32 sub_initial_offset_target;
+		spslr_u32 add_offset_target;
+		spslr_u32 sub_offset_target;
+		spslr_s32 add_const_value;
+	} op0;
+
+	union {
+		spslr_u32 patch_unused;
+		spslr_u32 add_initial_offset_field;
+		spslr_u32 sub_initial_offset_field;
+		spslr_u32 add_offset_field;
+		spslr_u32 sub_offset_field;
+		spslr_u32 add_const_unused;
+	} op1;
+} __packed;
+
+struct spslr_dpin {
+	spslr_u64 addr;
+	spslr_u32 target; // Index in spslr_target array
+} __packed;
+
+#undef __packed
+
+#endif
diff --git a/kernel/spslr/spslr_list_link.h b/kernel/spslr/spslr_list_link.h
new file mode 100644
index 000000000000..91a4e12f52b4
--- /dev/null
+++ b/kernel/spslr/spslr_list_link.h
@@ -0,0 +1,21 @@
+#ifndef SPSLR_LIST_LINK_H
+#define SPSLR_LIST_LINK_H
+
+#include "spslr_list.h"
+
+extern const spslr_u32 spslr_target_cnt;
+extern const struct spslr_target spslr_targets[];
+
+extern const spslr_u32 spslr_target_field_cnt;
+extern const struct spslr_target_field spslr_target_fields[];
+
+extern const spslr_u32 spslr_ipin_cnt;
+extern const struct spslr_ipin spslr_ipins[];
+
+extern const spslr_u32 spslr_ipin_op_cnt;
+extern const struct spslr_ipin_op spslr_ipin_ops[];
+
+extern const spslr_u32 spslr_dpin_cnt;
+extern const struct spslr_dpin spslr_dpins[];
+
+#endif
diff --git a/kernel/spslr/spslr_randomizer.c b/kernel/spslr/spslr_randomizer.c
new file mode 100644
index 000000000000..44dd94102656
--- /dev/null
+++ b/kernel/spslr/spslr_randomizer.c
@@ -0,0 +1,382 @@
+#include "spslr_randomizer.h"
+
+#include "spslr_list_link.h"
+#include "spslr_env.h"
+
+struct Field {
+	spslr_u32 offset; /* Final field offset -> fields[i].offset = offset of field i in final layout */
+	spslr_u32 oidx; /* Original field idx -> fields[i].oidx = original position of field i in final layout */
+	spslr_u32 fidx; /* Final field idx -> fields[i].fidx = randomized/final position of original field i */
+};
+
+static struct Field* fields;
+
+int __init spslr_randomizer_init(void) {
+	fields = (struct Field*)spslr_env_malloc(sizeof(struct Field) * spslr_target_field_cnt);
+	if (!fields)
+		return -1;
+
+	for (spslr_u32 tidx = 0; tidx < spslr_target_cnt; tidx++) {
+		const struct spslr_target* t = &spslr_targets[tidx];
+
+		for (spslr_u32 fidx = 0; fidx < t->fieldcnt; fidx++) {
+			spslr_u32 gfidx = t->fieldoff + fidx;
+
+			const struct spslr_target_field* srcf = &spslr_target_fields[gfidx];
+			struct Field* dstf = &fields[gfidx];
+
+			dstf->offset = srcf->offset;
+			dstf->oidx = fidx;
+			dstf->fidx = fidx;
+		}
+	}
+
+	return 0;
+}
+
+int spslr_randomizer_get_target(spslr_u32 target, spslr_u32* size, spslr_u32* fieldcnt) {
+	if (target >= spslr_target_cnt)
+		return -1;
+
+	const struct spslr_target* t = &spslr_targets[target];
+
+	if (size)
+		*size = t->size;
+
+	if (fieldcnt)
+		*fieldcnt = t->fieldcnt;
+
+	return 0;
+}
+
+int spslr_randomizer_get_field(spslr_u32 target, spslr_u32 field, int field_idx_mode,
+		struct spslr_randomizer_field_info* info) {
+	if (target >= spslr_target_cnt)
+		return -1;
+
+	if (!info)
+		return 0;
+
+	const struct spslr_target* t = &spslr_targets[target];
+
+	if (field >= t->fieldcnt)
+		return -1;
+
+	const struct spslr_target_field* of = NULL;
+	const struct Field* rf = NULL;
+
+	switch (field_idx_mode) {
+		case SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL:
+			of = &spslr_target_fields[t->fieldoff + field];
+			rf = &fields[t->fieldoff + fields[t->fieldoff + field].fidx];
+			break;
+		case SPSLR_RANDOMIZER_FIELD_IDX_MODE_FINAL:
+			of = &spslr_target_fields[t->fieldoff + fields[t->fieldoff + field].oidx];
+			rf = &fields[t->fieldoff + field];
+			break;
+		default:
+			return -1;
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
+int __init spslr_randomizer_validate_target(spslr_u32 target) {
+	spslr_u32 tsize, fieldcnt;
+
+	if (spslr_randomizer_get_target(target, &tsize, &fieldcnt) < 0)
+		return -1;
+
+	spslr_u32 cur_end = 0; 
+    
+	for (spslr_u32 i = 0; i < fieldcnt; i++) {
+		struct spslr_randomizer_field_info finfo;
+		if (spslr_randomizer_get_field(target, i, SPSLR_RANDOMIZER_FIELD_IDX_MODE_FINAL, &finfo) < 0)
+			return -1;
+
+		if (finfo.offset < cur_end)
+			return -1;
+
+		if (finfo.offset % finfo.alignment != 0)
+			return -1;
+
+		if ((finfo.flags & SPSLR_FLAG_FIELD_FIXED) && finfo.offset != finfo.initial_offset)
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
+	spslr_u32 begin; 
+	spslr_u32 end;
+	spslr_u32 fill_begin;
+	spslr_u32 fill_end;
+};
+
+static spslr_u32 rand_u32(void);
+static struct Field* get_rfield(spslr_u32 target, spslr_u32 final_idx);
+static const struct spslr_target_field* get_ofield(spslr_u32 target, spslr_u32 orig_idx);
+static void get_origin_region(spslr_u32 target, spslr_u32 final_idx, struct ShuffleRegion* region);
+static int pick_shuffle_option(spslr_u32 target, spslr_u32 origin_final_idx,
+	const struct ShuffleRegion* origin, spslr_u32 alignment, spslr_u32* selected);
+static void do_swap(spslr_u32 target, spslr_u32 origin_final_idx,
+	const struct ShuffleRegion* origin_region, spslr_u32 new_offset);
+static void shuffle_one_target(spslr_u32 target);
+static void shuffle_target(spslr_u32 target);
+
+static spslr_u32 rand_u32(void) {
+	return spslr_env_random_u32();
+}
+
+static struct Field* __init get_rfield(spslr_u32 target, spslr_u32 final_idx) {
+	const struct spslr_target* t = &spslr_targets[target];
+	return &fields[t->fieldoff + final_idx];
+}
+
+static const struct spslr_target_field* __init get_ofield(spslr_u32 target, spslr_u32 orig_idx) {
+	const struct spslr_target* t = &spslr_targets[target];
+	return &spslr_target_fields[t->fieldoff + orig_idx];
+}
+
+static void __init get_origin_region(spslr_u32 target, spslr_u32 final_idx, struct ShuffleRegion* region) {
+	const struct spslr_target* t = &spslr_targets[target];
+	const struct Field* rf = get_rfield(target, final_idx);
+	const struct spslr_target_field* of = get_ofield(target, rf->oidx);
+
+	region->fill_begin = rf->offset;
+	region->fill_end = region->fill_begin + of->size;
+
+	if (final_idx == 0) {
+		region->begin = 0;
+	} else {
+		const struct Field* pred_rf = get_rfield(target, final_idx - 1);
+		const struct spslr_target_field* pred_of = get_ofield(target, pred_rf->oidx);
+		region->begin = pred_rf->offset + pred_of->size;
+	}
+
+	if (final_idx + 1 >= t->fieldcnt) {
+		region->end = t->size;
+	} else {
+		const struct Field* succ_rf = get_rfield(target, final_idx + 1);
+		region->end = succ_rf->offset;
+	}
+}
+
+static int __init option_is_valid(spslr_u32 target, spslr_u32 origin_final_idx, const struct ShuffleRegion* origin, spslr_u32 offset) {
+	const struct spslr_target* t = &spslr_targets[target];
+	const struct spslr_target_field* origin_of =
+		get_ofield(target, get_rfield(target, origin_final_idx)->oidx);
+
+	// When placed at offset, field will occupy [offset, option_would_end)
+	spslr_u32 option_would_end = offset + origin_of->size;
+	if (option_would_end > t->size)
+		return 0;
+
+	// Field may overlap with origin region. Moving field to offset truly frees:
+	// [true_origin_region_begin, true_origin_region_end)
+	spslr_u32 true_origin_region_begin = origin->begin;
+	spslr_u32 true_origin_region_end = origin->end;
+
+	if (offset <= origin->fill_begin && option_would_end > true_origin_region_begin)
+		true_origin_region_begin = option_would_end;
+
+	if (offset >= origin->fill_begin && offset < true_origin_region_end)
+		true_origin_region_end = offset;
+
+	// Iterate over fields in target region [offset, option_would_end] and see if they fit into true origin region
+	spslr_u32 origin_region_ptr = true_origin_region_begin;
+	for (spslr_u32 it = 0; it < t->fieldcnt; it++) {
+		const struct Field* rf = get_rfield(target, it);
+		const struct spslr_target_field* of = get_ofield(target, rf->oidx);
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
+			origin_region_ptr += of->alignment - (origin_region_ptr % of->alignment);
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
+static int __init pick_shuffle_option(spslr_u32 target, spslr_u32 origin_final_idx, const struct ShuffleRegion* origin,
+		spslr_u32 alignment, spslr_u32* selected) {
+	const struct spslr_target* t = &spslr_targets[target];
+	spslr_u32 seen = 0;
+
+	/*
+	Note: Instead of looping over entire field array for each option, loops can be merged into one.
+	*/
+
+	for (spslr_u32 offset = 0; offset < t->size; offset += alignment) {
+		if (!option_is_valid(target, origin_final_idx, origin, offset))
+			continue;
+
+		// Reservoir sampling -> uniform distribution with O(1) memory consumption
+		seen++;
+		if ((rand_u32() % seen) == 0)
+			*selected = offset;
+	}
+
+	return seen ? 0 : -1;
+}
+
+static void __init do_swap(spslr_u32 target, spslr_u32 origin_idx,
+		const struct ShuffleRegion* origin_region, spslr_u32 new_offset) {
+	const struct spslr_target* t = &spslr_targets[target];
+	int pulled = 0;
+
+	spslr_u32 option_fill_end = new_offset + (origin_region->fill_end - origin_region->fill_begin);
+
+	spslr_u32 true_origin_region_begin = origin_region->begin;
+	if (new_offset <= origin_region->fill_begin && option_fill_end > true_origin_region_begin)
+		true_origin_region_begin = option_fill_end;
+
+	spslr_u32 origin_oidx = get_rfield(target, origin_idx)->oidx;
+
+	spslr_u32 origin_region_ptr = true_origin_region_begin;
+	for (spslr_u32 it = 0; it < t->fieldcnt; it++) {
+		struct Field* itf = get_rfield(target, it);
+
+		if (itf->oidx == origin_oidx)
+			continue;
+
+		const struct spslr_target_field* itof = get_ofield(target, itf->oidx);
+
+		if (itf->offset + itof->size <= new_offset)
+			continue;
+
+		if (itf->offset >= option_fill_end)
+			break;
+
+		spslr_u32 falign = itof->alignment;
+		if (origin_region_ptr % falign != 0)
+			origin_region_ptr += falign - (origin_region_ptr % falign);
+
+		if (!pulled) {
+			pulled = 1;
+
+			struct Field tmp = *get_rfield(target, it);
+			*get_rfield(target, it) = *get_rfield(target, origin_idx);
+			*get_rfield(target, origin_idx) = tmp;
+
+			get_rfield(target, it)->offset = new_offset;
+
+			get_rfield(target, origin_idx)->offset = origin_region_ptr;
+			origin_region_ptr += get_ofield(target, get_rfield(target, origin_idx)->oidx)->size;
+			continue;
+		}
+
+		{
+			struct Field tmp = *get_rfield(target, it);
+
+			if (origin_idx >= it) {
+				for (spslr_u32 pull_it = it + 1; pull_it <= origin_idx; pull_it++)
+					*get_rfield(target, pull_it - 1) = *get_rfield(target, pull_it);
+
+				*get_rfield(target, origin_idx) = tmp;
+				get_rfield(target, origin_idx)->offset = origin_region_ptr;
+				origin_region_ptr += get_ofield(target, get_rfield(target, origin_idx)->oidx)->size;
+
+				it--; // Must still look at the element now at it
+			} else {
+				for (spslr_u32 pull_it = it; pull_it > origin_idx + (spslr_u32)pulled; pull_it--)
+					*get_rfield(target, pull_it) = *get_rfield(target, pull_it - 1);
+
+				*get_rfield(target, origin_idx + (spslr_u32)pulled) = tmp;
+				get_rfield(target, origin_idx + (spslr_u32)pulled)->offset = origin_region_ptr;
+				origin_region_ptr += get_ofield(target, get_rfield(target, origin_idx + (spslr_u32)pulled)->oidx)->size;
+			}
+		}
+
+		pulled++;
+	}
+
+	/*
+	 * Rebuild original->final mapping for this target.
+	 */
+	for (spslr_u32 final_idx = 0; final_idx < t->fieldcnt; final_idx++) {
+		struct Field* rf = get_rfield(target, final_idx);
+		fields[t->fieldoff + rf->oidx].fidx = final_idx;
+	}
+}
+
+/*
+Note: final version should not shuffle random fields but try to shuffle each original field idx once
+*/
+static void __init shuffle_one_target(spslr_u32 target) {
+	const struct spslr_target* t = &spslr_targets[target];
+	if (t->fieldcnt == 0)
+		return;
+
+	spslr_u32 origin_final_idx = rand_u32() % t->fieldcnt;
+	struct Field* origin_rf = get_rfield(target, origin_final_idx);
+	const struct spslr_target_field* origin_of = get_ofield(target, origin_rf->oidx);
+
+	if (origin_of->flags & SPSLR_FLAG_FIELD_FIXED)
+		return;
+
+	struct ShuffleRegion origin_region;
+	spslr_u32 selected_option;
+
+	get_origin_region(target, origin_final_idx, &origin_region);
+
+	if (pick_shuffle_option(target, origin_final_idx, &origin_region,
+			origin_of->alignment, &selected_option) < 0)
+		return;
+
+	do_swap(target, origin_final_idx, &origin_region, selected_option);
+}
+
+static void __init shuffle_target(spslr_u32 target) {
+	const struct spslr_target* t = &spslr_targets[target];
+	spslr_u32 shuffle_count = t->fieldcnt * 2;
+
+	for (spslr_u32 i = 0; i < shuffle_count; i++)
+		shuffle_one_target(target);
+}
+
+int __init spslr_randomize(void) {
+	if (!fields)
+		return -1;
+
+	for (spslr_u32 tidx = 0; tidx < spslr_target_cnt; tidx++)
+		shuffle_target(tidx);
+
+	return 0;
+}
+
diff --git a/kernel/spslr/spslr_randomizer.h b/kernel/spslr/spslr_randomizer.h
new file mode 100644
index 000000000000..b240257d28b6
--- /dev/null
+++ b/kernel/spslr/spslr_randomizer.h
@@ -0,0 +1,26 @@
+#ifndef SPSLR_RANDOMIZER_H
+#define SPSLR_RANDOMIZER_H
+
+#include "spslr_env.h"
+
+#define SPSLR_RANDOMIZER_FIELD_IDX_MODE_ORIGINAL 1
+#define SPSLR_RANDOMIZER_FIELD_IDX_MODE_FINAL 2
+
+struct spslr_randomizer_field_info {
+	spslr_u32 size;
+	spslr_u32 offset;
+	spslr_u32 initial_offset;
+	spslr_u32 alignment;
+	spslr_u32 flags;
+};
+
+int spslr_randomizer_init(void);
+int spslr_randomize(void);
+
+int spslr_randomizer_get_target(spslr_u32 target, spslr_u32* size, spslr_u32* fieldcnt);
+int spslr_randomizer_get_field(spslr_u32 target, spslr_u32 field, int field_idx_mode,
+	struct spslr_randomizer_field_info* info);
+
+int spslr_randomizer_validate_target(spslr_u32 target);
+
+#endif
-- 
2.43.0

