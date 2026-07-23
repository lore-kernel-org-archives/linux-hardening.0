Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DABC32C8B;
	Thu, 23 Jul 2026 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786248; cv=none; b=blGeKIrkMZcyV3Kk/0cUX8SkCeuCaEAdZcYvgeMaXq5hRXTTPDD4wJtzQ4h/+Pk6yX+ba+PXa9A/gzKSwr1GwWdvG8Zatn2LaAUmP/fuXEZYUYAMxzwPcV3pxdBDp4kRfP72Rywy77VkK5taYr/+tx7AXp56qD+Rqzdv9zXkIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786248; c=relaxed/simple;
	bh=FdNXOOmzFJ56NMNtXW551REGWdO/3itmiVOQUjhNeJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddlI6SsR/nU8ZIrjyyycS6p4F7V8UhBKj8kK09aNl5eFUwdhbjl+e1mpX7Yn4HiISD/12kdKzrCWva42kyxP4ZVx0FYZypc0EC30tMAC/rg/SqyJD4IKN8PdweQPRYDrwFES9FMS0ozuOmYF2w6/jfPIvSulouioTqdHhLAwScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LOWpAtDo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LOWpAtDo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09D3F16F2;
	Wed, 22 Jul 2026 22:57:20 -0700 (PDT)
Received: from [10.164.19.44] (unknown [10.164.19.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 879BB3F66F;
	Wed, 22 Jul 2026 22:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784786244; bh=FdNXOOmzFJ56NMNtXW551REGWdO/3itmiVOQUjhNeJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LOWpAtDoTm28o2tE/1stUtYVbc0rRPQchkrnlB7RW/S9U6SE5nUU0Fwcrw4OOJ2K+
	 UHaD7IDWwYQSmFPfnOcf1eWhmM/bJE29QgK2J4WEgNqxJW8XEzaQNhlFk6wJOsnBd8
	 O1ttBL/Yxwa/JKbvG6S2DgbbCRHIYjFfwWgXN3Ko=
Message-ID: <e510fc4a-b3a1-4b7a-b10a-3306e75e8b66@arm.com>
Date: Thu, 23 Jul 2026 11:27:18 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc
 allocations
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, gustavoars@kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, david@kernel.org, urezki@gmail.com
References: <20260722142936.3287702-1-dev.jain@arm.com>
 <202607222102.E6A5679@keescook>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <202607222102.E6A5679@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/07/26 9:33 am, Kees Cook wrote:
> On Wed, Jul 22, 2026 at 02:29:35PM +0000, Dev Jain wrote:
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
> 
> Looks good to me! Can you update the LKDTM tests to check for this more
> tightened range check with a new vmalloc-based test?

Thanks. I have written the test, I'll send a v2 with it once the mm people
take a look at this.


> 
> If other mm folks can double-check this, I'll happily take this via the
> hardening tree.
> 
> Thanks!
> 
> -Kees
> 
>> ---
>> Applies on mm-new (3d18f3499c48).
>>
>>  mm/usercopy.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>> index 5de7a518b1b1c..772681aff8477 100644
>> --- a/mm/usercopy.c
>> +++ b/mm/usercopy.c
>> @@ -176,10 +176,28 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>>  
>>  	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
>>  		struct vmap_area *area = find_vmap_area(addr);
>> +		struct vm_struct *vm;
>>  
>>  		if (!area)
>>  			usercopy_abort("vmalloc", "no area", to_user, 0, n);
>>  
>> +		vm = area->vm;
>> +		/*
>> +		 * Mappings with a vm_struct track the originally requested
>> +		 * size. Check against that rather than the page-rounded
>> +		 * vmap_area->va_end so copies cannot reach vmalloc tail
>> +		 * padding. vmap mappings are always page aligned.
>> +		 */
>> +		if (vm && (vm->flags & VM_ALLOC) && vm->requested_size) {
>> +			unsigned long size = vm->requested_size;
>> +
>> +			offset = addr - area->va_start;
>> +			if (offset > size || n > size - offset)
>> +				usercopy_abort("vmalloc", NULL, to_user,
>> +					       offset, n);
>> +			return;
>> +		}
>> +
>>  		if (n > area->va_end - addr) {
>>  			offset = addr - area->va_start;
>>  			usercopy_abort("vmalloc", NULL, to_user, offset, n);
>> -- 
>> 2.43.0
>>
> 

