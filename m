Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9D2EB841;
	Thu,  8 Jan 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892542; cv=none; b=qI3TIoBUxNfBp8naMPrtXAID/aEqutLV+ihIIydPYbacYtJUXTYuLkP9m59/1GoMN7R2iertm1Krc/VQyUMpFSYLY6Om2//3o0NScptSaXyQgy/JxLV9LVoxIoEbatjxBJtQOKpfkqT3GvlW7gBhIht1o9Ai0N2TQTVKuh4wfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892542; c=relaxed/simple;
	bh=odztZpOUjdPpxpnVnhNo5G14j/5HFOW1Zpu+cMYj4mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZp/Jr2KL7+mu9XbJokOaehMM6/IalILfXzbYI+Pfy4NbYjx7oi5hI2I+9n5jmcskK41PlHQiAf+Qyae7PuseCTOB/2EWYaVzfFmyYH8uCUc7uGFYs5NJ6OlSCcph2p5RgEVnZE7rVlPGINPN61fxS2pnEFwKUKfCgjQx0uFU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9BRioOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9BRioOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89616C2BCB2;
	Thu,  8 Jan 2026 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892541;
	bh=odztZpOUjdPpxpnVnhNo5G14j/5HFOW1Zpu+cMYj4mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9BRioOmXSEdRevGPU2umsDaGngTrbkSFKt8n+5010kaFbJb3XhoQBBbnRYpes7KH
	 9etMgBsH349DVH7lP6n7Twjkt9tCQv7EICUiBdLE/bXLDpfmENj1ridUABHwLSMdxj
	 uSjmQ2lCPwAwa5E0ZShmgomJu2iNw8rRtOTcbaUs7Gb1X6W5N9yKGpA+NsJxGYOE8S
	 B6OUt47Vg8ILGw9witmobk++jbuZCzOOgrYrpLQpxmRefyCdeLkpX95NCZMJ9nyoJY
	 muqWbQByN8NZldOnr9ExnxgNVfJjDVQz608JR31HmzXT7bM9Vk+aFbZ5H1g1dZxR9S
	 HgGy3xg+SBmfg==
Date: Thu, 8 Jan 2026 09:15:40 -0800
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 1/5] slab: Introduce kmalloc_obj() and family
Message-ID: <202601080912.F762F30B6@keescook>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-1-kees@kernel.org>
 <960729bb-0746-4709-a40c-2e254f963deb@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960729bb-0746-4709-a40c-2e254f963deb@suse.cz>

On Thu, Jan 08, 2026 at 03:01:00PM +0100, Vlastimil Babka wrote:
> On 12/4/25 00:30, Kees Cook wrote:
> > Introduce type-aware kmalloc-family helpers to replace the common
> > idioms for single object and arrays of objects allocation:
> > 
> > 	ptr = kmalloc(sizeof(*ptr), gfp);
> > 	ptr = kmalloc(sizeof(struct some_obj_name), gfp);
> > 	ptr = kzalloc(sizeof(*ptr), gfp);
> > 	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> > 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> > 
> > These become, respectively:
> > 
> > 	ptr = kmalloc_obj(*ptr, gfp);
> > 	ptr = kmalloc_obj(*ptr, gfp);
> > 	ptr = kzalloc_obj(*ptr, gfp);
> > 	ptr = kmalloc_objs(*ptr, count, gfp);
> > 	ptr = kzalloc_objs(*ptr, count, gfp);
> > 
> > Beyond the other benefits outlined below, the primary ergonomic benefit
> > is the elimination of needing "sizeof" nor the type name, and the
> > enforcement of assignment types (they do not return "void *", but rather
> > a pointer to the type of the first argument). The type name _can_ be
> > used, though, in the case where an assignment is indirect (e.g. via
> > "return"). This additionally allows[1] variables to be declared via
> > __auto_type:
> > 
> > 	__auto_type ptr = kmalloc_obj(struct foo, gfp);
> > 
> > Internal introspection of the allocated type now becomes possible,
> > allowing for future alignment-aware choices to be made by the allocator
> > and future hardening work that can be type sensitive. For example,
> > adding __alignof(*ptr) as an argument to the internal allocators so that
> > appropriate/efficient alignment choices can be made, or being able to
> > correctly choose per-allocation offset randomization within a bucket
> > that does not break alignment requirements.
> > 
> > Link: https://lore.kernel.org/all/CAHk-=wiCOTW5UftUrAnvJkr6769D29tF7Of79gUjdQHS_TkF5A@mail.gmail.com/ [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> How do you plan to handle this series? Given minimal slab changes (just
> wrappers) but there being also changes elsewhere, want to use your hardening
> tree? I wouldn't mind.

Ah! Sure, yeah, I can take it. Thanks for the Ack. I'll get it into
-next and refresh the treewide changes.

-Kees

-- 
Kees Cook
