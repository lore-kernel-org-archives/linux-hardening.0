Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E2834251A;
	Tue, 27 Jan 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510482; cv=none; b=ZdDtPWOBIjXPxBva/QktIYqzG2rPw7t/lpjJfES3xdO4ii4vqgAjGYW22ey+nPiSL4b9EHUGUCRTIHzG3Wihyz+OupuBXTQNwl0sJBvDzFhpVLTBrzHl9CEfM5fZO+j4t4t2YWoWk7QAZoBXJcAvhgTXQ5PiavOay8663kKyZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510482; c=relaxed/simple;
	bh=zv5lK9tjxVO0n9izBY5BhoELfk0rMA3xB259NEaHDBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nj95142v0ls0lEzcrDoGs5iV8Ts6jQ+aMP1+cydpV3Hx2fjRDD8YbMJhBHvaqnz0E4QyO68tkGMlotW/rKj9s3oo/J/SHt3rik1wiAdhJ8Cl23piswBULE1LtcdtAnT4wPA8YgfM+gXY3i5UIJhA7bFBXql3BJYbimdzaYTZiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD5E91595;
	Tue, 27 Jan 2026 02:41:13 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E5813F73F;
	Tue, 27 Jan 2026 02:41:18 -0800 (PST)
Message-ID: <bb451854-0edd-4197-b1b0-50d1f1582c0b@arm.com>
Date: Tue, 27 Jan 2026 10:41:16 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] arm64: mm: Map the kernel data/bss read-only in
 the linear map
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-21-ardb+git@google.com>
 <62b1723a-2ff3-4cac-ad99-a0e8d388ef12@arm.com>
 <CAMj1kXHh2X0fWSZtN_xYQCwwwWKFJfBXaCec-BGXp3FDhE6S5g@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXHh2X0fWSZtN_xYQCwwwWKFJfBXaCec-BGXp3FDhE6S5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2026 10:36, Ard Biesheuvel wrote:
> On Tue, 27 Jan 2026 at 11:33, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 26/01/2026 09:26, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> On systems where the bootloader adheres to the original arm64 boot
>>> protocol, the placement of the kernel in the physical address space is
>>> highly predictable, and this makes the placement of its linear alias in
>>> the kernel virtual address space equally predictable, given the lack of
>>> randomization of the linear map.
>>>
>>> The linear aliases of the kernel text and rodata regions are already
>>> mapped read-only, but the kernel data and bss are mapped read-write in
>>> this region. This is not needed, so map them read-only as well.
>>>
>>> Note that the statically allocated kernel page tables do need to be
>>> modifiable via the linear map, so leave these mapped read-write.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm64/include/asm/sections.h |  1 +
>>>  arch/arm64/mm/mmu.c               | 10 ++++++++--
>>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
>>> index 51b0d594239e..f7fe2bcbfd03 100644
>>> --- a/arch/arm64/include/asm/sections.h
>>> +++ b/arch/arm64/include/asm/sections.h
>>> @@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
>>>  extern char __mmuoff_data_start[], __mmuoff_data_end[];
>>>  extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
>>>  extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
>>> +extern char __pgdir_start[];
>>>
>>>  static inline size_t entry_tramp_text_size(void)
>>>  {
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 18415d4743bf..fdbbb018adc5 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1122,7 +1122,9 @@ static void __init map_mem(void)
>>>  {
>>>       static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>>>       phys_addr_t kernel_start = __pa_symbol(_text);
>>> -     phys_addr_t kernel_end = __pa_symbol(__init_begin);
>>> +     phys_addr_t init_begin = __pa_symbol(__init_begin);
>>> +     phys_addr_t init_end = __pa_symbol(__init_end);
>>> +     phys_addr_t kernel_end = __pa_symbol(__pgdir_start);
>>>       phys_addr_t start, end;
>>>       phys_addr_t early_kfence_pool;
>>>       int flags = NO_EXEC_MAPPINGS;
>>> @@ -1158,7 +1160,9 @@ static void __init map_mem(void)
>>>        * Note that contiguous mappings cannot be remapped in this way,
>>>        * so we should avoid them here.
>>>        */
>>> -     __map_memblock(kernel_start, kernel_end, PAGE_KERNEL,
>>> +     __map_memblock(kernel_start, init_begin, PAGE_KERNEL,
>>> +                    flags | NO_CONT_MAPPINGS);
>>> +     __map_memblock(init_end, kernel_end, PAGE_KERNEL,
>>>                      flags | NO_CONT_MAPPINGS);
>>
>> I'm probably being dumb again... why map [init_end, kernel_end) RW here, only to
>> remap RO below? Why not just map RO here?
>>
> 
> Because the loop that iterates over the memblocks will remap it RW
> again anyway, so whether we map RW or RO at this point is irrelevant.
> This call just needs to occur here to ensure that no block mappings
> needs to be broken up later.

Ahh yes, got it.

> 
> 
>>>
>>>       /* map all the memory banks */
>>> @@ -1172,6 +1176,8 @@ static void __init map_mem(void)
>>>                              flags);
>>>       }
>>>
>>> +     __map_memblock(init_end, kernel_end, PAGE_KERNEL_RO,
>>> +                    flags | NO_CONT_MAPPINGS);
>>
>> This seems iffy since __map_memblock() doesn't flush the tlb. If you want to
>> update an existing mapping you want to be calling update_mapping_prot() right?
>>
> 
> Fair enough - I'll use that here.

