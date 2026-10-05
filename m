Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2E4CDA31;
	Mon,  5 Oct 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215840; cv=none; b=qo4XFY1TPfFK8T2wwXXWAFc+XFVbSeLDQNKbFrYURVdD71plOUk333N5hulwv0qgWZipn+AoUhID9OtDvpdOjdzy8zVNLCcTzDogv47dfSWdGSlW17y4xbGVcLcHz8ZvnMH7CgRi0aRMpzsxERieT+42wJwGukMtzjGpMoDVvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215840; c=relaxed/simple;
	bh=YwLsahYsWmNqs1L95eBiszrnF63XntsXCJ+kXs/pvFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GF9vlO1seakyn0tcg5lrjV2BltGK2K9r7uCBx2DZLSaTp+1BTVpb+EtfSoxLyg02o2GgfeGmHk/4nlEaz7pxJQzVkKgZsCoe+9KJH70Ro2UIwU946wljXQok9RR7P+eXX0Jo4G0dfPITJlNmG6pVhpJFBlzvWrU6/wFI2PxbyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaiFQ7rQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaiFQ7rQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90B31F0089C;
	Mon,  5 Oct 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215838;
	bh=2BClMQyem5CdSIr7g/P3Vp0jZz3cQr1lWPykyLpyvXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JaiFQ7rQAmpi8Pcr/8S4eJYpWz4WPyiq99ErWFPxs8/hsVy9U/86Kfi2+dHmTJ7pK
	 AFH7j++3BPwx2omiqNkHFT/MukGp7gaoE8DbAVMi/Ggaqwd5U4+AXCfHZxv3k+/qxS
	 8s/jykQvjQ3pV1IzNL1igGAfu/gj1FBR1jiZltYkjUM84GiM8A5YH73WgdZWt0G06a
	 0F1Gyb6J/2lxyF1/JfO74qN6ltuRRYgOIQ+L1f1+ZntP0yY2vlbtoInmhjs6Ntvfjr
	 l2xikNP1tUitBNgFITIObHztKDba3Mge7SXaQTCNEbDCEZJC0rY1xNmanLOHL3G9pX
	 zShN8NIX+p9ZA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <david@davidgow.net>,
	Jiri Kosina <jikos@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 05/12] seq_buf: Clear what a writer did not claim when a seq_buf overflows
Date: Mon,  5 Oct 2026 08:56:55 -0700
Message-ID: <20261005155708.1471260-5-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005155653.late.426-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5989; i=kees@kernel.org; h=from:subject; bh=YwLsahYsWmNqs1L95eBiszrnF63XntsXCJ+kXs/pvFM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHT5yuOqZaqbr0g3Sy8KVE019dMxO4rrWF+sos5H6x7 taTPx/5OkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACaScZiR4UlTEOupN1Pm9t/3 nX51yRWZFxM+f/JoP5WbEN8bxO9eGcTwz1zNUvW65SKR75V1r7sCZ5ZvYz/COSlY3ixW9cnBXSu EWQE=
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

seq_buf_path() was not exported, so the test failed to link as a
module. Export it.

Tests passed under qemu on ARCH=x86_64 with GCC 16.2.0 and CONFIG_KASAN=y,
and on big-endian ARCH=s390 with GCC s390x-linux-gnu 16.2.0, and the
test builds as a module (CONFIG_SEQ_BUF_KUNIT_TEST=m).

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/seq_buf.h   |  8 +++++--
 lib/seq_buf.c             |  5 +++++
 lib/tests/seq_buf_kunit.c | 44 +++++++++++++++++++++++++++++++++++++++
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
index 60e9eadb3ef7..8da2e9447adf 100644
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
@@ -343,6 +347,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(seq_buf_path);
 
 /**
  * seq_buf_to_user - copy the sequence buffer to user space
diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
index 046614100c77..5eaf024fa3a5 100644
--- a/lib/tests/seq_buf_kunit.c
+++ b/lib/tests/seq_buf_kunit.c
@@ -7,7 +7,9 @@
 
 #include <kunit/test.h>
 #include <linux/console.h>
+#include <linux/fs.h>
 #include <linux/seq_buf.h>
+#include <linux/shmem_fs.h>
 #include <linux/string.h>
 
 static void seq_buf_init_test(struct kunit *test)
@@ -466,6 +468,47 @@ static void seq_buf_do_printk_test(struct kunit *test)
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
@@ -482,6 +525,7 @@ static struct kunit_case seq_buf_test_cases[] = {
 	KUNIT_CASE(seq_buf_puts_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_partial_overflow_test),
 	KUNIT_CASE(seq_buf_putmem_hex_partial_overflow_test),
+	KUNIT_CASE(seq_buf_path_overflow_test),
 	KUNIT_CASE(seq_buf_do_printk_test),
 	{}
 };
-- 
2.55.0

