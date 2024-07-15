Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C491CAA1;
	Mon, 15 Jul 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062917; cv=none; b=jCbP+qNtP21E06rmufGzB4nP1Gxt5/L12Xg6MXslFeYwpon4YVLlIZ1kE4LwowwqL0MDIKadLNdVc8HgPG049QafSx+QgNJGoign0G6/Wuto7Jj8aZyrAXkcWzwM5i4UpUynCm/dsGCxqhCg83TxZzVzR+Dlb1P9+PemfuwhP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062917; c=relaxed/simple;
	bh=YfAErmDFuTuGgAAA5BBqIA3z3wpqh2qk+SRl1hShE0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1LMSwk9u0Okgcw6BDtJRS9OUzROiQrv0tt+NjYxoJd3M1EOZJb+bwFlNPrZhQaWdl3nM2hHmOlcPDcgjH7kQr4B9Gc21eBpH/BR/cqfWHswqSs5ehDqk74sY9+mvYR20QMhwFSp1ywZ0OklhM4kwU//672j/g7/tSEp4pWHB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA/D+vVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA/D+vVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA72C4AF0D;
	Mon, 15 Jul 2024 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721062917;
	bh=YfAErmDFuTuGgAAA5BBqIA3z3wpqh2qk+SRl1hShE0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FA/D+vVDeqwU92wURKsxE+FPSR5D+TT7bVdiQ5atMRceoq5JbhYljtitkxQc3woGY
	 raxOHm/+gNqdUw1O9mFfAPKZoO73t4WWlLQIS2GC5rDZjHoB0rNUdn0rzIO2N0xs5U
	 dm3ae8h9Az5KxPoC0k3Y9oJRDlzDT6VfStZYBnefRXr5+GiGj9r62d5nEO7J3wO4iF
	 fG9REMg1s9bmwea3WJZU4dGAd5TOVBEx8sLFOJWLYVWdGc7ALwYLH9GjbP7/YJZCP8
	 4ZoM6PtkTHlRFaWD43T+Apg9z9ldBEAsIiP0IRaIKphJaX4ghUJFnDqGlwdRAO3hKh
	 rEn6Hlu5AAI3A==
Date: Mon, 15 Jul 2024 10:01:56 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/syscall: Avoid memcpy() for ia32
 syscall_get_arguments()
Message-ID: <202407150947.92A48C959@keescook>
References: <20240708202202.work.477-kees@kernel.org>
 <20240711214450.GG27299@noisy.programming.kicks-ass.net>
 <202407111500.B86485B3@keescook>
 <20240712090008.GA19796@noisy.programming.kicks-ass.net>
 <202407121008.EDAD65A33@keescook>
 <20240715083713.GX27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715083713.GX27299@noisy.programming.kicks-ass.net>

On Mon, Jul 15, 2024 at 10:37:13AM +0200, Peter Zijlstra wrote:
> Yeah, arguing a committee is mostly a waste of time, also, they
> typically listen a lot more when you say, here these two compilers have
> implemented it and this Linux thing uses it.

Precisely.

> So yeah, language extensions are it.

The one I may try to point out to the committee is flexible arrays in
unions. "array[1]" and "array[0]" are allowed in unions, but "array[]"
wasn't. This totally wrecks attempts to modernize a codebase that
depends on such union uses. We worked around it but finally got the
language extension, er, extended, recently:

https://github.com/llvm/llvm-project/commit/14ba782a87e16e9e15460a51f50e67e2744c26d9
https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=adb1c8a0f167c3a1f7593d75f5a10eb07a5d741a

> Yeah, not just Linux I imagine. The rules are so insane it's near
> useless. I'd say press onwards with the language extension, it's not
> like Linux kernel is written in ANSI/ISO C anyway :-)

Yup. Between the above flex arrays in unions fix and -fstrict-flex-arrays=3,
a C codebase can actually get unambiguous array bounds handling. And now
with the "counted_by" attribute, we can cover _dynamic_ arrays too.

> > struct_group() helper. It's internally ugly, but it works.
> 
> That macro is fairly trivial, nowhere near as ugly as struct_size() :-)
> But urgh... can't we do something like:
> 
> void *memcpy_off(void *dst, const void *src, size_t off, size_t n)
> {
> 	memcpu(dst, src+off, n);
> 	return dst;
> }
> 
> And then you can write:
> 
>   memcpy_off(args, regs, offsetof(*regs, bx), 6);
> 
> I mean, that sucks, but possilby less than struct_group() does.
> 
> [ also, we should probably do:
>   #defime offsetof(t, m) __builtin_offsetof(typeof(t), m) ]

Yeah, that would be possible, but I wanted something that the compiler
could reason about for a given identifier since it's not just fortify
that cares about object bounds. Being able to declare the layouts so
that the bounds sanitizer instrumentation wouldn't get confused was
important too. That is more related to arrays than integral members, but
separating those quickly became confusing to declare easily/correctly. So
struct_group() ended up being the best direction in the general case.

> In this case I would just make all of pt_regs a union with one giant
> array (much like some archs already have IIRC).

Yup, that works too. (Though pt_regs is relatively unique in this "the
whole thing is expected to be an array" characteristic.)

-Kees

-- 
Kees Cook
