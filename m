Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB651917D0
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757994058; cv=none; b=ZGjHNb15kQvx5+14SthU572dxr/NwdVS6ikOCO9WlxJEkvWrJe914Q+RFG8QQB9md3YhoFnJNzafdBemepZEGtjlsweTi4VOZHuRklatzUMsABtrg58QHydn48HQqFVp+boqWRdEK8tPv6QwVe1/ygtdx9yGXTYwPGMtjCfovJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757994058; c=relaxed/simple;
	bh=VHgVKRhSvWgLessSnpdAHm7lt0qU5d3opMD0pHPY/xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQ/2teypB7F8FnhYpFRsktQU06oh04d2QoEXdm00murhF/uHvlLxXl7Vk0ZWzrS4QHTRKTrfnWgKmCHYjs9A46FjZUAkTOSIzwxgnFxLBnkETmKVvNP7aWoy2liD0REnhv1lPPILqN7K1tMkvkcgmycDO+gveRqqGmnh1IBgwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moy0t2PO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moy0t2PO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-772481b2329so5264433b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 15 Sep 2025 20:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757994056; x=1758598856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxYJ7j3JIu2i4eeQri3+U22dNTdD0G/OMTcdxsyMGEQ=;
        b=Moy0t2POyBUPFPN0n6Iy8okEcABRNkjaXswCuYrmn20UUcpnyW7F/xFDZufFjAQ68W
         vJz7S9iED7nvt5OODdDK4AcZIkaJZYBmXKuRkvh4DsQGh0KTi/3ak9NgYavIMkW3FxGF
         6z100EWnjWdPNrg+/CM0iBUd13F5mlZBzeQnkHHBeFcw7IFFBEImkTAO1uyEhSOOPu90
         rJcUK2jDIboqZsBwPNL6AJDdM+WfD7YTHKvu2m7bQyJU8JghBLdDteXo8V+bjCrmvWJT
         UG3jeFw+iVlvzIVrI/p8XJAhgqY2KlwZe8gNHaH05ydUBeYHh4AXU+0EUsGc3b5mHaEX
         gNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757994056; x=1758598856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxYJ7j3JIu2i4eeQri3+U22dNTdD0G/OMTcdxsyMGEQ=;
        b=BzcG+QBJu2mfIZGJpgy7/4isbLXibVGII2jIfMPq0tby0qigHKFX+5GJtAAHSkQsTg
         ORFfzhjBT3ds/iQCbyOavIuayW7DJQ9aBWtiSd8ein4ojKgHPLfH5v9B1lAsnu5Opr19
         yqH5cDOoM/kJE7IRKCD29XWHacDw1PWogPUKSHwZQAfmfcL0MHh098gLJqA/5s0Vwv8m
         yGwb9QfrJd6Hvn5lnappkMxEQvn/PMw++84FqoN+GZH7DPrV+UZinsojrIutl3+4ax/r
         lpv3kcGBi82/jM48QflBaXJp+cHkes+XHhLh2IY3DbpCeVLH0KYZTjcIj1mK70biPLAl
         YXkA==
X-Forwarded-Encrypted: i=1; AJvYcCWsfADnS0HURt/2+Y6MQ0umNHVSu5PEVhNK4jlylPhXQM2apKNYeCbrxcmfnjoFwKtTRH+d458BtHMgSipS2xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOah0pdqH2lJiqRj4H05Rb6e4LQHj9m/qASOXIoIrsQ5y+gTT
	6Co+ig7njNBfqj388Uai1P6nAZAdM2wt4K/qa2emtB/n5uRmInkgpOMQ
X-Gm-Gg: ASbGnctRPse0awX65H6OVbzD1txapx9w/5PXoW/H2/Z3Qd/myMpTIg57kUpTRRHv5U7
	6LIj1aO7xgdRCvtHik96Op29IbhB7/HdCZbupg0YoY4VIpL3FEq/6/ZT9j3WvudHNk05zGJg+Uv
	v4Dh2D9RKl45EXK7SDAOuNOcJccRU+TAWRzbUgaPuooPDoaIVcveaIa9MMd4zs0Bwi80FtGPcy9
	UzchJwnE2/lczMg74tWC6fUgowtrUtQlJ/24/+PD/c4zc2oYDYTfLzjYyHiWgHWoYTr/joxBGsD
	OqOyfDytlA+RCnm86aGOwGPAAtAAALTsuxrvar8bLe5G/RwOQcTF002H82eS48VAfLvC8QreEx4
	MuWb2+6tFT8ydYsIXN7r828XUBplRCRLiZ3txeQ==
X-Google-Smtp-Source: AGHT+IFlIJMesoLUJ6LdxDKauGDKY+Y14YjUre3YkDTw8sn9u16qQCGm7WqXCcLq1kloyGVAinLGBQ==
X-Received: by 2002:a05:6a20:4305:b0:245:ff00:5332 with SMTP id adf61e73a8af0-26029ea8f00mr18638975637.7.1757994056189;
        Mon, 15 Sep 2025 20:40:56 -0700 (PDT)
Received: from [172.31.0.38] ([136.38.201.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a399081dsm13112078a12.43.2025.09.15.20.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 20:40:55 -0700 (PDT)
Message-ID: <dbf9a593-e19d-4f53-96d0-d067868f40b5@gmail.com>
Date: Mon, 15 Sep 2025 21:40:53 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
To: Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Richard Biener <rguenther@suse.de>,
 Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
 Richard Earnshaw <richard.earnshaw@arm.com>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Marcus Shawcroft <marcus.shawcroft@arm.com>,
 Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng <kito.cheng@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Waterman <andrew@sifive.com>,
 Jim Wilson <jim.wilson.gcc@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Dan Li <ashimida.1990@gmail.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>, Joao Moreira
 <joao@overdrivepizza.com>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
 linux-hardening@vger.kernel.org
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-6-kees@kernel.org>
Content-Language: en-US
From: Jeff Law <jeffreyalaw@gmail.com>
In-Reply-To: <20250905002418.464643-6-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/25 18:24, Kees Cook wrote:
> Implement RISC-V-specific KCFI backend.
> 
> - Function preamble generation using .word directives for type ID storage
>    at offset from function entry point (no alignment NOPs needed due to
>    fix 4-byte instruction size).
> 
> - Scratch register allocation using t1/t2 (x6/x7) following RISC-V
>    procedure call standard for temporary registers.
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
> 
> Build and run tested with Linux kernel ARCH=riscv.
> 
> gcc/ChangeLog:
> 
> 	config/riscv/riscv-protos.h: Declare KCFI helpers.
> 	config/riscv/riscv.cc (riscv_maybe_wrap_call_with_kcfi): New
> 	function, to wrap calls.
> 	(riscv_maybe_wrap_call_value_with_kcfi): New function, to
> 	wrap calls with return values.
> 	(riscv_output_kcfi_insn): New function to emit KCFI assembly.
> 	config/riscv/riscv.md: Add KCFI RTL patterns and hook expansion.
> 	doc/invoke.texi: Document riscv nuances.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   gcc/config/riscv/riscv-protos.h |   3 +
>   gcc/config/riscv/riscv.cc       | 147 ++++++++++++++++++++++++++++++++
>   gcc/config/riscv/riscv.md       |  74 ++++++++++++++--
>   gcc/doc/invoke.texi             |  13 +++
>   4 files changed, 231 insertions(+), 6 deletions(-)
> 
> diff --git a/gcc/config/riscv/riscv-protos.h b/gcc/config/riscv/riscv-protos.h
> index 2d60a0ad44b3..0e916fbdde13 100644
> --- a/gcc/config/riscv/riscv-protos.h
> +++ b/gcc/config/riscv/riscv-protos.h
> @@ -126,6 +126,9 @@ extern bool riscv_split_64bit_move_p (rtx, rtx);
>   extern void riscv_split_doubleword_move (rtx, rtx);
>   extern const char *riscv_output_move (rtx, rtx);
>   extern const char *riscv_output_return ();
> +extern rtx riscv_maybe_wrap_call_with_kcfi (rtx, rtx);
> +extern rtx riscv_maybe_wrap_call_value_with_kcfi (rtx, rtx);
> +extern const char *riscv_output_kcfi_insn (rtx_insn *, rtx *);
>   extern void riscv_declare_function_name (FILE *, const char *, tree);
>   extern void riscv_declare_function_size (FILE *, const char *, tree);
>   extern void riscv_asm_output_alias (FILE *, const tree, const tree);

> @@ -11346,6 +11347,149 @@ riscv_convert_vector_chunks (struct gcc_options *opts)
>       return 1;
>   }
>   
> +/* Apply KCFI wrapping to call pattern if needed.  */
> +rtx
> +riscv_maybe_wrap_call_with_kcfi (rtx pat, rtx addr)
So our coding standards require a bit more for that function comment. 
What are PAT and ADDR and how are they used?



> +}
> +
> +/* Apply KCFI wrapping to call_value pattern if needed.  */
> +rtx
> +riscv_maybe_wrap_call_value_with_kcfi (rtx pat, rtx addr)
Similarly here.


> +
> +/* Output the assembly for a KCFI checked call instruction.  */
> +const char *
> +riscv_output_kcfi_insn (rtx_insn *insn, rtx *operands)
And here.


> +{
> +  /* Target register.  */
> +  rtx target_reg = operands[0];
> +  gcc_assert (REG_P (target_reg));
> +
> +  /* Get KCFI type ID.  */
> +  uint32_t expected_type = (uint32_t) INTVAL (operands[3]);
Do we know operands[3] is a CONST_INT?

> +
> +  /* Calculate typeid offset from call target.  */
> +  HOST_WIDE_INT offset = -(4 + kcfi_patchable_entry_prefix_nops);
> +
> +  /* Choose scratch registers that don't conflict with target.  */
> +  unsigned temp1_regnum = T1_REGNUM;
> +  unsigned temp2_regnum = T2_REGNUM;
ISTM that this will need some kidn of adjustment if someone were to 
compile with -ffixed-reg.  Maybe all we really need is a sorry() so that 
if someone were to try to fix the temporary registers they'd get a loud 
complaint from teh compiler.


> +
> +  /* Load actual type from memory at offset.  */
> +  temp_operands[0] = gen_rtx_REG (SImode, temp1_regnum);
> +  temp_operands[1] = gen_rtx_MEM (SImode,
> +                      gen_rtx_PLUS (DImode, target_reg,
> +                                   GEN_INT (offset)));
> +  output_asm_insn ("lw\t%0, %1", temp_operands);
Rather than using DImode for the PLUS, shouldn't it instead use Pmode so 
that it at least tries to work on rv32?  Or is this stuff somehow 
defined as only working for rv64?



> +
> +  /* Execute the indirect call.  */
> +  if (SIBLING_CALL_P (insn))
> +    {
> +      /* Tail call uses x0 (zero register) to avoid saving return address.  */
> +      temp_operands[0] = gen_rtx_REG (DImode, 0);  /* x0 */
> +      temp_operands[1] = target_reg;  /* target register */
> +      temp_operands[2] = const0_rtx;
> +      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
> +    }
> +  else
> +    {
> +      /* Regular call uses x1 (return address register).  */
> +      temp_operands[0] = gen_rtx_REG (DImode, RETURN_ADDR_REGNUM);  /* x1 */
> +      temp_operands[1] = target_reg;  /* target register */
> +      temp_operands[2] = const0_rtx;
> +      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
> +    }
More cases where we probably should be using Pmode.

We generally prefer to not generate assembly code like you've done, but 
instead prefer to generate actual RTL.  Is there some reason why you 
decided to use output_asm_insn rather than generating RTL and letting 
usual mechanisms for generating assembly code kick in?


>     rtx target = riscv_legitimize_call_address (XEXP (operands[0], 0));
> -  emit_call_insn (gen_sibcall_internal (target, operands[1], operands[2]));
> +  rtx pat = gen_sibcall_internal (target, operands[1], operands[2]);
> +  pat = riscv_maybe_wrap_call_with_kcfi (pat, target);
> +  emit_call_insn (pat);
>     DONE;
>   })
>   
> +;; KCFI sibling call - matches KCFI wrapper RTL
> +(define_insn "*kcfi_sibcall_insn"
> +  [(kcfi (call (mem:SI (match_operand:DI 0 "call_insn_operand" "l"))
> +               (match_operand 1 ""))
> +         (match_operand 3 "const_int_operand"))
> +   (use (unspec:SI [(match_operand 2 "const_int_operand")] UNSPEC_CALLEE_CC))]
> +  "SIBLING_CALL_P (insn)"
I think the DI for the memory operand should probably be :P instead so 
that we're not so tied to rv64.

> +;; KCFI sibling call with return value - matches KCFI wrapper RTL
> +(define_insn "*kcfi_sibcall_value_insn"
> +  [(set (match_operand 0 "")
> +	(kcfi (call (mem:SI (match_operand:DI 1 "call_insn_operand" "l"))
> +		    (match_operand 2 ""))
> +	      (match_operand 4 "const_int_operand")))
> +   (use (unspec:SI [(match_operand 3 "const_int_operand")] UNSPEC_CALLEE_CC))]
> +  "SIBLING_CALL_P (insn)"
> +{
> +  return riscv_output_kcfi_insn (insn, &operands[1]);
> +}
> +  [(set_attr "type" "call")
> +   (set_attr "length" "24")])
Similarly for this pattern.



>   
> +;; KCFI indirect call - matches KCFI wrapper RTL
> +(define_insn "*kcfi_call_internal"
> +  [(kcfi (call (mem:SI (match_operand:DI 0 "call_insn_operand" "l"))
> +               (match_operand 1 "" ""))
> +         (match_operand 3 "const_int_operand"))
> +   (use (unspec:SI [(match_operand 2 "const_int_operand")] UNSPEC_CALLEE_CC))
> +   (clobber (reg:SI RETURN_ADDR_REGNUM))]
> +  "!SIBLING_CALL_P (insn)"
> +{
> +  return riscv_output_kcfi_insn (insn, operands);
> +}
> +  [(set_attr "type" "call")
> +   (set_attr "length" "24")])
And this one.


>   
> +;; KCFI call with return value - matches KCFI wrapper RTL
> +(define_insn "*kcfi_call_value_insn"
> +  [(set (match_operand 0 "" "")
> +	(kcfi (call (mem:SI (match_operand:DI 1 "call_insn_operand" "l"))
> +		    (match_operand 2 "" ""))
> +	      (match_operand 4 "const_int_operand")))
> +   (use (unspec:SI [(match_operand 3 "const_int_operand")] UNSPEC_CALLEE_CC))
> +   (clobber (reg:SI RETURN_ADDR_REGNUM))]
> +  "!SIBLING_CALL_P (insn)"
> +{
> +  return riscv_output_kcfi_insn (insn, &operands[1]);
> +}
> +  [(set_attr "type" "call")
> +   (set_attr "length" "24")])
THis one too.


64).
>   
> +On RISC-V, KCFI type identifiers are emitted as a @code{.word ID}
> +directive (a 32-bit constant) before the function entry, similar to AArch64.
> +RISC-V's natural 4-byte instruction alignment eliminates the need for
> +additional padding NOPs.  When used with @option{-fpatchable-function-entry},
> +the type identifier is placed before any patchable NOPs. 
Note that many designs implement the "C" extension and as a result only 
have a 2 byte alignment for instructions.


Jeff
