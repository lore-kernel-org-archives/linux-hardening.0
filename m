Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262F76020
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553620; cv=none; b=MzAlPTxgzsybPs5UT98NSeTZdCk1Nnwzao0/YaK6GPVzP3o7Fa1lxF25MfVQWxhHpjtxQmVUmqb1x524vAF3Os/bEDSeqwPckVX2mbHHE/K1/GXaIgA/5LBrsuoFEoGQup5T+0qvNA2kb/JlCC1DxD0HQNGLcHnpivC6DCJoZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553620; c=relaxed/simple;
	bh=R2t7ERucYntEaiouukVxBCXGGyHD7wa90M6aZ+Evuwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mvyoZOk8AdzM+988uSsDLJ0e6WrkLoYvSfgWTAtHVuyaJzlfyBLupvVr+W6ITzaDW7WXAzdJyBY6C+ETDujYhfnQzC/+GvZ79j+e7LgeYWWN5TObYu8WKmewqxnu7LM5gasmx9xLXMxbNLIqvQCVV72Bi3BRywq4r49mTLouCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YKVpCR0o; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YKVpCR0o"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a27fbe832so554373eaf.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553618; x=1707158418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FndaoLuezk++wxgVrcH5NtXJoTq/9EmRf7oCHvFRc0=;
        b=YKVpCR0oacknJ8wxTULb127zriOH+E//z3pPhQins5bYgYqK+4Dgdze79PZCCzP3Bo
         95DyjSBEyL0oAeynXPoI5anVT0xLw4Txap1NGjkIQcnEwbmK/Lt71ejXEddXjTtZav6s
         aLIAP5XARwhNVephydle/KFdQm0r/p7Op5uq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553618; x=1707158418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FndaoLuezk++wxgVrcH5NtXJoTq/9EmRf7oCHvFRc0=;
        b=L0QxkACjUjDh/yPt2pZo8ctI0duMkRB0aBySj51sp2xx7Y5oVGavR9KGsEJM98QNa0
         AQ2Fv4vOFS9jRX0cSVfsbxz75uJR7YlJWsZrRT65qDghG6AF231MrB/bx1jAWzvpD//8
         asTS5SI8+rbW01c2D2hH9r0dkj+aUTSLS2Ms4dt1/6EGP2mB6xIHyWUR13YymYT8xflf
         d0jHM8HISpOr67EWrJDy9/nq5khlPEBZ32gjjIuIkkRUKj7hAh9uGlYNY/AL7zgrKbPI
         neh5tBb2rronmY/2szkjnpg7Un0s35H6CGPOTE5VW/Xw1yeKrgW08VUP1Omesywc4nCS
         QWng==
X-Gm-Message-State: AOJu0YwJCl1k82IgNvevxPkY0u21RDPOL0j+1jWq0Gzwj1bZfQHYu1I2
	3oCNR6P+CkzGfYZJcFVwK9E21+KUNuMs2Hhf0w/oOwXimIVya/4dN7LGnjlOTQ==
X-Google-Smtp-Source: AGHT+IHOhi+sxu1kUOA8mCIzVmAbbxxks8PiFMkQLmL98Lyj8XHKWyUPwIfFNCDqEurVhlwYZZyIyw==
X-Received: by 2002:a05:6358:d592:b0:178:632d:656f with SMTP id ms18-20020a056358d59200b00178632d656fmr2226352rwb.62.1706553618251;
        Mon, 29 Jan 2024 10:40:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b005cd86cd9055sm6450299pgk.1.2024.01.29.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:40:17 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] select: Avoid wrap-around instrumentation in do_sys_poll()
Date: Mon, 29 Jan 2024 10:40:15 -0800
Message-Id: <20240129184014.work.593-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2692; i=keescook@chromium.org;
 h=from:subject:message-id; bh=R2t7ERucYntEaiouukVxBCXGGyHD7wa90M6aZ+Evuwc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt/EPCgLg3aGtKRVzbHxjO78YeZKfPnx5tmaL9
 ehYjSVEgj6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfxDwAKCRCJcvTf3G3A
 JudFD/4uj/y23P8K+iLzDJ8hOxwYy4bJl41fAFTr2k6Q1vBAcDDMCSOq7ZggcPMb7ixLGFwyNcY
 KlAInc1U0WE9ttaTeseDa0Rj/x8VV4ygOBIkywlomWkVKJXAMRv3RzT0H/MtQBaayJVZ7+a6KIG
 03JEZgOWmMKFT6mMl9hDu65yy37G7tRzOfLbWF7hcuzhEz2Z6hUhkl/yXUwNq3/ml5T3D+DuSFw
 ySoX+Bk/uLVmIEtFiRK4WrXbLH8ld3qwsU1CN8GNApzcJhb2Nb8E0pjM8QRvm+SLGznR9p0yXut
 Cj/UnGpJs1l+GIvDv/n6H4aRvcXauUntzoT+qLmYseBhos4YiHAtT/1GVFx/IWfPeV0/Or9Gxol
 1VQUpH5v09Z0yt3IxuJXLmYMhFxOKgVAubQk9JQZafDMW0Y8Y9FAcXJ1O0r6TmhE8lZba2qiTi7
 /4VTVfjzPLrfyrJy/+h8yt2OmQhT5kU06J39wfOYI8b39I+B9Fduig96lgysYFTZC4dYLniRgbv
 n5QosAv43xkYCX9W7n7GASxlft7ESwATPaZ0bb5JEOV012ZuuX0TyK61a/ZeR/Yzhi9LrYnNwRT
 qhOS1mgazV2q9wTf5a+VzSWFPqz+4Yxb0Cpb5cMk1Y7UVCXCA4xjJ+sni5dnXpvgxgxOeSkYiP+
 BYy8vSA Ho8G6Txw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The mix of int, unsigned int, and unsigned long used by struct
poll_list::len, todo, len, and j meant that the signed overflow
sanitizer got worried it needed to instrument several places where
arithmetic happens between these variables. Since all of the variables
are always positive and bounded by unsigned int, use a single type in
all places. Additionally expand the zero-test into an explicit range
check before updating "todo".

This keeps sanitizer instrumentation[1] out of a UACCESS path:

vmlinux.o: warning: objtool: do_sys_poll+0x285: call to __ubsan_handle_sub_overflow() with UACCESS enabled

Link: https://github.com/KSPP/linux/issues/26 [1]
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/select.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 0ee55af1a55c..11a3b1312abe 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -839,7 +839,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
 
 struct poll_list {
 	struct poll_list *next;
-	int len;
+	unsigned int len;
 	struct pollfd entries[];
 };
 
@@ -975,14 +975,15 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 		struct timespec64 *end_time)
 {
 	struct poll_wqueues table;
-	int err = -EFAULT, fdcount, len;
+	int err = -EFAULT, fdcount;
 	/* Allocate small arguments on the stack to save memory and be
 	   faster - use long to make sure the buffer is aligned properly
 	   on 64 bit archs to avoid unaligned access */
 	long stack_pps[POLL_STACK_ALLOC/sizeof(long)];
 	struct poll_list *const head = (struct poll_list *)stack_pps;
  	struct poll_list *walk = head;
- 	unsigned long todo = nfds;
+	unsigned int todo = nfds;
+	unsigned int len;
 
 	if (nfds > rlimit(RLIMIT_NOFILE))
 		return -EINVAL;
@@ -998,9 +999,9 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 					sizeof(struct pollfd) * walk->len))
 			goto out_fds;
 
-		todo -= walk->len;
-		if (!todo)
+		if (walk->len >= todo)
 			break;
+		todo -= walk->len;
 
 		len = min(todo, POLLFD_PER_PAGE);
 		walk = walk->next = kmalloc(struct_size(walk, entries, len),
@@ -1020,7 +1021,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 
 	for (walk = head; walk; walk = walk->next) {
 		struct pollfd *fds = walk->entries;
-		int j;
+		unsigned int j;
 
 		for (j = walk->len; j; fds++, ufds++, j--)
 			unsafe_put_user(fds->revents, &ufds->revents, Efault);
-- 
2.34.1

