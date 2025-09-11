Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAB202C5D
	for <linux-hardening@vger.kernel.org>; Thu, 11 Sep 2025 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559912; cv=none; b=B1Ns7EhqaBvmbedcTG9M2KZ3UIG4b9YLwMWxYxlY9snLULIAGCaDRyLLhD1sC3cmk61QjuLgkpOzG3MykHUht5Y38ejVQVkDRAmVA0fTxzpyc3kF2CYIj3ZYJ0n1jSR0Yqq6/TzQ1Dh31fylg4jckPuleAsMx0/3YsT4c0sQA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559912; c=relaxed/simple;
	bh=NzGnilBJ5AcXCkYb3ZM7IzsNP2l+297CHBUm2bRhfS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8JY4LAli6xvrMprqklTiiNw25t0NILvz/VYW+SZwP9fViSIs7Vx8zcEgDKL0BR1glW+Z+TH7XH/kttsi1UNb2wKJG3IK590jgw2XJbonXSoIE/64gPlKPZSisLkXF74vFy9hS28ziNV1W21XDKWvowk5u6KkdpJ/5f+lI0rkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/HThkg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/HThkg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3C9C4CEEB;
	Thu, 11 Sep 2025 03:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757559911;
	bh=NzGnilBJ5AcXCkYb3ZM7IzsNP2l+297CHBUm2bRhfS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/HThkg8wwOJJpSEzx6Nta3hOHSClUiRU0XXu0R6B/8AKSOkk24ZLIUH19MpxM0MK
	 yioQcuBygDiA/QOLkLrukWiYu6SziEksRag/2x7EtVEWFZ1C+qVm+CB5kKf7ykA9Eh
	 KQNdCx4MnqEUZQMuRCtrKbOTt7R4DT6MYCoBrAruAsanygjllogXMxSvaZ2MgKdvaC
	 t5p2IzVD5bxxARaQSWcdMRkvgjdfnlFZZA9LxVy/DDpW6W6kvvakcTXXqs2vszPBWS
	 tG+B+jdoFVdNWwIUtOjicOkwtn83D8IqO8UvrePkbdVbOF86jxAeH9riyq7YWsrSJl
	 6MglIrbQs6vUw==
Date: Wed, 10 Sep 2025 20:05:11 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
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
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202509101705.92474D66@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <65CF25F7-E9F5-41C8-9316-F7A461FD35D0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65CF25F7-E9F5-41C8-9316-F7A461FD35D0@oracle.com>

On Tue, Sep 09, 2025 at 06:49:22PM +0000, Qing Zhao wrote:
> 
> > On Sep 4, 2025, at 20:24, Kees Cook <kees@kernel.org> wrote:
> > +For indirect call sites:
> > +
> > +- Keeping indirect calls from being merged (see above) by adding a
> > +  wrapping type so that equality was tested based on type-id.
> 
> I still think that the additional new created wrapping type and the new assignment stmt
> 
> wrapper_tmp = (wrapper_ptr_type) fn
> is not necessary.
> 
> All the information can be get from function type + type-id which is attached as an attribute
> to the original_function_type of “fn”. 
> Could you explain why the wrapper type and the new temporary, new assignment is 
> necessary?

I couldn't find a way to stop merging just using the attributes. I need
a way to directly associated indirect call sites with the typeid.

> > +
> > +- Keeping typeid information available through to the RTL expansion
> > +  phase was done via a new KCFI insn that wraps CALL and the typeid.
> 
> Is the new KCFI insn the following:
> wrapper_tmp = (wrapper_ptr_type) fn?

This bullet is speaking about the backend change to support the KCFI
check-call insn sequences:

+/* KCFI wrapper for call expressions.
+   Operand 0 is the call expression.
+   Operand 1 is the KCFI type ID (const_int).  */
+
+DEF_RTL_EXPR(KCFI, "kcfi", "ee", RTX_EXTRA)

> Why the type-id attached as the attribute is not enough? 

Doing the wrapping avoided needing to update multiple optimization passes
to check for the attribute. And it still needed a way to distinguish
between direct and indirect calls, so I need to wrap only the indirect
calls, where as the typeid attribute is for all functions for all typeid
needs, like preamble generation, etc.

> > +
> > +- To make sure KCFI expansion is skipped for inline functions, the
> > +  inlining is marked during GIMPLE with a new flag which is checked
> > +  during expansion.
> > +
> > +For indirect call targets:
> > +
> > +- kcfi_emit_preamble() uses function_needs_kcfi_preamble(),
> > +  to emit the preablem,
> Typo: preamble. 

Fixed.

> > +HOST_WIDE_INT kcfi_patchable_entry_prefix_nops = 0;  /* For callsite offset */
> > +static HOST_WIDE_INT kcfi_patchable_entry_arch_alignment_nops = 0;  /* For preamble alignment */
> > +
> > +/* Common helper for RTL patterns to emit .kcfi_traps section entry.  */
> 
> there should be one empty line between the comments of the function and the start of the function. 
> I noticed that you need such empty line for all the new functions you added.  -:)

Oh! Wow, yeah, I totally missed this coding style requirement. Fixed.

> > +/* Check if a function needs KCFI preamble generation.
> > +   ALL functions get preambles when -fsanitize=kcfi is enabled, regardless
> > +   of no_sanitize("kcfi") attribute.  */
> 
> Why no_sanitize(“kcfi”) is not considered here?

no_sanitize(“kcfi”) is strictly about whether call-site checking
is performed within the function. It is not used to mark a function as
not being the target of a KCFI call.

> > +/* Get KCFI type ID for a function declaration during assembly output phase.
> > +   Fatal error if type ID was not previously set during IPA phase.  */
> > +static uint32_t
> > +get_function_kcfi_type_id (tree fndecl)
> > +{
> > +  if (!kcfi_type_id_attr)
> > +    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
> > +
> > +  tree attr = lookup_attribute_by_prefix ("kcfi_type_id",
> > +   DECL_ATTRIBUTES (fndecl));
> > +  if (attr && TREE_VALUE (attr) && TREE_VALUE (TREE_VALUE (attr)))
> > +    {
> > +      tree value = TREE_VALUE (TREE_VALUE (attr));
> > +      if (TREE_CODE (value) == INTEGER_CST)
> > + return (uint32_t) TREE_INT_CST_LOW (value);
> The indentation of above is off.

I understand GCC code style indentation to be "leading spans of 8 spaces
should be replaced with a tab character". This is what I followed:

first line indents to column 6, so 6 spaces. Second line indents to
column 8, so 1 tab:

SSSSSSif (TREE_CODE (value) == INTEGER_CST)
Treturn (uint32_t) TREE_INT_CST_LOW (value);

This seems to match everywhere else? Randomly picking line get_section()
from varasm.cc, I see the same:

      if (not_existing)
	internal_error ("section already exists: %qs", name);

> > +  /* Calculate alignment NOPs needed */
> > +  arch_alignment = (alignment_bytes - ((kcfi_patchable_entry_prefix_nops + typeid_size) % alignment_bytes)) % alignment_bytes;
> The above line is too long. 

Oops, yes, thank you. Fixed.

What is the right tool for me to run to check for these kinds of code
style glitches? contrib/check_GNU_style.py doesn't report anything. Oh!
It takes _patches_ not _files_. The .sh version specifies "patch" in the
help usage. Okay, I will get this all passing cleanly.

> > +/* Wrap indirect calls with KCFI type for anti-merging.  */
> > +static unsigned int
> > +kcfi_instrument (void)
> > +{
> > +  /* Process current function for call instrumentation only.
> > +     Type ID setting is handled by the separate IPA pass.  */
> > +
> > +  basic_block bb;
> > +
> > +  FOR_EACH_BB_FN (bb, cfun)
> > +    {
> > +      gimple_stmt_iterator gsi;
> > +      for (gsi = gsi_start_bb (bb); !gsi_end_p (gsi); gsi_next (&gsi))
> > + {
> > +  gimple *stmt = gsi_stmt (gsi);
> > +
> > +  if (!is_gimple_call (stmt))
> > +    continue;
> > +
> > +  gcall *call_stmt = as_a <gcall *> (stmt);
> > +
> > +  // Skip internal calls - we only instrument indirect calls
> > +  if (gimple_call_internal_p (call_stmt))
> > +    continue;
> > +
> > +  tree fndecl = gimple_call_fndecl (call_stmt);
> > +
> > +  // Only process indirect calls (no fndecl)
> > +  if (fndecl)
> > +    continue;
> > +
> > +  tree fn = gimple_call_fn (call_stmt);
> > +  if (!is_kcfi_indirect_call (fn))
> > +    continue;
> > +
> > +  // Get the function type to compute KCFI type ID
> > +  tree fn_type = gimple_call_fntype (call_stmt);
> > +  gcc_assert (fn_type);
> > +  if (TREE_CODE (fn_type) != FUNCTION_TYPE)
> > +    continue;
> > +
> > +  uint32_t type_id = compute_kcfi_type_id (fn_type);
> > +
> > +  // Create KCFI wrapper type for this call
> > +  tree wrapper_type = create_kcfi_wrapper_type (fn_type, type_id);
> Again, the new “type_id” has been attached as an attribute of “fn_type” here, 

The attribute is attached during IPA. This is run before that, but as I
mentioned, this is the call-site handling, and the IPA pass is for
globally associating a type-id to the function for all other uses
(preambles, weak symbols, etc).

> > +  // Create a temporary variable for the wrapped function pointer
> > +  tree wrapper_ptr_type = build_pointer_type (wrapper_type);
> > +  tree wrapper_tmp = create_tmp_var (wrapper_ptr_type, "kcfi_wrapper");
> > +
> > +  // Create assignment: wrapper_tmp = (wrapper_ptr_type) fn
> > +  tree cast_expr = build1 (NOP_EXPR, wrapper_ptr_type, fn);
> > +  gimple *cast_stmt = gimple_build_assign (wrapper_tmp, cast_expr);
> > +  gsi_insert_before (&gsi, cast_stmt, GSI_SAME_STMT);
> > +
> 
> Why the additional wrapper_ptr_type, wrapper_tmp and new assignment stmt
> Are needed here?

Based on my understanding of the requirements for GIMPLE here is that I
needed a cast between the original and the wrapper, and an assignment
for SSA. It's converting the call like:

  Original: result = fn(arg1, arg2)
  Becomes:  result = wrapper(arg1, arg2, type_id)

I'm open to whatever alternative is needed here. I tried to capture the
merging issue with gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c

My other test methodology is "does Linux boot?" ;)

-- 
Kees Cook
