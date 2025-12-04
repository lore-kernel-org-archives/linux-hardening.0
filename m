Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D623398F98;
	Thu,  4 Dec 2025 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879956; cv=none; b=HEHx97PQgskYvmJI2q0Y+aSZYNybWerl9xEGdPOOai+xqcJ3xq1Rn64G7zWdRZs0Y3Bb73Ge9H8dGKmZY+E4RVdN6cAnRHMPCwfun3AUntCY1wb0UVLijvXRe7m21ZuptkAI6JUQmryisNnSsHs7JmxHL1Ye/E865A/lZ9WfU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879956; c=relaxed/simple;
	bh=kaPs0IQaF7S1VKck3FZz6uJuYv3S2JC1BT6Tky0WNBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVJ/dzPPekxNoW0Wcv1gspGq4sHQzVmz/foWCaDnl4ChjZACPgZWtGj2cSbyzqV+anLpC34VWZsDrMYOAqvgsTJ065bWobjxPGFULig5Ztwz1QXW8TGDn+uCPzhVdiReX+qiIiPgHTNAt9et+CbLCRPDsV0WQ/EUhmT3ZG9QDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/ts9h1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/ts9h1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B6DC4CEFB;
	Thu,  4 Dec 2025 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764879955;
	bh=kaPs0IQaF7S1VKck3FZz6uJuYv3S2JC1BT6Tky0WNBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/ts9h1yO6KJK6fBmRkUgCRFbLgOKPgwRBpvdMm7W5xS9EmK5iebZlcKqTo2jyx2L
	 Ro7nmWQaTVjDXmyjjNd4fzNLHtn2FfViF92pIX3od5R+vnopde+GbSHtdSLEleZvlv
	 C55Q4kRI1a9rdPulSxXB9pH+qmBtWoX6blshzuG0183Dds+kO++CfJzx+Q+gddIv+y
	 GSpM2wFbD8a7at6iSPH5GOL1iPEU05fJgs7oNext5Eu8eOUZjv6MEckThfwTYk4M4B
	 acpwg74GxE5yNIOnQbi6acGvlFA0L7cCpweWRexjPD6c1KYUwqVo2N5saAJeqQhJ+3
	 o9LATwSnjw1TA==
Date: Thu, 4 Dec 2025 12:25:55 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miguel Ojeda <ojeda@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Marco Elver <elver@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-hardening@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v6 3/5] compiler_types: Introduce __flex_counter() and
 family
Message-ID: <202512041215.44484FCACD@keescook>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-3-kees@kernel.org>
 <20251204085435.GC2528459@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204085435.GC2528459@noisy.programming.kicks-ass.net>

On Thu, Dec 04, 2025 at 09:54:35AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 03:30:33PM -0800, Kees Cook wrote:
> > Introduce __flex_counter() which wraps __builtin_counted_by_ref(),
> > as newly introduced by GCC[1] and Clang[2]. Use of __flex_counter()
> > allows access to the counter member of a struct's flexible array member
> > when it has been annotated with __counted_by().
> > 
> > Introduce typeof_flex_counter(), overflows_flex_counter_type(), and
> > __set_flex_counter() to provide the needed _Generic() wrappers to get
> > sane results out of __flex_counter().
> > 
> > For example, with:
> > 
> > 	struct foo {
> > 		int counter;
> > 		short array[] __counted_by(counter);
> > 	} *p;
> > 
> > __flex_counter(p->array) will resolve to: &p->counter
> > 
> > typeof_flex_counter(p->array) will resolve to "int". (If p->array was not
> > annotated, it would resolve to "size_t".)
> 
> Uhh, how will this interact with the proposed extension of
> __counted_by() to normal pointer types?

Good point -- at present __builtin_counted_by_ref() only works on flex
arrays. I will ask the compiler devs their thoughts on expanding it to
the pointer references too...

-- 
Kees Cook
