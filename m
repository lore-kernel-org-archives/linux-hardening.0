Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C4D3CF21E;
	Tue, 13 Oct 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882724; cv=none; b=bdwKI5IlkdjCsLFJxFOloczABOFtgWq/Mm0ZM5NCCd4K7w7nGGmRJhwyiP9aAA60vvvHC0eDcWE+aickc/gWKjFxza1fJBTH9apoAoPuysdQKsSPbCC4MvD1lYAvraU+R43ia+Tgaxgxlz/3ioL0tMmUEsVJGhmsHDMK6BjKM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882724; c=relaxed/simple;
	bh=FoXXCh3Ly68j7HlWZIqI8eY6/xQ/lJuU86V5bU3LoiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZGMtVKN4g5mcT6/Lp0tUBkPOuAlWu42uG4KvlASdK31is8dvparqdOdq6oM9HxgEiYbMxPz0jNYvKpEephYkGUkBZJ21qLtQh9m3bRFpZe6FwXOccVlGGsWoG/1mlxf50nPFEAM6wus6/ONfd72ch9NkYkiybj4nLyRkEzxXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dfoF+48a; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dfoF+48a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zs3ej6PfR6qiUCZQ3kfH9WcDU/sY4iZRDWHRn8Kxmyg=; b=dfoF+48aWvT3iTt1F6ZbR3CNbN
	CRhLtl8H3Qie3dEOUShw9uFc7/Z2ZOLj687i+CPRdR4qsZIcjPsFeO2JInpx1YHcQgbDayqSnaGEn
	YwmNEhfth1HAqEjwG/+NwIaQmSPrUY8veNqAqjgAcg8fhjpTkKaaTjoPBi/5aFle02fg4BfP0Wa8T
	NGDtIn6j7Ou9mmGsXVsDS2QYw2NaAQSxHHB7ApkxB8Lj+RhggXQu5+kJtdVhxTBIz748TVzatQOlg
	PztWYUVnXNXQZs3McQIkfPSXVNI7hJkD0UWaUO6gyH1/H8Z68mSFwJg0RHlKasA5c1WC58i7CMWLU
	XUJDJ4oQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGYYC-0000000CRoQ-1EBm;
	Tue, 13 Oct 2026 09:12:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D83E330015F; Tue, 13 Oct 2026 11:11:59 +0200 (CEST)
Date: Tue, 13 Oct 2026 11:11:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool: Skip jump table jumps in the kCFI indirect
 call check
Message-ID: <20261013091159.GM4121620@noisy.programming.kicks-ass.net>
References: <20261012090424.i.497-kees@kernel.org>
 <20261012090436.1676525-3-kees@kernel.org>
 <20261012092250.GO4121339@noisy.programming.kicks-ass.net>
 <20261012183925.ca026d-kees@kernel.org>
 <20261013064405.GY2009045@noisy.programming.kicks-ass.net>
 <202610130126.E24D003C0@keescook>
 <20261013090613.GE2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013090613.GE2009045@noisy.programming.kicks-ass.net>

On Tue, Oct 13, 2026 at 11:06:14AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 13, 2026 at 01:37:03AM -0700, Kees Cook wrote:
> > On Tue, Oct 13, 2026 at 08:44:05AM +0200, Peter Zijlstra wrote:
> > > On Mon, Oct 12, 2026 at 11:41:03AM -0700, Kees Cook wrote:
> > > > Clang never has this jump: with retpolines, LLVM's IndirectBrExpand pass
> > > > turns the label addresses into indexes and the "goto *" into a switch,
> > > > which Clang's -fno-jump-tables then makes a compare tree. So it's only
> > > > constructed this way under GCC, but since now we can turn on kCFI with
> > > > GCC, the objtool warning about indirects without kcfi protection trips.
> > > 
> > > OK, then the next question; do we *want* to allow a 'naked' indirect
> > > branch to survive?
> > 
> > I originally struggled about this. I'd really rather that GCC not codgen
> > like this at all. On the other hand, it's a bounded load and jump through
> > an .rodata table, so that's kind of a manual CFI. :P (And if it gets
> > targeted via ROP, it doesn't matter: everything is a target then.)
> 
> With IBT enabled, I would image GCC will also spray ENDBR around like
> there is no tomorrow :/

And that would in turn cause more problems for FineIBT evasion, since
that more or less depends on ENDBR being followed by the hash check.

With FRED we got rid of the 'naked' ENDBR instances on entry, but now we
get them here :-(
