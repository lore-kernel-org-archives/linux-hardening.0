Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7811BB6BD
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967854; cv=none; b=WP7iG6N0dxwgi/zzi0oyTzrUDD2gpiAQdu7Vx5uizh275G3oM6+ALCJBNKTiUvobk4n2vPxTOYbjqunqE4yPir52OdImIUlShRKZOHG5poatLN7fdj8BZpvU4MaoYHe9b12dpCYI9oRWivuIzI7uDYUpOGvWUD1tuldb5gy6OtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967854; c=relaxed/simple;
	bh=ACgdkIlvnRhZ7PHc5BWlTN2Eo+ik0nzcD6MIX1rROxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUP2gMMwBUekdzinqzF5SLDll8UMQxsbxVhTB5kUinmFc4u8tmd+b8A6OJfLdZNWHDu6uZUzSG13eqbJ24LZMdkHVi7BY/H1I7XU7yRAz6iIzv0pzpHJdyTHtN/lYgfRLgcvQ1A2QsCMxzWb01/wIfAMYuSzuvm0dIpEBdxwd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i9NMRfNF; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i9NMRfNF"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3df075ef43cso91999b6e.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967851; x=1725572651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAPF+mFWkE9aMPYn9qrkTRHhUapPOCqVhxefhrunDUc=;
        b=i9NMRfNFMGr3JCOXXE3q6gYMg8F8eTQZNKu1z/77/140ymVMZ4KjNAtJ9h+MhXDNLs
         pqj/Ts5TC3ije71bkF2NVNOykOfrdmnjyzxTCjWVQG2+kTuI0exNSGw5U1wM3lLtjH2a
         HIdvlo8cSQnYTW6Z4tcsLWXkPXdt53BJK5bmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967851; x=1725572651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAPF+mFWkE9aMPYn9qrkTRHhUapPOCqVhxefhrunDUc=;
        b=lp9aEPt5Wcb+m8D2SkW8xGGhuu2fXj6mO0bv+HKBG0R5LB1mTHX9mqI2GyxO6eicKA
         DMuqD5Z1M5CUzfjrgmdDXPUaKNZBrfTWbCgm6IGa0ISa9nqhJ42Npb7Q9XwPjHAWC443
         YYRxILR3+kXKnqpxFlgmJQyD9ht+V7aVc9gLbdxzsqLbRo9dXYVhTFwSY0hRfTqTW54M
         LAmhzVFJ2rVy3KW44PRB2as+r0JPqiC3sKh6ysDZnlb/8Jtnn/HVd4TJ1ArA0renQky1
         b1oJcZsCxI4XrvYbj0D46KsHGLeax9cIEju2OJ0quvFtemyXnOt7rHwwLJ9j4iMgGDKm
         OveQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPuTrnlMv7wPYZsNATq7nlza4PEkf2w9D+qJDBoqn1vejCzJO1YbxsCe2kSv3eMLbAEy59BKNzD5aCOrViHXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98Y1+7wIfvDv83aXoQ1gHT33rDfKKr5GxPn/wkNvGaYvIi5OJ
	GLSdDN3179aVy7vBy7yNzl3s14mMN/yvqdmEBxc+gYC9Ewk3ZW9cImBoVQevXg==
X-Google-Smtp-Source: AGHT+IHtVngpZOZlZonUTLqOqg/y/b0gvT/st7+gVnwMaqdrCOVHCIfjFfjqHOSo+TMO91gZzOvYCQ==
X-Received: by 2002:a05:6871:5226:b0:260:ccfd:2e52 with SMTP id 586e51a60fabf-27790377431mr2564127fac.7.1724967850809;
        Thu, 29 Aug 2024 14:44:10 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e56d7593sm1585108b3a.168.2024.08.29.14.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:10 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 4/4] selftests/mm: mseal_test add more tests for mremap
Date: Thu, 29 Aug 2024 21:43:52 +0000
Message-ID: <20240829214352.963001-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240829214352.963001-1-jeffxu@chromium.org>
References: <20240829214352.963001-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add sealing test to cover mremap for
Expand/shrink/move across vmas.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 202 +++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index d83538039e76..494035129d65 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2338,6 +2338,197 @@ static void test_seal_mmap_reuse_addr(bool seal)
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
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
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
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
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
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
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
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0);
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2359,7 +2550,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(97);
+	ksft_set_plan(105);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2480,5 +2671,14 @@ int main(int argc, char **argv)
 	test_seal_mmap_reuse_addr(false);
 	test_seal_mmap_reuse_addr(true);
 
+	test_seal_mremap_shrink_multiple_vmas(false);
+	test_seal_mremap_shrink_multiple_vmas(true);
+	test_seal_mremap_expand_multiple_vmas(false);
+	test_seal_mremap_expand_multiple_vmas(true);
+	test_seal_mremap_move_expand_multiple_vmas(false);
+	test_seal_mremap_move_expand_multiple_vmas(true);
+	test_seal_mremap_move_shrink_multiple_vmas(false);
+	test_seal_mremap_move_shrink_multiple_vmas(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog

