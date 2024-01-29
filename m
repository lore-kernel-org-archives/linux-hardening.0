Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188036F08E
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560152; cv=none; b=hhsbE5D3eza7aLl0Kmho7SG6+R65t7pp8bFuuZgbNykKrflfTVmM2TKIiAyjtKJxqh5l79wMBvRun4zS2ounfHL5//LlEYqmwDl8WVaykiQQU4eaRDVecb9oKfEpONs8mCp0fryKqlBru1nSV7DqKJBrg0MC4lwnRPRLoM/spSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560152; c=relaxed/simple;
	bh=tXy4xQ2kacaBozMPbfsCpwvJ6haeLTL5rU9zhmjNRhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsCYJSC9pZJah7TQRXIExgiNEPIFX+kj0/RA4aAP/qN+cQCMz14p75X8DhsrTqRJw1fbep8TQThpT0MDkhWwljEQlcprzFTAM+TtPEIy3Sj2r2NZ4cG+efI01b0ZDFdZEVRlKFCzFm+QyBMM4DTimjgUx+nnwNtF70CER9uEV2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SQK3wD0T; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SQK3wD0T"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e1270e8cd3so638125a34.1
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 12:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706560150; x=1707164950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAmaslHwzSDAfTrzdx10Kky4yB8faOBeb7X7c1JV820=;
        b=SQK3wD0TYh/dmlGPm81OMv1ZDRopgMzXpng8G4e4ckFMi7K/o7xvq/VilnFWTSjY0c
         7cSTyFGRVX2wjVpyKkZCJfw7TT0dipYY3c9UTgIx1qQmb0jOgF0PdiAz4dwuR2mv94qM
         5t5FvRUVwi1bFFIdEetUctBBwSytGW/+JBo4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706560150; x=1707164950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAmaslHwzSDAfTrzdx10Kky4yB8faOBeb7X7c1JV820=;
        b=LvkG5rrPuZqoqZ8h1DHjcgp9tfZApaOilxoTmoiICgBWmepU0AbkttM+SEoiRxqYHz
         U9yhZf8wY8CdpY+m9SjE3RoKesoblmbgh5dQzVlEhQl6nY1hUyfo5qd9XX3+zeK08HOx
         HgCMBiAnORTdjYP3WjkJBLkzuxCvNUeH4ddzb2RvQhSy3F2mrpiuub+Nn5fan4VJVjZg
         EhJ+kgNGu02iLt+wFay9IUPFwrf7O7a+UmnshjcaoOIi7Yg2HTkoYHnv94YP8Z5iIC3q
         m7QnMOHKeo+9iENowoJds6KV9qFaJ39tYDSp0C5zwPxa0zL54gwEReL1jbUukezrglWX
         u2RQ==
X-Gm-Message-State: AOJu0YzmEIHWlbdPBEk151dsDereU9Xml3GUAHK2a20QP9IFsZ04vII1
	ETsyUrigNLICtgWsyB1N37dhO9071FguGfKgrQUqvpHAzH4Nn3bQ6Da4x/llUw==
X-Google-Smtp-Source: AGHT+IGBV7PI3DksPECDDGdtUCxoJJV95ddL5HiaF24j8VZ2IZnzCXajijC6v/GeaFVMOtk9V6Oilg==
X-Received: by 2002:a05:6359:459c:b0:176:5c72:8e6b with SMTP id no28-20020a056359459c00b001765c728e6bmr4764001rwb.0.1706560150083;
        Mon, 29 Jan 2024 12:29:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006da73b90fe4sm6486393pfb.14.2024.01.29.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:29:09 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] string: Allow 2-argument strscpy()
Date: Mon, 29 Jan 2024 12:29:04 -0800
Message-Id: <20240129202901.work.282-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3384; i=keescook@chromium.org;
 h=from:subject:message-id; bh=tXy4xQ2kacaBozMPbfsCpwvJ6haeLTL5rU9zhmjNRhw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluAqQjb/yEaEffuTpus0VYworpNQ2/qAcr663e
 hxOXJPsTGCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbgKkAAKCRCJcvTf3G3A
 JoMBD/97fRjBYcKsgjVB+5kZoBDBwn/Qkmsz26xpgAkAcRvKEunPlBPgoAHuj7D0h44dpc1y1Tu
 QDRaM8+ranKSunfp38P4bFrh+tQZ7XBoCzDDn/GyYW+20edRO+w9AzDRK/SJLwwaLQNTQXZgbyT
 fcYYuBJ+D7w9u50IV3GS7VwcI4sGCfe13F3Ld70zmGE1pkOoydrnCHx/MKMQPBHkE937BXrb1gj
 4zNko2F7thdJQMjQ5szeNjNm++whmDIKOFH50IW7ua7/O7tq1TYVCOYj+VVAiBIZrK/Ssj7d+Gr
 lv1hny4mVotCA+jAe3mbLoJI9eE+Qh7u9VPrMPE89BejJOgMoaZ3AWb8hH3C4VAbsFGjG1crORx
 3vDiipoqtO3lA84pRUSBbPGzp8Jr/1X56+n42vvrW6BXbOa55rukH+rg9hy4hyPYKN8GaQhACXW
 AM9d8wfV9AeI4kIbkLrs309vLqUU0EfIe0HQSzPCV/77EzTCLdcRoMgrRoJTYipigMmQJsYqkp+
 7L3OQvomXjcdX+MWy9hXGSRGoBEAeaH+Y5oWLPc1K8c4iO/vTJLuua+up01bc56eQQcOgRtcG8L
 WT1X+DG3rBzJmx/XauaaYDx30PmedeFvZSpI+Hbv0aqDJpmzsmX0Xe+w1yR45C/gpRxtJqLL9hT
 yUbMbZ4 bhORMvZA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using sizeof(dst) is the overwhelmingly common case for strscpy().
Instead of requiring this everywhere, allow a 2-argument version to be
used that will use the sizeof() internally.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
What do people think of this idea? It's usually very redundant to
include the 3rd argument, so this might improve readability (and
perhaps make things more robust by avoiding mistakes when the
destination name changes).
---
 include/linux/fortify-string.h | 4 ++--
 include/linux/string.h         | 9 ++++++++-
 lib/string.c                   | 4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 89a6888f2f9e..56be4d4a5dea 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -215,7 +215,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 }
 
 /* Defined after fortified strnlen() to reuse it. */
-extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strscpy);
 /**
  * strscpy - Copy a C-string into a sized buffer
  *
@@ -234,7 +234,7 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
  * Returns the number of characters copied in @p (not including the
  * trailing %NUL) or -E2BIG if @size is 0 or the copy of @q was truncated.
  */
-__FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
+__FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
 {
 	/* Use string size rather than possible enclosing struct size. */
 	const size_t p_size = __member_size(p);
diff --git a/include/linux/string.h b/include/linux/string.h
index ab148d8dbfc1..0bb1c8d05f18 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -67,9 +67,16 @@ extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_STRSCPY
-ssize_t strscpy(char *, const char *, size_t);
+ssize_t sized_strscpy(char *, const char *, size_t);
 #endif
 
+#define __strscpy0(dst, src, ...)	sized_strscpy(dst, src, sizeof(dst))
+
+#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
+
+#define strscpy(dst, src, ...)	\
+	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
+
 /* Wraps calls to strscpy()/memset(), no arch specific code required */
 ssize_t strscpy_pad(char *dest, const char *src, size_t count);
 
diff --git a/lib/string.c b/lib/string.c
index 6891d15ce991..2869895a1180 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -104,7 +104,7 @@ EXPORT_SYMBOL(strncpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRSCPY
-ssize_t strscpy(char *dest, const char *src, size_t count)
+ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	size_t max = count;
@@ -170,7 +170,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 
 	return -E2BIG;
 }
-EXPORT_SYMBOL(strscpy);
+EXPORT_SYMBOL(sized_strscpy);
 #endif
 
 /**
-- 
2.34.1

