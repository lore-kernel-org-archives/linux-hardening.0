Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC92E8B9C
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761229; cv=none; b=t9FvzURzZRUVPaEIyVZMw5rjE/P4w7uYG6g7EsOULa+IV3XHuGggxvBmfBFQ613jTMoZ74RD51UJrir07If+zGNRwYbIjTFi7GHHt+65PBSIIvaBszqg8RzSC2PdvgbiQnJGeaciFauz8B/KKd/BZJqmW5btLWJ6qO/3bkibuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761229; c=relaxed/simple;
	bh=8HCCfZj3Yr0DRNY3RA/7SxWlUzaO5bFr20Rnsm+5LuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyrgEHXEgqSFn3NkEqpF5QTTrvUEhUAWQ3nWcZ505NTosd/lvNtnoEE4NdCbxgvI9os/VEgJNAz/Kwpa7HY5moTBTvXqvoBaGiev9xx4kj6dcihV2ejtnVpB/IdD7I6jPgMnf8APZGRwfe5ZK3iU9KacGIoHy4dKc9OB18NrHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSMk2cTZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSMk2cTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4077AC19423;
	Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761229;
	bh=8HCCfZj3Yr0DRNY3RA/7SxWlUzaO5bFr20Rnsm+5LuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSMk2cTZWajSA21FHAS3y0aQ86ALXumYov0IsaA0L+m0rbKcVd1xz5T6nFir+VWPC
	 dUSdqWm8hgqGcfeWJuKrTqY+ZgdYpOsX1G951yMMdxNc9iTh5yOctmC9NEKzSTb1HW
	 GAZKAWzEe2FMU4J3KmWbHaaHv4JNOl40GV65gpso/LVkCj+dJBYArAyih+5izaxuqH
	 4hojK8kN5gORHPiIHqelP2jvQ/rL6/e/fhzZh0wsrJXDKEZ09eGfSWJJYlP6ftpvru
	 yFxb5wIG1EZhCGZ2HzmR/JOO4JeWIfDmOlIrz5N+dyiKWql85NFXAuTsVe1C6OZbaN
	 dYmXWWRQ3AXUQ==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH 7/7] kcfi: Add regression test suite
Date: Thu, 21 Aug 2025 00:26:40 -0700
Message-Id: <20250821072708.3109244-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821064202.work.893-kees@kernel.org>
References: <20250821064202.work.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a test suite for KCFI (Kernel Control Flow Integrity) ABI.

Core Functionality Tests:
- kcfi-basics.c: Basic KCFI preamble generation, IPA analysis, and
  __kcfi_typeid_ symbol emission for external address-taken functions.
- kcfi-type-mangling.c: Type ID hashing validation with Itanium C++ ABI
  mangling for function signatures covering basic types, pointers, const
  qualifiers, multiple parameters, return types, arrays, function pointers,
  structs/unions/enums, typedef canonicalization, and recursive type
  definitions.
- kcfi-no-sanitize.c: no_sanitize("kcfi") attribute support for
  instrumentation disabling.
- kcfi-no-sanitize-inline.c: Regression test for preserving no_sanitize("kcfi")
  attributes during function inlining. Tests that functions marked with both
  no_sanitize("kcfi") and always_inline correctly suppress KCFI checks when
  inlined.
- kcfi-trap-section.c: Trap section (.kcfi_traps) generation and
  proper trap instruction placement.

Optimization and Code Generation Tests:
- kcfi-adjacency.c: Regression test ensuring KCFI checks remain
  immediately adjacent to indirect calls with no intervening instructions.
- kcfi-call-sharing.c: Prevents optimizer from incorrectly sharing
  KCFI checks between different function pointer types.
- kcfi-tail-calls.c: KCFI protection preservation when indirect calls
  are converted to tail calls under optimization.
- kcfi-ipa-robustness.c: IPA pass robustness with compiler-generated
  constructs like static_assert.

Addressing and Environment Tests:
- kcfi-complex-addressing.c: Structure member and array element function
  pointers with complex addressing modes.
- kcfi-pic-addressing.c: Position-independent code with PIC addressing
  modes and symbol references.
- kcfi-cold-partition.c: Cold function attributes and block partitioning
  with -freorder-blocks-and-partition.

Architecture-Specific Verification:
- kcfi-aarch64-esr.c: AArch64 ESR encoding in BRK instructions with
  proper exception register values.
- kcfi-offset-validation.c: Call site offset validation across
  architectures.
- kcfi-insn-sequence.c: Exact instruction sequence verification for
  KCFI runtime checks.

Patchable Function Entry Integration:
- kcfi-patchable-none.c: Standard case without patchable entries.
- kcfi-patchable-basic.c: Basic patchable entries (5,2 configuration).
- kcfi-patchable-prefix-only.c: Equal prefix/entry split (3,3
  configuration).
- kcfi-patchable-entry-only.c: Entry-only NOPs (4,0 configuration).
- kcfi-patchable-medium.c: Medium prefix NOPs (8,4 configuration).
- kcfi-patchable-large.c: Large prefix NOPs (11,11 configuration).

Tests can be run via:
  make check-gcc RUNTESTFLAGS='kcfi.exp'

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-esr.c  |  36 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  83 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  83 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  75 ++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         | 133 +++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 116 +++
 .../gcc.dg/kcfi/kcfi-insn-sequence.c          |  42 +
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 ++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  96 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  39 +
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |  41 +
 .../gcc.dg/kcfi/kcfi-patchable-basic.c        |  54 ++
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  36 +
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  47 +
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  52 ++
 .../gcc.dg/kcfi/kcfi-patchable-none.c         |  18 +
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  48 +
 .../gcc.dg/kcfi/kcfi-pic-addressing.c         |  98 ++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 111 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  56 ++
 .../gcc.dg/kcfi/kcfi-type-mangling.c          | 864 ++++++++++++++++++
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  36 +
 22 files changed, 2218 insertions(+)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-esr.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-insn-sequence.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-none.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-type-mangling.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp

diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-esr.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-esr.c
new file mode 100644
index 000000000000..6bbbba0431b0
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-esr.c
@@ -0,0 +1,36 @@
+/* Test AArch64 KCFI ESR encoding in BRK instructions */
+/* { dg-do compile { target aarch64*-*-* } } */
+/* { dg-options "-fsanitize=kcfi" } */
+
+void target_function(int x, char y) {
+    /* Different signature to get different type ID */
+}
+
+int main() {
+    void (*func_ptr)(int, char) = target_function;
+
+    /* This should generate BRK with ESR encoding */
+    func_ptr(42, 'a');
+
+    return 0;
+}
+
+/* Should have KCFI preamble */
+/* { dg-final { scan-assembler "__cfi_target_function:" } } */
+
+/* AArch64 specific: Should have BRK instruction with proper ESR encoding
+   ESR format: 0x8000 | ((type_reg & 31) << 5) | (addr_reg & 31)
+
+   Test the ESR encoding by checking for the expected value.
+   Since we know this test uses x2, we expect ESR = 0x8000 | (17<<5) | 2 = 33314
+
+   A truly dynamic test would need to extract the register from blr and compute
+   the corresponding ESR, but DejaGnu's regex limitations make this complex.
+   This test validates the specific case and documents the encoding.
+   */
+/* { dg-final { scan-assembler "blr\\s+x2" { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler "brk\\s+#33314" { target aarch64*-*-* } } } */
+
+/* Should have KCFI check with type comparison */
+/* { dg-final { scan-assembler {ldur\t*w16, \[x[0-9]+, #-4\]} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler {cmp\t*w16, w17} { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
new file mode 100644
index 000000000000..35678abe0e12
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -0,0 +1,83 @@
+/* Test KCFI check/transfer adjacency - regression test for instruction insertion */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+/* This test ensures that KCFI security checks remain immediately adjacent
+   to their corresponding indirect calls/jumps, with no executable instructions
+   between the type ID check and the control flow transfer. */
+
+/* External function pointers to prevent optimization */
+extern void (*complex_func_ptr)(int, int, int, int);
+extern int (*return_func_ptr)(int, int);
+
+/* Function with complex argument preparation that could tempt
+   the optimizer to insert instructions between KCFI check and call */
+__attribute__((noinline)) void test_complex_args(int a, int b, int c, int d) {
+    /* Complex argument expressions that might cause instruction scheduling */
+    complex_func_ptr(a * 2, b + c, d - a, (a << 1) | b);
+}
+
+/* Function with return value handling */
+__attribute__((noinline)) int test_return_value(int x, int y) {
+    /* Return value handling that shouldn't interfere with adjacency */
+    int result = return_func_ptr(x + 1, y * 2);
+    return result + 1;
+}
+
+/* Test struct field access that caused issues in try-catch.c */
+struct call_info {
+    void (*handler)(void);
+    int status;
+    int data;
+};
+
+extern struct call_info *global_call_info;
+
+__attribute__((noinline)) void test_struct_field_call(void) {
+    /* This pattern caused adjacency issues before the fix */
+    global_call_info->handler();
+}
+
+/* Test conditional indirect call */
+__attribute__((noinline)) void test_conditional_call(int flag) {
+    if (flag) {
+        global_call_info->handler();
+    }
+}
+
+/* Should have KCFI instrumentation for all indirect calls */
+
+/* x86_64: Complete KCFI check sequence should be present */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r1[01]d\n\taddl\t[^,]+, %r1[01]d\n\tje\t\.L[0-9]+\n\t\.L[0-9]+:\n\tud2} { target x86_64-*-* } } } */
+
+/* AArch64: Complete KCFI check sequence should be present */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-[0-9]+\]\n\tmov\tw17, #[0-9]+\n\tmovk\tw17, #[0-9]+, lsl #16\n\tcmp\tw16, w17\n\tb\.eq\t\.L[0-9]+\n\t\.L[0-9]+:\n\tbrk\t#[0-9]+} { target aarch64*-*-* } } } */
+
+/* RISC-V: Complete KCFI check sequence should be present */
+/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, \.L[a-zA-Z0-9_]+\n\.L[a-zA-Z0-9_]+:\n\tebreak} { target riscv*-*-* } } } */
+
+/* Trap instructions are now validated as part of the complete compound patterns above */
+
+/* Should have trap section with entries */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } */
+
+/* AArch64 should NOT have trap section (uses brk immediate instead) */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
+
+/* Critical adjacency requirement: After each KCFI type comparison,
+   there should be only a conditional jump and label before the indirect transfer.
+   No executable instructions should be inserted between the security check
+   and the control flow transfer.
+
+   Pattern on x86_64 should be:
+   movl $(-TYPEID), %r10d # Load inverse type ID
+   addl OFFSET(%reg), %r10d # Add actual type ID
+   je   .LabelN           # Jump if zero (match)
+   .LN:                  # Trap label (not executable)
+   ud2                   # Trap instruction
+   .LabelN:              # Call label (not executable)
+   call/jmp *TARGET      # Indirect transfer
+
+   This test serves as a regression test to ensure this adjacency
+   property is maintained across compiler changes. */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
new file mode 100644
index 000000000000..db1fcfd8f5e2
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
@@ -0,0 +1,83 @@
+/* Test basic KCFI functionality - preamble generation */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi" } */
+
+/* Extern function declarations - should NOT get KCFI preambles */
+extern void external_func(void);
+extern int external_func_int(int x);
+
+void regular_function(int x) {
+    /* This should get KCFI preamble */
+}
+
+void static_target_function(int x) {
+    /* Target function that can be called indirectly */
+}
+
+static void static_caller(void) {
+    /* Static function that makes an indirect call */
+    /* Should NOT get KCFI preamble (not address-taken) */
+    /* But must generate KCFI check for the indirect call */
+    void (*local_ptr)(int) = static_target_function;
+    local_ptr(42);  /* This should generate KCFI check */
+}
+
+void (*func_ptr)(int) = regular_function;
+void (*ext_ptr)(void) = external_func;  /* Make external_func address-taken */
+
+int main() {
+    func_ptr(42);
+    ext_ptr();        /* Indirect call to external_func */
+    external_func_int(10);  /* Direct call to external_func_int */
+    static_caller();  /* Direct call to static function */
+    return 0;
+}
+
+/* Verify KCFI preamble exists for regular_function */
+/* { dg-final { scan-assembler {__cfi_regular_function:} } } */
+
+/* Target function should have preamble (address-taken) */
+/* { dg-final { scan-assembler {__cfi_static_target_function:} } } */
+
+/* Static caller should NOT have preamble (it's only called directly, not address-taken) */
+/* { dg-final { scan-assembler-not {__cfi_static_caller:} } } */
+
+/* x86_64: Verify type ID in preamble (after NOPs, before function label) */
+/* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
+
+/* x86_64: Static function should generate complete KCFI check sequence */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[a-z0-9]+\), %r10d\n\tje\t\.L[0-9]+\n\t\.L[0-9]+:\n\tud2} { target x86_64-*-* } } } */
+
+/* AArch64: Verify type ID word in preamble */
+/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word 0x[0-9a-f]+} { target aarch64*-*-* } } } */
+
+/* AArch64: Static function should generate complete KCFI check sequence */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]\n\tmov\tw17, #[0-9]+\n\tmovk\tw17, #[0-9]+, lsl #16\n\tcmp\tw16, w17\n\tb\.eq\t\.L[0-9]+\n\t\.L[0-9]+:\n\tbrk\t#[0-9]+} { target aarch64*-*-* } } } */
+
+/* RISC-V: Verify type ID word in preamble */
+/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-9a-f]+} { target riscv*-*-* } } } */
+
+/* RISC-V: Static function should generate KCFI check for indirect call */
+/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, \.L[a-zA-Z0-9_]+\n\.L[a-zA-Z0-9_]+:\n\tebreak} { target riscv*-*-* } } } */
+
+/* Extern functions should NOT get KCFI preambles */
+/* { dg-final { scan-assembler-not {__cfi_external_func:} } } */
+/* { dg-final { scan-assembler-not {__cfi_external_func_int:} } } */
+
+/* Local functions should NOT get __kcfi_typeid_ symbols */
+/* Only external declarations that are address-taken should get __kcfi_typeid_ */
+/* { dg-final { scan-assembler-not {__kcfi_typeid_regular_function} } } */
+/* { dg-final { scan-assembler-not {__kcfi_typeid_main} } } */
+
+/* External address-taken functions should get __kcfi_typeid_ symbols */
+/* { dg-final { scan-assembler {__kcfi_typeid_external_func} } } */
+
+/* External functions that are only called directly should NOT get __kcfi_typeid_ symbols */
+/* { dg-final { scan-assembler-not {__kcfi_typeid_external_func_int} } } */
+
+/* Should have trap section for KCFI checks */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } */
+
+/* AArch64 should NOT have trap section (uses brk immediate instead) */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
new file mode 100644
index 000000000000..e8c480e81de2
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -0,0 +1,75 @@
+/* Test KCFI check sharing bug - optimizer incorrectly shares KCFI checks between different function types */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+/* Reproduce the pattern from Linux kernel internal_create_group where:
+   - Two different function pointer types (is_visible vs is_bin_visible)
+   - Both get loaded into the same register (%rcx)
+   - Optimizer creates shared KCFI check with wrong type ID
+   - This causes CFI failures in production kernel */
+
+struct kobject { int dummy; };
+struct attribute { int dummy; };
+struct bin_attribute { int dummy; };
+
+struct attribute_group {
+    const char *name;
+    int (*is_visible)(struct kobject *, struct attribute *, int);       // Type ID A
+    int (*is_bin_visible)(struct kobject *, const struct bin_attribute *, int);  // Type ID B
+    struct attribute **attrs;
+    const struct bin_attribute **bin_attrs;
+};
+
+/* Function that mimics __first_visible from kernel - gets inlined into caller */
+static int __first_visible(const struct attribute_group *grp, struct kobject *kobj)
+{
+    /* Path 1: Call is_visible function pointer */
+    if (grp->attrs && grp->attrs[0] && grp->is_visible)
+        return grp->is_visible(kobj, grp->attrs[0], 0);
+
+    /* Path 2: Call is_bin_visible function pointer */
+    if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
+        return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
+
+    return 0;
+}
+
+/* Main function that triggers the optimization bug */
+int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *grp)
+{
+    /* This should inline __first_visible and create the problematic pattern where:
+       1. Both function pointers get loaded into same register
+       2. Optimizer shares KCFI check between them
+       3. Uses wrong type ID for one of the calls */
+    return __first_visible(grp, kobj);
+}
+
+/* Each indirect call should have its own KCFI check with correct type ID
+
+   Should see:
+   1. KCFI check for is_visible call with is_visible type ID
+   2. KCFI check for is_bin_visible call with is_bin_visible type ID */
+
+/* Verify we have TWO different KCFI check sequences */
+/* Each check should have different type ID constants */
+/* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2 { target i?86-*-* x86_64-*-* } } } */
+/* AArch64: { dg-final { scan-assembler-times {mov\s+w17, #[0-9]+} 2 { target aarch64*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {lui\tt2, [0-9]+} 2 { target riscv*-*-* } } } */
+
+/* Verify the checks use DIFFERENT type IDs (not shared) */
+/* We should NOT see the same type ID used twice - that would indicate sharing bug */
+/* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*movl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
+/* AArch64: { dg-final { scan-assembler-not {mov\s+w17, #([0-9]+).*mov\s+w17, #\1} { target aarch64*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-not {lui\s+t2, ([0-9]+)\s.*lui\s+t2, \1\s} { target riscv*-*-* } } } */
+
+/* Verify each call follows its own check (not shared) */
+/* Should have 2 separate trap instructions */
+/* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
+/* AArch64: { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {ebreak} 2 { target riscv*-*-* } } } */
+
+/* Verify 2 separate call sites */
+/* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { target i?86-*-* x86_64-*-* } } } */
+/* AArch64: Allow both blr (regular call) and br (tail call) */
+/* AArch64: { dg-final { scan-assembler-times {br	x[0-9]+} 2 { target aarch64*-*-* } } } */
+/* RISC-V: { dg-final { scan-assembler-times {jalr\t[a-z0-9]+} 2 { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
new file mode 100644
index 000000000000..f4fa9f6646a4
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
@@ -0,0 +1,133 @@
+/* Test KCFI cold function and cold partition behavior */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -O2 -freorder-blocks-and-partition" } */
+
+void regular_function(void) {
+    /* Regular function should get preamble */
+}
+
+/* Cold-attributed function should STILL get preamble (it's a regular function, just marked cold) */
+__attribute__((cold))
+void cold_attributed_function(void) {
+    /* This function has cold attribute but should still get KCFI preamble */
+}
+
+/* Hot-attributed function should get preamble */
+__attribute__((hot))
+void hot_attributed_function(void) {
+    /* This function is explicitly hot and should get KCFI preamble */
+}
+
+/* Global to prevent optimization from eliminating cold paths */
+extern void abort(void);
+
+/* Additional function to test that normal functions still get preambles */
+__attribute__((noinline))
+int another_regular_function(int x) {
+    return x + 42;
+}
+
+/* Function designed to generate cold partitions under optimization */
+__attribute__((noinline))
+void function_with_cold_partition(int condition) {
+    /* Hot path - very likely to execute */
+    if (__builtin_expect(condition == 42, 1)) {
+        /* Simple hot path that optimizer will keep inline */
+        return;
+    }
+
+    /* Cold paths that actually do something to prevent elimination */
+    if (__builtin_expect(condition < 0, 0)) {
+        /* Error path 1 - call abort to prevent elimination */
+        abort();
+    }
+
+    if (__builtin_expect(condition > 1000000, 0)) {
+        /* Error path 2 - call abort to prevent elimination */
+        abort();
+    }
+
+    if (__builtin_expect(condition == 999999, 0)) {
+        /* Error path 3 - more substantial cold code */
+        volatile int sum = 0;
+        for (volatile int i = 0; i < 100; i++) {
+            sum += i * condition;
+        }
+        if (sum > 0)
+            abort();
+    }
+
+    /* More cold paths - switch with many unlikely cases */
+    switch (condition) {
+        case 1000001: case 1000002: case 1000003: case 1000004: case 1000005:
+        case 1000006: case 1000007: case 1000008: case 1000009: case 1000010:
+            /* Each case does some work before abort */
+            volatile int work = condition * 2;
+            if (work > 0) abort();
+            break;
+        default:
+            if (condition != 42) {
+                /* Fallback cold path - substantial work */
+                volatile int result = 0;
+                for (volatile int j = 0; j < condition % 50; j++) {
+                    result += j;
+                }
+                if (result >= 0) abort();
+            }
+    }
+}
+
+/* Test function pointers to ensure address-taken detection works */
+void test_function_pointers(void) {
+    void (*regular_ptr)(void) = regular_function;
+    void (*cold_ptr)(void) = cold_attributed_function;
+    void (*hot_ptr)(void) = hot_attributed_function;
+
+    regular_ptr();
+    cold_ptr();
+    hot_ptr();
+}
+
+int main() {
+    regular_function();
+    cold_attributed_function();
+    hot_attributed_function();
+    function_with_cold_partition(42); /* Normal case - stay in hot path */
+    another_regular_function(5);
+    test_function_pointers();
+    return 0;
+}
+
+/* Regular function should have preamble */
+/* { dg-final { scan-assembler "__cfi_regular_function:" } } */
+
+/* Cold-attributed function should STILL have preamble (it's a legitimate function) */
+/* { dg-final { scan-assembler "__cfi_cold_attributed_function:" } } */
+
+/* Hot-attributed function should have preamble */
+/* { dg-final { scan-assembler "__cfi_hot_attributed_function:" } } */
+
+/* Function that generates cold partitions should have preamble for main entry */
+/* { dg-final { scan-assembler "__cfi_function_with_cold_partition:" } } */
+
+/* Address-taken functions should have preambles */
+/* { dg-final { scan-assembler "__cfi_test_function_pointers:" } } */
+
+/* The function should generate a .cold partition */
+/* { dg-final { scan-assembler "function_with_cold_partition\\.cold:" } } */
+
+/* The .cold partition should NOT get a __cfi_ preamble since it's never reached via indirect calls */
+/* { dg-final { scan-assembler-not "__cfi_function_with_cold_partition\\.cold:" } } */
+
+/* Additional regular function should get preamble */
+/* { dg-final { scan-assembler "__cfi_another_regular_function:" } } */
+
+/* Test coverage summary:
+   1. Cold-attributed function (__attribute__((cold))): SHOULD get preamble
+   2. Cold partition (-freorder-blocks-and-partition): should NOT get preamble
+   3. IPA split .part function (split_part=true): Logic in place, would skip if triggered
+
+   Note: IPA function splitting (creating .part functions with split_part=true) requires
+   specific optimization conditions that are difficult to trigger reliably in tests.
+   The KCFI logic correctly handles this case using the split_part flag check.
+*/
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
new file mode 100644
index 000000000000..ac7e2db2d654
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -0,0 +1,116 @@
+/* Test KCFI with complex addressing modes (structure members, array elements) */
+/* This is a regression test for the change_address_1 RTL error that occurred */
+/* when target_addr was PLUS(reg, offset) instead of a simple register */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+struct function_table {
+    int (*callback1)(int);
+    int (*callback2)(int, int);
+    void (*callback3)(void);
+    int data;
+};
+
+static int handler1(int x) {
+    return x * 2;
+}
+
+static int handler2(int x, int y) {
+    return x + y;
+}
+
+static void handler3(void) {
+    /* Empty handler */
+}
+
+/* Test indirect calls through structure members - this creates PLUS(reg, offset) addressing */
+int test_struct_members(struct function_table *table) {
+    int result = 0;
+
+    /* These indirect calls will generate complex addressing modes:
+     * call *(%rdi)          - callback1 at offset 0
+     * call *8(%rdi)         - callback2 at offset 8
+     * call *16(%rdi)        - callback3 at offset 16
+     * Our KCFI instrumentation must handle PLUS(reg, struct_offset) + kcfi_offset */
+
+    result += table->callback1(10);        /* MEM[PLUS(reg, 0)] -> PLUS(reg, -4) for KCFI */
+    result += table->callback2(5, 7);      /* MEM[PLUS(reg, 8)] -> PLUS(reg, 4) for KCFI */
+    table->callback3();                    /* MEM[PLUS(reg, 16)] -> PLUS(reg, 12) for KCFI */
+
+    return result;
+}
+
+/* Test indirect calls through array elements - another source of complex addressing */
+typedef int (*func_array_t)(int);
+
+int test_array_elements(func_array_t functions[], int index) {
+    /* This creates addressing like MEM[PLUS(PLUS(reg, index*8), 0)]
+     * which should be simplified to MEM[PLUS(reg, index*8)] */
+    return functions[index](42);  /* Complex array indexing */
+}
+
+/* Test with global structure */
+static struct function_table global_table = {
+    .callback1 = handler1,
+    .callback2 = handler2,
+    .callback3 = handler3,
+    .data = 100
+};
+
+int test_global_struct(void) {
+    /* Access through global structure - may generate different addressing patterns */
+    return global_table.callback1(20) + global_table.callback2(3, 4);
+}
+
+/* Test nested structure access */
+struct nested_table {
+    struct function_table inner;
+    int extra_data;
+};
+
+int test_nested_struct(struct nested_table *nested) {
+    /* Even more complex addressing: nested structure member access */
+    return nested->inner.callback1(15);  /* MEM[PLUS(reg, inner_offset + callback1_offset)] */
+}
+
+int main() {
+    struct function_table local_table = {
+        .callback1 = handler1,
+        .callback2 = handler2,
+        .callback3 = handler3,
+        .data = 50
+    };
+
+    func_array_t func_array[] = { handler1, handler1, handler1 };
+
+    int result = 0;
+    result += test_struct_members(&local_table);
+    result += test_array_elements(func_array, 1);
+    result += test_global_struct();
+
+    struct nested_table nested = { .inner = local_table, .extra_data = 200 };
+    result += test_nested_struct(&nested);
+
+    return result;
+}
+
+/* Verify that all address-taken functions get KCFI preambles */
+/* { dg-final { scan-assembler {__cfi_handler1:} } } */
+/* { dg-final { scan-assembler {__cfi_handler2:} } } */
+/* { dg-final { scan-assembler {__cfi_handler3:} } } */
+
+/* x86_64: Verify KCFI checks are generated for indirect calls through complex addressing */
+/* The key test: these should compile without change_address_1 errors (kernel-style encoding) */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {ud2} { target x86_64-*-* } } } */
+
+/* AArch64: Verify KCFI checks for complex addressing */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler {brk} { target aarch64*-*-* } } } */
+
+/* RISC-V: Verify KCFI check sequence for complex addressing */
+/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, \.L[a-zA-Z0-9_]+\n\.L[a-zA-Z0-9_]+:\n\tebreak} { target riscv*-*-* } } } */
+
+/* Should have trap section (x86 and RISC-V - AArch64 uses brk immediate) */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-insn-sequence.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-insn-sequence.c
new file mode 100644
index 000000000000..eac730c54956
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-insn-sequence.c
@@ -0,0 +1,42 @@
+/* Test for exact expected KCFI instrumentation instruction sequence */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi" } */
+
+void untaken_function(int x) {
+    /* Target function should get preamble */
+}
+
+void target_function(int x) {
+    /* Target function should get preamble */
+}
+
+int main() {
+    void (*func_ptr)(int) = target_function;
+
+    /* This indirect call should get KCFI check */
+    func_ptr(42);
+
+    untaken_function(15);
+
+    return 0;
+}
+
+/* Should have KCFI preamble for target */
+/* { dg-final { scan-assembler "__cfi_target_function:" } } */
+
+/* Should not have KCFI preamble for local non-address-take function */
+/* { dg-final { scan-assembler-not "__cfi_untaken-function:" } } */
+
+/* x86_64: Complete KCFI check sequence (kernel-style encoding) - updated for unified trap emission */
+/* Note: Single regex to enforce exact sequence - based on actual hexdump analysis */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%rax\), %r10d\n\tje\t\.L[0-9]+\n\t\.L[0-9]+:\n\tud2} { target x86_64-*-* } } } */
+
+/* AArch64: Complete KCFI check sequence */
+/* Load type ID, load expected type, compare, conditional branch, trap, branch target, call */
+/* Note: Single regex to enforce exact sequence - based on actual hexdump analysis */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]\n\tmov\tw17, #[0-9]+\n\tmovk\tw17, #[0-9]+, lsl #16\n\tcmp\tw16, w17\n\tb\.eq\t\.L[0-9]+\n\t\.L([^:]+):\n\tbrk\t#[0-9]+\n\t\.L[0-9]+:\n\t+blr\tx[0-9]+} { target aarch64*-*-* } } } */
+
+/* RISC-V: Complete KCFI check sequence */
+/* Load type ID, load expected type, compare, conditional branch, trap, branch target, call */
+/* Note: Single regex to enforce exact sequence - based on actual hexdump analysis */
+/* { dg-final { scan-assembler {lw\tt1, -[0-9]+\([^)]+\)\n\tlui\tt2, [0-9]+\n\taddiw\tt2, t2, [0-9-]+\n\tbeq\tt1, t2, \.Lkcfi_pass_[0-9]+\n\.Lkcfi_trap_[0-9]+:\n\tebreak\n\t\.pushsection\t\.kcfi_traps[^\n]*\n\.Lkcfi_trap_entry_[0-9]+:\n\t\.word\t\.Lkcfi_trap_[0-9]+ - \.Lkcfi_trap_entry_[0-9]+\n\t\.popsection\n\.Lkcfi_pass_[0-9]+:\n\tjalr\t[^,\s]+} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
new file mode 100644
index 000000000000..2a5f1d311b6b
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
@@ -0,0 +1,54 @@
+/* Test KCFI IPA pass robustness with compiler-generated constructs */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+#include <stddef.h>
+
+/* Test various compiler-generated constructs that could confuse IPA pass */
+
+/* 1. static_assert - this was causing the original crash */
+typedef struct {
+    int field1;
+    char field2;
+} test_struct_t;
+
+static_assert(offsetof(test_struct_t, field1) == 0, "layout check 1");
+static_assert(offsetof(test_struct_t, field2) == 4, "layout check 2");
+static_assert(sizeof(test_struct_t) >= 5, "size check");
+
+/* 2. Regular functions that should get KCFI analysis */
+void regular_function(void) {
+    /* Should get KCFI preamble */
+}
+
+static void static_function(void) {
+    /* With -O2: correctly identified as not address-taken, no preamble */
+}
+
+void address_taken_function(void) {
+    /* Should get KCFI preamble (address taken below) */
+}
+
+/* 3. Function pointer to create address-taken scenario */
+void (*func_ptr)(void) = address_taken_function;
+
+/* 4. More static_asserts mixed with function definitions */
+static_assert(sizeof(void*) == 8, "pointer size check");
+
+int main(void) {
+    regular_function();    /* Direct call */
+    static_function();     /* Direct call to static */
+    func_ptr();           /* Indirect call */
+
+    static_assert(sizeof(int) == 4, "int size check");
+
+    return 0;
+}
+
+/* Verify KCFI preambles are generated appropriately */
+/* { dg-final { scan-assembler "__cfi_regular_function:" } } */
+/* { dg-final { scan-assembler "__cfi_address_taken_function:" } } */
+/* { dg-final { scan-assembler "__cfi_main:" } } */
+
+/* With -O2: static_function correctly identified as not address-taken */
+/* { dg-final { scan-assembler-not "__cfi_static_function:" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
new file mode 100644
index 000000000000..2f0efc16486f
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -0,0 +1,96 @@
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+/* Test that no_sanitize("kcfi") attribute is preserved during inlining */
+
+extern void external_side_effect(int value);
+
+/* Regular function (should get KCFI checks) */
+__attribute__((noinline))
+void normal_function(void (*callback)(int))
+{
+    /* This indirect call must generate KCFI checks */
+    callback(300);
+    external_side_effect(300);
+}
+
+/* Regular function marked with no_sanitize("kcfi") (positive control) */
+__attribute__((noinline, no_sanitize("kcfi")))
+void sensitive_non_inline_function(void (*callback)(int))
+{
+    /* This indirect call should NOT generate KCFI checks */
+    callback(100);
+    external_side_effect(100);
+}
+
+/* Function marked with both no_sanitize("kcfi") and always_inline */
+__attribute__((always_inline, no_sanitize("kcfi")))
+static inline void sensitive_inline_function(void (*callback)(int))
+{
+    /* This indirect call should NOT generate KCFI checks when inlined */
+    callback(42);
+    external_side_effect(42);
+}
+
+/* Explicit wrapper for testing sensitive_inline_function behavior */
+__attribute__((noinline))
+void wrap_sensitive_inline(void (*callback)(int))
+{
+    sensitive_inline_function(callback);
+}
+
+/* Function marked with only always_inline (should get KCFI checks) */
+__attribute__((always_inline))
+static inline void normal_inline_function(void (*callback)(int))
+{
+    /* This indirect call must generate KCFI checks when inlined */
+    callback(200);
+    external_side_effect(200);
+}
+
+/* Explicit wrapper for testing normal_inline_function behavior */
+__attribute__((noinline))
+void wrap_normal_inline(void (*callback)(int))
+{
+    normal_inline_function(callback);
+}
+
+void test_callback(int value)
+{
+    external_side_effect(value);
+}
+
+static void (*volatile function_pointer)(int) = test_callback;
+
+int main(void)
+{
+    void (*fn_ptr)(int) = function_pointer;
+
+    normal_function(fn_ptr);
+    wrap_normal_inline(fn_ptr);
+    sensitive_non_inline_function(fn_ptr);
+    wrap_sensitive_inline(fn_ptr);
+
+    return 0;
+}
+
+/* Verify correct number of KCFI checks: exactly 2 */
+/* { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {brk\s+#33313} 2 { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-times {ebreak} 2 { target riscv*-*-* } } } */
+
+/* Positive controls: these should have KCFI checks */
+/* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_function} { target i?86-*-* x86_64-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_normal_inline} { target i?86-*-* x86_64-*-* } } } */
+/* { dg-final { scan-assembler {normal_function:.*brk\s+#33313.*\.size\s+normal_function} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#33313.*\.size\s+wrap_normal_inline} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler {normal_function:.*ebreak.*\.size\s+normal_function} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler {wrap_normal_inline:.*ebreak.*\.size\s+wrap_normal_inline} { target riscv*-*-* } } } */
+
+/* Negative controls: these should NOT have KCFI checks */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.*\.size\s+sensitive_non_inline_function} { target i?86-*-* x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\s+wrap_sensitive_inline} { target i?86-*-* x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*brk\s+#33313.*\.size\s+sensitive_non_inline_function} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#33313.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ebreak.*\.size\s+sensitive_non_inline_function} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ebreak.*\.size\s+wrap_sensitive_inline} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
new file mode 100644
index 000000000000..1a48fd1407f3
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -0,0 +1,39 @@
+/* Test KCFI with no_sanitize attribute */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi" } */
+
+void target_function(void) {
+    /* This should get KCFI preamble */
+}
+
+void caller_with_checks(void) {
+    /* This function should generate KCFI checks */
+    void (*func_ptr)(void) = target_function;
+    func_ptr();
+}
+
+__attribute__((no_sanitize("kcfi")))
+void caller_no_checks(void) {
+    /* This function should NOT generate KCFI checks due to no_sanitize */
+    void (*func_ptr)(void) = target_function;
+    func_ptr();
+}
+
+int main() {
+    caller_with_checks();    /* This should generate checks inside */
+    caller_no_checks();      /* This should NOT generate checks inside */
+    return 0;
+}
+
+/* All functions should get preambles regardless of no_sanitize */
+/* { dg-final { scan-assembler "__cfi_target_function:" } } */
+/* { dg-final { scan-assembler "__cfi_caller_with_checks:" } } */
+/* { dg-final { scan-assembler "__cfi_caller_no_checks:" } } */
+/* { dg-final { scan-assembler "__cfi_main:" } } */
+
+/* caller_with_checks() should generate KCFI check (1 check) */
+/* caller_no_checks() should NOT generate KCFI check due to no_sanitize attribute */
+/* Total: exactly 1 KCFI check in the entire program */
+/* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 1 { target aarch64-*-* } } } */
+/* { dg-final { scan-assembler-times {lw\tt1, -[0-9]+\(} 1 { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
new file mode 100644
index 000000000000..735892c65997
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -0,0 +1,41 @@
+/* Test KCFI call-site offset validation across architectures */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi" } */
+
+void target_func_a(void) { }
+void target_func_b(int x) { }
+void target_func_c(int x, int y) { }
+
+int main() {
+    void (*ptr_a)(void) = target_func_a;
+    void (*ptr_b)(int) = target_func_b;
+    void (*ptr_c)(int, int) = target_func_c;
+
+    /* Multiple indirect calls - each should use -4 offset in standard case */
+    ptr_a();
+    ptr_b(1);
+    ptr_c(1, 2);
+
+    return 0;
+}
+
+/* Should have KCFI preambles for all functions */
+/* { dg-final { scan-assembler "__cfi_target_func_a:" } } */
+/* { dg-final { scan-assembler "__cfi_target_func_b:" } } */
+/* { dg-final { scan-assembler "__cfi_target_func_c:" } } */
+
+/* x86_64: All call sites should use -4 offset for KCFI type ID loads (kernel-style encoding) */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
+
+/* AArch64: All call sites should use -4 offset */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aarch64*-*-* } } } */
+
+/* RISC-V: All call sites should use -4 offset */
+/* { dg-final { scan-assembler {lw\tt1, -4\(} { target riscv*-*-* } } } */
+
+/* Should have trap section with multiple entries */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } */
+
+/* AArch64 should NOT have trap section (uses brk immediate instead) */
+/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c
new file mode 100644
index 000000000000..f21de4021124
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c
@@ -0,0 +1,54 @@
+/* Test KCFI with patchable function entries - basic case */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -fpatchable-function-entry=5,2" } */
+
+void test_function(int x) {
+    /* Function should get both KCFI preamble and patchable entries */
+}
+
+int main() {
+    test_function(42);
+    return 0;
+}
+
+/* Should have KCFI preamble */
+/* { dg-final { scan-assembler "__cfi_test_function:" } } */
+
+/* Should have patchable function entry section */
+/* { dg-final { scan-assembler "__patchable_function_entries" } } */
+
+/* x86_64: Should have exactly 2 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*\.type} { target x86_64-*-* } } } */
+
+/* x86_64: Should have exactly 3 entry NOPs between .cfi_startproc and pushq */
+/* { dg-final { scan-assembler {\.cfi_startproc\n\t*nop\n\t*nop\n\t*nop\n\t*pushq} { target x86_64-*-* } } } */
+
+/* x86_64: KCFI should have exactly 9 NOPs between __cfi_ and movl */
+/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*movl} { target x86_64-*-* } } } */
+
+/* x86_64: Validate KCFI type ID is present */
+/* { dg-final { scan-assembler {movl\t\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
+
+/* AArch64: Should have exactly 2 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*\.type} { target aarch64*-*-* } } } */
+
+/* AArch64: Should have exactly 3 entry NOPs between .cfi_startproc and sub sp */
+/* { dg-final { scan-assembler {\.cfi_startproc\n\t*nop\n\t*nop\n\t*nop\n\t*sub\t*sp} { target aarch64*-*-* } } } */
+
+/* AArch64: KCFI should have only .word immediate (no NOPs) */
+/* { dg-final { scan-assembler {__cfi_test_function:\n\t\.word 0x[0-9a-f]+} { target aarch64*-*-* } } } */
+
+/* AArch64: Validate clean KCFI boundary - .word then immediate end/size */
+/* { dg-final { scan-assembler {\.word 0x[0-9a-f]+\n\.Lcfi_func_end_test_function:\n\t\.size\t__cfi_test_function, \.-__cfi_test_function} { target aarch64*-*-* } } } */
+
+/* RISC-V: Should have exactly 2 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*\.type} { target riscv*-*-* } } } */
+
+/* RISC-V: Should have exactly 3 entry NOPs before .cfi_startproc followed by addi sp */
+/* { dg-final { scan-assembler {nop\n\t*nop\n\t*nop\n\.LFB[0-9]+:\n\t*\.cfi_startproc\n\t*addi\t*sp} { target riscv*-*-* } } } */
+
+/* RISC-V: KCFI should have only .word immediate (no NOPs) */
+/* { dg-final { scan-assembler {__cfi_test_function:\n\t\.word\t0x[0-9a-f]+} { target riscv*-*-* } } } */
+
+/* RISC-V: Validate clean KCFI boundary - .word then immediate end/size */
+/* { dg-final { scan-assembler {\.word\t0x[0-9a-f]+\n\.Lcfi_func_end_test_function:\n\t\.size\t__cfi_test_function, \.-__cfi_test_function} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
new file mode 100644
index 000000000000..68a42dd32995
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
@@ -0,0 +1,36 @@
+/* Test KCFI with patchable function entries - entry NOPs only */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -fpatchable-function-entry=4,0" } */
+
+void test_function(void) {
+    /* All NOPs are entry NOPs, no prefix NOPs for KCFI */
+}
+
+int main() {
+    test_function();
+    return 0;
+}
+
+/* Should NOT have KCFI preamble (no prefix NOPs) */
+/* { dg-final { scan-assembler-not "__cfi_test_function:" } } */
+
+/* x86_64: All 4 NOPs are entry NOPs - should have exactly 4 entry NOPs */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*pushq} { target x86_64-*-* } } } */
+
+/* x86_64: No prefix NOPs - function type should come immediately before function */
+/* { dg-final { scan-assembler {\.type\t*test_function, @function\n*test_function:} { target x86_64-*-* } } } */
+
+/* AArch64: All 4 NOPs are entry NOPs - should have exactly 4 entry NOPs */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*stp} { target aarch64*-*-* } } } */
+
+/* AArch64: No prefix NOPs - function type should come immediately before function */
+/* { dg-final { scan-assembler {\.type\t*test_function, %function\n*test_function:} { target aarch64*-*-* } } } */
+
+/* RISC-V: All 4 NOPs are entry NOPs */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\.LFB} { target riscv*-*-* } } } */
+
+/* RISC-V: No prefix NOPs - function type should come immediately before function */
+/* { dg-final { scan-assembler {\.type\t*test_function, @function\n*test_function:} { target riscv*-*-* } } } */
+
+/* Should have patchable function entry section */
+/* { dg-final { scan-assembler "__patchable_function_entries" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
new file mode 100644
index 000000000000..015b021b9a0a
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -0,0 +1,47 @@
+/* Test KCFI with large patchable function entries */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -fpatchable-function-entry=11,11" } */
+
+void test_function(void) {
+    /* 11 prefix NOPs, 0 entry NOPs - maximum prefix case */
+}
+
+int main() {
+    void (*func_ptr)(void) = test_function;
+    func_ptr(); /* Call site should use -(11+4) = -15 offset */
+    return 0;
+}
+
+/* Should have KCFI preamble */
+/* { dg-final { scan-assembler "__cfi_test_function:" } } */
+
+/* Should have patchable function entry section */
+/* { dg-final { scan-assembler "__patchable_function_entries" } } */
+
+/* x86_64: Should have exactly 11 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} { target x86_64-*-* } } } */
+
+/* x86_64: Should have 0 entry NOPs - function starts immediately with pushq (no __kcfi_typeid for definitions) */
+/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_startproc\n\t*pushq\t*%rbp} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_function\n} { target x86_64-*-* } } } */
+
+/* x86_64: KCFI should have 0 NOPs - goes directly to movl (offsetToAlignment(11+5,16)=0) */
+/* { dg-final { scan-assembler {__cfi_test_function:\n\t*movl} { target x86_64-*-* } } } */
+
+/* x86_64: Validate KCFI type ID is present */
+/* { dg-final { scan-assembler {movl\t\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
+
+/* x86_64: Call site should use -15 offset (kernel-style encoding) */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-15\(%r[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
+
+/* AArch64: Should have exactly 11 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} { target aarch64*-*-* } } } */
+
+/* AArch64: Call site should use -15 offset */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-15\]} { target aarch64*-*-* } } } */
+
+/* RISC-V: Should have 11 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} { target riscv*-*-* } } } */
+
+/* RISC-V: Call site should use -15 offset (same as x86/AArch64) */
+/* { dg-final { scan-assembler {lw\tt1, -15\(} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
new file mode 100644
index 000000000000..e6922cf81355
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -0,0 +1,52 @@
+/* Test KCFI with medium patchable function entries */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -fpatchable-function-entry=8,4" } */
+
+void test_function(void) {
+    /* 4 prefix NOPs, 4 entry NOPs - should affect KCFI offset */
+}
+
+int main() {
+    void (*func_ptr)(void) = test_function;
+    func_ptr(); /* Call site should use -(4+4) = -8 offset */
+    return 0;
+}
+
+/* Should have KCFI preamble */
+/* { dg-final { scan-assembler "__cfi_test_function:" } } */
+
+/* Should have patchable function entry section */
+/* { dg-final { scan-assembler "__patchable_function_entries" } } */
+
+/* x86_64: Should have exactly 4 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} { target x86_64-*-* } } } */
+
+/* x86_64: Should have exactly 4 entry NOPs between .cfi_startproc and pushq */
+/* { dg-final { scan-assembler {\.cfi_startproc\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*pushq} { target x86_64-*-* } } } */
+
+/* x86_64: KCFI should have exactly 7 NOPs between __cfi_ and movl (offsetToAlignment(4+5,16)=7) */
+/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*movl} { target x86_64-*-* } } } */
+
+/* x86_64: Validate KCFI type ID is present */
+/* { dg-final { scan-assembler {movl\t\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
+
+/* x86_64: Call site should use -8 offset (kernel-style encoding) */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-8\(%r[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
+
+/* AArch64: Should have exactly 4 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} { target aarch64*-*-* } } } */
+
+/* AArch64: Should have exactly 4 entry NOPs after .cfi_startproc */
+/* { dg-final { scan-assembler {\.cfi_startproc\n\t*nop\n\t*nop\n\t*nop\n\t*nop} { target aarch64*-*-* } } } */
+
+/* AArch64: Call site should use -8 offset */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-8\]} { target aarch64*-*-* } } } */
+
+/* RISC-V: Should have exactly 4 prefix NOPs between .LPFE and .type */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} { target riscv*-*-* } } } */
+
+/* RISC-V: Should have 4 entry NOPs */
+/* { dg-final { scan-assembler {test_function:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\.LFB} { target riscv*-*-* } } } */
+
+/* RISC-V: Call site should use -8 offset (same as x86/AArch64) */
+/* { dg-final { scan-assembler {lw\tt1, -8\(} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-none.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-none.c
new file mode 100644
index 000000000000..01a611ca754d
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-none.c
@@ -0,0 +1,18 @@
+/* Test KCFI without patchable function entries - standard case */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi" } */
+
+void test_function(void) {
+    /* Standard KCFI without patchable entries */
+}
+
+int main() {
+    test_function();
+    return 0;
+}
+
+/* Should have KCFI preamble */
+/* { dg-final { scan-assembler "__cfi_test_function:" } } */
+
+/* Should NOT have patchable function entry section */
+/* { dg-final { scan-assembler-not "__patchable_function_entries" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
new file mode 100644
index 000000000000..5a500f3a8ea9
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -0,0 +1,48 @@
+/* Test KCFI with patchable function entries - prefix NOPs only */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -fpatchable-function-entry=3,3" } */
+
+void test_function(void) {
+    /* All NOPs are prefix NOPs, should integrate with KCFI */
+}
+
+int main() {
+    test_function();
+    return 0;
+}
+
+/* Should have KCFI preamble */
+/* { dg-final { scan-assembler "__cfi_test_function:" } } */
+
+/* x86_64: All 3 NOPs are prefix NOPs - should have exactly 3 prefix NOPs */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*\.type\t*test_function} { target x86_64-*-* } } } */
+
+/* x86_64: No entry NOPs - function should start immediately with prologue (no __kcfi_typeid for definitions) */
+/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_startproc\n\t*pushq\t*%rbp} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_function\n} { target x86_64-*-* } } } */
+
+/* x86_64: KCFI padding should have exactly 8 NOPs (offsetToAlignment(3+5,16)=8) */
+/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*movl} { target x86_64-*-* } } } */
+
+/* AArch64: All 3 NOPs are prefix NOPs - should have exactly 3 prefix NOPs */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*\.type\t*test_function} { target aarch64*-*-* } } } */
+
+/* AArch64: No entry NOPs - function should start immediately with prologue (no __kcfi_typeid for definitions) */
+/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_startproc\n\t*nop\n\t*ret} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_function\n} { target aarch64*-*-* } } } */
+
+/* AArch64: KCFI type ID should be immediate word (no alignment NOPs needed) */
+/* { dg-final { scan-assembler {__cfi_test_function:\n\t\.word 0x[0-9a-f]+} { target aarch64*-*-* } } } */
+
+/* RISC-V: All 3 NOPs are prefix NOPs - should have exactly 3 prefix NOPs */
+/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\t*\.type\t*test_function} { target riscv*-*-* } } } */
+
+/* RISC-V: No entry NOPs - function should start immediately with .cfi_startproc */
+/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_startproc} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_function\n} { target riscv*-*-* } } } */
+
+/* RISC-V: KCFI type ID should be immediate word */
+/* { dg-final { scan-assembler {__cfi_test_function:\n\t\.word\t0x[0-9a-f]+} { target riscv*-*-* } } } */
+
+/* Should have patchable function entry section */
+/* { dg-final { scan-assembler "__patchable_function_entries" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c
new file mode 100644
index 000000000000..d6c580e1e502
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c
@@ -0,0 +1,98 @@
+/* Test KCFI with position-independent code addressing modes */
+/* This is a regression test for complex addressing like PLUS(PLUS(...), symbol_ref) */
+/* which can occur with PIC and caused change_address_1 RTL errors */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -O2 -fpic" } */
+
+/* Global function pointer table that creates PIC addressing */
+struct callbacks {
+    int (*handler1)(int);
+    void (*handler2)(void);
+    int (*handler3)(int, int);
+};
+
+static int simple_handler(int x) {
+    return x * 2;
+}
+
+static void void_handler(void) {
+    /* Empty handler */
+}
+
+static int complex_handler(int a, int b) {
+    return a + b;
+}
+
+/* Global structure that will require PIC addressing */
+struct callbacks global_callbacks = {
+    .handler1 = simple_handler,
+    .handler2 = void_handler,
+    .handler3 = complex_handler
+};
+
+/* Function that uses PIC addressing to access global callbacks */
+int test_pic_addressing(int value) {
+    /* These indirect calls through global structure create complex addressing
+     * like PLUS(PLUS(GOT_base, symbol_offset), struct_offset) which previously
+     * caused RTL errors in KCFI instrumentation */
+
+    int result = 0;
+    result += global_callbacks.handler1(value);
+
+    global_callbacks.handler2();
+
+    result += global_callbacks.handler3(value, result);
+
+    return result;
+}
+
+/* Test with function pointer arrays */
+static int (*func_array[])(int) = {
+    simple_handler,
+    simple_handler,
+    simple_handler
+};
+
+int test_pic_array(int index, int value) {
+    /* Array access with PIC can also create complex addressing */
+    return func_array[index % 3](value);
+}
+
+/* Test with dynamic PIC addressing */
+struct callbacks *get_callbacks(void) {
+    return &global_callbacks;
+}
+
+int test_dynamic_pic(int value) {
+    /* Dynamic access through function call creates very complex addressing */
+    struct callbacks *cb = get_callbacks();
+    return cb->handler1(value) + cb->handler3(value, value);
+}
+
+int main() {
+    int result = 0;
+    result += test_pic_addressing(10);
+    result += test_pic_array(1, 20);
+    result += test_dynamic_pic(5);
+    return result;
+}
+
+/* Verify that all address-taken functions get KCFI preambles */
+/* { dg-final { scan-assembler {__cfi_simple_handler:} } } */
+/* { dg-final { scan-assembler {__cfi_void_handler:} } } */
+/* { dg-final { scan-assembler {__cfi_complex_handler:} } } */
+
+/* x86_64: Verify KCFI checks are generated (should compile without RTL errors, kernel-style encoding) */
+/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {ud2} { target x86_64-*-* } } } */
+
+/* AArch64: Verify KCFI checks */
+/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler {brk} { target aarch64*-*-* } } } */
+
+/* RISC-V: Verify complete KCFI check sequence */
+/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, \.L[a-zA-Z0-9_]+\n\.L[a-zA-Z0-9_]+:\n\tebreak} { target riscv*-*-* } } } */
+
+/* Should have trap section */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
new file mode 100644
index 000000000000..7b8877de4254
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
@@ -0,0 +1,111 @@
+/* Test KCFI protection when indirect calls get converted to tail calls */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+typedef int (*func_ptr_t)(int);
+typedef void (*void_func_ptr_t)(void);
+
+struct function_table {
+    func_ptr_t process;
+    void_func_ptr_t cleanup;
+};
+
+/* Target functions */
+int process_data(int x) { return x * 2; }
+void cleanup_data(void) {}
+
+/* Initialize function table */
+volatile struct function_table vtable = {
+    .process = &process_data,
+    .cleanup = &cleanup_data
+};
+
+/* Test 1: Indirect call through struct member that should become tail call */
+int test_struct_indirect_call(int x) {
+    /* This is an indirect call that should be converted to tail call:
+     * Without -fno-optimize-sibling-calls: should become "jmp *vtable+0(%rip)" with KCFI
+     * With -fno-optimize-sibling-calls: should be "call *vtable+0(%rip)" with KCFI */
+    return vtable.process(x);
+}
+
+/* Test 2: Indirect call through function pointer parameter */
+int test_param_indirect_call(func_ptr_t handler, int x) {
+    /* This is an indirect call that should be converted to tail call:
+     * Without -fno-optimize-sibling-calls: should become "jmp *%rdi" with KCFI
+     * With -fno-optimize-sibling-calls: should be "call *%rdi" with KCFI */
+    return handler(x);
+}
+
+/* Test 3: Void indirect call through struct member */
+void test_void_indirect_call(void) {
+    /* This is an indirect call that should be converted to tail call:
+     * Without -fno-optimize-sibling-calls: should become "jmp *vtable+8(%rip)" with KCFI
+     * With -fno-optimize-sibling-calls: should be "call *vtable+8(%rip)" with KCFI */
+    vtable.cleanup();
+}
+
+/* Test 4: Non-tail call for comparison (should always be call with KCFI) */
+int test_non_tail_indirect_call(func_ptr_t handler, int x) {
+    /* This should never become a tail call - always "call *%rdi" with KCFI */
+    int result = handler(x);
+    return result + 1;  /* Prevents tail call optimization */
+}
+
+/* Should have KCFI preambles for all functions (same for both architectures) */
+/* { dg-final { scan-assembler-times "__cfi_process_data:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_cleanup_data:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_test_struct_indirect_call:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_test_param_indirect_call:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_test_void_indirect_call:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_test_non_tail_indirect_call:" 1 } } */
+
+/* Should have exactly 4 KCFI checks for indirect calls (load type ID + compare) */
+/* { dg-final { scan-assembler-times {movl\t\$-?[0-9]+, %r10d} 4 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {addl\t-4\(%r[a-z0-9]+\), %r10d} 4 { target x86_64-*-* } } } */
+
+/* Should have exactly 4 trap sections and 4 trap instructions */
+/* { dg-final { scan-assembler-times "\\.kcfi_traps" 4 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times "ud2" 4 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times "\\.kcfi_traps" 4 { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-times "ebreak" 4 { target riscv*-*-* } } } */
+
+/* Should NOT have unprotected direct jumps to vtable */
+/* { dg-final { scan-assembler-not {jmp\t\*vtable\(%rip\)} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-not {jmp\t\*vtable\+8\(%rip\)} { target x86_64-*-* } } } */
+
+/* Should have exactly 3 protected tail calls (jmp through register after KCFI check) */
+/* { dg-final { scan-assembler-times {jmp\t\*%[a-z0-9]+} 3 { target x86_64-*-* } } } */
+
+/* Should have exactly 1 regular call (non-tail call case) */
+/* { dg-final { scan-assembler-times {call\t\*%[a-z0-9]+} 1 { target x86_64-*-* } } } */
+
+/* RISC-V: Should have exactly 4 complete KCFI check sequences */
+/* { dg-final { scan-assembler-times {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, \.L[a-zA-Z0-9_]+\n\.L[a-zA-Z0-9_]+:\n\tebreak} 4 { target riscv*-*-* } } } */
+
+/* RISC-V: Should have exactly 4 KCFI checks for indirect calls (load type ID + compare) */
+/* { dg-final { scan-assembler-times {lw\tt1, -4\([a-z0-9]+\)} 4 { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-times {lui\tt2, [0-9]+} 4 { target riscv*-*-* } } } */
+
+/* RISC-V: Should have exactly 3 protected tail calls (jr after KCFI check - no return address save) */
+/* { dg-final { scan-assembler-times {jalr\tx0, [a-z0-9]+, 0} 3 { target riscv*-*-* } } } */
+
+/* RISC-V: Should have exactly 1 regular call (non-tail call case - saves return address) */
+/* { dg-final { scan-assembler-times {jalr\tx1, [a-z0-9]+, 0} 1 { target riscv*-*-* } } } */
+
+/* AArch64-specific patterns */
+/* Should have exactly 4 KCFI checks for indirect calls (load type ID from -4 offset + compare) */
+/* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 4 { target aarch64-*-* } } } */
+/* { dg-final { scan-assembler-times {cmp\tw16, w17} 4 { target aarch64-*-* } } } */
+
+/* Should have exactly 4 trap instructions */
+/* { dg-final { scan-assembler-times {brk\t#[0-9]+} 4 { target aarch64-*-* } } } */
+
+/* Should have exactly 3 protected tail calls (br through register after KCFI check) */
+/* { dg-final { scan-assembler-times {br\tx[0-9]+} 3 { target aarch64-*-* } } } */
+
+/* Should have exactly 1 regular call (non-tail call case) */
+/* { dg-final { scan-assembler-times {blr\tx[0-9]+} 1 { target aarch64-*-* } } } */
+
+/* Type ID loading should use mov + movk pattern for 32-bit constants */
+/* { dg-final { scan-assembler {mov\tw17, #[0-9]+} { target aarch64-*-* } } } */
+/* { dg-final { scan-assembler {movk\tw17, #[0-9]+, lsl #16} { target aarch64-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
new file mode 100644
index 000000000000..8b0c4819e11b
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
@@ -0,0 +1,56 @@
+/* Test KCFI trap section generation */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi" } */
+
+void target_function(void) {}
+
+int main() {
+    void (*func_ptr)(void) = target_function;
+
+    /* Multiple indirect calls to generate trap entries */
+    func_ptr();
+    func_ptr();
+
+    return 0;
+}
+
+/* Should have KCFI preamble */
+/* { dg-final { scan-assembler "__cfi_target_function:" } } */
+
+/* Should have exactly 2 trap labels in code */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*brk} 2 { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ebreak} 2 { target riscv*-*-* } } } */
+
+/* Should have .kcfi_traps section with exactly 2 entries (x86 and RISC-V - AArch64 uses brk immediate) */
+/* { dg-final { scan-assembler {\.pushsection\t*\.kcfi_traps,"ao",@progbits,\.text} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {\.L[^:]+:\n\t*\.long} 2 { target x86_64-*-* } } } */
+
+/* AArch64 should NOT have .kcfi_traps section (uses brk immediate instead) */
+/* { dg-final { scan-assembler-not {\.pushsection\t*\.kcfi_traps} { target aarch64*-*-* } } } */
+/* { dg-final { scan-assembler-not {\.L[^:]+:\n\t*\.long} { target aarch64*-*-* } } } */
+
+/* Each section entry must reference its corresponding trap label directly (x86 and RISC-V) */
+/* Entry references trap label directly (no offset needed) */
+/* { dg-final { scan-assembler {\.L([^:]+):\n\t*\.long\t*\.L([^\s]+)\s+-\s+\.L\1} { target x86_64-*-* } } } */
+
+/* RISC-V: Should have .kcfi_traps section with exactly 2 entries */
+/* { dg-final { scan-assembler {\.pushsection\t*\.kcfi_traps,"ao",@progbits,\.text} { target riscv*-*-* } } } */
+/* { dg-final { scan-assembler-times {\.Lkcfi_trap_entry_[0-9]+:\n\t*\.word} 2 { target riscv*-*-* } } } */
+
+/* AArch64 should NOT have RISC-V-style .kcfi_traps section entries */
+/* { dg-final { scan-assembler-not {\.Lkcfi_trap_entry_[0-9]+:\n\t*\.word} { target aarch64*-*-* } } } */
+
+/* RISC-V section entries must reference their corresponding trap labels */
+/* Entry references trap label directly (no offset needed) */
+/* { dg-final { scan-assembler {\.Lkcfi_trap_entry_([0-9]+):\n\t*\.word\t*\.Lkcfi_trap_\1\s+-\s+\.Lkcfi_trap_entry_\1} { target riscv*-*-* } } } */
+
+/* AArch64 should NOT have RISC-V-style trap label references */
+/* { dg-final { scan-assembler-not {\.Lkcfi_trap_entry_([0-9]+):\n\t*\.word\t*\.Lkcfi_trap_\1} { target aarch64*-*-* } } } */
+
+/* Section must be properly closed (x86 and RISC-V) */
+/* { dg-final { scan-assembler {\.popsection} { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler {\.popsection} { target riscv*-*-* } } } */
+
+/* AArch64 should NOT have .popsection (no .kcfi_traps section to close) */
+/* { dg-final { scan-assembler-not {\.popsection} { target aarch64*-*-* } } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-type-mangling.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-type-mangling.c
new file mode 100644
index 000000000000..36cdfd3ed890
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-type-mangling.c
@@ -0,0 +1,864 @@
+/* Test KCFI type ID hashing - verify different signatures generate different __kcfi_typeid_ symbols */
+/* { dg-do compile } */
+/* { dg-options "-fsanitize=kcfi -fdump-tree-kcfi0-details" } */
+
+/* Test __kcfi_typeid_ symbol generation for address-taken functions.
+   Verify precise type discrimination using Itanium C++ ABI mangling. */
+
+/* External function declarations - these will get __kcfi_typeid_ symbols when address-taken */
+extern void func_void(void);                    /* FvvE -> 0x68d6d5b6 */
+extern void func_char(char x);                  /* FvcE -> 0x14f227f7 */
+extern void func_int(int x);                    /* FviE -> 0x28e33ce9 */
+extern void func_long(long x);                  /* FvlE -> 0x64f06750 */
+
+/* Basic types - verify exact type IDs match with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_void\n\t\.set\t__kcfi_typeid_func_void, 0x68d6d5b6} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_char\n\t\.set\t__kcfi_typeid_func_char, 0x14f227f7} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_int\n\t\.set\t__kcfi_typeid_func_int, 0x28e33ce9} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_long\n\t\.set\t__kcfi_typeid_func_long, 0x64f06750} } } */
+
+/* Verify basic types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvvE' typeid=0x68d6d5b6} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvcE' typeid=0x14f227f7} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFviE' typeid=0x28e33ce9} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvlE' typeid=0x64f06750} kcfi0 } } */
+
+/* Count verification - basic types (void type used by multiple functions) */
+/* { dg-final { scan-assembler-times {0x68d6d5b6} 2 } } +1 from local_func_void preamble below */
+/* { dg-final { scan-assembler-times {0x14f227f7} 1 } } */
+/* { dg-final { scan-assembler-times {0x28e33ce9} 1 } } */
+/* { dg-final { scan-assembler-times {0x64f06750} 1 } } */
+
+/* Pointer parameter types - must all differ */
+extern void func_int_ptr(int *x);               /* FvPiE -> 0x6d478137 */
+extern void func_char_ptr(char *x);             /* FvPcE -> 0x81389629 */
+extern void func_void_ptr(void *x);             /* FvPvE -> 0x5d1c8700 */
+
+/* Pointer types - verify they all differ with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_int_ptr\n\t\.set\t__kcfi_typeid_func_int_ptr, 0x6d478137} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_char_ptr\n\t\.set\t__kcfi_typeid_func_char_ptr, 0x81389629} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_void_ptr\n\t\.set\t__kcfi_typeid_func_void_ptr, 0x5d1c8700} } } */
+
+/* Verify pointer types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPiE' typeid=0x6d478137} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPcE' typeid=0x81389629} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPvE' typeid=0x5d1c8700} kcfi0 } } */
+
+/* Count verification - pointer types (will appear twice due to array decay earlier) */
+/* { dg-final { scan-assembler-times {0x6d478137} 2 } } */
+/* { dg-final { scan-assembler-times {0x81389629} 2 } } */
+/* { dg-final { scan-assembler-times {0x5d1c8700} 1 } } */
+
+/* Const qualifier discrimination - const vs non-const must have different type IDs */
+extern void func_const_int_ptr(const int *x);   /* FvPKiE -> const int* (must differ from int*) */
+extern void func_const_char_ptr(const char *x); /* FvPKcE -> const char* (must differ from char*) */
+extern void func_const_void_ptr(const void *x); /* FvPKvE -> const void* (must differ from void*) */
+
+/* Const qualifier types - verify const vs non-const have different type IDs */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_const_int_ptr\n\t\.set\t__kcfi_typeid_func_const_int_ptr, 0xcc6626a0} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_const_char_ptr\n\t\.set\t__kcfi_typeid_func_const_char_ptr, 0xb0750516} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_const_void_ptr\n\t\.set\t__kcfi_typeid_func_const_void_ptr, 0xdc8f8dd7} } } */
+
+/* Verify const qualifier types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPKiE' typeid=0xcc6626a0} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPKcE' typeid=0xb0750516} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPKvE' typeid=0xdc8f8dd7} kcfi0 } } */
+
+/* Count verification - const qualifier types should appear exactly once */
+/* { dg-final { scan-assembler-times {0xcc6626a0} 1 } } */
+/* { dg-final { scan-assembler-times {0xb0750516} 1 } } */
+/* { dg-final { scan-assembler-times {0xdc8f8dd7} 1 } } */
+
+/* Nested pointer types */
+extern void func_int_ptr_ptr(int **x);          /* FvPPiE -> 0x3d62bef1 */
+extern void func_char_ptr_ptr(char **x);        /* FvPPcE -> 0x494939ef */
+
+/* Nested pointers with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_int_ptr_ptr\n\t\.set\t__kcfi_typeid_func_int_ptr_ptr, 0x3d62bef1} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_char_ptr_ptr\n\t\.set\t__kcfi_typeid_func_char_ptr_ptr, 0x494939ef} } } */
+
+/* Verify nested pointer types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPPiE' typeid=0x3d62bef1} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPPcE' typeid=0x494939ef} kcfi0 } } */
+
+/* Count verification - nested pointer types should appear exactly once */
+/* { dg-final { scan-assembler-times {0x3d62bef1} 1 } } */
+/* { dg-final { scan-assembler-times {0x494939ef} 1 } } */
+
+/* Multiple parameter types - order matters */
+extern void func_int_char(int x, char y);       /* FvicE -> 0x0e0cb81e */
+extern void func_char_int(char x, int y);       /* FvciE -> 0xab661a02 */
+extern void func_two_int(int x, int y);         /* FviiE -> 0x0a2649b8 */
+
+/* Multiple parameter tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_int_char\n\t\.set\t__kcfi_typeid_func_int_char, 0x0e0cb81e} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_char_int\n\t\.set\t__kcfi_typeid_func_char_int, 0xab661a02} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_two_int\n\t\.set\t__kcfi_typeid_func_two_int, 0x0a2649b8} } } */
+
+/* Verify multiple parameter types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvicE' typeid=0x0e0cb81e} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvciE' typeid=0xab661a02} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFviiE' typeid=0x0a2649b8} kcfi0 } } */
+
+/* Count verification - multiple parameter types should appear exactly once */
+/* { dg-final { scan-assembler-times {0x0e0cb81e} 1 } } */
+/* { dg-final { scan-assembler-times {0xab661a02} 1 } } */
+/* { dg-final { scan-assembler-times {0x0a2649b8} 1 } } */
+
+/* Return types */
+extern int func_return_int(void);               /* FivE -> 0x426f60ef */
+extern char func_return_char(void);             /* FcvE -> 0x3688e5f1 */
+extern void* func_return_ptr(void);             /* FPvvE -> 0x924cfbe6 */
+
+/* Return type tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_return_int\n\t\.set\t__kcfi_typeid_func_return_int, 0x4193590b} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_return_char\n\t\.set\t__kcfi_typeid_func_return_char, 0xe340f049} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_return_ptr\n\t\.set\t__kcfi_typeid_func_return_ptr, 0xa8267e10} } } */
+
+/* Verify return types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFivE' typeid=0x4193590b} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFcvE' typeid=0xe340f049} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFPvvE' typeid=0xa8267e10} kcfi0 } } */
+
+/* Count verification - return types should appear exactly once */
+/* { dg-final { scan-assembler-times {0x4193590b} 1 } } */
+/* { dg-final { scan-assembler-times {0xe340f049} 1 } } */
+/* { dg-final { scan-assembler-times {0xa8267e10} 1 } } */
+
+/* Array parameters - decay to pointers */
+extern void func_int_array(int arr[]);          /* FvPiE -> 0x6d478137 (same as int*) */
+extern void func_char_array(char arr[]);        /* FvPcE -> 0x81389629 (same as char*) */
+
+/* Array decay validation - arrays should have SAME type ID as corresponding pointers */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_int_array\n\t\.set\t__kcfi_typeid_func_int_array, 0x6d478137} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_char_array\n\t\.set\t__kcfi_typeid_func_char_array, 0x81389629} } } */
+/* Counted below. */
+
+/* Function pointer parameters */
+extern void func_fptr_void(void (*fp)(void));   /* FvPFvvEE -> 0xbe908da1 */
+extern void func_fptr_int(void (*fp)(int));     /* FvPFviEE -> 0x8f3bc4fe */
+extern void func_fptr_ret_int(int (*fp)(void)); /* FvPFivEE -> 0xdcab0e2c */
+
+/* Function pointer parameter tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_fptr_void\n\t\.set\t__kcfi_typeid_func_fptr_void, 0x5f78c457} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_fptr_int\n\t\.set\t__kcfi_typeid_func_fptr_int, 0x8f3bc4fe} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_fptr_ret_int\n\t\.set\t__kcfi_typeid_func_fptr_ret_int, 0x5993cc14} } } */
+
+/* Verify function pointer parameter types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPFvvEE' typeid=0x5f78c457} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPFviEE' typeid=0x8f3bc4fe} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPFivEE' typeid=0x5993cc14} kcfi0 } } */
+
+/* Count verification - function pointer parameter types should appear exactly once */
+/* { dg-final { scan-assembler-times {0x5f78c457} 1 } } */
+/* { dg-final { scan-assembler-times {0x8f3bc4fe} 1 } } */
+/* { dg-final { scan-assembler-times {0x5993cc14} 1 } } */
+
+/* Struct/union/enum parameter types: each struct name must produce different type IDs */
+struct test_struct_a { int x; };
+struct test_struct_b { int y; };
+struct test_struct_c { int z; };
+union test_union_a { int i; float f; };
+union test_union_b { int j; float g; };
+enum test_enum_a { ENUM_A_VAL1, ENUM_A_VAL2 };
+enum test_enum_b { ENUM_B_VAL1, ENUM_B_VAL2 };
+
+/* Functions taking struct pointers - must have different type IDs */
+extern void func_struct_a_ptr(struct test_struct_a *x);  /* Fv14test_struct_aPiE -> unique */
+extern void func_struct_b_ptr(struct test_struct_b *x);  /* Fv14test_struct_bPiE -> unique */
+extern void func_struct_c_ptr(struct test_struct_c *x);  /* Fv14test_struct_cPiE -> unique */
+
+/* Struct pointer tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_a_ptr\n\t\.set\t__kcfi_typeid_func_struct_a_ptr, 0x778e8c02} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_b_ptr\n\t\.set\t__kcfi_typeid_func_struct_b_ptr, 0x1791c679} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_c_ptr\n\t\.set\t__kcfi_typeid_func_struct_c_ptr, 0x43944a54} } } */
+
+/* Verify struct pointer types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP13test_struct_aE' typeid=0x778e8c02} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP13test_struct_bE' typeid=0x1791c679} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP13test_struct_cE' typeid=0x43944a54} kcfi0 } } */
+
+/* Count verification - struct pointer types should appear exactly once */
+/* { dg-final { scan-assembler-times {0x778e8c02} 1 } } */
+/* { dg-final { scan-assembler-times {0x1791c679} 1 } } */
+/* { dg-final { scan-assembler-times {0x43944a54} 1 } } */
+
+/* Functions taking const struct pointers - must differ from non-const versions */
+extern void func_const_struct_a_ptr(const struct test_struct_a *x);  /* FvPK14test_struct_aE -> unique, different from non-const */
+extern void func_const_struct_b_ptr(const struct test_struct_b *x);  /* FvPK14test_struct_bE -> unique, different from non-const */
+extern void func_const_struct_c_ptr(const struct test_struct_c *x);  /* FvPK14test_struct_cE -> unique, different from non-const */
+
+/* Const struct pointer tests with precise patterns - must differ from non-const */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_const_struct_a_ptr\n\t\.set\t__kcfi_typeid_func_const_struct_a_ptr, 0x763752c9} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_const_struct_b_ptr\n\t\.set\t__kcfi_typeid_func_const_struct_b_ptr, 0x5634e1d2} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_const_struct_c_ptr\n\t\.set\t__kcfi_typeid_func_const_struct_c_ptr, 0x32326a8f} } } */
+
+/* Verify const struct pointer types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPK13test_struct_aE' typeid=0x763752c9} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPK13test_struct_bE' typeid=0x5634e1d2} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvPK13test_struct_cE' typeid=0x32326a8f} kcfi0 } } */
+
+/* Count verification - const struct pointer types should appear exactly once */
+/* { dg-final { scan-assembler-times {0x763752c9} 1 } } */
+/* { dg-final { scan-assembler-times {0x5634e1d2} 1 } } */
+/* { dg-final { scan-assembler-times {0x32326a8f} 1 } } */
+
+extern void func_union_a_ptr(union test_union_a *x);     /* Fv13test_union_aPiE -> unique */
+extern void func_union_b_ptr(union test_union_b *x);     /* Fv13test_union_bPiE -> unique */
+extern void func_enum_a_ptr(enum test_enum_a *x);        /* Fv11test_enum_aPiE -> unique */
+extern void func_enum_b_ptr(enum test_enum_b *x);        /* Fv11test_enum_bPiE -> unique */
+
+/* Union member access discrimination test - prevents regression of union member bug */
+struct tasklet_like_struct {
+    int state;
+    union {
+	/* First union member - should NOT be used for callback calls */
+        void (*func)(unsigned long data);
+	/* Second union member - should be used for callback calls */
+        void (*callback)(struct tasklet_like_struct *t);
+    };
+    unsigned long data;
+};
+
+/* Function with callback signature - this should match when accessed via union->callback */
+extern void tasklet_callback_function(struct tasklet_like_struct *t);  /* FvP19tasklet_like_structE -> unique */
+
+/* Function with func signature - this should NOT match callback calls */
+extern void tasklet_func_function(unsigned long data);                  /* FvmE -> different from callback */
+
+/* Union member access discrimination tests - MUST use correct union member type */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_tasklet_callback_function\n\t\.set\t__kcfi_typeid_tasklet_callback_function, 0x5634f4ec} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_tasklet_func_function\n\t\.set\t__kcfi_typeid_tasklet_func_function, 0x48edfca5} } } */
+
+/* Verify union member discrimination tests */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP19tasklet_like_structE' typeid=0x5634f4ec} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvmE' typeid=0x48edfca5} kcfi0 } } */
+
+/* Union pointer tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_union_a_ptr\n\t\.set\t__kcfi_typeid_func_union_a_ptr, 0xb03d9275} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_union_b_ptr\n\t\.set\t__kcfi_typeid_func_union_b_ptr, 0x003a3ece} } } */
+
+/* Verify union pointer types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP12test_union_aE' typeid=0xb03d9275} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP12test_union_bE' typeid=0x003a3ece} kcfi0 } } */
+
+/* Count verification - union pointer types should appear exactly once */
+/* { dg-final { scan-assembler-times {0xb03d9275} 1 } } */
+/* { dg-final { scan-assembler-times {0x003a3ece} 1 } } */
+
+/* Enum pointer tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_enum_a_ptr\n\t\.set\t__kcfi_typeid_func_enum_a_ptr, 0x9a32df78} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_enum_b_ptr\n\t\.set\t__kcfi_typeid_func_enum_b_ptr, 0xaa2c3ce3} } } */
+
+/* Verify enum pointer types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP11test_enum_aE' typeid=0x9a32df78} kcfi0 } } */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP11test_enum_bE' typeid=0xaa2c3ce3} kcfi0 } } */
+
+/* Count verification - enum pointer types should appear exactly once */
+/* { dg-final { scan-assembler-times {0x9a32df78} 1 } } */
+/* { dg-final { scan-assembler-times {0xaa2c3ce3} 1 } } */
+
+/* Count verification - union member discrimination types should appear exactly once */
+/* The key test is that callback and func functions have DIFFERENT type IDs, proving union member discrimination works */
+/* { dg-final { scan-assembler-times {0x5634f4ec} 1 } } */
+/* { dg-final { scan-assembler-times {0x48edfca5} 1 } } */
+
+/* Indirect call through t->callback union must use correct callback type ID (0x5634f4ec).
+   The decimal value -1446311148 is the two's complement of 0x5634f4ec used in KCFI checks.  */
+/* { dg-final { scan-assembler-times {\tmovl\t\$-1446311148, %r10d} 1 { target x86_64-*-* } } } */
+/* { dg-final { scan-assembler-times {\tmov\tw17, #62700\n\tmovk\tw17, #22068, lsl #16} 1 { target aarch64-*-* } } } */
+/* { dg-final { scan-assembler-times {\tlui\tt2, 353103\n\taddiw\tt2, t2, 1260} 1 { target riscv*-*-* } } } */
+
+/* Functions returning struct pointers - must have different type IDs */
+extern struct test_struct_a* func_ret_struct_a_ptr(void); /* F14test_struct_aPvE -> unique */
+extern struct test_struct_b* func_ret_struct_b_ptr(void); /* F14test_struct_bPvE -> unique */
+extern struct test_struct_c* func_ret_struct_c_ptr(void); /* F14test_struct_cPvE -> unique */
+
+/* Struct return pointer tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_ret_struct_a_ptr\n\t\.set\t__kcfi_typeid_func_ret_struct_a_ptr, 0x39c14222} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_ret_struct_b_ptr\n\t\.set\t__kcfi_typeid_func_ret_struct_b_ptr, 0xe26c7223} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_ret_struct_c_ptr\n\t\.set\t__kcfi_typeid_func_ret_struct_c_ptr, 0x4efac19c} } } */
+
+/* Verify struct return pointer types */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFP13test_struct_avE' typeid=0x39c14222} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFP13test_struct_bvE' typeid=0xe26c7223} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFP13test_struct_cvE' typeid=0x4efac19c} kcfi0 } } */
+
+/* { dg-final { scan-assembler-times {0x39c14222} 1 } } */
+/* { dg-final { scan-assembler-times {0xe26c7223} 1 } } */
+/* { dg-final { scan-assembler-times {0x4efac19c} 1 } } */
+
+/* Functions taking structs by value - must have different type IDs */
+extern void func_struct_a_val(struct test_struct_a x);   /* Fv14test_struct_aE -> unique */
+extern void func_struct_b_val(struct test_struct_b x);   /* Fv14test_struct_bE -> unique */
+extern void func_struct_c_val(struct test_struct_c x);   /* Fv14test_struct_cE -> unique */
+
+/* Struct by-value parameter tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_a_val\n\t\.set\t__kcfi_typeid_func_struct_a_val, 0x3c685468} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_b_val\n\t\.set\t__kcfi_typeid_func_struct_b_val, 0xcc60e853} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_c_val\n\t\.set\t__kcfi_typeid_func_struct_c_val, 0xf0635f96} } } */
+
+/* Verify struct by-value parameter types */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFv13test_struct_aE' typeid=0x3c685468} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFv13test_struct_bE' typeid=0xcc60e853} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFv13test_struct_cE' typeid=0xf0635f96} kcfi0 } } */
+
+/* { dg-final { scan-assembler-times {0x3c685468} 1 } } */
+/* { dg-final { scan-assembler-times {0xcc60e853} 1 } } */
+/* { dg-final { scan-assembler-times {0xf0635f96} 1 } } */
+
+/* Functions returning structs by value - must have different type IDs */
+extern struct test_struct_a func_ret_struct_a_val(void); /* F14test_struct_avE -> unique */
+extern struct test_struct_b func_ret_struct_b_val(void); /* F14test_struct_bvE -> unique */
+extern struct test_struct_c func_ret_struct_c_val(void); /* F14test_struct_cvE -> unique */
+
+/* Struct return by-value tests with precise patterns */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_ret_struct_a_val\n\t\.set\t__kcfi_typeid_func_ret_struct_a_val, 0x872d60f8} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_ret_struct_b_val\n\t\.set\t__kcfi_typeid_func_ret_struct_b_val, 0x12ecd535} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_ret_struct_c_val\n\t\.set\t__kcfi_typeid_func_ret_struct_c_val, 0x6f7b0b7e} } } */
+
+/* Verify struct return by-value types - using correct P prefix for function pointer */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPF13test_struct_avE' typeid=0x872d60f8} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPF13test_struct_bvE' typeid=0x12ecd535} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPF13test_struct_cvE' typeid=0x6f7b0b7e} kcfi0 } } */
+
+/* { dg-final { scan-assembler-times {0x872d60f8} 1 } } */
+/* { dg-final { scan-assembler-times {0x12ecd535} 1 } } */
+/* { dg-final { scan-assembler-times {0x6f7b0b7e} 1 } } */
+
+/* Mixed struct parameters - order and type must matter */
+extern void func_struct_a_b(struct test_struct_a *a, struct test_struct_b *b); /* unique */
+extern void func_struct_b_a(struct test_struct_b *b, struct test_struct_a *a); /* different! */
+
+/* Mixed struct parameter tests - MUST be different (parameter order matters) */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_a_b\n\t\.set\t__kcfi_typeid_func_struct_a_b, 0x3858f101} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_b_a\n\t\.set\t__kcfi_typeid_func_struct_b_a, 0x9c8f2985} } } */
+
+/* Verify mixed struct parameter types */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvP13test_struct_aP13test_struct_bE' typeid=0x3858f101} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvP13test_struct_bP13test_struct_aE' typeid=0x9c8f2985} kcfi0 } } */
+
+/* { dg-final { scan-assembler-times {0x3858f101} 1 } } */
+/* { dg-final { scan-assembler-times {0x9c8f2985} 1 } } */
+
+/* Typedef structs - must be different from named structs */
+typedef struct { int value; } typedef_struct_x;
+typedef struct { int value; } typedef_struct_y;  /* Same layout but different typedef name */
+extern void func_typedef_x_ptr(typedef_struct_x *x);  /* Must be unique */
+extern void func_typedef_y_ptr(typedef_struct_y *x);  /* Must be different from typedef_struct_x */
+
+/* Typedef struct tests - MUST be different from each other */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_typedef_x_ptr\n\t\.set\t__kcfi_typeid_func_typedef_x_ptr, 0xd04404df} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_typedef_y_ptr\n\t\.set\t__kcfi_typeid_func_typedef_y_ptr, 0xf4467c22} } } */
+
+/* Verify typedef struct pointer types */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvP16typedef_struct_xE' typeid=0xd04404df} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvP16typedef_struct_yE' typeid=0xf4467c22} kcfi0 } } */
+
+/* { dg-final { scan-assembler-times {0xd04404df} 1 } } */
+/* { dg-final { scan-assembler-times {0xf4467c22} 1 } } */
+
+/* Typedef vs open-coded function types - MUST have identical type IDs */
+typedef void (*func_ptr_typedef)(int x, char y);
+extern void func_with_typedef_param(func_ptr_typedef fp);               /* Should match open-coded */
+extern void func_with_opencoded_param(void (*fp)(int x, char y));      /* Should match typedef */
+
+/* Function parameter types - typedef and open-coded should generate SAME type ID */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_with_typedef_param\n\t\.set\t__kcfi_typeid_func_with_typedef_param, 0xc3f653f3} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_with_opencoded_param\n\t\.set\t__kcfi_typeid_func_with_opencoded_param, 0xc3f653f3} } } */
+
+/* Verify function pointer parameter types */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvPFvicEE' typeid=0xc3f653f3} kcfi0 } } */
+
+/* Verify exact count - each typedef/opencoded pair should generate exactly 2 symbols with identical values */
+/* { dg-final { scan-assembler-times {0xc3f653f3} 2 } } */
+
+/* Typedef vs open-coded function types - MUST have identical type IDs */
+typedef int (*ret_func_ptr_typedef)(void);
+extern ret_func_ptr_typedef func_ret_typedef_param(void);              /* Should match open-coded */
+extern int (*func_ret_opencoded_param(void))(void);                    /* Should match typedef */
+
+/* Return function pointer types - typedef and open-coded should generate SAME type ID */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_ret_typedef_param\n\t\.set\t__kcfi_typeid_func_ret_typedef_param, 0xff38a80c} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_ret_opencoded_param\n\t\.set\t__kcfi_typeid_func_ret_opencoded_param, 0xff38a80c} } } */
+
+/* Verify return function pointer types */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFPFivEvE' typeid=0xff38a80c} kcfi0 } } */
+
+/* Verify exact count - each typedef/opencoded pair should generate exactly 2 symbols with identical values */
+/* { dg-final { scan-assembler-times {0xff38a80c} 2 } } */
+
+/* Anonymous struct via typedef - should get typedef name as struct name */
+typedef struct { int anon_member_1; } anon_typedef_1;
+typedef struct { int anon_member_2; } anon_typedef_2;
+extern void func_anon_typedef_1(anon_typedef_1 *param);                /* Should use typedef name */
+extern void func_anon_typedef_2(anon_typedef_2 *param);                /* Should be different from anon_typedef_1 */
+
+/* Anonymous typedef struct tests - MUST be different from each other */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_anon_typedef_1\n\t\.set\t__kcfi_typeid_func_anon_typedef_1, 0xeb2cfcf5} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_anon_typedef_2\n\t\.set\t__kcfi_typeid_func_anon_typedef_2, 0x3b29a94e} } } */
+
+/* Verify anonymous typedef struct types */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvP14anon_typedef_1E' typeid=0xeb2cfcf5} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvP14anon_typedef_2E' typeid=0x3b29a94e} kcfi0 } } */
+
+/* { dg-final { scan-assembler-times {0xeb2cfcf5} 1 } } */
+/* { dg-final { scan-assembler-times {0x3b29a94e} 1 } } */
+
+/* Local function definitions - these will NOT get __kcfi_typeid_ symbols (only external declarations do) */
+void local_func_void(void) { }                  /* FvvE -> 0x126cd6c8 */
+void local_func_short(short x) { }              /* FvsE -> 0x34cb4ae7 */
+void local_func_uint(unsigned int x) { }        /* FvjE -> 0x08e0cbf2 */
+void local_func_float(float x) { }              /* FvfE -> 0x48ff45c6 */
+
+/* Local function validation - verify local function definitions do NOT get __kcfi_typeid_ symbols */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_void\n} } } */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_short\n} } } */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_uint\n} } } */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_float\n} } } */
+
+/* Local pointer parameter types */
+void local_func_double_ptr(double *x) { }       /* FvPdE -> 0x713f38be */
+void local_func_float_ptr(float *x) { }         /* FvPfE -> 0xbd442d90 */
+
+/* Local pointer parameter types - should NOT emit symbols */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_double_ptr\n} } } */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_float_ptr\n} } } */
+
+/* Local nested pointers */
+void local_func_void_ptr_ptr(void **x) { }      /* FvPPvE -> 0x1d2eb12e */
+
+/* Local nested pointers - should NOT emit symbols */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_void_ptr_ptr\n} } } */
+
+/* Local mixed parameters */
+void local_func_ptr_val(int *x, int y) { }      /* FvPiiE -> 0x79c26342 */
+void local_func_val_ptr(int x, int *y) { }      /* FviPiE -> 0x467eba8c */
+
+/* Local mixed parameter validation - should NOT emit symbols */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_ptr_val\n} } } */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_val_ptr\n} } } */
+
+/* Local return types */
+float local_func_return_float(void) { return 0.0f; }    /* FfvE -> 0xf29546d8 */
+double local_func_return_double(void) { return 0.0; }   /* FdvE -> 0x268f8886 */
+
+/* Local return type discrimination - should NOT emit symbols */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_return_float\n} } } */
+/* { dg-final { scan-assembler-not {\t\.weak\t__kcfi_typeid_local_func_return_double\n} } } */
+
+/* Verify local function mangle strings appear in KCFI dump (even though no symbols are emitted) */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvsE' typeid=0x34cb4ae7} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvfE' typeid=0x48ff45c6} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvPdE' typeid=0x713f38be} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvPfE' typeid=0xbd442d90} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvPPvE' typeid=0x1d2eb12e} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFvPiiE' typeid=0x79c26342} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFviPiE' typeid=0x467eba8c} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFfvE' typeid=0x3b5a51e6} kcfi0 } } */
+/* { dg-final { scan-tree-dump {KCFI type ID: mangled='_ZTSPFdvE' typeid=0x1043bac0} kcfi0 } } */
+
+struct not_void {
+	int nothing;
+};
+
+/* Function that takes addresses to make functions visible to KCFI */
+void test_address_taken(struct not_void *arg)
+{
+    /* External functions - taking addresses generates __kcfi_typeid_ symbols */
+    void (*p1)(void) = func_void;
+    void (*p2)(char) = func_char;
+    void (*p3)(int) = func_int;
+    void (*p4)(long) = func_long;
+
+    void (*p5)(int*) = func_int_ptr;
+    void (*p6)(char*) = func_char_ptr;
+    void (*p7)(void*) = func_void_ptr;
+
+    void (*p_const_int_ptr)(const int*) = func_const_int_ptr;
+    void (*p_const_char_ptr)(const char*) = func_const_char_ptr;
+    void (*p_const_void_ptr)(const void*) = func_const_void_ptr;
+
+    void (*p8)(int**) = func_int_ptr_ptr;
+    void (*p9)(char**) = func_char_ptr_ptr;
+
+    void (*p10)(int, char) = func_int_char;
+    void (*p11)(char, int) = func_char_int;
+    void (*p12)(int, int) = func_two_int;
+
+    int (*p13)(void) = func_return_int;
+    char (*p14)(void) = func_return_char;
+    void* (*p15)(void) = func_return_ptr;
+
+    /* Array parameters - should decay to pointers */
+    void (*p16)(int*) = func_int_array;
+    void (*p17)(char*) = func_char_array;
+
+    /* Function pointer parameters */
+    void (*p18)(void(*)(void)) = func_fptr_void;
+    void (*p19)(void(*)(int)) = func_fptr_int;
+    void (*p20)(int(*)(void)) = func_fptr_ret_int;
+
+    /* Struct/union/enum function pointers - taking addresses generates __kcfi_typeid_ symbols */
+    void (*p_struct_a_ptr)(struct test_struct_a*) = func_struct_a_ptr;
+    void (*p_struct_b_ptr)(struct test_struct_b*) = func_struct_b_ptr;
+    void (*p_struct_c_ptr)(struct test_struct_c*) = func_struct_c_ptr;
+
+    /* Const struct function pointers - taking addresses generates __kcfi_typeid_ symbols */
+    void (*p_const_struct_a_ptr)(const struct test_struct_a*) = func_const_struct_a_ptr;
+    void (*p_const_struct_b_ptr)(const struct test_struct_b*) = func_const_struct_b_ptr;
+    void (*p_const_struct_c_ptr)(const struct test_struct_c*) = func_const_struct_c_ptr;
+    void (*p_union_a_ptr)(union test_union_a*) = func_union_a_ptr;
+    void (*p_union_b_ptr)(union test_union_b*) = func_union_b_ptr;
+    void (*p_enum_a_ptr)(enum test_enum_a*) = func_enum_a_ptr;
+    void (*p_enum_b_ptr)(enum test_enum_b*) = func_enum_b_ptr;
+
+    struct test_struct_a* (*p_ret_struct_a_ptr)(void) = func_ret_struct_a_ptr;
+    struct test_struct_b* (*p_ret_struct_b_ptr)(void) = func_ret_struct_b_ptr;
+    struct test_struct_c* (*p_ret_struct_c_ptr)(void) = func_ret_struct_c_ptr;
+
+    void (*p_struct_a_val)(struct test_struct_a) = func_struct_a_val;
+    void (*p_struct_b_val)(struct test_struct_b) = func_struct_b_val;
+    void (*p_struct_c_val)(struct test_struct_c) = func_struct_c_val;
+
+    struct test_struct_a (*p_ret_struct_a_val)(void) = func_ret_struct_a_val;
+    struct test_struct_b (*p_ret_struct_b_val)(void) = func_ret_struct_b_val;
+    struct test_struct_c (*p_ret_struct_c_val)(void) = func_ret_struct_c_val;
+
+    void (*p_struct_a_b)(struct test_struct_a*, struct test_struct_b*) = func_struct_a_b;
+    void (*p_struct_b_a)(struct test_struct_b*, struct test_struct_a*) = func_struct_b_a;
+
+    void (*p_typedef_x_ptr)(typedef_struct_x*) = func_typedef_x_ptr;
+    void (*p_typedef_y_ptr)(typedef_struct_y*) = func_typedef_y_ptr;
+
+    /* Typedef vs open-coded function type assignments - should generate identical type IDs */
+    void (*p_with_typedef_param)(func_ptr_typedef) = func_with_typedef_param;
+    void (*p_with_opencoded_param)(void (*)(int, char)) = func_with_opencoded_param;
+    ret_func_ptr_typedef (*p_ret_typedef_param)(void) = func_ret_typedef_param;
+    int (*(*p_ret_opencoded_param)(void))(void) = func_ret_opencoded_param;
+
+    /* Anonymous struct typedef assignments - should generate unique type IDs */
+    void (*p_anon_typedef_1)(anon_typedef_1 *) = func_anon_typedef_1;
+    void (*p_anon_typedef_2)(anon_typedef_2 *) = func_anon_typedef_2;
+
+    /* Union member access discrimination test - take addresses to generate __kcfi_typeid_ symbols */
+    void (*p_tasklet_callback)(struct tasklet_like_struct *) = tasklet_callback_function;
+    void (*p_tasklet_func)(unsigned long) = tasklet_func_function;
+
+    /* Local functions - taking addresses does NOT generate __kcfi_typeid_ symbols (only external declarations do) */
+    void (*p21)(void) = local_func_void;
+    void (*p22)(short) = local_func_short;
+    void (*p23)(unsigned int) = local_func_uint;
+    void (*p24)(float) = local_func_float;
+
+    void (*p25)(double*) = local_func_double_ptr;
+    void (*p26)(float*) = local_func_float_ptr;
+
+    void (*p27)(void**) = local_func_void_ptr_ptr;
+
+    void (*p28)(int*, int) = local_func_ptr_val;
+    void (*p29)(int, int*) = local_func_val_ptr;
+
+    float (*p30)(void) = local_func_return_float;
+    double (*p31)(void) = local_func_return_double;
+
+    /* Use pointers to prevent optimization - external functions */
+    if (p1) p1();
+    if (p2) p2('x');
+    if (p3) p3(42);
+    if (p4) p4(42L);
+    if (p5) p5((int*)0);
+    if (p6) p6((char*)0);
+    if (p7) p7((void*)0);
+
+    /* Use const qualifier pointers to prevent optimization */
+    if (p_const_int_ptr) p_const_int_ptr((const int*)0);
+    if (p_const_char_ptr) p_const_char_ptr((const char*)0);
+    if (p_const_void_ptr) p_const_void_ptr((const void*)0);
+    if (p8) p8((int**)0);
+    if (p9) p9((char**)0);
+    if (p10) p10(1, 'x');
+    if (p11) p11('x', 1);
+    if (p12) p12(1, 2);
+    if (p13) p13();
+    if (p14) p14();
+    if (p15) p15();
+    if (p16) p16((int*)0);
+    if (p17) p17((char*)0);
+    if (p18) p18((void(*)(void))0);
+    if (p19) p19((void(*)(int))0);
+    if (p20) p20((int(*)(void))0);
+
+    /* Use pointers to prevent optimization - local functions */
+    if (p21) p21();
+    if (p22) p22(1);
+    if (p23) p23(1U);
+    if (p24) p24(1.0f);
+    if (p25) p25((double*)0);
+    if (p26) p26((float*)0);
+    if (p27) p27((void**)0);
+    if (p28) p28((int*)0, 1);
+    if (p29) p29(1, (int*)0);
+    if (p30) p30();
+    if (p31) p31();
+
+    /* Use struct/union/enum function pointers to generate KCFI type IDs */
+    if (p_struct_a_ptr) p_struct_a_ptr((struct test_struct_a*)0);
+    if (p_struct_b_ptr) p_struct_b_ptr((struct test_struct_b*)0);
+    if (p_struct_c_ptr) p_struct_c_ptr((struct test_struct_c*)0);
+    if (p_const_struct_a_ptr) p_const_struct_a_ptr((const struct test_struct_a*)0);
+    if (p_const_struct_b_ptr) p_const_struct_b_ptr((const struct test_struct_b*)0);
+    if (p_const_struct_c_ptr) p_const_struct_c_ptr((const struct test_struct_c*)0);
+    if (p_union_a_ptr) p_union_a_ptr((union test_union_a*)0);
+    if (p_union_b_ptr) p_union_b_ptr((union test_union_b*)0);
+    if (p_enum_a_ptr) p_enum_a_ptr((enum test_enum_a*)0);
+    if (p_enum_b_ptr) p_enum_b_ptr((enum test_enum_b*)0);
+
+    /* Use struct return type function pointers to generate type IDs */
+    if (p_ret_struct_a_ptr) p_ret_struct_a_ptr();
+    if (p_ret_struct_b_ptr) p_ret_struct_b_ptr();
+    if (p_ret_struct_c_ptr) p_ret_struct_c_ptr();
+
+    /* Use struct by-value parameter function pointers to generate type IDs */
+    struct test_struct_a dummy_a = {};
+    struct test_struct_b dummy_b = {};
+    struct test_struct_c dummy_c = {};
+    if (p_struct_a_val) p_struct_a_val(dummy_a);
+    if (p_struct_b_val) p_struct_b_val(dummy_b);
+    if (p_struct_c_val) p_struct_c_val(dummy_c);
+
+    /* Use struct return by-value function pointers to generate type IDs */
+    if (p_ret_struct_a_val) p_ret_struct_a_val();
+    if (p_ret_struct_b_val) p_ret_struct_b_val();
+    if (p_ret_struct_c_val) p_ret_struct_c_val();
+
+    /* Use multi-parameter struct function pointers to generate type IDs */
+    if (p_struct_a_b) p_struct_a_b((struct test_struct_a*)0, (struct test_struct_b*)0);
+    if (p_struct_b_a) p_struct_b_a((struct test_struct_b*)0, (struct test_struct_a*)0);
+
+    /* Use typedef struct function pointers to generate type IDs */
+    if (p_typedef_x_ptr) p_typedef_x_ptr((typedef_struct_x*)0);
+    if (p_typedef_y_ptr) p_typedef_y_ptr((typedef_struct_y*)0);
+
+    /* Use typedef vs open-coded function pointers to generate type IDs */
+    if (p_with_typedef_param) p_with_typedef_param((func_ptr_typedef)0);
+    if (p_with_opencoded_param) p_with_opencoded_param((void (*)(int, char))0);
+    if (p_ret_typedef_param) p_ret_typedef_param();
+    if (p_ret_opencoded_param) p_ret_opencoded_param();
+
+    /* Use anonymous typedef function pointers to generate type IDs */
+    if (p_anon_typedef_1) p_anon_typedef_1((anon_typedef_1*)0);
+    if (p_anon_typedef_2) p_anon_typedef_2((anon_typedef_2*)0);
+
+    /* Use tasklet func function pointer to generate the missing FvmE type ID */
+    if (p_tasklet_func) p_tasklet_func(0);
+
+    struct tasklet_like_struct test_tasklet = { };
+    test_tasklet.callback = tasklet_callback_function;  /* Set callback function */
+
+    /* This indirect call through union->callback MUST generate type ID 0x5634f4ec (callback signature) */
+    /* NOT type ID 0x48edfca5 (func signature from first union member) */
+    /* Force indirect call through union member access */
+    struct tasklet_like_struct *volatile tasklet_ptr = &test_tasklet;
+    if (tasklet_ptr->callback) {
+        /* This call should match tasklet_callback_function type ID */
+        tasklet_ptr->callback(tasklet_ptr);
+    }
+}
+
+/* Named struct and its typedef should have IDENTICAL type IDs after canonicalization */
+struct named_for_typedef_test { int member; };
+typedef struct named_for_typedef_test named_for_typedef_test_t;
+
+extern void func_named_struct_param(struct named_for_typedef_test *param);
+extern void func_typedef_struct_param(named_for_typedef_test_t *param);
+
+/* Named struct typedef canonicalization - MUST have identical type IDs */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_named_struct_param\n\t\.set\t__kcfi_typeid_func_named_struct_param, 0x010f62ae} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_typedef_struct_param\n\t\.set\t__kcfi_typeid_func_typedef_struct_param, 0x010f62ae} } } */
+
+/* Verify named struct typedef canonicalization types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP22named_for_typedef_testE' typeid=0x010f62ae} kcfi0 } } */
+
+/* Verify exact count - both should generate exactly 2 symbols with identical values */
+/* { dg-final { scan-assembler-times {0x010f62ae} 2 } } */
+
+void test_named_struct_typedef_canonicalization(struct not_void *arg) {
+    /* These should be compatible after canonicalization */
+    void (*fp_struct)(struct named_for_typedef_test *) = func_named_struct_param;
+    void (*fp_typedef)(struct named_for_typedef_test *) = func_typedef_struct_param;  /* Should work with canonicalization */
+
+    /* Take addresses to generate type IDs */
+    if (fp_struct) fp_struct((struct named_for_typedef_test *)0);
+    if (fp_typedef) fp_typedef((struct named_for_typedef_test *)0);
+}
+
+/* Basic type typedef canonicalization - typedef should canonicalize to underlying basic type */
+
+/* Basic type typedefs commonly used in kernel code */
+typedef unsigned char u8;
+typedef unsigned short u16;
+typedef unsigned int u32;
+
+/* Functions with basic type typedef vs original type parameters */
+extern void func_u8_param(u8 param);
+extern void func_unsigned_char_param(unsigned char param);
+extern void func_u16_param(u16 param);
+extern void func_unsigned_short_param(unsigned short param);
+extern void func_u32_param(u32 param);
+extern void func_unsigned_int_param(unsigned int param);
+
+void test_basic_typedef_canonicalization(struct not_void *arg) {
+    /* These should be compatible after canonicalization */
+    void (*fp_u8)(unsigned char) = func_u8_param;                    /* Should work with canonicalization */
+    void (*fp_uchar)(unsigned char) = func_unsigned_char_param;      /* Should work normally */
+    void (*fp_u16)(unsigned short) = func_u16_param;                 /* Should work with canonicalization */
+    void (*fp_ushort)(unsigned short) = func_unsigned_short_param;   /* Should work normally */
+    void (*fp_u32)(unsigned int) = func_u32_param;                   /* Should work with canonicalization */
+    void (*fp_uint)(unsigned int) = func_unsigned_int_param;         /* Should work normally */
+
+    /* Take addresses to generate type IDs */
+    if (fp_u8) fp_u8(0);
+    if (fp_uchar) fp_uchar(0);
+    if (fp_u16) fp_u16(0);
+    if (fp_ushort) fp_ushort(0);
+    if (fp_u32) fp_u32(0);
+    if (fp_uint) fp_uint(0);
+}
+
+/* Basic type typedef canonicalization - MUST have identical type IDs after canonicalization */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u8_param\n\t\.set\t__kcfi_typeid_func_u8_param, 0x54e5c0c4} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_unsigned_char_param\n\t\.set\t__kcfi_typeid_func_unsigned_char_param, 0x54e5c0c4} } } */
+
+/* Verify basic type canonicalization (u8/unsigned char) */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvhE' typeid=0x54e5c0c4} kcfi0 } } */
+
+/* Count test is below, which includes other tests that use this hash. */
+
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u16_param\n\t\.set\t__kcfi_typeid_func_u16_param, 0x34dc9408} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_unsigned_short_param\n\t\.set\t__kcfi_typeid_func_unsigned_short_param, 0x34dc9408} } } */
+
+/* Verify basic type canonicalization (u16/unsigned short) */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvtE' typeid=0x34dc9408} kcfi0 } } */
+
+/* { dg-final { scan-assembler-times {0x34dc9408} 2 } } */
+
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u32_param\n\t\.set\t__kcfi_typeid_func_u32_param, 0x08e0cbf2} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_unsigned_int_param\n\t\.set\t__kcfi_typeid_func_unsigned_int_param, 0x08e0cbf2} } } */
+
+/* Verify basic type canonicalization (u32/unsigned int) */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvjE' typeid=0x08e0cbf2} kcfi0 } } */
+
+/* Count test is below, which includes other tests that use this hash. */
+
+/* Verify exact count - each typedef/basic type pair should generate exactly 2 symbols with identical values */
+/* Note: Counts updated below to include recursive typedef tests */
+
+/* Recursive typedef canonicalization - test multi-level typedef chains */
+
+/* Kernel-style recursive typedef chains that need full canonicalization */
+typedef unsigned char __u8_recursive;
+typedef __u8_recursive u8_recursive;
+
+typedef unsigned int __u32_recursive;
+typedef __u32_recursive u32_recursive;
+
+/* Three-level typedef chains */
+typedef unsigned char base_u8_recursive_t;
+typedef base_u8_recursive_t mid_u8_recursive_t;
+typedef mid_u8_recursive_t top_u8_recursive_t;
+
+/* Struct recursive typedef chains */
+struct recursive_struct_test { int value; };
+typedef struct recursive_struct_test base_recursive_struct_t;
+typedef base_recursive_struct_t top_recursive_struct_t;
+
+/* Functions with recursive typedefs - MUST have same type IDs as canonical forms */
+extern void func_u8_recursive_chain(u8_recursive param);          /* u8_recursive -> __u8_recursive -> unsigned char */
+extern void func_u8_recursive_mid(__u8_recursive param);          /* __u8_recursive -> unsigned char */
+extern void func_u8_recursive_base(unsigned char param);          /* unsigned char (baseline) */
+
+extern void func_u32_recursive_chain(u32_recursive param);        /* u32_recursive -> __u32_recursive -> unsigned int */
+extern void func_u32_recursive_mid(__u32_recursive param);        /* __u32_recursive -> unsigned int */
+extern void func_u32_recursive_base(unsigned int param);          /* unsigned int (baseline) */
+
+extern void func_three_level_recursive(top_u8_recursive_t param); /* top -> mid -> base -> unsigned char */
+extern void func_three_level_mid(mid_u8_recursive_t param);       /* mid -> base -> unsigned char */
+extern void func_three_level_base(base_u8_recursive_t param);     /* base -> unsigned char */
+extern void func_three_level_final(unsigned char param);          /* unsigned char (baseline) */
+
+extern void func_struct_recursive_chain(top_recursive_struct_t *param);     /* Should resolve to struct name */
+extern void func_struct_recursive_mid(base_recursive_struct_t *param);      /* Should resolve to struct name */
+extern void func_struct_recursive_original(struct recursive_struct_test *param); /* struct name (baseline) */
+
+void test_recursive_canonicalization(struct not_void *arg) {
+    /* Recursive typedef function pointers - should be compatible after full canonicalization */
+    void (*fp_u8_chain)(unsigned char) = func_u8_recursive_chain;        /* Should work after 2-level canonicalization */
+    void (*fp_u8_mid)(unsigned char) = func_u8_recursive_mid;            /* Should work after 1-level canonicalization */
+    void (*fp_u8_base)(unsigned char) = func_u8_recursive_base;          /* Should work normally */
+
+    void (*fp_u32_chain)(unsigned int) = func_u32_recursive_chain;       /* Should work after 2-level canonicalization */
+    void (*fp_u32_mid)(unsigned int) = func_u32_recursive_mid;           /* Should work after 1-level canonicalization */
+    void (*fp_u32_base)(unsigned int) = func_u32_recursive_base;         /* Should work normally */
+
+    void (*fp_three_chain)(unsigned char) = func_three_level_recursive;  /* Should work after 3-level canonicalization */
+    void (*fp_three_mid)(unsigned char) = func_three_level_mid;          /* Should work after 2-level canonicalization */
+    void (*fp_three_base)(unsigned char) = func_three_level_base;        /* Should work after 1-level canonicalization */
+    void (*fp_three_final)(unsigned char) = func_three_level_final;      /* Should work normally */
+
+    void (*fp_struct_chain)(struct recursive_struct_test *) = func_struct_recursive_chain;  /* Should work after canonicalization */
+    void (*fp_struct_mid)(struct recursive_struct_test *) = func_struct_recursive_mid;      /* Should work after canonicalization */
+    void (*fp_struct_orig)(struct recursive_struct_test *) = func_struct_recursive_original; /* Should work normally */
+
+    /* Use function pointers to prevent optimization */
+    if (fp_u8_chain) fp_u8_chain(0);
+    if (fp_u8_mid) fp_u8_mid(0);
+    if (fp_u8_base) fp_u8_base(0);
+    if (fp_u32_chain) fp_u32_chain(0);
+    if (fp_u32_mid) fp_u32_mid(0);
+    if (fp_u32_base) fp_u32_base(0);
+    if (fp_three_chain) fp_three_chain(0);
+    if (fp_three_mid) fp_three_mid(0);
+    if (fp_three_base) fp_three_base(0);
+    if (fp_three_final) fp_three_final(0);
+    if (fp_struct_chain) fp_struct_chain((struct recursive_struct_test *)0);
+    if (fp_struct_mid) fp_struct_mid((struct recursive_struct_test *)0);
+    if (fp_struct_orig) fp_struct_orig((struct recursive_struct_test *)0);
+}
+
+/* Recursive typedef canonicalization validation - MUST have identical type IDs after full canonicalization */
+
+/* u8 recursive chain - all should resolve to unsigned char */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u8_recursive_chain\n\t\.set\t__kcfi_typeid_func_u8_recursive_chain, 0x54e5c0c4} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u8_recursive_mid\n\t\.set\t__kcfi_typeid_func_u8_recursive_mid, 0x54e5c0c4} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u8_recursive_base\n\t\.set\t__kcfi_typeid_func_u8_recursive_base, 0x54e5c0c4} } } */
+
+/* u32 recursive chain - all should resolve to unsigned int */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u32_recursive_chain\n\t\.set\t__kcfi_typeid_func_u32_recursive_chain, 0x08e0cbf2} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u32_recursive_mid\n\t\.set\t__kcfi_typeid_func_u32_recursive_mid, 0x08e0cbf2} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_u32_recursive_base\n\t\.set\t__kcfi_typeid_func_u32_recursive_base, 0x08e0cbf2} } } */
+
+/* Three-level u8 recursive chain - all should resolve to unsigned char */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_three_level_recursive\n\t\.set\t__kcfi_typeid_func_three_level_recursive, 0x54e5c0c4} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_three_level_mid\n\t\.set\t__kcfi_typeid_func_three_level_mid, 0x54e5c0c4} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_three_level_base\n\t\.set\t__kcfi_typeid_func_three_level_base, 0x54e5c0c4} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_three_level_final\n\t\.set\t__kcfi_typeid_func_three_level_final, 0x54e5c0c4} } } */
+
+/* Struct recursive chain - all should resolve to same struct name */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_recursive_chain\n\t\.set\t__kcfi_typeid_func_struct_recursive_chain, 0x2e72122c} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_recursive_mid\n\t\.set\t__kcfi_typeid_func_struct_recursive_mid, 0x2e72122c} } } */
+/* { dg-final { scan-assembler {\t\.weak\t__kcfi_typeid_func_struct_recursive_original\n\t\.set\t__kcfi_typeid_func_struct_recursive_original, 0x2e72122c} } } */
+
+/* Update counts to include recursive typedef tests */
+/* Note: u8/unsigned char recursive tests add 7 more occurrences (actual count: 9) */
+/* { dg-final { scan-assembler-times {0x54e5c0c4} 9 } } */
+
+/* Note: u32/unsigned int recursive tests add 3 more occurrences (actual count: 6) */
+/* { dg-final { scan-assembler-times {0x08e0cbf2} 6 } } */
+
+/* Verify struct recursive typedef canonicalization types */
+/* { dg-final { scan-tree-dump {mangled='_ZTSPFvP21recursive_struct_testE' typeid=0x2e72122c} kcfi0 } } */
+
+/* Struct recursive: 3 identical type IDs */
+/* { dg-final { scan-assembler-times {0x2e72122c} 3 } } */
+
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi.exp b/gcc/testsuite/gcc.dg/kcfi/kcfi.exp
new file mode 100644
index 000000000000..2aebcbe1c01b
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi.exp
@@ -0,0 +1,36 @@
+#   Copyright (C) 2025 Free Software Foundation, Inc.
+
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with GCC; see the file COPYING3.  If not see
+# <http://www.gnu.org/licenses/>.
+
+# GCC testsuite for KCFI (Kernel Control Flow Integrity) tests.
+
+# Load support procs.
+load_lib gcc-dg.exp
+
+# If a testcase doesn't have special options, use these.
+global DEFAULT_CFLAGS
+if ![info exists DEFAULT_CFLAGS] then {
+    set DEFAULT_CFLAGS ""
+}
+
+# Initialize `dg'.
+dg-init
+
+# Main loop.
+dg-runtest [lsort [glob -nocomplain $srcdir/$subdir/*.c]] \
+	"" $DEFAULT_CFLAGS
+
+# All done.
+dg-finish
-- 
2.34.1

