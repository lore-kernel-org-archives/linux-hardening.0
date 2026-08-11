Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90895445AD3
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457570; cv=none; b=K1S6ASiP13gOTtMheNfpv3JXYdTxqOTW5REgLgNQjyItOSsL3gQ36IxmPhWJqcpqLbsDhlLZcHhR9mF9yfxwBGXEQs0UGo8EaBO8gwr0woCmyWMnttHNlkYBTp30Wto2zB0g1InuzKYTtn+XBNa3Oy4P3NgP4diPpbyhiJe8YkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457570; c=relaxed/simple;
	bh=xWPijaXXRIkBoc/QHjewJtmMl0ZST5M/cYh7D7YQf7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B81qV89B4cOSBEtXzv00cnMvtfJmub86qiLSGCZKrshGKaLXWIC78jyF3KyFihYle+gVIHdDDX1LylCJZpdLB+RGMBO85EuOXmLSaIA6kU/SxkTTDYp5+01rIT99Pgfy+vhE39QDbi2df1peJTTt4JZ1bRyRB7xZ+lzyDTXmhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUoJI9Wy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUoJI9Wy"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1755222f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786457567; x=1787062367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwwTg+OQL0Tw8flGAD/WL1rLA9ceEVBQqkqlLz//DPI=;
        b=WUoJI9Wy+9wEoLJwRJtYDA1Z77UP1Vkv22JSs9gcDUxhZV2KRxdzyKD8oWYX8B7EQr
         nDUC3uO4GYuGHvtK0feifQR2BE5BX/cMElOXycjKZr0VONCTFtkBoSf0pfc15kTkgLK8
         OwJKZp+kSuVcCrOKmNSYkZhTUhtWNp9rS2FSRqkO/jpMH/rzyK8E7uQpjeh8l10SlCZs
         F1Lbgh4l4pxBPb5y9seR2rwLr6Im+0+txzwXrLGzehXN3b37W1FkYlLdvupNqGDBvsiL
         tyI9+cx5SZohZWEGlAFbFmiK8C4IUsB0m0NEghHSqCHcAwi5IAc8/CAmVMUwiYUoh0mj
         wGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457567; x=1787062367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bwwTg+OQL0Tw8flGAD/WL1rLA9ceEVBQqkqlLz//DPI=;
        b=NfLYTIaUuygkJHrrc73fq+79U+3Sw8NsmDaWFaGecNpbF4GrhGIM8ZgoFEDKX1S/Os
         3T90GzIL0hvNCDW1IxgLm0/ziLuubX6l0uc6JrqyjHdG22MSIFv9Ri6I4dpBGh21XCw9
         CrNXpJSqc8RmmDtO6CFXkghR7DZeNhtf/A8cZ/S3tRr4A5lUz8lycjK5hFa/Lo/ObxMG
         gRS4sWUAJlQOGnO4LEuUapqf2eJFjhi+0l7hbCuImhtWFl3SbWOE0B/NDYf3+aB7/ENd
         sRbJxOBwsf25Q2ue0TStHli/0Cavs7yO5bxkR7Qc9UgCzWS4LXKhwHYmDr/5IL2vataR
         Wd9g==
X-Forwarded-Encrypted: i=1; AHgh+RqAW4/Lzf8X7XxrnssFHxNJ3YMEXCd2unPZpuP3LRLuNX+qmNsSSlZFTzP5F+n5Tdbmr9dvTTGMIsWObFy5qEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrF+DTH8mIQelNdZePXw5UnGLFpQrizXH2frH2UhuAC7XtkES
	PAeVvCWZ/Ux+MJ08VfbKgWkT/5mM/0RSB+ucVnfxfa9yVMuHDcD/bBiK
X-Gm-Gg: AR+sD10/uH4vFZ94Pwmxxuoc+2DlViPLXIrAVB6z2QH6LAI2yqreOyoTphonWo1eWMS
	BnpkOn6uofWYWxkpKTG78Yvvj5GnyYS4XGXFTbjLSCovmznust57adOhbRYNgYhIpK9ui1GSbP5
	5vsrPwBHfvyLzRD3Z2VMi60qzfEOPMpbVLOZNJTUj4Ct/7JVtKwowIayjepyDcfKg16AC6Y434t
	f00/eOwha8Ra5IwQs0FAQHM4J1lMGQdNJF1TEyAV69tOdchIXWxH8JgTcuYaBjZv41KWPxctSkP
	ZMobkzA5/WRO6+If/v+aDnHGA/L5FesGXddK/fhszgNmEue5eM4ztnIbcfXTNf9pW2Y2KGyK9rz
	EtvUWVZ4NVbGCG5mNxQq6ntKskS/WEp8/H5nWmIGBm0YI0TKS/luFDTZPRM7t9g+zftoo53BCfx
	xmaodsJaXq/xFzutX0DYR7LpAu+cARnNfVLaVxge4Pet26vRIKTjZYeoMzCjWiQxqk1jXpL72za
	k4YIxXZyXdqtp9lM+xzPPeAVC2k4b0YerOfhMPwPAl1XUCsUCGRUobVQXzLYPFKKytEVep1GxEV
	rJGZukAo8YRsDsgGIlgUebFiSfKtntJ7AZ7V1O/tyWxplEZZtRyK1ATIzBgUXuH4pYzj
X-Received: by 2002:a05:6000:240c:b0:47f:6dcb:3737 with SMTP id ffacd0b85a97d-4814aee3ef2mr5025916f8f.29.1786457566359;
        Tue, 11 Aug 2026 07:12:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5be29fsm4464099f8f.12.2026.08.11.07.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 07:12:45 -0700 (PDT)
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 1/3] slab: align ZERO_SIZE_PTR to ARCH_KMALLOC_MINALIGN
Date: Tue, 11 Aug 2026 16:12:38 +0200
Message-Id: <20260811141240.62519-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260811141240.62519-1-kmehltretter@gmail.com>
References: <20260811141240.62519-1-kmehltretter@gmail.com>
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

Clang's UBSAN_ALIGNMENT detects the violation on armv5. GCC and Clang
retain the ZERO_OR_NULL_PTR() range check but eliminate an exact
ZERO_SIZE_PTR comparison after an annotated allocation.

Define ZERO_SIZE_PTR as the greater of 16 and ARCH_KMALLOC_MINALIGN,
retaining the existing value where it is already aligned. Assert that
ARCH_KMALLOC_MINALIGN remains below 0x100, the value of LIST_POISON1
when POISON_POINTER_DELTA is zero, so the sentinel remains distinct
from that poison pointer.

Fixes: 94a58c360a45 ("slab.h: sprinkle __assume_aligned attributes")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/slab.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 32c9f8ed7ae20..3e012cc4f001e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -259,13 +259,16 @@ enum _slab_flag_bits {
 
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
@@ -622,6 +625,13 @@ static inline bool kmem_dump_obj(void *object) { return false; }
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

