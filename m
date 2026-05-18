Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9430EF77
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110085; cv=none; b=VK3+vhg2bqA9WH8VMdBQpmaSnIpDzSpdHLyx96W0ErayIR4LlCo+tZeL0uZ3DDFsiJJxUYgLEfYIzgMhRCtvEdEhytKk1D5wKyw/jf/gY9l1jJduFrp8t540WDZp9tQP6XypDw/c/65iuPWRAB6QB439biIzYzsMYh5tPg5U9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110085; c=relaxed/simple;
	bh=Z14QFUUikHODQ3aoLQOJClldtUmxt3XO+7A+JlcVNO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=didqBUyIS2XfG7yajHM4G1VRRBpbST37T+XEDh+bm5xM2L68d2+8llfJyqBnqmFerZU/DDHHCriJOASsvM5isXZ3Ke2PJENG7jfXfDXhdPyw+EBH72vg3kuzt2vviTryZhrKlB0uPDHrMBWwjuELXLU7wf9PLegoHYPcgV7Xe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJdeiVr4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJdeiVr4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso17150885e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110082; x=1779714882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2W8Kh26zpmPW+LCobCj4WL6hHrjmrN7QEdZmG2gns4=;
        b=qJdeiVr4spigxuI8weSe7dZyMnfA6yu/VSFSN8dog2o2Hmd6nMqnTV5fegqq3n8SXI
         2KpYOAn/8f4ObO92UMoKHziEWE8OuUlulYwC8L9a+4lyXKPiwDxLqRsihPJqPeTbFk4u
         lizr+GlAQNLUONznvS/PM6ADK/IsQ3GOyaCfiSdn4f9D+u/bDhH4MCjfZ6Rhvy9iRY6R
         YGL3FEFPUOurCEOkUk2wjuEq9JpHfhevmzFQc2h6fLcVnOR//PJmeennieg4JrDIyirF
         yEiwjP092tAPPXtldjD6gkI6UB7PEw04b4ltwP9DjaaBTPhh2JmDRfHVLQgYQBc4fo9a
         NJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110082; x=1779714882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2W8Kh26zpmPW+LCobCj4WL6hHrjmrN7QEdZmG2gns4=;
        b=QMCu+xKib/ae0viu8VsQDiZe//72jvc+04qA6ulVkJufOKOvctPEtQX27bcVE2WI1K
         GToPx866HyKYU096IuQeNWJvnTci0XCdDHo7qZ2nV1cAFEzgbIe4nT+rvvdSCFi7oGsH
         2a+EUONvs1t/tjJ+oEW3sbB9UWm8SMeaL70er5/nqEeUvgcc46ruv9wdtpe46l9Qwt1A
         V9uqwd/qimaMn7A3Xc/ZVCqwlo7WJZZtMXYYVM4v/8mnXlJKWWdAK+j2k2lWmUceDXiI
         jkMHO1TJBwRwfgzBEfrvW4rCY4EmQNxoPpsmGps6/c/3JXawu9aKYiFFW5Ze9SlkyOUo
         JLOw==
X-Forwarded-Encrypted: i=1; AFNElJ/8Mtj2UvdmO+V5qRDu5U+6UH7fa7O+bf3AHrBbwCafiW62qzyVR5J9RZn/QzSloMKIWrcNPfonLf8P637nGRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bcwLqxrVlkr0U1qnOkCpWMj9OhG4g+OnkKWYpFb75K5CJm+E
	+L6+WnaIgpXIbyUQl4NEKB6EHlFC9QEmHWmUNLWnE2+yIcz+Y9O+F92X
X-Gm-Gg: Acq92OGS/fV1DG1fB0oRNpSPIDbxOAgGpGeVrpYr2suWE4BgbBpmRka+AcOwtyZFvwC
	/M7Pqs1SNPMDM2CUYeHk/ViGnYlWL5Qy+vxobgavu3AP4/eNo49WT2hTM0X0VxsE/cPjV1r6MTg
	72gfII5dxJthOd7AyAqprpeXDZ++FLCS1iVAwH5IB2jBdmH9cz4qWMk3HkjOYxE2Z0orfsTqOmL
	CyO0ewT36FJP8I3wdRQJqX25fbdfwEX4z72ow5R3oJ9nMgffd21AObInfZQFdNAq+iLVoPVOHnt
	NRqR2zi4Xm7BY1vbTNTbLbT8uwhW3gkgUTwys6ROJJ+Bt+J8V6xopk5zysDXNkbWUBnViCPvidC
	Nc1YleUtT7ivYOLEbgEHygsMeAzW3qQcG2H8r5hqAZ880ogjg59klO7rB5FbiCGEc8cIIruWzK7
	/INLNenieNJQGVqYVno/judkZUl45S51VR6R0586jx
X-Received: by 2002:a05:600c:4f8a:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48fe62f8c6bmr230536955e9.24.1779110082062;
        Mon, 18 May 2026 06:14:42 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([95.86.49.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm249619265e9.9.2026.05.18.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:14:41 -0700 (PDT)
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
	Milan Tripkovic <milant2002@gmail.com>,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH v4 0/2] riscv: lib: add optimized memcmp() and extend KUnit tests
Date: Mon, 18 May 2026 15:14:05 +0200
Message-ID: <20260518131407.1026049-1-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v4 series introduces an optimized RISC-V memcmp() implementation 
and extends the KUnit string tests to cover both functional correctness 
and benchmarking of memcmp().

The memcmp() implementation incorporates review feedback from earlier 
versions. It features improved alignment handling, optimized loop 
structures, efficient use of the Zbb extension, and ensures overall 
correctness.

The KUnit updates provide comprehensive memcmp() test coverage and a 
benchmark mode. This v4 specifically fixes a build error regarding an 
undeclared function call (STRING_BENCH).

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

---
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
 arch/riscv/lib/memcmp.S         | 125 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 lib/tests/string_kunit.c        | 120 ++++++++++++++++++++++++++++++
 5 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/memcmp.S

-- 
2.43.0

