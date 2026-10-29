Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793251977;
	b=suQjq0jCM1fRboawjSvj7XPeSKJvCILmOBNVu1RLnhEpWBQLZ3820WBDb059jvHZ5fNA
	 bAEpdm8/nk91Ght0Af9NivuoRC6jSf7lGTwqfYaVLNwcSyz7fygYlknfJqpuM4dTXt/we
	 e/Hdc1+bjnl3Eku3m9qQ/N8OsjVq4bXfCUrRFR86Ch5zhEiIXe+d6ztc6YbQlOS34L89F
	 Qvh2SH0xQEaq2ISMvZFP9Fk4xTkJdPYW5kSYGAhkfBVmB/uqb2afqKFsOcR3hRG1aYLtR
	 kxTI1/gBC09pyi8SzlJJdvFSofQc5NDK+s1mAZ8N0QTxD6ipkrJ89elHP5JYzeVqmeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793251977;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=FhkaABeHOyktDN6PUa1N1F2mjspl8ccZnGo2qj3CXko=;
	b=VZROSKt4s3pglvN9khAG74esIrpjSku4CyxEipQiRBpNzDsDM76RFgHtTVQNjkenBE5h
	 +ZW6MPBqNr+/3IZNphAFb8ksUuqCJjXoyt+kdepZ4HyxC7JN5azDs2ta9nPRX67ckRc2A
	 vqTuO6HN94A0xpoC838qM0eGnGDPwyjneoxfxxy/wxyQbFSg1nJ/iTW8y3PRkPxlyeNNI
	 KFv/sy/p0geCT3YU+TEtuV7coyHHofXKF8lB2UAC4zmBWCOCLCgVoI1VbouJnLsBiEb6E
	 1y/GI7tbG3tWe3yHO0dy5L42DWe5MUUmNitkeO4YvFAOhPg4rw4PQsnoYPEOQLLa3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=noObcaIX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07143606A31A;
	Thu, 29 Oct 2026 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=noObcaIX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7DE1F01825;
	Thu, 29 Oct 2026 05:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793251976;
	bh=FhkaABeHOyktDN6PUa1N1F2mjspl8ccZnGo2qj3CXko=;
	h=From:To:Cc:Subject:Date;
	b=noObcaIX91O9F+FS08lOo/ZPaVfYYH8BmV0Wn7WnZPB9GEc+hx38rAUXFgV9UGsFB
	 LGJW0RnAtBiwHtTBqVenvlMEzYwZukA3UFfhM3kqr5qWSkItw1rwxYHyqt1xFHgnV/
	 G3+j3qri3efSHEfRfdfdNjRVzlgQZBlugKonts0Do5anqidnHz+vCgA+bK0E99al1z
	 LfxfJ39AHDI9awJOGDPuITKmnXhBQiH9S7ejM9IitsicdicCOEoDkSfZNTj84suDpj
	 h4KM7Ia6fFbGuKCgm1cFQCaL6/XpEgJ/ORUf6iVCWQrYXRhAJlvRHrASqHIExXFkS5
	 ChL/yb/EA7PYg==
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it loses a byte
Date: Wed, 28 Oct 2026 22:32:54 -0700
Message-ID: <20261029053250.i.220-kees@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8082; i=kees@kernel.org; h=from:subject:message-id; bh=VUlEBLYmWwC5csMRY6js1Lx/4Dcsgh1Rjeq88l5Lm6I=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmPbrUplbJdXyi+4OR54yOVu0x+H2xxXL4yzmGfOM+Ev 3v4n/6t6yhlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjI2SuMDHvkLM1LfDTWbizl +pgaqvfv3QS5uO8zNWR6nMxl7+x73cXI0BS1cxOjWf6Xq0KvFs3jNc2Qc/+7WXzB9defihd1n/Y 5xg4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When there is no room after the data for a NUL, __seq_buf_terminate()
writes it over the last byte of the buffer. An overflowed seq_buf has
already lost data, but one that is exactly full, as seq_buf_putc(),
seq_buf_putmem(), and seq_buf_commit() can leave it, has not: the NUL
replaces the last byte written, and the seq_buf still does not report
an overflow. seq_buf_str(), seq_buf_strlen(), and seq_buf_terminate()
all go through it, so each of them can silently truncate what was
written, and seq_buf_pop() then returns the NUL in place of the byte it
replaced.

Mark the seq_buf overflowed in that case with seq_buf_set_overflow(),
as suggested in review. Nothing is left between "len" and "size" for it
to clear there, and seq_buf_used() still counts the lost byte.

No current caller checks for overflow after terminating a seq_buf that
can be left exactly full, so none of them behaves differently.

Add a test that fills a seq_buf exactly and checks that each of the
three accessors marks it overflowed, that seq_buf_pop() then returns
-1, and that a seq_buf with room for the NUL is not marked. Update the
existing tests that terminate an exactly full seq_buf to expect it, and
move the length check in the seq_buf_do_printk() test after the run,
so that the buffer still reaches seq_buf_do_printk() exactly full.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0, and the new
test fails with the fix reverted.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20261016145928.16eddc9a@gandalf.local.home/
Fixes: 8d1478bfd63be ("seq_buf: Add seq_buf_strlen()")
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h   | 19 ++++++++++-----
 lib/tests/seq_buf_kunit.c | 49 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index f006f2654e4c..c38b5eccc212 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -128,8 +128,8 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 
 /*
  * NUL-terminate the buffer in @s: directly after the data when there is
- * room for it, otherwise in the last byte of the buffer. @s->size must not
- * be zero.
+ * room for it, otherwise in the last byte of the buffer, which marks @s as
+ * overflowed. @s->size must not be zero.
  *
  * Returns: the offset of the NUL.
  */
@@ -137,10 +137,16 @@ static inline size_t __seq_buf_terminate(struct seq_buf *s)
 {
 	size_t end;
 
-	if (seq_buf_buffer_left(s))
+	if (seq_buf_buffer_left(s)) {
 		end = s->len;
-	else
+	} else {
 		end = s->size - 1;
+		/*
+		 * About to overwrite a written byte in the last position
+		 * in the buffer, so it must be considered overflowed now.
+		 */
+		seq_buf_set_overflow(s);
+	}
 
 	s->buffer[end] = 0;
 
@@ -158,7 +164,8 @@ static inline size_t __seq_buf_terminate(struct seq_buf *s)
  * the last byte of the buffer is zeroed, and the len will still
  * point passed it. The same happens when the buffer is exactly
  * full: the NUL takes the place of the last byte written, which is
- * lost, though seq_buf_used() still counts it.
+ * lost, so @s is marked as overflowed, though seq_buf_used() still
+ * counts that byte.
  *
  * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
  * is returned instead of writing to @s->buffer. Any other seq_buf
@@ -189,7 +196,7 @@ static inline const char *seq_buf_str(struct seq_buf *s)
  * without walking it. Unlike seq_buf_used(), this does not count the byte
  * given up to the NUL when the buffer is full or has overflowed. When the
  * buffer is exactly full, that byte is the last one written, and calling
- * either function loses it.
+ * either function loses it and marks @s as overflowed.
  *
  * A zero-sized seq_buf holds no string, so 0 is returned without writing
  * to @s->buffer, matching what seq_buf_str() returns for one.
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index fc53e9ef844c..a67ed6d7b517 100644
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
@@ -735,6 +737,48 @@ static void seq_buf_terminate_test(struct kunit *test)
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
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
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
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_init_append_test),
@@ -760,6 +804,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_strlen_embedded_nul_test),
 	KUNIT_CASE(seq_buf_strlen_zero_size_test),
 	KUNIT_CASE(seq_buf_terminate_test),
+	KUNIT_CASE(seq_buf_terminate_full_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.55.0

