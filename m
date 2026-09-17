Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5357314D35
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604615; cv=none; b=EsscVtvZmNDKdeXlJE1lTA9PSdBzzZXi74fdtAitaTj/xBBBkH9GZMC8NYMeIkqQxGOqMSTrJZFO/WTrYkdrAE8Fz5M6RiOCGCvNqQ1Z6Ev7YDPyD/XX/35MUONkX5OEF4iFfIwI0scBuVWef7VnUKEIGz2yPeTO22RgDQPfrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604615; c=relaxed/simple;
	bh=5qJ2B0WCLIGXkavgLN5Iy/BGxIHdcyND6NZ9e6wSobI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDNiNW09h++N7InhRedLC/eFCntDN5cEx+UgVEXl+8soLpOMOZI1PzA2OalkUFbVj/aQ9+4lqbkHiN1BEBKJ0TPO1UQmiDO+ubntmcEM4qGMq05MVH3CGyOOQe3wnYH8SwD2xFrwR+i/nLDel2K6TThJzGqZ8ic0ijGrG6NbtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gdjdry1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gdjdry1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9991F0089A;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604613;
	bh=pJo4MTWrKo+t8aH2lewjCaTzKPUlgNsW2BWe2T82ACw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gdjdry1KWfukVbIUzCu6XYSBQ5pKLgHsAqdqGNpviVS+UIshSA4YfxAzKFAzaH0xR
	 Kd00M7/qJVoUXj5MstG5XD1P1aWEX//Qz88xOtqOsYrYBnOVaIFDfZI1sq0CeN+Pvb
	 VHO6X+doUAKIH0H+egQJ2eypSrdzAF7ft5Wd8qNe10JoCOLOF1m8pQRoQJCkHayhyF
	 q7b/g+k2e5JCyPDJKIp/Jeke1zx/Hnqiuh/L0oXf+FuRKQis8GzfHs8CFdAROuHP9p
	 E/0U+b9agjHraaEiYIwFPDfo6OsNCiim2bZgCxrYIb5VXab2WADhqeOll/x9cIQwGP
	 18nBzDdYvueLQ==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	David Gow <david@davidgow.net>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/7] seq_buf: Copy what fits when seq_buf_puts() and seq_buf_putmem() overflow
Date: Wed, 16 Sep 2026 17:23:14 -0700
Message-Id: <20260917002333.2306346-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917002312.i.923-kees@kernel.org>
References: <20260917002312.i.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6753; i=kees@kernel.org; h=from:subject; bh=5qJ2B0WCLIGXkavgLN5Iy/BGxIHdcyND6NZ9e6wSobI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmrjb5qGn6+c7xHq/Zuw0qXpsLJAvZrrdOkzwhvf2N55 MG1zY/WdpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwkYArD/9Dt02Za3eZwvJTC 12PLdLbh0a/pTYec5BnZ34qGPXUt4GX4X/8/h2+3qF/NtVfSXt5xV2aYzV44fcb5T1ISficNtZy juAE=
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

Update seq_buf_putmem_hex_overflow_test, which expected a hex group that
did not fit whole to be left out entirely, and add tests that overflow
seq_buf_puts() and seq_buf_putmem_hex() with stale bytes in the buffer.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: David Gow <david@davidgow.net>
---
 include/linux/seq_buf.h   |  6 +++++
 lib/seq_buf.c             | 16 +++++++++++--
 lib/tests/seq_buf_kunit.c | 47 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 4 deletions(-)

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
index a92093f346da..4d67fe25e916 100644
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
@@ -242,6 +249,11 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
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
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 9048037f6ba0..3f3b076dd6fa 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -246,9 +246,9 @@ static void seq_buf_putmem_hex_overflow_test(struct kunit *test)
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
@@ -257,6 +257,47 @@ static void seq_buf_putmem_hex_overflow_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
 }
 
+static void seq_buf_puts_partial_overflow_test(struct kunit *test)
+{
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
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&t), "abcdefg");
+}
+
+static void seq_buf_putmem_hex_partial_overflow_test(struct kunit *test)
+{
+	const u8 data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+#ifdef __BIG_ENDIAN
+	const char *expected = "0001020304050607 08";
+#else
+	const char *expected = "0706050403020100 09";
+#endif
+	struct seq_buf s;
+	char buf[20];
+
+	/* Stale bytes after the data must not show up in the string. */
+	memset(buf, 'X', sizeof(buf));
+	seq_buf_init(&s, buf, sizeof(buf));
+	KUNIT_EXPECT_EQ(test, seq_buf_putmem_hex(&s, data, sizeof(data)), -1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
+}
+
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_declare_test),
@@ -270,6 +311,8 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_get_buf_commit_test),
 	KUNIT_CASE(seq_buf_putmem_hex_test),
 	KUNIT_CASE(seq_buf_putmem_hex_overflow_test),
+	KUNIT_CASE(seq_buf_puts_partial_overflow_test),
+	KUNIT_CASE(seq_buf_putmem_hex_partial_overflow_test),
 	{}
 };
 
-- 
2.34.1

