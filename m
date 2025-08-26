Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B923A99F
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187016; cv=none; b=lC/NQdcsQB6ZyXFAbz5+/X6H9uMWA4Q93NGIQuiKakm22s6ejGiAvvMeXqO/nmbaxnpi9LmsHAnEN9ytGI8mkNpGujuqrs/GMUA5FC19/xmNZQ7BvwDFhgeFXlQyrxfrB7ytwhDL0by9eCZ0Fds8w28k0dq0rKeuwC6tUzHVWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187016; c=relaxed/simple;
	bh=TPY5zEyqQZgiZXcU+DsUt0t3HrajKjlfOpEuWN7yJog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpDFXzCijnPtTHkL7/L7ffNh+NBdvhQoRy59LHDC9y/3y9e/RXgON0oNd+E9kZymMHEeKe9r2RYA2ut6Cg9rvNu3/KiVtGaqTZ2j0DOr2KI9yPfgeW52I8pcnbLyeJG0OECWSJhpzzUj1HCseE0/YFaLMrmpb0RYMfo22zHT9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WysxvJv5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WysxvJv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F02C4CEF1;
	Tue, 26 Aug 2025 05:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756187016;
	bh=TPY5zEyqQZgiZXcU+DsUt0t3HrajKjlfOpEuWN7yJog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WysxvJv5WwGspP6ntCQZveR9MZ89DyWGF1PAT+JI6h66tPcmnX+WTPMyJmHTDbHFY
	 e57FCtRvMaomu35nT8GK7GEDPA4qw9Okm0c8QhCXcMOaoov+c7ocsBkEpogWtGb+BM
	 v1WriIbA9AKoleO8D0HLM2orlyoDJ7HCZzCvLvYIRfMMB+1rzoWLGFZlQIzO8MiY2O
	 HkTda/MQlnSrxnjLbv1kdcAJ8koszFhxATOsvDCt8tUNI8Y4PiD5m5DyY4sHNOvn66
	 Yo8O7Y6QrUXGVMEuwS3HecsQmSvevhDYzn5ew3z14vk3uoYLhY7NEo03Z2ZQFV1QTg
	 rczQo3hkG1gkg==
Date: Mon, 25 Aug 2025 22:43:35 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] Fix sanitizer attribute infrastructure to use standard
 TREE_LIST format [PR113264]
Message-ID: <202508252225.4D954189C5@keescook>
References: <20250825155953.work.196-kees@kernel.org>
 <16491240-42E1-407A-B809-295CFE396D98@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16491240-42E1-407A-B809-295CFE396D98@oracle.com>

On Mon, Aug 25, 2025 at 08:24:20PM +0000, Qing Zhao wrote:
> Hi, Kees,
> 
> Is this patch for GCC14? I noticed that some codes have been changed in the latest trunk GCC already.

Oh, I may be a bit behind. My base commit was
3e4ced9de1f1c6444eae44c1fed493742c345bc6 (Aug 1st).

I will rebase...

> > On Aug 25, 2025, at 11:59, Kees Cook <kees@kernel.org> wrote:
> > 
> > The __attribute__((__copy__)) functionality was crashing when copying
> > sanitizer-related attributes because these attributes violated the standard
> > GCC attribute infrastructure by storing INTEGER_CST values directly instead
> > of wrapping them in TREE_LIST like all other attributes.
> 
> So, from my understanding of your patch, this is a bug in the handling of 
> the attribute “no_sanitize”.

It looks like it's all the sanitizer attributes. I happened across this
bug while testing some alternative solutions for Linux's disabling of
retpolines in certain sections[1]. I was trying to add no_sanitize("kcfi")
as a test and tripped over PR113264. So I figured I should try to fix
it.

[1] https://lore.kernel.org/all/20250825142603.1907143-4-kees@kernel.org/

> Is there any issue with the handling of the attribute “copy”? 

The problem appears to be entirely due to attempting an attribute copy,
yes. The sanitizer itself is fine and happy with INTEGER_CST, but when
the attribute copy code runs it was very alarmed to not find TREE_LIST.

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
> > Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> > ---
> > gcc/asan.h                                    |  8 ++-
> > .../gcc.dg/pr113264-asan-no-instrumentation.c | 43 +++++++++++
> > gcc/testsuite/gcc.dg/pr113264.c               | 72 +++++++++++++++++++
> > gcc/c-family/c-attribs.cc                     | 49 +++++++++----
> > gcc/d/d-attribs.cc                            | 16 ++++-
> > 5 files changed, 170 insertions(+), 18 deletions(-)
> > create mode 100644 gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
> > create mode 100644 gcc/testsuite/gcc.dg/pr113264.c
> > 
> > diff --git a/gcc/asan.h b/gcc/asan.h
> > index 273d6745c58d..13cd741306b0 100644
> > --- a/gcc/asan.h
> > +++ b/gcc/asan.h
> > @@ -252,7 +252,13 @@ sanitize_flags_p (unsigned int flag, const_tree fn = current_function_decl)
> >     {
> >       tree value = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (fn));
> >       if (value)
> > - result_flags &= ~tree_to_uhwi (TREE_VALUE (value));
> > + {
> > +  /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> > +  tree attr_args = TREE_VALUE (value);
> > +  gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
> > +  unsigned long long no_sanitize_flags = tree_to_uhwi (TREE_VALUE (attr_args));
> 
> Should the above be “unsigned long long” or “unsigned HOST_WIDE_INT”?

Oh, this may have slipped through when I tried to separate this from my
other patch that moved from 32-bit to 64-bit bit widths in this code.
That type should be the same type as "result_flags".

I have fixed it locally now:


diff --git a/gcc/asan.h b/gcc/asan.h
index 13cd741306b0..be7be7a067ce 100644
--- a/gcc/asan.h
+++ b/gcc/asan.h
@@ -256,7 +256,7 @@ sanitize_flags_p (unsigned int flag, const_tree fn = current_function_decl)
 	  /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
 	  tree attr_args = TREE_VALUE (value);
 	  gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
-	  unsigned long long no_sanitize_flags = tree_to_uhwi (TREE_VALUE (attr_args));
+	  unsigned int no_sanitize_flags = tree_to_uhwi (TREE_VALUE (attr_args));
 	  result_flags &= ~no_sanitize_flags;
 	}
     }

> 
> > +  result_flags &= ~no_sanitize_flags;
> 
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
> > index 1f4a0df12051..e028d599e3c2 100644
> > --- a/gcc/c-family/c-attribs.cc
> > +++ b/gcc/c-family/c-attribs.cc
> > @@ -1414,19 +1414,28 @@ add_no_sanitize_value (tree node, unsigned int flags)
> >   tree attr = lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (node));
> >   if (attr)
> >     {
> > -      unsigned int old_value = tree_to_uhwi (TREE_VALUE (attr));
> > +      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> > +      tree attr_args = TREE_VALUE (attr);
> > +      gcc_assert (attr_args && TREE_CODE (attr_args) == TREE_LIST);
> > +      unsigned int old_value = tree_to_uhwi (TREE_VALUE (attr_args));
> > +
> >       flags |= old_value;
> > 
> >       if (flags == old_value)
> > return;
> > 
> > -      TREE_VALUE (attr) = build_int_cst (unsigned_type_node, flags);
> > +      tree new_value = build_tree_list (NULL_TREE,
> > + build_int_cst (unsigned_type_node, flags));
> the indentation in the above line has issue.

Oh, weird. It looks correct on my end? Did the tabs get lost? It looks
okay here?
https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693250.html

> > +      TREE_VALUE (attr) = new_value;
> >     }
> >   else
> > -    DECL_ATTRIBUTES (node)
> > -      = tree_cons (get_identifier ("no_sanitize"),
> > -   build_int_cst (unsigned_type_node, flags),
> > -   DECL_ATTRIBUTES (node));
> > +    {
> > +      tree attr_value = build_tree_list (NULL_TREE,
> > +  build_int_cst (unsigned_type_node, flags));
> > +      DECL_ATTRIBUTES (node)
> > + = tree_cons (get_identifier ("no_sanitize"), attr_value,
> > +     DECL_ATTRIBUTES (node));
> The indentations in the above  have issues.

Where should I do the breaks on this to avoid 80 char limit? I was
copying the existing style. If I bring the assignment up a line, I
get 85 characters:

      DECL_ATTRIBUTES (node) = tree_cons (get_identifier ("no_sanitize"), attr_value,
                                          DECL_ATTRIBUTES (node));


> > +    }
> > }
> > 
> > /* Handle a "no_sanitize" attribute; arguments as in
> > @@ -1444,17 +1453,29 @@ handle_no_sanitize_attribute (tree *node, tree name, tree args, int,
> >       return NULL_TREE;
> >     }
> > 
> > -  for (; args; args = TREE_CHAIN (args))
> > +  /* Handle both original string arguments and copied attributes that
> > +     have already been processed into INTEGER_CST wrapped in TREE_LIST.  */
> 
> So, when handling the attribute “copy” of the current function, the attribute “no sanitize” 
> of the original function has been handled already? 

Right, when trying to add a new sanitizer attribute to a function that
already had sanitizer attributes copied over.

-Kees

-- 
Kees Cook
