Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC428285C83;
	Thu, 17 Jul 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742342; cv=none; b=uUvOIfbj+wdk+brXBo6ks36+c7p2ovCGm0e7Wcc1ZOdjxbK8QjoexV2iefyNw6IgCPlHZhtDsOUnZlEY9eAJmeR/hbJEgzFJrswXW3qbaTpnzqRauAdrXvm0WG3fCC944pLG+Jv1wY+RsWHmQhmKv/iSmOK26V4VUwulJRApH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742342; c=relaxed/simple;
	bh=zQ2q2p+X54vWSXTSlQEJoWNnQD11CBMqUstKSQYiAt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C2l7NmVYgCE0E7Vt3IvieJtEWtM8yXZ18P7p+gwnOsIHNgsnsfAvpLCNqvEPejM0tHu+/x81MqNBkJN584gxrPbq7mFXPv1q11rg/igJBEuBZ9m8JJp438w1hHxHwc/Dcs2v6/AXGEdhvRko+iR0ecacwiCBSCshdrUyh4h+WPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoCMg+TT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoCMg+TT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D362C4CEE3;
	Thu, 17 Jul 2025 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742341;
	bh=zQ2q2p+X54vWSXTSlQEJoWNnQD11CBMqUstKSQYiAt4=;
	h=From:To:Cc:Subject:Date:From;
	b=JoCMg+TTtDg4BotHO9UOOsJREERXFV+0aSeXwYq7PuqT8qNWbsWkh0MqH5QXD5f2p
	 5t3/jOx85EbSjtUnnOSAf4GGDIqG+BBjUFoqCYj9X25R/xjf9EF3mNYQzM/DJA3aWP
	 lnwanVqpuNb78OMA7nQbS2fjhqF6EOvMewJJRqgxWCrvyhz7dz4JASsZfEGghGdvRT
	 2hZ7GSeT+pVKke0SDsKI0NElrPNMRyJ/cRDy6YJSr8P9TOhT7+73lAxtLmsJQMBjOF
	 0/yTNdaDflLDzXKIi65uAU6IG0Rd2sHMOBg415tcTHSMaoweMBN3kx1oVZHrffJbwX
	 NbTxVTcu4VCDA==
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Rae Moar <rmoar@google.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] seq_buf: Introduce KUnit tests
Date: Thu, 17 Jul 2025 01:52:12 -0700
Message-Id: <20250717085156.work.363-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9135; i=kees@kernel.org; h=from:subject:message-id; bh=zQ2q2p+X54vWSXTSlQEJoWNnQD11CBMqUstKSQYiAt4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkVO/cYHJqe3Jw8+2GP87n9+sInZFxXSMrdWnBmuel5X bt3MQ9/dZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzkwVZGhr6GS6JR/IJqEl4P hJ9I35R9cVs2bknixh2L13Lw19idecLwm2X52mVGt5RXvt05L2StysZzOybtEM5VvRIybWamY+L sXm4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add KUnit tests for the seq_buf API to ensure its correctness and
prevent future regressions.

The tests cover the following functions:
- seq_buf_init()
- DECLARE_SEQ_BUF()
- seq_buf_clear()
- seq_buf_puts()
- seq_buf_putc()
- seq_buf_printf()
- seq_buf_get_buf()
- seq_buf_commit()

$ tools/testing/kunit/kunit.py run seq_buf
=================== seq_buf (9 subtests) ===================
[PASSED] seq_buf_init_test
[PASSED] seq_buf_declare_test
[PASSED] seq_buf_clear_test
[PASSED] seq_buf_puts_test
[PASSED] seq_buf_puts_overflow_test
[PASSED] seq_buf_putc_test
[PASSED] seq_buf_printf_test
[PASSED] seq_buf_printf_overflow_test
[PASSED] seq_buf_get_buf_commit_test
===================== [PASSED] seq_buf =====================

Signed-off-by: Kees Cook <kees@kernel.org>
---
I used an LLM to produce this; it did pretty well, but I had to help it
get the Kconfig and make targets in the right places, and I tweaked some
of the edge cases and added a bit more (perhaps redundant) state checking.

Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
---
 lib/Kconfig.debug         |   9 ++
 lib/tests/Makefile        |   1 +
 lib/tests/seq_buf_kunit.c | 205 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 lib/tests/seq_buf_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cf05bf1df983..048efc3183d5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2470,6 +2470,15 @@ config SCANF_KUNIT_TEST
 
 	  If unsure, say N.
 
+config SEQ_BUF_KUNIT_TEST
+	tristate "KUnit test for seq_buf" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for the seq_buf library.
+
+	  If unsure, say N.
+
 config STRING_KUNIT_TEST
 	tristate "KUnit test string functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 84b15c986b8c..fa6d728a8b5b 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
 obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
 obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
+obj-$(CONFIG_SEQ_BUF_KUNIT_TEST) += seq_buf_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
new file mode 100644
index 000000000000..74648dbda13f
--- /dev/null
+++ b/lib/tests/seq_buf_kunit.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the seq_buf API
+ *
+ * Copyright (C) 2025, Google LLC.
+ */
+
+#include <kunit/test.h>
+#include <linux/seq_buf.h>
+
+static void seq_buf_init_test(struct kunit *test)
+{
+	char buf[32];
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, sizeof(buf));
+
+	KUNIT_EXPECT_EQ(test, s.size, 32);
+	KUNIT_EXPECT_EQ(test, s.len, 0);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 32);
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 0);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+}
+
+static void seq_buf_declare_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 24);
+
+	KUNIT_EXPECT_EQ(test, s.size, 24);
+	KUNIT_EXPECT_EQ(test, s.len, 0);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 24);
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 0);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+}
+
+static void seq_buf_clear_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 128);
+
+	seq_buf_puts(&s, "hello");
+	KUNIT_EXPECT_EQ(test, s.len, 5);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello");
+
+	seq_buf_clear(&s);
+
+	KUNIT_EXPECT_EQ(test, s.len, 0);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+}
+
+static void seq_buf_puts_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 16);
+
+	seq_buf_puts(&s, "hello");
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 5);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello");
+
+	seq_buf_puts(&s, " world");
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
+}
+
+static void seq_buf_puts_overflow_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 10);
+
+	seq_buf_puts(&s, "123456789");
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 9);
+
+	seq_buf_puts(&s, "0");
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 10);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "123456789");
+
+	seq_buf_clear(&s);
+	KUNIT_EXPECT_EQ(test, s.len, 0);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+}
+
+static void seq_buf_putc_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 4);
+
+	seq_buf_putc(&s, 'a');
+	seq_buf_putc(&s, 'b');
+	seq_buf_putc(&s, 'c');
+
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 3);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
+
+	seq_buf_putc(&s, 'd');
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
+
+	seq_buf_putc(&s, 'e');
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
+
+	seq_buf_clear(&s);
+	KUNIT_EXPECT_EQ(test, s.len, 0);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+}
+
+static void seq_buf_printf_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 32);
+
+	seq_buf_printf(&s, "hello %s", "world");
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
+
+	seq_buf_printf(&s, " %d", 123);
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 15);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world 123");
+}
+
+static void seq_buf_printf_overflow_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 16);
+
+	seq_buf_printf(&s, "%lu", 1234567890UL);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 10);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "1234567890");
+
+	seq_buf_printf(&s, "%s", "abcdefghij");
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 16);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "1234567890abcde");
+
+	seq_buf_clear(&s);
+	KUNIT_EXPECT_EQ(test, s.len, 0);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+}
+
+static void seq_buf_get_buf_commit_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 16);
+	char *buf;
+	size_t len;
+
+	len = seq_buf_get_buf(&s, &buf);
+	KUNIT_EXPECT_EQ(test, len, 16);
+	KUNIT_EXPECT_PTR_NE(test, buf, NULL);
+
+	memcpy(buf, "hello", 5);
+	seq_buf_commit(&s, 5);
+
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 5);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello");
+
+	len = seq_buf_get_buf(&s, &buf);
+	KUNIT_EXPECT_EQ(test, len, 11);
+	KUNIT_EXPECT_PTR_NE(test, buf, NULL);
+
+	memcpy(buf, " worlds!", 8);
+	seq_buf_commit(&s, 6);
+
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
+
+	len = seq_buf_get_buf(&s, &buf);
+	KUNIT_EXPECT_EQ(test, len, 5);
+	KUNIT_EXPECT_PTR_NE(test, buf, NULL);
+
+	seq_buf_commit(&s, -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+}
+
+static struct kunit_case seq_buf_test_cases[] = {
+	KUNIT_CASE(seq_buf_init_test),
+	KUNIT_CASE(seq_buf_declare_test),
+	KUNIT_CASE(seq_buf_clear_test),
+	KUNIT_CASE(seq_buf_puts_test),
+	KUNIT_CASE(seq_buf_puts_overflow_test),
+	KUNIT_CASE(seq_buf_putc_test),
+	KUNIT_CASE(seq_buf_printf_test),
+	KUNIT_CASE(seq_buf_printf_overflow_test),
+	KUNIT_CASE(seq_buf_get_buf_commit_test),
+	{}
+};
+
+static struct kunit_suite seq_buf_test_suite = {
+	.name = "seq_buf",
+	.test_cases = seq_buf_test_cases,
+};
+
+kunit_test_suite(seq_buf_test_suite);
-- 
2.34.1

