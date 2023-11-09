Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91F1DFC7
	for <linux-hardening@vger.kernel.org>; Thu,  9 Nov 2023 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0AA1AE
	for <linux-hardening@vger.kernel.org>; Thu,  9 Nov 2023 05:38:57 -0800 (PST)
X-QQ-mid: bizesmtp69t1699537093txdqplh1
Received: from localhost.localdomain ( [123.113.186.121])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Nov 2023 21:37:59 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: +ynUkgUhZJmSoLLIHIXW1BjoHW98x7fmJOzVL7zWM/NfqGYiLws58TvK3E7+G
	1/6CyJLBqICXwA0l2mzvKP7MilohTEGMnnarDhPlIClAV40z6/1Pg8WWjcXybBeMeT88igY
	BASQJ/AhX3p7MRuVnPYsLQXYzyUtNmdFv6s6YtsE67ITjEgaF+lUir24yscyLeSt++1gz4X
	58Q+dmmW+uKJHUAVsYNQsa5l8sbf1mguwwS1M7uEsQSc6rhpwc7lIBM/yLa9NQwxrgAR3+9
	N065IZNppXZrQAU30J78v+VcIVMnuPVLbSvt6FMUBqXFZXdwq6TCvVG6fuRQKsKwZKVL+aC
	By0S4kZufciBEXhppBPK9usJTQ7Sxa4H4oQBlrk
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5075732993716896576
From: Song Shuai <songshuaishuai@tinylab.org>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	keescook@chromium.org,
	guoren@kernel.org,
	bjorn@rivosinc.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	andy.chiu@sifive.com,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	coelacanthushex@gmail.com,
	dlemoal@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V2] riscv: Support RANDOMIZE_KSTACK_OFFSET
Date: Thu,  9 Nov 2023 21:37:51 +0800
Message-Id: <20231109133751.212079-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0

Inspired from arm64's implement -- commit 70918779aec9
("arm64: entry: Enable random_kstack_offset support")

Add support of kernel stack offset randomization while handling syscall,
the offset is defaultly limited by KSTACK_OFFSET_MAX() (i.e. 10 bits).

In order to avoid trigger stack canaries (due to __builtin_alloca) and
slowing down the entry path, use __no_stack_protector attribute to
disable stack protector for do_trap_ecall_u() at the function level.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
Changes since V1:
https://lore.kernel.org/linux-riscv/20231101064423.1906122-1-songshuaishuai@tinylab.org/
- fix whitespace errors Damien pointed out
- add Acked-by and Reviewed-by tags

---
 arch/riscv/Kconfig        |  1 +
 arch/riscv/kernel/traps.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..0e843de33f0c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -100,6 +100,7 @@ config RISCV
 	select HAVE_ARCH_KGDB_QXFER_PKT
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 19807c4d3805..a1a75163fb81 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/randomize_kstack.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -296,7 +297,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 	}
 }
 
-asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
+asmlinkage __visible __trap_section  __no_stack_protector
+void do_trap_ecall_u(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		long syscall = regs->a7;
@@ -308,10 +310,23 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		add_random_kstack_offset();
+
 		if (syscall >= 0 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
 		else if (syscall != -1)
 			regs->a0 = -ENOSYS;
+		/*
+		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
+		 * so the maximum stack offset is 1k bytes (10 bits).
+		 *
+		 * The actual entropy will be further reduced by the compiler when
+		 * applying stack alignment constraints: 16-byte (i.e. 4-bit) aligned
+		 * for RV32I or RV64I.
+		 *
+		 * The resulting 6 bits of entropy is seen in SP[9:4].
+		 */
+		choose_random_kstack_offset(get_random_u16());
 
 		syscall_exit_to_user_mode(regs);
 	} else {
-- 
2.20.1

