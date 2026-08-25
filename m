Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B93FF1D0
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702284; cv=none; b=Div+v+m5WVQgbC5ryAXXVasOuf1wS5N+jSSHYQ1FB4fR58UQCXZfNjx4Y7+6bE6A6TM9Mde04+nq+xPjR+Gm8OrzysMVLEjkIgeI2Xf5sEkMsSWn+5oOyd0rFNTN3VZN9YKP8BSWxivoxxYVrLirO1HyBxHZDFaFIzxRKX+ermc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702284; c=relaxed/simple;
	bh=SzXoaog0IISwzhAKiLzZMTnGJzSDQS+OK5DXvLnxOAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sr8d0z0BAikjHZ7UVCdngI+gwDia2KVeD6M2KgzU/8HO3cD4yjUG2LFSkkCzMvJhD0TQBCI8Fo+zLuW/ll9JD8dHolikceCe6Q6ID7NN25kLxcDlj3SWCoqogLni4H10ssDUjfRLHK/ZEAMk1FOLIPFkq0mPyiaRsZ7STIMSK0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aerIy7wd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aerIy7wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432851F00A3A;
	Tue, 25 Aug 2026 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787702280;
	bh=DS5ZbyUG6kOWx3he517weC6clH72TRw1wdsIO4lPFmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aerIy7wde5AjKtdgq0iSBepqREnuxmhXnMXQa46MHYZpHgeDfEJcgLIJdWZaShg8/
	 C0K6NxXii0rwY7fxuiwdegti7DWGNvTzAWEp7x6KhheF/3bbX9W8oFW5e66jMC2CyX
	 wpNNG6Dkt8uW5eD+j9TY1roDh+CEXlQJIpz90TP3RSXhkhgCR+64G1UgfBL2YGOHYD
	 9sKPvg1tf4/rcSlbbPZCYExm8n9DF2ts2xYDF6X3Q/3rCHsX6KX0A0XDa3oWwYTeFF
	 o8jucqkH/Zv5uCzFfNtvqHB2Ol2m4U//0i/UhCRIsRjDJg3Fm6Ee3nuueiEcyZg5rj
	 MUEp5bfil4Kkw==
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
Subject: [PATCH v15 1/7] kcfi: Introduce KCFI typeinfo mangling API
Date: Tue, 25 Aug 2026 16:57:51 -0700
Message-Id: <20260825235759.3379064-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825235748.i.456-kees@kernel.org>
References: <20260825235748.i.456-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=80849; i=kees@kernel.org; h=from:subject; bh=SzXoaog0IISwzhAKiLzZMTnGJzSDQS+OK5DXvLnxOAg=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl9OszP3Q8rfG83cCpU2+hx6+fbbbu0Ur0+XrPW7nthr 78p8JhKRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQuODD89/D+um+P3voyVzYL DtnN/4vuM1abXhJ/tD809dLnLxFplYwMP/vsGl7MbIrrjmWfdqrOS95C+65JxMtXTEtl7c5rKrx gBwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To support the KCFI typeid and future Linux type-based allocators,
which need to convert unique types into unique 32-bit values, add a
mangling system based on the Itanium C++ mangling ABI, adapted for
C types. Introduce __builtin_linux_abi_kcfi_hash for the hash, and
__builtin_linux_abi_kcfi_name for testing and debugging (to see the
human-readable mangling form). Add tests for typeinfo validation and
error handling.

This ABI needs to match what is used by LLVM Rust (which matches the Clang
ABI) so that KCFI can work on mixed GCC with LLVM-Rust kernel builds.
Instead of inventing a new ABI, all use the existing Itanium C++ mangling
which matches KCFI's needs.

An important aspect of the C++ typeinfo behavior that is retained here
is that typedefs are treated as pass-through except when the underlying
type lacks a tag (i.e. anonymous struct, union, or enum). This provides a
distinction between those typedefs and typedefs used to provide _aliases_
(u8, uint16_t). But regardless, this is distinct from strict ISO C type
equivalency, so it remains a Linux KCFI ABI.

gcc/ChangeLog:

	* Makefile.in: Add kcfi-typeinfo.o.
	* doc/extend.texi: Document typeinfo builtins.
	* kcfi-typeinfo.h: New file, typeinfo mangling API.
	* kcfi-typeinfo.cc: New file, implement typeinfo mangling.
	* selftest.h (kcfi_typeinfo_cc_tests): Declare.
	* selftest-run-tests.cc (selftest::run_tests): Call
	kcfi_typeinfo_cc_tests.

gcc/c-family/ChangeLog:

	* c-common.h (enum rid): Add typeinfo builtins.
	* c-common.cc: Add typeinfo builtins.

gcc/c/ChangeLog:

	* c-parser.cc (c_parser_get_builtin_type_arg): New function,
	parse type.
	(c_parser_postfix_expression): Add typeinfo builtins.

gcc/testsuite/ChangeLog:

	* gcc.dg/builtin-typeinfo.c: New test, typeinfo mangling.
	* gcc.dg/builtin-typeinfo-bitint.c: New test, BitInt.
	* gcc.dg/builtin-typeinfo-c23.c: New test, C23 types.
	* gcc.dg/builtin-typeinfo-errors.c: New test, validate bad
	arguments are rejected.
	* gcc.dg/builtin-typeinfo-fixed.c: New test, fixed point.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/doc/extend.texi                           |   99 ++
 .../gcc.dg/builtin-typeinfo-bitint.c          |   82 ++
 gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c   |   72 ++
 .../gcc.dg/builtin-typeinfo-errors.c          |   28 +
 gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c |   57 +
 gcc/testsuite/gcc.dg/builtin-typeinfo.c       |  375 ++++++
 gcc/Makefile.in                               |    1 +
 gcc/c-family/c-common.h                       |    1 +
 gcc/kcfi-typeinfo.h                           |   31 +
 gcc/selftest.h                                |    1 +
 gcc/c-family/c-common.cc                      |    2 +
 gcc/c/c-parser.cc                             |   72 ++
 gcc/kcfi-typeinfo.cc                          | 1009 +++++++++++++++++
 gcc/selftest-run-tests.cc                     |    1 +
 14 files changed, 1831 insertions(+)
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-bitint.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/kcfi-typeinfo.cc

diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
index 69034686a412..69bdccc98bfc 100644
--- a/gcc/doc/extend.texi
+++ b/gcc/doc/extend.texi
@@ -18176,6 +18176,105 @@ which will cause a @code{NULL} pointer to be used for the unsafe case.
 
 @enddefbuiltin
 
+@defbuiltin{{unsigned int} __builtin_linux_abi_kcfi_hash (@var{type})}
+
+The built-in function @code{__builtin_linux_abi_kcfi_hash} returns a hash value
+for the given type @var{type} (which is a type, not an expression).
+The hash is computed using the FNV-1a algorithm on the type's mangled
+name representation, which follows a subset of the
+@uref{https://itanium-cxx-abi.github.io/cxx-abi/abi.html#mangling,
+Itanium C++ ABI} conventions adapted for C types.  (See
+@code{__builtin_linux_abi_kcfi_name} for the string representation.)
+
+This built-in is primarily intended for kernel control flow integrity (KCFI)
+implementations and other type-aware runtime systems that need to generate
+consistent type identifiers.  The hash value is a 32-bit unsigned integer.
+
+Key characteristics of the hash:
+@itemize @bullet
+@item
+The hash is consistent for the same type across different translation units.
+@item
+Typedefs are recursively canonicalized down to integral type name or named
+struct, union, or enum tag name.
+@item
+Typedefs of anonymous structs, unions, and enums preserve the typedef name
+in the hash calculation (e.g., @code{typedef struct @{ int x; @} foo_t;}
+uses @code{foo_t} in the hash).
+@item
+Type qualifiers (@code{const}, @code{volatile}, @code{restrict}) affect
+the hash value.
+@item
+Function types include parameter types and variadic markers in the hash.
+@end itemize
+
+For example:
+@smallexample
+typedef struct @{ int x; @} mytype_t;
+unsigned int hash1 = __builtin_linux_abi_kcfi_hash (mytype_t);
+unsigned int hash2 = __builtin_linux_abi_kcfi_hash (struct @{ int x; @});
+/* hash1 != hash2 because the typedef name is preserved */
+
+void func(int x, char y);
+unsigned int hash3 = __builtin_linux_abi_kcfi_hash (typeof (func));
+/* Returns hash for function type "void(int, char)" */
+@end smallexample
+
+@emph{Note:} This construct is only available for C and Objective-C@.
+For C++, see @code{std::type_info::hash_code}.
+
+@enddefbuiltin
+
+@defbuiltin{{const char *} __builtin_linux_abi_kcfi_name (@var{type})}
+
+The built-in function @code{__builtin_linux_abi_kcfi_name} returns a string
+containing the mangled name representation of the given type @var{type}
+(which is a type, not an expression).  The string follows a subset of the
+@uref{https://itanium-cxx-abi.github.io/cxx-abi/abi.html#mangling,
+Itanium C++ ABI} mangling conventions adapted for C types.  (See
+@code{__builtin_linux_abi_kcfi_hash} for the unsigned 32-bit hash
+representation.)
+
+The returned string is a compile-time constant suitable for use in
+string comparisons, debugging output, or other type introspection needs.
+The string begins with @code{_ZTS} followed by the encoded type information.
+
+Mangling examples:
+@itemize @bullet
+@item
+@code{int} becomes @code{"_ZTSi"}
+@item
+@code{char *} becomes @code{"_ZTSPc"}
+@item
+@code{const int} becomes @code{"_ZTSKi"}
+@item
+@code{int[10]} becomes @code{"_ZTSA10_i"}
+@item
+@code{void (*)(int)} becomes @code{"_ZTSPFviE"}
+@item
+@code{struct foo} becomes @code{"_ZTS3foo"}
+@item
+@code{typedef struct @{ int x; @} bar_t;} becomes @code{"_ZTS5bar_t"}
+@end itemize
+
+The mangling preserves typedef names for anonymous compound types, which
+is particularly useful for distinguishing between different typedefs of
+structurally identical anonymous types:
+
+@smallexample
+typedef struct @{ int x; @} type_a;
+typedef struct @{ int x; @} type_b;
+/* name_a is "_ZTS6type_a", name_b is "_ZTS6type_b": different despite
+   identical structure.  */
+const char *name_a = __builtin_linux_abi_kcfi_name (type_a);
+const char *name_b = __builtin_linux_abi_kcfi_name (type_b);
+@end smallexample
+
+@emph{Note:} This construct is only available for C and Objective-C@.
+For C++, see @code{std::type_info::name}.
+
+@enddefbuiltin
+
 @defbuiltin{int __builtin_types_compatible_p (@var{type1}, @var{type2})}
 
 You can use the built-in function @code{__builtin_types_compatible_p} to
diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo-bitint.c b/gcc/testsuite/gcc.dg/builtin-typeinfo-bitint.c
new file mode 100644
index 000000000000..3695afbb3a0f
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/builtin-typeinfo-bitint.c
@@ -0,0 +1,82 @@
+/* Test KCFI type mangling of _BitInt types using
+   __builtin_linux_abi_kcfi_name.  Bit-precise integers require C23.  */
+/* { dg-do run } */
+/* { dg-require-effective-target bitint } */
+/* { dg-options "-std=c23" } */
+
+#include <stdio.h>
+#include <string.h>
+
+int pass, fail;
+
+#define TEST_STRING(expr, expected_string) \
+  do { \
+    const char *actual_string = __builtin_linux_abi_kcfi_name(typeof(expr)); \
+    printf("Testing %s: ", #expr); \
+    if (strcmp(actual_string, expected_string) == 0) { \
+      printf("PASS (%s)\n", actual_string); \
+      pass ++; \
+    } else { \
+      printf("FAIL\n"); \
+      printf("  Expected: %s\n", expected_string); \
+      printf("  Actual:   %s\n", actual_string); \
+      fail ++; \
+    } \
+  } while (0)
+
+int main(void)
+{
+    printf("Testing KCFI Typeinfo Mangling of _BitInt\n");
+    printf("======================================================\n");
+
+    /* Bit-precise integer types follow the Itanium C++ ABI: DB<N>_ for
+       signed _BitInt(N), DU<N>_ for unsigned _BitInt(N).  */
+    TEST_STRING(_BitInt(2),           "DB2_");
+    TEST_STRING(_BitInt(7),           "DB7_");
+    TEST_STRING(_BitInt(17),          "DB17_");
+    TEST_STRING(_BitInt(32),          "DB32_");
+    TEST_STRING(_BitInt(64),          "DB64_");
+    TEST_STRING(signed _BitInt(17),   "DB17_");
+
+    /* Unsigned bit-precise integers use DU.  The minimum unsigned width
+       is 1 (the minimum signed width is 2).  */
+    TEST_STRING(unsigned _BitInt(1),   "DU1_");
+    TEST_STRING(unsigned _BitInt(7),   "DU7_");
+    TEST_STRING(unsigned _BitInt(32),  "DU32_");
+    TEST_STRING(unsigned _BitInt(64),  "DU64_");
+
+    /* Qualifiers combine with the bit-precise encoding (Itanium order:
+       restrict, volatile, const).  */
+    TEST_STRING(const _BitInt(32),    "KDB32_");
+    TEST_STRING(volatile _BitInt(32), "VDB32_");
+
+    /* Pointers to _BitInt.  */
+    TEST_STRING(_BitInt(32) *,         "PDB32_");
+    TEST_STRING(unsigned _BitInt(7) *, "PDU7_");
+
+    /* _BitInt in function signatures (KCFI's actual use case).  */
+    extern void func_bitint(_BitInt(32) x);
+    extern void func_ubitint(unsigned _BitInt(64) x);
+    extern _BitInt(64) func_ret_bitint(void);
+    extern void func_bitint_mixed(int x, _BitInt(32) y, unsigned _BitInt(7) z);
+    TEST_STRING(func_bitint,       "FvDB32_E");
+    TEST_STRING(func_ubitint,      "FvDU64_E");
+    TEST_STRING(func_ret_bitint,   "FDB64_vE");
+    TEST_STRING(func_bitint_mixed, "FviDB32_DU7_E");
+
+    /* Distinct widths and signedness must produce distinct manglings.  */
+    if (strcmp(__builtin_linux_abi_kcfi_name(typeof(_BitInt(32))),
+	       __builtin_linux_abi_kcfi_name(typeof(_BitInt(64)))) == 0)
+      { printf("FAIL: _BitInt(32) and _BitInt(64) collide\n"); fail++; }
+    else
+      { printf("PASS: distinct widths are distinct\n"); pass++; }
+    if (strcmp(__builtin_linux_abi_kcfi_name(typeof(_BitInt(32))),
+	       __builtin_linux_abi_kcfi_name(typeof(unsigned _BitInt(32)))) == 0)
+      { printf("FAIL: signed/unsigned _BitInt(32) collide\n"); fail++; }
+    else
+      { printf("PASS: signed and unsigned are distinct\n"); pass++; }
+
+    printf("\n================================================================\n");
+    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail, pass + fail);
+    return fail;
+}
diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c b/gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c
new file mode 100644
index 000000000000..ff0e3e4eeb3b
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/builtin-typeinfo-c23.c
@@ -0,0 +1,72 @@
+/* Test KCFI type mangling of C23 nullptr_t and the extended floating-point
+   formats using __builtin_linux_abi_kcfi_name.  Optional-type blocks are
+   guarded by feature macros so the test runs on any target.  */
+/* { dg-do run } */
+/* { dg-options "-std=c23" } */
+
+#include <stdio.h>
+#include <string.h>
+
+int pass, fail;
+
+#define TEST_STRING(expr, expected_string) \
+  do { \
+    const char *actual_string = __builtin_linux_abi_kcfi_name(typeof(expr)); \
+    printf("Testing %s: ", #expr); \
+    if (strcmp(actual_string, expected_string) == 0) { \
+      printf("PASS (%s)\n", actual_string); \
+      pass ++; \
+    } else { \
+      printf("FAIL\n"); \
+      printf("  Expected: %s\n", expected_string); \
+      printf("  Actual:   %s\n", actual_string); \
+      fail ++; \
+    } \
+  } while (0)
+
+int main(void)
+{
+    printf("Testing KCFI Typeinfo Mangling of nullptr_t and extended floats\n");
+    printf("======================================================\n");
+
+    /* The type of C23 nullptr (std::nullptr_t): Dn.  */
+    TEST_STRING(typeof(nullptr),   "Dn");
+    TEST_STRING(typeof(nullptr) *, "PDn");
+    extern void func_nullptr(typeof(nullptr) x);
+    TEST_STRING(func_nullptr, "FvDnE");
+
+    /* Extended floating-point formats follow the Itanium C++ ABI.  Target FP
+       types (e.g. x86 __float128) are handled by the target mangle hook.
+       Each block is guarded by its feature macro so unsupported targets
+       skip it rather than failing to compile.  */
+#ifdef __FLT16_MANT_DIG__
+    TEST_STRING(_Float16, "DF16_");
+#endif
+#ifdef __FLT32_MANT_DIG__
+    TEST_STRING(_Float32, "DF32_");
+#endif
+#ifdef __FLT64_MANT_DIG__
+    TEST_STRING(_Float64, "DF64_");
+#endif
+#ifdef __FLT128_MANT_DIG__
+    TEST_STRING(_Float128, "DF128_");
+#endif
+#if defined(__SIZEOF_FLOAT128__) && defined(__FLT128_MANT_DIG__)
+    /* In C, __float128 is the same type as _Float128 where both exist, so it
+       must share the same mangling.  */
+    if (strcmp(__builtin_linux_abi_kcfi_name(typeof(__float128)),
+	       __builtin_linux_abi_kcfi_name(typeof(_Float128))) == 0)
+      { printf("PASS: __float128 matches _Float128\n"); pass++; }
+    else
+      { printf("FAIL: __float128 mangling differs from _Float128\n"); fail++; }
+#endif
+#ifdef __DEC32_MANT_DIG__
+    TEST_STRING(_Decimal32,  "Df");
+    TEST_STRING(_Decimal64,  "Dd");
+    TEST_STRING(_Decimal128, "De");
+#endif
+
+    printf("\n================================================================\n");
+    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail, pass + fail);
+    return fail;
+}
diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c b/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
new file mode 100644
index 000000000000..5d68425c229c
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
@@ -0,0 +1,28 @@
+/* Test error handling for __builtin_linux_abi_kcfi_name and __builtin_linux_abi_kcfi_hash.  */
+/* { dg-do compile } */
+
+int main() {
+    /* Test missing arguments */
+    const char *result1 = __builtin_linux_abi_kcfi_name(); /* { dg-error "expected specifier-qualifier-list before '\\)'" } */
+    /* { dg-error "expected type name in '__builtin_linux_abi_kcfi_name'" "" { target *-*-* } .-1 } */
+    unsigned int result2 = __builtin_linux_abi_kcfi_hash(); /* { dg-error "expected specifier-qualifier-list before '\\)'" } */
+    /* { dg-error "expected type name in '__builtin_linux_abi_kcfi_hash'" "" { target *-*-* } .-1 } */
+
+    /* Test wrong argument types (expressions instead of type names) */
+    const char *result3 = __builtin_linux_abi_kcfi_name(42); /* { dg-error "expected specifier-qualifier-list before numeric constant" } */
+    /* { dg-error "expected type name in '__builtin_linux_abi_kcfi_name'" "" { target *-*-* } .-1 } */
+    unsigned int result4 = __builtin_linux_abi_kcfi_hash(42); /* { dg-error "expected specifier-qualifier-list before numeric constant" } */
+    /* { dg-error "expected type name in '__builtin_linux_abi_kcfi_hash'" "" { target *-*-* } .-1 } */
+
+    int x = 5;
+    const char *result5 = __builtin_linux_abi_kcfi_name(x); /* { dg-error "expected specifier-qualifier-list before" } */
+    /* { dg-error "expected type name in '__builtin_linux_abi_kcfi_name'" "" { target *-*-* } .-1 } */
+    unsigned int result6 = __builtin_linux_abi_kcfi_hash(x); /* { dg-error "expected specifier-qualifier-list before" } */
+    /* { dg-error "expected type name in '__builtin_linux_abi_kcfi_hash'" "" { target *-*-* } .-1 } */
+
+    /* Test too many arguments */
+    const char *result7 = __builtin_linux_abi_kcfi_name(int, int); /* { dg-error "expected '\\)' before ','" } */
+    unsigned int result8 = __builtin_linux_abi_kcfi_hash(int, int); /* { dg-error "expected '\\)' before ','" } */
+
+    return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c b/gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c
new file mode 100644
index 000000000000..51a145f8ac54
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/builtin-typeinfo-fixed.c
@@ -0,0 +1,57 @@
+/* Test KCFI type mangling of fixed-point types (ISO/IEC TR 18037) using
+   __builtin_linux_abi_kcfi_name.  Fixed-point types have no Itanium C++ ABI
+   mangling, so KCFI emits a deterministic vendor-extended name.  Rather than
+   hard-code the target-dependent encoding, verify the two properties KCFI
+   actually relies on: every fixed-point type mangles (no ICE) to a vendor
+   name, and distinct fixed-point types get distinct manglings.  */
+/* { dg-do run } */
+/* { dg-require-effective-target fixed_point } */
+
+#include <stdio.h>
+#include <string.h>
+
+int pass, fail;
+
+/* Each mangling must be a non-empty vendor-extended builtin type ("u"...).  */
+#define CHECK_VENDOR(name, s) \
+  do { \
+    printf("%s = %s: ", name, s); \
+    if (s[0] == 'u' && s[1] != '\0') { printf("PASS\n"); pass++; } \
+    else { printf("FAIL (not a vendor name)\n"); fail++; } \
+  } while (0)
+
+int main(void)
+{
+    const char *fr   = __builtin_linux_abi_kcfi_name(typeof((_Fract) 0));
+    const char *ufr  = __builtin_linux_abi_kcfi_name(typeof((unsigned _Fract) 0));
+    const char *sfr  = __builtin_linux_abi_kcfi_name(typeof((_Sat _Fract) 0));
+    const char *lfr  = __builtin_linux_abi_kcfi_name(typeof((long _Fract) 0));
+    const char *ac   = __builtin_linux_abi_kcfi_name(typeof((_Accum) 0));
+    const char *sac  = __builtin_linux_abi_kcfi_name(typeof((_Sat _Accum) 0));
+
+    CHECK_VENDOR("_Fract", fr);
+    CHECK_VENDOR("unsigned _Fract", ufr);
+    CHECK_VENDOR("_Sat _Fract", sfr);
+    CHECK_VENDOR("long _Fract", lfr);
+    CHECK_VENDOR("_Accum", ac);
+    CHECK_VENDOR("_Sat _Accum", sac);
+
+    /* Distinctness: signedness, saturation, size and the fract/accum
+       distinction must each change the mangling.  */
+    const char *all[] = { fr, ufr, sfr, lfr, ac, sac };
+    int n = sizeof(all) / sizeof(all[0]);
+    for (int i = 0; i < n; i++)
+      for (int j = i + 1; j < n; j++)
+	{
+	  if (strcmp(all[i], all[j]) == 0)
+	    {
+	      printf("FAIL: manglings %d and %d collide (%s)\n", i, j, all[i]);
+	      fail++;
+	    }
+	  else
+	    pass++;
+	}
+
+    printf("\nPassed: %d Failed: %d (%d total tests)\n", pass, fail, pass + fail);
+    return fail;
+}
diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo.c b/gcc/testsuite/gcc.dg/builtin-typeinfo.c
new file mode 100644
index 000000000000..b155a67f9c33
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/builtin-typeinfo.c
@@ -0,0 +1,375 @@
+/* Test KCFI type mangling using __builtin_linux_abi_kcfi_name.  */
+/* { dg-do run } */
+/* { dg-options "-std=gnu99" } */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdarg.h>
+
+int pass, fail;
+
+#define TEST_STRING(expr, expected_string) \
+  do { \
+    const char *actual_string = __builtin_linux_abi_kcfi_name(typeof(expr)); \
+    printf("Testing %s: ", #expr); \
+    if (strcmp(actual_string, expected_string) == 0) { \
+      printf("PASS (%s)\n", actual_string); \
+      pass ++; \
+    } else { \
+      printf("FAIL\n"); \
+      printf("  Expected: %s\n", expected_string); \
+      printf("  Actual:   %s\n", actual_string); \
+      fail ++; \
+    } \
+  } while (0)
+
+int main(void)
+{
+    printf("Testing KCFI Typeinfo Mangling\n");
+    printf("======================================================\n");
+
+    /* Test basic types */
+    TEST_STRING(void, "v");
+    TEST_STRING(char, "c");
+    TEST_STRING(int, "i");
+    TEST_STRING(short, "s");
+    TEST_STRING(long, "l");
+    TEST_STRING(float, "f");
+    TEST_STRING(double, "d");
+
+    /* Test qualified types */
+    TEST_STRING(const int, "Ki");
+    TEST_STRING(volatile int, "Vi");
+
+    /* Test pointer types */
+    TEST_STRING(char*, "Pc");
+    TEST_STRING(int*, "Pi");
+    TEST_STRING(void*, "Pv");
+    TEST_STRING(const char*, "PKc");
+
+    /* Test array types */
+    TEST_STRING(int[10],  "A10_i");
+    TEST_STRING(char[20], "A20_c");
+    TEST_STRING(short[],  "A_s");
+
+    /* Test basic function types */
+    extern void func_void(void);
+    extern void func_char(char x);
+    extern void func_short(short x);
+    extern void func_int(int x);
+    extern void func_long(long x);
+    TEST_STRING(func_void,  "FvvE");
+    TEST_STRING(func_char,  "FvcE");
+    TEST_STRING(func_short, "FvsE");
+    TEST_STRING(func_int,   "FviE");
+    TEST_STRING(func_long,  "FvlE");
+
+    /* Test functions with unsigned types */
+    extern void func_unsigned_char(unsigned char x);
+    extern void func_unsigned_short(unsigned short x);
+    extern void func_unsigned_int(unsigned int x);
+    TEST_STRING(func_unsigned_char,  "FvhE");
+    TEST_STRING(func_unsigned_short, "FvtE");
+    TEST_STRING(func_unsigned_int,   "FvjE");
+
+    /* Test functions with signed types */
+    extern void func_signed_char(signed char x);
+    extern void func_signed_short(signed short x);
+    extern void func_signed_int(signed int x);
+    TEST_STRING(func_signed_char,  "FvaE");
+    TEST_STRING(func_signed_short, "FvsE");
+    TEST_STRING(func_signed_int,   "FviE");
+
+    /* Test functions with pointer types */
+    extern void func_void_ptr(void *x);
+    extern void func_char_ptr(char *x);
+    extern void func_short_ptr(short *x);
+    extern void func_int_ptr(int *x);
+    extern void func_int_array(int arr[]); /* Decays to "int *".  */
+    extern void func_long_ptr(long *x);
+    TEST_STRING(func_void_ptr,  "FvPvE");
+    TEST_STRING(func_char_ptr,  "FvPcE");
+    TEST_STRING(func_short_ptr, "FvPsE");
+    TEST_STRING(func_int_ptr,   "FvPiE");
+    TEST_STRING(func_int_array, "FvPiE");
+    TEST_STRING(func_long_ptr,  "FvPlE");
+
+    /* Test functions with const qualifiers */
+    extern void func_const_void_ptr(const void *x);
+    extern void func_const_char_ptr(const char *x);
+    extern void func_const_short_ptr(const short *x);
+    extern void func_const_int_ptr(const int *x);
+    extern void func_const_long_ptr(const long *x);
+    TEST_STRING(func_const_void_ptr,  "FvPKvE");
+    TEST_STRING(func_const_char_ptr,  "FvPKcE");
+    TEST_STRING(func_const_short_ptr, "FvPKsE");
+    TEST_STRING(func_const_int_ptr,   "FvPKiE");
+    TEST_STRING(func_const_long_ptr,  "FvPKlE");
+
+    /* Test nested pointers */
+    extern void func_int_ptr_ptr(int **x);
+    extern void func_char_ptr_ptr(char **x);
+    TEST_STRING(func_int_ptr_ptr,  "FvPPiE");
+    TEST_STRING(func_char_ptr_ptr, "FvPPcE");
+
+    /* Test multiple parameters */
+    extern void func_int_char(int x, char y);
+    extern void func_char_int(char x, int y);
+    extern void func_two_int(int x, int y);
+    TEST_STRING(func_int_char, "FvicE");
+    TEST_STRING(func_char_int, "FvciE");
+    TEST_STRING(func_two_int,  "FviiE");
+
+    /* Test return types */
+    extern int func_return_int(void);
+    extern char func_return_char(void);
+    extern void* func_return_ptr(void);
+    TEST_STRING(func_return_int,  "FivE");
+    TEST_STRING(func_return_char, "FcvE");
+    TEST_STRING(func_return_ptr,  "FPvvE");
+
+    /* Test function pointer parameters */
+    extern void func_fptr_void(void (*fp)(void));
+    extern void func_fptr_int(void (*fp)(int));
+    extern void func_fptr_ret_int(int (*fp)(void));
+    TEST_STRING(func_fptr_void,    "FvPFvvEE");
+    TEST_STRING(func_fptr_int,     "FvPFviEE");
+    TEST_STRING(func_fptr_ret_int, "FvPFivEE");
+
+    /* Test variadic functions */
+    struct audit_context { int dummy; };
+    extern void func_variadic_simple(const char *fmt, ...);
+    extern void func_variadic_mixed(int x, const char *fmt, ...);
+    extern void func_variadic_multi(int x, char y, const char *fmt, ...);
+    extern void audit_log_pattern(struct audit_context *ctx, unsigned int gfp_mask,
+				  int type, const char *fmt, ...);
+    TEST_STRING(func_variadic_simple, "FvPKczE");
+    TEST_STRING(func_variadic_mixed,  "FviPKczE");
+    TEST_STRING(func_variadic_multi,  "FvicPKczE");
+    TEST_STRING(audit_log_pattern,    "FvP13audit_contextjiPKczE");
+
+    /* Test mixed const/non-const */
+    extern void func_const_mixed(int x, const char *fmt);
+    TEST_STRING(func_const_mixed,  "FviPKcE");
+
+    /* Test named struct types */
+    struct test_struct_a { int x; };
+    struct test_struct_b { char y; };
+    struct test_struct_c { void *ptr; };
+    TEST_STRING(struct test_struct_a, "13test_struct_a");
+    extern void func_struct_a_ptr(struct test_struct_a *x);
+    extern void func_struct_b_ptr(struct test_struct_b *x);
+    extern void func_struct_c_ptr(struct test_struct_c *x);
+    TEST_STRING(func_struct_a_ptr, "FvP13test_struct_aE");
+    TEST_STRING(func_struct_b_ptr, "FvP13test_struct_bE");
+    TEST_STRING(func_struct_c_ptr, "FvP13test_struct_cE");
+
+    /* Test const named struct types */
+    extern void func_const_struct_a_ptr(const struct test_struct_a *x);
+    extern void func_const_struct_b_ptr(const struct test_struct_b *x);
+    extern void func_const_struct_c_ptr(const struct test_struct_c *x);
+    TEST_STRING(func_const_struct_a_ptr, "FvPK13test_struct_aE");
+    TEST_STRING(func_const_struct_b_ptr, "FvPK13test_struct_bE");
+    TEST_STRING(func_const_struct_c_ptr, "FvPK13test_struct_cE");
+
+    /* Test named union types */
+    union test_union_a { int x; float y; };
+    union test_union_b { char a; void *b; };
+    TEST_STRING(union test_union_a,  "12test_union_a");
+    extern void func_union_a_ptr(union test_union_a *x);
+    extern void func_union_b_ptr(union test_union_b *x);
+    TEST_STRING(func_union_a_ptr, "FvP12test_union_aE");
+    TEST_STRING(func_union_b_ptr, "FvP12test_union_bE");
+
+    /* Test enum types: distinct from int */
+    enum test_enum_a { ENUM_A_VAL };
+    enum test_enum_b { ENUM_B_VAL };
+    TEST_STRING(enum test_enum_a, "11test_enum_a");
+    extern void func_enum_a_ptr(enum test_enum_a *x);
+    extern void func_enum_b_ptr(enum test_enum_b *x);
+    TEST_STRING(func_enum_a_ptr, "FvP11test_enum_aE");
+    TEST_STRING(func_enum_b_ptr, "FvP11test_enum_bE");
+
+    /* Test union member discrimination */
+    struct tasklet {
+        int state;
+        union {
+            void (*func)(unsigned long data);
+            void (*callback)(struct tasklet *t);
+        };
+        unsigned long data;
+    } tasklet_instance;
+    TEST_STRING(tasklet_instance, "7tasklet");
+    struct tasklet *p = &tasklet_instance;
+    extern void tasklet_callback_function(struct tasklet *t);
+    extern void tasklet_func_function(unsigned long data);
+    TEST_STRING(tasklet_func_function,     "FvmE");
+    TEST_STRING(*p->func,                  "FvmE");
+    TEST_STRING(tasklet_callback_function, "FvP7taskletE");
+    TEST_STRING(*p->callback,              "FvP7taskletE");
+
+    /* Test struct return pointers */
+    extern struct test_struct_a* func_ret_struct_a_ptr(void);
+    extern struct test_struct_b* func_ret_struct_b_ptr(void);
+    extern struct test_struct_c* func_ret_struct_c_ptr(void);
+    TEST_STRING(func_ret_struct_a_ptr, "FP13test_struct_avE");
+    TEST_STRING(func_ret_struct_b_ptr, "FP13test_struct_bvE");
+    TEST_STRING(func_ret_struct_c_ptr, "FP13test_struct_cvE");
+
+    /* Test struct by-value parameters */
+    extern void func_struct_a_val(struct test_struct_a x);
+    extern void func_struct_b_val(struct test_struct_b x);
+    extern void func_struct_c_val(struct test_struct_c x);
+    TEST_STRING(func_struct_a_val, "Fv13test_struct_aE");
+    TEST_STRING(func_struct_b_val, "Fv13test_struct_bE");
+    TEST_STRING(func_struct_c_val, "Fv13test_struct_cE");
+
+    /* Test struct return by-value */
+    extern struct test_struct_a func_ret_struct_a_val(void);
+    extern struct test_struct_b func_ret_struct_b_val(void);
+    extern struct test_struct_c func_ret_struct_c_val(void);
+    TEST_STRING(func_ret_struct_a_val, "F13test_struct_avE");
+    TEST_STRING(func_ret_struct_b_val, "F13test_struct_bvE");
+    TEST_STRING(func_ret_struct_c_val, "F13test_struct_cvE");
+
+    /* Test mixed struct parameters */
+    extern void func_struct_a_b(struct test_struct_a *a, struct test_struct_b *b);
+    extern void func_struct_b_a(struct test_struct_b *b, struct test_struct_a *a);
+    TEST_STRING(func_struct_a_b, "FvP13test_struct_aP13test_struct_bE");
+    TEST_STRING(func_struct_b_a, "FvP13test_struct_bP13test_struct_aE");
+
+    /* Test anonymous struct typedefs */
+    typedef struct { int x; } typedef_struct_x;
+    typedef struct { int y; } typedef_struct_y;
+    TEST_STRING(typedef_struct_x, "16typedef_struct_x");
+    extern void func_typedef_x_ptr(typedef_struct_x *x);
+    extern void func_typedef_y_ptr(typedef_struct_y *y);
+    TEST_STRING(func_typedef_x_ptr, "FvP16typedef_struct_xE");
+    TEST_STRING(func_typedef_y_ptr, "FvP16typedef_struct_yE");
+    extern void func_typedef_x(typedef_struct_x x);
+    TEST_STRING(func_typedef_x, "Fv16typedef_struct_xE");
+
+    /* Test anonymous union typedefs */
+    typedef union { int x; short a; } typedef_union_x;
+    typedef union { int y; short b; } typedef_union_y;
+    TEST_STRING(typedef_union_x, "15typedef_union_x");
+    extern void func_typedef_union_x_ptr(typedef_union_x *x);
+    extern void func_typedef_union_y_ptr(typedef_union_y *y);
+    TEST_STRING(func_typedef_union_x_ptr, "FvP15typedef_union_xE");
+    TEST_STRING(func_typedef_union_y_ptr, "FvP15typedef_union_yE");
+    extern void func_typedef_union_x(typedef_union_x x);
+    TEST_STRING(func_typedef_union_x, "Fv15typedef_union_xE");
+
+    /* Test anonymous enum typedefs */
+    typedef enum { STEP_1, STEP_2 } typedef_enum_x;
+    typedef enum { STEP_A, STEP_B } typedef_enum_y;
+    TEST_STRING(typedef_enum_x, "14typedef_enum_x");
+    extern void func_typedef_enum_x_ptr(typedef_enum_x *x);
+    extern void func_typedef_enum_y_ptr(typedef_enum_y *y);
+    TEST_STRING(func_typedef_enum_x_ptr, "FvP14typedef_enum_xE");
+    TEST_STRING(func_typedef_enum_y_ptr, "FvP14typedef_enum_yE");
+    extern void func_typedef_enum_x(typedef_enum_x x);
+    TEST_STRING(func_typedef_enum_x, "Fv14typedef_enum_xE");
+
+    /* Test basic typedef vs open-coded function types: should be the same.  */
+    typedef void (*func_type_typedef)(int, char);
+    TEST_STRING(func_type_typedef,           "PFvicE");
+    extern void func_with_typedef_param(func_type_typedef fp);
+    extern void func_with_opencoded_param(void (*fp)(int, char));
+    TEST_STRING(func_with_typedef_param,   "FvPFvicEE");
+    TEST_STRING(func_with_opencoded_param, "FvPFvicEE");
+
+    /* Test return function pointer types */
+    typedef int (*ret_func_type_typedef)(void);
+    TEST_STRING(ret_func_type_typedef,     "PFivE");
+    extern ret_func_type_typedef func_ret_typedef_param(void);
+    extern int (*func_ret_opencoded_param(void))(void);
+    TEST_STRING(func_ret_typedef_param,   "FPFivEvE");
+    TEST_STRING(func_ret_opencoded_param, "FPFivEvE");
+
+    /* Test additional type combos */
+    extern void func_float(float x);
+    extern void func_double_ptr(double *x);
+    extern void func_float_ptr(float *x);
+    extern void func_void_ptr_ptr(void **x);
+    extern void func_ptr_val(int *x, int y);
+    extern void func_val_ptr(int x, int *y);
+    extern float func_return_float(void);
+    extern double func_return_double(void);
+    TEST_STRING(func_float,         "FvfE");
+    TEST_STRING(func_double_ptr,    "FvPdE");
+    TEST_STRING(func_float_ptr,     "FvPfE");
+    TEST_STRING(func_void_ptr_ptr,  "FvPPvE");
+    TEST_STRING(func_ptr_val,       "FvPiiE");
+    TEST_STRING(func_val_ptr,       "FviPiE");
+    TEST_STRING(func_return_float,  "FfvE");
+    TEST_STRING(func_return_double, "FdvE");
+
+    /* Test complex types (C99 _Complex): 'C' + element type.  */
+    TEST_STRING(_Complex float,       "Cf");
+    TEST_STRING(_Complex double,      "Cd");
+    TEST_STRING(_Complex long double, "Ce");
+    TEST_STRING(_Complex int,         "Ci"); /* GNU extension.  */
+    TEST_STRING(_Complex float *,     "PCf");
+    extern void func_complex(_Complex double x);
+    extern _Complex float func_ret_complex(void);
+    TEST_STRING(func_complex,     "FvCdE");
+    TEST_STRING(func_ret_complex, "FCfvE");
+
+    /* Test VLA types: should be all the same.  */
+    extern void func_vla_1d(int n, int arr[n]);
+    extern void func_vla_empty(int n, int arr[]);
+    extern void func_vla_ptr(int n, int *arr);
+    TEST_STRING(func_vla_1d,    "FviPiE");
+    TEST_STRING(func_vla_empty, "FviPiE");
+    TEST_STRING(func_vla_ptr,   "FviPiE");
+
+    /* Test 2D VLA with fixed dimension: should be all the same.  */
+    extern void func_vla_2d_first(int n, int arr[n][10]);
+    extern void func_vla_2d_empty(int n, int arr[][10]);
+    extern void func_vla_2d_ptr(int n, int (*arr)[10]);
+    TEST_STRING(func_vla_2d_first, "FviPA10_iE");
+    TEST_STRING(func_vla_2d_empty, "FviPA10_iE");
+    TEST_STRING(func_vla_2d_ptr,   "FviPA10_iE");
+
+    /* Test 2D VLA with both dimensions variable: should be all the same.  */
+    extern void func_vla_2d_both(int rows, int cols, int arr[rows][cols]);
+    extern void func_vla_2d_second(int rows, int cols, int arr[][cols]);
+    extern void func_vla_2d_star(int rows, int cols, int arr[*][cols]);
+    TEST_STRING(func_vla_2d_both,   "FviiPA_iE");
+    TEST_STRING(func_vla_2d_second, "FviiPA_iE");
+    TEST_STRING(func_vla_2d_star,   "FviiPA_iE");
+
+    /* Test a struct with a VLA member (a GCC extension).  Mangling keys on
+       the struct tag, not its layout, so the VLA member never leaks into the
+       encoding: a named struct mangles as its tag name regardless.  */
+    int vla_len = 8;
+    struct vla_member { int len; int data[vla_len]; };
+    struct vla_member vla_member_instance;
+    TEST_STRING(vla_member_instance, "10vla_member");
+    struct vla_member *vla_member_p = &vla_member_instance;
+    TEST_STRING(*vla_member_p, "10vla_member");
+    extern void func_vla_member_ptr(struct vla_member *x);
+    extern void func_vla_member_val(struct vla_member x);
+    TEST_STRING(func_vla_member_ptr, "FvP10vla_memberE");
+    TEST_STRING(func_vla_member_val, "Fv10vla_memberE");
+
+    /* Test recursive typedef canonicalization */
+    struct recursive_struct_test { int field; };
+    typedef struct recursive_struct_test recursive_struct_typedef_1;
+    typedef recursive_struct_typedef_1 recursive_struct_typedef_2;
+    extern void func_recursive_struct_test(struct recursive_struct_test *x);
+    TEST_STRING(func_recursive_struct_test, "FvP21recursive_struct_testE");
+
+    /* Test anonymous struct, union, enum types */
+    struct { int a; short b; } anon_struct;
+    union { int x; float y; } anon_union;
+    enum { ANON_VAL1, ANON_VAL2 } anon_enum;
+    TEST_STRING(anon_struct, "3$_0"); // <length>$_<counter>
+    TEST_STRING(anon_union, "3$_1");  // <length>$_<counter>
+    TEST_STRING(anon_enum, "3$_2");   // <length>$_<counter>
+
+    printf("\n================================================================\n");
+    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail, pass + fail);
+    return fail;
+}
diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index c718585e6071..f25dd396910d 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1614,6 +1614,7 @@ OBJS = \
 	ira-emit.o \
 	ira-lives.o \
 	jump.o \
+	kcfi-typeinfo.o \
 	langhooks.o \
 	late-combine.o \
 	lcm.o \
diff --git a/gcc/c-family/c-common.h b/gcc/c-family/c-common.h
index b89a8477e7ce..866b46440f87 100644
--- a/gcc/c-family/c-common.h
+++ b/gcc/c-family/c-common.h
@@ -113,6 +113,7 @@ enum rid
   RID_BUILTIN_HAS_ATTRIBUTE,   RID_BUILTIN_ASSOC_BARRIER,  RID_BUILTIN_STDC,
   RID_BUILTIN_COUNTED_BY_REF,  RID_BUILTIN_BSWAPG,
   RID_BUILTIN_BITREVERSEG,
+  RID_BUILTIN_LINUX_ABI_KCFI_NAME,  RID_BUILTIN_LINUX_ABI_KCFI_HASH,
   RID_DFLOAT32, RID_DFLOAT64, RID_DFLOAT128, RID_DFLOAT64X,
 
   /* TS 18661-3 keywords, in the same sequence as the TI_* values.  */
diff --git a/gcc/kcfi-typeinfo.h b/gcc/kcfi-typeinfo.h
new file mode 100644
index 000000000000..092a682276af
--- /dev/null
+++ b/gcc/kcfi-typeinfo.h
@@ -0,0 +1,31 @@
+/* KCFI-compatible type mangling, based on Itanium C++ ABI.
+   Copyright (C) 2026 Free Software Foundation, Inc.
+
+This file is part of GCC.
+
+GCC is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 3, or (at your option) any later
+version.
+
+GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+for more details.
+
+You should have received a copy of the GNU General Public License
+along with GCC; see the file COPYING3.  If not see
+<http://www.gnu.org/licenses/>.  */
+
+#ifndef GCC_KCFI_TYPEINFO_H
+#define GCC_KCFI_TYPEINFO_H
+
+#include "tree.h"
+
+/* Get the typeinfo mangled name string for any C type.  */
+extern std::string kcfi_typeinfo_get_name (tree type);
+
+/* Get the typeinfo hash for any C type.  */
+extern uint32_t kcfi_typeinfo_get_hash (tree type);
+
+#endif /* GCC_KCFI_TYPEINFO_H */
diff --git a/gcc/selftest.h b/gcc/selftest.h
index acfc4a46e49b..a17a6fe1b789 100644
--- a/gcc/selftest.h
+++ b/gcc/selftest.h
@@ -240,6 +240,7 @@ extern void ipa_modref_tree_cc_tests ();
 extern void json_cc_tests ();
 extern void json_parser_cc_tests ();
 extern void json_pointer_parsing_cc_tests ();
+extern void kcfi_typeinfo_cc_tests ();
 extern void opt_suggestions_cc_tests ();
 extern void optinfo_emit_json_cc_tests ();
 extern void opts_cc_tests ();
diff --git a/gcc/c-family/c-common.cc b/gcc/c-family/c-common.cc
index 6380bec4515d..4836b60811d2 100644
--- a/gcc/c-family/c-common.cc
+++ b/gcc/c-family/c-common.cc
@@ -466,6 +466,8 @@ const struct c_common_resword c_common_reswords[] =
   { "__builtin_stdc_trailing_zeros", RID_BUILTIN_STDC, D_CONLY },
   { "__builtin_tgmath", RID_BUILTIN_TGMATH, D_CONLY },
   { "__builtin_offsetof", RID_OFFSETOF, 0 },
+  { "__builtin_linux_abi_kcfi_hash", RID_BUILTIN_LINUX_ABI_KCFI_HASH, D_CONLY },
+  { "__builtin_linux_abi_kcfi_name", RID_BUILTIN_LINUX_ABI_KCFI_NAME, D_CONLY },
   { "__builtin_types_compatible_p", RID_TYPES_COMPATIBLE_P, D_CONLY },
   { "__builtin_c23_va_start", RID_C23_VA_START,	D_C23 | D_CXX26 },
   { "__builtin_va_arg",	RID_VA_ARG,	0 },
diff --git a/gcc/c/c-parser.cc b/gcc/c/c-parser.cc
index 9dc5ba1e3a13..63e1fbc60fc8 100644
--- a/gcc/c/c-parser.cc
+++ b/gcc/c/c-parser.cc
@@ -77,6 +77,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "asan.h"
 #include "c-family/c-ubsan.h"
 #include "gcc-urlifier.h"
+#include "kcfi-typeinfo.h"
 
 /* We need to walk over decls with incomplete struct/union/enum types
    after parsing the whole translation unit.
@@ -11245,6 +11246,38 @@ c_parser_has_attribute_expression (c_parser *parser)
   return result;
 }
 
+/* Parse the single type name argument of a builtin that takes a type name.
+   Returns true on success and stores the parsed type in *OUT_TYPE.
+   If successful, *OUT_CLOSE_PAREN_LOC is written with the location of
+   the closing parenthesis.  */
+
+static bool
+c_parser_get_builtin_type_arg (c_parser *parser, const char *bname,
+			       tree *out_type, location_t *out_close_paren_loc)
+{
+  matching_parens parens;
+  if (!parens.require_open (parser))
+    return false;
+
+  struct c_type_name *type_name = c_parser_type_name (parser);
+  if (type_name == NULL)
+    {
+      error_at (c_parser_peek_token (parser)->location,
+		"expected type name in %qs", bname);
+      return false;
+    }
+
+  *out_close_paren_loc = c_parser_peek_token (parser)->location;
+  parens.skip_until_found_close (parser);
+
+  tree type = groktypename (type_name, NULL, NULL);
+  if (type == error_mark_node)
+    return false;
+
+  *out_type = type;
+  return true;
+}
+
 /* Helper function to read arguments of builtins which are interfaces
    for the middle-end nodes like COMPLEX_EXPR, VEC_PERM_EXPR and
    others.  The name of the builtin is passed using BNAME parameter.
@@ -12283,6 +12316,45 @@ c_parser_postfix_expression (c_parser *parser)
 	    set_c_expr_source_range (&expr, loc, close_paren_loc);
 	  }
 	  break;
+	case RID_BUILTIN_LINUX_ABI_KCFI_NAME:
+	  {
+	    c_parser_consume_token (parser);
+	    location_t close_paren_loc;
+	    tree type;
+	    if (!c_parser_get_builtin_type_arg (parser,
+						"__builtin_linux_abi_kcfi_name",
+						&type, &close_paren_loc))
+	      {
+		expr.set_error ();
+		break;
+	      }
+
+	    /* Call the typeinfo name function.  */
+	    std::string type_name = kcfi_typeinfo_get_name (type);
+	    expr.value = build_string_literal (type_name.length () + 1,
+					       type_name.c_str ());
+	    set_c_expr_source_range (&expr, loc, close_paren_loc);
+	  }
+	  break;
+	case RID_BUILTIN_LINUX_ABI_KCFI_HASH:
+	  {
+	    c_parser_consume_token (parser);
+	    location_t close_paren_loc;
+	    tree type;
+	    if (!c_parser_get_builtin_type_arg (parser,
+						"__builtin_linux_abi_kcfi_hash",
+						&type, &close_paren_loc))
+	      {
+		expr.set_error ();
+		break;
+	      }
+
+	    /* Call the typeinfo hash function.  */
+	    uint32_t type_hash = kcfi_typeinfo_get_hash (type);
+	    expr.value = build_int_cst (unsigned_type_node, type_hash);
+	    set_c_expr_source_range (&expr, loc, close_paren_loc);
+	  }
+	  break;
 	case RID_BUILTIN_TGMATH:
 	  {
 	    vec<c_expr_t, va_gc> *cexpr_list;
diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
new file mode 100644
index 000000000000..b6723fac48da
--- /dev/null
+++ b/gcc/kcfi-typeinfo.cc
@@ -0,0 +1,1009 @@
+/* KCFI-compatible type mangling, based on Itanium C++ ABI.
+   Copyright (C) 2026 Free Software Foundation, Inc.
+
+This file is part of GCC.
+
+GCC is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 3, or (at your option) any later
+version.
+
+GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+for more details.
+
+You should have received a copy of the GNU General Public License
+along with GCC; see the file COPYING3.  If not see
+<http://www.gnu.org/licenses/>.  */
+
+/* Produces typeinfo mangling similar to Itanium C++ Mangling ABI, but
+   limited to types exposed within GCC for C language handling.  The
+   hashes are used by KCFI (and future type-aware allocator support).
+   The strings are used for testing and debugging.  */
+
+#define INCLUDE_STRING
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "tree.h"
+#include "target.h"
+#include "diagnostic-core.h"
+#include "stringpool.h"
+#include "stor-layout.h"
+#include "print-tree.h"
+#include "kcfi-typeinfo.h"
+
+/* Forward declaration for recursive type mangling.  */
+
+static void mangle_type (tree type, std::string *out_str, uint32_t *hash_state);
+
+/* Helper to update FNV-1a hash with a single character.  HASH_STATE is
+   the hash accumulator to update.  C is the character to hash.  */
+
+static inline void
+fnv1a_hash_char (uint32_t *hash_state, unsigned char c)
+{
+  *hash_state ^= c;
+  *hash_state *= 16777619U; /* FNV-1a 32-bit prime.  */
+}
+
+/* Helper to append character to optional string and update hash using
+   FNV-1a.  C is the character to append.  OUT_STR is the optional string
+   to append to (NULL if not needed).  HASH_STATE is the optional hash
+   accumulator to update (NULL if not needed).  */
+
+static void
+append_char (char c, std::string *out_str, uint32_t *hash_state)
+{
+  if (out_str)
+    *out_str += c;
+  if (!hash_state)
+    return;
+  fnv1a_hash_char (hash_state, (unsigned char) c);
+}
+
+/* Helper to append string to optional string and update hash using
+   FNV-1a.  STR is the string to append.  OUT_STR is the optional string
+   to append to (NULL if not needed).  HASH_STATE is the optional hash
+   accumulator to update (NULL if not needed).  */
+
+static void
+append_string (const char *str, std::string *out_str, uint32_t *hash_state)
+{
+  if (out_str)
+    *out_str += str;
+  if (!hash_state)
+    return;
+  for (const char *p = str; *p; p++)
+    fnv1a_hash_char (hash_state, (unsigned char) *p);
+}
+
+/* Mangle a builtin type following Itanium C++ ABI for C types.  TYPE is
+   the builtin type to mangle.  OUT_STR is the optional string to append
+   mangling to (NULL if not needed).  HASH_STATE is the optional hash
+   accumulator to update (NULL if not needed).  */
+
+static void
+mangle_builtin_type (tree type, std::string *out_str, uint32_t *hash_state)
+{
+  gcc_assert (type != NULL_TREE);
+
+  /* Handle any target-specific fundamental types first, matching the
+     Itanium C++ ABI mangler (e.g. x86 __float128 -> "g", _Float16 -> "DF16_",
+     __bf16 -> "DF16b", and PowerPC MMA opaque types).  */
+  if (const char *target_mangling = targetm.mangle_type (type))
+    {
+      append_string (target_mangling, out_str, hash_state);
+      return;
+    }
+
+  switch (TREE_CODE (type))
+    {
+    case VOID_TYPE:
+      append_char ('v', out_str, hash_state);
+      return;
+
+    case BOOLEAN_TYPE:
+      append_char ('b', out_str, hash_state);
+      return;
+
+    case INTEGER_TYPE:
+      if (type == char_type_node)
+	append_char ('c', out_str, hash_state);
+      else if (type == signed_char_type_node)
+	append_char ('a', out_str, hash_state);
+      else if (type == unsigned_char_type_node)
+	append_char ('h', out_str, hash_state);
+      else if (type == short_integer_type_node)
+	append_char ('s', out_str, hash_state);
+      else if (type == short_unsigned_type_node)
+	append_char ('t', out_str, hash_state);
+      else if (type == integer_type_node)
+	append_char ('i', out_str, hash_state);
+      else if (type == unsigned_type_node)
+	append_char ('j', out_str, hash_state);
+      else if (type == long_integer_type_node)
+	append_char ('l', out_str, hash_state);
+      else if (type == long_unsigned_type_node)
+	append_char ('m', out_str, hash_state);
+      else if (type == long_long_integer_type_node)
+	append_char ('x', out_str, hash_state);
+      else if (type == long_long_unsigned_type_node)
+	append_char ('y', out_str, hash_state);
+      else
+	{
+	  /* Fallback for other integer types - use precision-based
+	     encoding.  */
+	  append_char ('i', out_str, hash_state);
+	  append_string (std::to_string (TYPE_PRECISION (type)).c_str (),
+			 out_str, hash_state);
+	}
+      return;
+
+    case REAL_TYPE:
+      /* Encodings mirror the Itanium C++ ABI (see cp/mangle.cc).  Target FP
+	 types such as x86 __float128 ("g") are handled by the target hook
+	 above.  */
+      if (type == float_type_node)
+	append_char ('f', out_str, hash_state);
+      else if (type == double_type_node)
+	append_char ('d', out_str, hash_state);
+      else if (type == long_double_type_node)
+	append_char ('e', out_str, hash_state);
+      else if (type == dfloat32_type_node)
+	append_string ("Df", out_str, hash_state);
+      else if (type == dfloat64_type_node)
+	append_string ("Dd", out_str, hash_state);
+      else if (type == dfloat128_type_node)
+	append_string ("De", out_str, hash_state);
+      else if (type == float16_type_node)
+	append_string ("DF16_", out_str, hash_state);
+      else if (type == float32_type_node)
+	append_string ("DF32_", out_str, hash_state);
+      else if (type == float64_type_node)
+	append_string ("DF64_", out_str, hash_state);
+      else if (type == float128_type_node)
+	append_string ("DF128_", out_str, hash_state);
+      else if (type == float32x_type_node)
+	append_string ("DF32x", out_str, hash_state);
+      else if (type == float64x_type_node)
+	append_string ("DF64x", out_str, hash_state);
+      else if (type == float128x_type_node)
+	append_string ("DF128x", out_str, hash_state);
+      else if (type == bfloat16_type_node)
+	append_string ("DF16b", out_str, hash_state);
+      else
+	{
+	  /* Unknown real type: emit a deterministic vendor-extended name
+	     keyed on the machine mode, so distinct modes never collide.  */
+	  std::string name
+	    = std::string ("rf") + GET_MODE_NAME (TYPE_MODE (type));
+	  append_char ('u', out_str, hash_state);
+	  append_string (std::to_string (name.length ()).c_str (),
+			 out_str, hash_state);
+	  append_string (name.c_str (), out_str, hash_state);
+	}
+      return;
+
+    case VECTOR_TYPE:
+      {
+	/* Handle vector types:
+	   Dv<num-elements>_<element-type-encoding>
+	   Example: uint8x16_t -> Dv16_h (vector of 16 unsigned char)  */
+	tree vector_size = TYPE_SIZE_UNIT (type);
+	tree element_type = TREE_TYPE (type);
+	tree element_size = TYPE_SIZE_UNIT (element_type);
+
+	if (vector_size && element_size
+	    && TREE_CODE (vector_size) == INTEGER_CST
+	    && TREE_CODE (element_size) == INTEGER_CST)
+	  {
+	    append_char ('D', out_str, hash_state);
+	    append_char ('v', out_str, hash_state);
+
+	    unsigned HOST_WIDE_INT vec_bytes = tree_to_uhwi (vector_size);
+	    unsigned HOST_WIDE_INT elem_bytes = tree_to_uhwi (element_size);
+	    unsigned HOST_WIDE_INT num_elements = vec_bytes / elem_bytes;
+
+	    /* Append number of elements.  */
+	    append_string (std::to_string (num_elements).c_str (),
+			   out_str, hash_state);
+	    append_char ('_', out_str, hash_state);
+
+	    /* Recursively mangle the element type.  */
+	    mangle_type (element_type, out_str, hash_state);
+	    return;
+	  }
+
+	/* Scalable vectors (like RISC-V RVV types): use type name if
+	   available, otherwise use a generic scalable vector encoding.  */
+	if (TYPE_NAME (type))
+	  {
+	    const char *name = NULL;
+	    if (TREE_CODE (TYPE_NAME (type)) == TYPE_DECL)
+	      {
+		tree decl_name = DECL_NAME (TYPE_NAME (type));
+		if (decl_name && TREE_CODE (decl_name) == IDENTIFIER_NODE)
+		  name = IDENTIFIER_POINTER (decl_name);
+	      }
+	    else if (TREE_CODE (TYPE_NAME (type)) == IDENTIFIER_NODE)
+	      {
+		name = IDENTIFIER_POINTER (TYPE_NAME (type));
+	      }
+
+	    if (name)
+	      {
+		/* Use vendor-extended type name encoding: u<length><name>.  */
+		append_char ('u', out_str, hash_state);
+		append_string (std::to_string (strlen (name)).c_str (),
+			       out_str, hash_state);
+		append_string (name, out_str, hash_state);
+		return;
+	      }
+	  }
+
+	/* Fallback for unnamed scalable vectors: encode as Dv0_<element>.
+	   Using 0 elements indicates scalable/unknown size.  */
+	append_string ("Dv0_", out_str, hash_state);
+	mangle_type (element_type, out_str, hash_state);
+	return;
+      }
+
+    case BITINT_TYPE:
+      /* Bit-precise integer types follow the Itanium C++ ABI:
+	 DB<N>_ for signed _BitInt(N), DU<N>_ for unsigned _BitInt(N).  */
+      append_char ('D', out_str, hash_state);
+      append_char (TYPE_UNSIGNED (type) ? 'U' : 'B', out_str, hash_state);
+      append_string (std::to_string (TYPE_PRECISION (type)).c_str (),
+		     out_str, hash_state);
+      append_char ('_', out_str, hash_state);
+      return;
+
+    case NULLPTR_TYPE:
+      /* The type of C23 nullptr (std::nullptr_t): Dn.  */
+      append_string ("Dn", out_str, hash_state);
+      return;
+
+    case FIXED_POINT_TYPE:
+      {
+	/* Fixed-point types (_Fract/_Accum, ISO/IEC TR 18037) have no
+	   Itanium C++ ABI mangling.  Emit a deterministic vendor-extended
+	   name: the machine mode encodes size, signedness and the
+	   fract/accum distinction; the saturating flag is separate.  */
+	std::string name
+	  = std::string ("fx") + GET_MODE_NAME (TYPE_MODE (type));
+	if (TYPE_SATURATING (type))
+	  name += "s";
+	append_char ('u', out_str, hash_state);
+	append_string (std::to_string (name.length ()).c_str (),
+		       out_str, hash_state);
+	append_string (name.c_str (), out_str, hash_state);
+	return;
+      }
+
+    case OPAQUE_TYPE:
+      {
+	/* Target opaque types (e.g. PowerPC MMA __vector_pair) are normally
+	   mangled by the target hook above; if the target provides none, fall
+	   back to a deterministic vendor-extended name keyed on the type name
+	   or, lacking that, the machine mode.  */
+	const char *name = NULL;
+	if (TYPE_NAME (type))
+	  {
+	    if (TREE_CODE (TYPE_NAME (type)) == TYPE_DECL
+		&& DECL_NAME (TYPE_NAME (type)))
+	      name = IDENTIFIER_POINTER (DECL_NAME (TYPE_NAME (type)));
+	    else if (TREE_CODE (TYPE_NAME (type)) == IDENTIFIER_NODE)
+	      name = IDENTIFIER_POINTER (TYPE_NAME (type));
+	  }
+	std::string vname = std::string ("op")
+	  + (name ? name : GET_MODE_NAME (TYPE_MODE (type)));
+	append_char ('u', out_str, hash_state);
+	append_string (std::to_string (vname.length ()).c_str (),
+		       out_str, hash_state);
+	append_string (vname.c_str (), out_str, hash_state);
+	return;
+      }
+
+    default:
+      break;
+    }
+
+  /* Unknown builtin type: this should never happen in a well-formed C.  */
+  debug_tree (type);
+  internal_error ("mangle: Unknown builtin type - please report this as a bug");
+}
+
+/* Canonicalize typedef types to their underlying named struct/union types.
+   TYPE is the type to canonicalize.  Returns the canonicalized type.  */
+
+static tree
+canonicalize_typedef_type (tree type)
+{
+  /* Handle typedef types: canonicalize to named structs when possible.  */
+  if (TYPE_NAME (type) && TREE_CODE (TYPE_NAME (type)) == TYPE_DECL)
+    {
+      tree type_decl = TYPE_NAME (type);
+
+      /* Check if this is a typedef (not the original struct declaration) */
+      if (DECL_ORIGINAL_TYPE (type_decl))
+	{
+	  tree original_type = DECL_ORIGINAL_TYPE (type_decl);
+
+	  /* Handle struct/union/enum types.  */
+	  if (TREE_CODE (original_type) == RECORD_TYPE
+	      || TREE_CODE (original_type) == UNION_TYPE
+	      || TREE_CODE (original_type) == ENUMERAL_TYPE)
+	    {
+	      /* Preserve typedef of anonymous struct/union/enum types.  */
+	      if (!TYPE_NAME (original_type))
+		return type;
+
+	      /* Named compound type: canonicalize to it.  */
+	      return canonicalize_typedef_type (original_type);
+	    }
+
+	  /* For basic type typedefs (e.g., u8 -> unsigned char),
+	     canonicalize to original type.  */
+	  if (TREE_CODE (original_type) == INTEGER_TYPE
+	      || TREE_CODE (original_type) == REAL_TYPE
+	      || TREE_CODE (original_type) == POINTER_TYPE
+	      || TREE_CODE (original_type) == ARRAY_TYPE
+	      || TREE_CODE (original_type) == FUNCTION_TYPE
+	      || TREE_CODE (original_type) == METHOD_TYPE
+	      || TREE_CODE (original_type) == BOOLEAN_TYPE
+	      || TREE_CODE (original_type) == COMPLEX_TYPE
+	      || TREE_CODE (original_type) == VECTOR_TYPE)
+	    {
+	      /* Recursively canonicalize in case the original type is
+		 also a typedef.  */
+	      return canonicalize_typedef_type (original_type);
+	    }
+	}
+    }
+
+  return type;
+}
+
+/* Recursively mangle a C type following Itanium C++ ABI.  TYPE is the
+   type to mangle.  OUT_STR is the optional string to append mangling to
+   (NULL if not needed).  HASH_STATE is the optional hash accumulator to
+   update (NULL if not needed).  */
+
+static void
+mangle_type (tree type, std::string *out_str, uint32_t *hash_state)
+{
+  gcc_assert (type != NULL_TREE);
+
+  /* Canonicalize typedef types to their underlying named struct types.  */
+  type = canonicalize_typedef_type (type);
+
+  /* Save original qualified type for cases where we need typedef
+     information.  */
+  tree qualified_type = type;
+
+  /* Centralized qualifier handling: emit qualifiers for this type,
+     then continue with unqualified version.  */
+  if (TYPE_QUALS (type) != TYPE_UNQUALIFIED)
+    {
+      /* Emit qualifiers in Itanium ABI order: restrict, volatile, const.  */
+      if (TYPE_QUALS (type) & TYPE_QUAL_RESTRICT)
+	append_char ('r', out_str, hash_state);
+      if (TYPE_QUALS (type) & TYPE_QUAL_VOLATILE)
+	append_char ('V', out_str, hash_state);
+      if (TYPE_QUALS (type) & TYPE_QUAL_CONST)
+	append_char ('K', out_str, hash_state);
+
+      /* Get unqualified version for further processing.  */
+      type = TYPE_MAIN_VARIANT (type);
+    }
+
+  switch (TREE_CODE (type))
+    {
+    case POINTER_TYPE:
+      {
+	/* Pointer type: 'P' + pointed-to type.  */
+	append_char ('P', out_str, hash_state);
+
+	/* Recursively mangle the pointed-to type.  */
+	tree pointed_to_type = TREE_TYPE (type);
+	mangle_type (pointed_to_type, out_str, hash_state);
+	break;
+      }
+
+    case COMPLEX_TYPE:
+      /* Complex type (C99 _Complex): 'C' + element type.  */
+      append_char ('C', out_str, hash_state);
+      mangle_type (TREE_TYPE (type), out_str, hash_state);
+      break;
+
+    case ARRAY_TYPE:
+      /* Array type: 'A' + size + '_' + element type (simplified).  */
+      append_char ('A', out_str, hash_state);
+      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
+	{
+	  tree max_val = TYPE_MAX_VALUE (TYPE_DOMAIN (type));
+	  /* Check if array size is compile-time constant to handle VLAs.  */
+	  if (TREE_CODE (max_val) == INTEGER_CST && tree_fits_shwi_p (max_val))
+	    {
+	      HOST_WIDE_INT size = tree_to_shwi (max_val) + 1;
+	      append_string (std::to_string ((long) size).c_str (),
+			     out_str, hash_state);
+	    }
+	  /* For VLAs or non-constant dimensions, emit empty size (A_).  */
+	  append_char ('_', out_str, hash_state);
+	}
+      else
+	{
+	  /* No domain or no max value: emit A_.  */
+	  append_char ('_', out_str, hash_state);
+	}
+      mangle_type (TREE_TYPE (type), out_str, hash_state);
+      break;
+
+    case REFERENCE_TYPE:
+      /* Reference type: 'R' + referenced type.
+	 Note: We must handle references to builtin types including compiler
+	 builtins like __builtin_va_list used in functions like va_start.  */
+      append_char ('R', out_str, hash_state);
+      mangle_type (TREE_TYPE (type), out_str, hash_state);
+      break;
+
+    case FUNCTION_TYPE:
+      {
+	/* Function type: 'F' + return type + parameter types + 'E' */
+	append_char ('F', out_str, hash_state);
+	mangle_type (TREE_TYPE (type), out_str, hash_state);
+
+	/* Add parameter types.  */
+	tree param_types = TYPE_ARG_TYPES (type);
+
+	if (param_types == NULL_TREE)
+	  {
+	    /* func () - no parameter list (could be variadic). */
+	  }
+	else
+	  {
+	    bool found_real_params = false;
+	    for (tree param = param_types; param; param = TREE_CHAIN (param))
+	      {
+		tree param_type = TREE_VALUE (param);
+		if (param_type == void_type_node)
+		  {
+		    /* Check if this is the first parameter (explicit void) or a
+		       sentinel.  */
+		    if (!found_real_params)
+		      {
+			/* func (void) - explicit empty parameter list.
+			   Mangle void to distinguish from variadic func (). */
+			mangle_type (void_type_node, out_str, hash_state);
+		      }
+		    /* If we found real params before this void, it's a sentinel
+		       so stop here.  */
+		    break;
+		  }
+
+		found_real_params = true;
+
+		/* For value parameters, ignore const/volatile qualifiers as
+		   they don't affect the calling convention.  "const int" and
+		   "int" are passed identically by value.  */
+		tree canonical_param_type = param_type;
+
+		if (TREE_CODE (param_type) != POINTER_TYPE
+		    && TREE_CODE (param_type) != REFERENCE_TYPE
+		    && TREE_CODE (param_type) != ARRAY_TYPE)
+		  {
+		    /* For non-pointer/reference value parameters, strip
+		       qualifiers by default.  */
+		    canonical_param_type = TYPE_MAIN_VARIANT (param_type);
+
+		    /* Exception: preserve typedef information for anonymous
+		       compound types.  */
+		    if (TYPE_NAME (param_type)
+			&& TREE_CODE (TYPE_NAME (param_type)) == TYPE_DECL
+			&& DECL_ORIGINAL_TYPE (TYPE_NAME (param_type)))
+		      {
+			tree original_type
+			  = DECL_ORIGINAL_TYPE (TYPE_NAME (param_type));
+			if ((TREE_CODE (original_type) == RECORD_TYPE
+			     || TREE_CODE (original_type) == UNION_TYPE
+			     || TREE_CODE (original_type) == ENUMERAL_TYPE)
+			    && !TYPE_NAME (original_type))
+			  {
+			    /* Preserve typedef of an anonymous
+			       struct/union/enum.  */
+			    canonical_param_type = param_type;
+			  }
+		      }
+		  }
+
+		mangle_type (canonical_param_type, out_str, hash_state);
+	      }
+	  }
+
+	/* Check if this is a variadic function and add 'z' marker.  */
+	if (stdarg_p (type))
+	  {
+	    append_char ('z', out_str, hash_state);
+	  }
+
+	append_char ('E', out_str, hash_state);
+	break;
+      }
+
+    case RECORD_TYPE:
+    case UNION_TYPE:
+    case ENUMERAL_TYPE:
+      {
+	/* Struct/union/enum: use simplified representation for C types.  */
+	const char *name = NULL;
+
+	/* For compound types, use the original qualified type to preserve
+	   typedef info.  */
+	if (TYPE_QUALS (qualified_type) != TYPE_UNQUALIFIED)
+	  {
+	    type = qualified_type;
+	  }
+
+	if (TYPE_NAME (type))
+	  {
+	    if (TREE_CODE (TYPE_NAME (type)) == TYPE_DECL)
+	      {
+		/* TYPE_DECL case: both named structs and typedef structs.  */
+		tree decl_name = DECL_NAME (TYPE_NAME (type));
+		if (decl_name && TREE_CODE (decl_name) == IDENTIFIER_NODE)
+		  {
+		    name = IDENTIFIER_POINTER (decl_name);
+		  }
+	      }
+	    else if (TREE_CODE (TYPE_NAME (type)) == IDENTIFIER_NODE)
+	      {
+		/* Direct identifier case.  */
+		name = IDENTIFIER_POINTER (TYPE_NAME (type));
+	      }
+	  }
+
+	if (name)
+	  {
+	    append_string (std::to_string (strlen (name)).c_str (),
+			   out_str, hash_state);
+	    append_string (name, out_str, hash_state);
+	    break;
+	  }
+
+	/* If no name found, use anonymous type format: <length>$_<counter>.  */
+	static unsigned anon_counter = 0;
+	std::string anon_name = "$_" + std::to_string (anon_counter++);
+
+	append_string (std::to_string (anon_name.length ()).c_str (),
+		       out_str, hash_state);
+	append_string (anon_name.c_str (), out_str, hash_state);
+	break;
+      }
+
+    default:
+      /* Handle builtin types.  */
+      mangle_builtin_type (type, out_str, hash_state);
+      break;
+    }
+}
+
+/* Get the typeinfo mangled name string for any C type.  TYPE is the type
+   to mangle.  Returns the mangled type string following Itanium C++ ABI
+   conventions.  */
+
+std::string
+kcfi_typeinfo_get_name (tree type)
+{
+  gcc_assert (type != NULL_TREE);
+  std::string result = "";
+
+  /* Add Itanium typeinfo-name mangling prefix.  */
+  append_string ("_ZTS", &result, nullptr);
+  mangle_type (type, &result, nullptr);
+  return result;
+}
+
+/* Get the typeinfo hash for any C type.  TYPE is the type to hash.
+   Returns the FNV-1a hash of the mangled type string.  */
+
+uint32_t
+kcfi_typeinfo_get_hash (tree type)
+{
+  gcc_assert (type != NULL_TREE);
+  uint32_t hash_state = 2166136261U; /* FNV-1a 32-bit offset basis.  */
+
+  /* Add Itanium typeinfo-name mangling prefix.  */
+  append_string ("_ZTS", nullptr, &hash_state);
+  mangle_type (type, nullptr, &hash_state);
+  return hash_state;
+}
+
+#if CHECKING_P
+
+#include "selftest.h"
+
+namespace selftest {
+
+/* Bare Itanium mangling of TYPE, i.e. without the "_ZTS" typeinfo-name prefix
+   that the public entry points prepend.  Used to unit-test the recursive
+   mangler independently of that prefix to make the type/string pairs easier
+   to read here.  */
+
+static std::string
+kcfi_test_mangle (tree type)
+{
+  std::string result = "";
+  mangle_type (type, &result, nullptr);
+  return result;
+}
+
+/* Test mangling of basic builtin types.  */
+
+static void
+test_typeinfo_basic_types ()
+{
+  ASSERT_STREQ ("v", kcfi_test_mangle (void_type_node).c_str ());
+  ASSERT_STREQ ("c", kcfi_test_mangle (char_type_node).c_str ());
+  ASSERT_STREQ ("a", kcfi_test_mangle (signed_char_type_node).c_str ());
+  ASSERT_STREQ ("h", kcfi_test_mangle (unsigned_char_type_node).c_str ());
+  ASSERT_STREQ ("s", kcfi_test_mangle (short_integer_type_node).c_str ());
+  ASSERT_STREQ ("t", kcfi_test_mangle (short_unsigned_type_node).c_str ());
+  ASSERT_STREQ ("i", kcfi_test_mangle (integer_type_node).c_str ());
+  ASSERT_STREQ ("j", kcfi_test_mangle (unsigned_type_node).c_str ());
+  ASSERT_STREQ ("l", kcfi_test_mangle (long_integer_type_node).c_str ());
+  ASSERT_STREQ ("m", kcfi_test_mangle (long_unsigned_type_node).c_str ());
+  ASSERT_STREQ ("x", kcfi_test_mangle (long_long_integer_type_node).c_str ());
+  ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_str ());
+  ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
+  ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
+  ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
+}
+
+/* Test mangling of pointer types.  */
+
+static void
+test_typeinfo_pointer_types ()
+{
+  tree char_ptr = build_pointer_type (char_type_node);
+  ASSERT_STREQ ("Pc", kcfi_test_mangle (char_ptr).c_str ());
+
+  tree int_ptr = build_pointer_type (integer_type_node);
+  ASSERT_STREQ ("Pi", kcfi_test_mangle (int_ptr).c_str ());
+
+  tree void_ptr = build_pointer_type (void_type_node);
+  ASSERT_STREQ ("Pv", kcfi_test_mangle (void_ptr).c_str ());
+
+  /* Pointer to pointer.  */
+  tree int_ptr_ptr = build_pointer_type (int_ptr);
+  ASSERT_STREQ ("PPi", kcfi_test_mangle (int_ptr_ptr).c_str ());
+
+  tree void_ptr_ptr = build_pointer_type (void_ptr);
+  ASSERT_STREQ ("PPv", kcfi_test_mangle (void_ptr_ptr).c_str ());
+}
+
+/* Test mangling of qualified types.  */
+
+static void
+test_typeinfo_qualified_types ()
+{
+  tree const_int = build_qualified_type (integer_type_node, TYPE_QUAL_CONST);
+  ASSERT_STREQ ("Ki", kcfi_test_mangle (const_int).c_str ());
+
+  tree volatile_int = build_qualified_type (integer_type_node,
+					    TYPE_QUAL_VOLATILE);
+  ASSERT_STREQ ("Vi", kcfi_test_mangle (volatile_int).c_str ());
+
+  /* const char *.  */
+  tree const_char = build_qualified_type (char_type_node, TYPE_QUAL_CONST);
+  tree const_char_ptr = build_pointer_type (const_char);
+  ASSERT_STREQ ("PKc", kcfi_test_mangle (const_char_ptr).c_str ());
+
+  /* const void *.  */
+  tree const_void = build_qualified_type (void_type_node, TYPE_QUAL_CONST);
+  tree const_void_ptr = build_pointer_type (const_void);
+  ASSERT_STREQ ("PKv", kcfi_test_mangle (const_void_ptr).c_str ());
+
+  /* const int *.  */
+  tree const_int_ptr = build_pointer_type (const_int);
+  ASSERT_STREQ ("PKi", kcfi_test_mangle (const_int_ptr).c_str ());
+}
+
+/* Test mangling of function types.  */
+
+static void
+test_typeinfo_function_types ()
+{
+  /* void func(void) -> "FvvE".  */
+  tree void_void = build_function_type_list (void_type_node,
+					     void_type_node, NULL_TREE);
+  ASSERT_STREQ ("FvvE", kcfi_test_mangle (void_void).c_str ());
+
+  /* void func(int) -> "FviE".  */
+  tree void_int = build_function_type_list (void_type_node,
+					    integer_type_node, NULL_TREE);
+  ASSERT_STREQ ("FviE", kcfi_test_mangle (void_int).c_str ());
+
+  /* void func(char) -> "FvcE".  */
+  tree void_char = build_function_type_list (void_type_node,
+					     char_type_node, NULL_TREE);
+  ASSERT_STREQ ("FvcE", kcfi_test_mangle (void_char).c_str ());
+
+  /* void func(short) -> "FvsE".  */
+  tree void_short = build_function_type_list (void_type_node,
+					      short_integer_type_node,
+					      NULL_TREE);
+  ASSERT_STREQ ("FvsE", kcfi_test_mangle (void_short).c_str ());
+
+  /* void func(long) -> "FvlE".  */
+  tree void_long = build_function_type_list (void_type_node,
+					     long_integer_type_node, NULL_TREE);
+  ASSERT_STREQ ("FvlE", kcfi_test_mangle (void_long).c_str ());
+
+  /* int func(void) -> "FivE".  */
+  tree int_void = build_function_type_list (integer_type_node,
+					    void_type_node, NULL_TREE);
+  ASSERT_STREQ ("FivE", kcfi_test_mangle (int_void).c_str ());
+
+  /* char func(void) -> "FcvE".  */
+  tree char_void = build_function_type_list (char_type_node,
+					     void_type_node, NULL_TREE);
+  ASSERT_STREQ ("FcvE", kcfi_test_mangle (char_void).c_str ());
+
+  /* void* func(void) -> "FPvvE".  */
+  tree void_ptr = build_pointer_type (void_type_node);
+  tree voidptr_void = build_function_type_list (void_ptr,
+						void_type_node, NULL_TREE);
+  ASSERT_STREQ ("FPvvE", kcfi_test_mangle (voidptr_void).c_str ());
+}
+
+/* Test mangling of function types with pointer parameters.  */
+
+static void
+test_typeinfo_function_pointer_params ()
+{
+  tree void_ptr = build_pointer_type (void_type_node);
+  tree char_ptr = build_pointer_type (char_type_node);
+  tree int_ptr = build_pointer_type (integer_type_node);
+  tree long_ptr = build_pointer_type (long_integer_type_node);
+
+  /* void func(void*) -> "FvPvE".  */
+  tree void_voidptr = build_function_type_list (void_type_node,
+						void_ptr, NULL_TREE);
+  ASSERT_STREQ ("FvPvE", kcfi_test_mangle (void_voidptr).c_str ());
+
+  /* void func(char*) -> "FvPcE".  */
+  tree void_charptr = build_function_type_list (void_type_node,
+						char_ptr, NULL_TREE);
+  ASSERT_STREQ ("FvPcE", kcfi_test_mangle (void_charptr).c_str ());
+
+  /* void func(int*) -> "FvPiE".  */
+  tree void_intptr = build_function_type_list (void_type_node,
+					       int_ptr, NULL_TREE);
+  ASSERT_STREQ ("FvPiE", kcfi_test_mangle (void_intptr).c_str ());
+
+  /* void func(long*) -> "FvPlE".  */
+  tree void_longptr = build_function_type_list (void_type_node,
+						long_ptr, NULL_TREE);
+  ASSERT_STREQ ("FvPlE", kcfi_test_mangle (void_longptr).c_str ());
+
+  /* void func(const char*) -> "FvPKcE".  */
+  tree const_char = build_qualified_type (char_type_node, TYPE_QUAL_CONST);
+  tree const_char_ptr = build_pointer_type (const_char);
+  tree void_constcharptr = build_function_type_list (void_type_node,
+						     const_char_ptr, NULL_TREE);
+  ASSERT_STREQ ("FvPKcE", kcfi_test_mangle (void_constcharptr).c_str ());
+
+  /* void func(const void*) -> "FvPKvE".  */
+  tree const_void = build_qualified_type (void_type_node, TYPE_QUAL_CONST);
+  tree const_void_ptr = build_pointer_type (const_void);
+  tree void_constvoidptr = build_function_type_list (void_type_node,
+						     const_void_ptr, NULL_TREE);
+  ASSERT_STREQ ("FvPKvE", kcfi_test_mangle (void_constvoidptr).c_str ());
+
+  /* void func(int**) -> "FvPPiE".  */
+  tree int_ptr_ptr = build_pointer_type (int_ptr);
+  tree void_intptrptr = build_function_type_list (void_type_node,
+						  int_ptr_ptr, NULL_TREE);
+  ASSERT_STREQ ("FvPPiE", kcfi_test_mangle (void_intptrptr).c_str ());
+}
+
+/* Test mangling of function types with multiple parameters.  */
+
+static void
+test_typeinfo_function_multi_params ()
+{
+  /* void func(int, char) -> "FvicE".  */
+  tree void_int_char = build_function_type_list (void_type_node,
+						 integer_type_node,
+						 char_type_node, NULL_TREE);
+  ASSERT_STREQ ("FvicE", kcfi_test_mangle (void_int_char).c_str ());
+
+  /* void func(char, int) -> "FvciE".  */
+  tree void_char_int = build_function_type_list (void_type_node,
+						 char_type_node,
+						 integer_type_node, NULL_TREE);
+  ASSERT_STREQ ("FvciE", kcfi_test_mangle (void_char_int).c_str ());
+
+  /* void func(int, int) -> "FviiE".  */
+  tree void_int_int = build_function_type_list (void_type_node,
+						integer_type_node,
+						integer_type_node, NULL_TREE);
+  ASSERT_STREQ ("FviiE", kcfi_test_mangle (void_int_int).c_str ());
+
+  /* void func(int*, int) -> "FvPiiE".  */
+  tree int_ptr = build_pointer_type (integer_type_node);
+  tree void_intptr_int = build_function_type_list (void_type_node,
+						   int_ptr,
+						   integer_type_node,
+						   NULL_TREE);
+  ASSERT_STREQ ("FvPiiE", kcfi_test_mangle (void_intptr_int).c_str ());
+
+  /* void func(int, int*) -> "FviPiE".  */
+  tree void_int_intptr = build_function_type_list (void_type_node,
+						   integer_type_node,
+						   int_ptr, NULL_TREE);
+  ASSERT_STREQ ("FviPiE", kcfi_test_mangle (void_int_intptr).c_str ());
+}
+
+/* Test mangling of function pointer types.  */
+
+static void
+test_typeinfo_function_pointer_types ()
+{
+  /* void (*)(void) -> "PFvvE".  */
+  tree void_void = build_function_type_list (void_type_node,
+					     void_type_node, NULL_TREE);
+  tree fptr_void_void = build_pointer_type (void_void);
+  ASSERT_STREQ ("PFvvE", kcfi_test_mangle (fptr_void_void).c_str ());
+
+  /* void (*)(int) -> "PFviE".  */
+  tree void_int = build_function_type_list (void_type_node,
+					    integer_type_node, NULL_TREE);
+  tree fptr_void_int = build_pointer_type (void_int);
+  ASSERT_STREQ ("PFviE", kcfi_test_mangle (fptr_void_int).c_str ());
+
+  /* int (*)(void) -> "PFivE".  */
+  tree int_void = build_function_type_list (integer_type_node,
+					    void_type_node, NULL_TREE);
+  tree fptr_int_void = build_pointer_type (int_void);
+  ASSERT_STREQ ("PFivE", kcfi_test_mangle (fptr_int_void).c_str ());
+}
+
+/* Test mangling of functions with function pointer parameters.  */
+
+static void
+test_typeinfo_function_fptr_params ()
+{
+  /* void func(void (*)(void)) -> "FvPFvvEE".  */
+  tree void_void = build_function_type_list (void_type_node,
+					     void_type_node, NULL_TREE);
+  tree fptr_void_void = build_pointer_type (void_void);
+  tree func_fptr_void = build_function_type_list (void_type_node,
+						  fptr_void_void, NULL_TREE);
+  ASSERT_STREQ ("FvPFvvEE", kcfi_test_mangle (func_fptr_void).c_str ());
+
+  /* void func(void (*)(int)) -> "FvPFviEE".  */
+  tree void_int = build_function_type_list (void_type_node,
+					    integer_type_node, NULL_TREE);
+  tree fptr_void_int = build_pointer_type (void_int);
+  tree func_fptr_int = build_function_type_list (void_type_node,
+						 fptr_void_int, NULL_TREE);
+  ASSERT_STREQ ("FvPFviEE", kcfi_test_mangle (func_fptr_int).c_str ());
+
+  /* void func(int (*)(void)) -> "FvPFivEE".  */
+  tree int_void = build_function_type_list (integer_type_node,
+					    void_type_node, NULL_TREE);
+  tree fptr_int_void = build_pointer_type (int_void);
+  tree func_fptr_ret_int = build_function_type_list (void_type_node,
+						     fptr_int_void, NULL_TREE);
+  ASSERT_STREQ ("FvPFivEE", kcfi_test_mangle (func_fptr_ret_int).c_str ());
+}
+
+/* Test mangling of functions returning function pointers.  */
+
+static void
+test_typeinfo_function_returning_fptr ()
+{
+  /* int (*func(void))(void) -> "FPFivEvE".  */
+  tree int_void = build_function_type_list (integer_type_node,
+					    void_type_node, NULL_TREE);
+  tree fptr_int_void = build_pointer_type (int_void);
+  tree func_ret_fptr = build_function_type_list (fptr_int_void,
+						 void_type_node, NULL_TREE);
+  ASSERT_STREQ ("FPFivEvE", kcfi_test_mangle (func_ret_fptr).c_str ());
+}
+
+/* Test mangling of array types.  */
+
+static void
+test_typeinfo_array_types ()
+{
+  /* int[10] -> "A10_i".  */
+  tree domain_10 = build_index_type (build_int_cst (sizetype, 9));
+  tree int_array_10 = build_array_type (integer_type_node, domain_10);
+  ASSERT_STREQ ("A10_i", kcfi_test_mangle (int_array_10).c_str ());
+
+  /* char[20] -> "A20_c".  */
+  tree domain_20 = build_index_type (build_int_cst (sizetype, 19));
+  tree char_array_20 = build_array_type (char_type_node, domain_20);
+  ASSERT_STREQ ("A20_c", kcfi_test_mangle (char_array_20).c_str ());
+
+  /* int[] (incomplete array) -> "A_i".  */
+  tree int_array_incomplete = build_array_type (integer_type_node, NULL_TREE);
+  ASSERT_STREQ ("A_i", kcfi_test_mangle (int_array_incomplete).c_str ());
+}
+
+/* Test that hash values are correct (FNV-1a of the mangled name).  */
+
+static void
+test_typeinfo_hash_values ()
+{
+  /* Verify hash for a basic type: "_ZTSi" -> 0x5fbda8e8.  */
+  ASSERT_EQ (0x5fbda8e8U, kcfi_typeinfo_get_hash (integer_type_node));
+
+  /* Verify hash for a function type: "_ZTSFviE" -> 0x70e35def.  */
+  tree void_int = build_function_type_list (void_type_node,
+					    integer_type_node, NULL_TREE);
+  ASSERT_EQ (0x70e35defU, kcfi_typeinfo_get_hash (void_int));
+
+  /* Verify hash for a pointer type: "_ZTSPKc" -> 0x05f5ee31.  */
+  tree const_char = build_qualified_type (char_type_node, TYPE_QUAL_CONST);
+  tree const_char_ptr = build_pointer_type (const_char);
+  ASSERT_EQ (0x05f5ee31U, kcfi_typeinfo_get_hash (const_char_ptr));
+
+  /* Verify hash for a complex function type: "_ZTSFvPFvvEE" -> 0xc88f6251.  */
+  tree void_void = build_function_type_list (void_type_node,
+					     void_type_node, NULL_TREE);
+  tree fptr = build_pointer_type (void_void);
+  tree func_fptr = build_function_type_list (void_type_node, fptr, NULL_TREE);
+  ASSERT_EQ (0xc88f6251U, kcfi_typeinfo_get_hash (func_fptr));
+}
+
+/* Test that the public entry points emit the Itanium typeinfo-name "_ZTS"
+   prefix, so the KCFI type-id matches expected FNV-1a of mangleTypeName
+   (i.e. "_ZTS" + the bare type mangling).  */
+
+static void
+test_typeinfo_zts_prefix ()
+{
+  tree int_int_int = build_function_type_list (integer_type_node,
+					       integer_type_node,
+					       integer_type_node, NULL_TREE);
+  tree int_int = build_function_type_list (integer_type_node,
+					   integer_type_node, NULL_TREE);
+
+  /* The name carries the "_ZTS" prefix ahead of the bare "F...E" mangling.  */
+  ASSERT_STREQ ("_ZTSFiiiE", kcfi_typeinfo_get_name (int_int_int).c_str ());
+  ASSERT_STREQ ("_ZTSFiiE", kcfi_typeinfo_get_name (int_int).c_str ());
+
+  /* The hashes match for the same prototypes: "_ZTSFiiiE" -> 0x70785afd,
+     "_ZTSFiiE" -> 0xb8360626.  */
+  ASSERT_EQ (0x70785afdU, kcfi_typeinfo_get_hash (int_int_int));
+  ASSERT_EQ (0xb8360626U, kcfi_typeinfo_get_hash (int_int));
+}
+
+/* Run all typeinfo selftests.  */
+
+void
+kcfi_typeinfo_cc_tests ()
+{
+  test_typeinfo_basic_types ();
+  test_typeinfo_pointer_types ();
+  test_typeinfo_qualified_types ();
+  test_typeinfo_function_types ();
+  test_typeinfo_function_pointer_params ();
+  test_typeinfo_function_multi_params ();
+  test_typeinfo_function_pointer_types ();
+  test_typeinfo_function_fptr_params ();
+  test_typeinfo_function_returning_fptr ();
+  test_typeinfo_array_types ();
+  test_typeinfo_hash_values ();
+  test_typeinfo_zts_prefix ();
+}
+
+} /* namespace selftest.  */
+
+#endif /* CHECKING_P */
diff --git a/gcc/selftest-run-tests.cc b/gcc/selftest-run-tests.cc
index 07eb984e918e..c2b85493327b 100644
--- a/gcc/selftest-run-tests.cc
+++ b/gcc/selftest-run-tests.cc
@@ -92,6 +92,7 @@ selftest::run_tests ()
   input_cc_tests ();
   vec_perm_indices_cc_tests ();
   tree_cc_tests ();
+  kcfi_typeinfo_cc_tests ();
   convert_cc_tests ();
   gimple_cc_tests ();
   rtl_tests_cc_tests ();
-- 
2.34.1

