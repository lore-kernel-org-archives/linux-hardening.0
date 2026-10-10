Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3B36F8E5
	for <linux-hardening@vger.kernel.org>; Sat, 10 Oct 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619481; cv=none; b=DhGFx6OzpCjcmcRvIaqsljJaFlne3p0h2UINTdmCJUa5VJysAGVVpqVt89zPxcJxByhEWE53wz8SbINWXiOuKEVcsjuJAyIjFscBF49PZg4YwEEt5Ei2bvhmau572ySrFrj/z6S6jfvdckmnfh4SUp5Rctpp3BziyMcHbOp1dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619481; c=relaxed/simple;
	bh=187akcOhGh77YZm258qZcbsTaff3gX5UZOsoTa0V+qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhvpT93+r2TuZ2KG3MpmL/M8Hag79lazXi9qhG/bu/bZkzSzQFVa6sy3oNyc4oYI29EShMenVsjK8cpFfcsmN4gS2vRQV3FE2HliXBR1FxIPgH1kMmx6avrj9IrtMBaeqLdqfPGcsnAFrQDimjORFLusVD9nMR8w7AD0rl0njic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7aqHAUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7aqHAUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200631F000FF;
	Sat, 10 Oct 2026 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619479;
	bh=r5m70wsikJ7ga9aFiGn2QHDa/43Jc59QfQ+nUEEiW+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M7aqHAUS0PoviqELKYpZUat/4iFkbCmAYkrHOhlffEpHMEeEUymjgdX2UbNxG6Bfn
	 OBqDNIZt8aWgqoo3RHcrQW3hISKT7YBhWBOlBhab1LFTguLc8z9pci5NdF3TjEVGBR
	 ZCs1nWUD1rUVnwibywDYVu07wZMDKOqqGBqEOXpg+yQVr+qBVGTC8D2vRBZ7qHnEeN
	 9tjZaiRnBVcw0c/iy0+m8RQ3/Xr8n09l94V/9xN8IGh9jRlWKYSY69n7v8R9mlGg2B
	 w/AfDdGGseqXCbLxHFV4AY31oRNNVaXyU3S95XiMPVihj8mo7+ZjrUoTqdYANdvxrr
	 irGPeryqpZ6NQ==
Date: Sat, 10 Oct 2026 01:04:38 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Law <jeffrey.law@oss.qualcomm.com>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
	Richard Biener <rguenther@suse.de>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Uros Bizjak <ubizjak@gmail.com>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Osterlund Sebastian <sebastian.osterlund@intel.com>,
	Constable Scott D <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v17 7/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
Message-ID: <20261010075835.446f27-kees@kernel.org>
References: <20261005154028.out.839-kees@kernel.org>
 <20261005154039.1464721-7-kees@kernel.org>
 <45190057-a50b-40f4-9502-e3001fcac67e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45190057-a50b-40f4-9502-e3001fcac67e@oss.qualcomm.com>

On Thu, Oct 08, 2026 at 10:39:50PM -0600, Jeff Law wrote:
> Note that addiw explicitly sign extends the result from bit 32 out to
> bit 63.   That seems to match what you want with the implementation
> (since you do a lw do load the ID from the preamble and that's
> sign-extending from bit 32 to bit 63.

Right, both sides of the beq are sign-extended the same way, so the
comparison works for type IDs with bit 31 set.  I was suspicious of
the sign extension myself and had double-checked it at the edges
just to be sure when I first worked on this. :)

> So what I can't recall ever seeing is an explanation of why this
> sequence needs to be emitted as a single assembly block.  That's
> something we generally try to avoid.  Now if that design decision/need
> is covered in the talk from the Cauldron, that's fine.  I was
> intercepted and couldn't get there in time, but I'll certainly make a
> point to watch the whole thing.

You asked this back in v2, and my reply then[1] wasn't very helpful.
Sorry about that!  Here's hopefully more complete reasoning; v18 will
also put it in the design comment at the top of kcfi.cc, since you're
right that it was only asserted there.

1. The checked target must stay in the checked register until the call.
   If the register allocator spilled it after the check and reloaded it
   (or rematerialized it) before the call, memory an attacker can write
   would supply an unchecked target, effectively restoring the
   "pop %target; call %target" gadget that KCFI seeks to remove.
   Separate insns would give reload and the post-reload passes the
   freedom to create it again, which needs to be avoided.

2. The trap isn't noreturn. It is designed to be continuable: Linux
   has a permissive (warn-only) mode where the trap handler reports the
   mismatch and returns, and execution continues into the call right
   after it. So the trap can't be gen_trap() with a barrier after it,
   and the trap block must not be moved out of line by bb-reorder or
   hot/cold partitioning, even though it looks cold.

3. The kernel depends on the exact layout. (This is, of course,
   changeable, but it would require coordination with Linux and Clang.)
   Specifically on RISC-V, Linux's trap handler (arch/riscv/kernel/cfi.c)
   reads the beq just before the ebreak to find the register holding the
   expected type, and the jalr just after it to find the target. On x86,
   the kernel may rewrite every KCFI call site in place into the FineIBT
   sequence at boot, patching a fixed number of bytes before the call.

FWIW, Clang KCFI is built the same way: its RISC-V backend emits a
KCFI_CHECK pseudo that must immediately precede the call through the
same register (it asserts this), and expands it with specific scratch
registers when the assembly is printed (RISCVAsmPrinter::LowerKCFI_CHECK).

> And note that if it really needs to be an atomic sequence, there's still
> ways to achieve that that avoid the blobs of assembly code.  See below.

> Generally you don't want to be using types like uint32_t, uint64_t,
> etc.  Those are properties of the host, not the target.   Given that
> you're using "lw" and a sign extending "addiw", you probably want this
> to be a HOST_WIDE_INT (vs an unsigned HOST_WIDE_INT).  It probably

Ah, yes. This is now fixed in v18: RISC-V will hold it as a HOST_WIDE_INT,
sign-extended from bit 31 to match the lw and addiw, and the other three
backends will hold it as an unsigned HOST_WIDE_INT. The generated code
doesn't change.

I went through the rest of the series for the same problem. The type ID
itself will stay a uint32_t: the ABI defines it as a 32-bit FNV-1a hash,
computed on the host, so that's the arithmetic it needs. Now
__builtin_linux_abi_kcfi_hash will return a 32-bit unsigned type even
where int is 16 bits, and the type ID's size in the preamble will be a
named constant instead of sizeof (uint32_t).

> Why use fixed registers?   It would seem to work better if you just
> generated pseudos and let the register allocator do the right thing and
> assign them to whatever temporary is best.  That would also remove the
> restrictions around -ffixed-reg.

I'd love to, but the KCFI check is part of/within the call insn and LRA
allows no output reloads in a CALL_INSN:

	/* CALL_INSNs are not allowed to have any output reloads.  */
	if (CALL_P (curr_insn))
	  no_output_reloads_p = true;

So under register pressure the allocator can't provide a scratch register
for the call pattern, so I had to have each backend instead pick scratch
registers that are dead at the call (caller-saved temporaries that aren't
argument registers or the target). I went through this with Andrea for
AArch64[2][3]. Moving the check out into separate insns, so that pseudos
would work, runs into point 1 above.

And trying to create an entirely new mode of register allocation for
use within a CALL_INSN seemed like serious over-kill, given the other
narrow constraints on KCFI.

The -ffixed-reg restriction could go, though: Clang uses t1 and t2 and
falls back to t3 through t6, skipping any the user reserved, so it never
has to reject fixed registers.  I could do the same here, but I had so
much pain making the ARM backend do this that I didn't want to tackle
it again. :P  But I can if you'd like to see that here too.

> Why does this need to be an atomic sequence with restrictions around
> relaxing and compression avoidance?  From other comments I'm guessing
> you're rewriting that ebreak.  At the least you need to explain why its
> an atomic sequence.

The atomicity is for the reasons above; the kernel doesn't rewrite the
ebreak on RISC-V (x86 is where call sites get rewritten).

The directives came from your v12 review[4], where you said that if the
sequence really must be atomic, it should be wrapped in directives so
the assembler and linker don't expand macros or relax. However, in
looking at it more closely now, neither can affect this sequence:

- Nothing in it can be relaxed: the lw is register-relative, the lui and
  addiw take plain constants with no relocations, the beq goes to a
  local label, and the jalr is through a register. The linker only
  relaxes symbol-based sequences marked R_RISCV_RELAX.

- None of the instructions is an assembler macro.

- Compression is harmless: the assembler may use c.lui, c.addiw, c.jalr,
  or c.ebreak, but the beq can never be compressed (t1 and t2 aren't in
  the compressed register set, and c.beqz only compares against zero),
  and the kernel's decoder reads the beq at epc - 4, accepts jalr or
  c.jalr, and steps over the ebreak by its actual length.

So v18 will drop ".option norelax" and ".option norvc", which also lets
the sequence shrink with C, and matches Clang, which has none of these
directives either.

> So if we really don't need to generate an atomic sequence, then you've
> got the skeleton for generating RTL here.  You've got the register

> This is a "trap" insn.  So
>
> emit_insn (gen_trap ()); or something along those lines.

As in point 2, it can't be a trap with the usual noreturn semantics,
since execution continues from it into the call in permissive mode.

> So do you do something fun like rewrite the trap?  Is that why you're
> generating the atomic sequence?  ANd if so, we can still get you an
> atomic sequence without emitting blobs of assembly code via emit_barrier
> () at the start and end of the atomic sequence.

Marker insns at the start and end would keep the scheduler from moving
things across them, but they wouldn't stop reload from inserting spill
code between the check and the call (point 1), and the beq would split
the sequence into basic blocks that bb-reorder and partitioning are free
to rearrange (point 2). If there's a way to pin all of that down, I'm
happy to try it, but it seemed to fight the compiler at every step,
while emitting the sequence from the call pattern's output routine
appears to be the simplest and most robust way to get the right output.
(And, FWIW, Clang ended up in the same place too.)

> We probably need to avoid for C++ due to thunks and Fortran due to
> multiple entry points.  And you may not have a good way to test for
> those, particularly in an LTO build.  We need to think about that

KCFI is C-only: process_options() rejects -fsanitize=kcfi for any other
front end. And while I tried to enforce this under LTO too, I did now
find a way that it fails. The check for language accepted LTO's
"GNU GIMPLE", but that meant a C++ object built with -flto and linked
with -fsanitize=kcfi would crash on a METHOD_TYPE. v18 will check the
language of every translation unit the IL came from
(TRANSLATION_UNIT_LANGUAGE survives streaming), and reject anything that
isn't C, reporting the offending file:

  thunk.cc:3:49: sorry, unimplemented: '-fsanitize=kcfi' is only supported for C, but 'thunk.cc' was compiled by the GNU C++20 front end

I tested this by hand (and that C-only LTO links are still instrumented),
but I couldn't find a way to add a regression test for it: the case needs
-fsanitize=kcfi at link time only, which means lto.exp, and lto.exp has
no way to expect a link to fail; any failed link is a FAIL. If there's
a way to do this that I've missed, I'd be happy to add one.

> Really?  Natural instruction alignment for the designs I expect to see
> almost everywhere is 16 bits (via the C extension which is mandatory for
> rva23 and used in nearly design I'm aware of).  So you've got a bit of a
> problem here as unaligned access isn't necessary guaranteed to work.
> You could do something like force the function alignment to 4 bytes when
> KFCI is on.  A bit hackish, but probably sensible in practice.

Oops, yes, thank you for persisting on this. :P  You mentioned it in v12
too, but I misunderstood it: ".option norvc" around the call sequence
did nothing for the alignment of the functions it calls. With the C
extension the preamble was only 2-byte aligned, so the lw could be
misaligned (and so could the ldr on Thumb at -Os). Clang aligns every
function that has a KCFI type ID to at least 4 bytes, on all targets,
"to avoid unaligned access". v18 will do the same, and fix that paragraph
of the documentation.

> Is the offset always at -4?  Just helps me understand the underlying
> assumptions you need to make.

It's -4 plus the size of any prefix NOPs from
-fpatchable-function-entry=N,M, since the type ID sits before them.
(Call sites can't see per-function patchable_function_entry attributes,
so KCFI rejects those and uses only the global option.)

But checking this turned up the bug you were predicting about NOP sizing
in your 2/7 review. I had sized each prefix NOP from the nop insn's length
attribute (4 bytes), but with the C extension the assembler emits c.nop
(2 bytes), so with prefix NOPs the call sites loaded from the wrong
offset. As you pointed out, lengths are only upper bounds. v18 will add
a TARGET_KCFI_NOP_SIZE hook for the size the assembler actually emits;
RISC-V will return 2 with C or Zca, matching Clang.  More on this in
the 2/7 reply...

Thank you for the review! :)

-Kees

[1] https://inbox.sourceware.org/gcc-patches/202509152254.8A38F96D91@keescook/
[2] https://inbox.sourceware.org/gcc-patches/202509141233.33B8C6D4@keescook/
[3] https://inbox.sourceware.org/gcc-patches/202509171251.BA32F4B@keescook/
[4] https://inbox.sourceware.org/gcc-patches/6ab27ac0-619b-4960-b37c-e83389d75760@qti.qualcomm.com/

-- 
Kees Cook
