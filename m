Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6E221F13
	for <linux-hardening@vger.kernel.org>; Tue, 14 Oct 2025 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484529; cv=none; b=DPE6dTtgaFJKBlt4xb56B1Mnkn/rBftBOKt++WjQWmm4z0sKYRq/N/9aeBQmsSL8BtSGS4JTAhmJxBfPRw/6j4FmBBJ+lv7f+mlUloSA9R5+pYXOxQC+MkeD4xzVHH8cjNbnY/bmYCRQQ7jJOVRGPufzh3XcsWXKK1TR/HWS0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484529; c=relaxed/simple;
	bh=oOIjke1af0AHZCXoNxJPSZieFCPsb2BVGyHVu3E4rPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNcmJHkwQBRMyGTS50b92SbnA63Ler8BDMhhHBIffZZ6rr/Ra+vUPMiapeN9zlSmBR05Y9RaUdBqQsBm+e2KZfQOyaXyUyTMdBfNfWMPp/zOh2dumH3fTIYqqK+1X6FEIkgGdzGebDtH0c7xstv67LxjBEhqC5Ku4WV/5gUQ8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEbY9y7w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEbY9y7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E35C4CEE7;
	Tue, 14 Oct 2025 23:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484528;
	bh=oOIjke1af0AHZCXoNxJPSZieFCPsb2BVGyHVu3E4rPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEbY9y7wWncYdOrRBrsv6dAxjHLFLG+Ouy1lS/4Z0nYBBI8GufZdaOO3HYzeVTIOK
	 FXQ0WaGe2UEML8D3anwnBJB5ZE7SeGiPBOBUEUCtG2XkWeLV6WIRl+mV5v30dgH4f/
	 Rk9PKDGm3TAvkAlweiRtsKxwE43Y4nQHDPbAQMAk/yrUUIKgKEX3u0G0W/eLBHQ0MW
	 ql546Xz/2vIdYqwaPiUoE6ZIyjI5qEE7qlLFGOFmRSPOq7sH7yu6goxZdd6/DcWJcI
	 g/8fbUZjeL75oRz8p75fXlPx4DYnzUlG3DzXc+rGF15v47NUn8Y7Q7ODXDQu8t4b+a
	 VY8lmnj7R0GBg==
Date: Tue, 14 Oct 2025 16:28:47 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202510141554.19D1682@keescook>
References: <20250926023737.it.616-kees@kernel.org>
 <20250926030252.2387681-2-kees@kernel.org>
 <62775487-A524-4DBE-A9D2-EA4485FD8502@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62775487-A524-4DBE-A9D2-EA4485FD8502@oracle.com>

On Thu, Oct 02, 2025 at 02:56:15PM +0000, Qing Zhao wrote:
> > On Sep 25, 2025, at 23:02, Kees Cook <kees@kernel.org> wrote:
> > [...]
> > +/* For KCFI trap/call/entry label numbering.  */
> > +extern int kcfi_labelno;
> > +
> > +/* For calculating callsite typeid offset.  */
> > +extern HOST_WIDE_INT kcfi_typeid_offset;
> 
> I am still not very comfortable with the above two additional globals.
> Is it better to change them to “static”, and then use external utility functions to access/update them? 

I can certainly switch to that. It's likely cleaner for kcfi_labelno,
however it seems "expensive" to make a call for kcfi_typeid_offset,
though, which is a fixed value after initialization. I will make it
use a helper too, though.

> > [...]
> > +/* Global KCFI label counter, incremented by KCFI insn emission.  */
> > +int kcfi_labelno = 0;
> As I mentioned previously, it might be better to declare this as a static variable,
>  and use external utility routines (qualified as “inline” keyword if needed) to access them from other files. 
> 
> Another question is: 
> My understanding is: this “kcfi_lableno” is for the “N” in the following sequence:  
> 
> > +  .Lkcfi_trap$N:
> > +    trap
> > +  .section .kcfi_traps,"ao",@progbits,.text
> > +  .Lkcfi_entry$N:
> > +    .long .Lkcfi_trap$N - .Lkcfi_entry$N
> > +  .text
> > +  .Lkcfi_call$N:
> > +    call *%target

Yes.

> This “N” should be unique for each of the indirect callsite of the current module of the compilation. 

Yes.

> Is this understanding correct?
> If so, it’s better to clarify this in the comments of this new variable. 

Okay, I will update that.

> > +/* Callsite typeid loading offset.  */
> > +HOST_WIDE_INT kcfi_typeid_offset = 0;
> Also, it’s better to declare this as a static variable, and use external utility routines 
> (qualified as “inline” keyword if needed)  to access them from other files. 

I don't think I can make it static if the access routines are inline?

> > +/* Count of needed __cfi_... preamble alignment padding NOPs.  */
> > +static HOST_WIDE_INT kcfi_alignment_padding_nops = 0;
> > +/* NOP insn template.  */
> > +static const char *kcfi_nop = NULL;
> > +
> > +/* Common helper for RTL patterns to emit .kcfi_traps section entry.
> > +   FILE is the output assembly file stream.  TRAP_LABEL_SYM is the RTX
> > +   symbol reference for the trap instruction label.  */
> > +
> > +void
> > +kcfi_emit_traps_section (FILE *file, rtx trap_label_sym)
> > +{
> > +  /* Generate entry label name with custom prefix.  */
> > +  char entry_name[32];
> 
> Is the length 32 enough to hold the label_name? Will it’s possible that the module includes
>  a huge number of indirect callsites?

Yes, max string width of printed "int" is 12 (including NUL byte).
> 
> > +  ASM_GENERATE_INTERNAL_LABEL (entry_name, "Lkcfi_entry", kcfi_labelno);
> > +
> > +  /* Save current section to restore later.  */
> > +  section *saved_section = in_section;
> > +
> > +  /* Use varasm infrastructure for section handling:
> > +     .section .kcfi_traps,"ao",@progbits,.text  */
> > +  section *kcfi_traps_section = get_section (".kcfi_traps",
> > +     SECTION_LINK_ORDER, NULL);
> > +  switch_to_section (kcfi_traps_section);
> > +
> > +  /* Emit entry label for relative offset:
> > +     .Lkcfi_entry$N:  */
> > +  ASM_OUTPUT_LABEL (file, entry_name);
> > +
> > +  /* Generate address difference using RTL infrastructure.  */
> > +  rtx entry_label_sym = gen_rtx_SYMBOL_REF (Pmode, entry_name);
> > +  rtx addr_diff = gen_rtx_MINUS (Pmode, trap_label_sym, entry_label_sym);
> > +
> > +  /* Emit the address difference as a 4-byte value:
> > +    .long .Lkcfi_trap$N - .Lkcfi_entry$N  */
> > +  assemble_integer (addr_diff, 4, BITS_PER_UNIT, 1);
> > +
> > +  /* Restore the previous section:
> > +     .text  */
> > +  switch_to_section (saved_section);
> > +}
> > +
> > +/* Compute KCFI type ID for a function type.  FNTYPE is the function
> > +   type tree node to compute the type ID for.  Returns the 32-bit KCFI
> > +   type identifier hash.  */
> > +
> > +static uint32_t
> > +compute_kcfi_type_id (tree fntype)
> > +{
> > +  gcc_assert (fntype);
> > +  gcc_assert (TREE_CODE (fntype) == FUNCTION_TYPE);
> > +
> > +  uint32_t type_id = typeinfo_get_hash (fntype);
> > +
> > +  /* Apply target-specific masking if supported.  */
> > +  if (targetm.kcfi.mask_type_id)
> > +    type_id = targetm.kcfi.mask_type_id (type_id);
> > +
> > +  /* Output to dump file if enabled.  */
> > +  if (dump_file && (dump_flags & TDF_DETAILS))
> > +    {
> > +      std::string mangled_name = typeinfo_get_name (fntype);
> > +      fprintf (dump_file, "KCFI type ID: mangled='%s' typeid=0x%08x\n",
> > +       mangled_name.c_str (), type_id);
> > +    }
> > +
> > +  return type_id;
> > +}
> > +
> > +/* Function attribute to store KCFI type ID.  */
> > +static tree kcfi_type_id_attr = NULL_TREE;
> > +
> > +/* Get KCFI type ID for a function type.  Set it if missing.  FN_TYPE
> > +   is the function type tree node.  Returns the cached or newly computed
> > +   32-bit KCFI type identifier, storing it as a type attribute.  */
> > +
> > +static uint32_t
> > +kcfi_get_type_id (tree fn_type)
> > +{
> > +  uint32_t type_id;
> > +
> > +  /* Cache the attribute identifier for build_tree_list usage.  */
> > +  if (!kcfi_type_id_attr)
> > +    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
> > +
> > +  tree attr = lookup_attribute (IDENTIFIER_POINTER (kcfi_type_id_attr),
> > + TYPE_ATTRIBUTES (fn_type));
> 
> The above is better to be changed as:
> > 
> > 
> >  tree attr = lookup_attribute (“kcfi_type_id”, TYPE_ATTRIBUTES (fn_type));
> 
> To make it simpler and faster. 

Okay. I wanted to avoid the redundant string literal, but I'll switch
it.

> 
> > +  if (attr)
> > +    {
> > +      tree value = TREE_VALUE (attr);
> > +      gcc_assert (value && TREE_CODE (value) == INTEGER_CST);
> > +      type_id = (uint32_t) TREE_INT_CST_LOW (value);
> > +    }
> > +  else
> > +    {
> > +      type_id = compute_kcfi_type_id (fn_type);
> > +
> > +      tree type_id_tree = build_int_cst (unsigned_type_node, type_id);
> > +      tree attr = build_tree_list (kcfi_type_id_attr, type_id_tree);
> > +
> > +      TYPE_ATTRIBUTES (fn_type) = chainon (TYPE_ATTRIBUTES (fn_type), attr);
> > +    }
> > +
> > +  return type_id;
> > +}
> > +
> > +/* Prepare the global KCFI alignment NOPs calculation.  Called once
> > +   during IPA pass to set global variables including kcfi_typeid_offset
> > +   and kcfi_alignment_padding_nops based on patchable function entry
> > +   settings and function alignment requirements.  */
> > +
> > +static void
> > +kcfi_prepare_alignment_nops (void)
> > +{
> > +  /* Calculate where callsites load the 32-bit typeid from, based
> > +     on the target function address.  Under default circumstances,
> > +     the typeid is located 4 bytes before the function entry, in
> > +     the __cfi_... preamble:
> > +
> > +     __cfi_func:
> > +       [typeid] // -4 from func
> > +     func:
> > +       [function body]
> > +
> > +   */
> > +  kcfi_typeid_offset = sizeof(uint32_t);
> > +
> > +  /* When Patchable Function Entry is enabled, there may be NOP
> 
> /* When Patchable Function Entry (PFE) is enabled, there may be NOP

I will update.

> 
> > +     instructions between the typeid and the function entry point.
> > +     Since KCFI callsites have no way to see PFE function attributes,
> > +     it can only base the calculations on the global
> > +     -fpatchable-function-entry=TOTAL[,PREFIX] flag.  */
> > +  HOST_WIDE_INT prefix_nops = 0;
> > +  if (flag_patchable_function_entry)
> > +    {
> > +      HOST_WIDE_INT total_nops;
> > +      parse_and_check_patch_area (flag_patchable_function_entry, false,
> > +  &total_nops, &prefix_nops);
> > +    }
> 
> The above is clear.
> 
> > +
> > +  /* However, PFE is measured in NOP instruction counts, not bytes. So
> > +     we need to find out how many bytes they are, and we may need to
> > +     emit NOPs for alignment padding later. Prepare the NOP template.  */
> > +  rtx_insn *nop_insn = make_insn_raw (gen_nop ());
> > +  int code_num = recog_memoized (nop_insn);
> > +  kcfi_nop = get_insn_template (code_num, nop_insn);
> > +  int nop_insn_bytes = get_attr_length (nop_insn);
> I understand the above, but not very sure whether this is the correct way to do it.
> Other people might need to take another look at them.

The correct way to do what part? To find the length of the "NOP"
instruction? I'm open to whatever works. This seemed best since I later
needed the output of "get_insn_template" later too, so it feels like
it's right.

> > +
> > +  /* Adjust the offset by how many NOP bytes may be between the typeid
> > +     and the function entry point.
> > +
> > +     __cfi_func:
> > +       [typeid] // -(4 + (prefix nop count * nop size)) from func
> > +       [prefix nops] // added when -fpatchable-function-entry is set
> > +     func:
> > +       [entry nops] // added when -fpatchable-function-entry is set
> > +       [function body]
> > +
> > +     At this point, kcfi_typeid_offset is ready and callsites can now
> > +     correctly find the typeid.
> > +
> > +   */
> > +  int prefix_nop_bytes = prefix_nops * nop_insn_bytes;
> > +  kcfi_typeid_offset += prefix_nop_bytes;
> 
> Okay.
> 
> > +
> > +  /* In the case where the KCFI preamble (and potentially the prefix NOPs)
> > +     are being used for alternative CFI implementations via live-patching,
> > +     the __cfi_... label itself needs to be usable as a callable function
> > +     target, so alignment NOPs may need to be added between the preamble
> > +     label and the typeid during KCFI preamble emission:
> > +
> > +     __cfi_func: // may need to be function entry aligned
> > +       [alignment padding nops] // may be needed when -falign-functions set
> > +       [typeid]
> > +       [prefix nops]
> > +     func:
> > +       [entry nops]
> > +       [function body]
> > +
> > +     But we only calculate alignment padding NOPs when -falign-functions
> > +     has been explicitly set.
> > +   */
> > +  if (align_functions.levels[0].log <= 0)
> > +    return;
> > +  int function_entry_alignment = align_functions.levels[0].get_value ();
> Okay.
> 
> > +
> > +  /* Some architectures may be using an instruction for the typeid (though
> > +     this requires that the typeid is a trailing immediate value), but the
> > +     instruction will have a size greater than 4, which must be part of the
> > +     resulting alignment padding calculation.  */
> > +  int typeid_insn_bytes = targetm.kcfi.emit_type_id
> > +  ? targetm.kcfi.emit_type_id (NULL, 0)
> > +  : sizeof(uint32_t);
> > +
> > +  /* Calculate needed architecture-specific alignment padding bytes.  */
> > +  int needed_alignment_bytes = (function_entry_alignment
> > + - ((prefix_nop_bytes + typeid_insn_bytes)
> > +   % function_entry_alignment))
> > +       % function_entry_alignment;
> > +
> > +  /* Calculate number of NOP instructions needed for alignment padding.  */
> > +  if (needed_alignment_bytes % nop_insn_bytes != 0)
> > +    sorry ("KCFI function entry alignment padding bytes (%d) are not "
> > +   "a multiple of architecture NOP instruction size (%d)",
> > +   needed_alignment_bytes, nop_insn_bytes);
> > +  kcfi_alignment_padding_nops = needed_alignment_bytes / nop_insn_bytes;
> > +}
> Okay with the above, but really feel it’s so complicated. 

It is complicated, yes. But it's what is needed to get this calculated
correctly.

> > +static unsigned int
> > +ipa_kcfi_execute (void)
> > +{
> > +  struct cgraph_node *node;
> > +
> > +  /* Prepare global KCFI alignment NOPs calculation once for all functions.  */
> > +  kcfi_prepare_alignment_nops ();
> > +
> > +  /* Process all functions - both local and external.  */
> > +  FOR_EACH_FUNCTION (node)
> > +    {
> > +      tree fndecl = node->decl;
> > +
> > +      /* Skip all non-NORMAL builtins (MD, FRONTEND) entirely.
> > + For NORMAL builtins, skip those that lack an implicit
> > + implementation (closest way to distinguishing DEF_LIB_BUILTIN
> > + from others).  E.g. we need to have typeids for memset().  */
> > +      if (fndecl_built_in_p (fndecl))
> > + {
> > +  if (DECL_BUILT_IN_CLASS (fndecl) != BUILT_IN_NORMAL)
> > +    continue;
> I understand this.
> 
> > +  if (!builtin_decl_implicit_p (DECL_FUNCTION_CODE (fndecl)))
> > +    continue;
> 
> But not this, could you explain a little bit on why non_implicit builtins do not need typeids?

It shouldn't be possible to make calls to them in code (nothing has a
way to take them by reference when having the same function type). As
in, it's possible to take a reference (for an indirect call) to
__builtin_memset. It's not a *perfect* overlap with DEF_LIB_BUILTIN, but
it reduces the set of functions exposed to needing to have their
function type put through the typeinfo mangling, and I want to avoid
getting C++ types exposed there.

> > [...]
> > @@ -6514,6 +6518,17 @@ static tree
> > handle_patchable_function_entry_attribute (tree *, tree name, tree args,
> >   int, bool *no_add_attrs)
> > {
> > +  /* Function-specific patchable_function_entry attribute is incompatible
> > +     with KCFI because KCFI callsites cannot know about function-specific
> > +     patchable entry settings on a preamble in a different translation
> > +     unit.  */
> > +  if (sanitize_flags_p (SANITIZE_KCFI))
> > +    {
> > +      error ("%qE attribute cannot be used with %<-fsanitize=kcfi%>", name);
> > +      *no_add_attrs = true;
> > +      return NULL_TREE;
> > +    }
> > +
> 
> I noticed that you mentioned the above interaction in the doc of -fsanitize=kcfi, I am
> wondering whether we should mention this too in the doc of the “patchable_function_entry” attribute? 

It felt like more of an issue with -fsanitize=kcfi, but I will add a note
for it too.

Thanks for the review!

I'd like to get feedback from more backend folks ... is there something
I need to do better to get their attention?

-Kees

-- 
Kees Cook
