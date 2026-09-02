Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234647F782
	for <linux-hardening@vger.kernel.org>; Wed,  2 Sep 2026 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367780; cv=none; b=ijanUMajJA6hcgGFR5clDyHOJB6VcKjlQgc6ji8snscNbK2mM6Nruy4SJpb8O59QTCtmGdkakOO7o+O2UxGsCtGHOAEccpcslOGLEmpkfOwGqJVNT+++aRbe1RipHIsUCZ5z4WwcLPbuQ4gTYyFp1CVsT+o/25xNyrPuib5KdKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367780; c=relaxed/simple;
	bh=9shNRnPqe5mFjJZHqKaiw86lYkcbposuK+XA3Z7vWns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKVcVlXCPmhc2o/LPONgT7ggsMCII/KVfg1d+LE7NVZrCcO5AEuLb94zSD7z2APlngm0agp5NbF4I3y/MchVxopGTQHOXkYv3b0tVNCTaVcrmTwgq5IutroAWhdXmE+NcRq147fzkmplkkl/UIDB6LVY53d+pTYInlgYhWpZA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA9zxCi5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA9zxCi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8401F00A3E;
	Wed,  2 Sep 2026 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367776;
	bh=qnSFWRH9edHDq7j+QJIeR8F6vQ8iCKLGPNuIYi0UWFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kA9zxCi5xkvPth8eGOsSv+Ysn1JqCYoDcyEkMuHM/5izGUkBZY0El+uz7jIyaFHM7
	 YUfJvuyph1I+qZqrtBV2NucrsOrRdKneYOsHUFGy4pM8ZadujDLh/R7GenuhpkTw7r
	 ZydInGxdK9FiX6D0MTetWL/TTN/wfRLhXMueimelsOQ2LS2sg5scxFnRNF9cfbQ8kD
	 XeIu964dHLz9C+H23I9ljNFoZEKEK2I3n7gQJYI4h0yKbehnIdvnP0nqkEdm7MzpHT
	 BSv/wazGp+OMw7vp3nYqLpJxNVnvroAvlc9h7WpCZEmuEtoVN8QzO6Cu5wRh3OJtDO
	 lZfJBk+B8NBCg==
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
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
	"Osterlund Sebastian" <sebastian.osterlund@intel.com>,
	"Constable Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v16 3/7] kcfi: Add regression test suite
Date: Wed,  2 Sep 2026 09:49:28 -0700
Message-Id: <20260902164935.1390773-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902164928.stay.466-kees@kernel.org>
References: <20260902164928.stay.466-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=64514; i=kees@kernel.org; h=from:subject; bh=9shNRnPqe5mFjJZHqKaiw86lYkcbposuK+XA3Z7vWns=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkzgmepbNGoqZYzu7Hw4w9v5hMvapPSNje/jRU8L+1hG 5S5/9qbjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl0TGf47+B/xvZj1Hy2Wea3 qxjzHhzjf6AW+Dz5Qp8kl7TF4cNnBBkZrqmHXOuc5lFzs03267MHStZfoksuPv7Ucp4pZultn2g 9BgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
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
	* gcc.dg/kcfi/kcfi-asm-name.c: New test.
	* gcc.dg/kcfi/kcfi-basics.c: New test.
	* gcc.dg/kcfi/kcfi-call-sharing.c: New test.
	* gcc.dg/kcfi/kcfi-cold-partition.c: New test.
	* gcc.dg/kcfi/kcfi-complex-addressing.c: New test.
	* gcc.dg/kcfi/kcfi-direct-call-shapes.c: New test.
	* gcc.dg/kcfi/kcfi-ipa-robustness.c: New test.
	* gcc.dg/kcfi/kcfi-lto-offset.c: New test.
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
	* gcc.dg/kcfi-compat/kcfi-compat.exp: Add kcfi compat tests.
	* gcc.dg/kcfi-compat/kcfi-indirect-1.h: New test header.
	* gcc.dg/kcfi-compat/kcfi-indirect-1_main.c: New test main.
	* gcc.dg/kcfi-compat/kcfi-indirect-1_x.c: New test caller half.
	* gcc.dg/kcfi-compat/kcfi-indirect-1_y.c: New test target half.
	* gcc.dg/pch/kcfi-1.c: New test.
	* gcc.dg/pch/kcfi-1.hs: New test header.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 .../gcc.dg/kcfi-compat/kcfi-compat.exp        |  87 ++++++
 gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  51 ++++
 gcc/testsuite/lib/target-supports.exp         |  14 +
 .../gcc.dg/kcfi-compat/kcfi-indirect-1.h      |  22 ++
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_main.c |  22 ++
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_x.c    |  37 +++
 .../gcc.dg/kcfi-compat/kcfi-indirect-1_y.c    |  34 +++
 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  49 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c     |  16 +
 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  74 +++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  61 ++++
 .../gcc.dg/kcfi/kcfi-cold-partition.c         | 126 ++++++++
 .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 131 +++++++++
 .../gcc.dg/kcfi/kcfi-direct-call-shapes.c     |  28 ++
 .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 ++++
 gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c   |  26 ++
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
 gcc/testsuite/gcc.dg/pch/kcfi-1.c             |  50 ++++
 gcc/testsuite/gcc.dg/pch/kcfi-1.hs            |  20 ++
 30 files changed, 1488 insertions(+)
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-compat.exp
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1.h
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_main.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_x.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_y.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
 create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c
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
 create mode 100644 gcc/testsuite/gcc.dg/pch/kcfi-1.c
 create mode 100644 gcc/testsuite/gcc.dg/pch/kcfi-1.hs

diff --git a/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-compat.exp b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-compat.exp
new file mode 100644
index 000000000000..973a92a8ad0c
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-compat.exp
@@ -0,0 +1,87 @@
+# KCFI cross-TU / cross-compiler indirect-call ABI compatibility tests.
+#   Copyright (C) 2026 Free Software Foundation, Inc.
+#
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
+# Split each test into separately-compiled halves and verify that KCFI
+# indirect-call checks pass across the object boundary (i.e. that two
+# independent compilations agree on the type-id ABI).  The _x TU is the
+# indirect caller and the _y TU holds the targets; the framework builds
+# each with the compiler under test and, when an alternate compiler is
+# configured, in every combination, so both compilers are exercised as
+# caller and as target.
+#
+# By default both halves are built with the compiler under test.  To check
+# cross-compiler agreement with clang, pass ALT_CC_UNDER_TEST as a make
+# variable (DejaGnu writes it into site.exp; remove a stale site.exp first):
+#
+#   rm gcc/site.exp
+#   make check-c RUNTESTFLAGS="kcfi-compat.exp" \
+#       ALT_CC_UNDER_TEST="/path/to/clang -Xclang -fsanitize-kcfi-hash=FNV-1a"
+
+if $tracelevel then {
+    strace $tracelevel
+}
+
+global GCC_UNDER_TEST
+global ALT_CC_UNDER_TEST
+global compat_save_gcc_under_test
+global compat_use_alt
+global compat_same_alt
+
+# c-compat.exp must be loaded before compat.exp (which guards on it).
+load_lib standard.exp
+load_lib gcc.exp
+load_lib c-compat.exp
+load_lib compat.exp
+
+gcc_init
+
+# Only run where -fsanitize=kcfi is supported (and can be linked and run).
+if { ![check_no_compiler_messages fsanitize_kcfi executable {
+    int main (void) { return 0; }
+} "-fsanitize=kcfi"] } {
+    return
+}
+
+# Save the compiler under test; each test switches it a couple of times.
+set compat_save_gcc_under_test $GCC_UNDER_TEST
+
+# Identifier for this suite, to avoid object-file name clashes.
+set sid "kcfi_compat"
+
+# Find out whether there is an alternate compiler to test.
+set compat_use_alt 0
+set compat_same_alt 0
+if [info exists ALT_CC_UNDER_TEST] then {
+    set compat_use_alt 1
+    if [string match "same" $ALT_CC_UNDER_TEST] then {
+	set compat_same_alt 1
+    }
+}
+
+# Initialize the compat framework globals (compat_save_TEST_ALWAYS_FLAGS,
+# compat_alt_*, DFP support, ...).
+compat_setup_dfp
+
+foreach src [lsort [find $srcdir/$subdir *_main.c]] {
+    if ![runtest_file_p $runtests $src] then {
+	continue
+    }
+    compat-execute $src $sid $compat_use_alt
+}
+
+# Restore the original compiler under test.
+compat-use-tst-compiler
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi.exp b/gcc/testsuite/gcc.dg/kcfi/kcfi.exp
new file mode 100644
index 000000000000..8c7f9421071c
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi.exp
@@ -0,0 +1,51 @@
+#   Copyright (C) 2026 Free Software Foundation, Inc.
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
index ab726f729ab3..2250607f79d9 100644
--- a/gcc/testsuite/lib/target-supports.exp
+++ b/gcc/testsuite/lib/target-supports.exp
@@ -14412,6 +14412,20 @@ proc check_effective_target_no_fsanitize_address {} {
     return 0;
 }
 
+# Return 1 if this target supports KCFI (Kernel Control Flow Integrity)
+
+proc check_effective_target_kcfi {} {
+    # We don't need a full executable to test this flag
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
 # Return 1 if the target supports GNU Retain, 0 otherwise.
 # This means both SHF_GNU_RETAIN and SHT_INIT_ARRAY to simplify uses.
 
diff --git a/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1.h b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1.h
new file mode 100644
index 000000000000..5f2d5a88ca61
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1.h
@@ -0,0 +1,22 @@
+/* Shared declarations for the KCFI cross-TU indirect-call compat test.
+
+   Including this in both the caller (_x) and the targets (_y) keeps their view
+   of each target's prototype (and therefore the derived KCFI type-id) in
+   sync from a single source.  */
+
+#ifndef KCFI_INDIRECT_1_H
+#define KCFI_INDIRECT_1_H
+
+typedef int (*fp1) (int);
+typedef int (*fp2) (int, int);
+
+/* Targets defined in the _y TU, called indirectly from the _x TU.  */
+extern int tgt_inc (int);
+extern int tgt_add (int, int);
+extern int tgt_neg (int);
+extern int tgt_mul (int, int);
+
+/* Entry point of the caller TU (_x), invoked from _main.  */
+extern void run_caller (void);
+
+#endif /* KCFI_INDIRECT_1_H */
diff --git a/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_main.c b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_main.c
new file mode 100644
index 000000000000..799579f977d0
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_main.c
@@ -0,0 +1,22 @@
+/* KCFI cross-TU / cross-compiler indirect-call ABI compatibility test.
+
+   Bootstrap TU.  main() lives here because the compat framework always builds
+   the _main TU with the compiler under test; it does nothing interesting but
+   hand control to the caller in the _x TU.
+
+   The cross-TU / cross-compiler pairing under test is _x (the indirect caller)
+   against _y (the targets): the framework builds each of those with the
+   compiler under test and, when ALT_CC_UNDER_TEST is set, an alternate
+   compiler (in every combination) so both compilers get exercised as the
+   caller and as the target.  See kcfi-compat.exp.  */
+
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+#include "kcfi-indirect-1.h"
+
+int
+main (void)
+{
+  run_caller ();
+  return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_x.c b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_x.c
new file mode 100644
index 000000000000..49fb550372c8
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_x.c
@@ -0,0 +1,37 @@
+/* KCFI cross-TU / cross-compiler compat test: the "caller" TU.
+
+   This TU holds the KCFI-checked indirect calls; the target functions are
+   defined in the _y TU and declared in the shared header.  For each call to
+   succeed, the call-site type-id computed here (from the pointer's type) must
+   equal the __cfi_ preamble type-id the _y TU computed (from the function's
+   type).  I.e. the two separately-compiled objects (potentially built by
+   different compilers) must agree on the KCFI type-id ABI.  A mismatch traps
+   (SIGILL); success is running to completion.  */
+
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+#include "kcfi-indirect-1.h"
+
+void abort (void);
+
+/* volatile keeps each call indirect, so it is actually KCFI-checked.  */
+volatile fp1 p_inc, p_neg;
+volatile fp2 p_add, p_mul;
+
+void
+run_caller (void)
+{
+  p_inc = tgt_inc;
+  p_add = tgt_add;
+  p_neg = tgt_neg;
+  p_mul = tgt_mul;
+
+  if (p_inc (41) != 42)
+    abort ();
+  if (p_add (20, 22) != 42)
+    abort ();
+  if (p_neg (-42) != 42)
+    abort ();
+  if (p_mul (6, 7) != 42)
+    abort ();
+}
diff --git a/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_y.c b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_y.c
new file mode 100644
index 000000000000..0ef015fc5f7b
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi-compat/kcfi-indirect-1_y.c
@@ -0,0 +1,34 @@
+/* KCFI cross-TU / cross-compiler compat test: the "target" TU.
+
+   Defines the address-taken functions the caller (_x) invokes indirectly.
+   Being address-taken, each gets a __cfi_ preamble whose type-id is derived
+   from the function's own type; a call succeeds only if that matches the
+   caller's call-site type-id.  */
+
+/* { dg-options "-fsanitize=kcfi -O2" } */
+
+#include "kcfi-indirect-1.h"
+
+int
+tgt_inc (int a)
+{
+  return a + 1;
+}
+
+int
+tgt_add (int a, int b)
+{
+  return a + b;
+}
+
+int
+tgt_neg (int a)
+{
+  return -a;
+}
+
+int
+tgt_mul (int a, int b)
+{
+  return a * b;
+}
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c
new file mode 100644
index 000000000000..fbf34c30a591
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-asm-name.c
@@ -0,0 +1,16 @@
+/* Test that the KCFI preamble strips the assembler-name encoding when
+   forming the __cfi_ label.  Functions with a custom asm() name have a
+   leading '*' in their DECL_ASSEMBLER_NAME; without stripping it the
+   preamble emits "__cfi_*name:", which the assembler rejects.  Scanning the
+   emitted label is enough to catch this, so use dg-do compile (portable to
+   targets without an assembler).  */
+/* { dg-do compile } */
+
+int realname (int x) __asm__ ("my_custom_name");
+int realname (int x) { return x + 1; }
+
+int call (int (*p) (int), int x) { return p (x); }
+
+/* The preamble label must be clean (no encoding '*').  */
+/* { dg-final { scan-assembler "__cfi_my_custom_name:" } } */
+/* { dg-final { scan-assembler-not {__cfi_\*} } } */
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
new file mode 100644
index 000000000000..4fce0771a55d
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
@@ -0,0 +1,28 @@
+/* Verify that direct calls of every syntactic shape (plain, weak,
+   aliased, static) produce zero KCFI checks, and that the only KCFI
+   check generated comes from the lone indirect call.  This guards
+   against regressions where the direct-call detector would miss
+   non-SYMBOL_REF address forms (CONST, LABEL_REF) and wrongly wrap
+   a direct call.  */
+/* { dg-do compile } */
+/* { dg-additional-options "-O2" } */
+
+extern void plain_func(int);
+extern void weak_func(int) __attribute__((weak));
+void plain_func(int x) { __asm__("" : : "r"(x) : "memory"); }
+void weak_func(int x) { __asm__("" : : "r"(x) : "memory"); }
+extern void alias_func(int) __attribute__((alias("plain_func")));
+__attribute__((noinline)) static void static_func(int x) {
+    __asm__("" : : "r"(x) : "memory");
+}
+
+void caller(int sel, void (*ip)(int), int x) {
+    if (sel == 1) plain_func(x);   /* direct, plain extern */
+    if (sel == 2) weak_func(x);    /* direct, weak */
+    if (sel == 3) alias_func(x);   /* direct, alias */
+    if (sel == 4) static_func(x);  /* direct, static */
+    if (sel == 5) ip(x);           /* indirect — the only KCFI-checked call */
+}
+
+/* Per-arch dg-final patterns are added by each arch's KCFI implementation
+   commit; the invariant is "exactly one typeid load = one indirect call".  */
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
diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c b/gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c
new file mode 100644
index 000000000000..df67de940646
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-lto-offset.c
@@ -0,0 +1,26 @@
+/* Verify KCFI is correct under LTO.  The callsite typeid-load offset (and the
+   preamble alignment padding) must be computed in whichever process emits the
+   code.  Regression test for a bug where these were set in an IPA pass that
+   runs at WPA, so the globals were still 0 in the separate ltrans codegen
+   process: every indirect call then loaded the typeid from the wrong offset
+   and trapped at run time.  */
+
+/* { dg-do run { target native } } */
+/* { dg-additional-options "-O2 -flto" } */
+
+typedef int (*fp_t) (int);
+
+/* volatile keeps the call indirect (and KCFI-checked) through LTO.  */
+volatile fp_t sink;
+
+int target (int x) { return x + 1; }
+
+int do_call (int x) { return sink (x); }
+
+int
+main (void)
+{
+  sink = target;
+  /* With a wrong typeid offset this traps (SIGILL) instead of returning 42.  */
+  return do_call (41) == 42 ? 0 : 1;
+}
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
index 000000000000..2b5c13fac69c
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
+	    __builtin_linux_abi_kcfi_name(typeof(func_int_void)),
+	    __builtin_linux_abi_kcfi_hash(typeof(func_int_void)),
+	    __builtin_linux_abi_kcfi_name(typeof(*ptr)),
+	    __builtin_linux_abi_kcfi_hash(typeof(*ptr)));
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
+	    __builtin_linux_abi_kcfi_name(typeof(complex_entry_point)),
+	    __builtin_linux_abi_kcfi_hash(typeof(complex_entry_point)),
+	    __builtin_linux_abi_kcfi_name(typeof(*ptr)),
+	    __builtin_linux_abi_kcfi_hash(typeof(*ptr)));
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
+	      __builtin_linux_abi_kcfi_name(typeof(func_int_void_nocf_check)),
+	      __builtin_linux_abi_kcfi_hash(typeof(func_int_void_nocf_check)),
+	      __builtin_linux_abi_kcfi_name(typeof(*ptr)),
+	      __builtin_linux_abi_kcfi_hash(typeof(*ptr)));
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
+	      __builtin_linux_abi_kcfi_name(typeof(func_int_void)),
+	      __builtin_linux_abi_kcfi_hash(typeof(func_int_void)),
+	      __builtin_linux_abi_kcfi_name(typeof(*ptr)),
+	      __builtin_linux_abi_kcfi_hash(typeof(*ptr)));
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
diff --git a/gcc/testsuite/gcc.dg/pch/kcfi-1.c b/gcc/testsuite/gcc.dg/pch/kcfi-1.c
new file mode 100644
index 000000000000..8035396c7d85
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/pch/kcfi-1.c
@@ -0,0 +1,50 @@
+/* Test that KCFI is precompiled-header safe: compiling this TU with the header
+   pulled from a PCH must produce assembly identical to compiling it with the
+   header parsed normally.  KCFI type-ids are computed at codegen from the
+   FUNCTION_TYPE trees, so a PCH-restored type must hash the same as a
+   freshly-parsed one; the __cfi_ preamble type-ids and the indirect-call check
+   immediates below would differ otherwise.  It also guards the output-phase
+   label counter (kcfi_labelno): were it wrongly GTY-saved into the PCH, the
+   .Lkcfi_call labels would diverge between the two compilations.  */
+
+/* { dg-options "-fsanitize=kcfi -I." } */
+/* { dg-require-effective-target kcfi } */
+
+#include "kcfi-1.h"
+
+/* Address-taken targets: each gets a __cfi_ preamble carrying its type-id.  */
+int
+add (int a, int b)
+{
+  return a + b;
+}
+
+long
+deref (long *p)
+{
+  return *p;
+}
+
+void
+take (struct s *p)
+{
+  (void) p;
+}
+
+/* volatile keeps the calls indirect, so they are KCFI-checked.  */
+volatile fp_ii p_add;
+volatile fp_lp p_deref;
+volatile fp_sp p_take;
+
+int
+caller (struct s *sp)
+{
+  long v = 41;
+
+  p_add = add;
+  p_deref = deref;
+  p_take = take;
+
+  p_take (sp);
+  return p_add (1, 2) + (int) p_deref (&v);
+}
diff --git a/gcc/testsuite/gcc.dg/pch/kcfi-1.hs b/gcc/testsuite/gcc.dg/pch/kcfi-1.hs
new file mode 100644
index 000000000000..5a32e2bc1dc9
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/pch/kcfi-1.hs
@@ -0,0 +1,20 @@
+/* Header precompiled for kcfi-1.c.  It supplies the function types and
+   address-taken declarations whose KCFI type-ids kcfi-1.c relies on; the point
+   of the test is that those type-ids come out identical whether the
+   FUNCTION_TYPE trees are parsed fresh or restored from the PCH.
+
+   The header is precompiled with -fsanitize=kcfi so the PCH matches the way
+   kcfi-1.c is compiled; dg-require-effective-target keeps this UNSUPPORTED
+   (not failing) on targets without KCFI.  */
+
+/* { dg-options "-fsanitize=kcfi" } */
+/* { dg-require-effective-target kcfi } */
+
+typedef int (*fp_ii) (int, int);
+typedef long (*fp_lp) (long *);
+struct s;
+typedef void (*fp_sp) (struct s *);
+
+extern int add (int, int);
+extern long deref (long *);
+extern void take (struct s *);
-- 
2.34.1

