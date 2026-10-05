Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F24CDA39;
	Mon,  5 Oct 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215841; cv=none; b=bME8iA8jq8ZYy4F/jlR9+0Yo3VIZtcBwc2Jup4Fnu//hOn4PLK3AO7jDFdwpzfwgsWGabCgJVquVArh3AvkQoxXi8azAIXObYh89BjUpb8xv0mqiygWimBvzTVuiSlbIlB56JDZg1lnj6c+L9oBfoOq53Z/gIUNbhFlunHSkZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215841; c=relaxed/simple;
	bh=QUOiYZl0kgStBhrFWtz+FeWyxmh628RReet8gSO1iSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1w25VfPsuq2Y9H5LwoLqW1LziTknBVNCuTae2IKNGiMv52/MYhBvtnCspeVjHe+8uD5qTYtzfYAFuuNOA0rI7URlYIU0HkNbsYZc5Ru1o+3RMVKDgwPGJuP1wH2UTSa8LT5rOb/Syty8LGghV8Nut7m18W51fm9lpFJn0dQRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb1DwHLo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb1DwHLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1A61F0089A;
	Mon,  5 Oct 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215838;
	bh=Rawtrm6YxfOKom8iXQOvKuksfutyZZaM4MxF61dTer8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xb1DwHLoySizY1J5W19Vv6C/o0YjMVXsRwkRXKjWoF0iPdmUivMVAHYcCBd+fncaq
	 /lcuXDg7Ype8llu7PSKyZJQOdC/FpOmrx+LXAPMEnhr2wJH75nXobQU1MyWiz1adv8
	 hbLZIpEHktnx47coLVR7H1q2gG3khcCcY9z0/DMLlMnO4Z8+UuSZ+48tFYwsmcvQGR
	 337QRF4EENo5BaxQ6eEWYw2n/ySf0q65iRt25rK8dLN4aulA4MZsKHNMlegfQ5Wrzp
	 X1m2JfvKSZ3jogFAKJ+ruzWil+0tX2e4dnzhbGNRWi1RnWE62jH5fk8TMhY1lA/qep
	 sqKoM/8INmaTQ==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <david@davidgow.net>,
	Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 04/12] seq_buf: Copy what fits when seq_buf_puts() and seq_buf_putmem() overflow
Date: Mon,  5 Oct 2026 08:56:54 -0700
Message-ID: <20261005155708.1471260-4-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005155653.late.426-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9142; i=kees@kernel.org; h=from:subject; bh=QUOiYZl0kgStBhrFWtz+FeWyxmh628RReet8gSO1iSU=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHT5y2MKlNSt1/fPuvKcnypTzLF237+cNj3rZJc3on9 In5+zVO7yhlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiIigvDf/9O3UfXFk+aUdj+ fkLL/Gm/t03zqfrY9as16pCipZzxTmFGhmN+Catn/z5bzubzp8ZotsuGBtGFdbwf5q1ccEClSGv iPz4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When seq_buf_puts() or seq_buf_putmem() is given more than fits, it
copies nothing and only marks the seq_buf as overflowed. If seq_buf_str()
is used, it will terminate the buffer in its last byte, so every byte
between the end of the data and the end of the buffer becomes part of
the string, though the seq_buf never wrote them.

seq_buf_printf() does not have this problem, because vsnprintf() writes
as much of the output as fits, followed by a NUL. Repeat this behavior
in seq_buf_puts(), using strscpy(), and in seq_buf_putmem(), which also
covers seq_buf_putmem_hex(). seq_buf_putc() needs no change, as it can
only overflow when the buffer is already full.

Each writer now records the buffer as full once it has copied what fits,
so that what it wrote can be told apart from bytes nothing touched.

Of the callers that check the return value or test for overflow
afterward, only lpfc_rx_monitor_report() relied on a string that did not
fit being left out, and the previous patch has it drop such a record
itself. The others treat overflow as an error or report it. The callers
that ignore overflow use whatever the buffer holds, which now ends with
the part of the string that fit.

Update seq_buf_putmem_hex_overflow_test, which expected a hex group that
did not fit whole to be left out entirely, and add tests that overflow
seq_buf_puts(), seq_buf_putmem() and seq_buf_putmem_hex() with stale
bytes in the buffer.

The three partial-overflow tests check the buffer itself rather than
seq_buf_str(). Neither writer leaves the last byte of the buffer alone:
seq_buf_putmem() copies raw bytes and writes no NUL, and seq_buf_puts()
relies on strscpy() to write one. That byte is exactly where
seq_buf_str() writes its terminator, so asserting only on the string
would pass whether the copy stopped a byte early or dropped the NUL
entirely.

seq_buf_putmem() was not exported, so the test failed to link as a
module. Export it.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0, and the
test builds as a module (CONFIG_SEQ_BUF_KUNIT_TEST=m).

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h   |  6 +++
 lib/seq_buf.c             | 17 +++++++-
 lib/tests/seq_buf_kunit.c | 85 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index f5a350347bc5..77e76e283370 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -55,6 +55,12 @@ seq_buf_has_overflowed(struct seq_buf *s)
 	return s->len > s->size;
 }
 
+/*
+ * Mark @s as overflowed, which discards the length of what it holds. The
+ * bytes up to its last one are the string from then on, as that is where
+ * seq_buf_str() terminates it, so a caller that could not fill the buffer
+ * has to NUL them itself before calling this.
+ */
 static inline void
 seq_buf_set_overflow(struct seq_buf *s)
 {
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 35a5964370b4..60e9eadb3ef7 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -175,7 +175,9 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
  * @s: seq_buf descriptor
  * @str: simple string to record
  *
- * Copy a simple string into the sequence buffer.
+ * Copy a simple string into the sequence buffer. If @str does not fit,
+ * as much of it as fits is copied, followed by a null byte, as
+ * seq_buf_printf() does.
  *
  * Returns: zero on success, -1 on overflow.
  */
@@ -194,6 +196,11 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 		s->len += len - 1;
 		return 0;
 	}
+	/* Copy what fits, so the buffer never holds stale bytes */
+	if (s->len < s->size) {
+		strscpy(s->buffer + s->len, str, s->size - s->len);
+		s->len = s->size;
+	}
 	seq_buf_set_overflow(s);
 	return -1;
 }
@@ -229,7 +236,7 @@ EXPORT_SYMBOL_GPL(seq_buf_putc);
  *
  * There may be cases where raw memory needs to be written into the
  * buffer and a strcpy() would not work. Using this function allows
- * for such cases.
+ * for such cases. If @mem does not fit, as much of it as fits is copied.
  *
  * Returns: zero on success, -1 on overflow.
  */
@@ -242,9 +249,15 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
 		s->len += len;
 		return 0;
 	}
+	/* Copy what fits, so the buffer never holds stale bytes */
+	if (s->len < s->size) {
+		memcpy(s->buffer + s->len, mem, s->size - s->len);
+		s->len = s->size;
+	}
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_putmem);
 
 #define MAX_MEMHEX_BYTES	8U
 #define HEX_CHARS		(MAX_MEMHEX_BYTES*2 + 1)
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index de491f96c1ac..046614100c77 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -248,9 +248,9 @@ static void seq_buf_putmem_hex_overflow_test(struct kunit *test)
 	DECLARE_SEQ_BUF(s, 20);
 	const u8 data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 #ifdef __BIG_ENDIAN
-	const char *expected = "0001020304050607 ";
+	const char *expected = "0001020304050607 08";
 #else
-	const char *expected = "0706050403020100 ";
+	const char *expected = "0706050403020100 09";
 #endif
 
 	KUNIT_EXPECT_EQ(test, seq_buf_putmem_hex(&s, data, sizeof(data)), -1);
@@ -259,6 +259,84 @@ static void seq_buf_putmem_hex_overflow_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
 }
 
+static void seq_buf_puts_partial_overflow_test(struct kunit *test)
+{
+	static const char expected[] = "abcdefg";
+	DECLARE_SEQ_BUF(s, 16);
+	struct seq_buf t;
+	char buf[8];
+
+	/* As much of the string as fits is written, like seq_buf_printf(). */
+	seq_buf_puts(&s, "hello");
+	KUNIT_EXPECT_EQ(test, seq_buf_puts(&s, " world, again"), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 16);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world, ag");
+
+	/* Stale bytes after the data must not show up in the string. */
+	memset(buf, 'X', sizeof(buf));
+	seq_buf_init(&t, buf, sizeof(buf));
+	seq_buf_putc(&t, 'a');
+	KUNIT_EXPECT_EQ(test, seq_buf_puts(&t, "bcdefghij"), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
+
+	/*
+	 * Check the buffer before seq_buf_str() does: it would write the
+	 * terminator over the last byte itself, hiding whether the copy
+	 * placed one there. The literal's own NUL is the eighth byte.
+	 */
+	KUNIT_EXPECT_MEMEQ(test, buf, expected, sizeof(buf));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&t), "abcdefg");
+}
+
+static void seq_buf_putmem_partial_overflow_test(struct kunit *test)
+{
+	const u8 data[] = { 1, 2, 3, 4, 5, 6, 7 };
+	const char expected[] = { 'a', 'b', 1, 2, 3, 4, 5, 6 };
+	struct seq_buf s;
+	char buf[8];
+
+	memset(buf, 'X', sizeof(buf));
+	seq_buf_init(&s, buf, sizeof(buf));
+	seq_buf_putmem(&s, "ab", 2);
+
+	/* One byte too many, so the last byte of @data is dropped. */
+	KUNIT_EXPECT_EQ(test, seq_buf_putmem(&s, data, sizeof(data)), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+
+	/*
+	 * Check the buffer rather than seq_buf_str(): seq_buf_putmem() writes
+	 * no NUL of its own, so a short copy leaves a stale byte at the end,
+	 * exactly where seq_buf_str() would then write the terminator and
+	 * hide it.
+	 */
+	KUNIT_EXPECT_MEMEQ(test, buf, expected, sizeof(buf));
+}
+
+static void seq_buf_putmem_hex_partial_overflow_test(struct kunit *test)
+{
+	const u8 data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+#ifdef __BIG_ENDIAN
+	const char *expected = "0001020304050607 08";
+	static const char expected_raw[] = "0001020304050607 080";
+#else
+	const char *expected = "0706050403020100 09";
+	static const char expected_raw[] = "0706050403020100 090";
+#endif
+	struct seq_buf s;
+	char buf[20];
+
+	/* Stale bytes after the data must not show up in the string. */
+	memset(buf, 'X', sizeof(buf));
+	seq_buf_init(&s, buf, sizeof(buf));
+	KUNIT_EXPECT_EQ(test, seq_buf_putmem_hex(&s, data, sizeof(data)), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+
+	/* Before seq_buf_str() writes the terminator over the last byte. */
+	KUNIT_EXPECT_MEMEQ(test, buf, expected_raw, sizeof(buf));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
+}
+
 /*
  * Counters for the console that seq_buf_do_printk_test() registers while it
  * runs. Only records carrying the marker are counted, so unrelated kernel
@@ -401,6 +479,9 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_get_buf_commit_test),
 	KUNIT_CASE(seq_buf_putmem_hex_test),
 	KUNIT_CASE(seq_buf_putmem_hex_overflow_test),
+	KUNIT_CASE(seq_buf_puts_partial_overflow_test),
+	KUNIT_CASE(seq_buf_putmem_partial_overflow_test),
+	KUNIT_CASE(seq_buf_putmem_hex_partial_overflow_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.55.0

