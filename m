Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB184382383;
	Tue,  6 Oct 2026 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277533; cv=none; b=tJa/N6kMlSxtjcOA0xj9UTloAmGpotYhEVmT2kM2uTxVNTSXkGmb6DgEjATMCN/ydCMAsRd3oahu03nvMQnBNMLSwaw/QaybMVQf4ZX975/zW/oir0cWlBClvsgi3vmJy77+ZK+2u/l4TVwG6h9CwRmFlEqsUpEWIGdRPMs8GIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277533; c=relaxed/simple;
	bh=DqlX7p8H4/IV/CTzoF6Pn+1zd/zy2/hFxTa3S31Whfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TR4F4nvHTuLgmPtoCIde9GrN5wFDBrWKOfK50s4oXl8VrakFIBt8OAFzOn8FJlstLWyLVyxlbnqkYKDpsAag98WEdGb0P2IR5E+iLTqti4CSE7Dq/1necRK/kgJCMsLulZW1+XKaX4InZVj6OibnsR7bloeDLvPUs2pMtzfe3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD2W5yP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD2W5yP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519411F000FF;
	Tue,  6 Oct 2026 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791277531;
	bh=bJa95qu+WgQA0I7hDtTyw4vZyAQhmnKWc8K9WvZumho=;
	h=From:To:Cc:Subject:Date;
	b=cD2W5yP7pSXrSAt+TWwOVVQ8EQfuSFuR/hpJjySLe50mIYTwkR3fQP+cj4dTmCG/X
	 TH+rMPxZzt8DdaRJmlA3kAuEV0CdiU4VIgMlIiudqKKHGe5X2Kq6vYBI5KYIvnYoo+
	 sySoUsrVsw5b/V3Ew9mo6AcKLThjLvTqj0LbHcgUJyvgyB0thV5PZooMu0qao1a0xw
	 j5OAQQPQ9bWaSiCvN165r/DmUV3zEI8MHRlnAQAE6VgCsZ8yChR8Ok2PHhtUSeIoA0
	 vZSWQWXWCnHMkSVFqcZXWkGbk/B8EuItywx0ZjJ2NfzWdmUMU76Y0I9OQ8K+sV0ogo
	 +iGkMvxrQpWPg==
From: Kees Cook <kees@kernel.org>
To: Cong Wang <cwang@multikernel.io>
Cc: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] seccomp: Document RESTART_BEFORE_RECV and O_PATH addfd
Date: Tue,  6 Oct 2026 02:05:29 -0700
Message-ID: <20261006090528.i.976-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3586; i=kees@kernel.org; h=from:subject:message-id; bh=DqlX7p8H4/IV/CTzoF6Pn+1zd/zy2/hFxTa3S31Whfg=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlHdt7MqF73jOmoWL/0Tdt3N8/qcOhP2XRFt2zX3I/H7 bfFnVpysaOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAiEx4y/BV7+ar59rtso2vM jB3+dUseGel3vLLrknhmfuKH+d+7smaMDNsLz3fKOFv6bec7Hepx0aTJdmNGmIT1YXOW9N64syG J/AA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Describe SECCOMP_FILTER_FLAG_RESTART_BEFORE_RECV in the UAPI header, as
SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV is described above it, and say in
the documentation that supervisors must tolerate ENOENT from
SECCOMP_IOCTL_NOTIF_RECV, which the flag makes routine. Note at the
fget_raw() call that O_PATH files are allowed on purpose.

Build tested ARCH=x86_64 defconfig (kernel/seccomp.o and headers) with
GCC 16.2.0, and SPHINXDIRS=userspace-api htmldocs.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 Documentation/userspace-api/seccomp_filter.rst | 8 ++++++++
 include/uapi/linux/seccomp.h                   | 1 +
 tools/include/uapi/linux/seccomp.h             | 1 +
 kernel/seccomp.c                               | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index b6875ce54fe2..0a00336d773a 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -292,6 +292,14 @@ for calls such as ``close`` where callers do not retry on ``EINTR``.
 A failed notification receive that resets the notification to its initial
 state is also eligible for restart.
 
+Each restart withdraws the pending notification, so a supervisor woken by
+``poll()``, or blocked in ``ioctl(SECCOMP_IOCTL_NOTIF_RECV)``, may find
+nothing left to receive, and the ioctl then fails with ``ENOENT``. This
+already happens whenever a notifying process is interrupted before receipt,
+but with this flag it becomes routine under repeated signals. Supervisors
+should treat ``ENOENT`` from ``SECCOMP_IOCTL_NOTIF_RECV`` as a reason to wait
+again, not as an error.
+
 The flag requires ``SECCOMP_FILTER_FLAG_NEW_LISTENER`` and can be used with
 or without ``SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV``. Using both flags allows
 handlers to run before receipt and defers non-fatal signals during supervisor
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 30b76aa48355..3a0ee0551261 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -25,6 +25,7 @@
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
 /* Received notifications wait in killable state (only respond to fatal signals) */
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+/* Restart syscalls interrupted before their notification is received */
 #define SECCOMP_FILTER_FLAG_RESTART_BEFORE_RECV	(1UL << 6)
 
 /*
diff --git a/tools/include/uapi/linux/seccomp.h b/tools/include/uapi/linux/seccomp.h
index 30b76aa48355..3a0ee0551261 100644
--- a/tools/include/uapi/linux/seccomp.h
+++ b/tools/include/uapi/linux/seccomp.h
@@ -25,6 +25,7 @@
 #define SECCOMP_FILTER_FLAG_TSYNC_ESRCH		(1UL << 4)
 /* Received notifications wait in killable state (only respond to fatal signals) */
 #define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV	(1UL << 5)
+/* Restart syscalls interrupted before their notification is received */
 #define SECCOMP_FILTER_FLAG_RESTART_BEFORE_RECV	(1UL << 6)
 
 /*
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e6e1feed0e7b..3eecba5ccdef 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1743,6 +1743,7 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
 		return -EINVAL;
 
+	/* Allow O_PATH files, as SCM_RIGHTS and pidfd_getfd() do. */
 	kaddfd.file = fget_raw(addfd.srcfd);
 	if (!kaddfd.file)
 		return -EBADF;
-- 
2.55.0

