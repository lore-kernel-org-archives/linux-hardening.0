Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18693ED3D0
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199241; cv=none; b=lqNnhemSUSur+fcEKDM4se0S2ldHOKRCw7fMRxA48BoJveffiNSItClyW1KgPw1UdJEYo9ikLRO+swXtN60CwKNibo7Xitfmtqwlv8BEawzfE2QZOOhO2c3PjII7JA9kj0EZWFtVcuZg5mNiJQHBuSy9p/9W0pEOpS8LDs1YBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199241; c=relaxed/simple;
	bh=U6xmmjz5x3bhy/fDsykqsO73fvKnfshFcF/smiZMFhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9hXPfw1jCvB5zi6SDS7j6GBy5IKFk1phpzPEH5BU8NWSZGOG+z8BSqTbnVw+AyimmqDSL/L/ZfPBjgAqr+039JtgxabGcreUpG16cOemASMw4+aL06Y8FDPvdcjyjxu3as2e6dfQwav0o3uGuQPtVb6i6yDSDAvTZwez6Gfyb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAEhga8c; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAEhga8c"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-448528f4e69so2436924f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779199238; x=1779804038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BK6P9ZRx8illl6oBwVYfN3EvftuNIWvP02Fn1jxek7Q=;
        b=LAEhga8cUteAIjOWWhdNGE7AaflBsc18Fk61l04A4XDMJs6wBOUVuU/SYkPnC0EXGk
         zVeHlgYqEvmn6BVw4vcw7b+cdqwi8MG7Y6PO65Dk401b4IuG9QGu3hp7h6TX1jS65rtU
         RQZXG7WdAcVcY0FJvUi4ZctdZ4iq1tZzScs55aa3faIWmDpRL3kzYEYsOBaRnAVuIO8e
         ne4KMRDd2IVOmVf723ZsK2g4IEkzy4NOkqeTX5RT2/SJczc4mHm860MtBHeYWD8gSWCo
         weUznh0LKBfiG2f3g6kY157mq6is8U2Xi9c/tkh3Wr3ZLf+Z5QPH5X3hWX9HTYo11zdR
         i2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199238; x=1779804038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK6P9ZRx8illl6oBwVYfN3EvftuNIWvP02Fn1jxek7Q=;
        b=q5lDNq6Wkk3P4saRmU1qeNcTixohIbO50c4ENl2db8TV/zuhX8wrS6Qh74Jsul5q5J
         +L3utKidr7t/WVHCRu3V+N9hCb5dRtM5EoIzKTBEUMpiiTsjww3hGr3Q0kz79ZfNxMTu
         xjvp/bm16dPTrVJFk+YAAGvcZavpv2cly9tCCE/u3B7RgkeWexbTu2uOnNf9Ybfw+LsT
         Nnn5Kh36sFhMhwTfl6MXgsNzjb6rMbQTY4m2tSTAOjt3BWDOHCUss4sAchYwo/FPVUBJ
         yhfhlsNGjOflv2bB6MmvCMtruF+s8PUc/Bakyrq0eiSwmyOyWLXxEMPyQ1q3/dM7u+dU
         3A+w==
X-Forwarded-Encrypted: i=1; AFNElJ9e2yIiJ4hfLTB4949DUDfn90q676W1TUPYOhJ0K2K/ynXkZ9zU5qxeLAgb9LjJFeLKffaPjrMJX0921+lzbx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQtRDhM8vPqvSxMBS65dHTQ4ogkHzBMhLM4l5ADwOmj3UVGcj
	7YLFn48UZprdU/tbPEUH9TA8Qk+xRNjumni8oaFcu05uskgB2Tg+16+i
X-Gm-Gg: Acq92OHwxTYP5K8mld8Qf5VXpl4eJs7ARs0lVQmV/piVOOoMSHINvo51/qQC8XmdWux
	YMFQkMOz2kLbbSRIeE3e9mjKwdilXbGfuTgKQoaI0GJ/UPAauvvvRviDN0Xs0XBjWlr1S85hFEH
	B3qDOf8ysQbwVj/8QrM1eah1jMerRZvUCbJ+PlyaSZ2ko2gDSQnHjgCxSY6WLaQx9qUAdWop7HW
	wjceRbfxbXZXbWY8wpqRqbJPJ26X44diCZF0MEqdby3Rcy2HMHS6eySw2ECj6eYbmiIjlogDgQg
	eu3rAPLoWtEE4V0KtA21bkLymgJuqwmAXlJfSQhib9kwfs8QpiwWtcas9WBIkbE0OQx0kRGc/nP
	QjJSkloaiNwz1D4SElv/HX4l0W3syaMCSfcoRgYSBAuyg2GBdKn1mURpStPcBlVpyIIQKQaEUcT
	t8h1Y7D2kZfHOUz0hz22vgmqspdvLZJa9lJUDsrym+
X-Received: by 2002:a05:6000:4007:b0:43d:1cec:4766 with SMTP id ffacd0b85a97d-45e5c5bf971mr32297364f8f.23.1779199237965;
        Tue, 19 May 2026 07:00:37 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([95.86.49.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767d0bsm44065144f8f.3.2026.05.19.07.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:00:37 -0700 (PDT)
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
	Milan Tripkovic <milant2002@gmail.com>,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH v5 0/2] riscv: lib: add optimized memcmp() and extend KUnit tests
Date: Tue, 19 May 2026 16:00:27 +0200
Message-ID: <20260519140029.1190381-1-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v5 series provides an optimized RISC-V memcmp() implementation 
along with extended KUnit tests for functional verification and 
benchmarking

The memcmp() implementation now uses word-aligned loads for the generic 
path and leverages Zbb for fast sign resolution on supported hardware. 
A robust fallback to byte-by-byte comparison is implemented for non-Zbb 
systems to ensure correctness and stability across different toolchains 
and hardware revisions.

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

---
v5 changes:
    - Removed redundant warm-up from test case
    - Optimized generic memcmp path with word-aligned loads.
    - Implemented non-ZBB fallback to byte comparison per review.
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
    - Added alignment checks for buffers to avoid expensive misaligned loads.
    - Optimized the loop using end-pointers to reduce per-iteration overhead.
    - Implemented word-aligned tail handling using ZBB shifts.
    - Removed redundant pointer equality (a0 == a1) check.
    - Retained BE support via #ifndef; ZBB rev8 is used for the LE fast-path.
    - Fixed KUnit build failures for Clang and non-benchmark configs.
    - Link to v1: https://lore.kernel.org/all/20260512141007.1193033-1-milant2002@gmail.com/

Milan Tripkovic (2):
  riscv: lib: add memcmp() implementation
  lib/string_kunit: extend benchmarks and unit test to memcmp()

 arch/riscv/include/asm/string.h |   2 +
 arch/riscv/lib/Makefile         |   1 +
 arch/riscv/lib/memcmp.S         | 106 ++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 lib/tests/string_kunit.c        | 110 ++++++++++++++++++++++++++++++++
 5 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/memcmp.S

-- 
2.43.0

