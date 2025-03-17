Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7241A072A;
	Mon, 17 Mar 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228569; cv=none; b=AGxxGX6Ob0Ahpg9yHsawjujVokdgTXRylhcNdUf9J9vL2UQZgAsmr6u0RIkKJ2b+Ix7wfakd4t0SkWbpEYJNwZYfpOST9c+z0DtjjM+GbwNwh+/a4sJlHN6ryJXQFQkabaCADvhLUgItTQrT08To7QyxM0CZEmwZSj9NX+qFygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228569; c=relaxed/simple;
	bh=dRUIl3yQcLybI+RJ6oaOQPFfyifr9VBzmEcrLKujw2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4N7u+LcR0fsZnfaQxR9RvV5wBONhMlsoAHvm2GDif0dVL1zbEnbi65+fo0J8PBLbrkzYQ5ht/bcivezsBS8esjCBvNyIncp1Qzw1NUPQ/nDlqULd9exAEXhTl/N9qg8ck5FwJmab0lpH3YbWB0GKg0cfMBkYk+wmwFHicAXGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFYdRWCR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFYdRWCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D4AC4CEED;
	Mon, 17 Mar 2025 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228569;
	bh=dRUIl3yQcLybI+RJ6oaOQPFfyifr9VBzmEcrLKujw2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFYdRWCRMHtn3ek5pOSVea3e1aV3dB3WZkMmGn14i+pVDV70xQ4NY4R/ZlTkyS86C
	 HGEpT+dhq4uqjcBnp1l01qCouQcDLlbj5wo9QOTOFkc7pQMauL03MlK9Y4h3XhlRxh
	 cnup+q58QqMDwCuZn/G0pO3SmEuZT+0rrpjuXzn5U1gE9tEdYIF2XFctyrV6Z/YrXu
	 vMXqUWKB4xXGT75JveTVA6Oblr++7aq8T0SPVv/gnlvDtVtsH6QScGRc+4IUhUCZ+d
	 /xcMHRSGWcLrC/nuHlZIvmcLTNxXmfazqGOGiM4370sgCS3bSRyyCTmGT9+Rmo71w2
	 26zc6VcvZZdLw==
Date: Mon, 17 Mar 2025 09:22:46 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Marco Elver <elver@google.com>, linux-hardening@vger.kernel.org,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/2] compiler_types: Introduce __flex_counter() and
 family
Message-ID: <202503170918.A53A0F2@keescook>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-1-kees@kernel.org>
 <eb6e6198-dc42-4a63-8d0d-35f3061ff388@intel.com>
 <44a00ad4-b05d-4fb8-87f2-fccbaa068872@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44a00ad4-b05d-4fb8-87f2-fccbaa068872@intel.com>

On Mon, Mar 17, 2025 at 10:43:38AM +0100, Przemek Kitszel wrote:
> On 3/17/25 10:26, Przemek Kitszel wrote:
> > On 3/15/25 04:15, Kees Cook wrote:
> > > Introduce __flex_counter() which wraps __builtin_counted_by_ref(),
> > > as newly introduced by GCC[1] and Clang[2]. Use of __flex_counter()
> > > allows access to the counter member of a struct's flexible array member
> > > when it has been annotated with __counted_by().
> > > 
> > > Introduce typeof_flex_counter(), can_set_flex_counter(), and
> > > set_flex_counter() to provide the needed _Generic() wrappers to get sane
> > > results out of __flex_counter().
> > > 
> > > For example, with:
> > > 
> > >     struct foo {
> > >         int counter;
> > >         short array[] __counted_by(counter);
> > >     } *p;
> > > 
> > > __flex_counter(p->array) will resolve to: &p->counter
> > > 
> > > typeof_flex_counter(p->array) will resolve to "int". (If p->array was not
> > > annotated, it would resolve to "size_t".)
> > > 
> > > can_set_flex_counter(p->array, COUNT) is the same as:
> > > 
> > >     COUNT <= type_max(p->counter) && COUNT >= type_min(p->counter)
> > > 
> > > (If p->array was not annotated it would return true since everything
> > > fits in size_t.)
> > > 
> > > set_flex_counter(p->array, COUNT) is the same as:
> > > 
> > >     p->counter = COUNT;
> > > 
> > > (It is a no-op if p->array is not annotated with __counted_by().)
> > > 
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > 
> > I agree that there is no suitable fallback handy, but I see counter
> > as integral part of the struct (in contrast to being merely annotation),
> > IOW, without set_flex_counter() doing the assignment, someone will
> > reference it later anyway, without any warning when kzalloc()'d
> > 
> > So, maybe BUILD_BUG() instead of no-op?
> 
> I get that so far this is only used as an internal helper (in the next
> patch), so for me it would be also fine to just add __ prefix:
> __set_flex_counter(), at least until the following is true:
>  "manual initialization of the flexible array counter is still
> required (at some point) after allocation as not all compiler versions
> support the __counted_by annotation yet"

Yeah, that's fair. I will rename set_... and can_set_...

Thought FWIW I'm not sure we'll ever want a BUILD_BUG_ON() just because
there will be flex arrays with future annotations that can't have their
counter set (e.g. annotations that indicate globals, expressions, etc --
support for these cases is coming, if slowly[1]).

-Kees

[1] loooong thread https://gcc.gnu.org/pipermail/gcc-patches/2025-March/677024.html

-- 
Kees Cook
