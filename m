Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970C2D3752
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889322; cv=none; b=H4Ouzxazq2NUsw1/1iFeIbM8L96IOlNko6iQ0vGi29SMZX8GuB3mllBcdTmLuty0SswosC3Iq+/eC4Wa50vkE50WXqDPRKgBaT/Hw6OIA2LjRqmRPN/8GM29bnbKY7+AlqV5OBTyjNiknw2Y/pzQ1ILPYEUw8ML0ZKY/qMDfNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889322; c=relaxed/simple;
	bh=7u+tOLb2W9mspBt9fmN76OGTdwR39QLXh11S5gTh/eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr6twXSBHplzTA4tkrUKjGvAnaDMdOp3u+1aN+1kNOMACE8hceUrU5zPAbIP4z+2jxdmOibNZVMl6zqTepMC3TcSBEWXP9K0IjhkfvpNilS7ZT095HDc0UaegWYsgCTesPlnr5CWLSKvr5J7kSkWtMiY7l3vZyoje4po6vaEWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQEBVhgB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQEBVhgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9484C4CEF1;
	Fri, 22 Aug 2025 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755889321;
	bh=7u+tOLb2W9mspBt9fmN76OGTdwR39QLXh11S5gTh/eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQEBVhgBfVCgmUoFXPTt7sPwALEMy6RZtoFM3LwI9R0dlqENH8XWInciQXFmA2fmF
	 CMhmzS5Kn1Vjors4BMqwjpAulBCQtsFcYqBhDIFA8Nrs9tZTN86jH1kpXHJaRusd+1
	 +JtF4pxzd2b0L7k5YRUWg4Lhn45Nz5Lq9GTaqFr6H6/D4rnbnNAwWUXTKX2Y210PnF
	 n0a5R1aXJRPjZeOcOK7cQKypAMj9iJ2YA2y+qHYIMvdabiaebE1OZu7Zbk2tS9xKxV
	 E/syxfcVB6naAJf5VatMfw7ICrzuWrRYzxljUFUqZEqXGIMet6WNSyVse1lgPNmh+X
	 PMST3xkm7wDXg==
Date: Fri, 22 Aug 2025 12:02:01 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
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
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Message-ID: <202508221149.F19A56772@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
 <202508210841.8BE6E3C117@keescook>
 <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>
 <202508211258.8DEE293@keescook>
 <22C19D00-58D7-4854-915E-C7B8CDB3317E@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22C19D00-58D7-4854-915E-C7B8CDB3317E@oracle.com>

On Fri, Aug 22, 2025 at 03:11:16PM +0000, Qing Zhao wrote:
> > On Aug 21, 2025, at 17:29, Kees Cook <kees@kernel.org> wrote:
> > For non-static functions, we cannot know if other compilation units may
> > make indirect calls to a given function, so those functions must always
> > have their kcfi preamble added. For static functions, if they are
> > address-taken by the current compilation unit, then they must get a kcfi
> > preamble added.
> 
> Oh, yeah, I see. without lto or whole-program-mode, we cannot determine 
> whether a extern function is address taken or not. Therefore, we have to 
> treat ALL extern functions conservatively as address taken. 
> 
> So, from my understanding, the complete list that need to compute the typeid from the function prototype is:
> 
> - At indirect call sites
> 	- all indirect call sites; (At the call site)
> - At function preambles
> 	- all address-taken static functions  (At the function definition)
> 	- all extern functions  (At function declaration or function definition?? Please see my question below)

For "extern functions", the logic is split as:
 - "all extern function definitions get preamble"
 - "all extern function declarations without a definition that are
   address-taken get __kcfi_typeid_ symbol"

> > The other case is emitting the __ckfi_typeid_FUNC weak symbols, which is
> > used for link-time resolution with non-C code (i.e. raw .S assembly)
> > which doesn't have access to the C type system to calculate the hashes
> > on its own, and needs to have a way to build its own kcfi preambles.
> 
> So, for such functions, there should be an extern function declaration in the C code. 
> But the definition of such function is not available in the C code we are compiling. 
> Therefore the weak __ckfi_typeid_FUNC symbol is emitted at the function declaration
> point for such function when we compile the C code? 
> 
> And the typeid (the hash value) for such routine is computed at the function declaration 
> point too. 
> 
> Is the above understanding correct? 

Correct, the kcfi_typeid symbol and value are emitted at function
declaration point, but only if such function is address-taken.

> Then for the other extern function whose definition is in the C code of other modules that might
> be compiled later, should the typeid is computed at the declaration or the definition?

It is computed and emitted just for externs that are address-taken.

> > This
> > is how Linux constructs its assembly function entry points:
> > 
> > #ifndef __CFI_TYPE
> > #define __CFI_TYPE(name)                                \
> >        .4byte __kcfi_typeid_##name
> > #endif
> > 
> > #define SYM_TYPED_ENTRY(name, linkage, align...)        \
> >        linkage(name) ASM_NL                            \
> >        align ASM_NL                                    \
> >        __CFI_TYPE(name) ASM_NL                         \
> >        name:
> > 
> > That way all the asm functions can be be indirect call targets without
> > knowing the hash value (which will be filled in at link time).
> 
> Okay. I see.  This is the case for the extern function whose definition is in the assembly file. (Not available in
> the C code)

Right, and sometimes we have to explicitly perform a no-op
address-taking to make sure a symbol gets generated:

/*
 * Force the compiler to emit 'sym' as a symbol, so that we can reference
 * it from inline assembler. Necessary in case 'sym' could be inlined
 * otherwise, or eliminated entirely due to lack of references that are
 * visible to the compiler.
 */
#define ___ADDRESSABLE(sym, __attrs)                                            \
        static void * __used __attrs                                            \
        __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;

#define __ADDRESSABLE(sym) \
        ___ADDRESSABLE(sym, __section(".discard.addressable"))

$ git grep KCFI_REFERENCE
include/linux/compiler.h:#define KCFI_REFERENCE(sym) __ADDRESSABLE(sym)
arch/x86/include/asm/page_64.h:KCFI_REFERENCE(copy_page);
arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memset);
arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memmove);
arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_prog_runX);
arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_callback_fn);


> > I assume I just didn't see how yet. :) I wasn't able to identify nor
> > store the typeid for function definitions that ultimately end up getting
> > .s file output.
> So, the problem only exists for the external functions whose definition is NOT in the C code? 

Yup!

> > I couldn't figure out how to find these during the GIMPLE pass. Oh,
> > perhaps I can do this with an IPA pass? That should let me walk all
> > functions including externs. I'll give it a try...

Adding the IPA pass to find all functions worked perfectly. I was able
to remove all the weird DECL reconstruction and just use the original
FUNCTION_TYPE info for the typeids.

-Kees

-- 
Kees Cook
