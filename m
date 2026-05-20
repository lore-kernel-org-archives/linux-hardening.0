Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540D3DF001
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280809; cv=none; b=V66+VPQpRwJO/TL9duczeetOMoEJ2YbZyF+RjZJhZTldKsMzevB1so7MKNTYLQC/Grk/SnH6KHQ3rZaggjH6sv3XlkTP3vq38fkBB8oGtBby0dacGVbOC3JsyJ6SD8Cd7Q5gtO/Vepctmfec+Ah9sIvf12vSqauyQR2WKQlJIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280809; c=relaxed/simple;
	bh=riO1ZNMnJ54rVBK8RID6oN0pWaUmns533VE2TlxnP8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndIp/92M9+gCLrG0d5M1oXHRDdu5aTFaJGqlmlalcT/xIZuryKmKivdZNNTQX6bpO3lU3ZsYo7bF5YbqSy/7vbNwALeoh/wSf4uBGNfReQ2CF83cX2N56YTUa4cccUOAeFRsIK2iGvgk3waU7vq8aV4Mramg2xWcdCm6oAxkGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlWI1n9f; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlWI1n9f"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43eb05b1875so2667613f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779280806; x=1779885606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF9TELI0fOJNnQQ0E3LX4ebM27p0Qx0XyBTx0DYfCok=;
        b=XlWI1n9fatfZ3M0GiBap5c0WoV8VQsjet5Hb0ozB6cMB7oE2HrlB/q0XDi29KtUc3t
         QBnoajYpvcCGw4OTTKwECLBRFIikmNtMGEhBbXjjCW1RHUXu5NzRKI65a3Plzw5MaxCy
         VtLoXg5ORiYT0rm7byYx6E1vIM5/M1zSnm40ff5CV2lrsFcmx2r2p8Q/oi+oKXlJjMos
         XJH7wRE6KGBC5AoQQ9oofRS+5zpFySwSXi9farG9Rv7iImIZZJyAwfxgTzrlCOKxnspT
         8IYpWKJCHfLZv1/M3E/w+uJoXfdorjKrKS53JSa40aj3Lwvm3dlWiqtoj4lT/eZcNZS/
         zddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280806; x=1779885606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZF9TELI0fOJNnQQ0E3LX4ebM27p0Qx0XyBTx0DYfCok=;
        b=VxAWaQmenpo/fAw6+MsFWDFZR+WAvbxejF9Fiiuex2XwMoOeyWa1HWpj27o4616gQo
         W4nWOXuG8aZVdYL6AaIbNQJriiBUv5u+DYAmT0orUHS3JNw7voNsmtIM3bTAOJ6zXG3t
         7jnAEwFLrVYRbPWFrXaShmPv0tBMXeavn/8C11A967gzADyCL6KHTZ/BuouX53CO3MmO
         Reqq5ff8pbVKKWZYXsk6iq6u0fyVOYU/Ex5N3uM+q1u6vH0ln1qPrxhIuu6qXnUJeOnW
         LtkUrRk/LXsw+2nCSo4kVFCxfn6nedQMjmCRhxX1VVVHHfJbFNqSY9I35lBcYl6Ji6i8
         VEwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LZu1snOmBHVfJMVzycNo059GbtHrtohxXrPI3rUCa6O6YK6JT/t9G3CU/l4s+olTdso6yf0ZzyGqiT81u6X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpLQntPyxxAXbocsy9yvn6FtDL2aFW1hOWk4meXMZW7d0H9pm
	0dkn0P5P/C+Q7gp6Opts/T+WOL9hFD24CsQjczTubTA7dFxQzpX30Za1
X-Gm-Gg: Acq92OHnNBlZvpXQdpsF0WqJdbmqbli6xvCB9LHGUUragoHgWH2onuG4nf0DvK477fS
	VuKiUUnFwSO82y3tJ2yEQEdTu4VXfLEjMxdvQAc8Mrp+tSGnkxjzl9IjHju2RDaBAqegHKbx5vc
	oJzDbMeKGQUaa1FsI9k9NtMNYZsKRXeyX5uZkZNQTuzkOzqGe7W1U7BjujhXfN+5wjqM0P++fok
	FKLbG9XMpFOjYjn/pa1e9KCdy2FyE7rURr9URt79Dc4w+qAsMvzzJZRiniVDh1oe+yfuC+KotDW
	GFt3C6Eg2BZ63rp6haHoz1n3IMRgS2Z8G/uKicxgH+zyHDmSgQmPNQEXkYR5ExZIUwMeRBJuPDb
	x9nXNpRDlt/0rP6qPAPcbHuNGjUccaWXfljixt3bDA7qNji6sLl9Yy5zFB0z0BQ5MygfbjBbZUb
	Pwvel/L3Y2yzT/xn771rsqEN5F6Pj13bYMXdfKi99DI7DbIafXjexM
X-Received: by 2002:a05:6000:4007:b0:456:ba09:3e64 with SMTP id ffacd0b85a97d-45e5c5b3669mr37757602f8f.1.1779280806221;
        Wed, 20 May 2026 05:40:06 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([89.216.37.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm54460252f8f.12.2026.05.20.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:40:05 -0700 (PDT)
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
Subject: [PATCH v6 2/2] lib/string_kunit: extend benchmarks and unit test to memcmp()
Date: Wed, 20 May 2026 14:39:54 +0200
Message-ID: <20260520123954.379630-3-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520123954.379630-1-milant2002@gmail.com>
References: <20260520123954.379630-1-milant2002@gmail.com>
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
v6 changes:
    - Fixed build errors kernel test robot noticed. 
    - Link to v5: https://lore.kernel.org/all/20260519140029.1190381-1-milant2002@gmail.com/
    
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
    
 lib/tests/string_kunit.c | 106 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0819ace5b..d395627f7 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -881,6 +881,110 @@ static void string_bench_strrchr(struct kunit *test)
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
+			iterations = (len < 512) ? 100000ULL : 10000ULL;
+			elapsed = STRING_BENCH(iterations, memcmp, buf1, buf2 + off, len);
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
@@ -910,6 +1014,8 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_bench_strnlen),
 	KUNIT_CASE(string_bench_strchr),
 	KUNIT_CASE(string_bench_strrchr),
+	KUNIT_CASE(string_test_memcmp),
+	KUNIT_CASE_SLOW(string_bench_memcmp),
 	{}
 };
 
-- 
2.43.0

