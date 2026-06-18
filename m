Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623814A4F0
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760743; cv=none; b=gjc+Iua1IBFEAPnyOiJF1nTlY62682G/cZQN/MZBxrjWSEXUYTPrEJOHt5c7hNApOmAFtxdwfmlNZWlOaqZ/3YAX7I+nneakb1otH1L4Az8n+EFNhZUt9Xqb5yWyYtyLyK0X9YcGBl6d0lCe1jbswtiEx9E3ndCILhoz0SiznCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760743; c=relaxed/simple;
	bh=zwoxDtkbXXjUQe0a5IYKfc70qY5RSnCULjGP6BZBP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiWaBF9zW3JiPPuiocJBxGzc28wifnX2+nuRnm+1TehNtcym3/1CoY/lQLxHb9lG68B8jbLA2i/9OmwFC07cyti7fjz+vAINXAAlJFMuZms1gCml1NDB61rYe3o+JGqVoaI3WhBFHOoAnoDUY5AycpPseHJ98L+5b+n272//g9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S62nA6bH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S62nA6bH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FC31F000E9;
	Thu, 18 Jun 2026 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781760741;
	bh=H7zwOCWn8HGlXcnJSszfkUcWUVECqgSmOXbkoqEQ69c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S62nA6bHl9Br4+yGIKiJtRvi8I9vbmCgHYk0Px/X1f6hMibUZ3r9PQ2gP9mPAgJN0
	 USHDXC0r0h7kJoOPnIUoKdFjnsCX3t8v1XkW+TRYYBbs/+lLvO2goPidR3g0R81H9j
	 mfHswFAtk/lGawPi23QmN9adg2Gn6QU67cCwsrwp2253YcVrLZkdb7qVmfU8eecbRV
	 mOG7jHnhCAVE0w2tr8jaxRPc9LqUXeSJMf2l4IeCgOAMZxGKIWYbzFt6wBlcvJFTcY
	 vl6YXOuco3XK6+SrYxfF3l1MXY1FTiatW1yjhATPoZk92nw2a18MCoJFtg9elzAIb1
	 u61X76OrA9SEQ==
Date: Wed, 17 Jun 2026 22:32:20 -0700
From: Kees Cook <kees@kernel.org>
To: Jeffrey Law <jefflaw@qti.qualcomm.com>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
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
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v12 7/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
Message-ID: <202606172003.4AEE9421C5@keescook>
References: <20260515161551.stronger.641-kees@kernel.org>
 <20260515161602.1548211-7-kees@kernel.org>
 <6ab27ac0-619b-4960-b37c-e83389d75760@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ab27ac0-619b-4960-b37c-e83389d75760@qti.qualcomm.com>

On Sat, Jun 13, 2026 at 05:28:26PM +0000, Jeffrey Law wrote:
> Main things that stand out:
> 
> - **Hard bug: wrong register number for `t3`.**
> - The patch says “t3 (x8)” in the cover text, and the code uses 
> `T3_REGNUM` as fallback when target is `t1`/`t2`.
> - On RISC-V, `x8` is `s0/fp`, **not** `t3`. `t3` is `x28`.
> - If `T3_REGNUM` in GCC maps to architectural `t3` then the 
> comment/email is wrong; if not, the implementation is wrong. This should 
> be explicitly checked because using `s0` as a scratch across calls would 
> be a real ABI violation.

Oops, yes, this is a typo in the commit log. It's absolutely x28. I've
fixed this now.

> - **`addiw` makes this rv64-only in a stronger way than stated.**
> - The patch claims “Nothing is conceptually rv64 specific”, but the 
> emitted sequence uses `addiw`, which exists only on RV64/RV128, not RV32.
> - That’s consistent with the support hook rejecting 32-bit, but the 
> wording is misleading.

Yeah, good point. I've reworded this as:

    This is rv64-only: the emitted typeid construction uses addiw,
    which exists only on RV64/RV128. An rv32 backend would need an
    alternate sequence (e.g. addi); since the only current user of
    KCFI on riscv is the rv64 build of the Linux kernel, the support
    hook rejects rv32.

> - **Mode usage looks suspicious in the md patterns.**
> - The call memory is written as `mem:SI` even for RV64:
> - `(call (mem:SI (match_operand:DI ...`
> - That matches existing patterns, so maybe okay, but the new KCFI forms 
> also hardcode `match_operand:DI` for the target reg in all cases. Since 
> support is gated to 64-bit only this is probably fine, but it is more 
> brittle than necessary.

Yeah, true. I think I got mesmerized by copying :DI from my aarch64
implementation. ;) I've dropped the :DI now on the four kcfi insn
patterns.

> - **No clobbers for scratch regs in the new insns.**
> - `riscv_output_kcfi_insn` unconditionally uses `t1`/`t2`/`t3`, but the 
> `define_insn`s do not model those as clobbers.
> - Since these are emitted only in the final asm output path, GCC won’t 
> know these registers are killed by the insn. That is usually dangerous 
> unless the backend has an established convention for calls implicitly 
> clobbering these hard regs and nothing live can be placed there across 
> the call.
> - For caller-saved regs across a call this may happen to work, but it 
> still feels under-modeled, especially for the period *before* the `jalr` 
> within the same insn. I’d want confirmation from a maintainer that this 
> is acceptable for a monolithic call-pattern output function.

Right, this has similarly come up before in the aarch64 review (see
"trying to understand the register allocator" in
https://inbox.sourceware.org/gcc-patches/202509171251.BA32F4B@keescook/),
but because t1, t2, and t3 are caller-saved temporaries per the RISC-V
psABI, they should be safe to use this way. And there doesn't seem to be
any way to model these clobbers that I've found where the allocator
doesn't lose its mind due to having to place to "restore" from, given
it's a call. For all architectures my solution was to check register
liveness so I could choose what could be used by the KCFI internal
instructions.

If there is a "right" way to do this, I remain very interested in using
it. :) I would want to add such a marking to all architectures...

> - **Direct/indirect detection may be too narrow.**
> - `is_direct_call = SYMBOL_REF_P (addr);`
> - Are all direct call targets guaranteed to still be plain `SYMBOL_REF` 
> after `riscv_legitimize_call_address`? If some direct calls appear as 
> `CONST`, `LABEL_REF`, etc., this would incorrectly wrap them with KCFI.

I guess that could be true in the future? I've switched from "SYMBOL_REF_P
(addr)" to "!REG_P (addr)" in all architectures now. I also added a new
regression test to check if any other C function call types unexpectedly
gain KCFI instrumentation.

> - **Potential issue with constructing the expected type value.**
> - The code does:
> - `lui t2, hi20`
> - `addiw t2, t2, lo12`
> - This sign-extends to XLEN on RV64, and comparison is against the 
> loaded `lw` result in `SImode`, so likely okay.
> - But using `output_asm_insn` with `GEN_INT (hi20)`/`GEN_INT (lo12)` 
> depends on the printer accepting the exact immediate forms intended 
> here. Probably fine, but worth sanity-checking with negative IDs / 
> high-bit-set IDs.

Linux KCFI builds produce a working kernel which, based on my prior
bug experience with this series, would explode very quickly if this was
wrong. ;) But regardless, to triple-check, I built some tests with 20
distinct function signatures (varied parameter shapes, arities, and return
types) and verified all the emitted `lui tX, IMM ; addiw tX, tX, IMM2`
pairs reconstructed to one of the observed `__cfi_FUNC: .word VALUE`
preambles. 11/20 of those pairs exercised the top-bit-set path (hi20
has bit 19 set, lui sign-extends negative); 11/20 emitted a negative
`lo12`. Everything worked as expected.

> - **Trap label handling via `SYMBOL_REF` to an internal label is a bit 
> odd.**
> - `rtx trap_label_sym = gen_rtx_SYMBOL_REF (Pmode, trap_name);`
> - If `kcfi_emit_traps_section` expects a symbol ref string name, okay; 
> if it expects a label ref or some canonical internal-label RTX, this 
> could be fragile.

I went back and forth on how to handle the internal labels in prior
version, and being able to define an explicit label name made diagnostics
and regression testing much more stable. And I needed an rtx so I could
construct the gen_rtx_MINUS within kcfi_emit_traps_section, while still
being a useful label in the caller. LABEL_REF doesn't let me control
the string contents, so I used SYMBOL_REF, which seemed to work.

I'm not clear on what might be fragile here, though? Is there a better
way to have an rtx label I can control the name of? I see no API do it
other than SYMBOL_REF.

> - **Doc typo/grammar:**
> - “Because of the use of these register, they cannot be fixed registers” 
> → “registers”.

Oops, fixed.

> Tests:
> 
> - Good coverage overall.
> - The new negative tests expect both the target-specific error and the 
> generic “sorry, unimplemented” message. That’s probably right for 
> `TARGET_KCFI_SUPPORTED`, but these tests may be a bit brittle if the 
> frontend wording changes.

This string is used in lots of other regression tests, and I really want
to keep tests that explicitly test for "kcfi is refused here".

> So the two most important review points are:
> 
> 1. **Verify `T3_REGNUM` / `t3` really means architectural x28, not x8.**
> 2. **Be sure the backend is allowed to use hard scratch regs in 
> `output_asm_insn` without explicit RTL clobbers.**

Great; hopefully these are addressed above.

> > Assembly Code Pattern for RISC-V:
> >    lw      t1, -4(target_reg)         ; Load actual type ID from preamble
> >    lui     t2, %hi(expected_type)     ; Load expected type (upper 20 bits)
> >    addiw   t2, t2, %lo(expected_type) ; Add lower 12 bits (sign-extended)
> >    beq     t1, t2, .Lkcfi_call        ; Branch if types match
> >    .Lkcfi_trap: ebreak                ; Environment break trap on mismatch
> >    .Lkcfi_call: jalr/jr target_reg    ; Execute validated indirect transfer
> Right.  So at least one of the rv64-isms is that addiw.  I know this 
> isn't necessarily supposed to work on rv32 and we probably don't have a 
> full set of rv64-isms mapped out.  But just wanted to get that one noted 
> for the record.

Sure; I've called this out in the commit log now.

> > +/* Output the assembly for a KCFI checked call instruction.  INSN is the
> > +   RTL instruction being processed.  OPERANDS is the array of RTL operands
> > +   where operands[0] is the call target register, operands[3] is the KCFI
> > +   type ID constant.  Returns an empty string as all output is handled by
> > +   direct assembly generation.  */
> > +
> > +const char *
> > +riscv_output_kcfi_insn (rtx_insn *insn, rtx *operands)
> It's still not clear to me why this is being output as a single atomic 
> unit.  Why not generate proper RTL for the various steps where it 
> obviously can?

The load/check/call cannot be separated or it becomes a place where
attackers can circumvent the checking. If anything separates the check
from the call, it reintroduces a load/cmp ; ... ; call %target window
where the target register could be re-clobbered between the check and
the use.

It's also needed to avoid merging (i.e. under KCFI the typeid becomes
the indicator of whether calls can be merged, so we have to explicitly
disable merging under "standard" architectural detections).

> >    lw      t1, -4(target_reg)         ; Load actual type ID from preamble
> That's a standard SImode load most likely.
> 
> >    lui     t2, %hi(expected_type)     ; Load expected type (upper 20 bits)
> >    addiw   t2, t2, %lo(expected_type) ; Add lower 12 bits (sign-extended)
> Similarly.  Also note if you use standard mechanisms to do this, then it 
> should work for rv32 and rv64 trivially.
> 
> >    beq     t1, t2, .Lkcfi_call        ; Branch if types match
> Also a trivial insn, I don't offhand see a hard need emit this as part 
> of an atomic sequence.
> 
> >    .Lkcfi_trap: ebreak                ; Environment break trap on mismatch
> We can trivially define an insn for this if it doesn't exist.
> 
> >    .Lkcfi_call: jalr/jr target_reg    ; Execute validated indirect transfer
> This the most worrisome.  I suspect this needs to stay in a particular 
> form and avoid things like linker relaxation and such.
> 
> 
> Point being I still see generation of this sequence as a single atomic 
> unit as conceptually wrong.  If you really need it as an atomic unit, 
> then you need to be emitting the proper assembly directives around it to 
> ensure the assembler/linker don't expand macros, don't relax, etc etc

It does need the atomicity. I've added ".option norelax" now; I think
that will enforce atomicity?

> >
> > diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
> > index f2c3fafbb428..79c3180d9184 100644
> > --- a/gcc/doc/invoke.texi
> > +++ b/gcc/doc/invoke.texi
> > @@ -17474,6 +17474,23 @@ allowing the kernel to identify both the KCFI violation and the involved
> >   registers for detailed diagnostics (eliminating the need for a separate
> >   @code{.kcfi_traps} section as used on x86_64).
> >   
> > +On 64-bit RISC-V, KCFI type identifiers are emitted as a @code{.word ID}
> > +directive (a 32-bit constant) before the function entry, similar to AArch64.
> > +RISC-V's natural instruction alignment eliminates the need for
> > +additional alignment NOPs.  When used with @option{-fpatchable-function-entry},
> > +the type identifier is placed before any prefix NOPs.  The runtime check
> Really?  Note the C extension can result in instructions, including 
> function entry points starting at a 2 byte boundary rather than a 4 byte 
> boundary.

I think I've addressed this as well with ".option norvc". But I may be
misunderstanding what you mean.

Thanks for the review!

I'll send a v13 soon; I want to finish a full round of kernel
build/tests since I've also done a rebase to latest git.

-Kees

-- 
Kees Cook
