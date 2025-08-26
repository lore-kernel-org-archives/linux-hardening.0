Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15319309C
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189064; cv=none; b=Ry/WPkq2oG4ArDlCrQnxlJ78p58ll5ncT5N/jIFsBwy6sseMQKx8zlvmPN4DFx0o6bp677t4P4/k+W0Aep+RDJz5FqJ8VJq33Xm7g3jD2jjsBZTA3hLToIiwuHt7CGb3YHehWJcaxl1Tw/rrJ3xX+QbMLA24Uu5mfX2l0ggdXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189064; c=relaxed/simple;
	bh=ULArDttUoH2BnbOI3gLu8wJikWnIdMteyCkSVpdZ2qE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=okMz04EzVYP0CXvJ6bTP3Hk04zuyb4LzYLIYVfIk78KkXWmM6onn6JfC1l9g76CAPm1r9kqwoalTtwmjqID5oXd3wJXaObCRkfenPCC4NKzJsQpFEtT1EzR41rsSlHgYPkTBka+TB9dGcsAga8BoK7XoBLl8fEbnEDWEqpw8UFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txQf7h5t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txQf7h5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2BCC113D0;
	Tue, 26 Aug 2025 06:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756189063;
	bh=ULArDttUoH2BnbOI3gLu8wJikWnIdMteyCkSVpdZ2qE=;
	h=From:To:Cc:Subject:Date:From;
	b=txQf7h5t8gXt/wjnFGOSjDUXSEMUTcPaSEMFkaXyP6txgAdgVGSfTScyYXJKdmhPW
	 LioPj/kFrCdb46wRdYsF0PlkNALfuS9WPI8zGERHNvKZwL/9XY4CyhK554rtz648kB
	 2LCmleazmASoUO5VfgiwhhMJ/CbGKNtjqB/QqJSoL73U6yYHNTeb9WDJ2KeWirX7P/
	 HYe2+ahbjii5/AMV1ITc5PyJz2AEBkjQaVyRRf55g3IS+yhSn6zDQuoPi/MRWX1LNw
	 6dJIAykwrTTAo+q9ONOVKY1z0B/PIHt5Bz612YjRkN3y5GrBjkC8P0/84aUu1bfXFB
	 a2kX5ccor9bHw==
From: Kees Cook <kees@kernel.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Qing Zhao <qing.zhao@oracle.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] Fix sanitizer attribute infrastructure to use standard TREE_LIST format [PR113264]
Date: Mon, 25 Aug 2025 23:17:39 -0700
Message-Id: <20250826061735.it.634-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7367; i=kees@kernel.org; h=from:subject:message-id; bh=ULArDttUoH2BnbOI3gLu8wJikWnIdMteyCkSVpdZ2qE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlrA5uX9p+RPV16+MxUzqc+s4p0ym4cjLu3bQ2bgYTdU 5Yqr/iqjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlc62Rk+Hkwrnwx55E8D8/K Txxil4u+PlbbtKj2yow4rRMJ2+eGSjIybBFmX53wf9qE4mXaVxid7JSyVl+9bC7l/FHaQEX2sLo xDwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The __attribute__((__copy__)) functionality was crashing when copying
sanitizer-related attributes because these attributes violated the standard
GCC attribute infrastructure by storing INTEGER_CST values directly instead
of wrapping them in TREE_LIST like all other attributes.

Wrap sanitizer attributes INTEGER_CST values in TREE_LIST structures
to follow the same pattern as other attributes. This eliminates the
copy_list() crashes when copying sanitizer attributes:

test.c:4:1: internal compiler error: tree check: expected tree that contains ‘common’ structure, have ‘integer_cst’ in copy_list, at tree.cc:1427
    4 | __attribute__((__copy__(__tanh)));
      | ^~~~~~~~~~~~~
0x859d06 tree_contains_struct_check_failed(tree_node const*, tree_node_structure_enum, char const*, int, char const*)
        ../../gcc/gcc/tree.cc:9126
0x860f78 contains_struct_check(tree_node*, tree_node_structure_enum, char const*, int, char const*)
        ../../gcc/gcc/tree.h:3748
0x860f78 copy_list(tree_node*)
        ../../gcc/gcc/tree.cc:1427
0xa755a5 handle_copy_attribute
        ../../gcc/gcc/c-family/c-attribs.cc:3077

gcc/c-family/ChangeLog:

	PR c/113264
	* c-attribs.cc (add_no_sanitize_value): Store INTEGER_CST values
	wrapped in TREE_LIST following standard attribute conventions.
	(handle_no_sanitize_attribute): Handle both original string
	arguments and copied INTEGER_CST values from TREE_LIST format.

gcc/ChangeLog:

	PR c/113264
	* asan.h (sanitize_flags_p): Extract sanitizer flags from
	TREE_LIST wrapper instead of directly from INTEGER_CST.

gcc/d/ChangeLog:

	PR c/113264
	* d-attribs.cc (d_handle_no_sanitize_attribute): Store INTEGER_CST
	values wrapped in TREE_LIST following standard conventions.

gcc/testsuite/ChangeLog:

	PR c/113264
	* gcc.dg/pr113264.c: New test.
	* gcc.dg/pr113264-asan-no-instrumentation.c: New test validating
	that copied sanitizer attributes prevent ASAN instrumentation.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: Rebased on to latest upstream, which has sanitize_code_type now.
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
---
 gcc/asan.h                |  8 ++++++-
 gcc/c-family/c-attribs.cc | 49 +++++++++++++++++++++++++++------------
 gcc/d/d-attribs.cc        | 17 ++++++++++----
 3 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/gcc/asan.h b/gcc/asan.h
index a24562f67a29..f5dc3d7ceb8d 100644
--- a/gcc/asan.h
+++ b/gcc/asan.h
@@ -253,7 +253,13 @@ sanitize_flags_p (sanitize_code_type flag,
     {
       tree value = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (fn));
       if (value)
-	result_flags &= ~tree_to_uhwi (TREE_VALUE (value));
+	{
+	  /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
+	  tree attr_args = TREE_VALUE (value);
+	  gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
+	  sanitize_code_type no_sanitize_flags = tree_to_sanitize_code_type (TREE_VALUE (attr_args));
+	  result_flags &= ~no_sanitize_flags;
+	}
     }
 
   return result_flags;
diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
index 1e3a94ed9493..e629601579ef 100644
--- a/gcc/c-family/c-attribs.cc
+++ b/gcc/c-family/c-attribs.cc
@@ -1425,20 +1425,27 @@ add_no_sanitize_value (tree node, sanitize_code_type flags)
   tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (node));
   if (attr)
     {
-      sanitize_code_type old_value =
-	tree_to_sanitize_code_type (TREE_VALUE (attr));
+      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
+      tree attr_args = TREE_VALUE (attr);
+      gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
+      sanitize_code_type old_value = tree_to_sanitize_code_type (TREE_VALUE (attr_args));
+
       flags |= old_value;
 
       if (flags == old_value)
 	return;
 
-      TREE_VALUE (attr) = build_int_cst (uint64_type_node, flags);
+      tree new_value = build_tree_list (NULL_TREE,
+					build_int_cst (uint64_type_node, flags));
+      TREE_VALUE (attr) = new_value;
     }
   else
-    DECL_ATTRIBUTES (node)
-      = tree_cons (get_identifier ("no_sanitize"),
-		   build_int_cst (uint64_type_node, flags),
-		   DECL_ATTRIBUTES (node));
+    {
+      tree attr_value = build_tree_list (NULL_TREE,
+					 build_int_cst (uint64_type_node, flags));
+      DECL_ATTRIBUTES (node) = tree_cons (get_identifier ("no_sanitize"), attr_value,
+					  DECL_ATTRIBUTES (node));
+    }
 }
 
 /* Handle a "no_sanitize" attribute; arguments as in
@@ -1456,17 +1463,29 @@ handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
       return NULL_TREE;
     }
 
-  for (; args; args = TREE_CHAIN (args))
+  /* Handle both original string arguments and copied attributes that
+     have already been processed into INTEGER_CST wrapped in TREE_LIST.  */
+  if (args && TREE_CODE (args) == TREE_LIST
+      && TREE_VALUE (args) && TREE_CODE (TREE_VALUE (args)) == INTEGER_CST)
     {
-      tree id = TREE_VALUE (args);
-      if (TREE_CODE (id) != STRING_CST)
+      /* This is a copied attribute with the flags already processed.  */
+      flags = tree_to_sanitize_code_type (TREE_VALUE (args));
+    }
+  else
+    {
+      /* Process original string arguments.  */
+      for (; args; args = TREE_CHAIN (args))
 	{
-	  error ("%qE argument not a string", name);
-	  return NULL_TREE;
-	}
+	  tree id = TREE_VALUE (args);
+	  if (TREE_CODE (id) != STRING_CST)
+	    {
+	      error ("%qE argument not a string", name);
+	      return NULL_TREE;
+	    }
 
-      char *string = ASTRDUP (TREE_STRING_POINTER (id));
-      flags |= parse_no_sanitize_attribute (string);
+	  char *string = ASTRDUP (TREE_STRING_POINTER (id));
+	  flags |= parse_no_sanitize_attribute (string);
+	}
     }
 
   add_no_sanitize_value (*node, flags);
diff --git a/gcc/d/d-attribs.cc b/gcc/d/d-attribs.cc
index 53aea5e2e904..342702b05acb 100644
--- a/gcc/d/d-attribs.cc
+++ b/gcc/d/d-attribs.cc
@@ -1424,17 +1424,26 @@ d_handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
      merge existing flags if no_sanitize was previously handled.  */
   if (tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (*node)))
     {
-      sanitize_code_type old_value =
-	tree_to_sanitize_code_type (TREE_VALUE (attr));
+      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
+      tree attr_args = TREE_VALUE (attr);
+      gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
+      sanitize_code_type old_value = tree_to_sanitize_code_type (TREE_VALUE (attr_args));
+
       flags |= old_value;
 
       if (flags != old_value)
-	TREE_VALUE (attr) = build_int_cst (d_ulong_type, flags);
+	{
+	  tree new_value = build_tree_list (NULL_TREE,
+					     build_int_cst (d_ulong_type, flags));
+	  TREE_VALUE (attr) = new_value;
+	}
     }
   else
     {
+      tree attr_value = build_tree_list (NULL_TREE,
+					  build_int_cst (d_ulong_type, flags));
       DECL_ATTRIBUTES (*node) = tree_cons (get_identifier ("no_sanitize"),
-					   build_int_cst (d_ulong_type, flags),
+					   attr_value,
 					   DECL_ATTRIBUTES (*node));
     }
 
-- 
2.34.1

