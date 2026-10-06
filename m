Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485753822B7;
	Tue,  6 Oct 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277602; cv=none; b=sMH6eCRNgKNZg4vjfZOKjQ+wp84suOkixl0KFObAMvfRgyuodrDMqPy9thvJBVtWmINrpcznS1NHLbuQibDQ8iNNyi7iHZrwPjVirMPdz5JWm8yichyNaJrX934n0eEsGXYIFFLhcHJ82B+XWwfbmTe1mPhjOB4WUxY8gAicG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277602; c=relaxed/simple;
	bh=mVI5lvlBaJvbQUE+DeyS83R9kZqWun+Sy4716zKGRW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZCUnvJjFNIP11VLvOvUalSOXu8c4GLgYIv/c2p/wW8p2mb94AQkZoKFMdt9rAVN7GxeupoPVWSQaf6yIKBi4K++bqGihMh0Gqfx15xO5BFXNdbHr2K1+QUUEcSOxDf77pU7ZgTiAD8nfxgAQdYRtGJVVSaC9EJPDkVZD/OSqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npHp7Gew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npHp7Gew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC95F1F000FF;
	Tue,  6 Oct 2026 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791277600;
	bh=sUnzJFS0vEkM45lr13Lwjbra7wmPUhF8l2cLj7aPAwc=;
	h=From:To:Cc:Subject:Date;
	b=npHp7GewNj9aWKVHSgMpZLYTCW0F+d3oQXS2gwaG7CGidoCcNl85j7dKe3VlQM5cj
	 7b78FgL4LDd/kF9EdIon+tC54ylETW129D5l5uxQQ8i7t61DpTm9IpJyEVM49bigLu
	 /DvOa/TVrHPgEQyJ+yjQYAkEwWWvUP+VpgIaPnQsg06+VpEeQWZWqFkWCKxyLfI8RF
	 sHzJKh/rTyCqwkUnqkJXCxdO23kPW/BjkA+kdOKoswBUUBudt5JzJDrHoJ6BGDCGiH
	 yZNL+B0G5Usnm4/ugkqYcT7/pfYge+6H8TSIMTDTY0EnLnIFNFYvPB/l/qK77Ykmmj
	 FKUUNU1qCt7pA==
From: Kees Cook <kees@kernel.org>
To: Cong Wang <cwang@multikernel.io>
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Split fork_and_close into clone and close tests
Date: Tue,  6 Oct 2026 02:06:38 -0700
Message-ID: <20261006090637.i.823-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12721; i=kees@kernel.org; h=from:subject:message-id; bh=mVI5lvlBaJvbQUE+DeyS83R9kZqWun+Sy4716zKGRW8=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlHdskJOPg71cgE7dpn9uFWjuxC6cPrwmtuOjz0nZ3cc /ha8butHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABN59Zrhr+Slj1tZ5l5W+B2e tjVJNpDvydkHG2bc0N4pIRHRJfZh/gWGf2rGYUcMN+ZERGRv+9At+LBx4YPFe5L3ydtf7LPgFZp 0hQkA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

fork_and_close checked three things against one listener: that a
restarted clone3() creates exactly one child, that a restarted close()
releases its descriptor, and that a supervisor error reaches the caller
after a restart. A three-pass loop chose what each pass did for each
variant, and a failure in the first check kept the others from running.

Split it into notification_restart.clone and notification_restart.close,
each with one mediated syscall, one signal, and one expected result per
variant. They share helpers that fork the filtered child, receive its
listener, and interrupt its notification. notification_restart_child()
now uses the same fork and report helpers, and the filter flags are
computed in one place. Drop the supervisor error check, which
failed_receive already covers.

Tests run on ARCH=x86_64 defconfig with CONFIG_PROVE_LOCKING=y,
CONFIG_DEBUG_ATOMIC_SLEEP=y, and CONFIG_DEBUG_LIST=y under QEMU, built
with GCC 16.2.0: seccomp_bpf passes 137/137 with 5 skips, and the 28
notification_restart tests pass in 25 of 25 runs at -smp 2 and -smp 4.
On v7.3-rc2 the restart and both variants fail and the others pass.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 258 ++++++++++--------
 1 file changed, 148 insertions(+), 110 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b902d52cc917..730aaa21ee2d 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4916,20 +4916,27 @@ FIXTURE_VARIANT_ADD(notification_restart, both) {
 	.restart = true, .killable = true,
 };
 
-FIXTURE_SETUP(notification_restart)
+static unsigned int
+notification_restart_flags(const FIXTURE_VARIANT(notification_restart) *variant)
 {
 	unsigned int flags = SECCOMP_FILTER_FLAG_NEW_LISTENER;
 
+	if (variant->restart)
+		flags |= SECCOMP_FILTER_FLAG_RESTART_BEFORE_RECV;
+	if (variant->killable)
+		flags |= SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV;
+	return flags;
+}
+
+FIXTURE_SETUP(notification_restart)
+{
 	self->pid = -1;
 	self->listener = -1;
 	self->sync[0] = self->sync[1] = -1;
 	ASSERT_EQ(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0), 0);
 	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, self->sync), 0);
-	if (variant->restart)
-		flags |= SECCOMP_FILTER_FLAG_RESTART_BEFORE_RECV;
-	if (variant->killable)
-		flags |= SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV;
-	self->listener = user_notif_syscall(__NR_getppid, flags);
+	self->listener = user_notif_syscall(__NR_getppid,
+					    notification_restart_flags(variant));
 	ASSERT_GE(self->listener, 0);
 }
 
@@ -4944,29 +4951,50 @@ FIXTURE_TEARDOWN(notification_restart)
 	close(self->sync[1]);
 }
 
-static void notification_restart_child(struct __test_metadata *_metadata,
-				       struct _test_data_notification_restart *self)
+/*
+ * Fork the notifying child with SIGUSR1 handled. Returns true in the
+ * child, which sends its result with notification_report().
+ */
+static bool notification_restart_fork(struct __test_metadata *_metadata,
+				      struct _test_data_notification_restart *self)
 {
 	struct sigaction action = { .sa_handler = notification_restart_handler };
-	long result[2];
 
 	self->pid = fork();
 	ASSERT_GE(self->pid, 0);
 	if (self->pid)
-		return;
+		return false;
 
-	close(self->listener);
 	close(self->sync[0]);
 	handled = self->sync[1];
 	if (sigemptyset(&action.sa_mask) || sigaction(SIGUSR1, &action, NULL))
 		_exit(1);
-	result[0] = syscall(__NR_getppid);
-	result[1] = errno;
+	return true;
+}
+
+/* Send the child's syscall result to notification_result(), and exit. */
+static __noreturn void notification_report(long ret, int err)
+{
+	long result[2] = { ret, err };
+
 	if (write(handled, result, sizeof(result)) != sizeof(result))
 		_exit(1);
 	_exit(0);
 }
 
+static void notification_restart_child(struct __test_metadata *_metadata,
+				       struct _test_data_notification_restart *self)
+{
+	long ret;
+
+	if (!notification_restart_fork(_metadata, self))
+		return;
+
+	close(self->listener);
+	ret = syscall(__NR_getppid);
+	notification_report(ret, errno);
+}
+
 static void notification_pending(struct __test_metadata *_metadata, int fd)
 {
 	struct pollfd pfd = { .fd = fd, .events = POLLIN };
@@ -5084,28 +5112,17 @@ TEST_F(notification_restart, after_receive)
 	notification_result(_metadata, self, USER_NOTIF_MAGIC, 0);
 }
 
-TEST_F(notification_restart, fork_and_close)
+/*
+ * Fork a child that installs its own filter notifying on @nr, so that the
+ * test process is not mediated, and receive the child's listener. Returns
+ * true in the child.
+ */
+static bool
+notification_restart_filtered(struct __test_metadata *_metadata,
+			      struct _test_data_notification_restart *self,
+			      const FIXTURE_VARIANT(notification_restart) *variant,
+			      int nr)
 {
-	struct sigaction action = { .sa_handler = notification_restart_handler };
-	struct sock_filter filter[] = {
-		BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, nr)),
-#ifdef __NR_fork
-		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_fork, 0, 1),
-		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_USER_NOTIF),
-#endif
-#ifdef __NR_clone
-		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_clone, 0, 1),
-		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_USER_NOTIF),
-#endif
-#ifdef __NR_clone3
-		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_clone3, 0, 1),
-		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_USER_NOTIF),
-#endif
-		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_close, 0, 1),
-		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_USER_NOTIF),
-		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
-	};
-	struct sock_fprog prog = { .len = ARRAY_SIZE(filter), .filter = filter };
 	char control[CMSG_SPACE(sizeof(int))] = {};
 	char c = 'f';
 	struct iovec iov = { .iov_base = &c, .iov_len = 1 };
@@ -5114,73 +5131,25 @@ TEST_F(notification_restart, fork_and_close)
 		.msg_control = control, .msg_controllen = sizeof(control),
 	};
 	struct cmsghdr *cmsg;
-	/*
-	 * glibc's fork() blocks all signals across clone(), so the
-	 * notification wait could not be interrupted: call clone3()
-	 * directly instead.
-	 */
-	struct __clone_args args = { .exit_signal = SIGCHLD };
-	unsigned int flags = SECCOMP_FILTER_FLAG_NEW_LISTENER;
-	int i, fd, listener, status;
-	long result[2] = {};
-	pid_t child;
-
-	if (__NR_clone3 < 0)
-		SKIP(return, "Test not built with clone3 support");
-	/* Some container profiles reject clone3() with ENOSYS. */
-	if (sys_clone3(NULL, 0) == -1 && errno == ENOSYS)
-		SKIP(return, "clone3() is not available");
+	int listener;
 
-	if (variant->restart)
-		flags |= SECCOMP_FILTER_FLAG_RESTART_BEFORE_RECV;
-	if (variant->killable)
-		flags |= SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV;
+	/* A filter chain may hold only one listener. */
 	ASSERT_EQ(close(self->listener), 0);
 	self->listener = -1;
-	self->pid = fork();
-	ASSERT_GE(self->pid, 0);
-	if (!self->pid) {
-		close(self->sync[0]);
-		handled = self->sync[1];
-		ASSERT_EQ(sigemptyset(&action.sa_mask), 0);
-		ASSERT_EQ(sigaction(SIGUSR1, &action, NULL), 0);
-		fd = open("/dev/null", O_RDONLY);
-		ASSERT_GE(fd, 0);
-		listener = seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);
-		ASSERT_GE(listener, 0);
+	if (notification_restart_fork(_metadata, self)) {
+		listener = user_notif_syscall(nr, notification_restart_flags(variant));
+		if (listener < 0)
+			_exit(1);
 		cmsg = CMSG_FIRSTHDR(&msg);
 		cmsg->cmsg_level = SOL_SOCKET;
 		cmsg->cmsg_type = SCM_RIGHTS;
 		cmsg->cmsg_len = CMSG_LEN(sizeof(listener));
 		memcpy(CMSG_DATA(cmsg), &listener, sizeof(listener));
-		ASSERT_EQ(sendmsg(handled, &msg, 0), 1);
-
-		child = sys_clone3(&args, sizeof(args));
-		if (!child)
-			_exit(0);
-		if (variant->restart) {
-			ASSERT_GT(child, 0);
-			ASSERT_EQ(waitpid(child, &status, 0), child);
-			ASSERT_TRUE(WIFEXITED(status));
-			ASSERT_EQ(WEXITSTATUS(status), 0);
-			ASSERT_EQ(waitpid(-1, &status, WNOHANG), -1);
-			ASSERT_EQ(errno, ECHILD);
-			ASSERT_EQ(close(fd), 0);
-			ASSERT_EQ(fcntl(fd, F_GETFD), -1);
-			ASSERT_EQ(errno, EBADF);
-		} else {
-			ASSERT_EQ(child, -1);
-			ASSERT_EQ(errno, EINTR);
-			ASSERT_EQ(close(fd), -1);
-			ASSERT_EQ(errno, EINTR);
-			ASSERT_GE(fcntl(fd, F_GETFD), 0);
-		}
-
-		ASSERT_EQ(sys_clone3(&args, sizeof(args)), -1);
-		ASSERT_EQ(errno, EAGAIN);
-		ASSERT_EQ(write(handled, result, sizeof(result)), sizeof(result));
-		_exit(0);
+		if (sendmsg(handled, &msg, 0) != 1)
+			_exit(1);
+		return true;
 	}
+
 	ASSERT_EQ(recvmsg(self->sync[0], &msg, 0), 1);
 	ASSERT_FALSE(msg.msg_flags & MSG_CTRUNC);
 	cmsg = CMSG_FIRSTHDR(&msg);
@@ -5189,30 +5158,99 @@ TEST_F(notification_restart, fork_and_close)
 	ASSERT_EQ(cmsg->cmsg_type, SCM_RIGHTS);
 	ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(listener)));
 	memcpy(&self->listener, CMSG_DATA(cmsg), sizeof(self->listener));
+	return false;
+}
 
-	for (i = 0; i < 3; i++) {
-		struct seccomp_notif req = {};
-		struct seccomp_notif_resp resp = {};
+/*
+ * Interrupt the child's notification before it is received. Without the
+ * restart flag the syscall fails with EINTR. With it, the restarted
+ * syscall is notified again, allowed to continue, and succeeds.
+ */
+static void
+notification_restart_interrupt(struct __test_metadata *_metadata,
+			       struct _test_data_notification_restart *self,
+			       const FIXTURE_VARIANT(notification_restart) *variant)
+{
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
 
-		notification_pending(_metadata, self->listener);
-		if (i < 2 || variant->restart) {
-			notification_signal(_metadata, self);
-			if (!variant->restart)
-				continue;
-			notification_pending(_metadata, self->listener);
-		}
-		ASSERT_EQ(ioctl(self->listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
-		EXPECT_EQ(req.pid, self->pid);
-		resp.id = req.id;
-		if (i == 2)
-			resp.error = -EAGAIN;
-		else
-			resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
-		ASSERT_EQ(ioctl(self->listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+	notification_pending(_metadata, self->listener);
+	notification_signal(_metadata, self);
+	if (!variant->restart) {
+		notification_result(_metadata, self, -1, EINTR);
+		return;
 	}
+	notification_pending(_metadata, self->listener);
+	ASSERT_EQ(ioctl(self->listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	EXPECT_EQ(req.pid, self->pid);
+	resp.id = req.id;
+	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+	ASSERT_EQ(ioctl(self->listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
 	notification_result(_metadata, self, 0, 0);
 }
 
+/* A successful clone3() must have created exactly one child. */
+static __noreturn void notification_restart_clone_child(void)
+{
+	/*
+	 * glibc's fork() blocks all signals across clone(), so the
+	 * notification wait could not be interrupted: call clone3()
+	 * directly instead.
+	 */
+	struct __clone_args args = { .exit_signal = SIGCHLD };
+	int status;
+	long ret;
+
+	ret = sys_clone3(&args, sizeof(args));
+	if (ret == 0)
+		_exit(0);
+	if (ret > 0) {
+		if (waitpid(ret, &status, 0) != ret || !WIFEXITED(status) ||
+		    WEXITSTATUS(status) != 0)
+			_exit(2);
+		if (waitpid(-1, NULL, WNOHANG) != -1 || errno != ECHILD)
+			_exit(3);
+		ret = 0;
+	}
+	notification_report(ret, errno);
+}
+
+/* close() must release the descriptor exactly when it succeeds. */
+static __noreturn void notification_restart_close_child(void)
+{
+	int fd, err;
+	long ret;
+
+	fd = open("/dev/null", O_RDONLY);
+	if (fd < 0)
+		_exit(1);
+	ret = close(fd);
+	err = errno;
+	if ((fcntl(fd, F_GETFD) == -1) != (ret == 0))
+		_exit(2);
+	notification_report(ret, err);
+}
+
+TEST_F(notification_restart, clone)
+{
+	if (__NR_clone3 < 0)
+		SKIP(return, "Test not built with clone3 support");
+	/* Some container profiles reject clone3() with ENOSYS. */
+	if (sys_clone3(NULL, 0) == -1 && errno == ENOSYS)
+		SKIP(return, "clone3() is not available");
+
+	if (notification_restart_filtered(_metadata, self, variant, __NR_clone3))
+		notification_restart_clone_child();
+	notification_restart_interrupt(_metadata, self, variant);
+}
+
+TEST_F(notification_restart, close)
+{
+	if (notification_restart_filtered(_metadata, self, variant, __NR_close))
+		notification_restart_close_child();
+	notification_restart_interrupt(_metadata, self, variant);
+}
+
 TEST_F(notification_restart, fatal_signal)
 {
 	int status;
-- 
2.55.0

