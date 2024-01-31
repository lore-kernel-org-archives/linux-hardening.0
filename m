Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AA3DBAE
	for <linux-hardening@vger.kernel.org>; Wed, 31 Jan 2024 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680438; cv=none; b=duiYCL9ccppirCSqaWZyMrHyydlm5/JqVzpRqGM5aMAgW7bmDgMwrWH49TLCPA8mC7CZSD2yKzXNnTZnP2lKOypKAn08OuJmJmSQLwDohIXbeaPpJQ2qfi/OEvpAfiCDHmFXas6nHN9pN/X+aR/Kxm7ih+Vm/MMNZv11fTBTE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680438; c=relaxed/simple;
	bh=PPdE3DCvnZiG0bdg8iqUEfYeo4GDdFBvSrnY6OyKuc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OaNQ7vvEmv2KqDf9C46+h9sr00e4fDC7XTuExeahyNeeWgn3thTyUKW8LBfxbHXtcfL+zXVvajV2aV2aoZeTOwhnxrUWjfZ9/ma2OmsyAiHHYrUtSTA/kqWUmrxEptOp3xwWRsARbADID5DCIqA40TZvb8+PSt7JtBnZyHyWuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NMsuTCO8; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NMsuTCO8"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3be3daeff38so1400964b6e.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 21:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706680435; x=1707285235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjonwnQ4Kkp0hlfAVU98vKu6Nb7/9d5YGb1ApRAN5a8=;
        b=NMsuTCO8EtErCANA8SzuPqoItFuhb+bybmC0fk0K57Zw0PBZTBB9db1LgFDz4rmkVO
         ds/j4grWxWZek+jVQ2suEJeptMjd5MJA9X3I+a/wCPVM2k7+9UBRwzeBpujlWbYRI2Xr
         geKDTVD4zzNKq/4t9ZlC3mL/tYhoGBvguTMzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706680435; x=1707285235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjonwnQ4Kkp0hlfAVU98vKu6Nb7/9d5YGb1ApRAN5a8=;
        b=WInDF9q9J7olcVavhtL81PwPBBuD9Ba7DmzIXEH1em8IIDeJkGJ0EWpZEGvghpNcJh
         TbApkPq4ak9gEqioGM4SCHKgqUeUhSte02G3nYICX/8u9qCDk0a8fk6c7bROsOcwpVTw
         ch5vEXmN0LpX+DjBQbBg6zCOCqaY8QQmTaRRJjS654MJ/Mb1onusIr8a/+DCbfh3/k0t
         bbG/FS+wJCYHZJ4IcQtIUiat3CiZuLLSbIa88A59jNmOt2XsQ5rAAkt+T1tzo1bL7CZ4
         t5F8UWwr0ptk5H75ATJVwAT9eT7+5VHjrkpxP4UejM1ZyiL4C7jr6vcyPsw9oB4S0cvM
         ZNjw==
X-Gm-Message-State: AOJu0Yy3PO2BSKzCwMT8NhhrWNKylgDaOMCstFCQbC/vMW05JyfU087W
	wGDCmPR1stXYFar641WtfUVNaxqcrgWrvdrSke+v3YR5T6lpEn2o5Tolz/DlbA==
X-Google-Smtp-Source: AGHT+IEF1C4QOuTiJ7v2HQi8nJWh2OEI1K0aKxwaYbd7H9eAtVhiKYUUQkbojB7Ll1us3OKvHsAC1Q==
X-Received: by 2002:a05:6808:1289:b0:3bd:cacd:332d with SMTP id a9-20020a056808128900b003bdcacd332dmr922025oiw.40.1706680435247;
        Tue, 30 Jan 2024 21:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQfpblXybk1dAHjHe/xpMXJ7FQELNtajY/VAipRIhK9hCXwJ06aSb8h76iv3mgyW7fSLqBn//L/nzB/ZlHUcOW+fMUlYqSOnCElaOXn6ld4wYNSr1R8if96rmRdFVVSRtAUbEObxgNod+zglY65y6FZ2Rx4XXCbzbeO7dcf8og7tH2Ys/Z
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a056a00271200b006dd887e37f0sm8920617pfv.210.2024.01.30.21.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 21:53:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] string: Allow 2-argument strscpy()
Date: Tue, 30 Jan 2024 21:53:49 -0800
Message-Id: <20240131055340.work.279-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5419; i=keescook@chromium.org;
 h=from:subject:message-id; bh=PPdE3DCvnZiG0bdg8iqUEfYeo4GDdFBvSrnY6OyKuc8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlueBtuN91rHXKUbh4l/HsZ5vDVbyRzx8eSqHY+
 SxmyFjzh6uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbngbQAKCRCJcvTf3G3A
 JurKD/0a35JlRO0OL0c3Rfnf9p1z3fXM2DKD/ZRqBLuwUELJ5VVZrOtGBYFnCiI7rOvyXQuRqgV
 WsnNZFKVslGT077eXpGoX/j3sOufEd7oOxrBRq6331cWPShOdkGjSa2P/EOskqVZLAPRPpkH4FC
 70lz9ZqasamorG7F8ycNJPMQvSK9RVcivyOmg9UDt78w77N97f9YiPsA+5G9eUXfSTeJ0Y/7EhZ
 zuBB0chZoUPV3+d3CAIZd975ESbF+Q9ENrb0ed38dGKPeFf5dFfzmwW1nMXElob/GBtdPACTwy/
 /ViZcYaYAZzMi+ptPO/LK74AQpT/p4l2ULyI8AGOpr6GgJgZQ4b6TdKxGmD5HkZ7vB18uGCt4y7
 oFNICPDqQ8vVnd+MJY5Mi811h+CdTcJ2LdtJMugk2vHKHigsFN21Q/T69x5Os39S1jPvf05CeXP
 K24OsEBB9p4WrZ8a5uESjOgP6Rjrl4wN1yoFGrZkZoHT6UBPv5HVU/tyG9C2DKg8rEwRH2zszsJ
 BFHDCJwm0soki2jEbnncgLWQtqhmU5mVjA/r8Y21M0D1u3LeNMi4Y1lQjuHWs51jAxX/25YgE80
 GwFzgoKfb7tOmsCjZ+Gx6spw70vrdOqYRGyiURknzuEiUU3gTNc5TvJuYEO4f9rZoNhsSOMvOlt
 mTHr1ff LPoiOn4g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using sizeof(dst) for the "size" argument in strscpy() is the
overwhelmingly common case. Instead of requiring this everywhere, allow a
2-argument version to be used that will use the sizeof() internally. There
are other functions in the kernel with optional arguments[1], so this
isn't unprecedented, and improves readability. Update and relocate the
kern-doc for strscpy() too.

This could additionally let us save a few hundred lines of code:
 1177 files changed, 2455 insertions(+), 3026 deletions(-)
with a treewide cleanup using Coccinelle:

@needless_arg@
expression DST, SRC;
@@

        strscpy(DST, SRC
-, sizeof(DST)
        )

Link: https://elixir.bootlin.com/linux/v6.7/source/include/linux/pci.h#L1517 [1]
Reviewed-by: Justin Stitt <justinstitt@google.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
rfc: 
v1:
 - update kern-doc (justin, andy)
 - include __must_be_array() for sanity check 
---
 include/linux/fortify-string.h | 22 ++-------------------
 include/linux/string.h         | 36 +++++++++++++++++++++++++++++++++-
 lib/string.c                   |  4 ++--
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 89a6888f2f9e..06b3aaa63724 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -215,26 +215,8 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 }
 
 /* Defined after fortified strnlen() to reuse it. */
-extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
-/**
- * strscpy - Copy a C-string into a sized buffer
- *
- * @p: Where to copy the string to
- * @q: Where to copy the string from
- * @size: Size of destination buffer
- *
- * Copy the source string @q, or as much of it as fits, into the destination
- * @p buffer. The behavior is undefined if the string buffers overlap. The
- * destination @p buffer is always NUL terminated, unless it's zero-sized.
- *
- * Preferred to strncpy() since it always returns a valid string, and
- * doesn't unnecessarily force the tail of the destination buffer to be
- * zero padded. If padding is desired please use strscpy_pad().
- *
- * Returns the number of characters copied in @p (not including the
- * trailing %NUL) or -E2BIG if @size is 0 or the copy of @q was truncated.
- */
-__FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strscpy);
+__FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
 {
 	/* Use string size rather than possible enclosing struct size. */
 	const size_t p_size = __member_size(p);
diff --git a/include/linux/string.h b/include/linux/string.h
index ab148d8dbfc1..c16430c7c043 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -67,9 +67,43 @@ extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_STRSCPY
-ssize_t strscpy(char *, const char *, size_t);
+ssize_t sized_strscpy(char *, const char *, size_t);
 #endif
 
+/*
+ * The 2 argument style can only be used when dst is an array with a
+ * known size.
+ */
+#define __strscpy0(dst, src, ...)	\
+	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
+
+#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
+
+/**
+ * strscpy - Copy a C-string into a sized buffer
+ * @dst: Where to copy the string to
+ * @src: Where to copy the string from
+ * @...: Size of destination buffer (optional)
+ *
+ * Copy the source string @src, or as much of it as fits, into the
+ * destination @dst buffer. The behavior is undefined if the string
+ * buffers overlap. The destination @dst buffer is always NUL terminated,
+ * unless it's zero-sized.
+ *
+ * The size argument @... is only required when @dst is not an array, or
+ * when the copy needs to be smaller than sizeof(@dst).
+ *
+ * Preferred to strncpy() since it always returns a valid string, and
+ * doesn't unnecessarily force the tail of the destination buffer to be
+ * zero padded. If padding is desired please use strscpy_pad().
+ *
+ * Returns the number of characters copied in @dst (not including the
+ * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
+ * truncated.
+ */
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

