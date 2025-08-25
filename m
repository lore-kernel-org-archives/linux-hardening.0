Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AB28F1
	for <linux-hardening@vger.kernel.org>; Mon, 25 Aug 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109650; cv=none; b=p19XWZF2K085uCqt6jWuPih8UqO4yb6LL/Zw72IpZ6xhMwM6zHwOsI4qa0HccfC4kKhaGFphv3G/gXFG9u6efCBgjZVuQNX/34T9crV2a2YXhgSCXibPdDevR/ffpvWyOHbQkOSJZJMI/2gUSzeeAOIwHKQgY4x7KsxS0qqPsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109650; c=relaxed/simple;
	bh=8s5t2owYPtmxiICQgtYcgysAMaPRgAtiQulUGdZjG+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgkZ/NBa65ldscsZaV/UeDeybAeEgE3fXgfcaF0IUXoMs6FigO2UZ+WJmJ5B5R/ksd8pp2yZ4rdt6uJe4ExZICAuT0xFYCuhxqlEgx/ubtCUgXt7j+mGtfJO6LYGeD4xHf5Q7fSWT5EsVmGSzINn2EJjLkWggOli6ZYGomtHo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CmqhLnsV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CmqhLnsV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lRTu9c5L46ycIUkXtSIz7cdzeUcrFWh9AwNt49e3hU4=; b=CmqhLnsVB221BMPL6HHRq6cSb7
	UPGvOseOmjBPKuJdo7GHMGb7l51v8nl6paa5viQB4uv7xcAlzIlp5SyMZsfua8qd9aiGPBN84pIGE
	DOULYSepO7SFkhmZ7ihpx0G/wRdo5e4uWnR9t7QwjEb+pnXEdP9AzqRhDyPpvsHIWTr64nfpXt3qN
	8TM7Xr/eRvN5qa/1+lPGExNYARbJ4THyg6bJM+JVj7rUahstjXu68J+lGCUF2cS0THOoqYfO3B80t
	yOVYwoSydcnzfHOsmlk+SBvYFy6RF+/g6pv9BE3zc/GnzA7oNZHjoqMazT/ZlH3SqzcGpkfQuIwqO
	xT/5qBtQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqSL1-00000001mT3-19kT;
	Mon, 25 Aug 2025 08:13:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3BC463002ED; Mon, 25 Aug 2025 10:13:58 +0200 (CEST)
Date: Mon, 25 Aug 2025 10:13:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
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
	Dan Li <ashimida.1990@gmail.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
Message-ID: <20250825081358.GS3245006@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
 <202508210841.8BE6E3C117@keescook>
 <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>
 <202508211258.8DEE293@keescook>
 <22C19D00-58D7-4854-915E-C7B8CDB3317E@oracle.com>
 <202508221149.F19A56772@keescook>
 <0F3CAA68-8C9E-49AC-8B12-95BE8E92475C@oracle.com>
 <202508221519.02CEBB27@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508221519.02CEBB27@keescook>

On Fri, Aug 22, 2025 at 03:29:11PM -0700, Kees Cook wrote:
> On Fri, Aug 22, 2025 at 08:29:16PM +0000, Qing Zhao wrote:
> > > On Aug 22, 2025, at 15:02, Kees Cook <kees@kernel.org> wrote:
> > > Right, and sometimes we have to explicitly perform a no-op
> > > address-taking to make sure a symbol gets generated:
> > > 
> > > /*
> > > * Force the compiler to emit 'sym' as a symbol, so that we can reference
> > > * it from inline assembler. Necessary in case 'sym' could be inlined
> > > * otherwise, or eliminated entirely due to lack of references that are
> > > * visible to the compiler.
> > > */
> > > #define ___ADDRESSABLE(sym, __attrs)                                            \
> > >        static void * __used __attrs                                            \
> > >        __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
> > > 
> > > #define __ADDRESSABLE(sym) \
> > >        ___ADDRESSABLE(sym, __section(".discard.addressable"))
> > > 
> > > $ git grep KCFI_REFERENCE
> > > include/linux/compiler.h:#define KCFI_REFERENCE(sym) __ADDRESSABLE(sym)
> > > arch/x86/include/asm/page_64.h:KCFI_REFERENCE(copy_page);
> > > arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memset);
> > > arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memmove);
> > > arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_prog_runX);
> > > arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_callback_fn);
> > 
> > I am curious on why the compiler eliminates an external routine completely in the file if it's address-taken in that file. 
> > Why an additional no-op address-taken is needed here. 
> 
> If I am remembering correctly this is needed for rare cases where
> a function built without a C definition is being used in Linux's
> self-patching "alternatives" code swaps in one function for another,
> and is being used indirectly. These cases end up not being visible to
> compiler (so no address-taken), but the indirect call site is still
> being instrumented. And the above list is the _entire_ list of such
> corner cases: all really low-level things.
> 
> Peter may remember this better than me...

The above are all functions from assembly and JITs, the C compiler
simply never sees the function definition, only the declaration. The
above is used to force emit the __typeid symbol, such that assembly can
reference it and it all links correctly.
