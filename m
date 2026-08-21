Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31D411F88
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293784; cv=none; b=SVTnbmIecEDOwErPJW99+mE6atQ90RYnTJhTRpssj0+747xJTGOuya0HmaW/nEE8DWD+oqr66IHUKzpUQHAwdDZ3ZGkcV0Jb688W8NXCeOTERx7t7CrRE9/txgJ7ssSbV/vfi6vZLGLpoNHjUVYbcyGKks1nNo2+yohCho2ho6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293784; c=relaxed/simple;
	bh=yyy9xEwnmfOywjkRCBQZitYUbw411H9LZqUw5FRJemU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QUKlwy3hsje6gCuIGnMIXnVvOBVbKZu5hGfecDw8X4IuUzj5B8ov6zCUSfechSV8EHDoz86PCielfos9OlGwA//Za+xUL5qJiBfUqOklpCl2bRhafHXqJM5SA77QBPJmAyfDS6QpEWVLci6v5qQvtL9y+UbVfmKH+U0OeZGXqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBNbh/by; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBNbh/by"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4200E1F000E9;
	Fri, 21 Aug 2026 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787293782;
	bh=ZobDin0qj1+R6o6+t5mmNT6RplrFR1dU0S4A+a7iMAg=;
	h=Date:From:To:Cc:Subject;
	b=YBNbh/byTv3lC9+fOJX44HV/hwQdyXJKcoENGFwKNw86RnRIYgAVlgeQOuyoKMakf
	 dSJW09qarcJRVZMHtD4ZzDFRxC9tk6SXdGZecbIALUtYYq16ryYXiiV/by9JXC/+En
	 gCCxQmviwl0FBxJpmdWM+68au0YVnskR1Zp83/u56SqnqHXvf1QIqixjAPEbiNlJM9
	 5IwonZvWVqJa/AKtxly6XnKEvRUfdw4zoaI2AzRSQRfPCBmSUN8YYomzgXw5X+wLCZ
	 WJeUwjT4nGRLSzOQCGdTyOSxtu1KtFKWSSGKuAQJuvSxg5oUCM61pa39MOG1ftA9+V
	 CJMmJfsRyChKA==
Date: Fri, 21 Aug 2026 15:29:03 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jakub Jelinek <jakub@redhat.com>,
	Siddhesh Poyarekar <siddhesh@gotplt.org>,
	Kees Cook <kees@kernel.org>
Cc: gcc-patches@gcc.gnu.org, Martin Uecker <uecker@tugraz.at>,
	josmyers@redhat.com, Bill Wendling <morbo@google.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] tree-object-size: Fix type-1 size for pointers to
 FAM-containing subobjects [PR126975]
Message-ID: <aojDH2Db6XIkVqcf@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For a pointer to a subobject whose record/union type ends in a flexible-array
member (directly, or through its trailing nested struct), addr_object_size()
walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
measuring the referenced subobject. __builtin_object_size() and
__builtin_dynamic_object_size() type 1 therefore returned the whole-object
size, collapsing type 1 onto type 0 and losing the distinction between
&p->inner and p. FORTIFY_SOURCE relies on the type-1 distinction, so this
weakens its bounds checks.

Fix this by computing the size directly from the referenced record/union
instead of walking up, restoring the type-0/type-1 distinction that Clang
already implements.

Bootstraped and regtested on x86_64-linux-gnu.

	PR tree-optimization/126975

gcc/ChangeLog:

	* tree-object-size.cc (addr_object_size): For a reference to a
	record or union type, compute the object size from the referenced
	subobject instead of walking up to the enclosing object when the
	type recursively includes a flexible array member.

gcc/testsuite/ChangeLog:

	* gcc.dg/builtin-object-size-pr101832.c (main): Update the expected
	results of __builtin_object_size (..., 1) queries on subobjects
	whose type contains a flexible array member.
---
 .../gcc.dg/builtin-object-size-pr101832.c      |  6 +++---
 gcc/tree-object-size.cc                        | 18 +++++-------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
index 60078e11634..d76286ae454 100644
--- a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
+++ b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
@@ -92,9 +92,9 @@ int main (int argc, char *argv[])
   outer = (void *)magic1;
   outest = (void *)magic2;
 
-  expect (__builtin_object_size (&outer->a, 1), -1);
-  expect (__builtin_object_size (&outest->b, 1), -1);
-  expect (__builtin_object_size (&outest->b.a, 1), -1);
+  expect (__builtin_object_size (&outer->a, 1), sizeof(outer->a));
+  expect (__builtin_object_size (&outest->b, 1), sizeof(outest->b));
+  expect (__builtin_object_size (&outest->b.a, 1), sizeof(outest->b.a));
 
   struct B0 *outer0;
   struct C0 *outest0;
diff --git a/gcc/tree-object-size.cc b/gcc/tree-object-size.cc
index 54c320d36d0..5c8b4ee7862 100644
--- a/gcc/tree-object-size.cc
+++ b/gcc/tree-object-size.cc
@@ -732,21 +732,13 @@ addr_object_size (struct object_size_info *osi, const_tree ptr,
 			v = NULL_TREE;
 			break;
 		      }
-		    /* if the ref is to a record or union type, but the type
-		       does not include a flexible array recursively, compute
-		       the object size directly.  */
+		    /* If the ref is to a record or union type, compute the
+		       object size directly, regardless of whether the type
+		       recursively includes a flexible array member.  */
 		    if (RECORD_OR_UNION_TYPE_P (TREE_TYPE (v)))
 		      {
-			if (!TYPE_INCLUDES_FLEXARRAY (TREE_TYPE (v)))
-			  {
-			    v = NULL_TREE;
-			    break;
-			  }
-			else
-			  {
-			    v = TREE_OPERAND (v, 0);
-			    break;
-			  }
+			v = NULL_TREE;
+			break;
 		      }
 		    /* Now the ref is to an array type.  */
 		    gcc_assert (TREE_CODE (TREE_TYPE (v)) == ARRAY_TYPE);
-- 
2.47.3

