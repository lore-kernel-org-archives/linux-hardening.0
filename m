Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39B37999D;
	Thu, 29 Jan 2026 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670166; cv=none; b=U8XXLQU2rz57lsj3VhSskR+YVpFq02Eqqi0V2J5Tnwef01qXY6mKH7X15azL/lxasgElLMgBYn0IB4y7oZ0nxWJHxJvmBZeRxX7oJZchtf8cDQseAA2IgzegSJsend+fvzcYoA+E2GoFf6eiougf+BVK248bp616JKY9pG8vifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670166; c=relaxed/simple;
	bh=Ke+ry83FirFtNQiVokuMP16ZYl6Fm/zsnSEiK80ESFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f34pnbtCrztU5S/KFfwlSva1556Ck9X1njT6AtM/WwKkvl6Z8ptsl6AU7eYcrew/ITWze0gZMRcRz6ZPMxH43dsiXWUmLd1YkKVgGx0O2Xa654W79UBrZT5cJeAw7+n+d9266i8waILfgB2dGix1yCO8jxx5FQO5l6MggRR3T9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7d369a46fce011f0b0f03b4cfa9209d1-20260129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5e1217de-990d-4401-a1b6-2ed64fb254dd,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:05035b19a8c59727fa8d6b1a693e1812,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7d369a46fce011f0b0f03b4cfa9209d1-20260129
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1864206166; Thu, 29 Jan 2026 15:02:35 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	kees@kernel.org,
	andy@kernel.org,
	jiangfeng@kylinos.cn,
	ebiggers@kernel.org,
	martin.petersen@oracle.com,
	herbert@gondor.apana.org.au,
	samuel.holland@sifive.com,
	ajones@ventanamicro.com,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	linus.walleij@linaro.org,
	nathan@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v6 4/8] lib/string_kunit: add performance benchmark for strlen()
Date: Thu, 29 Jan 2026 15:02:23 +0800
Message-Id: <20260129070227.220866-5-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260129070227.220866-1-jiangfeng@kylinos.cn>
References: <20260129070227.220866-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a benchmarking framework to the string_kunit test suite to
measure the execution efficiency of string functions.

The implementation is inspired by crc_benchmark(), measuring throughput
(MB/s) and latency (ns/call) across a range of string lengths. It
includes a warm-up phase, disables preemption during measurement, and
uses a fixed seed for reproducible results.

This framework allows for comparing different implementations (e.g.,
generic C vs. architecture-optimized assembly) within the KUnit
environment.

Initially, provide a benchmark for strlen().

Suggested-by: Andy Shevchenko <andy@kernel.org>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 lib/Kconfig.debug        |  11 +++
 lib/tests/string_kunit.c | 160 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79..21b058ae815f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2475,6 +2475,17 @@ config STRING_HELPERS_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 
+config STRING_KUNIT_BENCH
+       bool "Benchmark string functions at runtime"
+       depends on STRING_KUNIT_TEST
+       help
+         Enable performance measurement for string functions.
+
+         This measures the execution efficiency of string functions
+         during the KUnit test run.
+
+         If unsure, say N.
+
 config FFS_KUNIT_TEST
 	tristate "KUnit test ffs-family functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index f16dfa29e8ce..4636379c6d5c 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -6,10 +6,16 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/prandom.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/time64.h>
+#include <linux/units.h>
 #include <linux/vmalloc.h>
 
 #define STRCMP_LARGE_BUF_LEN 2048
@@ -21,6 +27,9 @@
 #define STRING_TEST_MAX_LEN	128
 #define STRING_TEST_MAX_OFFSET	16
 
+#define STRING_BENCH_SEED	888
+#define STRING_BENCH_WORKLOAD	(1 * MEGA)
+
 static void string_test_memset16(struct kunit *test)
 {
 	unsigned i, j, k;
@@ -706,6 +715,156 @@ static void string_test_strends(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, strends("", ""));
 }
 
+#if IS_ENABLED(CONFIG_STRING_KUNIT_BENCH)
+/* Target string lengths for benchmarking */
+static const size_t bench_lens[] = {
+	0, 1, 7, 8, 16, 31, 64, 127, 512, 1024, 3173, 4096,
+};
+
+/**
+ * alloc_max_bench_buffer() - Allocate buffer for the max test case.
+ * @test: KUnit context for managed allocation.
+ * @lens: Array of lengths used in the benchmark cases.
+ * @count: Number of elements in the @lens array.
+ * @buf_len: [out] Pointer to store the actually allocated buffer
+ * size (including NUL character).
+ *
+ * Return: Pointer to the allocated memory, or NULL on failure.
+ */
+static void *alloc_max_bench_buffer(struct kunit *test,
+		const size_t *lens, size_t count, size_t *buf_len)
+{
+	size_t max_len = 0;
+	void *buf;
+
+	for (size_t i = 0; i < count; i++)
+		max_len = max(lens[i], max_len);
+
+	/* Add space for NUL character */
+	max_len += 1;
+
+	buf = kunit_kzalloc(test, max_len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	if (buf_len)
+		*buf_len = max_len;
+
+	return buf;
+}
+
+/**
+ * fill_random_string() - Populate a buffer with a random NUL-terminated string.
+ * @buf: Buffer to fill.
+ * @len: Length of the buffer in bytes.
+ *
+ * Fills the buffer with random non-NUL bytes and ensures the string is
+ * properly NUL-terminated.
+ */
+static void fill_random_string(char *buf, size_t len)
+{
+	struct rnd_state state;
+
+	if (!buf || !len)
+		return;
+
+	/* Use a fixed seed to ensure deterministic benchmark results */
+	prandom_seed_state(&state, STRING_BENCH_SEED);
+	prandom_bytes_state(&state, buf, len);
+
+	/* Replace NUL characters to avoid early string termination */
+	for (size_t i = 0; i < len; i++) {
+		if (buf[i] == '\0')
+			buf[i] = 0x01;
+	}
+
+	buf[len - 1] = '\0';
+}
+
+/**
+ * STRING_BENCH() - Benchmark string functions.
+ * @iters: Number of iterations to run.
+ * @func: Function to benchmark.
+ * @...: Variable arguments passed to @func.
+ *
+ * Disables preemption and measures the total time in nanoseconds to execute
+ * @func(@__VA_ARGS__) for @iters times, including a small warm-up phase.
+ *
+ * Context: Disables preemption during measurement.
+ * Return: Total execution time in nanoseconds (u64).
+ */
+#define STRING_BENCH(iters, func, ...)					\
+({									\
+	/* Volatile function pointer prevents dead code elimination */	\
+	typeof(func) (* volatile __func) = (func);			\
+	size_t __bn_iters = (iters);					\
+	size_t __bn_warm_iters;						\
+	u64 __bn_t;							\
+									\
+	/* Use 10% of the given iterations (maximum 50) to warm up */	\
+	__bn_warm_iters = max(__bn_iters / 10, 50U);			\
+									\
+	for (size_t __bn_i = 0; __bn_i < __bn_warm_iters; __bn_i++)	\
+		(void)__func(__VA_ARGS__);				\
+									\
+	preempt_disable();						\
+	__bn_t = ktime_get_ns();					\
+	for (size_t __bn_i = 0; __bn_i < __bn_iters; __bn_i++)		\
+		(void)__func(__VA_ARGS__);				\
+	__bn_t = ktime_get_ns() - __bn_t;				\
+	preempt_enable();						\
+	__bn_t;								\
+})
+
+/**
+ * STRING_BENCH_BUF() - Benchmark harness for single-buffer functions.
+ * @test: KUnit context.
+ * @buf_name: Local char * variable name to be defined.
+ * @buf_size: Local size_t variable name to be defined.
+ * @func: Function to benchmark.
+ * @...: Extra arguments for @func.
+ *
+ * Prepares a randomized, NUL-terminated buffer and iterates through lengths
+ * in bench_lens, defining @buf_name and @buf_size in each loop.
+ */
+#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
+do {									\
+	size_t _bn_i, _bn_iters, _bn_size = 0;				\
+	u64 _bn_t, _bn_mbps = 0, _bn_lat = 0;				\
+	char *_bn_buf;							\
+									\
+	_bn_buf = alloc_max_bench_buffer(test, bench_lens,		\
+			ARRAY_SIZE(bench_lens), &_bn_size);		\
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, _bn_buf);			\
+									\
+	fill_random_string(_bn_buf, _bn_size);				\
+									\
+	for (_bn_i = 0; _bn_i < ARRAY_SIZE(bench_lens); _bn_i++) {	\
+		size_t buf_size = bench_lens[_bn_i];			\
+		char *buf_name = _bn_buf + _bn_size - buf_size - 1;	\
+		_bn_iters = STRING_BENCH_WORKLOAD / max(buf_size, 1U);	\
+									\
+		_bn_t = STRING_BENCH(_bn_iters, func, ##__VA_ARGS__);	\
+		if (_bn_t > 0) {					\
+			_bn_mbps = (u64)(buf_size) * _bn_iters *	\
+					(NSEC_PER_SEC / MEGA);		\
+			_bn_mbps = div64_u64(_bn_mbps, _bn_t);		\
+			_bn_lat = div64_u64(_bn_t, _bn_iters);		\
+		}							\
+		kunit_info(test, "len=%zu: %llu MB/s (%llu ns/call)\n",	\
+				buf_size, _bn_mbps, _bn_lat);		\
+	}								\
+} while (0)
+#else
+#define STRING_BENCH_BUF(test, buf_name, buf_size, func, ...)		\
+	kunit_skip(test, "not enabled")
+#endif /* IS_ENABLED(CONFIG_STRING_KUNIT_BENCH) */
+
+static void string_bench_strlen(struct kunit *test)
+{
+	STRING_BENCH_BUF(test, buf, len, strlen, buf);
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memset16),
 	KUNIT_CASE(string_test_memset32),
@@ -731,6 +890,7 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_strtomem),
 	KUNIT_CASE(string_test_memtostr),
 	KUNIT_CASE(string_test_strends),
+	KUNIT_CASE(string_bench_strlen),
 	{}
 };
 
-- 
2.25.1

