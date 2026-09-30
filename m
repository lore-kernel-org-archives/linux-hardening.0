Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2004C33D3;
	Wed, 30 Sep 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812375; cv=none; b=bDbJi8z8f+da709+9YDZphSsnJTpW/cv5l6T8lTZmS7hwORqS7Y1s7eUZa60/yYnuQv4VPKvlI6Wkx5KVQ3miqpkC+GhHFTJsdQEUU2CebEijCJwKp03uXMIgoDHfehzFzoOKTz24ljYI7lIlCpHLGPZ3sml5FPWyxun0eNdsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812375; c=relaxed/simple;
	bh=2pWbibimYJjEXAHdaatZyQiBGge4J8y7TGlnBYdtUpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQs24sLcp6etvdsr8uHwjc2iZt3zXt7Vwz31vJdyDRQv/PWseyc/a7UWASNWe9xaNiB2OX4qSk8/poL7UPq7hUKH92muiVprremwqz+nyl1ogNQBzsDVVXkHNk7W9ZMSx2AcN0rS8QU2mmB6u0gGU8cCAS+uBZzBHv1Tc6aB9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTqH4x8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTqH4x8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CD71F0089D;
	Wed, 30 Sep 2026 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812371;
	bh=0rGd0l6phK5RjyIfaqlGeNty+f5gO7jzOqYdPkB7HTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fTqH4x8uFZnteW656odC+z6VqmAhSEJnkaKwZ7XfXo/zIuNLr/pYWyNOz2UbATeK6
	 e2HUvDwyphEucY0fsAGcTzqmZ3prg3i8/r92B0TpZK8O8gj79LBiDrO3iLW+NablZN
	 I3gU7hIBSqilk5HJyWd548AK5e6BUyM5fqEX/up4TC3Z51HZU+fF0je5V9YydCVpLF
	 Ci9HLLDFfZSPORayHWSajwFmv35DdTyqP0oHp5voPCz9Gx5Clqvqt5EHuH3Un/vZzd
	 uQPQQyPpi8XsrhHuGYTB2C3ToFN7K/ag0g3dS+6h2w6bICSv6QuMLoGEQh0w8aXC7J
	 W+910TYT3RyZw==
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
Subject: [PATCH v3 08/11] seq_buf: Add seq_buf_init_append()
Date: Wed, 30 Sep 2026 16:52:36 -0700
Message-Id: <20260930235247.157921-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4828; i=kees@kernel.org; h=from:subject; bh=BwcCXVyHW3lUCTkHo6Pgo9IWy8KBkwjAuRDkuIELs1I=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7FxxbJ9bQb2f/75B2rFc2x9Y1jn9UFt2/1RD8OHraT I7NtW31HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOZL8PI8ExX7vMMsxdx659O 7mqre+lldEh02y/7OYfTF/M6VBwUO8bwz672/u2NSW35VjOd/vpt+lXE3LJdfXGY6ZYFSV4r26r ecQIA
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
 include/linux/seq_buf.h   | 20 +++++++++++++++
 lib/tests/seq_buf_kunit.c | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 195e612a212a..4a2415fcb185 100644
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
index 8e879a4082ad..84caa552870b 100644
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
@@ -664,6 +716,7 @@ static void seq_buf_terminate_test(struct kunit *test)
 
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
+	KUNIT_CASE(seq_buf_init_append_test),
 	KUNIT_CASE(seq_buf_declare_test),
 	KUNIT_CASE(seq_buf_clear_test),
 	KUNIT_CASE(seq_buf_puts_test),
-- 
2.34.1

