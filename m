Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3382DC79E
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667789; cv=none; b=Q2SEGYiRyXtyvzL08Umndczf89IsyvTxacGTRitA1/QFGthDkPoj55seK3NzYcjEW7k7XwGy2wyHiVlJ4xVHuJktsgLI+2V5e71bmeRwKmkdmw9FaDlIaI+N5xah0SrHfUYU8mWElzUUQanpKbB+kgkz01YzYHgfWnnTlRpKd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667789; c=relaxed/simple;
	bh=yRWY4ZI541ZiclrrCZiDwaI5FbSF36BO8aSSUi2HqNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg/8layn14UPlfE+bqo47rLfI2AAP+Zhh4NQVwNpaRqVIwLYYdIo0xaA8xzDlERPL6NKtssW5Otrp0Z4alijSDMmLHHNeCcoVqeBaf6nPUCZBAnjx12Xig60kxLGpKNTJZSnaPCiZ32KAKfs09vzUio+nNfykVMS/hCHjhphsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGumIkKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGumIkKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E9CC4CEF1;
	Fri, 12 Sep 2025 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667788;
	bh=yRWY4ZI541ZiclrrCZiDwaI5FbSF36BO8aSSUi2HqNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGumIkKcLMJ5pT7aeRz3mM/RYTMzcxxEBXfeZV8rpQmZS5nXfBSwmHfs6rpQknnVe
	 JcmiyIggitQBXEdlX86XxChjSZVH9GU8P7qshelCpFt6aW290YNp7P46rS71v+/1C/
	 Yv1GVYTTtj4ymBU736aBZDuvx2DY7h5NtExvoWGU0TpznbHiA6WpYR3dg3pmEcF7uY
	 L71ds9l9POK5sIKvf30/r0Si4GRpbhKI4H9S2ToA5+xuhNgbd8p9iZbFArChwYRW/x
	 WlCA0bwNYQ+g9dmu4ki68inudot0sb4wd/KAbJqH1E/CyxZ1SIgNF2T3DJMmik7+WX
	 sN6eIv+Jvrwaw==
Date: Fri, 12 Sep 2025 02:03:08 -0700
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
Message-ID: <202509120157.9681B7FC6D@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-5-kees@kernel.org>
 <CAMj1kXG+PtcXE5gkQ278vZ2qQojfc3Cv20WJKZ8AAQ9BvC2-zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG+PtcXE5gkQ278vZ2qQojfc3Cv20WJKZ8AAQ9BvC2-zw@mail.gmail.com>

On Thu, Sep 11, 2025 at 09:49:56AM +0200, Ard Biesheuvel wrote:
> On Fri, 5 Sept 2025 at 02:24, Kees Cook <kees@kernel.org> wrote:
> >
> > Implement ARM 32-bit KCFI backend supporting ARMv7+:
> >
> > - Function preamble generation using .word directives for type ID storage
> >   at -4 byte offset from function entry point (no prefix NOPs needed due to
> >   4-byte instruction alignment).
> >
> > - Use movw/movt instructions for 32-bit immediate loading.
> >
> > - Trap debugging through UDF instruction immediate encoding following
> >   AArch64 BRK pattern for encoding registers with useful contents.
> >
> > - Scratch register allocation using r0/r1 following ARM procedure call
> >   standard for caller-saved temporary registers, though they get
> >   stack spilled due to register pressure.
> >
> > Assembly Code Pattern for ARM 32-bit:
> >   push {r0, r1}                ; Spill r0, r1
> >   ldr  r0, [target, #-4]       ; Load actual type ID from preamble
> >   movw r1, #type_id_low        ; Load expected type (lower 16 bits)
> >   movt r1, #type_id_high       ; Load upper 16 bits with top instruction
> >   cmp  r0, r1                  ; Compare type IDs directly
> >   pop [r0, r1]                 ; Reload r0, r1
> 
> We could avoid the MOVW/MOVT pair and the spilling by doing something
> along the lines of
> 
> ldr   ip, [target, #-4]
> eor   ip, ip, #type_id[0]
> eor   ip, ip, #type_id[1] << 8
> eor   ip, ip, #type_id[2] << 16
> eors  ip, ip, #type_id[3] << 24
> ldrne ip, =type_id[3:0]

Ah-ha, nice. And it could re-load the type_id on the slow path instead
of unconditionally, I guess? (So no "ne" suffix needed there.)

  ...
  eors  ip, ip, #type_id[3] << 24
  beq .Lkcfi_call
.Lkcfi_trap:
  ldr ip, =type_id[3:0]
  udf #nnn
.Lkcfi_call:
  blx target


> 
> Note that IP (R12) should be dead before a function call. Here it is
> conditionally loaded with the expected target typeid, removing the
> need to decode the instructions to recover it when the trap occurs.
> 
> This should compile to Thumb2 as well as ARM encodings.

Won't IP get used as the target register if r0-r3 are used for passing
arguments? AAPCS implies this is how it'll go (4 arguments in registers,
the rest on stack), but when I tried to force this to happen, it looked
like it'd only pass 3 via registers, and would make the call with r3.

I can't see if this is safe to unconditionally use IP?

-- 
Kees Cook
