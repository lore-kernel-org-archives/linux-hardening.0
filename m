Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52012F25E9
	for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143395; cv=none; b=PS8brcjJK4dKI19Xas0rH2Wl/1nmzOvVsGdXrExSBzADjth/efa/Z7S4/dRpQxiz6INl0csQaij3jIQd5MoUSm3bntuRB1qqp0yWl1QmqDiu23ld2S9/u/6Mcqc5/f88VWNljJfDZVzUjFjgSZShZ/n+bWhYpX89BwSv4lE71Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143395; c=relaxed/simple;
	bh=CjyDy91pkG0d3y4dUzwnnkceIp1kFwDYVSjjiFBEkOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag3aIrjAtBDl7BIkZ2WvBnKqTClipAysSHmypgWIyT8F2gfnao2NUZbFGJ0aY6e8w2IRTiBjA2AG8JR1Mv8Jyb6AV9gaVIG8xbvBc746MLCpUptUXN+uqyPG/nuR321bNUbgzoroI/+tX5JX/KvcpCTk82X/od+yG6QXcm/sb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9k6cKDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9k6cKDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F145C4CEE7;
	Wed, 17 Sep 2025 21:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758143395;
	bh=CjyDy91pkG0d3y4dUzwnnkceIp1kFwDYVSjjiFBEkOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9k6cKDWqqAmU8d0PUciLSMe8b3Ze18GgciWU/lvUeu9YucoCSKN18LpSqKFrX+Um
	 4dEzwjvvjtLZn25nQz0qoyYG5IJT3E9oxZjp4IReDXhxtyZuTVTdhLPpSCaBPv+CjZ
	 PXL6X6qI/P/MHumPQ5qPdO3zcKdOWGMhmy3rwloO28e+00Lefx5KXwQ4aWajhhy7Ai
	 kEewrfasUeJxEGuJUt+PZWbzEWcOFJq3xQkSaflnbqNuzr57EojFnrrJARLBh+pSYL
	 9pTJwCXjlG2Xrx7RpA0eso+dsHCjBKqx/V+ppJStBPoFpPmtgSqmWkoUiDS9J9VCer
	 mDMBMZo+sDb+w==
Date: Wed, 17 Sep 2025 14:09:54 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <hubicka@ucw.cz>,
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
Subject: Re: [PATCH v3 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202509171307.DC9740ABAB@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-2-kees@kernel.org>
 <6F94A091-6948-4220-A972-236055C2440A@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6F94A091-6948-4220-A972-236055C2440A@oracle.com>

On Wed, Sep 17, 2025 at 01:42:32PM +0000, Qing Zhao wrote:
> This version of the middle-end change is much simpler and cleaner-:).

Thanks! I think it's getter closer (hopefully). :)

> > On Sep 13, 2025, at 19:23, Kees Cook <kees@kernel.org> wrote:
> > +- KCFI check-call instrumentation must survive tail call optimization.
> > +  If an indirect call is turned into an indirect jump, KCFI checking
> > +  must still happen (but it will use a jmp rather than a call).
> 
> I didn’t see any code changes in this patch address the above issue,
>  is the issue automatically resolved without special handling? 

The logic for this is handled by the split RTL patterns on the backend. We
end up with 4 RTL patterns for KCFI that match the regular 4 call
patterns:

- call
- call with return value
- sibcall
- sibcall with return value

In the RTL assembly output the "is this a sibcall?" test is made to
choose between emitting a "call" or a "jump" insn.

> > +- Functions that may be called indirectly have a preamble added,
> > +  __cfi_$original_func_name, which contains the $typeid value:
> > +
> > +    __cfi_target_func:
> > +      .word $typeid
> > +    target_func:
> > +       [regular function entry...]
> > +
> > +- The preamble needs to interact with patchable function entry so that
> > +  the typeid appears further away from the actual start of the function
> > +  (leaving the prefix NOPs of the patchable function entry unchanged).
> > +  This means only _globally defined_ patchable function entry is supported
> > +  with KCFI (indrect call sites must know in advance what the offset is,
> > +  which may not be possible with extern functions that use a function
> > +  attribute to change their patchable function entry characteristics).
> > +  For example, a "4,4" patchable function entry would end up like:
> > +
> > +    __cfi_target_func:
> > +      .data $typeid
> > +      nop nop nop nop
> > +    target_func:
> > +       [regular function entry...]
> > +
> > +  Architectures may need to add alignment nops prior to the typeid to keep
> > +  __cfi_target_func aligned for function call conventions.
> 
> I am still a little confused with the above, are there two “nops” need to be computed
> and added: one is for patchable function entry, the other one is for architecture specific
> alignment nops? 
> If so, you might need to clarify the above to make this clear. 

Yes, this is a confusing bit of logic that needs more clarity. I'll
improve this. Here's what happens:

Normal function has no preamble:

func:
	body...

With KCFI, a preamble is created to hold the typeid to be checked from
site sites (addressed as -4 from "func"):

__cfi_func:
	.word typeid_value
func:
	body...

A "patchable function entry" function has both "prefix" and "entry" nops
added:

__pfe_func:
	nop	// "prefix" nops
	nop
func:
	nop	// "entry" nops
	nop
	nop
	body...

Confusingly, the argument specifies total (and optionally prefix):
 -fpatchable-function-entry=TOTAL[,PREFIX]
So the above example is -fpatchable-function-entry=5,2 (5 total NOPs,
with 2 of them being preamble insns).

For KCFI, callsites need to address the typeid, so a normal KCFI
callsite would use:

	load %tmp, -4(%target)

but when PFE is active, the typeid must be placed before the prefix NOPs
since PFE requires that the entire space is NOPs. Therefore the prefix
NOPs need to be included (and measured in _bytes_, not instructions)
when loading the typeid:

	load %tmp, -12(%target)
	// 2 nops (8 bytes on aarch64) and 4 bytes for typeid == -12

Which corresponds to the resulting function preamble layout:

__cfi_func:
	.word typeid_value
__pfe_func:
	nop	// "prefix" nops
	nop
func:
	nop	// "entry" nops
	nop
	nop
	body...

Now, an _additional_ requirement for x86 is that __cfi_func be function
entry aligned, so that Linux can, if it chooses, live-patch the entire
KCFI and PFE prefix area into a callable target (this is the "FineIBT"
KCFI alternative). So, when -falign-functions=N is set, given x86's 1
byte NOPs and the "movl" encoding used for holding the KCFI type id, the
final layout, given -falign-functions=8 -fpatchable-function-entry=4,1
would be:

__cfi_func:
	nop	// "alignment" nops	// 2 bytes total
	nop
	.word typeid_value		// 5 bytes total
__pfe_func:
	nop	// "prefix" nops	// 1 byte total
func:
	nop	// "entry" nops
	nop
	nop
	body...

4 total PFE bytes with 1 as prefix (leving 3 at the func entry). And
to align __cfi_func to 8 bytes, we have 5 byte typeid insn, and 1 byte
"prefix" nop, so we need 2 more bytes to be the "alignment" nops.


This layout was not obvious initially for x86 because Linux's FineIBT
implementation uses -falign-functions=16 -fpatchable-function-entry=11,11
so the alignment nops are pre-calculated.

> 
> > +
> > +- External functions that are address-taken have a weak __kcfi_typeid_$func
> > +  symbol added with the typeid value available so that the typeid can be
> > +  referenced from assembly linkages, etc, where the typeid values cannot be
> > +  calculated (i.e where C type information is missing):
> > +
> > +    .weak   __kcfi_typeid_$func
> > +    .set    __kcfi_typeid_$func, $typeid
> > +
> 
> From my previous understanding, the above weak symbol is emitted for external functions
> that are address-taken AND does not have a definition in the compilation. So the weak symbols
> Is emitted at the declaration site of the external function, is this true?
> 
> If so, could you please clarify this in the above?

Yes, this happens via assemble_external_real, which can be called under
a few conditions in gcc/varasm.cc.

> > +- Keep indirect calls from being merged (see earlier example) by
> > +  checking the KCFI insn's typeid for equality.
> 
> Is this resolved by the following code:
> 
> rtlanal.cc
> index 63a1d08c46cf..5016fe93ccac 100644
> --- a/gcc/rtlanal.cc
> +++ b/gcc/rtlanal.cc
> @@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
>     case IF_THEN_ELSE:
>       return reg_overlap_mentioned_p (x, body);
> 
> +    case KCFI:
> +      /* For KCFI wrapper, check both the wrapped call and the type ID.  */
> +      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
> +      || reg_overlap_mentioned_p (x, XEXP (body, 1)));
> +

The above is needed for accurate register "liveness" checking. When the
above code is removed, the kcfi-move-preservation.c regression test
fails (since it doesn't see the clobbers).

AFAICT, simply making it a new type of RTL (the DEF_RTL_EXPR), made it
unmergeable. I assume this is because whatever was doing the call
merging was looking strictly for "CALL" types, but I honestly don't know
where that was happening.

> > +/* Common helper for RTL patterns to emit .kcfi_traps section entry.  */
> 
> I noticed that you didn’t explain each parameter of the function in all the comments for the functions.
> This need to be updated for all the new functions. 

For externs like these, should the parameter documentation go in the .h
file, or the .cc file?

> > +void
> > +kcfi_emit_traps_section (FILE *file, rtx trap_label_sym)
> > +{
> > +  /* Generate entry label internally and get its number.  */
> > +  rtx entry_label = gen_label_rtx ();
> > +  int entry_labelno = CODE_LABEL_NUMBER (entry_label);
> 
> Is the only usage of the new RTX “entry_label” is to generate a label_number? 
> If so, the entry_label is not needed at all.  You can get a distinct labelno for each
> Lkcfi_entry, for example, the function id for the current function.

It is, yes. I can't use the function id because it's only incremented per
function and a given function may have multiple kcfi call sites within
it. I did have a version of this logic that used a kcfi-specific global
counter but (at the time) I was having trouble with it and had seen that
other "custom label" examples in the code base used this style, so I
switched to that.

I have since figured out why the global counter wasn't work (I was using
it during expansion and not during insn output, so I had cases where a
call was getting duplicated and I had a repeated label). If it's
preferred, I could try switching back to the global counter to avoid
these "useless" gen_label_rtx calls?

> > +static uint32_t
> > +kcfi_get_type_id (tree fn_type)
> > +{
> > +  uint32_t type_id;
> > +
> > +  /* Cache the attribute identifier.  */
> > +  if (!kcfi_type_id_attr)
> > +    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
> > +
> > +  tree attr = lookup_attribute (IDENTIFIER_POINTER (kcfi_type_id_attr),
> > + TYPE_ATTRIBUTES (fn_type));
> 
> The above can be simplified as:
> +  tree attr = lookup_attribute (“kcfi_type_id”, TYPE_ATTRIBUTES (fn_type));

Ugh, I totally misunderstood the examples I saw of this. I thought they
were caching the string lookup, but now that I look more closely, I see:

#define IDENTIFIER_POINTER(NODE) \
  ((const char *) IDENTIFIER_NODE_CHECK (NODE)->identifier.id.str)

it's just returning the string!

I will throw away the "caching" I was doing. I thought it would actually
look up the attribute using the tree returned by get_identifier, but I
see there is no overloaded lookup_attribute that takes a tree argument.

*face palm*

> > +/* Emit KCFI type ID symbol for an address-taken external function.  */
> 
> Is it more accurate to say:
> 
> Emit KCFI type ID symbol for the declaration of an address-taken external function FNDECL
> to the assembly file ASM_FILE.
> 
> ??

Yup, I will update it.

> > +  /* Process all functions - both local and external.  */
> > +  FOR_EACH_FUNCTION (node)
> > +    {
> > +      tree fndecl = node->decl;
> > +
> > +      /* Skip all non-NORMAL builtins (MD, FRONTEND) entirely.
> > + For NORMAL builtins, skip those that lack an implicit
> > + implementation (closest way to distinguishing DEF_LIB_BUILTIN
> > + from others).  E.g. we need to have typeids for memset().  */
> 
> I see indentation issue in the above comments.

This looks like your email client again. It passes
contrib/check_GNU_style.py:

  FOR_EACH_FUNCTION (node)$
    {$
      tree fndecl = node->decl;$
$
      /* Skip all non-NORMAL builtins (MD, FRONTEND) entirely.$
^I For NORMAL builtins, skip those that lack an implicit$
^I implementation (closest way to distinguishing DEF_LIB_BUILTIN$
^I from others).  E.g. we need to have typeids for memset().  */$

Or is there something special I need to be doing differently for
comments?

> 
> > +      if (fndecl_built_in_p (fndecl))
> > + {
> > +  if (DECL_BUILT_IN_CLASS (fndecl) != BUILT_IN_NORMAL)
> > +    continue;
> > +  if (!builtin_decl_implicit_p (DECL_FUNCTION_CODE (fndecl)))
> > +    continue;
> > + }
> 
> Also see indentation issue in the above.

      if (fndecl_built_in_p (fndecl))$
^I{$
^I  if (DECL_BUILT_IN_CLASS (fndecl) != BUILT_IN_NORMAL)$
^I    continue;$
^I  if (!builtin_decl_implicit_p (DECL_FUNCTION_CODE (fndecl)))$
^I    continue;$
^I}$

Looks like the same thing?


Thanks for the review! I'll have v4 ready soon.

-Kees

-- 
Kees Cook
