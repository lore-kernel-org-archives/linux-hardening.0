Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE441A56F
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433390; cv=none; b=sMyFDasU00pNhCYBZ2e9a+kbdGNxfRgoEJbhIrtIVenSwCZw9rWuII3TyQtwXd8exhockcJVudY62NqbDyw9fBcg3cbzeiO3OC2925k1199vUrMoJlPfvtdcDiiedYJjN6fXu+sT7fMNfThuvBlbT2Qf6u+ELpDmUUE5jGbc74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433390; c=relaxed/simple;
	bh=McYGF25kbK7AMgfufk8shA9jaV6/zQQ0wSrBPDqfbuw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jfGhhOKJm7ryRI2462uJhzOWr8Eq+ZrrJ/37SGE80OsK5m/inLNnonquDDW19XzvznATAKycUcYG0HCGZ9Wdz0Ck3BNE6+hpovEzcpnr56psBghgu5TkcCkPnAph9wfWie1vtL/gi/6qcIT5wO/4JKNHMSVJQVQejviKC54Fwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473AA1F000E9;
	Thu,  3 Sep 2026 11:03:06 +0000 (UTC)
Date: Thu, 3 Sep 2026 20:02:20 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Jakub Jelinek <jakub@redhat.com>,
	Richard Biener <richard.guenther@gmail.com>,
	Siddhesh Poyarekar <siddhesh@gotplt.org>,
	Kees Cook <kees@kernel.org>
Cc: gcc-patches@gcc.gnu.org, Martin Uecker <uecker@tugraz.at>,
	josmyers@redhat.com, Bill Wendling <morbo@google.com>,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v2] tree-object-size: Fix type-1 size for FAM subobjects
 under -fstrict-flex-arrays=3 [PR126975]
Message-ID: <apomrLZp1ee3NnBF@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For a pointer to a subobject whose record/union type ends in a flexible-array
member (directly, or through a trailing nested struct), addr_object_size()
walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
measuring the referenced subobject.  __builtin_object_size() and
__builtin_dynamic_object_size() type 1 therefore returned the whole-object
size, collapsing type 1 onto type 0 and losing the distinction between
&p->inner and p.  FORTIFY_SOURCE relies on the type-1 distinction, so this
weakens its bounds checks.

Fix this by computing the size directly from the referenced record/union
instead of walking up, under -fstrict-flex-arrays=3 specifically to avoid
conflicting with -fstrict-flex-arrays semantics at lower levels, thereby
restoring the type-0/type-1 distinction that Clang already implements.

Bootstrapped and regtested on x86_64-linux-gnu.

Changes in v2:
 - Change behavior under -fstrict-flex-arrays=3 only.
 - Update subject line and changelog text.
 - Document the new type-1 behavior in extend.texi.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aojDH2Db6XIkVqcf@kspp/

	PR tree-optimization/126975

gcc/ChangeLog:

	* tree-object-size.cc (addr_object_size): For a reference to a
	record or union type that recursively includes a flexible-array
	member, compute the object size from the referenced subobject
	instead of walking up to the enclosing object when
	-fstrict-flex-arrays=3 is in effect.
	* doc/extend.texi (__builtin_object_size): Document the type-1
	behavior for pointers to subobjects that end in a flexible array
	member, and its interaction with -fstrict-flex-arrays=3.

gcc/testsuite/ChangeLog:

	* gcc.dg/builtin-object-size-pr126975.c: New test.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 gcc/doc/extend.texi                           | 32 +++++++++++++
 .../gcc.dg/builtin-object-size-pr126975.c     | 45 +++++++++++++++++++
 gcc/tree-object-size.cc                       |  7 ++-
 3 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/builtin-object-size-pr126975.c

diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
index 397b05ab87d..30fdc702f13 100644
--- a/gcc/doc/extend.texi
+++ b/gcc/doc/extend.texi
@@ -17894,6 +17894,38 @@ assert (__builtin_object_size (q, 0)
 /* The subobject q points to is var.b.  */
 assert (__builtin_object_size (q, 1) == sizeof (var.b));
 @end smallexample
+
+When, for @var{type} 1, the closest surrounding subobject is of a
+@code{struct} or @code{union} type that ends in a flexible array
+(@pxref{Zero Length,,Arrays of Length Zero}), either directly or through a
+trailing nested struct, that subobject can be extended past its declared
+size.  Its size is therefore constrained only by the enclosing complete
+object, as it is for @var{type} 0.
+
+Under @option{-fstrict-flex-arrays=3}, where only a true C99
+flexible array member is treated as a flexible array, the declared size of
+the referenced subobject is used instead, which restores the distinction
+between @var{type} 0 and @var{type} 1 for such pointers.
+
+@smallexample
+/* Compiled with -fstrict-flex-arrays=3.  */
+struct A @{ int n; char data[]; @};
+struct B @{ int m; struct A a; @};
+struct B *b = malloc (sizeof (struct B) + 48);
+struct B *volatile vp = malloc (sizeof (struct B) + 48);
+struct B *op = vp;
+
+/* &b->a ends in a flexible array member, but -fstrict-flex-arrays=3 makes
+   type 1 its declared size, not the whole-object (type 0) size.  */
+assert (__builtin_object_size (&b->a, 1) == sizeof (b->a));
+/* Likewise when op is opaque, where type 0 would be (size_t) -1.  */
+assert (__builtin_object_size (&op->a, 1) == sizeof (op->a));
+
+/* For a pointer to the flexible array member itself, type 0 and type 1
+   both return (size_t) -1 here.  */
+assert (__builtin_object_size (op->a.data, 0) == (size_t) -1);
+assert (__builtin_object_size (op->a.data, 1) == (size_t) -1);
+@end smallexample
 @enddefbuiltin
 
 @defbuiltin{{size_t} __builtin_dynamic_object_size (const void * @var{ptr}, int @var{type})}
diff --git a/gcc/testsuite/gcc.dg/builtin-object-size-pr126975.c b/gcc/testsuite/gcc.dg/builtin-object-size-pr126975.c
new file mode 100644
index 00000000000..c8c60c4f76e
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/builtin-object-size-pr126975.c
@@ -0,0 +1,45 @@
+/* PR 126975:
+   Under -fstrict-flex-arrays=3 only a true C99 flexible-array member is
+   treated as flexible. For &subobject whose type ends in such a member,
+   __builtin_object_size/__builtin_dynamic_object_size type 1 must measure
+   the subobject, not the tail of the allocation (type 0). */
+/* { dg-do run } */
+/* { dg-options "-O2 -fstrict-flex-arrays=3" } */
+
+#include "builtin-object-size-common.h"
+
+struct flex {
+  size_t count;
+  char fam[];
+};
+
+struct outer {
+  int hdr;
+  struct flex inner;
+};
+
+int main (void)
+{
+  struct outer *p = __builtin_malloc (sizeof(*p) + 48);
+  struct outer *volatile vp = __builtin_malloc (sizeof(*vp) + 48);
+  struct outer *op = vp;
+
+  /* True C99 flexible-array member: type 1 measures the subobject. */
+  EXPECT(__builtin_object_size(&p->inner, 1), sizeof(p->inner));
+  EXPECT(__builtin_dynamic_object_size(&p->inner, 1), sizeof(p->inner));
+
+  /* Type 0 still reports the whole tail of the allocation. */
+  EXPECT(__builtin_object_size(&p->inner, 0), sizeof(p->inner) + 48);
+  EXPECT(__builtin_dynamic_object_size(&p->inner, 0), sizeof(p->inner) + 48);
+
+  /* When op is opaque, type 0 is unknown (-1), but type 1 still measures
+     the subobject. */
+  EXPECT(__builtin_object_size(&op->inner, 0), -1);
+  EXPECT(__builtin_object_size(&op->inner, 1), sizeof(op->inner));
+  EXPECT(__builtin_dynamic_object_size(&op->inner, 1), sizeof(op->inner));
+
+  __builtin_free (p);
+  __builtin_free (op);
+
+  DONE ();
+}
diff --git a/gcc/tree-object-size.cc b/gcc/tree-object-size.cc
index 54c320d36d0..90d2ac32614 100644
--- a/gcc/tree-object-size.cc
+++ b/gcc/tree-object-size.cc
@@ -734,10 +734,13 @@ addr_object_size (struct object_size_info *osi, const_tree ptr,
 		      }
 		    /* if the ref is to a record or union type, but the type
 		       does not include a flexible array recursively, compute
-		       the object size directly.  */
+		       the object size directly.  With -fstrict-flex-arrays=3 do
+		       the same even when it does, so type 1 measures the subobject
+		       instead of collapsing onto the whole-object type-0 size.  */
 		    if (RECORD_OR_UNION_TYPE_P (TREE_TYPE (v)))
 		      {
-			if (!TYPE_INCLUDES_FLEXARRAY (TREE_TYPE (v)))
+			if (!TYPE_INCLUDES_FLEXARRAY (TREE_TYPE (v))
+			    || flag_strict_flex_arrays == 3)
 			  {
 			    v = NULL_TREE;
 			    break;
-- 
2.47.3

