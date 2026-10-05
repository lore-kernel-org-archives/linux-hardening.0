Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDC4CEE48;
	Mon,  5 Oct 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215842; cv=none; b=NKBj+frME5ywMmgaHWmc+UyVrBJi+ALY0bayvRDl/J9dV+gi9J4B4bLqbQULviq9i4M94UoBR7Tkzqkjjonsni68H3H6oeSJPvc0Lzb4Pn4d6yYC9RehQdCipBOEyZOh9n+17Bc6n/QuN8lxg3h4H5C0D07qkurnoL0Nkddxlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215842; c=relaxed/simple;
	bh=Fc4YPUymT7fzfMypmfysrvoMXIOU0vKJ/PytFjq1/dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeZqOgD2hGOHs1Qzd9eVxwb2yAj/YWb1FhqfOInxvnCAnbZ1zFqIu3XlCwhMWZ6xgaG6kJt3Zb/QjL2XyraRLtIi/PkeWZj/WbuvjlDbgmVBqrAakgCxQAHhU1bYBOZ0BVkJ1ETz3wQQaerO7XgEe3VIbSr72l5k/SaC25xtacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exco2V/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exco2V/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FF91F00899;
	Mon,  5 Oct 2026 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215839;
	bh=2iOJNj5LTyOJpP9+jn+s4cOp/LpOXOOTjS6VN88a9wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exco2V/OoEoB5MlcEMxMiAuk+qU2tEoGIG2Gn6PMuOJ7g9czYQkxQVDkRPobhTEJO
	 5hW7vrGewbpvaUb4WemZNPLBZqcCJwXLqfIv7UapP6XLl/qWTTaaqbgus/vP1dEPlu
	 Z5fi6gNAj+W0kJ91HUB/uwjH4dWyC3XW53CDx8wJzC+JR2hCyWELz79yF3ROBX6GCE
	 OFX2vishOGq/qpckdFp4GlO+XB81U/EmiW0V/7vohP+Vc4QFmghfawFCQJ4Ms4JxgH
	 EhoTskkSAb9KM1Ym4vseRMVMRxv5WZiV1htcW1sbJJcBv0cRQac17el67Q255+GMGB
	 orKv+jbyZzAsg==
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
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 12/12] docs: core-api: Document the seq_buf API
Date: Mon,  5 Oct 2026 08:57:02 -0700
Message-ID: <20261005155708.1471260-12-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005155653.late.426-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3434; i=kees@kernel.org; h=from:subject; bh=Fc4YPUymT7fzfMypmfysrvoMXIOU0vKJ/PytFjq1/dI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHT5wzNS7I/nbEYGv47mjH0t6tr0yVRXW/3dzw7+VTu +JJ9zZyd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzkhjHD/9RpsdnPPNd9d7R3 vji9QqA5eLp2RsrrsrNxWQFNC2d0ajMytGfNv9n4wyr/hf3tuwWrc56YrD9ZZHtRWmDin/ceUmK yLAA=
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
index be979089228f..f006f2654e4c 100644
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
index 8da2e9447adf..54b76044e4ba 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -409,12 +409,13 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
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
2.55.0

