Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539711865EB
	for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867787; cv=none; b=HyC8SBFMsjUC/+ZnVEfLrIlP1DDnumS7jETjgfdj3Kecl9r+ioLVp0eHLiFHNg5+WbfB0ay9pN4C8fo92xVjm5ZYXWnlNHxpCcYX2ZBLbUzLIzZCvvNAI0X5uw73n+yKRFFJ0xvIN1GTvs4NR+ILFNZSyaH1fXRaIOOLJWWeVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867787; c=relaxed/simple;
	bh=3Ssal8wO83LAvy5YDPICfixRHLNHOiETBBH4FyiHuA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VLJJKGGSJ9s7vXQJhtIa1E90lwX4SQvWTeDWaCWoSLOAdfRrTqf7imG8IMndPlpadlJsqz19gfnU9gEDghcp+fOJhFnJPS5NWg2vSGNp0rMKAAi8/Rqcfp7rOoO7Q0qdLH18NkFCquYnrpkmGOsNVd4sjXqfHHAgsncJOLVK/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ai6+ezQl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ai6+ezQl"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso13552215a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Mar 2025 18:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742867785; x=1743472585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbmWscRvAoMTscJ7YX1VjxJzdFRKT7QCMrJKO+SUNOM=;
        b=ai6+ezQl3Qry/w+DxlaCoWIW9hEYsT4UsBt8KqEaJZNhdBrqxfeUL5iOnecn1BG2af
         EDg+0uY07u1qxYRJm70E/0pvw3WHrhgIm03yhFAInkZ0AWiHuPsaeLZNjBxImQknNCl+
         wGSWVWYNj9NYBxnRyEMs9tMXspQ0/lVdFIVD7U2E9y8rsfWZL1hamUHIAomkRpuArI5M
         1B7Q2+lO7gGqNZT86Li/L2a/TImIAVPnMhFxB1HcRN9nsmQlQBfuRo/K7CXo6VkRUbEp
         JlZfOmuFE8+7711ikI/TgVPcJJccPyg5l+e0CV8lq3t3Ap31uK8YqGeFrkaBBZkzNULZ
         +/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742867785; x=1743472585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbmWscRvAoMTscJ7YX1VjxJzdFRKT7QCMrJKO+SUNOM=;
        b=WL6zmrJL24r6rhUDrEdF8DjAPTaspU334QCMG2pi2lXmBGqjl/BbnxzV4kS8MfXgQS
         SuBZvjf8rCT6re2Z+K7jS8GBcoWqyVIyl0s4dTexH/VI/nIwTdqvOwLz9engoGUmQuZ1
         4yk4E4kxvPrzSQ9RDydNKAYJ6+zXg/C6s4UOz/tY/FhJhEdwTKC1a43W+FGTvl2I6jLf
         BaY59KZsqOQZL3ssizt8zbSIKDMOKz90ADgs1ybWSnh03NjaRZrIp38JKBxHI0jsKror
         9OpXSnT85RZ3Rltbjjte7zGZrVDrZ1P6bvBBXKWTl/ErYMTCUnNB27HoFZzXsXEHKKro
         F+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcipqMxi75Ap6THU4S8vYvzZz545QT1DZ0m6ITjA/b4j3Z3zwvGXem/tp8YWqj6J2qDWI42aBnDPTWJBAsEfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDS3GSLXS+8k/FEzOUAKXB7KbGnwl964Rjg30LeNcDnUOzlrq
	gE/lqsbL4yjRg2VgVwH+jtjCz4znAcQu5R8M5ocwbn2SoqryWYNOxINcIUb7E21g9Q==
X-Google-Smtp-Source: AGHT+IHw/mFa4K32w6FBmgVCLK0lfqwfx84tHmcbhBFHdeJjTz1GHC7yDdmMbL5MTLDA5q8NZ++fySA=
X-Received: from pgcu63.prod.google.com ([2002:a63:7942:0:b0:af2:3541:76e2])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:113:b0:1f5:874c:c987
 with SMTP id adf61e73a8af0-1fe42f2c872mr24619131637.15.1742867785611; Mon, 24
 Mar 2025 18:56:25 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:56:15 -0700
In-Reply-To: <20250325015617.23455-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325015617.23455-1-pcc@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325015617.23455-3-pcc@google.com>
Subject: [PATCH v3 2/2] kasan: Add strscpy() test to trigger tag fault on arm64
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, 
	Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When we invoke strscpy() with a maximum size of N bytes, it assumes
that:
- It can always read N bytes from the source.
- It always write N bytes (zero-padded) to the destination.

On aarch64 with Memory Tagging Extension enabled if we pass an N that is
bigger then the source buffer, it triggers an MTE fault.

Implement a KASAN KUnit test that triggers the issue with the current
implementation of read_word_at_a_time() on aarch64 with MTE enabled.

Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Co-developed-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If88e396b9e7c058c1a4b5a252274120e77b1898a
---
v3:
- simplify test case

v2:
- rebased
- fixed test failure

 mm/kasan/kasan_test_c.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 59d673400085f..b69f66b7eda1d 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1570,6 +1570,7 @@ static void kasan_memcmp(struct kunit *test)
 static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
+	char *src;
 	size_t size = 24;
 
 	/*
@@ -1581,6 +1582,18 @@ static void kasan_strings(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	src = kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
+	strscpy(src, "f0cacc1a0000000", KASAN_GRANULE_SIZE);
+
+	/*
+	 * The expected size does not include the terminator '\0'
+	 * so it is (KASAN_GRANULE_SIZE - 2) ==
+	 * KASAN_GRANULE_SIZE - ("initial removed character" + "\0").
+	 */
+	KUNIT_EXPECT_EQ(test, KASAN_GRANULE_SIZE - 2,
+			strscpy(ptr, src + 1, KASAN_GRANULE_SIZE));
+
+	kfree(src);
 	kfree(ptr);
 
 	/*
-- 
2.49.0.395.g12beb8f557-goog

