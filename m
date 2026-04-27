Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0E3D890C
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304152; cv=none; b=LUjJKGx9ttwyVAqAoTsZqJ2/C6E1K7r9KWXiUebyQw3Cs36zEpT+wdnUJNNNCA1GHhMWYjc3dUFUUIyOLlX/qKbfElx1SDTNFuDY3Y8dL0W0eTW55GsxSZtpupvdhbMyfbZe1256SibRb/c62dAEaGI3JI5AOaLH7ThNG2JVmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304152; c=relaxed/simple;
	bh=O/Gz5Nv/ULAYPtMULzEkMfXxCcd0WOOKaB94QYkzs4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b+uez19N9gq3jXfyZyffhq6pmYix6W+hDpodTJsKy04bSociGerzcclLRQaS3RrYek84f1hQpTnZ44YwfJCzSHCIn82dFodvqEmZeC4Rz2J/AN9OY3Ff2IZpH9Y0OSK0m4qnsGamyg65iBfFIcdQ/2ygflvwl4vOWdehbI5VXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3KQTKFv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3KQTKFv"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488e097a270so70597315e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777304149; x=1777908949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHBfAOq62ddYo5eYH63kmRGKW2W5oXHrS23q0wSzvjk=;
        b=i3KQTKFve1kA8loUu+2Nm7QkZkI1w4XF99eaYcQo9JClsupShmwTtAjYSJw8tpnzQk
         ZDgRBCBtzGIcKS+tOXnjaYIYf02d0hi9T1kC9n4s2jYIjsDQUzQKG8LRz8Elg6Y0CYHV
         rwfZeLKwx3G3uHdDcKWgxBhNXBpFwflUMv/FS1rm3aLk/88Maxv90T4mBlEgIiLPy5/t
         EusDYULznB0csoVTNNzu463yidxmHO/lu3nz4U9vqJaOe6H1g9BbVW6hjeS3d1VXiisM
         dLYe7uVpGrpTu/77mPogEcAg3DqPZKvKhsW1iVjpUunNIMLkieQOGeXIJnvCeGXVVFNF
         Grpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304149; x=1777908949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHBfAOq62ddYo5eYH63kmRGKW2W5oXHrS23q0wSzvjk=;
        b=L0uLUFTQLIhZmUxBnn/+nSfXJ6ObrEGbqQJ5kKdoC4l8pNoMKjppInxUTCJhUEmwQ2
         CoYsFnDbSrC1/qeveRcO7sVumoDp1IX0BWAgVrW8LmHrdfGH1mkPU2PeQdxvLcO8e0mR
         RNWqhrtZ/sLA+GNKBSll5W2cWrBKfrJ0ojRvvO7MApZ+AeaUya4uh4ehiTBoJxRqipo2
         pdPkJ9XSJ0AF7uqezkRU09d77Jgx1xRiAHicTyjzZzZjmM0CWEE0JA7LkFC//v5J9Gqc
         xcDWaZaYU/ZOpgQYc0U8lCZUE89s/SoXSZ4zRkvnztpzuSLpoPgshYSfMRtu6IkYMeqa
         Ahsg==
X-Forwarded-Encrypted: i=1; AFNElJ/o9IaI2c/4zzko1MeLnvqLsxDa7Ux3kLGTb8tMjDGgL5Nb+568ZGQofWLuC3E8lMGafYbD0TcvUReGBdFftYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29cw8CJbDP8c8F617t11Y95pxcghITzWTVSxcn2+8fAeD+6tZ
	m5fh3GTkIHvR2zinGBzuhkoDZmEf8vx94TEswo+HVicyd2hFAMuu0QBcklw8T7XLqhaOT0NIuQ=
	=
X-Received: from wmim14.prod.google.com ([2002:a7b:cb8e:0:b0:485:4f4a:bd84])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:628c:b0:48a:52d4:888c
 with SMTP id 5b1f17b1804b1-48a52d48985mr436500725e9.3.1777304148352; Mon, 27
 Apr 2026 08:35:48 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:34:30 +0200
In-Reply-To: <20260427153416.2103979-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=ardb@kernel.org;
 h=from:subject; bh=wQjR+F+1V7sUzLN4TnEphIKngbWEIlFdlV4UM9366h0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIfN9E8/zzp9rzJvuTrrssME56tgdeZGiCxu1/hnmHFEw2
 Kx3/PTcjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARdX2Gf7qTeGeyv/WQ3m+5
 YJN2SVKJmjhP0Cq12slhs9JOff29JYeR4fLhIoXXDu2TA92k7l89733+pdS0gHk/wh3rGVYs+M3 wjgkA
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427153416.2103979-30-ardb+git@google.com>
Subject: [PATCH v4 13/15] arm64: mm: Unmap kernel data/bss entirely from the
 linear map
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

The linear aliases of the kernel text and rodata are mapped read-only in
the linear map as well. Given that the contents of these regions are
mostly identical to the version in the loadable image, mapping them
read-only and leaving their contents visible is a reasonable hardening
measure.

Data and bss, however, are now also mapped read-only but the contents of
these regions are more likely to contain data that we'd rather not leak.
So let's unmap these entirely in the linear map when the kernel is
running normally.

When going into hibernation or waking up from it, these regions need to
be mapped, so map the region initially, and toggle the valid bit so
map/unmap the region as needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 44 ++++++++++++++++----
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9361b7efb848..a464f3d2d2df 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/suspend.h>
 #include <linux/kfence.h>
 #include <linux/pkeys.h>
 #include <linux/mm_inline.h>
@@ -1040,6 +1041,31 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
 				 end - start, prot, early_pgtable_alloc, flags);
 }
 
+static void remap_linear_data_alias(bool unmap)
+{
+	set_memory_valid((unsigned long)lm_alias(__init_end),
+			 (unsigned long)(__fixmap_pgdir_start - __init_end) / PAGE_SIZE,
+			 !unmap);
+}
+
+static int arm64_hibernate_pm_notify(struct notifier_block *nb,
+				     unsigned long mode, void *unused)
+{
+	switch (mode) {
+	default:
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		remap_linear_data_alias(true);
+		break;
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		remap_linear_data_alias(false);
+		break;
+	}
+	return 0;
+}
+
 void __init mark_linear_text_alias_ro(void)
 {
 	/*
@@ -1048,6 +1074,16 @@ void __init mark_linear_text_alias_ro(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
 			    (unsigned long)__init_begin - (unsigned long)_text,
 			    pgprot_tagged(PAGE_KERNEL_RO));
+
+	remap_linear_data_alias(true);
+
+	if (IS_ENABLED(CONFIG_HIBERNATION)) {
+		static struct notifier_block nb = {
+			.notifier_call = arm64_hibernate_pm_notify
+		};
+
+		register_pm_notifier(&nb);
+	}
 }
 
 #ifdef CONFIG_KFENCE
@@ -1162,7 +1198,7 @@ static void __init map_mem(void)
 
 	/* Map the kernel data/bss so it can be remapped later */
 	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
-		       flags);
+		       flags | NO_BLOCK_MAPPINGS);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1174,12 +1210,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/* Map the kernel data/bss read-only in the linear map */
-	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL_RO),
-		       flags);
-	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
-			       (unsigned long)lm_alias(__fixmap_pgdir_start));
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

