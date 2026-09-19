Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A502BEC52;
	Sat, 19 Sep 2026 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777639; cv=none; b=We9i1FcLbTk2T6ac+6iVULyCIgylxRrfap/uevQu+9pEYR3zJ06PC5FWq064AAtgjx0uzCol833SDhCNkY2i507EMFyXcrQPokXjjk5halznQVl+JEI+dVAEoW23WCQEPBvqXIuC8OlpzLLJ9IgEYwZcoBtY+rFQYDGbt72zrXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777639; c=relaxed/simple;
	bh=lP3YhXtwooEdkZJ58qzwIIDJ3xb1I/f2TrN/HlOVr44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5YDwhtxW/1JTs67b16OQchsgZ5fsqhn2hIWY+Dv/FCXkkvxQE6pQ+4a2OUczVKYQWJeMXZg56SxtSS2xDMHIVGLVCjRS6niB1sFW4HFMz49jHdT2D/t6lLyDBuc6K43NRX3cdzP/DMr7ZStqfXyXYNDtzu6UKqKmezo7YeCUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfUm/5uT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfUm/5uT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9006E1F0089B;
	Sat, 19 Sep 2026 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777634;
	bh=OpVR3zREuIGoT8snYnyTYbBAZywT2YlMcq79Rbv9Za4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EfUm/5uTSrP9dKhUju6qj7MwdQtJvKpKQ6+LULwxB/B6yNicSHSAJpNQ3KaSVMaga
	 UtuCzUhcllR45gNREprc9vFwOrksAHvRDW8oRIfjr0IahFck3+7XaUUCo40kUo6Vvu
	 Ervm4zuLUD8XOI7TrwuqbTRmosWDGmdEGUKEl3eSLFnEfW2Wg+uGCxAwFUmyOrzfOx
	 Q0953zgHDY+Fu2wBBKN8MHO08B359BIXo8fP46HVQKPGeEjK7KfC2StshFvatH1Pza
	 JWsh2i6yT+nCzoK9EBbNcuQrCyvBgGVrPew2jZySLw0jRcxFMvDoNJwJdH7T2n6SJw
	 ZDQ3ykQNJVltQ==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>,
	Jiri Kosina <jikos@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 4/9] seq_buf: Clear what a writer did not claim when a seq_buf overflows
Date: Fri, 18 Sep 2026 17:27:02 -0700
Message-Id: <20260919002714.4060307-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919002658.stay.929-kees@kernel.org>
References: <20260919002658.stay.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5946; i=kees@kernel.org; h=from:subject; bh=lP3YhXtwooEdkZJ58qzwIIDJ3xb1I/f2TrN/HlOVr44=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrr93sDP1mo8UQ++R/xtTXph5T4t1m1FyJkH1ZIBfsU LHoxvQ7HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPpNGP4w69ew7yg+pO4+815 R/6l7drW9Lb0kCbP9Ltmf3PEzDPZ3zL8lT0+5Z186C237VELcqefWbP/2ZIS7tfijeXOR6f3rLr xjgUA
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <david@davidgow.net>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/seq_buf.h   |  8 +++++--
 lib/seq_buf.c             |  4 ++++
 lib/tests/seq_buf_kunit.c | 45 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

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
index 00abdec8760e..7e3bf837da01 100644
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
index e0057eaeeb36..852eb645e253 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -6,6 +6,9 @@
  */
 
 #include <kunit/test.h>
+#include <linux/fs.h>
+#include <linux/seq_buf.h>
+#include <linux/shmem_fs.h>
 #include <linux/console.h>
 #include <linux/seq_buf.h>
 #include <linux/string.h>
@@ -466,6 +469,47 @@ static void seq_buf_do_printk_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, seq_buf_printk_empty, 0);
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
@@ -482,6 +526,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_puts_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_hex_partial_overflow_test),
+	KUNIT_CASE(seq_buf_path_overflow_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.34.1

