Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7333C9888
	for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760860; cv=none; b=V1xQCIF+Cuij7gW5Y97xMV1ws9QgaLX83CqlYLDHJRRxziJXvPQZgOZA0XtgXdv59Lpu2JKSTZF0I9BocoX35fueYQrSG2JSl0kYNjGuopwSugEPvVvpmOrfWrhz/5sg/ApPOucxQDc3mVHaKtdV43gKXfe1O4iIifFwKFU2pIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760860; c=relaxed/simple;
	bh=IAO71bX6/0l+Uffip8mV9c2OUmrqf/4IKgA70H+dCIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHAn5PRdWeUcoS3P3HdghAdQtWu7Q2BhtsqcfloFy/fXfXDt86uXP1LfXadViHWXPAEo5KgU/acoKKDzNkh221Cnc0Ggpok3DanUetOL1NdpdNER1O8UkvU/HOg7cUTp9U20M8aoMbXRvIVPljWZgxT+OKThkgaK3Ohlw8wrWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmtMA6cH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmtMA6cH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44a14580111so5792060f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778760858; x=1779365658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGqf3rD2el4Fophu1OMYrfA7Yv/0FbhBVG7jdE96agc=;
        b=TmtMA6cHxjf5s7Xq4k0Zc6xuSLk/RX5bk2IQ/e4QpZH1r3gCQtJfjnuraxAZ9U4Bvf
         XLGyEoGVjUkhqdFBk8YprZV4gyYKAuFa5lflsEp874CJWaycyTFHJZfvnQmhw1bFlF9O
         xvDCluF9FiTqpv8ctCITp76Jp+aAWkJ7bR9l3XCIbw7rL5z/ZxDiqNoNFvjfm6+p1j/n
         qcYmErKDBbbjbqmSxYUkL1V5KAok1NgsURh6p4b598ieigscvrnu2Iup4ZtumDgFn3Fs
         ghEzm1uP3+vYl2OAqLATBpaikaF816+p27Be0BKVpzWXtIvgTOBqRliFr3yf4zxq3SWc
         P1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760858; x=1779365658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGqf3rD2el4Fophu1OMYrfA7Yv/0FbhBVG7jdE96agc=;
        b=oDdJJC+RAWJKLli3gFUTeydRSTexLuemG/bwyV3e1QUB+83K2TnAbrJxuoYMZbO09/
         sEOi0+A/QTpFBRV6PNz02tKGK4MVO0za2D70R8uhiyQquWrSsNLVRxMO9Vtac3zBpx+E
         jKlQXzOBsjh45W91o6m5lybB71xDhgyC6v2PINPuAYmt+kI8gETG/LpdYz3A2mucahNL
         r2XvATN1UGNH+IfICYdr7Pf6HdGOcWleVCzsqQKbeocCioqjF/MrCJXqHjUIlTeRDuo+
         YZnMGhDCZ1SVXjIBBe40ZlSzvwu4ohBG9Z52OPcKNraQH1uK4DBYDGBVTVekr2W1PwZz
         mHyA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZkY0/4h9OaEN1hdtIawd62VhTrKuUCgWlFtdttzMbQIK9oqO3LSy+AdNrZ3ej77tgFc2o+zM4iI8p8df9kWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwN8pBDZkDmI6iB8Oql0dC1n3p1u9JkMKS+1pkh7CWTnrcxjA7
	BixT4T+tzvp40WcbJrWh6G9S+R2ZgDZC97bkDhLVLFFZp6OsjuybZAHO
X-Gm-Gg: Acq92OEmUh+GRk2xyYJDeA3F4P5KvQshdMepY6rzCQ/Ku+CqIs2k16fh2QeS0PPN3DG
	Li27b9lsKgshu3zEyAjc4Dtf0TBdiN/m7yl/pCSCNKqwytKRHrWEBlRzO/dFIZR+Kjx4y+VkqJA
	TVzFjN8nLyRr6GszgyZG37UHF1DuIA2ZIlDQSDkC/dZujiP38OHiFBarfJTjXIGCBW9y85/OVX3
	emAVnZrtYL+/cThfKpGtF4uE7F4j03nVaKlqbCFAgqPkN12b7vUkO/yCBkmWEs5UD1ecaEN4T8W
	/psUgdaKHFColTWqMp25EtcofFIU4ft62WBIgt3ckDbIG492o+edv5QfivedrL+FE9Uqm7+2Nv1
	CEBhGTmbKZ8e02QWuCM6aA4wW2M0dqZOqHSrN4yHIWopH88VIDiinMnJtAiSWrFOJ5HtDReqNCr
	8V3Fxpn1U3Abrc94Zv0F7sNzZLlX02CaB0xHCcCLNJiF8STJ4eFz4p
X-Received: by 2002:a05:6000:1acc:b0:43d:7af0:3a7c with SMTP id ffacd0b85a97d-45c7a4ef3e4mr11408615f8f.29.1778760857731;
        Thu, 14 May 2026 05:14:17 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([77.243.27.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm6285630f8f.2.2026.05.14.05.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:14:17 -0700 (PDT)
From: Milan Tripkovic <milant2002@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>,
	Milan Tripkovic <milant2002@gmail.com>,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH v2 0/2] riscv: lib: add optimized memcmp() and extend KUnit tests
Date: Thu, 14 May 2026 14:13:56 +0200
Message-ID: <20260514121359.931999-1-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an assembly implementation of memcmp() for RISC-V. This version
incorporates feedback from v1 regarding alignment safety, loop 
efficiency, and ZBB usage.

The second patch extends the KUnit string tests to include functional
verification and benchmarking for memcmp().
        
Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

---
v2 changes:
    - Added alignment checks for buffers to avoid expensive misaligned loads.
    - Optimized the loop using end-pointers to reduce per-iteration overhead.
    - Implemented word-aligned tail handling using ZBB shifts.
    - Removed redundant pointer equality (a0 == a1) check.
    - Retained BE support via #ifndef; ZBB rev8 is used for the LE fast-path.
    - Fixed KUnit build failures for Clang and non-benchmark configs.

Milan Tripkovic (2):
  riscv: lib: add memcmp() implementation
  lib/string_kunit: extend benchmarks and unit test to memcmp()

 arch/riscv/include/asm/string.h |   2 +
 arch/riscv/lib/Makefile         |   1 +
 arch/riscv/lib/memcmp.S         | 124 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 lib/tests/string_kunit.c        | 106 +++++++++++++++++++++++++++
 5 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/memcmp.S

-- 
2.43.0

