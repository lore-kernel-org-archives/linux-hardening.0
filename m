Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9D25392C
	for <linux-hardening@vger.kernel.org>; Wed, 10 Dec 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765333236; cv=none; b=gvw7TRvYdKwhzb/AHOxXBKbRt4wJFNO1nxifZwadG2vrKgMuoD7zWNqN2zE6IiSEHVBzctUKXzmUnLGfdTA+M5jr6QIXAT6Jp3TL6yrb2A5ShTvQSwY1TDKV6uTUbD54beKTMSWbtW3sgY9UfFIrcktXuxfZ+JG9An9YxbjyPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765333236; c=relaxed/simple;
	bh=eB+8+GsLlvDcBO/wBtbiOJ+r5luTKVbyoQXMRav9JuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCKN1FWomExv/T1g5el/CHo3YrDTvqybn3q923NHek9dnjdE0r4KThguHE0kBzxjTnExz0PrprLKvBJ3CXyhY7KB2ZXe2sYs4pZ00UOKmVNTiKOoooQHalpNOiARaQnNw39St4FB6JLHra+0kaG40xWy4m9vZLBbysIM64WxQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twcqbntk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twcqbntk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAF0C19423;
	Wed, 10 Dec 2025 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765333235;
	bh=eB+8+GsLlvDcBO/wBtbiOJ+r5luTKVbyoQXMRav9JuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwcqbntkGRj3T8PTqrdkMguxEIeuM/cYmr+ezQynaL4uNJln7h5jYFDCjXXZX2kGt
	 hPUSOdhcpyEOIo1GiHDpOJOE8Dvf58gJov7rqJ8S8VsR9gv7QA8RttVuciO939dEpA
	 QkrQo2X3x8m8mEqSqQnNzYsP1/HIhIW6VdPNOutmmnidEL2eBAXsbBMNRKbHd0OyE0
	 jIVUi7zs0V/o5nSMAERUf49KXRXpp24hIXfRYZmCPfFNfJ9kvdWQ9Ti6txrOE06Y24
	 /ku7bkJb4cKuEg8o2cUv5sQRt/7UfmkgO3itoyiQieSLifJnetNFHcPF65LHCfjBV6
	 TipaGhKTVcKXw==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>,
	Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v9 3/7] kcfi: Add regression test suite
Date: Tue,  9 Dec 2025 18:20:29 -0800
Message-Id: <20251210022035.331892-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210022025.harder.803-kees@kernel.org>
References: <20251210022025.harder.803-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=48747; i=kees@kernel.org; h=from:subject; bh=eB+8+GsLlvDcBO/wBtbiOJ+r5luTKVbyoQXMRav9JuA=; b=owGbwMvMwCVmps19z/KJym7G02pJDJkWN94XR9bcWFRgvjuAr1qVT/L4xISf85P/iPAedI8S5 N3A+XdXRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETqHBn+yvyonjLn44dta5/7 7ND+fnGCMsfOqpnL5kc3nw686tI+fTtQxbLF0lYh779mbjrBHpHSoH6taRVzBo+G8k4drUU8Eum sAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add test suite for KCFI (Kernel Control Flow Integrity) ABI, covering
core functionality, optimization and code generation, addressing,
architecture-specific KCFI sequence emission, and integration with
patchable function entry.

The arch-specific patterns themselves are added with the subsequent
architecture patches.

Tests can be run via:
  make check-c RUNTESTFLAGS='kcfi.exp'

gcc/testsuite/ChangeLog:

	* lib/target-supports.exp: Add check_effective_target_kcfi.
	* gcc.dg/kcfi/kcfi.exp: Add kcfi tests.
	* gcc.dg/kcfi/kcfi-adjacency.c: New test.
	* gcc.dg/kcfi/kcfi-basics.c: New test.
	* gcc.dg/kcfi/kcfi-call-sharing.c: New test.
	* gcc.dg/kcfi/kcfi-cold-partition.c: New test.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: New test.
	* gcc.dg/kcfi/kcfi-ipa-robustness.c: New test.
	* gcc.dg/kcfi/kcfi-move-preservation.c: New test.
	* gcc.dg/kcfi/kcfi-no-sanitize-inline.c: New test.
	* gcc.dg/kcfi/kcfi-no-sanitize.c: New test.
	* gcc.dg/kcfi/kcfi-offset-validation.c: New test.
	* gcc.dg/kcfi/kcfi-patchable-entry-only.c: New test.
	* gcc.dg/kcfi/kcfi-patchable-incompatible.c: New test.
	* gcc.dg/kcfi/kcfi-patchable-large.c: New test.
	* gcc.dg/kcfi/kcfi-patchable-medium.c: New test.
	* gcc.dg/kcfi/kcfi-patchable-prefix-only.c: New test.
	* gcc.dg/kcfi/kcfi-runtime.c: New test.
	* gcc.dg/kcfi/kcfi-tail-calls.c: New test.
	* gcc.dg/kcfi/kcfi-trap-section.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  51 ++++
 gcc/testsuite/lib/target-supports.exp         |  14 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  49 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  74 +++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  61 ++++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         | 126 ++++++++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 131 +++++++++
 .../gcc.dg/kcfi/kcfi-complex-addressing.s     |   0
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 ++++
 .../gcc.dg/kcfi/kcfi-move-preservation.c      |  41 +++
 .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  74 +++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  31 ++
 .../gcc.dg/kcfi/kcfi-offset-validation.c      |  24 ++
 .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  14 +
 .../gcc.dg/kcfi/kcfi-patchable-incompatible.c |   7 +
 .../gcc.dg/kcfi/kcfi-patchable-large.c        |  14 +
 .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  14 +
 .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  14 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      | 276 ++++++++++++++++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  60 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  17 ++
 21 files changed, 1146 insertions(+)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.s
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-incompatible.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c

diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi.exp b/gcc/testsuite/gcc.dg/kcfi/kcfi.exp
new file mode 100644
index 000000000000..131b24b8f140
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi.exp
@@ -0,0 +1,51 @@
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
+# Skip tests if KCFI is not supported on this target.
+if { ![check_effective_target_kcfi] } {
+    return
+}
+
+# Save DEFAULT_CFLAGS to restore later.
+global DEFAULT_CFLAGS
+if [info exists DEFAULT_CFLAGS] then {
+  set save_default_cflags $DEFAULT_CFLAGS
+}
+
+# Enable KCFI for all the kcfi/ tests.
+set DEFAULT_CFLAGS "-fsanitize=kcfi"
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
+
+# Restore original DEFAULT_CFLAGS.
+if [info exists save_default_cflags] {
+  set DEFAULT_CFLAGS $save_default_cflags
+} else {
+  unset DEFAULT_CFLAGS
+}
diff --git a/gcc/testsuite/lib/target-supports.exp b/gcc/testsuite/lib/target-supports.exp
index 6251f4e58f86..5b1fa50cca64 100644
--- a/gcc/testsuite/lib/target-supports.exp
+++ b/gcc/testsuite/lib/target-supports.exp
@@ -14035,6 +14035,20 @@ proc check_effective_target_no_fsanitize_address {} {
     return 0;
 }
 
+# Return 1 if this target supports KCFI (Kernel Control Flow Integrity)
+
+proc check_effective_target_kcfi {} {
+    # We don't need a full execuable to test this flag
+    return [check_no_compiler_messages kcfi assembly {
+	void func(void) {}
+	int main(void) {
+	    void (*ptr)(void) = func;
+	    ptr();
+	    return 0;
+	}
+    } "-fsanitize=kcfi"]
+}
+
 # Return 1 if this target supports 'R' flag in .section directive, 0
 # otherwise.  Cache the result.
 
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
new file mode 100644
index 000000000000..7c1cff986c01
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
@@ -0,0 +1,49 @@
+/* Test KCFI check/transfer adjacency - regression test for instruction
+   insertion.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-O2" } */
+
+/* This test ensures that KCFI security checks remain immediately adjacent
+   to their corresponding indirect calls/jumps, with no executable instructions
+   between the type ID check and the control flow transfer. */
+
+/* External function pointers to prevent optimization.  */
+extern void (*complex_func_ptr)(int, int, int, int);
+extern int (*return_func_ptr)(int, int);
+
+/* Function with complex argument preparation that could tempt
+   the optimizer to insert instructions between KCFI check and call.  */
+__attribute__((noinline)) void test_complex_args(int a, int b, int c, int d) {
+    /* Complex argument expressions that might cause instruction scheduling.  */
+    complex_func_ptr(a * 2, b + c, d - a, (a << 1) | b);
+}
+
+/* Function with return value handling.  */
+__attribute__((noinline)) int test_return_value(int x, int y) {
+    /* Return value handling that shouldn't interfere with adjacency.  */
+    int result = return_func_ptr(x + 1, y * 2);
+    return result + 1;
+}
+
+/* Test struct field access that caused issues in try-catch.c.  */
+struct call_info {
+    void (*handler)(void);
+    int status;
+    int data;
+};
+
+extern struct call_info *global_call_info;
+
+__attribute__((noinline)) void test_struct_field_call(void) {
+    /* This pattern caused adjacency issues before the fix.  */
+    global_call_info->handler();
+}
+
+/* Test conditional indirect call.  */
+__attribute__((noinline)) void test_conditional_call(int flag) {
+    if (flag) {
+        global_call_info->handler();
+    }
+}
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
new file mode 100644
index 000000000000..ca833fed2971
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
@@ -0,0 +1,74 @@
+/* Test basic KCFI functionality - preamble generation.  */
+/* { dg-do compile } */
+
+/* Extern function declarations - should NOT get KCFI preambles.  */
+extern void external_func(void);
+extern int external_func_int(int x);
+
+void regular_function(int x) {
+    /* This should get KCFI preamble.  */
+}
+
+void static_target_function(int x) {
+    /* Target function that can be called indirectly.  */
+}
+
+__attribute__((nocf_check))
+void nocf_check_function(int x) {
+    /* This function has nocf_check attribute - should NOT get KCFI preamble.  */
+}
+
+static void static_caller(void) {
+    /* Static function that makes an indirect call
+       Should NOT get KCFI preamble (not address-taken)
+       But must generate KCFI check for the indirect call.  */
+    void (*local_ptr)(int) = static_target_function;
+    local_ptr(42);  /* This should generate KCFI check.  */
+}
+
+/* Make external_func address-taken.  */
+void (*func_ptr)(int) = regular_function;
+void (*ext_ptr)(void) = external_func;
+void (__attribute__((nocf_check)) *nocf_ptr)(int) = nocf_check_function;
+
+int main() {
+    func_ptr(42);
+    ext_ptr();        /* Indirect call to external_func.  */
+    external_func_int(10);  /* Direct call to external_func_int.  */
+    static_caller();  /* Direct call to static function.  */
+    return 0;
+}
+
+/* Verify KCFI preamble exists for regular_function.  */
+/* { dg-final { scan-assembler {__cfi_regular_function:} } } */
+
+/* Verify KCFI preamble symbol comes before main function symbol.  */
+/* { dg-final { scan-assembler {__cfi_regular_function:.*regular_function:} } } */
+
+/* Target function should have preamble (address-taken).  */
+/* { dg-final { scan-assembler {__cfi_static_target_function:} } } */
+
+/* Static caller should NOT have preamble (it's only called directly,
+   not address-taken). */
+/* { dg-final { scan-assembler-not {__cfi_static_caller:} } } */
+
+/* Function with nocf_check attribute should NOT have preamble.  */
+/* { dg-final { scan-assembler-not {__cfi_nocf_check_function:} } } */
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
+
+/* Extern functions should NOT get KCFI preambles.  */
+/* { dg-final { scan-assembler-not {__cfi_external_func:} } } */
+/* { dg-final { scan-assembler-not {__cfi_external_func_int:} } } */
+
+/* Local functions should NOT get __kcfi_typeid_ symbols.  */
+/* Only external declarations that are address-taken should get __kcfi_typeid_ */
+/* { dg-final { scan-assembler-not {__kcfi_typeid_regular_function} } } */
+/* { dg-final { scan-assembler-not {__kcfi_typeid_main} } } */
+
+/* External address-taken functions should get __kcfi_typeid_ symbols.  */
+/* { dg-final { scan-assembler {__kcfi_typeid_external_func} } } */
+
+/* External functions that are only called directly should NOT get
+   __kcfi_typeid_ symbols.  */
+/* { dg-final { scan-assembler-not {__kcfi_typeid_external_func_int} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
new file mode 100644
index 000000000000..f72344f77124
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
@@ -0,0 +1,61 @@
+/* Test KCFI check sharing bug - optimizer incorrectly shares KCFI checks
+   between different function types.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-O2" } */
+
+/* Reproduce the pattern from Linux kernel internal_create_group where:
+   - Two different function pointer types (is_visible vs is_bin_visible).
+   - Both get loaded into the same register (%rcx).
+   - Optimizer creates shared KCFI check with wrong type ID.
+   - This causes CFI failures in production kernel.  */
+
+struct kobject { int dummy; };
+struct attribute { int dummy; };
+struct bin_attribute { int dummy; };
+
+struct attribute_group {
+    const char *name;
+    /* Type ID A.  */
+    int (*is_visible)(struct kobject *, struct attribute *, int);
+    /* Type ID B.  */
+    int (*is_bin_visible)(struct kobject *, const struct bin_attribute *, int);
+    /* Type ID B again.  */
+    int (*is_bin_visible_again)(struct kobject *, const struct bin_attribute *, int);
+    struct attribute **attrs;
+    const struct bin_attribute **bin_attrs;
+};
+
+/* Function that mimics __first_visible from kernel - gets inlined into
+   caller.  */
+static int __first_visible(const struct attribute_group *grp, struct kobject *kobj)
+{
+    /* Path 1: Call is_visible function pointer.  */
+    if (grp->attrs && grp->attrs[0] && grp->is_visible)
+        return grp->is_visible(kobj, grp->attrs[0], 0);
+
+    /* Path 2: Call is_bin_visible function pointer.  */
+    if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
+        return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
+
+    /* Path 3: Call is_bin_visible_again function pointer.  */
+    if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible_again)
+        return grp->is_bin_visible_again(kobj, grp->bin_attrs[0], 0);
+
+    return 0;
+}
+
+/* Main function that triggers the optimization bug.  */
+int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute_group *grp)
+{
+    /* This should inline __first_visible and create the problematic pattern where:
+       1. Both function pointers get loaded into same register.
+       2. Optimizer shares KCFI check between them.
+       3. Uses wrong type ID for one of the calls.  */
+    return __first_visible(grp, kobj);
+}
+
+/* Each indirect call should have its own KCFI check with correct type ID.
+
+   Should see:
+   1. KCFI check for is_visible call with is_visible type ID A.
+   2. KCFI check for is_bin_visible and is_bin_visible_again call with type ID B.  */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
new file mode 100644
index 000000000000..87ffdba1f0ae
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
@@ -0,0 +1,126 @@
+/* Test KCFI cold function and cold partition behavior.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-O2" } */
+/* { dg-additional-options "-freorder-blocks-and-partition" { target freorder } } */
+
+void regular_function(void) {
+    /* Regular function should get preamble.  */
+}
+
+/* Cold-attributed function should STILL get preamble (it's a regular
+   function, just marked cold).  */
+__attribute__((cold))
+void cold_attributed_function(void) {
+    /* This function has cold attribute but should still get KCFI preamble.  */
+}
+
+/* Hot-attributed function should get preamble.  */
+__attribute__((hot))
+void hot_attributed_function(void) {
+    /* This function is explicitly hot and should get KCFI preamble.  */
+}
+
+/* Global to prevent optimization from eliminating cold paths.  */
+extern void abort(void);
+
+/* Additional function to test that normal functions still get preambles.  */
+__attribute__((noinline))
+int another_regular_function(int x) {
+    return x + 42;
+}
+
+/* Function designed to generate cold partitions under optimization.  */
+__attribute__((noinline))
+void function_with_cold_partition(int condition) {
+    /* Hot path - very likely to execute.  */
+    if (__builtin_expect(condition == 42, 1)) {
+        /* Simple hot path that optimizer will keep inline.  */
+        return;
+    }
+
+    /* Cold paths that actually do something to prevent elimination.  */
+    if (__builtin_expect(condition < 0, 0)) {
+        /* Error path 1 - call abort to prevent elimination.  */
+        abort();
+    }
+
+    if (__builtin_expect(condition > 1000000, 0)) {
+        /* Error path 2 - call abort to prevent elimination.  */
+        abort();
+    }
+
+    if (__builtin_expect(condition == 999999, 0)) {
+        /* Error path 3 - more substantial cold code.  */
+        volatile int sum = 0;
+        for (volatile int i = 0; i < 100; i++) {
+            sum += i * condition;
+        }
+        if (sum > 0)
+            abort();
+    }
+
+    /* More cold paths - switch with many unlikely cases.  */
+    switch (condition) {
+        case 1000001: case 1000002: case 1000003: case 1000004: case 1000005:
+        case 1000006: case 1000007: case 1000008: case 1000009: case 1000010:
+            /* Each case does some work before abort.  */
+            volatile int work = condition * 2;
+            if (work > 0) abort();
+            break;
+        default:
+            if (condition != 42) {
+                /* Fallback cold path - substantial work.  */
+                volatile int result = 0;
+                for (volatile int j = 0; j < condition % 50; j++) {
+                    result += j;
+                }
+                if (result >= 0) abort();
+            }
+    }
+}
+
+/* Test function pointers to ensure address-taken detection works.  */
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
+    function_with_cold_partition(42); /* Normal case - stay in hot path.  */
+    another_regular_function(5);
+    test_function_pointers();
+    return 0;
+}
+
+/* Regular function should have preamble.  */
+/* { dg-final { scan-assembler "__cfi_regular_function:" } } */
+
+/* Cold-attributed function should STILL have preamble (it's a legitimate function) */
+/* { dg-final { scan-assembler "__cfi_cold_attributed_function:" } } */
+
+/* Hot-attributed function should have preamble.  */
+/* { dg-final { scan-assembler "__cfi_hot_attributed_function:" } } */
+
+/* Function that generates cold partitions should have preamble for main entry.  */
+/* { dg-final { scan-assembler "__cfi_function_with_cold_partition:" } } */
+
+/* Address-taken functions should have preambles.  */
+/* { dg-final { scan-assembler "__cfi_test_function_pointers:" } } */
+
+/* The function should generate a .cold partition (only on targets that support freorder) */
+/* { dg-final { scan-assembler "function_with_cold_partition\\.cold:" { target freorder } } } */
+
+/* The .cold partition should NOT get a __cfi_ preamble since it's never
+   reached via indirect calls.  */
+/* { dg-final { scan-assembler-not "__cfi_function_with_cold_partition\\.cold:" { target freorder } } } */
+
+/* Additional regular function should get preamble.  */
+/* { dg-final { scan-assembler "__cfi_another_regular_function:" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
new file mode 100644
index 000000000000..c48b8d7ad552
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
@@ -0,0 +1,131 @@
+/* Test KCFI with complex addressing modes (structure members, array
+   elements). This is a regression test for the change_address_1 RTL
+   error that occurred when target_addr was PLUS(reg, offset) instead
+   of a simple register.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-O2" } */
+
+struct function_table {
+    int (*callback1)(int);
+    int (*callback2)(int, int);
+    void (*callback3)(void);
+    int (*callback4)(void *, void *, void *, void *, void *, void *);
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
+    /* Empty handler.  */
+}
+
+/* Test indirect calls through structure members - this creates
+   PLUS(reg, offset) addressing.  */
+__attribute__((noinline))
+int test_struct_members(struct function_table *table) {
+    int result = 0;
+    int loop;
+
+    /* These indirect calls will generate complex addressing modes:
+     * call *(%rdi)          - callback1 at offset 0
+     * call *8(%rdi)         - callback2 at offset 8
+     * call *16(%rdi)        - callback3 at offset 16
+     * KCFI must handle PLUS(reg, struct_offset) + kcfi_offset.  */
+
+    for (loop = 0; loop < 16; loop++) {
+        result += table->callback1(10);
+        result += table->callback2(5, 7);
+        table->callback3();
+        result += table->callback4(handler1, handler2, handler3, &result, test_struct_members, table);
+    }
+
+    return result;
+}
+
+/* Test indirect calls through array elements - another source of
+   complex addressing.  */
+typedef int (*func_array_t)(int);
+
+int test_array_elements(func_array_t functions[], int index) {
+    /* This creates addressing like MEM[PLUS(PLUS(reg, index*8), 0)]
+       which should be simplified to MEM[PLUS(reg, index*8)].  */
+    return functions[index](42);
+}
+
+/* Test with global structure.  */
+static struct function_table global_table = {
+    .callback1 = handler1,
+    .callback2 = handler2,
+    .callback3 = handler3,
+    .data = 100
+};
+
+int test_global_struct(void) {
+    /* Access through global structure - may generate different
+       addressing patterns.  */
+    return global_table.callback1(20) + global_table.callback2(3, 4);
+}
+
+/* Test nested structure access.  */
+struct nested_table {
+    struct function_table inner;
+    int extra_data;
+};
+
+int test_nested_struct(struct nested_table *nested) {
+    /* Even more complex addressing: nested structure member access.  */
+    return nested->inner.callback1(15);
+}
+
+int test_many_args(void *one, void *two, void *three, void *four, void *five, void *six)
+{
+    return (unsigned long)one + (unsigned long)two + (unsigned long)three
+	   + (unsigned long)four + (unsigned long)five + (unsigned long)six;
+}
+
+int target_func(int a, int b, int c, int d) { return a + b + c + d; }
+
+/* Function to force r3 spill/reload by using 4+ arguments in indirect call */
+__attribute__((noinline))
+int force_r3_spill(int (*fp)(int, int, int, int)) {
+    int (*ip_reg)(int, int, int, int) = fp;
+    volatile int val = 0;
+    /* This should force r3 as scratch since ip is the target */
+    return ip_reg(val, val, val, val) + 5;
+}
+
+int main() {
+    struct function_table local_table = {
+        .callback1 = handler1,
+        .callback2 = handler2,
+        .callback3 = handler3,
+        .callback4 = test_many_args,
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
+    /* Force r3 spill/reload pattern in ARM32 KCFI */
+    volatile int (*four_arg_ptr)(int, int, int, int) = target_func;
+    result += force_r3_spill(four_arg_ptr);
+
+    result += local_table.callback4(handler1, handler2, handler3, &result, main, &local_table);
+
+    return result;
+}
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.s b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.s
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
new file mode 100644
index 000000000000..a43bcd4f3e3f
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
@@ -0,0 +1,54 @@
+/* Test KCFI IPA pass robustness with compiler-generated constructs.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-O2" } */
+
+#include <stddef.h>
+
+/* Test various compiler-generated constructs that could confuse IPA pass.  */
+
+/* static_assert - this was causing the original crash.  */
+typedef struct {
+    int field1;
+    char field2;
+} test_struct_t;
+
+static_assert(offsetof(test_struct_t, field1) == 0, "layout check 1");
+static_assert(offsetof(test_struct_t, field2) == 4, "layout check 2");
+static_assert(sizeof(test_struct_t) >= 5, "size check");
+
+/* Regular functions that should get KCFI analysis.  */
+void regular_function(void) {
+    /* Should get KCFI preamble.  */
+}
+
+static void static_function(void) {
+    /* With -O2: correctly identified as not address-taken, no preamble.  */
+}
+
+void address_taken_function(void) {
+    /* Should get KCFI preamble (address taken below) */
+}
+
+/* Function pointer to create address-taken scenario.  */
+void (*func_ptr)(void) = address_taken_function;
+
+/* More static_asserts mixed with function definitions.  */
+static_assert(sizeof(void*) >= 4, "pointer size check");
+
+int main(void) {
+    regular_function();    /* Direct call.  */
+    static_function();     /* Direct call to static.  */
+    func_ptr();            /* Indirect call.  */
+
+    static_assert(sizeof(int) == 4, "int size check");
+
+    return 0;
+}
+
+/* Verify KCFI preambles are generated appropriately.  */
+/* { dg-final { scan-assembler "__cfi_regular_function:" } } */
+/* { dg-final { scan-assembler "__cfi_address_taken_function:" } } */
+/* { dg-final { scan-assembler "__cfi_main:" } } */
+
+/* With -O2: static_function correctly identified as not address-taken.  */
+/* { dg-final { scan-assembler-not "__cfi_static_function:" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
new file mode 100644
index 000000000000..7d58fef3f920
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
@@ -0,0 +1,41 @@
+/* Test that KCFI preserves function pointer moves at -O2 optimization.
+   This test ensures that the combine pass doesn't incorrectly optimize away
+   the move instruction needed to transfer function pointers from argument
+   registers to the target registers used by KCFI patterns.  */
+
+/* { dg-do compile } */
+/* { dg-additional-options "-O2 -std=gnu11" } */
+
+static int called_count = 0;
+
+/* Function taking one argument, returning void.  */
+static __attribute__((noinline)) void increment_void(int *counter)
+{
+    (*counter)++;
+}
+
+/* Function taking one argument, returning int.  */
+static __attribute__((noinline)) int increment_int(int *counter)
+{
+    (*counter)++;
+    return *counter;
+}
+
+/* Don't allow the compiler to inline the calls.  */
+static __attribute__((noinline)) void indirect_call(void (*func)(int *))
+{
+    func(&called_count);
+}
+
+int main(void)
+{
+    /* This should work - matching prototype.  */
+    indirect_call(increment_void);
+
+    /* This should trap - mismatched prototype.  */
+    indirect_call((void *)increment_int);
+
+    return 0;
+}
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*|\.section|\.text} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
new file mode 100644
index 000000000000..4a90390d1934
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
@@ -0,0 +1,74 @@
+/* Test that no_sanitize("kcfi") attribute is preserved during inlining.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-O2" } */
+
+extern void external_side_effect(int value);
+
+/* Regular function (should get KCFI checks) */
+__attribute__((noinline))
+void normal_function(void (*callback)(int))
+{
+    /* This indirect call must generate KCFI checks.  */
+    callback(300);
+    external_side_effect(300);
+}
+
+/* Regular function marked with no_sanitize("kcfi") (positive control) */
+__attribute__((noinline, no_sanitize("kcfi")))
+void sensitive_non_inline_function(void (*callback)(int))
+{
+    /* This indirect call should NOT generate KCFI checks.  */
+    callback(100);
+    external_side_effect(100);
+}
+
+/* Function marked with both no_sanitize("kcfi") and always_inline.  */
+__attribute__((always_inline, no_sanitize("kcfi")))
+static inline void sensitive_inline_function(void (*callback)(int))
+{
+    /* This indirect call should NOT generate KCFI checks when inlined.  */
+    callback(42);
+    external_side_effect(42);
+}
+
+/* Explicit wrapper for testing sensitive_inline_function behavior.  */
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
+    /* This indirect call must generate KCFI checks when inlined.  */
+    callback(200);
+    external_side_effect(200);
+}
+
+/* Explicit wrapper for testing normal_inline_function behavior.  */
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
new file mode 100644
index 000000000000..124d26488635
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
@@ -0,0 +1,31 @@
+/* Test KCFI with no_sanitize attribute.  */
+/* { dg-do compile } */
+
+void target_function(void) {
+    /* This should get KCFI preamble.  */
+}
+
+void caller_with_checks(void) {
+    /* This function should generate KCFI checks.  */
+    void (*func_ptr)(void) = target_function;
+    func_ptr();
+}
+
+__attribute__((no_sanitize("kcfi")))
+void caller_no_checks(void) {
+    /* This function should NOT generate KCFI checks due to no_sanitize.  */
+    void (*func_ptr)(void) = target_function;
+    func_ptr();
+}
+
+int main() {
+    caller_with_checks();    /* This should generate checks inside.  */
+    caller_no_checks();      /* This should NOT generate checks inside.  */
+    return 0;
+}
+
+/* All functions should get preambles regardless of no_sanitize.  */
+/* { dg-final { scan-assembler "__cfi_target_function:" } } */
+/* { dg-final { scan-assembler "__cfi_caller_with_checks:" } } */
+/* { dg-final { scan-assembler "__cfi_caller_no_checks:" } } */
+/* { dg-final { scan-assembler "__cfi_main:" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
new file mode 100644
index 000000000000..213a1a2892a5
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
@@ -0,0 +1,24 @@
+/* Test KCFI call-site offset validation across architectures.  */
+/* { dg-do compile } */
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
+    /* Multiple indirect calls.  */
+    ptr_a();
+    ptr_b(1);
+    ptr_c(1, 2);
+
+    return 0;
+}
+
+/* Should have KCFI preambles for all functions.  */
+/* { dg-final { scan-assembler "__cfi_target_func_a:" } } */
+/* { dg-final { scan-assembler "__cfi_target_func_b:" } } */
+/* { dg-final { scan-assembler "__cfi_target_func_c:" } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
new file mode 100644
index 000000000000..a6a2f4816fef
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
@@ -0,0 +1,14 @@
+/* Test KCFI with patchable function entries - entry NOPs only.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-fpatchable-function-entry=4,0" } */
+
+void test_function(void) {
+}
+
+int main() {
+    void (*func_ptr)(void) = test_function;
+    func_ptr();
+    return 0;
+}
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-incompatible.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-incompatible.c
new file mode 100644
index 000000000000..c6cf9ab720a3
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-incompatible.c
@@ -0,0 +1,7 @@
+/* The patchable_function_entry attribute is incompatible with KCFI.  */
+/* { dg-do compile } */
+
+__attribute__((patchable_function_entry(4, 2)))
+int test_function(void) { /* { dg-error "'patchable_function_entry' attribute cannot be used with '-fsanitize=kcfi'" } */
+    return 42;
+}
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
new file mode 100644
index 000000000000..8c4ec30cecc5
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
@@ -0,0 +1,14 @@
+/* Test KCFI with large patchable function entries.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-fpatchable-function-entry=11,11" } */
+
+void test_function(void) {
+}
+
+int main() {
+    void (*func_ptr)(void) = test_function;
+    func_ptr();
+    return 0;
+}
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
new file mode 100644
index 000000000000..78a834ef2a97
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
@@ -0,0 +1,14 @@
+/* Test KCFI with medium patchable function entries.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-fpatchable-function-entry=8,4" } */
+
+void test_function(void) {
+}
+
+int main() {
+    void (*func_ptr)(void) = test_function;
+    func_ptr();
+    return 0;
+}
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
new file mode 100644
index 000000000000..1a4d8269ed56
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
@@ -0,0 +1,14 @@
+/* Test KCFI with patchable function entries - prefix NOPs only.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-fpatchable-function-entry=3,3" } */
+
+void test_function(void) {
+}
+
+int main() {
+    void (*func_ptr)(void) = test_function;
+    func_ptr();
+    return 0;
+}
+
+/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.word} } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
new file mode 100644
index 000000000000..7593a421a4c1
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
@@ -0,0 +1,276 @@
+/* Test KCFI runtime behavior: working calls and type mismatch trapping.  */
+/* { dg-do run { target native } } */
+/* { dg-additional-options "-O2" } */
+
+#include <stdio.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <stdlib.h>
+#include <string.h>
+
+/* Test functions with different signatures */
+static int func_int_void(void)
+{
+    return 42;
+}
+
+__attribute__((nocf_check))
+static int func_int_void_nocf_check(void)
+{
+    return 42;
+}
+
+static int func_int_int(int x)
+{
+    return x * 4;
+}
+
+/* Complex functions with many arguments to create register pressure */
+static long complex_calc_8args(int a, long b, int c, long d,
+                               int e, long f, int g, long h)
+{
+    /* Do actual work with all arguments to keep them live */
+    /* Each calculation uses specific operations to ensure values are preserved */
+    long result = (a * 2) + (b / 3) - (c * 4) + (d / 5) +
+                  (e * 6) - (f / 7) + (g * 8) - (h / 9);
+
+    return result;
+}
+
+static int complex_intermediate_6args(int x1, int x2, int x3,
+                                      int x4, int x5, int x6)
+{
+    /* Keep variables live by using them in multiple calculations */
+    int temp1 = x1 + x2;
+    int temp2 = x3 * x4;
+    int temp3 = x5 - x6;
+
+    /* Call another function with many args through pointer */
+    typedef long (*calc_ptr)(int, long, int, long, int, long, int, long);
+    volatile calc_ptr ptr = complex_calc_8args;
+
+    /* Pass derived values to force register preservation */
+    long result = ptr(temp1, temp2, temp3, x1 * x2,
+                      x3 + x4, x5 * x6, temp1 + temp2, temp3 - x1);
+
+    /* Use original args again to ensure they stayed live */
+    return (int)(result + x1 - x2 + x3 - x4 + x5 - x6);
+}
+
+static int complex_outer_4args(int a, int b, int c, int d)
+{
+    /* Create local variables that must be preserved */
+    int local1 = a * a;
+    int local2 = b * b;
+    int local3 = c * c;
+    int local4 = d * d;
+    volatile int force_spill1 = local1 + local2;
+    volatile int force_spill2 = local3 + local4;
+
+    /* Call through function pointer with many args */
+    typedef int (*inter_ptr)(int, int, int, int, int, int);
+    volatile inter_ptr ptr = complex_intermediate_6args;
+
+    /* Pass combinations that require preserving originals */
+    int result = ptr(local1, local2, local3, local4,
+                     a + b, c + d);
+
+    /* Force use of spilled values */
+    result += force_spill1 + force_spill2;
+
+    /* Use original arguments again */
+    return result + a - b + c - d;
+}
+
+/* Entry point for complex call chain */
+static int complex_entry_point(void)
+{
+    /* Start with many live values */
+    int v1 = 10, v2 = 20, v3 = 30, v4 = 40;
+    int v5 = 50, v6 = 60, v7 = 70, v8 = 80;
+
+    /* Keep them live with volatile stores */
+    volatile int keep_live1 = v1 + v5;
+    volatile int keep_live2 = v2 + v6;
+    volatile int keep_live3 = v3 + v7;
+    volatile int keep_live4 = v4 + v8;
+
+    /* Call through function pointer */
+    typedef int (*outer_ptr)(int, int, int, int);
+    volatile outer_ptr ptr = complex_outer_4args;
+
+    /* Use derived values to maintain register pressure */
+    int result = ptr(v1 * v2, v3 * v4, v5 * v6, v7 * v8);
+
+    /* Force original values to stay live */
+    result += keep_live1 + keep_live2 + keep_live3 + keep_live4;
+    result += v1 + v2 + v3 + v4 + v5 + v6 + v7 + v8;
+
+    /* Return the calculated result */
+    return result;
+}
+
+/* Global state for signal handling */
+static volatile int trap_occurred = 0;
+static jmp_buf trap_env;
+
+/* Signal handler for KCFI traps */
+static void trap_handler(int sig)
+{
+    trap_occurred = 1;
+    longjmp(trap_env, 1);
+}
+
+/* Compatible indirect call should work - simple version */
+static int test_compatible_call(void)
+{
+    typedef int (*int_void_ptr)(void);
+    volatile int_void_ptr ptr = func_int_void;
+
+    fprintf(stderr, "Calling %s(0x%08x) through %s(0x%08x) ...\n",
+	    __builtin_typeinfo_name(typeof(func_int_void)),
+	    __builtin_typeinfo_hash(typeof(func_int_void)),
+	    __builtin_typeinfo_name(typeof(*ptr)),
+	    __builtin_typeinfo_hash(typeof(*ptr)));
+
+    trap_occurred = 0;
+    /* This should work - same signature */
+    int result = ptr();
+
+    return (trap_occurred == 0 && result == 42) ? 1 : 0;
+}
+
+/* Compatible indirect call with complex register pressure */
+static int test_compatible_call_complex(void)
+{
+    typedef int (*int_void_ptr)(void);
+    volatile int_void_ptr ptr = complex_entry_point;
+
+    fprintf(stderr, "Calling complex chain %s(0x%08x) through %s(0x%08x) ...\n",
+	    __builtin_typeinfo_name(typeof(complex_entry_point)),
+	    __builtin_typeinfo_hash(typeof(complex_entry_point)),
+	    __builtin_typeinfo_name(typeof(*ptr)),
+	    __builtin_typeinfo_hash(typeof(*ptr)));
+
+    trap_occurred = 0;
+
+    /* This should work - complex call chain with register pressure */
+    int result = ptr();
+
+    /* Verify the complete call chain computed correctly with all register
+       values preserved through the high-pressure call sequence */
+    if (result != 657383831) {
+        fprintf(stderr, "ERROR: Incorrect final result %d (expected 657383831)\n", result);
+        return 0;
+    }
+
+    /* Check that no trap occurred and result is correct */
+    return (trap_occurred == 0) ? 1 : 0;
+}
+
+/* Compatible indirect call to nocf_check should not work */
+static int test_nocf_check_trap(void)
+{
+    trap_occurred = 0;
+
+    if (setjmp(trap_env) == 0) {
+      typedef int (__attribute__((nocf_check)) *int_void_ptr_nocf)(void);
+      volatile int_void_ptr_nocf ptr = func_int_void_nocf_check;
+
+      fprintf(stderr, "Calling %s(0x%08x) through %s(0x%08x) ...\n",
+	      __builtin_typeinfo_name(typeof(func_int_void_nocf_check)),
+	      __builtin_typeinfo_hash(typeof(func_int_void_nocf_check)),
+	      __builtin_typeinfo_name(typeof(*ptr)),
+	      __builtin_typeinfo_hash(typeof(*ptr)));
+
+      int result = ptr();
+
+      fprintf(stderr, "Yikes! Survived nocf_check call\n");
+
+      /* If we get here, the trap didn't occur */
+      return 0;
+    } else {
+      /* We caught the trap - this is expected */
+      return trap_occurred;
+    }
+}
+
+/* Type mismatch should trap */
+static int test_type_mismatch_trap(void)
+{
+    trap_occurred = 0;
+
+    if (setjmp(trap_env) == 0) {
+      /* Cast func_int_void to incompatible void(*)(void) type */
+      typedef void (*void_void_ptr)(void);
+      volatile void_void_ptr ptr = (void_void_ptr)func_int_void;
+
+      fprintf(stderr, "Calling %s(0x%08x) through %s(0x%08x) ...\n",
+	      __builtin_typeinfo_name(typeof(func_int_void)),
+	      __builtin_typeinfo_hash(typeof(func_int_void)),
+	      __builtin_typeinfo_name(typeof(*ptr)),
+	      __builtin_typeinfo_hash(typeof(*ptr)));
+
+      /* This should trap because type IDs don't match:
+         - func_int_void has type ID for int(void)
+         - but we're calling through void(void) pointer type */
+      ptr();
+
+      fprintf(stderr, "Yikes! Survived mismatched call\n");
+
+      /* If we get here, the trap didn't occur */
+      return 0;
+    } else {
+      /* We caught the trap - this is expected */
+      return trap_occurred;
+    }
+}
+
+int main(void)
+{
+    struct sigaction sa = {
+      .sa_handler = trap_handler,
+      .sa_flags = SA_NODEFER,
+    };
+    int failed = 4;
+
+    /* Install trap handler.  */
+    if (sigaction(SIGILL, &sa, NULL)) {
+      perror("sigaction");
+      return 1;
+    }
+
+    /* Simple compatible call should work */
+    if (test_compatible_call()) {
+      printf("OK: simple matched indirect call succeeded\n");
+      failed--;
+    } else {
+      printf("FAIL: simple matched call\n");
+    }
+
+    /* Complex compatible call chain should work */
+    if (test_compatible_call_complex()) {
+      printf("OK: complex matched indirect call chain succeeded\n");
+      failed--;
+    } else {
+      printf("FAIL: complex matched call chain\n");
+    }
+
+    /* Using nocf_check should trap */
+    if (test_nocf_check_trap()) {
+      printf("OK: indirect call to nocf_check correctly trapped\n");
+      failed--;
+    } else {
+      printf("FAIL: nocf_check trap\n");
+    }
+
+    /* Type mismatch should trap */
+    if (test_type_mismatch_trap()) {
+      printf("OK: mismatched indirect call correctly trapped\n");
+      failed--;
+    } else {
+      printf("FAIL: type mismatch trap\n");
+    }
+
+    return failed;
+}
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
new file mode 100644
index 000000000000..9ddf178aa2b1
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
@@ -0,0 +1,60 @@
+/* Test KCFI protection when indirect calls get converted to tail calls.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-O2" } */
+
+typedef int (*func_ptr_t)(int);
+typedef void (*void_func_ptr_t)(void);
+
+struct function_table {
+    func_ptr_t process;
+    void_func_ptr_t cleanup;
+};
+
+/* Target functions.  */
+int process_data(int x) { return x * 2; }
+void cleanup_data(void) {}
+
+/* Initialize function table.  */
+volatile struct function_table vtable = {
+    .process = &process_data,
+    .cleanup = &cleanup_data
+};
+
+/* Indirect call through struct member that should become tail call.  */
+int test_struct_indirect_call(int x) {
+    /* This is an indirect call that should be converted to tail call:
+       Without -fno-optimize-sibling-calls should become "jmp *vtable+0(%rip)"
+       With -fno-optimize-sibling-calls should become "call *vtable+0(%rip)"  */
+    return vtable.process(x);
+}
+
+/* Indirect call through function pointer parameter.  */
+int test_param_indirect_call(func_ptr_t handler, int x) {
+    /* This is an indirect call that should be converted to tail call:
+       Without -fno-optimize-sibling-calls should become "jmp *%rdi"
+       With -fno-optimize-sibling-calls should be "call *%rdi"  */
+    return handler(x);
+}
+
+/* Void indirect call through struct member.  */
+void test_void_indirect_call(void) {
+    /* This is an indirect call that should be converted to tail call:
+     * Without -fno-optimize-sibling-calls: should become "jmp *vtable+8(%rip)"
+     * With -fno-optimize-sibling-calls: should be "call *vtable+8(%rip)"  */
+    vtable.cleanup();
+}
+
+/* Non-tail call for comparison (should always be call).  */
+int test_non_tail_indirect_call(func_ptr_t handler, int x) {
+    /* This should never become a tail call - always "call *%rdi"  */
+    int result = handler(x);
+    return result + 1;  /* Prevents tail call optimization.  */
+}
+
+/* Should have KCFI preambles for all functions.  */
+/* { dg-final { scan-assembler-times "__cfi_process_data:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_cleanup_data:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_test_struct_indirect_call:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_test_param_indirect_call:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_test_void_indirect_call:" 1 } } */
+/* { dg-final { scan-assembler-times "__cfi_test_non_tail_indirect_call:" 1 } } */
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
new file mode 100644
index 000000000000..6d34ad6e1a0c
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
@@ -0,0 +1,17 @@
+/* Test KCFI trap section generation.  */
+/* { dg-do compile } */
+
+void target_function(void) {}
+
+int main() {
+    void (*func_ptr)(void) = target_function;
+
+    /* Multiple indirect calls to generate multiple trap entries.  */
+    func_ptr();
+    func_ptr();
+
+    return 0;
+}
+
+/* Should have KCFI preamble.  */
+/* { dg-final { scan-assembler "__cfi_target_function:" } } */
-- 
2.34.1

