Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6E330656
	for <linux-hardening@vger.kernel.org>; Wed,  9 Sep 2026 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974739; cv=none; b=L+sGcnYLFPVW6cvjeSXCQnrdsN6tS9t98shGNDwHNBu4hfdVJOKjkdLpFAOVv4d5hql6vKmYwRICVRIK31YP1KpbaqarrMLn15VxkbSK0Q4LHy/XTX6NzEqamXwVRdVj+b53pYPHjf+uKJo0ukct7nCyzUqhFh6YWaMqPE1cmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974739; c=relaxed/simple;
	bh=E55QeCRgXjlzg7U0ltqMTCEctDHetcBGNA8/m6k4LD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEzbLQwX4lIa2UFDB8wumjrmLTnVwiVLb0aNERVuhIKHn05fPUonR22S0Qpoq7PxgEcjN2okDTyotI9qKiHmjvnnkyCUfZEXVMW1MAe9+OIsX1L/mCRxqIQhjAasKqiOP6seCL9PyNNVdmQQ/BdIqCYGvEhjd4G+hKoK7lJuxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np2zHsZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np2zHsZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1130C1F00893;
	Wed,  9 Sep 2026 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974737;
	bh=Pubbd2dNu1LQzdMpKfGD1I+IW+yVdlfvOm5SQzKSwOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Np2zHsZYyQkXFsoQXHrepxlLGabd+RY/LBmPCa+qEqed8bCT4ZETBek7x/fepo2cf
	 chc0NHhTyWBOo6MGAe1MrYbgn7rNMGHB+e1UrAiQxAUHgqiXvdoqS10NF4irGfKGVI
	 OZJQwaSiCY2nNlmpzquIIfCMsl9L+cAJww6j7RQg4rEeYoATXyukmi6ZDsLquBc5uv
	 jbodWLtGPjBeZ5BJD1s91Ykdq+MH+S8UREAaZvPNBRWDpRr0ED+x0Ok8sayWFcQ6pQ
	 54ujIFeehVia5phkoxeM18mkzVx3GTUC3a4BKwkk6m7ri25RP/Lk54BM9PfdUa/6sZ
	 QZyhRCK3nIy1g==
Date: Wed, 9 Sep 2026 20:25:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
	Linu Cherian <linu.cherian@arm.com>,
	Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	=?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v9 12/25] mm: kpkeys: Protect regular page tables
Message-ID: <aqGWhJjE1VUZf8_3@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-12-743ad31b2c8f@arm.com>
 <178877845406.3691569.12554855722197968629.b4-review@b4>
 <bdba5b54-8733-4d47-952d-e1bd958a1ead@arm.com>
 <ap-6PZqGZHhPD6u1@kernel.org>
 <00e97c75-eef1-4587-b299-ab07591a07bc@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e97c75-eef1-4587-b299-ab07591a07bc@arm.com>

On Tue, Sep 08, 2026 at 12:11:57PM +0200, Kevin Brodsky wrote:
> On 08/09/2026 09:33, Mike Rapoport wrote:
> > On Mon, Sep 07, 2026 at 05:52:32PM +0200, Kevin Brodsky wrote:
> >> On 07/09/2026 12:54, Mike Rapoport wrote:
> >>>> [...]
> >>>>
> >>>>  static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int order)
> >>>>  {
> >>>> -	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
> >>>> +	struct page *page;
> >>>> +
> >>>> +	if (kpkeys_hardened_pgtables_enabled())
> >>>> +		page = kpkeys_pgtable_alloc(gfp | __GFP_COMP, order);
> >>>> +	else
> >>>> +		page = alloc_pages_noprof(gfp | __GFP_COMP, order);
> >>> Can we make it a sequence rahter than a branch?
> >>>
> >>> kpkeys_pgtable_alloc() does alloc_pages and then sets their pkeys, so I
> >>> think something like this should work:
> >>>
> >>> 	page = alloc_pages_noprof(gfp | __GFP_COMP, order);
> >>> 	if (!page)
> >>> 		return NULL;
> >>> 	err = kpkeys_pgtable_alloc(page);
> >>> 	if (err) {
> >>> 		__free_pages(page, order);
> >>> 		return NULL;
> >>>
> >>> with if (kpkeys_hardened_pgtables_enabled()) folded into
> >>> kpkeys_pgtable_alloc().
> >> I agree this would be less ugly. In fact this is pretty much what this
> >> series did up to RFC v5 (albeit in the ctor/dtor instead of alloc/free).
> >> We could go back to this API, *but* the big issue is that it makes it
> >> impossible to use a smarter allocation strategy for protected pages.
> >> Patch 14 in RFC v6 [1] will give you an idea of what such an allocator
> >> (with support for large blocks and splitting) would look like.
> >>
> >> As discussed with David H we're first trying to land this feature
> >> without large block support (fully PTE-mapped direct map), but we do
> >> want to support large blocks eventually [2] and I would prefer the core
> >> API to be already compatible with that objective. Very happy to hear
> >> about suggestions as to how to avoid the explicit condition in
> >> pagetable_alloc() though!
> > We could unconditionally replace alloc_pages_noprof() with
> > kpkeys_pgtable_alloc() and make the latter choose the right allocator, but
> > that's not very nice either :/
> 
> Yep I also thought of that but the naming would be really misleading...
> 
> Maybe, maybe, introduce __pagetable_alloc() that is a simple static
> inline calling alloc_pages_noprof() if !CONFIG_KPKEYS_HARDENED_PGTABLES,
> and otherwise checks kpkeys_hardened_pgtables_enabled()? Less ugliness
> in pagetable_alloc() but even more further down, not sure this helps.

You are right and I can't say I have any bright ideas.
 
> - Kevin

-- 
Sincerely yours,
Mike.
