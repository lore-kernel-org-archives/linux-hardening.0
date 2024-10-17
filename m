Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C31DDD1
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126278; cv=none; b=sr4nEGWu7VCFOVjz0KZBCmrkWH3vBWmtM7zee0qCU/94LGOjY6VbIOQUTg4/ulJLyTq0tQ32Tq+OVl4XUYWrYIAcbmHYqeKCfF5WEWqio3P7MqRLLvnaAksxymywli0QGDpa/w225R+3xLcbVOUj26CuRF/02Lanl649NcTR3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126278; c=relaxed/simple;
	bh=sNhuepxauFrRXvVIMAtmTnGspOhtzLln68OH8rtsxSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5ZDol/ZnXCf1aolj01PPvMT5Bwz0guN62O3XdZXm5ab4dmGXUyVgcc8ZID8Y/DYeYwX67u31dCNtcsL0eIWSkuGfaQEbhpBqNuWWwYmherjjDlUqq30qRBX8zDw/7c4nys23xo++vBtLRT/ZIQN0Ya7CtDyqk1PYPzTXQ/y8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n/UC59oY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/UC59oY"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e31aacbbso44697a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Oct 2024 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729126274; x=1729731074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkOjehUZhf9vTAiDfbTet38c6Gkgb8k55nqJSbDOZQY=;
        b=n/UC59oYtrP9ZJ+NMk+ibXwz+qhvmWwuqxY0RyuZ4J3geAlf/bVHmHUCS6KCE1yDpE
         Hfp6UNQEIxilZV/09kciyHzVJDofe7siwoWCO9JThepDr0dqG8ujSbW/mGCAqKeZnF7/
         lzp04wgA8GezOGyi4dnLY/ks0B16KnruS8jxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729126274; x=1729731074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkOjehUZhf9vTAiDfbTet38c6Gkgb8k55nqJSbDOZQY=;
        b=Pp9r93ohF2CscGacddaMy/x446S7VS49Zy1Xs9UYODIx7VX8GIvaFPXtMUBqwGDPaC
         6h+2F5TTDV9HhzF0HZaKmmmkg9CJUkp+KvIQfcvCpADsVRLzimOZ6lJ1MMfaFKVAwjNY
         nQlEbJhokW+tHQT+zo9KcV4Lmz9CpRFQ/qKR7w8MH7DcsP/oUdXC7jIy1hgqld/4bMR2
         Ac4mIxgWASIkkysgZye8wXIGpSCEPoCgJjAolo/NF+9cx4Q7vUz3cl2WNHtnWhDHYrDA
         MBzEqo4nGH+/d2J+3W5EmqceeUHrsEmpOjnYV6mlKCxSiGZnB+2H6p3v8o2g+VnXdtpx
         jXRA==
X-Forwarded-Encrypted: i=1; AJvYcCUnTsPR+G8vz9m94ukYxauDoU/9wyZz9IrtvhhKWVgO7GkK72hllMuDRR1NO3gNzb8uugXl23bpViVjw2m0aN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWOR2DoAszOMN9lFPMqGgWmBi2qVnoHw19j6/qslYNp8krudU
	JeRnc86A99L/dyoJsTq41mTHGNJ7tNZIxPR58DlpAUEiJdv4ApuO0Vvx40HtvQ==
X-Google-Smtp-Source: AGHT+IHy9OceESdtYyqY6xLVtyPe+K9jcM7IV9Ttt1i23Ri9jkWXgMq2TJu6PP5Z70ZTIPLzN7qP/w==
X-Received: by 2002:a17:902:dac7:b0:20c:a63e:b678 with SMTP id d9443c01a7336-20d47f829a5mr7401195ad.14.1729126274463;
        Wed, 16 Oct 2024 17:51:14 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20d1804c68bsm34559025ad.185.2024.10.16.17.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 17:51:14 -0700 (PDT)
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
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] selftest/mseal: Add tests for madvise fixes
Date: Thu, 17 Oct 2024 00:51:05 +0000
Message-ID: <20241017005105.3047458-3-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241017005105.3047458-1-jeffxu@chromium.org>
References: <20241017005105.3047458-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Testcase for "Two fixes for madvise(MADV_DONTNEED) when sealed"

test_seal_madvise_prot_none
  shall not block when mapping is PROT_NONE

test_madvise_filebacked_writable
  shall not block writeable private filebacked mapping.

test_madvise_filebacked_was_writable - shall block.
  shall block read-only private filebacked mapping which
  was previously writable.

Fixes: 8be7258aad44 ("mseal: add mseal syscall")
Cc: <stable@vger.kernel.org> # 6.11.y: 67203f3f2a63: selftests/mm: add mseal test for no-discard madvise
Cc: <stable@vger.kernel.org> # 6.11.y: f28bdd1b17ec: selftests/mm: add more mseal traversal tests
Cc: <stable@vger.kernel.org> # 6.11.y
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 118 +++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 01675c412b2a..fa74dbe4a684 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1728,7 +1728,7 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
 		FAIL_TEST_IF_FALSE(!ret);
 	}
 
-	/* sealing doesn't apply for file backed mapping. */
+	/* read-only private file-backed mapping, allow always */
 	ret = sys_madvise(ptr, size, MADV_DONTNEED);
 	FAIL_TEST_IF_FALSE(!ret);
 
@@ -1864,6 +1864,111 @@ static void test_seal_madvise_nodiscard(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_madvise_prot_none(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mprotect(ptr + page_size, page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		ret = seal_single_address(ptr + page_size, page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* madvise(DONTNEED) should pass on PROT_NONE sealed VMA */
+	ret = sys_madvise(ptr + page_size, page_size, MADV_DONTNEED);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_madvise_filebacked_writable(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int fd;
+	unsigned long mapflags = MAP_PRIVATE;
+
+	fd = memfd_create("test", 0);
+	FAIL_TEST_IF_FALSE(fd > 0);
+
+	ret = fallocate(fd, 0, 0, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ptr = mmap(NULL, size, PROT_READ|PROT_WRITE, mapflags, fd, 0);
+	FAIL_TEST_IF_FALSE(ptr != MAP_FAILED);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* sealing doesn't apply for writeable file-backed mapping. */
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+	close(fd);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_madvise_filebacked_was_writable(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int fd;
+	unsigned long mapflags = MAP_PRIVATE;
+
+	fd = memfd_create("test", 0);
+	FAIL_TEST_IF_FALSE(fd > 0);
+
+	ret = fallocate(fd, 0, 0, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ptr = mmap(NULL, size, PROT_READ|PROT_WRITE, mapflags, fd, 0);
+	FAIL_TEST_IF_FALSE(ptr != MAP_FAILED);
+
+	ret = sys_mprotect(ptr, size, PROT_READ);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* read-only file-backed mapping, was writable. */
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+	close(fd);
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -1876,7 +1981,7 @@ int main(int argc, char **argv)
 	if (!pkey_supported())
 		ksft_print_msg("PKEY not supported\n");
 
-	ksft_set_plan(88);
+	ksft_set_plan(94);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -1985,5 +2090,14 @@ int main(int argc, char **argv)
 	test_seal_discard_ro_anon_on_pkey(false);
 	test_seal_discard_ro_anon_on_pkey(true);
 
+	test_seal_madvise_prot_none(false);
+	test_seal_madvise_prot_none(true);
+
+	test_madvise_filebacked_writable(false);
+	test_madvise_filebacked_writable(true);
+
+	test_madvise_filebacked_was_writable(false);
+	test_madvise_filebacked_was_writable(true);
+
 	ksft_finished();
 }
-- 
2.47.0.rc1.288.g06298d1525-goog

