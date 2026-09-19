Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F022FB0B2;
	Sat, 19 Sep 2026 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777643; cv=none; b=E6JuAnUUtMSyZ0a2lTCn/YW9UG4ez5UOMcYljweBL6+hMVGaLrk0Ub/0qxGmx1Tvo8QTe+KHiq3WhWm2M9Z81XKf4rdlTfPtN3bRm2KkNzcoz0KbfFUwsHN5vvK7B7+RUrYuasI/08Jq/iUMlrfvjcet+sHBCXkWYuxSx39iQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777643; c=relaxed/simple;
	bh=Ffmeyw/SPMfMbYv80UoW0wOQOLJ9Q4s9W1oHBGqZKKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZLghqbxolvVagGQrHkvF8IOTfYTs7ftnMz3/MYPO3gfOPxReMZIqAx7ywysGi/vfZ23GxXEypc1/GAWExRzZ5NBtsJd4XfpXr7XnMxYWtt85RDXmQS0GI804ZJoPTauIBQ61p5BDeVELDthvSGif+iPVsJDE82vXHcTyiu3K54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeiHRseJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeiHRseJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA701F008A2;
	Sat, 19 Sep 2026 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777634;
	bh=9FN4BkBagpzfC5hM9xQO15OCTyyaEJmLpO1l+R0PMG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CeiHRseJ3Hg+/q60unvAYvL88rbAkTOPtytt8zoVERR+CXgOvC3sgx0DImlDYUaMt
	 H/CTMcnM0unYqTBBIobNOFGRT5Qiv5p4zNtcJPxTIGRSa/RrCVCfw44wD5ahEaNmjm
	 zQY8y17Vr6stjgpmwxtrpHo/oON/Tobafy1QJJAW2bu/qUcLS5g4X1rPInbUWYnsyA
	 G2rEF/Y0HSbtiVDomPgJKW9VRlsTuBi4IISiLIz5W1E1IQfB4O+cbSfINbeVAOtMcz
	 UWes5SOMbwJMb5X0DjBKMwQFZ2Ux7vqhG+eRO/BSoNynF+C8wdt2byFXimE+F2Tb8y
	 29IOU+k3pk5SA==
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
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 9/9] docs: core-api: Document the seq_buf API
Date: Fri, 18 Sep 2026 17:27:07 -0700
Message-Id: <20260919002714.4060307-9-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919002658.stay.929-kees@kernel.org>
References: <20260919002658.stay.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3731; i=kees@kernel.org; h=from:subject; bh=Ffmeyw/SPMfMbYv80UoW0wOQOLJ9Q4s9W1oHBGqZKKE=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrr9169+lsv3fss/zGzomWD2/3uJv0F0/da7PYvZjRm WVefLtARykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwET+OzL89/QzvpU2IYL/BvvU gvcqTZH7WzLeNC7aITLtRbllvx4XLyPDMp/F/d3iyaqJUu6VhbmPf3bYh9twhHeHbdqr/b/7xgc OAA==
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
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: <linux-doc@vger.kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
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
index 89d847d40626..416a8b67b9ad 100644
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

