Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CD3C10B3
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145421; cv=none; b=YmTa2PPQQqqb9taunMFEwR4aXOPRPwlSANsM0i0X1MHcTxHvfxHzBtavEYQFrqE7/9mNXX1ljEAeXxkQIZOWnZa7CB7VHp9ZD089tCNQx1xRPkukO0OaY0d2T5d4O7BbmsM3KKm6nwWMzb0+ZDZtrww+wEe4K6fC5TmNh1QRXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145421; c=relaxed/simple;
	bh=ngbT7sHDPSIbE6k9rjyNreW1XKhJWgxX6sLw4fQb+o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChYgWqyKlYylwCDxWkZtdVzyig5ysslFeNMjt0d48HabQ3Py4OWnzDWSwQP2feu7JeGLJRb5XHgS+dR0l88+eBiQcu+fvqUMw12i5tTeSw83yUNkSCpCaaZzphW2Pj0FEXgybBC+ruQfgQb4fdPc6SzHHc+0TqAn40eh3PA+3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3FuFsh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3FuFsh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441891F000E9;
	Wed, 15 Jul 2026 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784145415;
	bh=bzdPIEXxBOFZ9WryL+zUc5wJmcxmqPO3R/82iXUVhB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e3FuFsh9I1YZJ/hWOdjYSLwKwW+17hRMq7NZLwQ2ZVuZneY6ztOhqKk23QMWE7OFN
	 Lhq5+xMI3CHQe0LBA9jCGyv5QswZUWSXEh9O/itu8RdmXFpA979aVj7oS/qdoUnZyQ
	 p1AVe08HPGsA3KLyad8og18PPeN27l4rB6t8iBT9QBlG7NOF9CnUxhNtkL5Exjbkf6
	 +sQtT2wBZNp938MS/WGO4yS/3MnpU5AxYenCNwyHgdGY1cYWKO8mR7H7EvJ1Yf9oUf
	 VtZU9dsGr+yJ29gP969LDCWeXUcLi/xoqxdgCUo65/tEGru3sCB/uldhkOdBuFCEK2
	 xwgzkvP/7YUOA==
Date: Wed, 15 Jul 2026 12:56:54 -0700
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>,
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
Subject: Re: [PATCH v13 5/7] aarch64: Add AArch64 Kernel Control Flow
 Integrity implementation
Message-ID: <202607151256.417B05A99A@keescook>
References: <20260618204530.work.910-kees@kernel.org>
 <20260618204539.824446-5-kees@kernel.org>
 <CALvbMcDnK6iWkXbO7VbdBgeuym9yO6xNG8VE_RNQ8Nser0=TmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcDnK6iWkXbO7VbdBgeuym9yO6xNG8VE_RNQ8Nser0=TmA@mail.gmail.com>

On Sat, Jun 27, 2026 at 04:00:04PM -0700, Andrea Pinski wrote:
> On Thu, Jun 18, 2026 at 1:45 PM Kees Cook <kees@kernel.org> wrote:
> >
> > Implement AArch64-specific KCFI backend.
> >
> > - Trap debugging through ESR (Exception Syndrome Register) encoding
> >   in BRK instruction immediate values.
> >
> > - Scratch register allocation using w16/w17 (x16/x17) following
> >   AArch64 procedure call standard for intra-procedure-call registers,
> >   which already makes x16/x17 available through existing clobbers.
> >
> >   Note that BTI uses x16/x17 AT the call site, and KCFI uses w16/w17
> >   BEFORE the call (for the type hash comparison). These don't conflict
> >   because:
> >   - KCFI clobbers w16/w17 with hash values.
> >   - Then the actual call happens via blr %target_reg (whatever
> >     register the target is in).
> >   - If SLS hardening is enabled, aarch64_indirect_call_asm will
> >     create a thunk that moves target into x16 and does br x16.
> >   - By the time the SLS thunk uses x16, KCFI is already done with it.
> >
> > - Complementary with BTI (which uses a separate pass system to inject
> >   landing instructions where needed).
> >
> > - Does not interfere with SME, which uses attributes not function
> >   prototypes for distinguishing functions.
> >
> > Assembly Code Pattern for AArch64:
> >   ldur w16, [target, #-4]       ; Load actual type ID from preamble
> >   mov  w17, #type_id_low        ; Load expected type (lower 16 bits)
> >   movk w17, #type_id_high, lsl #16  ; Load upper 16 bits if needed
> >   cmp  w16, w17                 ; Compare type IDs directly
> >   b.eq .Lpass                   ; Branch if types match
> >   .Ltrap: brk #esr_value        ; Enhanced trap with register info
> >   .Lpass: blr/br target         ; Execute validated indirect transfer
> >
> > ESR (Exception Syndrome Register) Integration:
> > - BRK instruction immediate encoding format:
> >   0x8000 | ((TypeIndex & 31) << 5) | (AddrIndex & 31)
> >   - TypeIndex indicates which W register contains expected type (W17 = 17)
> >   - AddrIndex indicates which X register contains target address (0-30)
> >   - Example: brk #33313 (0x8221) = expected type in W17, target address in X1
> >
> > Build and run tested with Linux kernel ARCH=arm64.
> >
> > gcc/ChangeLog:
> >
> >         config/aarch64/aarch64-protos.h: Declare aarch64_indirect_branch_asm,
> >         and KCFI helpers.
> >         config/aarch64/aarch64.cc (aarch64_expand_call): Wrap CALLs in
> >         KCFI, with clobbers.
> >         (aarch64_indirect_branch_asm): New function, extract common
> >         logic for branch asm, like existing call asm helper.
> >         (aarch64_output_kcfi_insn): Emit KCFI assembly.
> >         config/aarch64/aarch64.md: Add KCFI RTL patterns and replace
> >         open-coded branch emission with aarch64_indirect_branch_asm.
> >         doc/invoke.texi: Document aarch64 nuances.
> >
> > gcc/testsuite/ChangeLog:
> >
> >         * gcc.dg/kcfi/kcfi-adjacency.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-basics.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-call-sharing.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-complex-addressing.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-direct-call-shapes.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-move-preservation.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-no-sanitize-inline.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-no-sanitize.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-offset-validation.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-patchable-entry-only.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-patchable-large.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-patchable-medium.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-patchable-prefix-only.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-tail-calls.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-trap-section.c: Add aarch64 patterns.
> >         * gcc.dg/kcfi/kcfi-trap-encoding.c: New test.
> 
> Ok once all other prerequisites have been approved.

Great; thank you for all the review!

-- 
Kees Cook
