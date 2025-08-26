Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E71862A
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756182144; cv=none; b=AogkSLXa4ETrFiW9HxgPdcGgZiItiuuUyxp8SpwKrJFl22z7Vh75uUZNrAR89jMjPp0H/FJhkESA7fXRpqKqLBkI4Iv277a2T4VuBLeVTl8VVLKallI4cnQvnpIL5SUM7ZMRZaQNQhoYPlq4UgKNGlcUofxSeY6A1JEz7xxtjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756182144; c=relaxed/simple;
	bh=2dralINBFtxtuUc+VGdnqm3K+3+y6x7q4nQCEpUCvhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjutaxOXUoWFM6HlM4criIlFWKGvoZxvVOv2fzrCDfCunuKsjU4NWGSom5e8j259MTR3L92BaxibdUFTbEWzIcWg31yiCRDdpWq1VzbsfyOBwO1I6T8yDrQ8Qxi1tKu8V4sTh13xXCGdlhaI+XoQUDDQKVgHWhnOATHPKwHUTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4BtClGw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4BtClGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E36C4CEF1;
	Tue, 26 Aug 2025 04:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756182144;
	bh=2dralINBFtxtuUc+VGdnqm3K+3+y6x7q4nQCEpUCvhA=;
	h=From:To:Cc:Subject:Date:From;
	b=i4BtClGw9e75X/tzZAInXfjZLqyrxmBOWIfsp/JXbyr7XS+j3GZeoduA98MQIbAxy
	 uZjyGzDGCMN1p/p3yFKCAvVDXSGf/12DmGMac1J6PeDb7VlfwzFPN381O9isxywa5o
	 ijiLp9Ml0bDsph7huNnxLjCIW2Cs6fu0bc2W1oJSfs4fQsYFZsEAUMYahhpTdQTXG9
	 DPYnuvVcdBFwrqyLG0OoPjKGQQriceG2QX8TwNZG9qgfS8+lq6be7XxE7Q0B4NecKW
	 DMPr0iLfPyiliTqQJB0RAMoskYlpKavb+rYvDwPfIxM98BZoIB/DA/uNxLfd98D9Hb
	 kiqlZw07jLTuw==
From: Kees Cook <kees@kernel.org>
To: Claudiu Zissulescu <claziss@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Qing Zhao <qing.zhao@oracle.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] arc: Add const attribute support for mathematical ARC builtins
Date: Mon, 25 Aug 2025 21:22:17 -0700
Message-Id: <20250826042212.work.202-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=31669; i=kees@kernel.org; h=from:subject:message-id; bh=2dralINBFtxtuUc+VGdnqm3K+3+y6x7q4nQCEpUCvhA=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlrzSqn+DXtnuUdqlhsqH1iZVRl/NVXj3evdpQ3Z5jy/ 6tm1nLDjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImcWcTwh6N8h5dofKzbzAkW mbtPtuibaLZ1Sbc+uLPm79buoiLGR4wMk6Z/3Htwk8PLZffec/1SFb362vyMgK23qOyqWlezjUy 6fAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The ARC builtin functions __builtin_arc_ffs and __builtin_arc_fls
perform pure mathematical operations equivalent to the standard
GCC __builtin_ffs function, which is marked with the const attribute.
However, the ARC target-specific versions were not marked as const,
preventing compiler optimizations like common subexpression elimination.

Extend the ARC builtin infrastructure to support function attributes
and mark the appropriate mathematical builtins as const:

- __builtin_arc_ffs: Find first set bit (const)
- __builtin_arc_fls: Find last set bit (const)
- __builtin_arc_norm: Count leading zeros (const)
- __builtin_arc_normw: Count leading zeros for 16-bit (const)
- __builtin_arc_swap: Endian swap (const)

gcc/ChangeLog:

	* config/arc/builtins.def: Add ATTRS parameter to DEF_BUILTIN
	macro calls.  Mark mathematical builtins (FFS, FLS, NORM, NORMW,
	SWAP) with attr_const, leave others as NULL_TREE.
	* config/arc/arc.cc: Add support for builtin function attributes.
	Create attr_const using tree_cons.  Update DEF_BUILTIN macro to
	pass ATTRS parameter to add_builtin_function.

gcc/testsuite/ChangeLog:

	* gcc.target/arc/builtin_fls_const.c: New test.  Verify that
	const attribute enables CSE optimization for mathematical ARC
	builtins by checking that duplicate calls are eliminated and
	results are optimized to shift operations.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 .../gcc.target/arc/builtin_fls_const.c        |  35 ++
 gcc/config/arc/arc.cc                         |  11 +-
 gcc/config/arc/builtins.def                   | 308 +++++++++---------
 3 files changed, 197 insertions(+), 157 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/arc/builtin_fls_const.c

diff --git a/gcc/testsuite/gcc.target/arc/builtin_fls_const.c b/gcc/testsuite/gcc.target/arc/builtin_fls_const.c
new file mode 100644
index 000000000000..cb1da946d377
--- /dev/null
+++ b/gcc/testsuite/gcc.target/arc/builtin_fls_const.c
@@ -0,0 +1,35 @@
+/* Test that const attribute enables CSE optimization for ARC builtins.  */
+/* { dg-do compile } */
+/* { dg-options "-O2" } */
+
+int test_fls_cse(int x)
+{
+  /* Two calls to the same const builtin with same argument should
+     be optimized to a single call plus a multiply-by-2 operation.  */
+  int a = __builtin_arc_fls(x);
+  int b = __builtin_arc_fls(x);
+  return a + b;
+}
+
+int test_ffs_cse(int x)
+{
+  /* Same pattern for __builtin_arc_ffs.  */
+  int a = __builtin_arc_ffs(x);
+  int b = __builtin_arc_ffs(x);
+  return a + b;
+}
+
+int test_norm_cse(int x)
+{
+  /* Same pattern for __builtin_arc_norm.  */
+  int a = __builtin_arc_norm(x);
+  int b = __builtin_arc_norm(x);
+  return a + b;
+}
+
+/* { dg-final { scan-assembler-times "fls\\s+" 1 } } */
+/* { dg-final { scan-assembler-times "ffs\\s+" 1 } } */
+/* { dg-final { scan-assembler-times "norm\\s+" 1 } } */
+
+/* Verify that the result is multiplied by 2 using left shift.  */
+/* { dg-final { scan-assembler "asl_s\\s+.*,.*,1" } } */
\ No newline at end of file
diff --git a/gcc/config/arc/arc.cc b/gcc/config/arc/arc.cc
index bb5db977c800..5c34d9c78907 100644
--- a/gcc/config/arc/arc.cc
+++ b/gcc/config/arc/arc.cc
@@ -6705,7 +6705,7 @@ arc_cannot_force_const_mem (machine_mode mode, rtx x)
 
 enum arc_builtin_id
   {
-#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK)	\
+#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK, ATTRS)	\
     ARC_BUILTIN_ ## NAME,
 #include "builtins.def"
 #undef DEF_BUILTIN
@@ -6723,7 +6723,7 @@ struct GTY(()) arc_builtin_description
 static GTY(()) struct arc_builtin_description
 arc_bdesc[ARC_BUILTIN_COUNT] =
 {
-#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK)		\
+#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK, ATTRS)		\
   { (enum insn_code) CODE_FOR_ ## ICODE, N_ARGS, NULL_TREE },
 #include "builtins.def"
 #undef DEF_BUILTIN
@@ -6855,8 +6855,11 @@ arc_init_builtins (void)
     = build_function_type_list (long_long_integer_type_node,
 				V2SI_type_node, V2HI_type_node, NULL_TREE);
 
+  /* Create const attribute for mathematical functions.  */
+  tree attr_const = tree_cons (get_identifier ("const"), NULL, NULL);
+
   /* Add the builtins.  */
-#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK)			\
+#define DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK, ATTRS)		\
   {									\
     int id = ARC_BUILTIN_ ## NAME;					\
     const char *Name = "__builtin_arc_" #NAME;				\
@@ -6866,7 +6869,7 @@ arc_init_builtins (void)
     if (MASK)								\
       arc_bdesc[id].fndecl						\
 	= add_builtin_function (arc_tolower(name, Name), TYPE, id,	\
-				BUILT_IN_MD, NULL, NULL_TREE);		\
+				BUILT_IN_MD, NULL, ATTRS);		\
   }
 #include "builtins.def"
 #undef DEF_BUILTIN
diff --git a/gcc/config/arc/builtins.def b/gcc/config/arc/builtins.def
index e3c57804c84f..ae230dcea749 100644
--- a/gcc/config/arc/builtins.def
+++ b/gcc/config/arc/builtins.def
@@ -20,7 +20,7 @@
    builtins defined in the ARC part of the GNU compiler.  Before
    including this file, define a macro
 
-   DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK)
+   DEF_BUILTIN(NAME, N_ARGS, TYPE, ICODE, MASK, ATTRS)
 
    NAME:    `__builtin_arc_name' will be the user-level name of the builtin.
             `ARC_BUILTIN_NAME' will be the internal builtin's id.
@@ -29,194 +29,196 @@
    TYPE:    A tree node describing the prototype of the built-in.
    ICODE:   Name of attached insn or expander.  If special treatment in arc.cc
             is needed to expand the built-in, use `nothing'.
-   MASK:    CPU selector mask.  */
+   MASK:    CPU selector mask.
+   ATTRS:   Function attributes like "attr_const" for the `const' attribute
+            or "NULL_TREE" for no attribute.  */
 
 /* Special builtins.  */
-DEF_BUILTIN (NOP,        0, void_ftype_void,        nothing,     1)
-DEF_BUILTIN (RTIE,       0, void_ftype_void,        rtie,        !TARGET_ARC600_FAMILY)
-DEF_BUILTIN (SYNC,       0, void_ftype_void,        sync,        1)
-DEF_BUILTIN (BRK,        0, void_ftype_void,        brk,         1)
-DEF_BUILTIN (SWI,        0, void_ftype_void,        swi,         1)
-DEF_BUILTIN (UNIMP_S,    0, void_ftype_void,        unimp_s,     !TARGET_ARC600_FAMILY)
-DEF_BUILTIN (TRAP_S,     1, void_ftype_usint,       trap_s,      !TARGET_ARC600_FAMILY)
-DEF_BUILTIN (ALIGNED,    2, int_ftype_pcvoid_int,   nothing,     1)
-DEF_BUILTIN (CLRI,       0, int_ftype_void,         clri,        TARGET_V2)
-DEF_BUILTIN (SLEEP,      1, void_ftype_usint,       sleep,       1)
-
-DEF_BUILTIN (FLAG,       1, void_ftype_usint,       flag,       1)
-DEF_BUILTIN (SR,         2, void_ftype_usint_usint, sr,         1)
-DEF_BUILTIN (KFLAG,      1, void_ftype_usint,       kflag,      TARGET_V2)
-DEF_BUILTIN (CORE_WRITE, 2, void_ftype_usint_usint, core_write, 1)
-DEF_BUILTIN (SETI,       1, void_ftype_int,         seti,       TARGET_V2)
+DEF_BUILTIN (NOP,        0, void_ftype_void,        nothing,     1, NULL_TREE)
+DEF_BUILTIN (RTIE,       0, void_ftype_void,        rtie,        !TARGET_ARC600_FAMILY, NULL_TREE)
+DEF_BUILTIN (SYNC,       0, void_ftype_void,        sync,        1, NULL_TREE)
+DEF_BUILTIN (BRK,        0, void_ftype_void,        brk,         1, NULL_TREE)
+DEF_BUILTIN (SWI,        0, void_ftype_void,        swi,         1, NULL_TREE)
+DEF_BUILTIN (UNIMP_S,    0, void_ftype_void,        unimp_s,     !TARGET_ARC600_FAMILY, NULL_TREE)
+DEF_BUILTIN (TRAP_S,     1, void_ftype_usint,       trap_s,      !TARGET_ARC600_FAMILY, NULL_TREE)
+DEF_BUILTIN (ALIGNED,    2, int_ftype_pcvoid_int,   nothing,     1, NULL_TREE)
+DEF_BUILTIN (CLRI,       0, int_ftype_void,         clri,        TARGET_V2, NULL_TREE)
+DEF_BUILTIN (SLEEP,      1, void_ftype_usint,       sleep,       1, NULL_TREE)
+
+DEF_BUILTIN (FLAG,       1, void_ftype_usint,       flag,       1, NULL_TREE)
+DEF_BUILTIN (SR,         2, void_ftype_usint_usint, sr,         1, NULL_TREE)
+DEF_BUILTIN (KFLAG,      1, void_ftype_usint,       kflag,      TARGET_V2, NULL_TREE)
+DEF_BUILTIN (CORE_WRITE, 2, void_ftype_usint_usint, core_write, 1, NULL_TREE)
+DEF_BUILTIN (SETI,       1, void_ftype_int,         seti,       TARGET_V2, NULL_TREE)
 
 /* Regular builtins.  */
-DEF_BUILTIN (NORM,       1, int_ftype_int,     clrsbsi2,      TARGET_NORM)
-DEF_BUILTIN (NORMW,      1, int_ftype_short,   normw,         TARGET_NORM)
-DEF_BUILTIN (SWAP,       1, int_ftype_int,     rotlsi2_cnt16, TARGET_SWAP)
-DEF_BUILTIN (DIVAW,      2, int_ftype_int_int, divaw,         TARGET_EA_SET)
-DEF_BUILTIN (CORE_READ,  1, usint_ftype_usint, core_read,     1)
-DEF_BUILTIN (LR,         1, usint_ftype_usint, lr,            1)
-DEF_BUILTIN (FFS,        1, int_ftype_int,     ffs,           (TARGET_EM && TARGET_NORM) || TARGET_HS)
-DEF_BUILTIN (FLS,        1, int_ftype_int,     fls,           (TARGET_EM && TARGET_NORM) || TARGET_HS)
+DEF_BUILTIN (NORM,       1, int_ftype_int,     clrsbsi2,      TARGET_NORM, attr_const)
+DEF_BUILTIN (NORMW,      1, int_ftype_short,   normw,         TARGET_NORM, attr_const)
+DEF_BUILTIN (SWAP,       1, int_ftype_int,     rotlsi2_cnt16, TARGET_SWAP, attr_const)
+DEF_BUILTIN (DIVAW,      2, int_ftype_int_int, divaw,         TARGET_EA_SET, NULL_TREE)
+DEF_BUILTIN (CORE_READ,  1, usint_ftype_usint, core_read,     1, NULL_TREE)
+DEF_BUILTIN (LR,         1, usint_ftype_usint, lr,            1, NULL_TREE)
+DEF_BUILTIN (FFS,        1, int_ftype_int,     ffs,           (TARGET_EM && TARGET_NORM) || TARGET_HS, attr_const)
+DEF_BUILTIN (FLS,        1, int_ftype_int,     fls,           (TARGET_EM && TARGET_NORM) || TARGET_HS, attr_const)
 
 /* ARC SIMD extenssion.  */
 /* BEGIN SIMD marker.  */
-DEF_BUILTIN (SIMD_BEGIN, 0, void_ftype_void, nothing, 0)
-
-DEF_BUILTIN ( VADDAW, 2, v8hi_ftype_v8hi_v8hi,  vaddaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VADDW, 2, v8hi_ftype_v8hi_v8hi,   vaddw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VAVB, 2, v8hi_ftype_v8hi_v8hi,    vavb_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VAVRB, 2, v8hi_ftype_v8hi_v8hi,   vavrb_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VDIFAW, 2, v8hi_ftype_v8hi_v8hi,  vdifaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VDIFW, 2, v8hi_ftype_v8hi_v8hi,   vdifw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMAXAW, 2, v8hi_ftype_v8hi_v8hi,  vmaxaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMAXW, 2, v8hi_ftype_v8hi_v8hi,   vmaxw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMINAW, 2, v8hi_ftype_v8hi_v8hi,  vminaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMINW, 2, v8hi_ftype_v8hi_v8hi,   vminw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMULAW, 2, v8hi_ftype_v8hi_v8hi,  vmulaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VMULFAW, 2, v8hi_ftype_v8hi_v8hi, vmulfaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMULFW, 2, v8hi_ftype_v8hi_v8hi,  vmulfw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMULW, 2, v8hi_ftype_v8hi_v8hi,   vmulw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VSUBAW, 2, v8hi_ftype_v8hi_v8hi,  vsubaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VSUBW, 2, v8hi_ftype_v8hi_v8hi,   vsubw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VSUMMW, 2, v8hi_ftype_v8hi_v8hi,  vsummw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VAND, 2, v8hi_ftype_v8hi_v8hi,    vand_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VANDAW, 2, v8hi_ftype_v8hi_v8hi,  vandaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VBIC, 2, v8hi_ftype_v8hi_v8hi,    vbic_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VBICAW, 2, v8hi_ftype_v8hi_v8hi,  vbicaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (    VOR, 2, v8hi_ftype_v8hi_v8hi,     vor_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VXOR, 2, v8hi_ftype_v8hi_v8hi,    vxor_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VXORAW, 2, v8hi_ftype_v8hi_v8hi,  vxoraw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VEQW, 2, v8hi_ftype_v8hi_v8hi,    veqw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VLEW, 2, v8hi_ftype_v8hi_v8hi,    vlew_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VLTW, 2, v8hi_ftype_v8hi_v8hi,    vltw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VNEW, 2, v8hi_ftype_v8hi_v8hi,    vnew_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMR1AW, 2, v8hi_ftype_v8hi_v8hi,  vmr1aw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMR1W, 2, v8hi_ftype_v8hi_v8hi,   vmr1w_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMR2AW, 2, v8hi_ftype_v8hi_v8hi,  vmr2aw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMR2W, 2, v8hi_ftype_v8hi_v8hi,   vmr2w_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMR3AW, 2, v8hi_ftype_v8hi_v8hi,  vmr3aw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMR3W, 2, v8hi_ftype_v8hi_v8hi,   vmr3w_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMR4AW, 2, v8hi_ftype_v8hi_v8hi,  vmr4aw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMR4W, 2, v8hi_ftype_v8hi_v8hi,   vmr4w_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMR5AW, 2, v8hi_ftype_v8hi_v8hi,  vmr5aw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMR5W, 2, v8hi_ftype_v8hi_v8hi,   vmr5w_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMR6AW, 2, v8hi_ftype_v8hi_v8hi,  vmr6aw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMR6W, 2, v8hi_ftype_v8hi_v8hi,   vmr6w_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMR7AW, 2, v8hi_ftype_v8hi_v8hi,  vmr7aw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMR7W, 2, v8hi_ftype_v8hi_v8hi,   vmr7w_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VMRB, 2, v8hi_ftype_v8hi_v8hi,    vmrb_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VH264F, 2, v8hi_ftype_v8hi_v8hi,  vh264f_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VH264FT, 2, v8hi_ftype_v8hi_v8hi, vh264ft_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VH264FW, 2, v8hi_ftype_v8hi_v8hi, vh264fw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VVC1F, 2, v8hi_ftype_v8hi_v8hi,   vvc1f_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VVC1FT, 2, v8hi_ftype_v8hi_v8hi,  vvc1ft_insn, TARGET_SIMD_SET)
-
-DEF_BUILTIN ( VBADDW, 2, v8hi_ftype_v8hi_int,  vbaddw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VBMAXW, 2, v8hi_ftype_v8hi_int,  vbmaxw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VBMINW, 2, v8hi_ftype_v8hi_int,  vbminw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VBMULAW, 2, v8hi_ftype_v8hi_int, vbmulaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VBMULFW, 2, v8hi_ftype_v8hi_int, vbmulfw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VBMULW, 2, v8hi_ftype_v8hi_int,  vbmulw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VBRSUBW, 2, v8hi_ftype_v8hi_int, vbrsubw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VBSUBW, 2, v8hi_ftype_v8hi_int,  vbsubw_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (SIMD_BEGIN, 0, void_ftype_void, nothing, 0, NULL_TREE)
+
+DEF_BUILTIN ( VADDAW, 2, v8hi_ftype_v8hi_v8hi,  vaddaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VADDW, 2, v8hi_ftype_v8hi_v8hi,   vaddw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VAVB, 2, v8hi_ftype_v8hi_v8hi,    vavb_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VAVRB, 2, v8hi_ftype_v8hi_v8hi,   vavrb_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VDIFAW, 2, v8hi_ftype_v8hi_v8hi,  vdifaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VDIFW, 2, v8hi_ftype_v8hi_v8hi,   vdifw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMAXAW, 2, v8hi_ftype_v8hi_v8hi,  vmaxaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMAXW, 2, v8hi_ftype_v8hi_v8hi,   vmaxw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMINAW, 2, v8hi_ftype_v8hi_v8hi,  vminaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMINW, 2, v8hi_ftype_v8hi_v8hi,   vminw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMULAW, 2, v8hi_ftype_v8hi_v8hi,  vmulaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VMULFAW, 2, v8hi_ftype_v8hi_v8hi, vmulfaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMULFW, 2, v8hi_ftype_v8hi_v8hi,  vmulfw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMULW, 2, v8hi_ftype_v8hi_v8hi,   vmulw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VSUBAW, 2, v8hi_ftype_v8hi_v8hi,  vsubaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VSUBW, 2, v8hi_ftype_v8hi_v8hi,   vsubw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VSUMMW, 2, v8hi_ftype_v8hi_v8hi,  vsummw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VAND, 2, v8hi_ftype_v8hi_v8hi,    vand_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VANDAW, 2, v8hi_ftype_v8hi_v8hi,  vandaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VBIC, 2, v8hi_ftype_v8hi_v8hi,    vbic_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VBICAW, 2, v8hi_ftype_v8hi_v8hi,  vbicaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (    VOR, 2, v8hi_ftype_v8hi_v8hi,     vor_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VXOR, 2, v8hi_ftype_v8hi_v8hi,    vxor_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VXORAW, 2, v8hi_ftype_v8hi_v8hi,  vxoraw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VEQW, 2, v8hi_ftype_v8hi_v8hi,    veqw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VLEW, 2, v8hi_ftype_v8hi_v8hi,    vlew_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VLTW, 2, v8hi_ftype_v8hi_v8hi,    vltw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VNEW, 2, v8hi_ftype_v8hi_v8hi,    vnew_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMR1AW, 2, v8hi_ftype_v8hi_v8hi,  vmr1aw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMR1W, 2, v8hi_ftype_v8hi_v8hi,   vmr1w_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMR2AW, 2, v8hi_ftype_v8hi_v8hi,  vmr2aw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMR2W, 2, v8hi_ftype_v8hi_v8hi,   vmr2w_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMR3AW, 2, v8hi_ftype_v8hi_v8hi,  vmr3aw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMR3W, 2, v8hi_ftype_v8hi_v8hi,   vmr3w_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMR4AW, 2, v8hi_ftype_v8hi_v8hi,  vmr4aw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMR4W, 2, v8hi_ftype_v8hi_v8hi,   vmr4w_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMR5AW, 2, v8hi_ftype_v8hi_v8hi,  vmr5aw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMR5W, 2, v8hi_ftype_v8hi_v8hi,   vmr5w_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMR6AW, 2, v8hi_ftype_v8hi_v8hi,  vmr6aw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMR6W, 2, v8hi_ftype_v8hi_v8hi,   vmr6w_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMR7AW, 2, v8hi_ftype_v8hi_v8hi,  vmr7aw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMR7W, 2, v8hi_ftype_v8hi_v8hi,   vmr7w_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VMRB, 2, v8hi_ftype_v8hi_v8hi,    vmrb_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VH264F, 2, v8hi_ftype_v8hi_v8hi,  vh264f_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VH264FT, 2, v8hi_ftype_v8hi_v8hi, vh264ft_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VH264FW, 2, v8hi_ftype_v8hi_v8hi, vh264fw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VVC1F, 2, v8hi_ftype_v8hi_v8hi,   vvc1f_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VVC1FT, 2, v8hi_ftype_v8hi_v8hi,  vvc1ft_insn, TARGET_SIMD_SET, NULL_TREE)
+
+DEF_BUILTIN ( VBADDW, 2, v8hi_ftype_v8hi_int,  vbaddw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VBMAXW, 2, v8hi_ftype_v8hi_int,  vbmaxw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VBMINW, 2, v8hi_ftype_v8hi_int,  vbminw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VBMULAW, 2, v8hi_ftype_v8hi_int, vbmulaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VBMULFW, 2, v8hi_ftype_v8hi_int, vbmulfw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VBMULW, 2, v8hi_ftype_v8hi_int,  vbmulw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VBRSUBW, 2, v8hi_ftype_v8hi_int, vbrsubw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VBSUBW, 2, v8hi_ftype_v8hi_int,  vbsubw_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* Va, Vb, Ic instructions.  */
-DEF_BUILTIN ( VASRW, 2, v8hi_ftype_v8hi_int,  vasrw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VSR8, 2, v8hi_ftype_v8hi_int,   vsr8_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VSR8AW, 2, v8hi_ftype_v8hi_int, vsr8aw_insn, TARGET_SIMD_SET)
+DEF_BUILTIN ( VASRW, 2, v8hi_ftype_v8hi_int,  vasrw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VSR8, 2, v8hi_ftype_v8hi_int,   vsr8_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VSR8AW, 2, v8hi_ftype_v8hi_int, vsr8aw_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* Va, Vb, u6 instructions.  */
-DEF_BUILTIN (  VASRRWi, 2, v8hi_ftype_v8hi_int,   vasrrwi_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VASRSRWi, 2, v8hi_ftype_v8hi_int,  vasrsrwi_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VASRWi, 2, v8hi_ftype_v8hi_int,    vasrwi_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VASRPWBi, 2, v8hi_ftype_v8hi_int,  vasrpwbi_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VASRRPWBi, 2, v8hi_ftype_v8hi_int, vasrrpwbi_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VSR8AWi, 2, v8hi_ftype_v8hi_int,   vsr8awi_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (    VSR8i, 2, v8hi_ftype_v8hi_int,     vsr8i_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (  VASRRWi, 2, v8hi_ftype_v8hi_int,   vasrrwi_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VASRSRWi, 2, v8hi_ftype_v8hi_int,  vasrsrwi_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VASRWi, 2, v8hi_ftype_v8hi_int,    vasrwi_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VASRPWBi, 2, v8hi_ftype_v8hi_int,  vasrpwbi_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VASRRPWBi, 2, v8hi_ftype_v8hi_int, vasrrpwbi_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VSR8AWi, 2, v8hi_ftype_v8hi_int,   vsr8awi_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (    VSR8i, 2, v8hi_ftype_v8hi_int,     vsr8i_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* Va, Vb, u8 (simm) instructions.  */
-DEF_BUILTIN (  VMVAW, 2, v8hi_ftype_v8hi_int,   vmvaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VMVW, 2, v8hi_ftype_v8hi_int,    vmvw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VMVZW, 2, v8hi_ftype_v8hi_int,   vmvzw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VD6TAPF, 2, v8hi_ftype_v8hi_int, vd6tapf_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (  VMVAW, 2, v8hi_ftype_v8hi_int,   vmvaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VMVW, 2, v8hi_ftype_v8hi_int,    vmvw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VMVZW, 2, v8hi_ftype_v8hi_int,   vmvzw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VD6TAPF, 2, v8hi_ftype_v8hi_int, vd6tapf_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* Va, rlimm, u8 (simm) instructions.  */
-DEF_BUILTIN (VMOVAW, 2, v8hi_ftype_int_int, vmovaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VMOVW, 2, v8hi_ftype_int_int,  vmovw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VMOVZW, 2, v8hi_ftype_int_int, vmovzw_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (VMOVAW, 2, v8hi_ftype_int_int, vmovaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VMOVW, 2, v8hi_ftype_int_int,  vmovw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VMOVZW, 2, v8hi_ftype_int_int, vmovzw_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* Va, Vb instructions.  */
-DEF_BUILTIN ( VABSAW, 1, v8hi_ftype_v8hi,  vabsaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VABSW, 1, v8hi_ftype_v8hi,   vabsw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VADDSUW, 1, v8hi_ftype_v8hi, vaddsuw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VSIGNW, 1, v8hi_ftype_v8hi,  vsignw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VEXCH1, 1, v8hi_ftype_v8hi,  vexch1_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VEXCH2, 1, v8hi_ftype_v8hi,  vexch2_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VEXCH4, 1, v8hi_ftype_v8hi,  vexch4_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VUPBAW, 1, v8hi_ftype_v8hi,  vupbaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VUPBW, 1, v8hi_ftype_v8hi,   vupbw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VUPSBAW, 1, v8hi_ftype_v8hi, vupsbaw_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VUPSBW, 1, v8hi_ftype_v8hi,  vupsbw_insn, TARGET_SIMD_SET)
+DEF_BUILTIN ( VABSAW, 1, v8hi_ftype_v8hi,  vabsaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VABSW, 1, v8hi_ftype_v8hi,   vabsw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VADDSUW, 1, v8hi_ftype_v8hi, vaddsuw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VSIGNW, 1, v8hi_ftype_v8hi,  vsignw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VEXCH1, 1, v8hi_ftype_v8hi,  vexch1_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VEXCH2, 1, v8hi_ftype_v8hi,  vexch2_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VEXCH4, 1, v8hi_ftype_v8hi,  vexch4_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VUPBAW, 1, v8hi_ftype_v8hi,  vupbaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VUPBW, 1, v8hi_ftype_v8hi,   vupbw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VUPSBAW, 1, v8hi_ftype_v8hi, vupsbaw_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VUPSBW, 1, v8hi_ftype_v8hi,  vupsbw_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* SIMD special DIb, rlimm, rlimm instructions.  */
-DEF_BUILTIN (VDIRUN, 2, void_ftype_int_int, vdirun_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VDORUN, 2, void_ftype_int_int, vdorun_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (VDIRUN, 2, void_ftype_int_int, vdirun_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VDORUN, 2, void_ftype_int_int, vdorun_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* SIMD special DIb, limm, rlimm instructions.  */
-DEF_BUILTIN (VDIWR, 2, void_ftype_int_int, vdiwr_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VDOWR, 2, void_ftype_int_int, vdowr_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (VDIWR, 2, void_ftype_int_int, vdiwr_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VDOWR, 2, void_ftype_int_int, vdowr_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* rlimm instructions.  */
-DEF_BUILTIN (   VREC, 1, void_ftype_int,    vrec_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (   VRUN, 1, void_ftype_int,    vrun_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VRECRUN, 1, void_ftype_int, vrecrun_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VENDREC, 1, void_ftype_int, vendrec_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (   VREC, 1, void_ftype_int,    vrec_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (   VRUN, 1, void_ftype_int,    vrun_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VRECRUN, 1, void_ftype_int, vrecrun_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VENDREC, 1, void_ftype_int, vendrec_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* Va, [Ib,u8] instructions.  */
-DEF_BUILTIN (VLD32WH, 3, v8hi_ftype_v8hi_int_int, vld32wh_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VLD32WL, 3, v8hi_ftype_v8hi_int_int, vld32wl_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VLD64, 3, v8hi_ftype_v8hi_int_int,   vld64_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (  VLD32, 3, v8hi_ftype_v8hi_int_int,   vld32_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (VLD32WH, 3, v8hi_ftype_v8hi_int_int, vld32wh_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VLD32WL, 3, v8hi_ftype_v8hi_int_int, vld32wl_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VLD64, 3, v8hi_ftype_v8hi_int_int,   vld64_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (  VLD32, 3, v8hi_ftype_v8hi_int_int,   vld32_insn, TARGET_SIMD_SET, NULL_TREE)
 
-DEF_BUILTIN (VLD64W, 2, v8hi_ftype_int_int,      vld64w_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VLD128, 2, v8hi_ftype_int_int,      vld128_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (VLD64W, 2, v8hi_ftype_int_int,      vld64w_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VLD128, 2, v8hi_ftype_int_int,      vld128_insn, TARGET_SIMD_SET, NULL_TREE)
 
-DEF_BUILTIN (VST128, 3, void_ftype_v8hi_int_int, vst128_insn, TARGET_SIMD_SET)
-DEF_BUILTIN ( VST64, 3, void_ftype_v8hi_int_int,  vst64_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (VST128, 3, void_ftype_v8hi_int_int, vst128_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN ( VST64, 3, void_ftype_v8hi_int_int,  vst64_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* Va, [Ib, u8] instructions.  */
-DEF_BUILTIN (VST16_N, 4, void_ftype_v8hi_int_int_int, vst16_n_insn, TARGET_SIMD_SET)
-DEF_BUILTIN (VST32_N, 4, void_ftype_v8hi_int_int_int, vst32_n_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (VST16_N, 4, void_ftype_v8hi_int_int_int, vst16_n_insn, TARGET_SIMD_SET, NULL_TREE)
+DEF_BUILTIN (VST32_N, 4, void_ftype_v8hi_int_int_int, vst32_n_insn, TARGET_SIMD_SET, NULL_TREE)
 
-DEF_BUILTIN (VINTI, 1, void_ftype_int, vinti_insn, TARGET_SIMD_SET)
+DEF_BUILTIN (VINTI, 1, void_ftype_int, vinti_insn, TARGET_SIMD_SET, NULL_TREE)
 
 /* END SIMD marker.  */
-DEF_BUILTIN (SIMD_END, 0, void_ftype_void, nothing, 0)
+DEF_BUILTIN (SIMD_END, 0, void_ftype_void, nothing, 0, NULL_TREE)
 
 /* ARCv2 SIMD instructions that use/clobber the accumulator reg.  */
-DEF_BUILTIN (QMACH,      2, long_ftype_v4hi_v4hi,   qmach,      TARGET_PLUS_QMACW)
-DEF_BUILTIN (QMACHU,     2, long_ftype_v4hi_v4hi,   qmachu,     TARGET_PLUS_QMACW)
-DEF_BUILTIN (QMPYH,      2, long_ftype_v4hi_v4hi,   qmpyh,      TARGET_PLUS_QMACW)
-DEF_BUILTIN (QMPYHU,     2, long_ftype_v4hi_v4hi,   qmpyhu,     TARGET_PLUS_QMACW)
+DEF_BUILTIN (QMACH,      2, long_ftype_v4hi_v4hi,   qmach,      TARGET_PLUS_QMACW, NULL_TREE)
+DEF_BUILTIN (QMACHU,     2, long_ftype_v4hi_v4hi,   qmachu,     TARGET_PLUS_QMACW, NULL_TREE)
+DEF_BUILTIN (QMPYH,      2, long_ftype_v4hi_v4hi,   qmpyh,      TARGET_PLUS_QMACW, NULL_TREE)
+DEF_BUILTIN (QMPYHU,     2, long_ftype_v4hi_v4hi,   qmpyhu,     TARGET_PLUS_QMACW, NULL_TREE)
 
-DEF_BUILTIN (DMACH,      2, int_ftype_v2hi_v2hi,    dmach,      TARGET_PLUS_DMPY)
-DEF_BUILTIN (DMACHU,     2, int_ftype_v2hi_v2hi,    dmachu,     TARGET_PLUS_DMPY)
-DEF_BUILTIN (DMPYH,      2, int_ftype_v2hi_v2hi,    dmpyh,      TARGET_PLUS_DMPY)
-DEF_BUILTIN (DMPYHU,     2, int_ftype_v2hi_v2hi,    dmpyhu,     TARGET_PLUS_DMPY)
+DEF_BUILTIN (DMACH,      2, int_ftype_v2hi_v2hi,    dmach,      TARGET_PLUS_DMPY, NULL_TREE)
+DEF_BUILTIN (DMACHU,     2, int_ftype_v2hi_v2hi,    dmachu,     TARGET_PLUS_DMPY, NULL_TREE)
+DEF_BUILTIN (DMPYH,      2, int_ftype_v2hi_v2hi,    dmpyh,      TARGET_PLUS_DMPY, NULL_TREE)
+DEF_BUILTIN (DMPYHU,     2, int_ftype_v2hi_v2hi,    dmpyhu,     TARGET_PLUS_DMPY, NULL_TREE)
 
-DEF_BUILTIN (DMACWH,     2, long_ftype_v2si_v2hi,   dmacwh,     TARGET_PLUS_QMACW)
-DEF_BUILTIN (DMACWHU,    2, long_ftype_v2si_v2hi,   dmacwhu,    TARGET_PLUS_QMACW)
+DEF_BUILTIN (DMACWH,     2, long_ftype_v2si_v2hi,   dmacwh,     TARGET_PLUS_QMACW, NULL_TREE)
+DEF_BUILTIN (DMACWHU,    2, long_ftype_v2si_v2hi,   dmacwhu,    TARGET_PLUS_QMACW, NULL_TREE)
 
-DEF_BUILTIN (VMAC2H,     2, v2si_ftype_v2hi_v2hi,   vmac2h,     TARGET_PLUS_MACD)
-DEF_BUILTIN (VMAC2HU,    2, v2si_ftype_v2hi_v2hi,   vmac2hu,    TARGET_PLUS_MACD)
-DEF_BUILTIN (VMPY2H,     2, v2si_ftype_v2hi_v2hi,   vmpy2h,     TARGET_PLUS_MACD)
-DEF_BUILTIN (VMPY2HU,    2, v2si_ftype_v2hi_v2hi,   vmpy2hu,    TARGET_PLUS_MACD)
+DEF_BUILTIN (VMAC2H,     2, v2si_ftype_v2hi_v2hi,   vmac2h,     TARGET_PLUS_MACD, NULL_TREE)
+DEF_BUILTIN (VMAC2HU,    2, v2si_ftype_v2hi_v2hi,   vmac2hu,    TARGET_PLUS_MACD, NULL_TREE)
+DEF_BUILTIN (VMPY2H,     2, v2si_ftype_v2hi_v2hi,   vmpy2h,     TARGET_PLUS_MACD, NULL_TREE)
+DEF_BUILTIN (VMPY2HU,    2, v2si_ftype_v2hi_v2hi,   vmpy2hu,    TARGET_PLUS_MACD, NULL_TREE)
 
 /* Combined add/sub HS SIMD instructions.  */
-DEF_BUILTIN (VADDSUB2H,  2, v2hi_ftype_v2hi_v2hi,   addsubv2hi3, TARGET_PLUS_DMPY)
-DEF_BUILTIN (VSUBADD2H,  2, v2hi_ftype_v2hi_v2hi,   subaddv2hi3, TARGET_PLUS_DMPY)
-DEF_BUILTIN (VADDSUB,    2, v2si_ftype_v2si_v2si,   addsubv2si3, TARGET_PLUS_QMACW)
-DEF_BUILTIN (VSUBADD,    2, v2si_ftype_v2si_v2si,   subaddv2si3, TARGET_PLUS_QMACW)
-DEF_BUILTIN (VADDSUB4H,  2, v4hi_ftype_v4hi_v4hi,   addsubv4hi3, TARGET_PLUS_QMACW)
-DEF_BUILTIN (VSUBADD4H,  2, v4hi_ftype_v4hi_v4hi,   subaddv4hi3, TARGET_PLUS_QMACW)
+DEF_BUILTIN (VADDSUB2H,  2, v2hi_ftype_v2hi_v2hi,   addsubv2hi3, TARGET_PLUS_DMPY, NULL_TREE)
+DEF_BUILTIN (VSUBADD2H,  2, v2hi_ftype_v2hi_v2hi,   subaddv2hi3, TARGET_PLUS_DMPY, NULL_TREE)
+DEF_BUILTIN (VADDSUB,    2, v2si_ftype_v2si_v2si,   addsubv2si3, TARGET_PLUS_QMACW, NULL_TREE)
+DEF_BUILTIN (VSUBADD,    2, v2si_ftype_v2si_v2si,   subaddv2si3, TARGET_PLUS_QMACW, NULL_TREE)
+DEF_BUILTIN (VADDSUB4H,  2, v4hi_ftype_v4hi_v4hi,   addsubv4hi3, TARGET_PLUS_QMACW, NULL_TREE)
+DEF_BUILTIN (VSUBADD4H,  2, v4hi_ftype_v4hi_v4hi,   subaddv4hi3, TARGET_PLUS_QMACW, NULL_TREE)
-- 
2.34.1

