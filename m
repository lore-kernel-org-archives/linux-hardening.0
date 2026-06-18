Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B2029405
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781812617; cv=none; b=tzJOxs3pCxWy07q8+rbRdwQfAEjGfCM8SJTOcGVRBJTnHrAFPKxx8W5IxCJ+VdhnDPmzuJgMdEKG9KRduiBBTBBunPDgLlUuvH42YnnFoCbxLf7wDSqbdydOsKDNXTn4JfrKvpJ/fk6E69z4al69V8+sHc0vvOKmgI+HESSKc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781812617; c=relaxed/simple;
	bh=OrbHAmXIkMZJ8dxJahwSkJQoQoMq/wFaZhhCMBGdpWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NjfN9qj49BHaCVEwzGmL+3A572BSEb6y07+ZIKaGej+lYaJ11c9NzMxY5EruxM4fSghWHG5Jni1hAX6b0QMMkwf8/sowI/HpMnX3yFR45EOPOqczfefcfhOcPIicw6mg8dpEARbf63BbX9PsR5cMet0cleFukx91tQ9WR88rtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLs2eduq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLs2eduq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D551F000E9;
	Thu, 18 Jun 2026 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781812615;
	bh=hb6PDNGYcobgIqMRxoY/YCLbpLErhS4bbH2USlpIKyM=;
	h=From:To:Cc:Subject:Date;
	b=eLs2eduqANSqdXx2JO+lw4UaLImA6jXamWAYmwrXOvL6oNIJkc/69qcrP6G6l9SJ6
	 0ZlGt6kzPPq2PhZUF9ky+i1NB+mHxZOsFXNnzlBd+VLGTI+Wnmo69CIp7Tul/DLLFO
	 yn+gvnFCQWnXeAARxofiHwVaoBWFzTgeGcvxUEhtp5eEyzQyx8yGk0cyZYly0JCRaN
	 PvSTzvklkKXkJIlU30ZbTHuEGGedWca0nppXUyzEaj1B4y3g9tAl2OiZmRA52kxz2m
	 7uAsh+XKBfqVzJPXENCDgBfELhYbiy2FULYIBif5qnwgn83rxAQJhu5tBy7JOUfDxg
	 DKMYNrSi/2KeA==
From: Kees Cook <kees@kernel.org>
To: Joseph Myers <josmyers@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Richard Biener <rguenther@suse.de>,
	Martin Uecker <uecker@tugraz.at>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] c: handle .ACCESS_WITH_SIZE in build_unary_op for !/+/- [PR125604]
Date: Thu, 18 Jun 2026 12:56:51 -0700
Message-Id: <20260618195646.it.067-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4068; i=kees@kernel.org; h=from:subject:message-id; bh=OrbHAmXIkMZJ8dxJahwSkJQoQoMq/wFaZhhCMBGdpWA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkmvs3MTFtuWC8t3PWPcXGtftz/rO/5VWLaK2/Nm/zxS vzE9z+6O0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACbyW4uR4Vsw09ZACXFe69cJ E+o+v2H43qSnUipZvzhg4dbF/90nPmL4nyQjrnkkaBXPvr7elpk6f+49i13N9WeWqG/prXRHtll /2QA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PR123569 fixed wrong code with the counted_by attribute on a pointer
member by suppressing creation of the .ACCESS_WITH_SIZE wrapper in the
parser's pre/post-increment paths, and added a checking assertion in
build_unary_op to ensure no .ACCESS_WITH_SIZE call reaches it.

The other rvalue-consuming unary operators (!, -, +) still
rvalue-convert their operand via convert_lvalue_to_rvalue, which
produces the .ACCESS_WITH_SIZE wrapper as before.  They then reach
parser_build_unary_op then build_unary_op carrying the wrapper and
trip the assertion.  A minimal reproducer:

  struct s {
    int n;
    char *p __attribute__((__counted_by__(n)));
  };
  int f (struct s *o) { return !o->p; }

Unwrap the .ACCESS_WITH_SIZE call at the top of build_unary_op via
get_ref_from_access_with_size.  These unary operators consume the
pointer rvalue rather than the pointed-to data, so the bounds-checking
wrapper is not load-bearing here.  The assertion is retained: after
the unwrap it documents the post-condition the rest of the function
relies on.

	PR c/125604

gcc/c/ChangeLog:

	* c-typeck.cc (build_unary_op): Unwrap .ACCESS_WITH_SIZE
	from the operand before further processing.

gcc/testsuite/ChangeLog:

	* gcc.dg/counted-by-unary.c: New test.
---
 gcc/testsuite/gcc.dg/counted-by-unary.c | 32 +++++++++++++++++++++++++
 gcc/c/c-typeck.cc                       | 12 ++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 gcc/testsuite/gcc.dg/counted-by-unary.c

diff --git a/gcc/testsuite/gcc.dg/counted-by-unary.c b/gcc/testsuite/gcc.dg/counted-by-unary.c
new file mode 100644
index 000000000000..65ede4c0dfd8
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/counted-by-unary.c
@@ -0,0 +1,32 @@
+/* Verify that unary operators that rvalue-convert a counted_by-annotated
+   pointer access do not ICE.  The original PR123569 fix suppressed the
+   .ACCESS_WITH_SIZE wrapper creation for ++/-- (which keep an lvalue);
+   the rvalue-consuming ops (!, -, +) still receive the wrapper and must
+   strip it in build_unary_op.  */
+/* { dg-do run } */
+/* { dg-options "-std=c99" } */
+
+struct s {
+    int n;
+    char *p __attribute__((__counted_by__(n)));
+};
+
+int test_not (struct s *o)    { return !o->p; }
+__INTPTR_TYPE__ test_neg (struct s *o)   { return -(__INTPTR_TYPE__)o->p; }
+__INTPTR_TYPE__ test_plus (struct s *o)  { return +(__INTPTR_TYPE__)o->p; }
+
+extern void abort (void);
+
+int main (void) {
+    char buf[4] = { 0 };
+    struct s s = { .n = 4, .p = buf };
+    if (test_not (&s) != 0)  abort ();    /* p is non-null */
+
+    struct s e = { .n = 0, .p = (void*)0 };
+    if (test_not (&e) != 1)  abort ();    /* p is null */
+
+    /* test_neg / test_plus must just compile and run without ICE.  */
+    (void) test_neg (&s);
+    (void) test_plus (&s);
+    return 0;
+}
diff --git a/gcc/c/c-typeck.cc b/gcc/c/c-typeck.cc
index 6bce8c427543..0f96de200743 100644
--- a/gcc/c/c-typeck.cc
+++ b/gcc/c/c-typeck.cc
@@ -5779,6 +5779,18 @@ build_unary_op (location_t location, enum tree_code code, tree xarg,
   tree eptype = NULL_TREE;
   const char *invalid_op_diag;
 
+  /* If ARG is wrapped in a call to .ACCESS_WITH_SIZE — created when the
+     C parser rvalue-converts a counted_by-annotated member access (see
+     PR123569) — unwrap it here.  Unary operators that consume an rvalue
+     (!, -, +) read the value itself rather than dereferencing into the
+     pointed-to data, so the bounds-checking wrapper is unnecessary and
+     would otherwise reach build_unary_op while it is not equipped to
+     handle the wrapped form.  PR123569 fixed the ++/-- side of this by
+     suppressing wrapper creation in the parser; the rvalue-consuming
+     ops still receive the wrapper and need to strip it here.  */
+  if (is_access_with_size_p (arg))
+    xarg = arg = get_ref_from_access_with_size (arg);
+
   gcc_checking_assert (!is_access_with_size_p (arg));
 
   bool int_operands = EXPR_INT_CONST_OPERANDS (xarg);
-- 
2.34.1

