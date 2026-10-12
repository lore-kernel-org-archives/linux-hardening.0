Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA212470438;
	Mon, 12 Oct 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796985; cv=none; b=G7qBveHVtkW/kefZQyfc0QmSdYhFI8UomH+77G+N6qKZTo/YXSBqaqJFIPnEMolH9lCXd20hnVp1anoaTw+KRDBN6r+kYPntD3ZQ9iLiz9/1NpJwOa0RDQDGf16X/HucRIHrocnVA7+0ADiExEzq5IFfxIyRThnSwf3YKPibtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796985; c=relaxed/simple;
	bh=6FTXd2DEitLhPDgb8LbhKeUv77Bp+DQ3JIx14UFlKvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew7f6k3FB9fmrShWNUV9qIH28I1ydVuQgdT83Px36GLqNtd07l3MA3LR29ujj5bWdVIVsz3ldJ+wJgRXFv6CS0f/XYFz7DnruFHDInvnO926LM+dD3faCtfU5yUkTJvj+5AS1CPMSldngxndSxz6aphTfOZcU+3C99vJVXebCRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QiO5k1O9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QiO5k1O9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ny2z5Q0UEbLxqkH7uXuNhmb5FydGmeg0KcVu18YOelI=; b=QiO5k1O9BuBJCJlOIHdS7NRszW
	/WQGffeU8OMlQMkprhyjt+u4fFMZCAEHXM2RqXY79biJo9bO7vRcH85ofmDxDwQc1QmPv/0Rab+SF
	dsPlmAUiRE5xq30Fb75ZmI2NFe7DpfpTDPzI9vGUmJLtcldHb/2GNFLKT+ZXnWn/HMBkhWcYImuoB
	1aFZq1HdZpmBH19PQfEKqjsnt1MuncjvZKZWU+4z0iIDRE2AptDJkyWB7mWyHEmLWjFQQwvKtP/ha
	s4lVK8bGpAjcta5VOsm1W9f6UC/IXLXgSgpx6qcOQxPSqpAnuSjV4h2SgOvl54KciFyeEnufKZOaX
	GfjyBLBw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGCF9-0000000E6K5-0rfr;
	Mon, 12 Oct 2026 09:22:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 350C2300720; Mon, 12 Oct 2026 11:22:50 +0200 (CEST)
Date: Mon, 12 Oct 2026 11:22:50 +0200
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
Message-ID: <20261012092250.GO4121339@noisy.programming.kicks-ass.net>
References: <20261012090424.i.497-kees@kernel.org>
 <20261012090436.1676525-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012090436.1676525-3-kees@kernel.org>

On Mon, Oct 12, 2026 at 02:04:26AM -0700, Kees Cook wrote:
> With MITIGATION_RETPOLINE=y, GCC lowers the computed goto in
> ___bpf_prog_run() to a jump through __x86_indirect_thunk_rdx. objtool
> puts that jump on the retpoline call list along with the indirect calls,
> so with CONFIG_CFI=y the kCFI check wants a UD2 before it:
> 
>   vmlinux.o: warning: objtool: ___bpf_prog_run+0x1e: no-cfi indirect call!
> 
> The jump goes through the "jumptable" array, which objtool already reads
> from .data.rel.ro.c_jump_table, so its targets stay inside the function
> and need no kCFI check. Skip jump table jumps in the check. Clang does
> not emit this jump: with retpolines, it lowers the computed goto without
> an indirect jump.

I am confused.. I don't see a computed goto in __bpf_prog_run(), and we
build with -fno-jump-tables.


