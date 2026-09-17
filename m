Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C013148DD
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604615; cv=none; b=GaFO6irCGANpQMm9ql5RzHhqiogz+erwB3P7vOSYIv0nN8DyK+21Kh3u54pt0IsmPMG4lNWx1IM/ov/3yWW8twsuqxy2yp3shwEFJMLBs4OjxwxGiFR+u5dJzjZuvUD0JMyNm7e0fcIux+MVUoBv4tPMAZZFTrxoHzGMuj7N/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604615; c=relaxed/simple;
	bh=+66no1vujxWVEQyS0MPjPa+xpYhOZUHD4I2Bv9g8zHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dzeehrpgu6yBdOSo9rQ97tQsbLsTZqP4K25/fo6pAScqYo+86L53gwBO5JiCnJ9JnlgMWpT8qj4A+Pn0EBmMZ1SFpRdCU5j0KA1q46pTNzckZyjVRglT3FaOBsUe3Ot3Ql8kAOWj+KDAwN6mno/B7SLqskVH3j4TXC9pk33As1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/PhwKcf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/PhwKcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579301F000FF;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604613;
	bh=s7aza80qwPkK1dvotiYmlmcM9klvPSGykLSgadTQ7Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/PhwKcfEVQfhpYavh4SJqkQdB3dk8uOL/t89MWnLw6uUhjHoWNrXtbnDLQFdoWaz
	 Y4KwMSFKhUwPUceAOQ+JHAhEDHmK9QkiGh/2W8IKbPOknZCSDzoxgu5WckV68Hg7cr
	 YwfamRlBx0VUSFiDwWBgHgL4xiGzk1vyE7f0qXxslIF+1dCbS3QPO2TZ08XAh1ybXu
	 Nd5/h6kjiFlz8aVPxdv6eBY1SLO23DUbfN2mZt/9FSb8sjU2GcT+XPxRQR2A+4n1eV
	 TRyffey4Y7jCWWcaGDmPA68wPol8V3wSEZV9J/eWpNiOQpN2P6h47Qnkdt/cB8L4JT
	 JOVFUKX78BjtA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	David Gow <david@davidgow.net>,
	Jiri Kosina <jikos@kernel.org>,
	Petr Mladek <pmladek@suse.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/7] seq_buf: Clear what a writer did not claim when a seq_buf overflows
Date: Wed, 16 Sep 2026 17:23:15 -0700
Message-Id: <20260917002333.2306346-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917002312.i.923-kees@kernel.org>
References: <20260917002312.i.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5725; i=kees@kernel.org; h=from:subject; bh=+66no1vujxWVEQyS0MPjPa+xpYhOZUHD4I2Bv9g8zHw=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmrjb5OmRVavXdd+9+OCXW7n6wyWmJlWhTaWsLgxxW+M +zHTwfWjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkEvWNkuDL7kKnEa6ars5Uz LlldmOr1cL1f59cQceWD1ptlWiZ48jD8ZtHjYf5xitdteszh/CaNouUbvFyEdlVu7HxkH3T/t8g aBgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using seq_buf_set_overflow() would leave the bytes between "len"
and "size" untouched, so if seq_buf_str() is used on an overflowed
seq_buf, those bytes may be exposed. For any paths that don't claim
partially written bytes, by setting "len = size" before calling
seq_buf_set_overflow(), wipe the unclaimed bytes. The seq_buf_puts()
and related APIs already claim those bytes now, so only the unclaimed
cases remain. A specific example of this was seq_buf_path() which uses
d_path() and would write to the tail before discovering it was out
of space, and would correctly mark a seq_buf as overflowed, but the
path fragment would be left over.

Clear from len to the end of the buffer in seq_buf_set_overflow(), which
every overflow goes through, including seq_buf_commit() with a negative
count.

Add a test that fills a seq_buf, leaves it too little room for a path, and
checks that nothing of the path is left in the buffer. The tests run before
anything writable is mounted, so it takes its file from shmem.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.1.0.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: David Gow <david@davidgow.net>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Petr Mladek <pmladek@suse.cz>
---
 include/linux/seq_buf.h   |  8 +++++--
 lib/seq_buf.c             |  4 ++++
 lib/tests/seq_buf_kunit.c | 44 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 77e76e283370..0c0a0db04b09 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -5,6 +5,7 @@
 #include <linux/bug.h>
 #include <linux/minmax.h>
 #include <linux/seq_file.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 /*
@@ -58,12 +59,15 @@ seq_buf_has_overflowed(struct seq_buf *s)
 /*
  * Mark @s as overflowed, which discards the length of what it holds. The
  * bytes up to its last one are the string from then on, as that is where
- * seq_buf_str() terminates it, so a caller that could not fill the buffer
- * has to NUL them itself before calling this.
+ * seq_buf_str() terminates it, so clear whatever was not written: a writer
+ * sets len to how much it filled, and anything past that was never adopted.
  */
 static inline void
 seq_buf_set_overflow(struct seq_buf *s)
 {
+	if (s->len < s->size)
+		memset(s->buffer + s->len, 0, s->size - s->len);
+
 	s->len = s->size + 1;
 }
 
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 4d67fe25e916..65806d5e4bb4 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -76,6 +76,8 @@ int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
 			s->len += len;
 			return 0;
 		}
+		/* vsnprintf() wrote as much as fits, so none of it is stale */
+		s->len = s->size;
 	}
 	seq_buf_set_overflow(s);
 	return -1;
@@ -164,6 +166,8 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
 			s->len += ret;
 			return 0;
 		}
+		/* bstr_printf() wrote as much as fits, so none of it is stale */
+		s->len = s->size;
 	}
 	seq_buf_set_overflow(s);
 	return -1;
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 3f3b076dd6fa..94fe928d537e 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -6,7 +6,9 @@
  */
 
 #include <kunit/test.h>
+#include <linux/fs.h>
 #include <linux/seq_buf.h>
+#include <linux/shmem_fs.h>
 
 static void seq_buf_init_test(struct kunit *test)
 {
@@ -298,6 +300,47 @@ static void seq_buf_putmem_hex_partial_overflow_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
 }
 
+/* Long enough that it cannot fit in the room the test leaves for it. */
+#define SEQ_BUF_TEST_PATH	"/seq_buf_kunit_path_name"
+
+static void seq_buf_path_overflow_test(struct kunit *test)
+{
+	DECLARE_SEQ_BUF(s, 32);
+	const char *expected = "keep:xxxxxxxxxxxxxxxxxxxxxxx";
+	struct file *file;
+	size_t len;
+	int i;
+
+	/*
+	 * The tests run before anything writable is mounted, so take the file
+	 * whose path gets printed from shmem, which needs no mount of its own.
+	 */
+	file = shmem_file_setup(SEQ_BUF_TEST_PATH, 0, EMPTY_VMA_FLAGS);
+	if (IS_ERR(file))
+		kunit_skip(test, "cannot create a file to print the path of");
+
+	/* Leave less room than the path needs, so d_path() cannot fit it. */
+	seq_buf_puts(&s, "keep:");
+	len = seq_buf_used(&s);
+	for (i = len; i < 28; i++)
+		seq_buf_putc(&s, 'x');
+
+	KUNIT_EXPECT_EQ(test, seq_buf_path(&s, &file->f_path, "\n"), -1);
+	fput(file);
+
+	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
+
+	/*
+	 * d_path() keeps as much of the path as fits when it does not fit
+	 * whole, and seq_buf_str() would hand out that fragment, as it ends
+	 * the string at the last byte of an overflowed buffer.
+	 */
+	for (i = 28; i < 32; i++)
+		KUNIT_EXPECT_EQ_MSG(test, s.buffer[i], '\0',
+				    "byte %d past the data is not cleared", i);
+	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), expected);
+}
+
 static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_init_test),
 	KUNIT_CASE(seq_buf_declare_test),
@@ -313,6 +356,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_putmem_hex_overflow_test),
 	KUNIT_CASE(seq_buf_puts_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_hex_partial_overflow_test),
+	KUNIT_CASE(seq_buf_path_overflow_test),
 	{}
 };
 
-- 
2.34.1

