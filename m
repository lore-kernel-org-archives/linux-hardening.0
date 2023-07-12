Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD633EB64DD
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jul 2023 16:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGLQYn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjGLQYJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Jul 2023 12:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E010FEA
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 09:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B146184D
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 16:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA53C433CA;
        Wed, 12 Jul 2023 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689179023;
        bh=0FoLjOK9ay+RimOH18pZRKzoagXi51u3EZAb+Kotzhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i92mZ7K3SpYFgBL17seuzZktcGzZs79vjKZD9Miu91O7JK8Tanij3LpwgWqISn6nP
         HB37T8TtKZHJsSrzjer8FwgnIx3tgMhiqr080sNjGNBBfoSALOsyVqKn35wVFxI1QO
         jxsbiPWdLFr/TbniQqKuH7ZTuse2wfuJi4frZL/dekyR5Hh6uhRg4cem6UQ5un4hqz
         AGNFSj221tYYcGVcoeztPNORv7foieXp5kX3EpObRznLxO0Owo+DWlCzVzyMLXN4Q0
         BbGup+v/npGLSHiXlU0OnBsnBxLcMEbUkrZRyxUpl9x/vot6RtIXJ6rbKE/gZgghKK
         lI1jOYbE/N5fw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 2/2] pstore: Replace crypto API compression with zlib_deflate library calls
Date:   Wed, 12 Jul 2023 18:23:32 +0200
Message-Id: <20230712162332.2670437-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712162332.2670437-1-ardb@kernel.org>
References: <20230712162332.2670437-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13579; i=ardb@kernel.org; h=from:subject; bh=0FoLjOK9ay+RimOH18pZRKzoagXi51u3EZAb+Kotzhc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWXd5eaNJS6zX2f8OHP7odO3iT0N6U3tspUbxOZp35fa7 zDr3EHjjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRpwGMDBu16mZ8sw0xD3NL urNA49GkZrtmaUZ5hpmnkk4XSP47cJjhv+PJWyKJXF6bJ/fEtbY9V2fZZjBDZKre4553jcICCzS qOQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Pstore supports compression using a variety of algorithms exposed by the
crypto API. This uses the deprecated comp (as opposed to scomp/acomp)
API, and so we should stop using that, and either move to the new API,
or switch to a different approach entirely.

Given that we only compress ASCII text in pstore, and considering that
this happens when the system is likely to be in an unstable state, the
flexibility that the complex crypto API provides does not outweigh its
impact on the risk that we might encounter additional problems when
trying to commit the kernel log contents to the pstore backend.

So let's switch [back] to the zlib deflate library API, and remove all
the complexity that really has no place in a low-level diagnostic
facility. Note that, while more modern compression algorithms have been
added to the kernel in recent years, the code size of zlib deflate is
substantially smaller than, e.g., zstd, while its performance in terms
of compression ratio is comparable for ASCII text, and speed is deemed
irrelevant in this context.

Note that this means that compressed pstore records may no longer be
accessible after a kernel upgrade, but this has never been part of the
contract. (The choice of compression algorithm is not stored in the
pstore records either)

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/pstore/Kconfig    | 100 ++------------
 fs/pstore/platform.c | 136 +++++++++++++-------
 2 files changed, 97 insertions(+), 139 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index c49d554cc9ae9f80..3acc38600cd1a2d0 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config PSTORE
 	tristate "Persistent store support"
-	select CRYPTO if PSTORE_COMPRESS
 	default n
 	help
 	   This option enables generic access to platform level
@@ -22,99 +21,18 @@ config PSTORE_DEFAULT_KMSG_BYTES
 	  Defines default size of pstore kernel log storage.
 	  Can be enlarged if needed, not recommended to shrink it.
 
-config PSTORE_DEFLATE_COMPRESS
-	tristate "DEFLATE (ZLIB) compression"
-	default y
-	depends on PSTORE
-	select CRYPTO_DEFLATE
-	help
-	  This option enables DEFLATE (also known as ZLIB) compression
-	  algorithm support.
-
-config PSTORE_LZO_COMPRESS
-	tristate "LZO compression"
-	depends on PSTORE
-	select CRYPTO_LZO
-	help
-	  This option enables LZO compression algorithm support.
-
-config PSTORE_LZ4_COMPRESS
-	tristate "LZ4 compression"
-	depends on PSTORE
-	select CRYPTO_LZ4
-	help
-	  This option enables LZ4 compression algorithm support.
-
-config PSTORE_LZ4HC_COMPRESS
-	tristate "LZ4HC compression"
-	depends on PSTORE
-	select CRYPTO_LZ4HC
-	help
-	  This option enables LZ4HC (high compression) mode algorithm.
-
-config PSTORE_842_COMPRESS
-	bool "842 compression"
-	depends on PSTORE
-	select CRYPTO_842
-	help
-	  This option enables 842 compression algorithm support.
-
-config PSTORE_ZSTD_COMPRESS
-	bool "zstd compression"
-	depends on PSTORE
-	select CRYPTO_ZSTD
-	help
-	  This option enables zstd compression algorithm support.
-
 config PSTORE_COMPRESS
-	def_bool y
+	bool "Pstore compression (deflate)"
 	depends on PSTORE
-	depends on PSTORE_DEFLATE_COMPRESS || PSTORE_LZO_COMPRESS ||	\
-		   PSTORE_LZ4_COMPRESS || PSTORE_LZ4HC_COMPRESS ||	\
-		   PSTORE_842_COMPRESS || PSTORE_ZSTD_COMPRESS
-
-choice
-	prompt "Default pstore compression algorithm"
-	depends on PSTORE_COMPRESS
+	select ZLIB_INFLATE
+	select ZLIB_DEFLATE
+	default y
 	help
-	  This option chooses the default active compression algorithm.
-	  This change be changed at boot with "pstore.compress=..." on
-	  the kernel command line.
-
-	  Currently, pstore has support for 6 compression algorithms:
-	  deflate, lzo, lz4, lz4hc, 842 and zstd.
-
-	  The default compression algorithm is deflate.
-
-	config PSTORE_DEFLATE_COMPRESS_DEFAULT
-		bool "deflate" if PSTORE_DEFLATE_COMPRESS
-
-	config PSTORE_LZO_COMPRESS_DEFAULT
-		bool "lzo" if PSTORE_LZO_COMPRESS
-
-	config PSTORE_LZ4_COMPRESS_DEFAULT
-		bool "lz4" if PSTORE_LZ4_COMPRESS
-
-	config PSTORE_LZ4HC_COMPRESS_DEFAULT
-		bool "lz4hc" if PSTORE_LZ4HC_COMPRESS
-
-	config PSTORE_842_COMPRESS_DEFAULT
-		bool "842" if PSTORE_842_COMPRESS
-
-	config PSTORE_ZSTD_COMPRESS_DEFAULT
-		bool "zstd" if PSTORE_ZSTD_COMPRESS
-
-endchoice
-
-config PSTORE_COMPRESS_DEFAULT
-	string
-	depends on PSTORE_COMPRESS
-	default "deflate" if PSTORE_DEFLATE_COMPRESS_DEFAULT
-	default "lzo" if PSTORE_LZO_COMPRESS_DEFAULT
-	default "lz4" if PSTORE_LZ4_COMPRESS_DEFAULT
-	default "lz4hc" if PSTORE_LZ4HC_COMPRESS_DEFAULT
-	default "842" if PSTORE_842_COMPRESS_DEFAULT
-	default "zstd" if PSTORE_ZSTD_COMPRESS_DEFAULT
+	  Whether pstore records should be compressed before being written to
+	  the backing store. This is implemented using the zlib 'deflate'
+	  algorithm, using the library implementation instead of using the full
+	  blown crypto API. This reduces the risk of secondary oopses or other
+	  problems while pstore is recording panic metadata.
 
 config PSTORE_CONSOLE
 	bool "Log kernel console messages"
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 13fd1a297846535a..aaa5e4e66db431b3 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -16,13 +16,14 @@
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pstore.h>
-#include <linux/crypto.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
+#include <linux/vmalloc.h>
 #include <linux/workqueue.h>
+#include <linux/zlib.h>
 
 #include "internal.h"
 
@@ -71,12 +72,21 @@ static char *backend;
 module_param(backend, charp, 0444);
 MODULE_PARM_DESC(backend, "specific backend to use");
 
-static char *compress =
-#ifdef CONFIG_PSTORE_COMPRESS_DEFAULT
-		CONFIG_PSTORE_COMPRESS_DEFAULT;
-#else
-		NULL;
-#endif
+/*
+ * pstore no longer implements compression via the crypto API, and only
+ * supports zlib deflate compression implemented using the zlib library
+ * interface. This removes additional complexity which is hard to justify for a
+ * diagnostic facility that has to operate in conditions where the system may
+ * have become unstable. Zlib deflate is comparatively small in terms of code
+ * size, and compresses ASCII text comparatively well. In terms of compression
+ * speed, deflate is not the best performer but for recording the log output on
+ * a kernel panic, this is not considered critical.
+ *
+ * The only remaining arguments supported by the compress= module parameter are
+ * 'deflate' and 'none'. To retain compatibility with existing installations,
+ * all other values are logged and replaced with 'deflate'.
+ */
+static char *compress = "deflate";
 module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "compression to use");
 
@@ -85,8 +95,7 @@ unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
 module_param(kmsg_bytes, ulong, 0444);
 MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 
-/* Compression parameters */
-static struct crypto_comp *tfm;
+static void *compress_workspace;
 
 static char *big_oops_buf;
 
@@ -156,36 +165,49 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 static int pstore_compress(const void *in, void *out,
 			   unsigned int inlen, unsigned int outlen)
 {
+	struct z_stream_s zstream = {
+		.next_in	= in,
+		.avail_in	= inlen,
+		.next_out	= out,
+		.avail_out	= outlen,
+		.workspace	= compress_workspace,
+	};
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS))
 		return -EINVAL;
 
-	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
-	if (ret) {
-		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
-		return ret;
-	}
+	ret = zlib_deflateInit2(&zstream, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
+				-MAX_WBITS, DEF_MEM_LEVEL, Z_DEFAULT_STRATEGY);
+	if (ret != Z_OK)
+		return -EINVAL;
 
-	return outlen;
+	ret = zlib_deflate(&zstream, Z_FINISH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	ret = zlib_deflateEnd(&zstream);
+	if (ret != Z_OK)
+		pr_warn_once("zlib_deflateEnd() failed: %d\n", ret);
+
+	return zstream.total_out;
 }
 
 static void allocate_buf_for_compression(void)
 {
-	struct crypto_comp *ctx;
 	char *buf;
 
-	/* Skip if not built-in or compression backend not selected yet. */
-	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !compress)
+	/* Skip if not built-in or compression disabled. */
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !compress ||
+	    !strcmp(compress, "none")) {
+		compress = NULL;
 		return;
+	}
 
-	/* Skip if no pstore backend yet or compression init already done. */
-	if (!psinfo || tfm)
-		return;
-
-	if (!crypto_has_comp(compress, 0, 0)) {
-		pr_err("Unknown compression: %s\n", compress);
-		return;
+	if (strcmp(compress, "deflate")) {
+		pr_err("Unsupported compression '%s', falling back to deflate\n",
+		       compress);
+		compress = "deflate";
 	}
 
 	/*
@@ -200,16 +222,15 @@ static void allocate_buf_for_compression(void)
 		return;
 	}
 
-	ctx = crypto_alloc_comp(compress, 0, 0);
-	if (IS_ERR_OR_NULL(ctx)) {
+	compress_workspace =
+		vmalloc(zlib_deflate_workspacesize(MAX_WBITS, DEF_MEM_LEVEL));
+	if (!compress_workspace) {
+		pr_err("Failed to allocate zlib deflate workspace\n");
 		kfree(buf);
-		pr_err("crypto_alloc_comp('%s') failed: %ld\n", compress,
-		       PTR_ERR(ctx));
 		return;
 	}
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
-	tfm = ctx;
 	big_oops_buf = buf;
 
 	pr_info("Using crash dump compression: %s\n", compress);
@@ -217,10 +238,11 @@ static void allocate_buf_for_compression(void)
 
 static void free_buf_for_compression(void)
 {
-	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
-		crypto_free_comp(tfm);
-		tfm = NULL;
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && compress_workspace) {
+		vfree(compress_workspace);
+		compress_workspace = NULL;
 	}
+
 	kfree(big_oops_buf);
 	big_oops_buf = NULL;
 }
@@ -531,7 +553,8 @@ void pstore_unregister(struct pstore_info *psi)
 }
 EXPORT_SYMBOL_GPL(pstore_unregister);
 
-static void decompress_record(struct pstore_record *record)
+static void decompress_record(struct pstore_record *record,
+			      struct z_stream_s *zstream)
 {
 	int ret;
 	int unzipped_len;
@@ -547,26 +570,37 @@ static void decompress_record(struct pstore_record *record)
 	}
 
 	/* Missing compression buffer means compression was not initialized. */
-	if (!big_oops_buf) {
+	if (!zstream->workspace) {
 		pr_warn("no decompression method initialized!\n");
 		return;
 	}
 
+	ret = zlib_inflateReset(zstream);
+	if (ret != Z_OK) {
+		pr_err("zlib_inflateReset() failed, ret = %d!\n", ret);
+		return;
+	}
+
 	/* Allocate enough space to hold max decompression and ECC. */
 	workspace = kmalloc(psinfo->bufsize + record->ecc_notice_size,
 			    GFP_KERNEL);
 	if (!workspace)
 		return;
 
-	/* After decompression "unzipped_len" is almost certainly smaller. */
-	ret = crypto_comp_decompress(tfm, record->buf, record->size,
-					  workspace, &unzipped_len);
-	if (ret) {
-		pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);
+	zstream->next_in	= record->buf;
+	zstream->avail_in	= record->size;
+	zstream->next_out	= workspace;
+	zstream->avail_out	= psinfo->bufsize;
+
+	ret = zlib_inflate(zstream, Z_FINISH);
+	if (ret != Z_STREAM_END) {
+		pr_err("zlib_inflate() failed, ret = %d!\n", ret);
 		kfree(workspace);
 		return;
 	}
 
+	unzipped_len = zstream->total_out;
+
 	/* Append ECC notice to decompressed buffer. */
 	memcpy(workspace + unzipped_len, record->buf + record->size,
 	       record->ecc_notice_size);
@@ -596,10 +630,17 @@ void pstore_get_backend_records(struct pstore_info *psi,
 {
 	int failed = 0;
 	unsigned int stop_loop = 65536;
+	struct z_stream_s zstream = {};
 
 	if (!psi || !root)
 		return;
 
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && compress) {
+		zstream.workspace = kvmalloc(zlib_inflate_workspacesize(),
+					     GFP_KERNEL);
+		zlib_inflateInit2(&zstream, -DEF_WBITS);
+	}
+
 	mutex_lock(&psi->read_mutex);
 	if (psi->open && psi->open(psi))
 		goto out;
@@ -628,7 +669,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 			break;
 		}
 
-		decompress_record(record);
+		decompress_record(record, &zstream);
 		rc = pstore_mkfile(root, record);
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
@@ -644,6 +685,12 @@ void pstore_get_backend_records(struct pstore_info *psi,
 out:
 	mutex_unlock(&psi->read_mutex);
 
+	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && compress) {
+		if (zlib_inflateEnd(&zstream) != Z_OK)
+			pr_warn("zlib_inflateEnd() failed\n");
+		kvfree(zstream.workspace);
+	}
+
 	if (failed)
 		pr_warn("failed to create %d record(s) from '%s'\n",
 			failed, psi->name);
@@ -671,13 +718,6 @@ static int __init pstore_init(void)
 {
 	int ret;
 
-	/*
-	 * Check if any pstore backends registered earlier but did not
-	 * initialize compression because crypto was not ready. If so,
-	 * initialize compression now.
-	 */
-	allocate_buf_for_compression();
-
 	ret = pstore_init_fs();
 	if (ret)
 		free_buf_for_compression();
-- 
2.39.2

