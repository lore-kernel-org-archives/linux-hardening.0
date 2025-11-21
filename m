Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300F2D73A1
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695732; cv=none; b=rzPH+iX4CAEP6iTlPJOjSQVJrs/PZGI2Cox9zC1Oy91mNzlEERfPHzVcbvVvb9Q/oxgezjckP3K3zhMJ/ITNlgJinwF32IGwqRyhifoNKHN7ibvHS7hStA00AH7Ft5W72GRiQEFG8HrawbLkzPOoy0aDbR5aMHznv8tkWgUndFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695732; c=relaxed/simple;
	bh=1fwl13BAvNUs6Navy5GQgY+OA2AbT3tB40iUKtEQh5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPZWAXk7i+zvDqEIXFI0vihvfgdWFGiWY72SlfU3fW/LedNxu0hrcLYiyumZrRZrJR7NWFIabvFH7Y6581z1hbLiVdJMoth1lGEhmc5YYYOwZ4/5ocnpFOmci4hqADu8xG9W6hKHpztywVVOIN03/AvZZ6RubarSyKmAEHqMj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QMKLlyDU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KIBNrtDw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QMKLlyDU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KIBNrtDw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKKBKfF1830845
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 03:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	49XbE083MSqwBXZZ/lflYPVfMxEMREritrwgSI8IU4o=; b=QMKLlyDUqD0ba3cY
	b2Gj/JiE3yz22HtcSyaPDHAPT/I2aRKdfnVdQwCxY2+D94sV70N+YcB0wW9Rwlv4
	sapsp7J+FWGP7DrB/UTTF0s0QNmX98ncvgn6NwM7DGJzpO7vwAHDdISawzki14kh
	qW1K5cyzpfPFv0WeGgXtvjuQIMSKtdwBzB/l+eJoRpnMal5WoqxcqLkUEj2vYQDJ
	M9hUDveoro/94IqNonDkn1yl6pLa/ffJNrmssT6c1xAHHxs6eE4kIO88VXLsxJoK
	cv5WXoPbiYC2/U5UgwppHqBj0pJhoIHlmJ79nc/fMF14pKVJuTBgV5GXEiXbjEH3
	O83S7g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aj0kw2ye7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 03:28:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2a45fea6efbso1642995eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 19:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763695726; x=1764300526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49XbE083MSqwBXZZ/lflYPVfMxEMREritrwgSI8IU4o=;
        b=KIBNrtDw1XW85c1FaSNQ532cvfHtR1p8wTAPnNBjzqj7CN+2S7CvXxa+wXF5HluTet
         hQc8SqkLdCd0flSVPklb6UhOVE10G8PiZUOphdrOnHq5Th7UdlmkLhvx24RXIaOROjaB
         Ezp9fHZ/JRkTHLclQ+V1Gc7xPDUl3KgIDMxFpK7fQV61DRRhTKeMpLmmHNsLNhTTR8F9
         PsDYvW1N+vUEqEEDj/Wo4MSPDu2WnMNralWbPeDPuzJaiMGmsV3VhYN2TYTtS1TtVvWE
         UTnQBOK4ZywiF2cDGykESue3Q156V+wMVJ8FfKQC/IhdIN6EgKA/QKznxUCvOnrLhMQf
         SUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763695726; x=1764300526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49XbE083MSqwBXZZ/lflYPVfMxEMREritrwgSI8IU4o=;
        b=QBD6gnvYCfGN6JmWHuZ1Lz5MMZI7UfPBuNq7Hx9nvDrtgeLxoCpDCHtZFEaMo3DHp3
         ljr3foZHSBJWgMUkO0L14+6CrTOtw7Wn3kMXq/Ky4BQm45wsc8rBP+y+Rk3gKe2DL54e
         PFxw1ce/ZEfeD1jHIE3+gD8/w7Z/yqBhNkFQoXMcwH2SzFALA7zUrgYBBaTMIcBYRiX6
         1t+NhpQWYXb43XObwHv3eracTPh8GALa4G/UzFM/EICua7Qo3oOzpd/P+wrWoefeWuFd
         i3TqvNMgDbpQLtNfC4M1w3QqqvZqTExinEydoP1wdhHLdQEv4WIr5eahqLCqjDD9D+Jx
         GQfg==
X-Forwarded-Encrypted: i=1; AJvYcCUrgFBRJTIYbdwQ2JX+DGQw5jrM4sCEIo5AIZxxvq1FztAo4MD2AN20vjFCRWqIcnu5OJqGueWIHcxyeX3+9uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnzjpndhEK7jOH/1I6xvQSt/pwgme/fI9iFOv7YkeBMvUM439L
	ENWjfyGhWmZJDaZAKKL4gQWm6fP45JsRtCTeFiKIOkBZXGUHfvITPGejPGEIZSk/THNeBON7y5m
	2ykjyaSCGtsRUn1PaYmU18VeCYHbbVARRBI3qlkFjsAYDEKQQ48Oakf9g2OeRdnhdpj/dRQJyOw
	HfLAiktH9PnRe2QKl9eESk8eXwk72X3s/ATDP1rmrQoH9Fng==
X-Gm-Gg: ASbGncvTSTT5cBAT4M+M/CBcTLSWMlT9ipW9+EFe11r+srmMxWy5+mR/+jDi58yyLGG
	LzOfYeqMJKhOHv8kRTjhsX3kmC+G7+mMuAjU2JL4/dFy+1ftDthfsC2hqL61OcpBXx4xE+9RtZ9
	9fEExJbKJWL0wpXscYlZaGbtlIg19K48YYkoQGkRLJUCgH2BvOBGGFLwZPSrErErjm
X-Received: by 2002:a05:7301:eab:b0:2a4:3593:ccc3 with SMTP id 5a478bee46e88-2a718665965mr375345eec.10.1763695725983;
        Thu, 20 Nov 2025 19:28:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/TdZEXZpvJFgO2faNntJNlradVIy6JwQh9j0M1b9zMVf3xw1Vh4iMYIHd6jaInQL9F/iSySWJgDD6KCoeYPY=
X-Received: by 2002:a05:7301:eab:b0:2a4:3593:ccc3 with SMTP id
 5a478bee46e88-2a718665965mr375325eec.10.1763695725231; Thu, 20 Nov 2025
 19:28:45 -0800 (PST)
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
Date: Thu, 20 Nov 2025 19:28:33 -0800
X-Gm-Features: AWmQ_bm5SlZjKTdK7fyHmhUIT2OCcWSa4sOEqhadmHTJ6OcfVXqnE1yn0p_8-aM
Message-ID: <CALvbMcA88JLUMf=2CW1S5yRcYeK1ynVa1LWVcOH=fzTeaj5HTg@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=WeUBqkhX c=1 sm=1 tr=0 ts=691fdc6f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=3Psi1EWd8GytgK1G_NEA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: lqVVm1_-e0SOTfFsdtpv8b8u_aViMUtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDAyNSBTYWx0ZWRfX/bz9YCBCI1y5
 wryF8ZbtGBCWBcAJogcKDM0tYmBEWeEZ45CzGeopA8+cGcUwOm/WQWeYMvlmWIuTuslY+b/Po+u
 uLxGxAhZIw870qYLR7vcCCMBZME9SjsDke9yeBJZzb6vEb3XxtVX9jEmbuhhZfwGgG9oXW6R4Ao
 o2WSYY4hVMd/JkgJT1/g7gEDOvcbfpqByLovPOOKgQdwXH8biz8EvDab9kwWpASZfmzsen+Vx6z
 90SfIWyR+LbMiPCfukwK5bQq6++Smabhxtmf0ZWLjI2WP7U1zIyt8UmlxzGNbe9hYaz0gOgwi9Q
 FPn5NnV7IqtR0nx1sqK3XTzSJwjJkhqAqxLLlDN12c2wnkWxaZnr/mwvJ0mP0eMWTRZLbPETA52
 JcFJo4spPcda/ivTyg9yMp8GUHUkXg==
X-Proofpoint-ORIG-GUID: lqVVm1_-e0SOTfFsdtpv8b8u_aViMUtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_01,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210025

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

I have not checked which one is called first
aarch64_override_options_internal or the hook. It might be that both
are needed depending on the order.
That is `-mabi=3Dilp32 -fsanitize=3Dkfci` vs `-fsanitize=3Dkfci -mabi=3Dilp=
32
`. If it might be the case that you only need the hook. It is not
valid to change the ABI at function level.
What I Mean is you could define something like:
```
static bool
aarch64_kcfi_supported_p (void)
{
  return !TARGET_ILP32;
}
```
And not need the error message in override_options.

Note, I think the error/sorry message is incorrect too:
sorry ("%<-fsanitize=3Dkcfi%> not supported by this target");
More likely should be `error ("%<-fsanitize=3Dkcfi%> not supported by
this configuration");`
And then unset SANITIZE_KCFI from flag_sanitize.

`Sorry` is incorrect here I think. `error` is more friendly.

Thanks,
Andrew


>
> Thanks for the review! I'll do more fixing. :)
>
> -Kees
>
> --
> Kees Cook
