Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F91AF0A7;
	Wed,  1 Oct 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322529; cv=none; b=TLHkxSZtvCNPYUTZa71KY8KKuEe1QDmnqrok/2BntRZcgLQJ3/+6nloQ5OePWNuvYzEb1KqmG7g6QyPdyPJGyvW/BiW9IKELpaO0mlpTU8gU+I7DeONP9bojqqACvObvkmhjZwjikiX5ACi+Xhdri8G17vJKfOpyPySdQ/O3rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322529; c=relaxed/simple;
	bh=F5LVkSGuP0grf+Cx0GXmav5hrI0mc7MFUG1TfZ3PCig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW5zWMxmjmWiF1gLa0L0ioWK7Yppi+TCM8RfyGofTuZF398ytfW96suYsZiLdkIAf2h2cruMjxfsm6Z021A9Q9rPX/lW00TR0iWcQriySCwaWy37VmQupWMz7grEW5Ry0qeFGUcg/B8pwr1SR28gM/yKxIwHFNr8XW/N45u+7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A8CF16F2;
	Wed,  1 Oct 2025 05:41:58 -0700 (PDT)
Received: from [10.57.66.40] (unknown [10.57.66.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E1733F66E;
	Wed,  1 Oct 2025 05:42:00 -0700 (PDT)
Message-ID: <6dc0b5c8-b485-4fe1-b85b-7dcd00214d1b@arm.com>
Date: Wed, 1 Oct 2025 14:41:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc: "maz@kernel.org" <maz@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "mbland@motorola.com" <mbland@motorola.com>,
 "david@redhat.com" <david@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "joey.gouly@arm.com"
 <joey.gouly@arm.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "pierre.langlois@arm.com" <pierre.langlois@arm.com>,
 "jeffxu@chromium.org" <jeffxu@chromium.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "jannh@google.com" <jannh@google.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
 "qperret@google.com" <qperret@google.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <98c9689f-157b-4fbb-b1b4-15e5a68e2d32@os.amperecomputing.com>
 <8e4e5648-9b70-4257-92c5-14c60928e240@arm.com>
 <8f7b3f4e-bf56-4030-952f-962291e53ccc@arm.com>
 <6e5d24de6a6661f83442741f6be8daf691a05a20.camel@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <6e5d24de6a6661f83442741f6be8daf691a05a20.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2025 19:31, Edgecombe, Rick P wrote:
> On Thu, 2025-09-18 at 16:15 +0200, Kevin Brodsky wrote:
>> This is where I have to apologise to Rick for not having studied his
>> series more thoroughly, as patch 17 [2] covers this issue very well in
>> the commit message.
>>
>> It seems fair to say there is no ideal or simple solution, though.
>> Rick's patch reserves enough (PTE-mapped) memory for fully splitting the
>> linear map, which is relatively simple but not very pleasant. Chatting
>> with Ryan Roberts, we figured another approach, improving on solution 1
>> mentioned in [2]. It would rely on allocating all PTPs from a special
>> pool (without using set_memory_pkey() in pagetable_*_ctor), along those
>> lines:
> Oh I didn't realize ARM split the direct map now at runtime. IIRC it used to
> just map at 4k if there were any permissions configured.

Until recently the linear map was always PTE-mapped on arm64 if
rodata=full (default) or in other situations (e.g. DEBUG_PAGEALLOC), so
that it never needed to be split at runtime. Since [1b] landed though,
there is support for setting permissions at the block level and
splitting, meaning that the linear map can be block-mapped in most cases
(see force_pte_mapping() in patch 3 for details). This is only enabled
on systems with the BBML2_NOABORT feature though.

[1b]
https://lore.kernel.org/all/20250917190323.3828347-1-yang@os.amperecomputing.com/

>> 1. 2 pages are reserved at all times (with the appropriate pkey)
>> 2. Try to allocate a 2M block. If needed, use a reserved page as PMD to
>> split a PUD. If successful, set its pkey - the entire block can now be
>> used for PTPs. Replenish the reserve from the block if needed.
>> 3. If no block is available, make an order-2 allocation (4 pages). If
>> needed, use 1-2 reserved pages to split PUD/PMD. Set the pkey of the 4
>> pages, take 1-2 pages to replenish the reserve if needed.
> Oh, good idea!
>
>> This ensures that we never run out of PTPs for splitting. We may get
>> into an OOM situation more easily due to the order-2 requirement, but
>> the risk remains low compared to requiring a 2M block. A bigger concern
>> is concurrency - do we need a per-CPU cache? Reserving a 2M block per
>> CPU could be very much overkill.
>>
>> No matter which solution is used, this clearly increases the complexity
>> of kpkeys_hardened_pgtables. Mike Rapoport has posted a number of RFCs
>> [3][4] that aim at addressing this problem more generally, but no
>> consensus seems to have emerged and I'm not sure they would completely
>> solve this specific problem either.
>>
>> For now, my plan is to stick to solution 3 from [2], i.e. force the
>> linear map to be PTE-mapped. This is easily done on arm64 as it is the
>> default, and is required for rodata=full, unless [1] is applied and the
>> system supports BBML2_NOABORT. See [1] for the potential performance
>> improvements we'd be missing out on (~5% ballpark).
>>
> I continue to be surprised that allocation time pkey conversion is not a
> performance disaster, even with the directmap pre-split.
>
>> I'm not quite sure
>> what the picture looks like on x86 - it may well be more significant as
>> Rick suggested.
> I think having more efficient direct map permissions is a solvable problem, but
> each usage is just a little too small to justify the infrastructure for a good
> solution. And each simple solution is a little too much overhead to justify the
> usage. So there is a long tail of blocked usages:
>  - pkeys usages (page tables and secret protection)
>  - kernel shadow stacks
>  - More efficient executable code allocations (BPF, kprobe trampolines, etc)
>
> Although the BPF folks started doing their own thing for this. But I don't think
> there are any fundamentally unsolvable problems for a generic solution. It's a
> question of a leading killer usage to justify the infrastructure. Maybe it will
> be kernel shadow stack.
It seems to be exactly the situation yes. Given Will's feedback, I'll
try to implement such a dedicated allocator one more time (based on the
scheme I suggested above) and see how it goes. Hopefully that will
create more momentum for a generic infrastructure :) - Kevin
