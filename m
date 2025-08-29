Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2112309B9;
	Fri, 29 Aug 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494449; cv=none; b=pf72O/GO85TtQ6KTcVopSpbZNLvc8HgYczywbIRjuDSkmlQK7UFbt4UBvmI0VLUgLERDshZt+KHwv6dhwYJNFAfnP+7XNSwBRubaMB2u1A/+4eAONnS6AiLjK/ulx/Jlej0dNTTwCd4Fb0RZSsSK869MGsYQPQPrpZGTeKugtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494449; c=relaxed/simple;
	bh=KhB9CZF6CwYnj2naomZZKO+E1e7v9OT05X6wGQRcFd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFO0zY5xoxi3mkhmrHJKq9xoWalRonqJ67B9QuQpXspcpOR6ePXi/jEtcxd0Ue0RtF9qkjigqf26Ewf8zlrPcFcJ6FiCCv83Ne5iCOBCXLvgEIaanqfNbAhNFWWmp/zgOKWwlwGsQYJR06/h2BNka2snW1gRD50a+4Gy3KyHwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvYzxJmg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvYzxJmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E864DC4CEF0;
	Fri, 29 Aug 2025 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756494449;
	bh=KhB9CZF6CwYnj2naomZZKO+E1e7v9OT05X6wGQRcFd0=;
	h=From:To:Cc:Subject:Date:From;
	b=lvYzxJmg+ard/fG5EsTMrf2xI7NBgIW3FlZDL6Njre+TqBc0AoWwn1hq5vnG0tb6u
	 v93dP4zFqrP9v41KlT41RW3qS54lbsJxSzZljt3DL3QZotf4kErIPvCENSBDT7rCce
	 C9daVpBYm+Z+CgKZysysOZPqzuspv/rXBrz6xhMh5JDfuPkK4u+FnUy9AQ1U4NShj9
	 2jtDHE5H45OrVlvHtFYkhwfH24pUkvTc5FjQOb3FjegcOgW522clqKk670Lxmc5Evc
	 EFXvSSvw7SLaN0qzS/VK49Jt8fDpBKWr+tvhV059esuzkMNqImPdwwPHplfvPMNk3p
	 /yoRkdlTrXSUA==
From: Kees Cook <kees@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Yue Haibing <yuehaibing@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Joey Gouly <joey.gouly@arm.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	James Morse <james.morse@arm.com>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	David Hildenbrand <david@redhat.com>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Dev Jain <dev.jain@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc function signature
Date: Fri, 29 Aug 2025 12:07:25 -0700
Message-Id: <20250829190721.it.373-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4745; i=kees@kernel.org; h=from:subject:message-id; bh=KhB9CZF6CwYnj2naomZZKO+E1e7v9OT05X6wGQRcFd0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkbf+X25rEmrrxy7tBxJu6bD0ybft1fnbf1WeeyS8wpD 5jMfcWqOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACYitoORYeHPQzun1WqtEzvy qyioXy5DbZLSbHu/M3/fmv5cuTz/jQXDX+HtxyR2pk2UX1+Td7rdfcH0iIZ3zy2apGMWfbunZrv KmB0A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Seen during KPTI initialization:

  CFI failure at create_kpti_ng_temp_pgd+0x124/0xce8 (target: kpti_ng_pgd_alloc+0x0/0x14; expected type: 0xd61b88b6)

The call site is alloc_init_pud() at arch/arm64/mm/mmu.c:

  pud_phys = pgtable_alloc(TABLE_PUD);

alloc_init_pud() has the prototype:

  static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
                             phys_addr_t phys, pgprot_t prot,
                             phys_addr_t (*pgtable_alloc)(enum pgtable_type),
                             int flags)

where the pgtable_alloc() prototype is declared.

The target (kpti_ng_pgd_alloc) is used in arch/arm64/kernel/cpufeature.c:

  create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc), KPTI_NG_TEMP_VA,
                          PAGE_SIZE, PAGE_KERNEL, kpti_ng_pgd_alloc, 0);

which is an alias for __create_pgd_mapping_locked() with prototype:

  extern __alias(__create_pgd_mapping_locked)
  void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
                               unsigned long virt,
                               phys_addr_t size, pgprot_t prot,
                               phys_addr_t (*pgtable_alloc)(enum pgtable_type),
                               int flags);

__create_pgd_mapping_locked() passes the function pointer down:

  __create_pgd_mapping_locked() -> alloc_init_p4d() -> alloc_init_pud()

But the target function (kpti_ng_pgd_alloc) has the wrong signature:

  static phys_addr_t __init kpti_ng_pgd_alloc(int shift);

The "int" should be "enum pgtable_type".

To make "enum pgtable_type" available to cpufeature.c, move
enum pgtable_type definition from arch/arm64/mm/mmu.c to
arch/arm64/include/asm/mmu.h.

Adjust kpti_ng_pgd_alloc to use "enum pgtable_type" instead of "int".
The function behavior remains identical (parameter is unused).

Fixes: c64f46ee1377 ("arm64: mm: use enum to identify pgtable level instead of *_SHIFT")
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: Fixed the Fixes line. ;)
 v1: https://lore.kernel.org/lkml/20250829154913.work.943-kees@kernel.org/
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Yue Haibing <yuehaibing@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 arch/arm64/include/asm/mmu.h   | 7 +++++++
 arch/arm64/kernel/cpufeature.c | 5 +++--
 arch/arm64/mm/mmu.c            | 7 -------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 6e8aa8e72601..49f1a810df16 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -17,6 +17,13 @@
 #include <linux/refcount.h>
 #include <asm/cpufeature.h>
 
+enum pgtable_type {
+	TABLE_PTE,
+	TABLE_PMD,
+	TABLE_PUD,
+	TABLE_P4D,
+};
+
 typedef struct {
 	atomic64_t	id;
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9ad065f15f1d..e49d142a281f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -84,6 +84,7 @@
 #include <asm/hwcap.h>
 #include <asm/insn.h>
 #include <asm/kvm_host.h>
+#include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/mte.h>
 #include <asm/hypervisor.h>
@@ -1945,11 +1946,11 @@ static bool has_pmuv3(const struct arm64_cpu_capabilities *entry, int scope)
 extern
 void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 			     phys_addr_t size, pgprot_t prot,
-			     phys_addr_t (*pgtable_alloc)(int), int flags);
+			     phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags);
 
 static phys_addr_t __initdata kpti_ng_temp_alloc;
 
-static phys_addr_t __init kpti_ng_pgd_alloc(int shift)
+static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
 {
 	kpti_ng_temp_alloc -= PAGE_SIZE;
 	return kpti_ng_temp_alloc;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34e5d78af076..183801520740 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -47,13 +47,6 @@
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
-enum pgtable_type {
-	TABLE_PTE,
-	TABLE_PMD,
-	TABLE_PUD,
-	TABLE_P4D,
-};
-
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
-- 
2.34.1

