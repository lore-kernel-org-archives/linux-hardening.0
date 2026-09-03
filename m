Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5C44839F
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467865; cv=none; b=JivKKC0nUQ3xfIRE05WnEAcW7LXZhVQLarSe2JmCmlyG2aVKpr557lV70DWywdkEEaZ6ouxwh/uaQzJsGqQ8BlXPXkRw2T9xf56cqvkSwrlYPtmJhiVZ+6mpEq6uNHoVViCCwgVs7F+c/bDF/yw9Z4c5aL9T2yEfWWsZTbeSpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467865; c=relaxed/simple;
	bh=mDzPWkMoO7yK7FwJIXdb8RjyDxLK4UW08E3phGRlvnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZgRtF7nrOIT9CxWUrS58HfwhqM8+AXM3Iu3HewnTXHfXF25Ee4mlwHbG5OTGe8rFyycIbaVCgz0aNlY9En9qvVlGt+i/gSGkZXubFUfotnOoXBYhJFiDkmqrcQD7D6iO/PyuFArk1JNPsuWYfzW3Vh6/7+tp5l6bgn7DjwO1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phZhNiB2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phZhNiB2"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4843f205a5bso234975f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 03 Sep 2026 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788467850; x=1789072650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0p7OiT9IYtJ0QF28DnbFmBCLEmI8cNswVbeL0gIZVk=;
        b=phZhNiB2JPwOVzfbjODU/rVBuCzEUk1yfw11MHjwlCgydOdqH4cYudgljkt9/Or4Jp
         Bh1dCCWwe2fV3EDwbj1VEW/UMU6KW+g5D8Y6/Xfn79UDSn2WuVHtn5PM1LneBBkfXKZW
         6AOZAXCwECymuAf6m03WlDwRD8jjP3AfNcC2G4jIbs9C2cGoOjUhVHrtNIzw3CFPhe4W
         ZARFTQPAehdcg/6uzqwVJ90PSlZM1ZVKAHKdhLIq9jf4I4zzDkUScuPzhNo5ZN3RinAI
         grAFU6CEAVwvARcBri3M9OHoCTiNFNRtuLNekGhKVkdr39zMrVbOTrFFpgczcxVr9bLB
         3v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467850; x=1789072650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0p7OiT9IYtJ0QF28DnbFmBCLEmI8cNswVbeL0gIZVk=;
        b=PuMGAae/MPgyeiDg6k0qm6uOUzPYIL+jgwN3aYyURoAvciZ1j77X2Dw9wwHcoFb9F8
         dm0omo9MAMhcCec0E4as8e9AI3bGuGk9Hcgq2GVZK03P4libfMrhQhlbs1xqRTTXx8E/
         uLOq3j6tRsJwE1KlJEfKHsDqJWIZsTig/IJNDACRRH2yshsibqrCkHyO23ErQbRWPg1t
         BvAi8Ayfsw2dJFsKM2rUUxbJbCP5dZIyyuo7sMzSO2a5xCJ5plQleQVMtagq2KJkdrel
         6HV85gxA3IS0apBAoEbhuIRpvkC0dMVECFbP/qkDIVHCakqkjasAYSZ3xzozVfUiQt60
         ITOg==
X-Forwarded-Encrypted: i=1; AKwUvBx6A+0p3J7y5Qu9G9e+FHOhZ2Cp+4NAlGzEnziE61phG+RsubojMWNrJJECADFJRK9BP3NYb3B+ty+sJTtXLJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lcTbXh8UumY60JQzUP+6ysTb/SOyvB7jXEePfUP6J7CuJVuVNH
	0pzqL8owzmfDDThpLlJmgizUUwqJ547BMAxTNZ/n8f1BtdFaaj5wYXPH
X-Gm-Gg: AYBFou1e5WliTp4F8cxLZ3HaQNi2YLjC70Yvhx7AMaZzAR99AXCcBtraU9aycN/LWnu
	7mL13Nins1g3mekEgniKwIUBdwHiMd8dAmhzQmCt6cDBAkWA8b6SmIKRLwrG4ynR6wKVbn0bWkY
	4kGYQG0FX5XQsY3TcfbO3fzxjCEYmzfCfW9DcdxB5OeoGapmCw9sBBn1PmtYPRJujEapJQWLPgi
	RKmcGnQ7JpV/JxjZufLVUyWt3Sx02KCtsEkx+lPjS2b5C8balV9yTGvolBuQ8Y6JYOXqlFn9HiN
	bKOLmp31/fWNvYaQCQcfOe2gf8WCh/rTLB3zwYRpO8Lq7jhZbK6e1KnPtxn2FjNx3gs1BXT79Pa
	VJuXujuDGpIYra6ZKfpJXqNfap28/kwgWmwii0YpmUSIFKfFMlMpY3EG2G1rtlXYbATGNi5th+7
	L/sMSZlqvy+vxlATBi808rB7B/48pa5kS3YmzYG0BalqS8zwGz8lUCVDF1q/dQilLN/lOy7GxTt
	DeEa33Pv3RXjnzAMp9ZtnVN1qkwHOnYvLWn9ypsXWjMSLZltYfH092UWv0QS2bREc34deeXf9zR
	myufALKs3ZhEezELTuZr9X0bBZaIydmhc7WG2//3ll8BAbzlhvCEwZOm0HB/ufMfju0j+EOYHul
	Fi9hI
X-Received: by 2002:a05:6000:46cc:b0:484:3f15:15f2 with SMTP id ffacd0b85a97d-485872bbf40mr1870059f8f.24.1788467849852;
        Thu, 03 Sep 2026 13:37:29 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm1005070f8f.8.2026.09.03.13.37.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 13:37:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 1/5] slab: align ZERO_SIZE_PTR to ARCH_KMALLOC_MINALIGN
Date: Thu,  3 Sep 2026 22:37:16 +0200
Message-Id: <20260903203720.63689-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903203720.63689-1-kmehltretter@gmail.com>
References: <20260903203720.63689-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kmalloc entry points are annotated with __assume_kmalloc_alignment
but return ZERO_SIZE_PTR, currently (void *)16, for zero-size requests.
This violates the annotation when ARCH_KMALLOC_MINALIGN exceeds 16.

This can mislead compiler optimizations. Clang's UBSAN_ALIGNMENT detects
the violation on armv5. GCC and Clang retain the ZERO_OR_NULL_PTR() range
check but eliminate an exact ZERO_SIZE_PTR comparison after an annotated
allocation.

Define ZERO_SIZE_PTR as the greater of 16 and ARCH_KMALLOC_MINALIGN,
retaining the existing value where it is already aligned. Assert that
ARCH_KMALLOC_MINALIGN remains below 0x100, the value of LIST_POISON1
when POISON_POINTER_DELTA is zero, so the sentinel remains distinct
from that poison pointer.

Fixes: 94a58c360a45 ("slab.h: sprinkle __assume_aligned attributes")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/slab.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index cda126def67a..563dadc16d82 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -262,13 +262,16 @@ enum _slab_flag_bits {
 
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
+ * It satisfies the alignment promised by __assume_kmalloc_alignment
+ * and keeps the historic value 16 where that is already aligned.
  *
  * Dereferencing ZERO_SIZE_PTR will lead to a distinct access fault.
  *
  * ZERO_SIZE_PTR can be passed to kfree though in the same way that NULL can.
  * Both make kfree a no-op.
  */
-#define ZERO_SIZE_PTR ((void *)16)
+#define ZERO_SIZE_PTR ((void *)(ARCH_KMALLOC_MINALIGN > 16 ? \
+				ARCH_KMALLOC_MINALIGN : 16))
 
 #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
 				(unsigned long)ZERO_SIZE_PTR)
@@ -625,6 +628,13 @@ static inline bool kmem_dump_obj(void *object) { return false; }
 #define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
 #endif
 
+/*
+ * Keep ZERO_SIZE_PTR at most 128, i.e. below 0x100: LIST_POISON1 is
+ * 0x100 when POISON_POINTER_DELTA is 0, and no architecture currently
+ * has an ARCH_KMALLOC_MINALIGN above 128.
+ */
+static_assert(ARCH_KMALLOC_MINALIGN < 0x100);
+
 /*
  * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
  * Intended for arches that get misalignment faults even for 64 bit integer
-- 
2.53.0

