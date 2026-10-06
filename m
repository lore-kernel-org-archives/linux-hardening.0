Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584043AA50A
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318871; cv=none; b=EnX7xo5y5+RgXGxUiTF48uCppVjRaf2SIprwWJhMHtOKVzs4hmzs7gHoIfSXbMgcQTqtFgZt7Z34jQlYjdJMJUIJVb4Bz4FNxDI9ZUtNaIVKkMAybFYjppLoLLg3FskYFJbjEeiiATnEICprNqWmIbaW4KzVTcIg8D8Mref/PH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318871; c=relaxed/simple;
	bh=393T32tfcUESSXyB1vomRgm1Foj+oh89u5Y+Lddsepk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN+hct1oapCQQ5/nFi8wVIE9LP4QntD8UIQgfeABz9kTCue5PasC8Zl+wKfDga+NXwFF+aQaOBBu4QUhRR2lUVYcAOBGVQ2kiXVGsTuTh9vzr6JVoNxX8F2J+ZERPX27wOykRXVfbWgBASvChVO23DLQxpikYctEwb4cfIrY43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GqOANJ7x; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GqOANJ7x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=eVxpaXp2GkkOgXQwwSJU7a7d1Vnevs5TQ5KaXs8K0eo=; b=
	GqOANJ7xRJmQugVLiLOhOrR5r1DlfeNRjUdu14xD+xF5fD/dk6AxYgjre5jC5MpFu2ZFCTJWcDwCc
	iuGJlEfzy1EUF9/gKwOpJ7hy6HsaeXPeSv/ylT46efC95/LnkTi4O0boRFJB3U8VUFDw3z03F3EjT
	Qqk7TQ6smhp06CrST6pDZRrIBPIYgo2+22KnMUfL6fpMwOCKs/YvwNgSWx/6RySltVMe4xpq3gRmv
	Aphh4tWaFy99l7JYkRQ20SDH8EKR98AfXPmqf/HuMQPx+S/Y4cQfiXHzcbih2+yYzZoRy+X0qN1NT
	4GFcH+hA0O+gI10EdGtfvchTPlN7Hm7Ssg==;
Received: from [187.90.178.110] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xEBri-00DcJv-By; Tue, 06 Oct 2026 22:34:22 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kees@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net
Subject: [PATCH V2 1/2] pstore: Consolidate compression handling in both init paths
Date: Tue,  6 Oct 2026 17:22:51 -0300
Message-ID: <20261006203412.175427-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261006203412.175427-1-gpiccoli@igalia.com>
References: <20261006203412.175427-1-gpiccoli@igalia.com>
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
single function called in both paths. Notice that the mutex is used
to serialize access to the compression parameter setup routine.

The __always_inline attribute usage is deliberate and necessary:
the pstore code relies on the compiler's Dead Code Elimination (DCE)
to drop references to zlib symbols that may not be built. The code
checks for CONFIG_PSTORE_COMPRESS and bails early in some functions,
which leads to zlib calls becoming dead code that is gone with DCE.
So, inlining is required here to avoid undefined references to zlib
symbols not built at link time.

On top of that, also improve the compression parameter module info.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V2:
- Guard the compression parameter routine access on pstore_init()
  with the psinfo_lock mutex, in order to avoid potential NULL pointer
  dereferences on strcmp() (thanks Sashiko!).

 fs/pstore/platform.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 1d76c9d92056..081c2134a60c 100644
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
@@ -747,10 +753,14 @@ static int __init pstore_init(void)
 {
 	int ret;
 
+	mutex_lock(&psinfo_lock);
+	compress_param_adjust();
+
 	ret = pstore_init_fs();
 	if (ret)
 		free_buf_for_compression();
 
+	mutex_unlock(&psinfo_lock);
 	return ret;
 }
 late_initcall(pstore_init);
-- 
2.50.1

