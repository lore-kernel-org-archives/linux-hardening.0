Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2B13AD06
	for <linux-hardening@vger.kernel.org>; Wed, 14 Aug 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619675; cv=none; b=r9/wuRZUnyZLD28fRT6ci6r02Uz5hKjQKLK8l1CP/IOygxnjgpl2eGgfH6AIhCxZu4aE1XFQSpz6thTbLdqYzYEJJU5mc7MAvfl9AtKSgsZ8DoQhIhVJg9MeDO0gJ3tAT2xG9mh5MJKF3J9L6DcjIXYo46qBNEwa5AXOBF+KTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619675; c=relaxed/simple;
	bh=FRw/jHn6ln5li8Cdyej4UuVStctKPxXfcZyK1aqevDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IENgMRV7vpP74OoGQt3NtoBXztWyPItbr2Hm5ooifTdSuS8+BkD3YgvrSDeCdBi3jaWF652hnjJS99rnT3A4YVF7Jf3A0RIQszqHdMd4eWa1H/ApOXN1LKYkAUMmn6n8u/Z8Gc1mlrI7vKeinf2VhO9SlVXgRJas7tNqCgpQ1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FtONhJ90; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtONhJ90"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd640a6454so49136005ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Aug 2024 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723619673; x=1724224473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgVLZ9rJ8uTulNaVowlNQVAT4uj5xefq6Kph3t1/npI=;
        b=FtONhJ90ux546tajtU0yzxkPIxbzPyhJqPCxp/XulcWDOyG+ZqZINtcrSaBRyurtKI
         gDNVktFTs0p5sKZX7sse+h4IDVCHOimqSToZSv7igZ7pZh7UwgdU24kcPZGeSjLUyo89
         t6x2xbjBL5TcmA+jD7xO+sUxTdbi+ZHUJsinQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723619673; x=1724224473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgVLZ9rJ8uTulNaVowlNQVAT4uj5xefq6Kph3t1/npI=;
        b=afJR98Mmyx2IrqMdiCpkYbaNfaTyYKo2sojSxBcuJSeEnVlDILnucZPIW8vRZcCih5
         4+qXY5G7TbtJUwXmzu7otXpUuK+EgiBGs8iJRDibkpCMKSdxOqowIfiySkUOOjzCK6K4
         C/hOg31Dke0pGm7c75FAIiq7uQPv+yrjbjKNkvtq4apVRgyrxBa7qe9xLH48Yz2jbU7Q
         lKjFno3Uk8bDq2i21YUL9GvKtQhwamEuoj/Xg8CNAIFLGlHP/ss6IpoHbWaNxeqNorqu
         MZeq3LATfmtBfWxLE9ZRZaN/swkVuX0JcdJEr6A5PLXQneXUqssIGHF6yGAPeXSbG9sa
         GtrA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/StZo+swNUtD7+3DEFvY9Sbl30hbtd0dkQqiMSCi5Jo+eSU5YZfqQEk4uQLAYs69ALwN5zWKaDL+DshHLh2P1ErwMHUhxgPm0usoBBS+
X-Gm-Message-State: AOJu0YwVU1OVdjxQgMXWlMTdb4ZN4KmYHdnSHVR409mabCOgKR1UiRvz
	Xc9zRGDwDBJUhsiCQ/1xWu96B/Tu7MnuA2C5Ow3qcGPrHDcICFbnUAP2e1kWDg==
X-Google-Smtp-Source: AGHT+IHU57C7vsS+qNBq8gDAWLhmPJNqgKoeLlLOzmIi1g6FfwO3Vs3x6r998OZVdfqTnr2qHr+eJA==
X-Received: by 2002:a17:902:d2c1:b0:1fd:6529:744c with SMTP id d9443c01a7336-201d638fe41mr23419445ad.1.1723619672938;
        Wed, 14 Aug 2024 00:14:32 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201cd1314cesm23705465ad.8.2024.08.14.00.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 00:14:32 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	willy@infradead.org,
	torvalds@linux-foundation.org,
	Liam.Howlett@oracle.com,
	pedro.falcato@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	jeffxu@google.com,
	lorenzo.stoakes@oracle.com,
	mpe@ellerman.id.au,
	oliver.sang@intel.com,
	vbabka@suse.cz,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 1/2] mseal:selftest mremap across VMA boundaries.
Date: Wed, 14 Aug 2024 07:14:23 +0000
Message-ID: <20240814071424.2655666-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240814071424.2655666-1-jeffxu@chromium.org>
References: <20240814071424.2655666-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add selftest to mremap across VMA boundaries,
i.e. mremap will fail.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
 1 file changed, 292 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 5bce2fe102ab..422cf90fb56c 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1482,6 +1482,47 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_mremap_move_dontunmap_allocated(bool seal)
+{
+	void *ptr, *ptr2;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/*
+	 * The new address is allocated.
+	 */
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+
+	/*
+	 * remap to allocated address.
+	 */
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+			(void *) ptr2);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+	} else {
+		/* remap success and but it won't be ptr2 */
+		FAIL_TEST_IF_FALSE(!(ret2 == MAP_FAILED));
+		FAIL_TEST_IF_FALSE(ret2 !=  ptr2);
+	}
+
+	REPORT_TEST_PASS();
+}
+
+
+
 static void test_seal_merge_and_split(void)
 {
 	void *ptr;
@@ -1746,6 +1787,239 @@ static void test_seal_discard_ro_anon(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_mremap_shrink_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret2 = sys_mremap(ptr, 12 * page_size, 6 * page_size, 0, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x0);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+	}
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_expand_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret2 = sys_mremap(ptr, 8 * page_size, 12 * page_size, 0, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x0);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	}
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_move_expand_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+	void *ptr2;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+
+	ret = sys_munmap(ptr2, 12 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* move and expand cross VMA boundary will fail */
+	ret2 = sys_mremap(ptr, 8 * page_size, 10 * page_size, MREMAP_FIXED | MREMAP_MAYMOVE, ptr2);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x0);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x0);
+	}
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_move_shrink_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+	void *ptr2;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+
+	ret = sys_munmap(ptr2, 12 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* move and shrink cross VMA boundary is NOK */
+	ret2 = sys_mremap(ptr, 12 * page_size, 8 * page_size, MREMAP_FIXED | MREMAP_MAYMOVE, ptr2);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+		//FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0);
+	}
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -1758,7 +2032,7 @@ int main(int argc, char **argv)
 	if (!pkey_supported())
 		ksft_print_msg("PKEY not supported\n");
 
-	ksft_set_plan(80);
+	ksft_set_plan(91);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -1835,8 +2109,12 @@ int main(int argc, char **argv)
 	test_seal_mremap_move_dontunmap(true);
 	test_seal_mremap_move_fixed_zero(false);
 	test_seal_mremap_move_fixed_zero(true);
+
 	test_seal_mremap_move_dontunmap_anyaddr(false);
 	test_seal_mremap_move_dontunmap_anyaddr(true);
+	test_seal_mremap_move_dontunmap_allocated(false);
+	test_seal_mremap_move_dontunmap_allocated(true);
+
 	test_seal_discard_ro_anon(false);
 	test_seal_discard_ro_anon(true);
 	test_seal_discard_ro_anon_on_rw(false);
@@ -1858,5 +2136,18 @@ int main(int argc, char **argv)
 	test_seal_discard_ro_anon_on_pkey(false);
 	test_seal_discard_ro_anon_on_pkey(true);
 
+	test_seal_mremap_shrink_multiple_vmas(false);
+	test_seal_mremap_shrink_multiple_vmas(true);
+
+	test_seal_mremap_expand_multiple_vmas(false);
+	test_seal_mremap_expand_multiple_vmas(true);
+
+	test_seal_mremap_move_expand_multiple_vmas(false);
+
+	test_seal_mremap_move_expand_multiple_vmas(false);
+	test_seal_mremap_move_expand_multiple_vmas(true);
+	test_seal_mremap_move_shrink_multiple_vmas(false);
+	test_seal_mremap_move_shrink_multiple_vmas(true);
+
 	ksft_finished();
 }
-- 
2.46.0.76.ge559c4bf1a-goog

