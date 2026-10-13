Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56921384242;
	Tue, 13 Oct 2026 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873853; cv=none; b=J0OQkYsXgxx42b0mcP5TuMjhXlrXmKXeNp8qJSNG5lxe1B2egg5zcO9fV9hk3sLsCpNIXcFMIm10byIqDeV4sy8EI7oKlp2NCAqpAzUegal6yKB9fkQr4u+t8D7dDCZF0yMKZdlQjCceYqiK/yypT/oFT/favDJ5Q0jzduDJ6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873853; c=relaxed/simple;
	bh=vrSavS8p7pUR78E2HEuhtydxzFGUu7iY/A0/B0lAOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCQGD/o+mJcCSzTCY0LcT9ffMOwqvuU6SvRKwr6n8PYVwy/30eF0tt0kbC7Vo1pNwIC/MmCXP+UXW94qyV+v3f8nE5bDasutW/ecdWTFrmTwmt5BUEoKLRNsaBJoLv1BLsMryRSfqjWJJcwMmLBoqdEkBcKZO+I6BWynV8m+NPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IfgQKdEf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfgQKdEf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+4sQpvtGl8rbG3DbVItMctIXcxgPZJH09YxXRKbkwvU=; b=IfgQKdEfl9R7LR8+vnN3pB1F1G
	mJBfAzdHrzDOBqzOc7XL+xnjQTnRqGY1GA7ewTFPklo9jrywi89bXQMH7KQTEbRY3ONWeRotV+4BN
	h18kM73ewhIQaHjVog2bCvFmPTRQ2xIhqtSBl0LPPLSdEV/Awba7SbAjVGAdFvbNnNIwz1kIOzaBO
	2W9GO3EZXWbWId9xeRan9ezzNSy3q8DLkFlBzLUrYxfQG652QThr3K540FTV37fTLnG28ZvWoJEX/
	9Ha0FJ6r4iVfl9KlR1yjymvLrZj3WUK5YycBNlg1ichGZCSx6YQ1NhBg3+tF+YPkpV33yM9pUvuAC
	zFlfSWlQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGWF4-0000000Bobs-3VoA;
	Tue, 13 Oct 2026 06:44:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 068F930045A; Tue, 13 Oct 2026 08:44:06 +0200 (CEST)
Date: Tue, 13 Oct 2026 08:44:05 +0200
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
Message-ID: <20261013064405.GY2009045@noisy.programming.kicks-ass.net>
References: <20261012090424.i.497-kees@kernel.org>
 <20261012090436.1676525-3-kees@kernel.org>
 <20261012092250.GO4121339@noisy.programming.kicks-ass.net>
 <20261012183925.ca026d-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012183925.ca026d-kees@kernel.org>

On Mon, Oct 12, 2026 at 11:41:03AM -0700, Kees Cook wrote:
> On Mon, Oct 12, 2026 at 11:22:50AM +0200, Peter Zijlstra wrote:
> > I am confused.. I don't see a computed goto in __bpf_prog_run(), and we
> > build with -fno-jump-tables.
> 
> It's the interpreter, ___bpf_prog_run() (three underscores) in

Durr, clearly I wasn't wearing my glasses or something.

> kernel/bpf/core.c, not the __bpf_prog_run() wrapper in filter.h:
> 
> 	static const void * const jumptable[256] __annotate_jump_table = {
> 		[0 ... 255] = &&default_label,
> 		...
> 	};
> 	...
> 	select_insn:
> 		goto *jumptable[insn->code];
> 
> So it's a manually constructed jump table, not the "normal"
> table-from-switch stuff that -fno-jump-tables suppresses (though see
> below about Clang). objtool already knows about it, with annotations
> added back in 2019 in commit e55a73251da33 ("bpf: Fix ORC unwinding in
> non-JIT BPF code").
> 
> With retpolines, GCC emits a single dispatch that every handler uses:
> 
> 	movzbl (%rbx),%esi
> 	movzbl %sil,%edx
> 	mov    jumptable(,%rdx,8),%rdx
> 	jmp    __x86_indirect_thunk_rdx
> 
> Clang never has this jump: with retpolines, LLVM's IndirectBrExpand pass
> turns the label addresses into indexes and the "goto *" into a switch,
> which Clang's -fno-jump-tables then makes a compare tree. So it's only
> constructed this way under GCC, but since now we can turn on kCFI with
> GCC, the objtool warning about indirects without kcfi protection trips.

OK, then the next question; do we *want* to allow a 'naked' indirect
branch to survive?

We can simply disable the whole interpreter when kcfi=y. Isn't that
thing recommended disabled anyway?
