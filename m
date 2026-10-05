Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DE3A7F51;
	Mon,  5 Oct 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236121; cv=none; b=oA+tRqcJWSvFHRBFGVsxJ0NSvg2LYJX8+G1+c9sI3zWCbcZsXcdk64Z9BNpLMNnDcTFExjV3c/QwNKwwvVT4lzTmOYVjL7KwISV6QZBeP//WoBL+ZM0sGfpVkNdrqzsdpTB0Hf7YriWx82DDfhrjRPpJT77m3Pfpz6yeGABGXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236121; c=relaxed/simple;
	bh=5PZqBYgQkiUo0RUtnjlMFOWXFEzOcshQuWqR5QYxgc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbTfF1otvCQAERC05aLiGUh+GPd6MMrbj/HTR3OuXWCjX7UNNtAxy/Hramavsc4MX+9ushry6hP/FCUTmY1Zpkcf2uEo0TL8c1TrudFgAMWHOgXGeyk3rMtxt7gxLFdjRbUkJ11/VszdJcm/ytRUz2xteJ2BAJstFy9aKBz9r/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P6Wc7Jxy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P6Wc7Jxy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5A21F000FF;
	Mon,  5 Oct 2026 21:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791236119;
	bh=yZ52pUPtOfeAPAn2Ck6Sgm1SDj6aR1P1uVv4/GKks+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P6Wc7Jxy+1ZID/sXiTgAHGuUNpQ/E2plLnrv8YW6H44xwVV2zjVF2KMjxSerXas3O
	 ELrFYnOTKa74Cl9ESuUEZ51asjQbAD2siHFnLxvZg4C79wMvpPWGPQJO8yDbAWUp73
	 I93AkL++LY7yM3DhVxV5JidS31ydjb0XCgAx7U00=
Date: Mon, 5 Oct 2026 23:35:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	driver-core@lists.linux.dev, linux-hardening@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
Message-ID: <2026100532-stench-enrage-0b81@gregkh>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914223219.901347-2-kees@kernel.org>

On Mon, Sep 14, 2026 at 03:32:17PM -0700, Kees Cook wrote:
> Mirroring the type-based allocation now in use for the kmalloc family of
> APIs, provide the same for the devm_kmalloc family of APIs. This will
> allow for future plumbing of type information (e.g. alignment) into the
> underlying allocations. This immediately gains type check on return
> values (instead of the prior "void *" return type).
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: <driver-core@lists.linux.dev>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  include/linux/device/devres.h | 102 ++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)


I'm guessing you want this to go through your tree?  If so, that's
great:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Otherwise let us know and we can take it through the driver core tree.

thanks,

greg k-h
