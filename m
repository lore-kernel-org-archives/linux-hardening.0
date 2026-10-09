Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C932E68D
	for <linux-hardening@vger.kernel.org>; Fri,  9 Oct 2026 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520878; cv=none; b=hADCI5SfqJQXARW7LC2WCp97AipIt29XYexFrj5IzL1lGWtKIITtmAptnuiciNHGes1kl+58vsGf1+mnVdqeLnDtL7eJmdScd+fE+vP6nf1lyKiird63t+tf1vQJdLX8/1lBo8bfhFGUJ48j50YlbYOtVzfT0lnSY/GOUTvjk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520878; c=relaxed/simple;
	bh=apsBLvDSDtrYFtRdxOZIt90s+fhkjsDGV+I4GLlbPn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tK5c0+sOmcdpyxMeTBxydyEvM1XCLRzHNza8jp7KnGu8SSfS+P2WGzw0LrWYdfxCFtgVPgLdltzqcLgvpnpTCb7md0d4HpWtc0ZSJ5YYzUtRfcUKQgwpFoq9B+SGQDGJWhg2h97fb4nt7L17qpLer7/48PxIEkbpmJFb4+nRrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLAwxJiN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fm32SrKN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLAwxJiN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fm32SrKN"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HGrK3768836
	for <linux-hardening@vger.kernel.org>; Fri, 9 Oct 2026 04:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IJ+d/FOYRNyUIb33q7LNbY2OaJfC20fdzwp59+f6sfM=; b=XLAwxJiNdJtKA7MN
	6dKRhueRm5uYrWDVSvG9upcUGX8D6JY2Rz7nYm0nYYfeBzO2UcWYgQ/SuAKVdbqn
	8ItRaL76bTsg1U7W72mMv/OrWfUYYg8XroxlUUeG9pxYsaW80V3VP8JpAeMZQqAs
	KA1xijnvaZLzX/rYGPX+wyCpSizo2t1kBOOJaDgCxLbKmbyLHnb6AWDIZOAkvhBV
	Nqvy/Y6N+9uZ5yzRPgktzF22HmbYBbAVqY/CnGPH3uffP1IeQ5gNHu7M6BjPHTpM
	J2phRFhoKPQpRd6g6bf99M4fp/OLKqAbgvrMrBO9SsiiMPNf5C6OWX/3sfUYOmGP
	xja9ZA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu1vpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 09 Oct 2026 04:41:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3537eb16c5dso562228eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2026 21:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791520874; x=1792125674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJ+d/FOYRNyUIb33q7LNbY2OaJfC20fdzwp59+f6sfM=;
        b=fm32SrKNsUK82XYlQKuMdIjerRxhNHcGLHmoriuKXzXm/J0uYagMXMidxl5apv0U+i
         P1HfC3GnLijJHu/ThSwxqowssNc72v8R3LSiIdMfkJOCwTTtGGMd9p/fKzPuyO34/SQS
         ADX+RL4IjukxRC4vkAmof6aQNApfusuFJCKzjh2ElFeXrkeuBFqjLKw/1+fFx6W9bXQF
         CponevaqfO/G3dg718z67eLK8iOaUD1OmtSM9kzRWJJu0nPzz/wv9UP2Ndu5pF6J8mYk
         Wlg4h9kN4OcXsi6op2XKlJo2WnNP5AslKIAZcA4KCnchaKrUl99ZD5Ifzq/La5/bVLom
         n0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791520874; x=1792125674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJ+d/FOYRNyUIb33q7LNbY2OaJfC20fdzwp59+f6sfM=;
        b=lUz2Inj4Wq9WjP+XlLoK+8BTpYYgnwPWedA3twUvtZzuMaAt1umf5sbSQLYbxGH0Lh
         u8TohgExe17KHxd695BruNMaDxenyhZrIrhR2dXDTQyedxtQkg99MVKaFOPH/VnBwTrF
         rUPKL3jWJrW19ViiosQAkf5Z+3CGM2gi1WPK1/XY+BOELQnm7/lFIz42DY6Sz6G5b1MJ
         2mSUpWzah7IkpTMVaCV4pJwBOoCx7+wHFIkJgIaOYLLAum5dwYwsc7XW5bkNpatEc8bY
         JGg3zp0u78qVutmmInkAOBhdSghQLGlYfZXNvrUWfHRcnuzs/1v8826lZ7XENAv7gTpo
         SEAA==
X-Forwarded-Encrypted: i=1; AKwUvBwppv3CMrwzJ+rsOnkAMMwFFX9TP2I8qxNgNdkefNbQkEYtH8uDhthlh063V+VULUqV4nGkrCXtkuNn1+7EJvk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEzgkjfH1pZELY/NBXy5aG9F5xgKDsjXoqTmy5WwRKq2OPucHK
	gwVqHOqScD3KYhSYZKO7+PvW0cANpoxcWv4GVeZY6TadZxLU2idyKlGk3bd0aKtSM2JR4nrH+hs
	eFenjK706u356yvIvI76cJQJN2+yrfmBzjm02XN5jTzqSToJPfSXuBeA0YmdgOFIOimV0IRY=
X-Gm-Gg: AYBFou34zLUZtP1O6fqu3qPPAAeqM1EgApa5j3EgU6ujiT9potkaBfjvYjKcutExZZA
	GzDoMJljSMKCS2GrIwuAyR1ws8d/Naj7IY/+Xet1wFMgTwKaCDSvwadOHeP/VJsqk7bYUiY0irr
	O/9HhBkRrg6+QjRikPgr9zXOOwG5TIsOUhALAn7VdyqvK7UNmAnoqE2PD4bF+HlXDOA9FTD3nbj
	OfULW5MyZoTysKuO8dAfu3GFHh9FoO4llkvpsOsTH0aYn8gBdXELrA7nCwFy/+jQ5Ee1144cJR4
	5PQP4SpgDPRBBeWFiSQz5f2opVMcJz99fcFK/lUJw9kNbmTufksV6ekWKhwF5EEjmAP+HdURBCW
	wngzArgr8o7vzMg==
X-Received: by 2002:a05:7300:8803:b0:351:735e:2ef8 with SMTP id 5a478bee46e88-3537df50e9dmr1384172eec.7.1791520874105;
        Thu, 08 Oct 2026 21:41:14 -0700 (PDT)
X-Received: by 2002:a05:7300:8803:b0:351:735e:2ef8 with SMTP id 5a478bee46e88-3537df50e9dmr1384128eec.7.1791520873360;
        Thu, 08 Oct 2026 21:41:13 -0700 (PDT)
Received: from [172.31.0.30] ([136.38.201.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm3142057eec.21.2026.10.08.21.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 21:41:12 -0700 (PDT)
Message-ID: <45190057-a50b-40f4-9502-e3001fcac67e@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 22:39:50 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 7/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
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
 <20261005154039.1464721-7-kees@kernel.org>
Content-Language: en-US
From: Jeff Law <jeffrey.law@oss.qualcomm.com>
In-Reply-To: <20261005154039.1464721-7-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAxOCBTYWx0ZWRfX/JzhqSNQwlYz
 e4BERa2MsW+9xMmJ9If4c4SFTat+ejIbautcxofziFSd7ZWv00UxQ+WDFTyYvXiODHT9sFai04q
 FlhWHX+DuLqkVLz+QJjJSU7UVwvqRPvLbifhqeAK8BPdhtiDCJHv2hg4yGlP272g9Pq3zvJ00dN
 3VicwynVmpDwVrOzjTBkO7Xs8nc+SYq5br1KT/7A8rJTIwpWIbEu79CqyGFRgUXXLv6AxFi7jsS
 pUgcZeBzKSTQBvFNTAUW75tOLc/arwwC3UmwPDP2VcGuPuV7hq9ajkshNcGq58VNjD9P8SkiCzo
 9EpOSU/tWFqXb9m0y+QN3ewDuTfFwK9ecKu89Xil+UyRcpnZlQm3axmfKUmonjzXwDnYI8I9BSU
 t98xnnAt9uHLZ0PGpcGnSWHzJDck6w6aToD/tSIHg900WWYk0hHTWfbrA0eKF5BBST4dnUHxEkb
 fd4Omz451MUbTVg2P2g==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8706b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=asGLMfRmzhnGNxaIYohjRg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=IhVgPsebU4KIi37ElK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: CptW8ccda9f8wAAnSQu-ybAqWiD-a46H
X-Proofpoint-ORIG-GUID: CptW8ccda9f8wAAnSQu-ybAqWiD-a46H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAxOCBTYWx0ZWRfXx27raEczNkqS
 ajZqZMVXc83Pjx16WyZZjRrbRJ7ClplitfjAZgroGM9qBWioe76C9GqGw/UsZQ6oxNM2tvrwIHV
 p46NaHTiv+kS6lf24F3eJ2/6hm0h1No=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090018



On 10/5/26 9:40 AM, Kees Cook wrote:
> Implement RISC-V-specific KCFI backend. This is rv64-only: the emitted
> typeid construction uses addiw, which exists only on RV64/RV128. An rv32
> backend would need an alternate sequence (e.g. addi); since the only
> current user of KCFI on riscv is the rv64 build of the Linux kernel, the
> support hook rejects rv32.
Note that addiw explicitly sign extends the result from bit 32 out to 
bit 63.   That seems to match what you want with the implementation 
(since you do a lw do load the ID from the preamble and that's 
sign-extending from bit 32 to bit 63.


>
> - Scratch register allocation using t1/t2 (x6/x7) following RISC-V
>    procedure call standard for temporary registers (already
>    caller-saved), and t3 (x28) when either t1 or t2 is already the call
>    target register.
>
> - Incompatible with -ffixed-t1, -ffixed-t2, or -ffixed-t3.
>
> - Integration with .kcfi_traps section for debugger/runtime metadata
>    (like x86_64).
>
> Assembly Code Pattern for RISC-V:
>    lw      t1, -4(target_reg)         ; Load actual type ID from preamble
>    lui     t2, %hi(expected_type)     ; Load expected type (upper 20 bits)
>    addiw   t2, t2, %lo(expected_type) ; Add lower 12 bits (sign-extended)
>    beq     t1, t2, .Lkcfi_call        ; Branch if types match
>    .Lkcfi_trap: ebreak                ; Environment break trap on mismatch
>    .Lkcfi_call: jalr/jr target_reg    ; Execute validated indirect transfer
So what I can't recall ever seeing is an explanation of why this 
sequence needs to be emitted as a single assembly block.  That's 
something we generally try to avoid.  Now if that design decision/need 
is covered in the talk from the Cauldron, that's fine.  I was 
intercepted and couldn't get there in time, but I'll certainly make a 
point to watch the whole thing.

And note that if it really needs to be an atomic sequence, there's still 
ways to achieve that that avoid the blobs of assembly code.  See below.


>
> Build and run tested with Linux kernel ARCH=riscv.
>
> Assisted-by: LLM [tests]
>
> gcc/ChangeLog:
>
> 	* config/riscv/riscv-protos.h: Declare KCFI helpers.
> 	* config/riscv/riscv.cc (riscv_maybe_wrap_call_with_kcfi): New
> 	function, to wrap calls.
> 	(riscv_maybe_wrap_call_value_with_kcfi): New function, to
> 	wrap calls with return values.
> 	(riscv_output_kcfi_insn): New function to emit KCFI assembly.
> 	* config/riscv/riscv.md: Add KCFI RTL patterns and hook expansion.
> 	* doc/invoke.texi: Document riscv nuances.
>
> gcc/testsuite/ChangeLog:
>
> 	* gcc.dg/kcfi/kcfi-adjacency.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-basics.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-call-sharing.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-complex-addressing.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-direct-call-shapes.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-move-preservation.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-no-sanitize.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-offset-validation.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-patchable-large.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-patchable-medium.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-tail-calls.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-trap-section.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-trap-section-per-func.c: Add riscv patterns.
> 	* gcc.dg/kcfi/kcfi-riscv-32bit.c: New test.
> 	* gcc.dg/kcfi/kcfi-riscv-fixed-t1.c: New test.
> 	* gcc.dg/kcfi/kcfi-riscv-fixed-t2.c: New test.
> 	* gcc.dg/kcfi/kcfi-riscv-fixed-t3.c: New test.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>
>
>
>
>
> +
> +/* Output the assembly for a KCFI checked call instruction.  INSN is the
> +   RTL instruction being processed.  OPERANDS is the array of RTL operands
> +   where operands[0] is the call target register, operands[2] is the KCFI
> +   type ID constant.  Returns an empty string as all output is handled by
> +   direct assembly generation.  */
> +
> +const char *
> +riscv_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> +{
> +  /* Target register.  */
> +  rtx target_reg = operands[0];
> +  gcc_assert (REG_P (target_reg));
> +
> +  /* Get KCFI type ID.  */
> +  uint32_t expected_type = UINTVAL (operands[2]);
Generally you don't want to be using types like uint32_t, uint64_t, 
etc.  Those are properties of the host, not the target.   Given that 
you're using "lw" and a sign extending "addiw", you probably want this 
to be a HOST_WIDE_INT (vs an unsigned HOST_WIDE_INT).  It probably 
doesn't matter in practice here, but  if you're pulling data out via 
[U]INTVAL, then destination data type should generally be a 
HOST_WIDE_INT or unsigned variant of the same.
> +
> +  /* Calculate typeid offset from call target.  */
> +  HOST_WIDE_INT offset = -kcfi_get_typeid_offset ();
> +
> +  /* Choose scratch registers that don't conflict with target.  */
> +  unsigned temp1_regnum = T1_REGNUM;
> +  unsigned temp2_regnum = T2_REGNUM;
Why use fixed registers?   It would seem to work better if you just 
generated pseudos and let the register allocator do the right thing and 
assign them to whatever temporary is best.  That would also remove the 
restrictions around -ffixed-reg.




> +
> +  rtx temp_operands[3];
> +
> +  /* The check sequence (typeid load through indirect jump) must be emitted
> +     as a single atomic unit: a mismatch must be caught before the jalr
> +     executes, with no opportunity for the linker or assembler to interleave
> +     anything.  Disable linker relaxation (which can rewrite jalr/call forms
> +     and shift offsets) and the C extension (which can shrink instructions
> +     and perturb sizes the length attribute reports) for the duration.  */
> +  output_asm_insn (".option push", operands);
> +  output_asm_insn (".option norelax", operands);
> +  output_asm_insn (".option norvc", operands);
Why does this need to be an atomic sequence with restrictions around 
relaxing and compression avoidance?  From other comments I'm guessing 
you're rewriting that ebreak.  At the least you need to explain why its 
an atomic sequence.



> +
> +  /* Load actual type from memory at offset.  */
> +  temp_operands[0] = gen_rtx_REG (SImode, temp1_regnum);
> +  temp_operands[1] = gen_rtx_MEM (SImode,
> +				  gen_rtx_PLUS (DImode, target_reg,
> +						GEN_INT (offset)));
> +  output_asm_insn ("lw\t%0, %1", temp_operands);
So if we really don't need to generate an atomic sequence, then you've 
got the skeleton for generating RTL here.  You've got the register 
destination and memory source.  So instead of output_asm_insn, you'd do 
something like:


emit_move_insn (temp_operands[0], temp_operands[1]);


> +
> +  /* Load expected type using lui + addiw for proper sign extension.  */
> +  temp_operands[0] = gen_rtx_REG (SImode, temp2_regnum);
> +  temp_operands[1] = GEN_INT (hi20);
> +  output_asm_insn ("lui\t%0, %1", temp_operands);
> +
> +  temp_operands[0] = gen_rtx_REG (SImode, temp2_regnum);
> +  temp_operands[1] = gen_rtx_REG (SImode, temp2_regnum);
> +  temp_operands[2] = GEN_INT (lo12);
> +  output_asm_insn ("addiw\t%0, %1, %2", temp_operands);
All that turns into dest = force_reg (SImode, GEN_INT (expected_type));


> +
> +  /* Output conditional branch to call label.  */
> +  fprintf (asm_out_file, "\tbeq\t%s, %s, ",
> +	   reg_names[temp1_regnum], reg_names[temp2_regnum]);
> +  assemble_name (asm_out_file, call_name);
> +  fputc ('\n', asm_out_file);
And you'd emit a conditional branch here via emit_jump_insn after 
generating appropriate RTL.

> +
> +  /* Output trap label and ebreak instruction.  */
> +  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
> +  output_asm_insn ("ebreak", operands);
This is a "trap" insn.  So

emit_insn (gen_trap ()); or something along those lines.


> +
> +  /* Use common helper for trap section entry.  */
> +  rtx trap_label_sym = gen_rtx_SYMBOL_REF (Pmode, trap_name);
> +  kcfi_emit_traps_section (asm_out_file, trap_label_sym, labelno);
So do you do something fun like rewrite the trap?  Is that why you're 
generating the atomic sequence?  ANd if so, we can still get you an 
atomic sequence without emitting blobs of assembly code via emit_barrier 
() at the start and end of the atomic sequence.


If you're rewriting the trap, then I'd probably do somethign like

1. Define a new insn that has the same basic properties as a barrier, 
but emits the .option thingies at the start of the sequence.
2. Define another new insn also with barrier semantics that emits the 
option pop.
3. Convert riscv_output_kcfi_insn to emit RTL instead and hook into the 
define_expands.  It'll need to generate the insns you created in steps 
#1 and #2.

Note that steps #1 and #2 would in turn allow others to simplify other 
parts of the RISC-V port as well.  Not the main motivation, but worth 
noting.


> +
>   /* 'Unpack' up the internal tuning structs and update the options
>       in OPTS.  The caller must have set up selected_tune and selected_arch
>       as all the other target-specific codegen decisions are
> @@ -17360,6 +17535,30 @@ riscv_memtag_tag_bitsize ()
>   #undef TARGET_MEMTAG_TAG_BITSIZE
>   #define TARGET_MEMTAG_TAG_BITSIZE riscv_memtag_tag_bitsize
>   
> +/* Return true if the target supports KCFI.
> +   KCFI requires 64-bit mode and the T1, T2, and T3 registers.  */
> +
> +static bool
> +riscv_kcfi_supported_p (void)
We probably need to avoid for C++ due to thunks and Fortran due to 
multiple entry points.  And you may not have a good way to test for 
those, particularly in an LTO build.  We need to think about that 
problem.  There are ways to identify multiple entry points, but those 
assume you've got a control flow graph for the current function.  So 
they probably won't work here and we can't really check for what 
language is in use (think about LTO).

>   
> diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> index f0b1314d1731..b1ebae37ed89 100644
> --- a/gcc/doc/invoke.texi
> +++ b/gcc/doc/invoke.texi
> @@ -17631,6 +17631,23 @@ allowing the kernel to identify both the KCFI violation and the involved
>   registers for detailed diagnostics (eliminating the need for a separate
>   @code{.kcfi_traps} section as used on x86_64).
>   
> +On 64-bit RISC-V, KCFI type identifiers are emitted as a @code{.word ID}
> +directive (a 32-bit constant) before the function entry, similar to AArch64.
> +RISC-V's natural instruction alignment eliminates the need for
> +additional alignment NOPs.
Really?  Natural instruction alignment for the designs I expect to see 
almost everywhere is 16 bits (via the C extension which is mandatory for 
rva23 and used in nearly design I'm aware of).  So you've got a bit of a 
problem here as unaligned access isn't necessary guaranteed to work.  
You could do something like force the function alignment to 4 bytes when 
KFCI is on.  A bit hackish, but probably sensible in practice.


>    When used with @option{-fpatchable-function-entry},
> +the type identifier is placed before any prefix NOPs.  The runtime check
> +loads the actual type using @code{lw t1, OFFSET(target_reg)}, where the
Is the offset always at -4?  Just helps me understand the underlying 
assumptions you need to make.

Jeff




