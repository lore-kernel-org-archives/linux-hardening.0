Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DA27448;
	Thu, 18 Jul 2024 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306572; cv=none; b=TxHLHEblsok5y8BTHXrvWSM3dImGQ6X3BMfqiaC8gCSsuKvQGxSkg32YPRLNRdXDbVmUP1VmfKs/WJ3cjuHedswMlJhsqA0co+Gd7r4QrlCWFLVD+/KrAuiPApmkVMHNqN6nNUNAsk4CAAiyEZwRcoty7rj2X5AYax4bjuWx31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306572; c=relaxed/simple;
	bh=3oo/1fdRVEeoCJR851fHyddrLVIO6d49k2GGZFgER/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHu5+ACSl6eO2NB/iOcV5H8GJbgSHQCQuO+Jw5VbVzbmNx/Tq0RAJiXiCzrdQW9CrDyJomA8v9KB/PB2sONEPT/P0Hd1HQPUtZWga/ufl/6IZAvD+TieQKeJt4EkmTkj3YwGnAfx4W72SUnPacgq7y0CSchnCljF/DNSHNymKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WPslw4s7BzyN2q;
	Thu, 18 Jul 2024 20:38:04 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B511918005F;
	Thu, 18 Jul 2024 20:42:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 20:42:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <arnd@arndb.de>, <maobibo@loongson.cn>,
	<loongarch@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] loongarch: Support RANDOMIZE_KSTACK_OFFSET
Date: Thu, 18 Jul 2024 20:47:39 +0800
Message-ID: <20240718124739.3834489-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Add support of kernel stack offset randomization while handling syscall,
the offset is defaultly limited by KSTACK_OFFSET_MAX().

In order to avoid trigger stack canaries (due to __builtin_alloca) and
slowing down the entry path, use __no_stack_protector attribute to
disable stack protector for do_syscall() at function level.

With this patch, the REPORT_STACK test show that:
	`loongarch64 bits of stack entropy: 7`

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/Kconfig          |  1 +
 arch/loongarch/kernel/syscall.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ddc042895d01..fcf6451b4e38 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -106,6 +106,7 @@ config LOONGARCH
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB if PERF_EVENTS
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index ec17cd5163b7..a332c6cb76ec 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -9,6 +9,7 @@
 #include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
+#include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 
@@ -39,7 +40,7 @@ void *sys_call_table[__NR_syscalls] = {
 typedef long (*sys_call_fn)(unsigned long, unsigned long,
 	unsigned long, unsigned long, unsigned long, unsigned long);
 
-void noinstr do_syscall(struct pt_regs *regs)
+__no_stack_protector void noinstr do_syscall(struct pt_regs *regs)
 {
 	unsigned long nr;
 	sys_call_fn syscall_fn;
@@ -55,11 +56,24 @@ void noinstr do_syscall(struct pt_regs *regs)
 
 	nr = syscall_enter_from_user_mode(regs, nr);
 
+	add_random_kstack_offset();
+
 	if (nr < NR_syscalls) {
 		syscall_fn = sys_call_table[nr];
 		regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
 					   regs->regs[7], regs->regs[8], regs->regs[9]);
 	}
 
+	/*
+	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
+	 * bits. The actual entropy will be further reduced by the compiler
+	 * when applying stack alignment constraints: 16-byte (i.e. 4-bit)
+	 * aligned, which will remove the 4 low bits from any entropy chosen
+	 * here.
+	 *
+	 * The resulting 6 bits of entropy is seen in SP[9:4].
+	 */
+	choose_random_kstack_offset(get_random_u16());
+
 	syscall_exit_to_user_mode(regs);
 }
-- 
2.34.1

