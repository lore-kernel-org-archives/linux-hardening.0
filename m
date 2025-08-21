Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803D221FBE
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768588; cv=none; b=By5et6kjJyXd7DbGMw7pUe6zTaZts1eQ/VWjwLPJb7QML6OC6XgfffE99Xh4vw0OupCWSOG8PNL2UmqxleZvwLWnQFsPpCGIARXYG7hgn5NGfqHSM7HiemPn0HfVo6aOjBTlWQQ2yXuzgHc3a7jOwmUvY9WBaWI3Wfi+f8Bfcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768588; c=relaxed/simple;
	bh=HZQcfNKR44LzFd6BFbU7OFv67sok8ni2NuQX8nqlI3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFijMZwh7mbkS5fYBiYP0KRho92YhrMOEdHBVIoUb/BC26YBVLnNFmqr0wUMh4obaJJ1BIkzp9g9qzfCJm9fmgjFGEpxCs4sE3BCE6JreBOuIfmZLpQuhjpdDcp5oW+2zl2SpG7hUQIAqgmfxAD9tQWvai+bMEZh0jl1pVbG7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BebQCHkq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BebQCHkq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vguXMGfgo/L8HMIOpqumu17oopMnwxh8bCSLFNilBm0=; b=BebQCHkqGXgCHcgNC44xU7x52T
	4sOewBAS3lSYT8qe9EnxinpSq1u4OoKJUr+39Ibo28yaFBrLRFyj8ZEZDDCZyY/TPs4gMqWZ+c64r
	e1wOuzMWOuBUi4Zd4txHKyN0Yir4TYadUo35/5kfwyXMqwp/lKPzWqPob78ukud4/stV5CNn1wuGU
	f8JgoVUSWPWq2+Ql4IXjyNKzMLCQdPu8tB6W7ACMiuu39g55upN/5i710eVhCUPb56FNjbWOjQI2n
	TCKiVtsgXdAzOCwgQ0BXEidZ7yj2hHmHoYvuN6vrJpt+PICdSSz2TqwOd+as/I1Ko/By+Bd7flis8
	m+2xzQ+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up1c0-00000000VpA-2UhV;
	Thu, 21 Aug 2025 09:29:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A22403002ED; Thu, 21 Aug 2025 11:29:35 +0200 (CEST)
Date: Thu, 21 Aug 2025 11:29:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
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
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <20250821092935.GN4067720@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821072708.3109244-4-kees@kernel.org>

On Thu, Aug 21, 2025 at 12:26:37AM -0700, Kees Cook wrote:
> Implement x86_64-specific KCFI backend:
> 
> - Function preamble generation with type IDs positioned at -(4+prefix_nops)
>   offset from function entry point.
> 
> - 16-byte alignment of KCFI preambles using calculated prefix NOPs:
>   aligned(prefix_nops + 5, 16) to maintain cache lines.
> 
> - Type-id hash avoids generating ENDBR instruction in type IDs
>   (0xfa1e0ff3/0xfb1e0ff3 are incremented by 1 to prevent execution).
> 
> - On-demand scratch register allocation strategy (r11 as needed).
>   The clobbers are available both early and late.
> 
> - Atomic bundled KCFI check + call/branch sequences using UNSPECV_KCFI
>   to prevent optimizer separation and maintain security properties.
> 
> - Uses the .kcfi_traps section for debugger/runtime metadata.
> 
> Assembly Code Pattern layout required by Linux kernel:
>   movl $inverse_type_id, %r10d  ; Load expected type (0 - hash)
>   addl offset(%target), %r10d   ; Add stored type ID from preamble
>   je .Lpass                     ; Branch if types match (sum == 0)
>   .Ltrap: ud2                   ; Undefined instruction trap on mismatch
>   .Lpass: call/jmp *%target     ; Execute validated indirect transfer
> 
> The initialization of the kcfi callbacks in ix86_option_override()
> seems like a hack. I couldn't find a better place to do this.
> 
> Build and run tested on x86_64 Linux kernel with various CPU errata
> handling alternatives and FineIBT.

I'm a little confused, does this force r11 to be the indirect call
register like clang does? The code seems to suggest it is possible it
uses another register.

The current kernel FineIBT code hard assumes r11 for now.
