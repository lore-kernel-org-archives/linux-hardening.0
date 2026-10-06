Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AF456E12;
	Tue,  6 Oct 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295929; cv=none; b=VQxHzkxcbDQvf/0qsZCv0TF8qx9svBVycOsSn1gKr8OnEBXkzIX57kKVxEwLRNrpUXpCb4T+ijJ0WOYSgMYxACpcg/MS6D6c8GSBmkuOd+83jzJ70iDcmDF9+Q/lyIw8UuUWtJtiKpXAEcG+JSUaweDMSEN7aPyiw8/55m0Mk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295929; c=relaxed/simple;
	bh=6btDlvHwBwnl8QJVoMY0bmEA6MybxcPQW3nb9CbBxJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/XjbRehIRay9VtucMS4WjR7s+3F5/NifVrFSEzfdsbPrZ6PkhMQg/kos0hQdR/pUzFnUOnKYxy2DYBh4S2MqwYv8QEd3vSPfQSbmiVcLCb9/JSB09Ii+tfnZkoGP1xG3XTqno/SaeF42JgouAFAsserIQbNJH6BqpUup9ZpRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBfzHk1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBfzHk1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67601F000FF;
	Tue,  6 Oct 2026 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791295927;
	bh=zUsVfvyVtNgk99RyjipDDevgTZGzhtwz6DXLUIWe1a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JBfzHk1FBxuCViejFOyT24cYGpJeOHIzE4MIEH9K1OGLtGcG82viVKe9eGY3wb039
	 Ah7Zanax6gmVKPPaYcC6dYe0v53Wt0zcKDOFc7kfBLTZZXLJsHc1aiNbWVwF76+8F0
	 v9Xe3NY3hZ7hxX9R06KzDsOiwNVkJmqKeK0VOnrBhFil0HT/FPS0GNWzH1NWUvGeke
	 SngQO8ZEwwf82d6mM/l4iZRJN1p29hdWgJR0chSoOPhUeLDNe76dpXM7u1n+YP2qBO
	 WbkMtrsWE4ldGpiyBWiC4XU4W6eobSykslgdV4ggSiBnZBaI+2KuD+5kKI6fFqVstA
	 HBSDEpT9s2x3A==
Date: Tue, 6 Oct 2026 07:12:07 -0700
From: Kees Cook <kees@kernel.org>
To: ardb@kernel.org, nathan@kernel.org, Bill Wendling <morbo@google.com>
Cc: gustavoars@kernel.org, ndesaulniers@google.com, justinstitt@google.com,
	broonie@kernel.org, elver@google.com, alan.maguire@oracle.com,
	namjain@linux.microsoft.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Message-ID: <202610060642.7C4125F@keescook>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261006094358.2948476-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006094358.2948476-1-morbo@google.com>

On Tue, Oct 06, 2026 at 09:43:58AM +0000, Bill Wendling wrote:
> Code that runs outside the kernel proper, such as the EFI stub, gets
> nothing out of the counted_by annotations: the bounds checks they feed
> (FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.
> 
> The annotations can also break the build. A __counted_by_ptr() that
> names a member declared after the pointer needs Clang's
> '-fexperimental-late-parse-attributes', which the top-level Makefile
> adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and does
> not get that flag, so it fails as soon as such a struct is pulled in
> through a common header.

We have a distinction between parsing and output (instrumentation,
linkage, etc). FORTIFY_SOURCE and UBSAN_BOUNDS (and lots of other
things) control output (e.g. fortify alternative linkages, ubsan
instrumentation). We don't normally have parsing issues, as that kind
of thing is usually controlled by compiler flag options (like here). For
example, if a transparent struct ever leaked into a header that libstub
includes, we would explode as well, due to x86's resulting lack of
-fms-extensions.

So, I this should _not_ be managed with a NO_* flag, as that has been
traditionally about suppressing output. I don't think we want to mix
that idiom with parsing issues.

And other architectures solve this problem by not wiping KBUILD_CFLAGS in
the first place. :P So if we want to continue to accept the x86 exception
(which I would argue is the actual problem), we likely need to, instead,
construct an explicit export that is used to collect parsing control
options so that it can be re-included here. Today, I can think of
-fms-extensions besides -fexperimental-late-parse-attributes.

KBUILD_PARSE_CFLAGS += -fms-extensions
...
KBUILD_PARSE_CFLAGS += -fexperimental-late-parse-attributes
...
export KBUILD_PARSE_CFLAGS
KBUILD_CFLAGS += $(KBUILD_PARSE_CFLAGS)
...

We already do something like this for CLANG_FLAGS, which, given
-fexperimental-late-parse-attributes being Clang-specific, perhaps we
ignore my -fms-extensions future-proofing, and just add it there, but
it doesn't look like that is how scripts/Makefile.clang was intended to
be used.

But, again, I think the problem is x86's wipe of the flags. In fact, I
see an explicit problem with that today, which is the loss of
-fauto-trivial-var-init, which all the other arch's stub gain (it's an
output flag, but it happens to neither change linkage nor create hooked
instrumentation). So x86 efi stub lacks stack var zeroing but all the
other archs have it.

Can we just fix x86 correctly to use filter-out, etc, there?

-Kees

-- 
Kees Cook
