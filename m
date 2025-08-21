Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE827FD64
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761229; cv=none; b=NR4HI5j9sVDbmb/xw4yV8goY7uhE3/Ck4R4zAlUeMNU7Dpe8KPraidSmCq1TzzoboK8x+ZYfTeE7jVx9AYTpX0j1BDcr6KBfhxSkFCk4B5RBGhVlVnb5ASd3j10tJfv9U3PM/tkmylAxRRplmte0dCKDRVxmS5lTsdFuOvh9Fsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761229; c=relaxed/simple;
	bh=Q+Wh3qll0av1CLSS8b4lkD2Xt+0czmIDg5yEqfg3hT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+RAbAaw5d2u90SDj7bqAp3Z2bfiyyyUutvcKTrEXfM1Lwp+qp+l5fiZaCW0eTVOhJFxh2G31iMnAiQx1nVNqno4M6eWsvTTeLTm+qGtlb/1qqyIja9l4ELh/jN+DvNn9KiyEKrvqDf3F7GI+hbx5RkdMTSsWun1sujRRsxeDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBR6DjlJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBR6DjlJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013EEC113CF;
	Thu, 21 Aug 2025 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755761229;
	bh=Q+Wh3qll0av1CLSS8b4lkD2Xt+0czmIDg5yEqfg3hT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBR6DjlJkX+6doXQJYJh8jctYp98YQ61Thit30GlyLD6pdTYljlYf5/9kaC/ERamk
	 0JHx2jMId73Y1LsSbFGkrMKluDsFa713ci1lerGJEYxMxly8lpANjzk4hCEz6LHCtf
	 yU5aUbRzSjmixrPYO/9qEVSGHCfy/C4KzpZZgpN4rHqlx42bMecQZZg0SbN5W28z03
	 wVNWdVS5TwVctGct8HjavM6Ipy1JOyxsnzPUEDko9fTfskMrszU/fNuXwdbRgF10md
	 hYkjVBlnlJTqmTdMegzSwmIv5+n5ue6owjP467WuBVAxC6rCM+sMvnGI3sCLXE5rx4
	 SaFAD0mpFI2BA==
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
Subject: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Date: Thu, 21 Aug 2025 00:26:35 -0700
Message-Id: <20250821072708.3109244-2-kees@kernel.org>
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

To support the KCFI type-id which needs to convert unique function
prototypes into unique 32-bit values, add a subset of the Itanium C++
mangling ABI for C typeinfo of function prototypes. This gets us to the
first step: a string representation of the function prototype.

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

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/Makefile.in |   1 +
 gcc/mangle.h    |  29 +++
 gcc/selftest.h  |   1 +
 gcc/mangle.cc   | 548 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 579 insertions(+)
 create mode 100644 gcc/mangle.h
 create mode 100644 gcc/mangle.cc

diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index d7d5cbe72770..86f62611c1d4 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -1619,6 +1619,7 @@ OBJS = \
 	lto-section-out.o \
 	lto-opts.o \
 	lto-compress.o \
+	mangle.o \
 	mcf.o \
 	mode-switching.o \
 	modulo-sched.o \
diff --git a/gcc/mangle.h b/gcc/mangle.h
new file mode 100644
index 000000000000..94521e1e7e5c
--- /dev/null
+++ b/gcc/mangle.h
@@ -0,0 +1,29 @@
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
+
+/* Function type mangling following Itanium C++ ABI conventions.
+   Returns a static buffer containing the mangled type string.  */
+extern const char *mangle_function_type (tree fntype_or_fndecl);
+
+#endif /* GCC_MANGLE_H */
diff --git a/gcc/mangle.cc b/gcc/mangle.cc
new file mode 100644
index 000000000000..830985251c81
--- /dev/null
+++ b/gcc/mangle.cc
@@ -0,0 +1,548 @@
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
+
+/* Forward declaration for recursive type mangling.  */
+static void mangle_type_to_buffer (tree type, char **p, char *end);
+
+/* Mangle a builtin type following Itanium C++ ABI for C types.  */
+static void
+mangle_builtin_type_to_buffer (tree type, char **p, char *end)
+{
+  gcc_assert (type != NULL_TREE);
+  gcc_assert (p != NULL && *p != NULL && end != NULL);
+  gcc_assert (*p < end);
+
+  if (*p >= end)
+    return;
+
+  switch (TREE_CODE (type))
+    {
+    case VOID_TYPE:
+      **p = 'v';
+      (*p)++;
+      break;
+
+    case BOOLEAN_TYPE:
+      **p = 'b';
+      (*p)++;
+      break;
+
+    case INTEGER_TYPE:
+      /* Handle standard integer types using Itanium ABI codes.  */
+      if (type == char_type_node)
+	{
+	  **p = 'c';
+	  (*p)++;
+	}
+      else if (type == signed_char_type_node)
+	{
+	  **p = 'a';
+	  (*p)++;
+	}
+      else if (type == unsigned_char_type_node)
+	{
+	  **p = 'h';
+	  (*p)++;
+	}
+      else if (type == short_integer_type_node)
+	{
+	  **p = 's';
+	  (*p)++;
+	}
+      else if (type == short_unsigned_type_node)
+	{
+	  **p = 't';
+	  (*p)++;
+	}
+      else if (type == integer_type_node)
+	{
+	  **p = 'i';
+	  (*p)++;
+	}
+      else if (type == unsigned_type_node)
+	{
+	  **p = 'j';
+	  (*p)++;
+	}
+      else if (type == long_integer_type_node)
+	{
+	  **p = 'l';
+	  (*p)++;
+	}
+      else if (type == long_unsigned_type_node)
+	{
+	  **p = 'm';
+	  (*p)++;
+	}
+      else if (type == long_long_integer_type_node)
+	{
+	  **p = 'x';
+	  (*p)++;
+	}
+      else if (type == long_long_unsigned_type_node)
+	{
+	  **p = 'y';
+	  (*p)++;
+	}
+      else
+	{
+	  /* Fallback for other integer types - use precision-based encoding.  */
+	  *p += snprintf (*p, end - *p, "i%d", TYPE_PRECISION (type));
+	}
+      break;
+
+    case REAL_TYPE:
+      if (type == float_type_node)
+	{
+	  **p = 'f';
+	  (*p)++;
+	}
+      else if (type == double_type_node)
+	{
+	  **p = 'd';
+	  (*p)++;
+	}
+      else if (type == long_double_type_node)
+	{
+	  **p = 'e';
+	  (*p)++;
+	}
+      else
+	{
+	  /* Fallback for other real types.  */
+	  *p += snprintf (*p, end - *p, "f%d", TYPE_PRECISION (type));
+	}
+      break;
+
+    default:
+      /* Unknown builtin type - this should never happen in a well-formed C program.  */
+      error ("mangle: Unknown builtin type with %<TREE_CODE%> %d", TREE_CODE (type));
+      error ("mangle: %<TYPE_MODE%> = %d, %<TYPE_PRECISION%> = %d", TYPE_MODE (type), TYPE_PRECISION (type));
+      error ("mangle: Please report this as a bug with the above diagnostic information");
+      gcc_unreachable ();
+    }
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
+mangle_type_to_buffer (tree type, char **p, char *end)
+{
+  gcc_assert (type != NULL_TREE);
+  gcc_assert (p != NULL && *p != NULL && end != NULL);
+  gcc_assert (*p < end);
+
+  if (*p >= end)
+    return;
+
+  /* Canonicalize typedef types to their underlying named struct types.  */
+  type = canonicalize_typedef_type (type);
+
+  switch (TREE_CODE (type))
+    {
+    case POINTER_TYPE:
+      {
+	/* Pointer type: 'P' + qualifiers + pointed-to type.  */
+	**p = 'P';
+	(*p)++;
+
+	/* Add qualifiers to the pointed-to type following Itanium C++ ABI ordering.  */
+	tree pointed_to_type = TREE_TYPE (type);
+	if (TYPE_QUALS (pointed_to_type) != TYPE_UNQUALIFIED)
+	  {
+	    /* Emit qualifiers in Itanium ABI order: restrict, volatile, const.  */
+	    if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_RESTRICT)
+	      {
+		**p = 'r';
+		(*p)++;
+	      }
+	    if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_VOLATILE)
+	      {
+		**p = 'V';
+		(*p)++;
+	      }
+	    if (TYPE_QUALS (pointed_to_type) & TYPE_QUAL_CONST)
+	      {
+		**p = 'K';
+		(*p)++;
+	      }
+	    /* Note: _Atomic is not typically used in kernel code.  */
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
+	mangle_type_to_buffer (target_type, p, end);
+	break;
+      }
+
+    case ARRAY_TYPE:
+      /* Array type: 'A' + size + '_' + element type (simplified).  */
+      **p = 'A';
+      (*p)++;
+      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
+	{
+	  HOST_WIDE_INT size = tree_to_shwi (TYPE_MAX_VALUE (TYPE_DOMAIN (type))) + 1;
+	  *p += snprintf (*p, end - *p, "%ld_", (long) size);
+	}
+      else
+	{
+	  **p = '_';
+	  (*p)++;
+	}
+      mangle_type_to_buffer (TREE_TYPE (type), p, end);
+      break;
+
+    case FUNCTION_TYPE:
+      {
+	/* Function type: 'F' + return type + parameter types + 'E' */
+	**p = 'F';
+	(*p)++;
+	mangle_type_to_buffer (TREE_TYPE (type), p, end);
+
+	/* Add parameter types.  */
+	tree param_types = TYPE_ARG_TYPES (type);
+
+	if (param_types == NULL_TREE)
+	  {
+	    /* func() - variadic function, no parameter list.
+	       Don't mangle any parameters. */
+	  }
+	else
+	  {
+	    bool found_real_params = false;
+	    for (tree param = param_types; param && *p < end; param = TREE_CHAIN (param))
+	      {
+	        tree param_type = TREE_VALUE (param);
+	        if (param_type == void_type_node)
+	          {
+	            /* Check if this is the first parameter (explicit void) or a sentinel */
+	            if (!found_real_params)
+	              {
+	                /* func(void) - explicit empty parameter list.
+	                   Mangle void to distinguish from variadic func(). */
+	                mangle_type_to_buffer (void_type_node, p, end);
+	              }
+	            /* If we found real params before this void, it's a sentinel - stop */
+	            break;
+	          }
+
+	        found_real_params = true;
+
+	        /* For value parameters, ignore const/volatile qualifiers as they
+	           don't affect the calling convention.  const int and int are
+	           passed identically by value.  */
+	        tree canonical_param_type = param_type;
+	        if (TREE_CODE (param_type) != POINTER_TYPE
+	            && TREE_CODE (param_type) != REFERENCE_TYPE
+	            && TREE_CODE (param_type) != ARRAY_TYPE)
+	          {
+	            /* Strip qualifiers for non-pointer/reference value parameters.  */
+	            canonical_param_type = TYPE_MAIN_VARIANT (param_type);
+	          }
+
+	        mangle_type_to_buffer (canonical_param_type, p, end);
+	      }
+	  }
+
+	**p = 'E';
+	(*p)++;
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
+		/* For anonymous structs/enums, use Itanium-style Ut encoding with layout info for discrimination.  */
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
+		/* Generate a hash based on field layout to distinguish same-sized anonymous types.  */
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
+		  snprintf (anon_name, sizeof(anon_name), "Ut_%s_%ld_%x", type_prefix, (long)size, layout_hash);
+		else
+		  snprintf (anon_name, sizeof(anon_name), "Ut_%s_%ld", type_prefix, (long)size);
+	      }
+
+	    name = anon_name;
+	  }
+
+	if (name)
+	  {
+	    *p += snprintf (*p, end - *p, "%zu%s", strlen (name), name);
+	  }
+	else
+	  {
+	    /* Always show diagnostic information for missing struct names.  */
+	    error ("mangle: No struct/union/enum name found for type code %d (%qs)",
+		   TREE_CODE (type), get_tree_code_name (TREE_CODE (type)));
+	    if (TYPE_NAME (type))
+	      {
+		error ("mangle: %<TYPE_NAME%> exists but extraction failed");
+		error ("mangle: %<TYPE_NAME%> tree code = %d", TREE_CODE (TYPE_NAME (type)));
+		if (TREE_CODE (TYPE_NAME (type)) == TYPE_DECL)
+		  {
+		    tree decl_name = DECL_NAME (TYPE_NAME (type));
+		    error ("mangle: %<TYPE_DECL%> %<DECL_NAME%> = %p", (void*)decl_name);
+		    if (decl_name && TREE_CODE (decl_name) == IDENTIFIER_NODE)
+		      error ("mangle: %<IDENTIFIER_NODE%> name = '%s'", IDENTIFIER_POINTER (decl_name));
+		  }
+		else if (TREE_CODE (TYPE_NAME (type)) == IDENTIFIER_NODE)
+		  {
+		    error ("mangle: %<IDENTIFIER_NODE%> name = '%s'", IDENTIFIER_POINTER (TYPE_NAME (type)));
+		  }
+		else
+		  {
+		    error ("mangle: Unknown %<TYPE_NAME%> tree code = %d", TREE_CODE (TYPE_NAME (type)));
+		  }
+	      }
+	    else
+	      {
+		error ("mangle: %<TYPE_NAME%> is NULL - anonymous struct/union/enum detected");
+	      }
+
+	    /* This indicates a missing case in our struct name extraction.  */
+	    error ("mangle: Please report this as a bug with the above diagnostic information");
+	    gcc_unreachable ();
+	  }
+	break;
+      }
+
+    default:
+      /* Handle builtin types.  */
+      mangle_builtin_type_to_buffer (type, p, end);
+      break;
+    }
+}
+
+/* Compute canonical type name using Itanium C++ ABI mangling.
+   Accepts either FUNCTION_DECL (preferred for typedef preservation) or FUNCTION_TYPE.  */
+const char *
+mangle_function_type (tree fntype_or_fndecl)
+{
+  gcc_assert (fntype_or_fndecl);
+
+  tree fntype = NULL;
+
+  /* Determine input type and extract function type.  */
+  if (TREE_CODE (fntype_or_fndecl) == FUNCTION_TYPE)
+    {
+      /* Already FUNCTION_TYPE.  */
+      fntype = fntype_or_fndecl;
+    }
+  else if (TREE_CODE (fntype_or_fndecl) == FUNCTION_DECL)
+    {
+      tree fndecl = fntype_or_fndecl;
+      tree base_fntype = TREE_TYPE (fndecl);
+
+      /* For FUNCTION_DECL, build a synthetic function type using DECL_ARGUMENTS
+	 if available to preserve typedef information.  */
+      tree parm = DECL_ARGUMENTS (fndecl);
+      if (parm)
+	{
+	  /* Build parameter type list from DECL_ARGUMENTS.  */
+	  tree param_list = NULL_TREE;
+	  tree *param_tail = &param_list;
+
+	  for (; parm; parm = DECL_CHAIN (parm))
+	    {
+	      tree parm_type = TREE_TYPE (parm);
+	      *param_tail = tree_cons (NULL_TREE, parm_type, NULL_TREE);
+	      param_tail = &TREE_CHAIN (*param_tail);
+	    }
+
+	  /* Add void_type_node sentinel if the function takes no parameters.  */
+	  if (!param_list)
+	    param_list = tree_cons (NULL_TREE, void_type_node, NULL_TREE);
+
+	  /* Build synthetic function type with preserved parameter types.  */
+	  fntype = build_function_type (TREE_TYPE (base_fntype), param_list);
+	}
+      else
+	{
+	  /* No DECL_ARGUMENTS - use the standard function type.  */
+	  fntype = base_fntype;
+	}
+    }
+  else
+    {
+      /* Must only be called with FUNCTION_DECL or FUNCTION_TYPE.  */
+      gcc_unreachable ();
+    }
+
+  static char name_buf[512];
+  char *p = name_buf;
+  char *end = name_buf + sizeof (name_buf) - 1;
+
+  /* Typeinfo for a function prototype.  */
+  p += sprintf(name_buf, "_ZTSP");
+
+  /* Use mangle_type_to_buffer for all cases.  */
+  mangle_type_to_buffer (fntype, &p, end);
+
+  /* Ensure we didn't overflow the buffer.  */
+  gcc_assert (p <= end);
+  *p = '\0';
+  return name_buf;
+}
-- 
2.34.1

