Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD83176AB9;
	Mon, 17 Jun 2024 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665608; cv=none; b=bHWO2pbTkNqIeYy44eHM667Hurx9JJFHDfiE5Z36aIPa8Kw5pP4aPQKJsRggiWxCq4YVGUFCWi7LqJJgWJE49VhgtuA04W0yRPfNvmNmb9eDTccQnEGjgUiRDdo/vQEhBuLEolpkQiMmryDs7mvvujfGDZevClNdsZSOgZyXssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665608; c=relaxed/simple;
	bh=vLazNnEc/xJPEF+aUOoG5khtpz42+kQKl+9e0EODWuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6vqEG+J/TW23m8ctqT5r744f9DQnfmSqG6KSMPz10YCkAJipTV5AlrKhE068XwuLo6ECce+zaubnplDrCRvKAen3e4oymw+wGbTcRODvZpx48tuKx5+jzI7D7/mFiUIc+nPw3ZZoAbCFaO33WJ24X2WPRJl9ldj+I0rkLoRmKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeTUngKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeTUngKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF6C2BD10;
	Mon, 17 Jun 2024 23:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718665607;
	bh=vLazNnEc/xJPEF+aUOoG5khtpz42+kQKl+9e0EODWuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeTUngKQEXdzBnPO4oHNWtGml7HuDaPs5+7Cgyuw1nA4GBdTdaydyliptdrmjhX1c
	 3gs6VIzYsJbr7liSU7EIF9bMzcjo1C0qhqTmHQz60GDCLvkWwrqKPQBraAXwR9/l2D
	 D+81ZjwyXzVlETFepM2FMs0+TyYp+wGT46sWfp+S1IAHQwHdSd3ZXIUoXnibCM7n+F
	 0GYcnzp+WfAIA1N1SXVn0BEZrmZXwcBOBS3ZpyMyOMkDxOFlmKMOeRv9Pyo7Hmx40g
	 xF3iIPxAjkqwNy7c4k1dozD0oZvrX6Fa8KUhSAhOoU9j7k17Q9PgNMMH3Fx0Gfawmx
	 1YdlAz4cfwHcQ==
Date: Mon, 17 Jun 2024 16:06:47 -0700
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
Message-ID: <202406171557.E6CA604FB@keescook>
References: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
 <878qzm6m2m.ffs@tglx>
 <7bthvkp3kitmmxwdywyeyexajedlxxf6rqx4zxwco6bzuyx5eq@ihpax3jffuz6>
 <202406121139.5E793B4F3E@keescook>
 <875xu7rzeg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xu7rzeg.ffs@tglx>

On Tue, Jun 18, 2024 at 12:13:27AM +0200, Thomas Gleixner wrote:
> On Wed, Jun 12 2024 at 11:42, Kees Cook wrote:
> > On Tue, Jun 11, 2024 at 01:26:09PM -0700, Gatlin Newhouse wrote:
> >> It seems that is_valid_bugaddr() needs to be implemented on all architectures
> >> and the function get_ud_type() replaces it here. So how should the patch handle
> >> is_valid_bugaddr()? Should the function remain as-is in traps.c despite no
> >> longer being used?
> >
> > Yeah, this is why I'd suggested to Gatlin in early designs to reuse
> > is_valid_bugaddr()'s int value. It's a required function, so it seemed
> > sensible to just repurpose it from yes/no to no/type1/type2/type3/etc.
> 
> It's not sensible, it's just tasteless.
> 
> If is_valid_bugaddr() is globaly required in it's boolean form then it
> should just stay that way and not be abused just because it can be
> abused.
> 
> What's wrong with doing:
> 
> __always_inline u16 get_ud_type(unsigned long addr)
> {
>         ....
> }
> 
> int is_valid_bugaddr(unsigned long addr)
> {
> 	return get_ud_type() != BUG_UD_NONE;
> }
> 
> Hmm?
> 
> In fact is_valid_bugaddr() should be globally fixed up to return bool to
> match what the function name suggests.
> 
> The UD type information is x86 specific and has zero business in a
> generic architecture agnostic function return value.
> 
> It's a sad state of affairs that I have to explain this to people who
> care about code correctness. Readability and consistency are substantial
> parts of correctness, really.

Well, it's trade-offs. If get_ud_type() is in is_valid_bugaddr(), we
have to call it _again_ outside of is_valid_bugaddr(). That's suboptimal
as well. I was trying to find a reasonable way to avoid refactoring all
architectures and to avoid code code.

Looking at it all again, I actually think arch/x86/kernel/traps.c
shouldn't call is_valid_bugaddr() at all. That usage can continue to
stay in lib/bug.c, which is only ever used by x86 during very early
boot, according to the comments in early_fixup_exception(). So just a
direct replacement of is_valid_bugaddr() with the proposed get_ud_type()
should be fine in arch/x86/kernel/traps.c.

What do you think?

-- 
Kees Cook
