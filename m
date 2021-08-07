Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2110C4320E
	for <linux-hardening@archiver.kernel.org>; Sat,  7 Aug 2021 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845F0610A6
	for <linux-hardening@archiver.kernel.org>; Sat,  7 Aug 2021 12:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhHGM7F (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 7 Aug 2021 08:59:05 -0400
Received: from smtpbg701.qq.com ([203.205.195.86]:44264 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231950AbhHGM7E (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 7 Aug 2021 08:59:04 -0400
X-QQ-mid: bizesmtp39t1628341106t5jl8mco
Received: from localhost.localdomain (unknown [114.212.83.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 07 Aug 2021 20:58:25 +0800 (CST)
X-QQ-SSF: 01400000001000B0P000B00B0000000
X-QQ-FEAT: G/QWXYAa6dlYfehyPr1274YH5Ef3Wfv0DQKm6kzOHMZeWdSVZTTEekLEw5lBV
        10AlxNEiwHWmi6BGnhjRf/F2D+YN17/f6UyTEmomsxC/BhXMyPaLE33KzrpA3qEaMS/2qx8
        bC43xw693zXJtEnOoxQkt/ETUBfjUiHLbOCCJfDmmF5bAKgTsbPAk5wrT350HTSW1irNOej
        9V0nnAEu4hJSF8bXKgIYBtU5g7KDMSXe1lQTtmg1foDj9vIlqNyhoLdyAiRQjt2vVByMXEq
        t1iA8uKWg7nHtnXG8OX6Lk1ky1vs2JLaxq0K7y0KqYiPJBtpgYVMlNRWXFxGGWlaJPNXdlP
        YliBQAW
X-QQ-GoodBg: 2
From:   Wang Zi-cheng <wzc@smail.nju.edu.cn>
To:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        lkml@metux.net
Cc:     purplewall1206 <wangzc5514@163.com>
Subject: [PATCH RFC]  v3 struct const ops pointers member hardening
Date:   Sat,  7 Aug 2021 20:58:59 +0800
Message-Id: <20210807125858.778488-1-wzc@smail.nju.edu.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:smail.nju.edu.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: purplewall1206 <wangzc5514@163.com>

Signed-off-by: purplewall1206 <wangzc5514@163.com>
---
 fs/open.c                  |  4 +++-
 include/linux/kernel.h     |  2 ++
 include/linux/mm.h         | 21 +++++++++++++++++++++
 include/linux/module.h     |  2 ++
 kernel/extable.c           | 27 +++++++++++++++++++++++++++
 kernel/module.c            | 36 ++++++++++++++++++++++++++++++++++++
 security/Kconfig.hardening | 13 ++++++++++++-
 7 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 94bef26ff1b6..9f06582ecd65 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -820,7 +820,9 @@ static int do_dentry_open(struct file *f,
 
 	/* normally all 3 are set; ->open() can clear them if needed */
 	f->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
-	if (!open)
+
+	/* check if open==NULL and fop is valid */
+	if (!open && check_valid_ops_pointer(f))
 		open = f->f_op->open;
 	if (open) {
 		error = open(inode, f);
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 1b2f0a7e00d6..a146565a7682 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -231,9 +231,11 @@ extern char *next_arg(char *args, char **param, char **val);
 extern int core_kernel_text(unsigned long addr);
 extern int init_kernel_text(unsigned long addr);
 extern int core_kernel_data(unsigned long addr);
+extern int core_kernel_rodata(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
+extern int const_ptr_is_kernel_rodata(void *ptr);
 
 extern void bust_spinlocks(int yes);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..6f52144e6875 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3283,5 +3283,26 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 	return 0;
 }
 
+/*
+ * check if const ops pointer dereference ptrs in .rodata
+ */
+static inline bool check_valid_ops_pointer(struct file *f)
+{
+	bool fop_valid = true;
+	bool fiop_valid = true;
+	if (IS_ENABLED(CONFIG_STRUCT_CONST_OPS_POINTER_HARDENING)) {
+		fop_valid = const_ptr_is_kernel_rodata((void *) f->f_op);
+		fiop_valid = const_ptr_is_kernel_rodata((void *) f->f_inode->i_op);
+		if (fop_valid && fiop_valid)
+			return true;
+		else {
+			WARN_ON_ONCE(!(fop_valid && fiop_valid));
+			return false;
+		}		
+	} else {
+		return true;
+	}
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index 8a298d820dbc..c6390e137ae8 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -554,11 +554,13 @@ static inline bool module_is_live(struct module *mod)
 }
 
 struct module *__module_text_address(unsigned long addr);
+struct module *__module_rodata_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
 bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
+bool is_module_rodata_address(unsigned long addr);
 
 static inline bool within_module_core(unsigned long addr,
 				      const struct module *mod)
diff --git a/kernel/extable.c b/kernel/extable.c
index b0ea5eb0c3b4..d51f78af6233 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -100,6 +100,21 @@ int core_kernel_data(unsigned long addr)
 	return 0;
 }
 
+/**
+ * core_kernel_rodata - tell if addr points to kernel rodata
+ * @addr: address to test
+ *
+ * Returns true if @addr passed in is from the core kernel rodata
+ * section.
+ */
+int core_kernel_rodata(unsigned long addr)
+{
+	if (addr >= (unsigned long)__start_rodata &&
+		addr < (unsigned long)__end_rodata)
+		return 1;
+	return 0;
+}
+
 int __kernel_text_address(unsigned long addr)
 {
 	if (kernel_text_address(addr))
@@ -173,3 +188,15 @@ int func_ptr_is_kernel_text(void *ptr)
 		return 1;
 	return is_module_text_address(addr);
 }
+
+/*
+ * check if const pointers derefence rodata section
+ */
+int const_ptr_is_kernel_rodata(void *ptr)
+{
+	unsigned long addr;
+	addr = (unsigned long) dereference_function_descriptor(ptr);
+	if (core_kernel_rodata(addr))
+		return 1;
+	return is_module_rodata_address(addr);
+}
diff --git a/kernel/module.c b/kernel/module.c
index ed13917ea5f3..639229202b01 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4730,6 +4730,42 @@ struct module *__module_text_address(unsigned long addr)
 	return mod;
 }
 
+/*
+ * is_module_rodata_address(unsigned long addr)
+ */
+bool is_module_rodata_address(unsigned long addr)
+{
+	bool ret;
+
+	preempt_disable();
+	ret = __module_rodata_address(addr) != NULL;
+	preempt_enable();
+
+	return ret;
+}
+
+/*
+ * __module_rodata_address - get the module whose rodata contains an address.
+ * @addr: the address.
+ *
+ * Must be called with preempt disabled or module mutex held so that
+ * module doesn't get freed during this.
+ */
+struct module *__module_rodata_address(unsigned long addr)
+{
+	struct module *mod = __module_address(addr);
+	if (mod) {
+		/* Make sure it's within the text section. */
+		if (!within(addr, mod->init_layout.base + mod->init_layout.text_size,
+			mod->init_layout.text_size + mod->init_layout.ro_size)
+		    && !within(addr, mod->core_layout.base + mod->core_layout.text_size,
+			 mod->core_layout.text_size + mod->core_layout.ro_size))
+			mod = NULL;
+	}
+	return mod;
+}
+EXPORT_SYMBOL_GPL(__module_text_address);
+
 /* Don't grab lock, we're oopsing. */
 void print_modules(void)
 {
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index a56c36470cb1..33d90771405d 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -218,5 +218,16 @@ config INIT_ON_FREE_DEFAULT_ON
 	  synthetic workloads have measured as high as 8%.
 
 endmenu
-
+config STRUCT_CONST_OPS_POINTER_HARDENING
+	bool "Struct const operation pointers hardening"
+	help
+		Security sensitive kernel objects, i.e. 'inode', 'file' protect
+		indirect call pointers by declaring const operation pointers and
+		making these pointers reference to static const global variables.
+		However const members in the kernel object are just compile hints
+		with no hardware restriction. To harden the operations pointers,
+		put a check in "open syscall" and make sure pointers are pointing
+		to the function pointers in `.rodata` section as recommanded in
+		Documentation:
+		"Kernel Self-Protection->function pointers must not be writable".
 endmenu
-- 
2.30.2


changelog:

1. Accept the advice and re-implement the `check_valid_ops_pointer` by 
checking if the pointer dereference .rodata section of the kernel or modules

2. the rationale of ops pointer hardening is to supply a weak CFI check,
to shrink the attack surface for out-of-bound or double-free attacks.

3. test the patch by running lmbench(smaller is better) and building kernel.

1437 MHz

"File system latency-hardenging on
0k	75863	52954	108852
1k	48385	44140	87904
4k	50612	47182	90154
10k	55001	27840	20653

"File system latency-hardening off
0k	36408	29820	132689
1k	65186	40018	92480
4k	79369	57943	95766
10k	43918	41612	8068

-------------

> For your commit log, perhaps justify why ops pointers are chosen to
> protect. Are there other pointers that could be protected as well? (In
> other words, what would be the _next_ most common thing an attacker
> would corrupt in the face of this defense being present?)

I read some material of slab attack this week, including an outstanding paper
'Slake: Facilitating slab manipulation for exploiting vulnerabilities in the linux kernel',
some PoCs and slab quarantine by Alexander Popov.

Finally i can try to answer the question.

In summary, there are 3 attacks on slab: 1.out-of-bound  2.double-free 3.use-after-free,
and 2 targets:1.function pointers  2. freelist(metadata)

since the kernel has randomized the metadata by default, the main purpose is to get the 
approximate layout in kmalloc cache, and spray enough manufactured objects to modify the
 function pointer

To modify the pointers who can dereference function pointers(objA->objB->fptr() or obj->fptr()),
1. OOB and double-free need **victim objects**, who have the sensitive pointer to be modified 
by exploiting the vulnerabilities
2. UAF and double-free need **spray objects**, who is controlled by attackers and filled in 
the corrupted object.

both victim and spray objects are allocated in kmalloc and controlled by clear syscalls.
details in the appendix.

As a result, objects that dereference fops is only one of the victim objects, and inspired
 by slab quarantine, maybe we need a new feature to obscure either victim or spray objects.
 I will submit it in the next RFC patch.



Appendix: evaluation public results in 'slake'
> victim: file, subprocess_info, ccid, seq_file, tty_struct, ip_mc_socklist, key, sock
> spray: load_msg, SyS_add_key()

thanks.

Wang Zi-cheng


