Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B401500941;
	Sat, 17 Jan 2026 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768676735; cv=none; b=WOdFSU/YbglxjbFREU5bt/vWa2LgSiyPnsADytmDrdIj1Hw6Axce3p8+1l8TRatHZk1RMhUMMxGg2lWLdEH4nP+421+RQ1YCv3dJTJUxhyBWoA9N6WEUpbv+5puEVLcTSbN8jwGcWvbfml1zFBv2fYUgp5+aNFHON5oLGMBDIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768676735; c=relaxed/simple;
	bh=u2oQpRiPHEki8iP9y2F1R/JfNWuAsPeS+Q3Lox8Ea3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng2HPseTJlUHdhpY6N3D4k2b4MlRi6P8FE7ukhxDaxQWB7hR7tabuVh5sfXyIwzFno8ZScZpt7Y7M7AawiNHzZO7b1W3zXxEadHAgJU/YkhFC+//GQgswOjeubGiEvZV9DPnNCk9vkkZduRXyFaBN3aupSrO2WxXUe17ob3O4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEUhepmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEUhepmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD58C4CEF7;
	Sat, 17 Jan 2026 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768676734;
	bh=u2oQpRiPHEki8iP9y2F1R/JfNWuAsPeS+Q3Lox8Ea3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEUhepmjD0cibOTd0zcpMB5ykLWH8ND5reejHYYCjeWnItCLPjB0YuFYRjzBaYt9Q
	 DFJNM4TIGpLcL7eNxo/FiXbK4zUfQfJYlURSs/SWJN7CudsSGthhwtNGhzM3OVTFKS
	 YLOhnnq/FvLIRdK9ro/dYf0GfBaHwuH7CpWingxro7g60FaOfjgWXQyG9hk9pXS2gP
	 YXYob5Lkd1/TSgqnrKwFCFusgDf6T/p5/crvmWQW6o0iuspBhheTrhG+FJR/PxTY5K
	 XdCSYGl26ij8j2RoxKvllFFAaSTDcguPx/zl99t6LQi5ohwMhVXLqBd0zG8Iz2Fjy7
	 YXdDe9CaSohTg==
Date: Sat, 17 Jan 2026 11:05:34 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	Qing Zhao <qing.zhao@oracle.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	Jan Hendrik Farr <kernel@jfarr.cc>
Subject: Re: [PATCH v2 1/2] Compiler Attributes: Add __counted_by_ptr macro
Message-ID: <202601171103.EF310A7@keescook>
References: <20251121193957.1655580-2-morbo@google.com>
 <20251121195504.1661783-1-morbo@google.com>
 <CANiq72=kqJApbOJ0hmC_mAYe6DO8YqXSFaLJOsbPhkXfxmvJHQ@mail.gmail.com>
 <20260116083516.GI830755@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116083516.GI830755@noisy.programming.kicks-ass.net>

On Fri, Jan 16, 2026 at 09:35:16AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 21, 2025 at 10:47:45PM +0100, Miguel Ojeda wrote:
> > On Fri, Nov 21, 2025 at 8:55 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > +/*
> > > + * Optional: only supported since clang >= 21
> > > + *
> > > + * clang: https://github.com/llvm/llvm-project/pull/137250
> > > + */
> > > +#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
> > > +#define __counted_by_ptr(member)       __attribute__((__counted_by__(member)))
> > > +#else
> > > +#define __counted_by_ptr(member)
> > > +#endif
> > 
> > I guess there is a reason for this name, but it sounds to me a bit
> > like the thing between parenthesis is a pointer, i.e. that perhaps it
> > is the pointee that one that counts.
> > 
> > Hmm... what about `__ptr_counted_by`?
> 
> Kees promised to drop this attribute once GCC-16 releases by basically
> doing 's/__counted_by_ptr/__counted_by/' and unifying things again.

Yeah, this will effectively raise "counted_by" support to GCC 16 (from
15) and to Clang 22 (from 20). I'd still prefer to keep the earlier
support, but we'll see how it goes.

-Kees

-- 
Kees Cook
