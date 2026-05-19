Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A29403EBE
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203901; cv=none; b=fqSIwOZhmMJ5FLMzmB2LQD7YrlGzlM7/gcR9Xgv+dckejSxmnz4wAjnJXzsR1KZ3f4H0qdnlWJG78CjnYGmaETBb7O/6k8voJl7v4Am9CtveiGl+rFcy/LiEbIsdjluOBs7mKTQjE9jf2m9uWK0AEHpS/qlvGNKRjpqyI0lb2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203901; c=relaxed/simple;
	bh=ZP+l+Sz6yAxcuTIEtZp9E588aid3LTA5av0nZy2xuOY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=elVcVb33Rb9ZbydXpynCpkNJj7vCkWUlN7hwUN1jxE46j6A9AvSl8nb6zolcEfJDpMQ+ou8Yhqb3xo5w3ao2vB4Q+jndgRChBS5VM2ThHkRTRaImJz4VjF3kHXTnzEE5uN+0lQ/rEFXkWM6ALkYVXsqZv5+7f3zszgU9wGSGPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=glMcyU/R; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glMcyU/R"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4900f69197fso11029735e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779203895; x=1779808695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Ph0PYjrVkzoxIOEpCFOVz5Nww7QyWvmwqNXMq1WP4E=;
        b=glMcyU/RoQIdMSDXVBQRNbKyOUKrxrHGIu43NzL/y/yydv8RtDg6Dq6CJVhYknHSoJ
         nLeR31QhqhvWccphmHRuRZ5RE4gyNJuXSnpu5ppwRLBY3pHluLK7ANWMhwspDrW5Pi3+
         zJufLDZIlunmzPIsQ+ybJXKUezMJzcITcN1xxaMUr9Flp+okE25HuLPXjbUNc6j7nxte
         H5V9FfWWdXNULUPVMhlHHI1Kx9UdVshHQMC7ZtEow4eAkF/UkAuuNpLDCy5spsH94Vp5
         +V6lkyVKAb9hgtnOia4iw65IY72LMF5pSiLDeU9v4T1nXJy84NKjSN3MSZBcLvdtJQbH
         iqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203895; x=1779808695;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Ph0PYjrVkzoxIOEpCFOVz5Nww7QyWvmwqNXMq1WP4E=;
        b=LrSlMF8KsvhiSSmvqGusVXAPOzh/ccPGgIYpELEbLjBjsnXX0jEILwqR+/SFCaKgUw
         ckWkSzUiP/UNz1XjwMzQb6Z4N1zKjOOivIl60LPJp6n4JlWdiqcD9sRu8UO0ZfigtSur
         +2TbeX7hh3bVDj8BA+u8wL2RQGMYMy0d5XjjC7bYaZVh6/lgHbvtNsmfsfyOQhJFDogD
         1BlAaDcNoU6SX1VeUyc1qKXziHQkWCOK2bwqLv91FiBueDL9hP6+tU4f1d19WP7lTPOH
         vW80BfERuIoFTDQHEr11Tn2yfGjozVWVgFef6vNc7vkcGhFSKU4tLVyzt28Sc2vg/EH4
         C5SQ==
X-Forwarded-Encrypted: i=1; AFNElJ9s5jXNwNln4TaAlJGRi23JoZqz/UacOGKwCyhJZZ7OVrokTGDJ65w2mHr4SP1/iF/MexZYzGPaFFcGvi0utNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5vdv30EtLj1cOOf8QbMYG8STLFUWGTX94lmbqFcfSk4Q/G76
	qw8fIboJ6VCHlp3d0qMx6+55RUZvDhnGA4jxlPI1D/xLzcX4WDQopp1kXvGTsD2EM/hU09A9aw=
	=
X-Received: from wmpj8.prod.google.com ([2002:a05:600c:4888:b0:48e:914f:1eff])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:630a:b0:48f:e249:4094
 with SMTP id 5b1f17b1804b1-48fe632663emr372340605e9.18.1779203895433; Tue, 19
 May 2026 08:18:15 -0700 (PDT)
Date: Tue, 19 May 2026 17:16:17 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3950; i=ardb@kernel.org;
 h=from:subject; bh=BfiC0GgeYqFLHZMi63jQd6ueIObiG50ZwO7JVw9lq90=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIYun7uCD1LW29zmS5p9gmMnBPcXya+T7hzd9amtaVA8LL
 ppw2OBBRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIsjwjw5o1DHveb37Ccv1C
 /yufS+tkgkKu5x00Wi/Jqyy4yP04lyIjw3M52VN8QnNmTgnRYP7z+ucK531LSjtfPF1akOSyrz9 xHQcA
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519151616.2557018-15-ardb+git@google.com>
Subject: [PATCH v5 00/13] arm64: Unmap linear alias of kernel data/bss
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
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

Changes since v4:
- Update the correct [early] mapping in patch #1
- Make empty_zero_page[] const instead of __ro_after_init
- Drop patches that remap the fixmap page tables r/o for now
- Don't force page mappings for the data/bss linear alias, as it is no
  longer needed for set_memory_valid()
- Add acks

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
Cc; Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liz Prucka <lizprucka@google.com>
Cc: Seth Jenkins <sethjenkins@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: linux-mm@kvack.org
Cc: linux-hardening@vger.kernel.org

Ard Biesheuvel (13):
  arm64: mm: Map the linear alias of text/rodata as tagged
  mm: Make empty_zero_page[] const
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

 arch/arm64/include/asm/pgtable.h |   4 +
 arch/arm64/kernel/vmlinux.lds.S  |  10 +-
 arch/arm64/mm/fixmap.c           |   7 +-
 arch/arm64/mm/mmu.c              | 134 +++++++++++---------
 include/linux/pgtable.h          |   2 +-
 mm/mm_init.c                     |   2 +-
 6 files changed, 90 insertions(+), 69 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.563.g4f69b47b94-goog

