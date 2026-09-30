Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266A4D09FE;
	Wed, 30 Sep 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812376; cv=none; b=t7bNnTOG86dfoj34BWWbQxpewu29PothGARDbt6CWULr34EhhfbVq95zjVCHlhvz2Mg978co0KlwxzZPGZdLkt6tLD4eSOOf1jgUwIA4lDUkslDVpvm93k/hWvzgEStrMIbsEWTT83F9OHL6nYDoDDzGjz/b5+267Jc+rHP9IVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812376; c=relaxed/simple;
	bh=+GwO+pBIKllSMwvQZVwmQPKe7afr4m7cANaRSyN5wEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzg4qUKBn1cvnNo/MyW8+EYtqPLKk1dymzojJa8ODALz45yKRHRSG1WpxKxSbXMkakdDUX4q/4b7YnzI6toKD53sJfXfDJqvu09RV4Kn/R8bCe3cgMLJ3d2M9TFDBmY67R5Mpaj9KmoCTBM/BpL9YXxW8xz4o262bWBF4Lyv54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htD5/eU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htD5/eU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D141F008A3;
	Wed, 30 Sep 2026 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812371;
	bh=qp0DM2K5qB6jeNajxybOIO/j4x8jRXa5tsku/7529BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htD5/eU1n3iqTe8bA0qZ4Vsp//1zTHTl80DFujYJS4QZd03JGtGsAmJyn0fQyI3ys
	 KODWf7S5cDk1spjapE6UCFnvoUB32QTasTFtAsms9twmHZzlWhH50EuJchmyKEr+Rv
	 FtrHIHCY7WVWGAEM/EjtJof/FbPbnc3icJ1SDiiqJZw/AXmULMpQTi4fnTwREgZkJF
	 XMXBD5zwbTbqp28kisXJMp72L27edx0fTxUlfDqaFEwhuluEpaNXP1ikxICy4ubLa3
	 9vb63/0ZVgFm/d0r/5s0k6tb8uUzKST0rX8Oz7tNSUs2XwkV/F7p5YNpX1whdDxdqo
	 jhH+Xke7oY5Bw==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 11/11] docs: core-api: Document the seq_buf API
Date: Wed, 30 Sep 2026 16:52:39 -0700
Message-Id: <20260930235247.157921-11-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3434; i=kees@kernel.org; h=from:subject; bh=+GwO+pBIKllSMwvQZVwmQPKe7afr4m7cANaRSyN5wEM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7Fxyf1rOpK/CJ2+w3Z45r6MnYz79zMzzsz7HbwZO+n JAw9ss901HKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRwtMM/3Qlb1t3/ikUPhPD J+BcFOvR2B4qGST3S03Zx3CzwCWDzUAVfuz2O2sfi3QKbPE79chEOfzcsj0Sm+sK2JZ95VV5rs0 KAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The kernel-doc in include/linux/seq_buf.h and lib/seq_buf.c documents
the seq_buf interface, but no .rst file pulls either of them in, so none
of it reaches the generated documentation.

Add the missing kernel-doc for seq_buf_clear() and seq_buf_init(), and a
Sequence Buffers section to the kernel API documentation. The static
internal helper seq_buf_can_fit() is left out. Additionally fix
seq_buf_hex_dump() indentation to avoid the reported Sphinx error:

  ERROR: Unexpected indentation.
  WARNING: Block quote ends without a blank line; unexpected unindent.

Verified with "make SPHINXDIRS=core-api htmldocs", which rendered
happily into core-api/kernel-api.html.

Assisted-by: LLM
Co-developed-by: Bill Wendling <morbo@google.com>
Signed-off-by: Bill Wendling <morbo@google.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 Documentation/core-api/kernel-api.rst |  9 +++++++++
 include/linux/seq_buf.h               | 12 ++++++++++++
 lib/seq_buf.c                         | 13 +++++++------
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 4c4a57c1c094..f5a0aedbbb48 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -96,6 +96,15 @@ Error Pointers
 .. kernel-doc:: include/linux/err.h
    :internal:
 
+Sequence Buffers
+----------------
+
+.. kernel-doc:: include/linux/seq_buf.h
+   :internal:
+
+.. kernel-doc:: lib/seq_buf.c
+   :no-identifiers: seq_buf_can_fit
+
 Sorting
 -------
 
diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 4a2415fcb185..45fbde43e3b7 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -31,6 +31,10 @@ struct seq_buf {
 		.size = SIZE,				\
 	}
 
+/**
+ * seq_buf_clear - reset the seq_buf to be read / appended from the beginning
+ * @s: the seq_buf handle
+ */
 static inline void seq_buf_clear(struct seq_buf *s)
 {
 	s->len = 0;
@@ -38,6 +42,14 @@ static inline void seq_buf_clear(struct seq_buf *s)
 		s->buffer[0] = '\0';
 }
 
+/**
+ * seq_buf_init - initialize a seq_buf
+ * @s: the seq_buf handle
+ * @buf: pointer to the buffer
+ * @size: total size of @buf
+ *
+ * The contents of the buffer are ignored.
+ */
 static inline void
 seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
 {
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 7e3bf837da01..1c86eae9e188 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -407,12 +407,13 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
  *
  * Function is an analogue of print_hex_dump() and thus has similar interface.
  *
- * linebuf size is maximal length for one line.
- * 32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
- *	separating space
- * 2 - spaces separating hex dump and ASCII representation
- * 32 - ASCII representation
- * 1 - terminating '\0'
+ * linebuf size is maximal length for one line::
+ *
+ *	32 * 3 - maximum bytes per line, each printed into 2 chars + 1 for
+ *		 separating space
+ *	2 - spaces separating hex dump and ASCII representation
+ *	32 - ASCII representation
+ *	1 - terminating '\0'
  *
  * Returns: zero on success, -1 on overflow.
  */
-- 
2.34.1

