Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E0393DF6
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901752; cv=none; b=Wr8YjjG3afsUt0K7yuLvqVdwPdvbhP26jUM1oPm5a7UxhPSVkpKbYbdSIS0DnTUcnDmALST8FciRUoUPs9fNLoEJExQ4gszxawqRc4Zp44Wekj7AXjwPNBygYDUnWpqvvXoLQW2N+WGMGTbHeMNcaxukniXjiBiGEQw4+NyF0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901752; c=relaxed/simple;
	bh=GS1D5/Nb5jV4iRJH3gv3Mgy+dmUtMmBhu29ziOfIxiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOrcjrfbXruYu6zxcUB1H49tsToY2xkPfAnQsvdpyph1MmIpwzN5KC1A6bvpzXy7YJj/CgmQvRqsdwBb66zlnhrylXhbDKZgxSiQgO0axMpd4QaLo7O4SLN2YE2gP1hWP2Gd7SLra+ahfcLqlbrqbATWMes5DuQkGdeWNM7XWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/ocA0xN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/ocA0xN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FA9C4CEED;
	Fri, 22 Aug 2025 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755901751;
	bh=GS1D5/Nb5jV4iRJH3gv3Mgy+dmUtMmBhu29ziOfIxiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/ocA0xN5SzK6mhyRongD1lUBbfd5vf2F4EwO1Y5zNEPH2rwbhq/BnrC82i4nyZc0
	 lpfJYMjic9MttR3AacCNNujGTa7WK312AbCXI1YTfjUkr2RsTJ4sx/jgcsRa1anaPt
	 nWBqaW6godCyRSC9DnfGgKXeE0kaqRlvu720IF3q/yOK0NK4wI0FvRW5Vikst/nD8W
	 il8/JHQQwA1Tc8cY3Q/0bFv33VMynnyi7nQCidy5DFR/gfJ+mkiwN1rolLd7AVwirY
	 wIn47hl+5SvPhdus2YON9Ef+CqmWmh1AjLMdr+ukRUKT5lHQabxvU15CqmP97bfUeo
	 yY+vsydPNloIg==
Date: Fri, 22 Aug 2025 15:29:11 -0700
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
Message-ID: <202508221519.02CEBB27@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com>
 <202508210841.8BE6E3C117@keescook>
 <E69330D6-1302-4BA1-BADD-8C91A096A1FD@oracle.com>
 <202508211258.8DEE293@keescook>
 <22C19D00-58D7-4854-915E-C7B8CDB3317E@oracle.com>
 <202508221149.F19A56772@keescook>
 <0F3CAA68-8C9E-49AC-8B12-95BE8E92475C@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F3CAA68-8C9E-49AC-8B12-95BE8E92475C@oracle.com>

On Fri, Aug 22, 2025 at 08:29:16PM +0000, Qing Zhao wrote:
> > On Aug 22, 2025, at 15:02, Kees Cook <kees@kernel.org> wrote:
> > Right, and sometimes we have to explicitly perform a no-op
> > address-taking to make sure a symbol gets generated:
> > 
> > /*
> > * Force the compiler to emit 'sym' as a symbol, so that we can reference
> > * it from inline assembler. Necessary in case 'sym' could be inlined
> > * otherwise, or eliminated entirely due to lack of references that are
> > * visible to the compiler.
> > */
> > #define ___ADDRESSABLE(sym, __attrs)                                            \
> >        static void * __used __attrs                                            \
> >        __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
> > 
> > #define __ADDRESSABLE(sym) \
> >        ___ADDRESSABLE(sym, __section(".discard.addressable"))
> > 
> > $ git grep KCFI_REFERENCE
> > include/linux/compiler.h:#define KCFI_REFERENCE(sym) __ADDRESSABLE(sym)
> > arch/x86/include/asm/page_64.h:KCFI_REFERENCE(copy_page);
> > arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memset);
> > arch/x86/include/asm/string_64.h:KCFI_REFERENCE(__memmove);
> > arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_prog_runX);
> > arch/x86/kernel/alternative.c:KCFI_REFERENCE(__bpf_callback_fn);
> 
> I am curious on why the compiler eliminates an external routine completely in the file if it's address-taken in that file. 
> Why an additional no-op address-taken is needed here. 

If I am remembering correctly this is needed for rare cases where
a function built without a C definition is being used in Linux's
self-patching "alternatives" code swaps in one function for another,
and is being used indirectly. These cases end up not being visible to
compiler (so no address-taken), but the indirect call site is still
being instrumented. And the above list is the _entire_ list of such
corner cases: all really low-level things.

Peter may remember this better than me...

> > Adding the IPA pass to find all functions worked perfectly. I was able
> > to remove all the weird DECL reconstruction and just use the original
> > FUNCTION_TYPE info for the typeids.
> 
> Nice. So this new IPA pass is invoked even when O0?

It seems like it works at any optimization level, yes.

-- 
Kees Cook
