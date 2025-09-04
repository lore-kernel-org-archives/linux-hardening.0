Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012A1BC58
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 04:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959863; cv=none; b=RQ7P9kiCbPOvI/4Sa2p2EGQUVYL0+ZFB8fijFEtxBqRiPZ7vRhgB0WM34M2obgjqu8nNMpwjCFiC3DZF3hTKiublRozAcO6QPm1tUnrhxy8AaVOURUExmra0xtpw/yeYwR2R8YtDNwkTFFybJZ1veFIiB41zi8J9MGeCAFvqmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959863; c=relaxed/simple;
	bh=uQ/LkDHGn2uFHlmIlQqaLCpYM0MuFYI31zt67FylvEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyZFxouDYZfVoEpC5AW3bzTQPrrHNp7n0X+eHxlOT2V+yJZbFdzq7atBBxTvI8knAVZgeYjiKkCL2uHtzNEn5IPptBKKXRvc1nfqSd05gS8BNh6Tpi44n2qjtDE0qJdOCSjjpf3MQcpIX69g1anpgkLymDfCDrGRLESR8CZO8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwNR+pwE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwNR+pwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33B5C4CEF0;
	Thu,  4 Sep 2025 04:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756959862;
	bh=uQ/LkDHGn2uFHlmIlQqaLCpYM0MuFYI31zt67FylvEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwNR+pwEkAK2B6iE7KzWIRJACED57uIT/FryP/ybVXZ1LISJOw3xjef4e27rIrOWk
	 2NxERjRPYrAmNVUpUlqSG9sz0fPyxDdcyOn8lRUdBZHPSSu+uqopDkcXEs9GJjxu/r
	 9wWW4MODNG1/Xuqz22IbktRvIezHZ0vd0PzFeA/7w5xBU7a/ELl/bXQX6V2VroUGLs
	 PHNTqeqb/C0Zs0KBFCr5gngVv5eVC/HcoQ6yxj3e4Zi64oEl4203ODzqMsa9OFEByR
	 3tucWWx6J3bWmgEp4XVEkSq3jUkryfyjgmImrmjRkSd2bLdeQdGCP6pNvGvUDP1Syx
	 C/vZHGcolI2Zg==
Date: Wed, 3 Sep 2025 21:24:22 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
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
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202509032057.34FA2F6AEC@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <84E03295-212C-4A89-8F8E-C5B1BA74C7EB@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84E03295-212C-4A89-8F8E-C5B1BA74C7EB@oracle.com>

On Thu, Aug 28, 2025 at 02:57:05PM +0000, Qing Zhao wrote:
> Hi, Kees,
> 
> I have several suggestions and questions first for this patch:
> 
> 1. Is -fsanitize=kcfi a C only feature? If so, you might need to mention this in 
>     the documentation and also reject its usage in other languages. 

Yes, it's C only. I will note it and add a check for that. Thanks for
the reminder!

> 2. There is no overall description of the design of this kcfi implementation 
>     in the source code, I think it might be very helpful to provide such description
>     In the new module kcfi.cc <http://kcfi.cc/>. such documentation will be helpful for current
>     review and future maintenance of this feature. 

Ah yeah, good idea. I will adapt the commit log.

> 
> > On Aug 21, 2025, at 03:26, Kees Cook <kees@kernel.org> wrote:
> > 
> > This series implements the Linux Kernel Control Flow Integrity ABI,
> > which provides a function prototype based forward edge control flow
> > integrity protection by instrumenting every indirect call to check for
> > a hash value before the target function address. If the hash at the call
> > site and the hash at the target do not match, execution will trap.
> > 
> > Just to set expectations, this is an RFC because this is my first time
> > working on most of the affected areas in GCC, and it is likely I have
> > missed really obvious stuff, or gone about doing things in very wrong
> > ways. I tried to find the best way to do stuff, but I was left with many
> > questions. :) All that said, this works for x86_64 and aarch64 Linux
> > kernels. (I have implemented riscv64 as well, but I lack a viable test
> > environment -- I am working on this still.)
> > 
> > KCFI has a number of specific constraints. Some are tied to the
> > backend architecture, which I'll cover in more detail in later patches.
> > The constraints are:
> > 
> > - The KCFI scheme generates a unique 32-bit hash for each unique function
> >  prototype, allowing for indirect call sites to verify that they are
> >  calling into a matching _type_ of function pointer. This changes the
> >  semantics of some optimization logic because now indirect calls to
> >  different types cannot be merged. For example:
> > 
> >    if (p->func_type_1)
> > return p->func_type_1();
> >    if (p->func_type_2)
> > return p->func_type_2();
> > 
> >  In final asm, the optimizer may collapse the second indirect call
> >  into a jump to the first indirect call once it has loaded the function
> >  pointer. KCFI must block cross-type merging otherwise there will be a
> >  single KCFI check happening for only 1 type but being used by 2 target
> >  types. The distinguishing characteristic for call merging becomes the
> >  type, not the address/register usage.
> > 
> > - The check-call instruction sequence must be treated a single unit: it
> >  cannot be rearranged or split or optimized. The pattern is that
> >  indirect calls, "call *$target", get converted into:
> > 
> >    mov $target_expression, %target (only present if the expression was
> >                                     not already %target)
> >    load -$offset(%target), %tmp
> >    cmp $hash, %tmp
> >    je .Lcheck_passed
> >  .Ltrap$N:
> >    trap
> >  .Lcheck_passed$N:
> >    call *%target
> > 
> >  This pattern of call immediately after trap provides for the
> >  "permissive" checking mode automatically: the trap gets handled,
> >  a warning emitted, and then execution continues after the trap to
> >  the call.
> > 
> >  (x86_64 uses "mov -$hash, %tmp; addl -$offset(%target), %tmp; je"
> >  to zero out the register before making the call. Also Linux needs
> >  exactly these insns because it is both disassembling them during
> >  trap handling and potentially live patching them at boot time to
> >  be converted into a different series of instrutions, a scheme
> >  know as FineIBT, making the insn sequence ABI.)
> > 
> > - KCFI check-call instrumentation must survive tail call optimization.
> >  If an indirect call is turned into an indirect jump, KCFI checking
> >  must still happen (but will still use the jmp).
> > 
> > - Functions that may be called indirectly have a preamble added,
> >  __cfi_$original_func_name, that contains the $hash value:
> > 
> >    __cfi_target_func:
> >      .word $hash
> >    target_func:
> >       [regular function entry...]
> > 
> >  (x86_64 uses a movl instruction to hold the hash and prefixed aligned
> >  NOPs to maintain cache line alignment in the face of patchable function
> >  entry...)
> > 
> > - The preamble needs to interact with patchable function entry so that
> >  the hash appears further away from the actual start of the function
> >  (leaving the prefix NOPs of the patchable function entry unchanged).
> >  This means only _globally defined_ patchable function entry is supported
> >  with KCFI (indrect call sites must know in advance what the offset is,
> >  which may not be possible extern functions). For example, a "4,4"
> >  patchable function entry would end up like:
> > 
> >    __cfi_target_func:
> >      .data $hash
> >      nop nop nop nop
> >    target_func:
> >       [regular function entry...]
> > 
> >  (Linux x86_64 uses an 11 byte prefix nop area resulting in 16 bytes
> >  total including the movl. This region may be live patched at boot time
> >  for FineIBT so the behavior here is also ABI.)
> > 
> > - External functions that are address-taken have a weak __kcfi_typeid_$funcname
> >  symbol added with the hash value available so that the hash can be referenced
> >  from assembly linkages, etc, where the hash values cannot be calculated (i.e
> >  where C type information is missing):
> > 
> >    .weak   __kcfi_typeid_$func
> >    .set    __kcfi_typeid_$func, $hash
> > 
> > - On architectures that do not have a good way to encode additional
> >  details in their trap (x86_64 and riscv64), the trap location
> >  is identified as a KCFI trap via a relative address offset entry
> >  emitted into the .kcfi_traps section for each indirect call site's
> >  trap instruction. The previous check-call example's insn sequence has
> >  a section push/pop inserted between the trap and call:
> > 
> >  ...
> >  .Ltrap$N:
> >    trap
> >  .pushsection    .kcfi_traps,"ao",@progbits,.text
> >    .Lentry$N:
> >        .long   .Ltrap$N - .Lentry$N
> >  .popsection
> >  .Lcheck_passed$N:
> >    call %target
> > 
> >  (aarch64 encodes the register numbers that hold the expected hash
> >  and the target address in the trap ESR and thereby does not need a
> >  .kcfi_traps section at all.)
> > 
> > - The no_sanitize("kcfi") function attribute means that the marked function
> >  must not produce KCFI checking for indirect calls, and that this
> >  attribute must survive inlining. This is used rarely by Linux, but
> >  is required to make BPF JIT trampolines work on older Linux kernel
> >  versions. (The preamble code is very recently finally being generated
> >  at JIT time on the last remaining Linux KCFI arch where this was
> >  missing: aarch64.)
> > 
> > As a result of these constraints, there are some behavioral aspects
> > that need to be preserved across the middle-end and back-end, as I
> > understand them.
> > 
> > For indirect call sites:
> > 
> > - Keeping indirect calls from being merged (see above). I did this by
> >  adding a wrapping type so that equality was tested based on type-id.
> >  This is done in create_kcfi_wrapper_type(), via kcfi_instrument(),
> >  via an early GIMPLE pass (pass_kcfi and pass_kcfi0). The wrapper type
> >  is checked in gcc/cfgcleanup.cc, old_insns_match_p().
> 
> First, Looks like that the routine “old_insns_match_p” checks the type-ids that were embedded
> in the REG_NOTE ( REG_CALL_KCFI_TYPE) of the RTL.  -:)

Once I started using the backend RTL patterns more correctly, this note
and all the logic attached to it went away. I'll send my v2 shortly.

> My understanding is: the computed type-id is recorded into to a “kcfi_type_id” attribute, and
> then this “kcfi_type_id” attribute is attached to the original function type. 

Correct (so that we can use it when generating the preambles and RTL
define_insn output).

> At the same time, A wrapper type is created for the original function type, whose typename is 
> “__kcfi_wrapper_type_id”.
> 
> I am confused:
> 
> 1. Why the additional wrapper type is needed?  why the original function type + “kcfi_type_id” not enough?

This was created to keep calls some being combined during optimization.
e.g.:

if (func1) {
	func1();
	return;
}
if (func2) {
	func2();
	return;
}

this was getting constructed as:

if (func1) {
	ptr = func1;
do_call:
	call ptr;
	return;
}
if (func2) {
	ptr = func2;
	goto do_call;
}

The above is normally totally fine because only address "matters", but
in the CFI world, the typeid is a part of the call. If func1 and
func2 don't share the same typeid, suddenly the "goto do_call" call path
will fail because the call (that checks the func1 typeid) will trigger a
mismatch wne func2 tries to be called through the func1-typeid-call.

> 2. Why attaching the type-id as a “kcfi_type_id” attribute to the original function type?
>      Is there other way to attach the type-id to the original function type? Or to the original indirect call site?

In the v2 series I moved this to the IPA phase so I could attach
everything to the original fndecl.

>     Is it possible that we might provide a user level “kcfi_type_id” attribute to function type in the future? then
>     That will be conflict with the current “kcfi_type_id” attribute? 

The closest I can imagine is the kcfi hash salt, which will just allow
the user to bump the typeid hash by a deterministic amount (to separate
the larger "pools" of hashes -- e.g. "void func(void)" is very common,
so the salt would allow for a slight modification to separate sets of
otherwise identical types).

> > 
> > - Keeping typeid information available through to the RTL expansion
> >  phase was done via a typeid note (REG_CALL_KCFI_TYPE) attached also
> >  in create_kcfi_wrapper_type() in the same GIMPLE pass.
> 
> This is done in the routine “expand_call_stmt” through call to “add_kcfi_type_note”. 
> The “type_id” is attached as a “kcfi_type_id” attribute to the original function type in the routine 
> “create_kcfi_wrapper_type”. 
> 
> Please see my above question 2. 

In v2 this has been pretty radically changed -- expansion just reads the
kcfi_type_id directly into an RTL operand for a new KCFI insn type (i.e.
separate from CALL or SET), which wraps CALL.

> > - To make sure instrumentation was skipped for inline functions, the
> >  RTL pass walks the basic blocks to identify their function origins,
> >  looking for the no_sanitize("kcfi") attribute, and skipping
> >  instrumentation if found.
> 
> I think this was done inefficiently. It’s better to do this during inlining transformation to 
> propagate the no_sanitize information from the caller to the callee body and attach
> the no_sanitize information to the indirect callsite. 

Yes, I took Andrew's suggestion and implemented a flag that is set on
the insn itself and is checked at the callsite.

> 
> > 
> > For indirect call targets:
> > 
> > - kcfi_emit_preamble_if_needed() uses function_needs_kcfi_preamble(),
> >  and counter helpers, to emit the preablem, with patchable function
> >  entry NOPs. This gets used both in default_print_patchable_function_entry()
> >  and the per-arch path.
> 
> I saw that “kcfi_emit_preamble_if_needed” is called by “default_print_patchable_function_entry”,
> But I didn’t see where it is called when the function is not patchable?

These were in the per-arch function label emission, but for v2 I've
moved them out after refactoring how the patchable function entry
integration works.

> > I could not find a simpler way to deal with
> >  patchable function entry besides splitting it up like this. I feel
> >  like there should be a better way.
> > 
> > - gcc/varasm.cc, assemble_external_real() calls emit_kcfi_typeid_symbol()
> >  to add the __kcfi_typeid symbols (see get_function_kcfi_type_id()
> >  below).
> > 
> > To support the per-arch back-ends, there are some common helpers:
> > 
> > - A callback framework is added via struct kcfi_target_hooks for
> >  backends to fill out.
> > 
> > - kcfi_emit_trap_with_section() handles the push/pop section and
> >  generating the relative offset section entries.
> > 
> > - get_function_kcfi_type_id() generates the 32-bit hash value, using
> >  compute_kcfi_type_id() and kcfi_hash_string() to hook to the mangling
> >  API. The hash is FNV-1a right now: it doesn't need secrecy. It could be
> >  replaced with any hash, though the hash will need to be coordinated
> >  with Rust, which implements the KCFI ABI as well.
> 
> One question here, the final type_id will be computed by the following 2 steps:
> 
> 1. Itanium C++ mangling based on return type + parameter types of the function. 
> 2. FNV-1a hash on the mangled string
> 
> If the hacker knows these, it should be quite easy for them to come up with a
> matched typeid, is it? 

The hashes aren't considered secret -- they need to be known/match between
compilation units, and even across languages (Rust). The KCFI mitigation
is fundamentally an "exploit surface reduction" measure in the sense
that it limits an attacker's set of callable functions to only matching
typeids (instead of all functions or all executable memory). I discuss
this a big more here:
https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693059.html

Thanks for the review! I'll have v2 up shortly -- I'm still going
through the commit logs and tests to make sure they're sensible. :)

-Kees

-- 
Kees Cook
