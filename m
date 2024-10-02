Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6B1D0B9B;
	Wed,  2 Oct 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890317; cv=none; b=qksDRINqQf5J57EuPqZ7ZpSq5G4iFrxI13xTu8DGOmm/GIMdDGs4cSW5TtZq18o3NTBSTP5YNL6bsykygzyMMieNhhVrCCl+FkyXJKPo1+T6ISR3NAdlBQaX/QIIzSQQk1ke+9aFuXKE5yGcM2/UziU/VGeEiuy9SpJx/t5xdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890317; c=relaxed/simple;
	bh=Xb/OoSDrrxytgvaYVAYYF+2fPew456qVNHvt4A+Ka4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYSf9MdI45AbRxr5CKOVbtL3SipjzHdbNVjsHlwZYM7yErnbUmWcthsiVHTQ2t3N4VunSlDC9xKm8RrsI0ACh3xw4ckNosPabkoGmUTtLtGn856Jmn7C+lT+bqpT/ruQLviJrpJEKLoWeBvnHzvzDaDWbmAjjlWaZFDYK0M57Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hhXmT0Zb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hhXmT0Zb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ME7Pc2+Q6XZhFMk8YNwfMNEQkh6kUYcbO1U84+cEdHA=; b=hhXmT0ZbD8NUz/2R
	otMdwqKPqrELQzre8fqVI39ODzjJY64S6s+0FCX8xNUZEcmjFtQtxiG1cXAMATv+Eugele6AfTXsp
	zvCnlkxdNlZXhzILVl/6wbIgQB/vKBlzQRPZhp46FSnNTJdD+mO5J/VRLimp2B7EHUODP1E+zd3Ox
	2iV5v6NrTJS0o4y58ORAojmxTZqxi8I+Zyia4ujD2hhofdEywIkg1JwaQlEDyGk4n/DL333d2rwAE
	BrJJ3On1SQR/jX0NG9RSZe/2M4G6TH6eY+reGXyvZ9KZwl1I8sicF0riN+SHzQEt5CLv5wdsxVpUL
	fyWjf65+XY0DtLJVLQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sw3CW-008Vr0-0D;
	Wed, 02 Oct 2024 17:31:48 +0000
From: linux@treblig.org
To: kees@kernel.org,
	andy@kernel.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	rostedt@goodmis.org,
	linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] printf: Remove unused 'bprintf'
Date: Wed,  2 Oct 2024 18:31:47 +0100
Message-ID: <20241002173147.210107-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

bprintf() is unused. Remove it. It was added in the commit 4370aa4aa753
("vsprintf: add binary printf") but as far as I can see was never used,
unlike the other two functions in that patch.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 include/linux/string.h |  1 -
 lib/vsprintf.c         | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 0dd27afcfaf7..493ac4862c77 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -335,7 +335,6 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 #ifdef CONFIG_BINARY_PRINTF
 int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
 int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
-int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...) __printf(3, 4);
 #endif
 
 extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 09f022ba1c05..d072cd59eb6a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3383,29 +3383,6 @@ int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 }
 EXPORT_SYMBOL_GPL(bstr_printf);
 
-/**
- * bprintf - Parse a format string and place args' binary value in a buffer
- * @bin_buf: The buffer to place args' binary value
- * @size: The size of the buffer(by words(32bits), not characters)
- * @fmt: The format string to use
- * @...: Arguments for the format string
- *
- * The function returns the number of words(u32) written
- * into @bin_buf.
- */
-int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...)
-{
-	va_list args;
-	int ret;
-
-	va_start(args, fmt);
-	ret = vbin_printf(bin_buf, size, fmt, args);
-	va_end(args);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(bprintf);
-
 #endif /* CONFIG_BINARY_PRINTF */
 
 /**
-- 
2.46.2

