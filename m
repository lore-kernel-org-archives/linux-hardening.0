Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DDB3C3BEF
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394494; cv=none; b=T1cyg8h50VnEmkpv824tMTV+/s/m70PFgIdconOd6xDeZlpCwCjQUgARUd5FL4glblV1gU5HtTcATkIGBuNNnMWM73RkW4M5CheMcu2cW+f5nIMJ+cdWmi5vrEPnk+zkO51uoRFcJuzT329Jntp0h0A/s7pbESiqRqBWIcAkuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394494; c=relaxed/simple;
	bh=11lwwhf51a8jtMkyr3zD1leOkoMzlOq+orz8Z8qYctM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=DXcj+Y/sSDd3ukSSX7YrtOORO7eNqoU8YlODvTwnjlG0z+8bC+Eqwl1dSxN4hL92ffW2b7uBVtRS4gHXqToMNFDEnW8bEWc7kyIwMMSB9W7HXiJUeVPGxeyFPDC82ZAqZO7X+0QVErZK8Xn8dWwi06ZffgrcpSOMzkKMl4YQZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=om7hJnVJ; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="om7hJnVJ"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e048a801dso3395036b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786394492; x=1786999292; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57hn69LoORcAARZ3NWfsdO/TCnOwkjz9mGtEcWdmx/M=;
        b=om7hJnVJ3mqP34q0TzG5UKRLU32GrspR1q4tLMKWGjACYntP9/09+3f4SHkBAUesx4
         qRkC/FEP/+KintcuMzyOxY3Mm9yoHPU4g1Wh4NhAyeAcEAVoQn2DZrqeXUSHnqJ//n9v
         qKeSNacC7MuwTHree9cM7PiEwGJ3zYHXF+ND8ZT9I5xRuMsTsJmd85dbmc7zYY4wnozG
         lfCQdHgJbSJIxYUJ4YQKnTcuwuKx+Ag705arnIBmIVSgHuALumh1RD88IELvECYXbnlo
         U6frCYxUZPT9c26opf+OWGbHWJbp5YqUNqMrP1LDb523B+Y51bXqa2fPme0uBC0RtEUs
         ni7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394492; x=1786999292;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57hn69LoORcAARZ3NWfsdO/TCnOwkjz9mGtEcWdmx/M=;
        b=VHvkHrjshacHOg+8TcBRwu+L+3wwm0NIQtKTT2XE5iX6th8rcuwYiCR3ZH/r8YCxIa
         BYrQuTiBQs3f08mLpA5YUb2sbGAI+XcJjdZEnH91xwYmdziU1vdt6BMyNa4b/aqLkB6M
         9PE+f85vwX9soLx5jOACDh4jKeso055M1+IHWCPjnl2tsxuv+uGwYRLSUKN660sZjE9q
         p3XnMs/HAH1qQOpbZs9v0Un1cb2cii4moEiTYy3tupxLTXEI4FIOj5IsA84Lxt9uqf4i
         XB3WbhDxRx0DBci8Xd+W0RJVK35Hzqdw0SVDM2dQexQMVgq5SgmjoHzRjGklxU4phF47
         KBZw==
X-Forwarded-Encrypted: i=1; AHgh+Rpup/nerskyw5wll5/tqDQROsbYoUpI4QPdSwAhmk9SeTGNFevUYW0e1NNIcMklS50QDu1JaDR2ItVnlORjMQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE7dOOu8N+oA//q6LlIt34aMfbepbFrgSXOEfjv91AyomXO+LB
	n2ZtMbGzcah2NVd39LU0RSEiXs3kaH/jQ77IEa+zy2FKh0MmZP89eHC7E/OvjxLownGH/AL0CMC
	z
X-Received: from pgbeu25.prod.google.com ([2002:a05:6a02:4799:b0:c99:d21a:f6c5])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:93d0:0:b0:84f:a170:4f5b
 with SMTP id d2e1a72fcca58-84fa1705062mr1047736b3a.8.1786394491846; Mon, 10
 Aug 2026 13:41:31 -0700 (PDT)
Date: Mon, 10 Aug 2026 20:41:13 +0000
In-Reply-To: <20260810204118.1981755-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810204118.1981755-3-morbo@google.com>
Subject: [PATCH 2/2] vfs: Add KUnit tests for fdtable
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This adds a KUnit test suite for fdtable to verify correct allocation,
max_fds initialization, and dynamic object size of the fd array under
__counted_by_ptr when CONFIG_CC_HAS_COUNTED_BY_PTR is enabled.

This patch was generated by CodeMender and checked by submitter.

Cc: codemender-patching+linux@google.com
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 fs/Kconfig               |  8 ++++++++
 fs/file.c                |  4 ++++
 fs/tests/.kunitconfig    |  2 ++
 fs/tests/fdtable_kunit.c | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 fs/tests/.kunitconfig
 create mode 100644 fs/tests/fdtable_kunit.c

diff --git a/fs/Kconfig b/fs/Kconfig
index cf6ae64776e6..f4b9235ab883 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -423,4 +423,12 @@ source "fs/unicode/Kconfig"
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
index 000000000000..41bae6b7400f
--- /dev/null
+++ b/fs/tests/fdtable_kunit.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+
+static void fdtable_test_alloc(struct kunit *test)
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
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);
+
+	/* Check dynamic object size of fdt->fd if compiler supports __counted_by_ptr */
+#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
+	KUNIT_EXPECT_EQ(test, __builtin_dynamic_object_size(fdt->fd, 0),
+			fdt->max_fds * sizeof(struct file *));
+#endif
+
+	/* Free the fdtable */
+	__free_fdtable(fdt);
+}
+
+static struct kunit_case fdtable_test_cases[] = {
+	KUNIT_CASE(fdtable_test_alloc),
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
2.55.0.679.g6767b8d81c-goog

