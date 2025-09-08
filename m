Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD122315D36
	for <linux-hardening@vger.kernel.org>; Mon,  8 Sep 2025 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345593; cv=none; b=gmAeJ5JuS0bDgqGEK3z5U0bg1/CYm2aMn/BN0HE/Rkd9AWnjsnunzVV+ehCEqS1ep1mb3UUOwAV5fFm9BEc/kEYTYcNcTcSVrYllqfsPAhhsVMgYx2L0ySJKwA1Mr1Kw5IvFNF6mXGj4Qc2s8WAKvvby4QfOup1/3pijrfA8tSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345593; c=relaxed/simple;
	bh=mA0Ld5Lz4RQIkXRx4qVjWeF2YTChMNN7VMeAC9k8U7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTJMylwPrCnCybTaP+yC3zl1Nxyq3tKidvVjBcdRWAC86OWt20nmOlusIfzN66tQck4SP0Pp2dR5LKJdoXxRrdwC7i60sXJrSAEr0TBZbpT1sYYa2jw2ZlP2bZwEsUC65gVNsk9GY2fRQyJQ9s1NNhvSqpKmy5jdXKZsZ4TDvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hw5RnLrL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hw5RnLrL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zTe2XP54J4wh9lsqfmRCJ/h1k6R0kMeomiRJ+qjt6fw=; b=Hw5RnLrL1Lm20A/UIa1peq9tIr
	SUVCuFpThatcoJU+u/v0YoaRdLF7/7+dXYIINqOFJRs6ROQ5+a5ohxXGbMmn+GjsVAAKszTMGpvEH
	w+loQMTJIKSrEmmiSR5I2vB8GoywQeuutsJ+bbSoBLfCLzhqhB4UkiWCCmV81Pf6KEY3z9sULmt/u
	MDkd4Mu/riL8XWMzhOQ/xC9artTOtlZjldFFbRdEovA/kckquhkYZfFKUjiBDWrb+EG7VP6k2CI7Y
	2BF8g9UhWZWoZpQ+kPUcZwxdOYqHloLJJEw7L7F9P4dwT72FA5tbPKNPHcO/xvSObxbkoetTH6vs2
	9G79yzHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvdrY-000000055La-1RO8;
	Mon, 08 Sep 2025 15:33:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DBA0F300230; Mon, 08 Sep 2025 17:32:58 +0200 (CEST)
Date: Mon, 8 Sep 2025 17:32:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <20250908153258.GE4067720@noisy.programming.kicks-ass.net>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <20250905085103.GT3245006@noisy.programming.kicks-ass.net>
 <202509050907.DE9A5ED2@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509050907.DE9A5ED2@keescook>

On Fri, Sep 05, 2025 at 09:19:29AM -0700, Kees Cook wrote:
> On Fri, Sep 05, 2025 at 10:51:03AM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 04, 2025 at 05:24:10PM -0700, Kees Cook wrote:
> > > +- The check-call instruction sequence must be treated a single unit: it
> > > +  cannot be rearranged or split or optimized. The pattern is that
> > > +  indirect calls, "call *$target", get converted into:
> > > +
> > > +    mov $target_expression, %target ; only present if the expression was
> > > +                                    ; not already %target register
> > > +    load -$offset(%target), %tmp    ; load the typeid hash at target
> > > +    cmp $hash, %tmp                 ; compare expected typeid with loaded
> > > +    je .Lcheck_passed               ; jump to the indirect call
> > > +  .Lkcfi_trap$N:                    ; label of trap insn
> > > +    trap                            ; trap on failure, but arranged so
> > > +                                    ; "permissive mode" falls through
> > > +  .Lkcfi_call$N:                    ; label of call insn
> > > +    call *%target                   ; actual indirect call
> > > +
> > > +  This pattern of call immediately after trap provides for the
> > > +  "permissive" checking mode automatically: the trap gets handled,
> > > +  a warning emitted, and then execution continues after the trap to
> > > +  the call.
> > 
> > I know it is far too late to do anything here. But I've recently dug
> > through a bunch of optimization manual and the like and that Jcc is
> > about as bad as it gets :/
> > 
> > The old optimization manual states that forward jumps are assumed
> > not-taken; while backward jumps are assumed taken.
> > 
> > The new wisdom is that any Jcc must be assumed not-taken; that is, the
> > fallthrough case has the best throughput.
> 
> I would expect the cmp to be the slowest part of this sequence, and I
> figured the both the trap and the call to be speculation barriers? I'm
> not sure, though. Is changing the sequence actually useful?

The load can miss, in which case it is definitely the most expensive
thing around.

> > Here we have a forward branch which is assumed taken :-(
> 
> The constraints we have are:
> 
> - Linux x86 KCFI trap handler decodes the instructions from the trap
>   backwards, but it uses exact offsets (-12 and -6).
> - Control flow following the trap must make the call (for warn-only mode)
> 
> If we change this, we'd need to make the insn decoder smarter to likey
> look at the insn AFTER the trap ("is it a direct jump?")
> 
> And then use this, which is ugly, but matches second constraint:
> 
> 	cmp $hash %tmp
> 	jne .Ltrap
> .Lcall:
> 	call *%target
> 	jmp .Ldone
> .Ltrap:
> 	ud2
> 	jmp .Lcall
> .Ldone:

Ah, you can do something like:

	cmp $hash, %tmp
	jne +3
	nopl -42(%rax)
	call *%target

which is only 2 bytes longer. Notably, that nopl is 4 bytes and the 4th
byte is 0xd6 (aka UDB). This is an effective UDcc instruction based
around a forward non-taken branch.

But yeah, I don't know if it is worth changing this. Its just that I've
been staring at these things far too much of late :-)
