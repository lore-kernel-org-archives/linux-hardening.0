Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1E2DC774;
	Thu,  8 Jan 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894060; cv=none; b=gryzWDACowubbE8M2ny2y81p0RrQ3D9R5AYZWv7QLOTTyqGV0KLRMall6FfmOaWeJ1fH+XdG/o13WUVr4I5ergpHHYEz9skYQiwilfxwXVn4faX8xHCDqEazR4eWSgzXWm4oau5MYhX3xKxEK+d8FAUPRpr8VtOiSkEmr6u4U6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894060; c=relaxed/simple;
	bh=BHDdPpb32MY2i2fwkzE3yXM71nGt/m2CVIq2iPGkD6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAnnYbHqdpOrG2PpaCYnTmymwxvd3ppoXbF3ude6/RMoUrpSOmRho8zgen5xIYUF40bJ1Enwdr7dOjzA691cXKewV60JDJjsxRvLfQ8JFWx5nqCLn6eFnRb8wTKQCOEymSK6f49xDcKslPggall4lDn7V5Tpnz5YRw2UwDfVSzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHtwXWTG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHtwXWTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0787C116C6;
	Thu,  8 Jan 2026 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767894060;
	bh=BHDdPpb32MY2i2fwkzE3yXM71nGt/m2CVIq2iPGkD6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHtwXWTGHb9kHiOWzYRLmcK5SrLwYwSLs4AP63ZX7lpeaKpX5t9iEmeEecGGFZJp0
	 xAmLwU5bChPZEPMLXPn0mQjWaEO0a52l/mybjLfoA2hocSEWiHejm3Adb2AC7PUAZg
	 5I26aGJYxIfmfz99qtmj/nQqtWkjQi+zkUgVbyBFfQ9FcHUKkYt3KKeOn20hVfDliv
	 DRksaxI3W8EnZj6XqYdLhjHZLzXTPSa0QWvvQN2urPu/iO0U22fAXMgZCSGha/IgIE
	 BW1pZV4/kWmAmc2n+SMbON22aMWCwYw/tI/Uphd9DRy4hHPXcivkNV73BdmkzT9g44
	 4mzT39lblGS5g==
Date: Thu, 8 Jan 2026 09:40:59 -0800
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
Message-ID: <202601080939.B99FEFF780@keescook>
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

I've changed this to:

...
based on the type size of the counter variable. For example:

        if (count > type_max(ptr->flex_counter))
                fail...;
        size = struct_size(ptr, flex_member, count);
        ptr = kmalloc(size, gfp);
        if (!ptr)
                fail...;
        ptr->flex_counter = count;

becomes (n.b. unchanged from earlier example):

        ptr = kmalloc_flex(*ptr, flex_member, count, gfp);
        if (!ptr)
                fail...;
        ptr->flex_counter = count;


May I add your Acked-by for this 4/5 patch?

-- 
Kees Cook
