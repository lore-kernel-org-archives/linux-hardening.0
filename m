Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815592367A0
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807033; cv=none; b=II4lMo3dAVGr/ZXRiID4LWc3piKgg51qryhUQ6IdXp4O8LWJ0eQkLlsKNh4luwfalK98mHTNFlHdS9FIEgtGEtSDWsh1IE7pXwW+N+UaDKU4dkYkgh6x/6P+P1Zt9wCuuvHYEFlGnXFLa1qRCIW+A7Ryn7hmpToZNkmDvYkSUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807033; c=relaxed/simple;
	bh=B+F43sYqZsg2HD7aYJTgDVbejTuIYSUAgOGeNWKTffY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmDrc1+hv0FUD5OAxHD/WuO1mDqr97+D9CZwSXmOmFJA2FkxM3sA5ZETC4ZpXimpjpjxm4Hk7E0fxzkp6gpqAazfg3pQycteaFNhHV7FwIWXh1ONh1qspswpzlRdkbgwYwqLq/V3fqKlJl4uvKjdlszUL+1+JRBvUMJQmk5Kqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZuB+jJd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZuB+jJd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58DMrXV1019966
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xe7Lvr3k+wUNAZBBw3Kg8vIeUWmznxUza0GSuNkDgkI=; b=FZuB+jJdXB3ovZ8w
	3/JoPnv0GfQUHqGqcMg0s1PeX7amAqBod0fYJDhaiIjPLaXoGW4YnUwcbwe74xjd
	PRBNHbUi1IxUfnIBbqihdoVdHbv7QJpc9ZLTbAAEWubkjGLHDByhhvTVE71SBNoE
	GK4C7L/TyVgLgj9dt/MvnzBkcyA0P1qhdSuAkZ+gvAL7r28sAbwVtabBrX6P8k0b
	otuPXfBGeMe1jcBCtVTQkdmFKaNX300WThDD5bR8/43ucDuPLyhNnvmJZtntG8uH
	ZyN+/0Gz8EUcQxXctYIbQeymOT4H8hAjCPApzD0o2Hxkp0ZlOSOYdIcKBDojKo/z
	UecJcw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma1f2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:43:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458345f5dso36730455ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 16:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757807022; x=1758411822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe7Lvr3k+wUNAZBBw3Kg8vIeUWmznxUza0GSuNkDgkI=;
        b=eOiJXNO1gGNmxUsNJzYeBV/jSvqBjrCttzhk1AgPwfyj55XRV/nLsMxCNk6O7H+WrR
         IrY6S/FnxXoGNfH3v1NDs2glC5IrZxAztXh0DVxxraILl22Ri1kUhIx517Ohju6NhDGD
         H4cC/FthcABWsYAM4ks6jxk0Qdr6ikAchT88AgKP8cLIFCjcl1EjzTmWWJut6jsRqRUW
         ZfCOPCZJOZpraEdq3LiqXnULZhMYkxOLxz8Src0uyM0Z199V1F9xUJsDEY/E+yqcfHIm
         1ml9ohBXw4QVambStC18kzYvAAvAxDzvTP/nqb1P0ax50duBr6QnxP01w2p+O36rpRmB
         H5hA==
X-Forwarded-Encrypted: i=1; AJvYcCULziAqnef/FH36n5ZrpMFHDwzlWVb/PjNzIzZf0+fvUy7QxeIqjN3zYHP679J6NlYsNOnndBJrQNLblfyp2UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbHu5bG0LzQEWoEH3vKSZU2UQvcvafRJiBzCjjHHkZRRS3GkQ
	bjR/k+Ikemk0sSv3q/YmVRMgc9RD/1lnKAPbkZtSeKJdbWd3AJC2TqVfLkR9g48oQA4MvCubO2F
	Hyz7KQIGq8Dj4ZrARUjO+iADe+JfQiLsgJzUite8N4A4wmzq0PGNv/jr0ZM/+a75L1PQ8Id/vr4
	xAVuTJyeiy6C7bcANgRwiQfRhfN8jnYwQGHKtV87fodxogOw==
X-Gm-Gg: ASbGncu9i+lZ3WnoaC2buE4XtDaGdHet3GpRJMx/5w8cB9soBXSE9qeDmNYe4zeFbrM
	uUhFj5CNeOXHk7vvzH71lYHIUDObY7AzvqoaVfMI+fGFMJ5iTB5/3HUnOKfKCTxuKVka3oy9Y7D
	QZEg28N3nrenVegRFNjp8=
X-Received: by 2002:a17:902:f54f:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-25d24f95c4fmr78749665ad.26.1757807022050;
        Sat, 13 Sep 2025 16:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjQWCBKVrEMZnZPm0Qxflo35jgAjm87QtBsmO0U0qn/HTdhYFJOJ0zLCx2yuru3Dwe47GP+OPPl5GoHShlJUI=
X-Received: by 2002:a17:902:f54f:b0:24a:a6c8:d6c4 with SMTP id
 d9443c01a7336-25d24f95c4fmr78749435ad.26.1757807021370; Sat, 13 Sep 2025
 16:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913231256.make.519-kees@kernel.org> <20250913232404.2690431-4-kees@kernel.org>
In-Reply-To: <20250913232404.2690431-4-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Sat, 13 Sep 2025 16:43:29 -0700
X-Gm-Features: AS18NWBKHKMN3AQD5UnsYHiBZ-YDsVFPMEJY1YcHWLxH6Zf4hPAcFV7JhoiVHuc
Message-ID: <CALvbMcDqbwjxeWn6B37+gQL1g+BvLvWpDFH=KEObMf=4kwZqZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] aarch64: Add AArch64 Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
        Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
        Richard Biener <rguenther@suse.de>, Joseph Myers <josmyers@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX5zOFq8kbneps
 m+B8D+7WrI2SOC4i9HqCkeiZvIRcFlJdKVkOY7WNI6mT2fyryCRQj8r7AIBKVCEAkFXArQNabZG
 24gjkwqoNOtFY3+9BCgy4HxiHovCrkJohaOR1Ela6Rwy2j090mWhcT/VuA8YuiP9g0dcV/Rsjy5
 1ibBpQqcRnUH9R1ylJGA00373gqTGN8wJmeqHQ4vShjSGoTR7JoSK0J/1k3vH3Eeq1NDOk5Rk+u
 foVcL1O9RG42Mk1V89GtjSnIGC/P4F25vU4d4V9Jv9vO5cNkwAJThJvaI5HZT4xiONCR/qPTS0k
 1qZtcY2MqxwdtkLbHZHQw7dVcYXm7ALtO0A8BonJ+GKPCDcjwxlht9IWI23Oae3FU6rLzl5/2Fp
 r3FGbHuW
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c601af cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=VwQbUJbxAAAA:8 a=xE9vkrlp46I2mIgoYYoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: tUZUi4tf14oYMnz-YTDi6cNmyzPalB7G
X-Proofpoint-GUID: tUZUi4tf14oYMnz-YTDi6cNmyzPalB7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-13_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Sat, Sep 13, 2025 at 4:28=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Implement AArch64-specific KCFI backend.
>
> - Trap debugging through ESR (Exception Syndrome Register) encoding
>   in BRK instruction immediate values.
>
> - Scratch register allocation using w16/w17 (x16/x17) following
>   AArch64 procedure call standard for intra-procedure-call registers.

How does this interact with BTI and sibcalls? Since for indirect
calls, x17 is already used for the address.
Why do you need/want to use a fixed register here for the load/compare
anyways? Why can't you use any free register?


>
> Assembly Code Pattern for AArch64:
>   ldur w16, [target, #-4]       ; Load actual type ID from preamble
>   mov  w17, #type_id_low        ; Load expected type (lower 16 bits)
>   movk w17, #type_id_high, lsl #16  ; Load upper 16 bits if needed
>   cmp  w16, w17                 ; Compare type IDs directly
>   b.eq .Lpass                   ; Branch if types match
>   .Ltrap: brk #esr_value        ; Enhanced trap with register info
>   .Lpass: blr/br target         ; Execute validated indirect transfer
>
> ESR (Exception Syndrome Register) Integration:
> - BRK instruction immediate encoding format:
>   0x8000 | ((TypeIndex & 31) << 5) | (AddrIndex & 31)
>   - TypeIndex indicates which W register contains expected type (W17 =3D =
17)
>   - AddrIndex indicates which X register contains target address (0-30)
>   - Example: brk #33313 (0x8221) =3D expected type in W17, target address=
 in X1
>
> Build and run tested with Linux kernel ARCH=3Darm64.
>
> gcc/ChangeLog:
>
>         config/aarch64/aarch64-protos.h: Declare aarch64_indirect_branch_=
asm,
>         and KCFI helpers.
>         config/aarch64/aarch64.cc (aarch64_expand_call): Wrap CALLs in
>         KCFI, with clobbers.
>         (aarch64_indirect_branch_asm): New function, extract common
>         logic for branch asm, like existing call asm helper.
>         (aarch64_output_kcfi_insn): Emit KCFI assembly.
>         config/aarch64/aarch64.md: Add KCFI RTL patterns and replace
>         open-coded branch emission with aarch64_indirect_branch_asm.
>         doc/invoke.texi: Document aarch64 nuances.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/config/aarch64/aarch64-protos.h |   5 ++
>  gcc/config/aarch64/aarch64.cc       | 116 ++++++++++++++++++++++++++++
>  gcc/config/aarch64/aarch64.md       |  64 +++++++++++++--
>  gcc/doc/invoke.texi                 |  14 ++++
>  4 files changed, 191 insertions(+), 8 deletions(-)
>
> diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aar=
ch64-protos.h
> index 56efcf2c7f2c..c91fdcc80ea3 100644
> --- a/gcc/config/aarch64/aarch64-protos.h
> +++ b/gcc/config/aarch64/aarch64-protos.h
> @@ -1261,6 +1261,7 @@ tree aarch64_resolve_overloaded_builtin_general (lo=
cation_t, tree, void *);
>
>  const char *aarch64_sls_barrier (int);
>  const char *aarch64_indirect_call_asm (rtx);
> +const char *aarch64_indirect_branch_asm (rtx);
>  extern bool aarch64_harden_sls_retbr_p (void);
>  extern bool aarch64_harden_sls_blr_p (void);
>
> @@ -1284,4 +1285,8 @@ extern unsigned aarch64_stack_alignment (const_tree=
 exp, unsigned align);
>  extern rtx aarch64_gen_compare_zero_and_branch (rtx_code code, rtx x,
>                                                 rtx_code_label *label);
>
> +/* KCFI support.  */
> +extern void kcfi_emit_trap_with_section (FILE *file, rtx trap_label_rtx)=
;
> +extern const char *aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operan=
ds);
> +
>  #endif /* GCC_AARCH64_PROTOS_H */
> diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.c=
c
> index fb8311b655d7..a7d17f18b72e 100644
> --- a/gcc/config/aarch64/aarch64.cc
> +++ b/gcc/config/aarch64/aarch64.cc
> @@ -83,6 +83,7 @@
>  #include "rtlanal.h"
>  #include "tree-dfa.h"
>  #include "asan.h"
> +#include "kcfi.h"
>  #include "aarch64-elf-metadata.h"
>  #include "aarch64-feature-deps.h"
>  #include "config/arm/aarch-common.h"
> @@ -11848,6 +11849,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx co=
okie, bool sibcall)
>
>    call =3D gen_rtx_CALL (VOIDmode, mem, const0_rtx);
>
> +  /* Only indirect calls need KCFI instrumentation.  */
> +  bool is_direct_call =3D SYMBOL_REF_P (XEXP (mem, 0));
> +  rtx kcfi_type_rtx =3D is_direct_call ? NULL_RTX
> +    : kcfi_get_type_id_for_expanding_gimple_call ();
> +  if (kcfi_type_rtx)
> +    {
> +      /* Wrap call in KCFI.  */
> +      call =3D gen_rtx_KCFI (VOIDmode, call, kcfi_type_rtx);
> +    }
> +
>    if (result !=3D NULL_RTX)
>      call =3D gen_rtx_SET (result, call);
>
> @@ -11864,6 +11875,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx co=
okie, bool sibcall)
>
>    auto call_insn =3D aarch64_emit_call_insn (call);
>
> +  /* Add KCFI clobbers for indirect calls.  */
> +  if (kcfi_type_rtx)
> +    {
> +      rtx usage =3D CALL_INSN_FUNCTION_USAGE (call_insn);
> +      /* Add X16 and X17 clobbers for AArch64 KCFI scratch registers.  *=
/
> +      clobber_reg (&usage, gen_rtx_REG (DImode, 16));
> +      clobber_reg (&usage, gen_rtx_REG (DImode, 17));
> +      CALL_INSN_FUNCTION_USAGE (call_insn) =3D usage;
> +    }
> +
>    /* Check whether the call requires a change to PSTATE.SM.  We can't
>       emit the instructions to change PSTATE.SM yet, since they involve
>       a change in vector length and a change in instruction set, which

Also how does this interact with SME calls?

> @@ -30630,6 +30651,14 @@ aarch64_indirect_call_asm (rtx addr)
>    return "";
>  }
>
> +const char *
> +aarch64_indirect_branch_asm (rtx addr)
> +{
> +  gcc_assert (REG_P (addr));
> +  output_asm_insn ("br\t%0", &addr);
> +  return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> +}
> +
>  /* Emit the assembly instruction to load the thread pointer into DEST.
>     Select between different tpidr_elN registers depending on -mtp=3D set=
ting.  */
>
> @@ -32823,6 +32852,93 @@ aarch64_libgcc_floating_mode_supported_p
>  #undef TARGET_DOCUMENTATION_NAME
>  #define TARGET_DOCUMENTATION_NAME "AArch64"
>
> +/* Output the assembly for a KCFI checked call instruction.  */
> +
> +const char *
> +aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> +{
> +  /* KCFI is only supported in LP64 mode.  */
> +  if (TARGET_ILP32)
> +    {
> +      sorry ("%<-fsanitize=3Dkcfi%> is not supported for %<-mabi=3Dilp32=
%>");

You should reject -fsanitize=3Dkcfi during option processing instead of
this late in the compilation.

> +      return "";
> +    }
> +  /* Target register is operands[0].  */
> +  rtx target_reg =3D operands[0];
> +  gcc_assert (REG_P (target_reg));
> +
> +  /* Get KCFI type ID from operand[3].  */
> +  uint32_t type_id =3D (uint32_t) INTVAL (operands[3]);

Maybe an assert that `(int32_t)type_id =3D=3D INTVAL (operands[3])`?

> +
> +  /* Calculate typeid offset from call target.  */
> +  HOST_WIDE_INT offset =3D -(4 + kcfi_patchable_entry_prefix_nops);
> +
> +  /* Generate labels internally.  */
> +  rtx trap_label =3D gen_label_rtx ();
> +  rtx call_label =3D gen_label_rtx ();
> +
> +  /* Get label numbers for custom naming.  */
> +  int trap_labelno =3D CODE_LABEL_NUMBER (trap_label);
> +  int call_labelno =3D CODE_LABEL_NUMBER (call_label);
> +
> +  /* Generate custom label names.  */
> +  char trap_name[32];
> +  char call_name[32];
> +  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", trap_labelno);
> +  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", call_labelno);
> +
> +  rtx temp_operands[3];
> +
> +  /* Load actual type into w16 from memory at offset using ldur.  */
> +  temp_operands[0] =3D gen_rtx_REG (SImode, R16_REGNUM);
> +  temp_operands[1] =3D target_reg;
> +  temp_operands[2] =3D GEN_INT (offset);
> +  output_asm_insn ("ldur\t%w0, [%1, #%2]", temp_operands);

Since you are using a fixed register, you don't need the temp_operands[0] h=
ere.
Also what happens if target_reg is x16? Shouldn't there be an assert
on that here?

> +
> +  /* Load expected type low 16 bits into w17.  */
> +  temp_operands[0] =3D gen_rtx_REG (SImode, R17_REGNUM);
> +  temp_operands[1] =3D GEN_INT (type_id & 0xFFFF);
> +  output_asm_insn ("mov\t%w0, #%1", temp_operands);
> +
> +  /* Load expected type high 16 bits into w17.  */
> +  temp_operands[0] =3D gen_rtx_REG (SImode, R17_REGNUM);
> +  temp_operands[1] =3D GEN_INT ((type_id >> 16) & 0xFFFF);
> +  output_asm_insn ("movk\t%w0, #%1, lsl #16", temp_operands);
> +
> +  /* Compare types.  */
> +  temp_operands[0] =3D gen_rtx_REG (SImode, R16_REGNUM);
> +  temp_operands[1] =3D gen_rtx_REG (SImode, R17_REGNUM);
> +  output_asm_insn ("cmp\t%w0, %w1", temp_operands);

No reason for the temp_operands here.

> +
> +  /* Output conditional branch to call label.  */
> +  fputs ("\tb.eq\t", asm_out_file);
> +  assemble_name (asm_out_file, call_name);
> +  fputc ('\n', asm_out_file);

There has to be a better way of implementing this.

> +
> +  /* Output trap label and BRK instruction.  */
> +  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
> +
> +  /* Calculate and emit BRK with ESR encoding.  */
> +  unsigned type_index =3D R17_REGNUM;
> +  unsigned addr_index =3D REGNO (operands[0]) - R0_REGNUM;
> +  unsigned esr_value =3D 0x8000 | ((type_index & 31) << 5) | (addr_index=
 & 31);
> +
> +  temp_operands[0] =3D GEN_INT (esr_value);
> +  output_asm_insn ("brk\t#%0", temp_operands);
> +
> +  /* Output call label.  */
> +  ASM_OUTPUT_LABEL (asm_out_file, call_name);
> +
> +  /* Return appropriate call instruction based on SIBLING_CALL_P.  */
> +  if (SIBLING_CALL_P (insn))
> +    return aarch64_indirect_branch_asm (operands[0]);
> +  else
> +    return aarch64_indirect_call_asm (operands[0]);
> +}
> +
> +#undef TARGET_KCFI_SUPPORTED
> +#define TARGET_KCFI_SUPPORTED hook_bool_void_true
> +
>  struct gcc_target targetm =3D TARGET_INITIALIZER;
>
>  #include "gt-aarch64.h"
> diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.m=
d
> index fedbd4026a06..1a5abc142f50 100644
> --- a/gcc/config/aarch64/aarch64.md
> +++ b/gcc/config/aarch64/aarch64.md
> @@ -1483,6 +1483,19 @@
>    }"
>  )
>
> +;; KCFI indirect call
> +(define_insn "*call_insn"
> +  [(kcfi (call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "=
Ucr"))
> +              (match_operand 1 "" ""))
> +        (match_operand 3 "const_int_operand"))
> +   (unspec:DI [(match_operand:DI 2 "const_int_operand")] UNSPEC_CALLEE_A=
BI)
> +   (clobber (reg:DI LR_REGNUM))]
> +  "!SIBLING_CALL_P (insn)"
> +{
> +  return aarch64_output_kcfi_insn (insn, operands);
> +}
> +  [(set_attr "type" "call")])
> +
>  (define_insn "*call_insn"
>    [(call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand"))
>          (match_operand 1 "" ""))
> @@ -1510,6 +1523,20 @@
>    }"
>  )
>
> +;; KCFI call with return value
> +(define_insn "*call_value_insn"
> +  [(set (match_operand 0 "" "")
> +       (kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operan=
d" "Ucr"))
> +                   (match_operand 2 "" ""))
> +             (match_operand 4 "const_int_operand")))
> +   (unspec:DI [(match_operand:DI 3 "const_int_operand")] UNSPEC_CALLEE_A=
BI)
> +   (clobber (reg:DI LR_REGNUM))]
> +  "!SIBLING_CALL_P (insn)"
> +{
> +  return aarch64_output_kcfi_insn (insn, &operands[1]);
> +}
> +  [(set_attr "type" "call")])
> +
>  (define_insn "*call_value_insn"
>    [(set (match_operand 0 "" "")
>         (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operand"))
> @@ -1550,6 +1577,19 @@
>    }
>  )
>
> +;; KCFI sibling call
> +(define_insn "*sibcall_insn"
> +  [(kcfi (call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "=
Ucs"))
> +              (match_operand 1 ""))
> +        (match_operand 3 "const_int_operand"))
> +   (unspec:DI [(match_operand:DI 2 "const_int_operand")] UNSPEC_CALLEE_A=
BI)
> +   (return)]
> +  "SIBLING_CALL_P (insn)"
> +{
> +  return aarch64_output_kcfi_insn (insn, operands);
> +}
> +  [(set_attr "type" "branch")])
> +
>  (define_insn "*sibcall_insn"
>    [(call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "Ucs, U=
sf"))
>          (match_operand 1 ""))
> @@ -1558,16 +1598,27 @@
>    "SIBLING_CALL_P (insn)"
>    {
>      if (which_alternative =3D=3D 0)
> -      {
> -       output_asm_insn ("br\\t%0", operands);
> -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> -      }
> +      return aarch64_indirect_branch_asm (operands[0]);
>      return "b\\t%c0";
>    }
>    [(set_attr "type" "branch, branch")
>     (set_attr "sls_length" "retbr,none")]
>  )
>
> +;; KCFI sibling call with return value
> +(define_insn "*sibcall_value_insn"
> +  [(set (match_operand 0 "")
> +       (kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operan=
d" "Ucs"))
> +                   (match_operand 2 ""))
> +             (match_operand 4 "const_int_operand")))
> +   (unspec:DI [(match_operand:DI 3 "const_int_operand")] UNSPEC_CALLEE_A=
BI)
> +   (return)]
> +  "SIBLING_CALL_P (insn)"
> +{
> +  return aarch64_output_kcfi_insn (insn, &operands[1]);
> +}
> +  [(set_attr "type" "branch")])
> +
>  (define_insn "*sibcall_value_insn"
>    [(set (match_operand 0 "")
>         (call (mem:DI
> @@ -1578,10 +1629,7 @@
>    "SIBLING_CALL_P (insn)"
>    {
>      if (which_alternative =3D=3D 0)
> -      {
> -       output_asm_insn ("br\\t%1", operands);
> -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> -      }
> +      return aarch64_indirect_branch_asm (operands[1]);
>      return "b\\t%c1";
>    }
>    [(set_attr "type" "branch, branch")
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index bd84b7dd903f..972e8e76494f 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -18425,6 +18425,20 @@ check-call bundle are considered ABI, as the Lin=
ux kernel may
>  optionally rewrite these areas at boot time to mitigate detected CPU
>  errata.
>
> +On AArch64, KCFI type identifiers are emitted as a @code{.word ID}
> +directive (a 32-bit constant) before the function entry.  AArch64's
> +natural 4-byte instruction alignment eliminates the need for additional
> +alignment NOPs.  When used with @option{-fpatchable-function-entry}, the
> +type identifier is placed before any prefix NOPs.  The runtime check
> +uses @code{x16} and @code{x17} as scratch registers.  Type mismatches
> +trigger a @code{brk} instruction with an immediate value that encodes
> +both the expected type register index and the target address register
> +index in the format @code{0x8000 | (type_reg << 5) | addr_reg}.  This
> +encoding is captured in the ESR (Exception Syndrome Register) when the
> +trap is taken, allowing the kernel to identify both the KCFI violation
> +and the involved registers for detailed diagnostics (eliminating the nee=
d
> +for a separate @code{.kcfi_traps} section as used on x86_64).
> +
>  KCFI is intended primarily for kernel code and may not be suitable
>  for user-space applications that rely on techniques incompatible
>  with strict type checking of indirect calls.
> --
> 2.34.1
>
