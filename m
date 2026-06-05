Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69354381AEC
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691738; cv=none; b=GG3jAMI/haNDoEqK0klfhz/UUNTAttIbxLPE4ekEK/lNGiomswrboVgr/BDN5zDiIz7WKgQNSs0ndTv74zSSQAAGBuk+vtQT0T/go+5/HkQX0KFC5tQ69cVUqaRCor7+FaMGaTzx99IlHPyHyHFVSiICdOJcjkuEmo/RxEmvwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691738; c=relaxed/simple;
	bh=7RenlYtfpcU8vUwt6iAa4lKHgtGDTKGTB96AX9oSQDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVJ+rOANRurjj2sCYlrs+kSFpW1dKRMu8rRA4i0Iu4efDkKEGc3QA+fhmCAYJA8EjXTjfcsrBeonNx9/KBjiN7XSHI1kE+hLxiabRcWQjrDM41wkNLEzvvIFVJoGsZjPADje6AKq/FH4gRNkYQEZpSngWokfV1pZGIklsuKDDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=uDBJVB4t; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="uDBJVB4t"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490c1915793so11023135e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691735; x=1781296535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy5A+Io8uFRTyVOfKVJ9UCNFV2K8P7j4lEaZnh+SQ3A=;
        b=uDBJVB4tsbRzpYlest2396PesBlSG3AKJXnqd009NgtPL0ETdxhCniukryRvre6lre
         LQ+V8+opj1V7n0ROkwy4zcLhR3Y63gvBmhgsy8f//6u9dfGFuHaTdoItRkCrEDgg136W
         XgIE8It8Rf569C2aMCF/XWvTWyccOUIucfXLuZ3mlfPuIE1TX6nbUH0L0MPKRp2vt0P8
         CktFLw3y3+86A7rFw1MRqIdvtZKp/OTwsQua8kCBiVUPs6hQf21v1lCNolXD/4Ux3C5k
         3KWEOMwqeoE/iXQp55AWrY0enFj2EbQJEeT7a13jmTayPqGXPNuZUxtzAJRGYWWsf8S+
         CxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691735; x=1781296535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qy5A+Io8uFRTyVOfKVJ9UCNFV2K8P7j4lEaZnh+SQ3A=;
        b=UDfkQZrMgMDfQ06/N2Y+G06psFYCFc4rqG+AsC0vAi22Sf6rNb5Wit6Mf1gsctC25X
         Tmi8s8SgukIEj5LqcnxoBNjuQxo6jgzog/7LHDQTBEaGmwkTnPjOnZMiyKnSyFxdAhZA
         7EqUvb9+fOT91u0U4sTPN943VqFu+TPP62UpNT7lHOlXWBpc9h1ckcUuJNCt5dVG0tL6
         mC4TlddQ3Teq02GQg0XXxF9Q6NQ8pgGhH/bnOEE4PbKNB2dytn+E4ZzSayV+M++X7LlM
         x2tU7gjpwB1ph35oyTMqbCWr5sfdikO5xPp52sxjmqbV0PoGYV4Os6w+l3kN1O369pDZ
         u/rw==
X-Gm-Message-State: AOJu0Yz8+u5/SxYIHiv7dWdxA5B1/HqULIiG5VesILn8CR5UHwQo+YX6
	coVbGHaBIB8wk2o6nnHeCbgX1C7ljb+jhkjcn+xM+a9aMYpus6x7DlJWIS22AYcg4NiGdWarD27
	wvyV2dw7x
X-Gm-Gg: Acq92OFySYLr8ezKEQ3uaWIhGD3WCVl8j2wOCUCXoketJWVGQwKfsOShsLnF0fGdvJW
	DXCCBziXT+rajRSW1d5yl2m1pbYLkp2n47Y5ME2yOecByWvikTXk3wm3+f4ftdMIXU57x2+X+FX
	pTDfV9c3KHGLyozrhDk5oyv/AL/+QF2l3DRnDabgtvnXCAyuKkkO8B+eCMrAj6ibH8Ucidsp8cz
	/5twO54jZP7vXv1jZdcihT1bdoOQvTrF4Gp4IQKCmc09nI6saWuRa2vcGbb4ymoYBwi9ybQbPDs
	sevCexSF+8qMJ3vbic1s2b0OlD+DN5f53DgMQ06mPr3ATLek34xvoKvHQCT7BDyvqf/e9n6MFKb
	ASBZ/00gsvk5SsCcXAtEyTBOHC/AWhNDpX2Yao8a9qlx14ycxvPUHDpUn05LmN2HIF6ywB1kapr
	QD0rbadqsOgW3/oOafZCeani8vn57CgPn43S2+9FvjAIoX+XmVMKjaOYCtbKCsRKEOhK92W2qH8
	Pv+pNpjhEjYXcJoJliUivIXDaGMOCbKA1qBirNNZxOiuUSwig==
X-Received: by 2002:a05:600c:3515:b0:490:b5d0:598e with SMTP id 5b1f17b1804b1-490c2604783mr87551295e9.21.1780691734693;
        Fri, 05 Jun 2026 13:35:34 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm91258805e9.1.2026.06.05.13.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:35:33 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de,
	York Jasper Niebuhr <yjn@yjn-systems.com>
Subject: [GCC PATCH] Add PLUGIN_BUILD_COMPONENT_REF callback
Date: Fri,  5 Jun 2026 22:35:20 +0200
Message-ID: <20260605203520.79939-1-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605202511.79272-1-yjn@yjn-systems.com>
References: <20260605202511.79272-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds the PLUGIN_BUILD_COMPONENT_REF callback, which is
required by Selfpatch-SLR tooling. It is based on mainline GCC 16.

The callback is invoked by the C front end when a COMPONENT_REF node is
built. The callback receives a pointer to the COMPONENT_REF tree (of
type 'tree *'). Plugins may replace the node by assigning through the
pointer, but any replacement must be type-compatible with the original
node.

The callback allows plugins to observe or instrument struct member
accesses that would otherwise be lost due to folding before the earliest
possible plugin pass or hook. In particular, the fold_offsetof
functionality removes all traces of type and member information in
offsetof-like trees, leaving only an integer constant for plugins to
inspect.

A considered alternative was to disable fold_offsetof altogether.
However, that prevents offsetof expressions from qualifying as
constant-expressions; for example, static assertions can no longer be
evaluated if they contain non-folded offsetof expressions. The callback
provides fine-grained control over individual COMPONENT_REFs instead of
universally changing folding behavior.

Allowing PLUGIN_BUILD_COMPONENT_REF to alter COMPONENT_REF nodes required
minor adjustments to fold_offsetof, which assumes a specific input
format. Code paths that cannot guarantee that format should now use
fold_offsetof_maybe(), which attempts to fold normally but, on failure,
casts the unfolded expression to the desired output type.

If the callback is not used to alter COMPONENT_REF trees, there is **no
change** in GCC’s behavior.

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 gcc/c-family/c-common.cc | 48 +++++++++++++++++++++++++++++++---------
 gcc/c-family/c-common.h  |  3 ++-
 gcc/c/c-parser.cc        |  2 +-
 gcc/c/c-typeck.cc        | 11 +++++++++
 gcc/doc/plugins.texi     |  6 +++++
 gcc/plugin.cc            |  2 ++
 gcc/plugin.def           |  6 +++++
 7 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/gcc/c-family/c-common.cc b/gcc/c-family/c-common.cc
index 5acb221d31f..63f7158cde9 100644
--- a/gcc/c-family/c-common.cc
+++ b/gcc/c-family/c-common.cc
@@ -7223,10 +7223,11 @@ c_common_to_target_charset (HOST_WIDE_INT c)
    the whole expression.  Return the folded result.  */
 
 tree
-fold_offsetof (tree expr, tree type, enum tree_code ctx)
+fold_offsetof (tree expr, tree type, enum tree_code ctx, bool may_fail)
 {
   tree base, off, t;
   tree_code code = TREE_CODE (expr);
+
   switch (code)
     {
     case ERROR_MARK:
@@ -7243,33 +7244,37 @@ fold_offsetof (tree expr, tree type, enum tree_code ctx)
      break;
 
     case VAR_DECL:
-      error ("cannot apply %<offsetof%> to static data member %qD", expr);
+      if (!may_fail)
+	error ("cannot apply %<offsetof%> to static data member %qD", expr);
       return error_mark_node;
 
     case CALL_EXPR:
     case TARGET_EXPR:
-      error ("cannot apply %<offsetof%> when %<operator[]%> is overloaded");
+      if (!may_fail)
+	error ("cannot apply %<offsetof%> when %<operator[]%> is overloaded");
       return error_mark_node;
 
     case NOP_EXPR:
     case INDIRECT_REF:
       if (!TREE_CONSTANT (TREE_OPERAND (expr, 0)))
 	{
-	  error ("cannot apply %<offsetof%> to a non constant address");
+	  if (!may_fail)
+	    error ("cannot apply %<offsetof%> to a non constant address");
 	  return error_mark_node;
 	}
       return convert (type, TREE_OPERAND (expr, 0));
 
     case COMPONENT_REF:
-      base = fold_offsetof (TREE_OPERAND (expr, 0), type, code);
+      base = fold_offsetof (TREE_OPERAND (expr, 0), type, code, may_fail);
       if (base == error_mark_node)
 	return base;
 
       t = TREE_OPERAND (expr, 1);
       if (DECL_C_BIT_FIELD (t))
 	{
-	  error ("attempt to take address of bit-field structure "
-		 "member %qD", t);
+	  if (!may_fail)
+	    error ("attempt to take address of bit-field structure "
+		   "member %qD", t);
 	  return error_mark_node;
 	}
       off = size_binop_loc (input_location, PLUS_EXPR, DECL_FIELD_OFFSET (t),
@@ -7278,7 +7283,7 @@ fold_offsetof (tree expr, tree type, enum tree_code ctx)
       break;
 
     case ARRAY_REF:
-      base = fold_offsetof (TREE_OPERAND (expr, 0), type, code);
+      base = fold_offsetof (TREE_OPERAND (expr, 0), type, code, may_fail);
       if (base == error_mark_node)
 	return base;
 
@@ -7335,17 +7340,38 @@ fold_offsetof (tree expr, tree type, enum tree_code ctx)
     case COMPOUND_EXPR:
       /* Handle static members of volatile structs.  */
       t = TREE_OPERAND (expr, 1);
-      gcc_checking_assert (VAR_P (get_base_address (t)));
-      return fold_offsetof (t, type);
+      if (!VAR_P (get_base_address (t)))
+	return error_mark_node;
+      return fold_offsetof (t, type, ERROR_MARK, may_fail);
 
     default:
-      gcc_unreachable ();
+      return error_mark_node;
     }
 
   if (!POINTER_TYPE_P (type))
     return size_binop (PLUS_EXPR, base, convert (type, off));
   return fold_build_pointer_plus (base, off);
 }
+
+/* Tries folding expr using fold_offsetof.  On success, the folded offsetof
+   is returned.  On failure, the original expr is wrapped in an ADDR_EXPR
+   and converted to the desired expression type.  The resulting expression
+   may or may not be constant!  */
+
+tree
+fold_offsetof_maybe (tree expr, tree type)
+{
+  /* expr might not have the correct structure, thus folding may fail.  */
+  tree maybe_folded = fold_offsetof (expr, type, ERROR_MARK, true);
+  if (maybe_folded != error_mark_node)
+    return maybe_folded;
+
+  tree ptr_type = build_pointer_type (TREE_TYPE (expr));
+  tree ptr = build1 (ADDR_EXPR, ptr_type, expr);
+
+  return fold_convert (type, ptr);
+}
+
 
 /* *PTYPE is an incomplete array.  Complete it with a domain based on
    INITIAL_VALUE.  If INITIAL_VALUE is not present, use 1 if DO_DEFAULT
diff --git a/gcc/c-family/c-common.h b/gcc/c-family/c-common.h
index 89517e2a80c..13e1a00ce88 100644
--- a/gcc/c-family/c-common.h
+++ b/gcc/c-family/c-common.h
@@ -1184,7 +1184,8 @@ extern bool c_dump_tree (void *, tree);
 extern void verify_sequence_points (tree);
 
 extern tree fold_offsetof (tree, tree = size_type_node,
-			   tree_code ctx = ERROR_MARK);
+			   tree_code ctx = ERROR_MARK, bool may_fail = false);
+extern tree fold_offsetof_maybe (tree, tree = size_type_node);
 
 extern int complete_array_type (tree *, tree, bool);
 extern void complete_flexible_array_elts (tree);
diff --git a/gcc/c/c-parser.cc b/gcc/c/c-parser.cc
index 0b8b2387109..5e4d65814e1 100644
--- a/gcc/c/c-parser.cc
+++ b/gcc/c/c-parser.cc
@@ -12170,7 +12170,7 @@ c_parser_postfix_expression (c_parser *parser)
 	    location_t end_loc = c_parser_peek_token (parser)->get_finish ();
 	    c_parser_skip_until_found (parser, CPP_CLOSE_PAREN,
 				       "expected %<)%>");
-	    expr.value = fold_offsetof (offsetof_ref);
+	    expr.value = fold_offsetof_maybe (offsetof_ref);
 	    set_c_expr_source_range (&expr, loc, end_loc);
 	  }
 	  break;
diff --git a/gcc/c/c-typeck.cc b/gcc/c/c-typeck.cc
index aa368a6e95a..232bf487d21 100644
--- a/gcc/c/c-typeck.cc
+++ b/gcc/c/c-typeck.cc
@@ -55,6 +55,7 @@ along with GCC; see the file COPYING3.  If not see
 #include "realmpfr.h"
 #include "tree-pretty-print-markup.h"
 #include "gcc-urlifier.h"
+#include "plugin.h"
 
 /* Possible cases of implicit conversions.  Used to select diagnostic messages
    and control folding initializers in convert_for_assignment.  */
@@ -3440,6 +3441,16 @@ build_component_ref (location_t loc, tree datum, tree component,
 	  else if (TREE_DEPRECATED (subdatum))
 	    warn_deprecated_use (subdatum, NULL_TREE);
 
+      tree pre_cb_type = TREE_TYPE (ref);
+      if (invoke_plugin_callbacks (PLUGIN_BUILD_COMPONENT_REF, &ref)
+	      == PLUGEVT_SUCCESS
+	      && !comptypes (TREE_TYPE (ref), pre_cb_type))
+	{
+	  error_at (EXPR_LOCATION (ref),
+		    "PLUGIN_BUILD_COMPONENT_REF callback returned"
+		    " expression of incompatible type");
+	}
+
 	  datum = ref;
 
 	  field = TREE_CHAIN (field);
diff --git a/gcc/doc/plugins.texi b/gcc/doc/plugins.texi
index ff0b5866f25..5e808013899 100644
--- a/gcc/doc/plugins.texi
+++ b/gcc/doc/plugins.texi
@@ -218,6 +218,12 @@ enum plugin_event
    as a const char* pointer.  */
   PLUGIN_INCLUDE_FILE,
 
+  /* Called by the C front end when a COMPONENT_REF node is built.  The
+     callback receives a pointer to the COMPONENT_REF tree (of type 'tree *').
+     Plugins may replace the node by assigning through the pointer, but any
+     replacement must be type-compatible with the original node.  */
+  PLUGIN_BUILD_COMPONENT_REF,
+
   PLUGIN_EVENT_FIRST_DYNAMIC    /* Dummy event used for indexing callback
                                    array.  */
 @};
diff --git a/gcc/plugin.cc b/gcc/plugin.cc
index 436be5e0147..3ea21956335 100644
--- a/gcc/plugin.cc
+++ b/gcc/plugin.cc
@@ -499,6 +499,7 @@ register_callback (const char *plugin_name,
       case PLUGIN_EARLY_GIMPLE_PASSES_END:
       case PLUGIN_NEW_PASS:
       case PLUGIN_INCLUDE_FILE:
+      case PLUGIN_BUILD_COMPONENT_REF:
         {
           struct callback_info *new_callback;
           if (!callback)
@@ -579,6 +580,7 @@ invoke_plugin_callbacks_full (int event, void *gcc_data)
       case PLUGIN_EARLY_GIMPLE_PASSES_END:
       case PLUGIN_NEW_PASS:
       case PLUGIN_INCLUDE_FILE:
+      case PLUGIN_BUILD_COMPONENT_REF:
         {
           /* Iterate over every callback registered with this event and
              call it.  */
diff --git a/gcc/plugin.def b/gcc/plugin.def
index b2fd27fa6e1..d44d45385b9 100644
--- a/gcc/plugin.def
+++ b/gcc/plugin.def
@@ -99,6 +99,12 @@ DEFEVENT (PLUGIN_NEW_PASS)
    as a const char* pointer.  */
 DEFEVENT (PLUGIN_INCLUDE_FILE)
 
+/* Called by the C front end when a COMPONENT_REF node is built.
+   The callback receives a pointer to the COMPONENT_REF tree (of type 'tree *').
+   Plugins may replace the node by assigning through the pointer, but any
+   replacement must be type-compatible with the original node.  */
+DEFEVENT (PLUGIN_BUILD_COMPONENT_REF)
+
 /* When adding a new hard-coded plugin event, don't forget to edit in
    file plugin.cc the functions register_callback and
    invoke_plugin_callbacks_full accordingly!  */
-- 
2.43.0

