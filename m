Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39C3803D6
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018803; cv=none; b=MMlQmaF54h6vdjLkS3cz546Hg1xX8pFwzuHueB4gPaHh/2F5L793KcCaFSNEedKjyVFfgXmksXNBettggw1bBG28jycAik3Y8pbjTCDINKL5QoZBRi5mpCyDafbv8mrJS6h9sgvnpRJ8VrTrac+vGpgA5w1D0eYJ3uezwhK2C70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018803; c=relaxed/simple;
	bh=GlF9REALPH8Thgc2BqeIb8XMITT2gtWDfWbp3wAEW7k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VEqSXgogKY3V/QHlRg12mbCaUPVT7vwFAzljwMKLe0aLgu4D/SQcoqUW7lDyi31FJRpIWZk2dKEwlgZjBNaS4xfxyolIoQkVPDCOF7dH4/ZNCyYILiX6WG//7RkU1pWpIIQbF9FOZNCoX0KTl5oaY+tu8krKz8edOFm83ajw5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XablGZRN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XablGZRN"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-486fa9ea1ebso4995225e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774018798; x=1774623598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MdVeokZjbztoTDx0L1beL77+M+R2awklYBvUejvaGn0=;
        b=XablGZRN22ujDRK8AOeGickbHh0Ajfgo0CVNxfQIUHBKgPjH3x3+dqB63zfbrJm7kV
         3FRkK6s/QibOvuPNIJPhD5jQ3C5TolAJDHjDvNLieTkM5jbf0QSCAQKqH51TLV8WmRPp
         VkJDdDD8yUAlJSZhI03T0Sr3M5dyUpujKjiaOwTJYXI/+8j/XHhs+ZKeB617LaDJjZHb
         QMUDNUfZXEMvDc/MtxBxbitguOts6kklIlOMiFqjmdCAE3/JMN8ffExsn21Mbu2/52CG
         XxdVF6V/qme2djJ8U/0O6sLVFbT0I5qawDG62wL8jn4IDmGhr6eyXBmbyn5aP6KXyZfk
         Bz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018798; x=1774623598;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdVeokZjbztoTDx0L1beL77+M+R2awklYBvUejvaGn0=;
        b=HM7i2156RvLNhJOJeMK0fr3WNsRpUzoyQ5r5oxvaTxGumiyI+2pfdnwu4ge+6yuk/Z
         RGCILv1S0fQX80Bq6CcCdNh7w1oRVsaLaGVB2INXOV7rEYJCe5xeGjU6trxkuBDfqDAZ
         YtAZOLZNoerriILCdfGpaKclnPTsKGhYj5PzA6eeAQOUHn2uVxtdP2bJSLpOs/c0w5fe
         BZJvfGtTGPQh+rdNCfZXYf9L24u0KbybOQZMdbDAVa2TXxhG4VqA+kZ9qrnaiIdnFwcm
         ZHsB7wVSNr6RTREUJNpA4VBTb1EptGXW3KyGz75M2Om7FiAwo64bw0ZXBf6cWcC+rxTp
         bbwg==
X-Forwarded-Encrypted: i=1; AJvYcCXDFpg6IaB+IMn+MgmaTu8GA40twQ0HYIlObgZlRzbpHsFAAB+BfrbaP+mL7u+3uEpzUVDq7rPe3UnMzMKvV14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSw3cZpqEZt4Ur3CSLylmIw/WzYhJkA4Nc1/Ts0cF7eIlCX3AO
	/RB7pwEF5buoQ3q6y7Efy3qi7Fw3FTJhv5YXg4xI6RuQdj5Of6neb5sdFKs4IDSDqNRB2BYJkg=
	=
X-Received: from wmdd6.prod.google.com ([2002:a05:600c:a206:b0:485:3f38:3dd2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c16e:b0:485:9a50:3370
 with SMTP id 5b1f17b1804b1-486fedb9497mr47266945e9.8.1774018797760; Fri, 20
 Mar 2026 07:59:57 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2793; i=ardb@kernel.org;
 h=from:subject; bh=Kl2s1+jB9ADBOpcUfcC5kqKIeNKk1TvIXb5NWMCOWDY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIXNvwvVCm4W7k+S+9jxJDjINjj92aRLDxz2bDl3M7b2wp
 s9KPyGoo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzE5AjDP53LXxQmHHy20vSM
 lOnRvwbnXbXOGrF9D47dVOH2/+g/Ph1Ghk2fVeM2bYvJrH70s8vMJO5+75m5nzYEPL4y4+RbeZF dx3kA
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320145934.2349881-15-ardb+git@google.com>
Subject: [PATCH v3 00/13] arm64: Unmap linear alias of kernel data/bss
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

One of the reasons the lack of randomization of the linear map on arm64
is considered problematic is the fact that bootloaders adhering to the
original arm64 boot protocol may place the kernel at the base of DRAM,
and therefore at the base of the non-randomized linear map. This puts a
writable alias of the kernel's data and bss regions at a predictable
location, removing the need for an attacker to guess where KASLR mapped
the kernel.

Let's unmap this linear, writable alias entirely, so that knowing the
location of the linear alias does not give write access to the kernel's
data and bss regions.

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
Cc: linux-hardening@vger.kernel.org

Ard Biesheuvel (13):
  arm64: Move the zero page to rodata
  arm64: mm: Preserve existing table mappings when mapping DRAM
  arm64: mm: Preserve non-contiguous descriptors when mapping DRAM
  arm64: mm: Remove bogus stop condition from map_mem() loop
  arm64: mm: Drop redundant pgd_t* argument from map_mem()
  arm64: mm: Permit contiguous descriptors to be rewritten
  arm64: mm: Use hierarchical XN mapping for the fixmap
  arm64: kfence: Avoid NOMAP tricks when mapping the early pool
  arm64: mm: Permit contiguous attribute for preliminary mappings
  arm64: Move fixmap page tables to end of kernel image
  arm64: mm: Don't abuse memblock NOMAP to check for overlaps
  arm64: mm: Map the kernel data/bss read-only in the linear map
  arm64: mm: Unmap kernel data/bss entirely from the linear map

 arch/arm64/include/asm/pgtable.h  |   4 +
 arch/arm64/include/asm/sections.h |   1 +
 arch/arm64/kernel/vmlinux.lds.S   |   6 +
 arch/arm64/mm/fixmap.c            |   8 +-
 arch/arm64/mm/mmu.c               | 138 +++++++++++---------
 5 files changed, 90 insertions(+), 67 deletions(-)


base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0.959.g497ff81fa9-goog

