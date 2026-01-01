Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B321D5BC
	for <linux-hardening@vger.kernel.org>; Thu,  1 Jan 2026 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307396; cv=none; b=qfiXsV0B+NHfhAlcnnOn989g+oK2Zq+KoRu67Dc+xVnwy+/aDAvdIRKekBq5pWyPfPj/ho51cxKlXSXl600Dmwu4aQQo4Q3M7Vuo63TCjCa1u1SCyqcXO6Bquc7mF89zsl6/08bFW9Y35Tmx8VVYYgnHPZiEwsLJdD9CugBj2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307396; c=relaxed/simple;
	bh=sN5/MgrPjzqYRPyznTYMAhkPlTIbWhXlWi+Znbo7TJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPJ5fpmG+WWi8P71SM2wA8qe3LyjHnCzveGYxlwpFtOt7MoM2s/e7sjjv3ewOxBznZ0w97vV2Ju/4+nDqLC/UPDQA56zLrpzNBjIrXzxkIP051EBjnFpb72Fj+5MsLiUunPziF3qLRc7H4tEuKj/vkAncgLZom33w5/sEhXtG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AlDJ40r0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LePDwBeD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AlDJ40r0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LePDwBeD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 601Law5Q3280458
	for <linux-hardening@vger.kernel.org>; Thu, 1 Jan 2026 22:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oAkPyQz4nnjbHZ7BUfGI1L3K38JUFBRcpl4tL8PKH4U=; b=AlDJ40r0vedQLg45
	qgR94hCmj06kkzB0jPYuE0JVJhKY5hIbfL1/R09sxc+jXc2z0gDTPS6e1EGSy+RE
	yPsFDk+pQ+P+VBL0K9ty8DEIYz908ux1dX2FfXg1UoCUg+4JfUqEVQRgnKi4IAfQ
	lr08VMYFLTSEePfaH2J1qMJG4kpwNcLcFLnOGmPWsN5o1do47Xl5IqzLhcM8OYi/
	iYUIrnTh8sPMhdlUZ70t5dCmJQE/PzEvLkehy+hwP2BmSio/6nrH+OxayMZjbegl
	ytc6/f17zbQFiTmW7YkAB1RfIi4h0ATLwi1oREFps0dkXSsxESbOgkEfq4HmCXTX
	49HS4Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcv4akej3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 01 Jan 2026 22:43:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b9d73d57328so11714224a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jan 2026 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767307392; x=1767912192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAkPyQz4nnjbHZ7BUfGI1L3K38JUFBRcpl4tL8PKH4U=;
        b=LePDwBeDpBMfPwiC8m+00DUMTK+N19uWtm0cCGSb7CBeccFOZvQjaKFbDtAM7m48/p
         0c54GE2DAjzPO7PT9Ml3WkC7mUaQGI0GrRIQsCsNqqTTQxVeAOFCgxUuo6bYtNI0cLjW
         4QXhdonibuAGKo0rkocOmmFrAl1NM9Jsn7BNE6fXanjdAK1Eltf4V8J5GjZP8aWCVK51
         Bo8UVwFiDmvW/qiAWkcyH2G5oT6k+2DY+Nlc/LqV7VAbnBH/B4311o9e2Gf7ihGjXzc3
         chZraepyemlcT877Ta/jjmvkN+PQLLJHqBP3TNuY0FCRMN6oFISuS8U9Sdy93M4fFcQ0
         8JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767307392; x=1767912192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAkPyQz4nnjbHZ7BUfGI1L3K38JUFBRcpl4tL8PKH4U=;
        b=WvFDcYvTYKLx3+Map9wM0cBHiyxsUmkDqaO96TL65PR405KQqJ/QISYlm2u/QPg2Z4
         DvbadTzDVFr/xxcow9kA77f4b95XIG5rEkhR/SegVOgmypJK3ifvYh7SGWYFQk/9iKry
         oIfZtoIR3CwLiHDFvqKpj/Heqv6cxgkMzw595t0G6H1lzta8rKtqH0/tmYTrHssj5pqL
         Lt75RWTDAbfo1wdPTpRlmRYqBILTHwYt2jXB1jIgpcnEAab+oMokJ4VWKjTJGrnlg7NR
         M/uzFClf/Rrbgwqgk0+aQZmL6QQjiyyKj8vTlz6jROYGDlsYDMXhcV8j60Yh0MqgQMe7
         Jw9w==
X-Forwarded-Encrypted: i=1; AJvYcCXuO2+M83fGSWDUjDhPBV+/93LvY3NxSzpzFAfFFkJCoC5lC/Etp0ibQ1Lw0kTlG9uscy0ieuwAQwZzG3zxxnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJA+C6mK6wI+PElRW09WmVdcTRRNHfFhx11j41dybaHMQVbzMH
	4edQ2HSGweZZn+ZMlsijhw3O6KCc1zFhrHS9v1sJ3B/IDHroKkFEEDRNc18DZp689YHTOReVRqW
	yg2Q8tx0h3qd+HgIs1j0L4PkuRhFhpVnLc4XSvRL+aNRaYndg4ucb9iTajS5Qb7aHB0rfLsq7yM
	J+TSS35cj3zNoNVj77c/3ROrvRUQxBZ8KROS/x2re6DYfPvQ==
X-Gm-Gg: AY/fxX7IKoIvZZ6sHOnVVPvie/o90Tiho6k7byl90yx+uQVJBTJ35j9oVrvL1arn6M9
	32X6lSbDThTUEVAFengjTcpLBpFBKtV7CHQd50fmkhg4LMhLh6R/TyUPSpq5rZ5NvRG0dgpiVoI
	8bAbXhPCQquaJD3x5b2CZFFFvEj8n81UbOT2NOZsOBKxtThk4I1+3eQOxvi/Zc/kmH
X-Received: by 2002:a05:7300:cca8:b0:2a7:343:399c with SMTP id 5a478bee46e88-2b05ebfc7afmr24916756eec.16.1767307391911;
        Thu, 01 Jan 2026 14:43:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV2eHMEVrxAZcmXZaJvcUeI5oqhsIBL8m52/n3tzMqTJnYS59DL9mCb7FpM/B7V0/IZ8qnhcYkIsZQ0R8S0nk=
X-Received: by 2002:a05:7300:cca8:b0:2a7:343:399c with SMTP id
 5a478bee46e88-2b05ebfc7afmr24916726eec.16.1767307391345; Thu, 01 Jan 2026
 14:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210022025.harder.803-kees@kernel.org>
In-Reply-To: <20251210022025.harder.803-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 1 Jan 2026 14:42:59 -0800
X-Gm-Features: AQt7F2qDT0ONTVyxo2roqZsn5N5seuq8weLFdBMSTgzJ9sw9bI-Y3CZgItOQZDo
Message-ID: <CALvbMcACT19UHPJme0w1rStX5XEJwNWdAMTuJ=cERkY38+EMQg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Introduce Kernel Control Flow Integrity ABI [PR107048]
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
X-Proofpoint-ORIG-GUID: ZDYmlgKtbOqvbAYqdSd9ORvbRgvEyJ8m
X-Authority-Analysis: v=2.4 cv=Ps6ergM3 c=1 sm=1 tr=0 ts=6956f880 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CCpqsmhAAAAA:8 a=pGLkceISAAAA:8
 a=mDV3o1hIAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=f_K3sRKlEXdHISidHpgA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAxMDIwNSBTYWx0ZWRfXwbZ7iDh72CHo
 q2ZE81xxxXi2cYKYlJ3XIrWfyJepn7t68QER12vwnimT9Wctbsg6ma+6cDN6W9eaMoS0mtPCgCv
 Y8cDO3SrnpDojz628ZGp0gT9t48GoJ1qngcuSeukWDNsXvI16lDq/ChFkT1tZ8RoQwRBFiQxvLu
 nnDv9oReXpyV5sP6y21a978Dpc9AsupRXlx5MxxBEzUN1/SE3mXSt7lLTTeiE54Pb9o4MdjxjNp
 GsyR5ITcZNueEQwLQy49DkKFUYOugTxwwAUgOuP33ENoFFSqRuqXBK57NY7pQYq7u2oq1mZ3P9E
 QtU3CEBJSg3sJHuIzcL12dymgdPPyV0E9CJYEkQMQhuoIXkLp1A5MAwOBl0+h6uJPnaZKOg3rWD
 Vz63KskdV8jkc6PjEbm5VfzEqYdnJHZohZD96DjiNlsoacv7G/EglM68gmcv1lUHduxPFxjealt
 7gfrhL9yW1Poi/kuErA==
X-Proofpoint-GUID: ZDYmlgKtbOqvbAYqdSd9ORvbRgvEyJ8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601010205

On Tue, Dec 9, 2025 at 6:22=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Hi,
>
> This series implements[1][2] the Linux Kernel Control Flow Integrity
> ABI, which provides a function prototype based forward edge control flow
> integrity protection by instrumenting every indirect call to check for
> a hash value before the target function address. If the hash at the call
> site and the hash at the target do not match, execution will trap.
>
> I'm hoping we can land front- and middle-end and do architectures as
> they also pass review. What do folks think? I'd really like to get this
> in a position where more people can test with GCC snapshots, etc.

So looking back into the other implementation that was submitted a few
years back (https://patchwork.sourceware.org/project/gcc/patch/202303250811=
17.93245-3-ashimida.1990@gmail.com/),
a regnote (REG_CALL_CFI_TYPEID) was used instead of the wrapping with
kfci rtl.
I get the feeling a regnote would be better as there is less for the
backend to deal with including new patterns.
What do others think?

Thanks,
Andrew Pinski

>
> Thanks!
>
> -Kees
>
> Changes since v8[3], addressing Andrew's feedback:
>
> - Split out aarch64 indirect branch logic into separate patch[4].
> - Simplify aarch64 asm output.
> - Clarify BTI interaction (it's safe) in commit log.
> - Move kcfi compatibility checking into hook logic instead of overrides
>   in aarch64, i386, and riscv.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D107048
> [2] https://github.com/KSPP/linux/issues/369
> [3] https://lore.kernel.org/linux-hardening/20251120222105.us.687-kees@ke=
rnel.org/
> [4] https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommitdiff;h=3D59a5fecfb2604=
56dd60be687491717f3dbdb354f
>
> Kees Cook (7):
>   typeinfo: Introduce KCFI typeinfo mangling API
>   kcfi: Add core Kernel Control Flow Integrity infrastructure
>   kcfi: Add regression test suite
>   x86: Add x86_64 Kernel Control Flow Integrity implementation
>   aarch64: Add AArch64 Kernel Control Flow Integrity implementation
>   arm: Add ARM 32-bit Kernel Control Flow Integrity implementation
>   riscv: Add RISC-V Kernel Control Flow Integrity implementation
>
>  gcc/kcfi.h                                    |  59 ++
>  gcc/kcfi.cc                                   | 696 ++++++++++++++++++
>  gcc/config/aarch64/aarch64-protos.h           |   4 +
>  gcc/config/arm/arm-protos.h                   |   4 +
>  gcc/config/i386/i386-protos.h                 |   2 +-
>  gcc/config/i386/i386.h                        |   3 +-
>  gcc/config/riscv/riscv-protos.h               |   3 +
>  gcc/config/aarch64/aarch64.md                 |  56 ++
>  gcc/config/arm/arm.md                         |  62 ++
>  gcc/config/i386/i386.md                       |  63 +-
>  gcc/config/riscv/riscv.md                     |  76 +-
>  gcc/config/aarch64/aarch64.cc                 |  93 +++
>  gcc/config/arm/arm.cc                         | 170 +++++
>  gcc/config/i386/i386-expand.cc                |  22 +-
>  gcc/config/i386/i386.cc                       | 210 +++++-
>  gcc/config/riscv/riscv.cc                     | 180 +++++
>  gcc/doc/extend.texi                           | 137 ++++
>  gcc/doc/invoke.texi                           | 127 ++++
>  gcc/doc/tm.texi                               |  32 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi.exp            |  51 ++
>  gcc/testsuite/lib/target-supports.exp         |  14 +
>  .../gcc.dg/builtin-typeinfo-errors.c          |  28 +
>  gcc/testsuite/gcc.dg/builtin-typeinfo.c       | 350 +++++++++
>  .../gcc.dg/kcfi/kcfi-aarch64-ilp32.c          |   7 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c    | 114 +++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c |  15 +
>  .../gcc.dg/kcfi/kcfi-arm-fixed-r12.c          |  15 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c       | 149 ++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c |  90 +++
>  .../gcc.dg/kcfi/kcfi-cold-partition.c         | 126 ++++
>  .../gcc.dg/kcfi/kcfi-complex-addressing.c     | 203 +++++
>  .../gcc.dg/kcfi/kcfi-complex-addressing.s     |   0
>  .../gcc.dg/kcfi/kcfi-ipa-robustness.c         |  54 ++
>  .../gcc.dg/kcfi/kcfi-move-preservation.c      | 118 +++
>  .../gcc.dg/kcfi/kcfi-no-sanitize-inline.c     | 100 +++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c  |  39 +
>  .../gcc.dg/kcfi/kcfi-offset-validation.c      |  38 +
>  .../gcc.dg/kcfi/kcfi-patchable-entry-only.c   |  64 ++
>  .../gcc.dg/kcfi/kcfi-patchable-incompatible.c |   7 +
>  .../gcc.dg/kcfi/kcfi-patchable-large.c        |  54 ++
>  .../gcc.dg/kcfi/kcfi-patchable-medium.c       |  60 ++
>  .../gcc.dg/kcfi/kcfi-patchable-prefix-only.c  |  61 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c  |   7 +
>  .../gcc.dg/kcfi/kcfi-riscv-fixed-t1.c         |   7 +
>  .../gcc.dg/kcfi/kcfi-riscv-fixed-t2.c         |   7 +
>  .../gcc.dg/kcfi/kcfi-riscv-fixed-t3.c         |   7 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c      | 276 +++++++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c   | 140 ++++
>  .../gcc.dg/kcfi/kcfi-trap-encoding.c          |  69 ++
>  gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c |  29 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c    |   7 +
>  gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c    |  93 +++
>  .../gcc.dg/kcfi/kcfi-x86-fixed-r10.c          |   7 +
>  .../gcc.dg/kcfi/kcfi-x86-fixed-r11.c          |   7 +
>  .../gcc.dg/kcfi/kcfi-x86-retpoline-r11.c      |  40 +
>  gcc/Makefile.in                               |   2 +
>  gcc/c-family/c-common.h                       |   1 +
>  gcc/flag-types.h                              |   2 +
>  gcc/gimple.h                                  |  22 +
>  gcc/kcfi-typeinfo.h                           |  32 +
>  gcc/tree-pass.h                               |   1 +
>  gcc/c-family/c-attribs.cc                     |  17 +-
>  gcc/c-family/c-common.cc                      |   2 +
>  gcc/c/c-parser.cc                             |  72 ++
>  gcc/common.opt                                |   8 +
>  gcc/df-scan.cc                                |   7 +
>  gcc/doc/tm.texi.in                            |  12 +
>  gcc/final.cc                                  |   3 +
>  gcc/kcfi-typeinfo.cc                          | 516 +++++++++++++
>  gcc/opts.cc                                   |   2 +
>  gcc/passes.cc                                 |   1 +
>  gcc/passes.def                                |   1 +
>  gcc/rtl.def                                   |   6 +
>  gcc/rtlanal.cc                                |   5 +
>  gcc/target.def                                |  39 +
>  gcc/toplev.cc                                 |  12 +
>  gcc/tree-inline.cc                            |  10 +
>  gcc/varasm.cc                                 |  37 +-
>  78 files changed, 5218 insertions(+), 44 deletions(-)
>  create mode 100644 gcc/kcfi.h
>  create mode 100644 gcc/kcfi.cc
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi.exp
>  create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo-errors.c
>  create mode 100644 gcc/testsuite/gcc.dg/builtin-typeinfo.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-aarch64-ilp32.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-ip.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-arm-fixed-r12.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-call-sharing.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-cold-partition.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-complex-addressing.s
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-ipa-robustness.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-move-preservation.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize-inline.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-no-sanitize.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-offset-validation.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-entry-only.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-incompatible=
.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-large.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-medium.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-patchable-prefix-only.=
c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-32bit.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t1.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t2.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-riscv-fixed-t3.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-runtime.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-tail-calls.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-encoding.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-trap-section.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-32bit.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-arity.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r10.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-fixed-r11.c
>  create mode 100644 gcc/testsuite/gcc.dg/kcfi/kcfi-x86-retpoline-r11.c
>  create mode 100644 gcc/kcfi-typeinfo.h
>  create mode 100644 gcc/kcfi-typeinfo.cc
>
> --
> 2.34.1
>
