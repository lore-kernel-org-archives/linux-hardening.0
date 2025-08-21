Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB715853B
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761229; cv=none; b=eZ9iGOiROxEc1tWCrzGLpOhuZzfoWWeGa9vXD5IUb9BvYw+QvCoQtD6pZf73FQ0jpuq1f/uafuptBPxjnaH27U9oHyWI4TqwMJG1+lWTc0pn06OPKoyL8BsC6n3grf4/H6iywTLLdrKrIdfl5p8tKM1Z5ar2FCnrmj5upkaHzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761229; c=relaxed/simple;
	bh=mQq1VWBqWLL0QEkQvPy5IM+PhOmrN1uvLeG6eYR+WpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dn0FNtY9v4cVjbITbsfeC98B9ENFQ+5UY5gBjs3+MsdIA/Iu6oKBrEgKPtsxz+7omcbhvRZsA6ghdhz0ZVolxeVhZHauNDTgGgplPIn59gEXzgpSvdpeyWjtJ29/QIbAX56j2MRgxWhk1H71POuZthd3sBIXB3J6P8Wp0FFWfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuxAbB0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuxAbB0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E71C4CEED;
	Thu, 21 Aug 2025 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761228;
	bh=mQq1VWBqWLL0QEkQvPy5IM+PhOmrN1uvLeG6eYR+WpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuxAbB0GXr5KDYo4gR5H5mtKG2uKvoYgqUavHjWTM+P+PQ5tqE9baFW2lrrxCCcyl
	 d2AgTHtHFBOiVQWqFBVi3N4uq0w+aBOI2NULQo5JMS0CNQjadxQyU+f2AdqeLDjLcv
	 TvlzxV0h0X4XLdW0xGMIcdXdGE0GDruHwhZrcF14qRuUTaXoZY5ngrjqWLWdP8k3dn
	 B7Wnf2dxP9ZG0t5RU3UtAJr0P3ybvF00p+bWvwcxc7nQPZ0+9+K4tuf2XuTBJ+/eEM
	 VAmxkuyBxdnoXFFEMED361HE1LrgA6UXghHiRpscPJGgjvuhJG8IRGCgxVu9oah4yp
	 I6QeTweS9yfcA==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH 1/7] sanitizer: Expand sanitizer flag from 32-bit to 64-bit
Date: Thu, 21 Aug 2025 00:26:34 -0700
Message-Id: <20250821072708.3109244-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821064202.work.893-kees@kernel.org>
References: <20250821064202.work.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the sanitizer flags infrastructure from unsigned int (32-bit)
to unsigned long long (64-bit) to support the future addition of KCFI
(Kernel Control Flow Integrity) at bit position 32, which exceeds the
previous 32-bit limit.

Update all sanitizer-related data structures, function signatures,
and type handling across the compiler:

* common.opt: Change flag_sanitize from unsigned int to unsigned long long
* flag-types.h: Convert all SANITIZE_* enum values from 1UL << N to 1ULL << N
* opts.h: Update parse_sanitizer_options() and parse_no_sanitize_attribute()
  function signatures to use unsigned long long parameters
* opts.cc: Update sanitizer parsing functions and sanitizer_opts_s
  structure to handle 64-bit flag values, including special handling for
  "all" flag (~0ULL)
* asan.h: Update sanitize_flags_p() to accept and return 64-bit values
* c-family/c-common.h: Update add_no_sanitize_value() signature
* c-family/c-attribs.cc: Update no_sanitize attribute handling functions
* c-family/c-attribs.cc: Replace unsigned_type_node with
  long_long_unsigned_type_node for no_sanitize attribute storage
* d/d-attribs.cc: Replace d_uint_type with long_long_unsigned_type_node
  for consistent 64-bit attribute representation across languages
* c/c-parser.cc: Update local flag_sanitize_save variables in declaration
  parsing where sanitization is temporarily disabled for initializers
* cp/typeck.cc: Update flag_sanitize_save in pointer-to-member function
  handling
* dwarf2asm.cc: Update save_flag_sanitize for ASan-disabled indirect
  constants

Is using "unsigned long long" correct here, or is switching to
"uint64_t" preferred?

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/asan.h                |  4 +--
 gcc/c-family/c-common.h   |  2 +-
 gcc/flag-types.h          | 64 +++++++++++++++++++--------------------
 gcc/opts.h                |  8 ++---
 gcc/c-family/c-attribs.cc | 19 +++++++-----
 gcc/c/c-parser.cc         |  4 +--
 gcc/common.opt            |  2 +-
 gcc/cp/typeck.cc          |  2 +-
 gcc/d/d-attribs.cc        |  8 ++---
 gcc/dwarf2asm.cc          |  2 +-
 gcc/opts.cc               | 16 +++++-----
 11 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/gcc/asan.h b/gcc/asan.h
index 273d6745c58d..7434d43ac493 100644
--- a/gcc/asan.h
+++ b/gcc/asan.h
@@ -242,9 +242,9 @@ asan_protect_stack_decl (tree decl)
    remove all flags mentioned in "no_sanitize" of DECL_ATTRIBUTES.  */
 
 inline bool
-sanitize_flags_p (unsigned int flag, const_tree fn = current_function_decl)
+sanitize_flags_p (unsigned long long flag, const_tree fn = current_function_decl)
 {
-  unsigned int result_flags = flag_sanitize & flag;
+  unsigned long long result_flags = flag_sanitize & flag;
   if (result_flags == 0)
     return false;
 
diff --git a/gcc/c-family/c-common.h b/gcc/c-family/c-common.h
index 7c7e21d2d0eb..e7940cc079f6 100644
--- a/gcc/c-family/c-common.h
+++ b/gcc/c-family/c-common.h
@@ -1713,7 +1713,7 @@ extern enum flt_eval_method
 excess_precision_mode_join (enum flt_eval_method, enum flt_eval_method);
 
 extern int c_flt_eval_method (bool ts18661_p);
-extern void add_no_sanitize_value (tree node, unsigned int flags);
+extern void add_no_sanitize_value (tree node, unsigned long long flags);
 
 extern void maybe_add_include_fixit (rich_location *, const char *, bool);
 extern void maybe_suggest_missing_token_insertion (rich_location *richloc,
diff --git a/gcc/flag-types.h b/gcc/flag-types.h
index 9a3cc4a2e165..33c88a15ecbb 100644
--- a/gcc/flag-types.h
+++ b/gcc/flag-types.h
@@ -301,42 +301,42 @@ enum zero_init_padding_bits_kind {
 /* Different instrumentation modes.  */
 enum sanitize_code {
   /* AddressSanitizer.  */
-  SANITIZE_ADDRESS = 1UL << 0,
-  SANITIZE_USER_ADDRESS = 1UL << 1,
-  SANITIZE_KERNEL_ADDRESS = 1UL << 2,
+  SANITIZE_ADDRESS = 1ULL << 0,
+  SANITIZE_USER_ADDRESS = 1ULL << 1,
+  SANITIZE_KERNEL_ADDRESS = 1ULL << 2,
   /* ThreadSanitizer.  */
-  SANITIZE_THREAD = 1UL << 3,
+  SANITIZE_THREAD = 1ULL << 3,
   /* LeakSanitizer.  */
-  SANITIZE_LEAK = 1UL << 4,
+  SANITIZE_LEAK = 1ULL << 4,
   /* UndefinedBehaviorSanitizer.  */
-  SANITIZE_SHIFT_BASE = 1UL << 5,
-  SANITIZE_SHIFT_EXPONENT = 1UL << 6,
-  SANITIZE_DIVIDE = 1UL << 7,
-  SANITIZE_UNREACHABLE = 1UL << 8,
-  SANITIZE_VLA = 1UL << 9,
-  SANITIZE_NULL = 1UL << 10,
-  SANITIZE_RETURN = 1UL << 11,
-  SANITIZE_SI_OVERFLOW = 1UL << 12,
-  SANITIZE_BOOL = 1UL << 13,
-  SANITIZE_ENUM = 1UL << 14,
-  SANITIZE_FLOAT_DIVIDE = 1UL << 15,
-  SANITIZE_FLOAT_CAST = 1UL << 16,
-  SANITIZE_BOUNDS = 1UL << 17,
-  SANITIZE_ALIGNMENT = 1UL << 18,
-  SANITIZE_NONNULL_ATTRIBUTE = 1UL << 19,
-  SANITIZE_RETURNS_NONNULL_ATTRIBUTE = 1UL << 20,
-  SANITIZE_OBJECT_SIZE = 1UL << 21,
-  SANITIZE_VPTR = 1UL << 22,
-  SANITIZE_BOUNDS_STRICT = 1UL << 23,
-  SANITIZE_POINTER_OVERFLOW = 1UL << 24,
-  SANITIZE_BUILTIN = 1UL << 25,
-  SANITIZE_POINTER_COMPARE = 1UL << 26,
-  SANITIZE_POINTER_SUBTRACT = 1UL << 27,
-  SANITIZE_HWADDRESS = 1UL << 28,
-  SANITIZE_USER_HWADDRESS = 1UL << 29,
-  SANITIZE_KERNEL_HWADDRESS = 1UL << 30,
+  SANITIZE_SHIFT_BASE = 1ULL << 5,
+  SANITIZE_SHIFT_EXPONENT = 1ULL << 6,
+  SANITIZE_DIVIDE = 1ULL << 7,
+  SANITIZE_UNREACHABLE = 1ULL << 8,
+  SANITIZE_VLA = 1ULL << 9,
+  SANITIZE_NULL = 1ULL << 10,
+  SANITIZE_RETURN = 1ULL << 11,
+  SANITIZE_SI_OVERFLOW = 1ULL << 12,
+  SANITIZE_BOOL = 1ULL << 13,
+  SANITIZE_ENUM = 1ULL << 14,
+  SANITIZE_FLOAT_DIVIDE = 1ULL << 15,
+  SANITIZE_FLOAT_CAST = 1ULL << 16,
+  SANITIZE_BOUNDS = 1ULL << 17,
+  SANITIZE_ALIGNMENT = 1ULL << 18,
+  SANITIZE_NONNULL_ATTRIBUTE = 1ULL << 19,
+  SANITIZE_RETURNS_NONNULL_ATTRIBUTE = 1ULL << 20,
+  SANITIZE_OBJECT_SIZE = 1ULL << 21,
+  SANITIZE_VPTR = 1ULL << 22,
+  SANITIZE_BOUNDS_STRICT = 1ULL << 23,
+  SANITIZE_POINTER_OVERFLOW = 1ULL << 24,
+  SANITIZE_BUILTIN = 1ULL << 25,
+  SANITIZE_POINTER_COMPARE = 1ULL << 26,
+  SANITIZE_POINTER_SUBTRACT = 1ULL << 27,
+  SANITIZE_HWADDRESS = 1ULL << 28,
+  SANITIZE_USER_HWADDRESS = 1ULL << 29,
+  SANITIZE_KERNEL_HWADDRESS = 1ULL << 30,
   /* Shadow Call Stack.  */
-  SANITIZE_SHADOW_CALL_STACK = 1UL << 31,
+  SANITIZE_SHADOW_CALL_STACK = 1ULL << 31,
   SANITIZE_SHIFT = SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
   SANITIZE_UNDEFINED = SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNREACHABLE
 		       | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
diff --git a/gcc/opts.h b/gcc/opts.h
index ea92c4922a3b..65b8a1079f34 100644
--- a/gcc/opts.h
+++ b/gcc/opts.h
@@ -432,10 +432,10 @@ extern char *write_langs (unsigned int mask);
 extern void print_ignored_options (void);
 extern void handle_common_deferred_options (void);
 extern void handle_deferred_dump_options (void);
-unsigned int parse_sanitizer_options (const char *, location_t, int,
-				      unsigned int, int, bool);
+unsigned long long parse_sanitizer_options (const char *, location_t, int,
+					    unsigned long long, int, bool);
 
-unsigned int parse_no_sanitize_attribute (char *value);
+unsigned long long parse_no_sanitize_attribute (char *value);
 extern bool common_handle_option (struct gcc_options *opts,
 				  struct gcc_options *opts_set,
 				  const struct cl_decoded_option *decoded,
@@ -477,7 +477,7 @@ extern bool opt_enum_arg_to_value (size_t opt_index, const char *arg,
 extern const struct sanitizer_opts_s
 {
   const char *const name;
-  unsigned int flag;
+  unsigned long long flag;
   size_t len;
   bool can_recover;
   bool can_trap;
diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
index 1f4a0df12051..eed384818433 100644
--- a/gcc/c-family/c-attribs.cc
+++ b/gcc/c-family/c-attribs.cc
@@ -1409,24 +1409,27 @@ handle_cold_attribute (tree *node, tree name, tree ARG_UNUSED (args),
 /* Add FLAGS for a function NODE to no_sanitize_flags in DECL_ATTRIBUTES.  */
 
 void
-add_no_sanitize_value (tree node, unsigned int flags)
+add_no_sanitize_value (tree node, unsigned long long flags)
 {
+
   tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (node));
   if (attr)
     {
-      unsigned int old_value = tree_to_uhwi (TREE_VALUE (attr));
+      unsigned long long old_value = tree_to_uhwi (TREE_VALUE (attr));
       flags |= old_value;
 
       if (flags == old_value)
 	return;
 
-      TREE_VALUE (attr) = build_int_cst (unsigned_type_node, flags);
+      TREE_VALUE (attr) = build_int_cst (long_long_unsigned_type_node, flags);
     }
   else
-    DECL_ATTRIBUTES (node)
-      = tree_cons (get_identifier ("no_sanitize"),
-		   build_int_cst (unsigned_type_node, flags),
-		   DECL_ATTRIBUTES (node));
+    {
+      DECL_ATTRIBUTES (node)
+	= tree_cons (get_identifier ("no_sanitize"),
+		     build_int_cst (long_long_unsigned_type_node, flags),
+		     DECL_ATTRIBUTES (node));
+    }
 }
 
 /* Handle a "no_sanitize" attribute; arguments as in
@@ -1436,7 +1439,7 @@ static tree
 handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
 			      bool *no_add_attrs)
 {
-  unsigned int flags = 0;
+  unsigned long long flags = 0;
   *no_add_attrs = true;
   if (TREE_CODE (*node) != FUNCTION_DECL)
     {
diff --git a/gcc/c/c-parser.cc b/gcc/c/c-parser.cc
index 4a13fc0d3842..7a0e1d6de6f3 100644
--- a/gcc/c/c-parser.cc
+++ b/gcc/c/c-parser.cc
@@ -2822,7 +2822,7 @@ c_parser_declaration_or_fndef (c_parser *parser, bool fndef_ok,
 			      specs->constexpr_p, &richloc);
 		  /* A parameter is initialized, which is invalid.  Don't
 		     attempt to instrument the initializer.  */
-		  int flag_sanitize_save = flag_sanitize;
+		  unsigned long long flag_sanitize_save = flag_sanitize;
 		  if (nested && !empty_ok)
 		    flag_sanitize = 0;
 		  init = c_parser_expr_no_commas (parser, NULL);
@@ -2911,7 +2911,7 @@ c_parser_declaration_or_fndef (c_parser *parser, bool fndef_ok,
 			      specs->constexpr_p, &richloc);
 		  /* A parameter is initialized, which is invalid.  Don't
 		     attempt to instrument the initializer.  */
-		  int flag_sanitize_save = flag_sanitize;
+		  unsigned long long flag_sanitize_save = flag_sanitize;
 		  if (TREE_CODE (d) == PARM_DECL)
 		    flag_sanitize = 0;
 		  init = c_parser_initializer (parser, d);
diff --git a/gcc/common.opt b/gcc/common.opt
index 70659fabebd5..f82f2b3f1b11 100644
--- a/gcc/common.opt
+++ b/gcc/common.opt
@@ -205,7 +205,7 @@ bool flag_opts_finished
 
 ; What the sanitizer should instrument
 Variable
-unsigned int flag_sanitize
+unsigned long long flag_sanitize
 
 ; What sanitizers should recover from errors
 Variable
diff --git a/gcc/cp/typeck.cc b/gcc/cp/typeck.cc
index f592894e01ab..c26b2fb8939b 100644
--- a/gcc/cp/typeck.cc
+++ b/gcc/cp/typeck.cc
@@ -4287,7 +4287,7 @@ get_member_function_from_ptrfunc (tree *instance_ptrptr, tree function,
       idx = build1 (NOP_EXPR, vtable_index_type, e3);
       switch (TARGET_PTRMEMFUNC_VBIT_LOCATION)
 	{
-	  int flag_sanitize_save;
+	  unsigned long long flag_sanitize_save;
 	case ptrmemfunc_vbit_in_pfn:
 	  e1 = cp_build_binary_op (input_location,
 				   BIT_AND_EXPR, idx, integer_one_node,
diff --git a/gcc/d/d-attribs.cc b/gcc/d/d-attribs.cc
index 77315dc5d58d..a1712f996bdc 100644
--- a/gcc/d/d-attribs.cc
+++ b/gcc/d/d-attribs.cc
@@ -1406,7 +1406,7 @@ d_handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
       return NULL_TREE;
     }
 
-  unsigned int flags = 0;
+  unsigned long long flags = 0;
   for (; args; args = TREE_CHAIN (args))
     {
       tree id = TREE_VALUE (args);
@@ -1424,16 +1424,16 @@ d_handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
      merge existing flags if no_sanitize was previously handled.  */
   if (tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (*node)))
     {
-      unsigned int old_value = tree_to_uhwi (TREE_VALUE (attr));
+      unsigned long long old_value = tree_to_uhwi (TREE_VALUE (attr));
       flags |= old_value;
 
       if (flags != old_value)
-	TREE_VALUE (attr) = build_int_cst (d_uint_type, flags);
+	TREE_VALUE (attr) = build_int_cst (long_long_unsigned_type_node, flags);
     }
   else
     {
       DECL_ATTRIBUTES (*node) = tree_cons (get_identifier ("no_sanitize"),
-					   build_int_cst (d_uint_type, flags),
+					   build_int_cst (long_long_unsigned_type_node, flags),
 					   DECL_ATTRIBUTES (*node));
     }
 
diff --git a/gcc/dwarf2asm.cc b/gcc/dwarf2asm.cc
index ec5c684da479..6f193a68bf9d 100644
--- a/gcc/dwarf2asm.cc
+++ b/gcc/dwarf2asm.cc
@@ -1041,7 +1041,7 @@ dw2_output_indirect_constant_1 (const char *sym, tree id)
   sym_ref = gen_rtx_SYMBOL_REF (Pmode, sym);
   /* Disable ASan for decl because redzones cause ABI breakage between GCC and
      libstdc++ for `.LDFCM*' variables.  See PR 78651 for details.  */
-  unsigned int save_flag_sanitize = flag_sanitize;
+  unsigned long long save_flag_sanitize = flag_sanitize;
   flag_sanitize &= ~(SANITIZE_ADDRESS | SANITIZE_USER_ADDRESS
 		     | SANITIZE_KERNEL_ADDRESS);
   /* And also temporarily disable -fsection-anchors.  These indirect constants
diff --git a/gcc/opts.cc b/gcc/opts.cc
index c21e66ba9171..5fd86aa89adb 100644
--- a/gcc/opts.cc
+++ b/gcc/opts.cc
@@ -2168,9 +2168,9 @@ const struct sanitizer_opts_s sanitizer_opts[] =
   SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true, true),
   SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true, true),
   SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false, false),
-  SANITIZER_OPT (all, ~0U, true, true),
+  SANITIZER_OPT (all, ~0ULL, true, true),
 #undef SANITIZER_OPT
-  { NULL, 0U, 0UL, false, false }
+  { NULL, 0ULL, 0UL, false, false }
 };
 
 /* -fzero-call-used-regs= suboptions.  */
@@ -2241,7 +2241,7 @@ get_closest_sanitizer_option (const string_fragment &arg,
     {
       /* -fsanitize=all is not valid, so don't offer it.  */
       if (code == OPT_fsanitize_
-	  && opts[i].flag == ~0U
+	  && opts[i].flag == ~0ULL
 	  && value)
 	continue;
 
@@ -2268,9 +2268,9 @@ get_closest_sanitizer_option (const string_fragment &arg,
    adjust previous FLAGS and return new ones.  If COMPLAIN is false,
    don't issue diagnostics.  */
 
-unsigned int
+unsigned long long
 parse_sanitizer_options (const char *p, location_t loc, int scode,
-			 unsigned int flags, int value, bool complain)
+			 unsigned long long flags, int value, bool complain)
 {
   enum opt_code code = (enum opt_code) scode;
 
@@ -2296,7 +2296,7 @@ parse_sanitizer_options (const char *p, location_t loc, int scode,
 	    && memcmp (p, sanitizer_opts[i].name, len) == 0)
 	  {
 	    /* Handle both -fsanitize and -fno-sanitize cases.  */
-	    if (value && sanitizer_opts[i].flag == ~0U)
+	    if (value && sanitizer_opts[i].flag == ~0ULL)
 	      {
 		if (code == OPT_fsanitize_)
 		  {
@@ -2377,10 +2377,10 @@ parse_sanitizer_options (const char *p, location_t loc, int scode,
 /* Parse string values of no_sanitize attribute passed in VALUE.
    Values are separated with comma.  */
 
-unsigned int
+unsigned long long
 parse_no_sanitize_attribute (char *value)
 {
-  unsigned int flags = 0;
+  unsigned long long flags = 0;
   unsigned int i;
   char *q = strtok (value, ",");
 
-- 
2.34.1

