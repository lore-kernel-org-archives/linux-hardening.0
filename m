Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF22288CB
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807932; cv=none; b=HSD62/FmFJJpKefVRMDWWxzsyzHE6niTcGGIELAw+9bgm5YIXyPG5LAjrjIInxuvgIYxDkQgwFgt88EeKYBAa1HfEcHKkJPloUFDNdGW/n/TeuyRein6We7vKtGlzw5m7WGDAO6S8lmlPjxjYnBrsSry/MjzpbUgF5tG0v9qaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807932; c=relaxed/simple;
	bh=FWXogq7dCJjdu9qwDs3WCNTqXM5PVZuv630cFuT/EJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoIsHIjq/t4dge8ZXs/PE5gvRU1gMAtGW29PwHDTyo+rZSJmWFq1819iwCopKpBUQOJV20VfaYYzL1nbTbNEA3nDH7X+4Fq0MRipWDpmbHAo0DWmLqgH3bJanXEhgwazVTSceZph2K2IEqyG6zsDWIuIkRlsnkwK7XJnsNHRjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boXu/geD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boXu/geD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58DNUKs1008131
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MO7x8Fjz+PHFchirJxD5s0p1l65JWUsbKd5Zt5ZBXHM=; b=boXu/geDkMwsgfWW
	GB4QLvLCGAROmU45XJg2fizufpG1De/Kyidvnc/xYJlY2qcE5NFfTcXF/ViTAy0g
	aFpGZwk+lu9dKlEfSLIkseYjZThWObP3dgkJTdwTIOIdtR4PD5tLfPUFTdnyV+0P
	zcCx3P9BRwOenItaczLm43D0mDpw/gd6v/UakMjLoSeAnIh/3Xn9qNYHnbDgZnYn
	QrL3OAjs37I05nIP5S9QUd4xEwmEZdGenSU8R2nAyGR+otGrv7Fgoue/CVUljSaE
	E6vbky2nRRnhBGOGJEwulVwx09wh4vM5S5qJHG8EDpu8DgGDD6M1yNhporJ+d2HI
	FL8l7A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr1mvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 23:58:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2641084fb5aso2368955ad.0
        for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 16:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757807923; x=1758412723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO7x8Fjz+PHFchirJxD5s0p1l65JWUsbKd5Zt5ZBXHM=;
        b=Bap9myh3wFMCAExjD49zMHVQZ1LKd10fSlX3FbqEX2ERTkydC0mxm/diwfa4y1alUn
         LR/PWxtbSHPS63/aywano02L8E1bjVsGtAqGn1SBaxjMEAj6cDlvct9SMtABD7ZN5Gm0
         aeawy+VjfQ8Uusq7QWzBWP4riVUKt5RLHiMBAw7m10iPrp+U5o1YYYeum9t2doSp4Uiw
         7kXQ1dPuL3Be4P3c1TJenyRLDKGmzgMt0yynAe2Zy3DQq2EigJjDpvGD4T3zcztc2L5j
         ptyCYzcVSZpDUY2JJRksTsIAnQ4fmZhasbVqDjU30MshNlX5cqZb5SQFbNdFNSKnd+IZ
         NJSw==
X-Forwarded-Encrypted: i=1; AJvYcCWYXRFg/eW+aTWcyYRiwFTQyDR5IIZaQaQmrg20M8OdeR+TqrOrwbndOQCqgV5AP436/OWU2lDRXTydajH5B3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Rpku3UaI17erDLurTemRyD07zAZFc0AZpOjWFAXKFNHIxD/N
	CPUg+PajZvnzvxTle0TRk/ufAyiKT/STE858n6vIgidQp6TWpaIASsnbs9k4nog4hiCzk1Ex+22
	ejkwJ8bnYafxyMdJdZ5YiI8ReMC56MK6UNxLuccuhG8mrLZ1fMiuon8Rr174jMU6Pr7jJhMRMmK
	OE+s13qeB7KKg+ZMAQTmQygKSGK1LcouCCJFlzvnPOaGICUQ==
X-Gm-Gg: ASbGncs47+LRcm2xJSMwGIJ+yM+QpennldnYCLT3T14PEJSbE5alMcyXCHSpnWhIba/
	51kA+44UFmcdBtZxQXYy570ZXQxcs4psaLs7o/DoeuC61NIJSGMJwLuVc3/enJIxoAhmCXmgDLU
	t0ZVosVNjArGXK3abfnzk=
X-Received: by 2002:a17:903:248:b0:249:2360:6af2 with SMTP id d9443c01a7336-25d24baff8emr98101395ad.16.1757807920786;
        Sat, 13 Sep 2025 16:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyhjZt0+upBohWCAJ5x2Zntw6xI9w/+xZ7Qsy08qHC6tn9rLa0PclNNpmVZpOrs/E3sU+Pzuorh2d9IomGRfM=
X-Received: by 2002:a17:903:248:b0:249:2360:6af2 with SMTP id
 d9443c01a7336-25d24baff8emr98100085ad.16.1757807917857; Sat, 13 Sep 2025
 16:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913231256.make.519-kees@kernel.org> <20250913232404.2690431-7-kees@kernel.org>
In-Reply-To: <20250913232404.2690431-7-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Sat, 13 Sep 2025 16:58:26 -0700
X-Gm-Features: AS18NWAHPhMMGMqp7tlifIMcFtn4OwTUi9R_66sr62eJ05rENUBG3ZvNRKSVqvo
Message-ID: <CALvbMcDm5i2-+Q-XBG16z1s5P67sJVS=bvpozUqqobAvO+xW4g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] kcfi: Add regression test suite
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
X-Proofpoint-ORIG-GUID: OTHfHNU6yFkV_C0rTKAHBQaA7ckJNalU
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c60536 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=Th9FP-laAYl7VsW0gK0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfXwCYhl285CKus
 bdoAzEwv/yD5QG9PWp6m45qTz9baKwa6U+eQ/AxYP9Dz32Xis4Tl+JE1UtMzt/L7YNQ+EdE/RDj
 srdPXuS0qKKFXCwNKnOoJ5mVOUMxhwhtdBm2yEIw0qAAz+vrs3iTPCLQzcvT2ihFCBRSibLvp5y
 x5ZvUZABiKETMkm/n1tItKkj4DyAqn6tLEj7DmL2EUDgC8S8OrJ9v3H4d0YoQR62hmSq3dQfgSW
 vsEeOkxVql18+h63eUtxB4Qg3hZ+KWThEDJLhuEyEYRhdO/IqwjgvxbKHGcYXGt2AZ+oLN2BJIE
 5mF+b7bNFDWPOWkOoq7qXKgUqwptbjV9Gw2vtGMB5oumGuApUZnzkkUES0JKlylKYm8gAmtEKlX
 cPf/+vhD
X-Proofpoint-GUID: OTHfHNU6yFkV_C0rTKAHBQaA7ckJNalU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-13_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On Sat, Sep 13, 2025 at 4:36=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Adds a test suite for KCFI (Kernel Control Flow Integrity) ABI, covering
> core functionality, optimization and code generation, addressing,
> architecture-specific KCFI sequence emission, and integration with
> patchable function entry.
>
> Tests can be run via:
>   make check-c RUNTESTFLAGS=3D'kcfi.exp'
>
> gcc/testsuite/ChangeLog:
>
>         * gcc.dg/kcfi/kcfi-adjacency.c: New test.
>         * gcc.dg/kcfi/kcfi-basics.c: New test.
>         * gcc.dg/kcfi/kcfi-call-sharing.c: New test.
>         * gcc.dg/kcfi/kcfi-cold-partition.c: New test.
>         * gcc.dg/kcfi/kcfi-complex-addressing.c: New test.
>         * gcc.dg/kcfi/kcfi-ipa-robustness.c: New test.
>         * gcc.dg/kcfi/kcfi-move-preservation.c: New test.
>         * gcc.dg/kcfi/kcfi-no-sanitize-inline.c: New test.
>         * gcc.dg/kcfi/kcfi-no-sanitize.c: New test.
>         * gcc.dg/kcfi/kcfi-offset-validation.c: New test.
>         * gcc.dg/kcfi/kcfi-patchable-basic.c: New test.
>         * gcc.dg/kcfi/kcfi-patchable-entry-only.c: New test.
>         * gcc.dg/kcfi/kcfi-patchable-large.c: New test.
>         * gcc.dg/kcfi/kcfi-patchable-medium.c: New test.
>         * gcc.dg/kcfi/kcfi-patchable-prefix-only.c: New test.
>         * gcc.dg/kcfi/kcfi-pic-addressing.c: New test.
>         * gcc.dg/kcfi/kcfi-retpoline-r11.c: New test.
>         * gcc.dg/kcfi/kcfi-runtime.c: New test.
>         * gcc.dg/kcfi/kcfi-tail-calls.c: New test.
>         * gcc.dg/kcfi/kcfi-trap-encoding.c: New test.
>         * gcc.dg/kcfi/kcfi-trap-section.c: New test.
>         * gcc.dg/kcfi/kcfi.exp: New test.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    |  72 +++++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       | 108 +++++++++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  84 ++++++++++
>  .../gcc.dg/kcfi/kcfi-cold-partition.c         | 136 ++++++++++++++++
>  .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 135 ++++++++++++++++
>  .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 +++++++
>  .../gcc.dg/kcfi/kcfi-move-preservation.c      |  55 +++++++
>  .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     | 100 ++++++++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  39 +++++
>  .../gcc.dg/kcfi/kcfi-offset-validation.c      |  48 ++++++
>  .../gcc.dg/kcfi/kcfi-patchable-basic.c        |  70 ++++++++
>  .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  62 +++++++
>  .../gcc.dg/kcfi/kcfi-patchable-large.c        |  51 ++++++
>  .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  60 +++++++
>  .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  60 +++++++
>  .../gcc.dg/kcfi/kcfi-pic-addressing.c         | 104 ++++++++++++
>  .../gcc.dg/kcfi/kcfi-retpoline-r11.c          |  50 ++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      | 151 ++++++++++++++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 142 ++++++++++++++++
>  .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  54 +++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  41 +++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  64 ++++++++
>  22 files changed, 1740 insertions(+)
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.=
c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-retpoline-r11.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
>
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c b/gcc/testsuite/g=
cc.dg/kcfi/kcfi-adjacency.c
> new file mode 100644
> index 000000000000..becb47678df0
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> @@ -0,0 +1,72 @@
> +/* Test KCFI check/transfer adjacency - regression test for instruction
> +   insertion.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2" } */
> +
> +/* This test ensures that KCFI security checks remain immediately adjace=
nt
> +   to their corresponding indirect calls/jumps, with no executable instr=
uctions
> +   between the type ID check and the control flow transfer. */
> +
> +/* External function pointers to prevent optimization.  */
> +extern void (*complex_func_ptr)(int, int, int, int);
> +extern int (*return_func_ptr)(int, int);
> +
> +/* Function with complex argument preparation that could tempt
> +   the optimizer to insert instructions between KCFI check and call.  */
> +__attribute__((noinline)) void test_complex_args(int a, int b, int c, in=
t d) {
> +    /* Complex argument expressions that might cause instruction schedul=
ing.  */
> +    complex_func_ptr(a * 2, b + c, d - a, (a << 1) | b);
> +}
> +
> +/* Function with return value handling.  */
> +__attribute__((noinline)) int test_return_value(int x, int y) {
> +    /* Return value handling that shouldn't interfere with adjacency.  *=
/
> +    int result =3D return_func_ptr(x + 1, y * 2);
> +    return result + 1;
> +}
> +
> +/* Test struct field access that caused issues in try-catch.c.  */
> +struct call_info {
> +    void (*handler)(void);
> +    int status;
> +    int data;
> +};
> +
> +extern struct call_info *global_call_info;
> +
> +__attribute__((noinline)) void test_struct_field_call(void) {
> +    /* This pattern caused adjacency issues before the fix.  */
> +    global_call_info->handler();
> +}
> +
> +/* Test conditional indirect call.  */
> +__attribute__((noinline)) void test_conditional_call(int flag) {
> +    if (flag) {
> +        global_call_info->handler();
> +    }
> +}
> +
> +/* Should have KCFI instrumentation for all indirect calls.  */
> +
> +/* x86_64: Complete KCFI check sequence should be present.  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r1[01]d\n\taddl\t[^,]=
+, %r1[01]d\n\tje\t\.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tud2} { target=
 x86_64-*-* } } } */
> +
> +/* AArch64: Complete KCFI check sequence should be present.  */
> +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-[0-9]+\]\n\tmov\=
tw17, #[0-9]+\n\tmovk\tw17, #[0-9]+, lsl #16\n\tcmp\tw16, w17\n\tb\.eq\t(\.=
Lkcfi_call[0-9]+)\n\.Lkcfi_trap[0-9]+:\n\tbrk\t#[0-9]+\n\1:\n\tblr\tx[0-9]+=
} { target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: Complete KCFI check sequence should be present with stack
> +   spilling.  */
> +/* { dg-final { scan-assembler {push\t\{r0, r1\}\n\tldr\tr0, \[r[0-9]+, =
#-[0-9]+\]\n\tmovw\tr1, #[0-9]+\n\tmovt\tr1, #[0-9]+\n\tcmp\tr0, r1\n\tpop\=
t\{r0, r1\}\n\tbeq\t\.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tudf\t#[0-9]+=
\n\.Lkcfi_call[0-9]+:\n\tblx\tr[0-9]+} { target arm32 } } } */
> +
> +/* RISC-V: Complete KCFI check sequence should be present.  */
> +/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9=
]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, \.Lkcfi_call[0-9]+\n\.Lkcfi_t=
rap[0-9]+:\n\tebreak} { target riscv*-*-* } } } */
> +
> +/* Should have trap section with entries.  */
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } =
*/
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } =
*/
> +
> +/* AArch64 should NOT have trap section (uses brk immediate instead) */
> +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* =
} } } */
> +
> +/* ARM 32-bit should NOT have trap section (uses udf immediate instead) =
*/
> +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target arm32 } } } *=
/
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c b/gcc/testsuite/gcc.=
dg/kcfi/kcfi-basics.c
> new file mode 100644
> index 000000000000..b0a9e11f1f3c
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
> @@ -0,0 +1,108 @@
> +/* Test basic KCFI functionality - preamble generation.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
> +
> +/* Extern function declarations - should NOT get KCFI preambles.  */
> +extern void external_func(void);
> +extern int external_func_int(int x);
> +
> +void regular_function(int x) {
> +    /* This should get KCFI preamble.  */
> +}
> +
> +void static_target_function(int x) {
> +    /* Target function that can be called indirectly.  */
> +}
> +
> +__attribute__((nocf_check))
> +void nocf_check_function(int x) {
> +    /* This function has nocf_check attribute - should NOT get KCFI prea=
mble.  */
> +}
> +
> +static void static_caller(void) {
> +    /* Static function that makes an indirect call
> +       Should NOT get KCFI preamble (not address-taken)
> +       But must generate KCFI check for the indirect call.  */
> +    void (*local_ptr)(int) =3D static_target_function;
> +    local_ptr(42);  /* This should generate KCFI check.  */
> +}
> +
> +/* Make external_func address-taken.  */
> +void (*func_ptr)(int) =3D regular_function;
> +void (*ext_ptr)(void) =3D external_func;
> +void (__attribute__((nocf_check)) *nocf_ptr)(int) =3D nocf_check_functio=
n;
> +
> +int main() {
> +    func_ptr(42);
> +    ext_ptr();        /* Indirect call to external_func.  */
> +    external_func_int(10);  /* Direct call to external_func_int.  */
> +    static_caller();  /* Direct call to static function.  */
> +    return 0;
> +}
> +
> +/* Verify KCFI preamble exists for regular_function.  */
> +/* { dg-final { scan-assembler {__cfi_regular_function:} } } */
> +
> +/* Verify KCFI preamble symbol comes before main function symbol.  */
> +/* { dg-final { scan-assembler {__cfi_regular_function:.*regular_functio=
n:} } } */
> +
> +/* Target function should have preamble (address-taken).  */
> +/* { dg-final { scan-assembler {__cfi_static_target_function:} } } */
> +
> +/* Static caller should NOT have preamble (it's only called directly,
> +   not address-taken). */
> +/* { dg-final { scan-assembler-not {__cfi_static_caller:} } } */
> +
> +/* Function with nocf_check attribute should NOT have preamble.  */
> +/* { dg-final { scan-assembler-not {__cfi_nocf_check_function:} } } */
> +
> +/* x86_64: Verify type ID in preamble (after NOPs, before function label=
) */
> +/* { dg-final { scan-assembler {__cfi_regular_function:\n\t+nop\n.*\n\t+=
movl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
> +
> +/* AArch64: Verify type ID word in preamble.  */
> +/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-=
9a-f]+} { target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: Verify type ID word in preamble.  */
> +/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-=
9a-f]+} { target arm32 } } } */
> +
> +/* RISC-V: Verify type ID word in preamble */
> +/* { dg-final { scan-assembler {__cfi_regular_function:\n\t\.word\t0x[0-=
9a-f]+} { target riscv*-*-* } } } */
> +
> +/* x86_64: Static function should generate complete KCFI check sequence.=
  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[=
a-z0-9]+\), %r10d\n\tje\t(\.Lkcfi_call[0-9]+)\n\.Lkcfi_trap[0-9]+:\n\tud2\n=
.*\n\1:\n\tcall} { target x86_64-*-* } } } */
> +
> +/* AArch64: Static function should generate complete KCFI check sequence=
.  */
> +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]\n\tmov\tw17,=
 #[0-9]+\n\tmovk\tw17, #[0-9]+, lsl #16\n\tcmp\tw16, w17\n\tb\.eq\t(\.Lkcfi=
_call[0-9]+)\n\.Lkcfi_trap[0-9]+:\n\tbrk\t#[0-9]+\n\1:\n\tblr} { target aar=
ch64*-*-* } } } */
> +
> +/* ARM 32-bit: Static function should generate complete KCFI check seque=
nce
> +   with stack spilling.  */
> +/* { dg-final { scan-assembler {push\t\{r0, r1\}\n\tldr\tr0, \[r[0-9]+, =
#-4\]\n\tmovw\tr1, #[0-9]+\n\tmovt\tr1, #[0-9]+\n\tcmp\tr0, r1\n\tpop\t\{r0=
, r1\}\n\tbeq\t\.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tudf\t#[0-9]+\n\.L=
kcfi_call[0-9]+:\n\tblx\tr[0-9]+} { target arm32 } } } */
> +
> +/* RISC-V: Static function should generate KCFI check for indirect call.=
  */
> +/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9=
]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, (\.Lkcfi_call[0-9]+)\n\.Lkcfi=
_trap[0-9]+:\n\tebreak\n\t\.section\t\.kcfi_traps,"ao",@progbits,\.text\n\.=
Lkcfi_entry[0-9]+:\n\t\.4byte\t\.Lkcfi_trap[0-9]+-\.Lkcfi_entry[0-9]+\n\t\.=
text\n\1:\n\tjalr} { target riscv*-*-* } } } */
> +
> +/* Extern functions should NOT get KCFI preambles.  */
> +/* { dg-final { scan-assembler-not {__cfi_external_func:} } } */
> +/* { dg-final { scan-assembler-not {__cfi_external_func_int:} } } */
> +
> +/* Local functions should NOT get __kcfi_typeid_ symbols.  */
> +/* Only external declarations that are address-taken should get __kcfi_t=
ypeid_ */
> +/* { dg-final { scan-assembler-not {__kcfi_typeid_regular_function} } } =
*/
> +/* { dg-final { scan-assembler-not {__kcfi_typeid_main} } } */
> +
> +/* External address-taken functions should get __kcfi_typeid_ symbols.  =
*/
> +/* { dg-final { scan-assembler {__kcfi_typeid_external_func} } } */
> +
> +/* External functions that are only called directly should NOT get
> +   __kcfi_typeid_ symbols.  */
> +/* { dg-final { scan-assembler-not {__kcfi_typeid_external_func_int} } }=
 */
> +
> +/* Should have trap section for KCFI checks.  */
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } =
*/
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } =
*/
> +
> +/* AArch64 should NOT have trap section (uses brk immediate instead).  *=
/
> +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* =
} } } */
> +
> +/* ARM 32-bit should NOT have trap section (uses udf immediate instead).=
  */
> +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target arm32 } } } *=
/
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c b/gcc/testsuit=
e/gcc.dg/kcfi/kcfi-call-sharing.c
> new file mode 100644
> index 000000000000..f34d5f88547f
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
> @@ -0,0 +1,84 @@
> +/* Test KCFI check sharing bug - optimizer incorrectly shares KCFI check=
s
> +   between different function types.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2" } */
> +
> +/* Reproduce the pattern from Linux kernel internal_create_group where:
> +   - Two different function pointer types (is_visible vs is_bin_visible)=
.
> +   - Both get loaded into the same register (%rcx).
> +   - Optimizer creates shared KCFI check with wrong type ID.
> +   - This causes CFI failures in production kernel.  */
> +
> +struct kobject { int dummy; };
> +struct attribute { int dummy; };
> +struct bin_attribute { int dummy; };
> +
> +struct attribute_group {
> +    const char *name;
> +    // Type ID A
> +    int (*is_visible)(struct kobject *, struct attribute *, int);
> +    // Type ID B
> +    int (*is_bin_visible)(struct kobject *, const struct bin_attribute *=
, int);
> +    struct attribute **attrs;
> +    const struct bin_attribute **bin_attrs;
> +};
> +
> +/* Function that mimics __first_visible from kernel - gets inlined into
> +   caller.  */
> +static int __first_visible(const struct attribute_group *grp, struct kob=
ject *kobj)
> +{
> +    /* Path 1: Call is_visible function pointer.  */
> +    if (grp->attrs && grp->attrs[0] && grp->is_visible)
> +        return grp->is_visible(kobj, grp->attrs[0], 0);
> +
> +    /* Path 2: Call is_bin_visible function pointer.  */
> +    if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
> +        return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
> +
> +    return 0;
> +}
> +
> +/* Main function that triggers the optimization bug.  */
> +int test_kcfi_check_sharing(struct kobject *kobj, const struct attribute=
_group *grp)
> +{
> +    /* This should inline __first_visible and create the problematic pat=
tern where:
> +       1. Both function pointers get loaded into same register.
> +       2. Optimizer shares KCFI check between them.
> +       3. Uses wrong type ID for one of the calls.  */
> +    return __first_visible(grp, kobj);
> +}
> +
> +/* Each indirect call should have its own KCFI check with correct type I=
D.
> +
> +   Should see:
> +   1. KCFI check for is_visible call with is_visible type ID.
> +   2. KCFI check for is_bin_visible call with is_bin_visible type ID.  *=
/
> +
> +/* Verify we have TWO different KCFI check sequences.  */
> +/* Each check should have different type ID constants.  */
> +/* x86: { dg-final { scan-assembler-times {movl\s+\$-?[0-9]+,\s+%r10d} 2=
 { target i?86-*-* x86_64-*-* } } } */
> +/* AArch64: { dg-final { scan-assembler-times {mov\s+w17, #[0-9]+} 2 { t=
arget aarch64*-*-* } } } */
> +/* ARM 32-bit: { dg-final { scan-assembler-times {movw\s+r1, #[0-9]+} 2 =
{ target arm32 } } } */
> +/* RISC-V: { dg-final { scan-assembler-times {lui\tt2, [0-9]+} 2 { targe=
t riscv*-*-* } } } */
> +
> +/* Verify the checks use DIFFERENT type IDs (not shared).
> +   We should NOT see the same type ID used twice - that would indicate
> +   sharing bug.  */
> +/* x86: { dg-final { scan-assembler-not {movl\s+\$(-?[0-9]+),\s+%r10d.*m=
ovl\s+\$\1,\s+%r10d} { target i?86-*-* x86_64-*-* } } } */
> +/* AArch64: { dg-final { scan-assembler-not {mov\s+w17, #([0-9]+).*mov\s=
+w17, #\1} { target aarch64*-*-* } } } */
> +/* ARM 32-bit: { dg-final { scan-assembler-not {movw\s+r1, #([0-9]+).*mo=
vw\s+r1, #\1} { target arm32 } } } */
> +/* RISC-V: { dg-final { scan-assembler-not {lui\s+t2, ([0-9]+)\s.*lui\s+=
t2, \1\s} { target riscv*-*-* } } } */
> +
> +/* Verify each call follows its own check (not shared) */
> +/* Should have 2 separate trap instructions.  */
> +/* x86: { dg-final { scan-assembler-times {ud2} 2 { target i?86-*-* x86_=
64-*-* } } } */
> +/* AArch64: { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target=
 aarch64*-*-* } } } */
> +/* ARM 32-bit: { dg-final { scan-assembler-times {udf\s+#[0-9]+} 2 { tar=
get arm32 } } } */
> +/* RISC-V: { dg-final { scan-assembler-times {ebreak} 2 { target riscv*-=
*-* } } } */
> +
> +/* Verify 2 separate call sites.  */
> +/* x86: { dg-final { scan-assembler-times {jmp\s+\*%[a-z0-9]+} 2 { targe=
t i?86-*-* x86_64-*-* } } } */
> +/* AArch64: Allow both blr (regular call) and br (tail call) */
> +/* AArch64: { dg-final { scan-assembler-times {br\tx[0-9]+} 2 { target a=
arch64*-*-* } } } */
> +/* ARM 32-bit: { dg-final { scan-assembler-times {bx\s+(?:r[0-9]+|ip)} 2=
 { target arm32 } } } */
> +/* RISC-V: { dg-final { scan-assembler-times {jalr\t[a-z0-9]+} 2 { targe=
t riscv*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c b/gcc/testsu=
ite/gcc.dg/kcfi/kcfi-cold-partition.c
> new file mode 100644
> index 000000000000..17def558ada4
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
> @@ -0,0 +1,136 @@
> +/* Test KCFI cold function and cold partition behavior.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2" } */
> +/* { dg-additional-options "-freorder-blocks-and-partition" { target fre=
order } } */
> +
> +void regular_function(void) {
> +    /* Regular function should get preamble.  */
> +}
> +
> +/* Cold-attributed function should STILL get preamble (it's a regular
> +   function, just marked cold).  */
> +__attribute__((cold))
> +void cold_attributed_function(void) {
> +    /* This function has cold attribute but should still get KCFI preamb=
le.  */
> +}
> +
> +/* Hot-attributed function should get preamble.  */
> +__attribute__((hot))
> +void hot_attributed_function(void) {
> +    /* This function is explicitly hot and should get KCFI preamble.  */
> +}
> +
> +/* Global to prevent optimization from eliminating cold paths.  */
> +extern void abort(void);
> +
> +/* Additional function to test that normal functions still get preambles=
.  */
> +__attribute__((noinline))
> +int another_regular_function(int x) {
> +    return x + 42;
> +}
> +
> +/* Function designed to generate cold partitions under optimization.  */
> +__attribute__((noinline))
> +void function_with_cold_partition(int condition) {
> +    /* Hot path - very likely to execute.  */
> +    if (__builtin_expect(condition =3D=3D 42, 1)) {
> +        /* Simple hot path that optimizer will keep inline.  */
> +        return;
> +    }
> +
> +    /* Cold paths that actually do something to prevent elimination.  */
> +    if (__builtin_expect(condition < 0, 0)) {
> +        /* Error path 1 - call abort to prevent elimination.  */
> +        abort();
> +    }
> +
> +    if (__builtin_expect(condition > 1000000, 0)) {
> +        /* Error path 2 - call abort to prevent elimination.  */
> +        abort();
> +    }
> +
> +    if (__builtin_expect(condition =3D=3D 999999, 0)) {
> +        /* Error path 3 - more substantial cold code.  */
> +        volatile int sum =3D 0;
> +        for (volatile int i =3D 0; i < 100; i++) {
> +            sum +=3D i * condition;
> +        }
> +        if (sum > 0)
> +            abort();
> +    }
> +
> +    /* More cold paths - switch with many unlikely cases.  */
> +    switch (condition) {
> +        case 1000001: case 1000002: case 1000003: case 1000004: case 100=
0005:
> +        case 1000006: case 1000007: case 1000008: case 1000009: case 100=
0010:
> +            /* Each case does some work before abort.  */
> +            volatile int work =3D condition * 2;
> +            if (work > 0) abort();
> +            break;
> +        default:
> +            if (condition !=3D 42) {
> +                /* Fallback cold path - substantial work.  */
> +                volatile int result =3D 0;
> +                for (volatile int j =3D 0; j < condition % 50; j++) {
> +                    result +=3D j;
> +                }
> +                if (result >=3D 0) abort();
> +            }
> +    }
> +}
> +
> +/* Test function pointers to ensure address-taken detection works.  */
> +void test_function_pointers(void) {
> +    void (*regular_ptr)(void) =3D regular_function;
> +    void (*cold_ptr)(void) =3D cold_attributed_function;
> +    void (*hot_ptr)(void) =3D hot_attributed_function;
> +
> +    regular_ptr();
> +    cold_ptr();
> +    hot_ptr();
> +}
> +
> +int main() {
> +    regular_function();
> +    cold_attributed_function();
> +    hot_attributed_function();
> +    function_with_cold_partition(42); /* Normal case - stay in hot path.=
  */
> +    another_regular_function(5);
> +    test_function_pointers();
> +    return 0;
> +}
> +
> +/* Regular function should have preamble.  */
> +/* { dg-final { scan-assembler "__cfi_regular_function:" } } */
> +
> +/* Cold-attributed function should STILL have preamble (it's a legitimat=
e function) */
> +/* { dg-final { scan-assembler "__cfi_cold_attributed_function:" } } */
> +
> +/* Hot-attributed function should have preamble.  */
> +/* { dg-final { scan-assembler "__cfi_hot_attributed_function:" } } */
> +
> +/* Function that generates cold partitions should have preamble for main=
 entry.  */
> +/* { dg-final { scan-assembler "__cfi_function_with_cold_partition:" } }=
 */
> +
> +/* Address-taken functions should have preambles.  */
> +/* { dg-final { scan-assembler "__cfi_test_function_pointers:" } } */
> +
> +/* The function should generate a .cold partition (only on targets that =
support freorder) */
> +/* { dg-final { scan-assembler "function_with_cold_partition\\.cold:" { =
target freorder } } } */
> +
> +/* The .cold partition should NOT get a __cfi_ preamble since it's never
> +   reached via indirect calls.  */
> +/* { dg-final { scan-assembler-not "__cfi_function_with_cold_partition\\=
.cold:" { target freorder } } } */
> +
> +/* Additional regular function should get preamble.  */
> +/* { dg-final { scan-assembler "__cfi_another_regular_function:" } } */
> +
> +/* Test coverage summary:
> +   1. Cold-attributed function (__attribute__((cold))): SHOULD get pream=
ble
> +   2. Cold partition (-freorder-blocks-and-partition): should NOT get pr=
eamble
> +   3. IPA split .part function (split_part=3Dtrue): Logic in place, woul=
d skip if triggered
> +
> +   Note: IPA function splitting (creating .part functions with split_par=
t=3Dtrue) requires
> +   specific optimization conditions that are difficult to trigger reliab=
ly in tests.
> +   The KCFI logic correctly handles this case using the split_part flag =
check.
> +*/
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c b/gcc/te=
stsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> new file mode 100644
> index 000000000000..b9a8955b0899
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
> @@ -0,0 +1,135 @@
> +/* Test KCFI with complex addressing modes (structure members, array
> +   elements). This is a regression test for the change_address_1 RTL
> +   error that occurred when target_addr was PLUS(reg, offset) instead
> +   of a simple register.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2" } */
> +
> +struct function_table {
> +    int (*callback1)(int);
> +    int (*callback2)(int, int);
> +    void (*callback3)(void);
> +    int (*callback4)(void *, void *, void *, void *, void *, void *);
> +    int data;
> +};
> +
> +static int handler1(int x) {
> +    return x * 2;
> +}
> +
> +static int handler2(int x, int y) {
> +    return x + y;
> +}
> +
> +static void handler3(void) {
> +    /* Empty handler.  */
> +}
> +
> +/* Test indirect calls through structure members - this creates
> +   PLUS(reg, offset) addressing.  */
> +int test_struct_members(struct function_table *table) {
> +    int result =3D 0;
> +
> +    /* These indirect calls will generate complex addressing modes:
> +     * call *(%rdi)          - callback1 at offset 0
> +     * call *8(%rdi)         - callback2 at offset 8
> +     * call *16(%rdi)        - callback3 at offset 16
> +     * KCFI must handle PLUS(reg, struct_offset) + kcfi_offset.  */
> +
> +    result +=3D table->callback1(10);
> +    result +=3D table->callback2(5, 7);
> +    table->callback3();
> +
> +    return result;
> +}
> +
> +/* Test indirect calls through array elements - another source of
> +   complex addressing.  */
> +typedef int (*func_array_t)(int);
> +
> +int test_array_elements(func_array_t functions[], int index) {
> +    /* This creates addressing like MEM[PLUS(PLUS(reg, index*8), 0)]
> +       which should be simplified to MEM[PLUS(reg, index*8)].  */
> +    return functions[index](42);
> +}
> +
> +/* Test with global structure.  */
> +static struct function_table global_table =3D {
> +    .callback1 =3D handler1,
> +    .callback2 =3D handler2,
> +    .callback3 =3D handler3,
> +    .data =3D 100
> +};
> +
> +int test_global_struct(void) {
> +    /* Access through global structure - may generate different
> +       addressing patterns.  */
> +    return global_table.callback1(20) + global_table.callback2(3, 4);
> +}
> +
> +/* Test nested structure access.  */
> +struct nested_table {
> +    struct function_table inner;
> +    int extra_data;
> +};
> +
> +int test_nested_struct(struct nested_table *nested) {
> +    /* Even more complex addressing: nested structure member access.  */
> +    return nested->inner.callback1(15);
> +}
> +
> +int test_many_args(void *one, void *two, void *three, void *four, void *=
five, void *six)
> +{
> +    return (unsigned long)one + (unsigned long)two + (unsigned long)thre=
e
> +          + (unsigned long)four + (unsigned long)five + (unsigned long)s=
ix;
> +}
> +
> +int main() {
> +    struct function_table local_table =3D {
> +        .callback1 =3D handler1,
> +        .callback2 =3D handler2,
> +        .callback3 =3D handler3,
> +        .callback4 =3D test_many_args,
> +        .data =3D 50
> +    };
> +
> +    func_array_t func_array[] =3D { handler1, handler1, handler1 };
> +
> +    int result =3D 0;
> +    result +=3D test_struct_members(&local_table);
> +    result +=3D test_array_elements(func_array, 1);
> +    result +=3D test_global_struct();
> +
> +    struct nested_table nested =3D { .inner =3D local_table, .extra_data=
 =3D 200 };
> +    result +=3D test_nested_struct(&nested);
> +
> +    result +=3D local_table.callback4(handler1, handler2, handler3, &res=
ult, main, &local_table);
> +
> +    return result;
> +}
> +
> +/* Verify that all address-taken functions get KCFI preambles.  */
> +/* { dg-final { scan-assembler {__cfi_handler1:} } } */
> +/* { dg-final { scan-assembler {__cfi_handler2:} } } */
> +/* { dg-final { scan-assembler {__cfi_handler3:} } } */
> +/* { dg-final { scan-assembler {__cfi_test_many_args:} } } */
> +
> +/* x86_64: Verify KCFI checks are generated for indirect calls through
> +   complex addressing.  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[=
a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {ud2} { target x86_64-*-* } } } */
> +
> +/* AArch64: Verify KCFI checks for complex addressing.  */
> +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aa=
rch64*-*-* } } } */
> +/* { dg-final { scan-assembler {brk} { target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: Verify KCFI checks for complex addressing with stack spil=
ling.  */
> +/* { dg-final { scan-assembler {ldr\tr0, \[r[0-9]+, #-4\]} { target arm3=
2 } } } */
> +/* { dg-final { scan-assembler {udf} { target arm32 } } } */
> +
> +/* RISC-V: Verify KCFI check sequence for complex addressing.  */
> +/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9=
]+\n\taddiw\tt2, t2, -?[0-9]+\n\tbeq\tt1, t2, \.Lkcfi_call[0-9]+\n\.Lkcfi_t=
rap[0-9]+:\n\tebreak} { target riscv*-*-* } } } */
> +
> +/* Should have trap section for x86 and RISC-V only.  */
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } =
*/
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } =
*/
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c b/gcc/testsu=
ite/gcc.dg/kcfi/kcfi-ipa-robustness.c
> new file mode 100644
> index 000000000000..a43bcd4f3e3f
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
> @@ -0,0 +1,54 @@
> +/* Test KCFI IPA pass robustness with compiler-generated constructs.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2" } */
> +
> +#include <stddef.h>
> +
> +/* Test various compiler-generated constructs that could confuse IPA pas=
s.  */
> +
> +/* static_assert - this was causing the original crash.  */
> +typedef struct {
> +    int field1;
> +    char field2;
> +} test_struct_t;
> +
> +static_assert(offsetof(test_struct_t, field1) =3D=3D 0, "layout check 1"=
);
> +static_assert(offsetof(test_struct_t, field2) =3D=3D 4, "layout check 2"=
);
> +static_assert(sizeof(test_struct_t) >=3D 5, "size check");
> +
> +/* Regular functions that should get KCFI analysis.  */
> +void regular_function(void) {
> +    /* Should get KCFI preamble.  */
> +}
> +
> +static void static_function(void) {
> +    /* With -O2: correctly identified as not address-taken, no preamble.=
  */
> +}
> +
> +void address_taken_function(void) {
> +    /* Should get KCFI preamble (address taken below) */
> +}
> +
> +/* Function pointer to create address-taken scenario.  */
> +void (*func_ptr)(void) =3D address_taken_function;
> +
> +/* More static_asserts mixed with function definitions.  */
> +static_assert(sizeof(void*) >=3D 4, "pointer size check");
> +
> +int main(void) {
> +    regular_function();    /* Direct call.  */
> +    static_function();     /* Direct call to static.  */
> +    func_ptr();            /* Indirect call.  */
> +
> +    static_assert(sizeof(int) =3D=3D 4, "int size check");
> +
> +    return 0;
> +}
> +
> +/* Verify KCFI preambles are generated appropriately.  */
> +/* { dg-final { scan-assembler "__cfi_regular_function:" } } */
> +/* { dg-final { scan-assembler "__cfi_address_taken_function:" } } */
> +/* { dg-final { scan-assembler "__cfi_main:" } } */
> +
> +/* With -O2: static_function correctly identified as not address-taken. =
 */
> +/* { dg-final { scan-assembler-not "__cfi_static_function:" } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c b/gcc/tes=
tsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> new file mode 100644
> index 000000000000..50029d136716
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
> @@ -0,0 +1,55 @@
> +/* Test that KCFI preserves function pointer moves at -O2 optimization.
> +   This test ensures that the combine pass doesn't incorrectly optimize =
away
> +   the move instruction needed to transfer function pointers from argume=
nt
> +   registers to the target registers used by KCFI patterns.  */
> +
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2 -std=3Dgnu11" } */
> +
> +static int called_count =3D 0;
> +
> +/* Function taking one argument, returning void.  */
> +static __attribute__((noinline)) void increment_void(int *counter)
> +{
> +    (*counter)++;
> +}
> +
> +/* Function taking one argument, returning int.  */
> +static __attribute__((noinline)) int increment_int(int *counter)
> +{
> +    (*counter)++;
> +    return *counter;
> +}
> +
> +/* Don't allow the compiler to inline the calls.  */
> +static __attribute__((noinline)) void indirect_call(void (*func)(int *))
> +{
> +    func(&called_count);
> +}
> +
> +int main(void)
> +{
> +    /* This should work - matching prototype.  */
> +    indirect_call(increment_void);
> +
> +    /* This should trap - mismatched prototype.  */
> +    indirect_call((void *)increment_int);
> +
> +    return 0;
> +}
> +
> +/* Verify complete KCFI check sequence with preserved move instruction. =
At
> +   -O2, the combine pass previously optimized away the move from %rdi to=
 %rax,
> +   breaking KCFI. Verify the full sequence is preserved. */
> +
> +/* x86_64: Complete KCFI sequence with move preservation and indirect ju=
mp.  */
> +/* { dg-final { scan-assembler {(indirect_call):.*\n.*movq\s+%rdi,\s+(%r=
ax)\n.*movl\s+\$[0-9]+,\s+%r10d\n\taddl\s+-4\(\2\),\s+%r10d\n\tje\s+\.Lkcfi=
_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tud2.*\.Lkcfi_call[0-9]+:\n\tjmp\s+\*\2.=
*\.size\s+\1,\s+\.-\1} { target x86_64-*-* } } } */
> +
> +/* AArch64: Complete KCFI sequence with move preservation and indirect b=
ranch.  */
> +/* { dg-final { scan-assembler {(indirect_call):.*\n.*mov\s+(x[0-9]+),\s=
+x0\n.*ldur\s+w16,\s+\[\2,\s+#-4\]\n\tmov\s+w17,\s+#[0-9]+\n\tmovk\s+w17,\s=
+#[0-9]+,\s+lsl\s+#16\n\tcmp\s+w16,\s+w17\n\tb\.eq\s+\.Lkcfi_call[0-9]+\n\.=
Lkcfi_trap[0-9]+:\n\tbrk\s+#[0-9]+.*\.Lkcfi_call[0-9]+:\n\tbr\s+\2.*\.size\=
s+\1,\s+\.-\1} { target aarch64*-*-* } } } */
> +
> +/* ARM32: Complete KCFI sequence with move preservation and indirect bra=
nch.  */
> +/* { dg-final { scan-assembler {(indirect_call):.*\n.*mov\s+(r[0-9]+),\s=
+r0\n.*push\s+\{r0,\s+r1\}\n\tldr\s+r0,\s+\[\2,\s+#-4\]\n\tmovw\s+r1,\s+#[0=
-9]+\n\tmovt\s+r1,\s+#[0-9]+\n\tcmp\s+r0,\s+r1\n\tpop\s+\{r0,\s+r1\}\n\tbeq=
\s+\.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tudf\s+#[0-9]+.*\.Lkcfi_call[0=
-9]+:\n\tbx\s+\2.*\.size\s+\1,\s+\.-\1} { target arm32 } } } */
> +
> +/* RISC-V: Complete KCFI sequence with move preservation and indirect ju=
mp.  */
> +/* { dg-final { scan-assembler {(indirect_call):.*mv\s+(a[0-9]+),a0.*lw\=
s+t1,\s+-4\(\2\).*lui\s+t2,\s+[0-9]+.*addiw\s+t2,\s+t2,\s+-?[0-9]+.*beq\s+t=
1,\s+t2,\s+\.Lkcfi_call[0-9]+.*ebreak.*jalr\s+zero,\s+\2,\s+0.*\.size\s+\1,=
\s+\.-\1} { target riscv64-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c b/gcc/te=
stsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> new file mode 100644
> index 000000000000..c43d8014ff2d
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
> @@ -0,0 +1,100 @@
> +/* Test that no_sanitize("kcfi") attribute is preserved during inlining.=
  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2" } */
> +
> +extern void external_side_effect(int value);
> +
> +/* Regular function (should get KCFI checks) */
> +__attribute__((noinline))
> +void normal_function(void (*callback)(int))
> +{
> +    /* This indirect call must generate KCFI checks.  */
> +    callback(300);
> +    external_side_effect(300);
> +}
> +
> +/* Regular function marked with no_sanitize("kcfi") (positive control) *=
/
> +__attribute__((noinline, no_sanitize("kcfi")))
> +void sensitive_non_inline_function(void (*callback)(int))
> +{
> +    /* This indirect call should NOT generate KCFI checks.  */
> +    callback(100);
> +    external_side_effect(100);
> +}
> +
> +/* Function marked with both no_sanitize("kcfi") and always_inline.  */
> +__attribute__((always_inline, no_sanitize("kcfi")))
> +static inline void sensitive_inline_function(void (*callback)(int))
> +{
> +    /* This indirect call should NOT generate KCFI checks when inlined. =
 */
> +    callback(42);
> +    external_side_effect(42);
> +}
> +
> +/* Explicit wrapper for testing sensitive_inline_function behavior.  */
> +__attribute__((noinline))
> +void wrap_sensitive_inline(void (*callback)(int))
> +{
> +    sensitive_inline_function(callback);
> +}
> +
> +/* Function marked with only always_inline (should get KCFI checks) */
> +__attribute__((always_inline))
> +static inline void normal_inline_function(void (*callback)(int))
> +{
> +    /* This indirect call must generate KCFI checks when inlined.  */
> +    callback(200);
> +    external_side_effect(200);
> +}
> +
> +/* Explicit wrapper for testing normal_inline_function behavior.  */
> +__attribute__((noinline))
> +void wrap_normal_inline(void (*callback)(int))
> +{
> +    normal_inline_function(callback);
> +}
> +
> +void test_callback(int value)
> +{
> +    external_side_effect(value);
> +}
> +
> +static void (*volatile function_pointer)(int) =3D test_callback;
> +
> +int main(void)
> +{
> +    void (*fn_ptr)(int) =3D function_pointer;
> +
> +    normal_function(fn_ptr);
> +    wrap_normal_inline(fn_ptr);
> +    sensitive_non_inline_function(fn_ptr);
> +    wrap_sensitive_inline(fn_ptr);
> +
> +    return 0;
> +}
> +
> +/* Verify correct number of KCFI checks: exactly 2 */
> +/* { dg-final { scan-assembler-times {ud2} 2 { target x86_64-*-* } } } *=
/
> +/* { dg-final { scan-assembler-times {brk\s+#[0-9]+} 2 { target aarch64*=
-*-* } } } */
> +/* { dg-final { scan-assembler-times {udf\s+#[0-9]+} 2 { target arm32 } =
} } */
> +/* { dg-final { scan-assembler-times {ebreak} 2 { target riscv*-*-* } } =
} */
> +
> +/* Positive controls: these should have KCFI checks.  */
> +/* { dg-final { scan-assembler {normal_function:.*ud2.*\.size\s+normal_f=
unction} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {wrap_normal_inline:.*ud2.*\.size\s+wrap_=
normal_inline} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {normal_function:.*brk\s+#[0-9]+.*\.size\=
s+normal_function} { target aarch64*-*-* } } } */
> +/* { dg-final { scan-assembler {wrap_normal_inline:.*brk\s+#[0-9]+.*\.si=
ze\s+wrap_normal_inline} { target aarch64*-*-* } } } */
> +/* { dg-final { scan-assembler {normal_function:.*udf\t#[0-9]+.*\.size\s=
+normal_function} { target arm32 } } } */
> +/* { dg-final { scan-assembler {wrap_normal_inline:.*udf\t#[0-9]+.*\.siz=
e\s+wrap_normal_inline} { target arm32 } } } */
> +/* { dg-final { scan-assembler {normal_function:.*ebreak.*\.size\s+norma=
l_function} { target riscv*-*-* } } } */
> +/* { dg-final { scan-assembler {wrap_normal_inline:.*ebreak.*\.size\s+wr=
ap_normal_inline} { target riscv*-*-* } } } */
> +
> +/* Negative controls: these should NOT have KCFI checks.  */
> +/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ud2.=
*\.size\s+sensitive_non_inline_function} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ud2.*\.size\=
s+wrap_sensitive_inline} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*brk\=
s+#[0-9]+.*\.size\s+sensitive_non_inline_function} { target aarch64*-*-* } =
} } */
> +/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*brk\s+#[0-9]=
+.*\.size\s+wrap_sensitive_inline} { target aarch64*-*-* } } } */
> +/* { dg-final { scan-assembler-not {sensitive_non_inline_function:[^\n]*=
udf\t#[0-9]+[^\n]*\.size\tsensitive_non_inline_function} { target arm32 } }=
 } */
> +/* { dg-final { scan-assembler-not {wrap_sensitive_inline:[^\n]*udf\t#[0=
-9]+[^\n]*\.size\twrap_sensitive_inline} { target arm32 } } } */
> +/* { dg-final { scan-assembler-not {sensitive_non_inline_function:.*ebre=
ak.*\.size\s+sensitive_non_inline_function} { target riscv*-*-* } } } */
> +/* { dg-final { scan-assembler-not {wrap_sensitive_inline:.*ebreak.*\.si=
ze\s+wrap_sensitive_inline} { target riscv*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c b/gcc/testsuite=
/gcc.dg/kcfi/kcfi-no-sanitize.c
> new file mode 100644
> index 000000000000..6f1a558c0820
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
> @@ -0,0 +1,39 @@
> +/* Test KCFI with no_sanitize attribute.  */
> +/* { dg-do compile } */
> +
> +void target_function(void) {
> +    /* This should get KCFI preamble.  */
> +}
> +
> +void caller_with_checks(void) {
> +    /* This function should generate KCFI checks.  */
> +    void (*func_ptr)(void) =3D target_function;
> +    func_ptr();
> +}
> +
> +__attribute__((no_sanitize("kcfi")))
> +void caller_no_checks(void) {
> +    /* This function should NOT generate KCFI checks due to no_sanitize.=
  */
> +    void (*func_ptr)(void) =3D target_function;
> +    func_ptr();
> +}
> +
> +int main() {
> +    caller_with_checks();    /* This should generate checks inside.  */
> +    caller_no_checks();      /* This should NOT generate checks inside. =
 */
> +    return 0;
> +}
> +
> +/* All functions should get preambles regardless of no_sanitize.  */
> +/* { dg-final { scan-assembler "__cfi_target_function:" } } */
> +/* { dg-final { scan-assembler "__cfi_caller_with_checks:" } } */
> +/* { dg-final { scan-assembler "__cfi_caller_no_checks:" } } */
> +/* { dg-final { scan-assembler "__cfi_main:" } } */
> +
> +/* caller_with_checks() should generate KCFI check.
> +   caller_no_checks() should NOT generate KCFI check (no_sanitize).
> +   So a total of exactly 1 KCFI check in the entire program.  */
> +/* { dg-final { scan-assembler-times {addl\t-4\(%r[ad]x\), %r1[01]d} 1 {=
 target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-times {ldur\tw16, \[x[0-9]+, #-4\]} 1 { t=
arget aarch64-*-* } } } */
> +/* { dg-final { scan-assembler-times {ldr\tr0, \[r[0-9]+, #-4\]} 1 { tar=
get arm32 } } } */
> +/* { dg-final { scan-assembler-times {lw\tt1, -[0-9]+\(} 1 { target risc=
v*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c b/gcc/tes=
tsuite/gcc.dg/kcfi/kcfi-offset-validation.c
> new file mode 100644
> index 000000000000..f93a042d9752
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
> @@ -0,0 +1,48 @@
> +/* Test KCFI call-site offset validation across architectures.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
> +
> +void target_func_a(void) { }
> +void target_func_b(int x) { }
> +void target_func_c(int x, int y) { }
> +
> +int main() {
> +    void (*ptr_a)(void) =3D target_func_a;
> +    void (*ptr_b)(int) =3D target_func_b;
> +    void (*ptr_c)(int, int) =3D target_func_c;
> +
> +    /* Multiple indirect calls.  */
> +    ptr_a();
> +    ptr_b(1);
> +    ptr_c(1, 2);
> +
> +    return 0;
> +}
> +
> +/* Should have KCFI preambles for all functions.  */
> +/* { dg-final { scan-assembler "__cfi_target_func_a:" } } */
> +/* { dg-final { scan-assembler "__cfi_target_func_b:" } } */
> +/* { dg-final { scan-assembler "__cfi_target_func_c:" } } */
> +
> +/* x86_64: All call sites should use -4 offset for KCFI type ID loads, e=
ven
> +   with -falign-functions=3D16 (we're not using patchable entries here).=
  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[=
a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
> +
> +/* AArch64: All call sites should use -4 offset.  */
> +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aa=
rch64*-*-* } } } */
> +
> +/* ARM 32-bit: All call sites should use -4 offset with stack spilling. =
 */
> +/* { dg-final { scan-assembler {ldr\tr0, \[r[0-9]+, #-4\]} { target arm3=
2 } } } */
> +
> +/* RISC-V: All call sites should use -4 offset.  */
> +/* { dg-final { scan-assembler {lw\tt1, -4\(} { target riscv*-*-* } } } =
*/
> +
> +/* Should have trap section.  */
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } =
*/
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } =
*/
> +
> +/* AArch64 should NOT have trap section (uses brk immediate instead) */
> +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target aarch64*-*-* =
} } } */
> +
> +/* ARM 32-bit should NOT have trap section (uses udf immediate instead) =
*/
> +/* { dg-final { scan-assembler-not {\.kcfi_traps} { target arm32 } } } *=
/
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c b/gcc/tests=
uite/gcc.dg/kcfi/kcfi-patchable-basic.c
> new file mode 100644
> index 000000000000..a2d0ef0c6ff6
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-basic.c
> @@ -0,0 +1,70 @@
> +/* Test KCFI with patchable function entries - basic case.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-fpatchable-function-entry=3D5,2" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
> +
> +void test_function(int x) {
> +    /* Function should get both KCFI preamble and patchable entries.  */
> +}
> +
> +int main() {
> +    test_function(42);
> +    return 0;
> +}
> +
> +/* Should have KCFI preamble.  */
> +/* { dg-final { scan-assembler "__cfi_test_function:" } } */
> +
> +/* Should have patchable function entry section.  */
> +/* { dg-final { scan-assembler "__patchable_function_entries" } } */
> +
> +/* x86_64: Should have exactly 2 prefix NOPs between .LPFE and .type.  *=
/
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*\.type=
} { target x86_64-*-* } } } */
> +
> +/* x86_64: Should have exactly 3 entry NOPs between .cfi_startproc and
> +   pushq.  */
> +/* { dg-final { scan-assembler {\.cfi_startproc\n\t*nop\n\t*nop\n\t*nop\=
n\t*pushq} { target x86_64-*-* } } } */
> +
> +/* x86_64: KCFI should have exactly 9 NOPs between __cfi_ and movl.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t=
*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*movl} { target x86=
_64-*-* } } } */
> +
> +/* x86_64: Validate KCFI type ID is present.  */
> +/* { dg-final { scan-assembler {movl\t\$0x[0-9a-f]+, %eax} { target x86_=
64-*-* } } } */
> +
> +/* AArch64: Should have exactly 2 prefix NOPs between .LPFE and .type.  =
*/
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*\.type=
} { target aarch64*-*-* } } } */
> +
> +/* AArch64: Should have exactly 3 entry NOPs between .cfi_startproc and
> +   stack manipulation.  */
> +/* { dg-final { scan-assembler {\.cfi_startproc\n\t*nop\n\t*nop\n\t*nop\=
n\t*sub\t*sp} { target aarch64*-*-* } } } */
> +
> +/* AArch64: KCFI should have alignment NOPs then .word immediate.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t=
*\.word\t0x[0-9a-f]+} { target aarch64*-*-* } } } */
> +
> +/* AArch64: Validate clean KCFI boundary - .word then immediate end/size=
.  */
> +/* { dg-final { scan-assembler {\.word\t0x[0-9a-f]+\n\.Lcfi_func_end_tes=
t_function:\n\t\.size\t__cfi_test_function, \.-__cfi_test_function} { targe=
t aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: Should have exactly 2 prefix NOPs between .LPFE and .synt=
ax.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*\.synt=
ax} { target arm32 } } } */
> +
> +/* ARM 32-bit: Should have exactly 3 entry NOPs after function label.  *=
/
> +/* { dg-final { scan-assembler {test_function:\n\t*nop\n\t*nop\n\t*nop} =
{ target arm32 } } } */
> +
> +/* ARM 32-bit: KCFI should have alignment NOPs then .word immediate.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t=
*\.word\t0x[0-9a-f]+} { target arm32 } } } */
> +
> +/* ARM 32-bit: Validate clean KCFI boundary - .word then immediate end/s=
ize.  */
> +/* { dg-final { scan-assembler {\.word\t0x[0-9a-f]+\n\.Lcfi_func_end_tes=
t_function:\n\t\.size\t__cfi_test_function, \.-__cfi_test_function} { targe=
t arm32 } } } */
> +
> +/* RISC-V: Should have exactly 2 prefix NOPs between .LPFE and .type.  *=
/
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*\.type=
} { target riscv*-*-* } } } */
> +
> +/* RISC-V: Should have exactly 3 entry NOPs before .cfi_startproc follow=
ed
> +   by addi sp.  */
> +/* { dg-final { scan-assembler {nop\n\t*nop\n\t*nop\n\.LFB[0-9]+:\n\t*\.=
cfi_startproc\n\t*addi\t*sp} { target riscv*-*-* } } } */
> +
> +/* RISC-V: KCFI should have alignment NOPs then .word immediate.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t=
*\.word\t0x[0-9a-f]+} { target riscv*-*-* } } } */
> +
> +/* RISC-V: Validate clean KCFI boundary - .word then immediate end/size.=
  */
> +/* { dg-final { scan-assembler {\.word\t0x[0-9a-f]+\n\.Lcfi_func_end_tes=
t_function:\n\t\.size\t__cfi_test_function, \.-__cfi_test_function} { targe=
t riscv*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c b/gcc/=
testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
> new file mode 100644
> index 000000000000..62e1926e107e
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
> @@ -0,0 +1,62 @@
> +/* Test KCFI with patchable function entries - entry NOPs only.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-fpatchable-function-entry=3D4,0" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
> +
> +void test_function(void) {
> +}
> +
> +static void caller(void) {
> +    /* Make an indirect call to test callsite offset calculation.  */
> +    void (*func_ptr)(void) =3D test_function;
> +    func_ptr();
> +}
> +
> +int main() {
> +    test_function();  /* Direct call.  */
> +    caller();         /* Indirect call via static function.  */
> +    return 0;
> +}
> +
> +/* x86_64: Should have KCFI preamble with architecture alignment NOPs (1=
1).  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t+nop\n\t+nop\n\t=
+nop\n\t+nop\n\t+nop\n\t+nop\n\t+nop\n\t+nop\n\t+nop\n\t+nop\n\t+nop\n\t+mo=
vl\t+\$0x[0-9a-f]+, %eax} { target x86_64-*-* } } } */
> +
> +/* AArch64: Should have KCFI preamble with no alignment NOPs.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*\.word\t0x[0-9a=
-f]+} { target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: Should have KCFI preamble with no alignment NOPs.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t\.word\t0x[0-9a-=
f]+} { target arm32 } } } */
> +
> +/* RISC-V: Should have KCFI preamble with no alignment NOPs.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t\.word\t0x[0-9a-=
f]+} { target riscv*-*-* } } } */
> +
> +/* x86_64: Indirect call should use original prefix NOPs (0) for offset
> +   calculation: -4 offset.  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[=
a-z0-9]+\), %r10d\n\tje\t(\.Lkcfi_call[0-9]+)\n\.Lkcfi_trap[0-9]+:\n\tud2\n=
.*\n\1:\n\tcall} { target x86_64-*-* } } } */
> +
> +/* x86_64: All 4 NOPs are entry NOPs - should have exactly 4 entry NOPs.=
  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*pushq} { target x86_64-*-* } } } */
> +
> +/* AArch64: All 4 NOPs are entry NOPs - should have exactly 4 entry NOPs=
.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*stp} { target aarch64*-*-* } } } */
> +
> +/* AArch64: No alignment NOPs - function type should come immediately be=
fore
> +   function.  */
> +/* { dg-final { scan-assembler {\.type\t*test_function, %function\n*test=
_function:} { target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: All 4 NOPs are entry NOPs - should have exactly 4 entry N=
OPs.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop} { target arm32 } } } */
> +
> +/* ARM 32-bit: No alignment NOPs - function type should come immediately
> +   before function.  */
> +/* { dg-final { scan-assembler {\.type\t*test_function, %function\n*test=
_function:} { target arm32 } } } */
> +
> +/* RISC-V: All 4 NOPs are entry NOPs.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\.LFB} { target riscv*-*-* } } } */
> +
> +/* RISC-V: No alignment NOPs - function type should come immediately
> +   before function.  */
> +/* { dg-final { scan-assembler {\.type\t*test_function, @function\n*test=
_function:} { target riscv*-*-* } } } */
> +
> +/* Should have patchable function entry section.  */
> +/* { dg-final { scan-assembler "__patchable_function_entries" } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c b/gcc/tests=
uite/gcc.dg/kcfi/kcfi-patchable-large.c
> new file mode 100644
> index 000000000000..3d5618847840
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
> @@ -0,0 +1,51 @@
> +/* Test KCFI with large patchable function entries.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-fpatchable-function-entry=3D11,11" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
> +
> +void test_function(void) {
> +}
> +
> +int main() {
> +    void (*func_ptr)(void) =3D test_function;
> +    func_ptr();
> +    return 0;
> +}
> +
> +/* Should have KCFI preamble.  */
> +/* { dg-final { scan-assembler "__cfi_test_function:" } } */
> +
> +/* Should have patchable function entry section.  */
> +/* { dg-final { scan-assembler "__patchable_function_entries" } } */
> +
> +/* x86_64: Should have exactly 11 alignment NOPs between .LPFE and .type=
.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} {=
 target x86_64-*-* } } } */
> +
> +/* x86_64: Should have 0 entry NOPs - function starts immediately with
> +   pushq.  */
> +/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_s=
tartproc\n\t*pushq\t*%rbp} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_funct=
ion\n} { target x86_64-*-* } } } */
> +
> +/* x86_64: KCFI should have 0 entry NOPs - goes directly to typeid movl.=
  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*movl\t\$0x[0-9a=
-f]+, %eax} { target x86_64-*-* } } } */
> +
> +/* x86_64: Call site should use -15 offset.  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-15\(%r=
[a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
> +
> +/* AArch64: Should have exactly 11 prefix NOPs between .LPFE and .type. =
 */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} {=
 target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: Should have exactly 11 prefix NOPs between .LPFE and .typ=
e.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop} { target arm=
32 } } } */
> +
> +/* AArch64: Call site should use -15 offset.  */
> +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-15\]} { target a=
arch64*-*-* } } } */
> +
> +/* ARM 32-bit: Call site should use -15 offset.  */
> +/* { dg-final { scan-assembler {ldr\tr0, \[r[0-9]+, #-15\]} { target arm=
32 } } } */
> +
> +/* RISC-V: Should have 11 prefix NOPs between .LPFE and .type.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*\.type} {=
 target riscv*-*-* } } } */
> +
> +/* RISC-V: Call site should use -15 offset (same as x86/AArch64).  */
> +/* { dg-final { scan-assembler {lw\tt1, -15\(} { target riscv*-*-* } } }=
 */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c b/gcc/test=
suite/gcc.dg/kcfi/kcfi-patchable-medium.c
> new file mode 100644
> index 000000000000..4f00a86dbcb7
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
> @@ -0,0 +1,60 @@
> +/* Test KCFI with medium patchable function entries.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-fpatchable-function-entry=3D8,4" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
> +
> +void test_function(void) {
> +}
> +
> +int main() {
> +    void (*func_ptr)(void) =3D test_function;
> +    func_ptr();
> +    return 0;
> +}
> +
> +/* Should have KCFI preamble.  */
> +/* { dg-final { scan-assembler "__cfi_test_function:" } } */
> +
> +/* Should have patchable function entry section.  */
> +/* { dg-final { scan-assembler "__patchable_function_entries" } } */
> +
> +/* x86_64: Should have exactly 4 prefix NOPs between .LPFE and .type.  *=
/
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*\.type} { target x86_64-*-* } } } */
> +
> +/* x86_64: Should have exactly 4 entry NOPs between .cfi_startproc and
> +   pushq.  */
> +/* { dg-final { scan-assembler {\.cfi_startproc\n\t*nop\n\t*nop\n\t*nop\=
n\t*nop\n\t*pushq} { target x86_64-*-* } } } */
> +
> +/* x86_64: KCFI should have exactly 7 alignment NOPs between __cfi_ and
> +   typeid movl.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t=
*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*movl\t\$0x[0-9a-f]+, %eax} { targe=
t x86_64-*-* } } } */
> +
> +/* x86_64: Call site should use -8 offset.  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-8\(%r[=
a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
> +
> +/* AArch64: Should have exactly 4 prefix NOPs between .LPFE and .type.  =
*/
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*\.type} { target aarch64*-*-* } } } */
> +
> +/* AArch64: Should have exactly 4 entry NOPs after .cfi_startproc.  */
> +/* { dg-final { scan-assembler {\.cfi_startproc\n\t*nop\n\t*nop\n\t*nop\=
n\t*nop} { target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: Should have exactly 4 prefix NOPs between .LPFE and .synt=
ax.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*\.syntax} { target arm32 } } } */
> +
> +/* ARM 32-bit: Should have exactly 4 entry NOPs after function label.  *=
/
> +/* { dg-final { scan-assembler {test_function:\n\t*nop\n\t*nop\n\t*nop\n=
\t*nop} { target arm32 } } } */
> +
> +/* AArch64: Call site should use -8 offset.  */
> +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-8\]} { target aa=
rch64*-*-* } } } */
> +
> +/* ARM 32-bit: Call site should use -8 offset.  */
> +/* { dg-final { scan-assembler {ldr\tr0, \[r[0-9]+, #-8\]} { target arm3=
2 } } } */
> +
> +/* RISC-V: Should have exactly 4 prefix NOPs between .LPFE and .type.  *=
/
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*nop\n\t*\.type} { target riscv*-*-* } } } */
> +
> +/* RISC-V: Should have 4 entry NOPs.  */
> +/* { dg-final { scan-assembler {test_function:\n\t*nop\n\t*nop\n\t*nop\n=
\t*nop\n\.LFB} { target riscv*-*-* } } } */
> +
> +/* RISC-V: Call site should use -8 offset (same as x86/AArch64) */
> +/* { dg-final { scan-assembler {lw\tt1, -8\(} { target riscv*-*-* } } } =
*/
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c b/gcc=
/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
> new file mode 100644
> index 000000000000..98c53ef52989
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.c
> @@ -0,0 +1,60 @@
> +/* Test KCFI with patchable function entries - prefix NOPs only.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-fpatchable-function-entry=3D3,3" } */
> +/* { dg-additional-options "-falign-functions=3D16" { target x86_64-*-* =
} } */
> +
> +void test_function(void) {
> +}
> +
> +int main() {
> +    test_function();
> +    return 0;
> +}
> +
> +/* Should have KCFI preamble.  */
> +/* { dg-final { scan-assembler "__cfi_test_function:" } } */
> +
> +/* x86_64: All 3 NOPs are prefix NOPs - should have exactly 3 prefix NOP=
s.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*\.type\t*test_function} { target x86_64-*-* } } } */
> +
> +/* x86_64: No entry NOPs - function should start immediately with prolog=
ue. */
> +/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_s=
tartproc\n\t*pushq\t*%rbp} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_funct=
ion\n} { target x86_64-*-* } } } */
> +
> +/* x86_64: should have exactly 8 alignment NOPs.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*nop\n\t=
*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*nop\n\t*movl} { target x86_64-*-* =
} } } */
> +
> +/* AArch64: All 3 NOPs are prefix NOPs - should have exactly 3 prefix NO=
Ps.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*\.type\t*test_function} { target aarch64*-*-* } } } */
> +
> +/* AArch64: No entry NOPs - function should start immediately with prolo=
gue.  */
> +/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_s=
tartproc\n\t*nop\n\t*ret} { target aarch64*-*-* } } } */
> +/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_funct=
ion\n} { target aarch64*-*-* } } } */
> +
> +/* AArch64: KCFI type ID should have 1 alignment NOP then word.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*\.word\=
t0x[0-9a-f]+} { target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: All 3 NOPs are prefix NOPs - should have exactly 3 prefix=
 NOPs.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop} {=
 target arm32 } } } */
> +
> +/* ARM 32-bit: No entry NOPs - function should start immediately with
> +   prologue.  */
> +/* { dg-final { scan-assembler {test_function:} { target arm32 } } } */
> +/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_funct=
ion\n} { target arm32 } } } */
> +
> +/* ARM 32-bit: KCFI type ID should have 1 alignment NOP then word.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*\.word\=
t0x[0-9a-f]+} { target arm32 } } } */
> +
> +/* RISC-V: All 3 NOPs are prefix NOPs - should have exactly 3 prefix NOP=
s.  */
> +/* { dg-final { scan-assembler {\.LPFE[0-9]+:\n\t*nop\n\t*nop\n\t*nop\n\=
t*\.type\t*test_function} { target riscv*-*-* } } } */
> +
> +/* RISC-V: No entry NOPs - function should start immediately with
> +   .cfi_startproc.  */
> +/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_s=
tartproc} { target riscv*-*-* } } } */
> +/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_funct=
ion\n} { target riscv*-*-* } } } */
> +
> +/* RISC-V: KCFI type ID should have 1 alignment NOP then word.  */
> +/* { dg-final { scan-assembler {__cfi_test_function:\n\t*nop\n\t*\.word\=
t0x[0-9a-f]+} { target riscv*-*-* } } } */
> +
> +/* Should have patchable function entry section.  */
> +/* { dg-final { scan-assembler "__patchable_function_entries" } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c b/gcc/testsu=
ite/gcc.dg/kcfi/kcfi-pic-addressing.c
> new file mode 100644
> index 000000000000..26323db4572f
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-pic-addressing.c
> @@ -0,0 +1,104 @@
> +/* Test KCFI with position-independent code addressing modes.
> +   This is a regression test for complex addressing like
> +   PLUS(PLUS(...), symbol_ref) which can occur with PIC and caused
> +   change_address_1 RTL errors.  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2 -fpic" } */
> +
> +/* Global function pointer table that creates PIC addressing.  */
> +struct callbacks {
> +    int (*handler1)(int);
> +    void (*handler2)(void);
> +    int (*handler3)(int, int);
> +};
> +
> +static int simple_handler(int x) {
> +    return x * 2;
> +}
> +
> +static void void_handler(void) {
> +    /* Empty handler.  */
> +}
> +
> +static int complex_handler(int a, int b) {
> +    return a + b;
> +}
> +
> +/* Global structure that will require PIC addressing.  */
> +struct callbacks global_callbacks =3D {
> +    .handler1 =3D simple_handler,
> +    .handler2 =3D void_handler,
> +    .handler3 =3D complex_handler
> +};
> +
> +/* Function that uses PIC addressing to access global callbacks.  */
> +int test_pic_addressing(int value) {
> +    /* These indirect calls through global structure create complex
> +       addressing like PLUS(PLUS(GOT_base, symbol_offset), struct_offset=
)
> +       which previously caused RTL errors in KCFI instrumentation.  */
> +
> +    int result =3D 0;
> +    result +=3D global_callbacks.handler1(value);
> +
> +    global_callbacks.handler2();
> +
> +    result +=3D global_callbacks.handler3(value, result);
> +
> +    return result;
> +}
> +
> +/* Test with function pointer arrays.  */
> +static int (*func_array[])(int) =3D {
> +    simple_handler,
> +    simple_handler,
> +    simple_handler
> +};
> +
> +int test_pic_array(int index, int value) {
> +    /* Array access with PIC can also create complex addressing.  */
> +    return func_array[index % 3](value);
> +}
> +
> +/* Test with dynamic PIC addressing.  */
> +struct callbacks *get_callbacks(void) {
> +    return &global_callbacks;
> +}
> +
> +int test_dynamic_pic(int value) {
> +    /* Dynamic access through function call creates very complex address=
ing.  */
> +    struct callbacks *cb =3D get_callbacks();
> +    return cb->handler1(value) + cb->handler3(value, value);
> +}
> +
> +int main() {
> +    int result =3D 0;
> +    result +=3D test_pic_addressing(10);
> +    result +=3D test_pic_array(1, 20);
> +    result +=3D test_dynamic_pic(5);
> +    return result;
> +}
> +
> +/* Verify that all address-taken functions get KCFI preambles.  */
> +/* { dg-final { scan-assembler {__cfi_simple_handler:} } } */
> +/* { dg-final { scan-assembler {__cfi_void_handler:} } } */
> +/* { dg-final { scan-assembler {__cfi_complex_handler:} } } */
> +
> +/* x86_64: Verify KCFI checks are generated.  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r10d\n\taddl\t-4\(%r[=
a-z0-9]+\), %r10d} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler {ud2} { target x86_64-*-* } } } */
> +
> +/* AArch64: Verify KCFI checks.  */
> +/* { dg-final { scan-assembler {ldur\tw16, \[x[0-9]+, #-4\]} { target aa=
rch64*-*-* } } } */
> +/* { dg-final { scan-assembler {brk} { target aarch64*-*-* } } } */
> +
> +/* ARM 32-bit: Verify KCFI checks with PIC addressing and stack spilling=
.  */
> +/* { dg-final { scan-assembler {ldr\tr0, \[r[0-9]+, #-4\]} { target arm3=
2 } } } */
> +/* { dg-final { scan-assembler {udf} { target arm32 } } } */
> +
> +/* RISC-V: Verify KCFI checks are generated.  */
> +/* { dg-final { scan-assembler {lw\tt1, -4\([a-z0-9]+\)\n\tlui\tt2, [0-9=
]+\n\taddiw\tt2, t2, -?[0-9]+} { target riscv*-*-* } } } */
> +/* { dg-final { scan-assembler {ebreak} { target riscv*-*-* } } } */
> +
> +/* Should have trap section.  */
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target x86_64-*-* } } } =
*/
> +/* { dg-final { scan-assembler {\.kcfi_traps} { target riscv*-*-* } } } =
*/
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-retpoline-r11.c b/gcc/testsui=
te/gcc.dg/kcfi/kcfi-retpoline-r11.c
> new file mode 100644
> index 000000000000..79e5ca61cdc2
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-retpoline-r11.c
> @@ -0,0 +1,50 @@
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
> +/* { dg-final { scan-assembler-times {call\s+__x86_indirect_thunk_r11} 1=
 } } */
> +
> +/* Sibcalls should also use r11 register and convert to extern thunks.  =
*/
> +/* { dg-final { scan-assembler-times {jmp\s+__x86_indirect_thunk_r11} 1 =
} } */
> +
> +/* Should have exactly 2 KCFI traps (one per function) */
> +/* { dg-final { scan-assembler-times {ud2} 2 } } */
> +
> +/* Should NOT use other registers for indirect calls.  */
> +/* { dg-final { scan-assembler-not {call\s+\*%rax} } } */
> +/* { dg-final { scan-assembler-not {call\s+\*%rcx} } } */
> +/* { dg-final { scan-assembler-not {call\s+\*%rdx} } } */
> +/* { dg-final { scan-assembler-not {call\s+\*%rdi} } } */
> +
> +/* Should NOT use other registers for sibcalls.  */
> +/* { dg-final { scan-assembler-not {jmp\s+\*%rax} } } */
> +/* { dg-final { scan-assembler-not {jmp\s+\*%rcx} } } */
> +/* { dg-final { scan-assembler-not {jmp\s+\*%rdx} } } */
> +/* { dg-final { scan-assembler-not {jmp\s+\*%rdi} } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c b/gcc/testsuite/gcc=
.dg/kcfi/kcfi-runtime.c
> new file mode 100644
> index 000000000000..6ad8fab5da80
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
> @@ -0,0 +1,151 @@
> +/* Test KCFI runtime behavior: working calls and type mismatch trapping.
> +   { dg-do run { target native } }
> +   { dg-options "-fsanitize=3Dkcfi" } */
> +
> +#include <stdio.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +/* Test functions with different signatures */
> +static int func_int_void(void)
> +{
> +    return 42;
> +}
> +
> +__attribute__((nocf_check))
> +static int func_int_void_nocf_check(void)
> +{
> +    return 42;
> +}
> +
> +static int func_int_int(int x)
> +{
> +    return x * 4;
> +}
> +
> +/* Global state for signal handling */
> +static volatile int trap_occurred =3D 0;
> +static jmp_buf trap_env;
> +
> +/* Signal handler for KCFI traps */
> +static void trap_handler(int sig)
> +{
> +    trap_occurred =3D 1;
> +    longjmp(trap_env, 1);
> +}
> +
> +/* Compatible indirect call should work */
> +static int test_compatible_call(void)
> +{
> +    typedef int (*int_void_ptr)(void);
> +    int_void_ptr ptr =3D func_int_void;
> +
> +    fprintf(stderr, "Calling %s(0x%08x) through %s(0x%08x) ...\n",
> +           __builtin_typeinfo_name(typeof(func_int_void)),
> +           __builtin_typeinfo_hash(typeof(func_int_void)),
> +           __builtin_typeinfo_name(typeof(*ptr)),
> +           __builtin_typeinfo_hash(typeof(*ptr)));
> +
> +    trap_occurred =3D 0;
> +    /* This should work - same signature */
> +    int result =3D ptr();
> +
> +    return (trap_occurred =3D=3D 0 && result =3D=3D 42) ? 1 : 0;
> +}
> +
> +/* Compatible indirect call to nocf_check should not work */
> +static int test_nocf_check_trap(void)
> +{
> +    trap_occurred =3D 0;
> +
> +    if (setjmp(trap_env) =3D=3D 0) {
> +      typedef int (__attribute__((nocf_check)) *int_void_ptr_nocf)(void)=
;
> +      int_void_ptr_nocf ptr =3D func_int_void_nocf_check;
> +
> +      fprintf(stderr, "Calling %s(0x%08x) through %s(0x%08x) ...\n",
> +             __builtin_typeinfo_name(typeof(func_int_void_nocf_check)),
> +             __builtin_typeinfo_hash(typeof(func_int_void_nocf_check)),
> +             __builtin_typeinfo_name(typeof(*ptr)),
> +             __builtin_typeinfo_hash(typeof(*ptr)));
> +
> +      int result =3D ptr();
> +
> +      /* If we get here, the trap didn't occur */
> +      return 0;
> +    } else {
> +      /* We caught the trap - this is expected */
> +      return trap_occurred;
> +    }
> +}
> +
> +/* Type mismatch should trap */
> +static int test_type_mismatch_trap(void)
> +{
> +    trap_occurred =3D 0;
> +
> +    if (setjmp(trap_env) =3D=3D 0) {
> +      /* Cast func_int_void to incompatible void(*)(void) type */
> +      typedef void (*void_void_ptr)(void);
> +      void_void_ptr ptr =3D (void_void_ptr)func_int_void;
> +
> +      fprintf(stderr, "Calling %s(0x%08x) through %s(0x%08x) ...\n",
> +             __builtin_typeinfo_name(typeof(func_int_void)),
> +             __builtin_typeinfo_hash(typeof(func_int_void)),
> +             __builtin_typeinfo_name(typeof(*ptr)),
> +             __builtin_typeinfo_hash(typeof(*ptr)));
> +
> +      /* This should trap because type IDs don't match:
> +         - func_int_void has type ID for int(void)
> +         - but we're calling through void(void) pointer type */
> +      ptr();
> +
> +      /* If we get here, the trap didn't occur */
> +      return 0;
> +    } else {
> +      /* We caught the trap - this is expected */
> +      return trap_occurred;
> +    }
> +}
> +
> +int main(void)
> +{
> +    struct sigaction sa =3D {
> +      .sa_handler =3D trap_handler,
> +      .sa_flags =3D SA_NODEFER,
> +    };
> +    int failed =3D 3;
> +
> +    /* Install trap handler.  */
> +    if (sigaction(SIGILL, &sa, NULL)) {
> +      perror("sigaction");
> +      return 1;
> +    }
> +
> +    /* Compatible call should work */
> +    if (test_compatible_call()) {
> +      printf("OK: matched indirect call succeeded\n");
> +      failed--;
> +    } else {
> +      printf("FAIL\n");
> +    }
> +
> +    /* Using nocf_check should trap */
> +    if (test_nocf_check_trap()) {
> +      printf("OK: indirect call to nocf_check correctly trapped\n");
> +      failed--;
> +    } else {
> +      printf("FAIL\n");
> +    }
> +
> +    /* Type mismatch should trap */
> +    if (test_type_mismatch_trap()) {
> +      printf("OK: mismatched indirect call correctly trapped\n");
> +      failed--;
> +    } else {
> +      printf("FAIL\n");
> +    }
> +
> +    return failed;
> +}
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c b/gcc/testsuite/=
gcc.dg/kcfi/kcfi-tail-calls.c
> new file mode 100644
> index 000000000000..e2e3912fffa3
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
> @@ -0,0 +1,142 @@
> +/* Test KCFI protection when indirect calls get converted to tail calls.=
  */
> +/* { dg-do compile } */
> +/* { dg-additional-options "-O2" } */
> +
> +typedef int (*func_ptr_t)(int);
> +typedef void (*void_func_ptr_t)(void);
> +
> +struct function_table {
> +    func_ptr_t process;
> +    void_func_ptr_t cleanup;
> +};
> +
> +/* Target functions.  */
> +int process_data(int x) { return x * 2; }
> +void cleanup_data(void) {}
> +
> +/* Initialize function table.  */
> +volatile struct function_table vtable =3D {
> +    .process =3D &process_data,
> +    .cleanup =3D &cleanup_data
> +};
> +
> +/* Indirect call through struct member that should become tail call.  */
> +int test_struct_indirect_call(int x) {
> +    /* This is an indirect call that should be converted to tail call:
> +       Without -fno-optimize-sibling-calls should become "jmp *vtable+0(=
%rip)"
> +       With -fno-optimize-sibling-calls should become "call *vtable+0(%r=
ip)"  */
> +    return vtable.process(x);
> +}
> +
> +/* Indirect call through function pointer parameter.  */
> +int test_param_indirect_call(func_ptr_t handler, int x) {
> +    /* This is an indirect call that should be converted to tail call:
> +       Without -fno-optimize-sibling-calls should become "jmp *%rdi"
> +       With -fno-optimize-sibling-calls should be "call *%rdi"  */
> +    return handler(x);
> +}
> +
> +/* Void indirect call through struct member.  */
> +void test_void_indirect_call(void) {
> +    /* This is an indirect call that should be converted to tail call:
> +     * Without -fno-optimize-sibling-calls: should become "jmp *vtable+8=
(%rip)"
> +     * With -fno-optimize-sibling-calls: should be "call *vtable+8(%rip)=
"  */
> +    vtable.cleanup();
> +}
> +
> +/* Non-tail call for comparison (should always be call).  */
> +int test_non_tail_indirect_call(func_ptr_t handler, int x) {
> +    /* This should never become a tail call - always "call *%rdi"  */
> +    int result =3D handler(x);
> +    return result + 1;  /* Prevents tail call optimization.  */
> +}
> +
> +/* Should have KCFI preambles for all functions.  */
> +/* { dg-final { scan-assembler-times "__cfi_process_data:" 1 } } */
> +/* { dg-final { scan-assembler-times "__cfi_cleanup_data:" 1 } } */
> +/* { dg-final { scan-assembler-times "__cfi_test_struct_indirect_call:" =
1 } } */
> +/* { dg-final { scan-assembler-times "__cfi_test_param_indirect_call:" 1=
 } } */
> +/* { dg-final { scan-assembler-times "__cfi_test_void_indirect_call:" 1 =
} } */
> +/* { dg-final { scan-assembler-times "__cfi_test_non_tail_indirect_call:=
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
> +/* { dg-final { scan-assembler-times "\\.kcfi_traps" 4 { target riscv*-*=
-* } } } */
> +/* { dg-final { scan-assembler-times "ebreak" 4 { target riscv*-*-* } } =
} */
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
> +
> +/* RISC-V: Should have exactly 4 KCFI checks for indirect calls
> +   (comparison instruction).  */
> +/* { dg-final { scan-assembler-times {beq\tt1, t2, \.Lkcfi_call[0-9]+} 4=
 { target riscv*-*-* } } } */
> +
> +/* RISC-V: Should have exactly 4 KCFI checks for indirect calls as
> +   (load type ID + compare).  */
> +/* { dg-final { scan-assembler-times {lw\tt1, -4\([a-z0-9]+\)} 4 { targe=
t riscv*-*-* } } } */
> +/* { dg-final { scan-assembler-times {lui\tt2, [0-9]+} 4 { target riscv*=
-*-* } } } */
> +
> +/* RISC-V: Should have exactly 3 protected tail calls (jr after
> +   KCFI check - no return address save).  */
> +/* { dg-final { scan-assembler-times {jalr\t(x0|zero), [a-z0-9]+, 0} 3 {=
 target riscv*-*-* } } } */
> +
> +/* RISC-V: Should have exactly 1 regular call (non-tail call case - save=
s
> +   return address).  */
> +/* { dg-final { scan-assembler-times {jalr\t(x1|ra), [a-z0-9]+, 0} 1 { t=
arget riscv*-*-* } } } */
> +
> +/* Type ID loading should use lui + addiw pattern for 32-bit constants. =
 */
> +/* { dg-final { scan-assembler {lui\tt2, [0-9]+} { target riscv*-*-* } }=
 } */
> +/* { dg-final { scan-assembler {addiw\tt2, t2, -?[0-9]+} { target riscv*=
-*-* } } } */
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
> +
> +/* Should have exactly 4 KCFI checks for indirect calls (load type ID fr=
om
> +   -4 offset + compare).  */
> +/* { dg-final { scan-assembler-times {ldr\tr0, \[r[0-9]+, #-4\]} 4 { tar=
get arm32 } } } */
> +/* { dg-final { scan-assembler-times {cmp\tr0, r1} 4 { target arm32 } } =
} */
> +
> +/* Should have exactly 4 trap instructions.  */
> +/* { dg-final { scan-assembler-times {udf\t#[0-9]+} 4 { target arm32 } }=
 } */
> +
> +/* Should have exactly 3 protected tail calls (bx through register after
> +   KCFI check).  */
> +/* { dg-final { scan-assembler-times {bx\tr[0-9]+} 3 { target arm32 } } =
} */
> +
> +/* Should have exactly 1 regular call (non-tail call case).  */
> +/* { dg-final { scan-assembler-times {blx\tr[0-9]+} 1 { target arm32 } }=
 } */
> +
> +/* Type ID loading should use movw + movt pattern for 32-bit constants
> +   into r1.  */
> +/* { dg-final { scan-assembler {movw\tr1, #[0-9]+} { target arm32 } } } =
*/
> +/* { dg-final { scan-assembler {movt\tr1, #[0-9]+} { target arm32 } } } =
*/
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c b/gcc/testsui=
te/gcc.dg/kcfi/kcfi-trap-encoding.c
> new file mode 100644
> index 000000000000..f2226fa58ac9
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
> @@ -0,0 +1,54 @@
> +/* Test AArch64 and ARM32 KCFI trap encoding in BRK/UDF instructions.  *=
/
> +/* { dg-do compile { target { aarch64*-*-* || arm32 } } } */
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
> +
> +   A truly dynamic test would need to extract the register from blr and =
compute
> +   the corresponding ESR, but DejaGnu's regex limitations make this comp=
lex.
> +   This test validates the specific case and documents the encoding.
> +   */
> +/* { dg-final { scan-assembler "blr\\s+x2" { target aarch64*-*-* } } } *=
/
> +/* { dg-final { scan-assembler "brk\\s+#33314" { target aarch64*-*-* } }=
 } */
> +
> +/* Should have KCFI check with type comparison.  */
> +/* { dg-final { scan-assembler {ldur\t*w16, \[x[0-9]+, #-4\]} { target a=
arch64*-*-* } } } */
> +/* { dg-final { scan-assembler {cmp\t*w16, w17} { target aarch64*-*-* } =
} } */
> +
> +/* ARM32 specific: Should have UDF instruction with proper encoding
> +   UDF format: 0x8000 | ((type_reg & 31) << 5) | (addr_reg & 31)
> +
> +   Since ARM32 spills and restores r0/r1 before the trap, the type_reg
> +   field uses 0x1F (31) to indicate "register was spilled" rather than
> +   pointing to a live register. The addr_reg field contains the actual
> +   target register number.
> +
> +   For this test case using r3, we expect:
> +   UDF =3D 0x8000 | (31 << 5) | 3 =3D 0x8000 | 0x3E0 | 3 =3D 33763
> +   */
> +/* { dg-final { scan-assembler "blx\\s+r3" { target arm32 } } } */
> +/* { dg-final { scan-assembler "udf\\s+#33763" { target arm32 } } } */
> +
> +/* Should have register spilling and restoration around type check.  */
> +/* { dg-final { scan-assembler {push\t*\{r0, r1\}} { target arm32 } } } =
*/
> +/* { dg-final { scan-assembler {pop\t*\{r0, r1\}} { target arm32 } } } *=
/
> +/* { dg-final { scan-assembler {ldr\t*r0, \[r[0-9]+, #-4\]} { target arm=
32 } } } */
> +/* { dg-final { scan-assembler {cmp\t*r0, r1} { target arm32 } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c b/gcc/testsuit=
e/gcc.dg/kcfi/kcfi-trap-section.c
> new file mode 100644
> index 000000000000..7f5f8a82f3dc
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
> @@ -0,0 +1,41 @@
> +/* Test KCFI trap section generation.  */
> +/* { dg-do compile } */
> +
> +void target_function(void) {}
> +
> +int main() {
> +    void (*func_ptr)(void) =3D target_function;
> +
> +    /* Multiple indirect calls to generate multiple trap entries.  */
> +    func_ptr();
> +    func_ptr();
> +
> +    return 0;
> +}
> +
> +/* Should have KCFI preamble.  */
> +/* { dg-final { scan-assembler "__cfi_target_function:" } } */
> +
> +/* Should have exactly 2 trap labels in code.  */
> +/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ud2} 2 { target x86_=
64-*-* } } } */
> +/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*brk} 2 { target aarc=
h64*-*-* } } } */
> +/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*udf} 2 { target arm3=
2 } } } */
> +/* { dg-final { scan-assembler-times {\.L[^:]+:\n\s*ebreak} 2 { target r=
iscv*-*-* } } } */
> +
> +/* x86_64: Should have complete .kcfi_traps section sequence with relati=
ve
> +   offset and 2 entries.  */
> +/* { dg-final { scan-assembler {\.section\t\.kcfi_traps,"ao",@progbits,\=
.text\n\.Lkcfi_entry([^:]+):\n\t\.long\t\.Lkcfi_trap([^\s\n]+)-\.Lkcfi_entr=
y\1\n\t\.text} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@prog=
bits,\.text} 2 { target x86_64-*-* } } } */
> +
> +/* AArch64 should NOT have .kcfi_traps section (uses brk immediate inste=
ad) */
> +/* { dg-final { scan-assembler-not {\.section\t+\.kcfi_traps} { target a=
arch64*-*-* } } } */
> +/* { dg-final { scan-assembler-not {\.long.*-\.L} { target aarch64*-*-* =
} } } */
> +
> +/* ARM 32-bit should NOT have .kcfi_traps section (uses udf immediate in=
stead) */
> +/* { dg-final { scan-assembler-not {\.section\t+\.kcfi_traps} { target a=
rm32 } } } */
> +/* { dg-final { scan-assembler-not {\.long.*-\.L} { target arm32 } } } *=
/
> +
> +/* RISC-V: Should have complete .kcfi_traps section sequence with relati=
ve
> +   offset and 2 entries.  */
> +/* { dg-final { scan-assembler {\.section\t\.kcfi_traps,"ao",@progbits,\=
.text\n\.Lkcfi_entry([^:]+):\n\t\.4byte\t\.L([^\s\n]+)-\.Lkcfi_entry\1\n\t\=
.text} { target riscv*-*-* } } } */
> +/* { dg-final { scan-assembler-times {\.section\t\.kcfi_traps,"ao",@prog=
bits,\.text} 2 { target riscv*-*-* } } } */
> diff --git a/gcc/testsuite/gcc.dg/kcfi/kcfi.exp b/gcc/testsuite/gcc.dg/kc=
fi/kcfi.exp
> new file mode 100644
> index 000000000000..0bbba196c82f
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi.exp
> @@ -0,0 +1,64 @@
> +#   Copyright (C) 2025 Free Software Foundation, Inc.
> +
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 3 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with GCC; see the file COPYING3.  If not see
> +# <http://www.gnu.org/licenses/>.
> +
> +# GCC testsuite for KCFI (Kernel Control Flow Integrity) tests.
> +
> +# Load support procs.
> +load_lib gcc-dg.exp
> +
> +# KCFI is only supported on specific targets
> +if { ![istarget "x86_64-*-*"] \
> +     && ![istarget "aarch64-*-*"] && ![istarget "arm*-*-*"] \
> +     && ![istarget "riscv*-*-*"] } {
> +    return
> +}
> +
> +# Skip tests if x86_64 is running in 32-bit mode (-m32)
> +if { [istarget "x86_64-*-*"] && ![check_effective_target_lp64] } {
> +    return
> +}

This is also wrong, you can have a multi-lib version of i?86 which
support -m64 too.


> +
> +# Skip tests if AArch64 is running in ILP32 mode (-mabi=3Dilp32)
> +if { [istarget "aarch64-*-*"] && ![check_effective_target_lp64] } {
> +    return
> +}
> +
> +# Skip tests if RISC-V is running in 32-bit mode (riscv32-*)
> +if { [istarget "riscv*-*-*"] && ![check_effective_target_lp64] } {
> +    return
> +}

These should really be part a new check_effective_target_kfci instead
of embeded here.
And then you can just call that from here.

Does kcfi work on non-elf targets, e.g. aarch64-mingw or x86_64-mingw
or x86_64-darwin?  I see you check lp64 and that would reject the
mingw case but not the darwin case.

Thanks,
Andrew


> +
> +# Add KCFI-specific flags to any existing DEFAULT_CFLAGS
> +global DEFAULT_CFLAGS
> +if ![info exists DEFAULT_CFLAGS] then {
> +    set DEFAULT_CFLAGS ""
> +}
> +set DEFAULT_CFLAGS "$DEFAULT_CFLAGS -fsanitize=3Dkcfi"
> +
> +# Add ARM32-specific flags for arm32 targets
> +if [check_effective_target_arm32] {
> +    set DEFAULT_CFLAGS "$DEFAULT_CFLAGS -march=3Darmv7-a -mfloat-abi=3Ds=
oft"

I think the above is incorrect can you explain why you want to change
this? Especially since you might not have soft fp ABI compatiable
glibc installed?
Also it is either arm or aarch32 and not arm32.

Thanks
Andrew


> +}
> +
> +# Initialize `dg'.
> +dg-init
> +
> +# Main loop.
> +dg-runtest [lsort [glob -nocomplain $srcdir/$subdir/*.c]] \
> +       "" $DEFAULT_CFLAGS
> +
> +# All done.
> +dg-finish
> --
> 2.34.1
>
