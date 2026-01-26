Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A2314A97
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419656; cv=none; b=S3cROVUGTFPue5vvVlMC9CiYSGuNwp2MFSeSDg2iLqQy1CCHgzImAjuZb4sHk1iCkdF2uj61Ns2Quw9wDJcCh81I/W+9tUXueGeTdm+oE8CvtSefRdul6jYzfSbWJj64pyRFAUaezpUBHGIBpPGZkITu5glW7j1McrE0LTdVVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419656; c=relaxed/simple;
	bh=yBnnkaxLVqMpw5r5t06s3FHeKjELSQxQfMxXYdwHi9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rjLtmufV2Up5N8r7/q9QgED/00MQUZA396+d9fXNHveVSGlgwXpaENZ9uYGioZkOFm4GZ6uBMCmJ1o2ybfc3q+eN9wY0ze3wAMMJayLpOhaEW0fuHdzp3CeatIYZacoWYtEZxppz1zVxS5hnBR0bUbCp09vp10VDZvd4MSTclHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NrtlqS5X; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrtlqS5X"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee7346f8bso31148185e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419651; x=1770024451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3gi4BPC4AMeAfrncqfJZ6M8Gr4YN2FYW/OAnF93oRW0=;
        b=NrtlqS5XPNKC5vfYIqWeG0SbGCBFIT0b3I69p4K4kjRMkJo/DcijrEu0qVOKocOoAa
         pwmbT5VVwiF2zef0osdLzyNA+kWiOmR5cxth1cD0Wm4efYDHFT5WRLTk+PGyQ4HrwKq5
         pVNSay1unjcxm8jTG0f1GIoXvvpLDDsEt/hr4VWmDivwM3206i1mtW2nYaln/dECYt8L
         my2cJRhQgwZTrkAbYq3We4lY4Lvl8EO8TAFODQ9cIP2a4hHnD1T6AmN+561gkATwxU6K
         x9EJLW+yrRKW1I20pjB2xayTaNi0VGaXbaFLEiaJkgpSwYV6+doqr0Jm57vZYgjU6b3+
         ooTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419651; x=1770024451;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gi4BPC4AMeAfrncqfJZ6M8Gr4YN2FYW/OAnF93oRW0=;
        b=BXiZIW4jZT7y84yim9zR9oY3iHu6eFEOMleHw60A0zF853ZBP8uG14F01IJQbqUy5n
         ykKpwIQqodWbEx0XmkkBEm1Ny7jZrFQ4hSbpqfxmbxTC8VtO1UW376Rax1z3uXJwrWH6
         ig/HVrgSmHSJa0U87Y/28f0gTqEoendp37r0p/ADhoKrhEkoaGcEsghrFcWmwaU7/UqI
         +rwhC5Si7jx5klOx/E/ic/VHPyFSNv9db8/KvaF6Kb7II0Dt+8ppISrTnfGIljg54KMd
         PTDFbG3TCW50GhcDwWqcVhsuWlPCqDcvm5EFQDNTAmq2r3+JC0iIPEwSM2iXDWk5Ny7y
         yqyw==
X-Forwarded-Encrypted: i=1; AJvYcCVOBQIccCB3x0t2KhMsyZMQltm8JyuQ8E66Me9i+blby03A2cqJH+XGxtwvPIE2q6cDPpFnk0HiHQas2WSoxBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwmR9uZZTEmUCSKeWeBerBffPjDCibwdsyYLVF1CSBUDMMlGB
	uOPwovfAQbW32PO7DxdFeLOG8Zhc14Ezj+LiG2D0oFLbyEe1Yg51aEbTbFr3frg92K7PYD0iMg=
	=
X-Received: from wmoz10.prod.google.com ([2002:a05:600c:78a:b0:480:1b84:b6e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1547:b0:47a:8088:439c
 with SMTP id 5b1f17b1804b1-4805d065d80mr73660365e9.35.1769419651572; Mon, 26
 Jan 2026 01:27:31 -0800 (PST)
Date: Mon, 26 Jan 2026 10:26:31 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317; i=ardb@kernel.org;
 h=from:subject; bh=Ap4lsZMuDyOofvFMFnMiKyoC8iLDVYVQLkvGkqS0gAs=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIbPc2L1g8uuyjPcXXdKLDtvWNxdXvd3cX/T5e9hlHXnGp
 cnx0i4dpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIz1zMyXN71+kra89XKJlwn
 dySpiXpz9G/71b8wq1aAdWLh/i9SDIwMM4N9XS/+NZ+w98KVaLHGO3ssbt78cfLZhCOHXrya8u/ 2HyYA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126092630.1800589-12-ardb+git@google.com>
Subject: [PATCH v2 00/10] arm64: Unmap linear alias of kernel data/bss
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

Ard Biesheuvel (10):
  arm64: Move the zero page to rodata
  arm64: Move fixmap page tables to end of kernel image
  arm64: mm: Permit contiguous descriptors to be rewritten
  arm64: mm: Preserve existing table mappings when mapping DRAM
  arm64: mm: Preserve non-contiguous descriptors when mapping DRAM
  arm64: mm: Remove bogus stop condition from map_mem() loop
  arm64: mm: Drop redundant pgd_t* argument from map_mem()
  arm64: mm: Don't abuse memblock NOMAP to check for overlaps
  arm64: mm: Map the kernel data/bss read-only in the linear map
  arm64: mm: Unmap kernel data/bss entirely from the linear map

 arch/arm64/include/asm/pgtable.h  |   4 +
 arch/arm64/include/asm/sections.h |   1 +
 arch/arm64/kernel/vmlinux.lds.S   |   6 ++
 arch/arm64/mm/fixmap.c            |   7 +-
 arch/arm64/mm/mmu.c               | 111 +++++++++++++-------
 5 files changed, 87 insertions(+), 42 deletions(-)


base-commit: f8261772d6a032f18aacd4d1a18bca5bd4e4a368
-- 
2.52.0.457.g6b5491de43-goog

