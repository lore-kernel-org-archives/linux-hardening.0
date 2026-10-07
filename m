Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40D3B42F3;
	Wed,  7 Oct 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364331; cv=none; b=m70RQEdJ8hD7iG58AUFY/YSnICAAVZKe9naajU67/d/+upUT+vijWFuFHyBm9uYCN+E00s5rQTH/SMqzJpKnsFfQtRq5adqqae8V93IFQsYRYHeO2uYoTsJ4dcWXOoAS7u+HrdcMdqdojG/uvg+QLV8DMMMDTRYnk0fi3EVcEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364331; c=relaxed/simple;
	bh=kiWfl8OENVcd4gQBI4pgBcEkDd8w7016Ituxq5+KTMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgDcbDoRAqjEjR3KAYjPGRzr5SgxDAlRvE29TsXkXrALs3cUr43V2PV8NOg8vgsTSD9JVPhFOGsvqwZ5BoEH35Qgf+HmmwOCGuXxOa3A+GEnPIfIQxzop4UywXcA3OC3m7YSupomzyrLYIr4j4Z9ooeBTdtoF+Qiyk13Ba2U6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkgL7qS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkgL7qS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBFB1F0089B;
	Wed,  7 Oct 2026 09:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791364160;
	bh=+0/GxN+SJmNpTy0NcfKiFa1AWYN1FPv3LWFb7/xzuoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NkgL7qS7hgZKdTDgmZcoPak61nO7l2gMYYLFmBcd2EApfgb9Eutc+XLtw5cB4Q4iZ
	 2oE3SPZcZ/owog+JQx3sopwSPIW7eVZHab0Kdeh8zjMBQirNPkkWMuMctzWUHqxdXH
	 mM0xxEczC8qqllzjoy20SjGDJFkJXYYix+3ZlrZozD6ZuoDtNTHvlY975/m6vITcKt
	 OOb95xZJLMw0EvET2/UNPhIWfFhGVkdXpeEEQmXcXODKieV9D1hjZU7prGF/kJMI1A
	 Rxr171lIhi8MCF9OadsAb/EpBRZ3mlW667hRyqH1W5p5y+IC6CTPZWi7t/xegweOuj
	 pkcSS+e5ZUCyw==
Date: Wed, 7 Oct 2026 11:09:15 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: ardb@kernel.org, Bill Wendling <morbo@google.com>,
	gustavoars@kernel.org, ndesaulniers@google.com,
	justinstitt@google.com, broonie@kernel.org, elver@google.com,
	alan.maguire@oracle.com, namjain@linux.microsoft.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Message-ID: <20261007090915.GA1504630@ax162>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261006094358.2948476-1-morbo@google.com>
 <202610060642.7C4125F@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610060642.7C4125F@keescook>

On Tue, Oct 06, 2026 at 07:12:07AM -0700, Kees Cook wrote:
> And other architectures solve this problem by not wiping KBUILD_CFLAGS in
> the first place. :P So if we want to continue to accept the x86 exception
> (which I would argue is the actual problem), we likely need to, instead,
> construct an explicit export that is used to collect parsing control
> options so that it can be re-included here. Today, I can think of
> -fms-extensions besides -fexperimental-late-parse-attributes.
> 
> KBUILD_PARSE_CFLAGS += -fms-extensions
> ...
> KBUILD_PARSE_CFLAGS += -fexperimental-late-parse-attributes
> ...
> export KBUILD_PARSE_CFLAGS
> KBUILD_CFLAGS += $(KBUILD_PARSE_CFLAGS)
> ...
> 
> We already do something like this for CLANG_FLAGS, which, given
> -fexperimental-late-parse-attributes being Clang-specific, perhaps we
> ignore my -fms-extensions future-proofing, and just add it there, but
> it doesn't look like that is how scripts/Makefile.clang was intended to
> be used.

I agree that fixing the x86 efistub to mirror other architectures is the
right fix for this particular instance of the problem (as you note this
is not the first time this has bitten us). However, we may want to
consider adding '-fexperimental-late-parse-attributes' to
CC_FLAGS_DIALECT as well so that the many other places in the kernel
that blow away KBUILD_CFLAGS won't have similar problems if
__counted_by_ptr happens to be used there, as this type of solution
might not always be possible. We could rename it to CC_FLAGS_PARSE or
something like that but I am not sure it is strictly necessary.

-- 
Cheers,
Nathan
