Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420106;
	b=G8w583z+siOlz0cloaPWCut/lypO81G8YYyoixu6sW1v4KDI2vvJBycBJxPT3bjlSMvm
	 BdJmHuvyaf7zK7GQOf5eCngRGDqIWeZ6dDKIgMEcPjiWmO1mTlSYhbnum5w2Xhe/PH7kU
	 uDQ05DyTVYVYnR8vAG6nqGMV2roMXsEymwDuMEiN68x8ay6XKG2V64VZ+nuSDT3Kc7lZi
	 XuCF8UuC+u/bmJfOTGoLiZWc9xv/cHpl1sSLpCCaj6vju8mdaaXMXfKawqIMCprFi0H+i
	 ETQtsljcNQriNbPbpmtgPjyRy43m4mR3nnMalhwEGSy0KXJjgHQV3jHhSZ6MtW4phmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420106;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3cGD2nXI1KRMoDbeVY3qmkZWqNOQZJ5tcGl5adpBOtc=;
	b=f9zVjNnbc/PAAZUtLtf2satiIEOcZWya5/kWmJEDPymDYDDz8wY6ebIVq7xBU4IA9mKt
	 gLaBMe1EzSDw4rF02EfZcaVNRI6e8SQRy1+/51qp5+dFdh4pFlDeDTEdFRyuhdXzr/Sov
	 Cl8uyUZ9EafXu4eIrCmtFAqkGUJ0dJnGL+Gd2nYVIqEIh/1OrU/SH7o+5b+1+Z/pSugOR
	 TqicrQGSHBCoG/MskY6zu2UxHxQrEMNBdjgD2WRryj1T9TpFtzRNQMfWo7SBnnXzgzCtW
	 e4Sp3HfhUKREDr3jM12/m0uIt1Y76oFbjtwmdAaCz9CLzsj/nxkLoffwgrMy65ra88A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaOzfFfL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9D606A31E;
	Sat, 31 Oct 2026 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RaOzfFfL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428101F000C1;
	Sat, 31 Oct 2026 04:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793420105;
	bh=3cGD2nXI1KRMoDbeVY3qmkZWqNOQZJ5tcGl5adpBOtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RaOzfFfLGzssuh+JjOKHBZYCqFiRxq3QTgt44gt8UZ1liV6gQAY4MQTHAUCDxfOuT
	 w6qmiQALxjw7NlwWzhRXKRELShPBy7H4rwzwz8UyGf9oG7WVa3uadE1C0BN724JkzK
	 DZ+vJeVC/nNjYaPcC1iIVOYsfuyUj1344RQ8diH0NBhLVcRZKjDCjKHdASpQdly8bA
	 SJXMUTzUMaY7P47tf6W/NtJCOA1nXQrUu2/Bbu4rMDoyUNzo3ewESByCgCsfk1nwrV
	 WdwQSrSSOLn4hCph4pf9WP6uDyBMZ/AIPu5OHDZ1O+FhlsGGwircODTeQ0UblVTBwp
	 jl4BXVE4yxqVw==
Date: Fri, 30 Oct 2026 21:15:05 -0700
From: Kees Cook <kees@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/6] mm/slab: Enable SLAB_FREELIST_RANDOM by default
Message-ID: <202610302113.FB347BE5@keescook>
References: <cover.1793253633.git.chris@chrisdown.name>
 <6bdc161bd869ead04b3b9a651ef6a83882ecbea3.1793253633.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bdc161bd869ead04b3b9a651ef6a83882ecbea3.1793253633.git.chris@chrisdown.name>

On Thu, Oct 29, 2026 at 02:07:55PM +0800, Chris Down wrote:
> SLAB_FREELIST_RANDOM randomises the order in which the objects in a new
> slab are handed out. Like SLAB_FREELIST_HARDENED, most distros already
> enable it, and its cost is only paid when a new slab is set up.
> 
> With it on, the same system level benchmarks didn't change measurably.
> Allocating from new slabs does get slower, by up to about 30% per object
> in a microbenchmark which does little else.
> 
> So let's enable it by default too. SHUFFLE_PAGE_ALLOCATOR defaults to
> SLAB_FREELIST_RANDOM && ACPI_NUMA, so it's now built in by default on
> those systems, but page shuffling itself stays off unless it's enabled
> with page_alloc.shuffle.
> 
> Suggested-by: Vlastimil Babka <vbabka@kernel.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>

Again, just like it should be. I wonder, though, don't these 2 changes
undercut the goal of making these boot-time selectable?

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
