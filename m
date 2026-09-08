Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F83976A4
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852813; cv=none; b=XOAqSsoIhdRPxL4gfGugLBc4Re2F6ofg13pehzGZme7MXYapPl8uT3FnbLXJhsaA7RQOzUdokUVaqOvAXPULdjB8poJ9VA4HOn4eZUIuvbE9aWQ18o2upQTOgRp2ooMc62RDS1jvKJc89IGR7JGl1y43A78KD9gbbUvu+JZeDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852813; c=relaxed/simple;
	bh=+stIGXX9vM3ctTpJ7Uf57CM2GvhY8ucJX56MI6UVhg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko/MdDWrIVxs10RfgpYY5QVdOScmap+4mmLoQSfw6e5CC7pktgRdaMgmCIu/MIA5G82/MazCVK8qYJqCS5WkCTh1xFhP/dIfDSVfVv8jPhi+cPtnFVVcTKNcnHfCFpG/Djb5myUviXNu/zQyHjFQpGrAGUXoOE/h4s8Zl5kFl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDf5yNAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDf5yNAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6E41F00A3A;
	Tue,  8 Sep 2026 07:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788852811;
	bh=XksScMTj542HVHkyB1nI14urzyZQ1NnPrwE6pFWv+JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NDf5yNABuLUHiqeaxlPBpJIkI3TK9/rc8cWI+3xEERZ7V7seyLQhxFkrAmyfltW9A
	 YMYkHArboRJpL/my33wJQzLLWU30oaoeEJ6Ttyg6w1/hv2TEYtTysufc1I4riY7Dqe
	 1JpKsL4Pz+cuPhrKS57RxOWMoKUh9ZXCcPFodVwYvHAdhk5Vs5zfob/oRkS22YVwvE
	 9ctwQ1+AqKOVimiiWzAVqs/TQgZg2HOTktggOfpLZh3Suk6syCfNKi0yyOR3e83vSz
	 TLAmts2y/e750y5m0ukDcwHblMQiyyUtAMyxQ5Byvy5FEVfYT0tz5dLmFYwRCykPWh
	 XLK7zvj4B1Wsw==
Date: Tue, 8 Sep 2026 10:33:17 +0300
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
Message-ID: <ap-6PZqGZHhPD6u1@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-12-743ad31b2c8f@arm.com>
 <178877845406.3691569.12554855722197968629.b4-review@b4>
 <bdba5b54-8733-4d47-952d-e1bd958a1ead@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdba5b54-8733-4d47-952d-e1bd958a1ead@arm.com>

On Mon, Sep 07, 2026 at 05:52:32PM +0200, Kevin Brodsky wrote:
> On 07/09/2026 12:54, Mike Rapoport wrote:
> >> [...]
> >>
> >>  static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int order)
> >>  {
> >> -	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
> >> +	struct page *page;
> >> +
> >> +	if (kpkeys_hardened_pgtables_enabled())
> >> +		page = kpkeys_pgtable_alloc(gfp | __GFP_COMP, order);
> >> +	else
> >> +		page = alloc_pages_noprof(gfp | __GFP_COMP, order);
> > Can we make it a sequence rahter than a branch?
> >
> > kpkeys_pgtable_alloc() does alloc_pages and then sets their pkeys, so I
> > think something like this should work:
> >
> > 	page = alloc_pages_noprof(gfp | __GFP_COMP, order);
> > 	if (!page)
> > 		return NULL;
> > 	err = kpkeys_pgtable_alloc(page);
> > 	if (err) {
> > 		__free_pages(page, order);
> > 		return NULL;
> >
> > with if (kpkeys_hardened_pgtables_enabled()) folded into
> > kpkeys_pgtable_alloc().
> 
> I agree this would be less ugly. In fact this is pretty much what this
> series did up to RFC v5 (albeit in the ctor/dtor instead of alloc/free).
> We could go back to this API, *but* the big issue is that it makes it
> impossible to use a smarter allocation strategy for protected pages.
> Patch 14 in RFC v6 [1] will give you an idea of what such an allocator
> (with support for large blocks and splitting) would look like.
> 
> As discussed with David H we're first trying to land this feature
> without large block support (fully PTE-mapped direct map), but we do
> want to support large blocks eventually [2] and I would prefer the core
> API to be already compatible with that objective. Very happy to hear
> about suggestions as to how to avoid the explicit condition in
> pagetable_alloc() though!

We could unconditionally replace alloc_pages_noprof() with
kpkeys_pgtable_alloc() and make the latter choose the right allocator, but
that's not very nice either :/
 
> - Kevin
> 
> [1]
> https://lore.kernel.org/linux-hardening/20260227175518.3728055-15-kevin.brodsky@arm.com/
> [2] https://lore.kernel.org/all/aMwd7IJVECEy8mzf@willie-the-truck/

-- 
Sincerely yours,
Mike.
