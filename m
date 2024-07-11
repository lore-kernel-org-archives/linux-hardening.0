Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5F28FF;
	Thu, 11 Jul 2024 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723796; cv=none; b=fq7UPkrKeb/yLfUMW0Etfrd/bSlA5dMZSzrxRwZW0zcH+dxOdZEtDQTxPKRb/CqbzQEx+4O45ESWUJC/chLAjsCONlULi360bG/Ym7f2HvL1pds6zEa9i/+rZcaKDAJtF+wVt+GJ65FkQbABSFQXQ3F2soaTh3qDkxsgeof3xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723796; c=relaxed/simple;
	bh=z2Zau4uAm8vaFqoE5iU5MmFK+8bXegUBo5jC5aSrspE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2GOyhz9RubhmSeqF8x9LCyR2gjtq70m46dcqL3xkJrt5FO7Vz6X+WVAjcLt1hIMHfbHjaoPXNUa4WUzRbu4IkwfTaFk3O8ytYKuvV5tT+qCUlzCcmN1zmnByTvVLFw+a1ixiZS6mElSJf9czRLw0iEK48V0Rf4sseHDzd6eeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=By5aYvAq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="By5aYvAq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o/IW2cCwLwJEDMO66z3r5dlrUmlAEsjcwslEcQLO45s=; b=By5aYvAqIMwiWTdp67RiKFT7sD
	+qDZ7b1sxVwD8VDiFHi9n1oSEdZ/3h5u/OftoP8fJgV1h4+y2lNUpjtwaPm5oMmGidDXTk6dic2b4
	w/casdFX/c1h5f+6ZemMDjQZ3uPI7rmnlYxBw3xBJCi2rYWiwztHif2ZV7DI7aeYu616aotcFIN9C
	fHGJCn/AfGhzqriuT4bVmSK64p4kqVZZQosYcIq2LPVBTd0SKRaSVRPAogOxHR/mIyA4AfgJUzmTU
	oPPAOqDQ/Yspi76VOtRsNQDtachP5NzFDNsIkhS/3e01Lk0lh5amtvxv19zcydP/4ugY7iD9yonGR
	xdtwKXHw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRyrJ-000000018ze-3Fdq;
	Thu, 11 Jul 2024 18:49:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4636630050D; Thu, 11 Jul 2024 20:49:37 +0200 (CEST)
Date: Thu, 11 Jul 2024 20:49:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>,
	Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Changbin Du <changbin.du@huawei.com>, Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	t.p.northover@gmail.com, Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v4] x86/traps: Enable UBSAN traps on x86
Message-ID: <20240711184937.GE27299@noisy.programming.kicks-ass.net>
References: <20240710203250.238782-1-gatlin.newhouse@gmail.com>
 <20240711081031.GB4587@noisy.programming.kicks-ass.net>
 <CANpmjNObEzShHvw19EAntPvCYJbqezKBq+pB=mkd7j3sXDEE7A@mail.gmail.com>
 <202407110924.81A08DD4D@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407110924.81A08DD4D@keescook>

On Thu, Jul 11, 2024 at 09:35:24AM -0700, Kees Cook wrote:
> On Thu, Jul 11, 2024 at 11:06:12AM +0200, Marco Elver wrote:
> > On Thu, 11 Jul 2024 at 10:10, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 08:32:38PM +0000, Gatlin Newhouse wrote:
> > > > Currently ARM architectures extract which specific sanitizer
> > > > has caused a trap via encoded data in the trap instruction.
> > > > Clang on x86 currently encodes the same data in ud1 instructions
> > > > but the x86 handle_bug() and is_valid_bugaddr() functions
> > > > currently only look at ud2s.
> > > >
> > > > Bring x86 to parity with arm64, similar to commit 25b84002afb9
> > > > ("arm64: Support Clang UBSAN trap codes for better reporting").
> > > > Enable the reporting of UBSAN sanitizer detail on x86 architectures
> > > > compiled with clang when CONFIG_UBSAN_TRAP=y.
> > >
> > > Can we please get some actual words on what code clang will generate for
> > > this? This doesn't even refer to the clang commit.
> > >
> > > How am I supposed to know if the below patch matches what clang will
> > > generate etc..
> > 
> > I got curious what the history of this is - I think it was introduced
> > in https://github.com/llvm/llvm-project/commit/c5978f42ec8e9, which
> > was reviewed here: https://reviews.llvm.org/D89959
> 
> Sorry, I should have suggested this commit be mentioned in the commit
> log. The details are in llvm/lib/Target/X86/X86MCInstLower.cpp:
> https://github.com/llvm/llvm-project/commit/c5978f42ec8e9#diff-bb68d7cd885f41cfc35843998b0f9f534adb60b415f647109e597ce448e92d9f
> 
>   case X86::UBSAN_UD1:
>     EmitAndCountInstruction(MCInstBuilder(X86::UD1Lm)
>                                 .addReg(X86::EAX)
>                                 .addReg(X86::EAX)
>                                 .addImm(1)
>                                 .addReg(X86::NoRegister)
>                                 .addImm(MI->getOperand(0).getImm())
>                                 .addReg(X86::NoRegister));
> 
> Which is using the UD1Lm template from
> https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/X86/X86InstrSystem.td#L27
> 
>   def UD1Lm   : I<0xB9, MRMSrcMem, (outs), (ins GR32:$src1, i32mem:$src2),
>                   "ud1{l}\t{$src2, $src1|$src1, $src2}", []>, TB, OpSize32;
> 
> It uses OpSize32, distinct from UD1Wm (16) and UD1Qm (64).
> 
> > But besides that, there's very little documentation. Either Gatlin or
> > one of the other LLVM folks might have more background, but we might
> > be out of luck if that 1 commit is all there is.
> > 
> > [+Cc Tim, author of the LLVM commit]
> > 
> > > > diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> > > > index a3ec87d198ac..ccd573d58edb 100644
> > > > --- a/arch/x86/include/asm/bug.h
> > > > +++ b/arch/x86/include/asm/bug.h
> > > > @@ -13,6 +13,17 @@
> > > >  #define INSN_UD2     0x0b0f
> > > >  #define LEN_UD2              2
> > > >
> > > > +/*
> > > > + * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
> > > > + */
> > > > +#define INSN_ASOP    0x67
> > >
> > > I asked, but did not receive answer, *WHY* does clang add this silly
> > > prefix? AFAICT this is entirely spurious and things would be simpler if
> > > we don't have to deal with it.
> 
> Even if we change LLVM, I'd still like to support the older versions, so
> we'll need to handle this regardless.

Is it (LLVM) allowed to do prefix stuffing for 'random' instructions in
order to achieve alignment goals? That is, are we ever expecting more
prefixes here?

Anyway, as proposed the 'decoder' also accepts ASOP UD2, should we be
complete and also return an instruction length? Just in case we want to
be non fatal (WARN like) and skip over the instruction.

> > >
> > > > +#define OPCODE_PREFIX        0x0f
> > >
> > > This is *NOT* a prefix, it is an escape, please see the SDM Vol 2
> > > Chapter 'Instruction Format'. That ASOP thing above is a prefix.
> > >
> > > > +#define OPCODE_UD1   0xb9
> > > > +#define OPCODE_UD2   0x0b
> > >
> > > These are second byte opcodes. The actual (single byte opcodes) of those
> > > value exist and are something entirely different (0xB0+r is MOV, and
> > > 0x0B is OR).
> 
> What would be your preferred names for all of these defines?

SDM calls 0x0f the escape opcode and these others secondary opcode
bytes, so something along those lines would be clear I suppose.	

Vol2 2.1.2 (todays edition)
