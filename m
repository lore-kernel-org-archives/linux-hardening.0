Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2A1A08C5;
	Thu,  6 Feb 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738869423; cv=none; b=e2Q4i0IcdLnndTm5Th4pIu5+CUA4AqeBZ1q8yh8G/BDPr1PDAkPMJMfhIPgTrUSo158ykKuTphfZPyJu1qwkR6V23SzRRu08zO830UdySta1ngScHwH7M4tp168gALWD66VUDboBD+R9JZxGnTYHqtp+jS0IiQYmKE0zfKHKng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738869423; c=relaxed/simple;
	bh=GdQnHoyLthlfKrlMEi6nzpGqWRjNbuL5NJ7PhAbGqhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+422ZEtNzX6DU6E76vJ6u271OYGoPeMEFDxNDzmzFLkIZlJP8jw/K7AXm02wU7S+kcw3XCCDQDK7+5nZrMIfZxTp3HKwY5bArszqWsMoSz2Z+ZcXvdhO4bChBgQj8uo+QYINq5wFJdvqFcLajU7/Xa/SdqxxYdoI+i/YrPIqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb2WXjwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb2WXjwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8522C4CEDD;
	Thu,  6 Feb 2025 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738869422;
	bh=GdQnHoyLthlfKrlMEi6nzpGqWRjNbuL5NJ7PhAbGqhY=;
	h=From:To:Cc:Subject:Date:From;
	b=rb2WXjwqOldsyzOMUFT36EIf4r7j2kZDMeywaA0Roe+9GNIq17srbrpMF9vjCJASF
	 BK5/qLDcNfSaqAE5cpIp1TdHZ20CWDpgLAWmcHbbs+C0LRjO0KQckNmSGvUxtdwF+1
	 NyDPH8x8kJWZYFCCsdEx3/aD1IAkXZvQ/YMHmpAEdOGtUfLimCL+pY0JiM1tqNJivP
	 pqVEKa82i1i5wGaIe4U7M/mnzQ/PPYLab4Ozh8TWSJhcwph0o73l7xIJTlquDc8qpg
	 27mss/p/PZGlsGHdemB95viltUiu/2C2VxVu1rOw7hgFl1sRZbzEmz7MFE+LH435kE
	 e+enZ/4BnZlUg==
From: Kees Cook <kees@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: Change kmsg_bytes storage size to u32
Date: Thu,  6 Feb 2025 11:16:59 -0800
Message-Id: <20250206191655.work.798-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3509; i=kees@kernel.org; h=from:subject:message-id; bh=GdQnHoyLthlfKrlMEi6nzpGqWRjNbuL5NJ7PhAbGqhY=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlLuVa75wXcCJqRvHlF9YI4kapPi9b9d9q0uIgvarnBC YMZPi4aHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNxusHwV3zDh1efiubItmnE TS8XEp7WtCfO9+StV4cyXvgU6S20z2JkaMh6+fGVZCp//bnnH1hPyHr/bKle9XuCtLLAh5vXOE8 /4AYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The types around kmsg_bytes were inconsistent. The global was unsigned
long, the argument to pstore_set_kmsg_bytes() was int, and the filesystem
option was u32. Given other internal limits, there's not much sense
in making a single pstore record larger than INT_MAX and it can't be
negative, so use u32 everywhere. Additionally, use READ/WRITE_ONCE and a
local variable in pstore_dump() to avoid kmsg_bytes changing during a
dump.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Eric Sandeen <sandeen@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org
---
 fs/pstore/inode.c    |  2 +-
 fs/pstore/internal.h |  4 ++--
 fs/pstore/platform.c | 11 ++++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 56815799ce79..9de6b280c4f4 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -265,7 +265,7 @@ static void parse_options(char *options)
 static int pstore_show_options(struct seq_file *m, struct dentry *root)
 {
 	if (kmsg_bytes != CONFIG_PSTORE_DEFAULT_KMSG_BYTES)
-		seq_printf(m, ",kmsg_bytes=%lu", kmsg_bytes);
+		seq_printf(m, ",kmsg_bytes=%u", kmsg_bytes);
 	return 0;
 }
 
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 801d6c0b170c..a0fc51196910 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -6,7 +6,7 @@
 #include <linux/time.h>
 #include <linux/pstore.h>
 
-extern unsigned long kmsg_bytes;
+extern unsigned int kmsg_bytes;
 
 #ifdef CONFIG_PSTORE_FTRACE
 extern void pstore_register_ftrace(void);
@@ -35,7 +35,7 @@ static inline void pstore_unregister_pmsg(void) {}
 
 extern struct pstore_info *psinfo;
 
-extern void	pstore_set_kmsg_bytes(int);
+extern void	pstore_set_kmsg_bytes(unsigned int bytes);
 extern void	pstore_get_records(int);
 extern void	pstore_get_backend_records(struct pstore_info *psi,
 					   struct dentry *root, int quiet);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index f56b066ab80c..557cf9d40177 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -92,8 +92,8 @@ module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "compression to use");
 
 /* How much of the kernel log to snapshot */
-unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
-module_param(kmsg_bytes, ulong, 0444);
+unsigned int kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
+module_param(kmsg_bytes, uint, 0444);
 MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 
 static void *compress_workspace;
@@ -107,9 +107,9 @@ static void *compress_workspace;
 static char *big_oops_buf;
 static size_t max_compressed_size;
 
-void pstore_set_kmsg_bytes(int bytes)
+void pstore_set_kmsg_bytes(unsigned int bytes)
 {
-	kmsg_bytes = bytes;
+	WRITE_ONCE(kmsg_bytes, bytes);
 }
 
 /* Tag each group of saved records with a sequence number */
@@ -278,6 +278,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 			struct kmsg_dump_detail *detail)
 {
 	struct kmsg_dump_iter iter;
+	unsigned int	remaining = READ_ONCE(kmsg_bytes);
 	unsigned long	total = 0;
 	const char	*why;
 	unsigned int	part = 1;
@@ -300,7 +301,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	kmsg_dump_rewind(&iter);
 
 	oopscount++;
-	while (total < kmsg_bytes) {
+	while (total < remaining) {
 		char *dst;
 		size_t dst_size;
 		int header_size;
-- 
2.34.1

