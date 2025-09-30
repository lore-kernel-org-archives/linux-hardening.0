Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3E28E5F3
	for <linux-hardening@vger.kernel.org>; Tue, 30 Sep 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213128; cv=none; b=WOSF/thbFoeuVG1bzK/6tJd//m0cju77vQS8phowZvEBR75j7qaHF6WvmdF+/uELQJJ2GK/ayLQnvimYrS1VjrmVaQUMlT+BTixTF5pUn7knCQ7muZ5ljkOADbY07udSEIyoWjo7ySWkc/aCrQ0jRwFkG7z+nX8LUBlYQjkiCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213128; c=relaxed/simple;
	bh=WDkopG1jTiC2kMfpl5FnHxjHgxpo7bWOGneHIlcDJ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU/syyOW6mtrpimmg5+ZRhZ/WHcSRmAIaqoEb02U55RP2YGIQbEzC4IhXxp2ikuwm6kSEnVKLK2p3qlUiqcIS3mOC3ai8+UiEy91IRBWUL5+l0Pqo+H5Cvag5ayeoapKqckf8SBYoa8E5rz6FYbK/wpCYeB1BnaaBwaJwjlDgz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwHfi1C9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwHfi1C9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36091C4CEF0;
	Tue, 30 Sep 2025 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759213127;
	bh=WDkopG1jTiC2kMfpl5FnHxjHgxpo7bWOGneHIlcDJ/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwHfi1C9BVKnVbr7wI+ZMNUHx8DTRh77zVLJQfQqbgUdURT3KPPXbWdCYv8/WbPHF
	 PysP2M+Bn2Ya6Vxv+jAfD6ne3raccx46p+L+AEx9GlfCTDClWTHfygzNr735xMbyKM
	 7tznEsh0hv9PFMQDKQ4OK8AkAa13WrO/T49sKf4ocQws2ikxP67Y/rHmeyWx+VJNF2
	 1YM7Fb15PlyINcQbQluxdQFRcaVZO3FA6jDUM921R19TLECQwI3JFc6ssmAaLwusER
	 KwH0Zw3qRehlFM98txHksMpuftldILafpZazTv6nEHKi1FXz0ulL6EsrMSJNPId/Iq
	 Q3mTWENyOo98A==
Date: Mon, 29 Sep 2025 23:18:46 -0700
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jeff Law <jeffreyalaw@gmail.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 6/7] arm: Add ARM 32-bit Kernel Control Flow Integrity
 implementation
Message-ID: <202509292310.BB6055DC@keescook>
References: <20250926023737.it.616-kees@kernel.org>
 <20250926030252.2387681-6-kees@kernel.org>
 <CAMj1kXHQn0YEvpnwRigL_Mu61SGtGfmKVUJJgotGmm8S_BT8dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHQn0YEvpnwRigL_Mu61SGtGfmKVUJJgotGmm8S_BT8dA@mail.gmail.com>

On Mon, Sep 29, 2025 at 11:59:15AM +0200, Ard Biesheuvel wrote:
> On Fri, 26 Sept 2025 at 05:02, Kees Cook <kees@kernel.org> wrote:
> >
> > diff --git a/gcc/config/arm/arm.md b/gcc/config/arm/arm.md
> > index 422ae549b65b..c3b9f16ea872 100644
> > --- a/gcc/config/arm/arm.md
> > +++ b/gcc/config/arm/arm.md
> ...
> > +/* Output the assembly for a KCFI checked call instruction.  INSN is the
> > +   RTL instruction being processed.  OPERANDS is the array of RTL operands
> > +   where operands[0] is the call target register, operands[2] is the KCFI
> > +   type ID constant.  Returns an empty string as all output is handled by
> > +   direct assembly generation.  */
> > +
> > +const char *
> > +arm_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> > +{
> > +  /* KCFI type id.  */
> > +  uint32_t type_id = INTVAL (operands[2]);
> > +
> > +  /* Calculate typeid offset from call target.  */
> > +  HOST_WIDE_INT offset = -kcfi_typeid_offset;
> > +
> > +  /* Generate custom label names.  */
> > +  char trap_name[32];
> > +  char call_name[32];
> > +  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", kcfi_labelno);
> > +  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", kcfi_labelno);
> > +
> > +  /* Create memory operand for the type load.  */
> > +  rtx mem_op = gen_rtx_MEM (SImode,
> > +                           gen_rtx_PLUS (SImode, operands[0],
> > +                                         GEN_INT (offset)));
> > +  rtx temp_operands[6];
> > +
> > +  /* Normally we can use r12 as our scratch register.  */
> > +  unsigned scratch_reg_num = IP_REGNUM;
> > +  /* If register pressure has made r12 our target register, we need to pick
> > +     a different register.  We don't want to spill our target register
> > +     because on reload at the end of the KCFI check, we'd be producing
> > +     the very kind of call gadget we were trying to protect against:
> > +     "pop %target; call %target".  In this case, use r3 as our scratch
> > +     register.  But since r3 may be used for function arguments, we need
> > +     to check if it is being used for that and only spill/reload if that
> > +     happens.  Any spill/reload of r3 due to making a call will already
> > +     have been managed by the register allocator, so we only have to care
> > +     about not clobbering the argument value it may be carrying into the
> > +     call here.  Also use r3 when r12 is a fixed register.  */
> > +  if (REGNO (operands[0]) == scratch_reg_num
> > +      || fixed_regs[scratch_reg_num])
> > +    scratch_reg_num = LAST_ARG_REGNUM;
> > +  rtx scratch_reg = gen_rtx_REG (SImode, scratch_reg_num);
> > +
> > +  /* We only need to spill r3 if it's actually used by the call.  */
> > +  bool need_spill = (scratch_reg_num == LAST_ARG_REGNUM)
> > +                   && reg_overlap_mentioned_p (scratch_reg, insn);
> > +
> > +  /* Calculate trap immediate.  */
> > +  unsigned addr_reg_num = REGNO (operands[0]);
> > +  /* The scratch register is always clobbered by eor seq: use 0x1F.  */
> > +  unsigned udf_immediate = 0x8000 | (0x1F << 5) | (addr_reg_num & 31);
> > +
> 
> I take it this means you still need to decode the instructions in the
> kernel to obtain the expected type id?

Currently, yes.

> Can't you insert the actual register index here, and defer the reload
> until after the UDF? That way, the scratch register will always
> contain the XOR of the actual vs expected typeids when taking the
> trap.

My instinct is to avoid any kind of load/call gadget (as a ROP target),
even if the controlled register is only the 4th argument. The risk is
much lower, but it seemed like reducing the risk to 0 requires just a
little help on the kernel side after taking the trap (and x86 already
does this reliably).

I suppose as an alternative I could use the index when it's not r3, but
then Linux would need to read the destination memory to rebulid the XOR?
I think that's even more fragile... I think it'd be best to just read
back the prior 5 instructions before the trap. It's reliable. :)

-Kees

-- 
Kees Cook
