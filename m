Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF076303A32
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304137; cv=none; b=Dqz+O8mz9INKErBUpzkwDocOnRr/ccvNKSjpQDsPr8J0uPNcOKFzt6/5keUG7VjV2Y+Dnm5iEHdaAhRVbwnUyH9W/XfyDx2+eIsBt85QAYNsP5uprQWSX60mOeFzpAGtDJ4qHi1wb3XMavB969o0OuMo3SscGcbfFN3zDCuFLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304137; c=relaxed/simple;
	bh=EsROKYCzD0ZQeyOrSN7MF6jezxidTzxhnRS9l8kLNJs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KhIoBhDevKnNyuacte+WB8jUKmU9oq6KMONpZBuYyATBW0jl4FNnawu/DPVw75kOjhOPR6xoBdKKpyKJcOV7Q9JpNJHIcpzdqYc6ENzNMYZtSFdL6bVpuCajIHoCkoa1/y3A3jrdhRDQd6B1oD9A7ZJKhy4bW2S0zSEYLc4BgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXMdbs4g; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXMdbs4g"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48a5c837c44so40634975e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304134; x=1777908934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YrjY8IxNTKfKtmD2Yq6xqpB77zy7Hr/7JUIGpo0JaOI=;
        b=ZXMdbs4gxeQZjPlfvQGKhLL0Q+JrXu/drY1A+SZ+NCuMD8znPMnnHKV0YqZI8T3x8B
         CZFE5Al6o58oTeFWV2lrFUaG+cD3dCh3O9gya0R8cEvhYlShetaFiTcNew+xGpt4Vpcq
         ZwtjTrrU1QhfEDJWSC9gnmbMQvD2dRtCW3e4SE5Zpb8q/e/0Vq/MZLwejCKZG/X1oDDB
         hy2z+yV3p58kUlCRg97Beq+ypvt1nRoXRWxpmL/9O2WH0TBC9WruP8MMphUbjMyo07bu
         gz44pU2ObZaSuB8yAGSEqGVd0uV/ueVbQWSFMCcicIz4RqrkzwLeTrMqY/fJCR2afMpJ
         tEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304134; x=1777908934;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrjY8IxNTKfKtmD2Yq6xqpB77zy7Hr/7JUIGpo0JaOI=;
        b=fxHgZpCIQCVU72wI7x9bDZ1H3Vuu+KKT1wkXaWSWy1iTD6N30SImlQ4lHPx00a9HiV
         THlOtuBAPkkv+89yp2dA7wW0LKQVsR3N+8C0pMA1sO9OG9BZ9Zj7sA8i5VPbfGiDHR6T
         cCj8/TVARMKXGy7SQHcCnnL7CP+u4cJU9ci95r+/nOiD3pUsjdNpEVtUJjPJp/gzIFpa
         soFc4mdg5IbaKxSuyqOvh2Jo1jmDOVG3Rb57ZIWkaqZFgr1wlv1w66nA3PGsJlPUrkml
         Clb/cbfbUVuAbaN030FeY3W9MSrlYMYH5FnzWyFSlAJ31zEAyaWpA2ndFztA9tIgobS6
         u1/g==
X-Forwarded-Encrypted: i=1; AFNElJ9ydHl+wMEaW0rcHvcBVLAHH+8gw9lWdQyfyqrWpf7cPfh2WPGXxRZInmu6uXDytvAlAEa7bc3mV4Oqt4M8Shg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9CCJRYugs3iC56mSHuzkhTCI/OOLsgUSCghx4K1uPp9P+c+Q
	uInSaFQlM7sPWxzlW7lluAbSGRUjyFtDX+w42yyXn5ZDJErNggVsUsu8UgDZt8CO7xLYM0dx/Q=
	=
X-Received: from wmbjx26.prod.google.com ([2002:a05:600c:579a:b0:485:34ec:2b75])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1da1:b0:488:d376:42cd
 with SMTP id 5b1f17b1804b1-488fb785901mr663577045e9.22.1777304134363; Mon, 27
 Apr 2026 08:35:34 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:17 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3717; i=ardb@kernel.org;
 h=from:subject; bh=LVM+Y6mOTsDAEGVgOMgatOUvHVY5AE8R0yMbkioDilo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9488nT45tn57o6vvE7q8ny9U5wpOCLGfNE187e/1Rp
 nVSOrNsO0pZGMS4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEir4yMvxY9lqk7ujm5tS7
 xyZaFgXbXOJ9Of3Dt6l/Uw/4vXS8MzuU4Z/xlCfNa575zJdKs4u0OnaxjvUIEy/3O1G52/Y+7/z ZU9kB
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-17-ardb+git@google.com>
Subject: [PATCH v4 00/15] arm64: Unmap linear alias of kernel data/bss
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

One of the reasons the lack of randomization of the linear map on arm64
is considered problematic is the fact that bootloaders adhering to the
original arm64 boot protocol (i.e., a substantial fraction of all
Android phones) may place the kernel at the base of DRAM, and therefore
at the base of the non-randomized linear map. This puts a writable alias
of the kernel's data and bss regions at a predictable location, removing
the need for an attacker to guess where KASLR mapped the kernel.

Let's unmap this linear, writable alias entirely, so that knowing the
location of the linear alias does not give write access to the kernel's
data and bss regions.

Changes since v3:
- Drop bogus patch adding hierarchical PXN to the fixmap mapping, which
  breaks the KPTI trampoline (thanks to Sashiko)
- Add generic patch to move the empty_zero_page to __ro_after_init, as
  it now lives in generic code.
- Add patches to remap the linear aliases of the fixmap page tables
  read-only too - these live at an a priori known offset in the linear
  map if physical KASLR was omitted, and control a priori known
  addresses in the virtual kernel space.
- Rebase onto v7.1-rc1

Changes since v2:
- Keep bm_pte[] in the region that is remapped r/o or unmapped, as it is
  only manipulated via its kernel alias
- Drop check that prohibits any manipulation of descriptors with the
  CONT bit set
- Add Ryan's ack to a couple of patches
- Rebase onto v7.0-rc4

Changes since v1:
- Put zero page patch at the start of the series
- Tweak __map_memblock() API to respect existing table and contiguous
  mappings, so that the logic to map the kernel alias can be simplified
- Stop abusing the MEMBLOCK_NOMAP flag to initially omit the kernel
  linear alias from the linear map
- Some additional cleanup patches
- Use proper API [set_memory_valid()] to (un)map the linear alias of
  data/bss.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Liz Prucka <lizprucka@google.com>
Cc: Seth Jenkins <sethjenkins@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-hardening@vger.kernel.org

Ard Biesheuvel (15):
  arm64: mm: Map the linear alias of text/rodata as tagged
  mm: Make empty_zero_page __ro_after_init
  arm64: mm: Preserve existing table mappings when mapping DRAM
  arm64: mm: Preserve non-contiguous descriptors when mapping DRAM
  arm64: mm: Remove bogus stop condition from map_mem() loop
  arm64: mm: Drop redundant pgd_t* argument from map_mem()
  arm64: mm: Permit contiguous descriptors to be rewritten
  arm64: kfence: Avoid NOMAP tricks when mapping the early pool
  arm64: mm: Permit contiguous attribute for preliminary mappings
  arm64: Move fixmap page tables to end of kernel image
  arm64: mm: Don't abuse memblock NOMAP to check for overlaps
  arm64: mm: Map the kernel data/bss read-only in the linear map
  arm64: mm: Unmap kernel data/bss entirely from the linear map
  arm64: mm: Generalize manipulation code of read-only descriptors
  arm64: mm: Remap linear aliases of the fixmap page tables read-only

 arch/arm64/include/asm/pgtable.h  |  33 ++--
 arch/arm64/include/asm/sections.h |   1 +
 arch/arm64/kernel/vmlinux.lds.S   |  14 +-
 arch/arm64/mm/fixmap.c            |   8 +-
 arch/arm64/mm/mmu.c               | 167 +++++++++++---------
 mm/mm_init.c                      |   2 +-
 6 files changed, 130 insertions(+), 95 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

