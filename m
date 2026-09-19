Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621D2ED141;
	Sat, 19 Sep 2026 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777641; cv=none; b=sp3MfNAlT92nfID3NNf2eb8gpSxifUrXT7TC+AivVFaYwv5s9z5a+RSLUZTjEQHgxZSUkklQkKe3fThKoMvieZ3GdfyqqHYCNt39M6rjbwcC300vXD2Z2gCC2hGzrZdy+uRR3SvtwOfmHO3IP34fj9yxp3rX9BuUlmWPlIYeDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777641; c=relaxed/simple;
	bh=g3n4Mc6ZCOTrZ0oyKstJy14X2L3I+LTBsJnqtfZJ9xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAlRTe959s9f7S9tH4Qsgem3Jtb/YL7M5LXqx78kCh7kG58ClTNuUQrG446cKstX0Rx9L7fjGAOLVfj8ubUrhNF5m7xwEeVAI4RgqoyiRmH01XzFDcD3qFQBJnZGwQXR7Bs1ZZsCL9CIr6ZBCbKCo8+EExNIYRiRiQlTHFXI52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrmdqRlE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrmdqRlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7111F008A0;
	Sat, 19 Sep 2026 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777634;
	bh=HeGhXR3Juett99sfkepIICZY00QfUwUjyLbhtWPzTaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nrmdqRlEQRF90lLwBBlxvCiMXyX1NuTFPv0T55a7Y2oEk+v4XR/cXJbgLeONNKt1Y
	 kJy9DCQkO1RQub2k7hH1wn4snnWDi9zAQ4P9dxlSUq/0LWJdk9MGFJsH0vNN9V3Lob
	 OerK9RdT7F6c0wChVuvQSGXd9tyRkwNAMSXDMewKB5aTXy1KFNec9o8hKTz2Dyklsi
	 zJ3pNpwJ9EHbDUnPGeaU+T2gk4C08uY25vSqBlro7mvSZYM7VooDVerS1B72KlvOIW
	 PXBMRRkWnvZFlBPreK24uYD5iJ5uo/HrwbGncEZrEHnKDzxvq9ssOUXPhImWYJFSCo
	 HinxjCSjx7xIw==
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
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 6/9] seq_buf: Add seq_buf_init_append()
Date: Fri, 18 Sep 2026 17:27:04 -0700
Message-Id: <20260919002714.4060307-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919002658.stay.929-kees@kernel.org>
References: <20260919002658.stay.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5159; i=kees@kernel.org; h=from:subject; bh=2jEhoAnmYol0m29D/A4CG+1cEgBdo3afaKT4TBfBk1k=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrr918q+DlZhubIHxMT+tES5zAkRCXdVOjo24wzJNcN 8X/wGyBjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIls4WH475RpnrZBLiSMtWaK tfFDrW+JFv+Lpit7eF6Z2739p4m8EsP/GHb7pwENB3/zNTzNusf7/mKDXnTonuLyA3fi5l66zjG bAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Bill Wendling <morbo@google.com>

Several strlcat() call sites being converted to seq_buf need behavior
seq_buf doesn't currently provide. The normal seq_buf_init() always
sets the new buffer size to 0 via seq_buf_clear(). Code migrating from
strlcat(buf, ...), which appends to whatever buf already contains,
can't use seq_buf_init() without discarding that existing content. Add
seq_buf_init_append(), which preserves the existing contents and positions
the seq_buf to append after it. Add KUnit tests for behavior coverage.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
Co-developed-by: Kees Cook <kees@kernel.org>
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
 include/linux/seq_buf.h   | 20 +++++++++++++++
 lib/tests/seq_buf_kunit.c | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 7f025c7a68be..89d847d40626 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -46,6 +46,26 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
 	seq_buf_clear(s);
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
+ */
+static inline void
+seq_buf_init_append(struct seq_buf *s, char *buf, unsigned int size)
+{
+	s->buffer = buf;
+	s->size = size;
+	s->len = strnlen(buf, size);
+}
+
 /*
  * seq_buf have a buffer that might overflow. When this happens
  * len is set to be greater than size.
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 0259c8506b89..f3058771d96c 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -29,6 +29,58 @@ static void seq_buf_init_test(struct kunit *test)
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
+	/* Check for required truncation when full. */
+	seq_buf_init_append(&s, buf, 11);
+	KUNIT_EXPECT_EQ(test, s.size, 11);
+	KUNIT_EXPECT_EQ(test, s.len, 11);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 0);
+	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 11);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hello worl");
+	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 10);
+
+	/*
+	 * The size bounds the scan: the string reaches past it, so an
+	 * unbounded strlen() would report 10 here and leave @s overflowed.
+	 */
+	seq_buf_init_append(&s, buf, 5);
+	KUNIT_EXPECT_EQ(test, s.size, 5);
+	KUNIT_EXPECT_EQ(test, s.len, 5);
+	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
+	KUNIT_EXPECT_EQ(test, seq_buf_buffer_left(&s), 0);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "hell");
+}
 
 static void seq_buf_declare_test(struct kunit *test)
 {
@@ -621,6 +673,7 @@ static void seq_buf_strlen_embedded_nul_test(struct kunit *test)
 
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
+	KUNIT_CASE(seq_buf_init_append_test),
 	KUNIT_CASE(seq_buf_declare_test),
 	KUNIT_CASE(seq_buf_clear_test),
 	KUNIT_CASE(seq_buf_puts_test),
-- 
2.34.1

