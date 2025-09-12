Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AB35975
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703704; cv=none; b=pdbp4gnv0xxff4AMK9oO/AmwJ4W/8U+r5z+XaUy9VkWVROYov4xmwTL5a+oGWhj83Sue7KEbc9eiMQOzW0KWfiUkDIO91kDkatoHWVzATK6YVQNV4jS8wn3+hayhduHj4hdbPLyRPJVB1XIZOtDSQmaRnP7lRm1/8jfdZErLUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703704; c=relaxed/simple;
	bh=hA6MyLWgvIm+B5v5H/EQMkzcwfOmSjHdmd6AaDQKXQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RChjq20a2GbmiJVdHlA55cnmpy3pPd6PYGg4yMzbRRRwHphtx5xvjeACbtuwv6T/VzfJlgn1PjHY01jVyxhprqE6w/br3o1JKBvBwUgNulBPNsDIHiSXtLCam6wYu+fJUmqMk0E1fhUEg3/8fKna8HwHfQYLVbVTJI9DbQ/0770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkwiEGjv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkwiEGjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD153C4CEF1;
	Fri, 12 Sep 2025 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757703703;
	bh=hA6MyLWgvIm+B5v5H/EQMkzcwfOmSjHdmd6AaDQKXQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkwiEGjv5m0lEwy3zEWfI9aoZ/I9vSCqy8y/muAAZ4kHWwasnUSRjBgqgiYpZvhs6
	 g+vg7fIK4cvrjGUx0Ik5PNbfbDfh8FSCDE6N/5XQoC9xbxAbnTEn/iucMVicxoYO9E
	 ilNqsm3Apg5y8+E2aeoMwtur2/LzD28ywysTTq75x5xyioW4QxI7qVceINwqU1uVPC
	 9QTW8JcJdLdiIzMPMZIlQiWiDQ+b9V/8dy2asmwhxHwzM9wsOKpu1109eCYY8qfeeh
	 7XdG3tLaNDl35L+5GyYMOmvT52epGahfssCgjK63oxJU2WepH+0H2n1qAwkwALAn7g
	 H8HE7aVZU9uXg==
Date: Fri, 12 Sep 2025 12:01:43 -0700
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v2 5/7] arm: Add ARM 32-bit Kernel Control Flow Integrity
 implementation
Message-ID: <202509121159.24CAA81@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-5-kees@kernel.org>
 <CAMj1kXG+PtcXE5gkQ278vZ2qQojfc3Cv20WJKZ8AAQ9BvC2-zw@mail.gmail.com>
 <202509120157.9681B7FC6D@keescook>
 <202509120205.69A1B0CB@keescook>
 <CAMj1kXFAaO2=B5jFBKcpf6rUbhKNG-BEqZoFBv0UJ2gb-Eym5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFAaO2=B5jFBKcpf6rUbhKNG-BEqZoFBv0UJ2gb-Eym5Q@mail.gmail.com>

On Fri, Sep 12, 2025 at 11:43:00AM +0200, Ard Biesheuvel wrote:
> On Fri, 12 Sept 2025 at 11:08, Kees Cook <kees@kernel.org> wrote:
> >
> > On Fri, Sep 12, 2025 at 02:03:08AM -0700, Kees Cook wrote:
> > > On Thu, Sep 11, 2025 at 09:49:56AM +0200, Ard Biesheuvel wrote:
> > > > On Fri, 5 Sept 2025 at 02:24, Kees Cook <kees@kernel.org> wrote:
> > > > >
> > > > > Implement ARM 32-bit KCFI backend supporting ARMv7+:
> > > > >
> > > > > - Function preamble generation using .word directives for type ID storage
> > > > >   at -4 byte offset from function entry point (no prefix NOPs needed due to
> > > > >   4-byte instruction alignment).
> > > > >
> > > > > - Use movw/movt instructions for 32-bit immediate loading.
> > > > >
> > > > > - Trap debugging through UDF instruction immediate encoding following
> > > > >   AArch64 BRK pattern for encoding registers with useful contents.
> > > > >
> > > > > - Scratch register allocation using r0/r1 following ARM procedure call
> > > > >   standard for caller-saved temporary registers, though they get
> > > > >   stack spilled due to register pressure.
> > > > >
> > > > > Assembly Code Pattern for ARM 32-bit:
> > > > >   push {r0, r1}                ; Spill r0, r1
> > > > >   ldr  r0, [target, #-4]       ; Load actual type ID from preamble
> > > > >   movw r1, #type_id_low        ; Load expected type (lower 16 bits)
> > > > >   movt r1, #type_id_high       ; Load upper 16 bits with top instruction
> > > > >   cmp  r0, r1                  ; Compare type IDs directly
> > > > >   pop [r0, r1]                 ; Reload r0, r1
> > > >
> > > > We could avoid the MOVW/MOVT pair and the spilling by doing something
> > > > along the lines of
> > > >
> > > > ldr   ip, [target, #-4]
> > > > eor   ip, ip, #type_id[0]
> > > > eor   ip, ip, #type_id[1] << 8
> > > > eor   ip, ip, #type_id[2] << 16
> > > > eors  ip, ip, #type_id[3] << 24
> > > > ldrne ip, =type_id[3:0]
> > >
> > > Ah-ha, nice. And it could re-load the type_id on the slow path instead
> > > of unconditionally, I guess? (So no "ne" suffix needed there.)
> > >
> > >   ...
> > >   eors  ip, ip, #type_id[3] << 24
> > >   beq .Lkcfi_call
> > > .Lkcfi_trap:
> > >   ldr ip, =type_id[3:0]
> 
> Yeah better. If you use the right compiler abstraction to emit this
> load, it will be turned into MOVW/MOVT if the target supports it.
> 
> > >   udf #nnn
> > > .Lkcfi_call:
> > >   blx target
> > >
> > >
> > > >
> > > > Note that IP (R12) should be dead before a function call. Here it is
> > > > conditionally loaded with the expected target typeid, removing the
> > > > need to decode the instructions to recover it when the trap occurs.
> > > >
> > > > This should compile to Thumb2 as well as ARM encodings.
> > >
> > > Won't IP get used as the target register if r0-r3 are used for passing
> > > arguments? AAPCS implies this is how it'll go (4 arguments in registers,
> > > the rest on stack), but when I tried to force this to happen, it looked
> > > like it'd only pass 3 via registers, and would make the call with r3.
> >
> > Wait, I misread, my test is using r4 as the target! Still, is IP guaranteed
> > to never be used for the target?
> >
> 
> The target register can be any GPR. IP is guaranteed by AAPCS not to
> play a role in parameter passing, because it is the Inter Procedural
> scratch register, and may be clobbered by PLT trampolines that get
> inserted between a direct call and its target. These are not direct
> calls, of course, but the callee does not know that, and so it cannot
> make any assumptions about the value of IP.

Okay, it seems like I am close to having this replaced with the eor
method, but the backend really really does not like constructing the ldr
for me. I may leave this as a "future improvement", and just change the
Linux side of the trap handling to decode the eor insns instead of
pulling the value out of IP.

-- 
Kees Cook
