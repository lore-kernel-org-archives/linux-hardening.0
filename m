Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42DB2FD67D
	for <linux-hardening@vger.kernel.org>; Sat, 10 Oct 2026 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608753; cv=none; b=i2R9+tJ/0WNlHDZ8gqjK/EV0mZ9ww4lsemr21npceB0QjnesZkZDWNx07n0mT3tzz+c7oRRjrjbiuCfpo4OBWedbjh0Gxv5LjJQvruoDAu59fBADEXoie0SeNW/bEpp4l+3w1Mg2+DspWoUrAPQBX+GkaRh7CdgUAb80/JFiDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608753; c=relaxed/simple;
	bh=xwR2PsdGAG8E8NORStEHNj7XDBZNGFyY7NmpnI2sW7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTTDq4TsHR79YXv3483+a3Q10GDAY0ZYWlukXs3TRXMcuKzeNTx+6igC+cZUeBmIk7Iol/rRSX8Jaa5hYoHfI/6N+3Dp2SwNrq6AiG5n4CX/e5mKojxuwvojiXW/Ykf8JOCo7XEnisDFNZOmp9NYu8d8N2hgZ4PeDOc2zP5jhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQqFHt4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQqFHt4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471541F000FF;
	Sat, 10 Oct 2026 05:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791608751;
	bh=jsoSoP7dqeVgfz6J4kVAvw67dyzfbJzAY6oYKh2JoFQ=;
	h=From:To:Cc:Subject:Date;
	b=dQqFHt4TqPddt0pTtEsd9XswOOzfbvuuCODJeqsIu/Qicms4zWc6tOFBLUio66yGy
	 QXr6k2/P/EqKJbooF1O3JLQLsvrirufOpH4wLKItJ/7Fo147zFWdqkYR9UaU1DcaQb
	 hiWyrn+Vle/Kv17wGjfzEYOkcRzdFZNtPzhIxGtX4pK7vXZUA8tEcw8teSER1evzso
	 xSHnDJ3Ufdr5Y1JBqhaT6u0juA2QvBDk1IZmOJpVpvK8rd6xVKnvfR+Pwzo0rEnPHb
	 N3tT8d8o8XgHS1j4CvbKuFwdtJh4D9wxMNmLVRlvHsfM/GEJK8vdV7g2mgNJT6HUj3
	 f26fAa7okLHEw==
From: Kees Cook <kees@kernel.org>
To: Jan Hubicka <hubicka@ucw.cz>
Cc: Kees Cook <kees@kernel.org>,
	Richard Biener <rguenther@suse.de>,
	Martin Jambor <mjambor@suse.cz>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ipa-icf: Compare access path type sizes without TBAA [PR105438]
Date: Fri,  9 Oct 2026 22:05:45 -0700
Message-ID: <20261010050537.i.784-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14580; i=kees@kernel.org; h=from:subject:message-id; bh=xwR2PsdGAG8E8NORStEHNj7XDBZNGFyY7NmpnI2sW7k=; b=owGbwMvMwCVmps19z/KJym7G02pJDFknj69Mz1k309ao27q7eObDdY+5X9l/9wnU6F7B+nfyz B3HuNtOdpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzk+QGG//H+Bmlpd1daz2Ur q1uyKd/ItPKT6Udpl+UcVzpsd2yasZuR4cw6z+AjKxZHRL1d2f6G7fSRMu/OuN6Vip+XPPi1St4 3kQUA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With -fno-strict-aliasing, IPA ICF merges functions that copy the same
fields between two struct types of different sizes, and the merged body,
inlined at the other function's call sites, can trip diagnostics like
-Warray-bounds:

    struct small { char pad[16]; int a; unsigned int b, c; };
    struct big   { char pad[16]; int a; unsigned int b, c; int extra; };

    void small_to_big (struct big *dst, const struct small *src)
    {
      dst->a = src->a;
      ...
    }

    void big_to_small (struct small *dst, const struct big *src)
    {
      dst->a = src->a;
      ...
    }

    void f (struct big *p)
    {
      struct small tmp;

      big_to_small (&tmp, p);
      ...
    }

    In function 'small_to_big', inlined from 'f' at t.c:22:3:
    warning: array subscript 'struct big[0]' is partly outside array bounds of 'struct small[1]' [-Warray-bounds=]

Without TBAA, compare those sizes at each level of the path, so we don't
see mismatched sizes on a merged body.  Require the same tree codes at
each level too, as the TBAA comparison does, and array members of the
same kind: -Warray-bounds treats an array member that ends its object as
possibly flexible, so "int arr[1]" at the end of one struct and in the
middle of another, at the same offset in structs of the same size, must
not merge either.  The sizes are compared with ICF's operand_equal_p, so
those of variably modified types, which refer to each function's own
decls, still match.  Functions accessing distinct types of the same
layout still merge, as gcc.dg/lto/pr113359-*.c tests expect.

The Linux kernel (which uses -fno-strict-aliasing) hit this with GCC 16 in
net/ipv6/ip6_tunnel.c: ip6_tnl_parm_from_user() and ip6_tnl_parm_to_user()
copy the same fields between struct ip6_tnl_parm and the larger struct
__ip6_tnl_parm in opposite directions. This was only seen on m68k,
parisc, arc, xtensa, and openrisc.  Those functions also memcpy a char
array member, and since r17-4004 (PR119006) ICF compares the fields in
those addresses and keeps the two apart, but functions that copy only
the scalar fields (as Linux is) still merged.

The stricter comparison doesn't cost merges in the kernel code I
measured: across the 636 objects of net/ipv6, fs/ext4, kernel, and mm in
an x86 allmodconfig build, none of the 1569 ICF merges is between
accesses whose sizes or array kinds differ, so the count and the text
size are the same with and without this change.

This turned out to match PR105438, but on trunk (with -fstrict-aliasing)
the access path comparison refused the merge. But with -fno-strict-aliasing
it was exposed.  (Its testcase also now needed -fno-early-inlining, or both
instantiations were inlined before ICF runs.)

Assisted-by: LLM [tests]

gcc/ChangeLog:

	PR ipa/105438
	* tree-ssa-alias.cc (ao_compare::compare_ao_refs): Without TBAA,
	compare the tree codes, the sizes of the types, and the kinds of
	array members along the access paths.

gcc/testsuite/ChangeLog:

	PR ipa/105438
	* g++.dg/ipa/pr105438.C: New test.
	* gcc.dg/ipa/ipa-icf-41.c: New test.
	* gcc.dg/ipa/ipa-icf-42.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
I tried to copy neighboring style. I don't like "while (true)", but that
seemed to be idiomatic?
---
 gcc/testsuite/g++.dg/ipa/pr105438.C   | 33 ++++++++++++
 gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c | 73 ++++++++++++++++++++++++++
 gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c | 75 +++++++++++++++++++++++++++
 gcc/tree-ssa-alias.cc                 | 34 +++++++++++-
 4 files changed, 213 insertions(+), 2 deletions(-)
 create mode 100644 gcc/testsuite/g++.dg/ipa/pr105438.C
 create mode 100644 gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c
 create mode 100644 gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c

diff --git a/gcc/testsuite/g++.dg/ipa/pr105438.C b/gcc/testsuite/g++.dg/ipa/pr105438.C
new file mode 100644
index 000000000000..45daece51abf
--- /dev/null
+++ b/gcc/testsuite/g++.dg/ipa/pr105438.C
@@ -0,0 +1,33 @@
+// PR ipa/105438
+// { dg-do compile }
+// { dg-options "-O2 -fno-strict-aliasing -fno-early-inlining -Warray-bounds -fdump-ipa-icf-optimized" }
+
+// With -fno-strict-aliasing, IPA ICF merged configure<7> and configure<2>,
+// whose accesses through IN differ only in the bound of the array type,
+// and the merged body, inlined for the call with SHORTER, read it as a
+// const int[7].  (-fno-early-inlining keeps the instantiations from being
+// inlined into main before ICF runs.)
+
+int longer[7] = {};
+int shorter[2] = {};
+int out[10] = {};
+
+template <int N>
+void configure(const int(&in)[N], const int nrows = N)
+{
+    if (nrows <= 10)
+    {
+        for (int i = 0; i < nrows; i++)
+        {
+            out[i] = in[i];	// { dg-bogus "outside array bounds" }
+        }
+    }
+}
+
+int main()
+{
+  configure(longer);
+  configure(shorter);
+}
+
+// { dg-final { scan-ipa-dump-not "Semantic equality hit" "icf" } }
diff --git a/gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c b/gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c
new file mode 100644
index 000000000000..64bf871de0f8
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/ipa/ipa-icf-41.c
@@ -0,0 +1,73 @@
+/* Verify that with -fno-strict-aliasing, IPA ICF doesn't merge functions
+   whose memory accesses go through types of different sizes, which would
+   put one function's types into the other's inlined copies, and that it
+   still merges functions whose accesses go through the same types, or
+   through distinct types of the same layout.
+   { dg-do compile }
+   { dg-options "-O2 -fno-strict-aliasing -fno-early-inlining -Warray-bounds -fdump-ipa-icf-optimized" } */
+
+struct small { char pad[16]; int a; unsigned int b, c; };
+struct big { char pad[16]; int a; unsigned int b, c; int extra; };
+struct small_twin { char pad[16]; int a; unsigned int b, c; };
+
+/* Not merged: the same offsets, but through types of different sizes.
+   Merged, the call to big_to_small in f would get small_to_big's body,
+   which stores to TMP through a "struct big *".  */
+
+void small_to_big (struct big *dst, const struct small *src)
+{
+  dst->a = src->a;	/* { dg-bogus "outside array bounds" } */
+  dst->b = src->b;	/* { dg-bogus "outside array bounds" } */
+  dst->c = src->c;	/* { dg-bogus "outside array bounds" } */
+}
+
+void big_to_small (struct small *dst, const struct big *src)
+{
+  dst->a = src->a;
+  dst->b = src->b;
+  dst->c = src->c;
+}
+
+void f (struct big *p)
+{
+  struct small tmp;
+
+  big_to_small (&tmp, p);
+  small_to_big (p, &tmp);
+}
+
+/* Merged: the same types.  */
+
+void big_to_big_1 (struct big *dst, const struct big *src)
+{
+  dst->a = src->a;
+  dst->b = src->b;
+  dst->c = src->c;
+}
+
+void big_to_big_2 (struct big *dst, const struct big *src)
+{
+  dst->a = src->a;
+  dst->b = src->b;
+  dst->c = src->c;
+}
+
+/* Merged: distinct types of the same layout.  */
+
+void small_to_twin (struct small_twin *dst, const struct small *src)
+{
+  dst->a = src->a;
+  dst->b = src->b;
+  dst->c = src->c;
+}
+
+void twin_to_small (struct small *dst, const struct small_twin *src)
+{
+  dst->a = src->a;
+  dst->b = src->b;
+  dst->c = src->c;
+}
+
+/* { dg-final { scan-ipa-dump-not {Semantic equality hit:[^\n]*(small_to_big|big_to_small)/} "icf" } } */
+/* { dg-final { scan-ipa-dump {Semantic equality hit:big_to_big_[12]/[0-9]+->big_to_big_[12]/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump {Semantic equality hit:(small_to_twin|twin_to_small)/[0-9]+->(small_to_twin|twin_to_small)/[0-9]+} "icf" } } */
diff --git a/gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c b/gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c
new file mode 100644
index 000000000000..cb6a0ab9fdc3
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/ipa/ipa-icf-42.c
@@ -0,0 +1,75 @@
+/* Verify that with -fno-strict-aliasing, IPA ICF compares each level of
+   an access path, not just its base: an array element against a scalar
+   member, a nested size mismatch, an array member that ends its object
+   against one that doesn't, and a flexible array member against a
+   zero-length one keep functions apart, while
+   flexible array members of the same layout, and identical functions
+   accessing variably modified types, still merge.
+   { dg-do compile }
+   { dg-options "-O2 -fno-strict-aliasing -fdump-ipa-icf-details" } */
+
+/* ICF hashes memory accesses with their alias sets even with
+   -fno-strict-aliasing, so functions accessing distinct structs would
+   not get the same hash and would never be compared.  may_alias gives
+   each struct alias set 0, so each pair below is compared, which the
+   "Equals called for" scans check, along with the reason for each
+   refusal.  */
+
+#define MA __attribute__ ((may_alias))
+
+/* Not merged: the stores are to the same offset and size, but one is to
+   an array element and the other to a scalar member, so the access
+   paths have different tree codes.  (The tree code of a load is part of
+   ICF's hash, so a load would not be compared.)  */
+
+struct MA c1 { int tag[2]; int x[1]; int y; };
+struct MA c2 { int tag[2]; int x; int y; };
+
+void codes_1 (struct c1 *dst, int v) { dst->x[0] = v; }
+void codes_2 (struct c2 *dst, int v) { dst->x = v; }
+
+/* Not merged: the outer structs are the same size, but the structs
+   holding A are 16 and 8 bytes.  */
+
+struct MA n1 { struct { int a; int pad[3]; } in; int t[1]; };
+struct MA n2 { struct { int a; int pad; } in; int t[3]; };
+
+void nested_1 (struct n1 *dst, const struct n1 *src) { dst->in.a = src->in.a; }
+void nested_2 (struct n2 *dst, const struct n2 *src) { dst->in.a = src->in.a; }
+
+/* Not merged: both structs are 16 bytes, but ARR ends struct t1, so it
+   may be a flexible array, and not struct t2.  */
+
+struct MA __attribute__ ((aligned (16))) t1 { int tag; int arr[1]; };
+struct MA __attribute__ ((aligned (16))) t2 { int tag; int arr[1]; int x; };
+
+void trailing_1 (struct t1 *dst, const struct t1 *src) { dst->arr[0] = src->arr[0]; }
+void trailing_2 (struct t2 *dst, const struct t2 *src) { dst->arr[0] = src->arr[0]; }
+
+/* Merged: flexible array members, whose types have no size.  Not merged:
+   either of those and a zero-length array.  */
+
+struct MA f1 { int tag; int arr[]; };
+struct MA f2 { int tag; int arr[]; };
+struct MA z { int tag; int arr[0]; };
+
+void flex_1 (struct f1 *dst, const struct f1 *src, int i) { dst->arr[i] = src->arr[i]; }
+void flex_2 (struct f2 *dst, const struct f2 *src, int i) { dst->arr[i] = src->arr[i]; }
+void zero_len (struct z *dst, const struct z *src, int i) { dst->arr[i] = src->arr[i]; }
+
+/* Merged: the sizes of variably modified types refer to each function's
+   own parameters.  */
+
+void vla_1 (int n, int (*p)[n], int i) { p[i][1] = 1; p[i][2] = 2; }
+void vla_2 (int n, int (*p)[n], int i) { p[i][1] = 1; p[i][2] = 2; }
+
+/* Each refusal is logged as its reason, a few more lines, and then the
+   pair compared; match the reason and the pair with no other comparison
+   between them.  */
+/* { dg-final { scan-ipa-dump {access path difference\)'[^\n]*\n(?:(?!Equals called)[^\n]*\n)*Equals called for: codes_[12]/[0-9]+:codes_[12]/[0-9]+ with result: false} "icf" } } */
+/* { dg-final { scan-ipa-dump {access path difference\)'[^\n]*\n(?:(?!Equals called)[^\n]*\n)*Equals called for: nested_[12]/[0-9]+:nested_[12]/[0-9]+ with result: false} "icf" } } */
+/* { dg-final { scan-ipa-dump {access path difference\)'[^\n]*\n(?:(?!Equals called)[^\n]*\n)*Equals called for: trailing_[12]/[0-9]+:trailing_[12]/[0-9]+ with result: false} "icf" } } */
+/* { dg-final { scan-ipa-dump {access path difference\)'[^\n]*\n(?:(?!Equals called)[^\n]*\n)*Equals called for: (zero_len/[0-9]+:flex_[12]|flex_[12]/[0-9]+:zero_len)/[0-9]+ with result: false} "icf" } } */
+/* { dg-final { scan-ipa-dump {Semantic equality hit:flex_[12]/[0-9]+->flex_[12]/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump {Semantic equality hit:vla_[12]/[0-9]+->vla_[12]/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump-not {Semantic equality hit:[^\n]*(codes_|nested_|trailing_|zero_len)} "icf" } } */
diff --git a/gcc/tree-ssa-alias.cc b/gcc/tree-ssa-alias.cc
index a8196d116355..2f3d7f523a02 100644
--- a/gcc/tree-ssa-alias.cc
+++ b/gcc/tree-ssa-alias.cc
@@ -4262,7 +4262,9 @@ types_equal_for_same_type_for_tbaa_p (tree type1, tree type2)
 /* Compare REF1 and REF2 and return flags specifying their differences.
    If LTO_STREAMING_SAFE is true do not use alias sets and canonical
    types that are going to be recomputed.
-   If TBAA is true also compare TBAA metadata.  */
+   If TBAA is true also compare TBAA metadata, and otherwise only the
+   shape of the access paths: the tree codes along them, the sizes of
+   their types, and the kind of each array member.  */
 
 int
 ao_compare::compare_ao_refs (ao_ref *ref1, ao_ref *ref2,
@@ -4379,8 +4381,36 @@ ao_compare::compare_ao_refs (ao_ref *ref1, ao_ref *ref2,
 	  || (MR_DEPENDENCE_BASE (rbase1) != MR_DEPENDENCE_BASE (rbase2))))
     flags |= DEPENDENCE_CLIQUE;
 
+  /* Without TBAA, the types along the access paths don't matter for
+     aliasing, but other consumers read their sizes (e.g. ranger
+     diagnostics like -Warray-bounds).  Require the same tree codes at
+     each level, with sizes that match and array members of the same
+     kind, so the references of a merged function are valid for the
+     callers of both.  The types themselves may differ, so functions
+     accessing distinct but identically laid out types still merge.  */
   if (!tbaa)
-    return flags;
+    {
+      tree c1 = ref1->ref, c2 = ref2->ref;
+      while (true)
+	{
+	  if (TREE_CODE (c1) != TREE_CODE (c2))
+	    return flags | ACCESS_PATH;
+	  tree size1 = TYPE_SIZE (TREE_TYPE (c1));
+	  tree size2 = TYPE_SIZE (TREE_TYPE (c2));
+	  if (size1 && size2
+	      ? !operand_equal_p (size1, size2, 0)
+	      : size1 != size2)
+	    return flags | ACCESS_PATH;
+	  if (TREE_CODE (c1) == COMPONENT_REF
+	      && component_ref_sam_type (c1) != component_ref_sam_type (c2))
+	    return flags | ACCESS_PATH;
+	  if (!handled_component_p (c1))
+	    break;
+	  c1 = TREE_OPERAND (c1, 0);
+	  c2 = TREE_OPERAND (c2, 0);
+	}
+      return flags;
+    }
 
   /* Alias sets are not stable across LTO sreaming; be conservative here
      and compare types the alias sets are ultimately based on.  */
-- 
2.55.0

