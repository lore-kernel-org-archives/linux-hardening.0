Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC262343D9B;
	Wed, 27 Aug 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310953; cv=none; b=O5Rgu/sKOn7IRjJlReeD/Pfpv7VkVA9KvXq+10QdTfNrDt7voy16hxryurky7jv0KYlmhZpejhei0jmFUqt6v+KpgsUduv0mPatLRRc/GiYQE6BkTIaKx98IlbY30nSo8K90xCbl8HYzVyMC5bXHOSpsnpY+eunK2YF634xIQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310953; c=relaxed/simple;
	bh=2FIZ5aJCiTKj3kPm7g09Z5KJppD3cqCl82AjidiHnlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7VZ5mVDdejDuvaApTneYRJV0hh6sNuPZIgIDl8L/NWbgRUeMePFDfTW3S0z6Wc6wDjvQ8cxyznE6UjqI5HJ0kqb751Rijw41PVirM9MAQdZFcMJdEokTwnHVsxMLvTXVzujAFQ3OqhrryXjRTbFEPnBr0RCqO9ePsc0kN/VK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C752B2720;
	Wed, 27 Aug 2025 09:09:02 -0700 (PDT)
Received: from [172.31.18.237] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CF663F738;
	Wed, 27 Aug 2025 09:09:05 -0700 (PDT)
Message-ID: <b9212134-0efa-422d-8cbf-4761e39ce8d6@arm.com>
Date: Wed, 27 Aug 2025 18:09:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
To: Yang Shi <yang@os.amperecomputing.com>, linux-hardening@vger.kernel.org
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
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <98c9689f-157b-4fbb-b1b4-15e5a68e2d32@os.amperecomputing.com>
 <8e4e5648-9b70-4257-92c5-14c60928e240@arm.com>
 <939ac25a-096f-46b3-90c1-d8cd6a9e445e@os.amperecomputing.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <939ac25a-096f-46b3-90c1-d8cd6a9e445e@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/08/2025 21:18, Yang Shi wrote:
>>
>>>> from a contiguous cache of pages could help minimise the overhead, as
>>>> proposed for x86 in [1].
>>> I'm a little bit confused about how this can work. The contiguous
>>> cache of pages should be some large page, for example, 2M. But the
>>> page table pages allocated from the cache may have different
>>> permissions if I understand correctly. The default permission is RO,
>>> but some of them may become R/W at sometime, for example, when calling
>>> set_pte_at(). You still need to split the linear mapping, right?
>> When such a helper is called, *all* PTPs become writeable - there is no
>> per-PTP permission switching.
>
> OK, so all PTPs in the same contiguous cache will become writeable
> even though the helper (i.e. set_pte_at()) is just called on one of
> the PTPs.  But doesn't it compromise the page table hardening somehow?
> The PTPs from the same cache may belong to different processes. 

First just a note that this is true regardless of how the PTPs are
allocated (i.e. this is already the case in this version of the series).

Either way, yes you are right, this approach does not introduce any
isolation *between* page tables - pgtable helpers are able to write to
all page tables. In principle it should be possible to use a different
pkey for kernel and user page tables, but that would make the kpkeys
level switching in helpers quite a bit more complicated. Isolating
further is impractical as we have so few pkeys (just 8 on arm64).

That said, what kpkeys really tries to protect against is the direct
corruption of critical data by arbitrary (unprivileged) code. If the
attacker is able to manipulate calls to set_pte() and the likes, kpkeys
cannot provide much protection - even if we restricted the writes to a
specific set of page tables, the attacker would still be able to insert
a translation to any arbitrary physical page.

- Kevin
