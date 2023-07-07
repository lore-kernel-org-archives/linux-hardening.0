Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF64C0015E
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Jul 2023 08:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGGIfJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjGGIfF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jul 2023 04:35:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AFE113
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 01:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C82B618A0
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 08:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621E4C433C9;
        Fri,  7 Jul 2023 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688718903;
        bh=Syc76tijxtvbXwP9yW1hCIGccwFm+ZANW7HGjysCep4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5rhuadgkoTMpxLFDmpZiIHS+tN+VUDqyI2BSovlfJ9xogtxuPgGjne/oNJiGTypq
         MQdyQMsp+LWkj+2+GoAO4sOWQiN4eGdcqtLWa4kWHzACs19Iq2LXSMO6tOcpoEpjO3
         rjaVHGUfsM06oyd0DxkI8PVgsCDBHuxBlTzzgAtWvFB1q23X+LDvklpd0iOFIFTFZE
         dRo0ILXfFa41kBu8cxk9PBC5LuWto1dV3QAw7tY2qNJbBERCONstt4/bdTJDtSEDjh
         WET/jA+C0hnp5AnolPg0cgP6YGkJlW4EnFRpkzcP7lQQ0T8R2kIZZA/NmnB+Yb7r6t
         ClC0yUMyWw09Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 1/2] pstore: Remove worst-case compression size logic
Date:   Fri,  7 Jul 2023 10:34:55 +0200
Message-Id: <20230707083456.2501913-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707083456.2501913-1-ardb@kernel.org>
References: <20230707083456.2501913-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8774; i=ardb@kernel.org; h=from:subject; bh=8QacjfByZV/y51cxxFAEaJ+YVhHgH3QmGlBAp/Bt9Po=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWX5OT1PQ4elZ4IzA3X3HM4vLNveXGccvqXAfMdOEQ4ev qOLkjI6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETYTRkZlkQUrfwvNOcMt9f6 4GgGi0qxDtkTfn5+JlKaC3aaTVqlzPA/POCkX2LZtsmf7zH6fj564tvypV/Emj4bM8jciZLamG/ NDAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The worst case compression size used by pstore gives an upper bound for
how much the data might inadvertently *grow* due to encapsulation
overhead if the input is not compressible at all.

Given that pstore records have individual 'compressed' flags, we can
simply store the uncompressed data if compressing it would end up using
more space, making the worst case identical to the uncompressed case.

This means we can just drop all the elaborate logic that reasons about
upper bounds for each individual compression algorithm, and just store
the uncompressed data directly if compression fails for any reason.

Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/pstore/platform.c | 202 ++------------------
 1 file changed, 15 insertions(+), 187 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cbc0b468c1ab6ca1..52d7b438c4882a43 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -16,15 +16,6 @@
 #include <linux/console.h>
 #include <linux/module.h>
 #include <linux/pstore.h>
-#if IS_ENABLED(CONFIG_PSTORE_LZO_COMPRESS)
-#include <linux/lzo.h>
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
-#include <linux/lz4.h>
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
-#include <linux/zstd.h>
-#endif
 #include <linux/crypto.h>
 #include <linux/string.h>
 #include <linux/timer.h>
@@ -97,13 +88,7 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 /* Compression parameters */
 static struct crypto_comp *tfm;
 
-struct pstore_zbackend {
-	int (*zbufsize)(size_t size);
-	const char *name;
-};
-
 static char *big_oops_buf;
-static size_t big_oops_buf_sz;
 
 void pstore_set_kmsg_bytes(int bytes)
 {
@@ -168,105 +153,6 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
 	}
 }
 
-#if IS_ENABLED(CONFIG_PSTORE_DEFLATE_COMPRESS)
-static int zbufsize_deflate(size_t size)
-{
-	size_t cmpr;
-
-	switch (size) {
-	/* buffer range for efivars */
-	case 1000 ... 2000:
-		cmpr = 56;
-		break;
-	case 2001 ... 3000:
-		cmpr = 54;
-		break;
-	case 3001 ... 3999:
-		cmpr = 52;
-		break;
-	/* buffer range for nvram, erst */
-	case 4000 ... 10000:
-		cmpr = 45;
-		break;
-	default:
-		cmpr = 60;
-		break;
-	}
-
-	return (size * 100) / cmpr;
-}
-#endif
-
-#if IS_ENABLED(CONFIG_PSTORE_LZO_COMPRESS)
-static int zbufsize_lzo(size_t size)
-{
-	return lzo1x_worst_compress(size);
-}
-#endif
-
-#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS) || IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
-static int zbufsize_lz4(size_t size)
-{
-	return LZ4_compressBound(size);
-}
-#endif
-
-#if IS_ENABLED(CONFIG_PSTORE_842_COMPRESS)
-static int zbufsize_842(size_t size)
-{
-	return size;
-}
-#endif
-
-#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
-static int zbufsize_zstd(size_t size)
-{
-	return zstd_compress_bound(size);
-}
-#endif
-
-static const struct pstore_zbackend *zbackend __ro_after_init;
-
-static const struct pstore_zbackend zbackends[] = {
-#if IS_ENABLED(CONFIG_PSTORE_DEFLATE_COMPRESS)
-	{
-		.zbufsize	= zbufsize_deflate,
-		.name		= "deflate",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_LZO_COMPRESS)
-	{
-		.zbufsize	= zbufsize_lzo,
-		.name		= "lzo",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_LZ4_COMPRESS)
-	{
-		.zbufsize	= zbufsize_lz4,
-		.name		= "lz4",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_LZ4HC_COMPRESS)
-	{
-		.zbufsize	= zbufsize_lz4,
-		.name		= "lz4hc",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_842_COMPRESS)
-	{
-		.zbufsize	= zbufsize_842,
-		.name		= "842",
-	},
-#endif
-#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
-	{
-		.zbufsize	= zbufsize_zstd,
-		.name		= "zstd",
-	},
-#endif
-	{ }
-};
-
 static int pstore_compress(const void *in, void *out,
 			   unsigned int inlen, unsigned int outlen)
 {
@@ -287,50 +173,42 @@ static int pstore_compress(const void *in, void *out,
 static void allocate_buf_for_compression(void)
 {
 	struct crypto_comp *ctx;
-	int size;
 	char *buf;
 
 	/* Skip if not built-in or compression backend not selected yet. */
-	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !compress)
 		return;
 
 	/* Skip if no pstore backend yet or compression init already done. */
 	if (!psinfo || tfm)
 		return;
 
-	if (!crypto_has_comp(zbackend->name, 0, 0)) {
-		pr_err("Unknown compression: %s\n", zbackend->name);
+	if (!crypto_has_comp(compress, 0, 0)) {
+		pr_err("Unknown compression: %s\n", compress);
 		return;
 	}
 
-	size = zbackend->zbufsize(psinfo->bufsize);
-	if (size <= 0) {
-		pr_err("Invalid compression size for %s: %d\n",
-		       zbackend->name, size);
-		return;
-	}
-
-	buf = kmalloc(size, GFP_KERNEL);
+	/* Worst-case compression should never be more than uncompressed. */
+	buf = kmalloc(psinfo->bufsize, GFP_KERNEL);
 	if (!buf) {
-		pr_err("Failed %d byte compression buffer allocation for: %s\n",
-		       size, zbackend->name);
+		pr_err("Failed %zu byte compression buffer allocation for: %s\n",
+		       psinfo->bufsize, compress);
 		return;
 	}
 
-	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
+	ctx = crypto_alloc_comp(compress, 0, 0);
 	if (IS_ERR_OR_NULL(ctx)) {
 		kfree(buf);
-		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
+		pr_err("crypto_alloc_comp('%s') failed: %ld\n", compress,
 		       PTR_ERR(ctx));
 		return;
 	}
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
 	tfm = ctx;
-	big_oops_buf_sz = size;
 	big_oops_buf = buf;
 
-	pr_info("Using crash dump compression: %s\n", zbackend->name);
+	pr_info("Using crash dump compression: %s\n", compress);
 }
 
 static void free_buf_for_compression(void)
@@ -341,33 +219,6 @@ static void free_buf_for_compression(void)
 	}
 	kfree(big_oops_buf);
 	big_oops_buf = NULL;
-	big_oops_buf_sz = 0;
-}
-
-/*
- * Called when compression fails, since the printk buffer
- * would be fetched for compression calling it again when
- * compression fails would have moved the iterator of
- * printk buffer which results in fetching old contents.
- * Copy the recent messages from big_oops_buf to psinfo->buf
- */
-static size_t copy_kmsg_to_buffer(int hsize, size_t len)
-{
-	size_t total_len;
-	size_t diff;
-
-	total_len = hsize + len;
-
-	if (total_len > psinfo->bufsize) {
-		diff = total_len - psinfo->bufsize + hsize;
-		memcpy(psinfo->buf, big_oops_buf, hsize);
-		memcpy(psinfo->buf + hsize, big_oops_buf + diff,
-					psinfo->bufsize - hsize);
-		total_len = psinfo->bufsize;
-	} else
-		memcpy(psinfo->buf, big_oops_buf, total_len);
-
-	return total_len;
 }
 
 void pstore_record_init(struct pstore_record *record,
@@ -426,13 +277,8 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		record.part = part;
 		record.buf = psinfo->buf;
 
-		if (big_oops_buf) {
-			dst = big_oops_buf;
-			dst_size = big_oops_buf_sz;
-		} else {
-			dst = psinfo->buf;
-			dst_size = psinfo->bufsize;
-		}
+		dst = big_oops_buf ?: psinfo->buf;
+		dst_size = psinfo->bufsize;
 
 		/* Write dump header. */
 		header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
@@ -453,8 +299,8 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 				record.compressed = true;
 				record.size = zipped_len;
 			} else {
-				record.size = copy_kmsg_to_buffer(header_size,
-								  dump_size);
+				record.size = header_size + dump_size;
+				memcpy(psinfo->buf, dst, record.size);
 			}
 		} else {
 			record.size = header_size + dump_size;
@@ -703,8 +549,7 @@ static void decompress_record(struct pstore_record *record)
 	}
 
 	/* Allocate enough space to hold max decompression and ECC. */
-	unzipped_len = big_oops_buf_sz;
-	workspace = kmalloc(unzipped_len + record->ecc_notice_size,
+	workspace = kmalloc(psinfo->bufsize + record->ecc_notice_size,
 			    GFP_KERNEL);
 	if (!workspace)
 		return;
@@ -818,27 +663,10 @@ static void pstore_timefunc(struct timer_list *unused)
 	pstore_timer_kick();
 }
 
-static void __init pstore_choose_compression(void)
-{
-	const struct pstore_zbackend *step;
-
-	if (!compress)
-		return;
-
-	for (step = zbackends; step->name; step++) {
-		if (!strcmp(compress, step->name)) {
-			zbackend = step;
-			return;
-		}
-	}
-}
-
 static int __init pstore_init(void)
 {
 	int ret;
 
-	pstore_choose_compression();
-
 	/*
 	 * Check if any pstore backends registered earlier but did not
 	 * initialize compression because crypto was not ready. If so,
-- 
2.39.2

