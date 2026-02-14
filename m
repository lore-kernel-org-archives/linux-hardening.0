Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4B225775
	for <linux-hardening@vger.kernel.org>; Sat, 14 Feb 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771077085; cv=none; b=ZEtcT07rzS42MrW13sEvJhLeI88WF6SqmNrhKE0GK1Vc2lD+0pn6O3HQ5qFhTwm/jLn+7A7M+ZuYq+L12mkZfUaJHQKtM427V7Y9UZCecnDnfeQl4PShb9hH+DGcNedS6OTycfKc5ZwFjDhalObNfmnXFTFL444F2rGYA8/fSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771077085; c=relaxed/simple;
	bh=VhhMkue9iw773rpzEZnIsBzM13biep36V6wC4o1vBRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ko/oj28VJpiJ1j7iQFb71QK8I9AlfI4YjsrTbfahnTT6ON9xs5vooQiYT/r+Zf9Fu8eUlJfeVHqUmh4Pwpwix4+R3KBC/rlP4OKg5hvCniV42HnzOXbTrrju0/xka9ktORM6ZXXuXKktV6uDkMCCDbPJ5hAz+rXgZMYuj9j8b1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcB936YF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcB936YF"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so1485380b3a.0
        for <linux-hardening@vger.kernel.org>; Sat, 14 Feb 2026 05:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771077084; x=1771681884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQIh2dXleF0tXd7fC57g6s194jlP8VKSVaVieQRVdm8=;
        b=hcB936YFgcu6XaKuhRbKHcVddyNCgfHO+DGlLWt4Xq3En0NhV1cv7eD+awGlPbNzlL
         0402+O4B6GkTvdyyKWmoRQT8dzSF9udLPorj8oMDUM9eY1CMXutRF8VszBnu0Yr4+ihR
         X9X3wQZw11PfyYBMtDLFVTxR3XSz3/vxsvG41fzeIG+ErTQnSCWtLLftMB3NKNDODGgY
         1lO7uyOmXPs1PGPj9XBifz7z4dfIOZ1RrpymPqBJBCCPuEJBoYxYP5fghgIu4pCNwX2x
         ADZTlnlaQ5iPai4Y0yZwxzA8LVG3/eJdZdD0qdwATwvmy4Sz1m11kQbTadiDfNVkPYih
         cdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771077084; x=1771681884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQIh2dXleF0tXd7fC57g6s194jlP8VKSVaVieQRVdm8=;
        b=KXgbKdEqHJ7xa0xwcAkrYIAuq4Xazawe4xpHz3bUwCJ2XE/PPnS6U0kKfwQDJyR0Kw
         NrDPPoAxWePzxbJg5ekgebV5/MmVO5m29byH700b1zisuE7BUbtPMFqSXOQbcOOz5km5
         TL0UB+D8q60Zx875tuxU2NOjnJGl+GVHO4sJvkb7wnEboE+uArqUfX+irFYaN02uqJ8r
         4RSLxK1ATLWwt+SWywGRfpGbcBshm7JawYymAB7u62cTlVI2dF1ifb1IKBxERS+Enk0H
         sgpoO0UCP9wkQnSPdJDkfb2OFLxQ4JszP3bpNJdyBaAjO0ADQbORLi3rw6/iKrpQJGtB
         Zy6w==
X-Forwarded-Encrypted: i=1; AJvYcCU9i2ULz5p2JWZPeZ0Zfz14lZi+EEbBz36yEqKPnre76whBuxX60UjLU+XLCE7z2/LpzgNCF93HJX3oQ5Qxzlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBBkAN+1kQ0K6BTXNyvksXMWb0z078pmJL6gbbYD2lgIPfMtA
	pYpnhZYDr36vfk942q92sswlfcw1ROU32RVBoLk99fhvJBfdkFgSjDZl
X-Gm-Gg: AZuq6aKX6UH1kteeCUEhhN4VRcxEpPcC65J4kRNeIcO9ubsxPXCd3LGLtTrcf/4ERZi
	V60omLDkO8rgGUUhrOsFTUV7uhHDuR4I4M6AVcbtHfhUOxz0XnAkl+/o8X2fegSo28QptnmclfR
	DNp7dJ1YSblqYrlQpVf0HG1BiwtfBXuONJlN1zEe+l3L8H6me0a6Lc6ZHKp3KHj0h6t9iSTs+J/
	NXMLw5uOkDRBZuMk5H5M4/r4k4BdHQCRMKF4PDRrTG14ebpsCXP4WWRmu1GG4ToHaR83gXDGwIV
	1h7L8mdKS7Cl3WO1sctPI4cqKBOi0GTuNH+BwjQXVLUVD8vFmrd8QSjlszP6l7+xyX+BgfLJa9o
	jW3H7RNDE552v4DcnfHvqhVqmUFkQOIWQc25QLqqxHGxTzBtFyuKSW5h6WbOWov7d2mO0nxK5mB
	CUyvMHtYUG69RNiTVFT91YM/CnOeVwCS5b33Au1Aw/jwotmkyM+g==
X-Received: by 2002:a05:6a00:2282:b0:81f:3fa0:8c38 with SMTP id d2e1a72fcca58-824d950050fmr2803920b3a.20.1771077083584;
        Sat, 14 Feb 2026 05:51:23 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:8817:dac0:96bb:43ff:fec0:e782])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2e936sm5433761b3a.6.2026.02.14.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 05:51:22 -0800 (PST)
From: Samyak <samyak.bambole07@gmail.com>
To: akpm@linux-foundation.org,
	kees@kernel.org
Cc: andy@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Samyak <samyak.bambole07@gmail.com>
Subject: [PATCH] [RFC PATCH] lib/string: fix coding style issues
Date: Sat, 14 Feb 2026 19:21:07 +0530
Message-ID: <20260214135107.595089-1-samyak.bambole07@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add spaces around binary operators
- remove spaces after casts
- Add blank line after variable declarations
- Fix constant on left side of a conditional expression (0 < count ->
  count > 0)
- Remove un-needed braces around single statements

Signed-off-by: Samyak Bambole <samyak.bambole07@gmail.com>
---
This is my first linux kernel patch. I have compiled and tested the
changes on QEMU. I would appreciate any feedback. Thanks.

 lib/string.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index b632c71df..8f5582d9a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -127,12 +127,13 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	 */
 	if ((long)src & (sizeof(long) - 1)) {
 		size_t limit = PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
+
 		if (limit < max)
 			max = limit;
 	}
 #else
 	/* If src or dest is unaligned, don't do word-at-a-time. */
-	if (((long) dest | (long) src) & (sizeof(long) - 1))
+	if (((long)dest | (long)src) & (sizeof(long) - 1))
 		max = 0;
 #endif
 #endif
@@ -150,23 +151,24 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 		unsigned long c, data;
 
 #ifdef CONFIG_DCACHE_WORD_ACCESS
-		c = load_unaligned_zeropad(src+res);
+		c = load_unaligned_zeropad(src + res);
 #else
-		c = read_word_at_a_time(src+res);
+		c = read_word_at_a_time(src + res);
 #endif
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-			*(unsigned long *)(dest+res) = c & zero_bytemask(data);
+			*(unsigned long *)(dest + res) = c &
+							 zero_bytemask(data);
 			return res + find_zero(data);
 		}
 		count -= sizeof(unsigned long);
 		if (unlikely(!count)) {
 			c &= ALLBUTLAST_BYTE_MASK;
-			*(unsigned long *)(dest+res) = c;
+			*(unsigned long *)(dest + res) = c;
 			return -E2BIG;
 		}
-		*(unsigned long *)(dest+res) = c;
+		*(unsigned long *)(dest + res) = c;
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
 	}
@@ -261,7 +263,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
 	dest += dsize;
 	count -= dsize;
 	if (len >= count)
-		len = count-1;
+		len = count - 1;
 	__builtin_memcpy(dest, src, len);
 	dest[len] = 0;
 	return res;
@@ -380,6 +382,7 @@ char *strnchrnul(const char *s, size_t count, int c)
 char *strrchr(const char *s, int c)
 {
 	const char *last = NULL;
+
 	do {
 		if (*s == (char)c)
 			last = s;
@@ -679,6 +682,7 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
 	if (count >= sizeof(unsigned long)) {
 		const unsigned long *u1 = cs;
 		const unsigned long *u2 = ct;
+
 		do {
 			if (get_unaligned(u1) != get_unaligned(u2))
 				break;
@@ -690,9 +694,10 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
 		ct = u2;
 	}
 #endif
-	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
+	for (su1 = cs, su2 = ct; count > 0; ++su1, ++su2, count--) {
 		if ((res = *su1 - *su2) != 0)
 			break;
+	}
 	return res;
 }
 EXPORT_SYMBOL(memcmp);
@@ -737,7 +742,7 @@ void *memscan(void *addr, int c, size_t size)
 		p++;
 		size--;
 	}
-  	return (void *)p;
+	return (void *)p;
 }
 EXPORT_SYMBOL(memscan);
 #endif
@@ -805,10 +810,10 @@ EXPORT_SYMBOL(strnstr);
 void *memchr(const void *s, int c, size_t n)
 {
 	const unsigned char *p = s;
+
 	while (n-- != 0) {
-        	if ((unsigned char)c == *p++) {
+		if ((unsigned char)c == *p++)
 			return (void *)(p - 1);
-		}
 	}
 	return NULL;
 }
-- 
2.53.0

