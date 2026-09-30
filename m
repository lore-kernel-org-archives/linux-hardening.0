Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB9417BFE;
	Wed, 30 Sep 2026 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812373; cv=none; b=LP3kbyWocQawkuQkuDzMGh7uY73pSIu0OqbY/HY9Nxq3gRoWrbSu+oZo4RofTYrb0d7ubMxxi8kIHH5UdeAvGr2yY+YCBb9Rvhx5TS4cb/laZWvtc30WQH2BQAqt0omAl/GuxO+ZKNff+DbFNLcUiySvPtCsS/WLktc7ofKfxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812373; c=relaxed/simple;
	bh=LfdqzhDxqwcOMXAga/7yFmqaO2XFeKmtyJYlId0x/lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzAs2F0rLkbCtCX7+yQ3hU03IdV/DCJktHLHT+NukWh1CLecnPOGEnmjUi/33SnFrChyCGWOdLehlXmEM5hWasqSVPDMocQKTMteH6go/QRKKyxKa+AocLSCwFTuLCdGFvGPcOjPkGr8R9DWxzb9tnHcXOeLE1v3OeukQsymTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwJRQt/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwJRQt/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E952C1F00899;
	Wed, 30 Sep 2026 23:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812371;
	bh=uzd5k9O4j8sZbvonYAaiyeBe54wVYlliOVZzb+pEqUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwJRQt/eKFVdfKes/QyX5sGhzN6zwVW41/iSTpNkrgGQpWTZYA4MguO2O4TX9mEm0
	 3+EfUGM81EB0oSMP48Y+SXh/inp5oGK62FNR3Rn6jCke1Tlnq26IFKfUuwQlOZlQWa
	 Te5k24aRQunwHV7b4kLdw1U3a2mdImzKQLHlf6yCFNn6Rr7gIki5985FOHj+5g5uV7
	 uQ/EYzAFSUtXtJ4kpxumLdX9MKCR6G+KszLU7w6xAQ3Q8QV9f1TPLBA9SsaE9HkfSI
	 bMGBc70yo7ym9bPZr5Ta4TZBYW7/IMmYFWqI+WydtPM1ITb0fdGnN5jEAxNJq3TRFF
	 h5Lr0sKXAGUfA==
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
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 05/11] seq_buf: Add seq_buf_strlen()
Date: Wed, 30 Sep 2026 16:52:33 -0700
Message-Id: <20260930235247.157921-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10485; i=kees@kernel.org; h=from:subject; bh=LfdqzhDxqwcOMXAga/7yFmqaO2XFeKmtyJYlId0x/lM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7FxydrVrywSBJYc+t+e85L10qNZ+opfL4cEAt06w5T 58vfT6jq6OUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BeAm2zH8U44xd3BXYe/2k1NJ v6PKlSjMptt6gmFt9KbFq1IqtmoqMPz36Z3cpH32JO9DJUN3gQXv3lyZ12QvcdbqRbVftdezAiU +AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Several strlcat() call sites being converted to seq_buf need behavior
seq_buf doesn't currently provide. The return from seq_buf_used() is
not the length of the string in a seq_buf. Once the buffer is full or
has overflowed it returns the buffer size, which counts the byte that
seq_buf_str() replaces with the NUL, so a caller that needs the string
and its length has to call seq_buf_str() and then walk the string with
strlen().

Move the termination out of seq_buf_str() into a helper that returns
where it put the NUL, and add seq_buf_strlen(), which terminates the
buffer in the same way and returns that offset.

As discussed in review, don't add WARN_ON() for seq_buf_strlen() and
drop it from seq_buf_str().

Add tests comparing seq_buf_strlen() against strlen() of seq_buf_str()
for empty, appended, truncated, exactly full, and overflowed buffers,
checking that seq_buf_strlen() alone terminates a full buffer, and
checking that a zero-sized seq_buf reports an empty string from both
accessors without touching the buffer.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h   |  65 +++++++++++++++++--
 lib/tests/seq_buf_kunit.c | 131 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 0c0a0db04b09..87ccc62f1c62 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -89,6 +89,27 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 	return min(s->len, s->size);
 }
 
+/*
+ * NUL-terminate the buffer in @s: directly after the data when there is
+ * room for it, otherwise in the last byte of the buffer. @s->size must not
+ * be zero.
+ *
+ * Returns: the offset of the NUL.
+ */
+static inline size_t __seq_buf_terminate(struct seq_buf *s)
+{
+	size_t end;
+
+	if (seq_buf_buffer_left(s))
+		end = s->len;
+	else
+		end = s->size - 1;
+
+	s->buffer[end] = 0;
+
+	return end;
+}
+
 /**
  * seq_buf_str - get NUL-terminated C string from seq_buf
  * @s: the seq_buf handle
@@ -98,7 +119,12 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  *
  * Note, if this is called when the buffer has overflowed, then
  * the last byte of the buffer is zeroed, and the len will still
- * point passed it.
+ * point passed it. The same happens when the buffer is exactly
+ * full: the NUL takes the place of the last byte written, which is
+ * lost, though seq_buf_used() still counts it.
+ *
+ * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
+ * is returned instead of writing to @s->buffer.
  *
  * After this function is called, s->buffer is safe to use
  * in string operations.
@@ -107,17 +133,44 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  */
 static inline const char *seq_buf_str(struct seq_buf *s)
 {
-	if (WARN_ON(s->size == 0))
+	if (s->size == 0)
 		return "";
 
-	if (seq_buf_buffer_left(s))
-		s->buffer[s->len] = 0;
-	else
-		s->buffer[s->size - 1] = 0;
+	__seq_buf_terminate(s);
 
 	return s->buffer;
 }
 
+/**
+ * seq_buf_strlen - get the length of the NUL-terminated C string in seq_buf
+ * @s: the seq_buf handle
+ *
+ * This makes sure that the buffer in @s is NUL-terminated, exactly as
+ * seq_buf_str() does, and returns the length of the resulting string
+ * without walking it. Unlike seq_buf_used(), this does not count the byte
+ * given up to the NUL when the buffer is full or has overflowed. When the
+ * buffer is exactly full, that byte is the last one written, and calling
+ * either function loses it.
+ *
+ * A zero-sized seq_buf holds no string, so 0 is returned without writing
+ * to @s->buffer, matching what seq_buf_str() returns for one.
+ *
+ * After this function is called, s->buffer is safe to use
+ * in string operations.
+ *
+ * Returns: the offset of the NUL that terminates @s->buffer. That is the
+ * length of the string unless an earlier NUL is in the way, either one the
+ * data written to @s carried itself, or one seq_buf_set_overflow() left
+ * behind when it cleared what no writer had claimed.
+ */
+static inline size_t seq_buf_strlen(struct seq_buf *s)
+{
+	if (s->size == 0)
+		return 0;
+
+	return __seq_buf_terminate(s);
+}
+
 /**
  * seq_buf_get_buf - get buffer to write arbitrary data to
  * @s: the seq_buf handle
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 852eb645e253..9859a44dd959 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -26,8 +26,10 @@ static void seq_buf_init_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 32);
 	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 0);
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 0);
 }
 
+
 static void seq_buf_declare_test(struct kunit *test)
 {
 	DECLARE_SEQ_BUF(s, 24);
@@ -510,6 +512,129 @@ static void seq_buf_path_overflow_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
 }
 
+static void seq_buf_strlen_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 16);
+
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 0);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+
+	seq_buf_puts(&s, "hello");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 5);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), strlen(seq_buf_str(&s)));
+
+	seq_buf_printf(&s, " %s", "world");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 11);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), strlen(seq_buf_str(&s)));
+}
+
+static void seq_buf_strlen_printf_overflow_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 16);
+	DECLARE_SEQ_BUF(t, 8);
+
+	seq_buf_printf(&s, "%s", "1234567890abcdefghij");
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 16);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 15);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "1234567890abcde");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), strlen(seq_buf_str(&s)));
+
+	/* Output one byte too long for the NUL. */
+	seq_buf_printf(&t, "%s", "12345678");
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&t), 8);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 7);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&t), "1234567");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), strlen(seq_buf_str(&t)));
+}
+
+static void seq_buf_strlen_full_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 4);
+	DECLARE_SEQ_BUF(t, 8);
+	char *buf;
+	size_t len;
+
+	/* Filled exactly, with no room left for a NUL, but not overflowed. */
+	seq_buf_putc(&s, 'a');
+	seq_buf_putc(&s, 'b');
+	seq_buf_putc(&s, 'c');
+	seq_buf_putc(&s, 'd');
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 3);
+	/* seq_buf_strlen() terminates the buffer by itself. */
+	KUNIT_EXPECT_EQ(test, s.buffer[3], '\0');
+	KUNIT_EXPECT_EQ(test, strnlen(s.buffer, s.size), 3);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), strlen(seq_buf_str(&s)));
+
+	/* A printf into a full buffer writes nothing. */
+	KUNIT_EXPECT_EQ(test, seq_buf_printf(&s, "%s", "x"), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 3);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), strlen(seq_buf_str(&s)));
+
+	len = seq_buf_get_buf(&t, &buf);
+	KUNIT_ASSERT_EQ(test, len, 8);
+	memset(buf, 'z', len);
+	seq_buf_commit(&t, len);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&t));
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 7);
+	KUNIT_EXPECT_EQ(test, t.buffer[7], '\0');
+	KUNIT_EXPECT_EQ(test, strnlen(t.buffer, t.size), 7);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&t), "zzzzzzz");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), strlen(seq_buf_str(&t)));
+}
+
+static void seq_buf_strlen_puts_overflow_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 16);
+
+	/* A puts that does not fit copies as much as fits. */
+	seq_buf_puts(&s, "hello");
+	KUNIT_EXPECT_EQ(test, seq_buf_puts(&s, " this does not fit"), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 15);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello this does");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), strlen(seq_buf_str(&s)));
+}
+
+
+static void seq_buf_strlen_embedded_nul_test(struct kunit *test)
+{
+	static const char data[] = "ab\0cd";
+	DECLARE_SEQ_BUF(s, 16);
+
+	/*
+	 * seq_buf_strlen() reports where it put the terminator, not where
+	 * the first NUL is, so data carrying a NUL of its own makes the two
+	 * disagree. That is expected, and is what the documented caveat is
+	 * about.
+	 */
+	seq_buf_putmem(&s, data, sizeof(data) - 1);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 5);
+	KUNIT_EXPECT_EQ(test, strlen(seq_buf_str(&s)), 2);
+}
+
+static void seq_buf_strlen_zero_size_test(struct kunit *test)
+{
+	char buf[] = "untouched";
+	struct seq_buf s;
+
+	/*
+	 * A zero-sized seq_buf has nowhere to put a terminator. Both
+	 * accessors report an empty string and leave the buffer alone
+	 * rather than writing outside it.
+	 */
+	seq_buf_init(&s, buf, 0);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 0);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+	KUNIT_EXPECT_STREQ(test, buf, "untouched");
+}
+
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_declare_test),
@@ -527,6 +652,12 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_putmem_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_hex_partial_overflow_test),
 	KUNIT_CASE(seq_buf_path_overflow_test),
+	KUNIT_CASE(seq_buf_strlen_test),
+	KUNIT_CASE(seq_buf_strlen_printf_overflow_test),
+	KUNIT_CASE(seq_buf_strlen_full_test),
+	KUNIT_CASE(seq_buf_strlen_puts_overflow_test),
+	KUNIT_CASE(seq_buf_strlen_embedded_nul_test),
+	KUNIT_CASE(seq_buf_strlen_zero_size_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.34.1

