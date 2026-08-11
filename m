Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFC448D1B
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457575; cv=none; b=Hf4HQGJHhXOm1GhRlV6TF367W2mJFh+IgCV0ho3AIa+CceX9uAHk/kH+6fIP3EIHvb6LS88dEQSN6INuH4L4KLsiQrPFIudAa7gBUWY6nSBd2414fFzDz5VkqwAcqVRWPiNHTy4ak7csKtdjMBT9/A1ty8A6z5y3Ep+UyqGCUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457575; c=relaxed/simple;
	bh=LjIubD3Zg+wcYFo41RfpwdNGP6TjBzaPkrqdHz0k0BI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6KPsZOTKgfTqpbW3W2Ia9EhlKDCaIad1RTztRn4THoxs/KmB/Vh5WnMVWSrstjkhQHFsL/mz3zt85Ltpr/nJJIaAGTJV8ed/0buUivaGOcs0HKBO55DNAD6XuvFJT1u7Pnz0KPdaNb/vnWx4nhvh2KCFuOvBkMw0gLle5MB55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYL6kqQ4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYL6kqQ4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso29949275e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786457572; x=1787062372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o80QnEVKUcuUdd3OZFAdxnODo4B1zikCcE/tvO9NxHk=;
        b=PYL6kqQ4cap3W/M0taPR1P8+0VSxhpAFQ082G8vEueVauFYcRZwN6eM49gXJJ8jQLA
         CZxBeXlPvkzBbRSFWkm7NwhKwlhlNvowEfjLuC9/wYQwt0x3t3DZMBRpoPnRPPfa5DV9
         KIkZs8C9qwZBluNiEUQ/Vvn60He2lhn7V1TIlAK/sM2+TKmevgb3lJJvbdcOlBfzMxfR
         RD52Y6D7mriNNHzGzkxUQzfPF+oVzaqmDq/n4VnGMmwtfaktpVYMOYSPB4yFuim33aOg
         B3on0epkL9FF1H24jBeuxt0c5omPBT71hS5Czqn9YgJtxPuMyM+/tjE506tlAJRbveW2
         UnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457572; x=1787062372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o80QnEVKUcuUdd3OZFAdxnODo4B1zikCcE/tvO9NxHk=;
        b=qR0njuB/9HB80E0cpkAPLO2G65zApta7n9J/6Bw2emZqE/+F4nh3u0Savm6o8hFJlE
         FwBkc180fDwwQTHOJACQX9MiJx6YHga1QvRfY9dYDj4Nuu0iDLnBZgepZ7M29jAAGOZC
         YwNTptyqnLUL45QC9fTfMHxytfrALyGFUVhwtX/F1vj77TAVmoZIml28OXWHUE+ecHsS
         VpNz0by6oMQpxNfXnvjGbz/FoUmGkdvpYPTOYg03Yy5sKqErVwsZr4YzBgXnb9Ce4OK+
         pFDQlT1jxSDhwKYhidNuJ6EC1NOuAiIk5WyXsAynsmZjes8d1OKjRHTGDluubNLhSjGF
         tYhA==
X-Forwarded-Encrypted: i=1; AHgh+RorKGdnnqZ+9NVb9nfxHgNdwKQCownAHcJL5Wr/otHndE/qcDXSsdthY6coBgUJCCbcjZDPfYmUgpS7g1WOqNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitSvxbvLPhG4SrfqQ9R7p5lUUtl6x5XJn05ED/rF5RZG9FpGC
	sqmaeOz5C8+CLWzGE6F9kPBn4CbkwTvCcx3uE0L2Mvx1RgIIMjLS4d/2
X-Gm-Gg: AR+sD12uA3ThHondOzfSYB9jS0g1TkI+TVK4nfR6YM6IpJoKpp9PWMR8PzAT+x6X3FD
	Iwix/zxJKmiRdZ+J+oVy62plQh7w5R/ui+lDFU7TlknGK8EEwMyd6L2it4NGmCmzYhyi2Sf3Sm2
	R4oPD8ydhW54uTUGbdg5rxQSYiOm8e6OLh4O68eBf0eck+sq7zhObZwL5yiTSETNMLK4pZh+Cb5
	o1UXprSnx6OzMfqCTvBCCLAZtBTvokAojkq3E4bdD+t1EmENQav85XPE1HXBmylnaTi+RfHtJUr
	5N9mlx8D8Dj0Pajw9z6/oLa7jjr9rqFinBWN9bLzZNV8njljUj0sDfhn0arP0Ew3Xt4jQ1RYELm
	46NB647dNAI0v/rG9v497hfJS5qvAQm5MVHjOYNaYvCsNb+QP8XKViQf1GM+dBhdfJ22fgjqtAZ
	MbB0hMfk13KmjRO1V3dAUi2VLC64EyZWO375d4aDPOs8JUX/mtgXfTpLQudpez+TBrR6gQJeTii
	yrWZLmJ+9pfSHb4UsIJ5PQ9o1Xx6Wgnkp5mZCouRzgU3gID0xWssLC0ToknLRbsN4JB6UH+CO4E
	uZo6jkWLJuA6VRc9aUpuKD3MdNOwxxc6XBZR/xGPwjEFOnIkttMkS6SBL2wEe+ijwQ02DpiVEQ=
	=
X-Received: by 2002:a05:600c:4709:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-4997844c55emr61209035e9.10.1786457571515;
        Tue, 11 Aug 2026 07:12:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5be29fsm4464099f8f.12.2026.08.11.07.12.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 07:12:51 -0700 (PDT)
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
Subject: [PATCH v2 3/3] slab: test zero-size allocations in slub_kunit
Date: Tue, 11 Aug 2026 16:12:40 +0200
Message-Id: <20260811141240.62519-4-kmehltretter@gmail.com>
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

Add KUnit coverage for the zero-size allocation contract, including
ZERO_SIZE_PTR alignment and exact ZERO_OR_NULL_PTR() matching.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 lib/tests/slub_kunit.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
index fa6d31dbca166..a02fc6b401e3e 100644
--- a/lib/tests/slub_kunit.c
+++ b/lib/tests/slub_kunit.c
@@ -380,6 +380,48 @@ static void test_kmalloc_kfree_nolock(struct kunit *test)
 }
 #endif
 
+static void test_zero_size_alloc(struct kunit *test)
+{
+	unsigned long zsp = (unsigned long)ZERO_SIZE_PTR;
+	void *p, *r;
+
+	static_assert((unsigned long)ZERO_SIZE_PTR % ARCH_KMALLOC_MINALIGN == 0);
+
+	p = kmalloc(0, GFP_KERNEL);
+	KUNIT_EXPECT_PTR_EQ(test, p, ZERO_SIZE_PTR);
+	KUNIT_EXPECT_EQ(test, ksize(p), 0);
+	kfree(p);
+
+	KUNIT_EXPECT_PTR_EQ(test, kzalloc(0, GFP_KERNEL), ZERO_SIZE_PTR);
+	KUNIT_EXPECT_PTR_EQ(test, kmalloc_array(0, 8, GFP_KERNEL), ZERO_SIZE_PTR);
+	KUNIT_EXPECT_PTR_EQ(test, kcalloc(4, 0, GFP_KERNEL), ZERO_SIZE_PTR);
+
+	p = kvmalloc(0, GFP_KERNEL);
+	KUNIT_EXPECT_PTR_EQ(test, p, ZERO_SIZE_PTR);
+	kvfree(p);
+
+	p = krealloc(NULL, 0, GFP_KERNEL);
+	KUNIT_EXPECT_PTR_EQ(test, p, ZERO_SIZE_PTR);
+	r = krealloc(p, 64, GFP_KERNEL);
+	KUNIT_EXPECT_FALSE(test, ZERO_OR_NULL_PTR(r));
+	p = krealloc(r, 0, GFP_KERNEL);
+	KUNIT_EXPECT_PTR_EQ(test, p, ZERO_SIZE_PTR);
+	kfree(p);
+
+	/* Only NULL and the zero-size sentinel match. */
+	KUNIT_EXPECT_TRUE(test, ZERO_OR_NULL_PTR(NULL));
+	KUNIT_EXPECT_TRUE(test, ZERO_OR_NULL_PTR(ZERO_SIZE_PTR));
+	KUNIT_EXPECT_FALSE(test, ZERO_OR_NULL_PTR((void *)1));
+	KUNIT_EXPECT_FALSE(test, ZERO_OR_NULL_PTR((void *)(zsp - 1)));
+	KUNIT_EXPECT_FALSE(test, ZERO_OR_NULL_PTR((void *)(zsp + 1)));
+	KUNIT_EXPECT_FALSE(test, ZERO_OR_NULL_PTR((void *)(zsp * 2)));
+
+	/* freeing the sentinel must stay a no-op */
+	kfree(ZERO_SIZE_PTR);
+	kfree_sensitive(ZERO_SIZE_PTR);
+	kvfree(ZERO_SIZE_PTR);
+}
+
 static int test_init(struct kunit *test)
 {
 	slab_errors = 0;
@@ -404,6 +446,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_kfree_rcu_wq_destroy),
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
+	KUNIT_CASE(test_zero_size_alloc),
 #ifdef CONFIG_PERF_EVENTS
 	KUNIT_CASE_SLOW(test_kmalloc_kfree_nolock),
 #endif
-- 
2.53.0

