Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CE374C4
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131993; cv=none; b=tbXvFN8JXNaC/z2p9tKOHkrmNv7MC3q5avQUJ+n21OItl2jhXbjFFMG7ZeEjps5dK6jTfx11h8FwtWTD58oeuJ3EeU/rF19FFpbqX9T5UWvYkGFp6wTVVQwDlZNjw2ZeSN8B9xFpMSdZJq2cDpYJpR1BuWL36Sv46xuRXh/3614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131993; c=relaxed/simple;
	bh=8I4WqVW9h0oo1wKFnIe5Zs1p9kcN+bU5Oifz/60G8e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cE5/IkV9CZ6FUIWhPKUlotmVz80QUGbuHb1r796Gb/m8Iz3Ep7GJpJmabLeBUqshFL0LlH7Wd2b/PVKfYFqqFeQ2H3iya+U/MKpKCSuVAZ1pJd66APVNyauURU0b6yAT9L+vPKNR1+rON+aKUrL8D2KDwU560wCaF2P8Bsx31ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QyBabcJl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyBabcJl"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea64af4bbbso56667a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Oct 2024 19:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729131991; x=1729736791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RN8JQgiITrQj6lHgprvd2MNM/V86U6nLKZivNfuyP0=;
        b=QyBabcJlYHLbRFuHyuScXpLH3azyIc4eososVqk75Gl+/BN1AdvmSqny7UD70gBzGn
         Q9M1DWQsDbig28U+F4qsrq89e9y3FVKH+AKkXF8/kzGayfbsQ1K9gV+kLofLYFtUq6vj
         mF4OsEXPvGL2Hy/y/KceJ3XQYiXj/0jJ3jDD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729131991; x=1729736791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RN8JQgiITrQj6lHgprvd2MNM/V86U6nLKZivNfuyP0=;
        b=g/+fdH24pDnjjFg72BqB9UTGobkCwP3d4L9BIvXlzLOy/CcQsx+ew9s+EROYLX1nkz
         nEStu/TIkHlt2n7KGo/pNOsXHpe2VyWW6HwwPrsCTrp/4j2Etbv9dTkw8UZM5xE5742H
         LPOMwjDqNPxNFnf6aE79VVzbcps3Bbak/NQtqpDpfM5BMa/UpCjeg/a4Nc+ed5x8B//U
         +vjDiooils2iCo+OuyfQSpLGR7Qq32xb5uY64+pvBJfy3PRfThTgefWjGe2CHxV2wqyL
         5OUb4QbLgiL29Xc2N5rDMgQnX5Mx0LXFAA53UNJAL6yo/u1wBiZE3zI3LH6g7wQ9RXeA
         tkMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3tVlAJJb/QPyR/zolePvaC9mZNLgHSb6RjHRxNjH7V9Vn8aK0SRh/W7gAdu4646a/aMegMyNDyx8Pq+/Jc9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRkUl74+vLR9N2P5ucCmcVZgTtv8WcMhvngV8Lx4HNl7vx9ei
	nrOoB2Sqtf5lQ0R/OYRsn623oB7Fv2BsXOwwajHrGodRXIqFkCJFCqU0rcT1oQ==
X-Google-Smtp-Source: AGHT+IHwzw6bEAHzD80log/xY9cbw81AdrYOnN6MnrGumBq7RqUgylPY4QxMSEBQbIgjN2nq1fXnjw==
X-Received: by 2002:a17:902:c454:b0:20d:345a:965b with SMTP id d9443c01a7336-20d345a9a5fmr22565015ad.7.1729131990866;
        Wed, 16 Oct 2024 19:26:30 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20d18036714sm34755975ad.152.2024.10.16.19.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 19:26:30 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	deraadt@openbsd.org,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org
Subject: [PATCH] munmap sealed memory cause memory to split (bug)
Date: Thu, 17 Oct 2024 02:26:27 +0000
Message-ID: <20241017022627.3112811-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

It appears there is a regression on the latest mm,
when munmap sealed memory, it can cause unexpected VMA split.
E.g. repro use this test.
---
 tools/testing/selftests/mm/mseal_test.c | 76 +++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index fa74dbe4a684..0af33e13b606 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1969,6 +1969,79 @@ static void test_madvise_filebacked_was_writable(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_munmap_free_multiple_ranges_with_split(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	/* seal the middle 4 page */
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	}
+
+	/* munmap 4  pages from the third page */
+	ret = sys_munmap(ptr + 2 * page_size, 4 * page_size);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	} else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	/* munmap 4 pages from the sealed page */
+	ret = sys_munmap(ptr + 6 * page_size, 4 * page_size);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	} else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	REPORT_TEST_PASS();
+}
+
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2099,5 +2172,8 @@ int main(int argc, char **argv)
 	test_madvise_filebacked_was_writable(false);
 	test_madvise_filebacked_was_writable(true);
 
+	test_munmap_free_multiple_ranges_with_split(false);
+	test_munmap_free_multiple_ranges_with_split(true);
+
 	ksft_finished();
 }
-- 
2.47.0.rc1.288.g06298d1525-goog

