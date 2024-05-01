Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251F168AE4
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606193; cv=none; b=GBcC5Z5j0y0A9IufhUJhPCt5YxQeMbRA5/Hmpu+frv+FdXg4TRo0lvA80TX0OP/AKskqXaOXzd6TbqPAo8W3NyOWi87jKEF2NuOA6vRJcm8bmeV9eeobPBVQBYavSIw/OxKYeBzeQJguEUzQjjVQFmheB1Ky/FlatqoPkkP0vF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606193; c=relaxed/simple;
	bh=4yXGVupLk19qBVTQBEk549iroBDGqX+1k4Vl05US0V4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZqXpqvM8WBsP5ZKHEn3TwqoTCgPHz08Nk5amuAdeSlPEU5pYpN/HU8EdkbSx0HR6tt9lOmhx8R06GM4bkGDl8tT2lug2Vg59PT8xvvcBbutDBtR6FnrYrg8zdmH23BQDlRb8vil4ReR+Mva5U/N9pjVpVxS4LsX4qUi9Y1jGErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bW3mr/RQ; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bW3mr/RQ"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23d7b0b0a5cso644618fac.3
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714606190; x=1715210990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dISoR/F5tfj4gTzAljBl0G32nuqdqdDkvElUgLUPzE=;
        b=bW3mr/RQGLji9yLzEcpbVK4VQL1iCTwN4Jv8FfH1R1V7hPzydoHRGgEnPgdZKacFgD
         UdqZq8/Pnar95dT/E7NGaYXtLPh8nxJqkBlMzsn5zqoC9b1lHac83oUkOQR295wESgLb
         dG43nbtGUHBA1RZwKWk+0UiUCh8ueayloHp/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714606190; x=1715210990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dISoR/F5tfj4gTzAljBl0G32nuqdqdDkvElUgLUPzE=;
        b=NDdquVvuAUGGFIKFbd1renO39YWmvXenWBTOlV5l85j3XXfc+t1ofIvTVBhR12I0jh
         tPCmKE1gYsr4lB43ML7GMEyvd1pe/mpKSfoeWBi1QepSQSzEVPBkU7iBTZGtnne0yeoC
         3dK8+gE9txmRgZEdexvlvUGM07fkwUSZ+LhCMejWLw8c4wEHrsCIVrkNACRsTvT/BHi+
         ne/QRxkekhl2EUpktDfWcvruNRcN8/hIxwHRaQKgPAOfIvYgfulAoUYUH7Yv6JLhRXfM
         OUm+hq4WRh6endxjfrbx2QKQ6oz/Z5KvS4p2FnkSKMcAIerd5qMmvmob9nFG5qnoJzRh
         Xq7g==
X-Gm-Message-State: AOJu0YwxfUT+FnHd5EKgjMQckJrGCAnjmOl9DmbrrxQkIP50xhOHKfRW
	S1AzIoOi0uskeh1ETyX/sldMqDkSxHTTApQ5ayPZZryGlF10b+/Ci1q2nh0ARw==
X-Google-Smtp-Source: AGHT+IFxrmXP1FPmykiQaZKkoA+c8VkJNoSxMdJBCA6PH9qSYW8eOS9grinif8S4SkabK8KpuqGivQ==
X-Received: by 2002:a05:6870:b153:b0:23c:357f:c475 with SMTP id a19-20020a056870b15300b0023c357fc475mr4763058oal.38.1714606190280;
        Wed, 01 May 2024 16:29:50 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m20-20020a634c54000000b005ceeeea1816sm22885951pgl.77.2024.05.01.16.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:29:49 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/fortify: Fix replaced failure path to unbreak __alloc_size
Date: Wed,  1 May 2024 16:29:48 -0700
Message-Id: <20240501232937.work.532-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2983; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4yXGVupLk19qBVTQBEk549iroBDGqX+1k4Vl05US0V4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmMtBswx0QYtZ0rs+tmVZCkrxjpdO96z9v30SuQ
 PXQbvHvF32JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjLQbAAKCRCJcvTf3G3A
 Jv0cD/9rjTr4nf4bUtgCGuLeGwUkaR7oehV53YB8I7E7VSAL09bqN7jFS15qKdHwtFKfif9iaxe
 SMck57SSDFpDJuynhJ+i/zIsVMLZPtIC1YM/qXxhdkMDnMxUALOttDuJ+nM0s53k0DT3NpSb2ic
 q+zxhuCMUjgOOTN+YY4S4qpaiMU8pC6e410vM/pJoTamsfuShEg0qIwcu0LXQbzTzaFRlm9Ghgr
 3qr91BJKm+JyDdJgO1UQZJxZggaKHP9qaRIBC8m1aMrRAOWTY+Gc5SSSrSvFvGPGVmydMSDEROc
 b1QbMtc8Mqso2aQX8mP0gYUa3CbmKw4Gd0T+Or9wLYa9BQaX/qbYN4SP/u5Eaw657wDu7us5V+4
 KMifVOHHL0LTCk3mplJ2NCOA4IFoQVPqlAb+8jdBtKFaPjxqP38nwwBWVmNX8OYVLVVkqDK0pyQ
 Ypm05AvNT0YtH8SCKkJoNcvXJlszHzO+WuCgDb8cMCqRFYvpf5qWowwLHzoasgixd31sEiHu1yZ
 IH0JEWPRVks3+HGBDZAWhdtSExkHzTVqs3aQQ/MSbFhcxj1xGi7WMlx4UgAstOpM4JECpcgodPM
 bH76x1iR5kZow8RNky8zpnPQA2GpsFi7zx8IROfMSiRUkmDfqBVkgve4yY3+yAJTbvbiRJmhviY
 M7dL0Y+ zS/WXqew==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The __alloc_size annotation for kmemdup() was getting disabled under
KUnit testing because the replaced fortify_panic macro implementation
was using "return NULL" as a way to survive the sanity checking. But
having the chance to return NULL invalidated __alloc_size, so kmemdup
was not passing the __builtin_dynamic_object_size() tests any more:

[23:26:18] [PASSED] fortify_test_alloc_size_kmalloc_const
[23:26:19]     # fortify_test_alloc_size_kmalloc_dynamic: EXPECTATION FAILED at lib/fortify_kunit.c:265
[23:26:19]     Expected __builtin_dynamic_object_size(p, 1) == expected, but
[23:26:19]         __builtin_dynamic_object_size(p, 1) == -1 (0xffffffffffffffff)
[23:26:19]         expected == 11 (0xb)
[23:26:19] __alloc_size() not working with __bdos on kmemdup("hello there", len, gfp)
[23:26:19] [FAILED] fortify_test_alloc_size_kmalloc_dynamic

Normal builds were not affected: __alloc_size continued to work there.

Use a zero-sized allocation instead, which allows __alloc_size to
behave.

Fixes: 4ce615e798a7 ("fortify: Provide KUnit counters for failure testing")
Fixes: fa4a3f86d498 ("fortify: Add KUnit tests for runtime overflows")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 include/linux/fortify-string.h | 3 ++-
 lib/fortify_kunit.c            | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index a0bb13825109..85fc0e6f0f7f 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -738,7 +738,8 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, p_size, size, NULL);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, p_size, size,
+			      __real_kmemdup(p, 0, gfp));
 	return __real_kmemdup(p, size, gfp);
 }
 
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index ef3e4c68b759..306522fd0aa2 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -1002,19 +1002,19 @@ static void fortify_test_kmemdup(struct kunit *test)
 
 	/* Out of bounds by 1 byte. */
 	copy = kmemdup(src, len + 1, GFP_KERNEL);
-	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_PTR_EQ(test, copy, ZERO_SIZE_PTR);
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
 	kfree(copy);
 
 	/* Way out of bounds. */
 	copy = kmemdup(src, len * 2, GFP_KERNEL);
-	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_PTR_EQ(test, copy, ZERO_SIZE_PTR);
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
 	kfree(copy);
 
 	/* Starting offset causing out of bounds. */
 	copy = kmemdup(src + 1, len, GFP_KERNEL);
-	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_PTR_EQ(test, copy, ZERO_SIZE_PTR);
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 3);
 	kfree(copy);
 }
-- 
2.34.1

