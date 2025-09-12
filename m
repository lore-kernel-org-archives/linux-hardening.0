Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE412DC79E
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668110; cv=none; b=iadwcNgS9JHFDMvZbXIg08G52gsfvkzIhzr5QEeOkmNmNknYQ5yeT7wsaBFfiHIP11z6jWBi+11ISYfN/XVMycRLwszlu3MKJqIVM0PlpWcvAZQTYyIqC62pSE3bm9++znYoxnIrc4uTCdCws7cH+zP3Pb+qRI6OXRuhSeY/Tl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668110; c=relaxed/simple;
	bh=jPansxgW+v0Kv1NFdq6yW9HYXPF1UTiaEXhcy+OXDS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pqj61xgHJ7da4e3/vHwRs4E6pU+C2MORo3BQwU0NOKC8LwgFTA/Lch1T6QuRooDnAcp4ek4ZEZF6Zq14uD/NjpaLZ7XWkiV0Sb9nx6PkgnJhPqSqAg4EaO35uPGqsmaZHzV5S0Cp9du8M4qhDYt3iFdY1//UCSxwYMECq3kJ1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibeeFaJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibeeFaJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24170C4CEF1;
	Fri, 12 Sep 2025 09:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757668110;
	bh=jPansxgW+v0Kv1NFdq6yW9HYXPF1UTiaEXhcy+OXDS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibeeFaJokTFbjVAZ/hLiCsxWKFKTHyiEj9eeHr3V2qEI7efvoMmhsMNXzV1nyxynz
	 Xy+2p6ROc25NUjyGrqmXhxVEyZ6r94JwR2iDSYw6bXGoRmn+JkaBrb+gfjL+vIB5rp
	 WgG50fUyuCsn5M2IeZ21I47AYXnWO6cMG8keoShp1dY5qJ8Ox/tlEYRmGCUzyQ9KKy
	 Gehed+cDufllOvv1eZX9gWTSu6Ipn306crEVRu8iwJ2ixrx3SLc41X34w9cOGWrWWv
	 4QJ0jkfp6OuSX9or4Udo8s80lQ91wGRBVJTLvrCVi2J2yhcXVOeviTans7pt2248n+
	 l8Gdr6S9Io1pA==
Date: Fri, 12 Sep 2025 02:08:29 -0700
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
Message-ID: <202509120205.69A1B0CB@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-5-kees@kernel.org>
 <CAMj1kXG+PtcXE5gkQ278vZ2qQojfc3Cv20WJKZ8AAQ9BvC2-zw@mail.gmail.com>
 <202509120157.9681B7FC6D@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509120157.9681B7FC6D@keescook>

On Fri, Sep 12, 2025 at 02:03:08AM -0700, Kees Cook wrote:
> On Thu, Sep 11, 2025 at 09:49:56AM +0200, Ard Biesheuvel wrote:
> > On Fri, 5 Sept 2025 at 02:24, Kees Cook <kees@kernel.org> wrote:
> > >
> > > Implement ARM 32-bit KCFI backend supporting ARMv7+:
> > >
> > > - Function preamble generation using .word directives for type ID storage
> > >   at -4 byte offset from function entry point (no prefix NOPs needed due to
> > >   4-byte instruction alignment).
> > >
> > > - Use movw/movt instructions for 32-bit immediate loading.
> > >
> > > - Trap debugging through UDF instruction immediate encoding following
> > >   AArch64 BRK pattern for encoding registers with useful contents.
> > >
> > > - Scratch register allocation using r0/r1 following ARM procedure call
> > >   standard for caller-saved temporary registers, though they get
> > >   stack spilled due to register pressure.
> > >
> > > Assembly Code Pattern for ARM 32-bit:
> > >   push {r0, r1}                ; Spill r0, r1
> > >   ldr  r0, [target, #-4]       ; Load actual type ID from preamble
> > >   movw r1, #type_id_low        ; Load expected type (lower 16 bits)
> > >   movt r1, #type_id_high       ; Load upper 16 bits with top instruction
> > >   cmp  r0, r1                  ; Compare type IDs directly
> > >   pop [r0, r1]                 ; Reload r0, r1
> > 
> > We could avoid the MOVW/MOVT pair and the spilling by doing something
> > along the lines of
> > 
> > ldr   ip, [target, #-4]
> > eor   ip, ip, #type_id[0]
> > eor   ip, ip, #type_id[1] << 8
> > eor   ip, ip, #type_id[2] << 16
> > eors  ip, ip, #type_id[3] << 24
> > ldrne ip, =type_id[3:0]
> 
> Ah-ha, nice. And it could re-load the type_id on the slow path instead
> of unconditionally, I guess? (So no "ne" suffix needed there.)
> 
>   ...
>   eors  ip, ip, #type_id[3] << 24
>   beq .Lkcfi_call
> .Lkcfi_trap:
>   ldr ip, =type_id[3:0]
>   udf #nnn
> .Lkcfi_call:
>   blx target
> 
> 
> > 
> > Note that IP (R12) should be dead before a function call. Here it is
> > conditionally loaded with the expected target typeid, removing the
> > need to decode the instructions to recover it when the trap occurs.
> > 
> > This should compile to Thumb2 as well as ARM encodings.
> 
> Won't IP get used as the target register if r0-r3 are used for passing
> arguments? AAPCS implies this is how it'll go (4 arguments in registers,
> the rest on stack), but when I tried to force this to happen, it looked
> like it'd only pass 3 via registers, and would make the call with r3.

Wait, I misread, my test is using r4 as the target! Still, is IP guaranteed
to never be used for the target?

-Kees

-- 
Kees Cook
