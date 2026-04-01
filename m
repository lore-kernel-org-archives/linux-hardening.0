Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2A2D0C82
	for <linux-hardening@vger.kernel.org>; Wed,  1 Apr 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053931; cv=none; b=nPhw1xQxCJ6s9UrkAikXoMhvVOzQHH/Cqf3bHRfYW71bZhzY/TnDNDd58l/wjVopIcK64kf4NYYFLY+udnVX+0WaV2a25A+wKkVt6cJiTuKgL7L0yGwrkyH7IC6soFOG4/FQUAZPOKyYzeGUZia0Z0n/ziaCVclGLaQ/Rhu6+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053931; c=relaxed/simple;
	bh=Q5Skf/Q0cN2o/FcGvISUP7ojEcZPEcIVT4XxZbbG56U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv4NWmZvLuxqNRHOnV9KOXM6+Wktc2sAgBBl6qPP4VWg03WcK3owW4daHbkanN5CZzIABlh6EMSitgJbqds7nyiNTNuO1RhuK7dzL2HOYtOqGGTDojkI89BT+Y/38sEzrLDlGM3jcxZDmoJNKmkW0k42hfmMXux+tFJ3VQrCIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ocjoGJEI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ocjoGJEI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45B7931DB;
	Wed,  1 Apr 2026 07:32:02 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575E33F641;
	Wed,  1 Apr 2026 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775053927; bh=Q5Skf/Q0cN2o/FcGvISUP7ojEcZPEcIVT4XxZbbG56U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocjoGJEIuL/I405PfYBiKYb3mKbyYL+3xOsmXuBWe0APxYaSuqgvVZoVmazTed82h
	 BV4doXjYNU9Ujd1jqab/F4/Xg9rCDNWb1SnLoJde/jRnIwzo/7NSKNPEBTlreoPo9x
	 BZA/EdfxOqa48ogaOFhzyRSJ335fUzjHABgnuyWA=
Date: Wed, 1 Apr 2026 15:31:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb+git@google.com>, kernel-team@android.com,
	linux-hardening@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Carlos Llamas <cmllamas@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH v8] arm64: Use static call trampolines when kCFI is
 enabled
Message-ID: <ac0sX46TwAQAChWG@arm.com>
References: <20260331110422.301901-2-ardb+git@google.com>
 <177503506493.2514486.12265333685036392947.b4-ty@kernel.org>
 <2b0b9c69-650c-46bb-8579-4af85c17b8ab@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b0b9c69-650c-46bb-8579-4af85c17b8ab@app.fastmail.com>

On Wed, Apr 01, 2026 at 02:03:22PM +0200, Ard Biesheuvel wrote:
> 
> On Wed, 1 Apr 2026, at 12:03, Will Deacon wrote:
> > On Tue, 31 Mar 2026 13:04:23 +0200, Ard Biesheuvel wrote:
> >> Implement arm64 support for the 'unoptimized' static call variety, which
> >> routes all calls through a trampoline that performs a tail call to the
> >> chosen function, and wire it up for use when kCFI is enabled. This works
> >> around an issue with kCFI and generic static calls, where the prototypes
> >> of default handlers such as __static_call_nop() and __static_call_ret0()
> >> don't match the expected prototype of the call site, resulting in kCFI
> >> false positives [0].
> >> 
> >> [...]
> >
> > Applied to arm64 (for-next/fixes), thanks!
> >
> > [1/1] arm64: Use static call trampolines when kCFI is enabled
> >       https://git.kernel.org/arm64/c/e70c2335f889
> >
> 
> Thanks,
> 
> I just spotted that the function name gets stringified twice inadvertently.
> 
> E.g., the assembler may see
> 
> .quad "__static_call_return0"
> 
> rather than the intended
> 
> .quad __static_call_return0
> 
> The assembler does not seem to care, and still emits an ABS64 relocation against the correct symbol, but it is definitely unintentional.
> 
> I can send a follow-up fix if you prefer, or you could just tweak the patch in place:
> 
> --- a/arch/arm64/include/asm/static_call.h
> +++ b/arch/arm64/include/asm/static_call.h
> @@ -16,7 +16,7 @@
>             "   .popsection                                     \n" \
>             "   .pushsection .rodata, \"a\"                     \n" \
>             "   .align  3                                       \n" \
> -           "1: .quad   " #target "                             \n" \
> +           "1: .quad   " target "                              \n" \
>             "   .popsection                                     \n")

Not sure Will is going to look at this until next week. I folded it into
the arm64 for-next/fixes branch and pushed out.

-- 
Catalin
