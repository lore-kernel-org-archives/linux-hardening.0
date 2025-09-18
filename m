Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EEE308F2B;
	Thu, 18 Sep 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204963; cv=none; b=BImUt5UPHWX5yb4K4UCnW2/NGINiQyJzM3g6KbN/iPM9Ma+q37e4Ul6e8Gy+WciSOWgjR8Pztq6R0SXzu+pjKr3eRVQdqKUNz42/kxtZlpaT0JkvLl4Pa2j1miS0j67bfyk0uPjLaw8vKDbbwfdT9r3Q003diVrWdxrR0cHu1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204963; c=relaxed/simple;
	bh=IDKOmDGdu4sjB+ajHbqv5oUDzo9Irz8OQyk6bFWkfJU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W2qvRjmEfQ/QYVELIoMP596olztz9xbe670qwEYQgqsqZj7pMwGDKAS/bBAP9kzIwNyrdTsjFqOatUe2tpvIaoSD0jfdbAzFRpLg/oI0n1gATA/gHUekrJ9qQ5D79XPx3cBluGZbKFPHVZF7mEE0hDZjGqqswwGVgGu643pC8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A88C1A25;
	Thu, 18 Sep 2025 07:15:52 -0700 (PDT)
Received: from [10.57.71.56] (unknown [10.57.71.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D05013F673;
	Thu, 18 Sep 2025 07:15:54 -0700 (PDT)
Message-ID: <8f7b3f4e-bf56-4030-952f-962291e53ccc@arm.com>
Date: Thu, 18 Sep 2025 16:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>, linux-hardening@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
 Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <98c9689f-157b-4fbb-b1b4-15e5a68e2d32@os.amperecomputing.com>
 <8e4e5648-9b70-4257-92c5-14c60928e240@arm.com>
Content-Language: en-GB
In-Reply-To: <8e4e5648-9b70-4257-92c5-14c60928e240@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2025 09:31, Kevin Brodsky wrote:
>>> Note: the performance impact of set_memory_pkey() is likely to be
>>> relatively low on arm64 because the linear mapping uses PTE-level
>>> descriptors only. This means that set_memory_pkey() simply changes the
>>> attributes of some PTE descriptors. However, some systems may be able to
>>> use higher-level descriptors in the future [5], meaning that
>>> set_memory_pkey() may have to split mappings. Allocating page tables
>> I'm supposed the page table hardening feature will be opt-in due to
>> its overhead? If so I think you can just keep kernel linear mapping
>> using PTE, just like debug page alloc.
> Indeed, I don't expect it to be turned on by default (in defconfig). If
> the overhead proves too large when block mappings are used, it seems
> reasonable to force PTE mappings when kpkeys_hardened_pgtables is enabled.

I had a closer look at what happens when the linear map uses block
mappings, rebasing this series on top of [1]. Unfortunately, this is
worse than I thought: it does not work at all as things stand.

The main issue is that calling set_memory_pkey() in pagetable_*_ctor()
can cause the linear map to be split, which requires new PTP(s) to be
allocated, which means more nested call(s) to set_memory_pkey(). This
explodes as a non-recursive lock is taken on that path.

More fundamentally, this cannot work unless we can explicitly allocate
PTPs from either:
1. A pool of PTE-mapped pages
2. A pool of memory that is already mapped with the right pkey (at any
level)

This is where I have to apologise to Rick for not having studied his
series more thoroughly, as patch 17 [2] covers this issue very well in
the commit message.

It seems fair to say there is no ideal or simple solution, though.
Rick's patch reserves enough (PTE-mapped) memory for fully splitting the
linear map, which is relatively simple but not very pleasant. Chatting
with Ryan Roberts, we figured another approach, improving on solution 1
mentioned in [2]. It would rely on allocating all PTPs from a special
pool (without using set_memory_pkey() in pagetable_*_ctor), along those
lines:

1. 2 pages are reserved at all times (with the appropriate pkey)
2. Try to allocate a 2M block. If needed, use a reserved page as PMD to
split a PUD. If successful, set its pkey - the entire block can now be
used for PTPs. Replenish the reserve from the block if needed.
3. If no block is available, make an order-2 allocation (4 pages). If
needed, use 1-2 reserved pages to split PUD/PMD. Set the pkey of the 4
pages, take 1-2 pages to replenish the reserve if needed.

This ensures that we never run out of PTPs for splitting. We may get
into an OOM situation more easily due to the order-2 requirement, but
the risk remains low compared to requiring a 2M block. A bigger concern
is concurrency - do we need a per-CPU cache? Reserving a 2M block per
CPU could be very much overkill.

No matter which solution is used, this clearly increases the complexity
of kpkeys_hardened_pgtables. Mike Rapoport has posted a number of RFCs
[3][4] that aim at addressing this problem more generally, but no
consensus seems to have emerged and I'm not sure they would completely
solve this specific problem either.

For now, my plan is to stick to solution 3 from [2], i.e. force the
linear map to be PTE-mapped. This is easily done on arm64 as it is the
default, and is required for rodata=full, unless [1] is applied and the
system supports BBML2_NOABORT. See [1] for the potential performance
improvements we'd be missing out on (~5% ballpark). I'm not quite sure
what the picture looks like on x86 - it may well be more significant as
Rick suggested.

- Kevin

[1]
https://lore.kernel.org/all/20250829115250.2395585-1-ryan.roberts@arm.com/
[2]
https://lore.kernel.org/all/20210830235927.6443-18-rick.p.edgecombe@intel.com/
[3] https://lore.kernel.org/lkml/20210823132513.15836-1-rppt@kernel.org/
[4] https://lore.kernel.org/all/20230308094106.227365-1-rppt@kernel.org/
