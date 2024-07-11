Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A816B752;
	Thu, 11 Jul 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715725; cv=none; b=d9r7CRGIx82YPM5bnS0cT0drDdbN39EnU0ANLtkLgpG5l3lNFhMGmzYHnQ2R0FfPjXpgDOQb77ONUsEckkqM67vaKHY9QWQL+KzEfXdiY4TcLGZbJdHg7JxgRewD0pjYLJs40NwFvSZome9dM++lw70w0bm6vJprD/DDx4RC1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715725; c=relaxed/simple;
	bh=eYOzrKzYkBArUGV+retdG2v4fSbxeHESNpJPniHrEBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hwmbukn1aQk+Mphk9wuQcIRZVMv4pihJUBMX+xQkGAP4eVvtxCSrteliQgfqVgiRGo3Fzvr6omlVNoI3MjviIWF3rR+Q8VD4U54d1+LHECNUtWrzYEByKIkMpWDzhx8E81N13Hmu/d9oQPTkFyBmcN1uixN7hy4E5QJXJj9gHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kty32UDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kty32UDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49893C116B1;
	Thu, 11 Jul 2024 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720715725;
	bh=eYOzrKzYkBArUGV+retdG2v4fSbxeHESNpJPniHrEBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kty32UDHqUwc34fH+pbtVG4FtlLSqpihl2Oc+Hx7JE/2QJAOzQDDdd+WDi2mpE1FR
	 ZRrliVHVYrxT73c5ivaXYRtGNOypC2rjHn0GspIwx18EiujaaBZPWBReeLhHof6AQo
	 KcE3iC9+6EU4S8xKN3dNo6itXqwJDzE2Jh0U086Jl1YY7TWF7FsoQekJJUzjNBNyPz
	 sOctkctn3WNBmPUZZtVkzDYsOgUYuIGMKxtwUOYHfd2cs3AzCYs1vtPTEUUmVnCRy/
	 r8sALqwCo5bDRDDISgYzxZlOqdSj/f43VR73tyNDJMtEzx6AzvNfC2CXY04fTc08vW
	 fdndubSKuYHeA==
Date: Thu, 11 Jul 2024 09:35:24 -0700
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <202407110924.81A08DD4D@keescook>
References: <20240710203250.238782-1-gatlin.newhouse@gmail.com>
 <20240711081031.GB4587@noisy.programming.kicks-ass.net>
 <CANpmjNObEzShHvw19EAntPvCYJbqezKBq+pB=mkd7j3sXDEE7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNObEzShHvw19EAntPvCYJbqezKBq+pB=mkd7j3sXDEE7A@mail.gmail.com>

On Thu, Jul 11, 2024 at 11:06:12AM +0200, Marco Elver wrote:
> On Thu, 11 Jul 2024 at 10:10, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jul 10, 2024 at 08:32:38PM +0000, Gatlin Newhouse wrote:
> > > Currently ARM architectures extract which specific sanitizer
> > > has caused a trap via encoded data in the trap instruction.
> > > Clang on x86 currently encodes the same data in ud1 instructions
> > > but the x86 handle_bug() and is_valid_bugaddr() functions
> > > currently only look at ud2s.
> > >
> > > Bring x86 to parity with arm64, similar to commit 25b84002afb9
> > > ("arm64: Support Clang UBSAN trap codes for better reporting").
> > > Enable the reporting of UBSAN sanitizer detail on x86 architectures
> > > compiled with clang when CONFIG_UBSAN_TRAP=y.
> >
> > Can we please get some actual words on what code clang will generate for
> > this? This doesn't even refer to the clang commit.
> >
> > How am I supposed to know if the below patch matches what clang will
> > generate etc..
> 
> I got curious what the history of this is - I think it was introduced
> in https://github.com/llvm/llvm-project/commit/c5978f42ec8e9, which
> was reviewed here: https://reviews.llvm.org/D89959

Sorry, I should have suggested this commit be mentioned in the commit
log. The details are in llvm/lib/Target/X86/X86MCInstLower.cpp:
https://github.com/llvm/llvm-project/commit/c5978f42ec8e9#diff-bb68d7cd885f41cfc35843998b0f9f534adb60b415f647109e597ce448e92d9f

  case X86::UBSAN_UD1:
    EmitAndCountInstruction(MCInstBuilder(X86::UD1Lm)
                                .addReg(X86::EAX)
                                .addReg(X86::EAX)
                                .addImm(1)
                                .addReg(X86::NoRegister)
                                .addImm(MI->getOperand(0).getImm())
                                .addReg(X86::NoRegister));

Which is using the UD1Lm template from
https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/X86/X86InstrSystem.td#L27

  def UD1Lm   : I<0xB9, MRMSrcMem, (outs), (ins GR32:$src1, i32mem:$src2),
                  "ud1{l}\t{$src2, $src1|$src1, $src2}", []>, TB, OpSize32;

It uses OpSize32, distinct from UD1Wm (16) and UD1Qm (64).

> But besides that, there's very little documentation. Either Gatlin or
> one of the other LLVM folks might have more background, but we might
> be out of luck if that 1 commit is all there is.
> 
> [+Cc Tim, author of the LLVM commit]
> 
> > > diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> > > index a3ec87d198ac..ccd573d58edb 100644
> > > --- a/arch/x86/include/asm/bug.h
> > > +++ b/arch/x86/include/asm/bug.h
> > > @@ -13,6 +13,17 @@
> > >  #define INSN_UD2     0x0b0f
> > >  #define LEN_UD2              2
> > >
> > > +/*
> > > + * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
> > > + */
> > > +#define INSN_ASOP    0x67
> >
> > I asked, but did not receive answer, *WHY* does clang add this silly
> > prefix? AFAICT this is entirely spurious and things would be simpler if
> > we don't have to deal with it.

Even if we change LLVM, I'd still like to support the older versions, so
we'll need to handle this regardless.

> >
> > > +#define OPCODE_PREFIX        0x0f
> >
> > This is *NOT* a prefix, it is an escape, please see the SDM Vol 2
> > Chapter 'Instruction Format'. That ASOP thing above is a prefix.
> >
> > > +#define OPCODE_UD1   0xb9
> > > +#define OPCODE_UD2   0x0b
> >
> > These are second byte opcodes. The actual (single byte opcodes) of those
> > value exist and are something entirely different (0xB0+r is MOV, and
> > 0x0B is OR).

What would be your preferred names for all of these defines?

-- 
Kees Cook
