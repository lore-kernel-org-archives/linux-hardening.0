Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF33F3298
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112395; cv=none; b=XlbvvNPp8qHof6IeXnPr4SpKTEmop3nCc1Dio9it2bLAzQL2acbpL8S5V17w9PwtMJ2TplH6gG/5EbNg9D2iU1JLgMD5AUM8Y6tSARYQhG8t51+36X6GCduVgd+yszim6fP/D05x3Zg+6Ca8v0BM7DuHam5t9z5P+pWrJjRvdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112395; c=relaxed/simple;
	bh=KRmOgMgV3D1iMRWVVinAPQ1z9kKRa+BptHyMhJ9diEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqn5DqNtIZUGQUGfly5oRlwjGhOXpJPI/VNfFIQtqs5uCB09y+dZdelr1QLq7ycfJQ5HMKbd7tJRDWOVmyQa9QmPmqs+DXv+1SNkVC13icLlzUwlhV9Lr2xjMXALmXbVZGB4jbX3VWUFXxymU3/6t5qB/SmdvTmF+R7cfx5ZIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IgSloBTO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IgSloBTO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=5pUM+2gyOYWR2o11f3PcVdBBbqdafV0koNPcK7icGhQ=; b=
	IgSloBTOUUUb/PkLfTaX+UjVBtV8M+TKyMqhf/5X4RnnbKoWb25LqeHRbi/e8MAP924PQPmaKrxP3
	69Atl/v5uj8lKLl1puTvPDOa0qgVM/nOA5c9A3PcVdarizj6vtjuuShVv8CIMWIE+f6bz7y/ID26h
	pFXC1bzdM5fcxyf8HllmdELqI05hXp8Etvj9ksf6aAZv8XWmp5zUrIOS9+KJWKg3fIIdPHCyX4tBq
	ypZZHYKWUyOwZ+Bep/jQ5EPQRl6cldccseo9XQayawrzMDfgviyF7ATA6D2ekh0nsj46vF53l43ZP
	Deg4vm/A6Lt/bQewkh6qrWyIhnfyY6UiNA==;
Received: from [191.32.244.140] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x980D-005pqZ-TH; Tue, 22 Sep 2026 23:26:14 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kees@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net
Subject: [PATCH 1/2] pstore: Consolidate compression handling in both init paths
Date: Tue, 22 Sep 2026 18:19:01 -0300
Message-ID: <20260922212532.98571-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922212532.98571-1-gpiccoli@igalia.com>
References: <20260922212532.98571-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pstore infrastructure can be initialized in two ways: either through
the filesystem registration at pstore_init(), or via backend registration
that calls pstore_register(). At the same time, we have a peculiarity
regarding pstore compression: multiple algorithms were once supported,
but they were phased out, and only "deflate" is now supported, along
with the backward-compatible "none" value.

These two apparently unrelated topics have one (lacking) point of
convergence: the compression parameter handling is done only in the
pstore registration phase, at allocate_buf_for_compression(). Now, if
the pstore fs gets registered prior to any backend registration, which
is common in practice, some funny scenarios are possible, for example:
users can set any string for compression and it is held in the
compression parameter up to the backend registration (if any). Another
one (maybe even more odd): it's possible to set any value to this
parameter even if CONFIG_PSTORE_COMPRESS is disabled, and such a value
is kept until backend registration, which is counter-intuitive.

Bring both initialization points of pstore in sync regarding the
compression set-up, by funneling the parameter handling through a
single function called in both paths. The __always_inline attribute
usage is deliberate and necessary: the pstore code relies on the
compiler's Dead Code Elimination (DCE) to drop references to zlib
symbols that may not be built. The code checks for CONFIG_PSTORE_COMPRESS
and bails early in some functions, which leads to zlib calls becoming
dead code that is gone with DCE. So, inlining is required here to
avoid undefined references to zlib symbols not built at link time.

On top of that, also improve the compression parameter module info.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/platform.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 1d76c9d92056..f3a900cf2cfb 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -89,7 +89,7 @@ MODULE_PARM_DESC(backend, "specific backend to use");
  */
 static char *compress = "deflate";
 module_param(compress, charp, 0444);
-MODULE_PARM_DESC(compress, "compression to use");
+MODULE_PARM_DESC(compress, "compression to use (deflate/none)");
 
 /* How much of the kernel log to snapshot */
 unsigned int kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
@@ -201,16 +201,12 @@ static int pstore_compress(const void *in, void *out,
 	return zstream.total_out;
 }
 
-static void allocate_buf_for_compression(void)
+static __always_inline bool compress_param_adjust(void)
 {
-	size_t compressed_size;
-	char *buf;
-
-	/* Skip if not built-in or compression disabled. */
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !compress ||
 	    !strcmp(compress, "none")) {
 		compress = NULL;
-		return;
+		return false;
 	}
 
 	if (strcmp(compress, "deflate")) {
@@ -219,6 +215,16 @@ static void allocate_buf_for_compression(void)
 		compress = "deflate";
 	}
 
+	return true;
+}
+
+static void allocate_buf_for_compression(void)
+{
+	size_t compressed_size;
+	char *buf;
+
+	if (!compress_param_adjust())
+		return;
 	/*
 	 * The compression buffer only needs to be as large as the maximum
 	 * uncompressed record size, since any record that would be expanded by
@@ -747,6 +753,8 @@ static int __init pstore_init(void)
 {
 	int ret;
 
+	compress_param_adjust();
+
 	ret = pstore_init_fs();
 	if (ret)
 		free_buf_for_compression();
-- 
2.50.1

