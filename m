Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D8E42E413
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796364; cv=none; b=adPkwVbV9YJZwhH3x26A7WzXu2s0yAYoa3EBLyykZaCvFFtxzceMIueftsTWs00ifPr2M5N222d3Vr+RSrm4lljrXSvtjE8qSyvOxLKLDXsP1Wtp7jg0HgJGxdWRB/HBY8zFVlbSVXu2sVCv7tLi+titW6YHNgta7ukPM7LX0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796364; c=relaxed/simple;
	bh=1M0VbCBYRIVwvuz1Ziz5LEHR5vyGozoVj/HRYFkUpHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA6Oe8P8VH3L1YQH/tp+Sr49R0rP+aA8VVc+tT6EfTK3L3gEQdbxuOAYt4DutMvqjOeqoOeLIGvMAR9E62yUQO9jxMNql+Ke4uJnRRilTvTF5ooywEcR+ROHrizTb12PemFsQDD7ErGv1eIot+Et7iwIPIKqG5vN0vAruKKVlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iW1r4M47; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iW1r4M47"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F861477;
	Mon,  7 Sep 2026 08:52:38 -0700 (PDT)
Received: from [10.57.6.26] (unknown [10.57.6.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60473F7B4;
	Mon,  7 Sep 2026 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788796362; bh=1M0VbCBYRIVwvuz1Ziz5LEHR5vyGozoVj/HRYFkUpHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iW1r4M47ZzYRpwxcxdOYtGK95O9RFQq3qSOfQBkbNtQb6iyGGZJq1Qq7WyOSdxPQS
	 tiShrG7ZcImz3k48GHsbWe18tgI+V91qts8G+Ozl/c1K/FnMZbBAW99fxzFgwYDpeM
	 ak7fGiCiqqU5MYmeGM83AcxJymFeIBMfc/qcUG8k=
Message-ID: <bdba5b54-8733-4d47-952d-e1bd958a1ead@arm.com>
Date: Mon, 7 Sep 2026 17:52:32 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 12/25] mm: kpkeys: Protect regular page tables
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>,
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-12-743ad31b2c8f@arm.com>
 <178877845406.3691569.12554855722197968629.b4-review@b4>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <178877845406.3691569.12554855722197968629.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2026 12:54, Mike Rapoport wrote:
>> [...]
>>
>>  static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int order)
>>  {
>> -	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
>> +	struct page *page;
>> +
>> +	if (kpkeys_hardened_pgtables_enabled())
>> +		page = kpkeys_pgtable_alloc(gfp | __GFP_COMP, order);
>> +	else
>> +		page = alloc_pages_noprof(gfp | __GFP_COMP, order);
> Can we make it a sequence rahter than a branch?
>
> kpkeys_pgtable_alloc() does alloc_pages and then sets their pkeys, so I
> think something like this should work:
>
> 	page = alloc_pages_noprof(gfp | __GFP_COMP, order);
> 	if (!page)
> 		return NULL;
> 	err = kpkeys_pgtable_alloc(page);
> 	if (err) {
> 		__free_pages(page, order);
> 		return NULL;
>
> with if (kpkeys_hardened_pgtables_enabled()) folded into
> kpkeys_pgtable_alloc().

I agree this would be less ugly. In fact this is pretty much what this
series did up to RFC v5 (albeit in the ctor/dtor instead of alloc/free).
We could go back to this API, *but* the big issue is that it makes it
impossible to use a smarter allocation strategy for protected pages.
Patch 14 in RFC v6 [1] will give you an idea of what such an allocator
(with support for large blocks and splitting) would look like.

As discussed with David H we're first trying to land this feature
without large block support (fully PTE-mapped direct map), but we do
want to support large blocks eventually [2] and I would prefer the core
API to be already compatible with that objective. Very happy to hear
about suggestions as to how to avoid the explicit condition in
pagetable_alloc() though!

- Kevin

[1]
https://lore.kernel.org/linux-hardening/20260227175518.3728055-15-kevin.brodsky@arm.com/
[2] https://lore.kernel.org/all/aMwd7IJVECEy8mzf@willie-the-truck/
