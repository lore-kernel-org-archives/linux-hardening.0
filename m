Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266AC433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4266B60F10
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Nov 2021 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhKCQdY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhKCQdV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Nov 2021 12:33:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC92BC061208
        for <linux-hardening@vger.kernel.org>; Wed,  3 Nov 2021 09:30:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o14so2886637pfu.10
        for <linux-hardening@vger.kernel.org>; Wed, 03 Nov 2021 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSU4MEw1vmUcUpi17shW7A/nf+kzKhbS5n/SddgA9O4=;
        b=ZRq8o3rMRKakkSdoK5LRqJcjb1b8tRoXqy0QPZzj8AQ7lK6BUhtdgWxdVBArTrIbrr
         qHsyzakdYDk8y3bcA23kXvKBfBirr77AJRU6N5bYXqLmyq7LLe4e3H9GH62PL2XHenXy
         EUnZq1zkkK+M+SpC4ASpsEj32tSdvybWu2WZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSU4MEw1vmUcUpi17shW7A/nf+kzKhbS5n/SddgA9O4=;
        b=a0B43KCc51NMBlkYe5ASnMfOArzDDjKfBKf0kkJmwTc2Lj47eTxcpbc5ozh3zYMO4k
         sIlGl3DkO5JGN3RgI+eo8NqDhj4huLJH6PFFk6mU1dpa+DF1+ECcKanbZlbDm7cnTryT
         rdhL1YG7CAFDKWK7PSi4O0DgoBSjNznGmTrXhxLYFTQD8E+O88tOki9ZnrXXc5Cq3bea
         E9NKIeZLJawh99EOzhxyTfvD+XK4VEM2oiMbN+8E9KlYp30zWokgztxs5G2Xp/YNzJj3
         QczQxSt8D4r0ujNJZmGx2Ln8YeISEvsF5GeSVOmjjYE2Qkv2PAB3aZDqx7c4BUXmzxT5
         YCTQ==
X-Gm-Message-State: AOAM532UyHeWM7D2U2NDW/0TTy7le1yXNun9r1PQNSxmK8SqvOmb9dE7
        mQzawA2pN9imUwaS5pZ/R/pXaw==
X-Google-Smtp-Source: ABdhPJwqAkHz1sDMuAlA/Zu6Io8atJqb2f8rFb56TeYotjt8Dvme8IKRkjdJqBIpG7W34wizMZ4SRg==
X-Received: by 2002:a63:8f4a:: with SMTP id r10mr33661700pgn.337.1635957044496;
        Wed, 03 Nov 2021 09:30:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nm13sm2203048pjb.56.2021.11.03.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 09:30:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] selftests/seccomp: Report event mismatches more clearly
Date:   Wed,  3 Nov 2021 09:30:39 -0700
Message-Id: <20211103163039.2104830-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103163039.2104830-1-keescook@chromium.org>
References: <20211103163039.2104830-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3916; h=from:subject; bh=G0yVpCH3xhjkJ1auI6tvazNhkTwsm1uC5S0md53TDcY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhgrkv5H6DETVsitpah1lX33nJQP/HIzqMSAsM18Fh Hbquu/SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYYK5LwAKCRCJcvTf3G3AJn9UEA CcUu7Gac9kA+lcV2BSjseTvB9ZbcjhhxJWD2oKo872hCcWokGfuaOVGNo/203FffnTrQDoB03k2l/M 4lQAR8+0BBMJJp8Ghv1WFkwgmwa0tQHxhmk0cm3a7pwB9SWqcryRrljMUd+rIgZuWa7TvGbn0q66BB SsvRGAAE8eesbMcJY0nigItVk2HjFHC08fP533Ik9YBwhrx3+BBeXC5dNb0GqiaFcko++uqFBmgysa bki7aHqluymwAMpZetKZL8/l2jJU8ffbY5ohlevgFRtE4hhnL1csBql1k1eC436Y26UKBz/Lmytcov J16X3XeScZRlQqNu6ko9vYkqZd4fmVXoLk2pWROXpvXdDjM9luoQ+nHPMfk737LTSXJUigCNEK5FqW zTvuqlhtU1Dfj8NdFXvctdJq2sGKQyDiy0C7fOEbPLGJyvjPoqvZ0INkkiRaV+lqxLyaEGfVlJRwDu zVngSmPOGOe+FPtSQjF9537dK2tY9fsOhGAHsfU3R8EiFZHGQlo2DAJTr0DBJHBf2M9687ilm9ijKR 8+nZtXylTytk/0v1Ozji24h3xhu2s8Yny66jkn2C4JAiPqoULs/y5i+flxhK2v0aE5Gy84fJX58cZn +mp2dylQoLcpYuI22fLmJGRetg6Dnx0nGHM44M03Umb9kOhRCsIp7PNGMgEA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When running under tracer, more explicitly report the status and event
mismatches to help with debugging. Additionally add an "immediate kill"
test when under tracing to verify that fatal SIGSYS behaves the same
under ptrace or seccomp tracing.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 54 +++++++++++++++++--
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index d999643d577c..60b8d5899fe3 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1487,7 +1487,7 @@ TEST_F(precedence, log_is_fifth_in_any_order)
 #define PTRACE_EVENT_SECCOMP 7
 #endif
 
-#define IS_SECCOMP_EVENT(status) ((status >> 16) == PTRACE_EVENT_SECCOMP)
+#define PTRACE_EVENT_MASK(status) ((status) >> 16)
 bool tracer_running;
 void tracer_stop(int sig)
 {
@@ -1539,12 +1539,22 @@ void start_tracer(struct __test_metadata *_metadata, int fd, pid_t tracee,
 
 		if (wait(&status) != tracee)
 			continue;
-		if (WIFSIGNALED(status) || WIFEXITED(status))
-			/* Child is dead. Time to go. */
+
+		if (WIFSIGNALED(status)) {
+			/* Child caught a fatal signal. */
+			return;
+		}
+		if (WIFEXITED(status)) {
+			/* Child exited with code. */
 			return;
+		}
 
-		/* Check if this is a seccomp event. */
-		ASSERT_EQ(!ptrace_syscall, IS_SECCOMP_EVENT(status));
+		/* Check if we got an expected event. */
+		ASSERT_EQ(WIFCONTINUED(status), false);
+		ASSERT_EQ(WIFSTOPPED(status), true);
+		ASSERT_EQ(WSTOPSIG(status) & SIGTRAP, SIGTRAP) {
+			TH_LOG("Unexpected WSTOPSIG: %d", WSTOPSIG(status));
+		}
 
 		tracer_func(_metadata, tracee, status, args);
 
@@ -1961,6 +1971,11 @@ void tracer_seccomp(struct __test_metadata *_metadata, pid_t tracee,
 	int ret;
 	unsigned long msg;
 
+	EXPECT_EQ(PTRACE_EVENT_MASK(status), PTRACE_EVENT_SECCOMP) {
+		TH_LOG("Unexpected ptrace event: %d", PTRACE_EVENT_MASK(status));
+		return;
+	}
+
 	/* Make sure we got the right message. */
 	ret = ptrace(PTRACE_GETEVENTMSG, tracee, NULL, &msg);
 	EXPECT_EQ(0, ret);
@@ -2011,6 +2026,11 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
 	long *syscall_nr = NULL, *syscall_ret = NULL;
 	FIXTURE_DATA(TRACE_syscall) *self = args;
 
+	EXPECT_EQ(WSTOPSIG(status) & 0x80, 0x80) {
+		TH_LOG("Unexpected WSTOPSIG: %d", WSTOPSIG(status));
+		return;
+	}
+
 	/*
 	 * The traditional way to tell PTRACE_SYSCALL entry/exit
 	 * is by counting.
@@ -2128,6 +2148,7 @@ FIXTURE_SETUP(TRACE_syscall)
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret);
 
+	/* Do not install seccomp rewrite filters, as we'll use ptrace instead. */
 	if (variant->use_ptrace)
 		return;
 
@@ -2186,6 +2207,29 @@ TEST_F(TRACE_syscall, syscall_faked)
 	EXPECT_SYSCALL_RETURN(45000, syscall(__NR_gettid));
 }
 
+TEST_F_SIGNAL(TRACE_syscall, kill_immediate, SIGSYS)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_mknodat, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_THREAD),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
+
+	/* Install "kill on mknodat" filter. */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	/* This should immediately die with SIGSYS, regardless of tracer. */
+	EXPECT_EQ(-1, syscall(__NR_mknodat, -1, NULL, 0, 0));
+}
+
 TEST_F(TRACE_syscall, skip_after)
 {
 	struct sock_filter filter[] = {
-- 
2.30.2

