Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A509B36D4EF;
	Tue, 20 Jan 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892358; cv=none; b=A/I94XKXKz0JgCfb01Sq6bMhhY+mwvlb18JeOYjKS1dEtQvAfHFckJDOYRZFhYjE56WUfJlFDEb15+mlT6YXJ/IcM7PVVcI030h0/lf1sEx+/+0rRrUaT2hJKxe2xMdkOtB4hOX3WcZNzS0GKmkmI1M/PPJvnkq1PcXdQsapfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892358; c=relaxed/simple;
	bh=EDDqVQ90kdARMaa/fnALe60ncrjAdoBPmLEj2q2HhIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NL8gDIG/blnoQbQoWhhjH1ZZzXSUM2uzGKzVCn04cI18oDfV+Q8eSX+z8X4zQzbJiaTl8JQq9iXWFQrncBp2s8641xp8LjUwNK+i1FRvFLFfyj21v5rS8OYRWmF1PxVcYbhRCikwxRqCAlj16GfSk/+rcLK4aElsHm8ZazD1QSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7df63eb0f5cd11f0b0f03b4cfa9209d1-20260120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7d4c9408-8de7-44b5-89f4-81c647000714,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:5937b3556e896896c799b93883eef36f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7df63eb0f5cd11f0b0f03b4cfa9209d1-20260120
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 272933333; Tue, 20 Jan 2026 14:58:57 +0800
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
	ardb@kernel.org,
	charlie@rivosinc.com,
	conor.dooley@microchip.com,
	ajones@ventanamicro.com,
	linus.walleij@linaro.org,
	nathan@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/8] riscv: optimize string functions and add kunit tests
Date: Tue, 20 Jan 2026 14:58:44 +0800
Message-Id: <20260120065852.166857-1-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series provides optimized implementations of strnlen(), strchr(),
and strrchr() for the RISC-V architecture. The strnlen implementation
is derived from the existing optimized strlen. For strchr and strrchr,
the current versions use simple byte-by-byte assembly logic, which
will serve as a baseline for future Zbb-based optimizations.

The patch series is organized into three parts:
1. Correctness Testing: The first three patches add KUnit test cases
   for strlen, strnlen, and strrchr to ensure the baseline and optimized
   versions are functionally correct.
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
comparing the generic C implementation with the new RISC-V assembly versions.

Performance Summary (Improvement %):
---------------------------------------------------------------
Function  |  16 B (Short) |  512 B (Mid) |  4096 B (Long)
---------------------------------------------------------------
strnlen   |    +64.0%     |   +346.2%    |    +410.7%
strchr    |    +4.0%      |   +6.4%      |    +1.5%
strrchr   |    +6.6%      |   +2.8%      |    +0.0%
---------------------------------------------------------------
The benchmarks can be reproduced by enabling CONFIG_STRING_KUNIT_BENCH
and running: ./tools/testing/kunit/kunit.py run --arch=riscv \
--cross_compile=riscv64-linux-gnu- --kunitconfig=my_string.kunitconfig \
--raw_output

The strnlen implementation leverages the Zbb 'orc.b' instruction and
word-at-a-time logic, showing significant gains as the string length
increases. For strchr and strrchr, the handwritten assembly reduces
fixed overhead by eliminating stack frame management. The gain is most
prominent on short strings (1-16B) where function call overhead dominates,
while the performance converges with the C implementation for longer
strings in the TCG environment.

I would like to thank Andy Shevchenko for the suggestion to add benchmarks
and for his detailed feedback on the test framework, and Eric Biggers for
the benchmarking approach. Thanks also to Joel Stanley for testing support
and feedback, and to David Laight for his suggestions regarding performance
measurement.

Changes:
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
  lib/string_kunit: add correctness test for strlen
  lib/string_kunit: add correctness test for strnlen
  lib/string_kunit: add correctness test for strrchr()
  lib/string_kunit: add performance benchmarks for strlen
  lib/string_kunit: extend benchmarks to strnlen and chr searches
  riscv: lib: add strnlen implementation
  riscv: lib: add strchr implementation
  riscv: lib: add strrchr implementation

 arch/riscv/include/asm/string.h |   9 ++
 arch/riscv/lib/Makefile         |   3 +
 arch/riscv/lib/strchr.S         |  35 +++++
 arch/riscv/lib/strnlen.S        | 164 ++++++++++++++++++++
 arch/riscv/lib/strrchr.S        |  37 +++++
 arch/riscv/purgatory/Makefile   |  11 +-
 lib/Kconfig.debug               |  11 ++
 lib/tests/string_kunit.c        | 258 ++++++++++++++++++++++++++++++++
 8 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/strchr.S
 create mode 100644 arch/riscv/lib/strnlen.S
 create mode 100644 arch/riscv/lib/strrchr.S

-- 
2.25.1

