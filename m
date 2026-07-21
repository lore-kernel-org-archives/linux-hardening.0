Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9255415F0E
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662499; cv=none; b=g5YfAPSPOYox0oY60OCWY3Wg385YSQPXf5eM8oIQcTddGvUO1TZbrlRfT1lmPge5Maoe/zOcIpLL1ekdPDljawEGNVv0pfRLZNAhUPlvzfsc4ynmXMT5rqULLQGcrJeTlAgpNls/JkBn0ygci0m7Yavc+/k41iWyexhG8edkbcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662499; c=relaxed/simple;
	bh=+qB/MMWXk1CzQOml95bsODtyuxB8YJhD0cmcjtJxzFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVeZnqiLPTtQ9299GtBnTMZ57TDu/e9R9UM+tV3WtoI54WBNHNuYSRor3OQiLDnZT6GU1pUfyNcs/hr9IgxE8775Pl1C6zEqk0V7pQNSoLQDuy4OzKUcf29v0XFE7K3OCKy8dBldi7Z4wat6V2dy8kHlrwQRQJMLwG2AMGQxQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=EvjjH+bi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="EvjjH+bi"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so29139595e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1784662496; x=1785267296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sLTRXbUvELbFfzpHrTsSk/mgu3wE8VN3E/dh6Cf4Cmo=;
        b=EvjjH+biapM5dc1KBwIa7qCbhSvH7iyTheS1GZLvQLBT9uJ8i+25Nv1AOlkIsKHgVD
         8EyhS2WLvT395309+Qc5ReuPQUomsx8UeIJyOX1LD+YcZTXo4PWXUfTgDnsdTGvX8MbT
         FqiyHaBCiBdzGhRntXdblAhvstOfhHMJ667cVI3sp6Muvu67He+8IxpgJUO/oQnJNXrG
         5gLJN6VDoQir/71tuffnfs6l14gHCFXXIhr1gQCWAZ/qjeWnaxC6L0sDPbBq2ehc0uYt
         ReVfGh5mUsQYzLyetKUeUV/13RHzrNyBnQmXFwCaLIcdQJEdW+TYAnGws6xQJ8P+Tw46
         KeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662496; x=1785267296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sLTRXbUvELbFfzpHrTsSk/mgu3wE8VN3E/dh6Cf4Cmo=;
        b=TqYTEq+Mq/0CQoCNMgz5EVijmcjEqyUpFrFcE5SsdUcOCUEvu9gsEXBreo2yYD1FYu
         RZLE1VK0W6eOxkYe48A9+tteGWSaOhr3uj5LbKQh0xWZ0c9aXgLC9pZQYuKhiAIu7glY
         85qrCllNnRh11J5ZZzGpmGZjH1UD/1poZBTqTkny5MxyKsKFgt0Py3GGmHQkALOoRlC5
         CC9MS2sy0Gjn9GRWJauojtejekDWPW/7sWqCYbbLxDA36/3+AifyFm4vff9OH8kgsHHu
         rMx31FyBMSh6NzVZa0M/XJI12ijsNBDSmhjKE44MSoyQwOQWLHs6xGTCQh0laukGKoKK
         2ZOw==
X-Gm-Message-State: AOJu0YxXuXR0q8JUIw2Jzv6IMpOTCXFGwi6Q8/qpLutYBOqqSjz2ar+o
	ciPjA7idgAwH/j6GMVVhnlvc5BYgzEYw591P+ZuktCW1l3i4u4ddxiITJYz+vWSq8THc3lKYARa
	jLXt9udJk
X-Gm-Gg: AfdE7ckEcZWHA08Zlmr/D23w7GIw7BNzLf4oT+H8taFSawom+w9YeUPQoNBh9a53wzZ
	FN7c/znqTnDwqXtTvb7j4ViE3VPCz0TjUn1eK3EYbQpJcyDf7lbqBVIRQDDnLqfyuYVJXh0H5ZV
	1umrDYoe7apZmCOel5AvK114iB/6Bd1byRDkP27syhluKuZnD14J4PoNr+EIboWNqfMBvFBEfXQ
	XNAIEmJx5hN4gE9rU5Gl8NgzO9+ZxGbWJ60Am9kfd5tlgem5OFXstGs11SONV+An1gF9LW7E5nF
	LAqZFPzDo7FNn+l3XjmnX7SocX0XTCaJZygbrNbiikaZhwV6t2fg19LPLCxxtPofVlkRviKqTNl
	BtA75eIknUiAiOQLdzr0wQ66LmxGn4PebpXxZuoOBfWE54aSS45UKFWv/Os2cdoTBEcCDyMAd0g
	OKAKSaw4vYD/84kCUUAkJgmWNRd09q3hSCiOwptLK8TwahpJJRydZZI4vcl6DUvpriFUkVoM71+
	CGx4s++gahFvevvCZ4=
X-Received: by 2002:a05:600c:4ec9:b0:495:4589:707 with SMTP id 5b1f17b1804b1-4954a3ec5ecmr252967315e9.5.1784662496136;
        Tue, 21 Jul 2026 12:34:56 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf448c00a6ccab16241b6894.dip0.t-ipconnect.de. [2003:dc:bf44:8c00:a6cc:ab16:241b:6894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b00338fsm5806705e9.2.2026.07.21.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:34:55 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	franzen@sec.in.tum.de,
	ardb@kernel.org,
	gregkh@linuxfoundation.org
Subject: [RFC v3 4/5] SPSLR and Sanemaker source integration
Date: Tue, 21 Jul 2026 21:34:55 +0200
Message-ID: <20260721193455.46612-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720191321.21635-1-yjn@yjn-systems.com>
References: <20260720191321.21635-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reposting this patch with a proper commit message following Greg's
comment. No functional changes.

This patch integrates the Bootpatch-SLR runtime into the kernel.

It introduces the source annotations used by Pinpoint, marks fields that
must remain fixed within randomized layouts, and invokes the Selfpatch
runtime during early boot and module loading.

At the moment, only task_struct is randomized.

Additionally, this patch integrates the Sanemaker runtime hooks. The
task_struct allocation and destruction are instrumented with Sanemaker
tag and untag traps. These inform Sanemaker of the exact location of
every live task_struct instance. Additionally, module text segments are
registered as they are loaded, allowing Sanemaker to normalize
instruction addresses against the image that contains them.

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

