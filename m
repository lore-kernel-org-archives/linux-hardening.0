Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00D31D750
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089170; cv=none; b=i0A3HBWKyQQl7/QM0/Srx+0EUNXfdh0RTwbtMlyKe2KORTN9q/8y8Niv+/TFN4Gz3GEhhcJ5FlZTQ/1y/Ofh4UJm+2yavNJ5ncdgfGKx+sHlpRrlkb0CfwDXwH66X8W/UT8EfVK36pLpBQtuZmp/tQLRg5s2oEcM+SFZedGmnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089170; c=relaxed/simple;
	bh=pDZbr2IgVOxJQT3hGM4g1OhQ1HBHGlX/uVtTXZssI/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMrXo4LiR1aMgF95GckpZ3VNDJ0a+GP6qnFVdtSE3l4OhRRdBTs4p3yiXvcc5+ISRwrarY9HIaB0yC7jZubbFi2MDXPpUTu4v8fXZxlTi4UNtl5ahfElLooEFvlA6FV+DYLcEfBpxhLc5x5ddS2TJ2+7P5UynDTToCSswxBXvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD3BQ+u6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD3BQ+u6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02C3C4CEF1;
	Fri,  5 Sep 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757089169;
	bh=pDZbr2IgVOxJQT3hGM4g1OhQ1HBHGlX/uVtTXZssI/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fD3BQ+u6pOIFonWbziEfK5l0zeH31gETBqqCxjWTKQWiqI7jKrgrZgP1AVZ1X23wV
	 MRsN7OrAhYGjgqyB2Fdlx+jIKfHpyKyA2XxosAfplu9McvLc6yVZ/DLckPIwIf/X47
	 a9RGfDO/yIm6HGAJl1FYm41Yk2KTHas7MJG3Dq4FjFVnA51p/4qWp1w8bYazzt6Cde
	 +N2/Hkm8vX4tdDqg/MOhkRTjsigLQjpMPXyRUG8otd7hwRy4YFPnvdZxDeNGHvYLNR
	 NnypNsOceDxyjyDw+GFCsb3ZfXgWKL8ct4vmOLU4TThwexSdQvwawjjfzREJXdp0cU
	 CLedEPJgSCp8w==
Date: Fri, 5 Sep 2025 09:19:29 -0700
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
Message-ID: <202509050907.DE9A5ED2@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-2-kees@kernel.org>
 <20250905085103.GT3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905085103.GT3245006@noisy.programming.kicks-ass.net>

On Fri, Sep 05, 2025 at 10:51:03AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 04, 2025 at 05:24:10PM -0700, Kees Cook wrote:
> > +- The check-call instruction sequence must be treated a single unit: it
> > +  cannot be rearranged or split or optimized. The pattern is that
> > +  indirect calls, "call *$target", get converted into:
> > +
> > +    mov $target_expression, %target ; only present if the expression was
> > +                                    ; not already %target register
> > +    load -$offset(%target), %tmp    ; load the typeid hash at target
> > +    cmp $hash, %tmp                 ; compare expected typeid with loaded
> > +    je .Lcheck_passed               ; jump to the indirect call
> > +  .Lkcfi_trap$N:                    ; label of trap insn
> > +    trap                            ; trap on failure, but arranged so
> > +                                    ; "permissive mode" falls through
> > +  .Lkcfi_call$N:                    ; label of call insn
> > +    call *%target                   ; actual indirect call
> > +
> > +  This pattern of call immediately after trap provides for the
> > +  "permissive" checking mode automatically: the trap gets handled,
> > +  a warning emitted, and then execution continues after the trap to
> > +  the call.
> 
> I know it is far too late to do anything here. But I've recently dug
> through a bunch of optimization manual and the like and that Jcc is
> about as bad as it gets :/
> 
> The old optimization manual states that forward jumps are assumed
> not-taken; while backward jumps are assumed taken.
> 
> The new wisdom is that any Jcc must be assumed not-taken; that is, the
> fallthrough case has the best throughput.

I would expect the cmp to be the slowest part of this sequence, and I
figured the both the trap and the call to be speculation barriers? I'm
not sure, though. Is changing the sequence actually useful?

> Here we have a forward branch which is assumed taken :-(

The constraints we have are:

- Linux x86 KCFI trap handler decodes the instructions from the trap
  backwards, but it uses exact offsets (-12 and -6).
- Control flow following the trap must make the call (for warn-only mode)

If we change this, we'd need to make the insn decoder smarter to likey
look at the insn AFTER the trap ("is it a direct jump?")

And then use this, which is ugly, but matches second constraint:

	cmp $hash %tmp
	jne .Ltrap
.Lcall:
	call *%target
	jmp .Ldone
.Ltrap:
	ud2
	jmp .Lcall
.Ldone:

+4 bytes for x86_64

-- 
Kees Cook
