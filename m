Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB03EB64DD
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 13:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGDNw3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 09:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDNw3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 09:52:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A4BE
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 06:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 015B06123A
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 13:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637BEC433CA;
        Tue,  4 Jul 2023 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688478747;
        bh=Q7WXn/9ScDpp+9OtWuC/H3KaPEup8gUb/dUDS2VbtJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0qLd+xdIJ1ZMr35lCFcSKhsJqDz2+7h1XAUKGHzbBQDW8V/aUoltf3b6H5P+6a+w
         xsBLrfnKhC8Qk4A/8XHSNH+1NWhFusM/V9ueUduSE2jnWplmYeKZCkMWOBhlJJbaZ3
         bi+CP23NF+k9lWd3lO/rwcd3Z9248S6o1ui1q+C1SOYJaweRIzLLzK6CC3IMVjhci3
         F92mYTE06kAfko79hc3+dnO3oKh/Gs+wSLZYIQZwnPWxa9izAd/l1C/1/MPMWngcCM
         AObIMuhK3oqYQUSxsNFxbhmKcbrF2B5PctmfYNHfCNxMwWYkKWemjoRsUo2J1+4V16
         4ZrwFgJ23e1og==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-hardening@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 1/2] pstore: Remove worst-case compression size logic
Date:   Tue,  4 Jul 2023 15:52:10 +0200
Message-Id: <20230704135211.2471371-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704135211.2471371-1-ardb@kernel.org>
References: <20230704135211.2471371-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6268; i=ardb@kernel.org; h=from:subject; bh=QmbLBa3x9rokegsWHpcbRv3J3rZorVO5B3xqQCg4liw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWJCud9+ev6G71VBSxDVRk7zy3Yquw3UeR9SntXo4Znf muwUG9HKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmEhCDSPDJ/G0fEPzJdFS/w79 67jWN2dF8JZ7eyujLtj2Gk+d6Hj0IcNfSa/EH/52f1YGHNPSYdc/aVJw8m/GmxkGq9k+q+VMC9V jBQA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The worst case compression size gives an upper bound for how much the
data might inadvertently *grow* due to encapsulation overhead if the
input is not compressible at all.

The kernel log is ASCII text so it should generally compress rather
well. This means that the probability that the kernel log grows beyond
the uncompressed size after compression is astronomically low, and in
such cases (i.e., dmesg filled with perfect entropy) we won't be able to
make sense of it anyway.

So let's just drop this logic, and use the uncompressed size as the
worst case instead.

Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/pstore/platform.c | 153 ++------------------
 1 file changed, 9 insertions(+), 144 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cbc0b468c1ab6ca1..6741ec4347a3eea9 100644
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
@@ -97,11 +88,6 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 /* Compression parameters */
 static struct crypto_comp *tfm;
 
-struct pstore_zbackend {
-	int (*zbufsize)(size_t size);
-	const char *name;
-};
-
 static char *big_oops_buf;
 static size_t big_oops_buf_sz;
 
@@ -168,105 +154,6 @@ static bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
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
@@ -291,36 +178,31 @@ static void allocate_buf_for_compression(void)
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
-		return;
-	}
-
-	size = zbackend->zbufsize(psinfo->bufsize);
-	if (size <= 0) {
-		pr_err("Invalid compression size for %s: %d\n",
-		       zbackend->name, size);
+	if (!crypto_has_comp(compress, 0, 0)) {
+		pr_err("Unknown compression: %s\n", compress);
 		return;
 	}
 
+	/* Worst-case compression should never be more than uncompressed. */
+	size = psinfo->bufsize;
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf) {
 		pr_err("Failed %d byte compression buffer allocation for: %s\n",
-		       size, zbackend->name);
+		       size, compress);
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
@@ -330,7 +212,7 @@ static void allocate_buf_for_compression(void)
 	big_oops_buf_sz = size;
 	big_oops_buf = buf;
 
-	pr_info("Using crash dump compression: %s\n", zbackend->name);
+	pr_info("Using crash dump compression: %s\n", compress);
 }
 
 static void free_buf_for_compression(void)
@@ -818,27 +700,10 @@ static void pstore_timefunc(struct timer_list *unused)
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

