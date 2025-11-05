Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82F2FE050
	for <linux-hardening@vger.kernel.org>; Wed,  5 Nov 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334773; cv=none; b=Zw+rx7Nl8fAR9YKei2Pz/aHmBsydym/wx14GLfvOoKkeXLaEaR65QqvDV++3hMsx9PfgwFQ4ktv1q4LwuP7tcHPdlCeuFwTD1i+wWaDZirebAAQBetViBUO8+UNbQMaYn5seWk3hmVBAwXWDEVqHnPERzrjx0g3v0i1dbPfcUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334773; c=relaxed/simple;
	bh=1gMVUeY1We+2uT+jFrkNSAtBkHyWf04VaJz8aIOfFvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3kj6dYrXx4g/103yr09MY7JFRaJPQlqILPGQ5v32CvdUETYdT4CDZy8q0f6posasbDQctJsFwdyIyGud68v4wBxLORv+WbSQ0S/KjApl3SGWt1ssbiB1ftGzx20Myzu6L+l64RzNKeO8EL9ybcacRpBVS9Z0A8bE64YyYOmvWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuwkP68h; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuwkP68h"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so23630771fa.3
        for <linux-hardening@vger.kernel.org>; Wed, 05 Nov 2025 01:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762334768; x=1762939568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pE9z4kMb+pMo+xGvo2//hSGHd260ks3U/2TY4FDak/Y=;
        b=AuwkP68h/rY5SfJzdjwK1sJrzw4UhJbgx9y9t7ImC8JM80eCMOo2YlHoXby9WXkkRL
         g0l1RrSdLkdPq8dINzDf9qtL+XBO4ug8WgAK6IqBtugPdvUjra/yqS/cdm+qR0VVubFM
         Y/SnpjsK/Fp3PKmgC6EiafrTkQaSfEDpI98GJd6rzDquz3lnDzmlhy1XxNV/ZOL8u1zv
         P7KSJtuVslanU00jnVi0zXZFguq13AlG5hhfYognC7rxNDSYZLsaz46dId5i4hXLTbPW
         BS1sW+woBUQFC2kIInReNWLUWyCCVaHwXiVHM3MmWjo8nOzVUsShh6RQeDHCw5OiJTNo
         FdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334768; x=1762939568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pE9z4kMb+pMo+xGvo2//hSGHd260ks3U/2TY4FDak/Y=;
        b=NVrbaFew3WYZEIMFijABjR1N8mefkBBs2fQ/lpzYm42CZGAUslDqilPOE58j3wjXLS
         C3Pk2DPIbhgqQNrbbOYT0ua51NazL+sffnahkL5Cqh7uIdQuzd4pGaWNRMEKsIIWqnds
         vXvLCRUY2VY8FoRLMSl72+izh5q7JLV2RL61at+WORRNQvfMpHKuNRUzYW+XNu6yvQrQ
         ObQzvBfXEHPMy4r48RrnuQRTrWipkumef5ebIhyLi0mRMlTUu8p0vSEsxKVQSi5HJ2cG
         2wIheNA9Gu2r0tompRItSBb3329j9tG1bg4BweFMmzsk0vjm2De2BpZs9TgZIvX/8GTO
         2Ilg==
X-Forwarded-Encrypted: i=1; AJvYcCVI1YlEO32Huq3UbavH1xqJta4VpcXcxP05GKVtH/8bK0m9Xs2Zyj30Bk+D4eqAx+QWe1ZWTBZqB9CL7pogkho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKblHpCOHU4RcKb4Lo4Qy9tSg8hyLzBXHmQToaR4pWcjMtuyBn
	pgrtTX59SDiM4sfy96VTprSk5CIj/Ln1k1zDoR0Oh+Jyog3W0KmCI/KEvpQ/B0SaVxNZim8F0oE
	Bqam8/qGvJivYGe9cTBm/hrnQZlkgkSE=
X-Gm-Gg: ASbGncuKST+oGSFWweyPfS7cxokh5XE6s6/mk67KYZHn9PpFKHwVQrCz4Wa3AqJWlHY
	6ThSOpA2lAcNKbIAbhjQy0hw3G4PhKJ8QGSG2ftLPM4J+vuN0swf2twuzGmrtas9BT5l+dz+THW
	CQ3l2Mk3KMpcXT6vvMS5ny3uc0hGg+v+kfkewFkzUAidDzw98UZaxJ21pHWBreGsP8YRWsnGBmJ
	WoT6MEJLQ34xTj3QG2qJg4t1OyH2YA8odYft09kTVIFnxSWA7ZYwvpqUzT3Twuifs4sumI=
X-Google-Smtp-Source: AGHT+IH1ckd8c25eG3PlV+Nl542LZProPLOXjFK0rpKqG7hxtqSHrrDkgkR4w0cIgnuSphBeFzsiZhPNhcIKCfm0ZQc=
X-Received: by 2002:a2e:9652:0:b0:36b:3a21:9c04 with SMTP id
 38308e7fff4ca-37a514888a7mr5021051fa.36.1762334767020; Wed, 05 Nov 2025
 01:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104165430.it.619-kees@kernel.org> <20251104165447.2835584-4-kees@kernel.org>
In-Reply-To: <20251104165447.2835584-4-kees@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 5 Nov 2025 10:25:54 +0100
X-Gm-Features: AWmQ_bkfwSKJFWsbHcDzUJeamBfE2RPgDgl37MV9l56M-IRAxgEZzq4944CdhDc
Message-ID: <CAFULd4Zh0fevd-wS2dVU4S3gS6--4hsFQSnh9yW9MB34_dSTng@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] x86: Add x86_64 Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>, 
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>, Richard Biener <rguenther@suse.de>, 
	Joseph Myers <josmyers@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>, Jan Hubicka <hubicka@ucw.cz>, 
	Richard Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, 
	Marcus Shawcroft <marcus.shawcroft@arm.com>, Kyrylo Tkachov <kyrylo.tkachov@arm.com>, 
	Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Waterman <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, 
	Dan Li <ashimida.1990@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Ramon de C Valle <rcvalle@google.com>, Joao Moreira <joao@overdrivepizza.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>, 
	"Constable, Scott D" <scott.d.constable@intel.com>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c396310642d589a3"

--000000000000c396310642d589a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:54=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Implement x86_64-specific KCFI backend:
>
> - Implies -mindirect-branch-register since KCFI needs call target in
>   a register for typeid hash loading.
>
> - Function preamble generation with type IDs positioned at -(4+prefix_nop=
s)
>   offset from function entry point.
>
> - Function-aligned KCFI preambles using calculated alignment padding NOPs=
:
>   aligned(prefix_nops + 5, $func_align) to maintain ability to call the
>   __cfi_ preamble directly in the case of Linux's FineIBT alternative
>   CFI sequences (live patched into place).
>
> - Type-id hash avoids generating ENDBR instruction in type IDs
>   (0xfa1e0ff3/0xfb1e0ff3 are incremented by 1 to prevent execution).
>
> - On-demand scratch register allocation strategy (r11 as needed), with
>   the clobbers added when KCFI is used.
>
> - Incompatible with -ffixed-r10 or -ffixed-r11.
>
> - Uses the .kcfi_traps section for debugger/runtime metadata.
>
> - Introduces -fsanitize-kcfi-arity to enable function arg count to be
>   represented in the kcfi hash preamble for FineIBT.
>
> Assembly Code Pattern layout required by Linux kernel:
>   movl $inverse_type_id, %r10d   ; Load expected type (0 - hash)
>   addl offset(%target), %r10d    ; Add stored type ID from preamble
>   je .Lkcfi_call                 ; Branch if types match (sum =3D=3D 0)
>   .Lkcfi_trap: ud2               ; Undefined instruction trap on mismatch
>   .Lkcfi_call: call/jmp *%target ; Execute validated indirect transfer
>
> Build and run tested on x86_64 Linux kernel with various CPU errata
> handling alternatives, with and without FineIBT patching.
>
> gcc/ChangeLog:
>
>         config/i386/i386.h: KCFI enables TARGET_INDIRECT_BRANCH_REGISTER.
>         config/i386/i386-protos.h: Declare ix86_output_kcfi_insn().
>         config/i386/i386-expand.cc (ix86_expand_call): Expand indirect
>         calls into KCFI RTL.
>         config/i386/i386.cc (ix86_kcfi_mask_type_id): New function.
>         (ix86_output_kcfi_insn): New function to emit KCFI assembly.
>         config/i386/i386.md: Add KCFI RTL patterns.
>         doc/invoke.texi: Document x86 nuances.
>
> gcc/testsuite/ChangeLog:
>
>         * gcc.dg/kcfi/kcfi-adjacency.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-basics.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-call-sharing.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-complex-addressing.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-move-preservation.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-no-sanitize.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-offset-validation.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-large.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-medium.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add x86 patterns.
>         * gcc.dg/kcfi/kcfi-tail-calls.c: Add x86 tail-call patterns.
>         * gcc.dg/kcfi/kcfi-trap-section.c: Add x86 trap patterns.
>         * gcc.dg/kcfi/kcfi-x86-arity.c: New test.
>         * gcc.dg/kcfi/kcfi-x86-fixed-r10.c: New test.
>         * gcc.dg/kcfi/kcfi-x86-fixed-r11.c: New test.
>         * gcc.dg/kcfi/kcfi-x86-retpoline-r11.c: New test.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/config/i386/i386-protos.h                 |   1 +
>  gcc/config/i386/i386.h                        |   3 +-
>  gcc/config/i386/i386.md                       |  62 +++++-
>  gcc/config/i386/i386-expand.cc                |  22 +-
>  gcc/config/i386/i386-options.cc               |  11 +
>  gcc/config/i386/i386.cc                       | 192 ++++++++++++++++++
>  gcc/doc/invoke.texi                           |  46 +++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  17 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  15 ++
>  .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  18 ++
>  .../gcc.dg/kcfi/kcfi-move-preservation.c      |  19 ++
>  .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  11 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   5 +
>  .../gcc.dg/kcfi/kcfi-offset-validation.c      |   5 +
>  .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  24 +++
>  .../gcc.dg/kcfi/kcfi-patchable-large.c        |  13 ++
>  .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  20 ++
>  .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  21 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  20 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   6 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |  93 +++++++++
>  .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |  17 ++
>  .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |  17 ++
>  .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 ++++
>  gcc/common.opt                                |   4 +
>  gcc/opts.cc                                   |   1 +
>  27 files changed, 716 insertions(+), 8 deletions(-)
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
>
> diff --git a/gcc/config/i386/i386-protos.h b/gcc/config/i386/i386-protos.=
h
> index 5ff414a22a2a..b6a584a27d01 100644
> --- a/gcc/config/i386/i386-protos.h
> +++ b/gcc/config/i386/i386-protos.h
> @@ -378,6 +378,7 @@ extern enum attr_cpu ix86_schedule;
>
>  extern bool ix86_nopic_noplt_attribute_p (rtx call_op);
>  extern const char * ix86_output_call_insn (rtx_insn *insn, rtx call_op);
> +extern const char * ix86_output_kcfi_insn (rtx_insn *insn, rtx *operands=
);
>  extern const char * ix86_output_indirect_jmp (rtx call_op);
>  extern const char * ix86_output_function_return (bool long_p);
>  extern const char * ix86_output_indirect_function_return (rtx ret_op);
> diff --git a/gcc/config/i386/i386.h b/gcc/config/i386/i386.h
> index 94f335f8a95c..b81309b770bf 100644
> --- a/gcc/config/i386/i386.h
> +++ b/gcc/config/i386/i386.h
> @@ -3054,7 +3054,8 @@ extern void debug_dispatch_window (int);
>
>  #define TARGET_INDIRECT_BRANCH_REGISTER \
>    (ix86_indirect_branch_register \
> -   || cfun->machine->indirect_branch_type !=3D indirect_branch_keep)
> +   || cfun->machine->indirect_branch_type !=3D indirect_branch_keep \
> +   || (flag_sanitize & SANITIZE_KCFI))
>
>  #define IX86_HLE_ACQUIRE (1 << 16)
>  #define IX86_HLE_RELEASE (1 << 17)
> diff --git a/gcc/config/i386/i386.md b/gcc/config/i386/i386.md
> index 3ea2439526be..6e955afec007 100644
> --- a/gcc/config/i386/i386.md
> +++ b/gcc/config/i386/i386.md
> @@ -20415,11 +20415,24 @@
>    DONE;
>  })
>
> +;; KCFI indirect call
> +(define_insn "*call"
> +  [(kcfi (call (mem:QI (match_operand:W 0 "call_insn_operand" "<c>BwBz")=
)
> +              (match_operand 1))
> +        (match_operand 2 "const_int_operand"))]
> +  "!SIBLING_CALL_P (insn)"
> +{
> +  return ix86_output_kcfi_insn (insn, operands);

No need to introduce another global function. Please change
ix86_output_call_insn to:

extern const char * ix86_output_call_insn (rtx_insn *insn, rtx *ops)

to pass all operands to the function and use:

" *  return ix86_output_call_insn (insn, operands);"

In the function, detect if "insn" RTX is wrapped in KCFI RTX and do
all the magic.

> +}
> +  [(set_attr "type" "call")])
> +
>  (define_insn "*call"
>    [(call (mem:QI (match_operand:W 0 "call_insn_operand" "<c>BwBz"))
>          (match_operand 1))]
>    "!SIBLING_CALL_P (insn)"
> -  "* return ix86_output_call_insn (insn, operands[0]);"
> +{
> +  return ix86_output_call_insn (insn, operands[0]);
> +}
>    [(set_attr "type" "call")])

This is *ideal* case for define_subst:

--cut here--
(define_subst_attr "kcfi" "kcfi_subst" "" "_kcfi")

(define_subst "kcfi_subst"
  [(match_operand 0)]
  ""
  [(kcfi (match_dup 0)
     (match_operand 2 "const_int_operand"))])
--cut here--

Then change the pattern from e.g.:

(define_insn "*call"

to

(define_insn "*call<kcfi>"

and you automatically get two RTX patterns, where one has all the
additions to the original pattern. Please see the attached patch.

Uros.

> diff --git a/gcc/config/i386/i386-expand.cc b/gcc/config/i386/i386-expand=
.cc
> index c131f7c44c11..4f0557f40ac2 100644
> --- a/gcc/config/i386/i386-expand.cc
> +++ b/gcc/config/i386/i386-expand.cc
> @@ -94,6 +94,7 @@ along with GCC; see the file COPYING3.  If not see
>  #include "i386-builtins.h"
>  #include "i386-expand.h"
>  #include "asan.h"
> +#include "kcfi.h"
>
>  /* Split one or more double-mode RTL references into pairs of half-mode
>     references.  The RTL can be REG, offsettable MEM, integer constant, o=
r
> @@ -11071,8 +11072,9 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx cal=
larg1,
>    unsigned int vec_len =3D 0;
>    tree fndecl;
>    bool call_no_callee_saved_registers =3D false;
> +  bool is_direct_call =3D SYMBOL_REF_P (XEXP (fnaddr, 0));
>
> -  if (SYMBOL_REF_P (XEXP (fnaddr, 0)))
> +  if (is_direct_call)
>      {
>        fndecl =3D SYMBOL_REF_DECL (XEXP (fnaddr, 0));
>        if (fndecl)
> @@ -11109,7 +11111,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx cal=
larg1,
>    if (TARGET_MACHO && !TARGET_64BIT)
>      {
>  #if TARGET_MACHO
> -      if (flag_pic && SYMBOL_REF_P (XEXP (fnaddr, 0)))
> +      if (flag_pic && is_direct_call)
>         fnaddr =3D machopic_indirect_call_target (fnaddr);
>  #endif
>      }
> @@ -11193,7 +11195,7 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx cal=
larg1,
>    if (ix86_cmodel =3D=3D CM_LARGE_PIC
>        && !TARGET_PECOFF
>        && MEM_P (fnaddr)
> -      && SYMBOL_REF_P (XEXP (fnaddr, 0))
> +      && is_direct_call
>        && !local_symbolic_operand (XEXP (fnaddr, 0), VOIDmode))
>      fnaddr =3D gen_rtx_MEM (QImode, construct_plt_address (XEXP (fnaddr,=
 0)));
>    /* Since x32 GOT slot is 64 bit with zero upper 32 bits, indirect
> @@ -11225,6 +11227,20 @@ ix86_expand_call (rtx retval, rtx fnaddr, rtx ca=
llarg1,
>
>    call =3D gen_rtx_CALL (VOIDmode, fnaddr, callarg1);
>
> +  /* Only indirect calls need KCFI instrumentation.  */
> +  rtx kcfi_type_rtx =3D is_direct_call ? NULL_RTX
> +    : kcfi_get_type_id_for_expanding_gimple_call ();
> +  if (kcfi_type_rtx)
> +    {
> +      /* Wrap call with KCFI.  */
> +      call =3D gen_rtx_KCFI (VOIDmode, call, kcfi_type_rtx);
> +
> +      /* Add KCFI clobbers for the insn sequence.  */
> +      clobber_reg (&use, gen_rtx_REG (DImode, R10_REG));
> +      clobber_reg (&use, gen_rtx_REG (DImode, R11_REG));
> +      clobber_reg (&use, gen_rtx_REG (CCmode, FLAGS_REG));
> +    }
> +
>    if (retval)
>      call =3D gen_rtx_SET (retval, call);
>    vec[vec_len++] =3D call;
> diff --git a/gcc/config/i386/i386-options.cc b/gcc/config/i386/i386-optio=
ns.cc
> index ba598a817f30..c7c917e1ed33 100644
> --- a/gcc/config/i386/i386-options.cc
> +++ b/gcc/config/i386/i386-options.cc
> @@ -2186,6 +2186,17 @@ ix86_option_override_internal (bool main_args_p,
>        ix86_lam_type =3D lam_u57;
>      }
>
> +  /* KCFI is only supported in 64-bit mode due to use of r10/r11 registe=
rs.  */
> +  if ((opts->x_flag_sanitize & SANITIZE_KCFI)
> +      && (!TARGET_64BIT_P (opts->x_ix86_isa_flags) || TARGET_X32_P (opts=
->x_ix86_isa_flags)))
> +    sorry ("%<-fsanitize=3Dkcfi%> is not supported for 32-bit x86 or x32=
 mode");
> +
> +  /* KCFI requires R10 and R11 registers for type checking.  */
> +  if ((opts->x_flag_sanitize & SANITIZE_KCFI)
> +      && (fixed_regs[R10_REG] || fixed_regs[R11_REG]))
> +    sorry ("%<-fsanitize=3Dkcfi%> is not compatible with %<-ffixed-r10%>=
 or "
> +          "%<-ffixed-r11%> as KCFI requires these registers for type che=
cking");
> +
>    /* For targets using ms ABI enable ms-extensions, if not
>       explicit turned off.  For non-ms ABI we turn off this
>       option.  */
> diff --git a/gcc/config/i386/i386.cc b/gcc/config/i386/i386.cc
> index 6b6febc88709..c998d6dbe49f 100644
> --- a/gcc/config/i386/i386.cc
> +++ b/gcc/config/i386/i386.cc
> @@ -98,6 +98,7 @@ along with GCC; see the file COPYING3.  If not see
>  #include "i386-builtins.h"
>  #include "i386-expand.h"
>  #include "i386-features.h"
> +#include "kcfi.h"
>  #include "function-abi.h"
>  #include "rtl-error.h"
>  #include "gimple-pretty-print.h"
> @@ -323,6 +324,26 @@ unsigned int const svr4_debugger_register_map[FIRST_=
PSEUDO_REGISTER] =3D
>    93, 94, 95, 96, 97, 98, 99, 100
>  };
>
> +/* KCFI arity (how many parameters a function has) is encoded in the
> +   preamble's immediate register. The encoding is as follows:
> +
> +   Arity represented by
> +       0 by %eax (gcc regno =3D 0)
> +       1 by %ecx (gcc regno =3D 2)
> +       2 by %edx (gcc regno =3D 1)
> +       3 by %ebx (gcc regno =3D 3)
> +       4 by %esp (gcc regno =3D 7)
> +       5 by %ebp (gcc regno =3D 6)
> +       6 by %esi (gcc regno =3D 4)
> +       7 by %edi (gcc regno =3D 5)
> +*/
> +#define KCFI_ARITY_MAX_INDICATOR 7
> +unsigned int const kcfi_arity_register_map[KCFI_ARITY_MAX_INDICATOR + 1]=
 =3D
> +{
> +  /* eax to edi */
> +  0, 2, 1, 3, 7, 6, 4, 5
> +};
> +
>  /* Define parameter passing and return registers.  */
>
>  static int const x86_64_int_parameter_registers[6] =3D
> @@ -28730,6 +28751,177 @@ ix86_set_handled_components (sbitmap components=
)
>        }
>  }
>
> +/* Output the assembly for a KCFI checked call instruction.  INSN is the
> +   RTL instruction being processed.  OPERANDS is the array of RTL operan=
ds
> +   where operands[0] is the call target register, operands[2] is the KCF=
I
> +   type ID constant.  Returns an empty string as all output is handled b=
y
> +   direct assembly generation.  */
> +
> +const char *
> +ix86_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> +{
> +  /* Target is guaranteed to be in a register due to
> +     TARGET_INDIRECT_BRANCH_REGISTER.  */
> +  rtx target_reg =3D operands[0];
> +  gcc_assert (REG_P (target_reg));
> +
> +  /* In thunk-extern mode, the register must be R11 for FineIBT
> +     compatibility.  Should this be handled via constraints?  */
> +  if (cfun->machine->indirect_branch_type =3D=3D indirect_branch_thunk_e=
xtern)
> +    {
> +      if (REGNO (target_reg) !=3D R11_REG)
> +       {
> +         /* Emit move from current target to R11.  */
> +         target_reg =3D gen_rtx_REG (DImode, R11_REG);
> +         rtx r11_operands[2] =3D { operands[0], target_reg };
> +         output_asm_insn ("movq\t%0, %1", r11_operands);
> +       }
> +    }
> +
> +  /* Get unique label number for this KCFI check.  */
> +  int labelno =3D kcfi_next_labelno ();
> +
> +  /* Generate custom label names.  */
> +  char trap_name[32];
> +  char call_name[32];
> +  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", labelno);
> +  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", labelno);
> +
> +  /* Choose scratch register: r10 by default, r11 if r10 is the target. =
 */
> +  bool target_is_r10 =3D (REGNO (target_reg) =3D=3D R10_REG);
> +  int scratch_reg =3D target_is_r10 ? R11_REG : R10_REG;
> +
> +  /* Get KCFI type ID from operand.  */
> +  uint32_t type_id =3D (uint32_t) INTVAL (operands[2]);
> +
> +  /* Convert to inverse for the check (0 - hash) */
> +  uint32_t inverse_type_id =3D (uint32_t)(0 - type_id);
> +
> +  /* Calculate offset to typeid from target address.  */
> +  HOST_WIDE_INT offset =3D -kcfi_get_typeid_offset ();
> +
> +  /* Output complete KCFI check + call/sibcall sequence atomically.  */
> +  rtx inverse_type_id_rtx =3D gen_int_mode (inverse_type_id, SImode);
> +  rtx mov_operands[2] =3D { inverse_type_id_rtx,
> +                         gen_rtx_REG (SImode, scratch_reg) };
> +  output_asm_insn ("movl\t$%c0, %1", mov_operands);
> +
> +  /* Create memory operand for the addl instruction.  */
> +  rtx offset_rtx =3D gen_int_mode (offset, DImode);
> +  rtx mem_op =3D gen_rtx_MEM (SImode,
> +                           gen_rtx_PLUS (DImode, target_reg, offset_rtx)=
);
> +  rtx add_operands[2] =3D { mem_op, gen_rtx_REG (SImode, scratch_reg) };
> +  output_asm_insn ("addl\t%0, %1", add_operands);
> +
> +  /* Output conditional jump to call label.  */
> +  fputs ("\tje\t", asm_out_file);
> +  assemble_name (asm_out_file, call_name);
> +  fputc ('\n', asm_out_file);
> +
> +  /* Output trap label and instruction.  */
> +  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
> +  output_asm_insn ("ud2", operands);
> +
> +  /* Use common helper for trap section entry.  */
> +  rtx trap_label_sym =3D gen_rtx_SYMBOL_REF (Pmode, trap_name);
> +  kcfi_emit_traps_section (asm_out_file, trap_label_sym, labelno);
> +
> +  /* Output pass/call label.  */
> +  ASM_OUTPUT_LABEL (asm_out_file, call_name);
> +
> +  /* Finally emit the protected call or sibling call.  */
> +  if (SIBLING_CALL_P (insn))
> +    return ix86_output_indirect_jmp (target_reg);
> +  else
> +    return ix86_output_call_insn (insn, target_reg);
> +}
> +
> +/* Apply x86-64 specific masking to KCFI type ID.  TYPE_ID is the 32-bit
> +   KCFI type identifier to potentially mask.  Returns the type ID with
> +   x86-64 specific adjustments to avoid embedding ENDBR instruction
> +   sequences in the type identifier values.  */
> +
> +static uint32_t
> +ix86_kcfi_mask_type_id (uint32_t type_id)
> +{
> +  /* Avoid embedding ENDBR instructions in KCFI type IDs.
> +     ENDBR64: 0xfa1e0ff3, ENDBR32: 0xfb1e0ff3
> +     If the type ID matches either instruction encoding, increment by 1.=
  */
> +  if (type_id =3D=3D 0xfa1e0ff3U || type_id =3D=3D 0xfb1e0ff3U)
> +    return type_id + 1;
> +
> +  return type_id;
> +}
> +
> +/* Return x86-64 specific function arity (number of integer register
> +   arguments) of the given FNDECL.  */
> +
> +static uint8_t
> +ix86_kcfi_compute_type_arity (tree fndecl)
> +{
> +  tree args;
> +  uint8_t arity =3D 0;
> +
> +  /* Only count arity if requested.  */
> +  if (!flag_sanitize_kcfi_arity)
> +    return 0;
> +
> +  /* If fndecl is NULL, we can't determine arity - return 0.  */
> +  if (!fndecl)
> +    return 0;
> +
> +  /* Count the number of registers used, disregard SSE registers.  */
> +  for (args =3D DECL_ARGUMENTS (fndecl); args; args =3D TREE_CHAIN (args=
))
> +  {
> +    int int_nregs, sse_nregs;
> +    bool args_on_stack =3D false;
> +    machine_mode mode =3D TYPE_MODE (TREE_TYPE (args));
> +
> +    args_on_stack =3D examine_argument (mode, TREE_TYPE (args), 0, &int_=
nregs,
> +                                     &sse_nregs);
> +    /* If we place arguments on the stack, return highest arity indicato=
r.  */
> +    if (args_on_stack)
> +       return KCFI_ARITY_MAX_INDICATOR;
> +    arity +=3D int_nregs;
> +  }
> +
> +  /* Return KCFI_ARITY_MAX_INDICATOR if we have counted more than
> +     KCFI_ARITY_MAX_INDICATOR arguments.  */
> +  return arity > KCFI_ARITY_MAX_INDICATOR ? KCFI_ARITY_MAX_INDICATOR : a=
rity;
> +}
> +
> +/* Emit x86_64-specific type ID instruction and return instruction size.
> +   FILE is the output assembly file stream, or NULL for size calculation=
 only.
> +   TYPE_ID is the 32-bit KCFI type identifier to emit.  FNDECL is the fu=
nction
> +   declaration, used to compute arity if needed.  Returns the number
> +   of bytes the instruction occupies (5 bytes for x86_64 movl instructio=
n).  */
> +
> +static int
> +ix86_kcfi_emit_type_id (FILE *file, uint32_t type_id, tree fndecl)
> +{
> +  /* Compute function arity.  */
> +  uint8_t arity =3D ix86_kcfi_compute_type_arity (fndecl);
> +
> +  /* Choose register for movl instruction.  */
> +  gcc_assert (arity <=3D KCFI_ARITY_MAX_INDICATOR);
> +  uint32_t regno =3D kcfi_arity_register_map[arity];
> +
> +  if (file)
> +    fprintf (file, "\tmovl\t$0x%08x, %%e%s\n", type_id, reg_names[regno]=
);
> +
> +  /* x86_64 uses 5-byte movl instruction for type ID.  */
> +  return 5;
> +}
> +
> +#undef TARGET_KCFI_SUPPORTED
> +#define TARGET_KCFI_SUPPORTED hook_bool_void_true
> +
> +#undef TARGET_KCFI_MASK_TYPE_ID
> +#define TARGET_KCFI_MASK_TYPE_ID ix86_kcfi_mask_type_id
> +
> +#undef TARGET_KCFI_EMIT_TYPE_ID
> +#define TARGET_KCFI_EMIT_TYPE_ID ix86_kcfi_emit_type_id
> +
>  #undef TARGET_SHRINK_WRAP_GET_SEPARATE_COMPONENTS
>  #define TARGET_SHRINK_WRAP_GET_SEPARATE_COMPONENTS ix86_get_separate_com=
ponents
>  #undef TARGET_SHRINK_WRAP_COMPONENTS_FOR_BB
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index faeeb29663dd..a10f2006f1ff 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -18477,6 +18477,52 @@ The type identifier is placed before the functio=
n entry point,
>  allowing runtime verification without additional metadata structures,
>  and without changing the entry points of the target functions.
>
> +Platform-specific implementation details:
> +
> +On x86_64, KCFI type identifiers are emitted as a @code{movl $ID, %eax}
> +instruction before the function entry.  The implementation ensures that
> +type IDs never collide with ENDBR instruction encodings.  When used
> +with @option{-fpatchable-function-entry}, the type identifier is
> +placed before any patchable NOPs, with appropriate alignment to maintain
> +the alignment specified by @code{-falign-functions}.  KCFI automatically
> +implies @option{-mindirect-branch-register}, forcing all indirect calls
> +and jumps to use registers instead of memory operands.  The runtime
> +check loads the type ID from the target function into @code{%r10d} and
> +uses an @code{addl} instruction to add the negative expected type ID,
> +effectively zeroing the register if the types match.  A conditional
> +jump follows to either continue execution or trap on mismatch.  The
> +check sequence uses @code{%r10d} and @code{%r11d} as scratch registers.
> +Trap locations are recorded in a special @code{.kcfi_traps} section
> +that maps trap sites to their corresponding function entry points,
> +enabling debuggers and crash handlers to identify KCFI violations.
> +The exact instruction sequences for both the KCFI preamble and the
> +check-call bundle are considered ABI, as the Linux kernel may
> +optionally rewrite these areas at boot time to mitigate detected CPU
> +errata.
> +
> +The @code{-fsanitize-kcfi-arity} option encodes the function arity
> +(i.e., the number of arguments) into the @code{movl $ID, $REG} instructi=
on,
> +where the @code{$REG} encodes the function arity. This allows users, suc=
h as
> +FineIBT to generate code in the kernel that is aware of how many registe=
r
> +arguments a function takes. The encoding is as follows:
> +
> +@multitable @columnfractions 0.10 0.50 0.40
> +@headitem Arity @tab Description @tab Register
> +@item 0 @tab 0 parameters @tab @code{EAX}
> +@item 1 @tab 1 parameter in RDI @tab @code{ECX}
> +@item 2 @tab 2 parameters in RDI and RSI @tab @code{EDX}
> +@item 3 @tab 3 parameters in RDI, RSI, and RDX @tab @code{EBX}
> +@item 4 @tab 4 parameters in RDI, RSI, RDX, and RCX @tab @code{ESP}
> +@item 5 @tab 5 parameters in RDI, RSI, RDX, RCX, and R8 @tab @code{EBP}
> +@item 6 @tab 6 parameters in RDI, RSI, RDX, RCX, R8, and R9 @tab @code{E=
SI}
> +@item 7 @tab At least one parameter may be passed on the stack @tab @cod=
e{EDI}
> +@end multitable
> +
> +For example, if a function `foo` takes 3 register arguments, the KCFI
> +header MOVri instruction would become something like this:
> +
> +@code{movl    $199571451, %ebx                # hash of foo's type =3D 0=
xBE537FB}
> +
>  KCFI is intended primarily for kernel code and may not be suitable
>  for user-space applications that rely on techniques incompatible
>  with strict type checking of indirect calls.
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/g=
cc.dg/kcfi/kcfi-adjacency.c
> index 7c1cff986c01..7c59921e630c 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> @@ -46,4 +46,21 @@ __attribute__((noinline)) void test_conditional_call(i=
nt flag) {
>      }
>  }
>
> +/*
> +** test_complex_args: { target x86_64-*-* }
> +** ...
> +** movl        \$-?[0-9]+, %r10d
> +** addl        -4\((%r[a-z0-9]+)\), %r10d
> +** je  .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap([0-9]+):
> +** ud2
> +** .section    .kcfi_traps,"ao",@progbits,.text
> +** .Lkcfi_entry([0-9]+):
> +** .long       .Lkcfi_trap\3-.Lkcfi_entry\4
> +** .text
> +** .Lkcfi_call\2:
> +** jmp \*\1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.=
dg/kcfi/kcfi-basics.c
> index ca833fed2971..fe0a21d26df9 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
> @@ -1,5 +1,6 @@
>  /* Test basic KCFI functionality - preamble generation.  */
>  /* { dg-do compile } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
>
>  /* Extern function declarations - should NOT get KCFI preambles.  */
>  extern void external_func(void);
> @@ -55,6 +56,26 @@ int main() {
>  /* Function with nocf_check attribute should NOT have preamble.  */
>  /* { dg-final { scan-assembler-not {__cfi_nocf_check_function:} } } */
>
> +/* x86_64: Verify type ID in preamble (after NOPs, before function label=
) */
> +/* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+=
movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
> +
> +/*
> +** static_caller: { target x86_64-*-* }
> +** ...
> +** movl        \$-?[0-9]+, %r10d
> +** addl        -4\((%r[a-z0-9]+)\), %r10d
> +** je  .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap([0-9]+):
> +** ud2
> +** .section    .kcfi_traps,"ao",@progbits,.text
> +** .Lkcfi_entry([0-9]+):
> +** .long       .Lkcfi_trap\3-.Lkcfi_entry\4
> +** .text
> +** .Lkcfi_call\2:
> +** call        \*\1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
>
>  /* Extern functions should NOT get KCFI preambles.  */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuit=
e/gcc.dg/kcfi/kcfi-call-sharing.c
> index 427b092fecb5..16154213eb82 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
> @@ -59,3 +59,18 @@ int test_kcfi_check_sharing(struct kobject *kobj, cons=
t struct attribute_group *
>     Should see:
>     1. KCFI check for is_visible call with is_visible type ID A.
>     2. KCFI check for is_bin_visible and is_bin_visible_again call with t=
ype ID B.  */
> +
> +/* Verify we have TWO different KCFI check sequences.  */
> +/* Each check should have different type ID constants.  */
> +/* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2=
 { target i?86-*-* x86_64-*-* } } } */
> +
> +/* Verify the checks use DIFFERENT type IDs (not shared).
> +   We should NOT see the same type ID used twice - that would indicate
> +   unmerged sharing.  */
> +/* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*m=
ovl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
> +
> +/* Verify expected number of traps.  */
> +/* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_=
64-*-* } } } */
> +
> +/* Verify 2 separate call sites.  */
> +/* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { targe=
t i?86-*-* x86_64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/te=
stsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> index c48b8d7ad552..ed415033c5c9 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> @@ -128,4 +128,22 @@ int main() {
>      return result;
>  }
>
> +/* Standard KCFI handling.  */
> +/*
> +** test_struct_members: { target x86_64-*-* }
> +** ...
> +** movl        \$-?[0-9]+, %r10d
> +** addl        -4\((%r[a-z0-9]+)\), %r10d
> +** je  .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap([0-9]+):
> +** ud2
> +** .section    .kcfi_traps,"ao",@progbits,.text
> +** .Lkcfi_entry([0-9]+):
> +** .long       .Lkcfi_trap\3-.Lkcfi_entry\4
> +** .text
> +** .Lkcfi_call\2:
> +** call        \*\1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/tes=
tsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> index 7d58fef3f920..5553ff47174b 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> @@ -38,4 +38,23 @@ int main(void)
>      return 0;
>  }
>
> +/*
> +** indirect_call: { target x86_64-*-* }
> +** ...
> +** movq        %rdi, (%rax)
> +** movl        \$called_count, %edi
> +** movl        \$-?[0-9]+, %r10d
> +** addl        -4\(\1\), %r10d
> +** je  .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap([0-9]+):
> +** ud2
> +** .section    .kcfi_traps,"ao",@progbits,.text
> +** .Lkcfi_entry([0-9]+):
> +** .long       .Lkcfi_trap\3-.Lkcfi_entry\4
> +** .text
> +** .Lkcfi_call\2:
> +** jmp \*\1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/te=
stsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> index 4a90390d1934..9ed7e21fe8eb 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> @@ -72,3 +72,14 @@ int main(void)
>
>      return 0;
>  }
> +
> +/* Verify correct number of KCFI checks: exactly 2 */
> +/* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } *=
/
> +
> +/* Positive controls: these should have KCFI checks.  */
> +/* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_f=
unction} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_=
normal_inline} { target x86_64-*-* } } } */
> +
> +/* Negative controls: these should NOT have KCFI checks.  */
> +/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.=
*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\=
s+wrap_sensitive_inline} { target x86_64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite=
/gcc.dg/kcfi/kcfi-no-sanitize.c
> index 124d26488635..95a8e8419e00 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
> @@ -29,3 +29,8 @@ int main() {
>  /* { dg-final { scan-assembler "__cfi_caller_with_checks:" } } */
>  /* { dg-final { scan-assembler "__cfi_caller_no_checks:" } } */
>  /* { dg-final { scan-assembler "__cfi_main:" } } */
> +
> +/* caller_with_checks() should generate KCFI check.
> +   caller_no_checks() should NOT generate KCFI check (no_sanitize).
> +   So a total of exactly 1 KCFI check in the entire program.  */
> +/* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 {=
 target x86_64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/tes=
tsuite/gcc.dg/kcfi/kcfi-offset-validation.c
> index 213a1a2892a5..97d964feebd3 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
> @@ -1,5 +1,6 @@
>  /* Test KCFI call-site offset validation across architectures.  */
>  /* { dg-do compile } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
>
>  void target_func_a(void) { }
>  void target_func_b(int x) { }
> @@ -22,3 +23,7 @@ int main() {
>  /* { dg-final { scan-assembler "__cfi_target_func_a:" } } */
>  /* { dg-final { scan-assembler "__cfi_target_func_b:" } } */
>  /* { dg-final { scan-assembler "__cfi_target_func_c:" } } */
> +
> +/* x86_64: All call sites should use -4 offset for KCFI type ID loads, e=
ven
> +   with -falign-functions=3D16 (we're not using patchable entries here).=
  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[=
a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/=
testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
> index a6a2f4816fef..379356385a16 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
> @@ -1,6 +1,7 @@
>  /* Test KCFI with patchable function entries - entry NOPs only.  */
>  /* { dg-do compile } */
>  /* { dg-additional-options "-fpatchable-function-entry=3D4,0" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
>
>  void test_function(void) {
>  }
> @@ -11,4 +12,27 @@ int main() {
>      return 0;
>  }
>
> +/*
> +** __cfi_test_function: { target x86_64-*-* }
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** movl        \$0x[0-9a-f]+, %eax
> +*/
> +
> +/*
> +** main: { target x86_64-*-* }
> +** ...
> +** addl        -4\(%r[a-z0-9]+\), %r10d
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.wor=
d} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/tests=
uite/gcc.dg/kcfi/kcfi-patchable-large.c
> index 8c4ec30cecc5..06df3495bb23 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
> @@ -1,6 +1,7 @@
>  /* Test KCFI with large patchable function entries.  */
>  /* { dg-do compile } */
>  /* { dg-additional-options "-fpatchable-function-entry=3D11,11" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
>
>  void test_function(void) {
>  }
> @@ -11,4 +12,16 @@ int main() {
>      return 0;
>  }
>
> +/*
> +** __cfi_test_function: { target x86_64-*-* }
> +** movl        \$0x[0-9a-f]+, %eax
> +*/
> +
> +/*
> +** main: { target x86_64-*-* }
> +** ...
> +** addl        -15\(%r[a-z0-9]+\), %r10d
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.wor=
d} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/test=
suite/gcc.dg/kcfi/kcfi-patchable-medium.c
> index 78a834ef2a97..ef87b135934b 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
> @@ -1,6 +1,7 @@
>  /* Test KCFI with medium patchable function entries.  */
>  /* { dg-do compile } */
>  /* { dg-additional-options "-fpatchable-function-entry=3D8,4" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
>
>  void test_function(void) {
>  }
> @@ -11,4 +12,23 @@ int main() {
>      return 0;
>  }
>
> +/*
> +** __cfi_test_function: { target x86_64-*-* }
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** movl        \$0x[0-9a-f]+, %eax
> +*/
> +
> +/*
> +** main: { target x86_64-*-* }
> +** ...
> +** addl        -8\(%r[a-z0-9]+\), %r10d
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.wor=
d} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc=
/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
> index 1a4d8269ed56..872814aa4171 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
> @@ -1,6 +1,7 @@
>  /* Test KCFI with patchable function entries - prefix NOPs only.  */
>  /* { dg-do compile } */
>  /* { dg-additional-options "-fpatchable-function-entry=3D3,3" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
>
>  void test_function(void) {
>  }
> @@ -11,4 +12,24 @@ int main() {
>      return 0;
>  }
>
> +/*
> +** __cfi_test_function: { target x86_64-*-* }
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** nop
> +** movl        \$0x[0-9a-f]+, %eax
> +*/
> +
> +/*
> +** main: { target x86_64-*-* }
> +** ...
> +** addl        -7\(%r[a-z0-9]+\), %r10d
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.wor=
d} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/=
gcc.dg/kcfi/kcfi-tail-calls.c
> index 9ddf178aa2b1..04a9eb1fd206 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
> @@ -58,3 +58,23 @@ int test_non_tail_indirect_call(func_ptr_t handler, in=
t x) {
>  /* { dg-final { scan-assembler-times "__cfi_test_param_indirect_call:" 1=
 } } */
>  /* { dg-final { scan-assembler-times "__cfi_test_void_indirect_call:" 1 =
} } */
>  /* { dg-final { scan-assembler-times "__cfi_test_non_tail_indirect_call:=
" 1 } } */
> +
> +/* Should have exactly 4 KCFI checks for indirect calls as
> +   (load type ID + compare).  */
> +/* { dg-final { scan-assembler-times {movl\t\$-?[0-9]+, %r10d} 4 { targe=
t x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-times {addl\t-4\(%r[a-z0-9]+\), %r10d} 4 =
{ target x86_64-*-* } } } */
> +
> +/* Should have exactly 4 trap sections and 4 trap instructions.  */
> +/* { dg-final { scan-assembler-times "\\.kcfi_traps" 4 { target x86_64-*=
-* } } } */
> +/* { dg-final { scan-assembler-times "ud2" 4 { target x86_64-*-* } } } *=
/
> +
> +/* Should NOT have unprotected direct jumps to vtable.  */
> +/* { dg-final { scan-assembler-not {jmp\t\*vtable\(%rip\)} { target x86_=
64-*-* } } } */
> +/* { dg-final { scan-assembler-not {jmp\t\*vtable\+8\(%rip\)} { target x=
86_64-*-* } } } */
> +
> +/* Should have exactly 3 protected tail calls (jmp through register afte=
r
> +   KCFI check).  */
> +/* { dg-final { scan-assembler-times {jmp\t\*%[a-z0-9]+} 3 { target x86_=
64-*-* } } } */
> +
> +/* Should have exactly 1 regular call (non-tail call case).  */
> +/* { dg-final { scan-assembler-times {call\t\*%[a-z0-9]+} 1 { target x86=
_64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuit=
e/gcc.dg/kcfi/kcfi-trap-section.c
> index 6d34ad6e1a0c..55c0829ccd7b 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
> @@ -15,3 +15,9 @@ int main() {
>
>  /* Should have KCFI preamble.  */
>  /* { dg-final { scan-assembler "__cfi_target_function:" } } */
> +
> +/* Should have exactly 2 trap labels in code.  */
> +/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_=
64-*-* } } } */
> +
> +/* x86_64 should exactly 2 .kcfi_traps sections.  */
> +/* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@prog=
bits,\.text} 2 { target x86_64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c b/gcc/testsuite/g=
cc.dg/kcfi/kcfi-x86-arity.c
> new file mode 100644
> index 000000000000..5c1d1ffcc619
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
> @@ -0,0 +1,93 @@
> +/* Test KCFI -fsanitize-kcfi-arity - preamble generation */
> +/* { dg-do compile { target x86_64-*-* } } */
> +/* { dg-additional-options "-O2 -fsanitize-kcfi-arity" } */
> +
> +void regular_function(int x) {
> +    /* This should get KCFI preamble */
> +}
> +
> +/* These functions should get a KCFI arity corresponing to the number of
> +   parameter.
> +
> +   On x86-64, the mov instruction in the preamble encodes the arity in t=
he
> +   used immediate register, as follows:
> +
> +       Arity   Description                     Encoding in reg field
> +       0       0 parameters                    EAX
> +       1       1 parameter in RDI              ECX
> +       2       2 parameters in RDI             EDX
> +                 and RSI
> +       3       3 parameters in RDI,            EBX
> +                 RSI, and RDX
> +       4       4 parameters in RDI,            ESP
> +                 RSI, RDX, and RCX
> +       5       5 parameters in RDI,            EBP
> +                 RSI, RDX, RCX, and R8
> +       6       6 parameters in RDI,            ESI
> +                 RSI, RDX, RCX, R8, and R9
> +       7       At least one parameter          EDI
> +                 may be passed on the stack
> +*/
> +void ind_fn_00(void) {}
> +void ind_fn_01(int) {}
> +void ind_fn_02(int, int) {}
> +void ind_fn_03(int, int, int) {}
> +void ind_fn_04(int, int, int, int) {}
> +void ind_fn_05(int, int, int, int, int) {}
> +void ind_fn_06(int, int, int, int, int, int) {}
> +/* Arguments on stack arity from here on should be 7.  */
> +void ind_fn_07(int, int, int, int, int, int, int) {}
> +void ind_fn_08(int, int, int, int, int, int, int, int) {}
> +
> +void ind_fn_float_01(int, float) {}
> +void ind_fn_float_03(int, int, float, float, float) {}
> +
> +void (*func_ptr_00)(void) =3D ind_fn_00;
> +void (*func_ptr_01)(int) =3D ind_fn_01;
> +void (*func_ptr_02)(int, int) =3D ind_fn_02;
> +void (*func_ptr_03)(int, int, int) =3D ind_fn_03;
> +void (*func_ptr_04)(int, int, int, int) =3D ind_fn_04;
> +void (*func_ptr_05)(int, int, int, int, int) =3D ind_fn_05;
> +void (*func_ptr_06)(int, int, int, int, int, int) =3D ind_fn_06;
> +void (*func_ptr_07)(int, int, int, int, int, int, int) =3D ind_fn_07;
> +void (*func_ptr_08)(int, int, int, int, int, int, int, int) =3D ind_fn_0=
8;
> +
> +
> +void (*func_ptr_float_01)(int, float) =3D ind_fn_float_01;
> +void (*func_ptr_float_03)(int, int, float, float, float) =3D ind_fn_floa=
t_03;
> +
> +int main() {
> +    /* Function arity tests.  */
> +    func_ptr_00();
> +    func_ptr_01(1);
> +    func_ptr_02(1, 1);
> +    func_ptr_03(1, 1, 1);
> +    func_ptr_04(1, 1, 1, 1);
> +    func_ptr_05(1, 1, 1, 1, 1);
> +    func_ptr_06(1, 1, 1, 1, 1, 1);
> +
> +    /* Both of these put arguments on the stack so both get arity 7.  */
> +    func_ptr_07(1, 1, 1, 1, 1, 1, 1);
> +    func_ptr_08(1, 1, 1, 1, 1, 1, 1, 1);
> +
> +    /* Float parameters should not be counted for arity.  */
> +    func_ptr_float_01(1, 1.0);
> +    func_ptr_float_03(1, 1, 0.5, 0.5, 0.5);
> +
> +    return 0;
> +}
> +
> +/* x86_64: Verify arity immediate register encoding in preamble.  */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_00:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %eax\n.*\nind_fn_00:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_01:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %ecx\n.*\nind_fn_01:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_02:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %edx\n.*\nind_fn_02:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_03:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %ebx\n.*\nind_fn_03:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_04:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %esp\n.*\nind_fn_04:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_05:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %ebp\n.*\nind_fn_05:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_06:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %esi\n.*\nind_fn_06:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_07:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %edi\n.*\nind_fn_07:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_08:.*\n\tmovl\t+\$0x[0-9a-f=
]+, %edi\n.*\nind_fn_08:} { target x86_64-*-* } } } */
> +
> +/* x86_64: Verify arity is not affected by SSE registers.  */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_float_01:.*\n\tmovl\t+\$0x[=
0-9a-f]+, %ecx\n.*\nind_fn_float_01:} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {__cfi_ind_fn_float_03:.*\n\tmovl\t+\$0x[=
0-9a-f]+, %edx\n.*\nind_fn_float_03:} { target x86_64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c b/gcc/testsui=
te/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
> new file mode 100644
> index 000000000000..f509bc918a82
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
> @@ -0,0 +1,17 @@
> +/* Test that KCFI is incompatible with -ffixed-r10 on x86_64.  */
> +/* { dg-do compile { target x86_64-*-* } } */
> +/* { dg-additional-options "-ffixed-r10" } */
> +
> +/* { dg-message "sorry, unimplemented: '-fsanitize=3Dkcfi' is not compat=
ible with '-ffixed-r10' or '-ffixed-r11' as KCFI requires these registers f=
or type checking" "" { target *-*-* } 0 } */
> +
> +void test_function(void)
> +{
> +    /* Empty function.  */
> +}
> +
> +int main(void)
> +{
> +    void (*ptr)(void) =3D test_function;
> +    ptr();  /* This would need KCFI instrumentation.  */
> +    return 0;
> +}
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c b/gcc/testsui=
te/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
> new file mode 100644
> index 000000000000..6b1ce8a1b6c5
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
> @@ -0,0 +1,17 @@
> +/* Test that KCFI is incompatible with -ffixed-r11 on x86_64.  */
> +/* { dg-do compile { target x86_64-*-* } } */
> +/* { dg-additional-options "-ffixed-r11" } */
> +
> +/* { dg-message "sorry, unimplemented: '-fsanitize=3Dkcfi' is not compat=
ible with '-ffixed-r10' or '-ffixed-r11' as KCFI requires these registers f=
or type checking" "" { target *-*-* } 0 } */
> +
> +void test_function(void)
> +{
> +    /* Empty function.  */
> +}
> +
> +int main(void)
> +{
> +    void (*ptr)(void) =3D test_function;
> +    ptr();  /* This would need KCFI instrumentation.  */
> +    return 0;
> +}
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c b/gcc/tes=
tsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
> new file mode 100644
> index 000000000000..056068b4f197
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
> @@ -0,0 +1,40 @@
> +/* Test KCFI with retpoline thunk-extern flag forces r11 usage.  */
> +/* { dg-do compile { target x86_64-*-* } } */
> +/* { dg-additional-options "-O2 -mindirect-branch=3Dthunk-extern" } */
> +
> +extern int external_target(void);
> +
> +/* Test regular call (not tail call) */
> +__attribute__((noinline))
> +int call_test(int (*func_ptr)(void)) {
> +    /* This indirect call should use r11 when both KCFI and
> +       -mindirect-branch=3Dthunk-extern are enabled.  */
> +    int result =3D func_ptr();  /* Function parameter prevents direct op=
timization.  */
> +    return result + 1;  /* Prevent tail call optimization.  */
> +}
> +
> +/* Reference external_target to generate the required symbol.  */
> +int (*external_func_ptr)(void) =3D external_target;
> +
> +/* Test function for sibcalls (tail calls) */
> +__attribute__((noinline))
> +void sibcall_test(int (**func_ptr)(void)) {
> +    /* This sibcall should use r11 when both KCFI and
> +       -mindirect-branch=3Dthunk-extern are enabled.  */
> +    (*func_ptr)();  /* Tail call - should be optimized to sibcall.  */
> +}
> +
> +/* Should have weak symbol for external function.  */
> +/* { dg-final { scan-assembler "__kcfi_typeid_external_target" } } */
> +
> +/* When both KCFI and -mindirect-branch=3Dthunk-extern are enabled,
> +   indirect calls should always use r11 register and convert to extern t=
hunks.  */
> +/* { dg-final { scan-assembler-times {call\s+} 1 } } */
> +/* { dg-final { scan-assembler-times {call\s+__x86_indirect_thunk_r11} 1=
 } } */
> +
> +/* Sibcalls should also use r11 register and convert to extern thunks.  =
*/
> +/* { dg-final { scan-assembler-times {jmp\s+} 1 } } */
> +/* { dg-final { scan-assembler-times {jmp\s+__x86_indirect_thunk_r11} 1 =
} } */
> +
> +/* Should have exactly 2 KCFI traps (one per function) */
> +/* { dg-final { scan-assembler-times {ud2} 2 } } */
> diff --git a/gcc/common.opt b/gcc/common.opt
> index 92b0d4d931bd..70f52186be3d 100644
> --- a/gcc/common.opt
> +++ b/gcc/common.opt
> @@ -1147,6 +1147,10 @@ Enum(sanitize_coverage) String(trace-pc) Value(SAN=
ITIZE_COV_TRACE_PC)
>  EnumValue
>  Enum(sanitize_coverage) String(trace-cmp) Value(SANITIZE_COV_TRACE_CMP)
>
> +fsanitize-kcfi-arity
> +Common Driver Var(flag_sanitize_kcfi_arity)
> +For supported targets, this feature extends kCFI by telling the compiler=
 to record information about each indirect-callable function=E2=80=99s arit=
y (i.e., the number of arguments passed in registers) into the binary. Some=
 kernel CFI techniques, such as FineIBT, may be able to use this informatio=
n to provide enhanced security.
> +
>  fasan-shadow-offset=3D
>  Common Joined RejectNegative Var(common_deferred_options) Defer
>  -fasan-shadow-offset=3D<number>  Use custom shadow memory offset.
> diff --git a/gcc/opts.cc b/gcc/opts.cc
> index 430c7fa6d1ed..5cb7ac995712 100644
> --- a/gcc/opts.cc
> +++ b/gcc/opts.cc
> @@ -2806,6 +2806,7 @@ common_handle_option (struct gcc_options *opts,
>           SET_OPTION_IF_UNSET (opts, opts_set, param_asan_stack, 0);
>           SET_OPTION_IF_UNSET (opts, opts_set, param_asan_protect_allocas=
, 0);
>           SET_OPTION_IF_UNSET (opts, opts_set, param_asan_use_after_retur=
n, 0);
> +         SET_OPTION_IF_UNSET (opts, opts_set, flag_sanitize_kcfi_arity, =
0);
>         }
>        if (opts->x_flag_sanitize & SANITIZE_KERNEL_HWADDRESS)
>         {
> --
> 2.34.1
>

--000000000000c396310642d589a3
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mhlsjn4z0>
X-Attachment-Id: f_mhlsjn4z0

ZGlmZiAtLWdpdCBhL2djYy9jb25maWcvaTM4Ni9pMzg2Lm1kIGIvZ2NjL2NvbmZpZy9pMzg2L2kz
ODYubWQKaW5kZXggM2VhMjQzOTUyNmIuLmVhM2NmY2NlODJlIDEwMDY0NAotLS0gYS9nY2MvY29u
ZmlnL2kzODYvaTM4Ni5tZAorKysgYi9nY2MvY29uZmlnL2kzODYvaTM4Ni5tZApAQCAtMjA0MTUs
MTEgKzIwNDE1LDE5IEBAIChkZWZpbmVfZXhwYW5kICJzaWJjYWxsIgogICBET05FOwogfSkKIAot
KGRlZmluZV9pbnNuICIqY2FsbCIKKyhkZWZpbmVfc3Vic3RfYXR0ciAia2NmaSIgImtjZmlfc3Vi
c3QiICIiICJfa2NmaSIpCisKKyhkZWZpbmVfc3Vic3QgImtjZmlfc3Vic3QiCisgIFsobWF0Y2hf
b3BlcmFuZCAwKV0KKyAgIiIKKyAgWyhrY2ZpIChtYXRjaF9kdXAgMCkKKwkgKG1hdGNoX29wZXJh
bmQgMiAiY29uc3RfaW50X29wZXJhbmQiKSldKQorCisoZGVmaW5lX2luc24gIipjYWxsPGtjZmk+
IgogICBbKGNhbGwgKG1lbTpRSSAobWF0Y2hfb3BlcmFuZDpXIDAgImNhbGxfaW5zbl9vcGVyYW5k
IiAiPGM+QndCeiIpKQogCSAobWF0Y2hfb3BlcmFuZCAxKSldCiAgICIhU0lCTElOR19DQUxMX1Ag
KGluc24pIgotICAiKiByZXR1cm4gaXg4Nl9vdXRwdXRfY2FsbF9pbnNuIChpbnNuLCBvcGVyYW5k
c1swXSk7IgorICAiKiByZXR1cm4gaXg4Nl9vdXRwdXRfY2FsbF9pbnNuIChpbnNuLCBvcGVyYW5k
cyk7IgogICBbKHNldF9hdHRyICJ0eXBlIiAiY2FsbCIpXSkKIAogOzsgVGhpcyBjb3ZlcnMgYm90
aCBjYWxsIGFuZCBzaWJjYWxsIHNpbmNlIG9ubHkgR09UIHNsb3QgaXMgYWxsb3dlZC4KQEAgLTIw
NjEzLDEyICsyMDYyMSwyMiBAQCAoZGVmaW5lX2V4cGFuZCAic2liY2FsbF92YWx1ZSIKICAgRE9O
RTsKIH0pCiAKLShkZWZpbmVfaW5zbiAiKmNhbGxfdmFsdWUiCisoZGVmaW5lX3N1YnN0X2F0dHIg
ImtjZml2IiAia2NmaXZfc3Vic3QiICIiICJfa2NmaXYiKQorCisoZGVmaW5lX3N1YnN0ICJrY2Zp
dl9zdWJzdCIKKyAgWyhzZXQgKG1hdGNoX29wZXJhbmQgMCkKKwkobWF0Y2hfb3BlcmFuZCAxKSld
CisgICIiCisgIFsoc2V0IChtYXRjaF9kdXAgMCkKKwkoa2NmaSAobWF0Y2hfZHVwIDEpCisJICAg
ICAgKG1hdGNoX29wZXJhbmQgMyAiY29uc3RfaW50X29wZXJhbmQiKSkpXSkKKworKGRlZmluZV9p
bnNuICIqY2FsbF92YWx1ZTxrY2Zpdj4iCiAgIFsoc2V0IChtYXRjaF9vcGVyYW5kIDApCiAJKGNh
bGwgKG1lbTpRSSAobWF0Y2hfb3BlcmFuZDpXIDEgImNhbGxfaW5zbl9vcGVyYW5kIiAiPGM+QndC
eiIpKQogCSAgICAgIChtYXRjaF9vcGVyYW5kIDIpKSldCiAgICIhU0lCTElOR19DQUxMX1AgKGlu
c24pIgotICAiKiByZXR1cm4gaXg4Nl9vdXRwdXRfY2FsbF9pbnNuIChpbnNuLCBvcGVyYW5kc1sx
XSk7IgorICAiKiByZXR1cm4gaXg4Nl9vdXRwdXRfY2FsbF9pbnNuIChpbnNuLCAmb3BlcmFuZHNb
MV0pOyIKICAgWyhzZXRfYXR0ciAidHlwZSIgImNhbGx2IildKQogCiA7OyBUaGlzIGNvdmVycyBi
b3RoIGNhbGwgYW5kIHNpYmNhbGwgc2luY2Ugb25seSBHT1Qgc2xvdCBpcyBhbGxvd2VkLgo=
--000000000000c396310642d589a3--
