Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF196F2F2;
	Wed, 12 Jun 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217721; cv=none; b=NStOJrDJcuJ8slczbt5QfWcAgfBNXkLmdivvg6wsXx2dIFi2dl1fINlJaLKiqwdc5g5KHQ1f6z6O6NRDYWzBXhy2UKNyeydNC+yjaCu3CPw2LiAVj4cVvbl2kJ5w8YUGuBed/+bm0Wel4C6Ke3U/tSG7Pl31KvkBA23rUfZy9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217721; c=relaxed/simple;
	bh=mAIdBktGBsJfF8zgxDtzpPy0UqBsNJgXgpFV2sbScFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRdsOkRgxdg/Ch5NK7hJoTVaurLSmJUicLP9OAg1sdWu1qmDzeXMhS5mFj6B3dFIoniA2K7Wi26YPtSRLm/ldgZvkWyk53oJslHX7m/7tTEOdCuT/cgMM/IEU9n+Q2rAFLnDNqCYcmEgxwFn2aFqSZr0//FwDMvsWjmJvJA3bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU4Pmgqd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU4Pmgqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C059C32786;
	Wed, 12 Jun 2024 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718217720;
	bh=mAIdBktGBsJfF8zgxDtzpPy0UqBsNJgXgpFV2sbScFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FU4PmgqdWvYqgfewU/OGEo4njYGh15AbSaztNNgZgaKDoOJyIe89t6a9VdxgK7G5i
	 lr0HflK89pgZpHcZXCgNSVx7vPuGhFiO6IbMdt27yUpdqVJjbe0xdsOynqXRo1gNiF
	 wcreD5n3XV0HtOeaT/1leJ4xDJzwR426ok4crPgso5y56yAo5nuvQ/BR8OnnxBhS9c
	 LSGRkYMnW2403gAUIjm5XqOZDGIj8gPthOiJRUETY0GO5bSxCnsEbfVhJoPPOZ8tXS
	 zHVI/JzaJZmnLvHzts71QRNENmFI2vhhos1MBZtXsY0wjwDjHPx7kSNR650oXchqC5
	 m01K2Ta0nJwoQ==
Date: Wed, 12 Jun 2024 11:42:00 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Baoquan He <bhe@redhat.com>, Changbin Du <changbin.du@huawei.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] x86/traps: Enable UBSAN traps on x86
Message-ID: <202406121139.5E793B4F3E@keescook>
References: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
 <878qzm6m2m.ffs@tglx>
 <7bthvkp3kitmmxwdywyeyexajedlxxf6rqx4zxwco6bzuyx5eq@ihpax3jffuz6>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bthvkp3kitmmxwdywyeyexajedlxxf6rqx4zxwco6bzuyx5eq@ihpax3jffuz6>

On Tue, Jun 11, 2024 at 01:26:09PM -0700, Gatlin Newhouse wrote:
> On Mon, Jun 03, 2024 at 06:13:53PM UTC, Thomas Gleixner wrote:
> > On Sat, Jun 01 2024 at 03:10, Gatlin Newhouse wrote:
> > 
> > > Bring x86 to parity with arm64, similar to commit 25b84002afb9
> > > ("arm64: Support Clang UBSAN trap codes for better reporting").
> > > Enable the output of UBSAN type information on x86 architectures
> > > compiled with clang when CONFIG_UBSAN_TRAP=y. Currently ARM
> > > architectures output which specific sanitizer caused the trap,
> > > via the encoded data in the trap instruction. Clang on x86
> > > currently encodes the same data in ud1 instructions but the x86
> > > handle_bug() and is_valid_bugaddr() functions currently only look
> > > at ud2s.
> > 
> > Please structure your change log properly instead of one paragraph of
> > unstructured word salad. See:
> > 
> >   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
> >   
> > > +/*
> > > + * Check for UD1, UD2, with or without Address Size Override Prefixes instructions.
> > > + */
> > >  __always_inline int is_valid_bugaddr(unsigned long addr)
> > >  {
> > >  	if (addr < TASK_SIZE_MAX)
> > > @@ -88,7 +92,13 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
> > >  	 * We got #UD, if the text isn't readable we'd have gotten
> > >  	 * a different exception.
> > >  	 */
> > > -	return *(unsigned short *)addr == INSN_UD2;
> > > +	if (*(u16 *)addr == INSN_UD2)
> > > +		return INSN_UD2;
> > > +	if (*(u16 *)addr == INSN_UD1)
> > > +		return INSN_UD1;
> > > +	if (*(u8 *)addr == INSN_ASOP && *(u16 *)(addr + 1) == INSN_UD1)
> > 
> > 	s/1/LEN_ASOP/ ?
> > 
> > > +		return INSN_ASOP;
> > > +	return 0;
> > 
> > I'm not really a fan of the reuse of the INSN defines here. Especially
> > not about INSN_ASOP. Also 0 is just lame.
> > 
> > Neither does the function name make sense anymore. is_valid_bugaddr() is
> > clearly telling that it's a boolean check (despite the return value
> > being int for hysterical raisins). But now you turn it into a
> > non-boolean integer which returns a instruction encoding. That's
> > hideous. Programming should result in obvious code and that should be
> > pretty obvious to people who create tools to validate code.
> > 
> > Also all UBSAN cares about is the actual failure type and not the
> > instruction itself:
> > 
> > #define INSN_UD_MASK		0xFFFF
> > #define INSN_ASOP_MASK		0x00FF
> > 
> > #define BUG_UD_NONE		0xFFFF
> > #define BUG_UD2			0xFFFE
> > 
> > __always_inline u16 get_ud_type(unsigned long addr)
> > {
> > 	u16 insn;
> > 
> > 	if (addr < TASK_SIZE_MAX)
> >         	return BUD_UD_NONE;
> > 
> >         insn = *(u16 *)addr;
> >         if ((insn & INSN_UD_MASK) == INSN_UD2)
> >         	return BUG_UD2;
> > 
> > 	if ((insn & INSN_ASOP_MASK) == INSN_ASOP)
> >         	insn = *(u16 *)(++addr);
> > 
> > 	// UBSAN encodes the failure type in the two bytes after UD1
> >         if ((insn & INSN_UD_MASK) == INSN_UD1)
> >         	return *(u16 *)(addr + LEN_UD1);
> > 
> > 	return BUG_UD_NONE;
> > }
> > 
> > No?
> 
> Thanks for the feedback.
> 
> It seems that is_valid_bugaddr() needs to be implemented on all architectures
> and the function get_ud_type() replaces it here. So how should the patch handle
> is_valid_bugaddr()? Should the function remain as-is in traps.c despite no
> longer being used?

Yeah, this is why I'd suggested to Gatlin in early designs to reuse
is_valid_bugaddr()'s int value. It's a required function, so it seemed
sensible to just repurpose it from yes/no to no/type1/type2/type3/etc.

-Kees

-- 
Kees Cook
