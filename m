Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455E3B8D4B
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579694; cv=none; b=jRAQTmPDSoMAXc9CLUA8AuKM8T+X0xF/7RCweUQBrHi9auU472knqgPNW3u+Iy7mHCmfT+8goyFEjCXalpXqN1VKeXZ7ltPkgCQpo6lj9DoGDKH4k1dmV2qqVqK4ZY+/gZ0ftj+vnJzRiOGksM6XQeiZFgRS9bV+cVTYIx+wVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579694; c=relaxed/simple;
	bh=Jek+o6VFawpiaQoDmiToojwZXavTJ2koErAa8mWNgPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nz2rDH4NhRkmJfQE2+kSaGA8Y4kaNCXqve00fWYLUjzO+7pWi74gK6yFBkmD2I2M1pHBJuPPL1rVNwQGXrQTNyidQtftim/vk+J6dFsE+cOqNPZRJN1DvqwvdsG7Lgl+3ceEKfOXF9Fuf1S3WMuNxXEG15sBHSqpS1MXGOpP+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cqwbq2+s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IYW+AqNL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cqwbq2+s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IYW+AqNL"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BC8SbUk3432731
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 22:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5CQ9q7V1phyZE4+bf4HRIIa8vBmDda6xQ4HvJwIzS0g=; b=Cqwbq2+sijPOj+MM
	byDvW5SiqyOe6c+1yN94aYHTau3M0/fDEg+qj7SCVE2FdnX894uJH+4GvDl0BHyp
	O3MyTivEh/QSDdOyhFT+XzkhkZnyMRmO1TgPi9hCmhxYhZxRBzS2DTqj1+iwaDwX
	kKGQbqMBz8qGmaaRnAzAQl4TgFGH6xpz2Hvv0D+/bePOlxK6q6m8HVeKX7h6Wbqj
	2V8fUPV1bGuA6nxSqE3dYwBEF4SJ3o3oKl28XK1nHqVnfhpN7giz+NTLzkqexzn6
	BoU/8PtyIeeIuhVVyNEdOYW8km6uN7wMIJOQAGBcnufH8b+cpoVLIcJGRlOKTjtk
	LyhLyQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b0fjt9kt3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 22:48:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-298535ef0ccso20585885ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 14:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765579690; x=1766184490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CQ9q7V1phyZE4+bf4HRIIa8vBmDda6xQ4HvJwIzS0g=;
        b=IYW+AqNLFIFoDH7Pt2R1bvP9BqjbFeI1gjFu9SOoFbu+d+ECW8SyfIgD5j/1sFjnk6
         WhBfdiOqz6f/l1iOP/gz180SuRuYrCxAhQ70WLJ7ZrDzij5KfDKdo9x64MuW83o5MfWI
         mC1rJ5UlprFXLNy7iiRNCL3GLAGt4ktZu8W5McI8MRizqZwXpDYuuNcduTKKYlj8pAMd
         YnKsuMZg6rm+CNYBrUF8+6wlbKAeRoXBnWIFinhOLJeVJY/wE2oDgkn/ia5jLVw1QK5z
         4ozJGPFnraxd5nJ+K7b5vtUfe6u3dnpcoOFy9ZBbagJ8t0sYOUQaaBD/TjIYlh+mZ7Li
         YB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579690; x=1766184490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5CQ9q7V1phyZE4+bf4HRIIa8vBmDda6xQ4HvJwIzS0g=;
        b=vpUQb7Bzdu8+4xakiCUg8IbEAp3ZVt4TMxrmFHnt7g77oq9xt1LpX/ViPye0B7nb+r
         r6hQMfts+NnHRPS22U/qNDDh/g5LolsaLS0INpYdLJNU+5n72bKanuL+Wq+hSIJujFXs
         uvL4RGcST6VzCu7vRwugp9rT9SC9OglGwR/ErPj0q6OJOcwsgKGkfmm+tJAwHsk4Vtk7
         YSXh0CizP61GGZr+UkicWHG1Wi0u/QGCJlrVw20cgrgabWY73U4eQf/mSPpuhwLEu3kZ
         m9SYc3QjG6o/f1DywaLeUSBdeGMO7M+3T547ZV5taV5YbtolqytxXESNgqugtch6nyrE
         rfrw==
X-Forwarded-Encrypted: i=1; AJvYcCUsTtke1L5khxmiJUWjWy+MIg1h/t+JwTerO/5LUEnq+NbzJe2DwUTBjujVLtX5w/7+Q9tfVrHy1cSOvha/XKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9E9nv9r9tVfkUiPscs/RdrMN0qMYixSBWiUTbczzjNOOasO/h
	e+ljI0KWAODPhtlTFmQ+O+9BqQ77DaICBoSg7rmSOwX03hqfX1MTVzYdlx0aTcGv0mCSWjknk1u
	/y0sc8FrWpr1fTELqjNe4wTRx1J6F8M/2UTyjXBI7fNg0fu4cVWZT1M3YK8Lmh8lYiI71A/kj88
	T4v9UWhGMDGu8K2hhOfZMf0rbbrqX+1gitiNjSbBFLvhjEog==
X-Gm-Gg: AY/fxX49JXM3X09XF6M/8koPfV5u2rdHKXfr16xp93v6IP7V4qHyeQ9PpDjHAono/bw
	QBLEOvDbYjJXyjH0x9QvWuctDhxVut8intcjpIAUwT5FrTnN9p/iQggmEnoQSyVWsJ68fKYI2r/
	shwe0XgWQx9jt6VLW0URSjqsNe1P4Gp12t5czTTwP1A3E3iLXxi5BO7b8pFqFs1fY0
X-Received: by 2002:a05:7300:5723:b0:2a6:a0f0:d7c1 with SMTP id 5a478bee46e88-2ac301f9627mr2081108eec.12.1765579689198;
        Fri, 12 Dec 2025 14:48:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9RqUUgchpeiiUkzVwefhk1qcLwlt1kAdGFMdzsB9C2o6+9gmcdMxaCmR+bspBDavWwVqNzfUvLPKZkTk+9po=
X-Received: by 2002:a05:7300:5723:b0:2a6:a0f0:d7c1 with SMTP id
 5a478bee46e88-2ac301f9627mr2081069eec.12.1765579688356; Fri, 12 Dec 2025
 14:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210022025.harder.803-kees@kernel.org> <20251210022035.331892-5-kees@kernel.org>
In-Reply-To: <20251210022035.331892-5-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Fri, 12 Dec 2025 14:47:57 -0800
X-Gm-Features: AQt7F2owWJWz97fvX13C104vCSNz1ZSBRgeII03ufizHxlaWJfD_JtSEu4IP1vw
Message-ID: <CALvbMcCFQbBO2McnTfWVHEcVvZfy+U6FSM7jMPyG-1-N9RP14A@mail.gmail.com>
Subject: Re: [PATCH v9 5/7] aarch64: Add AArch64 Kernel Control Flow Integrity implementation
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
X-Proofpoint-ORIG-GUID: 7sJ_uFCBu1wb6LmlZV4s3_awRUMp2JHG
X-Proofpoint-GUID: 7sJ_uFCBu1wb6LmlZV4s3_awRUMp2JHG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDE4NCBTYWx0ZWRfX5IvSEA72ynuJ
 LqiSiFD/5NqHSnaEVX5dufDJCK+AuzP1aSf7Kr+fjuI/1IjY8J0fuVkFlhIaDXyJJEij/N8SmdW
 jMyBxMKMAQ+jXNJLcxbImDWjjgS/i7Yx0EFXZKaSnnEAnX6SPL+4jC6vtUvTCmcU/k1Zo9NpNBF
 JYFX5Rgt4u8yRoMK319m1kdv9Sdjpl6j4tEHliQumj4XH9NgjzELinegbQJqF9miB+wEwlKnhkI
 NHmqD4ekzBg2HE/QndKfs0vSnrkcanTBVnY5hO7VGw10m3cOrFJrT1VxyuPFNt5Wnl8w7E5CEUt
 wcVSpnwEyRZFH6vNbpX0MX2cZ7Ox3HLoTxOqDW6SmT9tcQr19VDkpN9YS2deeO/LuvJi4r7R4O5
 K+nmCZ707pThg3+Qc/py76bSbUI7Yg==
X-Authority-Analysis: v=2.4 cv=GrpPO01C c=1 sm=1 tr=0 ts=693c9baa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=4X85NrQx50rkFQG2anEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_06,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512120184

On Tue, Dec 9, 2025 at 6:23=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Implement AArch64-specific KCFI backend.
>
> - Trap debugging through ESR (Exception Syndrome Register) encoding
>   in BRK instruction immediate values.
>
> - Scratch register allocation using w16/w17 (x16/x17) following
>   AArch64 procedure call standard for intra-procedure-call registers,
>   which already makes x16/x17 available through existing clobbers.
>
>   Note that BTI uses x16/x17 AT the call site, and KCFI uses w16/w17
>   BEFORE the call (for the type hash comparison). These don't conflict
>   because:
>   - KCFI clobbers w16/w17 with hash values.
>   - Then the actual call happens via blr %target_reg (whatever
>     register the target is in).
>   - If SLS hardening is enabled, aarch64_indirect_call_asm will
>     create a thunk that moves target into x16 and does br x16.
>   - By the time the SLS thunk uses x16, KCFI is already done with it.
>
> - Does not interfere with SME, which uses attributes not function
>   prototypes for distinguishing functions.
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

From an aarch64 point of view this is ok (except for a few minor
things [see below in the patch itself] which can be bundled up with
the fixes for the review of the middle-end parts and don't need an
extra approval).


The only open question with the aarch64 side of things (and other
targets) is how to represent the kfci calls, should there be wrapping
or not.
Right now I am ok with the wrapping but I am not a fan of it because
it introduces complexity to the call patterns. It is definitely
something that should be looked into but I am not going to block this
set of patches for it.
And using define_subst/define_subst_attr if we decide to stay with the
wrapping with the kfci rtl, is something to look into but that can
wait too.


>
> gcc/testsuite/ChangeLog:
>
>         * gcc.dg/kcfi/kcfi-aarch64-ilp32.c: New test.
>         * gcc.dg/kcfi/kcfi-adjacency.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-basics.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-call-sharing.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-complex-addressing.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-move-preservation.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-no-sanitize.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-offset-validation.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-large.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-medium.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-tail-calls.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-trap-section.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-trap-encoding.c: New test.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/config/aarch64/aarch64-protos.h           |  4 +
>  gcc/config/aarch64/aarch64.md                 | 56 +++++++++++
>  gcc/config/aarch64/aarch64.cc                 | 93 +++++++++++++++++++
>  gcc/doc/invoke.texi                           | 14 +++
>  .../gcc.dg/kcfi/kcfi-aarch64-ilp32.c          |  7 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    | 15 +++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       | 21 +++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  4 +
>  .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 16 ++++
>  .../gcc.dg/kcfi/kcfi-move-preservation.c      | 20 ++++
>  .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |  5 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  1 +
>  .../gcc.dg/kcfi/kcfi-offset-validation.c      |  3 +
>  .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   | 12 +++
>  .../gcc.dg/kcfi/kcfi-patchable-large.c        | 12 +++
>  .../gcc.dg/kcfi/kcfi-patchable-medium.c       | 12 +++
>  .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  | 12 +++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 19 ++++
>  .../gcc.dg/kcfi/kcfi-trap-encoding.c          | 41 ++++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  4 +
>  20 files changed, 371 insertions(+)
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-ilp32.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
>
> diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aar=
ch64-protos.h
> index da1d734a689f..6e5eeb203e28 100644
> --- a/gcc/config/aarch64/aarch64-protos.h
> +++ b/gcc/config/aarch64/aarch64-protos.h
> @@ -1296,4 +1296,8 @@ extern unsigned aarch64_stack_alignment (const_tree=
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
> diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.m=
d
> index 8beeefca65ee..5c0ec73d79cd 100644
> --- a/gcc/config/aarch64/aarch64.md
> +++ b/gcc/config/aarch64/aarch64.md
> @@ -1509,6 +1509,19 @@
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
> @@ -1536,6 +1549,21 @@
>    }"
>  )
>
> +;; KCFI call with return value
> +(define_insn "*call_value_insn"
> +  [(set (match_operand 0 "" "")
> +       (kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operan=
d"
> +                            "Ucr"))
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
> @@ -1576,6 +1604,19 @@
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
> @@ -1591,6 +1632,21 @@
>     (set_attr "sls_length" "retbr,none")]
>  )
>
> +;; KCFI sibling call with return value
> +(define_insn "*sibcall_value_insn"
> +  [(set (match_operand 0 "")
> +       (kcfi (call (mem:DI (match_operand:DI 1 "aarch64_call_insn_operan=
d"
> +                            "Ucs"))
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
> diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.c=
c
> index 0ef22e8e52c8..89c6c60c91ff 100644
> --- a/gcc/config/aarch64/aarch64.cc
> +++ b/gcc/config/aarch64/aarch64.cc
> @@ -98,6 +98,7 @@
>  #include "ipa-cp.h"
>  #include "ipa-prop.h"
>  #include "ipa-fnsummary.h"
> +#include "kcfi.h"
>  #include "hash-map.h"
>  #include "aarch64-sched-dispatch.h"
>  #include "aarch64-json-tunings-printer.h"
> @@ -12069,6 +12070,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx co=
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
> @@ -33329,6 +33340,88 @@ aarch64_libgcc_floating_mode_supported_p
>  #undef TARGET_DOCUMENTATION_NAME
>  #define TARGET_DOCUMENTATION_NAME "AArch64"
>
> +/* Output the assembly for a KCFI checked call instruction.  INSN is the
> +   RTL instruction being processed.  OPERANDS is the array of RTL operan=
ds
> +   where operands[0] is the call target register, operands[3] is the KCF=
I
> +   type ID constant.  Returns the appropriate call instruction string.  =
*/
> +
> +const char *
> +aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> +{
> +  /* Target register is operands[0].  */
> +  rtx target_reg =3D operands[0];
> +  gcc_assert (REG_P (target_reg));
> +
> +  /* Get KCFI type ID from operand[3].  */
> +  uint32_t type_id =3D (uint32_t) INTVAL (operands[3]);

Use UINTVAL .

> +
> +  /* Calculate typeid offset from call target.  */
> +  HOST_WIDE_INT offset =3D -kcfi_get_typeid_offset ();
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
> +  /* Load actual type into w16 from memory at offset using ldur.  */
> +  rtx temp_operands[2];
> +  temp_operands[0] =3D target_reg;
> +  temp_operands[1] =3D GEN_INT (offset);
> +  output_asm_insn ("ldur\tw16, [%0, #%1]", temp_operands);
> +
> +  /* Load expected type into w17 using mov/movk sequence.  */
> +  fprintf (asm_out_file, "\tmov\tw17, #%u\n", type_id & 0xFFFF);
> +  fprintf (asm_out_file, "\tmovk\tw17, #%u, lsl #16\n", (type_id >> 16) =
& 0xFFFF);
> +
> +  /* Compare types.  */
> +  fprintf (asm_out_file, "\tcmp\tw16, w17\n");
> +
> +  /* Output conditional branch to call label.  */
> +  fputs ("\tb.eq\t", asm_out_file);
> +  assemble_name (asm_out_file, call_name);
> +  fputc ('\n', asm_out_file);
> +
> +  /* Output trap label and BRK instruction.  */
> +  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
> +
> +  /* Calculate and emit BRK with ESR encoding.  */
> +  unsigned type_index =3D R17_REGNUM;
> +  unsigned addr_index =3D REGNO (target_reg) - R0_REGNUM;
> +  unsigned esr_value =3D 0x8000 | ((type_index & 31) << 5) | (addr_index=
 & 31);
> +
> +  fprintf (asm_out_file, "\tbrk\t#%u\n", esr_value);

It might be useful to print the hex instead of the decimal here.
Either way is ok.

> +
> +  /* Output call label.  */
> +  ASM_OUTPUT_LABEL (asm_out_file, call_name);
> +
> +  /* Return appropriate call instruction based on SIBLING_CALL_P.  */
> +  if (SIBLING_CALL_P (insn))
> +    return aarch64_indirect_branch_asm (target_reg);
> +  else
> +    return aarch64_indirect_call_asm (target_reg);
> +}
> +
> +/* Return true if the target supports KCFI.
> +   KCFI is not supported for ILP32 due to pointer size requirements.  */
> +
> +static bool
> +aarch64_kcfi_supported_p (void)
> +{
> +  if (TARGET_ILP32)
> +    {
> +      error ("%<-fsanitize=3Dkcfi%> is not supported for %<-mabi=3Dilp32=
%>");
> +      return false;
> +    }
> +  return true;
> +}
> +
> +#undef TARGET_KCFI_SUPPORTED
> +#define TARGET_KCFI_SUPPORTED aarch64_kcfi_supported_p
> +
>  struct gcc_target targetm =3D TARGET_INITIALIZER;
>
>  #include "gt-aarch64.h"
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index e7443b10b754..d93e6b4bb3f4 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -18761,6 +18761,20 @@ header MOVri instruction would become something =
like this:
>
>  @code{movl    $199571451, %ebx # hash of foo's type =3D 0xBE537FB}
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
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-ilp32.c b/gcc/testsui=
te/gcc.dg/kcfi/kcfi-aarch64-ilp32.c
> new file mode 100644
> index 000000000000..aff560020c7e
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-ilp32.c
> @@ -0,0 +1,7 @@
> +/* Test that KCFI is rejected for AArch64 ILP32.  */
> +/* { dg-do compile { target aarch64*-*-* } } */
> +/* { dg-additional-options "-mabi=3Dilp32 -Wno-deprecated" } */
> +/* { dg-error ".-fsanitize=3Dkcfi. is not supported for .-mabi=3Dilp32."=
 "" { target *-*-* } 0 } */
> +/* { dg-message "sorry, unimplemented: .-fsanitize=3Dkcfi. not supported=
" "" { target *-*-* } 0 } */
> +
> +void foo (void) { }
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/g=
cc.dg/kcfi/kcfi-adjacency.c
> index 7c59921e630c..f3d7d23e6af2 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> @@ -63,4 +63,19 @@ __attribute__((noinline)) void test_conditional_call(i=
nt flag) {
>  ** ...
>  */
>
> +/*
> +** test_complex_args: { target aarch64*-*-* }
> +** ...
> +** ldur        w16, \[(x[0-9]+), #-4\]
> +** mov w17, #[0-9]+
> +** movk        w17, #[0-9]+, lsl #16
> +** cmp w16, w17
> +** b.eq        .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap[0-9]+:
> +** brk #[0-9]+
> +** .Lkcfi_call\2:
> +** br  \1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.=
dg/kcfi/kcfi-basics.c
> index fe0a21d26df9..6eac946f7abf 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
> @@ -59,6 +59,9 @@ int main() {
>  /* x86_64: Verify type ID in preamble (after NOPs, before function label=
) */
>  /* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+=
movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
>
> +/* AArch64: Verify type ID word in preamble.  */
> +/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-=
9a-f]+} { target aarch64*-*-* } } } */
> +
>  /*
>  ** static_caller: { target x86_64-*-* }
>  ** ...
> @@ -76,6 +79,21 @@ int main() {
>  ** ...
>  */
>
> +/*
> +** static_caller: { target aarch64*-*-* }
> +** ...
> +** ldur        w16, \[(x[0-9]+), #-4\]
> +** mov w17, #[0-9]+
> +** movk        w17, #[0-9]+, lsl #16
> +** cmp w16, w17
> +** b.eq        .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap[0-9]+:
> +** brk #[0-9]+
> +** .Lkcfi_call\2:
> +** blr \1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
>
>  /* Extern functions should NOT get KCFI preambles.  */
> @@ -93,3 +111,6 @@ int main() {
>  /* External functions that are only called directly should NOT get
>     __kcfi_typeid_ symbols.  */
>  /* { dg-final { scan-assembler-not {__kcfi_typeid_external_func_int} } }=
 */
> +
> +/* AArch64 should NOT have trap section (use immediate instructions inst=
ead).  */
> +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* =
} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuit=
e/gcc.dg/kcfi/kcfi-call-sharing.c
> index 05165f0e2851..6062d74ef62a 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
> @@ -63,14 +63,18 @@ int test_kcfi_check_sharing(struct kobject *kobj, con=
st struct attribute_group *
>  /* Verify we have TWO different KCFI check sequences.  */
>  /* Each check should have different type ID constants.  */
>  /* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2=
 { target i?86-*-* x86_64-*-* } } } */
> +/* AArch64: { dg-final { scan-assembler-times {mov\s+w17, #[0-9]+} 2 { t=
arget aarch64*-*-* } } } */
>
>  /* Verify the checks use DIFFERENT type IDs (not shared).
>     We should NOT see the same type ID used twice - that would indicate
>     unmerged sharing.  */
>  /* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*m=
ovl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
> +/* AArch64: { dg-final { scan-assembler-not {mov\s+w17, #([0-9]+).*mov\s=
+w17, #\1} { target aarch64*-*-* } } } */
>
>  /* Verify expected number of traps.  */
>  /* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_=
64-*-* } } } */
> +/* AArch64: { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target=
 aarch64*-*-* } } } */
>
>  /* Verify 2 separate call sites.  */
>  /* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { targe=
t i?86-*-* x86_64-*-* } } } */
> +/* AArch64: { dg-final { scan-assembler-times {br\tx[0-9]+} 2 { target a=
arch64*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/te=
stsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> index ed415033c5c9..3ffbd408a69e 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> @@ -146,4 +146,20 @@ int main() {
>  ** ...
>  */
>
> +/* Standard KCFI handling.  */
> +/*
> +** main: { target aarch64*-*-* }
> +** ...
> +** ldur        w16, \[(x[0-9]+), #-4\]
> +** mov w17, #[0-9]+
> +** movk        w17, #[0-9]+, lsl #16
> +** cmp w16, w17
> +** b.eq        .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap[0-9]+:
> +** brk #[0-9]+
> +** .Lkcfi_call\2:
> +** blr \1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/tes=
tsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> index 5553ff47174b..df39b7f0a8a3 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> @@ -57,4 +57,24 @@ int main(void)
>  ** ...
>  */
>
> +/*
> +** indirect_call: { target aarch64*-*-* }
> +** ...
> +** mov (x[0-9]+), x0
> +** ...
> +** ldur        w16, \[\1, #-4\]
> +** mov w17, #[0-9]+
> +** movk        w17, #[0-9]+, lsl #16
> +** cmp w16, w17
> +** b.eq        .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap[0-9]+:
> +** brk #[0-9]+
> +** .Lkcfi_call\2:
> +** br  \1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
> +
> +/* AArch64 should NOT have trap section (use immediate instructions inst=
ead).  */
> +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* =
} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/te=
stsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> index 9ed7e21fe8eb..cdeb202ffd12 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> @@ -75,11 +75,16 @@ int main(void)
>
>  /* Verify correct number of KCFI checks: exactly 2 */
>  /* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } *=
/
> +/* { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*=
-*-* } } } */
>
>  /* Positive controls: these should have KCFI checks.  */
>  /* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_f=
unction} { target x86_64-*-* } } } */
>  /* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_=
normal_inline} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {normal_function:.*brk\s+#[0-9]+.*\.size\=
s+normal_function} { target aarch64*-*-* } } } */
> +/* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#[0-9]+.*\.si=
ze\s+wrap_normal_inline} { target aarch64*-*-* } } } */
>
>  /* Negative controls: these should NOT have KCFI checks.  */
>  /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.=
*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
>  /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\=
s+wrap_sensitive_inline} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*brk\=
s+#[0-9]+.*\.size\s+sensitive_non_inline_function} { target aarch64*-*-* } =
} } */
> +/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#[0-9]=
+.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite=
/gcc.dg/kcfi/kcfi-no-sanitize.c
> index 95a8e8419e00..af6d86803576 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
> @@ -34,3 +34,4 @@ int main() {
>     caller_no_checks() should NOT generate KCFI check (no_sanitize).
>     So a total of exactly 1 KCFI check in the entire program.  */
>  /* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 {=
 target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 1 { t=
arget aarch64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/tes=
tsuite/gcc.dg/kcfi/kcfi-offset-validation.c
> index 97d964feebd3..0ced5c43ae92 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
> @@ -27,3 +27,6 @@ int main() {
>  /* x86_64: All call sites should use -4 offset for KCFI type ID loads, e=
ven
>     with -falign-functions=3D16 (we're not using patchable entries here).=
  */
>  /* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[=
a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
> +
> +/* AArch64: All call sites should use -4 offset.  */
> +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aa=
rch64*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/=
testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
> index 379356385a16..7a251cbdee3b 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
> @@ -28,6 +28,11 @@ int main() {
>  ** movl        \$0x[0-9a-f]+, %eax
>  */
>
> +/*
> +** __cfi_test_function: { target aarch64*-*-* }
> +** .word       0x[0-9a-f]+
> +*/
> +
>  /*
>  ** main: { target x86_64-*-* }
>  ** ...
> @@ -35,4 +40,11 @@ int main() {
>  ** ...
>  */
>
> +/*
> +** main: { target aarch64*-*-* }
> +** ...
> +** ldur        w16, \[x[0-9]+, #-4\]
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.wor=
d} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/tests=
uite/gcc.dg/kcfi/kcfi-patchable-large.c
> index 06df3495bb23..3ed5d16c8e91 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
> @@ -17,6 +17,11 @@ int main() {
>  ** movl        \$0x[0-9a-f]+, %eax
>  */
>
> +/*
> +** __cfi_test_function: { target aarch64*-*-* }
> +** .word       0x[0-9a-f]+
> +*/
> +
>  /*
>  ** main: { target x86_64-*-* }
>  ** ...
> @@ -24,4 +29,11 @@ int main() {
>  ** ...
>  */
>
> +/*
> +** main: { target aarch64*-*-* }
> +** ...
> +** ldur        w16, \[x[0-9]+, #-48\]
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.wor=
d} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/test=
suite/gcc.dg/kcfi/kcfi-patchable-medium.c
> index ef87b135934b..e354914209e9 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
> @@ -24,6 +24,11 @@ int main() {
>  ** movl        \$0x[0-9a-f]+, %eax
>  */
>
> +/*
> +** __cfi_test_function: { target aarch64*-*-* }
> +** .word       0x[0-9a-f]+
> +*/
> +
>  /*
>  ** main: { target x86_64-*-* }
>  ** ...
> @@ -31,4 +36,11 @@ int main() {
>  ** ...
>  */
>
> +/*
> +** main: { target aarch64*-*-* }
> +** ...
> +** ldur        w16, \[x[0-9]+, #-20\]
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.wor=
d} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc=
/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
> index 872814aa4171..7a1dc4fa0e07 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
> @@ -25,6 +25,11 @@ int main() {
>  ** movl        \$0x[0-9a-f]+, %eax
>  */
>
> +/*
> +** __cfi_test_function: { target aarch64*-*-* }
> +** .word       0x[0-9a-f]+
> +*/
> +
>  /*
>  ** main: { target x86_64-*-* }
>  ** ...
> @@ -32,4 +37,11 @@ int main() {
>  ** ...
>  */
>
> +/*
> +** main: { target aarch64*-*-* }
> +** ...
> +** ldur        w16, \[x[0-9]+, #-16\]
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.wor=
d} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/=
gcc.dg/kcfi/kcfi-tail-calls.c
> index 04a9eb1fd206..1a7cc4aa167f 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
> @@ -78,3 +78,22 @@ int test_non_tail_indirect_call(func_ptr_t handler, in=
t x) {
>
>  /* Should have exactly 1 regular call (non-tail call case).  */
>  /* { dg-final { scan-assembler-times {call\t\*%[a-z0-9]+} 1 { target x86=
_64-*-* } } } */
> +
> +/* Should have exactly 4 KCFI checks for indirect calls (load type ID fr=
om
> +   -4 offset + compare).  */
> +/* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 4 { t=
arget aarch64-*-* } } } */
> +/* { dg-final { scan-assembler-times {cmp\tw16, w17} 4 { target aarch64-=
*-* } } } */
> +
> +/* Should have exactly 4 trap instructions.  */
> +/* { dg-final { scan-assembler-times {brk\t#[0-9]+} 4 { target aarch64-*=
-* } } } */
> +
> +/* Should have exactly 3 protected tail calls (br through register after
> +   KCFI check).  */
> +/* { dg-final { scan-assembler-times {br\tx[0-9]+} 3 { target aarch64-*-=
* } } } */
> +
> +/* Should have exactly 1 regular call (non-tail call case).  */
> +/* { dg-final { scan-assembler-times {blr\tx[0-9]+} 1 { target aarch64-*=
-* } } } */
> +
> +/* Type ID loading should use mov + movk pattern for 32-bit constants.  =
*/
> +/* { dg-final { scan-assembler {mov\tw17, #[0-9]+} { target aarch64-*-* =
} } } */
> +/* { dg-final { scan-assembler {movk\tw17, #[0-9]+, lsl #16} { target aa=
rch64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c b/gcc/testsui=
te/gcc.dg/kcfi/kcfi-trap-encoding.c
> new file mode 100644
> index 000000000000..0c257565c9e8
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
> @@ -0,0 +1,41 @@
> +/* Test AArch64 and ARM32 KCFI trap encoding in BRK/UDF instructions.  *=
/
> +/* { dg-do compile { target aarch64*-*-* } } */
> +
> +void target_function(int x, char y) {
> +}
> +
> +int main() {
> +    void (*func_ptr)(int, char) =3D target_function;
> +
> +    /* This should generate trap with immediate encoding.  */
> +    func_ptr(42, 'a');
> +
> +    return 0;
> +}
> +
> +/* Should have KCFI preamble.  */
> +/* { dg-final { scan-assembler "__cfi_target_function:" } } */
> +
> +/* AArch64 specific: Should have BRK instruction with proper ESR encodin=
g
> +   ESR format: 0x8000 | ((type_reg & 31) << 5) | (addr_reg & 31)
> +
> +   Test the ESR encoding by checking for the expected value.
> +   Since we know this test uses x2, we expect ESR =3D 0x8000 | (17<<5) |=
 2 =3D 33314
> +   */
> +
> +/*
> +** main: { target aarch64*-*-* }
> +** ...
> +** ldur        w16, \[x[0-9]+, #-4\]
> +** mov w17, #[0-9]+
> +** movk        w17, #[0-9]+, lsl #16
> +** cmp w16, w17
> +** b\.eq       .Lkcfi_call[0-9]+
> +** .Lkcfi_trap[0-9]+:
> +** brk #33314
> +** .Lkcfi_call[0-9]+:
> +** blr x2
> +** ...
> +*/
> +
> +/* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuit=
e/gcc.dg/kcfi/kcfi-trap-section.c
> index 55c0829ccd7b..e92873e51321 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
> @@ -18,6 +18,10 @@ int main() {
>
>  /* Should have exactly 2 trap labels in code.  */
>  /* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_=
64-*-* } } } */
> +/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*brk} 2 { target aarc=
h64*-*-* } } } */
>
>  /* x86_64 should exactly 2 .kcfi_traps sections.  */
>  /* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@prog=
bits,\.text} 2 { target x86_64-*-* } } } */
> +
> +/* AArch64 should NOT have .kcfi_traps section.  */
> +/* { dg-final { scan-assembler-not {\.section\t+\.kcfi_traps} { target a=
arch64*-*-* } } } */
> --
> 2.34.1
>
