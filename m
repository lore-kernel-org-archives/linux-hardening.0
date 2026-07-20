Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86467392822
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574806; cv=none; b=rhVZ5ajK6jPDOrxGdCRTmd47Z9SFJqR2SZVNvuiw/vK+tlX8asItfWJO1QRTr4kV9GrkQgo8GUJo/9Hu+9Ak2eH0n+wBMTkMIn8geZVCaGHgQJgoeeptHLHt+ORw8z0DY0liYpGZC7JeYLFX1167rbakkNlqkQMU9GMtoa/P1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574806; c=relaxed/simple;
	bh=2lK6gRroBoe4+bclCz1mfwWeoTeSwGscfR9tvghCLgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naQOejcpMOVKFEkqWYmhUU476+MRjln2Yk44IHWxq/vi8efZXmt5PU6Zh4tELEiJdsFXQltyIAMEi9fRe4kKBVeEcJi+cfHZL8xZvCB4BPbnBY5yzmiyDarJPH8BtQvABZ6b9Rp5R3FoAeuZaSMA2QgjBOxcPBmhqKbIxog41DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=lL2WFGIe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="lL2WFGIe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-475417f010dso5861325f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 20 Jul 2026 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784574803; x=1785179603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNy8FKI1rMtbV3QeF+PsHnoYXayigsA5C1ZOhTHQQls=;
        b=lL2WFGIel0zuS4G4SoGMeOu2nTUAQ7N7sNnrRZOnKFbBkpvHfVUaY6kC80GOaLhxxT
         iCZGcx4D+GE5eDZ6Tlb9lDUCKHLq8r5BrKTxQiVbtA7JPPiStJXZ6k/gG11Ud/K7SNVC
         v0zY5ctoAf5Jv/omfdAY3mrZu0yTEJHtdG1puzI5Ys8xbmhnQ5G+NCS6ULSol00JDnNw
         lkr1PDlT3gDBn29omqodJUzjKWWuhkUE7XOh9egJYZhTBwSRwz8IX9OkNp315Eg7NrVI
         n+x/adjQKqZt2Xj3cN2MpF+1gtgg3f5B7zSkqn0SodG3BBOsvZzSccdmg6ocWcStec4E
         zw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574803; x=1785179603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mNy8FKI1rMtbV3QeF+PsHnoYXayigsA5C1ZOhTHQQls=;
        b=PWo+R4pf9zXxtotI8mH8uquOjsK8KqeH+2in6u2O1PC8Z2n2LsJndAXE9TGaZcOcvb
         csIo6JDZ4ICna0rcwwJAMi1d15fHzLFrblK5yIaUQp/5DjHFm0NAyCZBYVMWFRKzYb+U
         T2xhD5j49vFTWBKnqCp9FnnejguOxakYRHulFP7JIj4zCUX87rLuT0t2iGQ8Fpc1rSVO
         DD6k+d1tQs2oDQEPo7g4lQkF5K5vZagtdj8YuLXFkXwOzuRNpiIL5DZAZPB0WbXbzEhZ
         IHqW6Jc+jKzjNXajqZru+DQhpgfQLYI+FITUDdhYAIuP6OiY8jm3EXaDfkLGzArEzMUE
         H+Qw==
X-Gm-Message-State: AOJu0YyCa218RTifTPMpVEzNeBN9BwMyI2zpQSkfZbJu+D53hrrH3yTM
	2Dg9k6zKOvNvDKTZs1EBcAqWH3HRw6dGRxd4lldXvnOpkpP43apKAq9bbawICVtURWSY4irIVtP
	QN9EFEiC/
X-Gm-Gg: AR+sD13qBTpeWpi5fSF49cOOcsUWJR4/bBBfhkJQtXkweSLoyZKO/5Cy0AzPF9qoo1+
	DOYSACVy8SCco7RbjKBW10JkpLBsaGaXMmUMx1p85ox5imLxxZM44alU27/D1gjm2gRRavD+GhG
	1x64jDNra1tazjriFVF5WtwEjaEgTm3FxcukjF94qWcc9WUr25BZNFhHbCPmjm69kvPgIkj7Ikj
	1aR9JG1gr5hy23SJzQeiIkyzAglKdWGv3iYU0LWHJc6rn2PXeycTcP6gksHgWTdzpWNGKTT90Im
	whdpHjzU0ydWuH8CPnMkxZ2BgNc8MJq4qsbmkiLOUiW9BRkExyH3d6RIML11JghM7kbdvHM90jO
	ex2H5x71NBfaLvB0F9JF9webOyEX8IPxW1XRxLwVuL484TnOT1T52Rz/g12me1Kgq9kW97Jvr2q
	2nNKORnyRoS+t5Z4Ct4Ez1E+AT3TOZ+LSOLAOxkuihDjGy5xWP5s4Ak4D+nadCoLhQVf4a+7MDf
	G2TlKmYBFzFRpWu428=
X-Received: by 2002:a5d:6f04:0:b0:47f:4508:585c with SMTP id ffacd0b85a97d-47f62306d29mr17874696f8f.11.1784574802823;
        Mon, 20 Jul 2026 12:13:22 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00c9c364f8ed993120.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:c9c3:64f8:ed99:3120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e65644sm30747590f8f.16.2026.07.20.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:13:22 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org
Subject: [RFC v3 4/5] SPSLR and Sanemaker source integration
Date: Mon, 20 Jul 2026 21:13:21 +0200
Message-ID: <20260720191321.21635-1-yjn@yjn-systems.com>
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
 include/linux/compiler_types.h |   8 ++
 include/linux/sched.h          |  58 ++++++------
 init/main.c                    |  35 +++++++
 kernel/fork.c                  |  10 +-
 kernel/module/main.c           | 167 +++++++++++++++++++++++++++++++++
 5 files changed, 250 insertions(+), 28 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..3ef553fb2489 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -465,6 +465,14 @@ struct ftrace_likely_data {
 # define __latent_entropy
 #endif
 
+#if defined(__SPSLR__)
+# define __spslr __attribute__((spslr))
+# define __spslr_field_fixed __attribute__((spslr_field_fixed))
+#else
+# define __spslr
+# define __spslr_field_fixed
+#endif
+
 #if defined(RANDSTRUCT) && !defined(__CHECKER__)
 # define __randomize_layout __designated_init __attribute__((randomize_layout))
 # define __no_randomize_layout __attribute__((no_randomize_layout))
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 373bcc0598d1..8e6a87988d07 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -829,12 +829,12 @@ struct task_struct {
 	 * For reasons of header soup (see current_thread_info()), this
 	 * must be the first element of task_struct.
 	 */
-	struct thread_info		thread_info;
+	struct thread_info		thread_info __spslr_field_fixed;
 #endif
-	unsigned int			__state;
+	unsigned int			__state __spslr_field_fixed;
 
 	/* saved state for "spinlock sleepers" */
-	unsigned int			saved_state;
+	unsigned int			saved_state __spslr_field_fixed;
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
@@ -877,12 +877,12 @@ struct task_struct {
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
 
@@ -919,7 +919,7 @@ struct task_struct {
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
-	struct hlist_head		preempt_notifiers;
+	struct hlist_head		preempt_notifiers __spslr_field_fixed;
 #endif
 
 #ifdef CONFIG_BLK_DEV_IO_TRACE
@@ -931,15 +931,15 @@ struct task_struct {
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			*user_cpus_ptr;
-	cpumask_t			cpus_mask;
+	cpumask_t			cpus_mask __spslr_field_fixed;
 	void				*migration_pending;
 	unsigned short			migration_disabled;
 	unsigned short			migration_flags;
 
 #ifdef CONFIG_PREEMPT_RCU
-	int				rcu_read_lock_nesting;
-	union rcu_special		rcu_read_unlock_special;
-	struct list_head		rcu_node_entry;
+	int				rcu_read_lock_nesting __spslr_field_fixed;
+	union rcu_special		rcu_read_unlock_special __spslr_field_fixed;
+	struct list_head		rcu_node_entry __spslr_field_fixed;
 	struct rcu_node			*rcu_blocked_node;
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 
@@ -948,9 +948,9 @@ struct task_struct {
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
@@ -964,8 +964,8 @@ struct task_struct {
 
 	struct sched_info		sched_info;
 
-	struct list_head		tasks;
-	struct plist_node		pushable_tasks;
+	struct list_head		tasks __spslr_field_fixed;
+	struct plist_node		pushable_tasks __spslr_field_fixed;
 	struct rb_node			pushable_dl_tasks;
 
 	struct mm_struct		*mm;
@@ -1072,8 +1072,12 @@ struct task_struct {
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
@@ -1090,8 +1094,8 @@ struct task_struct {
 	/*
 	 * Children/sibling form the list of natural children:
 	 */
-	struct list_head		children;
-	struct list_head		sibling;
+	struct list_head		children __spslr_field_fixed;
+	struct list_head		sibling __spslr_field_fixed;
 	struct task_struct		*group_leader;
 
 	/*
@@ -1100,13 +1104,13 @@ struct task_struct {
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
 
@@ -1211,7 +1215,7 @@ struct task_struct {
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
 	sigset_t			saved_sigmask;
-	struct sigpending		pending;
+	struct sigpending		pending __spslr_field_fixed;
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
 	unsigned int			sas_ss_flags;
@@ -1340,7 +1344,7 @@ struct task_struct {
 	/* Control Group info protected by css_set_lock: */
 	struct css_set __rcu		*cgroups;
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
-	struct list_head		cg_list;
+	struct list_head		cg_list __spslr_field_fixed;
 #ifdef CONFIG_PREEMPT_RT
 	struct llist_node		cg_dead_lnode;
 #endif	/* CONFIG_PREEMPT_RT */
@@ -1355,8 +1359,8 @@ struct task_struct {
 #ifdef CONFIG_PERF_EVENTS
 	u8				perf_recursion[PERF_NR_CONTEXTS];
 	struct perf_event_context	*perf_event_ctxp;
-	struct mutex			perf_event_mutex;
-	struct list_head		perf_event_list;
+	struct mutex			perf_event_mutex __spslr_field_fixed;
+	struct list_head		perf_event_list __spslr_field_fixed;
 	struct perf_ctx_data __rcu	*perf_ctx_data;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -1660,14 +1664,14 @@ struct task_struct {
 #endif
 
 	/* CPU-specific state of this task: */
-	struct thread_struct		thread;
+	struct thread_struct		thread __spslr_field_fixed;
 
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
 	 */
 	randomized_struct_fields_end
-} __attribute__ ((aligned (64)));
+} __spslr __attribute__ ((aligned (64)));
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
diff --git a/init/main.c b/init/main.c
index e363232b428b..fbd2967d1530 100644
--- a/init/main.c
+++ b/init/main.c
@@ -119,6 +119,22 @@
 
 #include <kunit/test.h>
 
+#include <linux/spslr.h>
+#include <sanemaker/traps.h>
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
@@ -974,6 +990,8 @@ void start_kernel(void)
 	char *command_line;
 	char *after_dashes;
 
+	sanemaker_target_tag(&init_task, struct task_struct);
+
 	set_task_stack_end_magic(&init_task);
 	smp_setup_processor_id();
 	debug_objects_early_init();
@@ -1023,6 +1041,23 @@ void start_kernel(void)
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
diff --git a/kernel/fork.c b/kernel/fork.c
index f0e2e131a9a5..f07f89d8c55a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -127,6 +127,9 @@
 
 #include <kunit/visibility.h>
 
+#include <linux/spslr.h>
+#include <sanemaker/traps.h>
+
 /*
  * Minimum number of threads to boot the kernel
  */
@@ -185,11 +188,16 @@ static struct kmem_cache *task_struct_cachep;
 
 static inline struct task_struct *alloc_task_struct_node(int node)
 {
-	return kmem_cache_alloc_node(task_struct_cachep, GFP_KERNEL, node);
+	struct task_struct *tsk =
+		kmem_cache_alloc_node(task_struct_cachep, GFP_KERNEL, node);
+
+	sanemaker_target_tag(tsk, struct task_struct);
+	return tsk;
 }
 
 static inline void free_task_struct(struct task_struct *tsk)
 {
+	sanemaker_target_untag(tsk);
 	kmem_cache_free(task_struct_cachep, tsk);
 }
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..1f314fc12930 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -66,6 +66,70 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
+#include <linux/spslr.h>
+#include <sanemaker/traps.h>
+
+/* Sanemaker image (de)registration helpers */
+
+static const void *sanemaker_module_image_base(const struct module *mod)
+{
+	unsigned long base = ULONG_MAX;
+
+	if (mod->mem[MOD_TEXT].base && mod->mem[MOD_TEXT].size)
+		base = min(base,
+			   (unsigned long)mod->mem[MOD_TEXT].base);
+
+	if (mod->mem[MOD_INIT_TEXT].base && mod->mem[MOD_INIT_TEXT].size)
+		base = min(base,
+			   (unsigned long)mod->mem[MOD_INIT_TEXT].base);
+
+	return base == ULONG_MAX ? NULL : (const void *)base;
+}
+
+static void sanemaker_register_module_image(struct module *mod)
+{
+	const struct module_memory *text;
+	const void *image_base;
+
+	image_base = sanemaker_module_image_base(mod);
+	if (!image_base)
+		return;
+
+	sanemaker_new_image(mod->name, image_base);
+
+	text = &mod->mem[MOD_TEXT];
+	if (text->base && text->size)
+		sanemaker_new_image_text(
+			mod->name,
+			text->base,
+			(const char *)text->base + text->size);
+
+	text = &mod->mem[MOD_INIT_TEXT];
+	if (text->base && text->size)
+		sanemaker_new_image_text(
+			mod->name,
+			text->base,
+			(const char *)text->base + text->size);
+}
+
+static void sanemaker_drop_module_init_text(struct module *mod)
+{
+	const struct module_memory *text = &mod->mem[MOD_INIT_TEXT];
+
+	if (!text->base || !text->size)
+		return;
+
+	sanemaker_drop_image_text(
+		mod->name,
+		text->base,
+		(const char *)text->base + text->size);
+}
+
+static void sanemaker_unregister_module_image(struct module *mod)
+{
+	sanemaker_drop_image(mod->name);
+}
+
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable within RCU read section),
@@ -1461,6 +1525,7 @@ static void free_module(struct module *mod)
 	kfree(mod->args);
 	percpu_modfree(mod);
 
+	sanemaker_unregister_module_image(mod);
 	free_mod_mem(mod);
 }
 
@@ -3100,10 +3165,22 @@ static noinline int do_init_module(struct module *mod)
 	freeinit->init_data = mod->mem[MOD_INIT_DATA].base;
 	freeinit->init_rodata = mod->mem[MOD_INIT_RODATA].base;
 
+	/*
+	 * Constructors and mod->init are the first entry points into module text.
+	 */
+	sanemaker_register_module_image(mod);
+
 	do_mod_ctors(mod);
 	/* Start the module */
 	if (mod->init != NULL)
 		ret = do_one_initcall(mod->init);
+
+	/*
+	 * mod->init() has returned, so no further execution should enter
+	 * MOD_INIT_TEXT. This is independent of when the allocation is freed.
+	 */
+	sanemaker_drop_module_init_text(mod);
+
 	if (ret < 0) {
 		/*
 		 * -EEXIST is reserved by [f]init_module() to signal to userspace that
@@ -3415,6 +3492,87 @@ static int early_mod_check(struct load_info *info, int flags)
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
@@ -3520,6 +3678,15 @@ static int load_module(struct load_info *info, const char __user *uargs,
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

