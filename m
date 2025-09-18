Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93D30595E;
	Thu, 18 Sep 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207478; cv=none; b=YZuqoGCROpmMEcgF4UIysdVA3EfEddOtYxHjC7Uv7sjc5ePUmt3CD+a4OsEuPfsGV8U8wu+QhKO9p8e4D74pm3ObgrYu05N+nsf92QEnUdf8Df8P/3iOlNiClcvtSvhh0C/POrBEpT9m2sKezwFr0gBMcfaz9gQ5jEicf5ZjuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207478; c=relaxed/simple;
	bh=9ptbDgx9yP30JQpxvmB423ylAWuRrb/kCJRElL8M6vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ3bSIByEoBXQLcL49/MyebERYAVgR+1G5fqBB16scrZwi8sARa13DsNlgsOUIsieQ8Jk3QP45BE+l8BrGg3YWhR0Mfcl0xSHpHbh2qX8ZfJmrWin6zqdV1CTJeAyeh4wLCzCHZCMEjOqLbMuM8EEg8jy7Xw7+Bhf2r60eaTkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3UZcSMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3UZcSMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2CEC4CEE7;
	Thu, 18 Sep 2025 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207478;
	bh=9ptbDgx9yP30JQpxvmB423ylAWuRrb/kCJRElL8M6vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3UZcSMD22E0ZDun9Js4sfb9Q7YO2pN4OwP/ARhsg4W9XplFc4V5HpaFVNce1vQNg
	 zvyPJzQGxARz6drO1QKZwc0lDuj0oqMgbGFdOY7cUfhFLM8caCYMCpenLKJr/KRxod
	 vkGrg9x5BZ6izYWXrUGrCkzYK2YYcgINJ8O/+1xGyXt32SlWBAtemljm7E0ZpUt7hB
	 tJsuEOOLl+ixsfYK23QR41GUCz/XQFhYTYp3qoYPQbGQBn0k6/CmmF0O1zXatmxs6s
	 Z6+3dPT0BgiwKpPoN+heHxgIJbgLwTBc0V5uqVsmVhKw9wsssQM9skdZRnNZHKdPsZ
	 wdPv0t9HbPuxA==
Date: Thu, 18 Sep 2025 15:57:48 +0100
From: Will Deacon <will@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, linux-hardening@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
Message-ID: <aMwd7IJVECEy8mzf@willie-the-truck>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <98c9689f-157b-4fbb-b1b4-15e5a68e2d32@os.amperecomputing.com>
 <8e4e5648-9b70-4257-92c5-14c60928e240@arm.com>
 <8f7b3f4e-bf56-4030-952f-962291e53ccc@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f7b3f4e-bf56-4030-952f-962291e53ccc@arm.com>

On Thu, Sep 18, 2025 at 04:15:52PM +0200, Kevin Brodsky wrote:
> On 25/08/2025 09:31, Kevin Brodsky wrote:
> >>> Note: the performance impact of set_memory_pkey() is likely to be
> >>> relatively low on arm64 because the linear mapping uses PTE-level
> >>> descriptors only. This means that set_memory_pkey() simply changes the
> >>> attributes of some PTE descriptors. However, some systems may be able to
> >>> use higher-level descriptors in the future [5], meaning that
> >>> set_memory_pkey() may have to split mappings. Allocating page tables
> >> I'm supposed the page table hardening feature will be opt-in due to
> >> its overhead? If so I think you can just keep kernel linear mapping
> >> using PTE, just like debug page alloc.
> > Indeed, I don't expect it to be turned on by default (in defconfig). If
> > the overhead proves too large when block mappings are used, it seems
> > reasonable to force PTE mappings when kpkeys_hardened_pgtables is enabled.
> 
> I had a closer look at what happens when the linear map uses block
> mappings, rebasing this series on top of [1]. Unfortunately, this is
> worse than I thought: it does not work at all as things stand.
> 
> The main issue is that calling set_memory_pkey() in pagetable_*_ctor()
> can cause the linear map to be split, which requires new PTP(s) to be
> allocated, which means more nested call(s) to set_memory_pkey(). This
> explodes as a non-recursive lock is taken on that path.
> 
> More fundamentally, this cannot work unless we can explicitly allocate
> PTPs from either:
> 1. A pool of PTE-mapped pages
> 2. A pool of memory that is already mapped with the right pkey (at any
> level)
> 
> This is where I have to apologise to Rick for not having studied his
> series more thoroughly, as patch 17 [2] covers this issue very well in
> the commit message.
> 
> It seems fair to say there is no ideal or simple solution, though.
> Rick's patch reserves enough (PTE-mapped) memory for fully splitting the
> linear map, which is relatively simple but not very pleasant. Chatting
> with Ryan Roberts, we figured another approach, improving on solution 1
> mentioned in [2]. It would rely on allocating all PTPs from a special
> pool (without using set_memory_pkey() in pagetable_*_ctor), along those
> lines:
> 
> 1. 2 pages are reserved at all times (with the appropriate pkey)
> 2. Try to allocate a 2M block. If needed, use a reserved page as PMD to
> split a PUD. If successful, set its pkey - the entire block can now be
> used for PTPs. Replenish the reserve from the block if needed.
> 3. If no block is available, make an order-2 allocation (4 pages). If
> needed, use 1-2 reserved pages to split PUD/PMD. Set the pkey of the 4
> pages, take 1-2 pages to replenish the reserve if needed.
> 
> This ensures that we never run out of PTPs for splitting. We may get
> into an OOM situation more easily due to the order-2 requirement, but
> the risk remains low compared to requiring a 2M block. A bigger concern
> is concurrency - do we need a per-CPU cache? Reserving a 2M block per
> CPU could be very much overkill.
> 
> No matter which solution is used, this clearly increases the complexity
> of kpkeys_hardened_pgtables. Mike Rapoport has posted a number of RFCs
> [3][4] that aim at addressing this problem more generally, but no
> consensus seems to have emerged and I'm not sure they would completely
> solve this specific problem either.
> 
> For now, my plan is to stick to solution 3 from [2], i.e. force the
> linear map to be PTE-mapped. This is easily done on arm64 as it is the
> default, and is required for rodata=full, unless [1] is applied and the
> system supports BBML2_NOABORT. See [1] for the potential performance
> improvements we'd be missing out on (~5% ballpark). I'm not quite sure
> what the picture looks like on x86 - it may well be more significant as
> Rick suggested.

Just as a data point, but forcing the linear map down to 4k would likely
prevent us from being able to enable this on Android. We've measured a
considerable (double digit %) increase in CPU power consumption for some
real-life camera workloads when mapping the linear map at 4k granularity
thanks to the additional memory traffic from the PTW.

At some point, KFENCE required 4k granularity for the linear map, but we
fixed it. rodata=full requires 4k granularity, but there are patches to
fix that too. So I think we should avoid making the same mistake from
the start for this series.

Will
