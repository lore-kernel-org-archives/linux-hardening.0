Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6892F30;
	Fri, 19 Jul 2024 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721358593; cv=none; b=u5J45H+lQTbMI/cKFS8VNQ4XK+KSHjiUxYxg9dC9FGWrYKzg1rdK8L/bNZsL0+eFTQqrlGQ89dpqWq22rvUTKcD1Tyxs+q3OpmEAiYzi0Tb3wejDJeO6db+OSk2rfjrPzuLsmGaOadn/GKtKedyEimSuA2rzmBJbiJhi8abx8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721358593; c=relaxed/simple;
	bh=0NipiEREOOjna/QPiVAGaJs9rCAbwvD6mTE4Or+JFkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FQbjQgFmoUZxKc0XV63kauQGUqJ6cyQdC8oTTzghtk6gTYWDCNoee1QQl2IDxJKY98aj3VW3fLLeso1SJiw4y4IKxNayNBs/ncpfqeYSatiuZxxWkgWauzoosCOtEsa66bNeUwQkg3CELpvFRYP5RRXrzX6nTp46nNEy636HQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WQF4z5DqZznbfc;
	Fri, 19 Jul 2024 11:09:07 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F8E9180106;
	Fri, 19 Jul 2024 11:09:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 19 Jul
 2024 11:09:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <arnd@arndb.de>, <maobibo@loongson.cn>,
	<loongarch@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] loongarch: Support RANDOMIZE_KSTACK_OFFSET
Date: Fri, 19 Jul 2024 11:14:27 +0800
Message-ID: <20240719031427.119274-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Add support of kernel stack offset randomization while handling syscall,
the offset is defaultly limited by KSTACK_OFFSET_MAX().

In order to avoid trigger stack canaries (due to __builtin_alloca) and
slowing down the entry path, use __no_stack_protector attribute to
disable stack protector for do_syscall() at function level.

With this patch, the REPORT_STACK test show that:
	`loongarch64 bits of stack entropy: 7`

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Huacai Chen <chenhuacai@kernel.org>
---
v2:
- get_random_u16() -> drdtime().
- Add Suggested-by.
---
 arch/loongarch/Kconfig          |  1 +
 arch/loongarch/kernel/syscall.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

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
index ec17cd5163b7..9df81197a09b 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -9,11 +9,13 @@
 #include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
+#include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 
 #include <asm/asm.h>
 #include <asm/exception.h>
+#include <asm/loongarch.h>
 #include <asm/signal.h>
 #include <asm/switch_to.h>
 #include <asm-generic/syscalls.h>
@@ -39,7 +41,7 @@ void *sys_call_table[__NR_syscalls] = {
 typedef long (*sys_call_fn)(unsigned long, unsigned long,
 	unsigned long, unsigned long, unsigned long, unsigned long);
 
-void noinstr do_syscall(struct pt_regs *regs)
+__no_stack_protector void noinstr do_syscall(struct pt_regs *regs)
 {
 	unsigned long nr;
 	sys_call_fn syscall_fn;
@@ -55,11 +57,24 @@ void noinstr do_syscall(struct pt_regs *regs)
 
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
+	choose_random_kstack_offset(drdtime());
+
 	syscall_exit_to_user_mode(regs);
 }
-- 
2.34.1

