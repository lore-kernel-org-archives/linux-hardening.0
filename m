Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81396212566
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840485; cv=none; b=ewzMY2HX5GAi5tUqz7IR3yqznQGEPMUF3q4fEP3KiZiD5XGbAexaG+BQjupyyn13V7rsujo06J7WosjKmscMEalNgjWwxSwWndJ3SDLS9/l2OjgTf3Xo9SEzjuAVuJ0ZkzoHbhKSjM9+iOHLoAwOM2tiQMf+Lx5PlSPoLNEni9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840485; c=relaxed/simple;
	bh=fY6JDLp1gHbKvLdm6QcRJZrFahcbIkcWdPnEKvOX0G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzQqMoT41aG/d/77JlrFnuSjrrj4H2l1DQ1yw8PkYp54wWZoM8Njo1YE9T/N1GJdO6fbRcYwH0OwHK9rCzuVTdsouUNTxwN9YJQ6yh384K1DTCzNiMytSo4jtzKzI6AkDFfn79j11a3F4SZoEQ0YxygbG0zs9trwCEvMWADHzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrNQnWGq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrNQnWGq"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49c0c5f4dfso205499a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755840483; x=1756445283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYNzfM2GG64lEnucFgHaUxEkC3G6G8qsTwival0Qp7Y=;
        b=PrNQnWGq3TcQlcckHvpNXpmzcq9qjmhMpz9LVBcV2xsrUqf8K4aabHuhgtt+fOy1D+
         Bcj3k4LfWlxRfuA0rsaJWay5L7UjwcZ7kzKv+cm1z1yV+DsJCDw9tApJR+wsqMcEPBIR
         ZgjNeMO7OBQY2AVQs0+yiLU/zOOM49IoOj7nDaTr+flSESTJiXPCoK+e+Zrvdoe79Rd8
         aazeSGM0uTZkvKjgg6UjId1OkjXQzmty104qbYTzgmOKD4mIkekBuGB2Tfe5poP4vyGF
         lg8lzHuY7emv+4bBuxdAaVJ+rh065vxY+wxstkYyBOHSQlpFkujydACRCfzr3BGOtycw
         EQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755840483; x=1756445283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYNzfM2GG64lEnucFgHaUxEkC3G6G8qsTwival0Qp7Y=;
        b=ABxcsGZO6O911ZHMGJlvMc+wOd2KzjMujBZnxwQFdY2h6GA8Zs5mKV6DUR8zmpmomx
         cJzelp06vLfuuwVJm0SvLQmHWTiM9F5e8lYIEh9uNcDoYg0RMnL6872uPvId96biepom
         t873dj6mmhrsNYMtwWPpYWlBCgpQrtkFsLgD6NRiac1lvONcRPWIK96UTl9Rh1RsASP4
         gaPUr3RIjQ7tgryCTTdnb0Xu+KHeKjEiYNyhPYCqcYoXXR9Z1cYYVpfDXTBfRImfkZeb
         8NVpkWzsGvYSp3Yvg01fi3Cewo8m9Le+jSjjtYuuT5iIW1wSSeckVgYMbyWBxFlzliCT
         MhBw==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZR2Y62c/6FSMQuGBzS5P99YnmKsndd0HCU3Tt4gp/EVhz44y9UMDB+VPBOAleghHn1F3z8FpThW/jr+mXps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGLl6KfVPCTg5bSlm6yjm8nqlDdljzneHeTByt9JKk48hf96y
	m5YM2/LnDtkg9snOXjQGnOfq+nBifz4BUtkGEmeofBhTOwIYf3vkjEj9TS20Tpqo8oUOohzdYrV
	ImEXbs3Y6IbMGPNmSydigrBD86jsAkjs=
X-Gm-Gg: ASbGncuWdAtJxKUgedSxtPsAOjzD1XGM47lgK3FVyCoK+BM/BA/1GbsF+M62J76q2+q
	+O2JCwE+gnC3Sl4f+zc2qOOhMcR0ltH8PzniqIrxD25wgg6TKN1RgWiG1MOC2WrwjtMOoXMJ2J6
	M1zvLY/bR0dUmG+kdNLW1/PLznGQudGo5GEy9exb1pcJDNdWPSxiS1Mdfy/HxJ4epmMJ4nDGehA
	I18xA==
X-Google-Smtp-Source: AGHT+IFQfD3+dvIY1HUjP36Jsv6ckBdTnHHl8B1PiJp6kge4BR4Kcf3UbUV94Z3/mQKweODqN6qVVvfa3gwFTqQtRCM=
X-Received: by 2002:a17:902:db0c:b0:240:8c85:4299 with SMTP id
 d9443c01a7336-2462edeeaacmr25964835ad.17.1755840482610; Thu, 21 Aug 2025
 22:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821064202.work.893-kees@kernel.org> <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com> <202508211948.327B5223F@keescook>
In-Reply-To: <202508211948.327B5223F@keescook>
From: Andrew Pinski <pinskia@gmail.com>
Date: Thu, 21 Aug 2025 22:27:50 -0700
X-Gm-Features: Ac12FXyScCgTi8wuw_axF--PYaXfdbaM_DIVfVY19QOMiTOU0RceTQMmD-4Zlb4
Message-ID: <CA+=Sn1k5gntixdu2wT8R-ac2tgYvp-KrAj_q1b-vYUM+dOYBVA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity infrastructure
To: Kees Cook <kees@kernel.org>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>, Qing Zhao <qing.zhao@oracle.com>, 
	gcc-patches@gcc.gnu.org, Joseph Myers <josmyers@redhat.com>, 
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>, 
	Richard Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, 
	Marcus Shawcroft <marcus.shawcroft@arm.com>, Kyrylo Tkachov <kyrylo.tkachov@arm.com>, 
	Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Waterman <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dan Li <ashimida.1990@gmail.com>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:
> > On Thu, Aug 21, 2025 at 12:47=E2=80=AFAM Kees Cook <kees@kernel.org> wr=
ote:
> > > +struct kcfi_target_hooks {
> > > +  /* Apply architecture-specific masking to type ID.  */
> > > +  uint32_t (*mask_type_id) (uint32_t type_id);
> > > +
> > > +  /* Generate bundled KCFI checked call (atomic check + call to prev=
ent
> > > optimizer separation) */
> > > +  rtx (*gen_kcfi_checked_call) (rtx call_insn, rtx target_reg, uint3=
2_t
> > > expected_type, HOST_WIDE_INT prefix_nops);
> > > +
> > > +  /* Add architecture-specific register clobbers for KCFI calls.  */
> > > +  void (*add_kcfi_clobbers) (rtx_insn *call_insn);
> > > +
> > > +  /* Calculate architecture-specific prefix NOPs count (optional, re=
turns
> > > prefix_nops unchanged if NULL) */
> > > +  int (*calculate_prefix_nops) (HOST_WIDE_INT prefix_nops);
> > > +
> > > +  /* Emit architecture-specific type ID instruction (required for co=
mmon
> > > preamble helper) */
> > > +  void (*emit_type_id_instruction) (FILE *file, uint32_t type_id);
> > > +};
> > >
> >
> > This should really be part of target.def so you also have the internals
> > documentation done for these hooks.
> > And then you could just use targetm.kcfi.xyz below.
> > And for the hooks you would have TARGET_KCFI_XYZ being defined like the
> > others one.
>
> Ah-ha! Thank you. The macros to build that eluded me. I've updated to
> this now.
>
> > > +/* Pass creation functions.  */
> > > +class gimple_opt_pass;
> > > +class rtl_opt_pass;
> > > +namespace gcc { class context; }
> > >
> >
> > This above is definitely bad form.
>
> Ah yeah, sorry; this was a leftover. (And below.)
>
> > > +
> > > +extern gimple_opt_pass *make_pass_kcfi (gcc::context *ctxt);
> > > +extern gimple_opt_pass *make_pass_kcfi_O0 (gcc::context *ctxt);
> > > +extern rtl_opt_pass *make_pass_kcfi_final_instrumentation (gcc::cont=
ext
> > > *ctxt);
> > >
> >
> > these 3 lines should just be in tree-pass.h with the other make_pass_*.
>
> Yup, totally. I've moved these now.
>
> > > diff --git a/gcc/cfgexpand.cc b/gcc/cfgexpand.cc
> > > index 8950294abb60..432ccc7f864a 100644
> > > --- a/gcc/cfgexpand.cc
> > > +++ b/gcc/cfgexpand.cc
> > > @@ -76,6 +76,7 @@ along with GCC; see the file COPYING3.  If not see
> > >  #include "opts.h"
> > >  #include "gimple-range.h"
> > >  #include "rtl-iter.h"
> > > +#include "kcfi.h"
> > >
> > >  /* Some systems use __main in a way incompatible with its use in gcc=
, in
> > > these
> > >     cases use the macros NAME__MAIN to give a quoted symbol and
> > > SYMBOL__MAIN to
> > > @@ -3203,6 +3204,66 @@ expand_call_stmt (gcall *stmt)
> > >    else
> > >      expand_expr (exp, const0_rtx, VOIDmode, EXPAND_NORMAL);
> > >
> > > +  /* Add KCFI annotations if this is an indirect call with KCFI wrap=
per
> > > type.  */
> > > +  if (sanitize_flags_p (SANITIZE_KCFI) && !gimple_call_fndecl (stmt)=
)
> > >
> >
> > Internal function calls with also have a null fndecl can you double che=
ck
> > that you don't have an internal function call here?
>
> I think I need this explained in more detail. This logic mostly matches
> the nocf_check below:
>
>   if (gimple_call_nocf_check_p (stmt)
>       && !gimple_call_fndecl (stmt))
>
> Or do you mean the fn_type below?

So nocf check is on the GIMPLE_CALL first unlike your code. The nocf
is set only from the original function type so it will NOT be on calls
to internal function. You just need to check gimple_call_internal_p
first.
But then I missed that expand_call_stmt does a check for call internal
very first. So just add a comment/assert that you will not have an
internal call here.

Thanks,
Andrew

> >
> >
> > > +    {
> > > +      tree fn_type =3D gimple_call_fntype (stmt);
> > > +      gcc_assert (fn_type);
>
> ... here? I haven't encountered this assert, if that's a useful signal. :=
)
>
> > > +      tree attr =3D lookup_attribute ("kcfi_type_id", TYPE_ATTRIBUTE=
S
> > > (fn_type));
> > > +      if (attr && TREE_VALUE (attr))
> > > +       {
> > > +         /* Check if this call site originated from a no_sanitize("k=
cfi")
> > > function
> > > +            during inlining. If so, skip KCFI instrumentation in RTL
> > > phase too.  */
> > >
> >
> > Why not add a bit to gimple_call and add while inlining instead of look=
ing
> > it up afterwards?
> > I am not 100% sure the BLOCK will always be correct.
>
> Ah, I think I see how: add a new GF_CALL_* flag? I'll go find where
> inlining happens...
>
> > > +         bool should_skip_kcfi =3D false;
> > > +         location_t call_location =3D gimple_location (stmt);
> > > +         gcc_assert (call_location !=3D UNKNOWN_LOCATION);
> > > +
> > > +         tree block =3D gimple_block (stmt);
> > > +         while (block && TREE_CODE (block) =3D=3D BLOCK)
> > > +           {
> > > +             tree fn_decl =3D BLOCK_ABSTRACT_ORIGIN (block);
> > > +             if (fn_decl && TREE_CODE (fn_decl) =3D=3D FUNCTION_DECL=
)
> > > +               {
> > > +                 /* Found an inlined function - check if it has
> > > no_sanitize("kcfi").  */
> > > +                 if (!sanitize_flags_p (SANITIZE_KCFI, fn_decl))
> > > +                   {
> > > +                     should_skip_kcfi =3D true;
> > > +                     break;
> > > +                   }
> > > +                 break;
> > > +               }
> > > +             /* Move up the block chain to find parent inlined
> > > functions.  */
> > > +             block =3D BLOCK_SUPERCONTEXT (block);
> > > +           }
> > > +
> > > +         if (!should_skip_kcfi)
> > > +           {
> > > +             uint32_t kcfi_type_id =3D (uint32_t) tree_to_uhwi (TREE=
_VALUE
> > > (attr));
> > > +
> > > +             /* Find the call that has been created.  */
> > > +             rtx_insn *call_insn =3D get_last_insn ();
> > > +             while (call_insn && call_insn !=3D before_call && !CALL=
_P
> > > (call_insn))
> > > +               call_insn =3D PREV_INSN (call_insn);
> > >
> >
> > This seems very fragile why not do this inside expand_call in calls.cc
> > instead of expand_call_stmt ?
>
> In expand_call, I couldn't find a way to have access to both the GIMPLE
> (for the typeid) and the just-created RTL to attach the clobbers and
> typeid. Initially I tried to just insert my own RTL in expand_call, but
> there are some very complicated things going on in the default expansion,
> so I needed to just let those run before I could try to tag the actually
> produced call insn.
>
> After looking through expand_call_stmt, I found the pattern used by
> nocf_check, which seems to be doing very nearly the same thing KCFI
> needed, so I repeated it (with great success). :)
>
> I am, of course, happy to try moving it somewhere else!
>
> > > +
> > > +             if (call_insn && call_insn !=3D before_call && CALL_P
> > > (call_insn))
> > > +               {
> > > +                 /* Add KCFI type ID note for anti-merging protectio=
n.  */
> > > +                 add_kcfi_type_note (call_insn, kcfi_type_id);
> > > +
> > > +                 /* Add architecture-specific clobbers so register
> > > allocator knows
> > > +                    they'll be used.  */
> > > +                 if (kcfi_target.add_kcfi_clobbers)
> > > +                   kcfi_target.add_kcfi_clobbers (call_insn);
> > > +               }
> > > +             else
> > > +               {
> > > +                 error ("KCFI: Could not find call instruction for
> > > wrapper type");
> > > +                 gcc_unreachable ();
> > >
> >
> > internal_error instead of error/gcc_unreachable.
>
> Okay, I will fix these. And I see fatal_error as well; is that just for
> user fixable issues? (i.e. I probably just need to use internal_error
> exclusively for these kind of sanity checking pieces.)
>
> > > +kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx)
> > > +{
> > > +  /* Convert trap label to string using standard GCC helper.  */
> > > +  char trap_name[64];
> > > +  ASM_GENERATE_INTERNAL_LABEL (trap_name, "L", CODE_LABEL_NUMBER
> > > (trap_label_rtx));
> > > +
> > > +  /* Generate entry label name from trap label number.  */
> > > +  char entry_name[64];
> > > +  ASM_GENERATE_INTERNAL_LABEL (entry_name, "Lentry", CODE_LABEL_NUMB=
ER
> > > (trap_label_rtx));
> > > +
> > > +  /* Emit .kcfi_traps section entry using the converted labels.  */
> > > +  fprintf (file, "\t.pushsection\t.kcfi_traps,\"ao\",@progbits,.text=
\n");
> > >
> >
> > This is totally wrong.  instead look at varasm and use a section.
>
> I've spent some more time looking through here and I *think* I see
> how it's expected to be done with get_section. The trouble seems to be
> with SECTION_LINK_ORDER which appears to need explicit special-casing
> with a strcmp? (There's an exception for __patchable_function_entries
> already.) It feels very weird. :P
>
> My new change to default_elf_asm_named_section replaces:
>
>          /* For now, only section "__patchable_function_entries"
>             adopts flag SECTION_LINK_ORDER, internal label LPFE*
>             was emitted in default_print_patchable_function_entry,
>             just place it here for linked_to section.  */
>          gcc_assert (!strcmp (name, "__patchable_function_entries"));
>          fprintf (asm_out_file, ",");
>          char buf[256];
>          ASM_GENERATE_INTERNAL_LABEL (buf, "LPFE",
>                                       current_function_funcdef_no);
>          assemble_name_raw (asm_out_file, buf);
>
> with:
>
>          if (!strcmp (name, "__patchable_function_entries"))
>            {
>              /* For patchable function entries, internal label LPFE*
>                 was emitted in default_print_patchable_function_entry,
>                 just place it here for linked_to section.  */
>              fprintf (asm_out_file, ",");
>              char buf[256];
>              ASM_GENERATE_INTERNAL_LABEL (buf, "LPFE",
>                                           current_function_funcdef_no);
>              assemble_name_raw (asm_out_file, buf);
>            }
>          else if (!strcmp (name, ".kcfi_traps"))
>            {
>              /* KCFI traps section links to .text section.  */
>              fprintf (asm_out_file, ",.text");
>            }
>          else
>            internal_error ("unexpected use of SECTION_LINK_ORDER by secti=
on %qs",
>                            name);
>
> These strcmps seem odd. Do __patchable_function_entries and .kcfi_traps
> need dedicated global sections like done for others (e.g.  exception_sect=
ion)?
> I really can't tell what the right approach should be here.
>
> > +  assemble_name (file, entry_name);
> > > +  fprintf (file, ":\n");
> > > +  fprintf (file, "\t.long\t");
> > > +  assemble_name (file, trap_name);
> > > +  fprintf (file, " - ");
> > > +  assemble_name (file, entry_name);
> > > +  fprintf (file, "\n");
> > >
> >
> > There are better ways of generating this subtraction.
>
> I couldn't find an obvious helper for this. I looked for stuff doing
> subtraction, relative offsets, etc. The closest I could find was
> dw2_asm_output_delta, but it's quite specialized. Were you thinking that
> using get_rtx* was the better way on this (like dw2_asm_output_delta
> does)? I now currently have:
>
>   section *saved_section =3D in_section;
>
>   section *kcfi_traps_section =3D get_section (".kcfi_traps",
>                                              SECTION_LINK_ORDER, NULL);
>   switch_to_section (kcfi_traps_section);
>
>   ASM_OUTPUT_LABEL (file, entry_name);
>
>   rtx trap_symbol =3D gen_rtx_SYMBOL_REF (Pmode, trap_name);
>   rtx entry_symbol =3D gen_rtx_SYMBOL_REF (Pmode, entry_name);
>   rtx addr_diff =3D gen_rtx_MINUS (Pmode, trap_symbol, entry_symbol);
>
>   /* Emit the address difference as a 4-byte value.  */
>   assemble_integer (addr_diff, 4, BITS_PER_UNIT, 1);
>
>   switch_to_section (saved_section);
>
> > > +  fprintf (file, "\t.popsection\n");
> > > +}
> > > +
> > > +/* Hash function for KCFI type ID computation.
> > > +   This implements a simple hash similar to FNV-1a.  */
> > > +static uint32_t
> > > +kcfi_hash_string (const char *str)
> > > +{
> > > +  uint32_t hash =3D 2166136261U; /* FNV-1a 32-bit offset basis.  */
> > > +  for (const char *p =3D str; *p; p++)
> > > +    {
> > > +      hash ^=3D (unsigned char) *p;
> > > +      hash *=3D 16777619U; /* FNV-1a 32-bit prime.  */
> > > +    }
> > > +  return hash;
> > > +}
> > > +
> > > +/* Compute KCFI type ID for a function declaration or function type
> > > (internal) */
> > > +static uint32_t
> > > +compute_kcfi_type_id (tree fntype_or_fndecl)
> > > +{
> > > +  if (!fntype_or_fndecl)
> > > +    return 0;
> > > +
> > > +  const char *canonical_name =3D mangle_function_type (fntype_or_fnd=
ecl);
> > > +  uint32_t base_type_id =3D kcfi_hash_string (canonical_name);
> > >
> >
> > Now I am curious why this needs to be a mangled function name? Since th=
e
> > function in C the symbol is just its name.
> > Is there documentation that says the hash needs to be based on all of t=
he
> > function arguments types?
> > Also since you are producing a mangled name just to produce a hash and
> > throwing away the mangled name (except writing it to a dump file which =
is
> > just human readable), instead if better just to produce the hash from t=
he
> > function type instead of doing it in 2 steps?
>
> I think this has been answered in other replies, but: yes, hash is based
> on entire function prototype (and not function name). The mangling is
> there to be human readable (it was an existing ABI so seemed a stable
> intermediate). But yes, we could just go directly to the hash and build
> the string only for the dumpfile, if no one wants to reuse this mangler?
>
> Thanks for the review!
>
> -Kees
>
> --
> Kees Cook
