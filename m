Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F52BB17
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962647; cv=none; b=DunUF8mDQyJzzWtBKCQEZEUQYEG0yW1OZMrW0kNETlOnZ8TBQgdUpdQkjRUJg5B70VQM3dSMGZMTX63yeVPXVzPWk9ImarJi3w8xp/9oIxYm3OGr86cGXtPVSQ0koo3KR9g9kVK6dhVSw0T7ZUMKvEr3IOy6fIhVSy3BIe3NCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962647; c=relaxed/simple;
	bh=U6RxPJH6Hqdv/e05D2O1NjiY7OzBMAGQE62YFatMOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFmtoLkw4TZg+Gscntazep0mF7QhW5qvEE+8wW9Px/6NOQzSq00hptlAu1VzDHH2Il0FxS7iX0tToR8nUNjiDH+uLZfLrbVFAq5qLJvdKiEige7qfvROBlUe78fLkB6T6fH29DAI6igF3WJa4sDopTtjNmmLYMdGgowFsGx5Mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=u6+bLOxQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="u6+bLOxQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b64c8311so28205745e9.3
        for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1781962644; x=1782567444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY6wjRRpjHbP8HSkgPuax1/fhSU+15bKF8bfyE0pIHY=;
        b=u6+bLOxQ4KX9TfF/1YC5df0sZ9X7pLxVEPh6YazXbntYwNrukIkX6wz49JrGE0aGX8
         R07j0umgnWLLMDYkOcuVsCCMMxvm+UabsSw2nAmRgXChwexTBrbnKYG+jze+rAtxC69u
         i6+LvrAqmW4cLeaeGyz0VIhKYCZFBKbwjO6+HdcWl3gE2hJsl/GoHVlkRX6uNjqDhE/T
         ZzNPo1UmjWEYjlrWYigbinIaluGeFizipp7Y0FaI4AMksaovJihRnsZ1gYbMjKkpL74R
         TJ1H67TIYngCvMZAk/9sMTAUExakw0+cSWkRGMWZ8AwG449FyjaBVGzKnEy1JMnuQYbM
         RjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962644; x=1782567444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IY6wjRRpjHbP8HSkgPuax1/fhSU+15bKF8bfyE0pIHY=;
        b=MCZ3RnCXLbFbjyLX/cjCvUpt7EpK6z5QJGBW5vVZaV0jKRxJDdGygK/l1BvPI51QpN
         B120nBOHsbnThNErfWL88BHKzNkuxx9DxlI/20BUrp1vXzSQdSL9dG9nUsrf6PXJGACw
         9eONQUibMuOk7vmBG0mMPyQOuX/UtugtAHiFAsxieYZUE3g2Icj25X4Ten+PqBKFG9jl
         an/xKqOZdxus31J7Cs2Q4Sbpi0rAqZ0nWEZSnVMfzIIcmyRwhFALMFgwp7zvAh0EK8eN
         TVLTuyiOpP82T0HUAsalPj8Z9ueO1BM0dILzXCMufC7+t1UFkTY+Ix6nXEB7WqkrNHGg
         n8xg==
X-Gm-Message-State: AOJu0Yxn9WIVN4wc6xhlSGa2Wn7pCZ7XodPDgN+9+FefTqoybY/0AInG
	56bvuJaqI1xE8FV32NmKY3iyCLitTMZSwwO8FS33GrisRZQee7y1ErEXeOxSPbV4vYVuG5w6kHW
	NnqF7jg==
X-Gm-Gg: AfdE7clr3JOvThwYCrMd+Qp9XhjPepVpaMojHDqRgcxlDJwel58AMcKbVtCQv2+oSrO
	KLZMfIimssZImzQ/M0mnkgeeQtvrftwOiyMkl6NwqFa+qLurNl4vlsXAOGbxNIIvRGY9cwoocvS
	kc8x6QMGLaDbMs+GDtsxgCTpFUG2owxVYreK+XoHo3KJ8bEaElF8ExoViN92vyDs7n1BaI9A8Pr
	fBQkqvQDADr83vNujwUa8NkmfyeTdL2FqUusevYhonVJxFgy5R0xfM2Mqk22Vz0/H0L6fEEYQh+
	BjJmNceCdYdzoLKP/6XHH/dFdpxEfhwsczygwYFUxjH7Ii7nDIwCoZ9FabjlI4hJQMUw/WtS2yl
	muyArXx5MesxvPD7bYW03atr8xRNSwbpbZJtqTjZBOtLkHZ4vPAkVKrEDzmgfWARYSOZF+qV0MJ
	JRD1QTcmXmICk7+XbYpsyPRBeISE1p3ejAYr0hE+775/Yu47KMrT16Fb4vqirE1d4NFif978il5
	l7A+QYdqQNK4jfreUHRTSTmonJG
X-Received: by 2002:a05:600c:5493:b0:490:e89a:b221 with SMTP id 5b1f17b1804b1-49240e7bbf5mr127708615e9.35.1781962642498;
        Sat, 20 Jun 2026 06:37:22 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00ab2024b6c6d10e76.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:ab20:24b6:c6d1:e76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667882f7sm8734639f8f.21.2026.06.20.06.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:37:22 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v2 4/5] SPSLR source integration
Date: Sat, 20 Jun 2026 15:37:21 +0200
Message-ID: <20260620133721.95239-1-yjn@yjn-systems.com>
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
 include/linux/sched.h | 50 ++++++++++++-----------
 init/main.c           | 32 +++++++++++++++
 kernel/module/main.c  | 92 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 22 deletions(-)

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
diff --git a/init/main.c b/init/main.c
index c4778edae797..e28b2ea94794 100644
--- a/init/main.c
+++ b/init/main.c
@@ -114,6 +114,21 @@
 
 #include <kunit/test.h>
 
+#include <linux/spslr.h>
+
+#ifdef CONFIG_SPSLR
+
+bool spslr_enabled __ro_after_init = true;
+
+static int __init nospslr_setup(char *str)
+{
+	spslr_enabled = false;
+	return 0;
+}
+early_param("nospslr", nospslr_setup);
+
+#endif
+
 static int kernel_init(void *);
 
 /*
@@ -953,6 +968,23 @@ void start_kernel(void)
 	/* Architectural and non-timekeeping rng init, before allocator init */
 	random_init_early(command_line);
 
+#ifdef CONFIG_SPSLR
+	if (spslr_enabled) {
+		/* Randomize structure layouts */
+		struct spslr_status spslr_init_status = spslr_init();
+		if (spslr_init_status.error != SPSLR_OK)
+			panic("SPSLR initialization failed");
+
+		struct spslr_status spslr_selfpatch_status = spslr_selfpatch();
+		if (spslr_selfpatch_status.error != SPSLR_OK)
+			panic("SPSLR selfpatch failed");
+
+		pr_notice("Successfully applied SPSLR\n");
+	} else {
+		pr_notice("SPSLR disabled\n");
+	}
+#endif
+
 	/*
 	 * These use large bootmem allocations and must precede
 	 * initalization of page allocator
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12..3d892cc1d8db 100644
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
@@ -2847,6 +2849,87 @@ static int early_mod_check(struct load_info *info, int flags)
 	return err;
 }
 
+#ifdef CONFIG_SPSLR
+
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
+static int __maybe_unused spslr_prepare_module(struct module *mod,
+					       const struct load_info *info)
+{
+	struct spslr_ctx ctx = { };
+	struct spslr_status st;
+	unsigned long workspace_size;
+	int err = 0;
+
+	ctx.entry.start_units = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_START_UNITS_SYM));
+	if (!ctx.entry.start_units) {
+		pr_err("%s: SPSLR units start symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.stop_units = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_STOP_UNITS_SYM));
+	if (!ctx.entry.stop_units) {
+		pr_err("%s: SPSLR units stop symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.start_targets = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_START_TARGETS_SYM));
+	if (!ctx.entry.start_targets) {
+		pr_err("%s: SPSLR targets start symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	ctx.entry.stop_targets = (const void *)spslr_find_module_symbol(info,
+							   __stringify(SPSLR_STOP_TARGETS_SYM));
+	if (!ctx.entry.stop_targets) {
+		pr_err("%s: SPSLR targets stop symbol missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	workspace_size = spslr_workspace_size(&ctx.entry);
+	ctx.workspace = kvmalloc(workspace_size, GFP_KERNEL);
+	if (!ctx.workspace)
+		return -ENOMEM;
+
+	st = spslr_patch_module(&ctx);
+	if (st.viability != SPSLR_VIABLE || st.error != SPSLR_OK) {
+		pr_err("%s: SPSLR patch failed: viability=%d error=%d\n",
+		       mod->name, st.viability, st.error);
+		err = -ENOEXEC;
+	}
+
+	kvfree(ctx.workspace);
+	return err;
+}
+
+#endif /* CONFIG_SPSLR */
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -2950,6 +3033,15 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err < 0)
 		goto free_modinfo;
 
+#ifdef CONFIG_SPSLR
+	if (spslr_enabled) {
+		/* SPSLR must happen after relocation and icache should be flushed afterwards */
+		err = spslr_prepare_module(mod, info);
+		if (err < 0)
+			goto free_modinfo;
+	}
+#endif
+
 	flush_module_icache(mod);
 
 	/* Now copy in args */
-- 
2.43.0

