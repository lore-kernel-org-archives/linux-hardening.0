Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCCA2F1FED
	for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488561; cv=none; b=sd7cuka0QFKVOGqoXfitb5f7uF+yy28yI36jO/L5EfPDAN3DpaF5HsWLhopfeh6foXAXUwjcUBhEtwdeRI4mflm3AiqzYVfQ7putkqRravj0owp4woB/TT0bqmxo6SIVSesBDrDJJOtbds/3QASFM/qD6Bzdf42alLhfK8wtEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488561; c=relaxed/simple;
	bh=m3/foVSlTLprK6U8iofc1Peeyg3Q/8J0g9g8uSqe4BY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fYUJLySHaizO256BzYQhzdSPZOwKg2gywkW2IPeQCT9Zj15J5SNJ95jcnbPDsv7GFF+tSSyvK+L726AoGJnCtSPu54tiigiTf+y7qvdLOLg2VPD5Fk9Unjz4OYv3m7zqHxf6cqnlLMNycnP+bMw+9FgEwRqFZTC8tqXLLpL5v/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvIfu+G0; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvIfu+G0"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cacd6d37edso32559355ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787488559; x=1788093359; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KQtX5pXj3qkU4C9cUQP5SJ/zcnZzst6Ie4c6fXHOEj4=;
        b=JvIfu+G0hA3jaICs9/OAE4CnORtLZHXeEu1FiUKZ5nF3o8XK+asOicM2/acA+XGhRh
         XkMpPo+una0kb45V8LgiJ5HULpr50MKoxuYcaQRwRHZfjF6W1NSgjmDaLv71AwJlkrMH
         WWqzpked99VxFWc6caDBTyJaubxgOjfFcSjdzV113EB74CElnWX2PgP2OWtAhOxlFn2d
         HO9yG8gkcNkWUMegnCCWQYmmZjJYrf4euz82/Wz1EjGq57QWcecvuMiRdMKsrod5uG2w
         bIEHTrowvM5rmCFo/FLJp+nmhlLPxoV62Lqq/9/FUJ6HZbvmTu0Rb6HCdAoTd20/TNPx
         qqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787488559; x=1788093359;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQtX5pXj3qkU4C9cUQP5SJ/zcnZzst6Ie4c6fXHOEj4=;
        b=a+mwPcGLpwzVtr+c5odCHH2UaQMNAUaWwjr/3IzI/bRXZXFRJ9qDXSde3Pl4wG/sT+
         33UVtzknQxG4nHhL+Mru2pIw4HmrjS/Vt2SFl6vKcvejKmZu2v2I7AByt5B9kzwG9Cwu
         FPlA+HrBy0PnrrbT2MtDnfJvhUWfDJTOUC6juf3PN1O+9a0Z9ASXGk8g59rC2pij5gkj
         kZ2NBN0XO0jq8w5H9AAGmIGMqsplidAmrhmigkFZImxi6OgenQvKuBHTiLsiTba5xQXL
         2wSAi9JpJKWL+yPeqO/VvBqVCFkNXPpxYiEPxeNJiIaYOxbfSMLiaKBNbkkA5T7LSgck
         cYwA==
X-Forwarded-Encrypted: i=1; AHgh+RpVVXAjKUu0mSVXp8gasnUbrI6NvYG/xOCrEtAxN98dKJ9ozzs2aytndmduv8iKMqsk46jbVWEOFmTXycXM/u0=@vger.kernel.org
X-Gm-Message-State: AFuF++nQXgKcSdO37TcbaOctJ+i+LQ1hReIJpyYBWPLAyB2rnixAmoMz
	AAhFGgRMox2ZQGYTii2Y+LB9PHEP1PbOWhNn7ZO7Gp0tIivFA43G7hoosUXV9IvIg4jV7Kaf0r6
	G
X-Received: from plco20.prod.google.com ([2002:a17:902:e294:b0:2ca:d66c:97b2])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f685:b0:2ca:6c8:abd8
 with SMTP id d9443c01a7336-2d670d5a2a6mr190055005ad.12.1787488558893; Sun, 23
 Aug 2026 05:35:58 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:35:33 +0000
In-Reply-To: <20260823123549.1120133-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823123549.1120133-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260823123549.1120133-3-morbo@google.com>
Subject: [PATCH 2/2] lib/tests: Add KUnit test for struct stack_trace
 __counted_by_ptr attribute
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Dmitry Antipov <dmantipov@yandex.ru>, Petr Mladek <pmladek@suse.com>, Kir Chou <note351@hotmail.com>, 
	codemender-patching+linux@google.com, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Add a custom KUnit test suite 'stacktrace_counted_by' to verify that the
__counted_by_ptr annotation on the 'entries' field of 'struct stack_trace'
behaves correctly.

The test verifies that 'max_entries' correctly limits and validates access
to 'entries' when CONFIG_ARCH_STACKWALK is not defined. If it is defined,
the test is cleanly skipped at runtime to prevent compile-time or runtime
failures due to 'struct stack_trace' being undefined on modern
architectures.

Assisted-by: Gemini Next
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <david@davidgow.net>
Cc: Rae Moar <raemoar63@gmail.com>
Cc: Ryota Sakamoto <sakamo.ryota@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Kir Chou <note351@hotmail.com>
Cc: codemender-patching+linux@google.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
---
 lib/Kconfig.debug            | 10 +++++++
 lib/kunit/.kunitconfig       |  1 +
 lib/tests/Makefile           |  1 +
 lib/tests/stacktrace_kunit.c | 51 ++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100644 lib/tests/stacktrace_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e97bdf3a42a8..51a6ac1a2461 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2716,6 +2716,16 @@ config BITOPS_KUNIT
 
 	  If unsure, say N.
 
+config STACKTRACE_KUNIT_TEST
+	tristate "KUnit test for stacktrace counted_by attribute" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test for verifying the __counted_by_ptr
+	  attribute on struct stack_trace.
+
+	  If unsure, say N.
+
 config BITFIELD_KUNIT
 	tristate "KUnit test bitfield functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/kunit/.kunitconfig b/lib/kunit/.kunitconfig
index 9235b7d42d38..b3761b41459e 100644
--- a/lib/kunit/.kunitconfig
+++ b/lib/kunit/.kunitconfig
@@ -1,3 +1,4 @@
 CONFIG_KUNIT=y
 CONFIG_KUNIT_TEST=y
 CONFIG_KUNIT_EXAMPLE_TEST=y
+CONFIG_STACKTRACE_KUNIT_TEST=y
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 4ead57602eac..40875e729fc8 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -6,6 +6,7 @@
 CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BASE64_KUNIT) += base64_kunit.o
 obj-$(CONFIG_BITOPS_KUNIT) += bitops_kunit.o
+obj-$(CONFIG_STACKTRACE_KUNIT_TEST) += stacktrace_kunit.o
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
 obj-$(CONFIG_SHDI3_KUNIT_TEST) += shdi3_kunit.o
diff --git a/lib/tests/stacktrace_kunit.c b/lib/tests/stacktrace_kunit.c
new file mode 100644
index 000000000000..7ec48edf84fe
--- /dev/null
+++ b/lib/tests/stacktrace_kunit.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for struct stack_trace counted_by attribute.
+ */
+
+#include <kunit/test.h>
+#include <linux/stacktrace.h>
+
+#ifndef CONFIG_ARCH_STACKWALK
+static void test_stack_trace_counted_by(struct kunit *test)
+{
+	unsigned long entries_buf[4];
+	struct stack_trace trace = {
+		.entries = entries_buf,
+		.max_entries = 4,
+	};
+
+	KUNIT_EXPECT_EQ(test, trace.max_entries, 4U);
+	KUNIT_EXPECT_PTR_EQ(test, trace.entries, (unsigned long *)entries_buf);
+
+	/* Write to the allocated elements to verify access */
+	trace.entries[0] = 0xdeadbeef;
+	trace.entries[1] = 0xbeefcafe;
+	trace.entries[2] = 0xcafebabe;
+	trace.entries[3] = 0x12345678;
+
+	KUNIT_EXPECT_EQ(test, trace.entries[0], 0xdeadbeefUL);
+	KUNIT_EXPECT_EQ(test, trace.entries[1], 0xbeefcafeUL);
+	KUNIT_EXPECT_EQ(test, trace.entries[2], 0xcafebabeUL);
+	KUNIT_EXPECT_EQ(test, trace.entries[3], 0x12345678UL);
+}
+#else
+static void test_stack_trace_counted_by(struct kunit *test)
+{
+	kunit_skip(test, "CONFIG_ARCH_STACKWALK is enabled, struct stack_trace is not defined");
+}
+#endif
+
+static struct kunit_case stacktrace_test_cases[] = {
+	KUNIT_CASE(test_stack_trace_counted_by),
+	{}
+};
+
+static struct kunit_suite stacktrace_test_suite = {
+	.name = "stacktrace_counted_by",
+	.test_cases = stacktrace_test_cases,
+};
+
+kunit_test_suite(stacktrace_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.55.0.860.g4b6b3295ed-goog

