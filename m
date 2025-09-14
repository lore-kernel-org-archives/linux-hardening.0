Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2510E9
	for <linux-hardening@vger.kernel.org>; Sun, 14 Sep 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879137; cv=none; b=R6L2NBvsGOhDWJVfHqf44xmAq5FtYBJcCxAl4O4WBbh130omHeyKhX0apKlULvpeQPp566YgeiZ+OZOFTqYqvFtH6AqwEQsR9guA96F/KxpbRgE1TKQWUv4Zqqxd15/ldUZQqpQrlBn7+ofhns6kc3FV3jrE9pCak+JLPHZiDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879137; c=relaxed/simple;
	bh=s09Txt3kzDxT1kPwv2iKbWOWBe+jmEfE7tmJBo9hjPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhy9f3wdUTDLFR1VkKQ4MDFKsZCDdzZ+iLDt+paZ9CTClX0J+fqb5o/f8hG8GOdUYM8Q2QqfNQs9kZVJZwugupiCpSsW7av6Qm8G/nBQRiTOLTU2IM1N4ugVV3CCZa1Rflzvbp3+pNKXKliHpDJN2fXB63UU0u215aakgGs/ZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyyNv0pn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyyNv0pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A991C4CEF0;
	Sun, 14 Sep 2025 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757879136;
	bh=s09Txt3kzDxT1kPwv2iKbWOWBe+jmEfE7tmJBo9hjPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyyNv0pnoWszpsl2Ac/bMTqYXwMl2atfNc26QW/ZDTxTeSU6h7hVXiCR4VwrUOKEm
	 aJZ9Z3LEORgNl3z+uBmBI9WQC3cMimtfq5hvX0VzXUo24wZmpJ5wD6CnOgJ1LmAcNy
	 ZKV5rAYI0O9eGuC8TsE6suGZxAIl0ryvN4GzpRVO2kRjLAcwLgozDHcOhpJ/zhmb/a
	 LVxVo34WH3XICBwvWLWVNMDjWa9PLEOIRe2aWXqjP+4suNmxIBqXomkP9Khz6Y9oWe
	 /UdyHB+QHDDjye/guEyXPVMnhsQIP1oU+KGhXEOtUvVUJWheOSWkfHFRBT6C8xMiGd
	 pPATcbExXZTYg==
Date: Sun, 14 Sep 2025 12:45:35 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <hubicka@ucw.cz>,
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
Subject: Re: [PATCH v3 4/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202509141233.33B8C6D4@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-4-kees@kernel.org>
 <CALvbMcDqbwjxeWn6B37+gQL1g+BvLvWpDFH=KEObMf=4kwZqZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcDqbwjxeWn6B37+gQL1g+BvLvWpDFH=KEObMf=4kwZqZw@mail.gmail.com>

On Sat, Sep 13, 2025 at 04:43:29PM -0700, Andrew Pinski wrote:
> On Sat, Sep 13, 2025 at 4:28 PM Kees Cook <kees@kernel.org> wrote:
> >
> > Implement AArch64-specific KCFI backend.
> >
> > - Trap debugging through ESR (Exception Syndrome Register) encoding
> >   in BRK instruction immediate values.
> >
> > - Scratch register allocation using w16/w17 (x16/x17) following
> >   AArch64 procedure call standard for intra-procedure-call registers.
> 
> How does this interact with BTI and sibcalls? Since for indirect
> calls, x17 is already used for the address.
> Why do you need/want to use a fixed register here for the load/compare
> anyways? Why can't you use any free register?

Ah, yeah, good point. I'm struggling with this on aarch32 too for Ard's
suggestion about using an eor sequence. So, the problem I haven't been
able to solve is that call instructions cannot have scratch register
operands. Or rather, can't when there is register pressure like on
aarch32, where a spill would be needed. This is in the LRA:

  if (CALL_P (curr_insn))
    no_output_reloads_p = true;

And that does make perfect sense, there's no place (in the current
design) to provide a place where the reload would happen. But I also
can't let the kcfi check/call get split up arbitrarily.

Is there some way I can convince LRA to let me do the restore manually?

> > +const char *
> > +aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> > +{
> > +  /* KCFI is only supported in LP64 mode.  */
> > +  if (TARGET_ILP32)
> > +    {
> > +      sorry ("%<-fsanitize=kcfi%> is not supported for %<-mabi=ilp32%>");
> 
> You should reject -fsanitize=kcfi during option processing instead of
> this late in the compilation.

Where is best to do this on a per-arch basis?

> > +  /* Get KCFI type ID from operand[3].  */
> > +  uint32_t type_id = (uint32_t) INTVAL (operands[3]);
> 
> Maybe an assert that `(int32_t)type_id == INTVAL (operands[3])`?

Oh, hm, actually, I think I should be using UINTVAL instead?

> > +  /* Load actual type into w16 from memory at offset using ldur.  */
> > +  temp_operands[0] = gen_rtx_REG (SImode, R16_REGNUM);
> > +  temp_operands[1] = target_reg;
> > +  temp_operands[2] = GEN_INT (offset);
> > +  output_asm_insn ("ldur\t%w0, [%1, #%2]", temp_operands);
> 
> Since you are using a fixed register, you don't need the temp_operands[0] here.
> Also what happens if target_reg is x16? Shouldn't there be an assert
> on that here?

Yeah, I need to solve the scratch register issue more generally.

> > +  /* Output conditional branch to call label.  */
> > +  fputs ("\tb.eq\t", asm_out_file);
> > +  assemble_name (asm_out_file, call_name);
> > +  fputc ('\n', asm_out_file);
> 
> There has to be a better way of implementing this.

I couldn't find one that would let me keep the custom label name. I'd
love to have something better! :)


-- 
Kees Cook
