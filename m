Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C512EA48F
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180720; cv=none; b=BgWfIEEQS5YuUm9dyoiKC+8QDYB06yZYUD3PRZ6oPhIdC3EsiWW+C1g81oAGus3OKym73fnBh+50uFTlWTVoYZjZED7ylAcMgBGNUDe847uZ/++H98dssUnw3j9GDjlJzZKkIZAm6VY/GjL4DXbvycssG8GdpeS7PHL/qvdCuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180720; c=relaxed/simple;
	bh=jwJZdpA0sddwsTL2E+BmvjRhHdQHmEs3LfFxD4i4XDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mL/pxZ6NhOkJ+u9yk/Fyi5p2jizbofxU3UFORdeNVhBQyecWLialn8XEY0OqDUXWy3TQK8pAamO1LML+a53XTYyJVUX6TkY+YUlvHmu02+aC9dxYBI35llr79ug324OLIoYlDFTf3fU6qJjxrL8OVvLXXRxyAL4tLdDIgSjQ+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=T1BeUzYU; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="T1BeUzYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1758180058;
	bh=x8o8HUkorA7tgH/mwn5wAA82D5Q8teDhsGnAP7uOKtY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T1BeUzYUmNGEWwNNAW/aetgQcSCYpf9h54T/jPL7fkAXLqhMv+U7YCpq8HzPP4Y+K
	 8C9kYjv80cSWTJGH78kEWE3bywyUAj8O4lIAbFoMmRFq+YhGO1+wAWXX2zkLAxdaAA
	 IcrV/yKeiQ1tpphs2VVWCFlD6oRi0ocYRqMXmcKk=
Received: from vra-172-150.tugraz.at (vra-172-150.tugraz.at [129.27.172.150])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4cS6Vs3ws9z2xLl;
	Thu, 18 Sep 2025 09:20:53 +0200 (CEST)
Message-ID: <8d93c033c8060e79d2f0374a97827172f79ebdf8.camel@tugraz.at>
Subject: Re: [PATCH v3 1/7] typeinfo: Introduce KCFI typeinfo mangling API
From: Martin Uecker <uecker@tugraz.at>
To: Qing Zhao <qing.zhao@oracle.com>, Kees Cook <kees@kernel.org>
Cc: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>, 
 Richard Biener <rguenther@suse.de>, Joseph Myers <josmyers@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,  Jan Hubicka <hubicka@ucw.cz>,
 Richard Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford	
 <richard.sandiford@arm.com>, Marcus Shawcroft <marcus.shawcroft@arm.com>, 
 Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng <kito.cheng@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,  Andrew Waterman <andrew@sifive.com>,
 Jim Wilson <jim.wilson.gcc@gmail.com>, Dan Li <ashimida.1990@gmail.com>, 
 Sami Tolvanen <samitolvanen@google.com>, Ramon de C Valle
 <rcvalle@google.com>, Joao Moreira	 <joao@overdrivepizza.com>, Nathan
 Chancellor <nathan@kernel.org>, Bill Wendling	 <morbo@google.com>,
 "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>, 
 "linux-hardening@vger.kernel.org"	 <linux-hardening@vger.kernel.org>
Date: Thu, 18 Sep 2025 09:20:52 +0200
In-Reply-To: <D6E2A1BD-5D42-4492-B190-A2B845D8B0EE@oracle.com>
References: <20250913231256.make.519-kees@kernel.org>
	 <20250913232404.2690431-1-kees@kernel.org>
	 <D6E2A1BD-5D42-4492-B190-A2B845D8B0EE@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116

Am Mittwoch, dem 17.09.2025 um 17:56 +0000 schrieb Qing Zhao:
> Hi,=20
>=20
> > On Sep 13, 2025, at 19:23, Kees Cook <kees@kernel.org> wrote:
> >=20
> > To support the KCFI typeid and future type-based allocators,
>=20
> Could you please explain a little bit more on the =E2=80=9Cfuture type-ba=
sed allocators=E2=80=9D?

People work on allocators where different types go into different
storage regions.  This prevents type-confusion errors, especially
where data could be misinterpreted as a pointer.

>=20
> And why these two new builtins are necessary for this purpose?
>=20
> > which need
> > to convert unique types into unique 32-bit values, add a mangling syste=
m
> > based on the Itanium C++ mangling ABI, adapted for for C types.
>=20
> There is a redundant =E2=80=9Cfor=E2=80=9D in the above last sentence.=
=20
>=20
> > Introduce
> > __builtin_typeinfo_hash for the hash, and __builtin_typeinfo_name for
> > testing and debugging (to see the human-readable mangling form).
>=20
> In addition to the testing and debugging purpose, are  there any use case=
s for
> these two new compiler provided builtins?=20

Kees may have other applications in mind, but it would be useful for all
user or library code that may do some kind of run-time type checking.
It might also be useful for serialization.

What I find problematic though is that this is not based on GNU / ISO C
rules but on stricter Linux kernel rules.   I think such builtin should
have two versions. =20

So maybe

__builtin_typeinfo_hash_strict // strict
__builtin_typeinfo_hash_canonical // standard

or similar, or maybe instead have a flag argument so that we can
other options which may turn out to be important in the future
(such as ignoring=C2=A0 qualifiers or supporting newer languag features).

 =20
Martin




>=20
> thanks.
>=20
> Qing
>=20
> > Add
> > tests for typeinfo validation and error handling.
> >=20
> > gcc/ChangeLog:
> >=20
> > * Makefile.in: Add kcfi-typeinfo.o.
> > * doc/extend.texi: Document typeinfo builtins.
> > * kcfi-typeinfo.h: New file, typeinfo mangling API.
> > * kcfi-typeinfo.cc: New file, implement typeinfo mangling.
> >=20
> > gcc/c-family/ChangeLog:
> >=20
> > * c-common.h (enum rid): Add typeinfo builtins.
> > * c-common.cc: Add typeinfo builtins.
> >=20
> > gcc/c/ChangeLog:
> >=20
> > * c-parser.cc (c_parser_get_builtin_type_arg): New function,
> > parse type.
> > (c_parser_postfix_expression): Add typeinfo builtins.
> >=20
> > gcc/testsuite/ChangeLog:
> >=20
> > * gcc.dg/builtin-typeinfo-errors.c: New test, validate bad
> > arguments are rejected.
> > * gcc.dg/builtin-typeinfo.c: New test, typeinfo mangling.
> >=20
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > gcc/Makefile.in                               |   1 +
> > gcc/c-family/c-common.h                       |   1 +
> > gcc/kcfi-typeinfo.h                           |  32 ++
> > .../gcc.dg/builtin-typeinfo-errors.c          |  28 ++
> > gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 350 +++++++++++++
> > gcc/c-family/c-common.cc                      |   2 +
> > gcc/c/c-parser.cc                             |  72 +++
> > gcc/doc/extend.texi                           |  94 ++++
> > gcc/kcfi-typeinfo.cc                          | 475 ++++++++++++++++++
> > 9 files changed, 1055 insertions(+)
> > create mode 100644 gcc/kcfi-typeinfo.h
> > create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
> > create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
> > create mode 100644 gcc/kcfi-typeinfo.cc
> >=20
> > diff --git a/gcc/Makefile.in b/gcc/Makefile.in
> > index d2744db843d7..a14fb498ce44 100644
> > --- a/gcc/Makefile.in
> > +++ b/gcc/Makefile.in
> > @@ -1591,6 +1591,7 @@ OBJS =3D \
> > ira-emit.o \
> > ira-lives.o \
> > jump.o \
> > + kcfi-typeinfo.o \
> > langhooks.o \
> > late-combine.o \
> > lcm.o \
> > diff --git a/gcc/c-family/c-common.h b/gcc/c-family/c-common.h
> > index b6021d241731..e0100837946e 100644
> > --- a/gcc/c-family/c-common.h
> > +++ b/gcc/c-family/c-common.h
> > @@ -112,6 +112,7 @@ enum rid
> >   RID_BUILTIN_SHUFFLEVECTOR,   RID_BUILTIN_CONVERTVECTOR,  RID_BUILTIN_=
TGMATH,
> >   RID_BUILTIN_HAS_ATTRIBUTE,   RID_BUILTIN_ASSOC_BARRIER,  RID_BUILTIN_=
STDC,
> >   RID_BUILTIN_COUNTED_BY_REF,
> > +  RID_BUILTIN_TYPEINFO_NAME,  RID_BUILTIN_TYPEINFO_HASH,
> >   RID_DFLOAT32, RID_DFLOAT64, RID_DFLOAT128, RID_DFLOAT64X,
> >=20
> >   /* TS 18661-3 keywords, in the same sequence as the TI_* values.  */
> > diff --git a/gcc/kcfi-typeinfo.h b/gcc/kcfi-typeinfo.h
> > new file mode 100644
> > index 000000000000..805f9ebaeca4
> > --- /dev/null
> > +++ b/gcc/kcfi-typeinfo.h
> > @@ -0,0 +1,32 @@
> > +/* KCFI-compatible type mangling, based on Itanium C++ ABI.
> > +   Copyright (C) 2025 Free Software Foundation, Inc.
> > +
> > +This file is part of GCC.
> > +
> > +GCC is free software; you can redistribute it and/or modify it under
> > +the terms of the GNU General Public License as published by the Free
> > +Software Foundation; either version 3, or (at your option) any later
> > +version.
> > +
> > +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> > +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> > +for more details.
> > +
> > +You should have received a copy of the GNU General Public License
> > +along with GCC; see the file COPYING3.  If not see
> > +<http://www.gnu.org/licenses/>.  */
> > +
> > +#ifndef GCC_KCFI_TYPEINFO_H
> > +#define GCC_KCFI_TYPEINFO_H
> > +
> > +#include "tree.h"
> > +#include <string>
> > +
> > +/* Get the typeinfo mangled name string for any C type.  */
> > +extern std::string typeinfo_get_name (tree type);
> > +
> > +/* Get the typeinfo hash for any C type.  */
> > +extern uint32_t typeinfo_get_hash (tree type);
> > +
> > +#endif /* GCC_KCFI_TYPEINFO_H */
> > diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c b/gcc/tests=
uite/gcc.dg/builtin-typeinfo-errors.c
> > new file mode 100644
> > index 000000000000..71ad01337b4e
> > --- /dev/null
> > +++ b/gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
> > @@ -0,0 +1,28 @@
> > +/* Test error handling for __builtin_typeinfo_name and __builtin_typei=
nfo_hash.  */
> > +/* { dg-do compile } */
> > +
> > +int main() {
> > +    /* Test missing arguments */
> > +    const char *result1 =3D __builtin_typeinfo_name(); /* { dg-error "=
expected specifier-qualifier-list before '\\)'" } */
> > +    /* { dg-error "expected type name in '__builtin_typeinfo_name'" ""=
 { target *-*-* } .-1 } */
> > +    unsigned int result2 =3D __builtin_typeinfo_hash(); /* { dg-error =
"expected specifier-qualifier-list before '\\)'" } */
> > +    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" ""=
 { target *-*-* } .-1 } */
> > +
> > +    /* Test wrong argument types (expressions instead of type names) *=
/
> > +    const char *result3 =3D __builtin_typeinfo_name(42); /* { dg-error=
 "expected specifier-qualifier-list before numeric constant" } */
> > +    /* { dg-error "expected type name in '__builtin_typeinfo_name'" ""=
 { target *-*-* } .-1 } */
> > +    unsigned int result4 =3D __builtin_typeinfo_hash(42); /* { dg-erro=
r "expected specifier-qualifier-list before numeric constant" } */
> > +    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" ""=
 { target *-*-* } .-1 } */
> > +
> > +    int x =3D 5;
> > +    const char *result5 =3D __builtin_typeinfo_name(x); /* { dg-error =
"expected specifier-qualifier-list before" } */
> > +    /* { dg-error "expected type name in '__builtin_typeinfo_name'" ""=
 { target *-*-* } .-1 } */
> > +    unsigned int result6 =3D __builtin_typeinfo_hash(x); /* { dg-error=
 "expected specifier-qualifier-list before" } */
> > +    /* { dg-error "expected type name in '__builtin_typeinfo_hash'" ""=
 { target *-*-* } .-1 } */
> > +
> > +    /* Test too many arguments */
> > +    const char *result7 =3D __builtin_typeinfo_name(int, int); /* { dg=
-error "expected '\\)' before ','" } */
> > +    unsigned int result8 =3D __builtin_typeinfo_hash(int, int); /* { d=
g-error "expected '\\)' before ','" } */
> > +
> > +    return 0;
> > +}
> > diff --git a/gcc/testsuite/gcc.dg/builtin-typeinfo.c b/gcc/testsuite/gc=
c.dg/builtin-typeinfo.c
> > new file mode 100644
> > index 000000000000..744dc50f407e
> > --- /dev/null
> > +++ b/gcc/testsuite/gcc.dg/builtin-typeinfo.c
> > @@ -0,0 +1,350 @@
> > +/* Test KCFI type mangling using __builtin_typeinfo_name.  */
> > +/* { dg-do run } */
> > +/* { dg-options "-std=3Dgnu99" } */
> > +
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <stdarg.h>
> > +
> > +int pass, fail;
> > +
> > +#define TEST_STRING(expr, expected_string) \
> > +  do { \
> > +    const char *actual_string =3D __builtin_typeinfo_name(typeof(expr)=
); \
> > +    printf("Testing %s: ", #expr); \
> > +    if (strcmp(actual_string, expected_string) =3D=3D 0) { \
> > +      printf("PASS (%s)\n", actual_string); \
> > +      pass ++; \
> > +    } else { \
> > +      printf("FAIL\n"); \
> > +      printf("  Expected: %s\n", expected_string); \
> > +      printf("  Actual:   %s\n", actual_string); \
> > +      fail ++; \
> > +    } \
> > +  } while (0)
> > +
> > +int main(void)
> > +{
> > +    printf("Testing KCFI Typeinfo Mangling\n");
> > +    printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> > +
> > +    /* Test basic types */
> > +    TEST_STRING(void, "_ZTSv");
> > +    TEST_STRING(char, "_ZTSc");
> > +    TEST_STRING(int, "_ZTSi");
> > +    TEST_STRING(short, "_ZTSs");
> > +    TEST_STRING(long, "_ZTSl");
> > +    TEST_STRING(float, "_ZTSf");
> > +    TEST_STRING(double, "_ZTSd");
> > +
> > +    /* Test qualified types */
> > +    TEST_STRING(const int, "_ZTSKi");
> > +    TEST_STRING(volatile int, "_ZTSVi");
> > +
> > +    /* Test pointer types */
> > +    TEST_STRING(char*, "_ZTSPc");
> > +    TEST_STRING(int*, "_ZTSPi");
> > +    TEST_STRING(void*, "_ZTSPv");
> > +    TEST_STRING(const char*, "_ZTSPKc");
> > +
> > +    /* Test array types */
> > +    TEST_STRING(int[10],  "_ZTSA10_i");
> > +    TEST_STRING(char[20], "_ZTSA20_c");
> > +    TEST_STRING(short[],  "_ZTSA_s");
> > +
> > +    /* Test basic function types */
> > +    extern void func_void(void);
> > +    extern void func_char(char x);
> > +    extern void func_short(short x);
> > +    extern void func_int(int x);
> > +    extern void func_long(long x);
> > +    TEST_STRING(func_void,  "_ZTSFvvE");
> > +    TEST_STRING(func_char,  "_ZTSFvcE");
> > +    TEST_STRING(func_short, "_ZTSFvsE");
> > +    TEST_STRING(func_int,   "_ZTSFviE");
> > +    TEST_STRING(func_long,  "_ZTSFvlE");
> > +
> > +    /* Test functions with unsigned types */
> > +    extern void func_unsigned_char(unsigned char x);
> > +    extern void func_unsigned_short(unsigned short x);
> > +    extern void func_unsigned_int(unsigned int x);
> > +    TEST_STRING(func_unsigned_char,  "_ZTSFvhE");
> > +    TEST_STRING(func_unsigned_short, "_ZTSFvtE");
> > +    TEST_STRING(func_unsigned_int,   "_ZTSFvjE");
> > +
> > +    /* Test functions with signed types */
> > +    extern void func_signed_char(signed char x);
> > +    extern void func_signed_short(signed short x);
> > +    extern void func_signed_int(signed int x);
> > +    TEST_STRING(func_signed_char,  "_ZTSFvaE");
> > +    TEST_STRING(func_signed_short, "_ZTSFvsE");
> > +    TEST_STRING(func_signed_int,   "_ZTSFviE");
> > +
> > +    /* Test functions with pointer types */
> > +    extern void func_void_ptr(void *x);
> > +    extern void func_char_ptr(char *x);
> > +    extern void func_short_ptr(short *x);
> > +    extern void func_int_ptr(int *x);
> > +    extern void func_int_array(int arr[]); /* Decays to "int *".  */
> > +    extern void func_long_ptr(long *x);
> > +    TEST_STRING(func_void_ptr,  "_ZTSFvPvE");
> > +    TEST_STRING(func_char_ptr,  "_ZTSFvPcE");
> > +    TEST_STRING(func_short_ptr, "_ZTSFvPsE");
> > +    TEST_STRING(func_int_ptr,   "_ZTSFvPiE");
> > +    TEST_STRING(func_int_array, "_ZTSFvPiE");
> > +    TEST_STRING(func_long_ptr,  "_ZTSFvPlE");
> > +
> > +    /* Test functions with const qualifiers */
> > +    extern void func_const_void_ptr(const void *x);
> > +    extern void func_const_char_ptr(const char *x);
> > +    extern void func_const_short_ptr(const short *x);
> > +    extern void func_const_int_ptr(const int *x);
> > +    extern void func_const_long_ptr(const long *x);
> > +    TEST_STRING(func_const_void_ptr,  "_ZTSFvPKvE");
> > +    TEST_STRING(func_const_char_ptr,  "_ZTSFvPKcE");
> > +    TEST_STRING(func_const_short_ptr, "_ZTSFvPKsE");
> > +    TEST_STRING(func_const_int_ptr,   "_ZTSFvPKiE");
> > +    TEST_STRING(func_const_long_ptr,  "_ZTSFvPKlE");
> > +
> > +    /* Test nested pointers */
> > +    extern void func_int_ptr_ptr(int **x);
> > +    extern void func_char_ptr_ptr(char **x);
> > +    TEST_STRING(func_int_ptr_ptr,  "_ZTSFvPPiE");
> > +    TEST_STRING(func_char_ptr_ptr, "_ZTSFvPPcE");
> > +
> > +    /* Test multiple parameters */
> > +    extern void func_int_char(int x, char y);
> > +    extern void func_char_int(char x, int y);
> > +    extern void func_two_int(int x, int y);
> > +    TEST_STRING(func_int_char, "_ZTSFvicE");
> > +    TEST_STRING(func_char_int, "_ZTSFvciE");
> > +    TEST_STRING(func_two_int,  "_ZTSFviiE");
> > +
> > +    /* Test return types */
> > +    extern int func_return_int(void);
> > +    extern char func_return_char(void);
> > +    extern void* func_return_ptr(void);
> > +    TEST_STRING(func_return_int,  "_ZTSFivE");
> > +    TEST_STRING(func_return_char, "_ZTSFcvE");
> > +    TEST_STRING(func_return_ptr,  "_ZTSFPvvE");
> > +
> > +    /* Test function pointer parameters */
> > +    extern void func_fptr_void(void (*fp)(void));
> > +    extern void func_fptr_int(void (*fp)(int));
> > +    extern void func_fptr_ret_int(int (*fp)(void));
> > +    TEST_STRING(func_fptr_void,    "_ZTSFvPFvvEE");
> > +    TEST_STRING(func_fptr_int,     "_ZTSFvPFviEE");
> > +    TEST_STRING(func_fptr_ret_int, "_ZTSFvPFivEE");
> > +
> > +    /* Test variadic functions */
> > +    struct audit_context { int dummy; };
> > +    extern void func_variadic_simple(const char *fmt, ...);
> > +    extern void func_variadic_mixed(int x, const char *fmt, ...);
> > +    extern void func_variadic_multi(int x, char y, const char *fmt, ..=
.);
> > +    extern void audit_log_pattern(struct audit_context *ctx, unsigned =
int gfp_mask,
> > +  int type, const char *fmt, ...);
> > +    TEST_STRING(func_variadic_simple, "_ZTSFvPKczE");
> > +    TEST_STRING(func_variadic_mixed,  "_ZTSFviPKczE");
> > +    TEST_STRING(func_variadic_multi,  "_ZTSFvicPKczE");
> > +    TEST_STRING(audit_log_pattern,    "_ZTSFvP13audit_contextjiPKczE")=
;
> > +
> > +    /* Test mixed const/non-const */
> > +    extern void func_const_mixed(int x, const char *fmt);
> > +    TEST_STRING(func_const_mixed,  "_ZTSFviPKcE");
> > +
> > +    /* Test named struct types */
> > +    struct test_struct_a { int x; };
> > +    struct test_struct_b { char y; };
> > +    struct test_struct_c { void *ptr; };
> > +    TEST_STRING(struct test_struct_a, "_ZTS13test_struct_a");
> > +    extern void func_struct_a_ptr(struct test_struct_a *x);
> > +    extern void func_struct_b_ptr(struct test_struct_b *x);
> > +    extern void func_struct_c_ptr(struct test_struct_c *x);
> > +    TEST_STRING(func_struct_a_ptr, "_ZTSFvP13test_struct_aE");
> > +    TEST_STRING(func_struct_b_ptr, "_ZTSFvP13test_struct_bE");
> > +    TEST_STRING(func_struct_c_ptr, "_ZTSFvP13test_struct_cE");
> > +
> > +    /* Test const named struct types */
> > +    extern void func_const_struct_a_ptr(const struct test_struct_a *x)=
;
> > +    extern void func_const_struct_b_ptr(const struct test_struct_b *x)=
;
> > +    extern void func_const_struct_c_ptr(const struct test_struct_c *x)=
;
> > +    TEST_STRING(func_const_struct_a_ptr, "_ZTSFvPK13test_struct_aE");
> > +    TEST_STRING(func_const_struct_b_ptr, "_ZTSFvPK13test_struct_bE");
> > +    TEST_STRING(func_const_struct_c_ptr, "_ZTSFvPK13test_struct_cE");
> > +
> > +    /* Test named union types */
> > +    union test_union_a { int x; float y; };
> > +    union test_union_b { char a; void *b; };
> > +    TEST_STRING(union test_union_a,  "_ZTS12test_union_a");
> > +    extern void func_union_a_ptr(union test_union_a *x);
> > +    extern void func_union_b_ptr(union test_union_b *x);
> > +    TEST_STRING(func_union_a_ptr, "_ZTSFvP12test_union_aE");
> > +    TEST_STRING(func_union_b_ptr, "_ZTSFvP12test_union_bE");
> > +
> > +    /* Test enum types: distinct from int */
> > +    enum test_enum_a { ENUM_A_VAL };
> > +    enum test_enum_b { ENUM_B_VAL };
> > +    TEST_STRING(enum test_enum_a, "_ZTS11test_enum_a");
> > +    extern void func_enum_a_ptr(enum test_enum_a *x);
> > +    extern void func_enum_b_ptr(enum test_enum_b *x);
> > +    TEST_STRING(func_enum_a_ptr, "_ZTSFvP11test_enum_aE");
> > +    TEST_STRING(func_enum_b_ptr, "_ZTSFvP11test_enum_bE");
> > +
> > +    /* Test union member discrimination */
> > +    struct tasklet {
> > +        int state;
> > +        union {
> > +            void (*func)(unsigned long data);
> > +            void (*callback)(struct tasklet *t);
> > +        };
> > +        unsigned long data;
> > +    } tasklet_instance;
> > +    TEST_STRING(tasklet_instance, "_ZTS7tasklet");
> > +    struct tasklet *p =3D &tasklet_instance;
> > +    extern void tasklet_callback_function(struct tasklet *t);
> > +    extern void tasklet_func_function(unsigned long data);
> > +    TEST_STRING(tasklet_func_function,     "_ZTSFvmE");
> > +    TEST_STRING(*p->func,                  "_ZTSFvmE");
> > +    TEST_STRING(tasklet_callback_function, "_ZTSFvP7taskletE");
> > +    TEST_STRING(*p->callback,              "_ZTSFvP7taskletE");
> > +
> > +    /* Test struct return pointers */
> > +    extern struct test_struct_a* func_ret_struct_a_ptr(void);
> > +    extern struct test_struct_b* func_ret_struct_b_ptr(void);
> > +    extern struct test_struct_c* func_ret_struct_c_ptr(void);
> > +    TEST_STRING(func_ret_struct_a_ptr, "_ZTSFP13test_struct_avE");
> > +    TEST_STRING(func_ret_struct_b_ptr, "_ZTSFP13test_struct_bvE");
> > +    TEST_STRING(func_ret_struct_c_ptr, "_ZTSFP13test_struct_cvE");
> > +
> > +    /* Test struct by-value parameters */
> > +    extern void func_struct_a_val(struct test_struct_a x);
> > +    extern void func_struct_b_val(struct test_struct_b x);
> > +    extern void func_struct_c_val(struct test_struct_c x);
> > +    TEST_STRING(func_struct_a_val, "_ZTSFv13test_struct_aE");
> > +    TEST_STRING(func_struct_b_val, "_ZTSFv13test_struct_bE");
> > +    TEST_STRING(func_struct_c_val, "_ZTSFv13test_struct_cE");
> > +
> > +    /* Test struct return by-value */
> > +    extern struct test_struct_a func_ret_struct_a_val(void);
> > +    extern struct test_struct_b func_ret_struct_b_val(void);
> > +    extern struct test_struct_c func_ret_struct_c_val(void);
> > +    TEST_STRING(func_ret_struct_a_val, "_ZTSF13test_struct_avE");
> > +    TEST_STRING(func_ret_struct_b_val, "_ZTSF13test_struct_bvE");
> > +    TEST_STRING(func_ret_struct_c_val, "_ZTSF13test_struct_cvE");
> > +
> > +    /* Test mixed struct parameters */
> > +    extern void func_struct_a_b(struct test_struct_a *a, struct test_s=
truct_b *b);
> > +    extern void func_struct_b_a(struct test_struct_b *b, struct test_s=
truct_a *a);
> > +    TEST_STRING(func_struct_a_b, "_ZTSFvP13test_struct_aP13test_struct=
_bE");
> > +    TEST_STRING(func_struct_b_a, "_ZTSFvP13test_struct_bP13test_struct=
_aE");
> > +
> > +    /* Test anonymous struct typedefs */
> > +    typedef struct { int x; } typedef_struct_x;
> > +    typedef struct { int y; } typedef_struct_y;
> > +    TEST_STRING(typedef_struct_x, "_ZTS16typedef_struct_x");
> > +    extern void func_typedef_x_ptr(typedef_struct_x *x);
> > +    extern void func_typedef_y_ptr(typedef_struct_y *y);
> > +    TEST_STRING(func_typedef_x_ptr, "_ZTSFvP16typedef_struct_xE");
> > +    TEST_STRING(func_typedef_y_ptr, "_ZTSFvP16typedef_struct_yE");
> > +    extern void func_typedef_x(typedef_struct_x x);
> > +    TEST_STRING(func_typedef_x, "_ZTSFv16typedef_struct_xE");
> > +
> > +    /* Test anonymous union typedefs */
> > +    typedef union { int x; short a; } typedef_union_x;
> > +    typedef union { int y; short b; } typedef_union_y;
> > +    TEST_STRING(typedef_union_x, "_ZTS15typedef_union_x");
> > +    extern void func_typedef_union_x_ptr(typedef_union_x *x);
> > +    extern void func_typedef_union_y_ptr(typedef_union_y *y);
> > +    TEST_STRING(func_typedef_union_x_ptr, "_ZTSFvP15typedef_union_xE")=
;
> > +    TEST_STRING(func_typedef_union_y_ptr, "_ZTSFvP15typedef_union_yE")=
;
> > +    extern void func_typedef_union_x(typedef_union_x x);
> > +    TEST_STRING(func_typedef_union_x, "_ZTSFv15typedef_union_xE");
> > +
> > +    /* Test anonymous enum typedefs */
> > +    typedef enum { STEP_1, STEP_2 } typedef_enum_x;
> > +    typedef enum { STEP_A, STEP_B } typedef_enum_y;
> > +    TEST_STRING(typedef_enum_x, "_ZTS14typedef_enum_x");
> > +    extern void func_typedef_enum_x_ptr(typedef_enum_x *x);
> > +    extern void func_typedef_enum_y_ptr(typedef_enum_y *y);
> > +    TEST_STRING(func_typedef_enum_x_ptr, "_ZTSFvP14typedef_enum_xE");
> > +    TEST_STRING(func_typedef_enum_y_ptr, "_ZTSFvP14typedef_enum_yE");
> > +    extern void func_typedef_enum_x(typedef_enum_x x);
> > +    TEST_STRING(func_typedef_enum_x, "_ZTSFv14typedef_enum_xE");
> > +
> > +    /* Test basic typedef vs open-coded function types: should be the =
same.  */
> > +    typedef void (*func_type_typedef)(int, char);
> > +    TEST_STRING(func_type_typedef,           "_ZTSPFvicE");
> > +    extern void func_with_typedef_param(func_type_typedef fp);
> > +    extern void func_with_opencoded_param(void (*fp)(int, char));
> > +    TEST_STRING(func_with_typedef_param,   "_ZTSFvPFvicEE");
> > +    TEST_STRING(func_with_opencoded_param, "_ZTSFvPFvicEE");
> > +
> > +    /* Test return function pointer types */
> > +    typedef int (*ret_func_type_typedef)(void);
> > +    TEST_STRING(ret_func_type_typedef,     "_ZTSPFivE");
> > +    extern ret_func_type_typedef func_ret_typedef_param(void);
> > +    extern int (*func_ret_opencoded_param(void))(void);
> > +    TEST_STRING(func_ret_typedef_param,   "_ZTSFPFivEvE");
> > +    TEST_STRING(func_ret_opencoded_param, "_ZTSFPFivEvE");
> > +
> > +    /* Test additional type combos */
> > +    extern void func_float(float x);
> > +    extern void func_double_ptr(double *x);
> > +    extern void func_float_ptr(float *x);
> > +    extern void func_void_ptr_ptr(void **x);
> > +    extern void func_ptr_val(int *x, int y);
> > +    extern void func_val_ptr(int x, int *y);
> > +    extern float func_return_float(void);
> > +    extern double func_return_double(void);
> > +    TEST_STRING(func_float,         "_ZTSFvfE");
> > +    TEST_STRING(func_double_ptr,    "_ZTSFvPdE");
> > +    TEST_STRING(func_float_ptr,     "_ZTSFvPfE");
> > +    TEST_STRING(func_void_ptr_ptr,  "_ZTSFvPPvE");
> > +    TEST_STRING(func_ptr_val,       "_ZTSFvPiiE");
> > +    TEST_STRING(func_val_ptr,       "_ZTSFviPiE");
> > +    TEST_STRING(func_return_float,  "_ZTSFfvE");
> > +    TEST_STRING(func_return_double, "_ZTSFdvE");
> > +
> > +    /* Test VLA types: should be all the same.  */
> > +    extern void func_vla_1d(int n, int arr[n]);
> > +    extern void func_vla_empty(int n, int arr[]);
> > +    extern void func_vla_ptr(int n, int *arr);
> > +    TEST_STRING(func_vla_1d,    "_ZTSFviPiE");
> > +    TEST_STRING(func_vla_empty, "_ZTSFviPiE");
> > +    TEST_STRING(func_vla_ptr,   "_ZTSFviPiE");
> > +
> > +    /* Test 2D VLA with fixed dimension: should be all the same.  */
> > +    extern void func_vla_2d_first(int n, int arr[n][10]);
> > +    extern void func_vla_2d_empty(int n, int arr[][10]);
> > +    extern void func_vla_2d_ptr(int n, int (*arr)[10]);
> > +    TEST_STRING(func_vla_2d_first, "_ZTSFviPA10_iE");
> > +    TEST_STRING(func_vla_2d_empty, "_ZTSFviPA10_iE");
> > +    TEST_STRING(func_vla_2d_ptr,   "_ZTSFviPA10_iE");
> > +
> > +    /* Test 2D VLA with both dimensions variable: should be all the sa=
me.  */
> > +    extern void func_vla_2d_both(int rows, int cols, int arr[rows][col=
s]);
> > +    extern void func_vla_2d_second(int rows, int cols, int arr[][cols]=
);
> > +    extern void func_vla_2d_star(int rows, int cols, int arr[*][cols])=
;
> > +    TEST_STRING(func_vla_2d_both,   "_ZTSFviiPA_iE");
> > +    TEST_STRING(func_vla_2d_second, "_ZTSFviiPA_iE");
> > +    TEST_STRING(func_vla_2d_star,   "_ZTSFviiPA_iE");
> > +
> > +    /* Test recursive typedef canonicalization */
> > +    struct recursive_struct_test { int field; };
> > +    typedef struct recursive_struct_test recursive_struct_typedef_1;
> > +    typedef recursive_struct_typedef_1 recursive_struct_typedef_2;
> > +    extern void func_recursive_struct_test(struct recursive_struct_tes=
t *x);
> > +    TEST_STRING(func_recursive_struct_test, "_ZTSFvP21recursive_struct=
_testE");
> > +
> > +    /* Test anonymous struct, union, enum types */
> > +    struct { int a; short b; } anon_struct;
> > +    union { int x; float y; } anon_union;
> > +    enum { ANON_VAL1, ANON_VAL2 } anon_enum;
> > +    TEST_STRING(anon_struct, "_ZTS3$_0"); // <length>$_<counter>
> > +    TEST_STRING(anon_union, "_ZTS3$_1");  // <length>$_<counter>
> > +    TEST_STRING(anon_enum, "_ZTS3$_2");   // <length>$_<counter>
> > +
> > +    printf("\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> > +    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail, pas=
s + fail);
> > +    return fail;
> > +}
> > diff --git a/gcc/c-family/c-common.cc b/gcc/c-family/c-common.cc
> > index e7dd4602ac11..94f2c2001ad5 100644
> > --- a/gcc/c-family/c-common.cc
> > +++ b/gcc/c-family/c-common.cc
> > @@ -461,6 +461,8 @@ const struct c_common_resword c_common_reswords[] =
=3D
> >   { "__builtin_stdc_trailing_zeros", RID_BUILTIN_STDC, D_CONLY },
> >   { "__builtin_tgmath", RID_BUILTIN_TGMATH, D_CONLY },
> >   { "__builtin_offsetof", RID_OFFSETOF, 0 },
> > +  { "__builtin_typeinfo_hash", RID_BUILTIN_TYPEINFO_HASH, D_CONLY },
> > +  { "__builtin_typeinfo_name", RID_BUILTIN_TYPEINFO_NAME, D_CONLY },
> >   { "__builtin_types_compatible_p", RID_TYPES_COMPATIBLE_P, D_CONLY },
> >   { "__builtin_c23_va_start", RID_C23_VA_START, D_C23 },
> >   { "__builtin_va_arg", RID_VA_ARG, 0 },
> > diff --git a/gcc/c/c-parser.cc b/gcc/c/c-parser.cc
> > index e8b64948bf69..996fb576ac7c 100644
> > --- a/gcc/c/c-parser.cc
> > +++ b/gcc/c/c-parser.cc
> > @@ -77,6 +77,7 @@ along with GCC; see the file COPYING3.  If not see
> > #include "asan.h"
> > #include "c-family/c-ubsan.h"
> > #include "gcc-urlifier.h"
> > +#include "kcfi-typeinfo.h"
> >=20
> > /* We need to walk over decls with incomplete struct/union/enum types
> >    after parsing the whole translation unit.
> > @@ -11017,6 +11018,38 @@ c_parser_has_attribute_expression (c_parser *p=
arser)
> >   return result;
> > }
> >=20
> > +/* Parse the single type name argument of a builtin that takes a type =
name.
> > +   Returns true on success and stores the parsed type in *OUT_TYPE.
> > +   If successful, *OUT_CLOSE_PAREN_LOC is written with the location of
> > +   the closing parenthesis.  */
> > +
> > +static bool
> > +c_parser_get_builtin_type_arg (c_parser *parser, const char *bname,
> > +       tree *out_type, location_t *out_close_paren_loc)
> > +{
> > +  matching_parens parens;
> > +  if (!parens.require_open (parser))
> > +    return false;
> > +
> > +  struct c_type_name *type_name =3D c_parser_type_name (parser);
> > +  if (type_name =3D=3D NULL)
> > +    {
> > +      error_at (c_parser_peek_token (parser)->location,
> > + "expected type name in %qs", bname);
> > +      return false;
> > +    }
> > +
> > +  *out_close_paren_loc =3D c_parser_peek_token (parser)->location;
> > +  parens.skip_until_found_close (parser);
> > +
> > +  tree type =3D groktypename (type_name, NULL, NULL);
> > +  if (type =3D=3D error_mark_node)
> > +    return false;
> > +
> > +  *out_type =3D type;
> > +  return true;
> > +}
> > +
> > /* Helper function to read arguments of builtins which are interfaces
> >    for the middle-end nodes like COMPLEX_EXPR, VEC_PERM_EXPR and
> >    others.  The name of the builtin is passed using BNAME parameter.
> > @@ -12025,6 +12058,45 @@ c_parser_postfix_expression (c_parser *parser)
> >    set_c_expr_source_range (&expr, loc, close_paren_loc);
> >  }
> >  break;
> > + case RID_BUILTIN_TYPEINFO_NAME:
> > +  {
> > +    c_parser_consume_token (parser);
> > +    location_t close_paren_loc;
> > +    tree type;
> > +    if (!c_parser_get_builtin_type_arg (parser,
> > + "__builtin_typeinfo_name",
> > + &type, &close_paren_loc))
> > +      {
> > + expr.set_error ();
> > + break;
> > +      }
> > +
> > +    /* Call the typeinfo name function.  */
> > +    std::string type_name =3D typeinfo_get_name (type);
> > +    expr.value =3D build_string_literal (type_name.length () + 1,
> > +       type_name.c_str ());
> > +    set_c_expr_source_range (&expr, loc, close_paren_loc);
> > +  }
> > +  break;
> > + case RID_BUILTIN_TYPEINFO_HASH:
> > +  {
> > +    c_parser_consume_token (parser);
> > +    location_t close_paren_loc;
> > +    tree type;
> > +    if (!c_parser_get_builtin_type_arg (parser,
> > + "__builtin_typeinfo_hash",
> > + &type, &close_paren_loc))
> > +      {
> > + expr.set_error ();
> > + break;
> > +      }
> > +
> > +    /* Call the typeinfo hash function.  */
> > +    uint32_t type_hash =3D typeinfo_get_hash (type);
> > +    expr.value =3D build_int_cst (unsigned_type_node, type_hash);
> > +    set_c_expr_source_range (&expr, loc, close_paren_loc);
> > +  }
> > +  break;
> > case RID_BUILTIN_TGMATH:
> >  {
> >    vec<c_expr_t, va_gc> *cexpr_list;
> > diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
> > index 382295834035..7cddea1ed6c1 100644
> > --- a/gcc/doc/extend.texi
> > +++ b/gcc/doc/extend.texi
> > @@ -17547,6 +17547,100 @@ which will cause a @code{NULL} pointer to be =
used for the unsafe case.
> >=20
> > @enddefbuiltin
> >=20
> > +@defbuiltin{{unsigned int} __builtin_typeinfo_hash (@var{type})}
> > +
> > +The built-in function @code{__builtin_typeinfo_hash} returns a hash va=
lue
> > +for the given type @var{type} (which is a type, not an expression).  T=
he hash
> > +is computed using the FNV-1a algorithm on the type's mangled name repr=
esentation,
> > +which follows a subset of the Itanium C++ ABI conventions adapted for =
C types.
> > +(See @code{__buitin_typeinfo_name} for the string representation.)
> > +
> > +This built-in is primarily intended for kernel control flow integrity =
(KCFI)
> > +implementations and other type-aware runtime systems that need to gene=
rate
> > +consistent type identifiers.  The hash value is a 32-bit unsigned inte=
ger.
> > +
> > +Key characteristics of the hash:
> > +@itemize @bullet
> > +@item
> > +The hash is consistent for the same type across different translation =
units.
> > +@item
> > +Typedefs are recursively canonicalized down to integral type name or n=
amed
> > +struct, union, or enum tag name.
> > +@item
> > +Typedefs of anonymous structs, unions, and enums preserve the typedef =
name
> > +in the hash calculation (e.g., @code{typedef struct @{ int x; @} foo_t=
;}
> > +uses @code{foo_t} in the hash).
> > +@item
> > +Type qualifiers (@code{const}, @code{volatile}, @code{restrict}) affec=
t
> > +the hash value.
> > +@item
> > +Function types include parameter types and variadic markers in the has=
h.
> > +@end itemize
> > +
> > +For example:
> > +@smallexample
> > +typedef struct @{ int x; @} mytype_t;
> > +unsigned int hash1 =3D __builtin_typeinfo_hash(mytype_t);
> > +unsigned int hash2 =3D __builtin_typeinfo_hash(struct @{ int x; @});
> > +/* hash1 !=3D hash2 because the typedef name is preserved */
> > +
> > +void func(int x, char y);
> > +unsigned int hash3 =3D __builtin_typeinfo_hash(typeof(func));
> > +/* Returns hash for function type "void(int, char)" */
> > +@end smallexample
> > +
> > +@emph{Note:} This construct is only available for C@. For C++, see
> > +@code{std::type_info::hash_code}.
> > +
> > +@enddefbuiltin
> > +
> > +@defbuiltin{{const char *} __builtin_typeinfo_name (@var{type})}
> > +
> > +The built-in function @code{__builtin_typeinfo_name} returns a string
> > +containing the mangled name representation of the given type @var{type=
}
> > +(which is a type, not an expression).  The string follows a subset of =
the
> > +Itanium C++ ABI mangling conventions adapted for C types.  (See
> > +@code{__buitin_typeinfo_hash} for the unsigned 32-bit hash representat=
ion.)
> > +
> > +The returned string is a compile-time constant suitable for use in
> > +string comparisons, debugging output, or other type introspection need=
s.
> > +The string begins with @code{_ZTS} followed by the encoded type inform=
ation.
> > +
> > +Mangling examples:
> > +@itemize @bullet
> > +@item
> > +@code{int} becomes @code{"_ZTSi"}
> > +@item
> > +@code{char *} becomes @code{"_ZTSPc"}
> > +@item
> > +@code{const int} becomes @code{"_ZTSKi"}
> > +@item
> > +@code{int[10]} becomes @code{"_ZTSA10_i"}
> > +@item
> > +@code{void (*)(int)} becomes @code{"_ZTSPFviE"}
> > +@item
> > +@code{struct foo} becomes @code{"_ZTS3foo"}
> > +@item
> > +@code{typedef struct @{ int x; @} bar_t;} becomes @code{"_ZTS5bar_t"}
> > +@end itemize
> > +
> > +The mangling preserves typedef names for anonymous compound types, whi=
ch
> > +is particularly useful for distinguishing between different typedefs o=
f
> > +structurally identical anonymous types:
> > +
> > +@smallexample
> > +typedef struct @{ int x; @} type_a;
> > +typedef struct @{ int x; @} type_b;
> > +const char *name_a =3D __builtin_typeinfo_name(type_a);  /* "_ZTS6type=
_a" */
> > +const char *name_b =3D __builtin_typeinfo_name(type_b);  /* "_ZTS6type=
_b" */
> > +/* name_a and name_b are different despite identical structure */
> > +@end smallexample
> > +
> > +@emph{Note:} This construct is only available for C@. For C++, see
> > +@code{std::type_info::name}.
> > +
> > +@enddefbuiltin
> > +
> > @defbuiltin{int __builtin_types_compatible_p (@var{type1}, @var{type2})=
}
> >=20
> > You can use the built-in function @code{__builtin_types_compatible_p} t=
o
> > diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> > new file mode 100644
> > index 000000000000..24099c42cc2e
> > --- /dev/null
> > +++ b/gcc/kcfi-typeinfo.cc
> > @@ -0,0 +1,475 @@
> > +/* KCFI-compatible type mangling, based on Itanium C++ ABI.
> > +   Copyright (C) 2025 Free Software Foundation, Inc.
> > +
> > +This file is part of GCC.
> > +
> > +GCC is free software; you can redistribute it and/or modify it under
> > +the terms of the GNU General Public License as published by the Free
> > +Software Foundation; either version 3, or (at your option) any later
> > +version.
> > +
> > +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> > +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> > +for more details.
> > +
> > +You should have received a copy of the GNU General Public License
> > +along with GCC; see the file COPYING3.  If not see
> > +<http://www.gnu.org/licenses/>.  */
> > +
> > +/* Produces typeinfo mangling similar to Itanium C++ Mangling ABI, but
> > +   limited to types exposed within GCC for C language handling.  The
> > +   hashes are used by KCFI (and future type-aware allocator support).
> > +   The strings are used for testing and debugging.  */
> > +
> > +#include "config.h"
> > +#include "system.h"
> > +#include "coretypes.h"
> > +#include "tree.h"
> > +#include "diagnostic-core.h"
> > +#include "stringpool.h"
> > +#include "stor-layout.h"
> > +#include "print-tree.h"
> > +#include "kcfi-typeinfo.h"
> > +
> > +/* Helper to update FNV-1a hash with a single character.  */
> > +
> > +static inline void
> > +fnv1a_hash_char (uint32_t *hash_state, unsigned char c)
> > +{
> > +  *hash_state ^=3D c;
> > +  *hash_state *=3D 16777619U; /* FNV-1a 32-bit prime.  */
> > +}
> > +
> > +/* Helper to append character to optional string and update hash using
> > +   FNV-1a.  */
> > +
> > +static void
> > +append_char (char c, std::string *out_str, uint32_t *hash_state)
> > +{
> > +  if (out_str)
> > +    *out_str +=3D c;
> > +  if (!hash_state)
> > +    return;
> > +  fnv1a_hash_char (hash_state, (unsigned char) c);
> > +}
> > +
> > +/* Helper to append string to optional string and update hash using
> > +   FNV-1a.  */
> > +
> > +static void
> > +append_string (const char *str, std::string *out_str, uint32_t *hash_s=
tate)
> > +{
> > +  if (out_str)
> > +    *out_str +=3D str;
> > +  if (!hash_state)
> > +    return;
> > +  for (const char *p =3D str; *p; p++)
> > +    fnv1a_hash_char (hash_state, (unsigned char) *p);
> > +}
> > +
> > +/* Forward declaration for recursive type mangling.  */
> > +
> > +static void mangle_type (tree type, std::string *out_str, uint32_t *ha=
sh_state);
> > +
> > +/* Mangle a builtin type following Itanium C++ ABI for C types.  */
> > +
> > +static void
> > +mangle_builtin_type (tree type, std::string *out_str, uint32_t *hash_s=
tate)
> > +{
> > +  gcc_assert (type !=3D NULL_TREE);
> > +
> > +  switch (TREE_CODE (type))
> > +    {
> > +    case VOID_TYPE:
> > +      append_char ('v', out_str, hash_state);
> > +      return;
> > +
> > +    case BOOLEAN_TYPE:
> > +      append_char ('b', out_str, hash_state);
> > +      return;
> > +
> > +    case INTEGER_TYPE:
> > +      if (type =3D=3D char_type_node)
> > + append_char ('c', out_str, hash_state);
> > +      else if (type =3D=3D signed_char_type_node)
> > + append_char ('a', out_str, hash_state);
> > +      else if (type =3D=3D unsigned_char_type_node)
> > + append_char ('h', out_str, hash_state);
> > +      else if (type =3D=3D short_integer_type_node)
> > + append_char ('s', out_str, hash_state);
> > +      else if (type =3D=3D short_unsigned_type_node)
> > + append_char ('t', out_str, hash_state);
> > +      else if (type =3D=3D integer_type_node)
> > + append_char ('i', out_str, hash_state);
> > +      else if (type =3D=3D unsigned_type_node)
> > + append_char ('j', out_str, hash_state);
> > +      else if (type =3D=3D long_integer_type_node)
> > + append_char ('l', out_str, hash_state);
> > +      else if (type =3D=3D long_unsigned_type_node)
> > + append_char ('m', out_str, hash_state);
> > +      else if (type =3D=3D long_long_integer_type_node)
> > + append_char ('x', out_str, hash_state);
> > +      else if (type =3D=3D long_long_unsigned_type_node)
> > + append_char ('y', out_str, hash_state);
> > +      else
> > + {
> > +  /* Fallback for other integer types - use precision-based
> > +     encoding.  */
> > +  append_char ('i', out_str, hash_state);
> > +  append_string (std::to_string (TYPE_PRECISION (type)).c_str (),
> > + out_str, hash_state);
> > + }
> > +      return;
> > +
> > +    case REAL_TYPE:
> > +      if (type =3D=3D float_type_node)
> > + append_char ('f', out_str, hash_state);
> > +      else if (type =3D=3D double_type_node)
> > + append_char ('d', out_str, hash_state);
> > +      else if (type =3D=3D long_double_type_node)
> > + append_char ('e', out_str, hash_state);
> > +      else
> > + {
> > +  /* Fallback for other real types.  */
> > +  append_char ('f', out_str, hash_state);
> > +  append_string (std::to_string (TYPE_PRECISION (type)).c_str (),
> > + out_str, hash_state);
> > + }
> > +      return;
> > +
> > +    case VECTOR_TYPE:
> > +      {
> > + /* Handle vector types:
> > +   Dv<num-elements>_<element-type-encoding>
> > +   Example: uint8x16_t -> Dv16_h (vector of 16 unsigned char)  */
> > + tree vector_size =3D TYPE_SIZE_UNIT (type);
> > + tree element_type =3D TREE_TYPE (type);
> > + tree element_size =3D TYPE_SIZE_UNIT (element_type);
> > +
> > + if (vector_size && element_size
> > +    && TREE_CODE (vector_size) =3D=3D INTEGER_CST
> > +    && TREE_CODE (element_size) =3D=3D INTEGER_CST)
> > +  {
> > +    append_char ('D', out_str, hash_state);
> > +    append_char ('v', out_str, hash_state);
> > +
> > +    unsigned HOST_WIDE_INT vec_bytes =3D tree_to_uhwi (vector_size);
> > +    unsigned HOST_WIDE_INT elem_bytes =3D tree_to_uhwi (element_size);
> > +    unsigned HOST_WIDE_INT num_elements =3D vec_bytes / elem_bytes;
> > +
> > +    /* Append number of elements.  */
> > +    append_string (std::to_string (num_elements).c_str (),
> > +   out_str, hash_state);
> > +    append_char ('_', out_str, hash_state);
> > +
> > +    /* Recursively mangle the element type.  */
> > +    mangle_type (element_type, out_str, hash_state);
> > +    return;
> > +  }
> > + /* Fail for vectors with unknown size.  */
> > +      }
> > +      break;
> > +
> > +    default:
> > +      break;
> > +    }
> > +
> > +  /* Unknown builtin type: this should never happen in a well-formed C=
.  */
> > +  debug_tree (type);
> > +  internal_error ("mangle: Unknown builtin type - please report this a=
s a bug");
> > +}
> > +
> > +/* Canonicalize typedef types to their underlying named struct/union t=
ypes.  */
> > +
> > +static tree
> > +canonicalize_typedef_type (tree type)
> > +{
> > +  /* Handle typedef types: canonicalize to named structs when possible=
.  */
> > +  if (TYPE_NAME (type) && TREE_CODE (TYPE_NAME (type)) =3D=3D TYPE_DEC=
L)
> > +    {
> > +      tree type_decl =3D TYPE_NAME (type);
> > +
> > +      /* Check if this is a typedef (not the original struct declarati=
on) */
> > +      if (DECL_ORIGINAL_TYPE (type_decl))
> > + {
> > +  tree original_type =3D DECL_ORIGINAL_TYPE (type_decl);
> > +
> > +  /* Handle struct/union/enum types.  */
> > +  if (TREE_CODE (original_type) =3D=3D RECORD_TYPE
> > +      || TREE_CODE (original_type) =3D=3D UNION_TYPE
> > +      || TREE_CODE (original_type) =3D=3D ENUMERAL_TYPE)
> > +    {
> > +      /* Preserve typedef of anonymous struct/union/enum types.  */
> > +      if (!TYPE_NAME (original_type))
> > + return type;
> > +
> > +      /* Named compound type: canonicalize to it.  */
> > +      return canonicalize_typedef_type (original_type);
> > +    }
> > +
> > +  /* For basic type typedefs (e.g., u8 -> unsigned char),
> > +     canonicalize to original type.  */
> > +  if (TREE_CODE (original_type) =3D=3D INTEGER_TYPE
> > +      || TREE_CODE (original_type) =3D=3D REAL_TYPE
> > +      || TREE_CODE (original_type) =3D=3D POINTER_TYPE
> > +      || TREE_CODE (original_type) =3D=3D ARRAY_TYPE
> > +      || TREE_CODE (original_type) =3D=3D FUNCTION_TYPE
> > +      || TREE_CODE (original_type) =3D=3D METHOD_TYPE
> > +      || TREE_CODE (original_type) =3D=3D BOOLEAN_TYPE
> > +      || TREE_CODE (original_type) =3D=3D COMPLEX_TYPE
> > +      || TREE_CODE (original_type) =3D=3D VECTOR_TYPE)
> > +    {
> > +      /* Recursively canonicalize in case the original type is
> > + also a typedef.  */
> > +      return canonicalize_typedef_type (original_type);
> > +    }
> > + }
> > +    }
> > +
> > +  return type;
> > +}
> > +
> > +/* Recursively mangle a C type following Itanium C++ ABI.  */
> > +
> > +static void
> > +mangle_type (tree type, std::string *out_str, uint32_t *hash_state)
> > +{
> > +  gcc_assert (type !=3D NULL_TREE);
> > +
> > +  /* Canonicalize typedef types to their underlying named struct types=
.  */
> > +  type =3D canonicalize_typedef_type (type);
> > +
> > +  /* Save original qualified type for cases where we need typedef
> > +     information.  */
> > +  tree qualified_type =3D type;
> > +
> > +  /* Centralized qualifier handling: emit qualifiers for this type,
> > +     then continue with unqualified version.  */
> > +  if (TYPE_QUALS (type) !=3D TYPE_UNQUALIFIED)
> > +    {
> > +      /* Emit qualifiers in Itanium ABI order: restrict, volatile, con=
st.  */
> > +      if (TYPE_QUALS (type) & TYPE_QUAL_RESTRICT)
> > + append_char ('r', out_str, hash_state);
> > +      if (TYPE_QUALS (type) & TYPE_QUAL_VOLATILE)
> > + append_char ('V', out_str, hash_state);
> > +      if (TYPE_QUALS (type) & TYPE_QUAL_CONST)
> > + append_char ('K', out_str, hash_state);
> > +
> > +      /* Get unqualified version for further processing.  */
> > +      type =3D TYPE_MAIN_VARIANT (type);
> > +    }
> > +
> > +  switch (TREE_CODE (type))
> > +    {
> > +    case POINTER_TYPE:
> > +      {
> > + /* Pointer type: 'P' + pointed-to type.  */
> > + append_char ('P', out_str, hash_state);
> > +
> > + /* Recursively mangle the pointed-to type.  */
> > + tree pointed_to_type =3D TREE_TYPE (type);
> > + mangle_type (pointed_to_type, out_str, hash_state);
> > + break;
> > +      }
> > +
> > +    case ARRAY_TYPE:
> > +      /* Array type: 'A' + size + '_' + element type (simplified).  */
> > +      append_char ('A', out_str, hash_state);
> > +      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
> > + {
> > +  tree max_val =3D TYPE_MAX_VALUE (TYPE_DOMAIN (type));
> > +  /* Check if array size is compile-time constant to handle VLAs. */
> > +  if (TREE_CODE (max_val) =3D=3D INTEGER_CST && tree_fits_shwi_p (max_=
val))
> > +    {
> > +      HOST_WIDE_INT size =3D tree_to_shwi (max_val) + 1;
> > +      append_string (std::to_string ((long) size).c_str (),
> > +     out_str, hash_state);
> > +    }
> > +  /* For VLAs or non-constant dimensions, emit empty size (A_).  */
> > +  append_char ('_', out_str, hash_state);
> > + }
> > +      else
> > + {
> > +  /* No domain or no max value: emit A_.  */
> > +  append_char ('_', out_str, hash_state);
> > + }
> > +      mangle_type (TREE_TYPE (type), out_str, hash_state);
> > +      break;
> > +
> > +    case REFERENCE_TYPE:
> > +      /* Reference type: 'R' + referenced type.
> > + Note: We must handle references to builtin types including compiler
> > + builtins like __builtin_va_list used in functions like va_start.  */
> > +      append_char ('R', out_str, hash_state);
> > +      mangle_type (TREE_TYPE (type), out_str, hash_state);
> > +      break;
> > +
> > +    case FUNCTION_TYPE:
> > +      {
> > + /* Function type: 'F' + return type + parameter types + 'E' */
> > + append_char ('F', out_str, hash_state);
> > + mangle_type (TREE_TYPE (type), out_str, hash_state);
> > +
> > + /* Add parameter types.  */
> > + tree param_types =3D TYPE_ARG_TYPES (type);
> > +
> > + if (param_types =3D=3D NULL_TREE)
> > +  {
> > +    /* func () - no parameter list (could be variadic). */
> > +  }
> > + else
> > +  {
> > +    bool found_real_params =3D false;
> > +    for (tree param =3D param_types; param; param =3D TREE_CHAIN (para=
m))
> > +      {
> > + tree param_type =3D TREE_VALUE (param);
> > + if (param_type =3D=3D void_type_node)
> > +  {
> > +    /* Check if this is the first parameter (explicit void) or a
> > +       sentinel.  */
> > +    if (!found_real_params)
> > +      {
> > + /* func (void) - explicit empty parameter list.
> > +   Mangle void to distinguish from variadic func (). */
> > + mangle_type (void_type_node, out_str, hash_state);
> > +      }
> > +    /* If we found real params before this void, it's a sentinel
> > +       so stop here.  */
> > +    break;
> > +  }
> > +
> > + found_real_params =3D true;
> > +
> > + /* For value parameters, ignore const/volatile qualifiers as
> > +   they don't affect the calling convention.  "const int" and
> > +   "int" are passed identically by value.  */
> > + tree canonical_param_type =3D param_type;
> > +
> > + if (TREE_CODE (param_type) !=3D POINTER_TYPE
> > +    && TREE_CODE (param_type) !=3D REFERENCE_TYPE
> > +    && TREE_CODE (param_type) !=3D ARRAY_TYPE)
> > +  {
> > +    /* For non-pointer/reference value parameters, strip
> > +       qualifiers by default.  */
> > +    canonical_param_type =3D TYPE_MAIN_VARIANT (param_type);
> > +
> > +    /* Exception: preserve typedef information for anonymous
> > +       compound types.  */
> > +    if (TYPE_NAME (param_type)
> > + && TREE_CODE (TYPE_NAME (param_type)) =3D=3D TYPE_DECL
> > + && DECL_ORIGINAL_TYPE (TYPE_NAME (param_type)))
> > +      {
> > + tree original_type
> > +  =3D DECL_ORIGINAL_TYPE (TYPE_NAME (param_type));
> > + if ((TREE_CODE (original_type) =3D=3D RECORD_TYPE
> > +     || TREE_CODE (original_type) =3D=3D UNION_TYPE
> > +     || TREE_CODE (original_type) =3D=3D ENUMERAL_TYPE)
> > +    && !TYPE_NAME (original_type))
> > +  {
> > +    /* Preserve typedef of an anonymous
> > +       struct/union/enum.  */
> > +    canonical_param_type =3D param_type;
> > +  }
> > +      }
> > +  }
> > +
> > + mangle_type (canonical_param_type, out_str, hash_state);
> > +      }
> > +  }
> > +
> > + /* Check if this is a variadic function and add 'z' marker.  */
> > + if (stdarg_p (type))
> > +  {
> > +    append_char ('z', out_str, hash_state);
> > +  }
> > +
> > + append_char ('E', out_str, hash_state);
> > + break;
> > +      }
> > +
> > +    case RECORD_TYPE:
> > +    case UNION_TYPE:
> > +    case ENUMERAL_TYPE:
> > +      {
> > + /* Struct/union/enum: use simplified representation for C types.  */
> > + const char *name =3D NULL;
> > +
> > + /* For compound types, use the original qualified type to preserve
> > +   typedef info.  */
> > + if (TYPE_QUALS (qualified_type) !=3D TYPE_UNQUALIFIED)
> > +  {
> > +    type =3D qualified_type;
> > +  }
> > +
> > + if (TYPE_NAME (type))
> > +  {
> > +    if (TREE_CODE (TYPE_NAME (type)) =3D=3D TYPE_DECL)
> > +      {
> > + /* TYPE_DECL case: both named structs and typedef structs.  */
> > + tree decl_name =3D DECL_NAME (TYPE_NAME (type));
> > + if (decl_name && TREE_CODE (decl_name) =3D=3D IDENTIFIER_NODE)
> > +  {
> > +    name =3D IDENTIFIER_POINTER (decl_name);
> > +  }
> > +      }
> > +    else if (TREE_CODE (TYPE_NAME (type)) =3D=3D IDENTIFIER_NODE)
> > +      {
> > + /* Direct identifier case.  */
> > + name =3D IDENTIFIER_POINTER (TYPE_NAME (type));
> > +      }
> > +  }
> > +
> > + if (name)
> > +  {
> > +    append_string (std::to_string (strlen (name)).c_str (),
> > +   out_str, hash_state);
> > +    append_string (name, out_str, hash_state);
> > +    break;
> > +  }
> > +
> > + /* If no name found, use anonymous type format: <length>$_<counter>. =
 */
> > + static unsigned anon_counter =3D 0;
> > + std::string anon_name =3D "$_" + std::to_string (anon_counter++);
> > +
> > + append_string (std::to_string (anon_name.length ()).c_str (),
> > +       out_str, hash_state);
> > + append_string (anon_name.c_str (), out_str, hash_state);
> > + break;
> > +      }
> > +
> > +    default:
> > +      /* Handle builtin types.  */
> > +      mangle_builtin_type (type, out_str, hash_state);
> > +      break;
> > +    }
> > +}
> > +
> > +/* Get the typeinfo mangled name string for any C type.
> > +   Returns the mangled type string following Itanium C++ ABI conventio=
ns.  */
> > +
> > +std::string
> > +typeinfo_get_name (tree type)
> > +{
> > +  gcc_assert (type !=3D NULL_TREE);
> > +  std::string result =3D "_ZTS";
> > +
> > +  mangle_type (type, &result, nullptr);
> > +  return result;
> > +}
> > +
> > +/* Get the typeinfo hash for any C type.
> > +   Returns the FNV-1a hash of the mangled type string.  */
> > +
> > +uint32_t
> > +typeinfo_get_hash (tree type)
> > +{
> > +  gcc_assert (type !=3D NULL_TREE);
> > +  uint32_t hash_state =3D 2166136261U; /* FNV-1a 32-bit offset basis. =
 */
> > +
> > +  /* Include _ZTS prefix in hash calculation.  */
> > +  append_string ("_ZTS", nullptr, &hash_state);
> > +
> > +  mangle_type (type, nullptr, &hash_state);
> > +  return hash_state;
> > +}
> > --=20
> > 2.34.1
> >=20
