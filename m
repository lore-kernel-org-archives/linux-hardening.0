Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8113BD653
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154851; cv=none; b=Ct97qq2iGdDjjiVBPRSg4N20EjKpR4b1N2QrI+3nFfghWcvMKeF2mw6YH5HptJBo+wS+S/fNsU7UHBu2NjewKnLFhlDN5jP5uDtNuAMt51eD/QO01eM8Yrrg+IdWFAQRctCvfityCyxKXXTBBbT0qVGvEoRmI3HUjWeN0ZB9i3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154851; c=relaxed/simple;
	bh=A5TJo5DNwQJUUQ+1OZBTxnzBCRLf/emq3cdku/Npz7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKU2yMTlGUSEIeJdpwuhfcWUXotBYQno2bFtQ2mbMVb0lVz9ZiNh3tX0Nvup1bn1P3nZWGeh7C2f2RD5cHPFooNtnn5JSDSHhw888uU6hn8jsu3iKxDk7PXZlR9QpOPxtotoy1i5WUIXfRdvU8v+VDNwLrnbzKFL/f0noV6VJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7TBRDmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7TBRDmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B451F000E9;
	Wed, 15 Jul 2026 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784154849;
	bh=4L3VkpWzLwo4AefEcnLv88AWAfcpGpCE7v4J8YEdpgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a7TBRDmQZ9mi9OyJ+7AfaMpDVXqUBpp9YGHT3s4/Tp/7U4qD09DzEkeYsG+ZArqWF
	 G+NNXwwmZsuZdoqI35rU9OWEkrS85FviDALTydxvgetmWyfankXqr3GuZqjKAEp5MN
	 1MP3YnNTnYhtyd6RLT9qpnvDg8JbzcfHHz/i+eA670maR9hQ21bjXsqP6qIkiBC/39
	 gPjb4qX5CvMX9ZrPzXkCVHWmztVwq+EWQUSIqxbfiN5SksHD0r7zjYPyi2y3bbsWNI
	 +6CqwabUNBEl7lakXo54UVrQn9coVOBt1DRq9cOJeCie2p5QAq4Pln+lDhf7p/wxyD
	 SMVf5AriBDfQg==
Date: Wed, 15 Jul 2026 15:34:09 -0700
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
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
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v13 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202607151337.31D0828D0@keescook>
References: <20260618204530.work.910-kees@kernel.org>
 <20260618204539.824446-2-kees@kernel.org>
 <CALvbMcDwYgJNo=qeZY1m+zAutURc7rfRCaW960DDjbRAOKUZ+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcDwYgJNo=qeZY1m+zAutURc7rfRCaW960DDjbRAOKUZ+w@mail.gmail.com>

On Sat, Jun 27, 2026 at 03:57:36PM -0700, Andrea Pinski wrote:
> On Thu, Jun 18, 2026 at 1:45 PM Kees Cook <kees@kernel.org> wrote:
> > [...]
> > diff --git a/gcc/kcfi.h b/gcc/kcfi.h
> > new file mode 100644
> > index 000000000000..ea7e7881040f
> > --- /dev/null
> > +++ b/gcc/kcfi.h
> > [...]
> > +#include "config.h"
> > +#include "system.h"
> > +#include "coretypes.h"
> > +#include "rtl.h"
> 
> This is wrong. Don't include config.h nor system.h in a header file.

Okay, removing.

> 
> > +
> > +/* Common helper for RTL patterns to emit .kcfi_traps section entry.
> > +   Call after emitting trap label and instruction with the trap symbol
> > +   reference.  */
> > +extern void kcfi_emit_traps_section (FILE *file, rtx trap_label_sym,
> > +                                     int labelno);
> > +
> > +/* Extract KCFI type ID from current GIMPLE statement.  */
> > +extern rtx internal_kcfi_get_type_id_for_expanding_gimple_call (void);
> > +
> > +/* Convenience wrapper to check for SANITIZE_KCFI.  */
> > +static inline rtx
> Remove static.

Okay. This is a Linux-ism in my finger, I think. :)

> > [...]
> > --- /dev/null
> > +++ b/gcc/kcfi.cc
> > @@ -0,0 +1,696 @@
> > +/* Kernel Control Flow Integrity (KCFI) support for GCC.
> > +   Copyright (C) 2025 Free Software Foundation, Inc.
> 
> 2026.

Yup, I went and hunted down all of these.

> > [...]
> > +#include "config.h"
> `#define INCLUDE_STRING` is needed based on review of the previous patch.

Got it.

> > [...]
> > +/* KCFI label counter, incremented by KCFI insn emission.  */
> > +static int kcfi_labelno = 0;
> 
> I am not 100% sure if this needs a GTY marker or not. I suspect no
> because we should not have emitted assembly code yet.

If this moves with kcfi_next_labelno into final, I think it's okay
without GTY?

> > +
> > +/* Get next KCFI label number.  Returns the current KCFI label number
> > +   and increments the internal counter for the next call.  The label is
> > +   used to provide a unique number for each indirect callsite of the
> > +   current module of the compilation.  */
> > +
> > +int
> > +kcfi_next_labelno (void)
> > +{
> > +  return kcfi_labelno++;
> > +}
> 
> Seems like this should be instead in `final.{cc,h}` rather than `kfci.{cc,h}`.

I think you want this because it's exclusively used during output phase?
I'll get it moved.

> > +/* Function attribute to store KCFI type ID.  */
> > +static tree kcfi_type_id_attr = NULL_TREE;
> 
> This 100% needs a GTY marker. to make sure the identifier does not get freed.

Got it.

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
> > +  tree attr = lookup_attribute ("kcfi_type_id", TYPE_ATTRIBUTES (fn_type));
> > +  if (attr)
> > +    {
> > +      tree value = TREE_VALUE (attr);
> > +      gcc_assert (value && TREE_CODE (value) == INTEGER_CST);
> gcc_assert (tree_fits_uhwi_p (value));
> type_id = tree_to_uhwi (value);

Updated.

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
> 
> Instead of an attribute there must be a better way of doing this.
> Maybe a hashset instead.

Perhaps? I will go examine this vs LTO, etc.

> > [...]
> > +rtx
> > +internal_kcfi_get_type_id_for_expanding_gimple_call (void)
> > +{
> > +  gcc_assert (currently_expanding_gimple_stmt);
> 
> gcall *call_stmt = dyn_cast<gcall *> (currently_expanding_gimple_stmt);
> gcc_assert (call_stmt);

Updated.

> > [...]
> > +  /* Emit .type directive.  */
> > +  ASM_OUTPUT_TYPE_DIRECTIVE (asm_file, cfi_symbol_name.c_str (), "function");
> > +  ASM_OUTPUT_LABEL (asm_file, cfi_symbol_name.c_str ());
> > +
> > +  /* Emit any needed alignment padding NOPs using target's NOP template.  */
> > +  for (int i = 0; i < kcfi_alignment_padding_nops; i++)
> > +    output_asm_insn (kcfi_nop, NULL);
> I think you need to calculate kcfi_nop each time you call this
> function. Instead of caching it. For GC reasons.

Uh, do I have to? This seems wasteful: the nop is generated frequently.
Should kcfi_nop gain GTY instead? I will take a closer look at this.

> > [...]
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
> > +        For NORMAL builtins, skip those that lack an implicit
> > +        implementation (closest way to distinguishing DEF_LIB_BUILTIN
> > +        from others).  E.g. we need to have typeids for memset().  */
> > +      if (fndecl_built_in_p (fndecl))
> > +       {
> > +         if (DECL_BUILT_IN_CLASS (fndecl) != BUILT_IN_NORMAL)
> > +           continue;
> > +         if (!builtin_decl_implicit_p (DECL_FUNCTION_CODE (fndecl)))
> > +           continue;
> > +       }
> > +
> > +      /* Cache the type_id in the function type.  */
> > +      kcfi_get_type_id (TREE_TYPE (fndecl));
> 
> Why are you needing to cache here?

This was originally added for the __kcfi_typeid emission for functions
known to the TU since at the time I couldn't figure out how to deal with
lacking FN_TYPE (to see the function argument types), but that logic
changed in v3, and I never noticed I didn't have to cache it any more.
It looks like I can drop this.

So... we could just not cache this at all, I guess? It seems wrong to
keep resolving the same typeid over and over though. I will look at
hashset, though, as you suggested.

-Kees

-- 
Kees Cook
