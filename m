Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A964D956D;
	Mon, 12 Oct 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830465; cv=none; b=p3x+dZNIcvkOrPvnt0lsDl/9pxFhBR5gO9/YpgZOqzLBokdNPgM+J7lJMPcrE1rjGstOdq3hnKPd9rm9LDdQa59lorKsDyirtRDv7o+MMNpKQyxx80chuzQDnA9ntIAAqcRo/XC+mFmdpq0sOVbK4dSfreYFg2OC5NeT0fy8pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830465; c=relaxed/simple;
	bh=2RYhboUm294LPHQVALh9L0eDB51UX/1aKGwNysxu+R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlaKZFWbtcgFip8muwZDA8d9nAhUNwwZlzpY/YNRzgmfFGGqDOk2CnVkKv/uR6mKAFyVqHf/eFDXAeUHRF/nMbJ6Jj21v2Uc/MH4loEni5skCl7F+dSZtVsEO7CIuMRZOMbnreISywAnpbnwad+6UFGHf0r4tcrglaarPIoWBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrBZQGyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrBZQGyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CAA1F0089B;
	Mon, 12 Oct 2026 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830463;
	bh=4TdtsTHdQ41W4OUZCv5jF0QWzU8uLyAJ8WWWW/d1wkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TrBZQGyzdNz1wh7v9M+LQDrDEs9hXGL+bsP+UEGwwJ6lVYwOKEaJlgg6QG7Wzrcjl
	 TA+Mn/YJarxFxJ1hqraPMH9GkK6veZUKAfKJraXwrODq6r80BCWdXJE+SPM+mZUD7L
	 INLjdud2Cj8nXhB9+0dvotOuoL+X264H/3ke9iAQSQgKaH4rYExs9K01ehsnPdXsQU
	 vDvsr53/ja16Ouo+mhK395MCF79WnfxKL6SO4G+m38meozxCYWpQdrscEvwTS9eOYh
	 TqXwzBqnW8cdnDmahjzHzn7ZAQct57PKhOTfNfRRRvBYVYn60cWeXFM73RSXpEbJJK
	 FKpE4oaKz1y6w==
Date: Mon, 12 Oct 2026 11:41:03 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool: Skip jump table jumps in the kCFI indirect
 call check
Message-ID: <20261012183925.ca026d-kees@kernel.org>
References: <20261012090424.i.497-kees@kernel.org>
 <20261012090436.1676525-3-kees@kernel.org>
 <20261012092250.GO4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012092250.GO4121339@noisy.programming.kicks-ass.net>

On Mon, Oct 12, 2026 at 11:22:50AM +0200, Peter Zijlstra wrote:
> I am confused.. I don't see a computed goto in __bpf_prog_run(), and we
> build with -fno-jump-tables.

It's the interpreter, ___bpf_prog_run() (three underscores) in
kernel/bpf/core.c, not the __bpf_prog_run() wrapper in filter.h:

	static const void * const jumptable[256] __annotate_jump_table = {
		[0 ... 255] = &&default_label,
		...
	};
	...
	select_insn:
		goto *jumptable[insn->code];

So it's a manually constructed jump table, not the "normal"
table-from-switch stuff that -fno-jump-tables suppresses (though see
below about Clang). objtool already knows about it, with annotations
added back in 2019 in commit e55a73251da33 ("bpf: Fix ORC unwinding in
non-JIT BPF code").

With retpolines, GCC emits a single dispatch that every handler uses:

	movzbl (%rbx),%esi
	movzbl %sil,%edx
	mov    jumptable(,%rdx,8),%rdx
	jmp    __x86_indirect_thunk_rdx

Clang never has this jump: with retpolines, LLVM's IndirectBrExpand pass
turns the label addresses into indexes and the "goto *" into a switch,
which Clang's -fno-jump-tables then makes a compare tree. So it's only
constructed this way under GCC, but since now we can turn on kCFI with
GCC, the objtool warning about indirects without kcfi protection trips.

-- 
Kees Cook
