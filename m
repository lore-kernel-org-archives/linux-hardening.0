Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB733CEBD
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375122; cv=none; b=gbXadO9q6oEJWO3071EwY60SOFxbMFHlpIY+4QTVmjbh0jqeG5apDY8BvH2CDe/DinEPgHaOcBeEAuuRuouwPc/Ef2Cf1pUrHse02/SLcvjSixQ2nnYw2CsewdBb06i4cMFKb4T++Jsrb2WwJ4BKy+6u3ULaPj2TFKucU/QJhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375122; c=relaxed/simple;
	bh=J5mMuI/2gP0v9ch0ANotvYhKJbiRS7t/s9fMyFsvGlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQeKxU8Ka8IonPXdj9lx6799fzGEIl/sve9YluH2Gic7d0Abh42d0N7c5Yy7Zbh3a+WRnVLmvDdei7P6NX1AvhVxCo/fdeH5PlfzT8hjwdjt/adhGGQFdVpZcFTFI87K5imMk3zOo8ZXIjTHJM5sdqqxeLCkUzysgKJW2xdhjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEm+MKtx; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEm+MKtx"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so3275639eec.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 18:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375120; x=1792979920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX3gFXGtK0qFC1+jmqNQ0ZBmFVgyc6CU75RzS6mT9B0=;
        b=hEm+MKtxGYdBQVuoQgTh2WX0Qa0qpPJ96tGhdiMZijcVuKqWcUXJukO24kGlJtGQEv
         MVoUQ7B/kzItelKX7K1NFaQ3F9zVcqEW+P50ei1uqv8YgBbl4iEeWLw/bdFfPFWXOGFJ
         e28i6BB+2w/qbWoWARaJvQOE4axLFJHuhO4nuKNzXUy/j7fjL9721/eKTBi+9mPPRPqV
         +2Wo3jE21ypjO6F2tfwQqMBlr1U1X+NDZXDikosaZWjfmDAXDxhyrf8aUcQZexT/kid8
         Cb+aymvn3O6EiAX2KdlRV7+22yqA0N316FiFJ156HqNQDUA/vkw92ZkrkAvmgPIeP/kL
         WN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375120; x=1792979920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eX3gFXGtK0qFC1+jmqNQ0ZBmFVgyc6CU75RzS6mT9B0=;
        b=c98q1i1dnl3uItA3CY+FXIlyavg7ydidR6Ud/48uAcxYM4bEZ7CJsPcFnQQhwK/Bg3
         on7PWfXbedvTwYvi7Bq6FUfpptpVbCiq15BwdINmv3TDH9k+L0G1DtKCz5UkOpSLlAQM
         QLtyu+mbTI4KQjnKnDLomqeMsuDEMea9m0VRH98OL6DluZ+j/TdO7jNZjbj/s1hyvko+
         ZNdJqULGLT/A4ENApo8BtzEkjubnDei8tQ4VO7gFvR4ILiCdpAxWSTEuBXKIGnMb5BRe
         g+8vyk+zY7knHO3Z+s8+5Nv4GobqnAV5uLYCMV8PTSiokr8M287PR0AIeEeCdcEkQ0kI
         38Pg==
X-Forwarded-Encrypted: i=1; AKwUvByUGgT6+5DJNjnWlTosZ9bcKecW707Nof/gtef/WM/l+QzKws2UUTxTPRaqGkvPP8sY8rKy3DliWqdWHRVh9Zc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLekpGC7w2XMqKcjGsvq+0MulyyWcsdf1IixoVPVLOiYggPM2sA
	VjB7k7VC4O3Bwf2vtV4NK50V8Zhc5+S3nfm1PP4BaYlV9dZFaV8heCR2
X-Gm-Gg: AYBFou22WwCoV2ceWY8UKC5H19xnntzuaMB9UUgP8BmDHj2Gz/4xTaWc9xjm9EZpKf7
	yWrS1Kw7zL1Ahuv+FkuB/7mx0aY44WrtfbWbymWCt+smRXHgd/FW9/8AzL2CMLesAOkHv0SkmK7
	J67JuOOH9IVGAEZObiOac2iDmjuiDDNnvtdEtT45iPr7rfHsGRmGNOVjx+lG7H5Lq3+doGALfCC
	r9vo0iBcDsIX3KKwb92MKYgjOEQLCQ1YoCAylu136b/YksDeTZUhSVzb1Vmy7SsxHeXvYBVkD4i
	ACthring35Ye7//ht2GjSiBzgNH3jDG8LiOm972diU+Iez+TJRxhbVq5WchbPXqvS6n9EPuHSdo
	GXKOfHVcgi9cWufaswpCcpkjF4IihrzL+YRrJyGtgvqxBmu0/0oLju0nWyPBwhCCJmbnCEzByHW
	L7LOlUwRxLtJ4NoyC8VCx0BjrjVWFnJjNv+HAwLmfuWUfEA7h6vCAEiyQR3SvWNQLKeg==
X-Received: by 2002:a05:7022:b057:20b0:18a:d0b5:fa42 with SMTP id a92af1059eb24-18ad0b5ffc8mr1432273c88.19.1792375119985;
        Sun, 18 Oct 2026 18:58:39 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm24177311c88.17.2026.10.18.18.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:58:39 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 09:58:10 +0800
Subject: [PATCH 2/2] kasan/test: cover load_unaligned_zeropad()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
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

