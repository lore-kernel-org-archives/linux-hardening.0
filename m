Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486448096F
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110088; cv=none; b=SFtuhT9GpK+QEUVGBsfWI6si7IzKlngZMwuj89IUax8TiMm/pvqikz3acaeiqYv12pbXqTU44JrAdBtjye3aD+e8AbRWnDHKCQK7DIQGPgl97tFGcDqrLlucq1UBvV65qk9j9gKysmt9uAEAzKtcsCiD3hz2AE20B1Fs3Y7rH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110088; c=relaxed/simple;
	bh=sW9PBi/UOltWN1DR57pORdbD5ITJ09pEbZk5A99xqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLM6ywBD0JQ8v2z18QYQPRUd8BleuH7Qxb10+lvxLl96swGFBum1gx0HA/qQBsaZaCYRK7CcjEOJc/HGaSdUs8U0fQ2o6JbAh8cnywcU0ZY/OGkhInGKqhoz6w3x5+rDNf3JrkTlAdXIP2yo1Kk8ZMEWRLIAxsvu9teIQVKHunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1sI0gLh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1sI0gLh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so18110905e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110086; x=1779714886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNKDREEZdQovW0REhCmZGfTK1N5DJlg6DXHt9BuUT0Y=;
        b=Q1sI0gLhy99jZS8YjWJ4xqfckhP7l6dIgSLNnWJrYwphbwYMVdBlyJM1Nf2ljxQ8IP
         9/Y2ILPZhMV+FXUaqRwZrmxpeNAI1q3FDVdXBqkKjHp4TYsMOzTyrKEsAGNg0qdziiC3
         3YZr+wMPmqcQyU4Lc4JHTOPcEC9A8tTD0+q+KieabD1PzoZ+SoX0tL56GyX3HNOP10aQ
         Qqn5rI7AzMUt3lmw1T0jBQifJn/l+Oh2d8tHVQY3E6vaj0jNki1g4kHUdC3XFT2uqJ3K
         dv9HeVAcZviOT2ruQ4aLG3QH5Md0Qcqc5jpTcIDdEoJ/CJ34d+F8MjD8/3mmGE/twuAd
         SewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110086; x=1779714886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dNKDREEZdQovW0REhCmZGfTK1N5DJlg6DXHt9BuUT0Y=;
        b=obPCm8HaCdpkb1ijTrRdJYCBpU3W3fLmhiLNQqoDsTg8Y18xwjBYF6Q4ung+taiRf3
         3hoTIurzTl5AYL1tMKMwskWJQPErjbHzePTIqEuXm0KIvGeoNwA8NMNxs9A6CPRVtrsL
         Vn1VVvbchpWXjHcXO5g9v9LBinWXq5moGpawHLKpI5kPZQw1KJvJbDDpc6UiUYiS3lDH
         u4qxdALg2rVp+CxM7Sqb0wio6cJ4k2NZXLZIqW10R8cEs+dxRhbBxSjabzBz/fia1xaq
         PukRyZboB3p0xX8Vg4WM3ik1V0FUSaEm8CHh3DpNUQEPOimKeMBxDDo3fe9UJlDah0zR
         eWrw==
X-Forwarded-Encrypted: i=1; AFNElJ8E1mma5ivNLW+yaeMCHjk3fJYSWpCVUC8AeirUjaIPrv/JrcMSQnfB0GbbJdXa6frZX2D9DQVq2b+cKkHDLAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xscDHooPZXb0zDL9laPlXMG2Jwf6ynPPCWn7Cvo5FS0WJZw+
	dQqLazZnAl/kvfNncoDHc3h/Ka8ZBBa7AfZU3nhbn8Ae/RcqusvheE5B
X-Gm-Gg: Acq92OFT5TSu06V/tXj1h1l+hNuWMKy8hFQcIJPnQydzq0xuTE4Z7SYpRpeBn3umZRv
	hUydAksvmtDg2wv2tTFyxYafOPeiVN3ta0W19VJ/nRBOIv1iDCekipjj2+VaZNM3topL378xlHe
	74ds2yI7QNL/aVXme8nRshelKGjdPMEa9RLoJIQk/QqaGJ0cp3Ae1VY+KfyLlopSiKJX4FE+Aro
	LbDupFK/0Zly6Uuus8Z4sb7+niSp/njlto9JX4A9QD0DmyC/rXVG6H28bcrQphi8ObG4b5x48CR
	6bdBqOr3FQv5dxmHfuchHueDyD02822KUbqV3TIrNqowAsM5JPU15nKNT0mdlhiQUuHpPxI0VO5
	4gSayo0+Y0rvJ7IQ0wcaWYnm1bxT+nOhPVQNMl/xhoxrb6Gm+jI32r14CIqchJlt/eLreFWb0pt
	VnxawYKLsftP/n9tI5rpgvCcCILFt8DjtqJfjbEZGq
X-Received: by 2002:a05:600c:3e1b:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48fe60eccc3mr223047365e9.13.1779110085224;
        Mon, 18 May 2026 06:14:45 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([95.86.49.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm249619265e9.9.2026.05.18.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:14:44 -0700 (PDT)
From: Milan Tripkovic <milant2002@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kees@kernel.org,
	andy@kernel.org,
	linux-hardening@vger.kernel.org,
	Dusan.Stojkovic@rt-rk.com,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH v4 2/2] lib/string_kunit: extend benchmarks and unit test to memcmp()
Date: Mon, 18 May 2026 15:14:07 +0200
Message-ID: <20260518131407.1026049-3-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518131407.1026049-1-milant2002@gmail.com>
References: <20260518131407.1026049-1-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

Extend the string benchmarking suite to include memcmp().
Extend the string unit test to include memcmp().

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
---
 lib/tests/string_kunit.c | 120 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b..48b1fd068 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -881,6 +881,124 @@ static void string_bench_strrchr(struct kunit *test)
 	STRING_BENCH_BUF(test, buf, len, strrchr, buf, '\0');
 }
 
+static void string_test_memcmp(struct kunit *test)
+{
+	const unsigned int max_offset = 16;
+	const unsigned int max_len = 32;
+	const unsigned int buf_size = max_offset + max_len + 32;
+	u8 *buf1, *buf2;
+	unsigned int i, j, len, k;
+	int res;
+
+	buf1 = kunit_kzalloc(test, buf_size, GFP_KERNEL);
+	buf2 = kunit_kzalloc(test, buf_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf2);
+
+	for (i = 0; i < max_offset; i++) {
+		for (j = 0; j < max_offset; j++) {
+			for (len = 0; len <= max_len; len++) {
+				memset(buf1, 'A', buf_size);
+				memset(buf2, 'A', buf_size);
+				KUNIT_EXPECT_EQ_MSG(test, memcmp(buf1 + i, buf2 + j, len), 0,
+						    "Should be equal: i:%u j:%u len:%u", i, j, len);
+				for (k = 0; k < len; k++) {
+					memset(buf1, 'A', buf_size);
+					memset(buf2, 'A', buf_size);
+					buf2[j + k] = 'B';
+					res = memcmp(buf1 + i, buf2 + j, len);
+					KUNIT_EXPECT_NE_MSG(test, res, 0,
+							    "Should detect difference at k:%u (i:%u j:%u len:%u)",
+						k, i, j, len);
+					if (buf1[i + k] < buf2[j + k])
+						KUNIT_EXPECT_LT(test, res, 0);
+					else
+						KUNIT_EXPECT_GT(test, res, 0);
+				}
+			}
+		}
+	}
+}
+
+#ifndef STRING_BENCH
+#define STRING_BENCH(...) 0
+#endif
+
+static void do_string_bench_memcmp(struct kunit *test)
+{
+	char *buf1 = NULL;
+	char *buf2 = NULL;
+	const u64 lengths[] = { 1, 7, 8, 16, 32, 64, 128, 512, 1024, 4096};
+	const int offsets[] = { 0, 1, 3, 7};
+	const u64 max_len = 4096 + 64;
+	unsigned int w, o, i;
+	unsigned int off;
+	u64 len;
+	char *p1;
+	char *p2;
+	u64 iterations;
+	u64 elapsed;
+	u64 ns_per_call;
+	u64 mbps;
+	u64 j;
+
+	buf1 = vmalloc(max_len);
+	buf2 = vmalloc(max_len);
+
+	if (!buf1 || !buf2) {
+		vfree(buf1);
+		vfree(buf2);
+		kunit_err(test, "vmalloc failed\n");
+		return;
+	}
+
+	memset(buf1, 'A', max_len);
+	memset(buf2, 'A', max_len);
+
+	for (w = 0; w < 100000U; w++)
+		(void)memcmp(buf1, buf2, 4096);
+
+	for (o = 0; o < ARRAY_SIZE(offsets); o++) {
+		off = offsets[o];
+
+		for (i = 0; i < ARRAY_SIZE(lengths); i++) {
+			len = lengths[i];
+			p1 = buf1;
+			p2 = buf2 + off;
+			iterations = (len < 512) ? 100000ULL : 10000ULL;
+
+			for (j = 0; j < iterations; j++) {
+				(void)memcmp(p1, p2, len);
+				barrier();
+			}
+
+			elapsed = STRING_BENCH(iterations, memcmp, p1, p2, len);
+			ns_per_call = div_u64(elapsed, iterations);
+			mbps = len ? div_u64(iterations * len * (NSEC_PER_SEC / MEGA), elapsed) : 0;
+
+			if (off == 0) {
+				kunit_info(test, "bench_memcmp_aligned: len=%-4llu: %llu MB/s (%llu ns/call)\n",
+					   len, mbps, ns_per_call);
+			} else {
+				kunit_info(test, "bench_memcmp_unaligned(off=%u): len=%-4llu: %llu MB/s (%llu ns/call)\n",
+					   off, len, mbps, ns_per_call);
+			}
+		}
+	}
+
+	vfree(buf1);
+	vfree(buf2);
+}
+
+static void string_bench_memcmp(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_STRING_KUNIT_BENCH)) {
+		kunit_skip(test, "CONFIG_STRING_KUNIT_BENCH not enabled");
+		return;
+	}
+	do_string_bench_memcmp(test);
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memset16),
 	KUNIT_CASE(string_test_memset32),
@@ -910,6 +1028,8 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_bench_strnlen),
 	KUNIT_CASE(string_bench_strchr),
 	KUNIT_CASE(string_bench_strrchr),
+	KUNIT_CASE(string_test_memcmp),
+	KUNIT_CASE_SLOW(string_bench_memcmp),
 	{}
 };
 
-- 
2.43.0

