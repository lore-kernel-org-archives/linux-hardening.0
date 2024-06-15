Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CA45C1C
	for <linux-hardening@vger.kernel.org>; Sat, 15 Jun 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457068; cv=none; b=pzXruDJz5AlZGw5nJAkes7R/9xcYSV4HiKEoXxVquiul0QuaUwIJbyc761MfgD0cDHBS8Mav2W8y1IVTpTLEywpPTK9+qCpeV5g+2OFICNfgBWh/iPQTyhEFPMiGMuTI8N42n2m7HbqzceQtszFBztfPSNXWEakACDsW6pVVSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457068; c=relaxed/simple;
	bh=Ol8fVMg6nVivSf4Nnwjw/1weReu0RFurMSRMDvD4Gdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WrqcCYnHqrndY0mwEFprdvxG3EiLdndIg4GEz7H7orI84pcpK714CpZLvsX0objrfq0xNVZAY52Nr5pIC076lvqLroOjGzPEavZt2+9nQLg4Df6Z4ECpPNMYXHzUK578oohvs9/A4JKLfH64QPM1R66Wq3UaViPSqPhtLU5IooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3MMId6P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3MMId6P"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so18581255e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 15 Jun 2024 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718457065; x=1719061865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba4JlU+lElmNUJ4vk5yO98VufPpPvVG+eNMTDfaipN4=;
        b=W3MMId6PyhL2aG4LeSWo5Jblt2/uwd/G6wJTI3scQB7ci/uK0AuVAhytEdpm4moxLr
         30mUCISSpYIhUu6TLwN3tulip2AYlUSNLqmW6Zq9xvgiRsvr/eq/u7KowDUlWJpwm5+T
         nIVNOS5DDseDNSgFmfyGKEFVv+4+h4wdKoakmeTNcfJtuc8DERcZsikcAIOlxh2PeFjA
         +jDI+Oa+oLJf1pzF+oRH3Qst/cEL6m7hB70u+cvq4dsNfEiKeaoHAOvBSNaiQRPcmFjB
         UIfVMn5240nla8o+Z++c62VT2VzuxKUvqFDgsOBWWG2aq8duezQaXYJGIgeyvHP7dxYB
         qzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718457065; x=1719061865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ba4JlU+lElmNUJ4vk5yO98VufPpPvVG+eNMTDfaipN4=;
        b=v0AoZpwhbH0ctNxzAeJc4zNhzxg+lPsQb937PDp6OClLGoIQ73f29+F/Fe9LjPDu+X
         01rTExgjEimDS3ljK2d7GQ6bsW4/TrN4o09OCe0a8YnkbHKUx/ijf7zz9gezijr8SdD8
         URw2/0Ioq+gvWWusDkPZnLUif+c3J8t1vpUZH7inrNhahKT4OHr5uEtDvasWIWRwZ9Gw
         L/RyY55hCmQKIla9N4Qy+JOS4XJXhNfGR9aDBqhkgfu1lw0doz8FvzULUlzXspMUUusb
         uRLojVZTdcyGiT5t4NWykxc5tgYWQan0b8Hyspi7LLwJ6gS4E3GTTTEb3b2fBXS7c3H5
         Y+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQNELVLxgluL9DOBfCp6F/VXJ0wpES44w30oqtRHvxjQ3K0eDQverXhbCUSOzlBPNHf5XOprrcKGIElcrKGClYebgirB1GDeKhJqDm91+6
X-Gm-Message-State: AOJu0Yz0qGqY6bMvup3PoDjSTJ+A1dnRT8iH2JL5M9MMoZ4HTQSE6d2m
	rqxPfP/zEYuH4mfj/fKVlDtfREx1v4XuJ1FWlpS8XgNRJaxpJ3hN
X-Google-Smtp-Source: AGHT+IGlaRl0TM5cmcT0s0u1x2uu4fe2YNNC0m3IIF4OwV+21QOMU70L+AkTmyX1r/hF+JUVri+5XA==
X-Received: by 2002:a05:600c:4448:b0:422:1705:7556 with SMTP id 5b1f17b1804b1-4230481bddemr58699165e9.4.1718457064982;
        Sat, 15 Jun 2024 06:11:04 -0700 (PDT)
Received: from qamajeed.Home ([39.45.142.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm136888545e9.37.2024.06.15.06.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 06:11:04 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: bscs16018@itu.edu.pk
Cc: Kees Cook <keescook@chromium.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-hardening@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 2/2] string: Remove strlcpy()
Date: Sat, 15 Jun 2024 18:10:25 +0500
Message-Id: <20240615131025.16746-3-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240615131025.16746-1-qasim.majeed20@gmail.com>
References: <20240615131025.16746-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

With all the users of strlcpy() removed[1] from the kernel, remove the
API, self-tests, and other references. Leave mentions in Documentation
(about its deprecation), and in checkpatch.pl (to help migrate host-only
tools/ usage). Long live strscpy().

Link: https://github.com/KSPP/linux/issues/89 [1]
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h                | 51 -------------------
 include/linux/string.h                        |  3 --
 lib/nlattr.c                                  |  2 +-
 lib/string.c                                  | 15 ------
 lib/test_fortify/write_overflow-strlcpy-src.c |  5 --
 lib/test_fortify/write_overflow-strlcpy.c     |  5 --
 6 files changed, 1 insertion(+), 80 deletions(-)
 delete mode 100644 lib/test_fortify/write_overflow-strlcpy-src.c
 delete mode 100644 lib/test_fortify/write_overflow-strlcpy.c

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 79ef6ac4c021..89a6888f2f9e 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -214,51 +214,6 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 	return ret;
 }
 
-/* Defined after fortified strlen() to reuse it. */
-extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
-/**
- * strlcpy - Copy a string into another string buffer
- *
- * @p: pointer to destination of copy
- * @q: pointer to NUL-terminated source string to copy
- * @size: maximum number of bytes to write at @p
- *
- * If strlen(@q) >= @size, the copy of @q will be truncated at
- * @size - 1 bytes. @p will always be NUL-terminated.
- *
- * Do not use this function. While FORTIFY_SOURCE tries to avoid
- * over-reads when calculating strlen(@q), it is still possible.
- * Prefer strscpy(), though note its different return values for
- * detecting truncation.
- *
- * Returns total number of bytes written to @p, including terminating NUL.
- *
- */
-__FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, size_t size)
-{
-	const size_t p_size = __member_size(p);
-	const size_t q_size = __member_size(q);
-	size_t q_len;	/* Full count of source string length. */
-	size_t len;	/* Count of characters going into destination. */
-
-	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
-		return __real_strlcpy(p, q, size);
-	q_len = strlen(q);
-	len = (q_len >= size) ? size - 1 : q_len;
-	if (__builtin_constant_p(size) && __builtin_constant_p(q_len) && size) {
-		/* Write size is always larger than destination. */
-		if (len >= p_size)
-			__write_overflow();
-	}
-	if (size) {
-		if (len >= p_size)
-			fortify_panic(__func__);
-		__underlying_memcpy(p, q, len);
-		p[len] = '\0';
-	}
-	return q_len;
-}
-
 /* Defined after fortified strnlen() to reuse it. */
 extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
 /**
@@ -272,12 +227,6 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
  * @p buffer. The behavior is undefined if the string buffers overlap. The
  * destination @p buffer is always NUL terminated, unless it's zero-sized.
  *
- * Preferred to strlcpy() since the API doesn't require reading memory
- * from the source @q string beyond the specified @size bytes, and since
- * the return value is easier to error-check than strlcpy()'s.
- * In addition, the implementation is robust to the string changing out
- * from underneath it, unlike the current strlcpy() implementation.
- *
  * Preferred to strncpy() since it always returns a valid string, and
  * doesn't unnecessarily force the tail of the destination buffer to be
  * zero padded. If padding is desired please use strscpy_pad().
diff --git a/include/linux/string.h b/include/linux/string.h
index ce137830a0b9..ab148d8dbfc1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -66,9 +66,6 @@ extern char * strcpy(char *,const char *);
 #ifndef __HAVE_ARCH_STRNCPY
 extern char * strncpy(char *,const char *, __kernel_size_t);
 #endif
-#ifndef __HAVE_ARCH_STRLCPY
-size_t strlcpy(char *, const char *, size_t);
-#endif
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *, const char *, size_t);
 #endif
diff --git a/lib/nlattr.c b/lib/nlattr.c
index dc15e7888fc1..ed2ab43e1b22 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -758,7 +758,7 @@ EXPORT_SYMBOL(nla_find);
  * @dstsize: Size of destination buffer.
  *
  * Copies at most dstsize - 1 bytes into the destination buffer.
- * Unlike strlcpy the destination buffer is always padded out.
+ * Unlike strscpy() the destination buffer is always padded out.
  *
  * Return:
  * * srclen - Returns @nla length (not including the trailing %NUL).
diff --git a/lib/string.c b/lib/string.c
index be26623953d2..6891d15ce991 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -103,21 +103,6 @@ char *strncpy(char *dest, const char *src, size_t count)
 EXPORT_SYMBOL(strncpy);
 #endif
 
-#ifndef __HAVE_ARCH_STRLCPY
-size_t strlcpy(char *dest, const char *src, size_t size)
-{
-	size_t ret = strlen(src);
-
-	if (size) {
-		size_t len = (ret >= size) ? size - 1 : ret;
-		__builtin_memcpy(dest, src, len);
-		dest[len] = '\0';
-	}
-	return ret;
-}
-EXPORT_SYMBOL(strlcpy);
-#endif
-
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
diff --git a/lib/test_fortify/write_overflow-strlcpy-src.c b/lib/test_fortify/write_overflow-strlcpy-src.c
deleted file mode 100644
index 91bf83ebd34a..000000000000
--- a/lib/test_fortify/write_overflow-strlcpy-src.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#define TEST	\
-	strlcpy(small, large_src, sizeof(small) + 1)
-
-#include "test_fortify.h"
diff --git a/lib/test_fortify/write_overflow-strlcpy.c b/lib/test_fortify/write_overflow-strlcpy.c
deleted file mode 100644
index 1883db7c0cd6..000000000000
--- a/lib/test_fortify/write_overflow-strlcpy.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#define TEST	\
-	strlcpy(instance.buf, large_src, sizeof(instance.buf) + 1)
-
-#include "test_fortify.h"
-- 
2.34.1

