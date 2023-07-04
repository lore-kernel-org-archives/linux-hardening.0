Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A13CEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 13:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGDNwb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDNwb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 09:52:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5FBE
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 06:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E5161269
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 13:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87A1C433C9;
        Tue,  4 Jul 2023 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688478748;
        bh=8StsOH1YSM6B1lDNSUCgh4bFfo6Z0UgatasdO2r0Z4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKLiLoiKU/IwjZgf60vNz3d/0+uKEfX/lX3AbftRs5JPRaV8NVR7PbUi0ZtZfnUBk
         l+/PaKiKT+uJ4ViNPRrbfCdbotpr0lnNTDMHbgvFnD6VWPr13pGX7HYU002mazakXT
         0jucoSuVde4+DOXT/7VAC2bNTwMUe5J6yMj/4cw7JOYS/5+YIfYqRfmnUrVTMNKdVk
         vfZYhYvr6+vLIlsdzk/zbJqYk30uFb+223ZoJEgsXeeMUsPUt9+5sSV256OTbDYDRH
         KM74EuP66tK7kVjVwBllyIORUwPQCXiKno7RGJo7OPs8xXX8PaG2T5so4BTk55wK3D
         fm6yJqb6kymSQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 2/2] pstore: Replace crypto API compression with zlib_deflate library calls
Date:   Tue,  4 Jul 2023 15:52:11 +0200
Message-Id: <20230704135211.2471371-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704135211.2471371-1-ardb@kernel.org>
References: <20230704135211.2471371-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12053; i=ardb@kernel.org; h=from:subject; bh=8StsOH1YSM6B1lDNSUCgh4bFfo6Z0UgatasdO2r0Z4I=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWJCteUi2xLZzpzu93euSouS3gNwyzPS2evyy76otm85 YvapVNnOkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEfiYz/K+rWz9hR6h0YLfg h0iOLBXjKTur4hXrPD0ilb4kTLV5yMbI0Gev4OL89bjcpant0x8xS9y5t+3G1N38r1pSV4spbjC M4wcA
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
this happens when the system is likely to be in a highly fragile state,
the flexibility that the complex crypto API provides does not outweigh
its impact on the risk that we might encounter additional problems when
trying to commit the kernel log contents to the pstore backend.

So let's switch [back] to the zlib deflate library API, and remove all
the complexity that really has no place in a low-level diagnostic
facility. Note that, while more modern compression algorithms have been
added to the kernel in recent years, the code size of zlib deflate is
substantially smaller, while its performance in terms of compression
ratio is perfectly acceptable, and speed is irrelevant in this context
(unless panic() is a performance bottleneck in your workload).

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/pstore/Kconfig    | 100 ++----------------
 fs/pstore/platform.c | 108 +++++++++++---------
 2 files changed, 69 insertions(+), 139 deletions(-)

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
index 6741ec4347a3eea9..27a045b730eaf1c4 100644
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
 
@@ -71,12 +72,7 @@ static char *backend;
 module_param(backend, charp, 0444);
 MODULE_PARM_DESC(backend, "specific backend to use");
 
-static char *compress =
-#ifdef CONFIG_PSTORE_COMPRESS_DEFAULT
-		CONFIG_PSTORE_COMPRESS_DEFAULT;
-#else
-		NULL;
-#endif
+static char *compress = "deflate";
 module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "compression to use");
 
@@ -85,8 +81,7 @@ unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
 module_param(kmsg_bytes, ulong, 0444);
 MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 
-/* Compression parameters */
-static struct crypto_comp *tfm;
+static void *compress_workspace;
 
 static char *big_oops_buf;
 static size_t big_oops_buf_sz;
@@ -157,37 +152,46 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
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
+	return zstream.total_out;
 }
 
 static void allocate_buf_for_compression(void)
 {
-	struct crypto_comp *ctx;
 	int size;
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
 
 	/* Worst-case compression should never be more than uncompressed. */
@@ -199,16 +203,15 @@ static void allocate_buf_for_compression(void)
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
 	big_oops_buf_sz = size;
 	big_oops_buf = buf;
 
@@ -217,10 +220,6 @@ static void allocate_buf_for_compression(void)
 
 static void free_buf_for_compression(void)
 {
-	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
-		crypto_free_comp(tfm);
-		tfm = NULL;
-	}
 	kfree(big_oops_buf);
 	big_oops_buf = NULL;
 	big_oops_buf_sz = 0;
@@ -563,7 +562,8 @@ void pstore_unregister(struct pstore_info *psi)
 }
 EXPORT_SYMBOL_GPL(pstore_unregister);
 
-static void decompress_record(struct pstore_record *record)
+static void decompress_record(struct pstore_record *record,
+			      struct z_stream_s *zstream)
 {
 	int ret;
 	int unzipped_len;
@@ -584,6 +584,12 @@ static void decompress_record(struct pstore_record *record)
 		return;
 	}
 
+	ret = zlib_inflateReset(zstream);
+	if (ret != Z_OK) {
+		pr_err("zlib_inflateReset() failed, ret = %d!\n", ret);
+		return;
+	}
+
 	/* Allocate enough space to hold max decompression and ECC. */
 	unzipped_len = big_oops_buf_sz;
 	workspace = kmalloc(unzipped_len + record->ecc_notice_size,
@@ -591,15 +597,20 @@ static void decompress_record(struct pstore_record *record)
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
+	zstream->avail_out	= unzipped_len;
+
+	ret = zlib_inflate(zstream, Z_SYNC_FLUSH);
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
@@ -629,10 +640,17 @@ void pstore_get_backend_records(struct pstore_info *psi,
 {
 	int failed = 0;
 	unsigned int stop_loop = 65536;
+	struct z_stream_s zstream;
 
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
@@ -661,7 +679,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 			break;
 		}
 
-		decompress_record(record);
+		decompress_record(record, &zstream);
 		rc = pstore_mkfile(root, record);
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
@@ -676,6 +694,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 		psi->close(psi);
 out:
 	mutex_unlock(&psi->read_mutex);
+	kvfree(zstream.workspace);
 
 	if (failed)
 		pr_warn("failed to create %d record(s) from '%s'\n",
@@ -704,13 +723,6 @@ static int __init pstore_init(void)
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

