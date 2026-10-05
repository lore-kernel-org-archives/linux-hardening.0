Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624D4CE68A;
	Mon,  5 Oct 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215843; cv=none; b=MqIY7vYEmPX0yipZVcMR8vMhW0oE8i1ilEegbr/ZmO2hMeGVYGymCUYs36R1HGbyqIoDkNh7JZAQyBpaVfOEzUQkLJBpUiUw3SDC4pNakWnj26e2F2j7bgIlAnfPJBvSAx+pyF3iOYFz6E4hNVQmeBoSHOUBVkWN1GtWudCiFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215843; c=relaxed/simple;
	bh=37rf/xNNVRb/1KiSTnxygbv5+NQ+4rfo7S3qzkrgWtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwLnfTZAIgh92UhY+NkDzLt4RdPJ64DOdIvWLrBoteuDGMBdrUhC/PzONwfZq3d3cua5wkNbJ8ILp8qN18KrQ6MbwzlWiiKWZo27JcCH+0pPMTkz5KtGF4M/daKzhKg2MeTkh8sEuT76R88mSGo17TT12OLADgckWujtkjccu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdMOiM5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdMOiM5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FB21F0089F;
	Mon,  5 Oct 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215838;
	bh=7SuJY3k2kmNsMJSwSZXA04J0ONqXZrkivO9Klq0IODE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IdMOiM5ngwnkH/2W6k6/OgamD2PV4FyT1eokpq5++vW3aVWfCsAVwxh/CdIp2513f
	 LUIXb9pVrTKhz4HQSm7688LjfT/F1KDp/PWDoUfVksvsSylFa9cCphodMt/jd6jsOx
	 2WD/5IJpJoSoMsYxDEDuv0BjVi6jhOkBJyX3uJ+thaSB13vIFF22yxv8LjjTOnvhgw
	 rNx8G0I49zxvdXH+mZUXwLCh59cqnpmPGnr1V9JdTKot+zU+VAb3tt1+eQhjv0m+Zt
	 mzgfb9TDGsdruNVfogahxuiNsktQE2PrPSk9mDrHEV2WMCGHPgUjNyTThKclyYpxGZ
	 3Iyqi9GTQbbOg==
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
Subject: [PATCH v5 09/12] seq_buf: Add seq_buf_init_append()
Date: Mon,  5 Oct 2026 08:56:59 -0700
Message-ID: <20261005155708.1471260-9-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005155653.late.426-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5786; i=kees@kernel.org; h=from:subject; bh=MsK9B4qxyOrArSkifRFg9tmcYn/2ynAQ2jzEol3ugWk=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHT5x98Nzm3ieBlheZvP5Hd+gu/1S31O0Ie21+UCfT0 fl3fYT/d5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwk2pWR4f//SwenJrfd5OxL u3l1bsokmzuSAWuD9S2kDSfJHHzEtobhf8WpnyZWFe1uH5MWP3v536daeekdduU7AQIL1y7nuf5 jJRMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Bill Wendling <morbo@google.com>

Several strlcat() call sites being converted to seq_buf need behavior
seq_buf doesn't currently provide. The normal seq_buf_init() always
empties the buffer (sets its "len" to 0) via seq_buf_clear(). Code
migrating from strlcat(buf, ...), which appends to whatever buf already
contains, can't use seq_buf_init() without discarding that existing
content. Add seq_buf_init_append(), which preserves the existing
contents and positions the seq_buf to append after it. A buffer with
no NUL within its size starts out overflowed, as strlcat() treats it
as already truncated. Add KUnit tests for behavior coverage.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0.

Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h   | 25 ++++++++++++++
 lib/tests/seq_buf_kunit.c | 69 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 9830f905f0ee..be979089228f 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -71,6 +71,31 @@ seq_buf_set_overflow(struct seq_buf *s)
 	s->len = s->size + 1;
 }
 
+/**
+ * seq_buf_init_append - initialize a seq_buf over a buffer that may
+ *			 already hold NUL-terminated content
+ * @s: the seq_buf handle
+ * @buf: pointer to the (possibly non-empty) buffer
+ * @size: total size of @buf
+ *
+ * Unlike seq_buf_init(), which always starts @buf at len=0, this
+ * preserves whatever NUL-terminated content @buf already holds and
+ * positions @s to append after it. Useful for converting code that used
+ * to append to an existing buffer with strlcat()/scnprintf() and friends.
+ *
+ * If @buf holds no NUL within @size, @s starts out overflowed, as
+ * strlcat() treats such a buffer as already truncated.
+ */
+static inline void
+seq_buf_init_append(struct seq_buf *s, char *buf, unsigned int size)
+{
+	s->buffer = buf;
+	s->size = size;
+	s->len = strnlen(buf, size);
+	if (s->len == size)
+		seq_buf_set_overflow(s);
+}
+
 /*
  * How much buffer is left on the seq_buf?
  */
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 33d351d0be64..fc53e9ef844c 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -28,6 +28,74 @@ static void seq_buf_init_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 0);
 }
 
+static void seq_buf_init_append_test(struct kunit *test)
+{
+	char buf[32] = "hello";
+	struct seq_buf s;
+
+	/* Initial string contents match. */
+	seq_buf_init_append(&s, buf, sizeof(buf));
+	KUNIT_EXPECT_EQ(test, s.size, 32);
+	KUNIT_EXPECT_EQ(test, s.len, 5);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 32 - 5);
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 5);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 5);
+
+	/* Appending with space works. */
+	seq_buf_puts(&s, " world");
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 11);
+
+	/* No truncation when space for NUL is present. */
+	seq_buf_init_append(&s, buf, 12);
+	KUNIT_EXPECT_EQ(test, s.size, 12);
+	KUNIT_EXPECT_EQ(test, s.len, 11);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello world");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 11);
+
+	/*
+	 * No NUL within the size: the content is already truncated, as
+	 * strlcat() would see it, so @s starts out overflowed. The content
+	 * stays, and appending adds nothing.
+	 */
+	seq_buf_init_append(&s, buf, 11);
+	KUNIT_EXPECT_EQ(test, s.size, 11);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 0);
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
+	KUNIT_EXPECT_MEMEQ(test, buf, "hello world", 11);
+	seq_buf_puts(&s, "!");
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_MEMEQ(test, buf, "hello world", 11);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello worl");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 10);
+
+	/*
+	 * The size bounds the scan: the string runs past it, so there is
+	 * no NUL within the size either.
+	 */
+	seq_buf_init_append(&s, buf, 5);
+	KUNIT_EXPECT_EQ(test, s.size, 5);
+	/* Overflowed at the size; an unbounded scan would find more. */
+	KUNIT_EXPECT_EQ(test, s.len, 5 + 1);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 0);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hell");
+
+	/* With no room even for a NUL, @s is overflowed and @buf untouched. */
+	seq_buf_init_append(&s, buf, 0);
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 0);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "");
+	KUNIT_EXPECT_EQ(test, buf[0], 'h');
+}
+
 static void seq_buf_declare_test(struct kunit *test)
 {
 	DECLARE_SEQ_BUF(s, 24);
@@ -669,6 +737,7 @@ static void seq_buf_terminate_test(struct kunit *test)
 
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
+	KUNIT_CASE(seq_buf_init_append_test),
 	KUNIT_CASE(seq_buf_declare_test),
 	KUNIT_CASE(seq_buf_clear_test),
 	KUNIT_CASE(seq_buf_puts_test),
-- 
2.55.0

