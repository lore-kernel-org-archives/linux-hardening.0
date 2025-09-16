Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B2101F2
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002660; cv=none; b=brQT+eWjzcYVjh5l42laoWO9+w60L/TEdPqFE9EfxPOFMSOcu1ruSg4HLEzIi1uKCVTSsH5OuC/0/vUwhWxZvE0z1U8KkwDn1rSaXpuiJxEn17WX3VmM1Uqitwf6YFdp/5ZwQGyHrHyYZqm466SSYhPblwwd7lJFs2GwlQnSOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002660; c=relaxed/simple;
	bh=qsa3bDVIaItaFQ9v+YDgGiDLcYmpylsuP+zGUrNJcT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyiRDIMrCFIwiXLV2ktSdIpt3IchXz3mDRkSdNhZdrNl3R38wbaTWX124LValtWQDWB5pJiuXBLk2CnuBYvVzcsxGCQolfQTa2Kyc6uPQVmObFfW6nfHHz3/Pr1uGxrv6wzg2U2Kem6QYR43DTVMjf4nNsmhhh8hmdYeaiRAGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1cfidhD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1cfidhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB0C4CEEB;
	Tue, 16 Sep 2025 06:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758002659;
	bh=qsa3bDVIaItaFQ9v+YDgGiDLcYmpylsuP+zGUrNJcT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1cfidhDhJ4NnlYGRvpMzNRrLNBlCqd7yzGkjnijaDryVzr0+u+UjWNk3JEnaDkEH
	 MEAvv1UqaMVtS7YaY3jQDyiSBOUk0cnr5XOtPN5Z0fYvPSc4Z/KjfSd9e8oeKx6Qh6
	 wXCmyx9GWrwGdpxK71a6cs1wWdMW7DrL2YrUjGAt3DkjaGVG3ResVPqYzPUAo9B4Y5
	 xHIhJW8ET0tTU8kU+zOHaKiUaWLhjSl78cnvu+YlY6egtAWTrU9wDFYZw3v8JSSEeI
	 gTchiTYrBI2Nus5JUwOYG1XPu414qRZT8OYPqu9L96S+w8JjGKeMYfUMAbM9fELe1r
	 bO8/5PcLBRBuA==
Date: Mon, 15 Sep 2025 23:04:18 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Law <jeffreyalaw@gmail.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
Message-ID: <202509152254.8A38F96D91@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-6-kees@kernel.org>
 <dbf9a593-e19d-4f53-96d0-d067868f40b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbf9a593-e19d-4f53-96d0-d067868f40b5@gmail.com>

On Mon, Sep 15, 2025 at 09:40:53PM -0600, Jeff Law wrote:
> 
> 
> On 9/4/25 18:24, Kees Cook wrote:
> > Implement RISC-V-specific KCFI backend.
> > 
> > - Function preamble generation using .word directives for type ID storage
> >    at offset from function entry point (no alignment NOPs needed due to
> >    fix 4-byte instruction size).
> > 
> > - Scratch register allocation using t1/t2 (x6/x7) following RISC-V
> >    procedure call standard for temporary registers.
> > 
> > - Integration with .kcfi_traps section for debugger/runtime metadata
> >    (like x86_64).
> > 
> > Assembly Code Pattern for RISC-V:
> >    lw      t1, -4(target_reg)         ; Load actual type ID from preamble
> >    lui     t2, %hi(expected_type)     ; Load expected type (upper 20 bits)
> >    addiw   t2, t2, %lo(expected_type) ; Add lower 12 bits (sign-extended)
> >    beq     t1, t2, .Lkcfi_call        ; Branch if types match
> >    .Lkcfi_trap: ebreak                ; Environment break trap on mismatch
> >    .Lkcfi_call: jalr/jr target_reg    ; Execute validated indirect transfer
> > 
> > Build and run tested with Linux kernel ARCH=riscv.
> > 
> > gcc/ChangeLog:
> > 
> > 	config/riscv/riscv-protos.h: Declare KCFI helpers.
> > 	config/riscv/riscv.cc (riscv_maybe_wrap_call_with_kcfi): New
> > 	function, to wrap calls.
> > 	(riscv_maybe_wrap_call_value_with_kcfi): New function, to
> > 	wrap calls with return values.
> > 	(riscv_output_kcfi_insn): New function to emit KCFI assembly.
> > 	config/riscv/riscv.md: Add KCFI RTL patterns and hook expansion.
> > 	doc/invoke.texi: Document riscv nuances.
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >   gcc/config/riscv/riscv-protos.h |   3 +
> >   gcc/config/riscv/riscv.cc       | 147 ++++++++++++++++++++++++++++++++
> >   gcc/config/riscv/riscv.md       |  74 ++++++++++++++--
> >   gcc/doc/invoke.texi             |  13 +++
> >   4 files changed, 231 insertions(+), 6 deletions(-)
> > 
> > diff --git a/gcc/config/riscv/riscv-protos.h b/gcc/config/riscv/riscv-protos.h
> > index 2d60a0ad44b3..0e916fbdde13 100644
> > --- a/gcc/config/riscv/riscv-protos.h
> > +++ b/gcc/config/riscv/riscv-protos.h
> > @@ -126,6 +126,9 @@ extern bool riscv_split_64bit_move_p (rtx, rtx);
> >   extern void riscv_split_doubleword_move (rtx, rtx);
> >   extern const char *riscv_output_move (rtx, rtx);
> >   extern const char *riscv_output_return ();
> > +extern rtx riscv_maybe_wrap_call_with_kcfi (rtx, rtx);
> > +extern rtx riscv_maybe_wrap_call_value_with_kcfi (rtx, rtx);
> > +extern const char *riscv_output_kcfi_insn (rtx_insn *, rtx *);
> >   extern void riscv_declare_function_name (FILE *, const char *, tree);
> >   extern void riscv_declare_function_size (FILE *, const char *, tree);
> >   extern void riscv_asm_output_alias (FILE *, const tree, const tree);
> 
> > @@ -11346,6 +11347,149 @@ riscv_convert_vector_chunks (struct gcc_options *opts)
> >       return 1;
> >   }
> > +/* Apply KCFI wrapping to call pattern if needed.  */
> > +rtx
> > +riscv_maybe_wrap_call_with_kcfi (rtx pat, rtx addr)
> So our coding standards require a bit more for that function comment. What
> are PAT and ADDR and how are they used?

Sure, I can document those more fully in the next version.

> > +riscv_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> > +{
> > +  /* Target register.  */
> > +  rtx target_reg = operands[0];
> > +  gcc_assert (REG_P (target_reg));
> > +
> > +  /* Get KCFI type ID.  */
> > +  uint32_t expected_type = (uint32_t) INTVAL (operands[3]);
> Do we know operands[3] is a CONST_INT?

Yes, these all come from their respective RTL's:

         (match_operand 3 "const_int_operand"))

(Except for sibcalls where the RTL operand is offset by 1, but adjust
for in the call to riscv_output_kcfi_insn.

> 
> > +
> > +  /* Calculate typeid offset from call target.  */
> > +  HOST_WIDE_INT offset = -(4 + kcfi_patchable_entry_prefix_nops);
> > +
> > +  /* Choose scratch registers that don't conflict with target.  */
> > +  unsigned temp1_regnum = T1_REGNUM;
> > +  unsigned temp2_regnum = T2_REGNUM;
> ISTM that this will need some kidn of adjustment if someone were to compile
> with -ffixed-reg.  Maybe all we really need is a sorry() so that if someone
> were to try to fix the temporary registers they'd get a loud complaint from
> teh compiler.

Yeah, this needs more careful management of the scratch registers. I
have not been able to find a sane way to provide working constraints to
the RTL patterns, but I'd _much_ rather let the register allocator do
all this work.

> > +
> > +  /* Load actual type from memory at offset.  */
> > +  temp_operands[0] = gen_rtx_REG (SImode, temp1_regnum);
> > +  temp_operands[1] = gen_rtx_MEM (SImode,
> > +                      gen_rtx_PLUS (DImode, target_reg,
> > +                                   GEN_INT (offset)));
> > +  output_asm_insn ("lw\t%0, %1", temp_operands);
> Rather than using DImode for the PLUS, shouldn't it instead use Pmode so
> that it at least tries to work on rv32?  Or is this stuff somehow defined as
> only working for rv64?

It was designed entirely for rv64. I'm not against making it work with
rv32, but I just haven't tried or tested it there.

> > +
> > +  /* Execute the indirect call.  */
> > +  if (SIBLING_CALL_P (insn))
> > +    {
> > +      /* Tail call uses x0 (zero register) to avoid saving return address.  */
> > +      temp_operands[0] = gen_rtx_REG (DImode, 0);  /* x0 */
> > +      temp_operands[1] = target_reg;  /* target register */
> > +      temp_operands[2] = const0_rtx;
> > +      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
> > +    }
> > +  else
> > +    {
> > +      /* Regular call uses x1 (return address register).  */
> > +      temp_operands[0] = gen_rtx_REG (DImode, RETURN_ADDR_REGNUM);  /* x1 */
> > +      temp_operands[1] = target_reg;  /* target register */
> > +      temp_operands[2] = const0_rtx;
> > +      output_asm_insn ("jalr\t%0, %1, %2", temp_operands);
> > +    }
> More cases where we probably should be using Pmode.
> 
> We generally prefer to not generate assembly code like you've done, but
> instead prefer to generate actual RTL.  Is there some reason why you decided
> to use output_asm_insn rather than generating RTL and letting usual
> mechanisms for generating assembly code kick in?

Yeah, I covered this a bit in patch #2 in the series which describe the
design requirements. The main issue is that the typeid validation check
cannot be separated from the call, and the instruction pattern needs to
have very close control over the register usage so we don't introduce
any new indirect call gadgets (pop %target, call %target).

So, this is a replacement of the regular CALL rtl pattern. I am totally
open to any other way to do this. I have been bumbling around in here
(and on the other architectures) trying to find ways to make it all
work, but it still feels like a bit of a hack. :)

> > +On RISC-V, KCFI type identifiers are emitted as a @code{.word ID}
> > +directive (a 32-bit constant) before the function entry, similar to AArch64.
> > +RISC-V's natural 4-byte instruction alignment eliminates the need for
> > +additional padding NOPs.  When used with @option{-fpatchable-function-entry},
> > +the type identifier is placed before any patchable NOPs.
> Note that many designs implement the "C" extension and as a result only have
> a 2 byte alignment for instructions.

Okay, noted. Are there any restrictions on function pointer alignment?
Regardless, I should probably rewrite this language a bit to try to
better say "we don't care about alignment padding since the preamble
typeid contents are a multiple of instruction size" (which would still
be true for 2 byte alignemnt).

Thanks for looking this over!

-Kees

-- 
Kees Cook
