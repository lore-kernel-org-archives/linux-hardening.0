Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D1418359
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467867; cv=none; b=DRiXV54ZPWGDMsP+odNeA7fZdZLPZSQdAEsshazdRh917fvUm46k9eKdf15NX6+TupH0fbX2K7kh2/+tsyDC3dUHtXbJuNezKiSximHiEXXZpz6rSZpizYFzIQmggYDTxOLzICHnI15eLk3HH4uLU/vWLWQW49pfo+yO3E4R8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467867; c=relaxed/simple;
	bh=0mPWZrRtMVPeUI6XJyCqfL68axEeDCO9y1H3650V6jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rao0gZczEwQFPzoDiHZYhY10uGLswL5B8hYObY2qEKgWa+F5/3t5Yzydit0avTXY1l2A3pXLd7fhmw35+tmKWQyvoZPlZeAHaMXEshFvZJA/+P40XORcOVhJjjXqsUPvw3BBVsFMiyQaFBxJh3nTNLCgsxbEqXQ5FCJFsLWlMlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlDKEkbm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlDKEkbm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48436251906so335924f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 03 Sep 2026 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788467851; x=1789072651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TnjfNvCLnsTvxUWLkyT6RSPdRaY1HQsFa2V6exB/dnE=;
        b=LlDKEkbmjzIPcmLHIn0nsLH3JOroRmIAlnQOEqzvZtYimCF2vOWPYGCMONkFaArlU6
         5YjN7srB9za4Q1c7pJeBcF3HVbzWvJeqmdF253nFzFY2MURKYbeX69VD8zaqQ/Qrfpk/
         c/saUAVyYtc4Sk5g5nEB6IRz9XBPiQrqz996ok0kEZ7d4topHpEYgzP1LCIC2N7/5nzo
         TA2RfnwDzl5ykB/THYwqtt2ClzLww/+439dCVE6p2HK9ALAAtTRmiJa2ufS6YNxVvRy/
         2T8Ri4YHJhBzLScPeIPCVDv10xl1W126rBIRG1Aj2d2kXf5hsujcVPgAfMTIAovY8OAD
         MN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467851; x=1789072651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TnjfNvCLnsTvxUWLkyT6RSPdRaY1HQsFa2V6exB/dnE=;
        b=Jl8Pc0x1396ZUz55FfLqWdVIXARL7XrEjQ3+BsvQRIpL4JdA0fqJz7k3QhjjDVdmfI
         A7OJmhbVeDE5AFndEtIWNeaqD6+7PGCWD0vrXzk6wtmFZTVuEyKfz/aEaOLdKF5VSxTf
         OSq/BCELH3wAtM6QQ/fliACulPfWxyLnLTq+zXWmMZRlDCeuUVxHWYay/G5mTNLOuvO8
         /w3vFWh7OAotxuEIardjOZyuUEwnfDYNFrxQlGL7/JXKdekt83SsNqo15+d5BBzGPh95
         TIOlezoxrSJYrDjPsXSHVDiKkdIqvN3eMTskvlGty0oy5YdaPWsAkAw/3rmXjTJpYkG3
         tvFg==
X-Forwarded-Encrypted: i=1; AKwUvBzZb3CQb8KrED5HjR7aq/ct25nEyQTQ6H32fFrRzYLtPSJF2oq7QDzszFCrevjWTA9sATTCd3qG+xVXFDMWdis=@vger.kernel.org
X-Gm-Message-State: AFuF++lEq1H0eSm5Erdv1Ad1EWBHbyssC2e6FMVvfp1LqTuIqJs1RiOc
	kNo51dXsRq4Nn137h8aocmBlKYBW2YY+yysu1NC7jsfot0ajulaq/PWFyl1rtemj
X-Gm-Gg: AYBFou02rjeHOw8dAr37UBdPy/1z3+dID/6/i6q41S/aMx14iVfosafJ8o2JBSRQFN6
	PqHBQECRRx5n1QCHtvFOWrD2BLF8yoGAH8wiH6OFOPpNdzp4sib4Ht62yf6j/9saTTKQLd6k7N0
	FkWEcvsQqSQmaad7fHJR/lIU6GQY0N66146DlCYnCkkNxOKrYSjrhzJiNERBiAd2EWodA/eXg9n
	/c6bpdb0BumT9vZKCqjNMWkNsUzmKupx8G3/7wo5VdeSAteBIYjq2GXoqPga1IAbs+q4m4G5zFH
	/OMl9DDsVRPmOjOz4XXEGLwn9m8PNZUrO0xqFlFIKRqN2hDT6ggFkGEjK+sgcV8LQoqX5jQt68u
	XmiaLuIzC93lNd3liYzl7SGgsbbvSyltBQV7BCWSJL4WJSSzkILhhzqKOjfmp3r9mO72cv6i7T9
	z26eL0wqHCjWFVsTZuThJfMbOp2Gob7Bje2nSm5AivyUiHp+NJ9WxbAW5UOdQwvnDRz6uWdYV59
	+VUwGx0et11yWgmEw1o8wMc3NoyYbrb/rnaIOHx9iH3sycR1Az6boBOWQkvLV8tI9qb9VcouLy8
	tPEuyOq57LMQlNaWFMagvbURUKZIluSkYNEBr4EZE+bB1dCY7mqsPfolssgA2NJakxlTVCggQFN
	s8LynENTt8wqP37gW
X-Received: by 2002:a05:6000:4b11:b0:485:8313:9f47 with SMTP id ffacd0b85a97d-48587055d09mr3572292f8f.10.1788467851379;
        Thu, 03 Sep 2026 13:37:31 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm1005070f8f.8.2026.09.03.13.37.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 13:37:30 -0700 (PDT)
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
Subject: [PATCH v3 2/5] slab: check for ZERO_SIZE_PTR by exact match
Date: Thu,  3 Sep 2026 22:37:17 +0200
Message-Id: <20260903203720.63689-3-kmehltretter@gmail.com>
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

ZERO_OR_NULL_PTR() returns true for every value less than or equal to
ZERO_SIZE_PTR. With the sentinel raised to ARCH_KMALLOC_MINALIGN, up
to 128 on some architectures, the helper matches additional values
that are neither NULL nor the sentinel.

Compare explicitly against NULL and ZERO_SIZE_PTR. Store the argument
in an unsigned long temporary to support both pointer and integer
address arguments while evaluating it only once.

This also changes check_bogus_address() in hardened usercopy: nonzero
addresses below ZERO_SIZE_PTR no longer cause its null-address abort.
The rejected window was incidental to the sentinel value: address 17
already passed the old check, including in s390's mapped lowcore, and a
principled first-page bound would be a separate usercopy change.

Apart from hardened usercopy, direct in-tree users apply the helper
to allocation results or explicit sentinel values.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/slab.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 563dadc16d82..458c4229b1d7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -273,8 +273,12 @@ enum _slab_flag_bits {
 #define ZERO_SIZE_PTR ((void *)(ARCH_KMALLOC_MINALIGN > 16 ? \
 				ARCH_KMALLOC_MINALIGN : 16))
 
-#define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
-				(unsigned long)ZERO_SIZE_PTR)
+#define ZERO_OR_NULL_PTR(x)						\
+({									\
+	unsigned long __zon_ptr = (unsigned long)(x);			\
+	__zon_ptr == 0 ||						\
+	__zon_ptr == (unsigned long)ZERO_SIZE_PTR;			\
+})
 
 #include <linux/kasan.h>
 
-- 
2.53.0

