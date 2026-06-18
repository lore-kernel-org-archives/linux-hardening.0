Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024722E22BD;
	Thu, 18 Jun 2026 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770380; cv=none; b=lcWnlvs6FogmpBPT4OoGizharv3W5XqG/w8AEkHclxonY1Z/FqY8CFU/0Zo5/ZHSGhB7b4VrDBU5X6mPTI0+z39Um3hYLIf5/eGcWURf8IRL/di3up83VdcsDPkVeWh9cMGQ6sn3YsyZloz2C4FySaRW5UEYQm6a9bdz8PQNJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770380; c=relaxed/simple;
	bh=ModCF8ov3TtoIrFxkQYcmcDaoLwDTqZa7+2eB+/85xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ey4hkcpPSmC00GCVoR24bYLAtxNUigLRpDKniLLBAhXQo9rFfQGTj5inwpVbDsML0RoocFpk3FGSKUNt8ZW3vS4WlkreSG5jvtirVwJp7fYcf6w+qhojUfWi2dCJUHlHrnWUk8iyxdB4jBeg3Juy/dwRsIL3CpNIuWz9yB/SZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkigb6gK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkigb6gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944F71F00A3A;
	Thu, 18 Jun 2026 08:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781770378;
	bh=jVNjv8JxwUwcCkGdwQsT2x+fWCMTSZLSOFkNo5kgMWk=;
	h=From:To:Cc:Subject:Date;
	b=lkigb6gKRHtpYsq/sANBKiyykvRoCUDy2MtsJvRMvfhQaBBSQHIa0QWMVCM1JpfG4
	 jLXJzCr7WqEA2oimef8Ao8hcUkKHu5An1BvLH3eBkT62HrmzpL7sbGF2DeGsGRWlgV
	 vUHtp4XaDgx/NAbYYumG2WjDcZM1fLbGQdejMVo0i2pKbqhuTJjL5Uf9J2Rx5U3++6
	 Cd6Vmip99BbNCNyL1rdvsUeJvK1sgYxFNJBOlC/Ayore2NEQ8mQqaeVjK/u6s82QHk
	 j8i4mQJT6GlxPApi27/VofVaK6YlarPwnWficZVGT9FGDcIXqILA+YgW4IGy0GEETo
	 hcjFeAYR6s4nA==
From: Kees Cook <kees@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] riscv: Add kCFI type prefix to unaligned copy routines
Date: Thu, 18 Jun 2026 01:12:57 -0700
Message-Id: <20260618081252.work.711-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973; i=kees@kernel.org; h=from:subject:message-id; bh=ModCF8ov3TtoIrFxkQYcmcDaoLwDTqZa7+2eB+/85xs=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnGKzpaPKx/V1tc877xMLEm5tue7lXNfUsU+pLmF/39e Uy15LhCRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQYNjL8s7zo+EalbVv8o+RY psIlU9tnNcc7Gn0WPt9mnL9cOMDtKMP/6C73/1HrI9f8zw4xf7Z28fX1fTWSJc+S7eQV356SUqz lAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

__riscv_copy_words_unaligned() and __riscv_copy_bytes_unaligned() are
called indirectly through function pointers from measure_cycles() (via
compare_unaligned_access()) during the boot-time unaligned-access
probe. Under kCFI, an indirect call checks the type id stored in the
word immediately preceding the callee against the type id of the
function-pointer type at the call site. These two routines are defined
with SYM_FUNC_START(), which emits no __cfi_ prefix, so the check reads
the alignment padding ahead of the function (zero) instead of a type id
and traps:

  CFI failure at measure_cycles.constprop.0+0x34
    (target: __riscv_copy_words_unaligned+0x0; expected type: 0x00000000)
  Kernel panic - not syncing: Fatal exception in interrupt

The call site is correct: it loads the actual type id from [target-4]
and compares against the expected 0xf1200a56, which matches the
compiler-generated __kcfi_typeid___riscv_copy_words_unaligned. Only the
callee is missing its prefix word.

Switch both routines to SYM_TYPED_FUNC_START() so the assembler emits
the __cfi_ type-id prefix, matching the existing treatment of other
indirectly-called riscv assembly routines (e.g. ftrace_stub in
mcount.S and __cpu_resume_enter in suspend_entry.S), and add the
<linux/cfi_types.h> include that provides the macro.

Build and boot tested ARCH=riscv defconfig+CONFIG_CFI=y with GCC
17.0.0 20260615 (experimental kCFI tree) under qemu; the boot-time
unaligned-access probe no longer traps.

Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
Assisted-by: Claude:claude-opus-4-8[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/riscv/kernel/copy-unaligned.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/copy-unaligned.S b/arch/riscv/kernel/copy-unaligned.S
index 2b3d9398c113..c649ad3d19e0 100644
--- a/arch/riscv/kernel/copy-unaligned.S
+++ b/arch/riscv/kernel/copy-unaligned.S
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Rivos Inc. */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm.h>
 
 	.text
@@ -9,7 +10,7 @@
 /* void __riscv_copy_words_unaligned(void *, const void *, size_t) */
 /* Performs a memcpy without aligning buffers, using word loads and stores. */
 /* Note: The size is truncated to a multiple of 8 * SZREG */
-SYM_FUNC_START(__riscv_copy_words_unaligned)
+SYM_TYPED_FUNC_START(__riscv_copy_words_unaligned)
 	andi  a4, a2, ~((8*SZREG)-1)
 	beqz  a4, 2f
 	add   a3, a1, a4
@@ -41,7 +42,7 @@ SYM_FUNC_END(__riscv_copy_words_unaligned)
 /* void __riscv_copy_bytes_unaligned(void *, const void *, size_t) */
 /* Performs a memcpy without aligning buffers, using only byte accesses. */
 /* Note: The size is truncated to a multiple of 8 */
-SYM_FUNC_START(__riscv_copy_bytes_unaligned)
+SYM_TYPED_FUNC_START(__riscv_copy_bytes_unaligned)
 	andi a4, a2, ~(8-1)
 	beqz a4, 2f
 	add  a3, a1, a4
-- 
2.34.1

