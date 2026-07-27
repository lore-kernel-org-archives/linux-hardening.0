Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143831EBFE0;
	Mon, 27 Jul 2026 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135845; cv=none; b=hLRLKXYn544NeYamDu24XkI7GO5m74yw7Y/qyWbwjiIXnyiaGoMDWn1efJLHkh6AEBiR+cBQHUkjeNojyove4qtgOfstXb67qbyZEgynFznBdbYf4F+0MEW1fmXkCIN5ql6HiWXBCPkl6q0jyPOC2rTfwokrN62iF5ajcHr8u4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135845; c=relaxed/simple;
	bh=4ltq6LtZBqJVd3I7pMRg9u6HVMA61yXfYDc8FQY5yWE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=anId2Svs4QLsqjHDSTKBPENZQCOwzs2Y0vB9beXdHNM1ibvmGBBiZ9Frju1T1LAkv3zTc9Va/GeDhcLVwOhAKrB67bzvKrQ6gt/1ugOtMlZmFoC9lOuM6eG5+4c7vXVdD6FaGVLeKQd8I67HX02JhT3LA/4It5LjGMp9W3jyts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ifZFJuEU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ifZFJuEU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77D09143D;
	Mon, 27 Jul 2026 00:03:51 -0700 (PDT)
Received: from [10.164.19.51] (unknown [10.164.19.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE69E3F86F;
	Mon, 27 Jul 2026 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785135835; bh=4ltq6LtZBqJVd3I7pMRg9u6HVMA61yXfYDc8FQY5yWE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ifZFJuEU4VWNW/epbN4+hCZvMbZ69RlJEhdU1cImyCsU9NV6vfU3ttTkEghOFlwvz
	 WyVNZrWwQeebbS+fCJ88/AMYbNtcuQ6hVWTBqoLzSdhX2nZitlsOgyv8nBgVJ2Gag2
	 YrcwzppSiJI40iegLyh8rlslss0lNNIm/r6CUOBA=
Message-ID: <0a312983-3d63-4d60-8ff4-d53dcfff7819@arm.com>
Date: Mon, 27 Jul 2026 12:33:49 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc
 allocations
To: Matthew Wilcox <willy@infradead.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, gustavoars@kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, david@kernel.org, urezki@gmail.com
References: <20260722142936.3287702-1-dev.jain@arm.com>
 <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>
 <amXldUo3LfIGs-zs@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <amXldUo3LfIGs-zs@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/07/26 4:16 pm, Matthew Wilcox wrote:
> On Sun, Jul 26, 2026 at 02:23:20PM +0530, Dev Jain wrote:
>> On 22/07/26 7:59 pm, Dev Jain wrote:
>>> The vmalloc allocator stores the actual allocation size inside the
>>> vm_struct structure. We can use this bound in usercopy instead of the
>>> page-aligned va_end to catch usercopy beyond the actual allocation size.
>>>
>>> For vmap, the requested_size field is always page-aligned since it maps a
>>> certain number of pages. Same for vm_map_ram (alongwith, not even having
>>> a vm_struct). So the check is only relevant for vmalloc mappings.
>>>
>>> Because there are early vm areas registered even before vmalloc_init,
>>> requested_size may be zero. So also check whether the requested_size
>>> is set.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>
>> Sashiko:
>>
>> 1. "Does this locklessly access area->vm after find_vmap_area() has dropped
>> the busy tree lock?
>>
>> If an out-of-bounds pointer falls into an adjacent vmap_area, and that
>> adjacent area is concurrently freed by another thread, its vm_struct
>> is freed. Additionally, when the vmap_area is moved to the free tree,
>> area->vm (which shares a union with subtree_max_size) is overwritten
>> with an integer size.
>>
>> Would dereferencing vm->flags later in this function cause a use-after-free
>> or a wild pointer dereference?"
>>
>>
>> I don't get it. So usercopy is checking OOB for an object but shouldn't
>> assume the existence of that object while using it?
>>
>> It is a bug in the caller if someone does vfree() while usercopy is operating
>> on the vmalloc object. I don't think usercopy should handle it. For example
>> we don't handle it for slabs currently.
> 
> I think the question Sashiko is getting to is how we handle:
> 
> 	char *p = vmalloc();
> 	copy_to_user(p - 4);

Thanks Willy, I completely misread Sashiko's point.

I think this is an existing problem? We are using area->va_end currently,
so we can access freed memory.

But with my patch if the area is freed then area->vm can actually be
subtree_max_size. So now we use this unsigned long value as a bogus
pointer to retrieve ->flags and ->requested_size, and may accidentally
pass the check.

Trivially I can move my diff below the existing check to prevent this.

So now a copy_to/from_user() passing a pointer not lying in the vmalloc
page can be caught by the existing check. Then, my patch will always
retrieve the struct vmap_area of the vmalloc allocation we are checking.
So at least my patch won't regress anything from security PoV.


> 
> My quibble with this patch is that you've made this more precise at the
> cost of making it more expensive.  Is the extra precision worth the
> cost?  You're not running into anybody else's allocation (ie these pages
> are allocated to you exclusively), so I would tend to think not.  It's
> like calling kmalloc(93) and then accessing bytes 93-95.  It's out of
> bounds, but they're not anybody else's memory.

I hope Kees can jump in this as I am not a security expert :)


So the motivation of this patch is: From the perspective of security,
I am looking at ways to use arm64 MTE only when it really matters,
so we can get maximum security with as little MTE overhead.

Currently if we enable KASAN_HW_TAGS (i.e arm64 MTE), the kernel tags
vmalloc, slab and page allocator.

There is a measurable overhead for vmalloc and slab tagging. If you really
think about it, the semantics of the vmalloc allocator already give us
a lot of security.

There are broadly two ways an attacker exploits kernel (C, really) bugs:

1) OOB corrupting a member of the same object (type), and then using
that corrupted member to do nasty stuff

2) type confusion through

  a) UAF: Using the dangling pointer to access a freed object which has
	  now been reallocated to a different type

  b) OOB: Corrupting an adjacent object of a different type

I believe 1) cannot be stopped. A way of exploiting 1) is usercopy, but
vmalloc does not have an analogue of kmem_cache_create_usercopy().

2 (b) doesn't happen since a vmalloc page contains a single vmalloc object
(although I searched and there is weird code allocating a vmalloc page
and storing two different structs on it, let us assume this is rare enough)

2 (a) is stopped because vmalloc has a concept of lazy TLB flush: virtual
regions are freed into the lazy list.

The lazy list is flushed after certain parameters are met, so this gives a
vmalloc virtual region a natural "quarantine period" wherein a UAF cannot be
converted into type confusion. The dangling pointer can access memory it
already had which is not a security problem.

I just noticed that usercopy wasn't checking the actual allocation size in
vmalloc, so to further harden it without using MTE, I wrote this patch.

(Note that KASAN_HW_TAGS creates a "poisoned redzone" beyond the tail of
the allocation, so the concept itself is not new)


One way I can think of exploiting an OOB into the same page, is vrealloc()
extending into the attacker bytes. Following is a snippet of vrealloc code:


	/*
	 * We already have the bytes available in the allocation; use them.
	 */
	if (size <= alloced_size) {
		/*
		 * No need to zero memory here, as unused memory will have
		 * already been zeroed at initial allocation time or during
		 * realloc shrink time.
		 */
		vm->requested_size = size;
		kasan_vrealloc(p, old_size, size);
		return (void *)p;
	}



> 

