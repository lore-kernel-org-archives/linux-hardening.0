Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72D37A4B7
	for <linux-hardening@vger.kernel.org>; Wed,  5 Aug 2026 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926449; cv=none; b=Ov7rQUDCX5BccRM4qUIj1w7v4OLxNjHnZdTK70JFk+X4Q8AwJRBm9poTAlhsDb+sf0vwnLp2tdYswZokzJxgxmRe1YDX7aEhj33F6AgbpSSbckJdJpOoOQKXUMJBK2YxzXE5SmHX9sah8TdlnAeMxYCqQQhOzUJxac9IsNjgxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926449; c=relaxed/simple;
	bh=Rmbdm/R9T+nVHns9xmbwhhzc7T2IKGzFyN/cTZjjqhY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VP4Q4fDgR2xJ5vn5SUYFoGSv2H3SDIQUxox3NFHw9YnSJox8mC5N/qRtejef532O9V0olEHXPevg8H0f+riktQcCO11MrtF7u+P9ovfjTO/I+GbsmvGBJkxKHF5Z25uKbshKtqkg1QtfRzl2GFDfoiqoM6LbEGoxhVTF5P1ND3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QtruUX8F; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtruUX8F"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a0de3383c0so971376a12.2
        for <linux-hardening@vger.kernel.org>; Wed, 05 Aug 2026 03:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785926446; x=1786531246; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKn6cZqAriR/zZlCyouZ9X4PnMk81SsImmt/7OIBzd8=;
        b=QtruUX8FDiEyJvgj01i/ZPe7Oo3Zrr8hQ5sp+XqnMqXAZd8085gD2ZY7aFw+Co4G/d
         PmoKYkYbrg2jwUSGoaAB18xMBThBZQA1zY96iiqwtBDNuUyQZWuaw61iEavShA2Rmrd8
         3X0ELc36HTjFAVl7sY5tL+MpBmWqz3sYeSgsfGomXDoKX/Ty5doPIR/pSUaKrc9GAtw0
         2BIuVtw3BVnmwkBJFotfS5/l+ijGUnQUVRQrvIWULTs0sW8ftJjUCElt+oaPp/cdY4hS
         h/6yoBpm9+O8QKoC3j0BN9Fa+URvxacGfLKwmvohNK/m4WCEB+VgtZteSH7N3yLD1vyE
         w04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785926446; x=1786531246;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKn6cZqAriR/zZlCyouZ9X4PnMk81SsImmt/7OIBzd8=;
        b=b5WHllxyUPJZyWrHMTyghP5W1bpnZ8Rmze91nZH+eRzFAw/pBmX88dlU4WqVysi9t4
         RvQDQ5I0gDbSdnq5LjTG/ZD6QCrmIdhmd2eEFAg4Fk7z/O2EVFEPhmusRNlAED4DAI0B
         NBvO4hTBYZcI2AY9LDQ6m/Yeh39uYynumIXhwvsj3nnVnNbtZkjlSFr4VNkwl81QTJwM
         3Pd8Zc10QqRMLfrxyMGdS5uh/TDjVzDKybb1viZJmuxjsvBtjvlWnbAk7S0/BmtA0Rt7
         Rr0Wzc6hw+aDWbsTZvH0oTeWJQgNNnL6C/L8F/npwLvoXVixmNd6s210Nhr8T4De5T05
         NnFA==
X-Forwarded-Encrypted: i=1; AHgh+RpIHO3C3Ql+1bwonQEl8QFXBC/xzTgqxYUJWzzM7BQodOhjZpJJJVosdfAKvUkJNKspAXZerhMlAQBpNSPRoEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ZPuqf/5q3oqSL0ntq9OoP0oskkpRoNzraU4Vo9NJE6k7ZVDF
	y9Y4rvZV/75jifHsxLHG96zdrg7MrBSVgYSC0W3SoeJs/xpBqH7csFYU1F4nP3nrwsKWo1vZqA=
	=
X-Received: from edoy16.prod.google.com ([2002:aa7:c250:0:b0:6a0:d084:32ec])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:52d5:b0:697:564c:9095
 with SMTP id 4fb4d7f45d1cf-6a14f256695mr3050404a12.21.1785926445667; Wed, 05
 Aug 2026 03:40:45 -0700 (PDT)
Date: Wed,  5 Aug 2026 12:40:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3419; i=ardb@kernel.org;
 h=from:subject; bh=aQqHgsHDXATSChltB95ehBTGy6vjImAwBYlhcut/HS4=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatYWJtd8KFR3xa3Gw4H5wYk210KejdP31k9cLmRRe2+X
 WaPPqZ0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlkrWb4Zyqzs+ZoQfJZlqwT
 bKpeLC5sLw5yd9zhXuLPcF3jZED8N0aGu3LPI79XZhRMPlpWavJC9XOB4I/csrgyyUMTV9768uU fFwA=
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260805104042.1107678-2-ardb+git@google.com>
Subject: [RFC PATCH] arm64: mm: Map fixmap PTE tables r/o in the linear map
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Without physical KASLR, the fixmap page tables will appear at an a
priori known offset in the physical address space, and due to the lack
of randomization, the linear map carries a writeable alias of the fixmap
PTE pages, which appears at an offset in the kernel VA space that is
also predictable.

Given that the placement of the fixmap area is never randomized either,
a single store to this linear alias region is sufficient to map any
physical page with any permissions at a known offset in the kernel VA
space, including on top of the PTI trampoline.

Avoid this, by remapping the fixmap PTE pages read-only in the linear
map. This is possible because all updates to bm_pte[] occur via the
mapping of the kernel image in the vmap area. A read-only mapping is
still needed for things like ptdump that walk the page tables.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liz Prucka <lizprucka@google.com>
Cc: Seth Jenkins <sethjenkins@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/set_memory.h |  2 ++
 arch/arm64/mm/fixmap.c              |  7 +++++++
 arch/arm64/mm/pageattr.c            | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 90f61b17275e..a685fb534c3e 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -11,6 +11,8 @@ bool can_set_direct_map(void);
 
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
+int set_direct_map_ro(unsigned long addr, int numpages);
+
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index f66a0016dd02..fcb571dffe82 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -14,6 +14,7 @@
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 
 /* ensure that the fixmap region does not grow down into the PCI I/O region */
@@ -173,3 +174,9 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 
 	return dt_virt;
 }
+
+static int __init fixmap_remap_ro(void)
+{
+	return set_direct_map_ro((unsigned long)lm_alias(&bm_pte), NR_BM_PTE_TABLES);
+}
+late_initcall(fixmap_remap_ro);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index bbe98ac9ad8c..5072b14d4f9d 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -251,6 +251,16 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_PRESENT_VALID_KERNEL));
 }
 
+int set_direct_map_ro(unsigned long addr, int numpages)
+{
+	if (!can_set_direct_map())
+		return 0;
+
+	return __change_memory_common(addr, PAGE_SIZE * numpages,
+				      __pgprot(PTE_RDONLY),
+				      __pgprot(PTE_WRITE));
+}
+
 int set_direct_map_invalid_noflush(struct page *page)
 {
 	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
-- 
2.55.0.571.g244d577d93-goog

