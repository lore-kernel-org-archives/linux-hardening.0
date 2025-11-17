Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114F281368
	for <linux-hardening@vger.kernel.org>; Mon, 17 Nov 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763410353; cv=none; b=C/U2WvjHmhtA8IkYJLbOtJtUWHIZxg/G0FAzpTA1Zl+56WLKnOEENmpAQz4iDAjEHPyuidI/12XBzrj7YLP3U+15i+S7Thr7gM6zK3QmtIuarXj2V8q4ARzX3sR7lwzrsYNvjqfKLwIlZHIufMWDguwsHJAmiqxDTYeQuoZ/564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763410353; c=relaxed/simple;
	bh=S+EGvqn3SgMTgVmwq7y6XecKcPh5kT213kYegf+v5BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fa+xH7/lweSgn8SUDOwLjKklbT94tW9DWsUgslRp7rEBvIEXpVzPNbxy2v44qYkXkXrrPUkaqIShXY6Y/zTGdKIL9CvB7ExXMuitS/oJpHM3ENPDj/l5NaOcKXwB7jbeqmfHeqe9MgDnXEUPGFnMl03DLvcqSxXttY3tiX5A9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ9GUKNh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ9GUKNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E42C116B1;
	Mon, 17 Nov 2025 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763410352;
	bh=S+EGvqn3SgMTgVmwq7y6XecKcPh5kT213kYegf+v5BE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJ9GUKNh5YuLKTxawiu/NQTgXu1w2gPUcnainepOgcMHuqyyx+cZ8FKepiPtpbbhK
	 icmmbOnmaLt/wn4MJ8xTJwFx6glQ4bIJuTP9e4WAQM7RidanYk844coG19piTYMRsT
	 jGqk3burUVU9U2aMbS0jwda/0uybFtxMr1/nwkx2XMdnzOw+Sv8gXolDmkzjtlwdM/
	 FGRvxZ1BVDbD6aSS/hsi8dtU/IkJTkQQbMMX+ZGxa6HszlMo4CFYeV6o0oDdfPW4rh
	 fuPd2inNUykaJzyEpBe85qpKgqyAMjLeSXgymAxGcc4K8mcoU1X5JTwuDHRaws/tGC
	 u+8mu7wvl2kDg==
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
Subject: [PATCH v7 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Date: Mon, 17 Nov 2025 12:12:24 -0800
Message-Id: <20251117201231.2160039-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117201219.makes.617-kees@kernel.org>
References: <20251117201219.makes.617-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=47434; i=kees@kernel.org; h=from:subject; bh=S+EGvqn3SgMTgVmwq7y6XecKcPh5kT213kYegf+v5BE=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnSjaszd3XlmVW0n2Xlk3i35wn3a6MEmSotoStzQrZfs 9KQtlXvKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMgsF0aGn2ufW743jPp3ie34 AbmnT2Oy4rmjEx127oq4vPCYoXnjZob/dSkeC1dxSzRI/V/dN2WOWcLZowGz48/y9bH9vaHRE+b BAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To support the KCFI typeid and future type-based allocators, which need
to convert unique types into unique 32-bit values, add a mangling system
based on the Itanium C++ mangling ABI, adapted for C types. Introduce
__builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name for
testing and debugging (to see the human-readable mangling form). Add
tests for typeinfo validation and error handling.

This ABI needs to match what is used by LLVM Rust (which matches the Clang
ABI) so that KCFI can work on mixed GCC with LLVM-Rust kernel builds.
Instead of inventing a new ABI, all use the existing Itanium C++ mangling
which matches KCFI's needs.

An important aspect of the C++ typeinfo behavior that is retained here
is that typedefs are treated as pass-through except when the underlying
type lacks a tag (i.e. anonymous struct, union, or enum). This provides a
distinction between those typedefs and typedefs used to provide _aliases_
(u8, uint16_t).

In the future, an additional "strict mode" builtin helper pair could
also be added to follow strict ISO C type equivalency instead of the
existing typeinfo used here, but that is out of scope for this patch.

gcc/ChangeLog:

	* Makefile.in: Add kcfi-typeinfo.o.
	* doc/extend.texi: Document typeinfo builtins.
	* kcfi-typeinfo.h: New file, typeinfo mangling API.
	* kcfi-typeinfo.cc: New file, implement typeinfo mangling.

gcc/c-family/ChangeLog:

	* c-common.h (enum rid): Add typeinfo builtins.
	* c-common.cc: Add typeinfo builtins.

gcc/c/ChangeLog:

	* c-parser.cc (c_parser_get_builtin_type_arg): New function,
	parse type.
	(c_parser_postfix_expression): Add typeinfo builtins.

gcc/testsuite/ChangeLog:

	* gcc.dg/builtin-typeinfo-errors.c: New test, validate bad
	arguments are rejected.
	* gcc.dg/builtin-typeinfo.c: New test, typeinfo mangling.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/doc/extend.texi                           |  94 ++++
 .../gcc.dg/builtin-typeinfo-errors.c          |  28 +
 gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 350 +++++++++++++
 gcc/Makefile.in                               |   1 +
 gcc/c-family/c-common.h                       |   1 +
 gcc/kcfi-typeinfo.h                           |  32 ++
 gcc/c-family/c-common.cc                      |   2 +
 gcc/c/c-parser.cc                             |  72 +++
 gcc/kcfi-typeinfo.cc                          | 485 ++++++++++++++++++
 9 files changed, 1065 insertions(+)
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
 create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
 create mode 100644 gcc/kcfi-typeinfo.h
 create mode 100644 gcc/kcfi-typeinfo.cc

diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
index cd2d3475df31..f2556e062922 100644
--- a/gcc/doc/extend.texi
+++ b/gcc/doc/extend.texi
@@ -17895,6 +17895,100 @@ which will cause a @code{NULL} pointer to be used for the unsafe case.
 
 @enddefbuiltin
 
+@defbuiltin{{unsigned int} __builtin_typeinfo_hash (@var{type})}
+
+The built-in function @code{__builtin_typeinfo_hash} returns a hash value
+for the given type @var{type} (which is a type, not an expression).  The hash
+is computed using the FNV-1a algorithm on the type's mangled name representation,
+which follows a subset of the Itanium C++ ABI conventions adapted for C types.
+(See @code{__buitin_typeinfo_name} for the string representation.)
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
+unsigned int hash1 = __builtin_typeinfo_hash(mytype_t);
+unsigned int hash2 = __builtin_typeinfo_hash(struct @{ int x; @});
+/* hash1 != hash2 because the typedef name is preserved */
+
+void func(int x, char y);
+unsigned int hash3 = __builtin_typeinfo_hash(typeof(func));
+/* Returns hash for function type "void(int, char)" */
+@end smallexample
+
+@emph{Note:} This construct is only available for C@. For C++, see
+@code{std::type_info::hash_code}.
+
+@enddefbuiltin
+
+@defbuiltin{{const char *} __builtin_typeinfo_name (@var{type})}
+
+The built-in function @code{__builtin_typeinfo_name} returns a string
+containing the mangled name representation of the given type @var{type}
+(which is a type, not an expression).  The string follows a subset of the
+Itanium C++ ABI mangling conventions adapted for C types.  (See
+@code{__buitin_typeinfo_hash} for the unsigned 32-bit hash representation.)
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
+const char *name_a = __builtin_typeinfo_name(type_a);  /* "_ZTS6type_a" */
+const char *name_b = __builtin_typeinfo_name(type_b);  /* "_ZTS6type_b" */
+/* name_a and name_b are different despite identical structure */
+@end smallexample
+
+@emph{Note:} This construct is only available for C@. For C++, see
+@code{std::type_info::name}.
+
+@enddefbuiltin
+
 @defbuiltin{int __builtin_types_compatible_p (@var{type1}, @var{type2})}
 
 You can use the built-in function @code{__builtin_types_compatible_p} to
diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c b/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
new file mode 100644
index 000000000000..71ad01337b4e
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
@@ -0,0 +1,28 @@
+/* Test error handling for __builtin_typeinfo_name and __builtin_typeinfo_hash.  */
+/* { dg-do compile } */
+
+int main() {
+    /* Test missing arguments */
+    const char *result1 = __builtin_typeinfo_name(); /* { dg-error "expected specifier-qualifier-list before '\\)'" } */
+    /* { dg-error "expected type name in '__builtin_typeinfo_name'" "" { target *-*-* } .-1 } */
+    unsigned int result2 = __builtin_typeinfo_hash(); /* { dg-error "expected specifier-qualifier-list before '\\)'" } */
+    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" "" { target *-*-* } .-1 } */
+
+    /* Test wrong argument types (expressions instead of type names) */
+    const char *result3 = __builtin_typeinfo_name(42); /* { dg-error "expected specifier-qualifier-list before numeric constant" } */
+    /* { dg-error "expected type name in '__builtin_typeinfo_name'" "" { target *-*-* } .-1 } */
+    unsigned int result4 = __builtin_typeinfo_hash(42); /* { dg-error "expected specifier-qualifier-list before numeric constant" } */
+    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" "" { target *-*-* } .-1 } */
+
+    int x = 5;
+    const char *result5 = __builtin_typeinfo_name(x); /* { dg-error "expected specifier-qualifier-list before" } */
+    /* { dg-error "expected type name in '__builtin_typeinfo_name'" "" { target *-*-* } .-1 } */
+    unsigned int result6 = __builtin_typeinfo_hash(x); /* { dg-error "expected specifier-qualifier-list before" } */
+    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" "" { target *-*-* } .-1 } */
+
+    /* Test too many arguments */
+    const char *result7 = __builtin_typeinfo_name(int, int); /* { dg-error "expected '\\)' before ','" } */
+    unsigned int result8 = __builtin_typeinfo_hash(int, int); /* { dg-error "expected '\\)' before ','" } */
+
+    return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo.c b/gcc/testsuite/gcc.dg/builtin-typeinfo.c
new file mode 100644
index 000000000000..307657310fec
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/builtin-typeinfo.c
@@ -0,0 +1,350 @@
+/* Test KCFI type mangling using __builtin_typeinfo_name.  */
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
+    const char *actual_string = __builtin_typeinfo_name(typeof(expr)); \
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
index d05e15e2b6ce..890a60dfc6a2 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1600,6 +1600,7 @@ OBJS = \
 	ira-emit.o \
 	ira-lives.o \
 	jump.o \
+	kcfi-typeinfo.o \
 	langhooks.o \
 	late-combine.o \
 	lcm.o \
diff --git a/gcc/c-family/c-common.h b/gcc/c-family/c-common.h
index 8b7f4ae44717..8c3d3cef6128 100644
--- a/gcc/c-family/c-common.h
+++ b/gcc/c-family/c-common.h
@@ -112,6 +112,7 @@ enum rid
   RID_BUILTIN_SHUFFLEVECTOR,   RID_BUILTIN_CONVERTVECTOR,  RID_BUILTIN_TGMATH,
   RID_BUILTIN_HAS_ATTRIBUTE,   RID_BUILTIN_ASSOC_BARRIER,  RID_BUILTIN_STDC,
   RID_BUILTIN_COUNTED_BY_REF,
+  RID_BUILTIN_TYPEINFO_NAME,  RID_BUILTIN_TYPEINFO_HASH,
   RID_DFLOAT32, RID_DFLOAT64, RID_DFLOAT128, RID_DFLOAT64X,
 
   /* TS 18661-3 keywords, in the same sequence as the TI_* values.  */
diff --git a/gcc/kcfi-typeinfo.h b/gcc/kcfi-typeinfo.h
new file mode 100644
index 000000000000..805f9ebaeca4
--- /dev/null
+++ b/gcc/kcfi-typeinfo.h
@@ -0,0 +1,32 @@
+/* KCFI-compatible type mangling, based on Itanium C++ ABI.
+   Copyright (C) 2025 Free Software Foundation, Inc.
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
+#include <string>
+
+/* Get the typeinfo mangled name string for any C type.  */
+extern std::string typeinfo_get_name (tree type);
+
+/* Get the typeinfo hash for any C type.  */
+extern uint32_t typeinfo_get_hash (tree type);
+
+#endif /* GCC_KCFI_TYPEINFO_H */
diff --git a/gcc/c-family/c-common.cc b/gcc/c-family/c-common.cc
index 9b97a0fe6224..8cb1318525d5 100644
--- a/gcc/c-family/c-common.cc
+++ b/gcc/c-family/c-common.cc
@@ -462,6 +462,8 @@ const struct c_common_resword c_common_reswords[] =
   { "__builtin_stdc_trailing_zeros", RID_BUILTIN_STDC, D_CONLY },
   { "__builtin_tgmath", RID_BUILTIN_TGMATH, D_CONLY },
   { "__builtin_offsetof", RID_OFFSETOF, 0 },
+  { "__builtin_typeinfo_hash", RID_BUILTIN_TYPEINFO_HASH, D_CONLY },
+  { "__builtin_typeinfo_name", RID_BUILTIN_TYPEINFO_NAME, D_CONLY },
   { "__builtin_types_compatible_p", RID_TYPES_COMPATIBLE_P, D_CONLY },
   { "__builtin_c23_va_start", RID_C23_VA_START,	D_C23 | D_CXX26 },
   { "__builtin_va_arg",	RID_VA_ARG,	0 },
diff --git a/gcc/c/c-parser.cc b/gcc/c/c-parser.cc
index 360df52967b5..4adca5909c6c 100644
--- a/gcc/c/c-parser.cc
+++ b/gcc/c/c-parser.cc
@@ -77,6 +77,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "asan.h"
 #include "c-family/c-ubsan.h"
 #include "gcc-urlifier.h"
+#include "kcfi-typeinfo.h"
 
 /* We need to walk over decls with incomplete struct/union/enum types
    after parsing the whole translation unit.
@@ -11036,6 +11037,38 @@ c_parser_has_attribute_expression (c_parser *parser)
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
@@ -12064,6 +12097,45 @@ c_parser_postfix_expression (c_parser *parser)
 	    set_c_expr_source_range (&expr, loc, close_paren_loc);
 	  }
 	  break;
+	case RID_BUILTIN_TYPEINFO_NAME:
+	  {
+	    c_parser_consume_token (parser);
+	    location_t close_paren_loc;
+	    tree type;
+	    if (!c_parser_get_builtin_type_arg (parser,
+						"__builtin_typeinfo_name",
+						&type, &close_paren_loc))
+	      {
+		expr.set_error ();
+		break;
+	      }
+
+	    /* Call the typeinfo name function.  */
+	    std::string type_name = typeinfo_get_name (type);
+	    expr.value = build_string_literal (type_name.length () + 1,
+					       type_name.c_str ());
+	    set_c_expr_source_range (&expr, loc, close_paren_loc);
+	  }
+	  break;
+	case RID_BUILTIN_TYPEINFO_HASH:
+	  {
+	    c_parser_consume_token (parser);
+	    location_t close_paren_loc;
+	    tree type;
+	    if (!c_parser_get_builtin_type_arg (parser,
+						"__builtin_typeinfo_hash",
+						&type, &close_paren_loc))
+	      {
+		expr.set_error ();
+		break;
+	      }
+
+	    /* Call the typeinfo hash function.  */
+	    uint32_t type_hash = typeinfo_get_hash (type);
+	    expr.value = build_int_cst (unsigned_type_node, type_hash);
+	    set_c_expr_source_range (&expr, loc, close_paren_loc);
+	  }
+	  break;
 	case RID_BUILTIN_TGMATH:
 	  {
 	    vec<c_expr_t, va_gc> *cexpr_list;
diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
new file mode 100644
index 000000000000..c9819d1f45ec
--- /dev/null
+++ b/gcc/kcfi-typeinfo.cc
@@ -0,0 +1,485 @@
+/* KCFI-compatible type mangling, based on Itanium C++ ABI.
+   Copyright (C) 2025 Free Software Foundation, Inc.
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
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "tree.h"
+#include "diagnostic-core.h"
+#include "stringpool.h"
+#include "stor-layout.h"
+#include "print-tree.h"
+#include "kcfi-typeinfo.h"
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
+/* Forward declaration for recursive type mangling.  */
+
+static void mangle_type (tree type, std::string *out_str, uint32_t *hash_state);
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
+      if (type == float_type_node)
+	append_char ('f', out_str, hash_state);
+      else if (type == double_type_node)
+	append_char ('d', out_str, hash_state);
+      else if (type == long_double_type_node)
+	append_char ('e', out_str, hash_state);
+      else
+	{
+	  /* Fallback for other real types.  */
+	  append_char ('f', out_str, hash_state);
+	  append_string (std::to_string (TYPE_PRECISION (type)).c_str (),
+			 out_str, hash_state);
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
+	/* Fail for vectors with unknown size.  */
+      }
+      break;
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
+    case ARRAY_TYPE:
+      /* Array type: 'A' + size + '_' + element type (simplified).  */
+      append_char ('A', out_str, hash_state);
+      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
+	{
+	  tree max_val = TYPE_MAX_VALUE (TYPE_DOMAIN (type));
+	  /* Check if array size is compile-time constant to handle VLAs. */
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
+typeinfo_get_name (tree type)
+{
+  gcc_assert (type != NULL_TREE);
+  std::string result = "";
+
+  mangle_type (type, &result, nullptr);
+  return result;
+}
+
+/* Get the typeinfo hash for any C type.  TYPE is the type to hash.
+   Returns the FNV-1a hash of the mangled type string.  */
+
+uint32_t
+typeinfo_get_hash (tree type)
+{
+  gcc_assert (type != NULL_TREE);
+  uint32_t hash_state = 2166136261U; /* FNV-1a 32-bit offset basis.  */
+
+  mangle_type (type, nullptr, &hash_state);
+  return hash_state;
+}
-- 
2.34.1

