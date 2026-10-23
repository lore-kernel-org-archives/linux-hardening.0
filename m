Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720219;
	b=ycghz2h/IkX85AKkSIr2uo0PTTC58UI6X8yj6dKDdMAyO6SJB7YCyNDlU9eVJhf4ul73
	 IM1Hv9ALxSXt8kWr+PWggmkPAhUCaxV6/aytAplZn5L0Vvfm1NaIuFNoA3SBDXHUYdg8b
	 Vv9X3cubVEHYEKpNQ+nQ11VI5Slpky7SMvp4+0xCebUHGTWoAHEx65yEoIKHWUqKJYJia
	 2fHHwScfzShcSQKthRjYvnKS/avJs842+J43rFCzawmModl9AaReORCPesDDz5HHbgg4o
	 tCh9C7ZG4Tu/JtLva59NGMPL4DMhM2sX5GZ2fa0qaCi2d3ybFWOVj98XPeeDHwul3zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
	b=ktpUhieoS6RanGqLaj/yw4F7MHau4egm13eJb+kUlN0T/CrdqW1DnNxk/ray09Ck/As2
	 fx2VDk38m0S6TKp72XQnpPkcVo/X8yrpj0OGj7TzUr8cOCxZzvQ9ihZdLp4jC/xGbFGkZ
	 2jpRk5wbjz1mLDx1MDtnstSxk4ENsqttZvOVKXSIGjLPrbLv7iHeQptomXTjNL3a09dUv
	 mEKjHLyqo4b8gvJzCXdxmS3EViDNO2M4Z2DFxEypq4V1uIsxEHMhYIHaDnFplu1XA6Yz+
	 sbOd/1txQ0VBTbOPYJAPBZ22kGxIQEu7Wnm8CNjUiXzaYYw77LNz/QonPlUbvhaQTaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rp8a0nB0;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE00606A31A
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 01:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rp8a0nB0
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35943f55c06so452039eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792720218; x=1793325018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
        b=Rp8a0nB0sJ+TJDR4hlmpgIpdVyGie5oBwLC0PFdydmMtqnyLfTvFup4nWx4OJIpd2D
         /0nqKXWsIu5jqq4imY11lyfjYev/8OExuK7Q/OxHuhOu+pzzZpTTeTiYx/F49RMSUzmt
         GccSr96gdC2DqGPOsPztHQgBSqn1ACJig8rztK0kgxx6Gea9Ck+5Xlj61UOtcZIedsp9
         2K8Mmg1SrottEj+86QdTk9X5iO+xMAXf8q0Rsd1uy/ZXcFhOOPsyHifwcG2ONoxKcfEW
         CpkDdF+5YUGAXHkpwXQORt34Ay1acS1LK0wiHEEbMpZhAYUW7HX3YNCtZr6OkoJjolGz
         H5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720218; x=1793325018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
        b=tn6b+T6JxZWMxZGu+emAicUqYiiqQoQAsTh1m3+asELupc0/0W0zH4IbrKlicY7mZz
         qfG5TtUMbswt27l4YFp9kAlkQv4RIqIenm53waBknMI+lyJM7/UVMFQJO6F7Q22fZCId
         H/+uDAhpnD/oqcuGJFwtndjDvSVIePrzI/PZIG1ocyDQ/ZjE7DUDV245p+IkQ3QLGfOv
         1FQgSPiR3tMnHC4fNFL7dORnebPZmeOSXZI4vvShu3W9VaHRc81SgClmR9J7XuPWm1Fg
         1hxsnKfnfST1WgkyYk6uwN1Gc8DZ9FfLmzBzylqmB8zfiucQ731y3us97r44z5Wh8q0f
         8vVg==
X-Forwarded-Encrypted: i=1; AKwUvBx9PCHP9k0GIm7tOAnILbW97MRZdli9PGicYDSxrMmfcwpcR+EpBYHKxtCKznuMOxje2mCt4bfZh1CebQzbrww=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6DlE1D6OXV+Hz76r96suQs2gOrXxStU5xdFOGv8J48gaRqMk1
	Rkrb298AfXleNlo8yK1ZeabTUlcvdLYiffCuwkqM0E4bPrgFb6LgmVBdKhu3wmv/
X-Gm-Gg: AYBFou0woviXA6+P1qjdd9kLDblsbr/ji5u5o119V9jJ0YJYsTf3ZBOmv/JnlcVNaOY
	iws06aLexL2lRjVnZ3csp2wivy+YoPdvUuCgj6QSCd0Nokt2XRPMcVReIoRx19mlsZeKKMJ6cSw
	rrmFr2dEXdN6uvVQ9K/r4WpEcKKPPC975Dpj2PXEg5kV3mBTwSsCW8GLis9g1a6bBNgjJjZi+/w
	m6qB+XcGT3kmM5toLuPPTwSNOCyzW+MAC/TuWPQWvv8c858O8vP8bKD666OZRNDH21V2qEJvBf4
	2uQ0isaDDB3tKv02ht6Eiwx0EHzqASDhQ3LQ6oMujIMnD5YVLYkLj+37wmMIkLVcqvYWckuXD4U
	5OFKDfJLCPu1xNyPtaLC8ySnVC6TXZYsB3vMN2mrtXmPcoNmyz9/7KRk8RmEPWPKA3Edt3YIZIv
	EdCDEWp5cAV2wqy7OSyRFR67TSNWLrM0Tp0WGGAvtcCS1/rFpoZprhRnJJ8GzmgEH68y7Q7mXOG
	Byj/1JuggH/2sSowWOeMa+kKxBSQYtTes5eI12Sgx6pc3tdJDQ=
X-Received: by 2002:a05:693c:69c3:b0:368:2c6d:ddfe with SMTP id 5a478bee46e88-368afd86765mr4796119eec.9.1792720218428;
        Thu, 22 Oct 2026 18:50:18 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c0e60dsm1971091eec.2.2026.10.22.18.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:50:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 23 Oct 2026 09:49:49 +0800
Subject: [PATCH v2 2/2] kasan/test: cover load_unaligned_zeropad()
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-bug-word-at-a-time-zeropad-kasan-v2-2-be0ecfbae847@gmail.com>
References: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
In-Reply-To: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
To: Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

On architectures with CONFIG_DCACHE_WORD_ACCESS, load_unaligned_zeropad()
does the word loads of the dcache name compare and of path name
hashing.

None of the KASAN test cases reads memory through it, so nothing
noticed that KASAN did not check these loads at all.

Add a case that reads a freed object through load_unaligned_zeropad()
and expects a report. Skip it with hardware tag-based KASAN, since
arm64 turns tag checking off for this load:

  kasan_load_unaligned_zeropad, x86_64, generic KASAN
  without "word-at-a-time: check the first byte in
  load_unaligned_zeropad()"                                 FAILED
  with it                                                   PASSED

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 mm/kasan/kasan_test_c.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index b9e167ed5be32..c791512f6fc49 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -28,6 +28,9 @@
 #include <trace/events/printk.h>
 
 #include <asm/page.h>
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+#include <asm/word-at-a-time.h>
+#endif
 
 #include "kasan.h"
 
@@ -1673,6 +1676,26 @@ static void kasan_memcmp(struct kunit *test)
 	kfree(ptr);
 }
 
+static void kasan_load_unaligned_zeropad(struct kunit *test)
+{
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+	char *ptr;
+
+	/* The tag check is turned off for this load on arm64 with MTE. */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
+
+	ptr = kmalloc(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	kfree(ptr);
+
+	OPTIMIZER_HIDE_VAR(ptr);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
+		kasan_int_result = load_unaligned_zeropad(ptr));
+#else
+	kunit_skip(test, "Test requires CONFIG_DCACHE_WORD_ACCESS=y");
+#endif
+}
+
 static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
@@ -2264,6 +2287,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_alloca_oob_right),
 	KUNIT_CASE(kasan_memchr),
 	KUNIT_CASE(kasan_memcmp),
+	KUNIT_CASE(kasan_load_unaligned_zeropad),
 	KUNIT_CASE(kasan_strings),
 	KUNIT_CASE(kasan_bitops_generic),
 	KUNIT_CASE(kasan_bitops_tags),

-- 
2.43.0

