Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0410F1;
	Tue, 21 Jul 2026 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592727; cv=none; b=nDrBC3ZgZ4aoMK/uh8VkhKfRu2goy3xbSHzmlwoMTPBSMf33jVdaoF/g8s6JrltgB+pTm9u3eTLVfDPltJJlRip5WKz3XOHZn93+s65wJfJxlxh6EgGkhvDa6sCCrJARHA3TpJLgoTMV19YEhDgvvdaKs8UfEancYtLwt+rzcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592727; c=relaxed/simple;
	bh=FuVrgXP7lMIHKi453Aiwl8puJACKfO5cBs5WKc3tPEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEVUp6KbaFXHml9HNGoTYhmOCdDWUJ8wRnvj8ECFqstg8R9vIJN0gcppbPo3HB2Z3CevcA5LLSdBzWWslDP/3rBAfsxwsEvh1a0Nmg5CrjjbdU4gOIvSQG5tg3sqf0UzVHJ38mb6EPR9jq0p6UowSGncjFoGQzEzuO4eogni+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7lsda8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7lsda8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A8E1F000E9;
	Tue, 21 Jul 2026 00:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784592725;
	bh=VXlc6HT4lYc03UjhyLS3oPG/+n1mY3bfDktU1WUYqAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N7lsda8wgWs09xBOYAOmoQ90scQZUIW+wwU1JYnB2SddZXloWe42l+bWx5uwn9N7t
	 ZBVK83YqBKcyJEQertnaLibX5qRO0C4BrYJuT7G4yxEazd/Z8+MUj7mVwC5+qnc6Mn
	 6VF1MOp5sIBOBvryDTOhV2dGnDxVqSks4fhlaHpZm0dmocljiyGJWvjw3ONlBNErtE
	 l89OQJQKwriJc6g4AfWsSp9EXFT8+k0iOjTE8+Zke53X4p+f08FMrjhtA1Vc6EGgF6
	 qZPmeYU3CN5TWEq+oaRLPPHplOFeom5DDPpTYGYIoChe5QkGk2GFT71XEWkhXA60jg
	 r4eP6jXHiaCEw==
Date: Mon, 20 Jul 2026 17:11:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linusw@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] ARM: traps: Implement KCFI trap handler for ARM32
Message-ID: <20260721001159.GA3326792@ax162>
References: <20260715175223.make.153-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715175223.make.153-kees@kernel.org>

On Wed, Jul 15, 2026 at 10:52:27AM -0700, Kees Cook wrote:
> ARM32 GCC KCFI[1] violations currently show as generic "Oops - undefined
> instruction" errors, making debugging CFI failures difficult. Add a proper
> KCFI trap handler similar to the aarch64 implementation to provide clear
> CFI error messages, including the call target and the expected type.
> 
> Clang and GCC trap CFI failures differently on ARM32. Clang lowers
> its checks to a BKPT, handled via the breakpoint/prefetch-abort path
> in hw_breakpoint.c, which cannot recover the target or expected type
> and so must report via report_cfi_failure_noaddr(). GCC instead lowers
> KCFI checks to a UDF (undefined instruction) whose immediate encodes
> the registers involved, so the handler can decode it and call the full
> report_cfi_failure() with the target and expected type.
> 
> The GCC ARM32 KCFI implementation uses UDF instructions with a specific
> encoding pattern:
> - UDF instruction format: cccc 0111 1111 imm12 1111 imm4
> - 16-bit immediate reconstructed from bits 19-8 and 3-0
> - KCFI encoding: 0x8000 | (type_reg_num << 5) | (target_reg_num & 31)
> - Bit 15: KCFI trap identifier (0x8000)
> - Bits 9-5: Type ID register field (0x1F when unavailable)
> - Bits 4-0: Target address register number
> 
> When the type register field is 0x1F (the type was spilled rather than
> kept in a register), the handler walks back up to 6 preceding
> instructions to recover the 32-bit type ID from the four EOR-immediate
> instructions the compiler emits, similar to x86 CFI trap reconstruction.
> 
> The handler is dispatched directly from do_undefinstr() rather than
> through register_undef_hook(). A registered hook is only installed once
> initcalls run, so any KCFI violation that fires earlier in boot would be
> reported as a generic "undefined instruction"; calling the decoder from
> the exception handler itself catches failures from the very first
> instruction. Dispatching directly also lets the handler ignore
> non-kernel-mode UDFs, preventing a user process from spoofing the KCFI
> encoding.
> 
> Both the UDF handler and the Clang breakpoint handler in hw_breakpoint.c
> act on the report_cfi_failure*() result identically (oops on a fatal
> violation, or skip the trapping instruction under CFI permissive mode)
> so factor that shared tail into arm_cfi_handle_failure(), declared in
> asm/traps.h.
> 
> Link: https://inbox.sourceware.org/gcc-patches/20260618204539.824446-6-kees@kernel.org/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

I tested this in QEMU using LKDTM, which shows lkdtm_increment_int() as
the target of the failed call.

-- 
Cheers,
Nathan
