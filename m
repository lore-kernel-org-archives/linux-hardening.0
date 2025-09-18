Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67334BA53
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219660; cv=none; b=q6IS76UDFym/o/3JNhAkdikDxkqI4fP1oWiYkDgm2B+evYqycBTiG1gdETFvdQnSst9+NCDjwpJG/OBaB33ZU1EpqY4uu6YWRQuTmAVMqfEib14/dOr40FgCNlljTPBieY9VIY7YGuaiPwWbTKl7sJVUl7tKBYgLYTmZvdHA2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219660; c=relaxed/simple;
	bh=vz8t5yPR5ESZSe7j+7P/ZvM4MT76gxp4DlFFkZUxVLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMnPJqMpT4tbrWw7E3kAYHaFEtCEEKNpgOImm4dozTidpXnJWaCEw2CTJUS6WUwt0oCZuV5TC3FDKJvff5OJZ+IeTOpy2ISaEWMsb9yNqmeikTOvSKLeCbAuM3nYxyNNn5g/UgWTNuZtoc0ApfJRAvIVQPErV0KsevEIuRIBftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ7U8TQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ7U8TQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B6DC4CEE7;
	Thu, 18 Sep 2025 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758219659;
	bh=vz8t5yPR5ESZSe7j+7P/ZvM4MT76gxp4DlFFkZUxVLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZ7U8TQWFQFez/BbWuqs7uepdppWKT2q8rPVF4F9WPDqx6VV5ICaFVYLUu74DvQDR
	 lxREtOaZ/i22p/en9vRi+MR9enAcrUbO3kh8jtpBKnZR29oPDGqtjQ0cRkpiXbAgT4
	 vS+1P4WgSjL7Z+CUz45SZjifi7yrj8vdxngjD2AInrJbZpQ7OUSnB1WncH9+ot5cou
	 ikzlLo8pasJV/09iNxWsZFppdPZIaSqhCl+5mhT9goN6wIZu4GrZHRF4gfnFXq92Ms
	 58ETDVRAj0yVWd/zOCNxhBW//YKuGrrB62u59ZcD3NSxrTsSyFcSi6mqUGe9/Dfz4R
	 8AMjB0LSRx+4A==
Date: Thu, 18 Sep 2025 11:20:59 -0700
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
Message-ID: <202509181112.B39B490E@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-2-kees@kernel.org>
 <6F94A091-6948-4220-A972-236055C2440A@oracle.com>
 <202509171307.DC9740ABAB@keescook>
 <306E5909-C77F-415E-A2F4-6FAE3E5740DB@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <306E5909-C77F-415E-A2F4-6FAE3E5740DB@oracle.com>

On Thu, Sep 18, 2025 at 04:59:56PM +0000, Qing Zhao wrote:
> 
> 
> > On Sep 17, 2025, at 17:09, Kees Cook <kees@kernel.org> wrote:
> > 
> > On Wed, Sep 17, 2025 at 01:42:32PM +0000, Qing Zhao wrote:
> >> This version of the middle-end change is much simpler and cleaner-:).
> > 
> > Thanks! I think it's getter closer (hopefully). :)
> > 
> >>> On Sep 13, 2025, at 19:23, Kees Cook <kees@kernel.org> wrote:
> [...]
> The above examples explain the whole picture very well.
> It might be a good idea to include them as comments of the routine “kcfi_prepare_alignment_nops”. 

I've expanded this much more now for the future v4.

> >>> +- External functions that are address-taken have a weak __kcfi_typeid_$func
> >>> +  symbol added with the typeid value available so that the typeid can be
> >>> +  referenced from assembly linkages, etc, where the typeid values cannot be
> >>> +  calculated (i.e where C type information is missing):
> >>> +
> >>> +    .weak   __kcfi_typeid_$func
> >>> +    .set    __kcfi_typeid_$func, $typeid
> >>> +
> >> 
> >> From my previous understanding, the above weak symbol is emitted for external functions
> >> that are address-taken AND does not have a definition in the compilation. So the weak symbols
> >> Is emitted at the declaration site of the external function, is this true?
> >> 
> >> If so, could you please clarify this in the above?
> > 
> > Yes, this happens via assemble_external_real, which can be called under
> > a few conditions in gcc/varasm.cc.
> 
> Okay. Please clarify this in the design doc. 

I mention it later in the "behavioral" section:

- assemble_external_real calls kcfi_emit_typeid_symbol to add the
  __kcfi_typeid_$func symbols.

I had left off implementation details (i.e. "called from
assemble_external_real") in the "constraints" section. How would you
like this arranged?

> >>> +- Keep indirect calls from being merged (see earlier example) by
> >>> +  checking the KCFI insn's typeid for equality.
> >> 
> >> Is this resolved by the following code:
> >> 
> >> rtlanal.cc
> >> index 63a1d08c46cf..5016fe93ccac 100644
> >> --- a/gcc/rtlanal.cc
> >> +++ b/gcc/rtlanal.cc
> >> @@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
> >>    case IF_THEN_ELSE:
> >>      return reg_overlap_mentioned_p (x, body);
> >> 
> >> +    case KCFI:
> >> +      /* For KCFI wrapper, check both the wrapped call and the type ID.  */
> >> +      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
> >> +      || reg_overlap_mentioned_p (x, XEXP (body, 1)));
> >> +
> > 
> > The above is needed for accurate register "liveness" checking. When the
> > above code is removed, the kcfi-move-preservation.c regression test
> > fails (since it doesn't see the clobbers).
> Okay.  I see. 
> > 
> > AFAICT, simply making it a new type of RTL (the DEF_RTL_EXPR), made it
> > unmergeable.
> 
> Then is it possible some legal merging might not work anymore with this change? 

Perhaps? I will see if I can construct a case where there should be a
"merged" call (when the typeid matches).

> 
> > I assume this is because whatever was doing the call
> > merging was looking strictly for "CALL" types, but I honestly don't know
> > where that was happening.
> > 
> >>> +/* Common helper for RTL patterns to emit .kcfi_traps section entry.  */
> >> 
> >> I noticed that you didn’t explain each parameter of the function in all the comments for the functions.
> >> This need to be updated for all the new functions.
> > 
> > For externs like these, should the parameter documentation go in the .h
> > file, or the .cc file?
> 
> My understanding is the parameter doc going in the .cc file (just double checked some gcc files to make sure this) -:)

Okay, thanks! I will update these.

> > 
> >>> +void
> >>> +kcfi_emit_traps_section (FILE *file, rtx trap_label_sym)
> >>> +{
> >>> +  /* Generate entry label internally and get its number.  */
> >>> +  rtx entry_label = gen_label_rtx ();
> >>> +  int entry_labelno = CODE_LABEL_NUMBER (entry_label);
> >> 
> >> Is the only usage of the new RTX “entry_label” is to generate a label_number? 
> >> If so, the entry_label is not needed at all.  You can get a distinct labelno for each
> >> Lkcfi_entry, for example, the function id for the current function.
> > 
> > It is, yes. I can't use the function id because it's only incremented per
> > function and a given function may have multiple kcfi call sites within
> > it.
> 
> Okay.  I see. 
> 
> So, you need a unique lableno for each Lkcfi_entryN? Any other requirement?

Right, I need unique labels for each of trap, call, and entry. But they
are all associated together, so they could use a single counter.

> > I did have a version of this logic that used a kcfi-specific global
> > counter but (at the time) I was having trouble with it
> 
> What kind of issue? 
> 
> > and had seen that
> > other "custom label" examples in the code base used this style, so I
> > switched to that.
> 
> My concern is, the new generated RTX "entry_label” is not used at all, will there be any member leak from this?
> 
> 
> > 
> > I have since figured out why the global counter wasn't work (I was using
> > it during expansion and not during insn output, so I had cases where a
> > call was getting duplicated and I had a repeated label). If it's
> > preferred, I could try switching back to the global counter to avoid
> > these "useless" gen_label_rtx calls?
> 
> Yes, global counter approach is better. 

Okay, I will switch to that.

> 
> > 
> >>> +static uint32_t
> >>> +kcfi_get_type_id (tree fn_type)
> >>> +{
> >>> +  uint32_t type_id;
> >>> +
> >>> +  /* Cache the attribute identifier.  */
> >>> +  if (!kcfi_type_id_attr)
> >>> +    kcfi_type_id_attr = get_identifier ("kcfi_type_id");
> >>> +
> >>> +  tree attr = lookup_attribute (IDENTIFIER_POINTER (kcfi_type_id_attr),
> >>> + TYPE_ATTRIBUTES (fn_type));
> >> 
> >> The above can be simplified as:
> >> +  tree attr = lookup_attribute (“kcfi_type_id”, TYPE_ATTRIBUTES (fn_type));
> > 
> > Ugh, I totally misunderstood the examples I saw of this. I thought they
> > were caching the string lookup, but now that I look more closely, I see:
> > 
> > #define IDENTIFIER_POINTER(NODE) \
> >  ((const char *) IDENTIFIER_NODE_CHECK (NODE)->identifier.id.str)
> > 
> > it's just returning the string!
> > 
> > I will throw away the "caching" I was doing. I thought it would actually
> > look up the attribute using the tree returned by get_identifier, but I
> > see there is no overloaded lookup_attribute that takes a tree argument.
> > 
> > *face palm*
> 
> -:)

Okay, so I tried to remove this and remembered that it's actually cached
not for lookup_attribute, but for build_tree_list call case:

      tree attr = build_tree_list (kcfi_type_id_attr, type_id_tree);

      TYPE_ATTRIBUTES (fn_type) = chainon (TYPE_ATTRIBUTES (fn_type), attr);

For _that_, I need a "tree" argument. So instead of building it each
time, I have it built already, and I can get at its string for
lookup_attribute too. So I think this code is good as-is.

Thanks!

-Kees

-- 
Kees Cook
