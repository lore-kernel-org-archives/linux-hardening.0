Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F24028E1
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199245; cv=none; b=j6bmCgjNcylu64nC2H9u/C9YvpYnQCtgsZD1Pwxw4hcrhMmkdZ6mnc5SEozgMT2IOyldt2CXLRx59JB4GQVmRhOLnRvpqqvwW5kT+iEIrICKQfKUmilc+qYQGHc4xzGS4y0XE1DC1NYdROACH6pdXxW6rJGYSCGmSjISE9hTctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199245; c=relaxed/simple;
	bh=SBevbqMau5DY2yzo6uvtYwB5R6Zbc33OOhrDkj7at1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFYwznnbw6GuSmxAHbYzQP3oxNA3RV01DbMJjhfTlAlkJwtbVFawU+sGxU3qquv202oyb4RexSE6sDAXMXrWon9LKFyH5hS7coKW0dTzaEXOdpNkahQKPt94csuk7JdUwUd1yLMeV7Ly41lcpTFKgcy+M1gFEn8pzMoFg3d6D6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3WOB7UA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3WOB7UA"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2409152f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779199241; x=1779804041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzK6VYeUiVHSRFo0FZ0JhAzgzZD4BZVN0mP+XFPvz0c=;
        b=h3WOB7UA4m2eVTO8hBPrUNfjRiDqWAuoXLs8WbmgAgAYlnBCEYLhbiz17gtr/S0LE4
         AOLsaBKS9Wfv9y/fss02rNbj9IA0F9hMBJKxvzda8Kzvei4Ny8u9nNWx+9OqP79TlHM3
         PP7wdAy7B+j6w6THHknDKouF2lKtW5u8S+VAoRALIrpQw4w1qpJnHQGLnwT10QeVtW81
         bLVgCStRo0k2pbVGzLpQcTQ8zUWgRt1lMdMOnJku62tsUBeHkjY0uzyRfjRCH2lpPY0Z
         fiW+jw559STBBKjD3RAY/lLfFZRzf48hBTfy3lFpLb85J8uuavOXYHGoLpYZgDRyqiHU
         H0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199241; x=1779804041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EzK6VYeUiVHSRFo0FZ0JhAzgzZD4BZVN0mP+XFPvz0c=;
        b=c9cb+FQ6v4iE3fYDi6TibEv7eaVcKI9V9QL4pVKTSq4cCTh/j3fSHzXzNIb30exObc
         RZEhwYMjhXmMNbr5dhgv1eHuJOlZNYUhHVUOuxOQrOHfuYxN/DZTUNspFTMoPlFYU3ex
         GwAAJWZAxyh6Zp1cfFcTn1oN0XlUE8C0HbDWL/vqiQYoxzdurgftu9cD18TMvCGHoOhJ
         jJwEyFskJxPICn/3VcqWQzptkD6Fpm4yaA7MwmxGiQqWt1PTZS+2Ytc8gND5KOXMGWmn
         /Uebo9v8p9ueAIij01vDHylnxO4y/OSJz7K2AV8EZ8C/pby6GXjMcoVGxb1XO8a7/550
         I/qg==
X-Forwarded-Encrypted: i=1; AFNElJ9Lzfseg6Dj9eVP4Mk0q7A3KvAX6/Xs4/MdSwbAuvzER0KrSxJhjwxGE66j63EQIa61SqpKwIFxCSMelqOgsTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5t0A0IhroKpBxSFOibGUTEmqkdekM9NRZj80VzZfjaHu0OJDH
	XU7118qi15UpemQFu1SHYopPiPYljORY1pHC0rdVuYcWXMb6ZGeWrddx
X-Gm-Gg: Acq92OHP7NzLlGvd7Kq2Oxmy/QyI8NwD+RFFhdWU9gEHOaiV3Fs1clrO4E1GVmI7vvK
	fwSbq5luwYsvtdeYLPLOusVcSJDOI4lGwB4N5wYtMrBZ7LVoLyFDysRIM3G9EwTq+yWkITwKi2v
	D+i+Na53Tj8wwxTiWFjCsDHS/7j3SCzMixuWGH92p9xdaxgQb2HNmFKj92BL/9weKgmaKodUiEg
	wpltDXMvv968CTBQrrOp30aqaAOi0UcfGCsEFfL0E4hbYjmtxk1aksFdm8GPo2JmVQUpGPV8RbJ
	2uLkuxAbQ9f6uVtLfh2yFVPUcRIPvyHVzWfKMC8Qe5weH5n3BO7JZrbGOlKMdvAn2RfnyQYh4Zc
	t/RKJE4an413RdPZqt041yoV1qr9zzxnMwq4FyTht1vtB3IcX4uRwkR2NTaYSdVXqo5zN3g06or
	BONY6qjrsyNZuYVXYV/ehvEILJRY1vmbFLR+HLJRrP
X-Received: by 2002:a05:6000:2482:b0:45d:8c16:5566 with SMTP id ffacd0b85a97d-45e5c3728d1mr31602074f8f.18.1779199240823;
        Tue, 19 May 2026 07:00:40 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([95.86.49.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm44065144f8f.3.2026.05.19.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:00:40 -0700 (PDT)
From: Milan Tripkovic <milant2002@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	kees@kernel.org
Cc: alex@ghiti.fr,
	andy@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dusan.Stojkovic@rt-rk.com,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH v5 2/2] lib/string_kunit: extend benchmarks and unit test to memcmp()
Date: Tue, 19 May 2026 16:00:29 +0200
Message-ID: <20260519140029.1190381-3-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519140029.1190381-1-milant2002@gmail.com>
References: <20260519140029.1190381-1-milant2002@gmail.com>
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
v5 changes:
    - Removed redundant warm-up from test case
    - Link to v4: https://lore.kernel.org/all/20260518131407.1026049-2-milant2002@gmail.com/

v4 changes:
    - Fixed build error: call to undeclared function 'STRING_BENCH'
    - Link to v3: https://lore.kernel.org/all/20260515141019.1234037-1-milant2002@gmail.com/

v3 changes:
    - Split memcmp benchmark into wrapper (string_bench_memcmp) and worker
      function (do_string_bench_memcmp).
    - Removed all C99 mixed declarations; moved all variable declarations
      to the top of each function.
    - Converted len, iterations and loop counters in the benchmark to u64
      to avoid implicit casts.
    - Cleaned up spacing, indentation and minor style issues.
    - Added #if defined(CONFIG_RISCV_ISA_ZBB)... in  memcmp.S
    - Link to v2: https://lore.kernel.org/all/20260514121359.931999-1-milant2002@gmail.com/

v2 changes:
    - Fixed KUnit build failures for Clang and non-benchmark configs.
    - Link to v1: https://lore.kernel.org/all/20260512141007.1193033-1-milant2002@gmail.com/

 lib/tests/string_kunit.c | 110 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b..7b14c0052 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -881,6 +881,114 @@ static void string_bench_strrchr(struct kunit *test)
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
+	unsigned int o, i;
+	unsigned int off;
+	u64 len;
+	char *p1;
+	char *p2;
+	u64 iterations;
+	u64 elapsed;
+	u64 ns_per_call;
+	u64 mbps;
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
+	for (o = 0; o < ARRAY_SIZE(offsets); o++) {
+		off = offsets[o];
+
+		for (i = 0; i < ARRAY_SIZE(lengths); i++) {
+			len = lengths[i];
+			p1 = buf1;
+			p2 = buf2 + off;
+			iterations = (len < 512) ? 100000ULL : 10000ULL;
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
@@ -910,6 +1018,8 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_bench_strnlen),
 	KUNIT_CASE(string_bench_strchr),
 	KUNIT_CASE(string_bench_strrchr),
+	KUNIT_CASE(string_test_memcmp),
+	KUNIT_CASE_SLOW(string_bench_memcmp),
 	{}
 };
 
-- 
2.43.0

