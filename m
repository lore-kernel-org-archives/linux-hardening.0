Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C23822A9
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804168; cv=none; b=Y9x6vfnb5SIKbakXHPWIUty9VmvyIyW56R8c6vvGyxGcGsNB2soumUecs+BlAHXMTTHGoOfWvEdnq7jR/jNiZOVkv7L4I66CCS9cwznj+KE/tyTHCJUqTGFg5x60E8ZB3tyX9WLxlENWM2xCBEll3RqR+T2FD7MvgI6vKshtOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804168; c=relaxed/simple;
	bh=UWzUvtID8syz4sGuom2ZigoVHQiCo7GCx8hU0w977u8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=frq64dsqdPVc5z5XxJjpY1w5NFCgUZI+3ab5o47PAqiqGDr0jWGQnA1oi629cq5MU2catbx+WuTIhBwTA12rbq1plNc4zIayZHRO3R34NNeCiURYJ8mqmU0wW9dX2NT/cgSrMS+CPws+63p3Kmu2JyrnACcXUh+NyvDEpXGAMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqBgjLoc; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqBgjLoc"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1850663a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 21:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787804166; x=1788408966; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYByO2UIdNlghf6qo3FWAyAUG9bYH3XbqKc7jalZmSU=;
        b=kqBgjLocOeSrkxMe6lcBL2pLLB5ksuG3zg8ZU9SMOeIViFWBQdUGmSgmp+4vt+nZE9
         SRSJBemGWV2/CJjnL2pVtP/p9BjAOT6n1mayovLUoOiLI4mTUSvTzWGeZZaM69qgMsKp
         XwQv4ZuGAiZzUIkGhEzj10iKuJVuXaaoIN8vN1ARhrOvLey1W/zYU4iRRqDEJm06aHHB
         sZljLGfzg35gAimFSKtL768/1qLsrk1VWKki21ZvEOGEQxSLVITzTmJkg4cxZckQHZc1
         StXWgSiUO8gVYkRxrrfzKBHKBbCFgeIhAG/sljj2iHY/4lYS/Zaa3mCiGSdODiQTsqUQ
         l0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787804166; x=1788408966;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYByO2UIdNlghf6qo3FWAyAUG9bYH3XbqKc7jalZmSU=;
        b=jmdvqGhqS0HunbHcNkyZIcCp7gjFjZn0kOEGLw5fcB8ScnPNvqke7aT5ST9ZgLvsIh
         W7AAr60SXYjH/8oPQtCVAepuat+dFffiAOWJMOxTXYYLtl2ioSuCeNmGrq0OeoXrEaZx
         ckAJSe+tooxItMgTJfFLZEKuvSoM61lB3BgwUanVt0JRHwawV2LZiy0w44IvmeDJwecL
         I12WWLAdU/pMj3BCGyoaqfXxb8Ub4FtGx0BXJJWd7KmEFz7m2Nv+89Nv1WhDBanOMJk1
         oWJW2tliDEmzVfDDvFtYf8dh/ZHCnqJlDiMwj1D96MC5XuyYFCuUV1oAULED4FiAf2+M
         j7TA==
X-Forwarded-Encrypted: i=1; AHgh+RoA+2ZPDPFeAKUFTYwz55ITQoqtHNGuzm3tGeKJk1cNlLkt5HhiaJOGxT7dgI9Un59ARrEx13ot644TPBwr0JQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l0YKdxgCnG2NkTbFup+gW2NO9deVcgv2IwKWCGbybPgi6BiVrG
	uOqg7v59U4I4JZBe8nOYc15xe2spDZMT/PVHVKQgYE+3BSRxL4GlKqYcMPbvBRbZFu1dSktde4q
	/
X-Received: from plok12.prod.google.com ([2002:a17:903:3bcc:b0:2cc:97d3:e244])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c03:b0:2ca:e19c:97b
 with SMTP id d9443c01a7336-2d707a3f857mr189197875ad.5.1787804165952; Wed, 26
 Aug 2026 21:16:05 -0700 (PDT)
Date: Thu, 27 Aug 2026 04:15:56 +0000
In-Reply-To: <20260827041601.187608-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com> <20260827041601.187608-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827041601.187608-2-morbo@google.com>
Subject: [PATCH 2/2] vfs: Add KUnit tests for fdtable
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This adds a KUnit test suite for fdtable to verify correct allocation,
max_fds initialization, and dynamic object size of the fd array under
__counted_by_ptr when CONFIG_CC_HAS_COUNTED_BY_PTR is enabled.

Assisted-by: Gemini:3.1-pro-preview
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2 - Added 'test_dup_fd' testcase for separate allocation path.
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: codemender-patching+linux@google.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 fs/Kconfig               |  8 +++++
 fs/file.c                |  4 +++
 fs/tests/.kunitconfig    |  2 ++
 fs/tests/fdtable_kunit.c | 72 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 fs/tests/.kunitconfig
 create mode 100644 fs/tests/fdtable_kunit.c

diff --git a/fs/Kconfig b/fs/Kconfig
index e05917adcd60..05b63f7506a7 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -421,4 +421,12 @@ source "fs/unicode/Kconfig"
 config IO_WQ
 	bool
 
+config FDTABLE_KUNIT_TEST
+	bool "KUnit test for fdtable" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the fdtable KUnit tests, which tests various aspects
+	  of the fdtable structure and allocation.
+
 endmenu
diff --git a/fs/file.c b/fs/file.c
index 628ca07dc4b1..9c7001b901cf 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1529,3 +1529,7 @@ int iterate_fd(struct files_struct *files, unsigned n,
 	return res;
 }
 EXPORT_SYMBOL(iterate_fd);
+
+#ifdef CONFIG_FDTABLE_KUNIT_TEST
+#include "tests/fdtable_kunit.c"
+#endif
diff --git a/fs/tests/.kunitconfig b/fs/tests/.kunitconfig
new file mode 100644
index 000000000000..de67125a9421
--- /dev/null
+++ b/fs/tests/.kunitconfig
@@ -0,0 +1,2 @@
+CONFIG_KUNIT=y
+CONFIG_FDTABLE_KUNIT_TEST=y
diff --git a/fs/tests/fdtable_kunit.c b/fs/tests/fdtable_kunit.c
new file mode 100644
index 000000000000..6abd2a8d8f5d
--- /dev/null
+++ b/fs/tests/fdtable_kunit.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+
+static void test_alloc_fdtable(struct kunit *test)
+{
+	struct fdtable *fdt;
+	unsigned int slots = 64;
+
+	fdt = alloc_fdtable(slots);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
+
+	/* Check that max_fds is set correctly and is >= slots */
+	KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
+
+	/* Check that fd is allocated */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt->fd);
+
+	/*
+	 * Check dynamic object size of fdt->fd if compiler supports
+	 * __counted_by_ptr.
+	 */
+#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+	KUNIT_EXPECT_EQ(test, __builtin_dynamic_object_size(fdt->fd, 0),
+			fdt->max_fds * sizeof(struct file *));
+#endif
+
+	__free_fdtable(fdt);
+}
+
+static void test_dup_fd(struct kunit *test)
+{
+	struct files_struct *newf;
+	struct fdtable *fdt;
+
+	newf = dup_fd(&init_files, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, newf);
+
+	fdt = rcu_dereference_raw(newf->fdt);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
+
+	/* Check that max_fds is set correctly and is >= NR_OPEN_DEFAULT */
+	KUNIT_EXPECT_GE(test, fdt->max_fds, NR_OPEN_DEFAULT);
+
+	/* Check that fd is allocated */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt->fd);
+
+	/*
+	 * Check dynamic object size of fdt->fd if compiler supports
+	 * __counted_by_ptr.
+	 */
+#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+	KUNIT_EXPECT_EQ(test, __builtin_dynamic_object_size(fdt->fd, 0),
+			fdt->max_fds * sizeof(struct file *));
+#endif
+
+	put_files_struct(newf);
+}
+
+static struct kunit_case fdtable_test_cases[] = {
+	KUNIT_CASE(test_alloc_fdtable),
+	KUNIT_CASE(test_dup_fd),
+	{}
+};
+
+static struct kunit_suite fdtable_test_suite = {
+	.name = "fdtable",
+	.test_cases = fdtable_test_cases,
+};
+
+kunit_test_suite(fdtable_test_suite);
-- 
2.55.0.897.gb25b4bd76c-goog

