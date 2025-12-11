Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8727510B
	for <linux-hardening@vger.kernel.org>; Thu, 11 Dec 2025 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765426204; cv=none; b=E/tP+I1ItsQnX6CIduK7NUNWsCVOl8gq3OME3VjMXHsV1ihxQ2jI+Wx1gU23I6s3t3mPJ4XwBe8iVK9jwSE3ctpTf8xncsBrgn/F70r+kV28vrxmTKulFRrhaJjG+Wx/D3HPs+8MbQqqhEUqnkNa9k277BzPUkbe1RGEc6r1lO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765426204; c=relaxed/simple;
	bh=oxGZLAoYraEnTaqd4KcbBYAZ3MpFudos0PelzD7Ngyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFrKpS3t7TlWHkRowB6bdhoTWk2a2y11eHcC5C7LOwq0YCls+S1jCl6sCTykl1adwqsHb5X7kG3MTJ0Yrs9guzrjDD3Tjff6P9RupRZpNRgrU5avox8qcct+o5Zb/1fdCW9otFKhlRFasPOWqBXaPNnsKIT6glKozsa6rjibpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8I+GWKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8I+GWKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FB7C4CEFB;
	Thu, 11 Dec 2025 04:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765426203;
	bh=oxGZLAoYraEnTaqd4KcbBYAZ3MpFudos0PelzD7Ngyg=;
	h=From:To:Cc:Subject:Date:From;
	b=N8I+GWKbRrm4CHAdNG6zcb9eUvUBiSY9fEsUbqbHAUcD9cR2jVM4aO9UFOK957kVe
	 5WtBLOx8lsq2kj2bZJvFkPPmDaMxKDch++Skzh4+hCqGJJHBGSbMMQqGgr0mUaTNHr
	 4SLXGCgVYCh8aWpIcBEBCuYOpLLsvgO9xUhZCHtRBqjgVjiSURVaoxPbvi8smIilCX
	 Ec4Ue8IRmrrApbyQRZuJg7IkOegeYF9FO9cQXOHhHkwxK1zlSU+JiU8ApOznHBgYQ8
	 34lRFpKnWHfVcuuzNYOAAIctkE5dcwpVI60KlwXywUn+v2Vv3TJhHS2eiRCBuzrDex
	 du3jjMNx3dgtQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-hardening@vger.kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	kees@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>
Subject: [RFC PATCH] arm64: Bring back linear map randomization using PArange override
Date: Thu, 11 Dec 2025 05:09:36 +0100
Message-ID: <20251211040935.1288349-2-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5568; i=ardb@kernel.org; h=from:subject; bh=oxGZLAoYraEnTaqd4KcbBYAZ3MpFudos0PelzD7Ngyg=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JIdPKhSlUtKtiadtSpqCtBzk/+3E+ups/a9bjue1z6l/OP 7796LukjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRokqGf+Y3T/3IYdsYdyD7 ZN0an+Jyl6ZPO/Q3Pj/w1fervvWSsr8M/0MjuqLsznk8u3H28IZ1zXERj9eG8W2VOnBH3PfbjxU RzzkA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Commit

  1db780bafa4ce ("arm64/mm: Remove randomization of the linear map")

removed linear map randomization from the arm64 port, on the basis that
a prior change to the logic rendered it non-functional on the majority
of relevant CPU implementations.

As has been reported numerous times now, the upshot of this is that the
virtual addresses of statically allocated kernel data structures are
highly predictable if the kernel is loaded at a known physical address.
Any bootloader that still adheres to the original arm64 boot protocol,
which stipulated that the kernel should be loaded at the lowest
available physical address, is affected by this.

So bring back the most recent version of linear map randomization, which
is based on the CPU's physical address range, but this time, allow this
PA range to be overridden on the kernel command line.

E.g., by passing

  id_aa64mmfr0.parange=1 # 36 bits
  id_aa64mmfr0.parange=2 # 40 bits

the CPU's supported physical range can be reduced to the point where
linear map randomization becomes feasible again. It also means that
nothing else is permitted to appear in that physical window, i.e.,
hotplug memory but also non-memory peripherals, or stage-2 mappings on
behalf of KVM guests.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Cc: Liz Prucka <lizprucka@google.com>
Cc: Seth Jenkins <sethjenkins@google.com>

This is posted as an RFC because there are obvious shortcomings to this
approach. However, before I spend more time on this, I'd like to gauge
if there is any consensus that bringing this back is a good idea.

 arch/arm64/include/asm/cpufeature.h   | 13 +++++++++++++
 arch/arm64/kernel/image-vars.h        |  1 +
 arch/arm64/kernel/kaslr.c             |  2 ++
 arch/arm64/kernel/pi/idreg-override.c |  1 +
 arch/arm64/kernel/pi/kaslr_early.c    |  4 ++++
 arch/arm64/mm/init.c                  | 16 ++++++++++++++++
 6 files changed, 37 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 4de51f8d92cb..fdb1331c406d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -1078,6 +1078,19 @@ static inline bool cpu_has_lpa2(void)
 #endif
 }
 
+static inline u64 cpu_get_phys_range(void)
+{
+	u64 mmfr0 = read_sysreg(id_aa64mmfr0_el1);
+
+	mmfr0 &= ~id_aa64mmfr0_override.mask;
+	mmfr0 |= id_aa64mmfr0_override.val;
+
+	int parange = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_EL1_PARANGE_SHIFT);
+
+	return BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
+}
+
 #endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 85bc629270bd..263543ad6155 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -58,6 +58,7 @@ PI_EXPORT_SYM(id_aa64zfr0_override);
 PI_EXPORT_SYM(arm64_sw_feature_override);
 PI_EXPORT_SYM(arm64_use_ng_mappings);
 PI_EXPORT_SYM(_ctype);
+PI_EXPORT_SYM(memstart_offset_seed);
 
 PI_EXPORT_SYM(swapper_pg_dir);
 
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index c9503ed45a6c..1da3e25f9d9e 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -10,6 +10,8 @@
 #include <asm/cpufeature.h>
 #include <asm/memory.h>
 
+u16 __initdata memstart_offset_seed;
+
 bool __ro_after_init __kaslr_is_enabled = false;
 
 void __init kaslr_init(void)
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index bc57b290e5e7..a8351ba70300 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -43,6 +43,7 @@ static const struct ftr_set_desc mmfr0 __prel64_initconst = {
 	.override	= &id_aa64mmfr0_override,
 	.fields		= {
 		FIELD("ecv", ID_AA64MMFR0_EL1_ECV_SHIFT, NULL),
+		FIELD("parange", ID_AA64MMFR0_EL1_PARANGE_SHIFT, NULL),
 		{}
 	},
 };
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index e0e018046a46..0257b43819db 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -18,6 +18,8 @@
 
 #include "pi.h"
 
+extern u16 memstart_offset_seed;
+
 static u64 __init get_kaslr_seed(void *fdt, int node)
 {
 	static char const seed_str[] __initconst = "kaslr-seed";
@@ -51,6 +53,8 @@ u64 __init kaslr_early_init(void *fdt, int chosen)
 			return 0;
 	}
 
+	memstart_offset_seed = seed & U16_MAX;
+
 	/*
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 524d34a0e921..6c55eca6ccad 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -275,6 +275,22 @@ void __init arm64_memblock_init(void)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		extern u16 memstart_offset_seed;
+		s64 range = linear_region_size - cpu_get_phys_range();
+
+		/*
+		 * If the size of the linear region exceeds, by a sufficient
+		 * margin, the size of the region that the physical memory can
+		 * span, randomize the linear region as well.
+		 */
+		if (memstart_offset_seed > 0 && range >= (s64)ARM64_MEMSTART_ALIGN) {
+			range /= ARM64_MEMSTART_ALIGN;
+			memstart_addr -= ARM64_MEMSTART_ALIGN *
+					 ((range * memstart_offset_seed) >> 16);
+		}
+	}
+
 	/*
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
-- 
2.47.3

