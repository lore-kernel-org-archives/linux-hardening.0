Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0F3DA5A5
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280806; cv=none; b=keNhKDYzIKWCbWXciKkMtrImvjCj+yM9gD6qN4b95Te4pLymgrAXRIplLe/KRbsVuUWqOTABIFqkYbExgKUBv2ifKPl3n6ACECUzGMOBdlDgZ+nUZeSExaBhn71lu4w4Ylsg+uInLC9l1EBciWTIETnWrbHsk7/n3wqzP6IaAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280806; c=relaxed/simple;
	bh=j5Dhu/C427Mc96rLjuNTCKrByvq16NPlOapdfKSW+wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfFt9x1OaRR6yT7xs6gFd4bnBLsPfwGluAIuKOreG523QSmSY7ESzhUJfDJDZ/4KidknHf6mD6L7njXYCtU212Y437k+F+OyrgsBxg5u/5IS+MXjel6qDUyB6cNZjhquzw00lqFrxq8haz5W2gsj+179akZ/2KONGtT9WQhXPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9BRWlOK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9BRWlOK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso36035245e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779280803; x=1779885603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuH6Fo8n73X094Nx+BXIM9AYUCXKRRgGdAspq57tSsc=;
        b=Q9BRWlOKCkueTp/KKpAP5EVIQlrJtUpDmlpX/AGIsrhV+wyAlRhpvCTn0Oqakb3GHP
         KMylu5mqW8dAcJ3VQ4LnthaCbzUOa0DKDFAmkllnDCnVhosBKJ1EVnQsSnrsrdDpIqQ8
         XYbYKWtRZ6bz/DWtOZhc/t/DALeidl4wn7HRKdmd9LG3efVqQa8snuiv5hsaDlZe4Dro
         UlctsM9J0qFaJWrD9PyjtMJenwvuw/KWZMeedGlQwBmccuUMXT/R3I+ZqlMsVYMBcJuu
         hZ8wJ9b2BCoIzJ+90f01jUXhRBhYIUyiam1Ui1pKtqwwALkuF+JHHYNeD8MEmNQC6oxT
         +TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280803; x=1779885603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuH6Fo8n73X094Nx+BXIM9AYUCXKRRgGdAspq57tSsc=;
        b=WZJCAS1C82B1C6/RCPGpiznKRelFd/NRmbCP0BFuueeQmtS+Vqzaxtp6VE+oMHQUDc
         k4kDQQW61m12tHRTidFRGwNyo8gEx1CsWrqUhL0s5tWsMD1d/T2o4SHUefq9VBq0tCqu
         wlEArGmYXJN8OBBEjMhC5EGSJAJh3OyW0n2S/iR2vydHx5St0YlVB5wMNKG2gM9m9+cL
         dEW0Z9DzQmNqhBlXRR1/SfBoaWlOBnNtahAcyK1NJWtoGE7jBm0hhFz85/7joUZmkg3a
         JqOon9s/K5r9DrjuEZbphUqWWmc6moo+e8lBzNBButyxu/q+4RwCvQ54ycTesa0yc+j/
         q4Yw==
X-Forwarded-Encrypted: i=1; AFNElJ9IXoiTLclH6BG/3THL4EIWGX0js/59U9J3SwKzG7pES6bDu+BiLCk59ygBBQ50Lji5jTy4WWV/9b68e4V590s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzreVttJb1USgz1YbQaH9pmsyo061FZ+CArOfQP9XvlLc/qen7o
	pzIPmcEWX4ncwu1QxXopjzzMT2Bv5DSdpSt5vF3dmavWVIisUaYWp3Xm
X-Gm-Gg: Acq92OGzK7B8/lM4WuHfMLDGpECNnuIoWCQy2NxynHM4fWGlrsn8IWlflOdI06mzNDH
	YtwxvTEFoRjCvN0fjAUUEkCBiru60ezkHjJKhG08I0SP0P1Ab2N+KZuV3RbRumWxWtAoylfx/DY
	FoPwDXeY+3nxHuCr4ajV2ELsbroqk6VApUkt4wCnr8jiH85I4ktuI2sMhaiLWKtYgPWXjiTJ96Q
	79QEKDDBO8RapAS1FdSrIkx+VYCl7CICdnamWcxxnORwC59goD6ETbAg3+oKZVNPO2adhfTeKVN
	C862CTz06o8SNtbPtSuNpxNb/xR+KZ0d788TE6DZOyRztfk/mlnl9LAHW2NEQ+dTQWAyrFFfz8s
	nPFIBre3dQaWl31NQsqL+adPrTgva0TlgsO2LJdYl4bi5hrZqZNE7iUb7RZLsMXFTENGND026sB
	9jPWzXpYJ55sNbocm0nGCN6LMGMDlrJo4kEkjv4PCjPQ==
X-Received: by 2002:a05:600c:1d0d:b0:48f:da34:ec4e with SMTP id 5b1f17b1804b1-48fe632343dmr344264205e9.19.1779280803275;
        Wed, 20 May 2026 05:40:03 -0700 (PDT)
Received: from RTRKW671-LIN.domain.local ([89.216.37.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm54460252f8f.12.2026.05.20.05.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:40:02 -0700 (PDT)
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
Subject: [PATCH v6 0/2] riscv: lib: add optimized memcmp() and extend KUnit tests
Date: Wed, 20 May 2026 14:39:52 +0200
Message-ID: <20260520123954.379630-1-milant2002@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v6 series provides an optimized RISC-V memcmp() implementation 
along with extended KUnit tests for functional verification and 
benchmarking

The memcmp() implementation now uses word-aligned loads for the generic 
path and leverages Zbb for fast sign resolution on supported hardware. 
A robust fallback to byte-by-byte comparison is implemented for non-Zbb 
systems to ensure correctness and stability across different toolchains 
and hardware revisions.

Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

---
v6 changes:
    - Fixed build errors kernel test robot noticed. 
    - Link to v5: https://lore.kernel.org/all/20260519140029.1190381-1-milant2002@gmail.com/
    
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
 arch/riscv/lib/memcmp.S         | 107 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |   5 +-
 lib/tests/string_kunit.c        | 106 +++++++++++++++++++++++++++++++
 5 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/memcmp.S

-- 
2.43.0

