Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388057;
	b=txx3bBqqqMLG1I7thEG7l5JoWwEJprBj+gqsaHYpWLleFRYBLJ7pFTj4B74hxM3VJFHJ
	 stJZ+PDFUrYR/omFhifwAoftFOD9Vc8yqIMsgnB2zWDsH4umPlmIcvIsr0qqmrv3zLCIm
	 Vdp5ItB2MfbrPUqy/CZPGQTbv3ZkF9hGZ23Yg/RxjO6jCJLLYM1U9LaaNIGqEWU705z5x
	 ti8XJ0XuoidT6m1c5dNVStsfGMORr+5FhZTdCZthMsz+X7a6XuSEQpBFAAs1Apzu29mDO
	 fpCGk3ruCxwiocqBQupyDaV1bsUTxerzuzKYmscrhImnL62rVP1TRQmO15aTkGqp6Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=RVjiRSShWC/S1BGZPacen5xemtsVNhSesBDhJtJT+80=;
	b=b5OCWIFIvhq3gXS4omMIrNBCnS7I2LS7rJlJMjOavWYuIJ1cbRQt1MSWe3BUL9lRV4v8
	 1sFUuaeZohslbOralCSYmIZm6AyJKvhK8x+5V+rhQ7ZWDhJmcKVJc+9+QeyYIXdEzy+G4
	 RfWf+pe0eHcB54MzQVtmVi/JImAPW6YgTsQeHgyLsaTFnPIlIy+iMzRKrqlgKVT3EXcqd
	 Q9LlqNe25QTXOUuGvUB3LCyVf1iw7H8WriQxJ9ReNzdC4AlM4Aol3X9Jd00kP2dx0hFvo
	 P1x58/DAy+J59seTvxUeb//YT+UPmRaXwpshuw3o+siToPWe85Q4mJ6Jp/EaHGV+l1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPovoLjW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD8606A31C;
	Fri, 30 Oct 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPovoLjW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429401F0093A;
	Fri, 30 Oct 2026 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793388056;
	bh=RVjiRSShWC/S1BGZPacen5xemtsVNhSesBDhJtJT+80=;
	h=From:To:Cc:Subject:Date;
	b=fPovoLjW7xops4x5iegUkAWRsBZcK+vzK//NhaNxa+2/wGDjTK27PVl88RE5dnwuD
	 usTPZWWeNtBzENviYMpljoDxrL8NWdaVCoheGyXCC9h7q4GYzrmPJGm31pv+WLaHWe
	 E+FEdQJqs3kb0+hFqZAv0PLc3/CM2jllIr1MozeNA6zas3Z3bLj8hpKTctbpni8Rk6
	 8w+tx4NbrUm/vTIPktB4LSip4F6NianWprhPD92oEiFW10a+bdPg3k+3FEjYJfR2hh
	 +N5Lm8HdhyjiVosBQQwa3l1Bd7hvYtlAhhbSqFfifklEh6fEEpAq6WD/ZC62FJvgK2
	 xrB5HiTXcXwJA==
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] seq_buf: Mark a seq_buf overflowed when terminating it loses a byte
Date: Fri, 30 Oct 2026 12:20:54 -0700
Message-ID: <20261030192049.stay.397-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10254; i=kees@kernel.org; h=from:subject:message-id; bh=5S3mEBnZJi4xhrRwl8W7UzUgqbvBGFlsgrM0mW6JkiA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlP3okd5k79I2e7ZnL+zJIeRdmkW0oGnObHZh2uSVzzy KWkYcH8jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImY6zH8M5YKFw5unNxqfHS2 yXmOdfkCV/8lLH26sPCjqpm8/zNXSUaGh9Xre7nFo8qFzQ/uPXlwUp2nf65vWfWf+xHnFnlz7Fd jBAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When there is no room after the data for a NUL, __seq_buf_terminate()
writes the NUL over the last byte of the buffer. An overflowed seq_buf
has already lost data, but one that is exactly full, as seq_buf_putc(),
seq_buf_putmem(), and seq_buf_commit() can leave it, has not: the NUL
replaces the last byte written, and the seq_buf still does not report an
overflow. seq_buf_str(), seq_buf_strlen(), and seq_buf_terminate() all
go through it, so each of them can silently truncate what was written,
and seq_buf_pop() then returns the NUL in place of the byte it replaced.

Mark the seq_buf overflowed in that case with seq_buf_set_overflow().
Nothing is left between "len" and "size" for it to clear there, and
seq_buf_used() still counts the lost byte. This must not, however,
mark the string as overflowed when it already ends in a NUL.

No current caller checks for overflow after terminating a seq_buf that
can be left exactly full, so none of them behaves differently.

Add a test that fills a seq_buf exactly and checks that each of the
three accessors marks it overflowed, that seq_buf_pop() then returns
-1, and that a seq_buf with room for the NUL is not marked, and another
that checks the same accessors on data ending in its own NUL. Update the
existing tests that terminate an exactly full seq_buf to expect it, and
move the length check in the seq_buf_do_printk() test after the run,
so that the buffer still reaches seq_buf_do_printk() exactly full.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0, and the new
tests fail with the fix reverted.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20261016145928.16eddc9a@gandalf.local.home/
Fixes: 8d1478bfd63be ("seq_buf: Add seq_buf_strlen()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2:
 - Leave data that already ends in a NUL as it is: an exactly full
   seq_buf holding it is not marked overflowed, and with room left the
   offset of that NUL is returned (Steven Rostedt)
 - Add seq_buf_terminate_written_nul_test for that case
 - Drop a redundant seq_buf_str() check from seq_buf_terminate_full_test
 v1: https://lore.kernel.org/all/20261029053250.i.220-kees@kernel.org/

---
 include/linux/seq_buf.h   | 27 ++++++++++---
 lib/tests/seq_buf_kunit.c | 84 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index f006f2654e4c..1b38c3844e96 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -128,8 +128,9 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 
 /*
  * NUL-terminate the buffer in @s: directly after the data when there is
- * room for it, otherwise in the last byte of the buffer. @s->size must not
- * be zero.
+ * room for it, otherwise in the last byte of the buffer, which marks @s as
+ * overflowed. Data that already ends in a NUL is left as it is, and @s is
+ * not marked. @s->size must not be zero.
  *
  * Returns: the offset of the NUL.
  */
@@ -137,10 +138,20 @@ static inline size_t __seq_buf_terminate(struct seq_buf *s)
 {
 	size_t end;
 
-	if (seq_buf_buffer_left(s))
+	if (seq_buf_buffer_left(s)) {
+		if (s->len && !s->buffer[s->len - 1])
+			return s->len - 1;
 		end = s->len;
-	else
+	} else {
 		end = s->size - 1;
+		if (!s->buffer[end])
+			return end;
+		/*
+		 * About to overwrite a written byte in the last position
+		 * in the buffer, so it must be considered overflowed now.
+		 */
+		seq_buf_set_overflow(s);
+	}
 
 	s->buffer[end] = 0;
 
@@ -158,7 +169,9 @@ static inline size_t __seq_buf_terminate(struct seq_buf *s)
  * the last byte of the buffer is zeroed, and the len will still
  * point passed it. The same happens when the buffer is exactly
  * full: the NUL takes the place of the last byte written, which is
- * lost, though seq_buf_used() still counts it.
+ * lost, so @s is marked as overflowed, though seq_buf_used() still
+ * counts that byte. When that byte is a NUL already, nothing is lost
+ * and @s is left as it is.
  *
  * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
  * is returned instead of writing to @s->buffer. Any other seq_buf
@@ -189,7 +202,9 @@ static inline const char *seq_buf_str(struct seq_buf *s)
  * without walking it. Unlike seq_buf_used(), this does not count the byte
  * given up to the NUL when the buffer is full or has overflowed. When the
  * buffer is exactly full, that byte is the last one written, and calling
- * either function loses it.
+ * either function loses it and marks @s as overflowed, unless it is a NUL
+ * itself. Data that ends in a NUL is already terminated, so its length
+ * does not count that NUL.
  *
  * A zero-sized seq_buf holds no string, so 0 is returned without writing
  * to @s->buffer, matching what seq_buf_str() returns for one.
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index fc53e9ef844c..7f9cd5855922 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -504,13 +504,13 @@ static void seq_buf_do_printk_test(struct kunit *test)
 	seq_buf_putc(&s, '!');
 	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&s));
 	KUNIT_ASSERT_EQ(test, seq_buf_used(&s), 8);
-	KUNIT_ASSERT_EQ(test, strlen(seq_buf_str(&s)), 7);
 
 	seq_buf_printk_run(&capture, &s);
 
 	/* The one line that was written, and nothing after it. */
 	KUNIT_EXPECT_EQ(test, seq_buf_printk_marked, 1);
 	KUNIT_EXPECT_EQ(test, seq_buf_printk_empty, 0);
+	KUNIT_EXPECT_EQ(test, strlen(seq_buf_str(&s)), 7);
 
 	/* Check that lines without a trailing newline are shown. */
 	seq_buf_puts(&t, SEQ_BUF_PRINTK_MARKER "\n" SEQ_BUF_PRINTK_MARKER);
@@ -630,7 +630,8 @@ static void seq_buf_strlen_full_test(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
 	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
 	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 3);
-	/* seq_buf_strlen() terminates the buffer by itself. */
+	/* seq_buf_strlen() terminates the buffer by itself, losing the 'd'. */
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
 	KUNIT_EXPECT_EQ(test, s.buffer[3], '\0');
 	KUNIT_EXPECT_EQ(test, strnlen(s.buffer, s.size), 3);
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
@@ -649,6 +650,7 @@ static void seq_buf_strlen_full_test(struct kunit *test)
 	seq_buf_commit(&t, len);
 	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&t));
 	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 7);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
 	KUNIT_EXPECT_EQ(test, t.buffer[7], '\0');
 	KUNIT_EXPECT_EQ(test, strnlen(t.buffer, t.size), 7);
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&t), "zzzzzzz");
@@ -735,6 +737,82 @@ static void seq_buf_terminate_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, buf, "untouched");
 }
 
+static void seq_buf_terminate_full_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 4);
+	DECLARE_SEQ_BUF(t, 4);
+	DECLARE_SEQ_BUF(u, 4);
+	DECLARE_SEQ_BUF(v, 4);
+
+	/*
+	 * Terminating a buffer that is exactly full puts the NUL over the
+	 * last byte written, so what it holds is truncated, and each of
+	 * seq_buf_str(), seq_buf_strlen() and seq_buf_terminate() must mark
+	 * it overflowed.
+	 */
+	seq_buf_putmem(&s, "abcd", 4);
+	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
+	/* The NUL must not be popped in place of the 'd' it replaced. */
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), -1);
+
+	seq_buf_putmem(&t, "abcd", 4);
+	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&t));
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 3);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
+
+	seq_buf_putmem(&u, "abcd", 4);
+	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&u));
+	seq_buf_terminate(&u);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&u));
+	KUNIT_EXPECT_STREQ(test, u.buffer, "abc");
+
+	/* With room left for the NUL, nothing is lost. */
+	seq_buf_putmem(&v, "abc", 3);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&v), "abc");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&v), 3);
+	seq_buf_terminate(&v);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&v));
+	KUNIT_EXPECT_EQ(test, seq_buf_pop(&v), 'c');
+}
+
+static void seq_buf_terminate_written_nul_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 4);
+	DECLARE_SEQ_BUF(t, 4);
+	DECLARE_SEQ_BUF(u, 4);
+	DECLARE_SEQ_BUF(v, 8);
+
+	/*
+	 * A buffer filled exactly by data that ends in its own NUL is
+	 * already terminated, so nothing written is lost, and none of
+	 * seq_buf_str(), seq_buf_strlen() and seq_buf_terminate() may mark
+	 * it overflowed.
+	 */
+	seq_buf_putmem(&s, "abc", 4);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
+
+	seq_buf_putmem(&t, "abc", 4);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 3);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&t));
+
+	seq_buf_putmem(&u, "abc", 4);
+	seq_buf_terminate(&u);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&u));
+	KUNIT_EXPECT_STREQ(test, u.buffer, "abc");
+
+	/* With room left, the length still ends at the NUL that was written. */
+	seq_buf_putmem(&v, "abc", 4);
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&v), 3);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&v), "abc");
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&v));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&v), 4);
+}
+
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_init_append_test),
@@ -760,6 +838,8 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_strlen_embedded_nul_test),
 	KUNIT_CASE(seq_buf_strlen_zero_size_test),
 	KUNIT_CASE(seq_buf_terminate_test),
+	KUNIT_CASE(seq_buf_terminate_full_test),
+	KUNIT_CASE(seq_buf_terminate_written_nul_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.55.0

