Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC823EA94;
	Thu, 29 Jan 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670159; cv=none; b=ZIIb4aL6dc8+d3pPEq5qjbM+lmoOezxNXdqr7I82lxpK7/JGTastvMuK/WU39YXa0LkZQoQpY3CATNVIhCshQ44seu8nJ3Z87QguelqkJmh4vjAzdLkIWYhzodW2Le4Zb7QxwW75hti0iGw80yYHm1ZWB2WkylgHFCTH+Wjz838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670159; c=relaxed/simple;
	bh=ku5OHSJAkkvVcH5Nd/i1Vjxjtz4dKYzfQpsoK0iM/6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RJyn9IGVEz8TQwlZpxYirRKrEmx4AQn6Y8rtlwWjrkgKEbdqCAchaJxEu8tu6wxWbUi1Li3azB6uwL3ajMfs9QQiaSFXXzocAsgrfj2MjAJDehbyoHMBY7NVFy5BGHJQJgQem4wDes8e54UnXq6QUsHrkvpTy2bwVigZL199qQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7b4013d4fce011f0b0f03b4cfa9209d1-20260129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:63c251e9-6d9a-4116-83f4-d0e2245be342,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:57e8c5082dda505fa025034405a69548,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7b4013d4fce011f0b0f03b4cfa9209d1-20260129
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 226172025; Thu, 29 Jan 2026 15:02:31 +0800
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
Subject: [PATCH v6 0/8] riscv: optimize string functions and add kunit tests
Date: Thu, 29 Jan 2026 15:02:19 +0800
Message-Id: <20260129070227.220866-1-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series provides optimized implementations of strnlen(), strchr(),
and strrchr() for the RISC-V architecture. The strnlen() implementation
is derived from the existing optimized strlen(). For strchr() and
strrchr(), the current versions use simple byte-by-byte assembly logic,
which will serve as a baseline for future Zbb-based optimizations.

The patch series is organized into three parts:
1. Correctness Testing: The first three patches add KUnit test cases
   for strlen(), strnlen(), and strrchr() to ensure the baseline and
   optimized versions are functionally correct.
2. Benchmarking Tool: Patches 4 and 5 extend string_kunit to include
   performance measurement capabilities, allowing for comparative
   analysis within the KUnit environment.
3. Architectural Optimizations: The final three patches introduce the
   RISC-V specific assembly implementations.

Following suggestions from Andy Shevchenko, performance benchmarks have
been added to string_kunit.c to provide quantifiable evidence of the
improvements. Andy provided many specific comments on the implementation
of the benchmark logic, which is also inspired by Eric Biggers'
crc_benchmark(). Performance was measured in a QEMU TCG (rv64) environment,
comparing the generic C implementation with the new RISC-V assembly
versions.

Performance Summary (Improvement %):
---------------------------------------------------------------
Function  |  16 B (Short) |  512 B (Mid) |  4096 B (Long)
---------------------------------------------------------------
strnlen   |    +72.6%     |   +350.1%    |    +427.5%
strchr    |    +3.6%      |   +3.5%      |    -0.3%
strrchr   |    +5.3%      |   +5.8%      |    +0.8%
---------------------------------------------------------------
The benchmarks can be reproduced by enabling CONFIG_STRING_KUNIT_BENCH
and running: ./tools/testing/kunit/kunit.py run --arch=riscv \
--cross_compile=riscv64-linux-gnu- --kunitconfig=my_string.kunitconfig \
--raw_output

The strnlen() implementation leverages the Zbb 'orc.b' instruction and
word-at-a-time logic, showing significant gains as the string length
increases. For strchr() and strrchr(), the handwritten assembly reduces
fixed overhead by eliminating stack frame management. The gain is most
prominent on short strings where function call overhead dominates,
while the performance converges with the C implementation for longer
strings in the TCG environment.

I would like to thank Andy Shevchenko for the suggestion to add benchmarks
and for his detailed feedback on the test framework, and Eric Biggers for
the benchmarking approach. I am also grateful to Qingfang Deng for
providing the optimized implementation logic for strnlen(). Thanks also to
Joel Stanley for testing support and feedback, and to David Laight for his
suggestions regarding performance measurement.

Changes:

v6:
- Use vmalloc() and page-boundary alignment in strlen(), strnlen(), and
  strrchr() correctness tests to ensure over-reads are detected, as
  suggested by Kees Cook. Consequently, previous Acked-by and Tested-by
  tags for these tests have been dropped.
- Added <linux/minmax.h> include.
- Update STRING_BENCH_BUF macro to initialize variables inside the loop.
- Fixed operator positioning and removed redundant blank lines.
- Added warm-up iteration comment.

v5:
- Include <linux/ktime.h> for ktime_get_ns() and <linux/time64.h> 
  for NSEC_PER_SEC.
- Use #if IS_ENABLED(CONFIG_STRING_KUNIT_BENCH) to define the macro 
  instead of using if (!IS_ENABLED(...)) inside the function.
- Declare variables inside for-loops.
- Simplify the for-loop logic in alloc_max_bench_buffer().
- Replace the magic number 1000 with (NSEC_PER_SEC / MEGA) to clarify 
  the bytes/ns to MB/s conversion.

v4:
- Refine formatting and terminology:
  - Refer to '\0' as NUL.
  - Append parentheses () when referencing function names.
  - Ensure trailing commas are present in initializers.
  - Reorder local variable declarations to follow the "reverse Xmas tree" 
    style. (Style-only change; kept existing Acked-by tags).
- Improve documentation: Refine comments and commit messages for better 
  clarity.
- Improve readability by using (1 * MEGA) instead of 1000000UL.
- Replace max_t() with max() where type-casting is unnecessary.
- Simplify the return value check for kunit_kzalloc() in 
  alloc_max_bench_buffer().
- Remove redundant NUL-terminator handling in STRING_BENCH_BUF().
- Optimize strnlen() implementation by replacing bleu/bgeu instructions 
  with minu, as suggested by Qingfang Deng.
- Remove incorrect Suggested-by tags from certain patches.
- Drop Tested-by tags for benchmark-related patches due to significant 
  framework changes since v3.
- Re-run all tests and updated the performance data in the documentation.

v3:
- Re-implement benchmark logic inspired by crc_benchmark().
- Add 'len - 2' test case to strnlen correctness tests.
- Incorporate detailed benchmark data into individual commit messages.

v2: 
- Refactored lib/string.c to export __generic_* functions and added
  corresponding functional/performance tests for strnlen, strchr,
  and strrchr (Andy Shevchenko).
- Replaced magic numbers with STRING_TEST_MAX_LEN etc. (Andy Shevchenko).

v1: Initial submission.

---

Feng Jiang (8):
  lib/string_kunit: add correctness test for strlen()
  lib/string_kunit: add correctness test for strnlen()
  lib/string_kunit: add correctness test for strrchr()
  lib/string_kunit: add performance benchmark for strlen()
  lib/string_kunit: extend benchmarks to strnlen() and chr searches
  riscv: lib: add strnlen() implementation
  riscv: lib: add strchr() implementation
  riscv: lib: add strrchr() implementation

 arch/riscv/include/asm/string.h |   9 ++
 arch/riscv/lib/Makefile         |   3 +
 arch/riscv/lib/strchr.S         |  35 ++++
 arch/riscv/lib/strnlen.S        | 164 +++++++++++++++++++
 arch/riscv/lib/strrchr.S        |  37 +++++
 arch/riscv/purgatory/Makefile   |  11 +-
 lib/Kconfig.debug               |  11 ++
 lib/tests/string_kunit.c        | 273 ++++++++++++++++++++++++++++++++
 8 files changed, 542 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/strchr.S
 create mode 100644 arch/riscv/lib/strnlen.S
 create mode 100644 arch/riscv/lib/strrchr.S

-- 
2.25.1

