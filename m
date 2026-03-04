Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B613321D8;
	Wed,  4 Mar 2026 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626815; cv=none; b=B0YOg87mBsBaFtVEBjHjraHI6NP6gE8L/BhUmeBoI1xo2mB38kcY33tWbDPiMzpUF/cOBMEMpfZsW7wTRx+8I/VECnp/GOurXomPUWHo10t6mmsXqC99XqgKFyvKp8m76sYHBBFigyLeEw6pHKw89zi7mrt4S550NAGfQAH5O/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626815; c=relaxed/simple;
	bh=WnoeAiH2zeYFOAvm4hMpg8jxN72aiERbJc4YfUHDZDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoOl23hFG+KmuSM7wNFqxi+BaClBlniK6g2ihG+4j6lVc1hKm1E2213yS0ytviUr2iOQCZs0XCheZBSh6HGVPPIKEF2TVcYIUw7fJflqPL8eh2XvQahbkvlLfqsB+mWA8vrc04EliWyaz+OcB5hARfRqGD4DmFlE1WqjdU7KMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsaHi6sB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsaHi6sB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C382BC19423;
	Wed,  4 Mar 2026 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772626814;
	bh=WnoeAiH2zeYFOAvm4hMpg8jxN72aiERbJc4YfUHDZDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CsaHi6sBwsPfp+NPjbz2Ilf7H2PfoN78U0IiIBUR7ZEsgvy/StYpQiCXoCbsVjdVh
	 uIajtSgfMOWXoR5kBOMZgxml5ZKxV8s4pVAs1I9rDpqJnu4cYOvuJneB/aLBPwECrH
	 FjWIvg1nw7NqJdX9gDc3RWowg5IRaYCCywN7nBxuZLSbYT7npvOGy713OjEla6wbf1
	 caFy362tRt7y/cuxjfFkh7Ur+qpOjZ54lm7TjUcdH4Km4lTEPbzyTPJSeAa00bBy5h
	 eLhgctkNXLFCEeRs6EgEflzgOR+9ThZEI1kmWEvK/daxZ2qRS5JJb115fYSW+VQ8Eg
	 8TwoXf5+SjXLQ==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vxlD2-0000000BmbB-2bXO;
	Wed, 04 Mar 2026 13:20:12 +0100
Date: Wed, 4 Mar 2026 13:20:11 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kees Cook <kees@kernel.org>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
Message-ID: <20260304132011.1a9567b7@localhost>
In-Reply-To: <352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
	<33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
	<878qcj8pvw.fsf@trenco.lwn.net>
	<352c3f9f8ffd2d031c86a476e532a8ea6ffcf1ed@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Wed, 04 Mar 2026 12:07:45 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Mon, 23 Feb 2026, Jonathan Corbet <corbet@lwn.net> wrote:
> > Jani Nikula <jani.nikula@linux.intel.com> writes:
> >  
> >> There's always the question, if you're putting a lot of effort into
> >> making kernel-doc closer to an actual C parser, why not put all that
> >> effort into using and adapting to, you know, an actual C parser?  
> >
> > Not speaking to the current effort but ... in the past, when I have
> > contemplated this (using, say, tree-sitter), the real problem is that
> > those parsers simply strip out the comments.  Kerneldoc without comments
> > ... doesn't work very well.  If there were a parser without those
> > problems, and which could be made to do the right thing with all of our
> > weird macro usage, it would certainly be worth considering.  
> 
> I think e.g. libclang and its Python bindings can be made to work. The
> main problems with that are passing proper compiler options (because
> it'll need to include stuff to know about types etc. because it is a
> proper parser), preprocessing everything is going to take time, you need
> to invest a bunch into it to know how slow exactly compared to the
> current thing and whether it's prohitive, and it introduces an extra
> dependency.

It is not just that. Assume we're parsing something like this:

	static __always_inline int _raw_read_trylock(rwlock_t *lock)
		__cond_acquires_shared(true, lock);


using a cpp (or libclang). We would need to define/undefine 3 symbols:

	#if defined(WARN_CONTEXT_ANALYSIS) && !defined(__CHECKER__) && !defined(__GENKSYMS__)

(in this particular case, the default is OK, but on others, it may not
be)

This is by far more complex than just writing a logic that would
convert the above into:

	static int _raw_read_trylock(rwlock_t *lock);

which is the current kernel-doc approach.

-

Using a C preprocessor, we might have a very big prototype - and even have
arch-specific defines affecting it, as some includes may be inside 
arch/*/include.

So, we would need a kernel-doc ".config" file with a set of defines
that can be hard to maintain.

> So yeah, there are definitely tradeoffs there. But it's not like this
> constant patching of kernel-doc is exactly burden free either. I don't
> know, is it just me, but I'd like to think as a profession we'd be past
> writing ad hoc C parsers by now.

I'd say that the binding logic and the ".config" kernel-doc defines will
be complex to maintain. Maybe more complex than kernel-doc patching and
a simple C parser, like the one on my test.

> > On Mon, 23 Feb 2026 15:47:00 +0200
> > Jani Nikula <jani.nikula@linux.intel.com> wrote:  
> >> There's always the question, if you're putting a lot of effort into
> >> making kernel-doc closer to an actual C parser, why not put all that
> >> effort into using and adapting to, you know, an actual C parser?  
> >
> > Playing with this idea, it is not that hard to write an actual C
> > parser - or at least a tokenizer.  
> 
> Just for the record, I suggested using an existing parser, not going all
> NIH and writing your own.

I know, but I suspect that a simple tokenizer similar to my example might
do the job without any major impact, but yeah, tests are needed.


-- 
Thanks,
Mauro
