Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899219CD06
	for <linux-hardening@vger.kernel.org>; Sat, 13 Dec 2025 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765590052; cv=none; b=YPBRwCtH3o/xPlHP9jIpNR71FNXFA11Ot+wbmMcfN1NLzSWPslPu/HDc80AXHh9hthL0B42hUZyG4FoTW8DtY8MlqvVhUc2e828lyq3Ao2pLMCf9HERAYxOKKgghRmR9VFZDl+fT8Aatk36iFjFZRyXnwtnsvhf7G8UTUCUCICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765590052; c=relaxed/simple;
	bh=AdXSrMPN4V5AQHZPHttYGtOBS+VgutdGUgFfjMUR0oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYu54shd6GF2c2BryJ/bOLnbYX2/4C2bd5DXaOufEzAMAoVNRe0hasYrYWUuGuQET0wnPY62QKcNlF0JEdNTdbAXgNxTGqkkgiTg/uE7x5l/j59bPaEQV0yZHiEmCNaCByoOO5fSzmhAsEhyFrslGwQtWkqthTJ866IRGCqmmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caysVnEu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caysVnEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF57BC4CEF1;
	Sat, 13 Dec 2025 01:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765590050;
	bh=AdXSrMPN4V5AQHZPHttYGtOBS+VgutdGUgFfjMUR0oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caysVnEu5xo/RlepHwYOhdNexZFZo5ep2bavwv9VrwGuOMAQHszuhrx7aQiE0oESt
	 oagq7FWDCZP9BIFws+JqX2M381tPelffQ3V08tNneqtf9HqOH6Axj9e6VlOfN0jK+e
	 mqvrLWslxbCJKisIqepCk42MZqJ/9sDcEgwJ0N8mIOq9tVtz0zFoMBPRgNnj/4ikVg
	 WnsCqceuuLbjwZTUenPK2c2zZazba71dI81tc0bEVKmExMC8Opi23Q5ghYX1dQCEk6
	 jIZr4kWvm0nTuc8HyGuuI/kHmWrvGQJoPC04YABomFenQMLpB1a3LgXO912nykMz9K
	 OLZM1DNdZSBhA==
Date: Fri, 12 Dec 2025 17:40:50 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
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
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 5/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202512121725.9CC129F0@keescook>
References: <20251210022025.harder.803-kees@kernel.org>
 <20251210022035.331892-5-kees@kernel.org>
 <CALvbMcCFQbBO2McnTfWVHEcVvZfy+U6FSM7jMPyG-1-N9RP14A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcCFQbBO2McnTfWVHEcVvZfy+U6FSM7jMPyG-1-N9RP14A@mail.gmail.com>

On Fri, Dec 12, 2025 at 02:47:57PM -0800, Andrew Pinski wrote:
> On Tue, Dec 9, 2025 at 6:23 PM Kees Cook <kees@kernel.org> wrote:
> > Implement AArch64-specific KCFI backend.
> [...]
> 
> From an aarch64 point of view this is ok (except for a few minor
> things [see below in the patch itself] which can be bundled up with
> the fixes for the review of the middle-end parts and don't need an
> extra approval).

Thanks! I will go through these and fix them up for v10.

> The only open question with the aarch64 side of things (and other
> targets) is how to represent the kfci calls, should there be wrapping
> or not.
> Right now I am ok with the wrapping but I am not a fan of it because
> it introduces complexity to the call patterns. It is definitely
> something that should be looked into but I am not going to block this
> set of patches for it.
> And using define_subst/define_subst_attr if we decide to stay with the
> wrapping with the kfci rtl, is something to look into but that can
> wait too.

Yeah, I would love more guidance on this; Uros suggested using
define_subst during the x86 review, and I was able to use it there
because x86's expansion and call patterns don't use PARALLEL. When I
tried to apply define_subst to the other architectures with PARALLEL it
got extremely complex, and ended up being more complicated than what I
already had. See this for my (brief) comments on this attempt in v7:
https://lore.kernel.org/linux-hardening/20251117201219.makes.617-kees@kernel.org/

Maybe I just didn't see the right way to do it, so I'm happy to try
something different here if there's a better method.

> [...]
> > +const char *
> > +aarch64_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> > +{
> > +  /* Target register is operands[0].  */
> > +  rtx target_reg = operands[0];
> > +  gcc_assert (REG_P (target_reg));
> > +
> > +  /* Get KCFI type ID from operand[3].  */
> > +  uint32_t type_id = (uint32_t) INTVAL (operands[3]);
> 
> Use UINTVAL .

Now fixed (for all archs).

> > +
> > +  /* Calculate typeid offset from call target.  */
> > +  HOST_WIDE_INT offset = -kcfi_get_typeid_offset ();
> > +
> > +  /* Get unique label number for this KCFI check.  */
> > +  int labelno = kcfi_next_labelno ();
> > +
> > +  /* Generate custom label names.  */
> > +  char trap_name[32];
> > +  char call_name[32];
> > +  ASM_GENERATE_INTERNAL_LABEL (trap_name, "Lkcfi_trap", labelno);
> > +  ASM_GENERATE_INTERNAL_LABEL (call_name, "Lkcfi_call", labelno);
> > +
> > +  /* Load actual type into w16 from memory at offset using ldur.  */
> > +  rtx temp_operands[2];
> > +  temp_operands[0] = target_reg;
> > +  temp_operands[1] = GEN_INT (offset);
> > +  output_asm_insn ("ldur\tw16, [%0, #%1]", temp_operands);
> > +
> > +  /* Load expected type into w17 using mov/movk sequence.  */
> > +  fprintf (asm_out_file, "\tmov\tw17, #%u\n", type_id & 0xFFFF);
> > +  fprintf (asm_out_file, "\tmovk\tw17, #%u, lsl #16\n", (type_id >> 16) & 0xFFFF);
> > +
> > +  /* Compare types.  */
> > +  fprintf (asm_out_file, "\tcmp\tw16, w17\n");
> > +
> > +  /* Output conditional branch to call label.  */
> > +  fputs ("\tb.eq\t", asm_out_file);
> > +  assemble_name (asm_out_file, call_name);
> > +  fputc ('\n', asm_out_file);
> > +
> > +  /* Output trap label and BRK instruction.  */
> > +  ASM_OUTPUT_LABEL (asm_out_file, trap_name);
> > +
> > +  /* Calculate and emit BRK with ESR encoding.  */
> > +  unsigned type_index = R17_REGNUM;
> > +  unsigned addr_index = REGNO (target_reg) - R0_REGNUM;
> > +  unsigned esr_value = 0x8000 | ((type_index & 31) << 5) | (addr_index & 31);
> > +
> > +  fprintf (asm_out_file, "\tbrk\t#%u\n", esr_value);
> 
> It might be useful to print the hex instead of the decimal here.
> Either way is ok.

Yeah, that's more human-readable. Now changed.

-Kees

-- 
Kees Cook
