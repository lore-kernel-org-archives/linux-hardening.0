Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5E83A09
	for <linux-hardening@vger.kernel.org>; Wed,  7 Aug 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044952; cv=none; b=W0We4Ld1kDICW0O1bJMLey/jrF7wOsgin/s25TGxpLYNNEM9+f8FxztA83pDg+MVhuG5M8JLe8lI1K4JSeJL3lHQu29ZAyv7Aren0NRV6ulYxADfeJQfT1voydrfHdtqcY61ki6eeFwk/wvTj/9XWJGtAgIv12h/74A8+dks+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044952; c=relaxed/simple;
	bh=s9CkfNWvW6jQ+KuZef0P+IXflX2IogIAMHBgJSRl9Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qsk9cFGfDkbcXdNJmQA92o+9QK6fq0z9GkipBbQi6NY4tu0fPJOwr6EEpY7pntqKDM7q5rQ2D3hHdBx5oQYf5De1+wB4vn6vo8pEy0/+U4zx5XS+TGPiLXEGWQAh3Y9JGJxQKsj+cgvAy+nwaIoxHMOtK8pxVBAiVdKvCkj++tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UJF5d+oI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJF5d+oI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ff67158052so446205ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 07 Aug 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723044949; x=1723649749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwzf1u9uZY62W33ta9kOU+Pg3rCPU/ryARfGIfXdTqQ=;
        b=UJF5d+oIpyRH/tzBzrFKKlEVSqR629mp+03LPfGPsivzJwVy6nyiUtMR18tt6sRiGD
         /6otdjQt0o4ZXzuf1yGZd6bDJPUEaPXJqErg3ST2SYOqsV8ryW6yRI62UKQNu35tSGu0
         k5Eu+DSJhiz2dXaUvAbVM+ML0rgXuJARqgdTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044949; x=1723649749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wwzf1u9uZY62W33ta9kOU+Pg3rCPU/ryARfGIfXdTqQ=;
        b=K1A9TbLbtDTwnTbNC3+2RKNFNk6trOo9wlIivQMQBe0IfzOocFFjgiQ8Dm9YK/2yCe
         38OmJsCe2hAa9NtNTiUpYcsFZvKxuELWhYVFBEfhMaI77vURiam8urGmra64mx+yNRxU
         CcP8kUYor3RqvdUwOP9MD+8xD8yEny8livZndUToXcKJj/OXv6c98v0ORv1E1seWaxr+
         Q3AER3hHw+yWNVZ7PthimTnoTMZ1I3oIZph8YPNPJl6cgm/f8dVpe7rPui1QJ/tNvPvc
         DKpOMFroKoDPXuuh1Pv/p+BhVC4C9zDwkwxZkt/qJ/lwm0GgWx8hVpuu745vU5efyyVN
         V/0A==
X-Forwarded-Encrypted: i=1; AJvYcCUI3Bte9VpPRhAxlIiHoDjK8eq0c/uur9T3vqcbbRvMAX7Ozn4DEJ3zwtdTWDAjVg5V+MCUJMhf5xeSHuSM2WB/yGkP40OszQu+2rsXmG3j
X-Gm-Message-State: AOJu0Ywd2yZS3+XgvFkEAqFtucX7eLVfJa3rD3TzwsEvymhaUDpEN/1f
	Jz64DStruh6YglkWhI4PpzGail+XTm6eO4e3Vph1d0WnU2v/RbyNAsEgZtmWPw==
X-Google-Smtp-Source: AGHT+IGvi7dQHzYwS3aVaZb2F6yx2nnD9//HN/3+Cc1hlgmg2cIb+ocyDjoQkdIhNeB/X542y+CYmQ==
X-Received: by 2002:a17:902:ecd2:b0:1fd:64d2:62da with SMTP id d9443c01a7336-1ff572c4e13mr220549835ad.29.1723044949167;
        Wed, 07 Aug 2024 08:35:49 -0700 (PDT)
Received: from localhost (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ff592aa11csm107549745ad.272.2024.08.07.08.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:35:48 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	willy@infradead.org,
	torvalds@linux-foundation.org,
	Liam.Howlett@oracle.com,
	pedro.falcato@gmail.com
Cc: jeffxu@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mpe@ellerman.id.au,
	oliver.sang@intel.com,
	vbabka@suse.cz,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
Date: Wed,  7 Aug 2024 15:35:44 +0000
Message-ID: <20240807153544.2754247-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

the syscall remap accepts following:

sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
		(void*) 0xdead0000)

when the src is sealed, the call will fail with when error code:
EPERM

Also remove the dependency on glibc for mremap(), the previous
version of test pass on certain version of glibc and fail in another.
By calling syscall directly, we test and verify remap function
in kernel directly.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 tools/testing/selftests/mm/mseal_test.c | 44 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index a818f010de47..45d299fd74ed 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -110,6 +110,16 @@ static int sys_madvise(void *start, size_t len, int types)
 	return sret;
 }
 
+static void *sys_mremap(void *addr, size_t old_len, size_t new_len,
+	unsigned long flags, void *new_addr)
+{
+	void *sret;
+
+	errno = 0;
+	sret = (void *) syscall(__NR_mremap, addr, old_len, new_len, flags, new_addr);
+	return sret;
+}
+
 static int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
 {
 	int ret = syscall(__NR_pkey_alloc, flags, init_val);
@@ -1115,12 +1125,12 @@ static void test_seal_mremap_shrink(bool seal)
 	}
 
 	/* shrink from 4 pages to 2 pages. */
-	ret2 = mremap(ptr, size, 2 * page_size, 0, 0);
+	ret2 = sys_mremap(ptr, size, 2 * page_size, 0, 0);
 	if (seal) {
-		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 != (void *) MAP_FAILED);
 
 	}
 
@@ -1147,7 +1157,7 @@ static void test_seal_mremap_expand(bool seal)
 	}
 
 	/* expand from 2 page to 4 pages. */
-	ret2 = mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
+	ret2 = sys_mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1180,7 +1190,7 @@ static void test_seal_mremap_move(bool seal)
 	}
 
 	/* move from ptr to fixed address. */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1299,7 +1309,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	}
 
 	/* mremap to move and shrink to fixed address */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
@@ -1330,7 +1340,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	}
 
 	/* mremap to move and expand to fixed address */
-	ret2 = mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
@@ -1361,7 +1371,7 @@ static void test_seal_mremap_move_fixed(bool seal)
 	}
 
 	/* mremap to move to fixed address */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1390,14 +1400,13 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	/*
 	 * MREMAP_FIXED can move the mapping to zero address
 	 */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 == 0);
-
 	}
 
 	REPORT_TEST_PASS();
@@ -1420,13 +1429,12 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 	}
 
 	/* mremap to move, and don't unmap src addr. */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
-
 	}
 
 	REPORT_TEST_PASS();
@@ -1449,18 +1457,16 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	}
 
 	/*
-	 * The 0xdeaddead should not have effect on dest addr
+	 * The 0xdead0000 should not have effect on dest addr
 	 * when MREMAP_DONTUNMAP is set.
 	 */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
-			0xdeaddead);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+			(void *) 0xdead0000);
 	if (seal) {
-		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
-		FAIL_TEST_IF_FALSE((long)ret2 != 0xdeaddead);
-
+		FAIL_TEST_IF_FALSE(ret2 == (void *) 0xdead0000);
 	}
 
 	REPORT_TEST_PASS();
-- 
2.46.0.rc2.264.g509ed76dc8-goog

