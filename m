Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02A230BEC
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007616; cv=none; b=dH8WtiiOLBknyvuRKwZS/k6m82g6/ufUfLn7JUli4t6h/qbERt9FHaBpQtNojNj4svWHRyvDFvyGI7uglO9TH2Cwb0tkfGgHOS172YWcOcJ3Zr72O+A6NfhGqofD3RK+KlJDpJYWm1W6f9Rt4JnlKKWZRB39n0izBVk6hOkfrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007616; c=relaxed/simple;
	bh=D5Phpn6y3fU+4beeWzw/j3xTj8ogkr6+YYpQj1NpqQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd+GxEqN2t1qtpRxzVQxQXIJXIbOXJL7N5WVTzc44HfmuuY+3yg9dWgDkJbhzp0pg0awXuxJtxsezaDQaFI4u+AWrv6lrkjIw2bWwAL2fhLhM6fJedYY9LCkqKLuuK297ydLs72BDN1GH6slBQ2RzXGyYfmF7Pwd9W7gbzLw6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOUnwMtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOUnwMtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12257C4CEF0;
	Thu,  4 Sep 2025 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007616;
	bh=D5Phpn6y3fU+4beeWzw/j3xTj8ogkr6+YYpQj1NpqQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOUnwMtVvp2AH7EKXhyGvnvzenDi0Wpz5oGtoo1VyFSUp+CU0dcRTiE42+B5UPaAI
	 aQKBjf0yJje7bLykhem6kLVzW9/+PzaOfC1X8Q+u6nU6MrN3ZaxOLsYRn0DN9yL+Gb
	 I/w4zsVL9WjlL6G0X3ZcfpmMf/QuWZ/beht3Xim2uju8pBWHspoQVlBfjOO4qeh4Ju
	 I2RGgFKywFWdEehlHDUH+FsU89JDqW3Mu3AY7zWRqoK2AS6xi9srC1Pnvt0pbiPLZh
	 01VG+MHO0q28MI7aVJm+Y9nIIAmlxqdHcXHj7vq+e6zUDDrxinPwSGCZKKw6+NYkwX
	 gB8r5gtgjPNXA==
Date: Thu, 4 Sep 2025 10:40:15 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>,
	Claudiu Zissulescu-Ianculescu <claudiu.zissulescu-ianculescu@oracle.com>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3] Fix sanitizer attribute infrastructure to use
 standard TREE_LIST format [PR113264]
Message-ID: <202509040947.6A19B67@keescook>
References: <20250826172500.make.968-kees@kernel.org>
 <DC56CD19-C342-4443-B308-945C860B9A3A@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DC56CD19-C342-4443-B308-945C860B9A3A@oracle.com>

On Tue, Aug 26, 2025 at 06:22:31PM +0000, Qing Zhao wrote:
> Hi, Kees,
> 
> > On Aug 26, 2025, at 13:25, Kees Cook <kees@kernel.org> wrote:
> > 
> > The __attribute__((__copy__)) functionality was crashing when copying
> > sanitizer-related attributes because these attributes violated the standard
> > GCC attribute infrastructure by storing INTEGER_CST values directly instead
> > of wrapping them in TREE_LIST like all other attributes.
> 
> From my understanding of the problem and your patch, the major issue is in the 
> routine “add_no_sanitize_value”,  in which, the flags is not been wrapped in TREE_LIST
> as the handling of all other attributes. 
> 
> Since all the following routines called the routine “add_no_sanitize_value”:
> 
> handle_no_sanitize_attribute			// for attribute “no_sanitize"
> handle_no_sanitize_address_attribute	// for attribute “no_sanitize_address”
> handle_no_sanitize_thread_attribute	// for attribute “no_sanitize_thread"
> handle_no_address_safety_analysis_attribute	// for attribute “no_address_safety_analysis"
> handle_no_sanitize_undefined_attribute	// for attribute “no_sanitize_undefined”
> 
> So, all the above attributes have the same issue. 

Yes, and that's what I try to test in gcc/testsuite/gcc.dg/pr113264.c.
FWIW, I hit this bug due to trying to copy a func that had no_sanitize("kcfi").

> However, the handling of the attribute “copy” doesn’t have any issue. 

I don't know how to answer this question. :) "copy" is expecting
TREE_LIST for all attributes, but the sanitizer is using INTEGER_CST. So
either copy is wrong (and needs to handle INTEGER_CST) or sanitizer is
wrong and needs to use TREE_LIST. When I originally tackled this, I
tried to teach "copy" how to deal with INTEGER_CST, but it created way
more problems, so I took the path of fixing sanitizer to use TREE_LIST.

> Is the above correct understanding?
> 
> > 
> > Wrap sanitizer attributes INTEGER_CST values in TREE_LIST structures
> > to follow the same pattern as other attributes. This eliminates the
> > copy_list() crashes when copying sanitizer attributes:
> > 
> > test.c:4:1: internal compiler error: tree check: expected tree that contains ‘common’ structure, have ‘integer_cst’ in copy_list, at tree.cc:1427
> >    4 | __attribute__((__copy__(__tanh)));
> >      | ^~~~~~~~~~~~~
> > 0x859d06 tree_contains_struct_check_failed(tree_node const*, tree_node_structure_enum, char const*, int, char const*)
> >        ../../gcc/gcc/tree.cc:9126
> > 0x860f78 contains_struct_check(tree_node*, tree_node_structure_enum, char const*, int, char const*)
> >        ../../gcc/gcc/tree.h:3748
> > 0x860f78 copy_list(tree_node*)
> >        ../../gcc/gcc/tree.cc:1427
> > 0xa755a5 handle_copy_attribute
> >        ../../gcc/gcc/c-family/c-attribs.cc:3077
> > 
> > gcc/c-family/ChangeLog:
> > 
> > PR c/113264
> > * c-attribs.cc (add_no_sanitize_value): Store INTEGER_CST values
> > wrapped in TREE_LIST following standard attribute conventions.
> > (handle_no_sanitize_attribute): Handle both original string
> > arguments and copied INTEGER_CST values from TREE_LIST format.
> > 
> > gcc/ChangeLog:
> > 
> > PR c/113264
> > * asan.h (sanitize_flags_p): Extract sanitizer flags from
> > TREE_LIST wrapper instead of directly from INTEGER_CST.
> > 
> > gcc/d/ChangeLog:
> > 
> > PR c/113264
> > * d-attribs.cc (d_handle_no_sanitize_attribute): Store INTEGER_CST
> > values wrapped in TREE_LIST following standard conventions.
> > 
> > gcc/testsuite/ChangeLog:
> > 
> > PR c/113264
> > * gcc.dg/pr113264.c: New test.
> > * gcc.dg/pr113264-asan-no-instrumentation.c: New test validating
> > that copied sanitizer attributes prevent ASAN instrumentation.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > v3: now with the tests actually included. Argh
> > Cc: Indu Bhagat <indu.bhagat@oracle.com>
> > Cc: Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>
> > Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> > ---
> > gcc/asan.h                                    |  8 ++-
> > .../gcc.dg/pr113264-asan-no-instrumentation.c | 43 +++++++++++
> > gcc/testsuite/gcc.dg/pr113264.c               | 72 +++++++++++++++++++
> > gcc/c-family/c-attribs.cc                     | 49 +++++++++----
> > gcc/d/d-attribs.cc                            | 17 +++--
> > 5 files changed, 169 insertions(+), 20 deletions(-)
> > create mode 100644 gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
> > create mode 100644 gcc/testsuite/gcc.dg/pr113264.c
> > 
> > diff --git a/gcc/asan.h b/gcc/asan.h
> > index a24562f67a29..f5dc3d7ceb8d 100644
> > --- a/gcc/asan.h
> > +++ b/gcc/asan.h
> > @@ -253,7 +253,13 @@ sanitize_flags_p (sanitize_code_type flag,
> >     {
> >       tree value = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (fn));
> >       if (value)
> > - result_flags &= ~tree_to_uhwi (TREE_VALUE (value));
> > + {
> > +  /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> > +  tree attr_args = TREE_VALUE (value);
> > +  gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
> > +  sanitize_code_type no_sanitize_flags = tree_to_sanitize_code_type (TREE_VALUE (attr_args));
> > +  result_flags &= ~no_sanitize_flags;
> > + }
> >     }
> > 
> >   return result_flags;
> > diff --git a/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c b/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
> > new file mode 100644
> > index 000000000000..d99819b4792f
> > --- /dev/null
> > +++ b/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
> > @@ -0,0 +1,43 @@
> > +/* PR c/113264 - __attribute__((copy)) crashes with sanitizer attributes
> > +   Test that copied no_sanitize_address attributes prevent ALL ASAN instrumentation.
> > +   This file should have NO ASAN calls since all functions have the attribute.
> > +   { dg-do compile }
> > +   { dg-options "-fsanitize=address" }
> > +   { dg-skip-if "no address sanitizer" { no_fsanitize_address } } */
> > +
> > +/* Original function with no_sanitize_address */
> > +__attribute__((no_sanitize_address))
> > +int original (int *p, int *q)
> > +{
> > +  *p = 42;
> > +  return *q;
> > +}
> > +
> > +/* Copy the attribute - should also have no_sanitize_address */
> > +__typeof(original) copy1 __attribute__((__copy__(original)));
> > +int copy1 (int *p, int *q)
> > +{
> > +  *p = 43;
> > +  return *q;
> > +}
> > +
> > +/* Another copy - should also have no_sanitize_address */
> > +__typeof(original) copy2 __attribute__((__copy__(original)));
> > +int copy2 (int *p, int *q)
> > +{
> > +  *p = 44;
> > +  return *q;
> > +}
> > +
> > +/* Copy from a copy - should still have no_sanitize_address */
> > +__typeof(copy1) copy_of_copy __attribute__((__copy__(copy1)));
> > +int copy_of_copy (int *p, int *q)
> > +{
> > +  *p = 45;
> > +  return *q;
> > +}
> > +
> > +/* Since ALL functions have no_sanitize_address (either directly or copied),
> > +   there should be NO ASAN instrumentation calls in the entire file. */
> > +/* { dg-final { scan-assembler-not "__asan_report_store" } } */
> > +/* { dg-final { scan-assembler-not "__asan_report_load" } } */
> > diff --git a/gcc/testsuite/gcc.dg/pr113264.c b/gcc/testsuite/gcc.dg/pr113264.c
> > new file mode 100644
> > index 000000000000..7a1b128bf203
> > --- /dev/null
> > +++ b/gcc/testsuite/gcc.dg/pr113264.c
> > @@ -0,0 +1,72 @@
> > +/* PR c/113264 - __attribute__((copy)) crashes with sanitizer attributes
> > +   Test that the copy attribute correctly handles sanitizer attributes
> > +   which store their arguments as INTEGER_CST values rather than TREE_LIST.
> > +   { dg-do compile }
> > +   { dg-options "-O2" } */
> > +
> > +/* Test copying no_sanitize_address attribute.  */
> > +__attribute__((no_sanitize_address)) void f1 (void);
> > +__typeof(f1) f1_copy __attribute__((__copy__(f1)));
> > +
> > +/* Test copying no_sanitize_thread attribute.  */
> > +__attribute__((no_sanitize_thread)) void f2 (void);
> > +__typeof(f2) f2_copy __attribute__((__copy__(f2)));
> > +
> > +/* Test copying no_sanitize_undefined attribute.  */
> > +__attribute__((no_sanitize_undefined)) void f3 (void);
> > +__typeof(f3) f3_copy __attribute__((__copy__(f3)));
> > +
> > +/* Test copying no_sanitize_coverage attribute.  */
> > +__attribute__((no_sanitize_coverage)) void f4 (void);
> > +__typeof(f4) f4_copy __attribute__((__copy__(f4)));
> > +
> > +/* Test copying no_sanitize attribute with string arguments.  */
> > +__attribute__((no_sanitize("address"))) void f5 (void);
> > +__typeof(f5) f5_copy __attribute__((__copy__(f5)));
> > +
> > +__attribute__((no_sanitize("thread"))) void f6 (void);
> > +__typeof(f6) f6_copy __attribute__((__copy__(f6)));
> > +
> > +__attribute__((no_sanitize("undefined"))) void f7 (void);
> > +__typeof(f7) f7_copy __attribute__((__copy__(f7)));
> > +
> > +/* Test copying multiple sanitizer flags.  */
> > +__attribute__((no_sanitize("address", "thread"))) void f8 (void);
> > +__typeof(f8) f8_copy __attribute__((__copy__(f8)));
> > +
> > +/* Test the original bug report case.  This may trigger a warning
> > +   about conflicting with a built-in function name.  */
> > +__attribute__((no_sanitize_address)) void h (void);
> > +__typeof(h) tanhf64 __attribute__((__copy__(h)));
> > +/* { dg-warning "conflicting types for built-in function" "" { target *-*-* } .-1 } */
> > +
> > +/* Test copying from a function pointer variable - this should trigger a warning.  */
> > +__attribute__((no_sanitize_address)) void f9 (void);
> > +void (*f9_ptr)(void) = f9; /* { dg-message "symbol 'f9_ptr' referenced" } */
> > +__typeof(f9) f9_ptr_copy __attribute__((__copy__(*f9_ptr))); /* { dg-warning "'copy' attribute ignored" } */
> > +
> > +/* Test with actual function definitions to ensure attributes are properly applied.  */
> > +__attribute__((no_sanitize_address))
> > +void actual_func (int *p)
> > +{
> > +  *p = 100;
> > +}
> > +
> > +__typeof(actual_func) actual_func_copy __attribute__((__copy__(actual_func)));
> > +
> > +void actual_func_copy (int *p)
> > +{
> > +  *p = 200;
> > +}
> > +
> > +/* Test copying sanitizer attributes along with other attributes.  */
> > +__attribute__((no_sanitize_address, noinline, cold))
> > +void multi_attr (void);
> > +
> > +__typeof(multi_attr) multi_attr_copy __attribute__((__copy__(multi_attr)));
> > +
> > +/* Verify that the copy attribute works with function declarations that
> > +   have sanitizer attributes applied via separate declarations.  */
> > +void separate_decl (void);
> > +__attribute__((no_sanitize_address)) void separate_decl (void);
> > +__typeof(separate_decl) separate_decl_copy __attribute__((__copy__(separate_decl)));
> > diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
> > index 1e3a94ed9493..e629601579ef 100644
> > --- a/gcc/c-family/c-attribs.cc
> > +++ b/gcc/c-family/c-attribs.cc
> > @@ -1425,20 +1425,27 @@ add_no_sanitize_value (tree node, sanitize_code_type flags)
> >   tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (node));
> >   if (attr)
> >     {
> > -      sanitize_code_type old_value =
> > - tree_to_sanitize_code_type (TREE_VALUE (attr));
> > +      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> > +      tree attr_args = TREE_VALUE (attr);
> > +      gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
> > +      sanitize_code_type old_value = tree_to_sanitize_code_type (TREE_VALUE (attr_args));
> > +
> >       flags |= old_value;
> > 
> >       if (flags == old_value)
> > return;
> > 
> > -      TREE_VALUE (attr) = build_int_cst (uint64_type_node, flags);
> > +      tree new_value = build_tree_list (NULL_TREE,
> > + build_int_cst (uint64_type_node, flags));
> > +      TREE_VALUE (attr) = new_value;
> >     }
> >   else
> > -    DECL_ATTRIBUTES (node)
> > -      = tree_cons (get_identifier ("no_sanitize"),
> > -   build_int_cst (uint64_type_node, flags),
> > -   DECL_ATTRIBUTES (node));
> > +    {
> > +      tree attr_value = build_tree_list (NULL_TREE,
> > + build_int_cst (uint64_type_node, flags));
> > +      DECL_ATTRIBUTES (node) = tree_cons (get_identifier ("no_sanitize"), attr_value,
> > +  DECL_ATTRIBUTES (node));
> > +    }
> > }
> > 
> > /* Handle a "no_sanitize" attribute; arguments as in
> > @@ -1456,17 +1463,29 @@ handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
> >       return NULL_TREE;
> >     }
> > 
> > -  for (; args; args = TREE_CHAIN (args))
> > +  /* Handle both original string arguments and copied attributes that
> > +     have already been processed into INTEGER_CST wrapped in TREE_LIST.  */
> > +  if (args && TREE_CODE (args) == TREE_LIST
> > +      && TREE_VALUE (args) && TREE_CODE (TREE_VALUE (args)) == INTEGER_CST)
> >     {
> > -      tree id = TREE_VALUE (args);
> > -      if (TREE_CODE (id) != STRING_CST)
> > +      /* This is a copied attribute with the flags already processed.  */
> > +      flags = tree_to_sanitize_code_type (TREE_VALUE (args));
> > +    }
> 
> > +  else
> > +    {
> > +      /* Process original string arguments.  */
> > +      for (; args; args = TREE_CHAIN (args))
> > {
> > -  error ("%qE argument not a string", name);
> > -  return NULL_TREE;
> > - }
> > +  tree id = TREE_VALUE (args);
> > +  if (TREE_CODE (id) != STRING_CST)
> > +    {
> > +      error ("%qE argument not a string", name);
> > +      return NULL_TREE;
> > +    }
> 
> Is it possible that the above two situations exist at the same time, i.e, the attribute “copy” and
>  the attribute “no_sanitize” presents together for the same routine?
> 
> 
> +/* Original function with no_sanitize_address */
> +__attribute__((no_sanitize_address))
> +int original (int *p, int *q)
> +{
> +  *p = 42;
> +  return *q;
> +}
> +
> +/* Copy the attribute - should also have no_sanitize_address */
> +__typeof(original) copy1 __attribute__(copy (original),no_sanitize (”alignment”))
> +int copy1 (int *p, int *q)
> +{
> +  *p = 43;
> +  return *q;
> +}
> +
> 
> i.e, in the above, the routine “copy1” has two attributes, one is “no_sanitize” alignment, the other is “copy”.
> 
> When the attribute “copy” is handled for the routine “copy1”, the no_sanitize “alignment” and the copied
> no_sanitize_address from the “original” should be combined together and be attached to the routine “copy1”. 
> 
> For such situation, your change in this routine doesn’t work correctly, I think. 
> Could you double check on this?

I've checked it again and it appears to work. Here's my test diff to
validate it. I will send a v4 with it added:


diff --git a/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c b/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
index d99819b4792f..812c67c33086 100644
--- a/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
+++ b/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
@@ -37,6 +37,23 @@ int copy_of_copy (int *p, int *q)
   return *q;
 }
 
+int separate_decl (void);
+__attribute__((noinline)) int separate_decl (void);
+
+__attribute__((__copy__(separate_decl), no_sanitize_address))
+int copy_and_annotated_alias (int *p, int *q)
+{
+  *p = 42;
+  return *q;
+}
+
+__attribute__((__copy__(separate_decl), no_sanitize("address")))
+int copy_and_annotated_string (int *p, int *q)
+{
+  *p = 42;
+  return *q;
+}
+
 /* Since ALL functions have no_sanitize_address (either directly or copied),
    there should be NO ASAN instrumentation calls in the entire file. */
 /* { dg-final { scan-assembler-not "__asan_report_store" } } */
diff --git a/gcc/testsuite/gcc.dg/pr113264.c b/gcc/testsuite/gcc.dg/pr113264.c
index 7a1b128bf203..2a49965e26fd 100644
--- a/gcc/testsuite/gcc.dg/pr113264.c
+++ b/gcc/testsuite/gcc.dg/pr113264.c
@@ -70,3 +70,38 @@ __typeof(multi_attr) multi_attr_copy __attribute__((__copy__(multi_attr)));
 void separate_decl (void);
 __attribute__((no_sanitize_address)) void separate_decl (void);
 __typeof(separate_decl) separate_decl_copy __attribute__((__copy__(separate_decl)));
+
+/* Test combining copy attribute with additional no_sanitize attributes.
+   The copied function should have both the original no_sanitize_address
+   and the new no_sanitize flags.  */
+__attribute__((no_sanitize_address))
+int combined_original (int *p, int *q)
+{
+  *p = 42;
+  return *q;
+}
+
+/* Copy the no_sanitize_address attribute and add no_sanitize for alignment.  */
+__typeof(combined_original) combined_copy1 __attribute__((__copy__(combined_original), no_sanitize("alignment")));
+
+/* Test with multiple no_sanitize attributes on original.  */
+__attribute__((no_sanitize("address", "undefined")))
+int combined_original2 (int *p, int *q)
+{
+  *p = 44;
+  return *q;
+}
+
+/* Copy existing sanitizer attributes and add more.  */
+__typeof(combined_original2) combined_copy2 __attribute__((__copy__(combined_original2), no_sanitize("alignment")));
+
+/* Test with no_sanitize_undefined on original.  */
+__attribute__((no_sanitize_undefined))
+int combined_original3 (int *p, int *q)
+{
+  *p = 46;
+  return *q;
+}
+
+/* Copy and add no_sanitize_address - combining different sanitizer attributes.  */
+__typeof(combined_original3) combined_copy3 __attribute__((__copy__(combined_original3), no_sanitize_address));

-- 
Kees Cook
