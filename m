Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55801478E25
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062383; cv=none; b=EKZvdSF73ifBjIskPdqgB1m9niXGE/SZyhQ9vTjUlywfgm9Ag/A4WCO3QUgRTmT0WyaVgIrWL2fXoE784+ECYbaE82hGckSPKu2Zszx01ZisItBoWEEJDOwPeqyFTq/z3/j4uUQR61q7Ir8HTlampLHgN3K/Lqoko2F7o1mrK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062383; c=relaxed/simple;
	bh=AZS/qmiDqyYyalyFT0fayk+2twxYIjtBapS2JESmNTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4UeoDjebS7wIu9LQxIvRsDvpR+3ZZLowcS1rtHlKaYasQslBpZGtxQSa5PhCyTA+oSRQgREMQmAcLXa8mXOmv7mRyiAzEQEY11Qi39ozhHCADqmnAhTBfbqyVD8qmzr5kusfZGwm0FlEEy+5y/vaca+Uw6LdPCvCIUtBsUAGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QSP94uag; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QSP94uag"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1BA21A00;
	Tue, 18 Aug 2026 07:12:57 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A4713F85F;
	Tue, 18 Aug 2026 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787062381; bh=AZS/qmiDqyYyalyFT0fayk+2twxYIjtBapS2JESmNTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QSP94uagRM5mQtJgReaoriW9rQvliNR8r1ZJ3oUzK9bkEZG4Z2oBnlR/jesx7nv5T
	 MUMNK3OmCMxrCDwSkWTs2eDllBWxK3og8BUlB2tk/ztR1f0mAPE226vlBjT7P7HhkV
	 WwaLpJHbyP1blczS0t4p8k3xA1/9LIOlOosZNJD4=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 18 Aug 2026 15:09:02 +0100
Subject: [PATCH RFC v9 20/25] arm64: mm: Map kernel image alias of
 init_pg_dir read-only
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-kpkeys-v9-20-743ad31b2c8f@arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
In-Reply-To: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787062277; l=2968;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=AZS/qmiDqyYyalyFT0fayk+2twxYIjtBapS2JESmNTM=;
 b=zQo9evzSCEFr+xMZNuLdCY5hB7IzXLtzsT8DJWfg/QX4opN7VmkgL4CBcD8e6MJGjTCMykKIX
 PFdhqBrClYHDLLlqyMzlAXnMlgbwf7Qmjvvju+E6ewXcqE+Hcd1yys7
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Updates to page tables in init_pg_dir are expected to be done via
the linear map only. We are about to protect the linear mapping of
init_pg_dir using kpkeys; map its kernel image alias read-only to
ensure that the kpkeys protection cannot be bypassed.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/sections.h | 1 +
 arch/arm64/kernel/pi/map_kernel.c | 9 +++++++--
 arch/arm64/mm/mmu.c               | 8 ++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 51b0d594239e..dc961cf67168 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
 extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
+extern char __pi_init_pg_dir[], __pi_init_pg_end[];
 
 static inline size_t entry_tramp_text_size(void)
 {
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index fb44cbdd2f29..81ca3e98f0f7 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -92,8 +92,13 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 		    __inittext_end, prot, false, root_level);
 	map_segment(init_pg_dir, &pgdp, va_offset, __initdata_begin,
 		    __initdata_end, data_prot, false, root_level);
-	map_segment(init_pg_dir, &pgdp, va_offset, _data, _end, data_prot,
-		    true, root_level);
+	map_segment(init_pg_dir, &pgdp, va_offset, _data, init_pg_dir,
+		    data_prot, true, root_level);
+	/* Map init_pg_dir separately as we will remap it read-only later on */
+	map_segment(init_pg_dir, &pgdp, va_offset, init_pg_dir, init_pg_end,
+		    data_prot, true, root_level);
+	map_segment(init_pg_dir, &pgdp, va_offset, init_pg_end, _end,
+		    data_prot, true, root_level);
 	dsb(ishst);
 
 	idmap_cpu_replace_ttbr1((phys_addr_t)init_pg_dir);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a10e9f9876d0..ee972c78e45c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1217,6 +1217,14 @@ void mark_rodata_ro(void)
 	update_mapping_prot(__pa_symbol(_text), (unsigned long)_text,
 			    (unsigned long)_stext - (unsigned long)_text,
 			    PAGE_KERNEL_RO);
+	/*
+	 * Map the kernel image mapping of init_pg_dir read-only; it should
+	 * only be written via the linear map.
+	 */
+	section_size = (unsigned long)__pi_init_pg_end - (unsigned long)__pi_init_pg_dir;
+	update_mapping_prot(__pa_symbol(__pi_init_pg_dir),
+			    (unsigned long)__pi_init_pg_dir,
+			    section_size, PAGE_KERNEL_RO);
 
 	/* Map the kernel data/bss read-only in the linear map */
 	update_mapping_prot(__pa_symbol(__init_end),

-- 
2.51.2

