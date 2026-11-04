Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763076;
	b=RCF81s9ItDrdfLDolEpz+lhuEuIT0UkZ+nT306SY8op8pYdL/fTKz7tB2ShqUd6a27+O
	 rdJAL8+Wyzb32X1CIDyg2Ktcb4V9D3OukKLgLGRghLrMOTYbJSjZYloFlXo8k8fOCjGbW
	 TNM370odlcvisQCdQHAAzafgNZ9nYWlisVKEITKS4fG0DhVqK1iV3QGwJbCE6Oo5gjTeO
	 5iZJzEjcRHqxwOfdNHsKC//mEE9jBaFHWy5eBkH9B3b1qt87cIO2dqRGDbbXxKESqrt6y
	 gXPqNZi1gDxwE8mvxxCDowUe1MrEqlypV31xxwVNAeAZl+0ZZ2rc1scDAqvXbyZxZrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763076;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=Kj38Yl5CIRITnwl0c840BEY5eU5VTEEYN+KugRp93fg=;
	b=Lwr4R9zlg1B/F6Si3KS8eVGNM3jD2M15y627Uq9rvVjtTwrG0OmqHGrcL7C5vMSq4XK/
	 N6e1a+l9wmFv1GThTeXs0Pak6KtEtcyBPR7oEu/NqhJB4qz098JdBltfftfVLoNxCIBkQ
	 qGnC2z74WjRO7DhKojblTS16ydsAAMzSC4d+NOxKEbohFlV1iR+NRSudlUruf0TGzeJCH
	 VRwgPmeXfHs/WJD4sUXnyRzWg3pigtetQfohxQx/1khIoIFjp6lVVYTkFD43TiiL3kn41
	 lFM35XHAEDUs64ASn4kXFZBszDsGLg+jqSmqY0MMrtnpcXENKpDjp2tqM6p4Pav1ZPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ch6Q41G2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BB606A329;
	Wed,  4 Nov 2026 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ch6Q41G2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296441F00A02;
	Wed,  4 Nov 2026 03:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793763075;
	bh=Kj38Yl5CIRITnwl0c840BEY5eU5VTEEYN+KugRp93fg=;
	h=From:To:Cc:Subject:Date;
	b=Ch6Q41G2CHFwAH52qlGW1TTB3C/dxPQJKGhV6AF1KJi7WlOPuB9vYSi9TVxEllkLs
	 oXymL033G4awzqMcipuSUn119VdimXqVgLNdm+SKLMBTch4tjD47gR5TY59CTKRoLH
	 LSMA2HqKVk8xtmJkSndCbIykOirSmTbLP5ZJEv/T7D7mcsUT0QNGUv8Nvzm/vfvDfG
	 boh32aZyHD+8wrUIFAjnQL4VqS49Nbq0rO190DdV9R4tNaUwDT+YCFRC9tQ6hCHlX9
	 jZ0py2TnDdsFVTzaWZIR4DnvOGcwbe6qjTIBS13YNtH46vUP0/oUeayz7aBUbRb0T3
	 3vXBjYWAafa1w==
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
Subject: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating it loses a byte
Date: Tue,  3 Nov 2026 19:31:13 -0800
Message-ID: <20261104033110.out.418-kees@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10113; i=kees@kernel.org; h=from:subject:message-id; bh=AaA3XB7g1wjlPLxdPqpdlLAY8rBei4Wukl4gjEd75VY=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmvljMeaQt78F96durdm3927S6QDfx+u3TC7w2//izu/ 5Zg0Ku/qqOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAigrmMDI94rvo1KpoemvH2 u+Dd3Zcezl1dI6Nj19b/MPyjEdPjr2cY/gfwrNmvcmuWeKGy0eGz7J+NGrP2xG4wyjyiHiNm8Mt NjRUA
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
seq_buf_used() still counts the lost byte. Data that already ends in a
NUL is left as is.

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
Fixes: f2616c772c768 ("seq_buf: Add seq_buf_terminate() API")
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v3:
 - Reword comments: "left as is", and no "must" (Steven Rostedt)
 - Fixes: the bug predates seq_buf_strlen(), back to the addition of
   seq_buf_terminate() (Alejandro Colomar)
 v2: https://lore.kernel.org/all/20261030192049.stay.397-kees@kernel.org/
 v1: https://lore.kernel.org/all/20261029053250.i.220-kees@kernel.org/

---
 include/linux/seq_buf.h   | 27 ++++++++++---
 lib/tests/seq_buf_kunit.c | 84 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index f006f2654e4c..6b915c67d235 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -128,8 +128,9 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 
 /*
  * NUL-terminate the buffer in @s: directly after the data when there is
- * room for it, otherwise in the last byte of the buffer. @s->size must not
- * be zero.
+ * room for it, otherwise in the last byte of the buffer, which marks @s as
+ * overflowed. Data that already ends in a NUL is left as is. @s->size must
+ * not be zero.
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
+		 * The last byte of data will be overwritten by a NUL
+		 * character, so mark the seq_buf as overflowed.
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
+ * and @s is left as is.
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

