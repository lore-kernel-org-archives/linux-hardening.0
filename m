Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9031F981
	for <linux-hardening@vger.kernel.org>; Sat, 27 Jun 2026 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782601222; cv=pass; b=L1YG7z2MPZCxkA4ZPkXTrROHA6EgJ84DNkoI29JUd1wh5n9QW/QMN4lCQgWweMpGr1HeGsWFKVcDapQlCXmYuuXFffwMZlY0BfoMPjGGTtySp0eXj2w/Q0+bqqCmsJsZ0qndB7VuFpvG3BDN/7WGDVJvADIbgkG7Lo9pLl6CfHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782601222; c=relaxed/simple;
	bh=5B8bmfXjXPzDC0FBSdSiZoyNxS82LLLCn+CGkZ+Dh1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Noc+8IF/1ObzDlNl9q5kLhayLU5ILlaROqjad/mNU/eJXnJWyK0ifEdCbSqETRfaze0Wfrli/AppyS/bp+l8vodR84vREOfJ7zFu3c3ua375CZqsn/B7yUDtuUAqzDHgGGfpK+kY6Wol9JpUI4/urLw+vsPIMLNpeMsxjHoK1AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=da+ZomjC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+6mzBfl; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="da+ZomjC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+6mzBfl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65RLI98t2133217
	for <linux-hardening@vger.kernel.org>; Sat, 27 Jun 2026 23:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZsyVAYO8tSjoNq91x685FB0D24bPzXh3i7rtnDObFOY=; b=da+ZomjCT0esCf21
	bDqGbl8fFaaNAN7CT6l2CnoFMXUWVc6CIgwfugNBEcsbEnUDT+NRlhik+4FxMPBe
	tOcm6kzdOaE8iuwEYJPS8Z/trJors/rsBI/xBsd0QicgniuAKALStRmdRT+l0hB8
	ngPeSmAPe/vgflZZwq69jw4IuFVEtVjIXU83ubTj2sqLda6krLGgTNvfSN10qM2+
	xeXjXgtiv76tqozYQVxuA7pWNk2y3A8BCM3jM1LdaHXGLG3xemLS4Pa7J4znGz28
	mvOHOtj+YdnuyHfqZpUcODkTV7RB5W3weOUI7EV+T1/y9ninxmo+zayZPYAZgK8u
	aby5vQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf1qdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 27 Jun 2026 23:00:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0a27ad86so3611872eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 27 Jun 2026 16:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782601217; cv=none;
        d=google.com; s=arc-20260327;
        b=X8WvVpo7rAMt5XkPB9IQl4lUL5TohX2uFgbpNxwo1VjwCpohFbdajhW/eLdjCAKOV9
         rVyN3Ny509/vcdJuossvx7saEpAserXL7Pio+FTFqvkgTTnQBEocsg0cfTwUMG7EwGX2
         id9rWMRIpxJV8z6V++naYV681ZsrZdp36YE4S9ngY2CVJZrNkzy58/rSl/yLf38STFOz
         dFOSkIhz1xjffDMDRySAG/RzeENG6fNNRMq3zwwlv7zc4lifWk8cd6wG4qZ1DGGid5Mn
         jrzoL+Z9jRJ7LAKedGvPiNK/zzKrLbonk7vsWM9S4UYDsNpdkIYbXnSD4SiJimM1nM/S
         DaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZsyVAYO8tSjoNq91x685FB0D24bPzXh3i7rtnDObFOY=;
        fh=D9+u3Un35uEHdxh/CyOC96lYLq401KoZqQsYlO9gjY0=;
        b=PA+S3hPKLmmtkg171dl7+YgHhabqvuoTog2FTIm4/ciTU04hEUFJ72uQ2ZFilZvjkP
         pQAEzhDDk7y3Go08ZafWRiUls60yTSVxvGtC5zcmsCm5bDDcfudQ6HnriYMKp7xUEOSe
         /+F6sUbEM5nj63uX2K2dftrC2Tyhs08IHr5vJDnczve1jiG0b+JyLX1eqdZHk9204Sz3
         S7aReZEJJONv9uKVXoendnXtmdp2ahzpSOKBG0qx6I/MDMzx7UYRqRjFRXqTzgfzVvpN
         lN20UEF3NAQqofXUTV0IrtiK9EzkhKi8ogqzPMkuzVXYF96zjg5T+YaBuRhokZhhfv3k
         NYqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782601217; x=1783206017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsyVAYO8tSjoNq91x685FB0D24bPzXh3i7rtnDObFOY=;
        b=f+6mzBflASNYOyu0W0rVkid5yZL7MAusM/vTtYTe7wB20K362OAB9A/tuFNPdO5oH+
         qtCMCoad7jsGOl0TOP60pKxENr0Pb377Z4Jsd18QBzWOg1+Us9byGlDmJ0IicLJizwhM
         6BVGZoLqLPWpwpKTI/0TePSLo1/f3+57JwXigJkEqNXqn/88Si0aFdFawDac/gQ4+pso
         qa6kujFcJzDHiqP+VTU3kxxExChLvRSxOAa0fw00clGSjvyvFLNQj2pfMkLSqgukbyCZ
         Qp/oxAJ+HhWcnIEJq82FyCAiXrKL7jzlBvJsiYf99ZSPnP+NDujdDrB9yOPmCp6nSKEA
         Omeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782601217; x=1783206017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZsyVAYO8tSjoNq91x685FB0D24bPzXh3i7rtnDObFOY=;
        b=Eazz9lvX27180FM6bpfnqqikQp6cn0Mnst7++FPLLH1IDwyaI3AC0Eg98yaxVA2vS7
         R2flJhqbcX197/kxmEpgAiams2k2+3xoa8oooIL4x9GjYW/9g4iciDB9EBlW0C61/tMa
         CxJRY2QbHAyKNm8A+/kMrWZRbXw/bIW4GGsYJFu4gzCUX9EQoIreGaDhHasIceahQKaw
         fTrXpmddD+6Z85+04VT8Fa11RP+A/MSWUWzIDh2GbgBPTtyFqzgE67sxKpeIweZbdQ94
         NaSGgkjp3KiwdrybDQ2HSYDhjRA57mtk2JpZ+dF5f296JHqSRsdMeQQbZf/7i7Jop3rK
         4V7Q==
X-Forwarded-Encrypted: i=1; AHgh+RoiGCnc28PUIsUwckBaTk9XfEZOqEeYTKgb9HUDDVbBOx4rMnI1kz19GChXVJ9RYa1SBsuh7UqX5UdWBKTirPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+Q+A/8YNeI1tQ4mUb8ZyAHsDv8ox2DbFQ40XPb1v1srD4KXZ
	cUJiJgHDwAOg9XaiH0Yqe4wiQ+7oD/PQAOWufaBCz613+Ys0dYuszWbZs3FAF6gjz+t3yl6hjTZ
	Bf/kyYsayM3wMI/7mWjWu1Jm3NM2q0nTlOkdh/vAOqkrzLZ4uT/FLSRzmNjXW2BsBYrrZtW6fxb
	dX5LzrgyNG4HLUsdll4cpqTc1rsEccbjtxN3/htCtd7jCGnA==
X-Gm-Gg: AfdE7cnwgySQttvkzm4s41v2MtryjyItyLjk9EMxB5MJklJHKqug3vC5c477m5KhfPv
	rZSvi28XXPclOpVkBDS3fV9miNO8WwZUhFS+2wW8KbLkauegxFWDugHbHmor+eji/h6rQAgsKWD
	yVrVtqTJIC7J1T7uPLCo3s9fu/EFhRlJv7ORJdujyYFaHMLai51gSWwIq8xVyazL39
X-Received: by 2002:a05:693c:8951:10b0:30c:a62b:d033 with SMTP id 5a478bee46e88-30ca62be4f9mr4467107eec.15.1782601216411;
        Sat, 27 Jun 2026 16:00:16 -0700 (PDT)
X-Received: by 2002:a05:693c:8951:10b0:30c:a62b:d033 with SMTP id
 5a478bee46e88-30ca62be4f9mr4467073eec.15.1782601215544; Sat, 27 Jun 2026
 16:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618204530.work.910-kees@kernel.org> <20260618204539.824446-5-kees@kernel.org>
In-Reply-To: <20260618204539.824446-5-kees@kernel.org>
From: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Date: Sat, 27 Jun 2026 16:00:04 -0700
X-Gm-Features: AVVi8CexlJnH-uJlZkfBTfh-X8FOUbCMSPUWN4md_sYIb-aUbbyLCSHBie6ZIkA
Message-ID: <CALvbMcDnK6iWkXbO7VbdBgeuym9yO6xNG8VE_RNQ8Nser0=TmA@mail.gmail.com>
Subject: Re: [PATCH v13 5/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
To: Kees Cook <kees@kernel.org>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>, Joseph Myers <josmyers@redhat.com>,
        Richard Biener <rguenther@suse.de>, Jeff Law <jeffreyalaw@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDIwNCBTYWx0ZWRfXwYHVkWHf+lCH
 5Vb0B22LDMOEcPQvRxhNIeY6I45mG16BYvTC4ZKBJus04AbiYpPVIEE/cKNgAp4Eue3QBQ9bi/V
 2lr+NuxySMF7rB7N7V4OE6nEVvMj7d4=
X-Proofpoint-GUID: kqSy-vkR4wmCRhxLU_Sz10jTuVj1J5El
X-Proofpoint-ORIG-GUID: kqSy-vkR4wmCRhxLU_Sz10jTuVj1J5El
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDIwNCBTYWx0ZWRfX1PMEH52fbuNr
 ZQs1H+inVynEii+hxvBIIf0+1gosSklzUpK3Cl65VYb2HGPcbseryPHG/b/A02blf+oKIjZltsh
 U10HLk1jbhsPV15auVWO/YDrb/LbJgjH4yII4HQPjCXmg3H4hbW9C8T53Xnb/OK6dEFFFhI+h1e
 kqNTQFCCry3WBFePHDge74x1LTXvdSnswKRRnQZDY4IOOYf83CnNA0S7pvNLuo0ecryKVyPpRVg
 ujw6RT6SkPs9qL6z6BSciNPbw50U00uyAlj4qVCGkh36zBQfuUaSYyfRG7/7rEkOdn3FdNH8bOu
 qNeDW3Cq6JgVh+e/+rbZC3EsUPdHy+iOBarOpjoJ3pqWtheViGeXWPfZeF8un6qpflU23LHObnB
 /E/kyvwEabEgvYmH5gPwEnC1mWIOqJ4aWRh9I5sLktjiW3BjbXyMI6vS4JOIuPlsaeyReYgYTWb
 zcieOCqfZkhngnuxIpQ==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a405601 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=RMCdRfIdQ23t-mW40EAA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270204

On Thu, Jun 18, 2026 at 1:45=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
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
> - Complementary with BTI (which uses a separate pass system to inject
>   landing instructions where needed).
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
>
> gcc/testsuite/ChangeLog:
>
>         * gcc.dg/kcfi/kcfi-adjacency.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-basics.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-call-sharing.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-complex-addressing.c: Add aarch64 patterns.
>         * gcc.dg/kcfi/kcfi-direct-call-shapes.c: Add aarch64 patterns.
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

Ok once all other prerequisites have been approved.

>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/config/aarch64/aarch64-protos.h           |   4 +
>  gcc/config/aarch64/aarch64.md                 |  56 ++++++++
>  gcc/config/aarch64/aarch64.cc                 | 127 ++++++++++++++++++
>  gcc/doc/invoke.texi                           |  14 ++
>  .../gcc.dg/kcfi/kcfi-aarch64-ilp32.c          |   7 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  20 +++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       |  21 +++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |   4 +
>  .../gcc.dg/kcfi/kcfi-complex-addressing.c     |  16 +++
>  .../gcc.dg/kcfi/kcfi-direct-call-shapes.c     |   3 +
>  .../gcc.dg/kcfi/kcfi-move-preservation.c      |  20 +++
>  .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     |   5 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |   1 +
>  .../gcc.dg/kcfi/kcfi-offset-validation.c      |   3 +
>  .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  12 ++
>  .../gcc.dg/kcfi/kcfi-patchable-large.c        |  12 ++
>  .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  12 ++
>  .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  12 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   |  21 +++
>  .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  42 ++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |   4 +
>  21 files changed, 416 insertions(+)
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-ilp32.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
>
> diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aar=
ch64-protos.h
> index 34e770db60c0..4d5b1537244d 100644
> --- a/gcc/config/aarch64/aarch64-protos.h
> +++ b/gcc/config/aarch64/aarch64-protos.h
> @@ -1313,4 +1313,8 @@ extern unsigned aarch64_stack_alignment (const_tree=
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
> index d8c8c73a6321..b55a607b6d7c 100644
> --- a/gcc/config/aarch64/aarch64.md
> +++ b/gcc/config/aarch64/aarch64.md
> @@ -1561,6 +1561,19 @@
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
> @@ -1588,6 +1601,21 @@
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
> @@ -1628,6 +1656,19 @@
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
> @@ -1643,6 +1684,21 @@
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
> index 08746b657746..9b4e2afd0be7 100644
> --- a/gcc/config/aarch64/aarch64.cc
> +++ b/gcc/config/aarch64/aarch64.cc
> @@ -98,6 +98,7 @@
>  #include "ipa-cp.h"
>  #include "ipa-prop.h"
>  #include "ipa-fnsummary.h"
> +#include "kcfi.h"
>  #include "hash-map.h"
>  #include "ifcvt.h"
>  #include "aarch64-sched-dispatch.h"
> @@ -12320,6 +12321,16 @@ aarch64_expand_call (rtx result, rtx mem, rtx co=
okie, bool sibcall)
>
>    call =3D gen_rtx_CALL (VOIDmode, mem, const0_rtx);
>
> +  /* Only indirect calls need KCFI instrumentation.  */
> +  bool is_direct_call =3D !REG_P (XEXP (mem, 0));
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
> @@ -34403,6 +34414,122 @@ aarch64_libgcc_floating_mode_supported_p
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
> +  uint32_t type_id =3D UINTVAL (operands[3]);
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
> +  /* Pick scratch registers that do not alias the call target.  The
> +     scratch defaults are w16 (actual type) and w17 (expected type), but
> +     for an indirect sibling call the target is itself constrained to
> +     x16/x17 (TAILCALL_ADDR_REGS).  Loading into a register that aliases
> +     the target would clobber it before the branch.  When the target is
> +     x16 or x17, keep the expected type in the other of the two and load
> +     the actual type into x9: a caller-saved temporary that is dead at
> +     the call point.  */
> +  unsigned tregno =3D REGNO (target_reg);
> +  unsigned actual_regno, expected_regno;
> +  if (tregno =3D=3D R16_REGNUM || tregno =3D=3D R17_REGNUM)
> +    {
> +      expected_regno =3D (tregno =3D=3D R16_REGNUM) ? R17_REGNUM : R16_R=
EGNUM;
> +      actual_regno =3D R9_REGNUM;
> +    }
> +  else
> +    {
> +      actual_regno =3D R16_REGNUM;
> +      expected_regno =3D R17_REGNUM;
> +    }
> +
> +  /* The scratch operands are the 32-bit type values, printed with the
> +     %w modifier (w-names); target_reg is Pmode and prints as the 64-bit
> +     base (x-name) in the load.  */
> +  rtx actual_reg =3D gen_rtx_REG (SImode, actual_regno);
> +  rtx expected_reg =3D gen_rtx_REG (SImode, expected_regno);
> +  rtx ops[3];
> +
> +  /* Load actual type from memory at offset using ldur.  */
> +  ops[0] =3D actual_reg;
> +  ops[1] =3D target_reg;
> +  ops[2] =3D GEN_INT (offset);
> +  output_asm_insn ("ldur\t%w0, [%1, #%2]", ops);
> +
> +  /* Load expected type using mov/movk sequence.  */
> +  ops[0] =3D expected_reg;
> +  ops[1] =3D GEN_INT (type_id & 0xFFFF);
> +  output_asm_insn ("mov\t%w0, #%1", ops);
> +  ops[1] =3D GEN_INT ((type_id >> 16) & 0xFFFF);
> +  output_asm_insn ("movk\t%w0, #%1, lsl #16", ops);
> +
> +  /* Compare types.  */
> +  ops[0] =3D actual_reg;
> +  ops[1] =3D expected_reg;
> +  output_asm_insn ("cmp\t%w0, %w1", ops);
> +
> +  /* Output conditional branch to call label.  */
> +  fputs ("\tb.eq\t", asm_out_file);
> +  assemble_name (asm_out_file, call_name);
> +  fputc ('\n', asm_out_file);
> +
> +  /* Output trap label and BRK instruction.  */
> +  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
> +
> +  /* Calculate and emit BRK with ESR encoding.  The type index must name
> +     the register that actually holds the expected type.  */
> +  unsigned type_index =3D expected_regno;
> +  unsigned addr_index =3D REGNO (target_reg) - R0_REGNUM;
> +  unsigned esr_value =3D 0x8000 | ((type_index & 31) << 5) | (addr_index=
 & 31);
> +
> +  fprintf (asm_out_file, "\tbrk\t#%#x\n", esr_value);
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
> index 32161707ae16..589605921844 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -17511,6 +17511,20 @@ header MOVri instruction would become something =
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
> index 7c59921e630c..47a33bf6393b 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> @@ -63,4 +63,24 @@ __attribute__((noinline)) void test_conditional_call(i=
nt flag) {
>  ** ...
>  */
>
> +/*
> +** test_complex_args: { target aarch64*-*-* }
> +** ...
> +** ldur        w[0-9]+, \[(x[0-9]+), #-4\]
> +** mov w[0-9]+, #[0-9]+
> +** movk        w[0-9]+, #[0-9]+, lsl #16
> +** cmp w[0-9]+, w[0-9]+
> +** b.eq        .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap[0-9]+:
> +** brk #0x[0-9a-f]+
> +** .Lkcfi_call\2:
> +** br  \1
> +** ...
> +*/
> +
> +/* The typeid load must not clobber the call target: its destination
> +   register must differ from the base (target) register.  "ldur wN, [xN,=
..."
> +   (same register number) means the target was overwritten by the load. =
 */
> +/* { dg-final { scan-assembler-not {ldur\tw([0-9]+), \[x\1,} { target aa=
rch64*-*-* } } } */
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.=
dg/kcfi/kcfi-basics.c
> index fe0a21d26df9..7f1c45f1fe94 100644
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
> +** brk #0x[0-9a-f]+
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
> index 05165f0e2851..c402a1678a73 100644
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
> +/* AArch64: { dg-final { scan-assembler-times {brk\s+#0x[0-9a-f]+} 2 { t=
arget aarch64*-*-* } } } */
>
>  /* Verify 2 separate call sites.  */
>  /* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { targe=
t i?86-*-* x86_64-*-* } } } */
> +/* AArch64: { dg-final { scan-assembler-times {br\tx[0-9]+} 2 { target a=
arch64*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/te=
stsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> index ed415033c5c9..0b23caa49ebb 100644
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
> +** brk #0x[0-9a-f]+
> +** .Lkcfi_call\2:
> +** blr \1
> +** ...
> +*/
> +
>  /* { dg-final { check-function-bodies "**" "" "" { target *-*-* } {\.L.*=
|\.section|\.text} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c b/gcc/te=
stsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
> index cda9bf6c82b8..6b4698447b7b 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-direct-call-shapes.c
> @@ -27,3 +27,6 @@ void caller(int sel, void (*ip)(int), int x) {
>  /* Per-arch dg-final patterns are added by each arch's KCFI implementati=
on
>     commit; the invariant is "exactly one typeid load =3D one indirect ca=
ll".  */
>  /* { dg-final { scan-assembler-times {addl\t-4\(%r[a-z0-9]+\), %r10d} 1 =
{ target x86_64-*-* } } } */
> +/* The typeid scratch register avoids the call target, so it is not alwa=
ys
> +   w16 (a sibcall target lands in x16/x17, forcing the load into w9).  *=
/
> +/* { dg-final { scan-assembler-times {ldur\tw[0-9]+, \[x[0-9]+, #-4\]} 1=
 { target aarch64*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/tes=
tsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> index 5553ff47174b..ad6130c9d323 100644
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
> +** ldur        w[0-9]+, \[\1, #-4\]
> +** mov w[0-9]+, #[0-9]+
> +** movk        w[0-9]+, #[0-9]+, lsl #16
> +** cmp w[0-9]+, w[0-9]+
> +** b.eq        .Lkcfi_call([0-9]+)
> +** .Lkcfi_trap[0-9]+:
> +** brk #0x[0-9a-f]+
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
> index 9ed7e21fe8eb..98591ed9b145 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> @@ -75,11 +75,16 @@ int main(void)
>
>  /* Verify correct number of KCFI checks: exactly 2 */
>  /* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } *=
/
> +/* { dg-final { scan-assembler-times {brk\s+#0x[0-9a-f]+} 2 { target aar=
ch64*-*-* } } } */
>
>  /* Positive controls: these should have KCFI checks.  */
>  /* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_f=
unction} { target x86_64-*-* } } } */
>  /* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_=
normal_inline} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {normal_function:.*brk\s+#0x[0-9a-f]+.*\.=
size\s+normal_function} { target aarch64*-*-* } } } */
> +/* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#0x[0-9a-f]+.=
*\.size\s+wrap_normal_inline} { target aarch64*-*-* } } } */
>
>  /* Negative controls: these should NOT have KCFI checks.  */
>  /* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.=
*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
>  /* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\=
s+wrap_sensitive_inline} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*brk\=
s+#0x[0-9a-f]+.*\.size\s+sensitive_non_inline_function} { target aarch64*-*=
-* } } } */
> +/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#0x[0-=
9a-f]+.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
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
> index 04a9eb1fd206..7ac40719504b 100644
> --- a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
> @@ -78,3 +78,24 @@ int test_non_tail_indirect_call(func_ptr_t handler, in=
t x) {
>
>  /* Should have exactly 1 regular call (non-tail call case).  */
>  /* { dg-final { scan-assembler-times {call\t\*%[a-z0-9]+} 1 { target x86=
_64-*-* } } } */
> +
> +/* Should have exactly 4 KCFI checks for indirect calls (load type ID fr=
om
> +   -4 offset + compare).  The actual-type scratch register avoids the ca=
ll
> +   target, so it is w9 for the sibcall targets (x16) and w16 otherwise; =
the
> +   expected type is in the other of w16/w17.  */
> +/* { dg-final { scan-assembler-times {ldur\tw[0-9]+, \[x[0-9]+, #-4\]} 4=
 { target aarch64-*-* } } } */
> +/* { dg-final { scan-assembler-times {cmp\tw[0-9]+, w1[67]} 4 { target a=
arch64-*-* } } } */
> +
> +/* Should have exactly 4 trap instructions.  */
> +/* { dg-final { scan-assembler-times {brk\t#0x[0-9a-f]+} 4 { target aarc=
h64-*-* } } } */
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
> index 000000000000..159e3b340973
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
> @@ -0,0 +1,42 @@
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
> +   Since we know this test uses x2, we expect
> +   ESR =3D 0x8000 | (17<<5) | 2 =3D 0x8222 (33314)
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
> +** brk #0x8222
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
