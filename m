Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42C4AA00D;
	Tue, 22 Sep 2026 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107060; cv=none; b=SHk9KLWj5koePz1HMZiyVQNNpo4HMOUJQcUOeewNqZJ0plmK9nWNu+4bfvRyzbN4d/qIgpBsw6oVwRWo60YkLcX3oM2NZOxEiLFh6Llf8VFLu8W0dgVwd4/WZk2Kd8qWQzv7L3qH6pHYxQHHNz68xMt9A5yiB4xm3yoXmb0xV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107060; c=relaxed/simple;
	bh=ZZ3/lvXFNs1lg2dDopy2fkY4jeWNeezpAZTvbUBNIwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIToBQI5H6PUWLqmaRkpyc8V1Y56NcAIdEw4Jpdw9yessbW2d+igO24IIQW1cq2PkqJYTpz4Be/6pbVjWENTUJPnJiOFspK5VyuLFhHwHYoSUHjwG5yZ6nD2oaQP9VyQMROFKQf4Jo9EtpEML02wxyLf6NsP0AO5iG1yahUkpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5p5eaOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5p5eaOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FC81F000FF;
	Tue, 22 Sep 2026 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790107057;
	bh=LWf2P5Ys75rAjXmSpn/rwIwvU1jkRlLw5TSKsGJpoII=;
	h=From:To:Cc:Subject:Date;
	b=i5p5eaOEomxZ5KRbEZIx4y6EMe4Ky0fZ1ze7lLcIncPOv+AjkI9a6pPfrbzo+Gv7P
	 pCHoatm/4wvaJSqLP4iqnnz2af6VOrxTyrf+pJ88C0vF3/XTwFGpCMrUVywKVGJQgH
	 K61uLSN6nBP/mY97/cENdKrzU2KZc3/hP+A10q8J16kth7bGHgZD8kHhjdiAWrnGcO
	 OCR65VAfLSITl3ffbY3k70vAFW23QqjYOHMVJCTURhYy9Yrkm+wGl43uZ1n6wvf4UH
	 mVKtaCKZrpGgKgMi4HOttUeL4gJdKoIC/Q/I30ACWKutDKXw2MdNDMMfmTdV2hRo+x
	 Y6jsi5cuGGD2Q==
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Kees Cook <kees@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	oleg@redhat.com,
	luto@amacapital.net,
	wad@chromium.org,
	peterz@infradead.org,
	ada.coupriediaz@arm.com,
	linusw@kernel.org,
	yeoreum.yun@arm.com,
	kevin.brodsky@arm.com,
	anshuman.khandual@arm.com,
	james.morse@arm.com,
	thuth@redhat.com,
	vladimir.murzin@arm.com,
	tglx@kernel.org,
	broonie@kernel.org,
	liqiang01@kylinos.cn,
	ryan.roberts@arm.com,
	pengcan@kylinos.cn,
	kmehltretter@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/ptrace: Add PTRACE_SYSEMU_SINGLESTEP syscall-exit-stop test
Date: Tue, 22 Sep 2026 12:57:20 -0700
Message-Id: <20260922195719.i.211-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9515; i=kees@kernel.org; h=from:subject:message-id; bh=ZZ3/lvXFNs1lg2dDopy2fkY4jeWNeezpAZTvbUBNIwE=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmb7s5/uSQyNuOKZH7YrKpLahc4+i/U7Gp6ZZVWWSfkO 1nKf8nKjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImsv8jwz/wex/rrvV3/y88v bpPa4RNwm4P/iwKv1dU9LGsnB66U3Mrwv8JceMUxw8M7PvokFvoreFfZf9dt8ZJPWyvA5yXON8+ XBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

ptrace(2) states that no syscall-exit-stop occurs when a tracee is
continued with PTRACE_SYSEMU or PTRACE_SYSEMU_SINGLESTEP. arm64 gated
its syscall-exit report on

	flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)

and ptrace_resume() clears SYSCALL_TRACE for both SYSEMU requests while
PTRACE_SYSEMU_SINGLESTEP additionally sets TIF_SINGLESTEP, so the
single-step bit alone produced a stop that must not exist. Nothing in
tools/testing/selftests covered this.

Detecting the extra stop is less direct than it looks. The report is
emitted with step=1, so ptrace_report_syscall_exit() dispatches to
user_single_step_report() rather than ptrace_report_syscall(), and it
arrives as a plain SIGTRAP indistinguishable by signal from the
legitimate single-step trap: neither PTRACE_O_TRACESYSGOOD nor
PTRACE_GET_SYSCALL_INFO separates the two. What does separate them is
the PC. The redundant report fires before the tracee has moved past the
syscall instruction, so it lands on the PC of the syscall-entry stop:

	[0] sig=133 SYSCALL-STOP  pc=0x41ec28
	[1] sig=5   trap          pc=0x41ec28   <-- must not exist
	[2] sig=5   trap          pc=0x41ec2c

A fixed kernel reports pc=0x41ec2c already at stop [1]. The test
therefore asserts that the first stop after the syscall-entry stop is at
a different PC, which tests the consequence rather than the mechanism
and does not depend on how many pseudo-step traps follow.

PTRACE_SYSEMU is used to reach the syscall-entry stop, as single-
stepping there costs one stop per instruction and takes roughly 200000
stops. Architectures without a PC accessor here, or without SYSEMU
support, skip rather than fail.

Build tested ARCH=arm64 with GCC aarch64-linux-gnu 16.1.0, ARCH=arm
with GCC arm-linux-gnueabihf 16.1.0, and ARCH=x86_64 with GCC 16.2.0.

Tests passing on ARCH=arm64 under qemu-system-aarch64, and the same
test fails as expected on v7.3-rc2 without the fix[1]:

	# entry stop pc=0x41ec28, next stop sig=5 pc=0x41ec28
	# Expected next_pc (4320296) != entry_pc (4320296)
	not ok 1 sysemu.no_syscall_exit_stop

An AArch32 build of the same test on an arm64 kernel reproduces the
failure identically, covering the is_compat_task() path. It also passes
on x86_64, which already uses generic entry, so the test does not report
a false positive against a correct implementation.

Link: https://lore.kernel.org/all/20260922035510.1090299-2-ruanjinjie@huawei.com/ [1]
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 tools/testing/selftests/ptrace/Makefile       |   3 +-
 .../selftests/ptrace/sysemu_singlestep.c      | 176 ++++++++++++++++++
 tools/testing/selftests/ptrace/.gitignore     |   1 +
 3 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptrace/sysemu_singlestep.c

diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index c5e0b76ba6ac..5284d79e9b71 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := get_syscall_info set_syscall_info peeksiginfo vmaccess get_set_sud
+TEST_GEN_PROGS := get_syscall_info set_syscall_info peeksiginfo vmaccess get_set_sud \
+		  sysemu_singlestep
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/sysemu_singlestep.c b/tools/testing/selftests/ptrace/sysemu_singlestep.c
new file mode 100644
index 000000000000..f9b16445b3d5
--- /dev/null
+++ b/tools/testing/selftests/ptrace/sysemu_singlestep.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Check that PTRACE_SYSEMU_SINGLESTEP does not report a syscall-exit-stop.
+ *
+ * ptrace(2), "Syscall-stops":
+ *
+ *	If the tracee is continued using any other method (including
+ *	PTRACE_SYSEMU), no syscall-exit-stop occurs. Note that all mentions of
+ *	PTRACE_SYSEMU apply equally to PTRACE_SYSEMU_SINGLESTEP.
+ *
+ * PTRACE_SYSEMU_SINGLESTEP sets SYSCALL_EMU and enables single-stepping, and
+ * ptrace_resume() clears SYSCALL_TRACE for it. An architecture that gates its
+ * syscall-exit report on "single-stepping is enabled" rather than on "the
+ * tracer asked for syscall stops" reports an extra stop here.
+ *
+ * Detecting that extra stop takes some care. The report is emitted with
+ * step=1, and ptrace_report_syscall_exit() then calls
+ * user_single_step_report() rather than ptrace_report_syscall(), so it arrives
+ * as a plain SIGTRAP: PTRACE_O_TRACESYSGOOD and PTRACE_GET_SYSCALL_INFO cannot
+ * tell it from the legitimate single-step trap. What distinguishes it is the
+ * PC, which has not yet moved past the syscall instruction. So this asserts
+ * that the first stop after the syscall-entry stop is at a different PC.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ptrace.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <linux/elf.h>
+#include <linux/ptrace.h>
+#include "../kselftest_harness.h"
+
+/*
+ * Not every libc declares these, even where the kernel implements them (an
+ * AArch32 tracer on an arm64 kernel, for instance). The values are ABI.
+ */
+#ifndef PTRACE_SYSEMU
+#define PTRACE_SYSEMU			31
+#endif
+#ifndef PTRACE_SYSEMU_SINGLESTEP
+#define PTRACE_SYSEMU_SINGLESTEP	32
+#endif
+
+/*
+ * Reading the PC portably would need one regset layout per architecture. Cover
+ * the ones that implement PTRACE_SYSEMU_SINGLESTEP and can be checked here;
+ * elsewhere the test skips rather than failing the build or the run.
+ */
+#if defined(__aarch64__)
+#include <asm/ptrace.h>
+static int tracee_pc(pid_t pid, unsigned long long *pc)
+{
+	struct user_pt_regs regs;
+	struct iovec iov = { &regs, sizeof(regs) };
+
+	if (ptrace(PTRACE_GETREGSET, pid, (void *)NT_PRSTATUS, &iov))
+		return -1;
+	*pc = regs.pc;
+	return 0;
+}
+#elif defined(__arm__)
+static int tracee_pc(pid_t pid, unsigned long long *pc)
+{
+	unsigned long uregs[18];	/* struct user_regs; uregs[15] is PC */
+	struct iovec iov = { uregs, sizeof(uregs) };
+
+	if (ptrace(PTRACE_GETREGSET, pid, (void *)NT_PRSTATUS, &iov))
+		return -1;
+	*pc = uregs[15];
+	return 0;
+}
+#elif defined(__x86_64__) || defined(__i386__)
+#include <sys/user.h>
+static int tracee_pc(pid_t pid, unsigned long long *pc)
+{
+	struct user_regs_struct regs;
+	struct iovec iov = { &regs, sizeof(regs) };
+
+	if (ptrace(PTRACE_GETREGSET, pid, (void *)NT_PRSTATUS, &iov))
+		return -1;
+#if defined(__x86_64__)
+	*pc = regs.rip;
+#else
+	*pc = regs.eip;
+#endif
+	return 0;
+}
+#else
+static int tracee_pc(pid_t pid, unsigned long long *pc)
+{
+	return -1;
+}
+#define NO_PC_ACCESSOR	1
+#endif
+
+FIXTURE(sysemu)
+{
+	pid_t tracee;
+};
+
+FIXTURE_SETUP(sysemu)
+{
+	self->tracee = -1;
+}
+
+FIXTURE_TEARDOWN(sysemu)
+{
+	/* Reap the tracee however the test ended, including on assert. */
+	if (self->tracee > 0) {
+		kill(self->tracee, SIGKILL);
+		waitpid(self->tracee, NULL, 0);
+	}
+}
+
+TEST_F(sysemu, no_syscall_exit_stop)
+{
+	unsigned long long entry_pc = 0, next_pc = 0;
+	int status;
+
+#ifdef NO_PC_ACCESSOR
+	SKIP(return, "no PC accessor for this architecture");
+#endif
+
+	self->tracee = fork();
+	ASSERT_GE(self->tracee, 0);
+	if (self->tracee == 0) {
+		if (ptrace(PTRACE_TRACEME, 0, 0, 0))
+			_exit(1);
+		raise(SIGSTOP);
+		/* A raw syscall: a libc wrapper may not issue one. */
+		syscall(__NR_getpid);
+		_exit(0);
+	}
+
+	ASSERT_EQ(waitpid(self->tracee, &status, 0), self->tracee);
+	ASSERT_TRUE(WIFSTOPPED(status));
+	ASSERT_EQ(ptrace(PTRACE_SETOPTIONS, self->tracee, 0,
+			 (void *)PTRACE_O_TRACESYSGOOD), 0);
+
+	/*
+	 * PTRACE_SYSEMU reaches the syscall-entry stop in one resume. Getting
+	 * there by single-stepping would cost one stop per instruction.
+	 */
+	if (ptrace(PTRACE_SYSEMU, self->tracee, 0, 0)) {
+		if (errno == EIO || errno == EINVAL)
+			SKIP(return, "PTRACE_SYSEMU not supported");
+		ASSERT_EQ(errno, 0) TH_LOG("PTRACE_SYSEMU: %m");
+	}
+	ASSERT_EQ(waitpid(self->tracee, &status, 0), self->tracee);
+	ASSERT_TRUE(WIFSTOPPED(status));
+	ASSERT_TRUE(WSTOPSIG(status) & 0x80)
+		TH_LOG("expected a syscall-entry stop, got signal %d",
+		       WSTOPSIG(status));
+	ASSERT_EQ(tracee_pc(self->tracee, &entry_pc), 0);
+
+	/* The resume under test. */
+	if (ptrace(PTRACE_SYSEMU_SINGLESTEP, self->tracee, 0, 0)) {
+		if (errno == EIO || errno == EINVAL)
+			SKIP(return, "PTRACE_SYSEMU_SINGLESTEP not supported");
+		ASSERT_EQ(errno, 0) TH_LOG("PTRACE_SYSEMU_SINGLESTEP: %m");
+	}
+	ASSERT_EQ(waitpid(self->tracee, &status, 0), self->tracee);
+	ASSERT_TRUE(WIFSTOPPED(status));
+	ASSERT_EQ(tracee_pc(self->tracee, &next_pc), 0);
+
+	TH_LOG("entry stop pc=%#llx, next stop sig=%d pc=%#llx",
+	       entry_pc, WSTOPSIG(status), next_pc);
+
+	EXPECT_NE(next_pc, entry_pc)
+		TH_LOG("redundant syscall-exit-stop reported at the syscall PC");
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index f6be8efd57ea..792c81f804c0 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -4,3 +4,4 @@ get_set_sud
 peeksiginfo
 vmaccess
 set_syscall_info
+sysemu_singlestep
-- 
2.34.1

