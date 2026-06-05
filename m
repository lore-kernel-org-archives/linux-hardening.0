Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7703E1216
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691121; cv=none; b=CqdfPpkpDUakC1omaDJ29Bw/sbxF0Wx5DSkZwmsrQUeGYqxMBxvcMoNpmUt5cWoe4/IGmRe5bRLk4xJtoygdBYFzs/DD7NEWxio4RSaB+gksXMTzwFmYOfPXBDDSu0D1WMOGUepUJVR63uHPaiRikZip++Db8PVuuz8q+gKSE28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691121; c=relaxed/simple;
	bh=QfHsASPh+oovD81FJs6/3emtWIT4NSODWgRlxbiDsuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ni2vxAGRfAx7dGz1poMa16Zm9Xth28OW6+ZQVAvDOHdbI6JuIkak2BCR57pxgdc0WgdqRKXJ+i68lsvcaS4SVB3gfJ9O1dUt6bvljB0pjnsvjkLlqXbWUpr1u1ku0pislo6yNKv53VwTehFUbVFzF9ygP33YTn0IQ56P7tAwpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=LkndyO5n; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="LkndyO5n"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so25422615e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691117; x=1781295917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kp9foTKxxVbxhnS1Knkf9GQbg/aPlRxDw6WHV+hk1s=;
        b=LkndyO5n/FpAij1pOpG+3mCeCeMcqMpUmT719IGGI48NLCKF76XfnHdBjtvNtfKvgm
         JiL8ERvdH9h+SDbf2O6JYsUYmXRLx3aafHmASq60iXhraQ7kbWMpbRHKIfwLzFDqbfH0
         j7RMKs9AtdpMhIuRa2CVtgpYyFcIgg4ALbPOUOU1ZZrONNW+R3x/pfvTU9KK3ExvkjWJ
         4F9b5ES/wN1MFn5lhVskwncrp9mSLBebtIboHYX8J9KIkW7n7OICTznovY20EdO0ECsr
         fGlif7i9+BL1cxeiZ/3hT8qGYnPnbNLQn38dnvjBFHU/52UxAaT/rUGmC+q+LsBV/UFH
         X7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691117; x=1781295917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1kp9foTKxxVbxhnS1Knkf9GQbg/aPlRxDw6WHV+hk1s=;
        b=KFCf0atJk2ydYyE1KHabnNvbWtN3VCgPv45nEYBFkRjhb/pE6uCnEEaQYpAtxPyCPN
         FEljOvDLEkqqkckAdN+y2AOgKrxHIthXyqVc/Up4kbAYrBAuKYkhkQ41DOGGN+S2rgNL
         /QFP3vj6Gb5W6Pp5X+8TxKb7CUAA9LEl+EGs2dpTh9Fkgn6or6O2V42iTrYEO8UrNo6s
         ZnUQSXhGXqYhjkCMKEl02vb6xLMVbc1Qvmp/UhT1ZuLzdkx/ZAtnt0scLkJ/G4IlGXHw
         CMtFbI78RrVkcSPXX4LypyVIUuCImw6A4rnGxIwZnrOB0PJ1Rt8Q/0bAlUYb3KgU9olW
         04AQ==
X-Gm-Message-State: AOJu0YxULs0rPC+abBNWzkI+kOPrFtB1IqXNfZnhOyWryXIg+dAi2NcZ
	2mloeM7KwBIytMsg44/b2R9yR7RUJepaqmnrE5Xwe4l8n1sdNoD3UeoTx1XPJuAeAVK2qCu0+iJ
	r8Pkgpup0
X-Gm-Gg: Acq92OGf/IaR2uen1AsZabCGMU2FEi4BEIE7WcBow2oP+H4l4QE9Q5yk6QRVzuYpmFf
	bsVdpZw8tCS4pzOSHqcvx0WHSyZApxnqFemjl8uvTHC7PrvIFkPueac0yjSLJal7jjKOwVl2CmO
	zIT8agLf4sh9FUNie2V87ZmT0BCH6qfx4t0hNSqpcHw4LbiYxgmOaMwUz3NAMFWECxMIm5AXdQF
	yTPGbuhLIZfNHWqivOtxQFlyRZ3ckR10i+mTgPWm35T/UbUlQWbS+5liKD3lAmlYqkHoyOCEXLM
	HMRVUcfLfJ8VVYDn5wB2HAboz3VqDRCS+kY279sFCnVq6N7kwyztPmDm4sGI1F2vEtyRXtKHfJB
	3ClPsfYenDLfYjjmDbwJgeJCvtyusbRzuqO5VfldTRNW+Jd9CxOu3XyRstt9BWyy16j5GToVrO/
	uwiyNmRSgQwfm2tbA6PyLs8igqnaangkCzYSONWWiaj/mb81ptA2tIRCT024pBBcuA8FPcTueAf
	4cKCIDR/cyBxDdlEfFA3maJjLOfmsdUGl6phV/uIllsjWGi/Q==
X-Received: by 2002:a05:600c:1d2a:b0:490:bbc1:d508 with SMTP id 5b1f17b1804b1-490c258f3femr85443055e9.1.1780691117398;
        Fri, 05 Jun 2026 13:25:17 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm168442995e9.7.2026.06.05.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:25:16 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de
Subject: [RFC 5/7] BPSLR task_struct integration
Date: Fri,  5 Jun 2026 22:25:09 +0200
Message-ID: <20260605202511.79272-6-yjn@yjn-systems.com>
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
 Makefile                              | 131 ++++++++++++++++++++++++++
 arch/x86/boot/compressed/Makefile     |   2 +
 arch/x86/kernel/vmlinux.lds.S         |   8 ++
 drivers/firmware/efi/libstub/Makefile |   2 +
 include/linux/compiler_types.h        |  12 +++
 include/linux/sched.h                 |  50 +++++-----
 init/Kconfig                          |   7 ++
 init/main.c                           |  15 +++
 kernel/module/main.c                  |  62 ++++++++++++
 scripts/Makefile.build                |   9 +-
 scripts/Makefile.modfinal             | 131 +++++++++++++++++++++++++-
 scripts/Makefile.vmlinux              |   4 +
 scripts/Makefile.vmlinux_o            |   1 +
 scripts/link-vmlinux.sh               |   5 +
 14 files changed, 413 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 68a8faff2543..d491db3db2e8 100644
--- a/Makefile
+++ b/Makefile
@@ -796,6 +796,39 @@ include/config/auto.conf:
 endif # may-sync-config
 endif # need-config
 
+# Outside config for make clean
+SPSLR_METADIR := $(objtree)/.spslr-meta
+SPSLR_VMLINUX_TARGET_MAP := $(objtree)/.vmlinux-spslr-targets
+
+ifdef CONFIG_SPSLR
+
+export SPSLR_METADIR
+export SPSLR_VMLINUX_TARGET_MAP
+export SPSLR_TOOL_PINPOINT := $(srctree)/tools/spslr/pinpoint.so
+export SPSLR_TOOL_PATCHCOMPILE := $(srctree)/tools/spslr/patchcompile
+
+# Use pinpoint plugin for kernel objects
+
+SPSLR_PLUGIN      := -fplugin=$(SPSLR_TOOL_PINPOINT)
+SPSLR_PLUGIN_META := -fplugin-arg-pinpoint-metadir=$(SPSLR_METADIR)
+SPSLR_PLUGIN_SRC  := -fplugin-arg-pinpoint-srcroot=$(srctree)
+export SPSLR_PLUGIN_FLAGS := -D__SPSLR__ $(SPSLR_PLUGIN) $(SPSLR_PLUGIN_META) $(SPSLR_PLUGIN_SRC)
+
+KBUILD_CFLAGS += $(SPSLR_PLUGIN_FLAGS)
+
+endif
+
+# Supress warnings generated by newer gcc-16
+
+KBUILD_CFLAGS += -Wno-address-of-packed-member
+KBUILD_CFLAGS += -Wno-format-truncation
+KBUILD_CFLAGS += -Wno-unused-but-set-variable
+KBUILD_CFLAGS += -Wno-dangling-pointer
+KBUILD_CFLAGS += -Wno-unterminated-string-initialization
+KBUILD_CFLAGS += -Wno-format-overflow
+KBUILD_CFLAGS += -Wno-stringop-truncation
+KBUILD_CFLAGS += -Wno-stringop-overread
+
 KBUILD_CFLAGS	+= -fno-delete-null-pointer-checks
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
@@ -1142,6 +1175,104 @@ targets += vmlinux.a
 vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt FORCE
 	$(call if_changed,ar_vmlinux.a)
 
+# Outside config for make clean
+SPSLR_VMLINUX_SPSLR_SECTION_ASM := $(objtree)/spslr_section.S
+SPSLR_VMLINUX_SPSLR_SECTION_OBJ := $(objtree)/spslr_section.o
+SPSLR_VMLINUX_SPSLR_LIST := $(objtree)/.vmlinux-spslr-files
+SPSLR_VMLINUX_PATCHCOMPILE_STAMP := $(objtree)/.vmlinux-spslr-patchcompile
+
+ifdef CONFIG_SPSLR
+
+targets += $(SPSLR_VMLINUX_SPSLR_SECTION_ASM) $(SPSLR_VMLINUX_SPSLR_SECTION_OBJ) $(SPSLR_VMLINUX_SPSLR_LIST) $(SPSLR_VMLINUX_TARGET_MAP) $(SPSLR_VMLINUX_PATCHCOMPILE_STAMP)
+
+SPSLR_VMLINUX_LINK_INPUTS := vmlinux.a $(KBUILD_VMLINUX_LIBS)
+
+export SPSLR_VMLINUX_SPSLR_SECTION_OBJ
+
+quiet_cmd_gen_spslr_list = SPSLRLST $@
+      cmd_gen_spslr_list = set -e; \
+	tmp=$@.tmp; \
+	rm -f $$tmp; \
+	for in_f in $(SPSLR_VMLINUX_LINK_INPUTS); do \
+		printf 'SPSLR input: %s\n' "$$in_f" >&2; \
+		case "$$in_f" in \
+		*.a) \
+			$(AR) t "$$in_f" ;; \
+		*.o) \
+			printf '%s\n' "$$in_f" ;; \
+		esac; \
+	done | awk '!seen[$$0]++' | while read -r obj; do \
+		spslr="$(SPSLR_METADIR)/$${obj%.o}.c.spslr"; \
+		printf 'SPSLR map: obj=%s spslr=%s\n' "$$obj" "$$spslr" >&2; \
+		if [ -f "$$spslr" ]; then \
+			printf 'SPSLR found: %s\n' "$$spslr" >&2; \
+			printf '%s\n' "$$spslr"; \
+		else \
+			printf 'SPSLR missing: obj=%s expected=%s\n' "$$obj" "$$spslr" >&2; \
+		fi; \
+	done > $$tmp; \
+	printf 'SPSLR wrote manifest: %s\n' "$$tmp" >&2; \
+	if [ -s "$$tmp" ]; then \
+		printf 'SPSLR manifest entries: %s\n' "$$(wc -l < "$$tmp")" >&2; \
+	else \
+		printf 'SPSLR manifest is empty: %s\n' "$$tmp" >&2; \
+	fi; \
+	mv -f $$tmp $@; \
+	printf 'SPSLR final manifest: %s\n' "$@" >&2
+
+$(SPSLR_VMLINUX_SPSLR_LIST): $(SPSLR_VMLINUX_LINK_INPUTS) FORCE
+	$(call if_changed,gen_spslr_list)
+
+quiet_cmd_spslr_patchcompile_vmlinux = SPSLR   $@
+      cmd_spslr_patchcompile_vmlinux = set -e; \
+	if [ ! -s $(SPSLR_VMLINUX_SPSLR_LIST) ]; then \
+		echo "No .spslr files found for vmlinux link inputs" >&2; \
+		exit 1; \
+	fi; \
+	targets_tmp="$(SPSLR_VMLINUX_TARGET_MAP).tmp"; \
+	trap 'rm -f "$$targets_tmp"' EXIT; \
+	$(SPSLR_TOOL_PATCHCOMPILE) \
+		--out $(SPSLR_VMLINUX_SPSLR_SECTION_ASM) \
+		--dump-targets "$$targets_tmp" \
+		--verbose \
+		$$(cat $(SPSLR_VMLINUX_SPSLR_LIST)); \
+	if ! cmp -s "$$targets_tmp" "$(SPSLR_VMLINUX_TARGET_MAP)"; then \
+		mv -f "$$targets_tmp" "$(SPSLR_VMLINUX_TARGET_MAP)"; \
+	else \
+		rm -f "$$targets_tmp"; \
+	fi
+
+quiet_cmd_spslr_as = AS      $@
+      cmd_spslr_as = $(CC) $(KBUILD_AFLAGS) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) -c -o $@ $<
+
+$(SPSLR_VMLINUX_PATCHCOMPILE_STAMP): $(SPSLR_VMLINUX_SPSLR_LIST) $(SPSLR_TOOL_PATCHCOMPILE) FORCE
+	$(call if_changed,spslr_patchcompile_vmlinux)
+	@touch $@
+
+$(SPSLR_VMLINUX_SPSLR_SECTION_ASM): $(SPSLR_VMLINUX_PATCHCOMPILE_STAMP)
+	@:
+
+$(SPSLR_VMLINUX_TARGET_MAP): $(SPSLR_VMLINUX_PATCHCOMPILE_STAMP)
+	@:
+
+$(SPSLR_VMLINUX_SPSLR_SECTION_OBJ): $(SPSLR_VMLINUX_SPSLR_SECTION_ASM) FORCE
+	$(call if_changed,spslr_as)
+
+vmlinux_o: $(SPSLR_VMLINUX_SPSLR_SECTION_OBJ)
+
+modules: $(SPSLR_VMLINUX_TARGET_MAP)
+
+endif
+
+CLEAN_FILES += $(SPSLR_METADIR) \
+	       $(SPSLR_VMLINUX_SPSLR_SECTION_ASM) \
+	       $(SPSLR_VMLINUX_SPSLR_SECTION_OBJ) \
+	       $(SPSLR_VMLINUX_SPSLR_LIST) \
+	       $(SPSLR_VMLINUX_TARGET_MAP) \
+	       $(SPSLR_VMLINUX_PATCHCOMPILE_STAMP)
+
+clean: tools/spslr_clean
+
 PHONY += vmlinux_o
 vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..bd0685bb1ef3 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -44,6 +44,8 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
+KBUILD_CFLAGS += -std=gnu11
+
 # sev.c indirectly includes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
 # that the compiler finds it even with out-of-tree builds (make O=/some/path).
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index feb8102a9ca7..b5e5cfc1d9db 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -185,6 +185,14 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+#ifdef CONFIG_SPSLR
+		. = ALIGN(8);
+		__spslr_start = .;
+		KEEP(*(.spslr))
+		KEEP(*(.spslr.*))
+		__spslr_end = .;
+#endif
+
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ed4e8ddbe76a..cfc99d5a0e80 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,6 +20,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fno-asynchronous-unwind-tables \
 				   $(CLANG_FLAGS)
 
+cflags-$(CONFIG_X86_64) += -std=gnu11 -Wno-address-of-packed-member
+
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index bb343136ddd0..427de1e2a787 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -793,6 +793,7 @@ struct task_struct {
 	 * scheduling-critical items should be added above here.
 	 */
 	randomized_struct_fields_start
+	spslr_struct_fields_start
 
 	void				*stack;
 	refcount_t			usage;
@@ -828,12 +829,12 @@ struct task_struct {
 	int				normal_prio;
 	unsigned int			rt_priority;
 
-	struct sched_entity		se;
-	struct sched_rt_entity		rt;
+	struct sched_entity		se __spslr_field_fixed;
+	struct sched_rt_entity		rt __spslr_field_fixed;
 	struct sched_dl_entity		dl;
 	struct sched_dl_entity		*dl_server;
 #ifdef CONFIG_SCHED_CLASS_EXT
-	struct sched_ext_entity		scx;
+	struct sched_ext_entity		scx __spslr_field_fixed;
 #endif
 	const struct sched_class	*sched_class;
 
@@ -865,7 +866,7 @@ struct task_struct {
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
-	struct hlist_head		preempt_notifiers;
+	struct hlist_head		preempt_notifiers __spslr_field_fixed;
 #endif
 
 #ifdef CONFIG_BLK_DEV_IO_TRACE
@@ -877,7 +878,7 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			*user_cpus_ptr;
-	cpumask_t			cpus_mask;
+	cpumask_t			cpus_mask __spslr_field_fixed;
 	void				*migration_pending;
 #ifdef CONFIG_SMP
 	unsigned short			migration_disabled;
@@ -887,7 +888,7 @@ struct task_struct {
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
 	union rcu_special		rcu_read_unlock_special;
-	struct list_head		rcu_node_entry;
+	struct list_head		rcu_node_entry __spslr_field_fixed;
 	struct rcu_node			*rcu_blocked_node;
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 
@@ -896,25 +897,25 @@ struct task_struct {
 	u8				rcu_tasks_holdout;
 	u8				rcu_tasks_idx;
 	int				rcu_tasks_idle_cpu;
-	struct list_head		rcu_tasks_holdout_list;
+	struct list_head		rcu_tasks_holdout_list __spslr_field_fixed;
 	int				rcu_tasks_exit_cpu;
-	struct list_head		rcu_tasks_exit_list;
+	struct list_head		rcu_tasks_exit_list __spslr_field_fixed;
 #endif /* #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 	int				trc_reader_nesting;
 	int				trc_ipi_to_cpu;
 	union rcu_special		trc_reader_special;
-	struct list_head		trc_holdout_list;
-	struct list_head		trc_blkd_node;
+	struct list_head		trc_holdout_list __spslr_field_fixed;
+	struct list_head		trc_blkd_node __spslr_field_fixed;
 	int				trc_blkd_cpu;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 	struct sched_info		sched_info;
 
-	struct list_head		tasks;
+	struct list_head		tasks __spslr_field_fixed;
 #ifdef CONFIG_SMP
-	struct plist_node		pushable_tasks;
+	struct plist_node		pushable_tasks __spslr_field_fixed;
 	struct rb_node			pushable_dl_tasks;
 #endif
 
@@ -1019,8 +1020,12 @@ struct task_struct {
 	pid_t				tgid;
 
 #ifdef CONFIG_STACKPROTECTOR
+	/* Canary can not be randomized because of arch/x86/kernel/asm-offsets.c
+	 * Pinpoint plugin could recognize context of instrumented accesses
+	 * and e.g. hijack asm instructions that want to use them as constants.
+	 */
 	/* Canary value for the -fstack-protector GCC feature: */
-	unsigned long			stack_canary;
+	unsigned long				stack_canary __spslr_field_fixed;
 #endif
 	/*
 	 * Pointers to the (original) parent process, youngest child, younger sibling,
@@ -1037,8 +1042,8 @@ struct task_struct {
 	/*
 	 * Children/sibling form the list of natural children:
 	 */
-	struct list_head		children;
-	struct list_head		sibling;
+	struct list_head		children __spslr_field_fixed;
+	struct list_head		sibling __spslr_field_fixed;
 	struct task_struct		*group_leader;
 
 	/*
@@ -1047,13 +1052,13 @@ struct task_struct {
 	 * This includes both natural children and PTRACE_ATTACH targets.
 	 * 'ptrace_entry' is this task's link on the p->parent->ptraced list.
 	 */
-	struct list_head		ptraced;
-	struct list_head		ptrace_entry;
+	struct list_head		ptraced __spslr_field_fixed;
+	struct list_head		ptrace_entry __spslr_field_fixed;
 
 	/* PID/PID hash table linkage. */
 	struct pid			*thread_pid;
 	struct hlist_node		pid_links[PIDTYPE_MAX];
-	struct list_head		thread_node;
+	struct list_head		thread_node __spslr_field_fixed;
 
 	struct completion		*vfork_done;
 
@@ -1157,7 +1162,7 @@ struct task_struct {
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
 	sigset_t			saved_sigmask;
-	struct sigpending		pending;
+	struct sigpending		pending __spslr_field_fixed;
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
 	unsigned int			sas_ss_flags;
@@ -1273,7 +1278,7 @@ struct task_struct {
 	/* Control Group info protected by css_set_lock: */
 	struct css_set __rcu		*cgroups;
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
-	struct list_head		cg_list;
+	struct list_head		cg_list __spslr_field_fixed;
 #endif
 #ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
@@ -1292,8 +1297,8 @@ struct task_struct {
 #ifdef CONFIG_PERF_EVENTS
 	u8				perf_recursion[PERF_NR_CONTEXTS];
 	struct perf_event_context	*perf_event_ctxp;
-	struct mutex			perf_event_mutex;
-	struct list_head		perf_event_list;
+	struct mutex			perf_event_mutex __spslr_field_fixed;
+	struct list_head		perf_event_list __spslr_field_fixed;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
 	unsigned long			preempt_disable_ip;
@@ -1596,6 +1601,7 @@ struct task_struct {
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
 	 */
+	spslr_struct_fields_end
 	randomized_struct_fields_end
 
 	/* CPU-specific state of this task: */
diff --git a/init/Kconfig b/init/Kconfig
index c521e1421ad4..c0cf7fa7a491 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2052,3 +2052,10 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
+
+config SPSLR
+	bool "Selfpatch SLR prototype"
+	depends on X86_64
+	depends on CC_IS_GCC
+	help
+	  Experimental structure layout randomization prototype.
diff --git a/init/main.c b/init/main.c
index c4778edae797..f2c4e606fa8a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -114,6 +114,8 @@
 
 #include <kunit/test.h>
 
+#include <linux/spslr.h>
+
 static int kernel_init(void *);
 
 /*
@@ -953,6 +955,19 @@ void start_kernel(void)
 	/* Architectural and non-timekeeping rng init, before allocator init */
 	random_init_early(command_line);
 
+#ifdef CONFIG_SPSLR
+	/* Randomize structure layouts */
+	struct spslr_status spslr_init_status = spslr_init();
+	if (spslr_init_status.error != SPSLR_OK)
+		panic("SPSLR initialization failed");
+
+	struct spslr_status spslr_selfpatch_status = spslr_selfpatch();
+	if (spslr_selfpatch_status.error != SPSLR_OK)
+		panic("SPSLR selfpatch failed");
+
+	pr_notice("Successfully applied SPSLR\n");
+#endif
+
 	/*
 	 * These use large bootmem allocations and must precede
 	 * initalization of page allocator
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12..209030881b8a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -65,6 +65,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
+#include <linux/spslr.h>
+
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
@@ -2847,6 +2849,59 @@ static int early_mod_check(struct load_info *info, int flags)
 	return err;
 }
 
+/* Find spslr symbol in module without kallsym */
+static unsigned long spslr_find_module_symbol(const struct load_info *info,
+					      const char *name)
+{
+	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
+	Elf_Sym *sym = (void *)symsec->sh_addr;
+	unsigned int i, n = symsec->sh_size / sizeof(*sym);
+
+	for (i = 1; i < n; i++) {
+		const char *symname = info->strtab + sym[i].st_name;
+
+		if (strcmp(symname, name) != 0)
+			continue;
+
+		/* Ignore undefined symbols just in case. */
+		if (sym[i].st_shndx == SHN_UNDEF)
+			return 0;
+
+		return (unsigned long)sym[i].st_value;
+	}
+
+	return 0;
+}
+
+/* Apply structure layout randomization to module */
+static int __maybe_unused spslr_prepare_module(struct module *mod, const struct load_info *info)
+{
+	struct spslr_module sm = { };
+	struct spslr_status st;
+
+	sm.ipin_cnt = (const void *)spslr_find_module_symbol(info, SPSLR_MODULE_SYM_IPIN_CNT);
+	sm.ipins = (const void *)spslr_find_module_symbol(info, SPSLR_MODULE_SYM_IPINS);
+	sm.ipin_op_cnt = (const void *)spslr_find_module_symbol(info, SPSLR_MODULE_SYM_IPIN_OP_CNT);
+	sm.ipin_ops = (const void *)spslr_find_module_symbol(info, SPSLR_MODULE_SYM_IPIN_OPS);
+	sm.dpin_cnt = (const void *)spslr_find_module_symbol(info, SPSLR_MODULE_SYM_DPIN_CNT);
+	sm.dpins = (const void *)spslr_find_module_symbol(info, SPSLR_MODULE_SYM_DPINS);
+
+	if (!sm.ipin_cnt || !sm.ipins || !sm.ipin_op_cnt ||
+	    !sm.ipin_ops || !sm.dpin_cnt || !sm.dpins) {
+		pr_err("%s: SPSLR metadata incomplete\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	st = spslr_patch_module(&sm);
+	if (st.viability != SPSLR_VIABLE || st.error != SPSLR_OK) {
+		pr_err("%s: SPSLR patch failed: viability=%d error=%d\n",
+		       mod->name, st.viability, st.error);
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -2950,6 +3005,13 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err < 0)
 		goto free_modinfo;
 
+#ifdef CONFIG_SPSLR
+	/* SPSLR must happen after relocation and icache should be flushed afterwards */
+	err = spslr_prepare_module(mod, info);
+	if (err < 0)
+		goto free_modinfo;
+#endif
+
 	flush_module_icache(mod);
 
 	/* Now copy in args */
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8f423a1faf50..59fc7489d9eb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -95,10 +95,15 @@ endif
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------
 
+ifdef SPSLR_TOOL_PINPOINT
+$(SPSLR_TOOL_PINPOINT):
+	$(Q)$(MAKE) -f $(srctree)/Makefile $(SPSLR_TOOL_PINPOINT)
+endif
+
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
       cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS) $(CC_FLAGS_LTO), $(c_flags)) -fverbose-asm -S -o $@ $<
 
-$(obj)/%.s: $(obj)/%.c FORCE
+$(obj)/%.s: $(obj)/%.c $(if $(CONFIG_SPSLR),$(SPSLR_TOOL_PINPOINT)) FORCE
 	$(call if_changed_dep,cc_s_c)
 
 quiet_cmd_cpp_i_c = CPP $(quiet_modtag) $@
@@ -225,7 +230,7 @@ define rule_as_o_S
 endef
 
 # Built-in and composite module parts
-$(obj)/%.o: $(obj)/%.c $(recordmcount_source) FORCE
+$(obj)/%.o: $(obj)/%.c $(recordmcount_source) $(if $(CONFIG_SPSLR),$(SPSLR_TOOL_PINPOINT)) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 1482884ec3ca..5e5f203b1d6d 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -33,6 +33,128 @@ quiet_cmd_cc_o_c = CC [M]  $@
 $(extmod_prefix).module-common.o: $(srctree)/scripts/module-common.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
+ifdef CONFIG_SPSLR
+
+quiet_cmd_gen_spslr_mod_list = SPSLRLST [M] $@
+      cmd_gen_spslr_mod_list = set -e; \
+	mod_o=$(@:.spslr-files=.o); \
+	modfile=$(@:.spslr-files=.mod); \
+	tmp=$@.tmp; \
+	found=0; \
+	rm -f "$$tmp"; \
+	add_src() { \
+		src="$$1"; \
+		objctx="$$2"; \
+		case "$$src" in \
+			*.c) \
+				spslr="$(SPSLR_METADIR)/$$src.spslr"; \
+				if [ -f "$$spslr" ]; then \
+					printf '%s\n' "$$spslr" >> "$$tmp"; \
+					found=1; \
+				else \
+					echo "Missing SPSLR sidecar for $$objctx from $$src: $$spslr" >&2; \
+					exit 1; \
+				fi; \
+				;; \
+			*.S) \
+				: ;; \
+			*) \
+				echo "Unsupported source for $$objctx: $$src" >&2; \
+				exit 1; \
+				;; \
+		esac; \
+	}; \
+	add_obj_from_cmd() { \
+		obj="$$1"; \
+		cmdfile="$$(dirname "$$obj")/.$$(basename "$$obj").cmd"; \
+		if [ -f "$$cmdfile" ]; then \
+			src="$$(sed -n 's/^source_.* := //p' "$$cmdfile" | head -n 1)"; \
+			if [ -n "$$src" ]; then \
+				add_src "$$src" "$$obj"; \
+				return 0; \
+			fi; \
+		fi; \
+		return 1; \
+	}; \
+	add_obj_direct() { \
+		obj="$$1"; \
+		src_c="$${obj%.o}.c"; \
+		src_S="$${obj%.o}.S"; \
+		if [ -f "$$src_c" ]; then \
+			add_src "$$src_c" "$$obj"; \
+		elif [ -f "$$src_S" ]; then \
+			: ; \
+		else \
+			echo "Could not determine SPSLR input for $$obj: no .cmd source entry, no $$src_c, and no $$src_S" >&2; \
+			exit 1; \
+		fi; \
+	}; \
+	if add_obj_from_cmd "$$mod_o"; then \
+		: ; \
+	elif [ -f "$$modfile" ]; then \
+		while read tok; do \
+			case "$$tok" in \
+				"" ) \
+					continue ;; \
+				*.mod.o|*.spslr_module.o) \
+					continue ;; \
+				*.o) \
+					if add_obj_from_cmd "$$tok"; then \
+						: ; \
+					else \
+						add_obj_direct "$$tok"; \
+					fi; \
+					;; \
+				*) \
+					echo "Unexpected entry in $$modfile: $$tok" >&2; \
+					exit 1; \
+					;; \
+			esac; \
+		done < "$$modfile"; \
+	else \
+		add_obj_direct "$$mod_o"; \
+	fi; \
+	if [ "$$found" = 1 ]; then \
+		awk '!seen[$$0]++' "$$tmp" > $@; \
+		rm -f "$$tmp"; \
+	else \
+		rm -f "$$tmp"; \
+		: > $@; \
+		echo "WARNING: no .spslr files found for module $$mod_o" >&2; \
+	fi
+
+quiet_cmd_spslr_patchcompile_mod = SPSLR   [M] $@
+      cmd_spslr_patchcompile_mod = set -e; \
+	if [ ! -s $(SPSLR_VMLINUX_TARGET_MAP) ]; then \
+		echo "Missing SPSLR target map: $(SPSLR_VMLINUX_TARGET_MAP)" >&2; \
+		exit 1; \
+	fi; \
+	if [ ! -s $< ]; then \
+		echo "Empty module SPSLR manifest: $<" >&2; \
+		exit 1; \
+	fi; \
+	$(SPSLR_TOOL_PATCHCOMPILE) \
+		--module \
+		--no-new-targets \
+		--load-targets $(SPSLR_VMLINUX_TARGET_MAP) \
+		--verbose \
+		--out $@ \
+		$$(cat $<)
+
+quiet_cmd_spslr_as_mod = AS      [M] $@
+      cmd_spslr_as_mod = $(CC) $(KBUILD_AFLAGS) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) -DMODULE -c -o $@ $<
+
+%.spslr-files: %.o FORCE
+	$(call if_changed,gen_spslr_mod_list)
+
+%.spslr_module.S: %.spslr-files $(SPSLR_VMLINUX_TARGET_MAP) FORCE
+	$(call if_changed,spslr_patchcompile_mod)
+
+%.spslr_module.o: %.spslr_module.S FORCE
+	$(call if_changed,spslr_as_mod)
+
+endif
+
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
@@ -57,13 +179,18 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o $(extmod_prefix).module-common.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
+%.ko: %.o %.mod.o $(extmod_prefix).module-common.o $(if $(CONFIG_SPSLR),%.spslr_module.o) scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
 	+$(call if_changed_except,ld_ko_o,vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
 
-targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) $(extmod_prefix).module-common.o
+targets += $(modules:%.o=%.ko) \
+	   $(modules:%.o=%.mod.o) \
+	   $(modules:%.o=%.spslr-files) \
+	   $(modules:%.o=%.spslr_module.S) \
+	   $(modules:%.o=%.spslr_module.o) \
+	   $(extmod_prefix).module-common.o
 
 # Add FORCE to the prerequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 1284f05555b9..afb723954150 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -24,6 +24,10 @@ endif
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
+ifdef CONFIG_SPSLR
+vmlinux: $(SPSLR_VMLINUX_SPSLR_SECTION_OBJ)
+endif
+
 # Final link of vmlinux with optional arch pass after final link
 cmd_link_vmlinux =							\
 	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";		\
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0b6e2ebf60dc..fd1483f5b793 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -54,6 +54,7 @@ quiet_cmd_ld_vmlinux.o = LD      $@
 	$(addprefix -T , $(initcalls-lds)) \
 	--whole-archive vmlinux.a --no-whole-archive \
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
+	$(SPSLR_VMLINUX_SPSLR_SECTION_OBJ) \
 	$(cmd_objtool)
 
 define rule_ld_vmlinux.o
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a9b3f34a78d2..603a90811257 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -66,6 +66,11 @@ vmlinux_link()
 	else
 		objs=vmlinux.a
 		libs="${KBUILD_VMLINUX_LIBS}"
+
+		# Only add it here because the spslr section is already contained in vmlinux.o
+		if is_enabled CONFIG_SPSLR; then
+			objs="${objs} ${SPSLR_VMLINUX_SPSLR_SECTION_OBJ}"
+		fi
 	fi
 
 	if is_enabled CONFIG_MODULES; then
-- 
2.43.0

