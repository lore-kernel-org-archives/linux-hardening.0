Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4408AC4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 May 2022 20:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbiERUwe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 May 2022 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbiERUwa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 May 2022 16:52:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A16F4BE
        for <linux-hardening@vger.kernel.org>; Wed, 18 May 2022 13:52:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r71so3243792pgr.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 May 2022 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQEoNfCNz+zq7ard1iLbZvA8V/F/glMURm+vwsuWs9Q=;
        b=ikEbWrq1QvO0cD5nQ5sJCbdw0A7gqcLMTzDCG+vJAlcD4uEsaqUsKJOegm/S2T/Ebt
         /cfShJYdWF1SkAklANQ8vkPKUdTkEh7thdnNIWqaGglOBE6fnaH6DqBxNBhASnFxg3pC
         D/Ivr4CUsM1AAhl+xKax/0Gp1UyyK6EdZpx0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQEoNfCNz+zq7ard1iLbZvA8V/F/glMURm+vwsuWs9Q=;
        b=2Oi9nzTK8XNVzoL1P0uUi1Vr3qgRPYD/tUE7zCVpuNw50HOsEysrRZtz9OlK/7r3kd
         YqJQ1tSYTE4qbrBy8OR8w+nZiP4ikDrvZwDb/p2WlYLTBbutrvAqiKXUmDuKqdONBodi
         AdSBYJXfkN8cZuBCYthjwAr9clTRAXZj77Seey5yPF9DQOkzliF+0IrbgGKEFDwuGJb5
         Ww0SWZ/WYMrcy5hPB5I+u2gJ8kJ2J3+4mXma8ZZ6v6Oq27SjlJb8UjDukiPYg1UbXBDZ
         nmztodA4BvrYzSXXNbNSVcnoaVIXTpdEH921nMPtoV4T9pfHwSrDXQWkma2HZuPQBFIJ
         RROA==
X-Gm-Message-State: AOAM533scacvFirvDm+hB9f9f02IilHA9WS6+Bxe5TDJ2YWKEh1Ix6gL
        WHBazt8zxrUXEvdHhx9+legODZMlGu/NaA==
X-Google-Smtp-Source: ABdhPJyNOM/+xy9skLHXjhlfQSTn59Toz2JoxVig5i+UXhMiUsM+eNTFyQewWfo11RPTnuUDHggi6w==
X-Received: by 2002:a63:41c1:0:b0:3c6:e382:c125 with SMTP id o184-20020a6341c1000000b003c6e382c125mr1029348pga.383.1652907148455;
        Wed, 18 May 2022 13:52:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b0016184e7b013sm2132387plg.36.2022.05.18.13.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:52:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/2] bitmap: Fix return values to be unsigned
Date:   Wed, 18 May 2022 13:52:22 -0700
Message-Id: <20220518205223.2908736-2-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220518205223.2908736-1-keescook@chromium.org>
References: <20220518205223.2908736-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9640; h=from:subject; bh=A9h0iGW+o8mMGv8LcfYnkc4CqQ94dA0Qq+cwea24/TQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihVyGlDacumFlXPw08iJ7ikCMSrsc7B7JNAnsPdkY IixvxFKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoVchgAKCRCJcvTf3G3AJrhvEA CvqsKWbwW4ch2+yd7nBDv+2LbHz1w98qurkOz+wN86+F+BUnI1EBNDWIu6avnShmFkFD4owy1/JnNf 5PtPqdSkFPFa4VHym9Hey/IDvQAxL9vbT0Kb4iwi42XuUq2ZL3sveDJMLlJEjNRtY42DklFgsDLfI+ 1VYPFFkT14on0pjhb0bERIJN3koLgb9RDoT4zlwfPVA5rHkl4bbkNafY14Ng98BbSlo6mnTiKun61M 8SEZGWDzdjbqUuGffJiAJefqopzAtHb9u873B7eSuIxBBesC9bcpDPgxlpNpoJYM9puCi+oeEKhdWC cmCmSBxBKyi0d9lvWmZVwAj8B0UMh5IODVqRJe9shQguN4U9OFSF3Zpq4bUFCc3E+ovIeUErQ3zKBm f3k92qXTJxG6M4Pyrdu5WNkCcyIOJMkBRQZRp2//JqyPm8C+afLdDsAkMk8IddsIpDo2UByUL2kAhN O2HMfZVvKl6Avvb+unk2Az5dstfJ3TatuyFb7KbqN96F1LnbRNFYGiKAvCJA2Gw6xrcLkhrzaB7Vmw s3Jiw1vsSX6bTHvTa2J3PpVwTnXrkZtJs17x05fjrFnqX3f5vLyfoFoyEFaJ5d0+LfEIwnXzVQvdsW kqZlb+KIBJmtc05i4GPFMQQtBF/HsWhPxU4zeOqn/3xZ9IywygoVaAlaMfMQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Both nodemask and bitmap routines had mixed return values that provided
potentially signed return values that could never happen. This was
leading to the compiler getting confusing about the range of possible
return values (it was thinking things could be negative where they could
not be). In preparation for fixing nodemask, fix all the bitmap routines
that should be returning unsigned (or bool) values.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Christophe de Dinechin <dinechin@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/bitmap.h       | 25 +++++++++++++------------
 lib/bitmap.c                 | 30 +++++++++++++++---------------
 tools/include/linux/bitmap.h | 17 +++++++++--------
 tools/lib/bitmap.c           | 20 ++++++++++----------
 4 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7dba0847510c..8303eb5604ca 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -132,8 +132,8 @@ unsigned long *devm_bitmap_zalloc(struct device *dev,
  * lib/bitmap.c provides these functions:
  */
 
-int __bitmap_equal(const unsigned long *bitmap1,
-		   const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_equal(const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int nbits);
 bool __pure __bitmap_or_equal(const unsigned long *src1,
 			      const unsigned long *src2,
 			      const unsigned long *src3,
@@ -157,10 +157,10 @@ int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 void __bitmap_replace(unsigned long *dst,
 		      const unsigned long *old, const unsigned long *new,
 		      const unsigned long *mask, unsigned int nbits);
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
-int __bitmap_subset(const unsigned long *bitmap1,
-		    const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int nbits);
 int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
@@ -331,8 +331,8 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 
-static inline int bitmap_equal(const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static inline bool bitmap_equal(const unsigned long *src1,
+				const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
@@ -362,8 +362,9 @@ static inline bool bitmap_or_equal(const unsigned long *src1,
 	return !(((*src1 | *src2) ^ *src3) & BITMAP_LAST_WORD_MASK(nbits));
 }
 
-static inline int bitmap_intersects(const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static inline bool bitmap_intersects(const unsigned long *src1,
+				     const unsigned long *src2,
+				     unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
@@ -371,8 +372,8 @@ static inline int bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
-static inline int bitmap_subset(const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static inline bool bitmap_subset(const unsigned long *src1,
+				 const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 0d5c2ece0bcb..2692fd43c125 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -45,19 +45,19 @@
  * for the best explanations of this ordering.
  */
 
-int __bitmap_equal(const unsigned long *bitmap1,
-		const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_equal(const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] != bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(__bitmap_equal);
 
@@ -303,33 +303,33 @@ void __bitmap_replace(unsigned long *dst,
 }
 EXPORT_SYMBOL(__bitmap_replace);
 
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & bitmap2[k])
-			return 1;
+			return true;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 1;
-	return 0;
+			return true;
+	return false;
 }
 EXPORT_SYMBOL(__bitmap_intersects);
 
-int __bitmap_subset(const unsigned long *bitmap1,
-		    const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & ~bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
-	return 1;
+			return false;
+	return true;
 }
 EXPORT_SYMBOL(__bitmap_subset);
 
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index ea97804d04d4..afdf93bebaaf 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -16,11 +16,11 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
 int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int bits);
-int __bitmap_equal(const unsigned long *bitmap1,
-		   const unsigned long *bitmap2, unsigned int bits);
+bool __bitmap_equal(const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int bits);
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int bits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
@@ -162,8 +162,8 @@ static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
 #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
 
-static inline int bitmap_equal(const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static inline bool bitmap_equal(const unsigned long *src1,
+				const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
@@ -173,8 +173,9 @@ static inline int bitmap_equal(const unsigned long *src1,
 	return __bitmap_equal(src1, src2, nbits);
 }
 
-static inline int bitmap_intersects(const unsigned long *src1,
-			const unsigned long *src2, unsigned int nbits)
+static inline bool bitmap_intersects(const unsigned long *src1,
+				     const unsigned long *src2,
+				     unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index db466ef7be9d..354f8cdc0880 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -72,31 +72,31 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 	return result != 0;
 }
 
-int __bitmap_equal(const unsigned long *bitmap1,
-		const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_equal(const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] != bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & bitmap2[k])
-			return 1;
+			return true;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 1;
-	return 0;
+			return true;
+	return false;
 }
-- 
2.32.0

