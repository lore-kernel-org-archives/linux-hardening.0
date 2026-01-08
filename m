Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0319DF4D;
	Thu,  8 Jan 2026 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892330; cv=none; b=TFt3gKs22ge9/eeu6S33zlhTxO2va3wUZChHX/dMDP7PSLA/lCRoJsrKJgVWnuAnZI5zh/IlAmUki0ij+xujG+PcyZN/3wGRO+ojond8gulFVVFq65wtjfyq6HVTcsrUSUqXvCpa5OSYLbMEKLFNfv1KATijkjdMdaJs4J9RoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892330; c=relaxed/simple;
	bh=LetoQP40gZ1AyG9X4BvpWxEt04ybOeOdK9lGPopip2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6zb7wrAD4mcp93iGCNqgn82qqkY2iJg9xHynHoxJx839pkz0exyt9OI+eskLyziqI5To+fcfxsCJJjHNoxTWOHjFQN130HXuWHh185o2d6cs031or9bGhf1l2JXR2rC/4bdX8wMyhIDbC1oSQCet2EKGh5whHJX3ARX6socGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2GlYfqj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2GlYfqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89280C116C6;
	Thu,  8 Jan 2026 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892329;
	bh=LetoQP40gZ1AyG9X4BvpWxEt04ybOeOdK9lGPopip2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2GlYfqjWCuHEGGgPcxNvy20Jt31rvHXCfJXRQrxEnRZmM6qC0Z/RvgY1k+nr/ypH
	 VWP1GfA9Pdsir3ysjvAX13fGkwKstN6C5+WmdGJuX+hwHwQtUQezMEqtJc3ZevEI/b
	 R0DbQpsk6s0CzpWsa8qn+wc5iau95SCa9SCRYtVf0074JEAmEBUjGpH+hYhqKXG3Ms
	 1gM+NaEq4K/ZSl7dAlp8jxJZQ/CDtA7edAqd0EMYyPV4ljGfBEVIUakuASb5LSlwj/
	 oSKdz7rpTwi0YuRuuMv2WoRTohxFNB3XSHdyYZ7HBu9WsImqX4JtigaxzI12VH906r
	 sRqyZImoMZ2+Q==
Date: Thu, 8 Jan 2026 09:12:09 -0800
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>, Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 4/5] slab: Introduce kmalloc_flex() and family
Message-ID: <202601080908.398D2129A@keescook>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-4-kees@kernel.org>
 <f1f06db9-a12c-4999-9723-1fca5e8383a4@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f06db9-a12c-4999-9723-1fca5e8383a4@suse.cz>

On Thu, Jan 08, 2026 at 03:06:31PM +0100, Vlastimil Babka wrote:
> On 12/4/25 00:30, Kees Cook wrote:
> > As done for kmalloc_obj*(), introduce a type-aware allocator for flexible
> > arrays, which may also have "counted_by" annotations:
> > 
> > 	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
> > 
> > becomes:
> > 
> > 	ptr = kmalloc_flex(*ptr, flex_member, count, gfp);
> > 
> > The internal use of __flex_counter() allows for automatically setting
> > the counter member of a struct's flexible array member when it has
> > been annotated with __counted_by(), avoiding any missed early size
> > initializations while __counted_by() annotations are added to the
> > kernel. Additionally, this also checks for "too large" allocations based
> > on the type size of the counter variable. For example:
> > 
> > 	if (count > type_max(ptr->flex_counter))
> > 		fail...;
> > 	size = struct_size(ptr, flex_member, count);
> > 	ptr = kmalloc(size, gfp);
> > 	ptr->flex_counter = count;
> > 
> > becomes (n.b. unchanged from earlier example):
> > 
> > 	ptr = kmalloc_flex(*ptr, flex_member, count, gfp);
> > 	ptr->flex_count = count;
> 
>              ^ flex_counter ?
> 
> But if it was "too large", ptr is NULL so this will oops?

Oops, yes, typo in the example. I will fix that. As for NULL, I dropped
the NULL checking on both sides of the example just to focus on the
differences.

-- 
Kees Cook
