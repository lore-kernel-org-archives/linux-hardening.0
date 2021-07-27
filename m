Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350FFC4338F
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jul 2021 10:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB46187C
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jul 2021 10:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhG0KZV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jul 2021 06:25:21 -0400
Received: from smtpbg704.qq.com ([203.205.195.105]:54207 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236306AbhG0KZS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jul 2021 06:25:18 -0400
X-Greylist: delayed 2697 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2021 06:25:17 EDT
X-QQ-mid: bizesmtp43t1627381514tkilclko
Received: from wangzc-pc.nju.edu.cn (unknown [114.212.83.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 27 Jul 2021 18:25:13 +0800 (CST)
X-QQ-SSF: 01400000001000B0P000000D0000000
X-QQ-FEAT: Sadz36CpCaRuYdH8OuHlNdPiWAH4dnF82LN6fr7IdSRKU4EEmQkhe0KfIIG+P
        U5yKBlaho1YoATB6EIi+ziZKGxKwSRlQyJhYtIDO2rgJm9D2DN96jCxUzE22DJMgXN2xGjT
        Qlx1bxYL8Td4aUf/zC9bReXDwNiYEbX4fe2xIabSJPGy3y7af5kThUbj4QLj0Zw6qSi6pU2
        /0XOf+hPdFmkx586ASdR4hgvrlwwloAH43/o+g9jky75M1qxZyZpovycsxxI/OAK/67Yasa
        pWzoGbR7FiAutx5Yz5dOE8tBtccwwIzy5kPVz9n/THIajGIvnxcv0rkudpsXOZrhvkFK5y1
        4v8Rembcb8/84c8xOfrxdTVRYTdDSzBWhSObXRA
X-QQ-GoodBg: 2
From:   Wang Zi-cheng <wzc@smail.nju.edu.cn>
To:     linux-hardening@vger.kernel.org
Cc:     Wang Zi-cheng <wzc@smail.nju.edu.cn>
Subject: [PATCH] RFC struct const ops pointer member hardening
Date:   Tue, 27 Jul 2021 18:26:02 +0800
Message-Id: <20210727102602.259038-1-wzc@smail.nju.edu.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:smail.nju.edu.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Signed-off-by: Wang Zi-cheng <wzc@smail.nju.edu.cn>
----------------------
RFC struct const ops pointer member hardening

some security sensitive kernel objects, i.e. inode, file, use 'const' to declare operations pointers, 
and these pointers reference to the static global variables in read only data segment.

```
struct file {
  ...
	const struct file_operations	*f_op;

const struct file_operations ext4_file_operations = {
```

However, const pointers are just compile hints with no hardware restrictions and prone to be modified by attakers at runtime.

It would be safer to make sure struct const pointer members are not pointing to malicious payload in the slab objects(direct mapping region).

we only need to check "open" syscall, because most file-related operations start with "open".

On the other side, kernel uses `kmem_cache_create` to alloc file/inode rather than `kmalloc`, 
which makes it hard to exploit through heap overflow or UAF, so maybe this is not a "must" update.
----------------------
---
 arch/x86/include/asm/pgtable_64_types.h |  3 +++
 fs/open.c                               |  4 ++++
 include/linux/mm.h                      | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 91ac10654570..ec6ce27dd3a3 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -133,13 +133,16 @@ extern unsigned int ptrs_per_p4d;
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
index e53af13b5835..930cbd75e1e2 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -820,6 +820,10 @@ static int do_dentry_open(struct file *f,
 
 	/* normally all 3 are set; ->open() can clear them if needed */
 	f->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
+	/* check if f_op point to malicious payload */
+	WARN_ON (!check_valid_ops_pointer((unsigned long) f->f_op));
+	WARN_ON (!check_valid_ops_pointer((unsigned long) f->f_inode->i_op));
+	
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ae31622deef..75336676006b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3251,5 +3251,16 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 	return 0;
 }
 
+static inline bool check_valid_ops_pointer(unsigned long addr)
+{
+#ifdef CONFIG_X86_64
+	if (addr >= __PAGE_OFFSET && addr <= DIRECT_MAPPING_END) 
+		return false;
+	else
+		return true;
+#endif
+	return true;
+}
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
-- 
2.32.0



