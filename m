Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676D2E3AE6
	for <linux-hardening@vger.kernel.org>; Mon,  8 Sep 2025 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368539; cv=none; b=GffKezZwlcimz1Qqwk0w2I01xyLUBj3a4oMrbz0n1hbxuMXuATyTWtLk+T949TvuLqJfGJjH9sUoUjcFqmpeqNXRaIKiciycNDJaNK/euSZsOSA2edtvy8le3uAkLokGw5iA3nhhjUpaACF+EeMgxw3ESDuut6WI2FeiHxSJ0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368539; c=relaxed/simple;
	bh=ekDYj2zs0R8kaSzqCC9ugiM/Ig3BJsBus8v4qfUaCmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0P9BEVzx4oak/gLDHu5Zj4svGJD5A5z54Mhmaoqwfx2vjPE5E4Qb/xV9XBAeq5rTFn5ZqAAgcoixOZnsz5HzI+m8a4aEBKcmQRJSfm1Rc1H7neditDINzo1CqU0VRhqZt/uRZMsQYaFgjvyXD+kwB3fOtfHABx2rI1YT/oENlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2yHvaCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2yHvaCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56EEC4CEF1;
	Mon,  8 Sep 2025 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368538;
	bh=ekDYj2zs0R8kaSzqCC9ugiM/Ig3BJsBus8v4qfUaCmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2yHvaClGdz629uOUfe1EY8LjTllS15XLwlnPKY6EyS9yMJ3ge+4tY3W1gwBk1qgv
	 hhXTb5+6b/ycWpG3TCtD8mzCdSxvlAliHuUpVTTmmet8pHGhl57QotPR9kki4Pyl0q
	 vlk6mgQB7Hza2lp8hRY4qInH2GuqQT2uylSKNbBE4fuHSReMjBEO94ITS6ryYWrPHD
	 NindhljdfsA6d5v3FY7MHjtIn8q2fK4jF0Bu9mBkm1q9dOuvw3uWfBv46AxIIVk8dd
	 W1ZtgkVTRQK5b4dIZLNZEo+A4TG5+9PBYiN1nH9roy7nUc+4QA/nyKjUr2iLNSryYv
	 nxf0ydZAOJL2Q==
Date: Mon, 8 Sep 2025 14:55:38 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <202509081452.5AD50CAA@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <20250905085103.GT3245006@noisy.programming.kicks-ass.net>
 <202509050907.DE9A5ED2@keescook>
 <20250908153258.GE4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908153258.GE4067720@noisy.programming.kicks-ass.net>

On Mon, Sep 08, 2025 at 05:32:58PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 05, 2025 at 09:19:29AM -0700, Kees Cook wrote:
> > On Fri, Sep 05, 2025 at 10:51:03AM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 04, 2025 at 05:24:10PM -0700, Kees Cook wrote:
> > > > +- The check-call instruction sequence must be treated a single unit: it
> > > > +  cannot be rearranged or split or optimized. The pattern is that
> > > > +  indirect calls, "call *$target", get converted into:
> > > > +
> > > > +    mov $target_expression, %target ; only present if the expression was
> > > > +                                    ; not already %target register
> > > > +    load -$offset(%target), %tmp    ; load the typeid hash at target
> > > > +    cmp $hash, %tmp                 ; compare expected typeid with loaded
> > > > +    je .Lcheck_passed               ; jump to the indirect call
> > > > +  .Lkcfi_trap$N:                    ; label of trap insn
> > > > +    trap                            ; trap on failure, but arranged so
> > > > +                                    ; "permissive mode" falls through
> > > > +  .Lkcfi_call$N:                    ; label of call insn
> > > > +    call *%target                   ; actual indirect call
> > > > +
> > > > +  This pattern of call immediately after trap provides for the
> > > > +  "permissive" checking mode automatically: the trap gets handled,
> > > > +  a warning emitted, and then execution continues after the trap to
> > > > +  the call.
> > > 
> > > I know it is far too late to do anything here. But I've recently dug
> > > through a bunch of optimization manual and the like and that Jcc is
> > > about as bad as it gets :/
> > > 
> > > The old optimization manual states that forward jumps are assumed
> > > not-taken; while backward jumps are assumed taken.
> > > 
> > > The new wisdom is that any Jcc must be assumed not-taken; that is, the
> > > fallthrough case has the best throughput.
> > 
> > I would expect the cmp to be the slowest part of this sequence, and I
> > figured the both the trap and the call to be speculation barriers? I'm
> > not sure, though. Is changing the sequence actually useful?
> 
> The load can miss, in which case it is definitely the most expensive
> thing around.
> 
> > > Here we have a forward branch which is assumed taken :-(
> > 
> > The constraints we have are:
> > 
> > - Linux x86 KCFI trap handler decodes the instructions from the trap
> >   backwards, but it uses exact offsets (-12 and -6).
> > - Control flow following the trap must make the call (for warn-only mode)
> > 
> > If we change this, we'd need to make the insn decoder smarter to likey
> > look at the insn AFTER the trap ("is it a direct jump?")
> > 
> > And then use this, which is ugly, but matches second constraint:
> > 
> > 	cmp $hash %tmp
> > 	jne .Ltrap
> > .Lcall:
> > 	call *%target
> > 	jmp .Ldone
> > .Ltrap:
> > 	ud2
> > 	jmp .Lcall
> > .Ldone:
> 
> Ah, you can do something like:
> 
> 	cmp $hash, %tmp
> 	jne +3
> 	nopl -42(%rax)
> 	call *%target
> 
> which is only 2 bytes longer. Notably, that nopl is 4 bytes and the 4th
> byte is 0xd6 (aka UDB). This is an effective UDcc instruction based
> around a forward non-taken branch.

Oh right, I forgot about the nop encodings.

> But yeah, I don't know if it is worth changing this. Its just that I've
> been staring at these things far too much of late :-)

To do this we'd need to change the Linux trap handler and Clang's
implementation, so yeah, I'm inclined to just leave it as-is until we
have a stronger reason to change it.

-- 
Kees Cook
