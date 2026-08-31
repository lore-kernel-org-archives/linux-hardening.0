Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B48E46E010
	for <linux-hardening@vger.kernel.org>; Mon, 31 Aug 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190121; cv=none; b=t+M+ElzPhdXaZWP5mWD9/vYkhsVmRLCsapcTo9AHMeneJEWoeVW+Sr2uy7TOJLc8aowxg4gyGhcc5yQsilPY7M8ByE0TWMJLziTX9xeR7jmjd0JqV/BISohuR59PqEF/Bo9AyzrgI/CnlKihzYR7ydAIdKf8JDzJjJeujVJO/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190121; c=relaxed/simple;
	bh=SuDeWaf7WgpqHSI1yoOLmbbz1EkZzpYkobKoVll1c/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o77JoM8byTMlmUrFhef837bwmu8uK7SiPlwyb0mOEUv9HQdr6kKMt19R8TKkvU6d5EVn60DkqJ7vjpG/fo1YYDwTo3LdAIkbkYrsuwpQNsu6MJak9aMYaC62+V7NaiTnVPtLvT8ZXBvAkbfmvoaWODd3jI2Jpt8Grfe2Em5QZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CREezQe4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CREezQe4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B49A14BF;
	Mon, 31 Aug 2026 08:28:34 -0700 (PDT)
Received: from [10.57.6.141] (unknown [10.57.6.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3BBE3F882;
	Mon, 31 Aug 2026 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788190118; bh=SuDeWaf7WgpqHSI1yoOLmbbz1EkZzpYkobKoVll1c/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CREezQe4GnXa4C8RGGDKvHVjF22t/L5J5b6UfZ5AXfZ4spJQ1gMP8m1du77D9yAnj
	 xflZERFG8KqRDlopy1LEHijk2M/I09pIur66mG5W1QsRPHMLbWbvd2DFbNAL2icWhg
	 drjXdEdwODQ0wCXxFG7WTRhQtDzhabUMNmya4Kds=
Message-ID: <7af32e98-f2ab-4961-9e3c-72b8a21416c0@arm.com>
Date: Mon, 31 Aug 2026 17:28:29 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 13/25] mm: kpkeys: Introduce early page table
 allocator
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 linux-hardening@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
 Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
 Linu Cherian <linu.cherian@arm.com>, Linus Walleij <linusw@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
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
 <20260818-kpkeys-v9-13-743ad31b2c8f@arm.com>
 <1dc8739e-4eb6-4a71-9534-e03a15afd620@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <1dc8739e-4eb6-4a71-9534-e03a15afd620@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 20:08, David Hildenbrand (Arm) wrote:
> On 8/18/26 16:08, Kevin Brodsky wrote:
>> The kpkeys_hardened_pgtables feature aims to protect all page table
>> pages (PTPs) by mapping them with a privileged pkey. This is primarily
>> handled by kpkeys_pgtable_alloc(), called from pagetable_alloc().
>> However, this does not cover PTPs allocated early, before the
>> buddy allocator is available. These PTPs are allocated by architecture
>> code, either 1. from static pools or 2. using the memblock allocator,
>> and should also be protected.
>>
>> This patch addresses the second category: PTPs allocated via memblock.
>> Such PTPs are notably used to create the linear map. Protecting them as
>> soon as they are allocated would require modifying the linear map while
>> it is being created, which seems at best difficult. Instead, a
>> simple allocator is introduced, obtaining pages from memblock and
>> keeping track of all allocated ranges to set their pkey once it is
>> safe to do so. PTPs allocated at that stage are not freed, so there
>> is no need to manage a free list.
> I'm think of ways to avoid remembering these ranges. I guess we get called that
> early that we don't even have a ptdesc where we could just link the pages.

Correct, in both the direct map and (early) vmemmap cases we can't rely
on struct page as storage.

> If only page tables would be linked in some datastructure where we could find
> them all ... ;)
>
> ... why can't we just scan the page table hierarchy to find all page tables that
> need protection?

It makes sense doesn't it :) In fact this is exactly what RFC v5 did [1]
(a year ago already...). Then in RFC v6 I attempted to support block
mappings, and things got a lot more complicated. In that case there are
(at least) two issues with protecting the early page tables by walking them:

1. On arm64 with BBML3 we cannot split blocks in the direct map until
all secondary cores are up. This makes locking pretty difficult if we're
to walk all page tables at that later stage.

2. Without modifying the allocation strategy, early page tables may not
be contiguous and setting their pkey would generate fragmentation.

Naturally neither of these issues is relevant to the present series,
where we force page granularity in the direct map. I still kept the same
approach as in RFC v6 though, as the goal remains to support block
mappings eventually.

That said, as discussed offline it may be sensible to revert to the
"walk early page tables" approach to start with, even if we would
probably need to change it later. This allows us to drop quite a few
patches, since init_pg_dir no longer needs to be explicitly protected.

One caveat is that in RFC v5, any page table page installed after
smp_prepare_boot_cpu() is called, and allocated using memblock (or
anything else but the buddy allocator), won't be protected. Codex can't
find any such case though so we should be good for now.

- Kevin

[1]
https://lore.kernel.org/linux-hardening/20250815085512.2182322-11-kevin.brodsky@arm.com/

