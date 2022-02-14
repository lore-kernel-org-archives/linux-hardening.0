Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE39C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Feb 2022 21:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiBNVil (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:38:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiBNVih (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Feb 2022 16:38:37 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588B816BFB0
        for <linux-hardening@vger.kernel.org>; Mon, 14 Feb 2022 13:38:26 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z17so11538569plb.9
        for <linux-hardening@vger.kernel.org>; Mon, 14 Feb 2022 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jxd3QRS6hHDImaBiK0k+S4F6Xjbk4YW+HJgrNXY9Kbg=;
        b=Nmw+A+ntyvaKALUT3mnOI9ct+iUH/qh1duzCURRxJmmXg9PhW9yh7YXU0mdQxeq7zL
         mFSt1NihLKxjkxHV1cd26vJE6LXRIxtzDfnkU1oxeE/CPxBl5yMmDsUphIfmc89FHyKT
         ADn5CVifma+Y0my7Sj0IaPyrzW8qhzcCdrP+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jxd3QRS6hHDImaBiK0k+S4F6Xjbk4YW+HJgrNXY9Kbg=;
        b=0rsERuhfPwrABu41K5jwq4bxtDE335CS9gVS6VOdx92kdvKJtYoYtUqyqps7edoiEh
         2MtkVXncmHZxwfiJhaL3Kuqt0mjXI2eX7clSBUnQWg8Jq/w1E8Z6bkbEva3J59MYYQBI
         n4oqOmSD76KYLr45o72v2/yGezYOcZz4QewtcweneIR4cygDZ9cZoeGCLjsrBrC5D+id
         4Y0X+ck3S4PR2aRHzYquyezbvzzzo1ruvubVOYlvBNbFbF6A7s7cABsdVJoZlbiUKL7M
         zAC+QiPoJ6PQIfHJvXTRk7kSJP9Q1wqq+DUbdt5Hnay0tdw9Pp/EuJ2eVB0oZgzlctm9
         ubSQ==
X-Gm-Message-State: AOAM532jpOiNplfyYGZcq9ZpnHdXFvAx3j7fMkMOK/On7GH1AZxyr+PC
        qCUXCNI4O4BgjLaEwkLuJDe6Pw==
X-Google-Smtp-Source: ABdhPJwz9qXp1ylwUoyvV6NLsQOMgokGT4/s/UfbmxTZl0nKGjMTqrC+/GbTLFs+9+7SU8SObuoyww==
X-Received: by 2002:a17:903:404a:: with SMTP id n10mr787760pla.132.1644874705810;
        Mon, 14 Feb 2022 13:38:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mm15sm14469213pjb.46.2022.02.14.13.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:38:25 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] selftests/seccomp: Check for waitid() behavior
Date:   Mon, 14 Feb 2022 13:38:23 -0800
Message-Id: <20220214213823.3297816-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214213823.3297816-1-keescook@chromium.org>
References: <20220214213823.3297816-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4605; h=from:subject; bh=1jqSKIchLphxFjjuynG3rVmJRqaoV1aHoQ0an0zs1aY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiCsvOFMcXnKRiEKhw2szLrF2Z3h7sVbX2lUpHshEi whsVA8OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgrLzgAKCRCJcvTf3G3AJpqCEA CLx5A+9dJE2NBfupspC7K0qqT/WttH9IM9v4weJG/vJVZVxxfPEEpHkVjtDZWVZk2jKWguUFcWOs7M 2y24VcIkFTma4HdENkUZEt3rjjYxQMJMrFu3g7cqWyVKZCNh6t+lwJGhPnSYpiDVnHTlEQMyIh9u9K XP5r+pl71QLNw3/uLkyON9RMLJlWbf8IAfvrws1Hldfc087+NSeaXzc78QUmvuKYzGSNYBhuFNZFO8 N1rsZP2VtAST2REJLAicCGFBQp56T/z4TWr7wmsXDsnaobKZoOpvh0OvXRaf7ucCyc1EAgO01RmPvO jrnyOdzk6crXnsQY4SL+fkBepoUfvZjqF2T1sg/WeUSCeLCyf53jdUR9ZM+pzyEVK+rWQg5qfyXuR7 Uw4Gm8AHjH/eQ1e58L/Gi4WGbLP4TJg+wu00/o+5DczbPYpdlDC48WjC2tEADEdtSohiu2pSS9dvIm FG9XV3n28zAJmwby9K/Q2UlCOkl1gKG3FoveE9tthK6Sof/2rYO+yFti3uDW/8mjeqnOG5RFZz9lXw 0k1LO5FSHqSnEjspvjno9n68zfyg3PsdmJYahZA91DKba9vImYXEZlc91VanCrVTrhAHbRAyT45o+Y +xK2Y3ttmq4OToA2tXbuTmGZ4Sj5hbtlhHFfmPtYFkulvvf3uYiQbexCypLw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Verify we can fetch child's siginfo_t from waitid() with __WCHILDSIGINFO.
Skip if it's not available.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9d126d7fabdb..0c803c2b450e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -268,6 +268,14 @@ struct seccomp_notif_addfd_big {
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH (1UL << 4)
 #endif
 
+#ifndef SYS_SECCOMP
+#define SYS_SECCOMP	1
+#endif
+
+#ifndef __WCHILDSIGINFO
+#define __WCHILDSIGINFO	0x10000000
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -765,6 +773,128 @@ TEST_SIGNAL(KILL_one_arg_six, SIGSYS)
 	close(fd);
 }
 
+FIXTURE(SIGINFO) {
+	pid_t child_pid;
+};
+
+FIXTURE_SETUP(SIGINFO)
+{
+	self->child_pid = 0;
+}
+
+FIXTURE_TEARDOWN(SIGINFO)
+{
+	if (self->child_pid > 0)
+		waitpid(self->child_pid, NULL, WNOHANG);
+}
+
+TEST_F(SIGINFO, child)
+{
+	int status;
+	siginfo_t info = { };
+	/* Kill only when calling __NR_prctl. */
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_PROCESS | 0xBA),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	self->child_pid = fork();
+	ASSERT_LE(0, self->child_pid);
+	if (self->child_pid == 0) {
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+			TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+		}
+		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
+		prctl(PR_GET_SECCOMP, 0, 0, 0, 0);
+		/* Should have died now. */
+		_exit(37);
+	}
+
+	/* Check siginfo_t contents. */
+	EXPECT_EQ(waitid(P_PID, self->child_pid, &info, WEXITED | WNOWAIT), 0);
+#if 0
+	struct {
+		int si_signo;
+		int si_code;
+		int si_errno;
+		union __sifields _sifields;
+	}
+
+	/* SIGCHLD */
+	struct {
+		__kernel_pid_t _pid;	/* which child */
+		__kernel_uid32_t _uid;	/* sender's uid */
+		int _status;		/* exit code */
+		__ARCH_SI_CLOCK_T _utime;
+		__ARCH_SI_CLOCK_T _stime;
+	} _sigchld;
+#endif
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	EXPECT_TRUE(info.si_code == CLD_KILLED || info.si_code == CLD_DUMPED);
+	EXPECT_TRUE(info.si_errno == 0);
+	EXPECT_EQ(info.si_pid, self->child_pid);
+
+	ASSERT_TRUE(WIFSIGNALED(info.si_status));
+	/* TODO: why doesn't this WCOREDUMP() agree with below? */
+	/* EXPECT_TRUE(WCOREDUMP(status)); */
+	EXPECT_EQ(WTERMSIG(info.si_status), SIGSYS);
+
+
+	memset(&info, 0, sizeof(info));
+	status = waitid(P_PID, self->child_pid, &info,
+			WEXITED | WNOWAIT | __WCHILDSIGINFO);
+	EXPECT_EQ(status, 0) {
+		if (status < 0 && errno == EINVAL)
+			SKIP(goto skip_siginfo, "Kernel does not support waitid() with __WCHILDSIGINFO");
+	}
+#if 0
+	/* SIGSYS */
+	struct {
+		void __user *_call_addr;/* calling user insn */
+		int _syscall;		/* triggering system call number */
+		unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
+	} _sigsys;
+
+	info.si_signo = SIGSYS;
+	info.si_code = SYS_SECCOMP;
+	info.si_call_addr = (void __user *)KSTK_EIP(current);
+	info.si_errno = reason;
+	info.si_arch = syscall_get_arch(current);
+	info.si_syscall = syscall;
+
+#endif
+	ASSERT_EQ(info.si_signo, SIGSYS);
+	EXPECT_EQ(info.si_code, SYS_SECCOMP);
+	/* EXPECT_EQ(info.si_arch, ...native arch...); */
+	EXPECT_EQ(info.si_syscall, __NR_prctl);
+	/*
+	 * The syscall will have happened somewhere near the libc
+	 * prctl implementation.
+	 */
+	EXPECT_TRUE(info.si_call_addr >= (void *)prctl &&
+		    info.si_call_addr <= (void *)prctl + PAGE_SIZE) {
+		TH_LOG("info.si_call_addr: %p", info.si_call_addr);
+		TH_LOG("prctl            : %p", prctl);
+	}
+	EXPECT_EQ(info.si_errno, 0xBA);
+
+skip_siginfo:
+	/* Check status contents. */
+	ASSERT_EQ(waitpid(self->child_pid, &status, 0), self->child_pid);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	/* TODO: why doesn't this WCOREDUMP() agree with above? */
+	/* EXPECT_TRUE(WCOREDUMP(status)); */
+	EXPECT_EQ(WTERMSIG(status), SIGSYS);
+	self->child_pid = 0;
+}
+
 /* This is a thread task to die via seccomp filter violation. */
 void *kill_thread(void *data)
 {
-- 
2.30.2

