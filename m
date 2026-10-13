Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C83B6C18;
	Tue, 13 Oct 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882391; cv=none; b=JnrcikYekFrI/4EEZDn3nTCsbxjvbNgv2ioF5pNRbhXOH7CQwFq+5rlknpPhXanu65wGEncS0qXI0ZC043ZSt/s6k1qWdX1bTr3wkNkLi2ONUKCpHjEZ2j2jn9oRvDuIsn+pcqg4AsSDaCcdMaya49aIum/4Vy4p+YNpUV+vhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882391; c=relaxed/simple;
	bh=4Gxx4JGIrNNVz11HTGtu39ngIiUWuqI6YvBtR7RUyM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNaaXqLyRMNo666l071nAWU7cXUiR3IXRTjaxSD8NEnReK/1TpM2uaxQ/ilYnvCvYQvaBh9ZEaHiyAlgp9oAmnIAAjAU9HDdo/9Tqc+VqSwTNs7G1jAFQHVoYOPxIRhB9q81IGw7+302TgXZztu+jOBxrsSUYhRie7hlOAB5wXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nqA7w4U0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nqA7w4U0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7zrAEGktIYh9nAiw6rmWA3rpgrSvWIioqu8bDZprKTA=; b=nqA7w4U0pDf4wPTzOpQ/ePiPKa
	cLK0UHIVXuL5AzAbotlZg7lEyEgRVjicONM32uMXHN9z3dabglCnlLKCe6iI9R/bSTsb8q9HwbGAq
	1kyJZ4s9oNkWtsr65rIlXGbFL8HSjykL6S3GNtK/GP82s7ZGSvlOnJioLPHQUi/Djnv7hsWEfEG9G
	c6gHUcJMonJKBUVk+EUhOZSJZApngwba5UOhcGe3v08SNWrHRSvoyyfTy74OW6CTf2MShK10hgesj
	iro62oMvZ86dOahNsxWbqWpCWszUxOj33KdtdgdET9tvfGLvxhTH7Y09alZqYodlioxWa3W+IryMI
	G7hiTImQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGYSc-0000000FJs9-3MPK;
	Tue, 13 Oct 2026 09:06:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0850C30063F; Tue, 13 Oct 2026 11:06:14 +0200 (CEST)
Date: Tue, 13 Oct 2026 11:06:13 +0200
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
Message-ID: <20261013090613.GE2009045@noisy.programming.kicks-ass.net>
References: <20261012090424.i.497-kees@kernel.org>
 <20261012090436.1676525-3-kees@kernel.org>
 <20261012092250.GO4121339@noisy.programming.kicks-ass.net>
 <20261012183925.ca026d-kees@kernel.org>
 <20261013064405.GY2009045@noisy.programming.kicks-ass.net>
 <202610130126.E24D003C0@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202610130126.E24D003C0@keescook>

On Tue, Oct 13, 2026 at 01:37:03AM -0700, Kees Cook wrote:
> On Tue, Oct 13, 2026 at 08:44:05AM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 12, 2026 at 11:41:03AM -0700, Kees Cook wrote:
> > > Clang never has this jump: with retpolines, LLVM's IndirectBrExpand pass
> > > turns the label addresses into indexes and the "goto *" into a switch,
> > > which Clang's -fno-jump-tables then makes a compare tree. So it's only
> > > constructed this way under GCC, but since now we can turn on kCFI with
> > > GCC, the objtool warning about indirects without kcfi protection trips.
> > 
> > OK, then the next question; do we *want* to allow a 'naked' indirect
> > branch to survive?
> 
> I originally struggled about this. I'd really rather that GCC not codgen
> like this at all. On the other hand, it's a bounded load and jump through
> an .rodata table, so that's kind of a manual CFI. :P (And if it gets
> targeted via ROP, it doesn't matter: everything is a target then.)

With IBT enabled, I would image GCC will also spray ENDBR around like
there is no tomorrow :/

> > We can simply disable the whole interpreter when kcfi=y. Isn't that
> > thing recommended disabled anyway?
> 
> I don't think that's realistic, as every GCC-building distro will (I
> hope) enable KCFI as soon as it's in GCC. It's present with
> CONFIG_BPF_JIT_ALWAYS_ON=y, and only Debian has it off:
> 
>   │ Debian sid and trixie                      │ not set
>   │ Ubuntu noble                               │ y
>   │ Fedora, CentOS Stream 9 and 10             │ y
>   │ Arch                                       │ y
>   │ openSUSE Tumbleweed, SLE15-SP7             │ y
>   │ Alpine (lts and virt)                      │ y
>   │ Android GKI android16-6.12 (arm64 and x86) │ y
> 

What an unfortunate situation this is :(

But I don't have a better suggestion. Your patch it is then.
