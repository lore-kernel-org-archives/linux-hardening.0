Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93630C147
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604617; cv=none; b=lq4Jkc0T5JDhKoQuUS1hlulzsxdJOrr9/efDvw431kMCOSmzYwQYBdIRFkqxd2BGmiiiiHI+7g4wiM0YcqnhXToZIWXAyC70sKsAvjsHPlZTj39njFYEyqMMNwNkVuDZI9EjE5Mw4fbg8RWs+b7WakiIOBFOYOyoGplGIKBAcew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604617; c=relaxed/simple;
	bh=dwii8eBVFHy8b+qc5cYEA8E49JMZi8lPmbHc9pzvEIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dn/xeETbH0erul2uTve616oO2U2icT+ct/ytiylZ3lc/JTuvk1FlRruwzqDjOhrONPEOEPaWfOMXj3+Do20eubqkpFEw/NeMvqhfG75meVrXjcbWOlym1QzLaGBFwW1GSvlNr9JJKgUGNfdk5TbNa5LMdJhW73XXJirSSAWA7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emvGIeQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emvGIeQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972321F008A4;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604613;
	bh=A/cvW8QeHBmd4zoGI3GQzGnZrkuz8ZBt+K6KrvCcjEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=emvGIeQ3aCtD0os7N05gyAgbbzktX/0Kypmu1quX8F/zPs8FkFXV6er50XoFPtiVH
	 F65jTL6cLokBsMKVmPfK7WXLY/TwYX6SNQJzdkr69h+OnPwya+XfM9nregjA3l0t/w
	 OUtkexsK5lxMUJhdHr0efEnPHMyD5ZzqwQODz+KLjG2rA5PYPyb7FAqW7CPXTMgwD+
	 ZhGBx6bJrIm+LIPVMJcaA8tAnXYRbl2VyHTGrz49vpWA82G+H4JPabBISY/mRQFhJj
	 WbAW/4Wqke+e7vqSJFYkIMzYqEBVHkTjW4FgiNQiKLiYqKbKkDUl4BMCUN+oLZdkx0
	 qXMPNinXYDtrw==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	David Gow <david@davidgow.net>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 5/7] seq_buf: Use seq_buf_strlen() for the string end in seq_buf_do_printk()
Date: Wed, 16 Sep 2026 17:23:17 -0700
Message-Id: <20260917002333.2306346-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917002312.i.923-kees@kernel.org>
References: <20260917002312.i.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5005; i=kees@kernel.org; h=from:subject; bh=dwii8eBVFHy8b+qc5cYEA8E49JMZi8lPmbHc9pzvEIg=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmrjb5xaYkVp1fHea5Qbb767/JfSXtjGV2/N9+zXDbOc CueIra0o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLcjgz/VOpZtff/WX00katw S+HcyTUCkWxFug8cVvmwlc5P+M+8juG/t5eptW7mHEvpN7WJLXc+uJY+Ys68JVQZWnZLW1Jb+hw PAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

seq_buf_do_printk() prints whatever follows the last line feed when
"start" is still inside the buffer, and for an overflowed seq_buf,
this may end up pointing at the NUL, so an extra blank line would be
emitted.

Take the end from seq_buf_strlen() instead, which is where the string
ends whether the buffer overflowed, is exactly full, or has room left.

The only caller is the memory cgroup OOM report, so this only ever
added a blank line to a report whose stats did not fit.

Add a test that registers a console to count the records that
seq_buf_do_printk() emits, with a seq_buf filled so that its string
ends in a line feed. It counts only the records carrying the test's
marker and the records holding nothing but a line feed, so that
unrelated kernel messages do not disturb it.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: David Gow <david@davidgow.net>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 lib/seq_buf.c             |  5 ++--
 lib/tests/seq_buf_kunit.c | 63 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 65806d5e4bb4..9977c2a6a315 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -116,12 +116,13 @@ EXPORT_SYMBOL_GPL(seq_buf_printf);
  */
 void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
 {
-	const char *start, *lf;
+	const char *start, *lf, *end;
 
 	if (s->size == 0 || s->len == 0)
 		return;
 
 	start = seq_buf_str(s);
+	end = s->buffer + seq_buf_strlen(s);
 	while ((lf = strchr(start, '\n'))) {
 		int len = lf - start + 1;
 
@@ -130,7 +131,7 @@ void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
 	}
 
 	/* No trailing LF */
-	if (start < s->buffer + s->len)
+	if (start < end)
 		printk("%s%s\n", lvl, start);
 }
 EXPORT_SYMBOL_GPL(seq_buf_do_printk);
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 2b8cacf000cb..43ca47ffdb7d 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -6,6 +6,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/console.h>
 #include <linux/fs.h>
 #include <linux/seq_buf.h>
 #include <linux/shmem_fs.h>
@@ -431,6 +432,67 @@ static void seq_buf_strlen_puts_overflow_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), strlen(seq_buf_str(&s)));
 }
 
+/*
+ * Counters for the console that seq_buf_do_printk_test() registers while it
+ * runs. Only records carrying the marker, and records holding nothing but a
+ * line feed, are counted, so unrelated kernel messages do not disturb them.
+ */
+#define SEQ_BUF_PRINTK_MARKER	"sbdpkx"
+
+static unsigned int seq_buf_printk_marked;
+static unsigned int seq_buf_printk_empty;
+
+static void seq_buf_printk_capture(struct console *con, const char *s,
+				   unsigned int count)
+{
+	const char *text = s;
+	const char *prefix;
+
+	/* Skip the "[   12.345678] " timestamp, when there is one. */
+	prefix = memchr(s, ']', count);
+	if (prefix && prefix + 2 <= s + count && prefix[1] == ' ')
+		text = prefix + 2;
+	count -= text - s;
+
+	if (count == 0 || (count == 1 && text[0] == '\n'))
+		seq_buf_printk_empty++;
+	else if (strnstr(text, SEQ_BUF_PRINTK_MARKER, count))
+		seq_buf_printk_marked++;
+}
+
+static void seq_buf_do_printk_test(struct kunit *test)
+{
+	static struct console capture = {
+		.name = "sbufcap",
+		.write = seq_buf_printk_capture,
+		.flags = CON_ENABLED,
+		.index = -1,
+	};
+	DECLARE_SEQ_BUF(s, 8);
+
+	/*
+	 * Fill the buffer exactly, so that the NUL takes the place of the
+	 * last byte and the string ends with the line feed before it.
+	 */
+	seq_buf_puts(&s, SEQ_BUF_PRINTK_MARKER);
+	seq_buf_putc(&s, '\n');
+	seq_buf_putc(&s, '!');
+	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_ASSERT_EQ(test, seq_buf_used(&s), 8);
+	KUNIT_ASSERT_EQ(test, seq_buf_strlen(&s), 7);
+
+	seq_buf_printk_marked = 0;
+	seq_buf_printk_empty = 0;
+
+	register_console(&capture);
+	seq_buf_do_printk(&s, KERN_INFO);
+	unregister_console(&capture);
+
+	/* The one line that was written, and nothing after it. */
+	KUNIT_EXPECT_EQ(test, seq_buf_printk_marked, 1);
+	KUNIT_EXPECT_EQ(test, seq_buf_printk_empty, 0);
+}
+
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_declare_test),
@@ -451,6 +513,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_strlen_printf_overflow_test),
 	KUNIT_CASE(seq_buf_strlen_full_test),
 	KUNIT_CASE(seq_buf_strlen_puts_overflow_test),
+	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
 
-- 
2.34.1

