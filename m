Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240135;
	b=cRc+yfw3/nwESMtu1xRDZ8GFX+9p0OiTq1tsvMbJK/2oSu3rHd3s25WlyJnkkJyn9j3I
	 Kgy/v/QU4qCqgeiqdYWFtoSTlfeh8TwWzMehT8nSVDmdvO4Ssw7tBdq2W8so2Mu7lKLow
	 cZ955uH6ASj28sGG0StgpNNRuVG3UTigwSu9spEkS1E7FIsfSnBrMSPxnq/W9YIbPOqxh
	 ye/owVZONGI2yUbHLOMwx+40jIBVQIcNiOO54afoN2biRqObHq5YxAsOvP3A1dwhUJkDk
	 kNoMWLCFpssh2/wbTy5YiZSHudNF/qmcj9mgXgtZ7ezsuV2zIt+ewPF2a3VKB6MCpCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240135;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=GTGmKFM4xFszxJT3yvxzfIEd2u2ou6U+2cFfGcbONdk=;
	b=c+5FHMiGNWz7Rn1PW6J+uF42DuKaYZ+GZJufVOO3xA+RWKYaQJ13K4uqsRtRZhwmJ3vr
	 EGGZ5qUXYJ7cFKmlMB0WFt2ZpWirXuYVJ37nB7qukaMRdiCf0DaCU4bPcw0QyQnuM5QoF
	 8ly2pl5FGTSmRnowb9ZGCsnO12dlPTD4Pew3wMgobuSYtxxv49A7VMBViUdnuHm3nWmt8
	 TWWk0lDxut24mTi0JUJEIJrQAERJQAxb/zRpnJy/Z6MxAyr6Oj8YqOD+OLbiLSqo09QZS
	 Zn0TcYhJB5TXmIE3wnY08hPucrnIj0GbjoNs8k7ot5H9E6mWer8IQvdDPWFaJSOkpvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GVdukjlx;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3160A2612;
	Mon,  9 Nov 2026 16:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D3160A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GVdukjlx
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF5DC2F;
	Mon,  9 Nov 2026 08:02:10 -0800 (PST)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E30A3F632;
	Mon,  9 Nov 2026 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794240133; bh=xf4mnCbgRoC4McQQdkoE98wQ+JFumNK4YzHFaYloEOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GVdukjlxt6BJwkZ8GSCwyaHoZsS5MHrj9UxdrQv4DpZ0VhH9HMytRJs38rarGnK4j
	 OBxKYeC/zG2+fIYLmXWZGCRbr0d0+d9CFANUIsspLIWmtRkQefPXHSzO2Eoc6PQiQV
	 tWWWmYdglDOQOBmXELlKZUa8M3SaMqzZwiKODvgc=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Mon, 09 Nov 2026 15:58:44 +0000
Subject: [PATCH RFC v10 19/22] arm64: kpkeys: Batch KPKEYS_CTX_PGTABLES
 switches
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-kpkeys-v10-19-aa6c4d9603bc@arm.com>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
In-Reply-To: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
To: linux-hardening@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ard Biesheuvel <ardb+git@google.com>, Andy Lutomirski <luto@kernel.org>, 
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
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794240029; l=4874;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=xf4mnCbgRoC4McQQdkoE98wQ+JFumNK4YzHFaYloEOc=;
 b=Gmrm9AOzE5rqNW6yMYk/EZ4iMTeukSeNRN048Oj3iqazwl2o/qZJ7PMOI+du48vXZZGmLoSb+
 V8grDTumbALC+mu+7PvZ5/wbybQgeL9EMYZI23gO7yjsEiiXRrkqGFI
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The kpkeys_hardened_pgtables feature currently switches kpkeys
context in every helper that writes to page tables, such as
set_pte(). With kpkeys implemented using POE, this entails a pair of
ISBs whenever such helper is called.

A simple way to reduce this overhead is to make use of the lazy MMU
mode. We amend the kpkeys_hardened_pgtables guard so that no kpkeys
context switch (i.e. POR_EL1 update) is issued while the lazy MMU
mode is active. Instead, we switch to KPKEYS_CTX_PGTABLES when
entering the lazy MMU mode, and restore the previous context when
exiting it.

Restoring the previous kpkeys context requires storing struct
kpkeys_state somewhere. POR_EL1 is a full 64-bit value so we cannot
simply use a TIF flag. There is no straightforward way to reuse
current->thread.por_el1 for that purpose - this is where the current
value of POR_EL1 is stored on a context switch, i.e. the value
corresponding to KPKEYS_CTX_PGTABLES inside a lazy_mmu section.
Instead, we add a new member to thread_struct to hold that state
temporarily. This isn't optimal as that member is unused outside of
lazy MMU sections, but it is the simplest option. Nesting of
sections is not a concern as arch_{enter,leave}_lazy_mmu_mode() are
not called in inner lazy MMU sections (nor do we need to do anything
there).

A further optimisation this patch makes is to merge the ISBs when
exiting lazy_mmu mode. That is, if an ISB is going to be issued by
emit_pte_barriers() because kernel pgtables were modified in the
lazy MMU section, we skip the ISB after restoring POR_EL1. This is
done by checking TIF_LAZY_MMU_PENDING and ensuring that POR_EL1 is
restored before emit_pte_barriers() is called.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/pgtable.h   | 50 +++++++++++++++++++++++++++++++++++---
 arch/arm64/include/asm/processor.h |  4 +++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5f46d4cb3882..5e958531e6ab 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -43,10 +43,44 @@
 
 #ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
 KPKEYS_GUARD_COND(kpkeys_hardened_pgtables, KPKEYS_CTX_PGTABLES,
-		  kpkeys_hardened_pgtables_enabled())
-#else
+		  kpkeys_hardened_pgtables_enabled() &&
+		  !is_lazy_mmu_mode_active())
+
+static inline void kpkeys_lazy_mmu_enter(void)
+{
+	if (!kpkeys_hardened_pgtables_enabled())
+		return;
+
+	current->thread.kpkeys_state_lazy_mmu =
+		kpkeys_enter_context(KPKEYS_CTX_PGTABLES);
+}
+
+static inline void kpkeys_lazy_mmu_exit(void)
+{
+	const struct kpkeys_state *state =
+		&current->thread.kpkeys_state_lazy_mmu;
+
+	if (!kpkeys_hardened_pgtables_enabled())
+		return;
+
+	/*
+	 * We skip any barrier if TIF_LAZY_MMU_PENDING is set:
+	 * emit_pte_barriers() will issue an ISB just after this function
+	 * returns.
+	 */
+	if (test_thread_flag(TIF_LAZY_MMU_PENDING) && state->entered_context)
+		__kpkeys_set_pkey_reg_nosync(state->arch_state.por);
+	else
+		kpkeys_leave_context(state);
+}
+#else /* CONFIG_KPKEYS_HARDENED_PGTABLES */
 KPKEYS_GUARD_NOOP(kpkeys_hardened_pgtables)
-#endif
+
+static inline void kpkeys_lazy_mmu_enter(void) {}
+static inline void kpkeys_lazy_mmu_exit(void) {}
+#endif /* CONFIG_KPKEYS_HARDENED_PGTABLES */
+
+
 
 static inline void emit_pte_barriers(void)
 {
@@ -79,7 +113,10 @@ static inline void queue_pte_barriers(void)
 	}
 }
 
-static inline void arch_enter_lazy_mmu_mode(void) {}
+static inline void arch_enter_lazy_mmu_mode(void)
+{
+	kpkeys_lazy_mmu_enter();
+}
 
 static inline void arch_flush_lazy_mmu_mode(void)
 {
@@ -89,6 +126,11 @@ static inline void arch_flush_lazy_mmu_mode(void)
 
 static inline void arch_leave_lazy_mmu_mode(void)
 {
+	/*
+	 * The ordering should be preserved to allow kpkeys_lazy_mmu_exit()
+	 * to skip any barrier when TIF_LAZY_MMU_PENDING is set.
+	 */
+	kpkeys_lazy_mmu_exit();
 	arch_flush_lazy_mmu_mode();
 }
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 18424d91d8b2..e96c4d57d67d 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -30,6 +30,7 @@
 #include <linux/build_bug.h>
 #include <linux/cache.h>
 #include <linux/init.h>
+#include <linux/kpkeys_types.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/thread_info.h>
@@ -196,6 +197,9 @@ struct thread_struct {
 	u64			tpidr2_el0;
 	u64			por_el0;
 	u64			por_el1;
+#ifdef CONFIG_KPKEYS_HARDENED_PGTABLES
+	struct kpkeys_state	kpkeys_state_lazy_mmu;
+#endif
 #ifdef CONFIG_ARM64_GCS
 	unsigned int		gcs_el0_mode;
 	unsigned int		gcs_el0_locked;

-- 
2.56.0

