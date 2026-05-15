Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6023AF67C
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854239; cv=none; b=gApFUMlpfQH36Qo74nNHe3sMr1RSBFedW5d59PA+Wn5VX8r2rCwM2Q759h35uecDxcLR7nFdR1lTn4sm/imFmyjuQk40oebDlPbGxgmLm32bowDFmdrg6Swd9eEVEBRKLrNS8joIhJeqX4hzMy4jhRtkbjJp7NhZK8+gxntLXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854239; c=relaxed/simple;
	bh=VBq8idrgBob0ux77XAytvvqN1OJXBAZAdRTkE9i2hII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xs28vQo2RoJ7YKEYU4DyvFwRAd4tP2lp9pxsOGom3z5xx2dohM8mOrjcPpQqEZaiMS19dbWNMzVvzC/8UEviyl4jOldN/9UtOZ42HNZhvz2H3yid2Q9a2u+mOnlW3YMidOKHWHKDAG1rhdmoXn7Ny3i+vrdVK/2i8ctB7VSsOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgav8TtQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgav8TtQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bcc9fdc959cso1053872066b.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778854236; x=1779459036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpAbwEPMmZHunefUXov3BCvB1DVZ1pCLobl0y+AYsyw=;
        b=Lgav8TtQDaYol+9j0O4+8fPt6Qcqj1N1Q1iNgO7MX4MtytUz6fdBBin65ka8vG3MHz
         UkbQY9pB405nhcOsQqiQ5w+xLmM3LuWLSUQHP23KztvzBPDcadyIcE/aAHMkOK+MjPns
         XW+x8z4wAlVINXz/V90CKYlaJwhlbLpz7590M9+UleQXLsjbCg7yK/Q4g6lilgbTUyfJ
         Pg00i+g6b0E9hX2Fmf7GlC8ykztcssVklWBpYZnVTg1cEzzjgy5N8FGEnSF3nEj/XWjn
         nl1SrfCPl4PqCQsRmS+Js0DEF7RFKy7HSLn7CPMWh5N3SLBaTlenJuRhtIOEj5P27BoN
         mqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854236; x=1779459036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpAbwEPMmZHunefUXov3BCvB1DVZ1pCLobl0y+AYsyw=;
        b=Qbg+EEldbApgvo7y/5oLnUna3/PD0Udvt7i4IvXtCbbgPuMdScCmNOSVi/29gYTBWL
         Pg5cJQI/mpz8sB/bDRm1rWINv6NHQau1O2b75OEfiWGQAK9riEGyN1wO2vcsgHhgqHMq
         L8jcTmPFu/p4DzwHGVrNEkcAYShgVGxCCU19pQUPO4pstLkuEniBzcWAfXNLu3Hh0kE2
         HDkusjxOpf41u+75V7f4QremkjEGWe7o/0TBbJfOpJ7Nn22pCpSvdf5Z48gG8+Vuq1CB
         uJ6M0iUvJXilJSqEqUpfgW6IhuCKP+vinejp5LtQnZXj4nWYK4IWmD5W7BtXWGClIiga
         pE7w==
X-Forwarded-Encrypted: i=1; AFNElJ/wk91mOtJaOX0UW4WQMH5GZQzx24QZBasbyoteIP9o3Up0m0K7EQgoLo5KUjnUS9PIlsv4jzm9kKL17H8HSFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/y4zOuhgrj2wf5jI0ge69SN5cQGW/eo8uH4ppalCEUNVFr0O
	0jK55wlbnysn/5eWf9ZcMIgTueEeJIxdnCjR9/NHGFHnDUK8/zXCZslq
X-Gm-Gg: Acq92OFn5XHU67bsoaIcMWQZ264ai2eXeruQVPnnErXFgO68QiAVlZkxO07l4jKKvk8
	SXLlQRi/UTTEN4qcT3h+ptFHPbX5dtJ3pQAcQ0x+WA9OD6SxtQDcbiFfSm/GmBECGxJcf4jF32/
	sKwAq9+29R008IJ6uE7FlWZDEKibpIhUA+5aowx1WpuHT6qPCv8L+DytncFb4t+TCXwZu1YVWPP
	Ra3nHljJ/HIWuR7T19Pv/FwpfRR5D+lgC+kFAvt06UkCYgnKTsyXeJabUEeuqLg/4OxR6nx5hNA
	5N4SiLUHLTQoGW/eCBUm7GA3Fo9oHSNdDZCyXogL+Xp0sI/qEe2paNXR/gS1RENWFy0BURYZ7a6
	bOXH+5rcvR8ej1sENC31JTn5lmMyAkGWBGOPsemfXd2801Gi2f/c3Et2S+V7NHp6a9u2sghi6WV
	BWmWVnCyYXSl7foGwOsQcjOYeuhU9aBZg3ltJ2iyJ1sQ==
X-Received: by 2002:a17:907:9483:b0:bd2:bd43:b46c with SMTP id a640c23a62f3a-bd517979775mr242223566b.43.1778854235491;
        Fri, 15 May 2026 07:10:35 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([77.243.23.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831197bf00sm2115768a12.31.2026.05.15.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:10:34 -0700 (PDT)
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
Subject: [PATCH v3 0/2] riscv: lib: add optimized memcmp() and extend KUnit tests
Date: Fri, 15 May 2026 16:10:17 +0200
Message-ID: <20260515141019.1234037-1-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v3 series introduces an optimized RISC-V memcmp() implementation and
extends the KUnit string tests to cover functional correctness and
benchmarking of memcmp().

The memcmp() implementation incorporates review feedback from earlier
versions, improving alignment handling, loop structure, Zbb usage, and
overall correctness.

The KUnit updates add comprehensive memcmp() test coverage and a benchmark
mode, with v3 addressing structural cleanups and style issues raised during
review.

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

---
v3 changes:
    - Split memcmp benchmark into wrapper (string_bench_memcmp) and worker
      function (do_string_bench_memcmp).
    - Removed all C99 mixed declarations; moved all variable declarations
      to the top of each function.
    - Converted len, iterations and loop counters in the benchmark to u64
      to avoid implicit casts.
    - Cleaned up spacing, indentation and minor style issues.
    - Added #if defined(CONFIG_RISCV_ISA_ZBB)... in  memcmp.S
    - Link to v2:https://lore.kernel.org/all/20260514121359.931999-1-milant2002@gmail.com/
		
v2 changes:
    - Added alignment checks for buffers to avoid expensive misaligned loads.
    - Optimized the loop using end-pointers to reduce per-iteration overhead.
    - Implemented word-aligned tail handling using ZBB shifts.
    - Removed redundant pointer equality (a0 == a1) check.
    - Retained BE support via #ifndef; ZBB rev8 is used for the LE fast-path.
    - Fixed KUnit build failures for Clang and non-benchmark configs.
    - Link to v1:https://lore.kernel.org/all/20260512141007.1193033-1-milant2002@gmail.com/
Milan Tripkovic (2):
  riscv: lib: add memcmp() implementation
  lib/string_kunit: extend benchmarks and unit test to memcmp()

 arch/riscv/include/asm/string.h |   2 +
 arch/riscv/lib/Makefile         |   1 +
 arch/riscv/lib/memcmp.S         | 125 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 lib/tests/string_kunit.c        | 116 +++++++++++++++++++++++++++++
 5 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/memcmp.S

-- 
2.43.0

