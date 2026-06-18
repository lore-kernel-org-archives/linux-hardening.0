Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F037DEAA
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759576; cv=none; b=elFP7iR3/SHw/zlAgHms/S+2V/dt406ILKKgJ8gMyZnyRw76RLTddiB0iY7BrGZsoWolU910XDnjHL1lH+AdDzU/PcTsyE6exKDQZpYIiD4dHSSDJeM1+8oBmLlOX9w/4fFspJvbgeOk1EuDuRpbK/561EDKCLnKV5vWAxzQl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759576; c=relaxed/simple;
	bh=ARmXfzfmk3LT7n9bbeg9IGAGgbAhu0IwTEMKbxCVmCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lxPQPu50Cwh+OxUtEGJiIYqg9K28ps7arUJteklaINVlfpSS+GHLwmdxE/QV8lcHowl3wdiOasCekuVzohJyPUlbsy3XcGXwZJvig/7MQ3cViSw42GnWmkecIXAIA2vW4bP1FPRtCg657yML2xJ64H0v+dRfJYk3AYQxts+6klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm9DrOkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm9DrOkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2431F000E9;
	Thu, 18 Jun 2026 05:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781759575;
	bh=bz8rcJEvW+UYdjiZC8i4NMtHtvVIsO82vzYqLQfHPok=;
	h=From:To:Cc:Subject:Date;
	b=Sm9DrOkQTvyuC0AqtzBB/KQawv7JeaFfGx8YbTCrYAU5cm3XSQAv3YxPJ8BqK/fj0
	 DH8dtqQNXFsgDc7p1FjWSBBVP/IUfQdSGdc8n4GpwsmJ0ZZt1nd8jwPoCsUD0wYckl
	 HH1ja0+M4iK7b8P4xMCfMqGQh4jZxy2nGsY2nMOYSk/wb/NikCaqEnUeaEMtokjNHu
	 /00U6vsAa68ZJjo92/wJE1TblyZFawQ/OgAA+0gfam4eqewBHFEJQDTZtgOYM/S2f8
	 QFWAXyrjTJAUUg+OEI23Fot5YoxhrOtkIGlGaf2wKwnlHIlx8XitOspgca9Bs3GYBp
	 7/pWOkqJlbGbg==
From: Kees Cook <kees@kernel.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Kees Cook <kees@kernel.org>,
	Richard Biener <rguenther@suse.de>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] c: handle .ACCESS_WITH_SIZE in build_unary_op for !/+/- [PR123569]
Date: Wed, 17 Jun 2026 22:12:51 -0700
Message-Id: <20260618051246.work.269-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=kees@kernel.org; h=from:subject:message-id; bh=ARmXfzfmk3LT7n9bbeg9IGAGgbAhu0IwTEMKbxCVmCM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnGdcFvVu+7svcqQ1IJ96mKxEkal8/eW72Apfkvq/anx A/LvMMEO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACYSI8PI0MThox31SpP98uG6 pnjRqN/FE/5+3sgWyCydZCjVPHO7IcM/xatxC9kvnXo2ZbraVxuec96p7PfnPrE6x5A4Pa7H60o RDwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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
wrapper is not useful here.  The assertion is retained: after the unwrap
it documents the post-condition the rest of the function relies on.

	PR c/123569

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
index 000000000000..b16b819d63b6
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
+long test_neg (struct s *o)   { return -(long)o->p; }
+long test_plus (struct s *o)  { return +(long)o->p; }
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
 
+  /* If ARG is wrapped in a call to .ACCESS_WITH_SIZE (created when the
+     C parser rvalue-converts a counted_by-annotated member access, see
+     PR123569) unwrap it here.  Unary operators that consume an rvalue
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

