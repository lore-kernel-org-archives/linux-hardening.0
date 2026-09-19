Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649A2F1FE4;
	Sat, 19 Sep 2026 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777643; cv=none; b=Ai1vpGWDisRD0KlddRDwnQ6yX6AQaRk1k9BgPOdqwixw077ckZBavQNpD5Rd0aaDagIvDmhwgLHQktBj4GwP++FlDWUYDv4qqMw0v6BPAsvSDqqGdcNvQC8fWm5ApQPbYMpKsBU3klW0r89SaZwUCAJcxEGZNZg6egXNq504E0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777643; c=relaxed/simple;
	bh=PbLlB9DKOsjHO6/JxB13sg1T6u0Dl9NAg3XsfR7cqlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFQyV/VUFkfhIvfUxkYqHJjvz+6dsyVvJLT3dmjq268RdzIBfDk1mbLuxsMKBT/AULMo7frSLvGaXGaSdrJOOpXzXZOXPyiMyg2bvl8PREwHUWdMsSe9qCnb+Q5RbljnRnwuiuoDvHcj+1X2HoupOHa5koSWwZ1aje2/EPDx5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhNT0/Uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhNT0/Uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6FC1F0089D;
	Sat, 19 Sep 2026 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777634;
	bh=BiLh1RQoBkl3U0Hhj9kq+ouzWOg1flvWVNa4jSBN+3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lhNT0/UojwtF+lzvuqtN24zRGG9D6uZTEGpKSFOFbQnECOI7w6OzklVzcu7VaPsdk
	 /8F2yJE/CxNcgZFuWg+weysDDZ8RV3hiC0fyrzyt4k/yLvNFxRzcQmNEvFi/1YcymV
	 jRrs44dDNRVmpMGWWFLIGKMwVS+tRHbA3pXUTBuHz1gCdwSwuqcYcpQCXiMfR81+oV
	 2X95hMjhYzUUuLk8QZHfhwQSvW1k7bT0IL8g1ILXKqEFPdmo96THreRoWSNsbq/UQw
	 e8YTsF+MwwfksbMioy1R2Te6B32bnpXSwecO9jw5Zxmp/Auk1/qejqtMfrku9hRZS/
	 HTV2XT8d5gIOg==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>,
	Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 5/9] seq_buf: Add seq_buf_strlen()
Date: Fri, 18 Sep 2026 17:27:03 -0700
Message-Id: <20260919002714.4060307-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919002658.stay.929-kees@kernel.org>
References: <20260919002658.stay.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9706; i=kees@kernel.org; h=from:subject; bh=PbLlB9DKOsjHO6/JxB13sg1T6u0Dl9NAg3XsfR7cqlo=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrr91cHdSX57XY4C1/X+AmH84zTb+/pB0qbb056YnP7 MIIGYGUjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImsD2ZkWLhyVVNU4/H0AsbN qenKKtcv7zZmeTYhIFtd6If10i9BoYwMU2RmuzzW3+udat/EUceS7aJkd2s6FwOTzPSsePej2bP ZAQ==
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

Add tests comparing seq_buf_strlen() against strlen() of seq_buf_str()
for empty, appended, truncated, exactly full, and overflowed buffers,
and checking that seq_buf_strlen() alone terminates a full buffer.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <david@davidgow.net>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/seq_buf.h   |  57 +++++++++++++++++--
 lib/tests/seq_buf_kunit.c | 114 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 0c0a0db04b09..7f025c7a68be 100644
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
@@ -98,7 +119,9 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  *
  * Note, if this is called when the buffer has overflowed, then
  * the last byte of the buffer is zeroed, and the len will still
- * point passed it.
+ * point passed it. The same happens when the buffer is exactly
+ * full: the NUL takes the place of the last byte written, which is
+ * lost, though seq_buf_used() still counts it.
  *
  * After this function is called, s->buffer is safe to use
  * in string operations.
@@ -110,14 +133,38 @@ static inline const char *seq_buf_str(struct seq_buf *s)
 	if (WARN_ON(s->size == 0))
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
+	if (WARN_ON(s->size == 0))
+		return 0;
+
+	return __seq_buf_terminate(s);
+}
+
 /**
  * seq_buf_get_buf - get buffer to write arbitrary data to
  * @s: the seq_buf handle
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 852eb645e253..0259c8506b89 100644
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
@@ -510,6 +512,113 @@ static void seq_buf_path_overflow_test(struct kunit *test)
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
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_declare_test),
@@ -527,6 +636,11 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_putmem_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_hex_partial_overflow_test),
 	KUNIT_CASE(seq_buf_path_overflow_test),
+	KUNIT_CASE(seq_buf_strlen_test),
+	KUNIT_CASE(seq_buf_strlen_printf_overflow_test),
+	KUNIT_CASE(seq_buf_strlen_full_test),
+	KUNIT_CASE(seq_buf_strlen_puts_overflow_test),
+	KUNIT_CASE(seq_buf_strlen_embedded_nul_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.34.1

