Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2693E173D
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292571; cv=none; b=l9Ry9XdoDnb1zHOihg0QxOOvnwHvJwK6YD8YEGnO9lU2ToI2p3ALsp19j+aHm24QWn851i4+moyFtxVEHwho7F0s/ffYVM//4Wm7FS+pSjh4MG/8pPrmffwBrJbN7TK3QWNzKTsoxg3aFK7+0QyODwBDQeBV4rG2wjYPyD896RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292571; c=relaxed/simple;
	bh=5Ym8/QltKDsf0fTf7eoFv+eDys5Obz62sVInt1MWNhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XK8fXw/+v5LDmM5mWZsjKkz3ywJsY8lNeJtK9NlHHyTDYq7Zdt8m7fWmO7KF9tmVVTMh9UklmJXDYeuGn3ifqsYF8xlT3p371IfewAzBsDu0+mVPxM21XsQsndRSZFNLGFKMBqTbIlnCaYpv8hp02ahfwCEaD6HXC7EntKD3l1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCf6Vgxm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCf6Vgxm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b0786beso35230265e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292568; x=1779897368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HX7UJhkeQ1tHA49U1WBUw3k6TwCuDc8sNoAYzxEJmV0=;
        b=GCf6VgxmcPefQbt3hRQuz3Aqz+znkPTohklkNFSuBOxcXhIUsaiNAOJcEkXa86WmCt
         qQxG9Q+DPHL1lJapomsRuTspviHCN98qzJkSf24KTJZnUI59cBMRyaNcdqni4dzQw49W
         8hfWA6w+uzF9ybBbX4QZZdZfYEGnhzQj9m+NzTcKBoOc0F4vwBGzQPHkCEYoUngAonpP
         fZSpj6xtYKQ5bKhltB1z2NUw2AjN67U/JCAg5ANucKMykMbyD876GCpJ/Cbi1+XkZSRK
         N6eIPb4f1OpsyLqZVYqheoqCfL88UF0dzzbo9ytpEqADw61gmy+0E8iGXB1Nlfk/4mHr
         w43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292568; x=1779897368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX7UJhkeQ1tHA49U1WBUw3k6TwCuDc8sNoAYzxEJmV0=;
        b=ch3mWGW06XCTE4d+9tWMDxV9ROY1//iPRd2eFd0d6Pvco20qG5Kb8MsDhbhwDSxHkY
         RbKKlEy6Qpg941V5MtorazH+ohkLZzIz6kclnyUQ6ZTZRgA1CivdurVykgAKWNMIxsln
         J3r1nn1a25fgHm1D+Sa62T1WpFcLnN4bHvjl95inh3k51358yTCHsWta8Vm2kxy8jo1L
         LZ7LUEsmchp7DnwLNO1lePM9BUHdXzrG4eJZl2uBgDX1tOYwFBirIwqlyAflVRaNbqDY
         dDq1F+tLPe9ZhT9YW0LTV9WQ5wtFQim5xS3QrKH/mRa1ujmCSq+s+vOxvmJ/8sTGrClv
         2+QQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nkjQNW4D0UFwbsq5gxI4YA11ZqM7NuO6+68sQ8mFLK7x/mtmSzJPm+wO7CavJdXRg2Qk2oA0b5BLHzK7KVKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbIAGcGjM71Yu4+UqhiDphX/SLhIeNxo26m7Dgadp7FK+uTJi
	7vfy4K+I/hN0lQb4tEUk1oOJOetu8QZ1a+qXHs8ZGOWQo/QAmTfxELmz
X-Gm-Gg: Acq92OFyt7xHC+6rwCRVXb8j6Fqy7qO66SPQET8DwUWKEysCpXnCKnt2OjBiAl7RdBM
	ftUFtusmq2w4qrmA7ugECVGCOvAnrgb5WpflfkB6aM601UFLVh6ej3VPnjWFF44X2fWuwCY2eB6
	3FOwXhE5aGuNBd68whR/SPSDnsP51VeUGvW1vtnfQQMbtRi0ahptNp6QJXuOxSEm7XGuZ631trM
	batfWxehvYGTj6gUv3g1oz+T308Aoi19EBr2VrL1bXTy6eBCWFt1T9nH081y2wtdvOztbqQ9V6P
	xTIce8N0SQaaG6wUqCXG6X6GFHH5u82vzvmReo6oz1ncCtivUU9EmY850EHB6rRV6MdchQapz/Q
	FYAijCNf1/bKPm8882tbNqiid9qyXOO9q4D+0TBtPsM6+wMqesmRI81gR9mebGAkdqRVXvqjbKc
	AEvk1IxetMTbDRWhbzNGhe4CpAP4Q3ZO1GKTwqfFmgTjFo7ryouXGa
X-Received: by 2002:a05:600d:10:b0:48f:e230:2a21 with SMTP id 5b1f17b1804b1-48fe662fd6bmr313080955e9.32.1779292567661;
        Wed, 20 May 2026 08:56:07 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([89.216.37.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab290e1sm215565025e9.2.2026.05.20.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:56:06 -0700 (PDT)
From: Milan Tripkovic <milant2002@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Kees Cook <kees@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Andy Shevchenko <andy@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>,
	Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: [PATCH 0/2] riscv: lib: add optimized memchr() and extend KUnit tests
Date: Wed, 20 May 2026 17:55:29 +0200
Message-ID: <20260520155532.1139471-1-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

Add an optimized assembly implementation of memchr() for RISC-V.
The implementation uses word-aligned loads and Zbb optimizations where
available, with a fallback for non-Zbb hardware.

The series also includes KUnit tests for functional verification 
and performance benchmarking.

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

Milan Tripkovic (2):
  riscv: lib: add memchr() implementation
  lib/string_kunit: extend benchmarks and unit test to memchr()

 arch/riscv/include/asm/string.h |   3 +-
 arch/riscv/lib/Makefile         |   1 +
 arch/riscv/lib/memchr.S         | 126 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 lib/tests/string_kunit.c        |  53 ++++++++++++++
 5 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/lib/memchr.S

-- 
2.43.0

