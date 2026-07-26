Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B2768EA;
	Sun, 26 Jul 2026 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785056112; cv=none; b=nye+JQP7EBLckctd8bLvzaGzHjxL3oOfag84idrkKI+KHXr4kxb8PtUQ7sxXQt01lpnMsf4IgQQKR4dMDD1ZePSMOmuCOqUoy7OdLgaltEPlPKz2dqAueBetGe02/kfkumvyH4M+Dy7kbZYPj+d6t+84RTHZZakFgXjxHhEfMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785056112; c=relaxed/simple;
	bh=B8VxLtUEWm05ZdkQT5GF34OFvxULa9Qs32lGvh5m4W0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uGt8vbc+0KDJbk36Gmg310ohRK1lVFJSgQUxXPEpsqhGK/29R/TnRAwMIAIG9v7vCOTXO12Q9sCrLSrA26MIGj2jNu4rX6Iyt4FUcCnbtbve/ptsL/ZFbqijRkgy/XOfnsEq5HNQi83X8g9CZ6pwAPYT/rdvRzmaoIwQScQMtGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m0xK5Px4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m0xK5Px4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30D8339;
	Sun, 26 Jul 2026 01:55:05 -0700 (PDT)
Received: from [10.164.11.0] (unknown [10.164.11.0])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77BEC3F86F;
	Sun, 26 Jul 2026 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785056110; bh=B8VxLtUEWm05ZdkQT5GF34OFvxULa9Qs32lGvh5m4W0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=m0xK5Px462Tdkk8/a8tejI65BdEdLV2kdmwsjuendkcPeZHNW++/uyhcg5EThmU0x
	 YNRjzaNhyZlO2XipAKPK5rstDmXP8atv6mE54T4XYyWx+7ZYqzLFxogYyNw6M1lEEM
	 xItu+sptKlW2borPTneoqRMYRa5LVthxpC1Rf1wM=
Message-ID: <4e140f87-2928-4c87-b075-153a111884df@arm.com>
Date: Sun, 26 Jul 2026 14:25:04 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc
 allocations
From: Dev Jain <dev.jain@arm.com>
To: kees@kernel.org, akpm@linux-foundation.org
Cc: gustavoars@kernel.org, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, david@kernel.org, urezki@gmail.com
References: <20260722142936.3287702-1-dev.jain@arm.com>
 <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>
Content-Language: en-US
In-Reply-To: <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/07/26 2:23 pm, Dev Jain wrote:
> 
> 
> On 22/07/26 7:59 pm, Dev Jain wrote:
>> The vmalloc allocator stores the actual allocation size inside the
>> vm_struct structure. We can use this bound in usercopy instead of the
>> page-aligned va_end to catch usercopy beyond the actual allocation size.
>>
>> For vmap, the requested_size field is always page-aligned since it maps a
>> certain number of pages. Same for vm_map_ram (alongwith, not even having
>> a vm_struct). So the check is only relevant for vmalloc mappings.
>>
>> Because there are early vm areas registered even before vmalloc_init,
>> requested_size may be zero. So also check whether the requested_size
>> is set.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
> 
> Sashiko:
> 
> 1. "Does this locklessly access area->vm after find_vmap_area() has dropped
> the busy tree lock?
> 
> If an out-of-bounds pointer falls into an adjacent vmap_area, and that
> adjacent area is concurrently freed by another thread, its vm_struct
> is freed. Additionally, when the vmap_area is moved to the free tree,
> area->vm (which shares a union with subtree_max_size) is overwritten
> with an integer size.
> 
> Would dereferencing vm->flags later in this function cause a use-after-free
> or a wild pointer dereference?"
> 
> 
> I don't get it. So usercopy is checking OOB for an object but shouldn't
> assume the existence of that object while using it?
> 
> It is a bug in the caller if someone does vfree() while usercopy is operating
> on the vmalloc object. I don't think usercopy should handle it. For example
> we don't handle it for slabs currently.
> 
> 
> 2. "Can addr still have hardware KASAN tags (like ARM64 MTE) attached in the
> top byte here?
> 
> Because check_heap_object() casts ptr to addr without calling
> kasan_reset_tag(), a tagged address will be numerically different from
> untagged kernel addresses. When calculating offset against the untagged
> area->va_start, this could underflow or produce a massive unsigned value.
> 
> Could this cause the offset > size check to evaluate to true, triggering a
> spurious usercopy_abort() for valid usercopies on HW-tagged vmalloc memory?"
> 
> 
> This looks genuine. check_heap_object() should be doing a kasan_reset_tag().
> We probably didn't catch this because no one is running CONFIG_HARDENED_USERCOPY
> with KASAN enabled, since the latter kind-of already stops the OOB bugs.
> 
> Even if they did, mostly we care about slab OOB's I think, and the __check_heap_object
> in mm/slub.c does a kasan_reset_tag() already.


To be clear, this is an existing bug, so shouldn't stop this patch from going in.


