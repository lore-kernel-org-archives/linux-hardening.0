Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64762A55
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031859; cv=none; b=oYlHdOEL+y+ZiOQBJsdYLQXs6pd7ZF64jl1VBGhe0cJnBaFiJk7wSag4wn3ad+6X6cteXaE6gkVB8wpTxXqY2J1JUYenEjUPG1uMUAT0NDZdUL6sTjhAWQG+vRVpgIj6684TtCj9ta3E4VNf67z1ieMGKZYB/KQkDy6DNbDmv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031859; c=relaxed/simple;
	bh=6uOI1A81vu/XXfGrOXXGTHoppUBrXRitjm2RCbCQcpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFoHmayDoNM6PypaIVFVeByscPNPH8fqawui6T+msgT+fYMEg8P0Nhhl83ObybqWU/Mhp+3RLg8/LevPybdtTAmH0djUoDc+6JZVtfgl6uWqkISfqvSLMyHRE7V2dS5vDRQuUuZURWUTFac1iVx593YfEDGrFYSDy/TzwoxVcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhQTfdAI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhQTfdAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A677C4CEF0;
	Fri,  5 Sep 2025 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757031859;
	bh=6uOI1A81vu/XXfGrOXXGTHoppUBrXRitjm2RCbCQcpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhQTfdAITdyqrflelCQ8pyDQOtrUTdi1tSKW4OWLgSHkx6mSDRuwASllh3u/PhfdH
	 oMCNuQs7PikDJ5Qk21ZKsemnZx+kKpTlJ3X7hgek4khVw4LXrFYr4BNf4NuAbqKFJq
	 qCC+URqh+a3IfYSLAHThCplQRE3PaxnWXocJFKCKgDj/dJKSSuFRJew0pZovPRmi2n
	 kFp98GysiYV9bW6Wuy91zJNU+yqW9cT6obiJa+sh19WuDkbk08dZa0IbPe0jsSRfr3
	 lQ7T7jMCT0caladVOf6tD4nKvKPhxpgEkixjGah/ZNAGUzOklH1J/lQFL1vyoSlUSP
	 0ii9liE65jdXg==
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
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
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/7] mangle: Introduce C typeinfo mangling API
Date: Thu,  4 Sep 2025 17:24:09 -0700
Message-Id: <20250905002418.464643-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905001157.it.269-kees@kernel.org>
References: <20250905001157.it.269-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21182; i=kees@kernel.org; h=from:subject; bh=6uOI1A81vu/XXfGrOXXGTHoppUBrXRitjm2RCbCQcpw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm7dNeeSLwbnFh34E5m6Bu3k9qfq7bbFHN/m9orkHkv+ lbpf7eyjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImU8jMynOxMTpO23np/3zyP Q55e57atCuEJnLCyae+faoEWnXkhZxn+SpwykvjlO5OjuoLz9L1Al8INWzZv2vq5/QzPTr9q1R4 fTgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To support the KCFI type-id which needs to convert unique function
prototypes into unique 32-bit values, add a subset of the Itanium C++
mangling ABI for C typeinfo of function prototypes, but then do
hashing, which is needed by KCFI to get a 32-bit hash value for a
given function prototype. Optionally report the mangled string
to the dumpfile.

Trying to extract only the C portions of the gcc/cp/mangle.cc code
seemed infeasible after a few attempts. So this is the minimal subset
of the mangling ABI needed to generate unique KCFI type ids.

I could not find a way to build a sensible selftest infrastructure for
this code. I wanted to do something like this:

  #ifdef CHECKING_P
  const char code[] = "
	typedef struct { int x, y } xy_t;
	extern int func(xy_t *p);
  ";

  ASSERT_MANGLE (code, "_ZTSPFiP4xy_tE");
  ...
  #endif

But I could not find any way to build a localized parser that could
parse the "code" string from which I could extract the "func" fndecl.
It would have been so much nicer to build the selftest directly into
mangle.cc here, but I couldn't figure it out. Instead, later patches
create a "kcfi" dump file, and the large kcfi testsuite validates
expected mangle strings as part of the type-id validation.

gcc/ChangeLog:

	* Makefile.in: Add mangle.o to build.
	* mangle.cc: New file. Implement C typeinfo mangling for KCFI.
	* mangle.h: New file. Export hash_function_type function.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/Makefile.in |   1 +
 gcc/mangle.h    |  32 +++
 gcc/mangle.cc   | 512 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 545 insertions(+)
 create mode 100644 gcc/mangle.h
 create mode 100644 gcc/mangle.cc

diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index d2744db843d7..4c12ac68d979 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1617,6 +1617,7 @@ OBJS = \
 	lto-section-out.o \
 	lto-opts.o \
 	lto-compress.o \
+	mangle.o \
 	mcf.o \
 	mode-switching.o \
 	modulo-sched.o \
diff --git a/gcc/mangle.h b/gcc/mangle.h
new file mode 100644
index 000000000000..fe7916dd68e0
--- /dev/null
+++ b/gcc/mangle.h
@@ -0,0 +1,32 @@
+/* Itanium C++ ABI type mangling for GCC.
+   Copyright (C) 2025 Free Software Foundation, Inc.
+
+This file is part of GCC.
+
+GCC is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 3, or (at your option) any later
+version.
+
+GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+for more details.
+
+You should have received a copy of the GNU General Public License
+along with GCC; see the file COPYING3.  If not see
+<http://www.gnu.org/licenses/>.  */
+
+#ifndef GCC_MANGLE_H
+#define GCC_MANGLE_H
+
+#include "tree.h"
+#include <string>
+
+/* Function type hashing following Itanium C++ ABI conventions.
+   Returns the FNV-1a hash of the mangled type string.
+   Builds the actual string only if dump is active for debugging.
+   Optional fndecl parameter provides function context for error reporting.  */
+extern uint32_t hash_function_type (tree fntype, tree fndecl = NULL_TREE);
+
+#endif /* GCC_MANGLE_H */
diff --git a/gcc/mangle.cc b/gcc/mangle.cc
new file mode 100644
index 000000000000..8f177a415e15
--- /dev/null
+++ b/gcc/mangle.cc
@@ -0,0 +1,512 @@
+/* Itanium C++ ABI type mangling for GCC.
+   Copyright (C) 2025 Free Software Foundation, Inc.
+
+This file is part of GCC.
+
+GCC is free software; you can redistribute it and/or modify it under
+the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 3, or (at your option) any later
+version.
+
+GCC is distributed in the hope that it will be useful, but WITHOUT ANY
+WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+for more details.
+
+You should have received a copy of the GNU General Public License
+along with GCC; see the file COPYING3.  If not see
+<http://www.gnu.org/licenses/>.  */
+
+#include "config.h"
+#include "system.h"
+#include "coretypes.h"
+#include "tree.h"
+#include "diagnostic-core.h"
+#include "stringpool.h"
+#include "stor-layout.h"
+#include "mangle.h"
+#include "selftest.h"
+#include "dumpfile.h"
+#include "print-tree.h"
+
+/* Current function context for better error reporting.  */
+static tree current_function_context = NULL_TREE;
+
+/* Helper to update FNV-1a hash with a single character.  */
+static inline void
+fnv1a_hash_char (uint32_t *hash_state, unsigned char c)
+{
+  *hash_state ^= c;
+  *hash_state *= 16777619U; /* FNV-1a 32-bit prime.  */
+}
+
+/* Helper to append character to optional string and update hash using FNV-1a.  */
+static void
+append_char (char c, std::string *out_str, uint32_t *hash_state)
+{
+  if (out_str)
+    *out_str += c;
+  fnv1a_hash_char (hash_state, (unsigned char) c);
+}
+
+/* Helper to append string to optional string and update hash using FNV-1a.  */
+static void
+append_string (const char *str, std::string *out_str, uint32_t *hash_state)
+{
+  if (out_str)
+    *out_str += str;
+  for (const char *p = str; *p; p++)
+    fnv1a_hash_char (hash_state, (unsigned char) *p);
+}
+
+/* Forward declaration for recursive type mangling.  */
+static void mangle_type (tree type, std::string *out_str, uint32_t *hash_state);
+
+/* Mangle a builtin type following Itanium C++ ABI for C types.  */
+static void
+mangle_builtin_type (tree type, std::string *out_str, uint32_t *hash_state)
+{
+  gcc_assert (type != NULL_TREE);
+
+  switch (TREE_CODE (type))
+    {
+    case VOID_TYPE:
+      append_char ('v', out_str, hash_state);
+      return;
+
+    case BOOLEAN_TYPE:
+      append_char ('b', out_str, hash_state);
+      return;
+
+    case INTEGER_TYPE:
+      /* Handle standard integer types using Itanium ABI codes.  */
+      if (type == char_type_node)
+	append_char ('c', out_str, hash_state);
+      else if (type == signed_char_type_node)
+	append_char ('a', out_str, hash_state);
+      else if (type == unsigned_char_type_node)
+	append_char ('h', out_str, hash_state);
+      else if (type == short_integer_type_node)
+	append_char ('s', out_str, hash_state);
+      else if (type == short_unsigned_type_node)
+	append_char ('t', out_str, hash_state);
+      else if (type == integer_type_node)
+	append_char ('i', out_str, hash_state);
+      else if (type == unsigned_type_node)
+	append_char ('j', out_str, hash_state);
+      else if (type == long_integer_type_node)
+	append_char ('l', out_str, hash_state);
+      else if (type == long_unsigned_type_node)
+	append_char ('m', out_str, hash_state);
+      else if (type == long_long_integer_type_node)
+	append_char ('x', out_str, hash_state);
+      else if (type == long_long_unsigned_type_node)
+	append_char ('y', out_str, hash_state);
+      else
+	{
+	  /* Fallback for other integer types - use precision-based encoding.  */
+	  append_char ('i', out_str, hash_state);
+	  append_string (std::to_string (TYPE_PRECISION (type)).c_str (), out_str, hash_state);
+	}
+      return;
+
+    case REAL_TYPE:
+      if (type == float_type_node)
+	append_char ('f', out_str, hash_state);
+      else if (type == double_type_node)
+	append_char ('d', out_str, hash_state);
+      else if (type == long_double_type_node)
+	append_char ('e', out_str, hash_state);
+      else
+	{
+	  /* Fallback for other real types.  */
+	  append_char ('f', out_str, hash_state);
+	  append_string (std::to_string (TYPE_PRECISION (type)).c_str (), out_str, hash_state);
+	}
+      return;
+
+    case VECTOR_TYPE:
+      {
+	/* Handle vector types following Itanium C++ ABI:
+	   Dv<num-elements>_<element-type-encoding>
+	   Example: uint8x16_t → Dv16_h (vector of 16 unsigned char)  */
+	tree vector_size = TYPE_SIZE_UNIT (type);
+	tree element_type = TREE_TYPE (type);
+	tree element_size = TYPE_SIZE_UNIT (element_type);
+
+	if (vector_size && element_size &&
+	    TREE_CODE (vector_size) == INTEGER_CST &&
+	    TREE_CODE (element_size) == INTEGER_CST)
+	  {
+	    append_char ('D', out_str, hash_state);
+	    append_char ('v', out_str, hash_state);
+
+	    unsigned HOST_WIDE_INT vec_bytes = tree_to_uhwi (vector_size);
+	    unsigned HOST_WIDE_INT elem_bytes = tree_to_uhwi (element_size);
+	    unsigned HOST_WIDE_INT num_elements = vec_bytes / elem_bytes;
+
+	    /* Append number of elements.  */
+	    append_string (std::to_string (num_elements).c_str (), out_str, hash_state);
+	    append_char ('_', out_str, hash_state);
+
+	    /* Recursively mangle the element type.  */
+	    mangle_type (element_type, out_str, hash_state);
+	    return;
+	  }
+	/* Fail for vectors with unknown size.  */
+      }
+      break;
+
+    default:
+      break;
+    }
+
+  /* Unknown builtin type - this should never happen in a well-formed C program.  */
+  debug_tree (type);
+  internal_error ("mangle: Unknown builtin type in function %qD - please report this as a bug",
+                  current_function_context);
+}
+
+/* Canonicalize typedef types to their underlying named struct/union types.  */
+static tree
+canonicalize_typedef_type (tree type)
+{
+  /* Handle typedef types - canonicalize to named structs when possible.  */
+  if (TYPE_NAME (type) && TREE_CODE (TYPE_NAME (type)) == TYPE_DECL)
+    {
+      tree type_decl = TYPE_NAME (type);
+
+      /* Check if this is a typedef (not the original struct declaration) */
+      if (DECL_ORIGINAL_TYPE (type_decl))
+	{
+	  tree original_type = DECL_ORIGINAL_TYPE (type_decl);
+
+	  /* If the original type is a named struct/union/enum, use that instead.  */
+	  if ((TREE_CODE (original_type) == RECORD_TYPE
+	       || TREE_CODE (original_type) == UNION_TYPE
+	       || TREE_CODE (original_type) == ENUMERAL_TYPE)
+	      && TYPE_NAME (original_type)
+	      && ((TREE_CODE (TYPE_NAME (original_type)) == TYPE_DECL
+		   && DECL_NAME (TYPE_NAME (original_type)))
+		  || TREE_CODE (TYPE_NAME (original_type)) == IDENTIFIER_NODE))
+	    {
+	      /* Recursively canonicalize in case the original type is also a typedef.  */
+	      return canonicalize_typedef_type (original_type);
+	    }
+
+	  /* For basic type typedefs (e.g., u8 -> unsigned char), canonicalize to original type.  */
+	  if (TREE_CODE (original_type) == INTEGER_TYPE
+	      || TREE_CODE (original_type) == REAL_TYPE
+	      || TREE_CODE (original_type) == POINTER_TYPE
+	      || TREE_CODE (original_type) == ARRAY_TYPE
+	      || TREE_CODE (original_type) == FUNCTION_TYPE
+	      || TREE_CODE (original_type) == METHOD_TYPE
+	      || TREE_CODE (original_type) == BOOLEAN_TYPE
+	      || TREE_CODE (original_type) == COMPLEX_TYPE
+	      || TREE_CODE (original_type) == VECTOR_TYPE)
+	    {
+	      /* Recursively canonicalize in case the original type is also a typedef.  */
+	      return canonicalize_typedef_type (original_type);
+	    }
+	}
+    }
+
+  return type;
+}
+
+/* Recursively mangle a type following Itanium C++ ABI conventions.  */
+static void
+mangle_type (tree type, std::string *out_str, uint32_t *hash_state)
+{
+  gcc_assert (type != NULL_TREE);
+
+  /* Canonicalize typedef types to their underlying named struct types.  */
+  type = canonicalize_typedef_type (type);
+
+  switch (TREE_CODE (type))
+    {
+    case POINTER_TYPE:
+      {
+	/* Pointer type: 'P' + qualifiers + pointed-to type.  */
+	append_char ('P', out_str, hash_state);
+
+	/* Add qualifiers to the pointed-to type following Itanium C++ ABI ordering.  */
+	tree pointed_to_type = TREE_TYPE (type);
+	if (TYPE_QUALS (pointed_to_type) != TYPE_UNQUALIFIED)
+	  {
+	    /* Emit qualifiers in Itanium ABI order: restrict, volatile, const.  */
+	    if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_RESTRICT)
+	      append_char ('r', out_str, hash_state);
+	    if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_VOLATILE)
+	      append_char ('V', out_str, hash_state);
+	    if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_CONST)
+	      append_char ('K', out_str, hash_state);
+	  }
+
+	/* For KCFI's hybrid type system: preserve typedef names for compound types,
+	   but use canonical forms for primitive types.  */
+	tree target_type;
+	if (TREE_CODE (pointed_to_type) == RECORD_TYPE
+	    || TREE_CODE (pointed_to_type) == UNION_TYPE
+	    || TREE_CODE (pointed_to_type) == ENUMERAL_TYPE)
+	  {
+	    /* Compound type: preserve typedef information by using original type.  */
+	    target_type = pointed_to_type;
+	  }
+	else
+	  {
+	    /* Primitive type: use canonical form to ensure structural typing.  */
+	    target_type = TYPE_MAIN_VARIANT (pointed_to_type);
+	  }
+	mangle_type (target_type, out_str, hash_state);
+	break;
+      }
+
+    case ARRAY_TYPE:
+      /* Array type: 'A' + size + '_' + element type (simplified).  */
+      append_char ('A', out_str, hash_state);
+      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
+	{
+	  tree max_val = TYPE_MAX_VALUE (TYPE_DOMAIN (type));
+	  /* Check if array size is a compile-time constant to handle VLAs safely.  */
+	  if (TREE_CODE (max_val) == INTEGER_CST && tree_fits_shwi_p (max_val))
+	    {
+	      HOST_WIDE_INT size = tree_to_shwi (max_val) + 1;
+	      append_string (std::to_string ((long) size).c_str (), out_str, hash_state);
+	    }
+	  /* For VLAs or non-constant dimensions, emit empty size (A_).  */
+	  append_char ('_', out_str, hash_state);
+	}
+      else
+	{
+	  /* No domain or no max value - emit A_.  */
+	  append_char ('_', out_str, hash_state);
+	}
+      mangle_type (TREE_TYPE (type), out_str, hash_state);
+      break;
+
+    case REFERENCE_TYPE:
+      /* Reference type: 'R' + referenced type.
+         Note: We must handle references to builtin types including compiler
+         builtins like __builtin_va_list used in functions like va_start. */
+      append_char ('R', out_str, hash_state);
+      mangle_type (TREE_TYPE (type), out_str, hash_state);
+      break;
+
+    case FUNCTION_TYPE:
+      {
+	/* Function type: 'F' + return type + parameter types + 'E' */
+	append_char ('F', out_str, hash_state);
+	mangle_type (TREE_TYPE (type), out_str, hash_state);
+
+	/* Add parameter types.  */
+	tree param_types = TYPE_ARG_TYPES (type);
+
+	if (param_types == NULL_TREE)
+	  {
+	    /* func() - no parameter list (could be variadic). */
+	  }
+	else
+	  {
+	    bool found_real_params = false;
+	    for (tree param = param_types; param; param = TREE_CHAIN (param))
+	      {
+		tree param_type = TREE_VALUE (param);
+		if (param_type == void_type_node)
+		  {
+		    /* Check if this is the first parameter (explicit void) or a sentinel */
+		    if (!found_real_params)
+		      {
+			/* func(void) - explicit empty parameter list.
+			   Mangle void to distinguish from variadic func(). */
+			mangle_type (void_type_node, out_str, hash_state);
+		      }
+		    /* If we found real params before this void, it's a sentinel - stop */
+		    break;
+		  }
+
+		found_real_params = true;
+
+		/* For value parameters, ignore const/volatile qualifiers as they
+		   don't affect the calling convention.  const int and int are
+		   passed identically by value.  */
+		tree canonical_param_type = param_type;
+		if (TREE_CODE (param_type) != POINTER_TYPE
+		    && TREE_CODE (param_type) != REFERENCE_TYPE
+		    && TREE_CODE (param_type) != ARRAY_TYPE)
+		  {
+		    /* Strip qualifiers for non-pointer/reference value parameters.  */
+		    canonical_param_type = TYPE_MAIN_VARIANT (param_type);
+		  }
+
+		mangle_type (canonical_param_type, out_str, hash_state);
+	      }
+	  }
+
+	/* Check if this is a variadic function and add 'z' marker.  */
+	if (stdarg_p (type))
+	  {
+	    append_char ('z', out_str, hash_state);
+	  }
+
+	append_char ('E', out_str, hash_state);
+	break;
+      }
+
+    case RECORD_TYPE:
+    case UNION_TYPE:
+    case ENUMERAL_TYPE:
+      {
+	/* Struct/union/enum: use simplified representation for C types.  */
+	const char *name = NULL;
+
+	if (TYPE_NAME (type))
+	  {
+	    if (TREE_CODE (TYPE_NAME (type)) == TYPE_DECL)
+	      {
+		/* TYPE_DECL case: both named structs and typedef structs.  */
+		tree decl_name = DECL_NAME (TYPE_NAME (type));
+		if (decl_name && TREE_CODE (decl_name) == IDENTIFIER_NODE)
+		  {
+		    name = IDENTIFIER_POINTER (decl_name);
+		  }
+	      }
+	    else if (TREE_CODE (TYPE_NAME (type)) == IDENTIFIER_NODE)
+	      {
+		/* Direct identifier case.  */
+		name = IDENTIFIER_POINTER (TYPE_NAME (type));
+	      }
+	  }
+
+	/* If no name found through normal extraction, handle anonymous types following Itanium C++ ABI.  */
+	if (!name && !TYPE_NAME (type))
+	  {
+	    static char anon_name[128];
+
+	    if (TREE_CODE (type) == UNION_TYPE)
+	      {
+		/* For anonymous unions, try to find first named field (Itanium ABI approach).  */
+		tree field = TYPE_FIELDS (type);
+		while (field && !DECL_NAME (field))
+		  field = DECL_CHAIN (field);
+
+		if (field && DECL_NAME (field))
+		  {
+		    const char *field_name = IDENTIFIER_POINTER (DECL_NAME (field));
+		    snprintf (anon_name, sizeof(anon_name), "anon_union_by_%s", field_name);
+		  }
+		else
+		  {
+		    /* No named fields - use Itanium-style Ut encoding.  */
+		    snprintf (anon_name, sizeof(anon_name), "Ut_unnamed_union");
+		  }
+	      }
+	    else
+	      {
+		/* For anonymous structs/enums, use Itanium-style Ut encoding
+		   with layout info for discrimination.  */
+		const char *type_prefix = "";
+		if (TREE_CODE (type) == RECORD_TYPE)
+		  type_prefix = "struct";
+		else if (TREE_CODE (type) == ENUMERAL_TYPE)
+		  type_prefix = "enum";
+
+		/* Include size and field layout for better discrimination.  */
+		HOST_WIDE_INT size = 0;
+		if (TYPE_SIZE (type) && tree_fits_shwi_p (TYPE_SIZE (type)))
+		  size = tree_to_shwi (TYPE_SIZE (type));
+
+		/* Generate a hash based on field layout to distinguish same-sized
+		   anonymous types.  */
+		unsigned layout_hash = 0;
+		if (TREE_CODE (type) == RECORD_TYPE)
+		  {
+		    for (tree field = TYPE_FIELDS (type); field; field = DECL_CHAIN (field))
+		      {
+			if (TREE_CODE (field) == FIELD_DECL)
+			  {
+			    /* Hash field offset and type.  */
+			    if (DECL_FIELD_OFFSET (field))
+			      {
+				HOST_WIDE_INT offset = tree_to_shwi (DECL_FIELD_OFFSET (field));
+				layout_hash = layout_hash * 31 + (unsigned)offset;
+			      }
+
+			    /* Hash field type.  */
+			    tree field_type = TREE_TYPE (field);
+			    if (field_type && TYPE_MODE (field_type) != VOIDmode)
+			      layout_hash = layout_hash * 37 + (unsigned)TYPE_MODE (field_type);
+			  }
+		      }
+		  }
+
+		if (layout_hash != 0)
+		  snprintf (anon_name, sizeof(anon_name), "Ut_%s_%ld_%x",
+			    type_prefix, (long)size, layout_hash);
+		else
+		  snprintf (anon_name, sizeof(anon_name), "Ut_%s_%ld",
+			    type_prefix, (long)size);
+	      }
+
+	    name = anon_name;
+	  }
+
+	if (name)
+	  {
+	    append_string (std::to_string (strlen (name)).c_str (), out_str, hash_state);
+	    append_string (name, out_str, hash_state);
+	  }
+	else
+	  {
+	    /* Always show diagnostic information for missing struct names.  */
+	    debug_tree (type);
+	    internal_error ("mangle: Missing case in struct name extraction - please report this as a bug");
+	  }
+	break;
+      }
+
+    default:
+      /* Handle builtin types.  */
+      mangle_builtin_type (type, out_str, hash_state);
+      break;
+    }
+}
+
+/* Compute canonical function type hash using Itanium C++ ABI mangling.  */
+uint32_t
+hash_function_type (tree fntype, tree fndecl)
+{
+  gcc_assert (fntype);
+  gcc_assert (TREE_CODE (fntype) == FUNCTION_TYPE);
+
+  std::string result;
+  std::string *out_str = nullptr;
+  uint32_t hash_state = 2166136261U; /* FNV-1a 32-bit offset basis.  */
+
+  /* Only build string if dump is active.  */
+  if (dump_file && (dump_flags & TDF_DETAILS))
+    {
+      result.reserve (32);
+      out_str = &result;
+    }
+
+  /* Store function context for error reporting.  */
+  current_function_context = fndecl;
+
+  /* Typeinfo for a function prototype.  */
+  append_string ("_ZTS", out_str, &hash_state);
+
+  mangle_type (fntype, out_str, &hash_state);
+
+  /* Clear function context.  */
+  current_function_context = NULL_TREE;
+
+  /* Output to dump file if enabled.  */
+  if (dump_file && (dump_flags & TDF_DETAILS))
+    {
+      fprintf (dump_file, "KCFI type ID: mangled='%s' typeid=0x%08x\n",
+	       result.c_str (), hash_state);
+    }
+
+  return hash_state;
+}
-- 
2.34.1

