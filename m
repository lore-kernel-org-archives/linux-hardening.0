Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09348BD44
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854243; cv=none; b=T+cX9pW8jJgxeRYCqiXDetGXBwTW8e4yNlSZhBxbEUkwti6hsI3g574EFJetiADV12GwAZ79a0pVFl+N+UhBdwiW24OeCYrLxm+eUGstxgcFgz48iYA0R3ypT1ByKm5jHvD1TEGViNK7GR2/bPAiKanMboEvSawSbBWXOarCBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854243; c=relaxed/simple;
	bh=alOcbIeDFm5Hn7hDWtUP3wA2P5q07QNIH5vgXgFTRHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9wLfmNNztuUqNQMRk3k2p+V2hYQq8n56TM3lupRUyO1eOTSdBiBLMS72GImsHVEg0r6D2Yxr6VJssoZy4dmZ6PA61xL01wcYqm6s0ROidt1g05XzJ0Gxs/0r/bOSjhktQ725yRmHJxReMjDP1IZF5U1Zz9ffhc1qZES80llkq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3+8VhmM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3+8VhmM"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso15874815a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778854239; x=1779459039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbNpooQrEJs3yBi52eeAYr0gS+PTGlwWyV+EDa32Vg0=;
        b=f3+8VhmMy40WtYxvZ0OzgFifcOsisTUqOwFf+BuR0HysWZAWXYj07jHZv2EfG+5ybd
         LdIp/oRdVvDtdbePxZ4JhP5l+Mu07HVqFlQ4nCxeOBCTWSisQ/RZqdzfqZGsLLtF5SgM
         iU61Kf9EjgBfhmv07tjimAaN7cQJUAGayvQFM8MO5ioF4hhWKH/4nMZSbb/jC1x7TegF
         Zf3zWax0LVqR6XIha7JfajM4MK/TRItWd6G5p/jtg2JFwNzVd2EGEZuOuo3ayP0Zq++D
         iQtOw9eZzsLV4/7eSkmblm19hj4/n77lypYo/LJ/snouZOVq4i5+DQXB/A5T+EsyX/12
         6ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854239; x=1779459039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbNpooQrEJs3yBi52eeAYr0gS+PTGlwWyV+EDa32Vg0=;
        b=dLyUDlgfGWlwkVYdBL3qUTObQV+GelWkOG9n2ElntxJIiJbc6ih0zE61ki4AzRdGw2
         xxNHPjzbYu3FxZVvBgZNQP28wtoeDkha8ATrFeNeU5E1VcGN7BfJb3qKDrm87SHJvALI
         Pg/M5y7RB4nnQgB90Ptl8KbC6KIbj5H9avi1LpKKeHizOfuOPZX1a7neERCs42yoptPS
         KeAXOMISY+ngN/JWh3hO0GIu9o/1Bt6aOmKJQdyzJ4spMxxaZLCBPx/ZrH3jXMnEHmMa
         xkmd0HPtPJTATEDJW4hXtop3iPSVh4z20Oe53ZeL/x1xu6BgsnVIwTICzfMZ2QYQlcUi
         plow==
X-Forwarded-Encrypted: i=1; AFNElJ9oYM1LhsG0kdKyCkarH1X6kHIEZNG5KXJ3F68azMXPFVb/nSeII5vyISlMyy+4yIL8Iht3gpXigi4xwI/uiyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ulEJ3ctFXZMvdV7poNf/e7dIWHs3Q5eDlITQ2C08ytpDfm2l
	eSEPHOMhOni/V+kVLYLz+ruwx5Se4asnVArooWCt07V4c0FcuLQvyjD+
X-Gm-Gg: Acq92OGQ2IHOJ/zK53B6G2lMeKkuEfLBOYHFLNJLgtHLocmkMAhusxGx798s5ukQ2aG
	uJ35E33gGkQGWCuZRzN/i2W78dVHz2r8d8U6+BYVUNCkDtChVEl99Xz7IjciqdN5ghJ+/ulpB7Z
	m+8Ut4afgQ5AFoRCexuhb375ciJUdukaK1myPjityN3VrfelpxnJu/Va0zjdusjzYWWEz4Snk6r
	tR0xCw3paf/dZkdb57cjxavDvjF6NfraSK/YfQB87NADJUfP60yHH4a4/dCyzvNSjgp6ioh3oej
	T9QvZEbuedKkmIpOnYOMzfNnwFrp23vjYR2VTNt+pDTsLQKq04aWPjZv2uWZlfRZeCrpHSyRUxH
	4iXjigHw21Xkoc62oztTAdhG3wz4U/DqhU56phLjLCV6DAHkuK+4o1nzkWdpbLYLuMMp7WMP9MF
	p0ZnPh+HKm5GkOcH6DnJPj6GsWt2mbVreOvDAMZh3yEQ==
X-Received: by 2002:a05:6402:a256:10b0:683:2a7d:fb5 with SMTP id 4fb4d7f45d1cf-683bc4b344dmr1548414a12.8.1778854239328;
        Fri, 15 May 2026 07:10:39 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([77.243.23.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831197bf00sm2115768a12.31.2026.05.15.07.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:10:38 -0700 (PDT)
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
Subject: [PATCH v3 2/2] lib/string_kunit: extend benchmarks and unit test to memcmp()
Date: Fri, 15 May 2026 16:10:19 +0200
Message-ID: <20260515141019.1234037-3-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515141019.1234037-1-milant2002@gmail.com>
References: <20260515141019.1234037-1-milant2002@gmail.com>
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
 lib/tests/string_kunit.c | 116 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b..95d65c25b 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -881,6 +881,120 @@ static void string_bench_strrchr(struct kunit *test)
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
+static void do_string_bench_memcmp(struct kunit *test)
+{
+	char *buf1 = NULL;
+	char *buf2 = NULL;
+	const u64 lengths[] = { 1, 7, 8, 16, 32, 64, 128, 512, 1024, 4096 };
+	const int offsets[] = { 0, 1, 3, 7 };
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
@@ -910,6 +1024,8 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_bench_strnlen),
 	KUNIT_CASE(string_bench_strchr),
 	KUNIT_CASE(string_bench_strrchr),
+	KUNIT_CASE(string_test_memcmp),
+	KUNIT_CASE_SLOW(string_bench_memcmp),
 	{}
 };
 
-- 
2.43.0

