Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA549CF21
	for <linux-hardening@vger.kernel.org>; Fri,  9 Oct 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553018; cv=none; b=hxGcBEgQ1GuoMBXSpJKwUhdozaXFpft4us+5zduyYLIM6CQMWZTx9xtBRIFXmXse/dosqxjTrP11GvjB8Fy1cN2aJPxm/9oOqk20HNadat6eKpKQLaLIR/0VOk35gYQxXmzxb7FMvC4Sok7TYr+EwRz0fGCV8c1Bnt3sLVO7ub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553018; c=relaxed/simple;
	bh=njJszu3y6d92YRLm1YbBdO4uzYdT++xq7uTtQmCrCQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVIqhEsoAdIbJdvmFmpnkprlAcc/qRlfjzfq/26AvRL57579dFxYnS6/wL6AG7BiMMxS9dExiMcWYEtrBhQ+qxcYPbVX5RBWDX7XgMXbZjFYPxm02ZsU+ERNh3tyKMmp1wn8ncvWpQ/07qt1eUMTjXZf2er2CTWaHRd7RkxipDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2J91NBC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hHb1dBHZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2J91NBC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hHb1dBHZ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DKGVg3024018
	for <linux-hardening@vger.kernel.org>; Fri, 9 Oct 2026 13:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kn01YQBVJs7dZ2p9I49z+8jWeDXb4E+0Y+L8YhD1J8o=; b=S2J91NBC/1//2gVH
	1397LInRoJr0ubir4hYghM+Olj/j2qdfzLS2t2dpBJbQZKCPoSZlxmN3W2a2aDv2
	ikRkm8GsgebZiSXJHTmdBqPjiscJT3TH6CILO8IFlW4TBZbyVOgqO0f0n6tSm4zq
	TdejFbDh3q2eWCeupRAhKnPZaaP3GtbW7rIXmkw1oojI3Kh7iDmf891o47/ve7Kk
	F8l4m6XvlPoLxn2dmVm8XVraCFSSrDsR/afigbfW2SDWDx650d7iRzG4xd4rM6yB
	Res7S8xUPKGDD0YHF9FRODhToSRmCrbIJX3pVC5Nfw6KmHFSADUNUAmtWudCE6pK
	k5BySQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxwbs9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 09 Oct 2026 13:36:56 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67686ccd1b6so8306118d50.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 Oct 2026 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791553015; x=1792157815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kn01YQBVJs7dZ2p9I49z+8jWeDXb4E+0Y+L8YhD1J8o=;
        b=hHb1dBHZNghHMa6KAWiLl0cXHOC7m2GfMSeK8Uvt1GgfJY9SVoZt9uxf+Gc78B0Qo8
         QkE4UFm3ElfuQMqDtd2y3hM4mf45ZTsxUQgffGg6jrplmQdwqVINZk0o7+bHpA49gppz
         mZL9m37I+v9fb6fIR4skH4XtzYUeo84ih63muIShmqeReOZTShD+51uyh0sIKbe2aGxW
         mETV7Evd/3gFttjNyXlX94xIiefhZ/v6XattgspY9zQUB0oYk6KaXU3cNGYnc3K93obH
         xY0QcJDpEnReZcDmFt6lJ/Ap3Gmmw+0JtBhLqytwkIbCS8BvjCKHiepeoN/Ydu4Ivpcy
         /mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553015; x=1792157815;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kn01YQBVJs7dZ2p9I49z+8jWeDXb4E+0Y+L8YhD1J8o=;
        b=03nWmp5pe8RRCnGWphY9NecetHL5uEuq14sw5jiIy0jVe4u7tb/82G63iCYpO/69d4
         H3EmLnM1GHcyNyLaH9k9kqvt1/GjOPpIUkQ/h+WQOBl4yfvtnPpQfptDbGuqVYFjNSy+
         egdkspTs6StZenTtgYL+F9LR4EbCSd0PE2SdBeyM/RM7ura1DPwVlY7iADdgRUuKimmN
         qwL3bPCX1ZhpWwjBQJLgtxSAG3Zn6H4CKso/sfZNTy8EUH7Um1GWMjaNv1KmZeqJYhkH
         Yy7Z7l1bEbDboWqh1xVktJU9yu5pHCgXgniLh7Etk8SFghTnT4PZxoVYnXW5Pdvs2R2q
         5ogg==
X-Forwarded-Encrypted: i=1; AKwUvByoYmeAAAheasZ869/3x2qUmbg6Zljh3Cibv9ZUpEXwk1WPTnuGruyVZTT9nFGNAN4XVehN0yo5QbB6pyW7aBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIFUFV93uJ33UunGfkha9xzvVLSNgB5xxg0b1LXEPMkzKiE18Y
	E0XnirmmVsh9f5KfFHF17lpq/S00K1aoVxUP0IO1/gOnpL0+T7vUgBev8mP57pqYezesCex3M9l
	zvog+e1HxhiWwaif8EFrIkAE9Oi06SFN1UUjNLGANA0+UyhV7E8Dax7YTEx5YrRn10tC10rE=
X-Gm-Gg: AYBFou1/MDBF+WdP3H/qv6MeOJ3F1pVNRfhzrDOxZsUVmnq0iKvalP+XAAA5mi3mxx0
	EktaGLD8y/n5N+13A9UraFYjYNLTGbuPx7XZo0f23VPFw0gIn8cm/ksJiP9ByJam6Q26lqdkT2A
	R8rwS2MGdqp3XmMStPgzMBEeOYvWIY4/7etOgOlrGYuyr5UvaF+eFCzynBd1Mjo/SMCVuLiUMsG
	liBftV96VNgzAy3ZOcXvA8waDS+/BYgGdBzgScv5xYFxn1pK44pu7xTw1sumB4NzxpVQQGF0ZOV
	AA5trwXpPkMIRa9zpNuusATRC2L/z6vLSrxSk7Huo56tFL4NyMiLFR1QD3Nez26u78RX2yuiOcs
	0C2bhxzqWhiBGUg==
X-Received: by 2002:a05:690e:4809:b0:677:c075:a576 with SMTP id 956f58d0204a3-6793604a27amr485829d50.57.1791553015032;
        Fri, 09 Oct 2026 06:36:55 -0700 (PDT)
X-Received: by 2002:a05:690e:4809:b0:677:c075:a576 with SMTP id 956f58d0204a3-6793604a27amr485796d50.57.1791553014416;
        Fri, 09 Oct 2026 06:36:54 -0700 (PDT)
Received: from [172.31.0.30] ([136.38.201.137])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6794057ac87sm91888d50.1.2026.10.09.06.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 06:36:53 -0700 (PDT)
Message-ID: <65c57069-0f3e-44e0-9562-8867548a7443@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 07:35:29 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
To: Kees Cook <kees@kernel.org>,
        Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Richard Biener <rguenther@suse.de>,
        Jeffrey Law
 <jefflaw@qti.qualcomm.com>,
        Joseph Myers <josmyers@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
        Uros Bizjak <ubizjak@gmail.com>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Juergen Christ
 <jchrist@linux.ibm.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira
 <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Osterlund Sebastian <sebastian.osterlund@intel.com>,
        Constable Scott D <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
References: <20261005154028.out.839-kees@kernel.org>
 <20261005154039.1464721-2-kees@kernel.org>
Content-Language: en-US
From: Jeff Law <jeffrey.law@oss.qualcomm.com>
In-Reply-To: <20261005154039.1464721-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NCBTYWx0ZWRfX1GNKvHgHwXSd
 fDy4BiNp0gkqO/iGJTVo1IIAgBRZ8X583cxRj50HooJmWw0VA2ZWGBy9se0gxo66QBdsvbtKeqf
 IoJllNrOkGhMjHwmUSKPkPWWmR1VohkZ8s452c0SUEJzxh//mi7xqfcnPr+oXEST2TrQvB1s72L
 8rD8QDaC4CGaOJi3uUTbxyGHZy+yndJ9BwVQyZRfjkzZ43PsgYD8Zo/BMn+NnTC8LhExdAGWXOU
 1tpBoZ/N98Tcj6Wkzhb1VXsCpl3B0sp/xGHXvoDPUwzDlxCcx2w8hE07euLbj8oKNmcjD0g7+4H
 nmiXpDtpVoa2edDIk/KrkNwjSWfYSOvT5zuifUdlZvPKNKsB+k5VTM0LWRW//GUNpYvkeQwh6GC
 7uauyh5gnltfs6IXaNyVclTIyxf6LC+AaxBrHkXV2if9w8rte21j8AD9GmvU4KN1Jo3kRlUoTX3
 qgvEH7wvc02/YlF8vqw==
X-Proofpoint-GUID: eIqs-uqTWpusdr_wtICnwW3kRJdtgJkX
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac8edf8 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=asGLMfRmzhnGNxaIYohjRg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=sb8BTsWPHRpwejcmeFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NCBTYWx0ZWRfX4R12DCbEwczp
 tGWW7Jsfjgnskn8CgMz448Bz4qBEr9YEZClzsugxdflr+vXZTZjCULDRDYL2xFXIcAew1Ai0itS
 7lITgLH9/hLIMjhoeam0exyzTh2RVBQ=
X-Proofpoint-ORIG-GUID: eIqs-uqTWpusdr_wtICnwW3kRJdtgJkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090054



On 10/5/26 9:40 AM, Kees Cook wrote:
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
> 	* kcfi.h: New file with KCFI public interface declarations.
> 	* kcfi.cc: New file implementing Kernel Control Flow Integrity
> 	infrastructure.
> 	* Makefile.in (OBJS): Add kcfi.o.
> 	* flag-types.h (enum sanitize_code): Add SANITIZE_KCFI.
> 	* gimple.h (enum gf_mask): Add GF_CALL_INLINED_FROM_KCFI_NOSANTIZE.
> 	(gimple_call_set_inlined_from_kcfi_nosantize): New function.
> 	(gimple_call_inlined_from_kcfi_nosantize_p): New function.
> 	* df-scan.cc (df_uses_record): Add KCFI case to handle KCFI RTL
> 	patterns and process wrapped RTL.
> 	* doc/extend.texi: Update nocf_check for kcfi.
> 	* doc/invoke.texi (fsanitize=kcfi): Add documentation for KCFI
> 	sanitizer option.
> 	* doc/tm.texi.in: Add Kernel Control Flow Integrity section with
> 	TARGET_KCFI_SUPPORTED, TARGET_KCFI_MASK_TYPE_ID,
> 	TARGET_KCFI_EMIT_TYPE_ID hooks.
> 	* doc/tm.texi: Regenerate.
> 	* final.cc (call_from_call_insn): Add KCFI case to handle
> 	KCFI-wrapped calls. Add kcfi_next_labelno().
> 	* opts.cc (sanitizer_opts): Add kcfi entry.
> 	(parse_sanitizer_options): Exclude SANITIZE_KCFI from
> 	-fsanitize-recover=all.
> 	* rtl.def (KCFI): Add new RTL code for KCFI instrumentation.
> 	* rtlanal.cc (reg_referenced_p): Add KCFI case.
> 	* target.def: Add KCFI target hooks.
> 	* toplev.cc (process_options): Add KCFI option processing.
> 	* tree-inline.cc (copy_bb): Handle KCFI no_sanitize attribute
> 	propagation during inlining.
> 	* tree-ssa-tail-merge.cc: Include kcfi.h.
> 	(gimple_equal_p): Don't treat calls that get different KCFI
> 	checks as equal.
> 	* varasm.cc (assemble_start_function): Emit KCFI preambles.
> 	(assemble_external_real): Emit KCFI typeid symbols.
> 	(default_elf_asm_named_section): Handle .kcfi_traps using
> 	SECTION_LINK_ORDER flag.
>
> gcc/c-family/ChangeLog:
>
> 	* c-attribs.cc: Include asan.h.
> 	(handle_nocf_check_attribute): Enable nocf_check under kcfi.
> 	(handle_patchable_function_entry_attribute): Add error for using
> 	patchable_function_entry attribute with -fsanitize=kcfi.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---


>
>
> +
> +#include "coretypes.h"
> +#include "rtl.h"
In general we try to avoid having .h files include other .h files. 
Instead push these into the appropriate .cc files.  This make it easier 
to spot potential layering violations since the use point is explicit in 
the .cc file rather than blindly carried around in a .h file and 
potentially getting exposed somewhere we don't want.


> +
> +/* Common helper for RTL patterns to emit .kcfi_traps section entry.
> +   Call after emitting trap label and instruction with the trap symbol
> +   reference.  */
> +extern void kcfi_emit_traps_section (FILE *file, rtx trap_label_sym,
> +				      int labelno);
> +
> +/* Extract KCFI type ID from current GIMPLE statement.  */
> +extern rtx internal_kcfi_get_type_id_for_expanding_gimple_call (void);
Pick one style.  You've got the parameter names in one prototype, but 
not the other.  The general preference within GCC is without the name.


> +
> +- The check-call instruction sequence must be treated as a single unit: it
> +  cannot be rearranged or split or optimized.  The pattern is that
> +  indirect calls, "call *%target", get converted into:
> +
> +    mov $target_expression, %target ; only present if the expression was
> +				    ; not already in %target register
> +    load -$offset(%target), %tmp    ; load typeid hash from target preamble
> +    cmp $typeid, %tmp		    ; compare expected typeid with loaded
> +    je .Lkcfi_call$N		    ; success: jump to the indirect call
> +  .Lkcfi_trap$N:		    ; label of trap insn
> +    trap			    ; trap on failure, but arranged so
> +				    ; "permissive mode" falls through
> +  .Lkcfi_call$N:		    ; label of call insn
> +    call *%target		    ; actual indirect call
So I sound like a broken record at this point.  I see the assertion that 
it has to be an atomic unit, but nothing about why.

> +  /* Keep a private copy: get_insn_template can return a pointer into a target
> +     output routine's static scratch buffer, and nop_insn is GC-allocated, so we
> +     must not cache the raw pointer for the life of the compilation.  */
> +  kcfi_nop = xstrdup (get_insn_template (code_num, nop_insn));
> +  int nop_insn_bytes = get_attr_length (nop_insn);
Note that some ports do not track insn lengths, so you'll consistently 
get back 0 on those.   I would probably recommend asserting the size is 
nonzero so that if you try to use this on a target without lengths 
you'll get a compile-time error rather than a runtime surprise.

Also note that length computations are not guaranteed to be correct; 
they are guaranteed to conservatively correct for things like 
jump/branch relaxing to work.  So in that context conservatively correct 
means the reported size is no smaller than the actual size.

So you need to make sure you're safe if the port reports back a longer 
size than what gets encoded into the final object.


> +  int prefix_nop_bytes = prefix_nops * nop_insn_bytes;
> +  kcfi_typeid_offset += prefix_nop_bytes;
> +
> +  /* In the case where the KCFI preamble (and potentially the prefix NOPs)
> +     are being used for alternative CFI implementations via live-patching,
> +     the __cfi_... label itself needs to be usable as a callable function
> +     target, so alignment NOPs may need to be added between the preamble
> +     label and the typeid during KCFI preamble emission:
> +
> +     __cfi_func:		// may need to be function entry aligned
> +       [alignment padding nops] // may be needed when -falign-functions set
> +       [typeid]
> +       [prefix nops]
> +     func:
> +       [entry nops]
> +       [function body]
> +
> +     But we only calculate alignment padding NOPs when -falign-functions
> +     has been explicitly set.
> +   */
> +  if (align_functions.levels[0].log <= 0)
> +    return;
So what happens if the port does not align functions to a useful boundary?

> +
> +  /* Ignore cold partition sections: cold partitions are never indirect call
> +     targets.  Only skip preambles for cold partitions (has_bb_partition = true)
> +     not for entire cold-attributed functions (has_bb_partition = false).  */
> +  if (in_cold_section_p && crtl && crtl->has_bb_partition)
> +    return;
Is that an design decision in the partitioning code or is it an 
implementation detail.  If it's the former, than I'm inclined to allow 
relying on it.  If it's the latter, then it seems we're just setting up 
a ticking time bomb.  It could well be either, I don't know off the top 
of my head.

I'm assuming that things like devirtualizing a call into a direct call 
are safe, including the speculative forms.

Given we can pretty easily describe the generic call setup in RTL, how 
painful would it be to instead do the instrumentation in a generic way 
rather than twiddling each backend?

In that kind of design we'd force the target to provide the two marker 
insns which mark the beginning and end of the atomic region. Target 
independent code would be used to load the typeid hash from the preamble 
(using the offset the target provides), compare it to the expected type 
id, branch around a trap-like insn, the trap-like insn itself, then 
finally the call.  I'm not demanding this rethink, but I do want it to 
be at least considered as a design question.

Jeff
