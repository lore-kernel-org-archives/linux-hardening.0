Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0E36F8F5;
	Wed, 30 Sep 2026 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812374; cv=none; b=FP86MSfOJ/6pVvAY4Aa1adi+qkoEEwGU2JEvnVvqMRF3KPwE0RvJlmufUoe8DDmlQdnPSfuAuFY2duTig0YEg7ff/hS0WH6IgAI0+uwpxu5MMdSMDV0Sfg4ie0xRzGA8//A+7krxJrGWQzNLbL+sx32++7URE5xKi6pJ4UqDhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812374; c=relaxed/simple;
	bh=0X2W/uHTisrVEcOD3gbO1as8VbV8rYPXxHnbPaktpB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AL/uTneU68YmGLmqcwYfstEVjJddnsy+DsbNYSnY2IGen72lCH6j8i5wIb/lMp5cSUMbRyVdmwE4cPnQMH/5kegkMstkgZkvfjzRMYaJ3X/axlCJaiJK1B8SImWnhx18BMVmWEs9oKjA/P5fgco4OThpHvbEmnarcrRU0lxHRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eglJ0xpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eglJ0xpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8B21F0089C;
	Wed, 30 Sep 2026 23:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812370;
	bh=fveClGIGE9Tcu1gqgEcvBXfEA6gnYm5WjMTFzLLpfPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eglJ0xpCf+/f+KZ6XyWT2NrdumJnBleWO4J9w2zduLm4ZjL1LCnPJ/hSQ/bxUIP5j
	 ftNpG4FZVQUKbcBH+feCJI/udiUC4NkJSuAd2CIywSx88EhBD/jYDGD5zR+NQAEH2Y
	 sp6+mVBmt6QbQHyvIp4D6sJ3UL/NOJJ2ZjTX1AQiy0zJP0GSr1ZeKp6M+RTTqMdjBe
	 8FNyoMPT8B59LlUmQNMeVlUzdN4ElsbkxUc5kSRc+3YAk/Dtkg9eQYcE/hOdLbxdbM
	 JMJjnoxf6oU9zvSJs/ZMCV7nJ7ATDmDv9R4pezzBFCvFzq4opSHDPpXwOrFFEcgF79
	 dTlGScNdkD1VA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <david@davidgow.net>,
	Jiri Kosina <jikos@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 04/11] seq_buf: Clear what a writer did not claim when a seq_buf overflows
Date: Wed, 30 Sep 2026 16:52:32 -0700
Message-Id: <20260930235247.157921-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5589; i=kees@kernel.org; h=from:subject; bh=0X2W/uHTisrVEcOD3gbO1as8VbV8rYPXxHnbPaktpB8=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7Fxz5GcEpd7HZRfL7dJFV/ycx3s3J392yctPbjXNKf 1+3SzHf3VHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjARNSGG/8Wq7GbXzijJWz6X fBRbe/6G89F/2+fnmd34K8TQ71TBbM7wz/QlT2mlUmJY8YS7/z+bnQs8avl2/5e2NLevFpzlJsm LWQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using seq_buf_set_overflow() would leave the bytes between "len"
and "size" untouched, so if seq_buf_str() is used on an overflowed
seq_buf, those bytes may be exposed. For any paths that don't claim
partially written bytes, by setting "len = size" before calling
seq_buf_set_overflow(), wipe the unclaimed bytes. The seq_buf_puts()
and related APIs already claim those bytes now, so only the unclaimed
cases remain. A specific example of this was seq_buf_path() which uses
d_path() and would write to the tail before discovering it was out
of space, and would correctly mark a seq_buf as overflowed, but the
path fragment would be left over.

Clear from len to the end of the buffer in seq_buf_set_overflow(), which
every overflow goes through, including seq_buf_commit() with a negative
count.

Add a test that fills a seq_buf, leaves it too little room for a path, and
checks that nothing of the path is left in the buffer. The tests run before
anything writable is mounted, so it takes its file from shmem.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h   |  8 +++++--
 lib/seq_buf.c             |  4 ++++
 lib/tests/seq_buf_kunit.c | 45 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 77e76e283370..0c0a0db04b09 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -5,6 +5,7 @@
 #include <linux/bug.h>
 #include <linux/minmax.h>
 #include <linux/seq_file.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 /*
@@ -58,12 +59,15 @@ seq_buf_has_overflowed(struct seq_buf *s)
 /*
  * Mark @s as overflowed, which discards the length of what it holds. The
  * bytes up to its last one are the string from then on, as that is where
- * seq_buf_str() terminates it, so a caller that could not fill the buffer
- * has to NUL them itself before calling this.
+ * seq_buf_str() terminates it, so clear whatever was not written: a writer
+ * sets len to how much it filled, and anything past that was never adopted.
  */
 static inline void
 seq_buf_set_overflow(struct seq_buf *s)
 {
+	if (s->len < s->size)
+		memset(s->buffer + s->len, 0, s->size - s->len);
+
 	s->len = s->size + 1;
 }
 
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 00abdec8760e..7e3bf837da01 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -76,6 +76,8 @@ int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
 			s->len += len;
 			return 0;
 		}
+		/* vsnprintf() wrote as much as fits, so none of it is stale */
+		s->len = s->size;
 	}
 	seq_buf_set_overflow(s);
 	return -1;
@@ -164,6 +166,8 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
 			s->len += ret;
 			return 0;
 		}
+		/* bstr_printf() wrote as much as fits, so none of it is stale */
+		s->len = s->size;
 	}
 	seq_buf_set_overflow(s);
 	return -1;
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index e0057eaeeb36..852eb645e253 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -6,6 +6,9 @@
  */
 
 #include <kunit/test.h>
+#include <linux/fs.h>
+#include <linux/seq_buf.h>
+#include <linux/shmem_fs.h>
 #include <linux/console.h>
 #include <linux/seq_buf.h>
 #include <linux/string.h>
@@ -466,6 +469,47 @@ static void seq_buf_do_printk_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, seq_buf_printk_empty, 0);
 }
 
+/* Long enough that it cannot fit in the room the test leaves for it. */
+#define SEQ_BUF_TEST_PATH	"/seq_buf_kunit_path_name"
+
+static void seq_buf_path_overflow_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 32);
+	const char *expected = "keep:xxxxxxxxxxxxxxxxxxxxxxx";
+	struct file *file;
+	size_t len;
+	int i;
+
+	/*
+	 * The tests run before anything writable is mounted, so take the file
+	 * whose path gets printed from shmem, which needs no mount of its own.
+	 */
+	file = shmem_file_setup(SEQ_BUF_TEST_PATH, 0, EMPTY_VMA_FLAGS);
+	if (IS_ERR(file))
+		kunit_skip(test, "cannot create a file to print the path of");
+
+	/* Leave less room than the path needs, so d_path() cannot fit it. */
+	seq_buf_puts(&s, "keep:");
+	len = seq_buf_used(&s);
+	for (i = len; i < 28; i++)
+		seq_buf_putc(&s, 'x');
+
+	KUNIT_EXPECT_EQ(test, seq_buf_path(&s, &file->f_path, "\n"), -1);
+	fput(file);
+
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+
+	/*
+	 * d_path() keeps as much of the path as fits when it does not fit
+	 * whole, and seq_buf_str() would hand out that fragment, as it ends
+	 * the string at the last byte of an overflowed buffer.
+	 */
+	for (i = 28; i < 32; i++)
+		KUNIT_EXPECT_EQ_MSG(test, s.buffer[i], '\0',
+				    "byte %d past the data is not cleared", i);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
+}
+
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_declare_test),
@@ -482,6 +526,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_puts_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_hex_partial_overflow_test),
+	KUNIT_CASE(seq_buf_path_overflow_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.34.1

