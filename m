Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE09218AAB
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763696653; cv=none; b=Z1C4cx4YGV0tD7skvz0GZaGXxL4Jl1Cie60c4VU9jAce4MCaLREcbPOrNjJ7fyH9vdsba+IN3XfFf4qFqiKI4WnXY0wCe8Ujwk31bdD9PKsbR9oK8ypLhL2Z3eTEH9qSBVaC9LCNKv4tQLCAlc0KS22902N+0Vd+3CytWzRwlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763696653; c=relaxed/simple;
	bh=7iMYxlH5cdW5fU3GLNbCH03+0BA7+8Gz+x505Uw9h2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKnRpRaKz4xDUPrxbF2U1N0D56SYWmm7IX/FIsQ1PDgM0h7VzzaLcrQ9gVUaJs0wbUnixhxjHD+KRNQleV3JSxjS64zGt/b8MdR5wmYkwILc9WLVsQ9/zGhQ6FpTDTwJsgk5OLI34HoopsgUPnkiynrqcNsy/xp7+jpjWkfRNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7Alt/ib; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kokrdNMA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7Alt/ib";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kokrdNMA"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKKAZDj1337453
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 03:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EbjRLWTFFddo6FlGlOZQCDrOw270K8SxuswNcMrT/UU=; b=g7Alt/ibIL7YP+4C
	FHKGY/EwNsvHF6CWpzzfBtbfQJr0aLT2Kjxybb33D5FmAvroIGQUpy0Z3PDPr1mw
	rrRi7Rpc4GSag/oU4nJfza3B3226vPdvqf+8hSWOzoawvOZPjYcyblX1qcY421x9
	gPAtXtdrWmFPhdONKLrcvTdqucou8c8kBxmbHavkURcmplacHwhrIV1ScxdgrAQq
	x8Jv+7jJhZiqQNB37gWxWuszZiuUsia6Cco7+XwEIEfzyPH2aKvQSLDl/Ii8ckT6
	vKw0go7rtZjrSSHb/4JNzgm3MBrjk6ijl8mdDFWGBbJu2c5URf0/O6fXqI0ltdCP
	O80PUA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aj5y7sw4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 03:44:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bc169af24cfso1244078a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 19:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763696650; x=1764301450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbjRLWTFFddo6FlGlOZQCDrOw270K8SxuswNcMrT/UU=;
        b=kokrdNMAozQJzo5A/YLULXfQaK264s+A+8kDZlgWRZ/aQCBF3IGz88jK/sTXkL8198
         fk0DeXMp/GaScsTntGumkqQV5FodMUCiHBzcSlqmsYo8YEzZAec4K8BcuBGwV+oIGB3c
         jIDPZ3q0AxB885lXf1yC0gGVhf7KuILvjA+3cZn8wRMtjX9E99fb6q25L9gGKWyvqydL
         krjuBOjNPLfZ3/iimpbEvGUERYXi7BszGZ5Cyg7AKDnbKrPB8BdEQqQqaVpl/SXNoCXJ
         LLj5Lh1cGeutQtZXFKKzewYr4yaZXKky7zbeqM0x0xmul4FqUQzSTgbxCj6intZ4+6bX
         bMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763696650; x=1764301450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbjRLWTFFddo6FlGlOZQCDrOw270K8SxuswNcMrT/UU=;
        b=kDtHzoy+dEANIOqqK6pDUyJoWQ0RREnxc2OZpyZIYeUiBZFQibCBtRErvNLMFvPTp0
         lSSbn8bheXlFX93AuivTYczRV2pyGhiz8S41EPAJULpzttAJi27jM7ZkkMcm/I5IM+5V
         27dJBMYa0OLhLs8l3bgZKAxAMMKw3QGuusvPo5KrQugzkWjkXSyIfAGC3Jux6dRz7CCA
         kughTjsV5EDlHCtx5MTaOq5NNkUUCk9Tx7xG8EBsPmZ7K0V+fAUR3kpAHiPLDf/Z6vTs
         Z22Ht0KWJynoJOVL6AXl0lJLvOqScuEnCZRvQWqxE6URxwB56vrzBYQCoko+fg+KlQ3P
         pvcA==
X-Forwarded-Encrypted: i=1; AJvYcCVsjL7cZYORb9adMMMi8YTR5xH4uExURCJXbQkeYe74blIwiSB3ZB7ItqbFVD0bAZlEx6nDwQEzbYT6hQbjhrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwauSNEItpMoANBQj/wL74xHTC0UEijI9H4+EQLRI729vPB+3QA
	1GK5IvpgoBfMN8fefcKnsTI6qenYZDxqfI23dLcbv/6X/C6tdXVNmU0bVzNZ4ftV4GvmnT+Ufgm
	k6J+qXw/9P5SySybKmaDyVWOdjt1GF9TtZxxH9kpN/viuaYpWvQsFgaoehUloo9e2GW7MHz87xs
	EMY53bN3IOomilZv29I0tE3jag3Ydhnf8UL06hf5m0cF9eyA==
X-Gm-Gg: ASbGncuiJ2BC2xTXL3XfDYgonfAeDzTcpqW00DmNDgIdESbiWABdgjoInkraGtSkqyH
	UuxLi5IluRVSoIaSYQZmjhdEy6KPNRcBKeksIP+W3Jr1DOJG5yFW9zXkfiS6wMuUBfpEHExKKv3
	vTRIJ70JrhELVpO9otPdmQNCcut0dz3vmqd9FUEby/skErLRjBnOj/IRvTQ2Qh9aGm
X-Received: by 2002:a05:7300:c88:b0:2a4:6ea6:b9a4 with SMTP id 5a478bee46e88-2a7192efda0mr397122eec.39.1763696649834;
        Thu, 20 Nov 2025 19:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExo6pLDaFSlQCVkniF/ljyfrTGGWgxQvpfifwW5phy4wpihR4eONtQNqSttBHFmmPjfPiAsl8VN2BgM98Qb9E=
X-Received: by 2002:a05:7300:c88:b0:2a4:6ea6:b9a4 with SMTP id
 5a478bee46e88-2a7192efda0mr397101eec.39.1763696649174; Thu, 20 Nov 2025
 19:44:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120222105.us.687-kees@kernel.org> <20251120222113.3318463-5-kees@kernel.org>
 <CALvbMcCx+N=P+AkpTbwQBanDTRWi+VsouoxyMLPEfOfEmNZaow@mail.gmail.com> <202511201624.02B217623C@keescook>
In-Reply-To: <202511201624.02B217623C@keescook>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 20 Nov 2025 19:43:57 -0800
X-Gm-Features: AWmQ_bl659JZ1TUImMKuIFQS-d95bXPQUyRPr_Ara4GT3y-w48to_E0IHi3_TTs
Message-ID: <CALvbMcAiNGN0XMb5utZarp3QMd=CNrr5ie8YCrGnGF4rB7innw@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] aarch64: Add AArch64 Kernel Control Flow Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
        Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
        Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
        Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
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
        Bill Wendling <morbo@google.com>,
        "Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
        "Constable, Scott D" <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QMxlhwLL c=1 sm=1 tr=0 ts=691fe00a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=DAAnpeMK5X6UO-Uk24oA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: bEsyG6C_uvoU2LylR47vnS_F00MskI8f
X-Proofpoint-ORIG-GUID: bEsyG6C_uvoU2LylR47vnS_F00MskI8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDAyNyBTYWx0ZWRfX/vYv+mnhCjlY
 zONaP/sSlOLgAD1cNbL2/nWCzbMYp6Ymp22/9T2AiebFy+RSnR+i4bdaBqgwCDmgmmJAAJ7BNTB
 hgrSqX+qt74PL7U6LQ5u7GOblOSrakKDNAW0Q15pHjDzH2RbDvjU2auW8Wn0ibqK8unkC1l/5VI
 9L0B2nHTZKaT7hgCaVin75FNAJ2g7aOcAOB9rolhWM8WBkefqv8Npe0kNe/CaQoEd24lHTwWrqW
 6aZLZJ7ydl+j6x0nlfrzhoQkXO90FtbPCvewW01P4/wN8dms+8YvjlL77PNmMbIHwCvB0ZtIz6f
 eom5nq8OaLg0HOL5ef916q4UlqmJfhCCz2Vt+FPo9+GyFoW9+aKWCSqew/hSJKNw5N+lhowCnqo
 cv/WaPXPbqP3MKRRVrPHXKVJRsiWJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_01,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210027

On Thu, Nov 20, 2025 at 4:30=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Nov 20, 2025 at 02:57:49PM -0800, Andrew Pinski wrote:
> > On Thu, Nov 20, 2025 at 2:29=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > Implement AArch64-specific KCFI backend.
> > >
> > > - Trap debugging through ESR (Exception Syndrome Register) encoding
> > >   in BRK instruction immediate values.
> > >
> > > - Scratch register allocation using w16/w17 (x16/x17) following
> > >   AArch64 procedure call standard for intra-procedure-call registers,
> > >   which already makes x16/x17 available through existing clobbers.
> > >
> > > - Complementary with BTI (which uses a separate pass system to inject
> > >   landing instructions where needed).
> > >
> > > - Does not interfere with SME, which uses attributes not function
> > >   prototypes for distinguishing functions.
> > >
> > > Assembly Code Pattern for AArch64:
> > >   ldur w16, [target, #-4]       ; Load actual type ID from preamble
> > >   mov  w17, #type_id_low        ; Load expected type (lower 16 bits)
> > >   movk w17, #type_id_high, lsl #16  ; Load upper 16 bits if needed
> > >   cmp  w16, w17                 ; Compare type IDs directly
> > >   b.eq .Lpass                   ; Branch if types match
> > >   .Ltrap: brk #esr_value        ; Enhanced trap with register info
> > >   .Lpass: blr/br target         ; Execute validated indirect transfer
> > >
> > > ESR (Exception Syndrome Register) Integration:
> > > - BRK instruction immediate encoding format:
> > >   0x8000 | ((TypeIndex & 31) << 5) | (AddrIndex & 31)
> > >   - TypeIndex indicates which W register contains expected type (W17 =
=3D 17)
> > >   - AddrIndex indicates which X register contains target address (0-3=
0)
> > >   - Example: brk #33313 (0x8221) =3D expected type in W17, target add=
ress in X1
> > >
> > > Build and run tested with Linux kernel ARCH=3Darm64.
> > >
> > > gcc/ChangeLog:
> > >
> > >         config/aarch64/aarch64-protos.h: Declare aarch64_indirect_bra=
nch_asm,
> > >         and KCFI helpers.
> > >         config/aarch64/aarch64.cc (aarch64_expand_call): Wrap CALLs i=
n
> > >         KCFI, with clobbers.
> > >         (aarch64_indirect_branch_asm): New function, extract common
> > >         logic for branch asm, like existing call asm helper.
> > >         (aarch64_output_kcfi_insn): Emit KCFI assembly.
> > >         config/aarch64/aarch64.md: Add KCFI RTL patterns and replace
> > >         open-coded branch emission with aarch64_indirect_branch_asm.
> > >         doc/invoke.texi: Document aarch64 nuances.
> > >
> > > gcc/testsuite/ChangeLog:
> > >
> > >         * gcc.dg/kcfi/kcfi-adjacency.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-basics.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-call-sharing.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-complex-addressing.c: Add aarch64 patterns=
.
> > >         * gcc.dg/kcfi/kcfi-move-preservation.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add aarch64 patterns=
.
> > >         * gcc.dg/kcfi/kcfi-no-sanitize.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-offset-validation.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add aarch64 patter=
ns.
> > >         * gcc.dg/kcfi/kcfi-patchable-large.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-patchable-medium.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add aarch64 patte=
rns.
> > >         * gcc.dg/kcfi/kcfi-tail-calls.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-trap-section.c: Add aarch64 patterns.
> > >         * gcc.dg/kcfi/kcfi-trap-encoding.c: New test.
> > >
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > ---
> > >  gcc/config/aarch64/aarch64-protos.h           |   5 +
> > >  gcc/config/aarch64/aarch64.md                 |  66 +++++++++--
> > >  gcc/config/aarch64/aarch64.cc                 | 105 ++++++++++++++++=
++
> > >  gcc/doc/invoke.texi                           |  14 +++
> > >  gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  15 +++
> > >  gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 ++++
> > >  gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   4 +
> > >  .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  16 +++
> > >  .../gcc.dg/kcfi/kcfi-move-preservation.c      |  20 ++++
> > >  .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |   5 +
> > >  gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   1 +
> > >  .../gcc.dg/kcfi/kcfi-offset-validation.c      |   3 +
> > >  .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  12 ++
> > >  .../gcc.dg/kcfi/kcfi-patchable-large.c        |  12 ++
> > >  .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  12 ++
> > >  .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  12 ++
> > >  gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  19 ++++
> > >  .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  41 +++++++
> > >  gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   4 +
> > >  19 files changed, 379 insertions(+), 8 deletions(-)
> > >  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
> > >
> > > diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64=
/aarch64-protos.h
> > > index a9e407ba340e..c32d454fe277 100644
> > > --- a/gcc/config/aarch64/aarch64-protos.h
> > > +++ b/gcc/config/aarch64/aarch64-protos.h
> > > @@ -1272,6 +1272,7 @@ tree aarch64_resolve_overloaded_builtin_general=
 (location_t, tree, void *);
> > >
> > >  const char *aarch64_sls_barrier (int);
> > >  const char *aarch64_indirect_call_asm (rtx);
> > > +const char *aarch64_indirect_branch_asm (rtx);
> > >  extern bool aarch64_harden_sls_retbr_p (void);
> > >  extern bool aarch64_harden_sls_blr_p (void);
> > >
> > > @@ -1295,4 +1296,8 @@ extern unsigned aarch64_stack_alignment (const_=
tree exp, unsigned align);
> > >  extern rtx aarch64_gen_compare_zero_and_branch (rtx_code code, rtx x=
,
> > >                                                 rtx_code_label *label=
);
> > >
> > > +/* KCFI support.  */
> > > +extern void kcfi_emit_trap_with_section (FILE *file, rtx trap_label_=
rtx);
> > > +extern const char *aarch64_output_kcfi_insn (rtx_insn *insn, rtx *op=
erands);
> > > +
> > >  #endif /* GCC_AARCH64_PROTOS_H */
> > > diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch=
64.md
> > > index 855df791bae7..84894816509c 100644
> > > --- a/gcc/config/aarch64/aarch64.md
> > > +++ b/gcc/config/aarch64/aarch64.md
> > > @@ -1506,6 +1506,19 @@
> > >    }"
> > >  )
> > >
> > > +;; KCFI indirect call
> > > +(define_insn "*call_insn"
> > > +  [(kcfi (call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operan=
d" "Ucr"))
> > > +              (match_operand 1 "" ""))
> > > +        (match_operand 3 "const_int_operand"))
> > > +   (unspec:DI [(match_operand:DI 2 "const_int_operand")] UNSPEC_CALL=
EE_ABI)
> > > +   (clobber (reg:DI LR_REGNUM))]
> > > +  "!SIBLING_CALL_P (insn)"
> > > +{
> > > +  return aarch64_output_kcfi_insn (insn, operands);
> > > +}
> > > +  [(set_attr "type" "call")])
> > > +
> > >  (define_insn "*call_insn"
> > >    [(call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand"))
> > >          (match_operand 1 "" ""))
> > > @@ -1533,6 +1546,21 @@
> > >    }"
> > >  )
> > >
> > > +;; KCFI call with return value
> > > +(define_insn "*call_value_insn"
> > > +  [(set (match_operand 0 "" "")
> > > +       (kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_op=
erand"
> > > +                            "Ucr"))
> > > +                   (match_operand 2 "" ""))
> > > +             (match_operand 4 "const_int_operand")))
> > > +   (unspec:DI [(match_operand:DI 3 "const_int_operand")] UNSPEC_CALL=
EE_ABI)
> > > +   (clobber (reg:DI LR_REGNUM))]
> > > +  "!SIBLING_CALL_P (insn)"
> > > +{
> > > +  return aarch64_output_kcfi_insn (insn, &operands[1]);
> > > +}
> > > +  [(set_attr "type" "call")])
> > > +
> > >  (define_insn "*call_value_insn"
> > >    [(set (match_operand 0 "" "")
> > >         (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operand"=
))
> > > @@ -1573,6 +1601,19 @@
> > >    }
> > >  )
> > >
> > > +;; KCFI sibling call
> > > +(define_insn "*sibcall_insn"
> > > +  [(kcfi (call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operan=
d" "Ucs"))
> > > +              (match_operand 1 ""))
> > > +        (match_operand 3 "const_int_operand"))
> > > +   (unspec:DI [(match_operand:DI 2 "const_int_operand")] UNSPEC_CALL=
EE_ABI)
> > > +   (return)]
> > > +  "SIBLING_CALL_P (insn)"
> > > +{
> > > +  return aarch64_output_kcfi_insn (insn, operands);
> > > +}
> > > +  [(set_attr "type" "branch")])
> > > +
> > >  (define_insn "*sibcall_insn"
> > >    [(call (mem:DI (match_operand:DI 0 "aarch64_call_insn_operand" "Uc=
s, Usf"))
> > >          (match_operand 1 ""))
> > > @@ -1581,16 +1622,28 @@
> > >    "SIBLING_CALL_P (insn)"
> > >    {
> > >      if (which_alternative =3D=3D 0)
> > > -      {
> > > -       output_asm_insn ("br\\t%0", operands);
> > > -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > > -      }
> > > +      return aarch64_indirect_branch_asm (operands[0]);
> >
> > Can you extract aarch64_indirect_branch_asm into a different patch?
> > Since it is only slightly related to this.
> > The main reason is because applying that can happen before the rest of
> > the KFCI patches are approved. And I will handling applying that once
> > it has been extracted out.
>
> Sure! I'll extract it.
>
> >
> > >      return "b\\t%c0";
> > >    }
> > >    [(set_attr "type" "branch, branch")
> > >     (set_attr "sls_length" "retbr,none")]
> > >  )
> > >
> > > +;; KCFI sibling call with return value
> > > +(define_insn "*sibcall_value_insn"
> > > +  [(set (match_operand 0 "")
> > > +       (kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_op=
erand"
> > > +                            "Ucs"))
> > > +                   (match_operand 2 ""))
> > > +             (match_operand 4 "const_int_operand")))
> > > +   (unspec:DI [(match_operand:DI 3 "const_int_operand")] UNSPEC_CALL=
EE_ABI)
> > > +   (return)]
> > > +  "SIBLING_CALL_P (insn)"
> > > +{
> > > +  return aarch64_output_kcfi_insn (insn, &operands[1]);
> > > +}
> > > +  [(set_attr "type" "branch")])
> > > +
> > >  (define_insn "*sibcall_value_insn"
> > >    [(set (match_operand 0 "")
> > >         (call (mem:DI
> > > @@ -1601,10 +1654,7 @@
> > >    "SIBLING_CALL_P (insn)"
> > >    {
> > >      if (which_alternative =3D=3D 0)
> > > -      {
> > > -       output_asm_insn ("br\\t%1", operands);
> > > -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > > -      }
> > > +      return aarch64_indirect_branch_asm (operands[1]);
> > >      return "b\\t%c1";
> > >    }
> > >    [(set_attr "type" "branch, branch")
> > > diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch=
64.cc
> > > index 6dfdaa4fb9b0..86e3af992d2a 100644
> > > --- a/gcc/config/aarch64/aarch64.cc
> > > +++ b/gcc/config/aarch64/aarch64.cc
> > > @@ -83,6 +83,7 @@
> > >  #include "rtlanal.h"
> > >  #include "tree-dfa.h"
> > >  #include "asan.h"
> > > +#include "kcfi.h"
> > >  #include "aarch64-elf-metadata.h"
> > >  #include "aarch64-feature-deps.h"
> > >  #include "config/arm/aarch-common.h"
> > > @@ -11965,6 +11966,16 @@ aarch64_expand_call (rtx result, rtx mem, rt=
x cookie, bool sibcall)
> > >
> > >    call =3D gen_rtx_CALL (VOIDmode, mem, const0_rtx);
> > >
> > > +  /* Only indirect calls need KCFI instrumentation.  */
> > > +  bool is_direct_call =3D SYMBOL_REF_P (XEXP (mem, 0));
> > > +  rtx kcfi_type_rtx =3D is_direct_call ? NULL_RTX
> > > +    : kcfi_get_type_id_for_expanding_gimple_call ();
> > > +  if (kcfi_type_rtx)
> > > +    {
> > > +      /* Wrap call in KCFI.  */
> > > +      call =3D gen_rtx_KCFI (VOIDmode, call, kcfi_type_rtx);
> > > +    }
> > > +
> > >    if (result !=3D NULL_RTX)
> > >      call =3D gen_rtx_SET (result, call);
> > >
> > > @@ -19225,6 +19236,9 @@ aarch64_override_options_internal (struct gcc=
_options *opts)
> > >  #endif
> > >      }
> > >
> > > +  if ((flag_sanitize & SANITIZE_KCFI) && TARGET_ILP32)
> > > +    sorry ("%<-fsanitize=3Dkcfi%> is not supported for %<-mabi=3Dilp=
32%>");
> > > +
> > >    aarch64_feature_flags isa_flags =3D aarch64_get_isa_flags (opts);
> > >    if ((isa_flags & (AARCH64_FL_SM_ON | AARCH64_FL_ZA_ON))
> > >        && !(isa_flags & AARCH64_FL_SME))
> > > @@ -30822,6 +30836,18 @@ aarch64_indirect_call_asm (rtx addr)
> > >    return "";
> > >  }
> > >
> > > +/* Generate assembly for AArch64 indirect branch instruction.  ADDR =
is the
> > > +   target address register.  Returns any additional barrier instruct=
ions
> > > +   needed for SLS (Straight Line Speculation) mitigation.  */
> > > +
> > > +const char *
> > > +aarch64_indirect_branch_asm (rtx addr)
> > > +{
> > > +  gcc_assert (REG_P (addr));
> > > +  output_asm_insn ("br\t%0", &addr);
> > > +  return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> > > +}
> > > +
> > >  /* Emit the assembly instruction to load the thread pointer into DES=
T.
> > >     Select between different tpidr_elN registers depending on -mtp=3D=
 setting.  */
> > >
> > > @@ -33089,6 +33115,85 @@ aarch64_libgcc_floating_mode_supported_p
> > >  #undef TARGET_DOCUMENTATION_NAME
> > >  #define TARGET_DOCUMENTATION_NAME "AArch64"
> > >
> > > +/* Output the assembly for a KCFI checked call instruction.  INSN is=
 the
> > > +   RTL instruction being processed.  OPERANDS is the array of RTL op=
erands
> > > +   where operands[0] is the call target register, operands[3] is the=
 KCFI
> > > +   type ID constant.  Returns the appropriate call instruction strin=
g.  */
> > > +
> > > +const char *
> > > +aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> > > +{
> > > +  /* Target register is operands[0].  */
> > > +  rtx target_reg =3D operands[0];
> > > +  gcc_assert (REG_P (target_reg));
> > > +
> > > +  /* Get KCFI type ID from operand[3].  */
> > > +  uint32_t type_id =3D (uint32_t) INTVAL (operands[3]);
> > > +
> > > +  /* Calculate typeid offset from call target.  */
> > > +  HOST_WIDE_INT offset =3D -kcfi_get_typeid_offset ();
> > > +
> > > +  /* Get unique label number for this KCFI check.  */
> > > +  int labelno =3D kcfi_next_labelno ();
> > > +
> > > +  /* Generate custom label names.  */
> > > +  char trap_name[32];
> > > +  char call_name[32];
> > > +  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", labelno);
> > > +  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", labelno);
> > > +
> > > +  rtx temp_operands[3];
> > > +
> > > +  /* Load actual type into w16 from memory at offset using ldur.  */
> > > +  temp_operands[0] =3D gen_rtx_REG (SImode, R16_REGNUM);
> > > +  temp_operands[1] =3D target_reg;
> > > +  temp_operands[2] =3D GEN_INT (offset);
> > > +  output_asm_insn ("ldur\t%w0, [%1, #%2]", temp_operands);
> >
> > Why not just:
> >   temp_operands[0] =3D target_reg;
> >   temp_operands[0] =3D GEN_INT (offset);
> >   output_asm_insn ("ldur\tw16, [%0, #%1]", temp_operands);
>
> Oops, yes. I have rewritten these handlers so many times I've lost my
> mind. :)
>
> >
> > > +
> > > +  /* Load expected type low 16 bits into w17.  */
> > > +  temp_operands[0] =3D gen_rtx_REG (SImode, R17_REGNUM);
> > > +  temp_operands[1] =3D GEN_INT (type_id & 0xFFFF);
> > > +  output_asm_insn ("mov\t%w0, #%1", temp_operands);
> > Likewise.
> > Also why not use fprintf here?
> > Like:
> > fprintf(asm_out_file, "mov\t%w0, #%d\n", type_id & 0xFFFF);
>
> It seemed like directly using fprintf() was frowned on, and the
> output_asm_insn with an operands array was the "correct" way to do all
> of these? I'm happy to do it however! :)

the other option is doing:
```
fputs("\tmov\t%w0, #", asm_out_file);
fprint_whex (type_id & 0xFFFF);
fputc ('\n', asm_out_file);
```
Which might be faster than both fprintf and output_asm_insn here and
stays away from fprintf.
You could also use asm_fprintf which calls fprintf in some cases :).

Thanks,
Andrew

>
> > > +#undef TARGET_KCFI_SUPPORTED
> > > +#define TARGET_KCFI_SUPPORTED hook_bool_void_true
> >
> > Why return true always for it being supported? I thought this is not
> > supported with ilp32, it is definitely not supported for mingw. Is it
> > supported with -elf targets rather than -linux-gnu targets?
>
> Ah, it seemed like the only place I could do the checking for ilp32,
> etc was in aarch64_override_options_internal. I'll see if I can figure
> out how to move that into the TARGET hooks, but all the examples I could
> find where in the override_options functions...
>
> Thanks for the review! I'll do more fixing. :)
>
> -Kees
>
> --
> Kees Cook
