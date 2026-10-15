Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FCA53CA85;
	Thu, 15 Oct 2026 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080850; cv=none; b=UNz542ScDnel7tbtr0Dt2VX4479Iv9+Ije3f/OLy6JKMl7SQnmhgeRcRBQs+BCxm3CjMkvNIl/B/Lme/qLz39gphqXdf5d1MQv+4olG/JcOgYLvEJdZxo/AOJuKA2x3kyvHGnC/s66+LT4AB4t78DaNYWhPQLylHebFk6AUk2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080850; c=relaxed/simple;
	bh=8bwprqGxRBHun1/JgD/FObTrwdc9bx0DjpMwwt2vpFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcKHOENI7PDwOy4QUovOYqAtfI0e8Qm2YTL1lnInJo6iHy2OVSazDMuWPYaU9ufQtrts+h/cxjX//mt8DOEpUrsiaknEO6VipD0wFW7WXQpYAEQYXiFjdKytTgh7tsXrQbtRnzwvovZlETv/RaoFkcnc7zifH7jq6YaS4OpF+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsjYY5n9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsjYY5n9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9FB1F000C4;
	Thu, 15 Oct 2026 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080835;
	bh=30bhUUWIqaWkvxc6HWDx5iOUXFGfR1hON5BVhCv9Fb0=;
	h=From:To:Cc:Subject:Date;
	b=UsjYY5n9mJXBX9OS96InGmyeV3KyCpfgjbeMWYr6T76RGfpdTLrt1sy3vOeXrqJXf
	 WPDxRComZy0EAviqfYuMS8srQoEQdAzsm3FAAE78Q8vPr+8i2Pn6PIP1zLyFkpMQ63
	 kfk0gvNTzXe6W8wwFU6BA29TRknvA/77c5HUfXND1wKm4O1t+7M7Ma5MvyUDwbszUV
	 /BsWH3EaiZxCK8SgBVq+9yNy/Gf2qXiTDyWS2t7F4v76WvDWE6qLYMSUL684JZJ4Pv
	 vlLC+PK2Io+JOn2yqn/MSxB7ZyFUMkqsqMjfvJt+INJmMDcd6RNN6E8oD++NTD227f
	 oTLc42SZCGvEg==
From: Kees Cook <kees@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Test a TSYNC filter arriving during a ptrace stop
Date: Thu, 15 Oct 2026 09:13:53 -0700
Message-ID: <20261015161348.i.779-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4801; i=kees@kernel.org; h=from:subject:message-id; bh=8bwprqGxRBHun1/JgD/FObTrwdc9bx0DjpMwwt2vpFo=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkXfh+wa5A2cGmq0rrgLHVN00u2ybhMLGJpS+aHSX+X2 bUb/rDrKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEiINyPD7J69mrOvB7D+sLif N+upqUq4VPhsoZZZ/9bWPZy1cZPgbEaG2yKLT4vHM89+/nR+0C2zq2xZfcprJnWszddhVFbKM0r nBAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Seccomp runs after ptrace at syscall entry so that it checks what the
tracer left. A thread can get its first filter by TSYNC from a sibling
while it is stopped at a syscall entry; the generic entry code used the
syscall work flags read before the stop, missed SYSCALL_WORK_SECCOMP,
and ran that syscall unfiltered until commit 4a3591287fb7f ("entry: Fix
seccomp bypass after ptrace with TSYNC").

Add a test based on the reproducer from that patch's thread, using pipes
instead of a sleep so the filter is known to be installed before the
tracer resumes the syscall.

Tests run under qemu on ARCH=x86_64 defconfig plus the seccomp selftest
config, with GCC 16.2.0: running the test 20 times all 20 runs pass at
v7.3-rc2 and fails in all 20 with the fix reverted.

Link: https://lore.kernel.org/all/157aa098-a263-4f4f-b0fc-108701480303@huawei.com/
Signed-off-by: Kees Cook <kees@kernel.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 0622bc2acad4..4da5ad1d7ab3 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5041,6 +5041,118 @@ TEST(tsync_vs_dead_thread_leader)
 	EXPECT_EQ(0, status);
 }
 
+struct tsync_vs_ptrace_args {
+	int go[2];
+	int done[2];
+};
+
+static void *tsync_vs_ptrace_syscall_stop_sibling(void *_args)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_getppid, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ERRNO | ESRCH),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	struct tsync_vs_ptrace_args *args = _args;
+	char result = 'N';
+	char go;
+
+	/* Wait for the leader to stop at the entry of getppid(). */
+	if (read(args->go[0], &go, 1) == 1 &&
+	    seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_TSYNC,
+		    &prog) == 0)
+		result = 'Y';
+	if (write(args->done[1], &result, 1) != 1)
+		exit(3);
+
+	return NULL;
+}
+
+/*
+ * Seccomp runs after ptrace at syscall entry, so that it sees what the
+ * tracer left. A thread's first filter can arrive by TSYNC from a sibling
+ * while the thread is stopped at a syscall entry, and it must still apply
+ * to that syscall once the tracer resumes it.
+ */
+TEST(tsync_vs_ptrace_syscall_stop)
+{
+	struct tsync_vs_ptrace_args args;
+	unsigned long msg;
+	char result;
+	int status;
+	pid_t pid;
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+	ASSERT_EQ(0, pipe(args.go));
+	ASSERT_EQ(0, pipe(args.done));
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pthread_t sibling;
+
+		if (pthread_create(&sibling, NULL,
+				   tsync_vs_ptrace_syscall_stop_sibling, &args))
+			exit(1);
+		/* Only this thread is traced; the sibling runs freely. */
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+			exit(2);
+		raise(SIGSTOP);
+
+		ret = syscall(__NR_getppid);
+		/* The filter installed during the entry stop must apply. */
+		if (ret != -1 || errno != ESRCH)
+			exit(4);
+		exit(0);
+	}
+
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFSTOPPED(status));
+	ASSERT_EQ(SIGSTOP, WSTOPSIG(status));
+	ASSERT_EQ(0, ptrace(PTRACE_SETOPTIONS, pid, NULL,
+			    PTRACE_O_TRACESYSGOOD | PTRACE_O_EXITKILL));
+
+	/* Run the child to its syscall entry stop for getppid(). */
+	do {
+		ASSERT_EQ(0, ptrace(PTRACE_SYSCALL, pid, NULL, 0));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status)) {
+			TH_LOG("Child did not stop: status 0x%x", status);
+		}
+		ASSERT_EQ(SIGTRAP | 0x80, WSTOPSIG(status));
+		ASSERT_EQ(0, ptrace(PTRACE_GETEVENTMSG, pid, NULL, &msg));
+	} while (msg != PTRACE_EVENTMSG_SYSCALL_ENTRY ||
+		 get_syscall(_metadata, pid) != __NR_getppid);
+
+	/* Have the sibling install the first filter with TSYNC, and wait. */
+	ASSERT_EQ(1, write(args.go[1], "G", 1));
+	ASSERT_EQ(1, read(args.done[0], &result, 1));
+	ASSERT_EQ('Y', result) {
+		TH_LOG("Sibling could not install the filter with TSYNC");
+	}
+
+	ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, 0));
+	ASSERT_EQ(pid, waitpid(pid, &status, 0));
+	ASSERT_TRUE(WIFEXITED(status)) {
+		TH_LOG("Child did not exit: status 0x%x", status);
+	}
+	EXPECT_EQ(0, WEXITSTATUS(status)) {
+		if (WEXITSTATUS(status) == 4)
+			TH_LOG("getppid() ran without the TSYNC filter");
+	}
+}
+
 #ifdef __x86_64__
 
 /*
-- 
2.55.0

