Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE337BE7B;
	Sun, 26 Jul 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785056332; cv=none; b=IeV3qktu+zMeHxbmuZubHCEkRI6oYoR5BO5Jj2hpqnCCmkEJFcW/OzDpRpGrzN7gGVqbU3RqmQD2ad8SXH9ZjjRKNTJkvnrw/3PQUGWhg8mQe6iP4uqHhCUADMIwlDAswZDG72MARXNbsJFNbjMkiVeY/OZ9hyoh62bh85x6q/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785056332; c=relaxed/simple;
	bh=HsTk2zi9LsNnreXaT5/Xhg6wgsUc7xZ+m0lgwTS04jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz80TP6RfL2rDZqT5uQPjn/JjbqleoeEWbFNPs9jg9KsLlFrbfc3v4/g0A4x5gI+LInwfTQRM+6JDeDwyBTnIE8Yk4NtHdrOPVJsqizmfM1FN64pRUVataepnCsr7im/h7OEV01wpR3IU56KyG/XKM21YWISMGsFnvqf7m2OfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=luZCEai/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="luZCEai/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FF4F2F;
	Sun, 26 Jul 2026 01:53:21 -0700 (PDT)
Received: from [10.164.11.0] (unknown [10.164.11.0])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120E13F86F;
	Sun, 26 Jul 2026 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785056005; bh=HsTk2zi9LsNnreXaT5/Xhg6wgsUc7xZ+m0lgwTS04jI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=luZCEai/ghbSmVGHX/P+9p6g7yYiIjeo7lSLfGz5eW/tFCmfFNcvaFXmOPw685ClY
	 b7U94Rpqam/lyWk5QMMocOJsHcmLOXhxthD8sOfUwLDLQwGjE1JxooGWI1uoa8MQeR
	 n1kgMVCneffHRTUED32NkBqzfaVKhRU9MlKbthes=
Message-ID: <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>
Date: Sun, 26 Jul 2026 14:23:20 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc
 allocations
To: kees@kernel.org, akpm@linux-foundation.org
Cc: gustavoars@kernel.org, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, david@kernel.org, urezki@gmail.com
References: <20260722142936.3287702-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260722142936.3287702-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/07/26 7:59 pm, Dev Jain wrote:
> The vmalloc allocator stores the actual allocation size inside the
> vm_struct structure. We can use this bound in usercopy instead of the
> page-aligned va_end to catch usercopy beyond the actual allocation size.
> 
> For vmap, the requested_size field is always page-aligned since it maps a
> certain number of pages. Same for vm_map_ram (alongwith, not even having
> a vm_struct). So the check is only relevant for vmalloc mappings.
> 
> Because there are early vm areas registered even before vmalloc_init,
> requested_size may be zero. So also check whether the requested_size
> is set.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

Sashiko:

1. "Does this locklessly access area->vm after find_vmap_area() has dropped
the busy tree lock?

If an out-of-bounds pointer falls into an adjacent vmap_area, and that
adjacent area is concurrently freed by another thread, its vm_struct
is freed. Additionally, when the vmap_area is moved to the free tree,
area->vm (which shares a union with subtree_max_size) is overwritten
with an integer size.

Would dereferencing vm->flags later in this function cause a use-after-free
or a wild pointer dereference?"


I don't get it. So usercopy is checking OOB for an object but shouldn't
assume the existence of that object while using it?

It is a bug in the caller if someone does vfree() while usercopy is operating
on the vmalloc object. I don't think usercopy should handle it. For example
we don't handle it for slabs currently.


2. "Can addr still have hardware KASAN tags (like ARM64 MTE) attached in the
top byte here?

Because check_heap_object() casts ptr to addr without calling
kasan_reset_tag(), a tagged address will be numerically different from
untagged kernel addresses. When calculating offset against the untagged
area->va_start, this could underflow or produce a massive unsigned value.

Could this cause the offset > size check to evaluate to true, triggering a
spurious usercopy_abort() for valid usercopies on HW-tagged vmalloc memory?"


This looks genuine. check_heap_object() should be doing a kasan_reset_tag().
We probably didn't catch this because no one is running CONFIG_HARDENED_USERCOPY
with KASAN enabled, since the latter kind-of already stops the OOB bugs.

Even if they did, mostly we care about slab OOB's I think, and the __check_heap_object
in mm/slub.c does a kasan_reset_tag() already.


> Applies on mm-new (3d18f3499c48).
> 
>  mm/usercopy.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 5de7a518b1b1c..772681aff8477 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -176,10 +176,28 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  
>  	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
>  		struct vmap_area *area = find_vmap_area(addr);
> +		struct vm_struct *vm;
>  
>  		if (!area)
>  			usercopy_abort("vmalloc", "no area", to_user, 0, n);
>  
> +		vm = area->vm;
> +		/*
> +		 * Mappings with a vm_struct track the originally requested
> +		 * size. Check against that rather than the page-rounded
> +		 * vmap_area->va_end so copies cannot reach vmalloc tail
> +		 * padding. vmap mappings are always page aligned.
> +		 */
> +		if (vm && (vm->flags & VM_ALLOC) && vm->requested_size) {
> +			unsigned long size = vm->requested_size;
> +
> +			offset = addr - area->va_start;
> +			if (offset > size || n > size - offset)
> +				usercopy_abort("vmalloc", NULL, to_user,
> +					       offset, n);
> +			return;
> +		}
> +
>  		if (n > area->va_end - addr) {
>  			offset = addr - area->va_start;
>  			usercopy_abort("vmalloc", NULL, to_user, offset, n);

