Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38C828D8DA;
	Thu, 18 Jun 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781811612; cv=none; b=Ipd8YqKTXg3OU2Nz/DysCQMrQ/eoPsCVnP/zdl9KqjOtvo0nkOgYI0dsECVxgzYqv/8Uyc06b4KxArPfEYpqwYLjq5lqZdN0J3tf7l0jqdnYc6T3a2gN5TSBTlKuw082THjhqHVgHjRn7rI/d25uK+nj/oX6AtttmuQKrChEYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781811612; c=relaxed/simple;
	bh=szhvhVk/2VIeUsNQ7v2pHIcUvWY4M9kFAyN/lZ1+s8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eFs5TnjLv7w36UTQlX0ZloDjUj6DpwDfz2GNTfhaK+FG9rlMuPe410Bl4Vq+GkGq1LMHDRk09qBS+W3jqoOQ6sqOaTYvSup6NM8xueAJZ/ZA5x7ShFoEUlC2z3hy8XH4ArKHTC8rVsXSoO7IV1Hh+eycjB1WQ0ZXCclV8esFwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOfa0gOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOfa0gOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8311F000E9;
	Thu, 18 Jun 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781811610;
	bh=X0NatULc6wFurB+L4ivEI6zWkmyswODn4cs0cESh/48=;
	h=From:To:Cc:Subject:Date;
	b=NOfa0gOn80A3YFRDsIHKXKhAUdAbIrtsBF3rDpqjeWlqXzMI/t37CvmrOl/Fx4U7q
	 q2FZLFuDANxZZzRPb0etsEGJ2Ob4jFQRMvw9uoEdRrW+eFl3ZadYfosIqAK5SvRUi+
	 bKMxytpWHwe3vPIfTVMgKKWvYBsIulkN625PutRJKYLfNxZoWJf7cUUyerg5qR9Ykm
	 OfU9Cy4fjC00NSaRtMDkEgH+h9GAtgycBpAxVVeWGLogzca/H7bJpzn7VLGDld/NZa
	 4arNof0pTjT0oJiVOs4IsVwAMvtogAqlljd3xMP1KZXxPJhgAbWW9WdBjL1fk5LyeQ
	 G4R9fURoPT8hA==
From: Kees Cook <kees@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	llvm@lists.linux.dev,
	kunit-dev@googlegroups.com,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] kunit: cfi: Add test for kCFI indirect-call type checks
Date: Thu, 18 Jun 2026 12:40:06 -0700
Message-Id: <20260618194001.work.490-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17644; i=kees@kernel.org; h=from:subject:message-id; bh=szhvhVk/2VIeUsNQ7v2pHIcUvWY4M9kFAyN/lZ1+s8c=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkmnlPdhPl0f/FruX87rFQeszFoj/Cse1EdR6J1LZxSP 4g73vncUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJErRxgZvhXt2K45l/v4zOqG M0HP0z3tHVIq7fRXXTlr4S7nonnvKSPDEQX2zN5Mxecui5sd4g2OK6mXv+y6E57Fqnjyv82OxBh GAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

drivers/misc/lkdtm/cfi.c already exercises kCFI's forward-edge check
via a debugfs trigger, but it is awkward to run from automated CI and
is gated on LKDTM being built in. Add a self-contained kunit test that
performs the same kind of indirect call through a deliberately-cast
function pointer and validates that kCFI catches the mismatch, plus
coverage that well-typed indirect calls are left undisturbed.

A deliberate kCFI violation is normally fatal: with
CONFIG_CFI_PERMISSIVE=n it kills the calling thread, and on architectures
where an in-kernel breakpoint is taken in NMI context (e.g. riscv)
it cannot even do that and panics the machine instead. To test the
check without depending on any of that, when CONFIG_CFI_KUNIT_TEST=y,
kernel/cfi.c grows a small hook, cfi_kunit_set_failure_hook(), consulted
by report_cfi_failure() on every kCFI trap. When the registered hook
counts the trap, the report is suppressed and BUG_TRAP_TYPE_WARN is
returned, so the arch trap handler skips the trapping instruction
and resumes the thread: the same "report and continue" path as
CFI_PERMISSIVE=y, but independent of how CFI_PERMISSIVE is configured. The
hook only ever claims a failure that fired during the test that armed
it (matched via the current task's kunit pointer), so any other CFI
failure behaves normally. It runs in trap context, possibly NMI-like,
so it stays lock-free.

With that in place, the kunit kCFI test adds the following tests:

 - forward_proto: an indirect call through a "void (*)(int *)" pointer
   to an "int (*)(int *)" callee, which must trip kCFI exactly once.

 - baseline: the same call with a matched prototype must not trip kCFI
   and must increment its counter (to show it actually got called).

 - arity sweep: matched-prototype indirect tail calls across increasing
   arity (1 to 7 arguments) must not trip kCFI and must return the right
   values. kCFI's instrumentation uses scratch registers to perform the
   typeid lookup and validation, which can compete with the argument
   registers on register-starved ABIs (e.g. arm32's r0-r3, which also
   forces a spill to the stack). A GCC arm32 kCFI codegen bug was
   observed where the callee pointer never reached the call register in
   a high-arity indirect tail call, leaving the kCFI prologue to read its
   typeid from a stale register and trapping a perfectly well-typed call.

The test lives in the new kernel/tests/ subdirectory rather than under
lib/tests/, since the code under test (kernel/cfi.c) lives in kernel/;
kernel/Makefile is taught to descend into tests/ when CONFIG_KUNIT is
set. The Kconfig sits next to "config CFI" and "config CFI_PERMISSIVE"
in arch/Kconfig and depends only on "KUNIT": the well-typed baseline
and arity cases exercise indirect-call codegen regardless of CFI,
while the mismatch case skips at runtime when CONFIG_CFI=n. The hook
makes that case work with CFI_PERMISSIVE either enabled or disabled.

This test is the first place that includes <linux/cfi.h> without
<linux/uaccess.h> already being in scope, so cfi.h is made self-contained
by including <linux/uaccess.h> for the get_kernel_nofault() it uses
in cfi_get_func_hash().

The mismatched-prototype call uses the same "(void *)" intermediate
cast that LKDTM uses, which is enough to silence -Wcast-function-type
on the intentional mis-cast.

Build and boot tested with GCC 17.0.0 20260615 (with my
experimental kCFI series); all three kunit cases pass under qemu via
tools/testing/kunit/kunit.py for ARCH=x86_64 (CFI_PERMISSIVE both n and
y), ARCH=arm64, ARCH=arm, and ARCH=riscv.

Assisted-by: Claude:claude-opus-4-8[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <david@davidgow.net>
Cc: Rae Moar <raemoar63@gmail.com>
Cc: llvm@lists.linux.dev
Cc: kunit-dev@googlegroups.com
---
 arch/Kconfig             |  15 +++
 kernel/Makefile          |   1 +
 kernel/tests/Makefile    |   5 +
 include/linux/cfi.h      |  17 +++
 kernel/cfi.c             |  28 ++++
 kernel/tests/cfi_kunit.c | 268 +++++++++++++++++++++++++++++++++++++++
 MAINTAINERS              |   1 +
 7 files changed, 335 insertions(+)
 create mode 100644 kernel/tests/Makefile
 create mode 100644 kernel/tests/cfi_kunit.c

diff --git a/arch/Kconfig b/arch/Kconfig
index e86880045158..c463b6f2960b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -983,6 +983,21 @@ config CFI_PERMISSIVE
 
 	  If unsure, say N.
 
+config CFI_KUNIT_TEST
+	tristate "KUnit test kCFI indirect-call type checks at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds a KUnit test that triggers kCFI type mismatches on real
+	  indirect calls and verifies that the violations are detected, and
+	  that well-typed indirect calls (including high-arity ones) are not
+	  disturbed. The test registers a hook in the kCFI failure path so
+	  its deliberate violations are counted and survived on its own
+	  threads, so it works with CFI_PERMISSIVE either enabled or disabled.
+
+	  For the fatal-trap behavior of a real violation, see LKDTM's "CFI_*"
+	  tests.
+
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/kernel/Makefile b/kernel/Makefile
index 6785982013dc..448de4fff75c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -59,6 +59,7 @@ obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
+obj-$(CONFIG_KUNIT) += tests/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/tests/Makefile b/kernel/tests/Makefile
new file mode 100644
index 000000000000..70f1f9a5c502
--- /dev/null
+++ b/kernel/tests/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for tests of kernel/ functions.
+
+obj-$(CONFIG_CFI_KUNIT_TEST) += cfi_kunit.o
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 0f220d29225c..e4e66a9423ca 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -24,6 +24,18 @@ static inline enum bug_trap_type report_cfi_failure_noaddr(struct pt_regs *regs,
 	return report_cfi_failure(regs, addr, NULL, 0);
 }
 
+#if IS_ENABLED(CONFIG_CFI_KUNIT_TEST)
+/*
+ * Register a hook consulted by report_cfi_failure() on every kCFI trap. If
+ * the hook returns true, the failure is treated as handled: the report is
+ * suppressed and BUG_TRAP_TYPE_WARN is returned so the arch trap handler
+ * skips the trapping instruction and resumes, regardless of CFI_PERMISSIVE.
+ * This lets the kCFI KUnit test count deliberate violations on its own
+ * threads without killing them. Pass NULL to unregister.
+ */
+void cfi_kunit_set_failure_hook(bool (*hook)(void));
+#endif
+
 #ifndef cfi_get_offset
 /*
  * Returns the CFI prefix offset. By default, the compiler emits only
@@ -58,6 +70,11 @@ extern u32 cfi_bpf_subprog_hash;
 static inline int cfi_get_offset(void) { return 0; }
 static inline u32 cfi_get_func_hash(void *func) { return 0; }
 
+#if IS_ENABLED(CONFIG_CFI_KUNIT_TEST)
+/* No kCFI traps to hook when CONFIG_CFI=n; the test skips at runtime. */
+static inline void cfi_kunit_set_failure_hook(bool (*hook)(void)) { }
+#endif
+
 #define cfi_bpf_hash 0U
 #define cfi_bpf_subprog_hash 0U
 
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 4dad04ead06c..28e5c915ccc9 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -11,9 +11,37 @@
 
 bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);
 
+#if IS_ENABLED(CONFIG_CFI_KUNIT_TEST)
+static bool (*cfi_kunit_failure_hook)(void);
+
+void cfi_kunit_set_failure_hook(bool (*hook)(void))
+{
+	WRITE_ONCE(cfi_kunit_failure_hook, hook);
+}
+EXPORT_SYMBOL_GPL(cfi_kunit_set_failure_hook);
+
+static bool cfi_kunit_handled(void)
+{
+	bool (*hook)(void) = READ_ONCE(cfi_kunit_failure_hook);
+
+	return hook && hook();
+}
+#else
+static inline bool cfi_kunit_handled(void) { return false; }
+#endif
+
 enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 				      unsigned long *target, u32 type)
 {
+	/*
+	 * Let a registered KUnit test consume and count its own deliberate
+	 * violations. If it claims the failure, suppress the report and tell
+	 * the arch handler to skip the trap and resume the thread, regardless
+	 * of CFI_PERMISSIVE.
+	 */
+	if (cfi_kunit_handled())
+		return BUG_TRAP_TYPE_WARN;
+
 	if (target)
 		pr_err("CFI failure at %pS (target: %pS; expected type: 0x%08x)\n",
 		       (void *)addr, (void *)*target, type);
diff --git a/kernel/tests/cfi_kunit.c b/kernel/tests/cfi_kunit.c
new file mode 100644
index 000000000000..cbbdc7783688
--- /dev/null
+++ b/kernel/tests/cfi_kunit.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for Kernel Control Flow Integrity (kCFI).
+ *
+ * Exercises properties of the compiler's KCFI indirect-call checks:
+ *
+ * Mirrors drivers/misc/lkdtm/cfi.c's CFI_FORWARD_PROTO test, but as a
+ * self-contained kunit suite that drives kernel/cfi.c via the standard
+ * indirect-call path. For the fatal-trap behavior of a real violation, see
+ * LKDTM's "CFI_*" tests.
+ */
+
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <linux/cfi.h>
+
+/*
+ * The test case currently expecting to count kCFI traps, and its running
+ * count. Only ever touched for the test that armed cfi_kunit_active, so a
+ * single counter is safe without locking.
+ */
+static struct kunit *cfi_kunit_active;
+static int cfi_kunit_trap_count;
+
+/*
+ * Consulted from report_cfi_failure() in kCFI trap context, which may be
+ * NMI-like (e.g. riscv kernel breakpoints), so this must stay lock-free: it
+ * only reads the current task's kunit pointer and touches module-static
+ * counters. It claims the failure by counting it and asking the arch handler
+ * to skip the trap and resume, but only when the trap fired on the very test
+ * that armed us. Any other CFI failure is left to behave normally.
+ */
+static bool cfi_kunit_failure_hook(void)
+{
+	if (kunit_get_current_test() != READ_ONCE(cfi_kunit_active))
+		return false;
+
+	cfi_kunit_trap_count++;
+	return true;
+}
+
+static int called_count;
+
+/*
+ * Two same-arity, same-arg-type callees with deliberately different return
+ * types so that kCFI's type-hash check at the call site catches the cast.
+ */
+static noinline void cfi_increment_void(int *counter)
+{
+	(*counter)++;
+}
+
+static noinline int cfi_increment_int(int *counter)
+{
+	(*counter)++;
+	return *counter;
+}
+
+/*
+ * The indirect call site. Type of the function pointer is what kCFI
+ * compares against the hash baked into the callee's __cfi_<name> prefix.
+ */
+static noinline void cfi_indirect_call(void (*func)(int *))
+{
+	func(&called_count);
+}
+
+/*
+ * Increasing-arity callees. Each returns a position-weighted sum of its
+ * arguments so that a dropped, reordered, or zeroed argument produces a wrong
+ * result rather than a coincidental match. Called with args (1, 2, 3, ...),
+ * cfi_arityN() returns sum(i*i) for i in 1..N.
+ */
+static noinline int cfi_arity1(int a)
+{
+	return a;
+}
+
+static noinline int cfi_arity2(int a, int b)
+{
+	return a + 2 * b;
+}
+
+static noinline int cfi_arity3(int a, int b, int c)
+{
+	return a + 2 * b + 3 * c;
+}
+
+static noinline int cfi_arity4(int a, int b, int c, int d)
+{
+	return a + 2 * b + 3 * c + 4 * d;
+}
+
+static noinline int cfi_arity5(int a, int b, int c, int d, int e)
+{
+	return a + 2 * b + 3 * c + 4 * d + 5 * e;
+}
+
+static noinline int cfi_arity6(int a, int b, int c, int d, int e, int f)
+{
+	return a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * f;
+}
+
+static noinline int cfi_arity7(int a, int b, int c, int d, int e, int f, int g)
+{
+	return a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * f + 7 * g;
+}
+
+/*
+ * Tail-calling trampolines: each receives the callee as an opaque pointer
+ * (defeating optimization) plus the arguments, then `return fn(args)` as
+ * its final statement so the compiler lowers it to an indirect tail call.
+ * Arity grows so the callee pointer and the kCFI scratch registers
+ * increasingly contend with argument registers.
+ */
+static noinline int cfi_tail_call1(int (*fn)(int), int a)
+{
+	return fn(a);
+}
+
+static noinline int cfi_tail_call2(int (*fn)(int, int), int a, int b)
+{
+	return fn(a, b);
+}
+
+static noinline int cfi_tail_call3(int (*fn)(int, int, int),
+				   int a, int b, int c)
+{
+	return fn(a, b, c);
+}
+
+static noinline int cfi_tail_call4(int (*fn)(int, int, int, int),
+				   int a, int b, int c, int d)
+{
+	return fn(a, b, c, d);
+}
+
+static noinline int cfi_tail_call5(int (*fn)(int, int, int, int, int),
+				   int a, int b, int c, int d, int e)
+{
+	return fn(a, b, c, d, e);
+}
+
+static noinline int cfi_tail_call6(int (*fn)(int, int, int, int, int, int),
+				   int a, int b, int c, int d, int e, int f)
+{
+	return fn(a, b, c, d, e, f);
+}
+
+static noinline int cfi_tail_call7(int (*fn)(int, int, int, int, int, int, int),
+				   int a, int b, int c, int d, int e, int f,
+				   int g)
+{
+	return fn(a, b, c, d, e, f, g);
+}
+
+#define CFI_MAX_ARITY 7
+
+static void cfi_kunit_forward_proto_traps(struct kunit *test)
+{
+	int before_traps = cfi_kunit_trap_count;
+
+	/* Only this case needs kCFI; the well-typed cases below run regardless. */
+	if (!IS_ENABLED(CONFIG_CFI))
+		kunit_skip(test, "kCFI is not enabled (CONFIG_CFI=n)");
+
+	/*
+	 * Force a kCFI type mismatch: the call site expects a callee whose
+	 * __cfi_ prefix encodes "void (*)(int *)", but the actual callee's
+	 * prefix encodes "int (*)(int *)". The (void *) intermediate cast
+	 * follows drivers/misc/lkdtm/cfi.c and sidesteps -Wcast-function-type
+	 * on the deliberate mis-cast.
+	 *
+	 * kCFI must detect this. The failure hook counts the trap and lets us
+	 * survive it, so control returns here normally.
+	 */
+	cfi_indirect_call((void *)cfi_increment_int);
+
+	KUNIT_EXPECT_EQ_MSG(test, cfi_kunit_trap_count, before_traps + 1,
+			    "mismatched-prototype indirect call was not caught by kCFI\n");
+}
+
+static void cfi_kunit_baseline_matched_proto(struct kunit *test)
+{
+	int before_traps = cfi_kunit_trap_count;
+	int before_calls = called_count;
+
+	/* Matched prototype: must NOT trap and must increment the counter. */
+	cfi_indirect_call(cfi_increment_void);
+	KUNIT_EXPECT_EQ(test, called_count, before_calls + 1);
+	KUNIT_EXPECT_EQ_MSG(test, cfi_kunit_trap_count, before_traps,
+			    "well-typed indirect call spuriously tripped kCFI\n");
+}
+
+static void cfi_kunit_arity_matched_calls(struct kunit *test)
+{
+	/* expected[N] = sum(i*i) for i in 1..N */
+	static const int expected[CFI_MAX_ARITY + 1] = {
+		0, 1, 5, 14, 30, 55, 91, 140,
+	};
+	int before_traps = cfi_kunit_trap_count;
+	int results[CFI_MAX_ARITY + 1];
+	int i;
+
+	results[1] = cfi_tail_call1(cfi_arity1, 1);
+	results[2] = cfi_tail_call2(cfi_arity2, 1, 2);
+	results[3] = cfi_tail_call3(cfi_arity3, 1, 2, 3);
+	results[4] = cfi_tail_call4(cfi_arity4, 1, 2, 3, 4);
+	results[5] = cfi_tail_call5(cfi_arity5, 1, 2, 3, 4, 5);
+	results[6] = cfi_tail_call6(cfi_arity6, 1, 2, 3, 4, 5, 6);
+	results[7] = cfi_tail_call7(cfi_arity7, 1, 2, 3, 4, 5, 6, 7);
+
+	for (i = 1; i <= CFI_MAX_ARITY; i++)
+		KUNIT_EXPECT_EQ_MSG(test, results[i], expected[i],
+				    "arity-%d matched indirect call returned %d, expected %d\n",
+				    i, results[i], expected[i]);
+
+	/*
+	 * None of the matched calls may trip kCFI. A spurious trap here is a
+	 * codegen bug, most likely the callee pointer never reaching the call
+	 * register under argument-register pressure.
+	 */
+	KUNIT_EXPECT_EQ_MSG(test, cfi_kunit_trap_count, before_traps,
+			    "a matched-prototype indirect call tripped kCFI under register pressure (codegen bug)\n");
+}
+
+static int cfi_kunit_init(struct kunit *test)
+{
+	cfi_kunit_trap_count = 0;
+	WRITE_ONCE(cfi_kunit_active, test);
+	return 0;
+}
+
+static void cfi_kunit_exit(struct kunit *test)
+{
+	WRITE_ONCE(cfi_kunit_active, NULL);
+}
+
+static int cfi_kunit_suite_init(struct kunit_suite *suite)
+{
+	cfi_kunit_set_failure_hook(cfi_kunit_failure_hook);
+	return 0;
+}
+
+static void cfi_kunit_suite_exit(struct kunit_suite *suite)
+{
+	cfi_kunit_set_failure_hook(NULL);
+}
+
+static struct kunit_case cfi_kunit_cases[] = {
+	KUNIT_CASE(cfi_kunit_baseline_matched_proto),
+	KUNIT_CASE(cfi_kunit_arity_matched_calls),
+	KUNIT_CASE(cfi_kunit_forward_proto_traps),
+	{}
+};
+
+static struct kunit_suite cfi_kunit_suite = {
+	.name = "cfi",
+	.init = cfi_kunit_init,
+	.exit = cfi_kunit_exit,
+	.suite_init = cfi_kunit_suite_init,
+	.suite_exit = cfi_kunit_suite_exit,
+	.test_cases = cfi_kunit_cases,
+};
+kunit_test_suite(cfi_kunit_suite);
+
+MODULE_DESCRIPTION("KUnit tests for kCFI indirect-call type checks");
+MODULE_LICENSE("GPL");
diff --git a/MAINTAINERS b/MAINTAINERS
index c8d4b913f26c..8c704a24136b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6252,6 +6252,7 @@ B:	https://github.com/ClangBuiltLinux/linux/issues
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	include/linux/cfi.h
 F:	kernel/cfi.c
+F:	kernel/tests/cfi_kunit.c
 
 CLANG-FORMAT FILE
 M:	Miguel Ojeda <ojeda@kernel.org>
-- 
2.34.1

