Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A78C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jul 2021 06:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E48A60C3F
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jul 2021 06:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhG1GwH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jul 2021 02:52:07 -0400
Received: from smtpbg511.qq.com ([203.205.250.109]:53922 "EHLO
        smtpbg511.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhG1GwG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jul 2021 02:52:06 -0400
X-Greylist: delayed 76286 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 02:52:06 EDT
X-QQ-mid: bizesmtp46t1627455117t6ikcf1d
Received: from wangzc-pc.nju.edu.cn (unknown [36.154.209.16])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 28 Jul 2021 14:51:56 +0800 (CST)
X-QQ-SSF: 01400000001000B0P000000B0000000
X-QQ-FEAT: L8+aRVORnLn4M1XtRZoWtZXse1fZAwNShPZ7DWyvP+ZQ69w+CWng3U7S2zuvA
        vpbi3D7n/46+qCbk3t27iFxT3H/JKj7NfOKxY47c+2lgXQYS5bhrxH53S5BAuM73605ZGFc
        MS34Vnax1WPaefO1+AxSoOVhBMkm+ul9y1o4pwpIhbGheGhS9N0++xROqSVds50RcoV0h9i
        cyGPfDi34zlEcMiqDxP+ge7IxoYPOdD8c6jnLnE2aPrjID7jRNLcpqM7bNPmPZP15Yma1oO
        78l7894ZY/0ARayhzn8tsm/teqt6ibL1X7kUvXN8yIqONXlBr8J1zSpY+dGDRtpxUTTICVY
        5epWvCnWZf4Jg3AB9BrheaTZQEA1lV/AMX3W5w0Hu3i5Vjcxi8=
X-QQ-GoodBg: 2
From:   Wang Zi-cheng <wzc@smail.nju.edu.cn>
To:     keescook@chromium.org, tycho@tycho.pizza,
        linux-hardening@vger.kernel.org
Cc:     Wang Zi-cheng <wzc@smail.nju.edu.cn>
Subject: [PATCH] RFC v2 struct const ops pointers member hardening
Date:   Wed, 28 Jul 2021 14:52:40 +0800
Message-Id: <20210728065239.472464-1-wzc@smail.nju.edu.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:smail.nju.edu.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Signed-off-by: Wang Zi-cheng <wzc@smail.nju.edu.cn>
--------------------
RFC v2 struct const ops pointers member hardening

I apologize for making mistakes in my previous submission, I fix the previous problems,
 add compile options and make tests(compile and lmbench).

1. this is a useful hardening, my opinion was wrong in the previous patch, 
because the attacker may overwrite a struct with an "struct file*" pointer,
 which point to a manufactured file struct with malicious f_op.
Hardening operation pointers CAN help.
> On the other side, kernel uses `kmem_cache_create` to alloc file/inode rather than `kmalloc`, 
> which makes it hard to exploit through heap overflow or UAF, so maybe this is not a "must" update.

2. V2 add compile option 'STRUCT_CONST_OPS_POINTER_HARDENING' in 
'Security options -> Kernel hardening options -> Struct const operation pointers hardening'

> PATCH v1
> some security sensitive kernel objects, i.e. inode, file, use 'const' to declare operations pointers, 
> and these pointers reference to the static global variables in read only data segment.

> ```
> struct file {
>   ...
> 	const struct file_operations	*f_op;
> 
> const struct file_operations ext4_file_operations = {
> ```

> However, const pointers are just compile hints with no hardware restrictions and prone to be modified by attakers at runtime.
> It would be safer to make sure struct const pointer members are not pointing to malicious payload in the slab objects(direct mapping region).
> we only need to check "open" syscall, because most file-related operations start with "open".


---
 arch/x86/include/asm/pgtable_64_types.h |  5 +++++
 fs/open.c                               |  5 +++++
 include/linux/mm.h                      |  9 +++++++++
 security/Kconfig.hardening              | 13 +++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 91ac10654570..869ef3dfaf29 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -128,18 +128,23 @@ extern unsigned int ptrs_per_p4d;
 
 #define __VMEMMAP_BASE_L4	0xffffea0000000000UL
 #define __VMEMMAP_BASE_L5	0xffd4000000000000UL
+#define DIRECT_MAPPING_TB_L4 64UL
+#define DIRECT_MAPPING_TB_L5 32000UL
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
 # define VMALLOC_SIZE_TB	(pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
 # define VMEMMAP_START		vmemmap_base
+# define DIRECT_MAPPING_SIZE_TB 	(pgtable_l5_enabled() ? DIRECT_MAPPING_TB_L5 : DIRECT_MAPPING_TB_L4)
 #else
 # define VMALLOC_START		__VMALLOC_BASE_L4
 # define VMALLOC_SIZE_TB	VMALLOC_SIZE_TB_L4
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
+# define DIRECT_MAPPING_SIZE_TB		DIRECT_MAPPING_TB_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
+#define DIRECT_MAPPING_END		(__PAGE_OFFSET + (DIRECT_MAPPING_SIZE_TB << 40) - 1)
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..871750b57267 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -820,6 +820,11 @@ static int do_dentry_open(struct file *f,
 
 	/* normally all 3 are set; ->open() can clear them if needed */
 	f->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
+	/* check if f_op point to malicious payload */
+#ifdef CONFIG_STRUCT_CONST_OPS_POINTER_HARDENING
+	WARN_ON (!check_valid_ops_pointer((unsigned long) f->f_op));
+	WARN_ON (!check_valid_ops_pointer((unsigned long) f->f_inode->i_op));
+#endif
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ae31622deef..c787acda7012 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3250,6 +3250,15 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 
 	return 0;
 }
+#ifdef CONFIG_STRUCT_CONST_OPS_POINTER_HARDENING
+static inline bool check_valid_ops_pointer(unsigned long addr)
+{
+	if (addr >= __PAGE_OFFSET && addr <= DIRECT_MAPPING_END) 
+		return false;
+	else
+		return true;
+}
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index a56c36470cb1..3a7e2a046842 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -219,4 +219,17 @@ config INIT_ON_FREE_DEFAULT_ON
 
 endmenu
 
+config STRUCT_CONST_OPS_POINTER_HARDENING
+	depends on X86_64
+	bool "Struct const operation pointers hardening"
+	help
+		Security sensitive kernel objects, i.e. 'inode', 'file' protect 
+		indirect call pointers by declaring const operation pointers and 
+		making these pointers reference to static const global variables. 
+		However const members in the kernel object are just compile hints
+		with no hardware restriction. To hardening the operations pointers
+		in structs, put a check in "open syscall" and make sure pointers
+		are not pointing to the malicious payload in slub 
+		objects(direct mapping region).
+
 endmenu
-- 
2.32.0



