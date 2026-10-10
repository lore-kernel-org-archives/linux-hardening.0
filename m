Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EA2D322E
	for <linux-hardening@vger.kernel.org>; Sat, 10 Oct 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619836; cv=none; b=Ob4EK2nkXMpufZkYUE2bNFnVDR+maFdUpFE/8BN0GZJVu/zM4FuwliOOEj61MfsvTq6J0nxkYeVw1mxdy67AbZ+lv0QF9dclLjM3pvqPJgTtHlcXOeWsUfi0puanTBxvzuE7zs7nZXN/tZuir65gux86gtZ3ugL2ykuRFeFdHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619836; c=relaxed/simple;
	bh=zxLLbIJJ0oKA9QCKqkWC9k1rBVCZTq6L58JmtVr3Nf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF28uzynQ8hll8kc3ir8b4Vb4MAVozGcJwYzKavpq8BFAtEwk/sju7HTYj4hD1uJoBRdN21FQ3Jm6xRKYTWj6/NZYJd4zqMf/vQYp3y/HN+1S5NwVj9fGBhjuJowgFHSM0Dejhjb78YbBRS465ovjsbvpEtdQGWWYUNvEUSygMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWsWarhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWsWarhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FB11F00893;
	Sat, 10 Oct 2026 08:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619834;
	bh=zL/3JpWUyg77v/Pnpfuul7ttQ8qC/NcYgaX+KxroUqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eWsWarhmjOmAnAKN8ZfpssyP0aR2w7welrhH1h6uMGeQmd7h3lwxnSyLhlcY9Cn0o
	 b2qXaq5RQG25h6jbUaXURPigHASlM1a7d06XGgU5l0uUnz2Za0GD6ELhvbhZc/QW8V
	 bZo3ixKX/BWlqzU8fa1RsPBU+8quEu5gJTYiYJn0dbeBjz8tfPexJ6sTYX9Zg/3JOK
	 sPon5RVFrTNw/Q9rRvDtUCAwOh3+t7DXy3RXwUCluSV22DzGA4kbDX1R0f3FT/O7dv
	 D77RphyWGzJtdVrmbmEE/xJ69K/TgOPBrAe5W2uFoO5ZMe1PRNoRXgIfTFb/ay8RC6
	 moIHWFPLm1pRg==
Date: Sat, 10 Oct 2026 01:10:34 -0700
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
Subject: Re: [PATCH v17 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <20261010080449.fe2893-kees@kernel.org>
References: <20261005154028.out.839-kees@kernel.org>
 <20261005154039.1464721-2-kees@kernel.org>
 <65c57069-0f3e-44e0-9562-8867548a7443@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65c57069-0f3e-44e0-9562-8867548a7443@oss.qualcomm.com>

On Fri, Oct 09, 2026 at 07:35:29AM -0600, Jeff Law wrote:
> > +#include "coretypes.h"
> > +#include "rtl.h"
> In general we try to avoid having .h files include other .h files.
> Instead push these into the appropriate .cc files.  This make it easier

Ah-ha, understood! I've fixed this for v18 now.

> > +extern void kcfi_emit_traps_section (FILE *file, rtx trap_label_sym,
> > +				      int labelno);
> > +
> > +/* Extract KCFI type ID from current GIMPLE statement.  */
> > +extern rtx internal_kcfi_get_type_id_for_expanding_gimple_call (void);
> Pick one style.  You've got the parameter names in one prototype, but
> not the other.  The general preference within GCC is without the name.

I've fixed this for v18.  (I'm used to the opposite in Linux: everything
has parameter names.)

> > +- The check-call instruction sequence must be treated as a single unit: it
> > +  cannot be rearranged or split or optimized.  The pattern is that
> > +  indirect calls, "call *%target", get converted into:
[...]
> So I sound like a broken record at this point.  I see the assertion that
> it has to be an atomic unit, but nothing about why.

Yes, sorry, and I've answered this in detail now in my reply to 7/7. In
short:

1. The checked target must stay in the checked register until the call:
   a spill and reload in between would let attacker-writable memory
   supply an unchecked target ("pop %target; call %target").
2. The trap isn't noreturn: in the kernel's permissive mode, execution
   continues from the trap into the call, so the trap block can't be
   moved out of line.
3. The kernel depends on the exact layout: its trap handlers decode the
   instructions around the trap, and x86 may rewrite call sites in place
   into FineIBT at boot.

v18 will add all of this to the design comment, so the "why" lives next
to the assertion.

> > +  kcfi_nop = xstrdup (get_insn_template (code_num, nop_insn));
> > +  int nop_insn_bytes = get_attr_length (nop_insn);
> Note that some ports do not track insn lengths, so you'll consistently
> get back 0 on those.   I would probably recommend asserting the size is
> nonzero so that if you try to use this on a target without lengths
> you'll get a compile-time error rather than a runtime surprise.
>
> Also note that length computations are not guaranteed to be correct;
> they are guaranteed to conservatively correct for things like
> jump/branch relaxing to work.  So in that context conservatively correct
> means the reported size is no smaller than the actual size.
>
> So you need to make sure you're safe if the port reports back a longer
> size than what gets encoded into the final object.

Yup, I was able to trigger this mismatch with RISC-V's C extension
where I get a length of 4, but the assembler emits c.nop (2 bytes),
so with prefix NOPs the call sites loaded the type ID from the wrong
offset. (The kernel doesn't use prefix NOPs with KCFI on RISC-V, which
is why I never hit this.)  v18 will add a TARGET_KCFI_NOP_SIZE hook for
the size the assembler actually emits; RISC-V will return 2 with C or
Zca, as Clang does. Without the hook, KCFI will fall back to the length
attribute and assert that it's nonzero.

> > +  if (align_functions.levels[0].log <= 0)
> > +    return;
> So what happens if the port does not align functions to a useful boundary?

That padding is only used in Linux for x86's FineIBT live-patching,
which needs the __cfi_ label itself to be callable, so the kernel asks
for it with -falign-functions. But since this padding is supported by
the core KCFI code, it needs to work on all backends.  On RISC-V with
C, and on Thumb at -Os, the type ID could end up only 2-byte aligned,
making the load misaligned. Clang aligns every function that has a KCFI
type ID to at least 4 bytes, on all targets; v18 will do the same now.

> > +  /* Ignore cold partition sections: cold partitions are never indirect call
> > +     targets.  Only skip preambles for cold partitions (has_bb_partition = true)
> > +     not for entire cold-attributed functions (has_bb_partition = false).  */
> > +  if (in_cold_section_p && crtl && crtl->has_bb_partition)
> > +    return;
> Is that an design decision in the partitioning code or is it an
> implementation detail.  If it's the former, than I'm inclined to allow
> relying on it.  If it's the latter, then it seems we're just setting up
> a ticking time bomb.  It could well be either, I don't know off the top
> of my head.

It's a design property of partitioning: the cold part of a function is
never called, only jumped to from its parent. A function's address is
always its hot entry, so there's no valid entry point into the middle
of a function, and we don't want KCFI to create one.

bb-reorder enforces this: sanitize_hot_paths() walks up from every hot
block to the entry and moves that path into the hot partition, so when a
function is split, its entry block is always hot.

And x86 IBT already depends on the same property. The ENDBR inserter
(rest_of_insert_endbr_and_patchable_area() in i386-features.cc) only
puts an ENDBR at the head of the function's first block, never at the
start of the cold partition. An indirect branch into a cold partition
would fault under IBT just as it would fail a KCFI check. For example,
with -O2 -fcf-protection=full -fsanitize=kcfi:

	__cfi_work:
		...
		movl	$0xb8360626, %eax
	work:
		endbr64
		testl	%edi, %edi
		js	.L4
		...
		.section	.text.unlikely
	work.cold:
	.L4:
		subq	$24, %rsp

work gets both the ENDBR and the KCFI preamble; work.cold gets neither,
and is reached only by the direct "js .L4".

> I'm assuming that things like devirtualizing a call into a direct call
> are safe, including the speculative forms.

Yes. A call that becomes direct needs no check, since its target is
immutable. A speculative call keeps the original indirect call as the
fallback, and that is still an indirect call with its function type, so
it gets checked. KCFI is C-only, so in practice the speculative form
comes from indirect call profiling; v18 will add a tree-prof test
(gcc.dg/tree-prof/kcfi-speculative-call.c) that checks the fallback
keeps its KCFI check and that the profiled program runs without
trapping.

> Given we can pretty easily describe the generic call setup in RTL, how
> painful would it be to instead do the instrumentation in a generic way
> rather than twiddling each backend?
>
> In that kind of design we'd force the target to provide the two marker
> insns which mark the beginning and end of the atomic region. Target
> independent code would be used to load the typeid hash from the preamble
> (using the offset the target provides), compare it to the expected type
> id, branch around a trap-like insn, the trap-like insn itself, then
> finally the call.  I'm not demanding this rethink, but I do want it to
> be at least considered as a design question.

I did consider it, and tried something like it around v2. Two things
stopped me:

- The marker insns don't make the region atomic in the ways that matter
  (spill code between the check and the call, and the trap block being
  moved), as above.

- Each target's call setup is more than the generic call: the call
  expanders handle calling conventions, sibcalls, PLT and long-call
  forms, BTI and SLS mitigations, and more. KCFI wraps the call pattern
  each target already produces, so all of that keeps working, and the
  per-target part is only the check sequence itself (and the kernel's
  trap handlers decode a different sequence on each architecture
  anyway). I described this to Andrea around v5[1].

Clang made the same choice: generic code marks the indirect calls, and
each target expands its own check sequence just before the call.

Thanks for looking at all this; hopefully I've covered everything.
Let me know if I need to dig in further anywhere or if I've misunderstood
anything. :)

-Kees

[1] https://inbox.sourceware.org/gcc-patches/202510221253.D6B51F950@keescook/

-- 
Kees Cook
