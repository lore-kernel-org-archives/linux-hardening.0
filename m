Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A76392C4B
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862335; cv=none; b=Lv2A3PZ9dBLFFm/sLzIha/WKeXqxYL89SxdxBiAlcl99Y6Fgjljgtean9t8flpJgaY6jLDj1ybj0G2ZhMOgNzFX3WXXvBoFVFpMV0F1uyFXyLTGhylF09G4fYvGruepbndFjmaqkJjPaDxhs515mXPSP/ZJvAcXQ4/QDIkONAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862335; c=relaxed/simple;
	bh=xlZC3OEZMV0/coWQyGMwBENJjfaFGyqN0Zg0ccer2wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYYEiWJZPL8LbgrP7difdEPVGfAMyH27PP+Yif1R9FZDyUSalBP2WkyedDQ/fcEhWdY8PC6NkRHIFgIDOls9qobC1Pv5EhT5iGLB8r0+qVArDfOxRmBbW8VJCWHRQSmH33ySyQzdQlr4RnXpdwF2iHIQ2zePU5optmvrxuUxTuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bq3wzFSn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bq3wzFSn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37FA41476;
	Tue,  8 Sep 2026 03:12:09 -0700 (PDT)
Received: from [10.57.7.202] (unknown [10.57.7.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34DD83F528;
	Tue,  8 Sep 2026 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788862332; bh=xlZC3OEZMV0/coWQyGMwBENJjfaFGyqN0Zg0ccer2wI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bq3wzFSnLt2zEXdSnnz8U9DC9OXdPlrslLiXfJfZ/k46iOwSa29UVewNF2oShj0Vu
	 /1YVazJsXb5vhqKLpsEUmyltbNMJhQZLlZtXH0OjNqzlNMIy0OoZofVpqolFOC9O0z
	 RpncI49u7gtPHlIbJmwbnR1eaq8VLcUU9Xix7Sik=
Message-ID: <00e97c75-eef1-4587-b299-ab07591a07bc@arm.com>
Date: Tue, 8 Sep 2026 12:11:57 +0200
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
 <bdba5b54-8733-4d47-952d-e1bd958a1ead@arm.com> <ap-6PZqGZHhPD6u1@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <ap-6PZqGZHhPD6u1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2026 09:33, Mike Rapoport wrote:
> On Mon, Sep 07, 2026 at 05:52:32PM +0200, Kevin Brodsky wrote:
>> On 07/09/2026 12:54, Mike Rapoport wrote:
>>>> [...]
>>>>
>>>>  static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int order)
>>>>  {
>>>> -	struct page *page = alloc_pages_noprof(gfp | __GFP_COMP, order);
>>>> +	struct page *page;
>>>> +
>>>> +	if (kpkeys_hardened_pgtables_enabled())
>>>> +		page = kpkeys_pgtable_alloc(gfp | __GFP_COMP, order);
>>>> +	else
>>>> +		page = alloc_pages_noprof(gfp | __GFP_COMP, order);
>>> Can we make it a sequence rahter than a branch?
>>>
>>> kpkeys_pgtable_alloc() does alloc_pages and then sets their pkeys, so I
>>> think something like this should work:
>>>
>>> 	page = alloc_pages_noprof(gfp | __GFP_COMP, order);
>>> 	if (!page)
>>> 		return NULL;
>>> 	err = kpkeys_pgtable_alloc(page);
>>> 	if (err) {
>>> 		__free_pages(page, order);
>>> 		return NULL;
>>>
>>> with if (kpkeys_hardened_pgtables_enabled()) folded into
>>> kpkeys_pgtable_alloc().
>> I agree this would be less ugly. In fact this is pretty much what this
>> series did up to RFC v5 (albeit in the ctor/dtor instead of alloc/free).
>> We could go back to this API, *but* the big issue is that it makes it
>> impossible to use a smarter allocation strategy for protected pages.
>> Patch 14 in RFC v6 [1] will give you an idea of what such an allocator
>> (with support for large blocks and splitting) would look like.
>>
>> As discussed with David H we're first trying to land this feature
>> without large block support (fully PTE-mapped direct map), but we do
>> want to support large blocks eventually [2] and I would prefer the core
>> API to be already compatible with that objective. Very happy to hear
>> about suggestions as to how to avoid the explicit condition in
>> pagetable_alloc() though!
> We could unconditionally replace alloc_pages_noprof() with
> kpkeys_pgtable_alloc() and make the latter choose the right allocator, but
> that's not very nice either :/

Yep I also thought of that but the naming would be really misleading...

Maybe, maybe, introduce __pagetable_alloc() that is a simple static
inline calling alloc_pages_noprof() if !CONFIG_KPKEYS_HARDENED_PGTABLES,
and otherwise checks kpkeys_hardened_pgtables_enabled()? Less ugliness
in pagetable_alloc() but even more further down, not sure this helps.

- Kevin
