Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAD23C39A
	for <linux-hardening@vger.kernel.org>; Wed, 10 Dec 2025 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339248; cv=none; b=rCo8t/7iOeKxp3tHvYuCFPPOTZpTGyhZk1fKpXGGz7SEzqo2RSRDm5j5U84xAgtCV5mR7Ca/kUzoUgZPKGNQIgICLy87mJpOnvuCKkEE3CRlYe3KVFxwpGqIntG4R2XkPyCVaUSu/sGMcrYQbn+I0N61udS5oWDK7pdrLuJk3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339248; c=relaxed/simple;
	bh=/eCrIYW9SiryTzEEP6Bpe5mBwWZcS2WzFNUt/7sSb6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIuiOQ25cEOuMYKBDyOYkff1qauf9SQnd4q9h+iDNw1KcQJGzgmUf8roDcpVlU6pSmwTRXcRAAfX2tN+1fTLpNsuI89INulXBBiYltYlfbfk92HQr2V/OOPM2i9JviYlGVC5LQU3WtIAksVyhjI6soCgrQQKkJF6fvBTtYVwWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmWqL3Aa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V/cZ+zW+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmWqL3Aa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/cZ+zW+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA3LXbp1810646
	for <linux-hardening@vger.kernel.org>; Wed, 10 Dec 2025 04:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mB8wkjPAsfO9ZbXscf0Q3QOWZOEPUTX/5kPQlPvLz6k=; b=AmWqL3AabdLZb7tF
	FfdA4NftWPs1aGoDSywXz8BJ4ekBOXkcWMlPwFkjUcYmJ3lzxDz2SJwtg4eQTCRn
	E2jBruqczRWwiVDXv4H8ms2+Kdvzri21HgEy0vszoYw9KyAJFTULz2xhlyVTA2HE
	Y1OHZV+Swoq4LVLLCEhDzfGLXuNYAcp4fq7At3JFn4ECcYW+p8yhP4bTxvmgCyIA
	WmvPXXhE0Nzcjh0jG/m3DADSLnLunwaSYZE09GvZJNmpXJQTqRPoXzsJsyXRm3HY
	XYIVpMZDRDocfT3eystqiguMea7DqSu41z3tMcPoYAw5NQPeamiBpihmnQ5i15c5
	5AISGA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axm9catb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 10 Dec 2025 04:00:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2a467c4e74bso773734eec.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Dec 2025 20:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765339242; x=1765944042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB8wkjPAsfO9ZbXscf0Q3QOWZOEPUTX/5kPQlPvLz6k=;
        b=V/cZ+zW+1VZgEDmx7F+t9pWxr8DTN+/5kN7jtv2Wo6wXDrOvpGTKnEJwUqDZFsUqwt
         VJQkYc2r0Awqb6MMjHYqOHomgguKqcJObj6aq4jZOdxUG5Pz+EiB71zKDymvm1iv+K2A
         i1U7G9RDNRpijI1mNTIVIiYYWf/qYPZmlz/F+48Y53v/zieSeF/jOotLuYwiFsbpNQnk
         jm6JAB+x/G5SRnhQAVr7Dcc7y6oPQK3JGSLpTRp/NfINkrOZHqbSogmYndcPhK9PYXt1
         EyRASJNr2UMLqPE5+hRIV9ZbqaBC428wkJJmPfRfhqUAzNjg2OvtP8lrwsoGG+3GZ1jy
         Ha2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765339242; x=1765944042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mB8wkjPAsfO9ZbXscf0Q3QOWZOEPUTX/5kPQlPvLz6k=;
        b=Nww441rabAN4JzHntpKIvlJDDMiplBgMz2u3ocmjZxeAHiZ7YIry4wR54IhpZVknYI
         RSjc7m/+YZ8eJ9PkXdkyzSvpyJQF4Q67aoOhcc6uWAvg1x1494farTeih97363RSw2Rq
         VlKmG70Va6gxOzrEY/HXNeJf8u+aaJUl1vEfuypgqJ0xBom9HM+1v/4vYfkeM2hStt60
         bx6hnpnCMfXzOGSY7oFR/cC51+TxH3lb3CmzLlWhW5g1FgS3wxca0cXnXbeCQzlp8ahE
         6OcPwboCKHMPhD9GO4J48hrgY04eIN1FgAOlwkGvtLP55PVbGru8eCtB6oRbQzihiyJ8
         5nzA==
X-Forwarded-Encrypted: i=1; AJvYcCWaS/XH4D+cjVBmX1C4Wt8nnEHgcO7Lwc+UJPnDENqTCgs5oUp78Qd7U4OigmOM5SSORLx8+ImozL+DLohbn1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOe4nxMRVuxT8QKzDMtPAbmiXSMIcOd4PnsE62erJqbXKBhZm+
	BNQJhLOObYYJgIBzI3Wkk2uMcwNv/t5nVedhshalltQE9/7v3m+ahC4s63cYhnyY/LAX14du2lH
	iuvJ3nzN39wG/qIdx5xj+DjKCiaxmiguVZaAAml8MKhqGT8rvntgUA0UYD7m4q0wMtz8iSbncqC
	5OGpkUG3e55luiT0iEXZGQ0wgo4B7zfn9NKqXY1GkGrvjd4g==
X-Gm-Gg: AY/fxX6TgPG2RO1l6j0uAUbJ9oqLsnQ3OI8Lw/ZnqY0Uu/XwqjlxPKorKDW2bs0Gkv5
	essbeR2YwwRVAdI8GFGMKjkx1NE6yoU05zik+VRSyZ4HvAfmT30bp7qVY746BjdC30fKzumprmU
	f/vE2atHn/EtYOb6bnNLouT2IDLFCcOkGdANMype0Vcv5kR5ArPukiWFAJGjtbfgw=
X-Received: by 2002:a05:7300:3247:b0:2a4:3593:ccbf with SMTP id 5a478bee46e88-2ac05ffdab3mr982302eec.6.1765339240935;
        Tue, 09 Dec 2025 20:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFZvd/tuN5h9q3A11R5nH8KhVTIhIXZsePQp35N7BwUv0FDGb3TxB8Tmm6uM3ztSQzCKwQiN5LvxMAhnW/rgk=
X-Received: by 2002:a05:7300:3247:b0:2a4:3593:ccbf with SMTP id
 5a478bee46e88-2ac05ffdab3mr982253eec.6.1765339239664; Tue, 09 Dec 2025
 20:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210022025.harder.803-kees@kernel.org> <20251210022035.331892-2-kees@kernel.org>
In-Reply-To: <20251210022035.331892-2-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 20:00:28 -0800
X-Gm-Features: AQt7F2rswPHsXh2PGfDxIFiuo4E8ascFnJEf8KHodcbwfdUYoqOqWB0xAqiumY0
Message-ID: <CALvbMcAd-03ZtYKBCecUKGLfna+kNe4TgYqkV80sVNQ+J-M-7A@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] kcfi: Add core Kernel Control Flow Integrity infrastructure
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAzMiBTYWx0ZWRfX7Aj2M0/sFdAz
 IXNBT2LVDwLPdYMo47D+bfasXfpxv4Q2D49k/ANPqY5Skwh22ws3GHYE4mcllClJj4jQYzaKvw/
 Z++p8sGhILXASEBoh/Jy8rZKcXI0IsJ+rfFYTktgrmMACw40qisfPM2kOKgel+GRcfAMCVhbyD5
 Ny5ZXtwTwBOqjKmnimj6ugPnQxqrQ+dh/CA8ObKptErbBcDiF0kTQiNRzljDXNk8C8/wq6DVVHG
 qeMVYLkxMrUaUv3eTB89szavcimRU4FGfkaH5NcXgeHx8wErBAAwVsqGZpEADn2jvb6WLW7gqiI
 SvwqlboyZvEg7GeoYl2iVx/+D5RjJ629B85Fxqgw7dTqxiOmjBma04sezGv8es9XAorg13qeTx/
 xjzXLMGd6oiouGEhrb01zj2ZMSx4bg==
X-Proofpoint-ORIG-GUID: YSq9cRrxgqroY2b31BRysOFHBumuFJaZ
X-Authority-Analysis: v=2.4 cv=Vcj6/Vp9 c=1 sm=1 tr=0 ts=6938f06b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=Ue42Q34zAAAA:8
 a=H0umD5oqAAAA:8 a=We0TE4j0AAAA:8 a=o4cBDJ48AAAA:8 a=OGjWj8McAAAA:8
 a=VwQbUJbxAAAA:8 a=Ll29ShCA9Sda8LojQwAA:9 a=Ls7hm5mh2MGOgLWU:21
 a=QEXdDO2ut3YA:10 a=s2Qs2jXM6lQA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=du2hvLAJtKcNxoDMbUSS:22 a=OOX4_xUL_TWpQX1oCgna:22 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-GUID: YSq9cRrxgqroY2b31BRysOFHBumuFJaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100032

On Tue, Dec 9, 2025 at 6:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Implements the Linux Kernel Control Flow Integrity ABI, which provides a
> function prototype based forward edge control flow integrity protection
> by instrumenting every indirect call to check for a hash value before
> the target function address. If the hash at the call site and the hash
> at the target do not match, execution will trap.
>
> See the start of kcfi.cc for design details.
>
> gcc/ChangeLog:
>
>         * kcfi.h: New file with KCFI public interface declarations.
>         * kcfi.cc: New file implementing Kernel Control Flow Integrity
>         infrastructure.
>         * Makefile.in (OBJS): Add kcfi.o.
>         * flag-types.h (enum sanitize_code): Add SANITIZE_KCFI.
>         * gimple.h (enum gf_mask): Add GF_CALL_INLINED_FROM_KCFI_NOSANTIZ=
E.
>         (gimple_call_set_inlined_from_kcfi_nosantize): New function.
>         (gimple_call_inlined_from_kcfi_nosantize_p): New function.
>         * tree-pass.h Add kcfi passes.
>         * df-scan.cc (df_uses_record): Add KCFI case to handle KCFI RTL
>         patterns and process wrapped RTL.
>         * doc/extend.texi: Update nocf_check for kcfi.
>         * doc/invoke.texi (fsanitize=3Dkcfi): Add documentation for KCFI
>         sanitizer option.
>         * doc/tm.texi.in: Add Kernel Control Flow Integrity section with
>         TARGET_KCFI_SUPPORTED, TARGET_KCFI_MASK_TYPE_ID,
>         TARGET_KCFI_EMIT_TYPE_ID hooks.
>         * doc/tm.texi: Regenerate.
>         * final.cc (call_from_call_insn): Add KCFI case to handle
>         KCFI-wrapped calls.
>         * opts.cc (sanitizer_opts): Add kcfi entry.
>         * passes.cc: Include kcfi.h.
>         * passes.def: Add KCFI IPA pass.
>         * rtl.def (KCFI): Add new RTL code for KCFI instrumentation.
>         * rtlanal.cc (reg_referenced_p): Add KCFI case.
>         * target.def: Add KCFI target hooks.
>         * toplev.cc (process_options): Add KCFI option processing.
>         * tree-inline.cc: Include kcfi.h and asan.h.
>         (copy_bb): Handle KCFI no_sanitize attribute propagation during
>         inlining.
>         * varasm.cc (assemble_start_function): Emit KCFI preambles.
>         (assemble_external_real): Emit KCFI typeid symbols.
>         (default_elf_asm_named_section): Handle .kcfi_traps using
>         SECTION_LINK_ORDER flag.
>
> gcc/c-family/ChangeLog:
>
>         * c-attribs.cc: Include asan.h.
>         (handle_nocf_check_attribute): Enable nocf_check under kcfi.
>         (handle_patchable_function_entry_attribute): Add error for using
>         patchable_function_entry attribute with -fsanitize=3Dkcfi.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/kcfi.h                |  59 ++++
>  gcc/kcfi.cc               | 696 ++++++++++++++++++++++++++++++++++++++
>  gcc/doc/extend.texi       |  42 +++
>  gcc/doc/invoke.texi       |  33 ++
>  gcc/doc/tm.texi           |  32 ++
>  gcc/Makefile.in           |   1 +
>  gcc/flag-types.h          |   2 +
>  gcc/gimple.h              |  22 ++
>  gcc/tree-pass.h           |   1 +
>  gcc/c-family/c-attribs.cc |  17 +-
>  gcc/df-scan.cc            |   7 +
>  gcc/doc/tm.texi.in        |  12 +
>  gcc/final.cc              |   3 +
>  gcc/opts.cc               |   1 +
>  gcc/passes.cc             |   1 +
>  gcc/passes.def            |   1 +
>  gcc/rtl.def               |   6 +
>  gcc/rtlanal.cc            |   5 +
>  gcc/target.def            |  39 +++
>  gcc/toplev.cc             |  12 +
>  gcc/tree-inline.cc        |  10 +
>  gcc/varasm.cc             |  37 +-
>  22 files changed, 1028 insertions(+), 11 deletions(-)
>  create mode 100644 gcc/kcfi.h
>  create mode 100644 gcc/kcfi.cc
>
> diff --git a/gcc/kcfi.h b/gcc/kcfi.h
> new file mode 100644
> index 000000000000..ea7e7881040f
> --- /dev/null
> +++ b/gcc/kcfi.h
> @@ -0,0 +1,59 @@
> +/* Kernel Control Flow Integrity (KCFI) support for GCC.
> +   Copyright (C) 2025 Free Software Foundation, Inc.
> +
> +This file is part of GCC.
> +
> +GCC is free software; you can redistribute it and/or modify it under
> +the terms of the GNU General Public License as published by the Free
> +Software Foundation; either version 3, or (at your option) any later
> +version.
> +
> +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with GCC; see the file COPYING3.  If not see
> +<http://www.gnu.org/licenses/>.  */
> +
> +#ifndef GCC_KCFI_H
> +#define GCC_KCFI_H
> +
> +#include "config.h"
> +#include "system.h"
> +#include "coretypes.h"
> +#include "rtl.h"
> +
> +/* Common helper for RTL patterns to emit .kcfi_traps section entry.
> +   Call after emitting trap label and instruction with the trap symbol
> +   reference.  */
> +extern void kcfi_emit_traps_section (FILE *file, rtx trap_label_sym,
> +                                     int labelno);
> +
> +/* Extract KCFI type ID from current GIMPLE statement.  */
> +extern rtx internal_kcfi_get_type_id_for_expanding_gimple_call (void);
> +
> +/* Convenience wrapper to check for SANITIZE_KCFI.  */
> +static inline rtx
> +kcfi_get_type_id_for_expanding_gimple_call (void)
> +{
> +  if (!(flag_sanitize & SANITIZE_KCFI))
> +    return NULL_RTX;
> +  return internal_kcfi_get_type_id_for_expanding_gimple_call ();
> +}
> +
> +/* Emit KCFI type ID symbol for external address-taken functions.  */
> +extern void kcfi_emit_typeid_symbol (FILE *asm_file, tree fndecl);
> +
> +/* Emit KCFI preamble for potential indirect call targets.  */
> +extern void kcfi_emit_preamble (FILE *asm_file, tree fndecl,
> +                               const char *actual_fname);
> +
> +/* Get next KCFI label number for trap/call/entry label numbering.  */
> +extern int kcfi_next_labelno (void);
> +
> +/* Get the KCFI typeid offset for calculating callsite typeid offset.  *=
/
> +extern HOST_WIDE_INT kcfi_get_typeid_offset (void);
> +
> +#endif /* GCC_KCFI_H */
> diff --git a/gcc/kcfi.cc b/gcc/kcfi.cc
> new file mode 100644
> index 000000000000..e61831eaa20d
> --- /dev/null
> +++ b/gcc/kcfi.cc
> @@ -0,0 +1,696 @@
> +/* Kernel Control Flow Integrity (KCFI) support for GCC.
> +   Copyright (C) 2025 Free Software Foundation, Inc.
> +
> +This file is part of GCC.
> +
> +GCC is free software; you can redistribute it and/or modify it under
> +the terms of the GNU General Public License as published by the Free
> +Software Foundation; either version 3, or (at your option) any later
> +version.
> +
> +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with GCC; see the file COPYING3.  If not see
> +<http://www.gnu.org/licenses/>.  */
> +
> +/* KCFI ABI Design:
> +
> +The Linux Kernel Control Flow Integrity ABI provides a function prototyp=
e
> +based forward edge control flow integrity protection by instrumenting
> +every indirect call to check for a hash value before the target function
> +address.  If the hash at the call site and the hash at the target do not
> +match, execution will trap.
> +
> +The general CFI ideas are discussed here, but focuses more on a CFG
> +analysis to construct valid call destinations, which tends to require LT=
O:
> +https://users.soe.ucsc.edu/~abadi/Papers/cfi-tissec-revised.pdf
> +
> +Later refinement for using jump tables (constructed via CFG analysis
> +during LTO) was proposed here:
> +https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-pa=
per-tice.pdf
> +
> +Linux used the above implementation from 2018 to 2022:
> +https://android-developers.googleblog.com/2018/10/control-flow-integrity=
-in-android-kernel.html
> +but the corner cases for target addresses not being the actual functions
> +(i.e. pointing into the jump table) was a continual source of problems,
> +and generating the jump tables required full LTO, which had its own set
> +of problems.
> +
> +Looking at function prototypes as the source of call validity was
> +presented here, though still relied on LTO:
> +https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The=
-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel-wp.pdf
> +
> +The KCFI approach built on the function-prototype idea, but avoided
> +needing LTO, and could be further updated to deal with CPU errata
> +(retpolines, etc):
> +https://lpc.events/event/16/contributions/1315/
> +
> +KCFI has a number of specific constraints.  Some are tied to the
> +backend architecture, which are covered in arch-specific code.
> +The constraints are:
> +
> +- The KCFI scheme generates a unique 32-bit hash ("typeid") for each
> +  unique function prototype, allowing for indirect call sites to verify
> +  that they are calling into a matching _type_ of function pointer.
> +  This changes the semantics of some optimization logic because now
> +  indirect calls to different types cannot be merged.  For example:
> +
> +    if (p->func_type_1)
> +       return p->func_type_1 ();
> +    if (p->func_type_2)
> +       return p->func_type_2 ();
> +
> +  In final asm, the optimizer may collapse the second indirect call
> +  into a jump to the first indirect call once it has loaded the function
> +  pointer.  KCFI must block cross-type merging otherwise there will be a
> +  single KCFI check happening for only 1 type but being used by 2 target
> +  types.  The distinguishing characteristic for call merging becomes the
> +  type, not the address/register usage.
> +
> +- The check-call instruction sequence must be treated as a single unit: =
it
> +  cannot be rearranged or split or optimized.  The pattern is that
> +  indirect calls, "call *%target", get converted into:
> +
> +    mov $target_expression, %target ; only present if the expression was
> +                                   ; not already in %target register
> +    load -$offset(%target), %tmp    ; load typeid hash from target pream=
ble
> +    cmp $typeid, %tmp              ; compare expected typeid with loaded
> +    je .Lkcfi_call$N               ; success: jump to the indirect call
> +  .Lkcfi_trap$N:                   ; label of trap insn
> +    trap                           ; trap on failure, but arranged so
> +                                   ; "permissive mode" falls through
> +  .Lkcfi_call$N:                   ; label of call insn
> +    call *%target                  ; actual indirect call
> +
> +  This pattern of call immediately after trap provides for the
> +  "permissive" checking mode automatically: the trap gets handled,
> +  a warning emitted, and then execution continues after the trap to
> +  the call.
> +
> +- KCFI check-call instrumentation must survive tail call optimization.
> +  If an indirect call is turned into an indirect jump, KCFI checking
> +  must still happen (but it will use a jmp rather than a call).
> +
> +- Functions that may be called indirectly have a preamble added,
> +  __cfi_$original_func_name, which contains the $typeid value:
> +
> +    __cfi_target_func:
> +      .word $typeid
> +    target_func:
> +       [regular function entry...]
> +
> +- The preamble needs to interact with patchable function entry so that
> +  the typeid appears further away from the actual start of the function
> +  (leaving the prefix NOPs of the patchable function entry unchanged).
> +  This means only _globally defined_ patchable function entry is support=
ed
> +  with KCFI (indrect call sites must know in advance what the offset is,
> +  which may not be possible with extern functions that use a function
> +  attribute to change their patchable function entry characteristics).
> +  For example, a "4,4" patchable function entry would end up like:
> +
> +    __cfi_target_func:
> +      .data $typeid
> +      nop nop nop nop
> +    target_func:
> +       [regular function entry...]
> +
> +  Architectures may need to add alignment nops prior to the typeid to ke=
ep
> +  __cfi_target_func aligned for function call conventions.
> +
> +- An external function that is address-taken but does not have a definit=
ion has
> +  a weak __kcfi_typeid_$func symbol added at the declaration site.  This=
 weak
> +  symbol has the typeid value available so that the typeid can be refere=
nced
> +  from assembly linkages, etc, where the typeid values cannot be calcula=
ted
> +  (i.e where C type information is missing):
> +
> +    .weak   __kcfi_typeid_$func
> +    .set    __kcfi_typeid_$func, $typeid
> +
> +- On architectures that do not have a good way to encode additional
> +  details in their trap insn (e.g. x86_64 and riscv64), the trap locatio=
n
> +  is identified as a KCFI trap via a relative address offset entry
> +  emitted into the .kcfi_traps section for each indirect call site's
> +  trap instruction.  The previous check-call example's insn sequence wou=
ld
> +  then have section changes inserted between the trap and call:
> +
> +  ...
> +  .Lkcfi_trap$N:
> +    trap
> +  .section     .kcfi_traps,"ao",@progbits,.text
> +  .Lkcfi_entry$N:
> +    .long      .Lkcfi_trap$N - .Lkcfi_entry$N
> +  .text
> +  .Lkcfi_call$N:
> +    call *%target
> +
> +  It is up to such architectures to decode instructions prior to the
> +  trap to locate the typeid that the callsite was expecting.
> +
> +  For architectures that can encode immediates in their trap function
> +  (e.g. aarch64 and arm32), this isn't needed: they just use immediate
> +  codes that indicate a KCFI trap.
> +
> +- The no_sanitize("kcfi") function attribute means that the marked
> +  function must not produce KCFI checking for indirect calls, and this
> +  attribute must survive inlining.  This is used rarely by Linux, but
> +  is required to make BPF JIT trampolines work on older Linux kernel
> +  versions.
> +
> +- The "nocf_check" function attribute can be used to supress the
> +  KCFI preamble for a function, making that function unavailable
> +  for indirect calls.
> +
> +As a result of these constraints, there are some behavioral aspects
> +that need to be preserved across the middle-end and back-end.
> +
> +For indirect call sites:
> +
> +- Make sure KCFI expansion is skipped for inline functions that
> +  are marked with no_sanitize("kcfi") by marking these calls
> +  during GIMPLE inlining with a new flag which is checked during
> +  expansion.
> +
> +- All function types have their associated typeid attached as an
> +  attribute during an IPA pass.
> +
> +- Keep typeid information available through to the RTL expansion
> +  phase via a new KCFI insn RTL pattern that wraps the CALL
> +  and the typeid as expressions.  Since per-arch RTL call logic
> +  can be very complex, we don't want to replace the "define_expand"
> +  patterns, but rather hook the tail end of expansion.  This is
> +  where kcfi_get_type_id_for_expanding_gimple_call gets used, which
> +  uses currently_expanding_gimple_stmt internally, as done in
> +  other cases where GIMPLE needs to be examined during expansion.
> +
> +- Keep indirect calls from being merged (see earlier example)
> +  naturally by having typeid be the second argument of the KCFI insn
> +  RTL pattern, so jump2 pass's use of rtx_equal_p see differing
> +  typeids in the RTL.
> +
> +- Update register liveness analysis to look inside the new KCFI
> +  RTL to find the CALL RTL and examine the registers in use there
> +  so the allocator can track register usage correctly.
> +
> +- KCFI insn emission interacts with patchable function entry to
> +  load the typeid from the target preamble, offset by prefix NOPs.
> +
> +For indirect call targets:
> +
> +- kcfi_emit_preamble interacts with patchable function entry to add
> +  any needed alignment padding prior to emitting the typeid.
> +
> +- assemble_external_real calls kcfi_emit_typeid_symbol to add the
> +  __kcfi_typeid_$func symbols.
> +
> +*/
> +
> +#include "config.h"
> +#include "system.h"
> +#include "coretypes.h"
> +#include "target.h"
> +#include "function.h"
> +#include "tree.h"
> +#include "tree-pass.h"
> +#include "dumpfile.h"
> +#include "basic-block.h"
> +#include "gimple.h"
> +#include "gimple-iterator.h"
> +#include "cgraph.h"
> +#include "kcfi.h"
> +#include "stringpool.h"
> +#include "attribs.h"
> +#include "rtl.h"
> +#include "cfg.h"
> +#include "cfgrtl.h"
> +#include "asan.h"
> +#include "diagnostic-core.h"
> +#include "memmodel.h"
> +#include "print-tree.h"
> +#include "emit-rtl.h"
> +#include "output.h"
> +#include "builtins.h"
> +#include "varasm.h"
> +#include "opts.h"
> +#include "target.h"
> +#include "flags.h"
> +#include "kcfi-typeinfo.h"
> +#include "insn-config.h"
> +#include "recog.h"
> +
> +/* KCFI label counter, incremented by KCFI insn emission.  */
> +static int kcfi_labelno =3D 0;
> +
> +/* Get next KCFI label number.  Returns the current KCFI label number
> +   and increments the internal counter for the next call.  The label is
> +   used to provide a unique number for each indirect callsite of the
> +   current module of the compilation.  */
> +
> +int
> +kcfi_next_labelno (void)
> +{
> +  return kcfi_labelno++;
> +}
> +
> +/* Callsite typeid loading offset.  */
> +static HOST_WIDE_INT kcfi_typeid_offset =3D 0;
> +
> +/* Get the KCFI typeid offset.  Returns the offset in bytes from the
> +   function entry point where the KCFI type ID is stored.  */
> +
> +HOST_WIDE_INT
> +kcfi_get_typeid_offset (void)
> +{
> +  return kcfi_typeid_offset;
> +}
> +/* Count of needed __cfi_... preamble alignment padding NOPs.  */
> +static HOST_WIDE_INT kcfi_alignment_padding_nops =3D 0;
> +/* NOP insn template.  */
> +static const char *kcfi_nop =3D NULL;
> +
> +/* Common helper for RTL patterns to emit .kcfi_traps section entry.
> +   FILE is the output assembly file stream.  TRAP_LABEL_SYM is the RTX
> +   symbol reference for the trap instruction label.  LABELNO is the KCFI
> +   label number to use for the entry label.  */
> +
> +void
> +kcfi_emit_traps_section (FILE *file, rtx trap_label_sym, int labelno)
> +{
> +  /* Generate entry label name with custom prefix.  */
> +  char entry_name[32];
> +  ASM_GENERATE_INTERNAL_LABEL (entry_name, "Lkcfi_entry", labelno);
> +
> +  /* Save current section to restore later.  */
> +  section *saved_section =3D in_section;
> +
> +  /* Use varasm infrastructure for section handling:
> +     .section  .kcfi_traps,"ao",@progbits,.text  */
> +  section *kcfi_traps_section =3D get_section (".kcfi_traps",
> +                                            SECTION_LINK_ORDER, NULL);
> +  switch_to_section (kcfi_traps_section);
> +
> +  /* Emit entry label for relative offset:
> +     .Lkcfi_entry$N:  */
> +  ASM_OUTPUT_LABEL (file, entry_name);
> +
> +  /* Generate address difference using RTL infrastructure.  */
> +  rtx entry_label_sym =3D gen_rtx_SYMBOL_REF (Pmode, entry_name);
> +  rtx addr_diff =3D gen_rtx_MINUS (Pmode, trap_label_sym, entry_label_sy=
m);
> +
> +  /* Emit the address difference as a 4-byte value:
> +    .long      .Lkcfi_trap$N - .Lkcfi_entry$N  */
> +  assemble_integer (addr_diff, 4, BITS_PER_UNIT, 1);
> +
> +  /* Restore the previous section:
> +     .text  */
> +  switch_to_section (saved_section);
> +}
> +
> +/* Compute KCFI type ID for a function type.  FNTYPE is the function
> +   type tree node to compute the type ID for.  Returns the 32-bit KCFI
> +   type identifier hash.  */
> +
> +static uint32_t
> +compute_kcfi_type_id (tree fntype)
> +{
> +  gcc_assert (fntype);
> +  gcc_assert (TREE_CODE (fntype) =3D=3D FUNCTION_TYPE);
> +
> +  uint32_t type_id =3D typeinfo_get_hash (fntype);
> +
> +  /* Apply target-specific masking if supported.  */
> +  if (targetm.kcfi.mask_type_id)
> +    type_id =3D targetm.kcfi.mask_type_id (type_id);
> +
> +  /* Output to dump file if enabled.  */
> +  if (dump_file && (dump_flags & TDF_DETAILS))
> +    {
> +      std::string mangled_name =3D typeinfo_get_name (fntype);
> +      fprintf (dump_file, "KCFI type ID: mangled=3D'%s' typeid=3D0x%08x\=
n",
> +              mangled_name.c_str (), type_id);
> +    }
> +
> +  return type_id;
> +}
> +
> +/* Function attribute to store KCFI type ID.  */
> +static tree kcfi_type_id_attr =3D NULL_TREE;
> +
> +/* Get KCFI type ID for a function type.  Set it if missing.  FN_TYPE
> +   is the function type tree node.  Returns the cached or newly computed
> +   32-bit KCFI type identifier, storing it as a type attribute.  */
> +
> +static uint32_t
> +kcfi_get_type_id (tree fn_type)
> +{
> +  uint32_t type_id;
> +
> +  /* Cache the attribute identifier for build_tree_list usage.  */
> +  if (!kcfi_type_id_attr)
> +    kcfi_type_id_attr =3D get_identifier ("kcfi_type_id");
> +
> +  tree attr =3D lookup_attribute ("kcfi_type_id", TYPE_ATTRIBUTES (fn_ty=
pe));
> +  if (attr)
> +    {
> +      tree value =3D TREE_VALUE (attr);
> +      gcc_assert (value && TREE_CODE (value) =3D=3D INTEGER_CST);
> +      type_id =3D (uint32_t) TREE_INT_CST_LOW (value);
> +    }
> +  else
> +    {
> +      type_id =3D compute_kcfi_type_id (fn_type);
> +
> +      tree type_id_tree =3D build_int_cst (unsigned_type_node, type_id);
> +      tree attr =3D build_tree_list (kcfi_type_id_attr, type_id_tree);
> +
> +      TYPE_ATTRIBUTES (fn_type) =3D chainon (TYPE_ATTRIBUTES (fn_type), =
attr);
> +    }
> +
> +  return type_id;
> +}
> +
> +/* Prepare the global KCFI alignment NOPs calculation.  Called once
> +   during IPA pass to set global variables including kcfi_typeid_offset
> +   and kcfi_alignment_padding_nops based on patchable function entry
> +   settings and function alignment requirements.  */
> +
> +static void
> +kcfi_prepare_alignment_nops (void)
> +{
> +  /* Calculate where callsites load the 32-bit typeid from, based
> +     on the target function address.  Under default circumstances,
> +     the typeid is located 4 bytes before the function entry, in
> +     the __cfi_... preamble:
> +
> +     __cfi_func:
> +       [typeid]                // -4 from func
> +     func:
> +       [function body]
> +
> +   */
> +  kcfi_typeid_offset =3D sizeof (uint32_t);
> +
> +  /* When Patchable Function Entry (PFE) is enabled, there may be NOP
> +     instructions between the typeid and the function entry point.
> +     Since KCFI callsites have no way to see PFE function attributes,
> +     it can only base the calculations on the global
> +     -fpatchable-function-entry=3DTOTAL[,PREFIX] flag.  */
> +  HOST_WIDE_INT prefix_nops =3D 0;
> +  if (flag_patchable_function_entry)
> +    {
> +      HOST_WIDE_INT total_nops;
> +      parse_and_check_patch_area (flag_patchable_function_entry, false,
> +                                 &total_nops, &prefix_nops);
> +    }
> +
> +  /* However, PFE is measured in NOP instruction counts, not bytes.  So
> +     we need to find out how many bytes they are, and we may need to
> +     emit NOPs for alignment padding later.  Prepare the NOP template.  =
*/
> +  rtx_insn *nop_insn =3D make_insn_raw (gen_nop ());
> +  int code_num =3D recog_memoized (nop_insn);
> +  kcfi_nop =3D get_insn_template (code_num, nop_insn);
> +  int nop_insn_bytes =3D get_attr_length (nop_insn);
> +
> +  /* Adjust the offset by how many NOP bytes may be between the typeid
> +     and the function entry point.
> +
> +     __cfi_func:
> +       [typeid]                // -(4 + (prefix nop count * nop size)) f=
rom func
> +       [prefix nops]   // added when -fpatchable-function-entry is set
> +     func:
> +       [entry nops]    // added when -fpatchable-function-entry is set
> +       [function body]
> +
> +     At this point, kcfi_typeid_offset is ready and callsites can now
> +     correctly find the typeid.
> +
> +   */
> +  int prefix_nop_bytes =3D prefix_nops * nop_insn_bytes;
> +  kcfi_typeid_offset +=3D prefix_nop_bytes;
> +
> +  /* In the case where the KCFI preamble (and potentially the prefix NOP=
s)
> +     are being used for alternative CFI implementations via live-patchin=
g,
> +     the __cfi_... label itself needs to be usable as a callable functio=
n
> +     target, so alignment NOPs may need to be added between the preamble
> +     label and the typeid during KCFI preamble emission:
> +
> +     __cfi_func:               // may need to be function entry aligned
> +       [alignment padding nops] // may be needed when -falign-functions =
set
> +       [typeid]
> +       [prefix nops]
> +     func:
> +       [entry nops]
> +       [function body]
> +
> +     But we only calculate alignment padding NOPs when -falign-functions
> +     has been explicitly set.
> +   */
> +  if (align_functions.levels[0].log <=3D 0)
> +    return;
> +  int function_entry_alignment =3D align_functions.levels[0].get_value (=
);
> +
> +  /* Some architectures may be using an instruction for the typeid (thou=
gh
> +     this requires that the typeid is a trailing immediate value), but t=
he
> +     instruction will have a size greater than 4, which must be part of =
the
> +     resulting alignment padding calculation.  */
> +  int typeid_insn_bytes =3D targetm.kcfi.emit_type_id
> +                         ? targetm.kcfi.emit_type_id (NULL, 0, NULL)
> +                         : sizeof (uint32_t);
> +
> +  /* Calculate needed architecture-specific alignment padding bytes.  */
> +  int needed_alignment_bytes =3D (function_entry_alignment
> +                               - ((prefix_nop_bytes + typeid_insn_bytes)
> +                                  % function_entry_alignment))
> +                              % function_entry_alignment;
> +
> +  /* Calculate number of NOP instructions needed for alignment padding. =
 */
> +  if (needed_alignment_bytes % nop_insn_bytes !=3D 0)
> +    sorry ("KCFI function entry alignment padding bytes (%d) are not "
> +          "a multiple of architecture NOP instruction size (%d)",
> +          needed_alignment_bytes, nop_insn_bytes);
> +  kcfi_alignment_padding_nops =3D needed_alignment_bytes / nop_insn_byte=
s;
> +}
> +
> +/* Extract KCFI type ID from indirect call GIMPLE statement.  Uses the
> +   currently expanding GIMPLE statement to determine if KCFI instrumenta=
tion
> +   is needed.  Returns RTX constant with type ID, or NULL_RTX if no KCFI
> +   instrumentation is required.  */
> +
> +rtx
> +internal_kcfi_get_type_id_for_expanding_gimple_call (void)
> +{
> +  gcc_assert (currently_expanding_gimple_stmt);
> +  gcc_assert (is_gimple_call (currently_expanding_gimple_stmt));
> +
> +  /* Internally checks for no_sanitize("kcfi") with current_function_dec=
l.  */
> +  if (!sanitize_flags_p (SANITIZE_KCFI))
> +    return NULL_RTX;
> +
> +  gcall *call_stmt =3D as_a <gcall *> (currently_expanding_gimple_stmt);
> +
> +  /* Only indirect calls need KCFI instrumentation.  */
> +  if (gimple_call_fndecl (call_stmt))
> +    return NULL_RTX;
> +
> +  /* Skip calls originating from inlined no_sanitize("kcfi") functions. =
 */
> +  if (gimple_call_inlined_from_kcfi_nosantize_p (call_stmt))
> +    return NULL_RTX;
> +
> +  /* Get function type of call.  */
> +  tree fn_type =3D gimple_call_fntype (call_stmt);
> +  gcc_assert (fn_type);
> +
> +  /* Return the type_id.  */
> +  return GEN_INT (kcfi_get_type_id (fn_type));
> +}
> +
> +/* Emit KCFI type ID symbol for an address-taken external function.
> +   ASM_FILE is the output assembly file stream.  FNDECL is the external
> +   function declaration tree node.  Emits weak symbol definitions for
> +   external functions that are address-taken.  */
> +
> +void
> +kcfi_emit_typeid_symbol (FILE *asm_file, tree fndecl)
> +{
> +  /* Only emit for external function declarations.  */
> +  if (TREE_CODE (fndecl) !=3D FUNCTION_DECL || DECL_INITIAL (fndecl))
> +    return;
> +
> +  /* Only emit for functions that are address-taken.  */
> +  struct cgraph_node *node =3D cgraph_node::get (fndecl);
> +  if (!node || !node->address_taken)
> +    return;
> +
> +  /* Get symbol name from RTL and strip encoding prefixes.  */
> +  rtx rtl =3D DECL_RTL (fndecl);
> +  const char *name =3D XSTR (XEXP (rtl, 0), 0);
> +  name =3D targetm.strip_name_encoding (name);
> +
> +  /* .weak __kcfi_typeid_{name} */
> +  std::string symbol_name =3D std::string ("__kcfi_typeid_") + name;
> +  ASM_WEAKEN_LABEL (asm_file, symbol_name.c_str ());
> +
> +  /* .set __kcfi_typeid_{name}, 0x{type_id} */
> +  char val[16];
> +  snprintf (val, sizeof (val), "0x%08x",
> +           kcfi_get_type_id (TREE_TYPE (fndecl)));
> +  ASM_OUTPUT_DEF (asm_file, symbol_name.c_str (), val);
> +}
> +
> +/* Emit KCFI preamble before the function label.  ASM_FILE is the output
> +   assembly file stream.  FNDECL is the function declaration tree node.
> +   ACTUAL_FNAME is the actual function name to use, or NULL to use the
> +   function's assembler name.  Functions get preambles when -fsanitize=
=3Dkcfi
> +   is enabled, regardless of no_sanitize("kcfi") attribute.  */
> +
> +void
> +kcfi_emit_preamble (FILE *asm_file, tree fndecl, const char *actual_fnam=
e)
> +{
> +  /* Skip functions with nocf_check attribute.  */
> +  if (lookup_attribute ("nocf_check", TYPE_ATTRIBUTES (TREE_TYPE (fndecl=
))))
> +    return;
> +
> +  struct cgraph_node *node =3D cgraph_node::get (fndecl);
> +
> +  /* Ignore cold partition functions: not reached via indirect call.  */
> +  if (node && node->split_part)
> +    return;
> +
> +  /* Ignore cold partition sections: cold partitions are never indirect =
call
> +     targets.  Only skip preambles for cold partitions (has_bb_partition=
 =3D true)
> +     not for entire cold-attributed functions (has_bb_partition =3D fals=
e).  */
> +  if (in_cold_section_p && crtl && crtl->has_bb_partition)
> +    return;
> +
> +  /* Check if function is truly address-taken using cgraph node analysis=
.  */
> +  bool addr_taken =3D (node && node->address_taken);
> +
> +  /* Only instrument functions that can be targets of indirect calls:
> +     - Public functions (can be called externally)
> +     - External declarations (from other modules)
> +     - Functions with true address-taken status from cgraph analysis.  *=
/
> +  if (!(TREE_PUBLIC (fndecl) || DECL_EXTERNAL (fndecl) || addr_taken))
> +    return;
> +
> +  /* Use actual function name if provided, otherwise fall back to
> +     DECL_ASSEMBLER_NAME.  */
> +  const char *fname =3D actual_fname
> +                       ? actual_fname
> +                       : IDENTIFIER_POINTER (DECL_ASSEMBLER_NAME (fndecl=
));
> +
> +  /* Create symbol name for reuse.  */
> +  std::string cfi_symbol_name =3D std::string ("__cfi_") + fname;
> +
> +  /* Emit __cfi_ symbol with proper visibility.  */
> +  if (TREE_PUBLIC (fndecl))
> +    {
> +      if (DECL_WEAK (fndecl))
> +       ASM_WEAKEN_LABEL (asm_file, cfi_symbol_name.c_str ());
> +      else
> +       targetm.asm_out.globalize_label (asm_file, cfi_symbol_name.c_str =
());
> +    }
> +
> +  /* Emit .type directive.  */
> +  ASM_OUTPUT_TYPE_DIRECTIVE (asm_file, cfi_symbol_name.c_str (), "functi=
on");
> +  ASM_OUTPUT_LABEL (asm_file, cfi_symbol_name.c_str ());
> +
> +  /* Emit any needed alignment padding NOPs using target's NOP template.=
  */
> +  for (int i =3D 0; i < kcfi_alignment_padding_nops; i++)
> +    output_asm_insn (kcfi_nop, NULL);
> +
> +  /* Emit type ID bytes.  */
> +  uint32_t type_id =3D kcfi_get_type_id (TREE_TYPE (fndecl));
> +  if (targetm.kcfi.emit_type_id)
> +    targetm.kcfi.emit_type_id (asm_file, type_id, fndecl);
> +  else
> +    fprintf (asm_file, "\t.word\t0x%08x\n", type_id);
> +
> +  /* Mark end of __cfi_ symbol and emit size directive.  */
> +  std::string cfi_end_label =3D std::string (".Lcfi_func_end_") + fname;
> +  ASM_OUTPUT_LABEL (asm_file, cfi_end_label.c_str ());
> +
> +  ASM_OUTPUT_MEASURED_SIZE (asm_file, cfi_symbol_name.c_str ());
> +}
> +
> +namespace {
> +
> +/* IPA pass for KCFI type ID setting - runs once per compilation unit.  =
*/
> +
> +const pass_data pass_data_ipa_kcfi =3D
> +{
> +  SIMPLE_IPA_PASS, /* type */
> +  "ipa_kcfi", /* name */
> +  OPTGROUP_NONE, /* optinfo_flags */
> +  TV_IPA_OPT, /* tv_id */
> +  0, /* properties_required */
> +  0, /* properties_provided */
> +  0, /* properties_destroyed */
> +  0, /* todo_flags_start */
> +  0, /* todo_flags_finish */
> +};
> +
> +/* Set KCFI type_ids for all usable function types in compilation unit.
> +   Processes all functions in the current compilation unit and caches th=
eir
> +   KCFI type identifiers.  Returns 0 on completion.  */
> +
> +static unsigned int
> +ipa_kcfi_execute (void)
> +{
> +  struct cgraph_node *node;
> +
> +  /* Prepare global KCFI alignment NOPs calculation once for all functio=
ns.  */
> +  kcfi_prepare_alignment_nops ();
> +
> +  /* Process all functions - both local and external.  */
> +  FOR_EACH_FUNCTION (node)
> +    {
> +      tree fndecl =3D node->decl;
> +
> +      /* Skip all non-NORMAL builtins (MD, FRONTEND) entirely.
> +        For NORMAL builtins, skip those that lack an implicit
> +        implementation (closest way to distinguishing DEF_LIB_BUILTIN
> +        from others).  E.g. we need to have typeids for memset().  */
> +      if (fndecl_built_in_p (fndecl))
> +       {
> +         if (DECL_BUILT_IN_CLASS (fndecl) !=3D BUILT_IN_NORMAL)
> +           continue;
> +         if (!builtin_decl_implicit_p (DECL_FUNCTION_CODE (fndecl)))
> +           continue;
> +       }
> +
> +      /* Cache the type_id in the function type.  */
> +      kcfi_get_type_id (TREE_TYPE (fndecl));
> +    }
> +
> +  return 0;
> +}
> +
> +class pass_ipa_kcfi : public simple_ipa_opt_pass
> +{
> +public:
> +  pass_ipa_kcfi (gcc::context *ctxt)
> +    : simple_ipa_opt_pass (pass_data_ipa_kcfi, ctxt)
> +  {}
> +
> +  bool gate (function *) final override
> +  {
> +    return sanitize_flags_p (SANITIZE_KCFI);
> +  }
> +
> +  unsigned int execute (function *) final override
> +  {
> +    return ipa_kcfi_execute ();
> +  }
> +
> +}; /* class pass_ipa_kcfi */
> +
> +} /* anon namespace */
> +
> +simple_ipa_opt_pass *
> +make_pass_ipa_kcfi (gcc::context *ctxt)
> +{
> +  return new pass_ipa_kcfi (ctxt);
> +}
> diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
> index 8a1b13c0263e..5e93d9d2ce7c 100644
> --- a/gcc/doc/extend.texi
> +++ b/gcc/doc/extend.texi
> @@ -2789,6 +2789,44 @@ void __attribute__ ((no_sanitize ("alignment,objec=
t-size")))
>  g () @{ /* @r{Do something.} */; @}
>  @end smallexample
>
> +When @code{no_sanitize ("kcfi")} is applied to a function, it disables
> +the generation of Kernel Control Flow Integrity (KCFI) instrumentation
> +for indirect function calls within that function.  This means that
> +indirect calls in the marked function will not be checked against the
> +target function's type signature.
> +
> +However, the function itself will still receive a KCFI preamble (type
> +identifier) when compiled with @option{-fsanitize=3Dkcfi}, allowing it t=
o
> +be safely called indirectly from other functions that do perform KCFI
> +checks.  In other words, @code{no_sanitize ("kcfi")} affects outgoing
> +calls from the function, not incoming calls to the function.
> +
> +@smallexample
> +void __attribute__ ((no_sanitize ("kcfi")))
> +trusted_function(void (*callback)(int))
> +@{
> +  /* This indirect call will NOT be instrumented with KCFI checks.  */
> +  callback (42);
> +@}
> +
> +void regular_function(void (*callback)(int))
> +@{
> +  /* This indirect call WILL be instrumented with KCFI checks.  */
> +  callback (42);
> +@}
> +@end smallexample
> +
> +This attribute is primarily used in kernel code for special contexts suc=
h
> +as BPF JIT trampolines or other low-level code where KCFI instrumentatio=
n
> +might interfere with the intended operation.  The attribute survives
> +inlining to ensure that @code{no_sanitize("kcfi")} functions do not gene=
rate
> +KCFI checks even when inlined into a function that otherwise performs KC=
FI
> +checks.
> +
> +Note: To disable KCFI preamble generation for functions so that they may
> +explicitly not be called indirectly, use the @code{nocf_check} function
> +attribute instead.
> +
>  @cindex @code{no_sanitize_address} function attribute
>  @item no_sanitize_address
>  @itemx no_address_safety_analysis
> @@ -3161,6 +3199,10 @@ instrumentation on all functions that are part of =
the instrumentation
>  framework with the attribute @code{patchable_function_entry (0)}
>  to prevent recursion.
>
> +This attribute cannot be used with @option{-fsanitize=3Dkcfi} because KC=
FI
> +callsites cannot know about function-specific patchable entry settings o=
n
> +a preamble in a different translation unit.
> +
>  @cindex @code{pure} function attribute
>  @cindex functions that have no side effects
>  @item pure
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index 813403a97331..f13f5d6620cb 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -18695,6 +18695,39 @@ possible by specifying the command-line options
>  @option{--param hwasan-instrument-allocas=3D1} respectively. Using a ran=
dom frame
>  tag is not implemented for kernel instrumentation.
>
> +@opindex fsanitize=3Dkcfi
> +@item -fsanitize=3Dkcfi
> +Enable Kernel Control Flow Integrity (KCFI), a lightweight control
> +flow integrity mechanism designed for operating system kernels.
> +KCFI instruments indirect function calls to verify that the target
> +function has the expected type signature at runtime.  Each function
> +receives a unique type identifier computed from a hash of its function
> +prototype (including parameter types and return type).  Before each
> +indirect call, the implementation inserts a check to verify that the
> +target function's type identifier matches the expected identifier
> +for the call site, issuing a trap instruction if a mismatch is detected.
> +This provides forward-edge control flow protection against attacks that
> +attempt to redirect indirect calls to unintended targets.
> +
> +The implementation adds minimal runtime overhead and does not require
> +runtime library support, making it suitable for kernel environments.
> +The type identifier is placed before the function entry point,
> +allowing runtime verification without additional metadata structures,
> +and without changing the entry points of the target functions.
> +
> +KCFI is intended primarily for kernel code and may not be suitable
> +for user-space applications that rely on techniques incompatible
> +with strict type checking of indirect calls.
> +
> +Note that KCFI is incompatible with function-specific
> +@code{patchable_function_entry} attributes because KCFI call sites
> +cannot know about function-specific patchable entry settings in differen=
t
> +translation units.  Only the global @option{-fpatchable-function-entry}
> +command-line option is supported with KCFI.
> +
> +Use @option{-fdump-ipa-kcfi-details} to examine the computed type identi=
fier
> +hashes and their corresponding mangled type strings during compilation.
> +
>  @opindex fsanitize=3Dpointer-compare
>  @item -fsanitize=3Dpointer-compare
>  Instrument comparison operation (<, <=3D, >, >=3D) with pointer operands=
.
> diff --git a/gcc/doc/tm.texi b/gcc/doc/tm.texi
> index 25aad2eb74b6..e38dfba2d5ad 100644
> --- a/gcc/doc/tm.texi
> +++ b/gcc/doc/tm.texi
> @@ -3175,6 +3175,7 @@ This describes the stack layout and calling convent=
ions.
>  * Tail Calls::
>  * Shrink-wrapping separate components::
>  * Stack Smashing Protection::
> +* Kernel Control Flow Integrity::
>  * Miscellaneous Register Hooks::
>  @end menu
>
> @@ -5441,6 +5442,37 @@ should be allocated from heap memory and consumers=
 should release them.
>  The result will be pruned to cases with PREFIX if not NULL.
>  @end deftypefn
>
> +@node Kernel Control Flow Integrity
> +@subsection Kernel Control Flow Integrity
> +@cindex kernel control flow integrity
> +@cindex KCFI
> +
> +@deftypefn {Target Hook} bool TARGET_KCFI_SUPPORTED (void)
> +Return true if the target supports Kernel Control Flow Integrity (KCFI).
> +This hook indicates whether the target has implemented the necessary RTL
> +patterns and infrastructure to support KCFI instrumentation.  The defaul=
t
> +implementation returns false.
> +@end deftypefn
> +
> +@deftypefn {Target Hook} uint32_t TARGET_KCFI_MASK_TYPE_ID (uint32_t @va=
r{type_id})
> +Apply architecture-specific masking to KCFI type ID.  This hook allows
> +targets to apply bit masks or other transformations to the computed KCFI
> +type identifier to match the target's specific requirements.  The defaul=
t
> +implementation returns the type ID unchanged.
> +@end deftypefn
> +
> +@deftypefn {Target Hook} int TARGET_KCFI_EMIT_TYPE_ID (FILE *@var{file},=
 uint32_t @var{type_id}, tree @var{fndecl})
> +Emit architecture-specific type ID instruction for KCFI preambles
> +and return the size of the instruction in bytes.
> +@var{file} is the assembly output stream and @var{type_id} is the KCFI
> +type identifier to emit.  If @var{file} is NULL, skip emission and only
> +return the size.  If not overridden, the default fallback emits a
> +@code{.word} directive with the type ID and returns 4 bytes.  Targets ca=
n
> +override this to emit different instruction sequences and return their
> +corresponding sizes.  @var{fndecl} is the function declaration, which
> +targets can use to compute architecture-specific arity or other properti=
es.
> +@end deftypefn
> +
>  @node Miscellaneous Register Hooks
>  @subsection Miscellaneous register hooks
>  @cindex miscellaneous register hooks
> diff --git a/gcc/Makefile.in b/gcc/Makefile.in
> index a4adc223d8ed..874a1f8f5afe 100644
> --- a/gcc/Makefile.in
> +++ b/gcc/Makefile.in
> @@ -1601,6 +1601,7 @@ OBJS =3D \
>         ira-lives.o \
>         jump.o \
>         kcfi-typeinfo.o \
> +       kcfi.o \
>         langhooks.o \
>         late-combine.o \
>         lcm.o \
> diff --git a/gcc/flag-types.h b/gcc/flag-types.h
> index 44a90becb27a..5f9ea6a6d7b3 100644
> --- a/gcc/flag-types.h
> +++ b/gcc/flag-types.h
> @@ -338,6 +338,8 @@ enum sanitize_code {
>    SANITIZE_KERNEL_HWADDRESS =3D 1UL << 30,
>    /* Shadow Call Stack.  */
>    SANITIZE_SHADOW_CALL_STACK =3D 1UL << 31,
> +  /* KCFI (Kernel Control Flow Integrity) */
> +  SANITIZE_KCFI =3D 1ULL << 32,
>    SANITIZE_SHIFT =3D SANITIZE_SHIFT_BASE | SANITIZE_SHIFT_EXPONENT,
>    SANITIZE_UNDEFINED =3D SANITIZE_SHIFT | SANITIZE_DIVIDE | SANITIZE_UNR=
EACHABLE
>                        | SANITIZE_VLA | SANITIZE_NULL | SANITIZE_RETURN
> diff --git a/gcc/gimple.h b/gcc/gimple.h
> index b421850625e0..c554e8f64699 100644
> --- a/gcc/gimple.h
> +++ b/gcc/gimple.h
> @@ -142,6 +142,7 @@ enum gf_mask {
>      GF_CALL_ALLOCA_FOR_VAR     =3D 1 << 5,
>      GF_CALL_INTERNAL           =3D 1 << 6,
>      GF_CALL_CTRL_ALTERING       =3D 1 << 7,
> +    GF_CALL_INLINED_FROM_KCFI_NOSANTIZE =3D 1 << 8,
>      GF_CALL_MUST_TAIL_CALL     =3D 1 << 9,
>      GF_CALL_BY_DESCRIPTOR      =3D 1 << 10,
>      GF_CALL_NOCF_CHECK         =3D 1 << 11,
> @@ -3487,6 +3488,27 @@ gimple_call_from_thunk_p (gcall *s)
>    return (s->subcode & GF_CALL_FROM_THUNK) !=3D 0;
>  }
>
> +/* If INLINED_FROM_KCFI_NOSANTIZE_P is true, mark GIMPLE_CALL S as being
> +   inlined from a function with no_sanitize("kcfi").  */
> +
> +inline void
> +gimple_call_set_inlined_from_kcfi_nosantize (gcall *s,
> +                                            bool inlined_from_kcfi_nosan=
tize_p)
> +{
> +  if (inlined_from_kcfi_nosantize_p)
> +    s->subcode |=3D GF_CALL_INLINED_FROM_KCFI_NOSANTIZE;
> +  else
> +    s->subcode &=3D ~GF_CALL_INLINED_FROM_KCFI_NOSANTIZE;
> +}
> +
> +/* Return true if GIMPLE_CALL S was inlined from a function with
> +   no_sanitize("kcfi").  */
> +
> +inline bool
> +gimple_call_inlined_from_kcfi_nosantize_p (const gcall *s)
> +{
> +  return (s->subcode & GF_CALL_INLINED_FROM_KCFI_NOSANTIZE) !=3D 0;
> +}
>
>  /* If FROM_NEW_OR_DELETE_P is true, mark GIMPLE_CALL S as being a call
>     to operator new or delete created from a new or delete expression.  *=
/
> diff --git a/gcc/tree-pass.h b/gcc/tree-pass.h
> index 410341d47119..60d20176dc76 100644
> --- a/gcc/tree-pass.h
> +++ b/gcc/tree-pass.h
> @@ -543,6 +543,7 @@ extern ipa_opt_pass_d *make_pass_ipa_odr (gcc::contex=
t *ctxt);
>  extern ipa_opt_pass_d *make_pass_ipa_reference (gcc::context *ctxt);
>  extern ipa_opt_pass_d *make_pass_ipa_pure_const (gcc::context *ctxt);
>  extern simple_ipa_opt_pass *make_pass_ipa_pta (gcc::context *ctxt);
> +extern simple_ipa_opt_pass *make_pass_ipa_kcfi (gcc::context *ctxt);
>  extern simple_ipa_opt_pass *make_pass_ipa_tm (gcc::context *ctxt);
>  extern simple_ipa_opt_pass *make_pass_target_clone (gcc::context *ctxt);
>  extern simple_ipa_opt_pass *make_pass_dispatcher_calls (gcc::context *ct=
xt);
> diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
> index 28a034f6c065..4daec35d8b73 100644
> --- a/gcc/c-family/c-attribs.cc
> +++ b/gcc/c-family/c-attribs.cc
> @@ -48,6 +48,7 @@ along with GCC; see the file COPYING3.  If not see
>  #include "gimplify.h"
>  #include "tree-pretty-print.h"
>  #include "gcc-rich-location.h"
> +#include "asan.h"
>  #include "gcc-urlifier.h"
>  #include "attr-callback.h"
>
> @@ -1767,8 +1768,11 @@ handle_nocf_check_attribute (tree *node, tree name=
,
>        warning (OPT_Wattributes, "%qE attribute ignored", name);
>        *no_add_attrs =3D true;
>      }
> -  else if (!(flag_cf_protection & CF_BRANCH))
> +  else if (!(flag_cf_protection & CF_BRANCH)
> +          && !(flag_sanitize & SANITIZE_KCFI))
>      {
> +      /* Allow it with -fsanitize=3Dkcfi, but leave this warning alone
> +        to avoid confusion over this weird corner case.  */
>        warning (OPT_Wattributes, "%qE attribute ignored. Use "
>                                 "%<-fcf-protection%> option to enable it"=
,
>                                 name);
> @@ -6651,6 +6655,17 @@ static tree
>  handle_patchable_function_entry_attribute (tree *, tree name, tree args,
>                                            int, bool *no_add_attrs)
>  {
> +  /* Function-specific patchable_function_entry attribute is incompatibl=
e
> +     with KCFI because KCFI callsites cannot know about function-specifi=
c
> +     patchable entry settings on a preamble in a different translation
> +     unit.  */
> +  if (sanitize_flags_p (SANITIZE_KCFI))
> +    {
> +      error ("%qE attribute cannot be used with %<-fsanitize=3Dkcfi%>", =
name);
> +      *no_add_attrs =3D true;
> +      return NULL_TREE;
> +    }
> +
>    for (; args; args =3D TREE_CHAIN (args))
>      {
>        tree val =3D TREE_VALUE (args);
> diff --git a/gcc/df-scan.cc b/gcc/df-scan.cc
> index 1e4c6a2a4fb5..2be5e60786a3 100644
> --- a/gcc/df-scan.cc
> +++ b/gcc/df-scan.cc
> @@ -2851,6 +2851,13 @@ df_uses_record (class df_collection_rec *collectio=
n_rec,
>        /* If we're clobbering a REG then we have a def so ignore.  */
>        return;
>
> +    case KCFI:
> +      /* KCFI wraps other RTL - process the wrapped RTL.  */
> +      df_uses_record (collection_rec, &XEXP (x, 0), ref_type, bb, insn_i=
nfo,
> +                     flags);
> +      /* The type ID operand (XEXP (x, 1)) doesn't contain register uses=
.  */
> +      return;
> +
>      case MEM:
>        df_uses_record (collection_rec,
>                       &XEXP (x, 0), DF_REF_REG_MEM_LOAD,
> diff --git a/gcc/doc/tm.texi.in b/gcc/doc/tm.texi.in
> index 24d47b19e5f1..dd1cbe01293d 100644
> --- a/gcc/doc/tm.texi.in
> +++ b/gcc/doc/tm.texi.in
> @@ -2442,6 +2442,7 @@ This describes the stack layout and calling convent=
ions.
>  * Tail Calls::
>  * Shrink-wrapping separate components::
>  * Stack Smashing Protection::
> +* Kernel Control Flow Integrity::
>  * Miscellaneous Register Hooks::
>  @end menu
>
> @@ -3816,6 +3817,17 @@ generic code.
>
>  @hook TARGET_GET_VALID_OPTION_VALUES
>
> +@node Kernel Control Flow Integrity
> +@subsection Kernel Control Flow Integrity
> +@cindex kernel control flow integrity
> +@cindex KCFI
> +
> +@hook TARGET_KCFI_SUPPORTED
> +
> +@hook TARGET_KCFI_MASK_TYPE_ID
> +
> +@hook TARGET_KCFI_EMIT_TYPE_ID
> +
>  @node Miscellaneous Register Hooks
>  @subsection Miscellaneous register hooks
>  @cindex miscellaneous register hooks
> diff --git a/gcc/final.cc b/gcc/final.cc
> index afcb0bb9efbc..7f6aa9f9e480 100644
> --- a/gcc/final.cc
> +++ b/gcc/final.cc
> @@ -2094,6 +2094,9 @@ call_from_call_insn (const rtx_call_insn *insn)
>         case SET:
>           x =3D XEXP (x, 1);
>           break;
> +       case KCFI:
> +         x =3D XEXP (x, 0);
> +         break;
>         }
>      }
>    return x;
> diff --git a/gcc/opts.cc b/gcc/opts.cc
> index 38f96efe7669..f1b324c5a397 100644
> --- a/gcc/opts.cc
> +++ b/gcc/opts.cc
> @@ -2182,6 +2182,7 @@ const struct sanitizer_opts_s sanitizer_opts[] =3D
>    SANITIZER_OPT (pointer-overflow, SANITIZE_POINTER_OVERFLOW, true, true=
),
>    SANITIZER_OPT (builtin, SANITIZE_BUILTIN, true, true),
>    SANITIZER_OPT (shadow-call-stack, SANITIZE_SHADOW_CALL_STACK, false, f=
alse),
> +  SANITIZER_OPT (kcfi, SANITIZE_KCFI, false, true),
>    SANITIZER_OPT (all, ~sanitize_code_type (0), true, true),
>  #undef SANITIZER_OPT
>    { NULL, sanitize_code_type (0), 0UL, false, false }
> diff --git a/gcc/passes.cc b/gcc/passes.cc
> index a33c8d924a52..4c6ceac740ff 100644
> --- a/gcc/passes.cc
> +++ b/gcc/passes.cc
> @@ -63,6 +63,7 @@ along with GCC; see the file COPYING3.  If not see
>  #include "diagnostic-core.h" /* for fnotice */
>  #include "stringpool.h"
>  #include "attribs.h"
> +#include "kcfi.h"
>
>  /* Reserved TODOs */
>  #define TODO_verify_il                 (1u << 31)
> diff --git a/gcc/passes.def b/gcc/passes.def
> index fac04cd86c7d..3d17873d76da 100644
> --- a/gcc/passes.def
> +++ b/gcc/passes.def
> @@ -52,6 +52,7 @@ along with GCC; see the file COPYING3.  If not see
>    NEXT_PASS (pass_ipa_auto_profile_offline);
>    NEXT_PASS (pass_ipa_free_lang_data);
>    NEXT_PASS (pass_ipa_function_and_variable_visibility);
> +  NEXT_PASS (pass_ipa_kcfi);
>    NEXT_PASS (pass_ipa_strub_mode);
>    NEXT_PASS (pass_build_ssa_passes);
>    PUSH_INSERT_PASSES_WITHIN (pass_build_ssa_passes)
> diff --git a/gcc/rtl.def b/gcc/rtl.def
> index 15ae7d10fcc1..af643d187b95 100644
> --- a/gcc/rtl.def
> +++ b/gcc/rtl.def
> @@ -318,6 +318,12 @@ DEF_RTL_EXPR(CLOBBER, "clobber", "e", RTX_EXTRA)
>
>  DEF_RTL_EXPR(CALL, "call", "ee", RTX_EXTRA)
>
> +/* KCFI wrapper for call expressions.
> +   Operand 0 is the call expression.
> +   Operand 1 is the KCFI type ID (const_int).  */
> +
> +DEF_RTL_EXPR(KCFI, "kcfi", "ee", RTX_EXTRA)

You don't document this new rtl in doc/rtl.texi.
Also I think it would be better if it was:
DEF_RTL_EXPR(KCFI, "kcfi", "ei", RTX_EXTRA)

So you don't need an extra indirection to the KCFI type ID. You can
just access it like `XUINT (kcficall, 2)`.
const_int seems too heavy weight for this.
I assume it fits in `unsigned int`.

Thanks,
Andrew

> +
>  /* Return from a subroutine.  */
>
>  DEF_RTL_EXPR(RETURN, "return", "", RTX_EXTRA)
> diff --git a/gcc/rtlanal.cc b/gcc/rtlanal.cc
> index 63a1d08c46cf..5016fe93ccac 100644
> --- a/gcc/rtlanal.cc
> +++ b/gcc/rtlanal.cc
> @@ -1177,6 +1177,11 @@ reg_referenced_p (const_rtx x, const_rtx body)
>      case IF_THEN_ELSE:
>        return reg_overlap_mentioned_p (x, body);
>
> +    case KCFI:
> +      /* For KCFI wrapper, check both the wrapped call and the type ID. =
 */
> +      return (reg_overlap_mentioned_p (x, XEXP (body, 0))
> +             || reg_overlap_mentioned_p (x, XEXP (body, 1)));

Isn't the type ID always a const_int if so then you don't need to
check if reg_overlap_mentioned_p here.

> +
>      case TRAP_IF:
>        return reg_overlap_mentioned_p (x, TRAP_CONDITION (body));
>
> diff --git a/gcc/target.def b/gcc/target.def
> index 61931278fd93..708489e99fce 100644
> --- a/gcc/target.def
> +++ b/gcc/target.def
> @@ -7666,6 +7666,45 @@ DEFHOOKPOD
>  The default value is NULL.",
>   const char *, NULL)
>
> +/* Kernel Control Flow Integrity (KCFI) hooks.  */
> +#undef HOOK_PREFIX
> +#define HOOK_PREFIX "TARGET_KCFI_"
> +HOOK_VECTOR (TARGET_KCFI, kcfi)
> +
> +DEFHOOK
> +(supported,
> + "Return true if the target supports Kernel Control Flow Integrity (KCFI=
).\n\
> +This hook indicates whether the target has implemented the necessary RTL=
\n\
> +patterns and infrastructure to support KCFI instrumentation.  The defaul=
t\n\
> +implementation returns false.",
> + bool, (void),
> + hook_bool_void_false)
> +
> +DEFHOOK
> +(mask_type_id,
> + "Apply architecture-specific masking to KCFI type ID.  This hook allows=
\n\
> +targets to apply bit masks or other transformations to the computed KCFI=
\n\
> +type identifier to match the target's specific requirements.  The defaul=
t\n\
> +implementation returns the type ID unchanged.",
> + uint32_t, (uint32_t type_id),
> + NULL)
> +
> +DEFHOOK
> +(emit_type_id,
> + "Emit architecture-specific type ID instruction for KCFI preambles\n\
> +and return the size of the instruction in bytes.\n\
> +@var{file} is the assembly output stream and @var{type_id} is the KCFI\n=
\
> +type identifier to emit.  If @var{file} is NULL, skip emission and only\=
n\
> +return the size.  If not overridden, the default fallback emits a\n\
> +@code{.word} directive with the type ID and returns 4 bytes.  Targets ca=
n\n\
> +override this to emit different instruction sequences and return their\n=
\
> +corresponding sizes.  @var{fndecl} is the function declaration, which\n\
> +targets can use to compute architecture-specific arity or other properti=
es.",
> + int, (FILE *file, uint32_t type_id, tree fndecl),
> + NULL)
> +
> +HOOK_VECTOR_END (kcfi)
> +
>  /* Close the 'struct gcc_target' definition.  */
>  HOOK_VECTOR_END (C90_EMPTY_HACK)
>
> diff --git a/gcc/toplev.cc b/gcc/toplev.cc
> index bcf1b7604c83..65496818cf57 100644
> --- a/gcc/toplev.cc
> +++ b/gcc/toplev.cc
> @@ -68,6 +68,7 @@ along with GCC; see the file COPYING3.  If not see
>  #include "attribs.h"
>  #include "asan.h"
>  #include "tsan.h"
> +#include "kcfi.h"
>  #include "plugin.h"
>  #include "context.h"
>  #include "pass_manager.h"
> @@ -1741,6 +1742,17 @@ process_options ()
>                   "requires %<-fno-exceptions%>");
>      }
>
> +  if (flag_sanitize & SANITIZE_KCFI)
> +    {
> +      if (!targetm.kcfi.supported ())
> +       sorry ("%<-fsanitize=3Dkcfi%> not supported by this target");
> +
> +      /* Compiling with -flto results in frontend language of GNU GIMPLE=
.
> +        Allow it since the original source was C.  */
> +      if (!lang_GNU_C () && !startswith (lang_hooks.name, "GNU GIMPLE"))
> +       sorry ("%<-fsanitize=3Dkcfi%> is only supported for C");
> +    }
> +
>    HOST_WIDE_INT patch_area_size, patch_area_start;
>    parse_and_check_patch_area (flag_patchable_function_entry, false,
>                               &patch_area_size, &patch_area_start);
> diff --git a/gcc/tree-inline.cc b/gcc/tree-inline.cc
> index 7fecf487af73..37eca44a5008 100644
> --- a/gcc/tree-inline.cc
> +++ b/gcc/tree-inline.cc
> @@ -2110,6 +2110,16 @@ copy_bb (copy_body_data *id, basic_block bb,
>           /* Advance iterator now before stmt is moved to seq_gsi.  */
>           gsi_next (&stmts_gsi);
>
> +         /* If inlining from a function with no_sanitize("kcfi"), mark a=
ny
> +            call statements in the inlined body with the flag so they sk=
ip
> +            KCFI instrumentation.  */
> +         if (is_gimple_call (stmt)
> +             && !sanitize_flags_p (SANITIZE_KCFI, id->src_fn))
> +           {
> +             gcall *call =3D as_a <gcall *> (stmt);
> +             gimple_call_set_inlined_from_kcfi_nosantize (call, true);
> +           }
> +
>           if (gimple_nop_p (stmt))
>               continue;
>
> diff --git a/gcc/varasm.cc b/gcc/varasm.cc
> index 0d78f5b384fb..07f2127721b7 100644
> --- a/gcc/varasm.cc
> +++ b/gcc/varasm.cc
> @@ -57,6 +57,7 @@ along with GCC; see the file COPYING3.  If not see
>  #include "attribs.h"
>  #include "asan.h"
>  #include "rtl-iter.h"
> +#include "kcfi.h"
>  #include "file-prefix-map.h" /* remap_debug_filename()  */
>  #include "alloc-pool.h"
>  #include "toplev.h"
> @@ -2199,6 +2200,10 @@ assemble_start_function (tree decl, const char *fn=
name)
>    unsigned short patch_area_size =3D crtl->patch_area_size;
>    unsigned short patch_area_entry =3D crtl->patch_area_entry;
>
> +  /* Emit KCFI preamble before any patchable areas.  */
> +  if (flag_sanitize & SANITIZE_KCFI)
> +    kcfi_emit_preamble (asm_out_file, decl, fnname);
> +
>    /* Emit the patching area before the entry label, if any.  */
>    if (patch_area_entry > 0)
>      targetm.asm_out.print_patchable_function_entry (asm_out_file,
> @@ -2767,6 +2772,9 @@ assemble_external_real (tree decl)
>        /* Some systems do require some output.  */
>        SYMBOL_REF_USED (XEXP (rtl, 0)) =3D 1;
>        ASM_OUTPUT_EXTERNAL (asm_out_file, decl, XSTR (XEXP (rtl, 0), 0));
> +
> +      if (flag_sanitize & SANITIZE_KCFI)
> +       kcfi_emit_typeid_symbol (asm_out_file, decl);
>      }
>  }
>  #endif
> @@ -7283,16 +7291,25 @@ default_elf_asm_named_section (const char *name, =
unsigned int flags,
>         fprintf (asm_out_file, ",%d", flags & SECTION_ENTSIZE);
>        if (flags & SECTION_LINK_ORDER)
>         {
> -         /* For now, only section "__patchable_function_entries"
> -            adopts flag SECTION_LINK_ORDER, internal label LPFE*
> -            was emitted in default_print_patchable_function_entry,
> -            just place it here for linked_to section.  */
> -         gcc_assert (!strcmp (name, "__patchable_function_entries"));
> -         fprintf (asm_out_file, ",");
> -         char buf[256];
> -         ASM_GENERATE_INTERNAL_LABEL (buf, "LPFE",
> -                                      current_function_funcdef_no);
> -         assemble_name_raw (asm_out_file, buf);
> +         if (!strcmp (name, "__patchable_function_entries"))
> +           {
> +             /* For patchable function entries, internal label LPFE*
> +                was emitted in default_print_patchable_function_entry,
> +                just place it here for linked_to section.  */
> +             fprintf (asm_out_file, ",");
> +             char buf[256];
> +             ASM_GENERATE_INTERNAL_LABEL (buf, "LPFE",
> +                                          current_function_funcdef_no);
> +             assemble_name_raw (asm_out_file, buf);
> +           }
> +         else if (!strcmp (name, ".kcfi_traps"))
> +           {
> +             /* KCFI traps section links to .text section.  */
> +             fprintf (asm_out_file, ",.text");
> +           }
> +         else
> +           internal_error ("unexpected use of %<SECTION_LINK_ORDER%> by =
"
> +                           "section %qs", name);
>         }
>        if (HAVE_COMDAT_GROUP && (flags & SECTION_LINKONCE))
>         {
> --
> 2.34.1
>
