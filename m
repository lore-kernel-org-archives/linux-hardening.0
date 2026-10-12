Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3E46EF71;
	Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795878; cv=none; b=g+5Q+hN8IyNC0WLr0SLoUoIeF9dYpI3JKqcKMYaoM04Jgbr6QDzf3Eu4xdECV+Mz/xMs3dWD+0YlnH8J4YnTSmrw0euE15pf+ojGgvZUepMMI8vHnsoVRQmuV5wbe2DK13qtzP7qrFKUQdah37+3FwIvyEzuAaww+qHIrYbUJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795878; c=relaxed/simple;
	bh=UQFEgaH0Sh7Cc3MUqo8fBua/RQhizp58gZcqmg8tf+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTrQaRa/lC7jtrgfEc4/q43ifZ9/4DUne8MYUJEe9wKdl1U6RlOwDs/PwPWTzOEBXnyKtmimajVOgYYQufmaKV8Qh0m5a5zbsMNxXYRJM2ZtiZRbjh1UybOr4aj3y4bk4k0ZDun+AQGOnhz8N1h3Bk22fsvqc0HhK8TA1O8xcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8dsi9P4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8dsi9P4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5501F0089C;
	Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795876;
	bh=6UEO5pBlN7ZKTV6J609AiJQRSN/XfLtjjo48RxWrohI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L8dsi9P4455OLJzZu9caJ4H2Elmfngh8YmSBi15CZ2vymW2HaLE5lEH8kzJAskUO2
	 PTRhLy6XY9fQH2k0Nbg4v2ih/X0pbGjXcstzcVvBJflPR9x5q0i6hzx083s7sjnv0a
	 mkSPof+AJanDzu/MEhUKcZgW+U8H3StiaszV6B96Z7LRX+utv+zJp0Ej5ThkpWc4fU
	 48PMlzV1kXvl3a3TrZXk1rYK4VqZjJtWXLgjlve+7ySK7UuvtYzeOZoGMoqzvb8P4F
	 zaIIdMLoarcNwYvRNUGz8eX7uVtjXssuTTTA82NWXpV25k/thSYSJchvpY2DbdliEh
	 e7ti1+AbcK08w==
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	x86@kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] x86/kcfi: Decode the kCFI check from the trap address
Date: Mon, 12 Oct 2026 02:04:24 -0700
Message-ID: <20261012090436.1676525-1-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012090424.i.497-kees@kernel.org>
References: <20261012090424.i.497-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3580; i=kees@kernel.org; h=from:subject; bh=UQFEgaH0Sh7Cc3MUqo8fBua/RQhizp58gZcqmg8tf+s=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlnFs3UsHsZf/P/3Etz93wPdFu5KHnhqzSNXZeds7N3r 7AU9qp71lHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR3BBGhu1rlKZ/16p9KPvx SGn14/9LK1cnPeV97pO0RGrRC+G+py2MDAs//18ZKiRUvX75JO/Kq1v57Cr+Z88zCK85ERr0cml dEQcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit b2250d63e6422 ("x86/kcfi: Optimize call sequence"), a
CONFIG_FINEIBT=y kernel running in kCFI mode rewrites each kCFI call
site at boot so that a failed check traps on the 0xd6 byte of
"test $0xd6, %al", one byte past where the compiler's "ud2" was.
handle_cfi_failure() steps "addr" back one byte to find the trap in
.kcfi_traps, but decode_cfi_insn() still decodes from regs->ip, so it
reads each instruction starting at its second byte.
"movl $-<id>, %r10d" then decodes as "movl $-<id>, %edx", so the
reported type is right by accident, but "addl -15(%r11), %r10d" decodes
as "addl -15(%rbx), %edx", so the reported target is whatever %rbx holds:

  CFI failure at lkdtm_indirect_call+0x16/0x20 (target: 0x12; expected type: 0xc79a2d1b)

Pass the adjusted address to decode_cfi_insn() and decode from it.

Tested ARCH=x86_64 defconfig with CONFIG_CFI=y and CONFIG_LKDTM=y under
QEMU, with LKDTM's CFI_FORWARD_PROTO and both Clang 24.0.0git and GCC
17.0.0 (experimental, with the kCFI series). With CONFIG_FINEIBT=y in
kCFI mode, the report gives %rbx as the target without this change, and
the expected lkdtm_increment_int() with it. With cfi=fineibt, with
cfi=fineibt,paranoid, and with CONFIG_FINEIBT=n, it gives
lkdtm_increment_int() both with and without this change.

Fixes: b2250d63e6422 ("x86/kcfi: Optimize call sequence")
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/x86/kernel/cfi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index 1df26dfdce08..8e5c4ed264a0 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -10,11 +10,11 @@
 #include <asm/insn-eval.h>
 
 /*
- * Returns the target address and the expected type when regs->ip points
+ * Returns the target address and the expected type when addr points
  * to a compiler-generated CFI trap.
  */
-static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
-			    u32 *type)
+static bool decode_cfi_insn(struct pt_regs *regs, unsigned long addr,
+			    unsigned long *target, u32 *type)
 {
 	char buffer[MAX_INSN_SIZE];
 	struct insn insn;
@@ -29,13 +29,13 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
 	 *   movl    -<id>, %r10d       ; 6 bytes
 	 *   addl    -<pos>(%reg), %r10d; 4 bytes
 	 *   je      .Ltmp1             ; 2 bytes
-	 *   ud2                        ; <- regs->ip
+	 *   ud2                        ; <- addr
 	 *   .Ltmp1:
 	 *
 	 * We can decode the expected type and the target address from the
 	 * movl/addl instructions.
 	 */
-	if (copy_from_kernel_nofault(buffer, (void *)regs->ip - 12, MAX_INSN_SIZE))
+	if (copy_from_kernel_nofault(buffer, (void *)addr - 12, MAX_INSN_SIZE))
 		return false;
 	if (insn_decode_kernel(&insn, &buffer[offset]))
 		return false;
@@ -44,7 +44,7 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
 
 	*type = -(u32)insn.immediate.value;
 
-	if (copy_from_kernel_nofault(buffer, (void *)regs->ip - 6, MAX_INSN_SIZE))
+	if (copy_from_kernel_nofault(buffer, (void *)addr - 6, MAX_INSN_SIZE))
 		return false;
 	if (insn_decode_kernel(&insn, &buffer[offset]))
 		return false;
@@ -82,7 +82,7 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 				return BUG_TRAP_TYPE_NONE;
 		}
 
-		if (!decode_cfi_insn(regs, &target, &type))
+		if (!decode_cfi_insn(regs, addr, &target, &type))
 			return report_cfi_failure_noaddr(regs, addr);
 
 		break;
-- 
2.55.0

