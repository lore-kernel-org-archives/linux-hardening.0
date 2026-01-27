Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB9D308F2E;
	Tue, 27 Jan 2026 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511620; cv=none; b=CQrGJiBcUHjjawFBbivmlsf6EzG6WoCKZx5BacYXp8qgtoql7B/2jYgR0tRChKeUj7fzrejIKixyb9H+TkZxRUOY3FdPib8UOyNV5w7yFBxibvQ7WOKT6hdype9+RhMhMY8TSBOs0rmyCBfhwzQSB4f7ElhBJzEGFsYJrV3SceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511620; c=relaxed/simple;
	bh=QKnxDWufETh4QfxozWbIe1k8YF81ifo4SWJHl8+W3Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLfQNwAn1U/FcTx+45J6oIVQ7ecVzxLREgLuD08T4+zrGRq/Gma6gEjUERnrpC9bIqJ7eQSRMXgr2dZ+BBZc8Ny0ZjEcet9LlB0P8D9fds+SLPpL2W/nexKh5jhAQP0AuCell8O61iRV6Hrue7K061PgbRxNKhV6uFkV/b3YmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 518E11595;
	Tue, 27 Jan 2026 03:00:11 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2367A3F632;
	Tue, 27 Jan 2026 03:00:16 -0800 (PST)
Message-ID: <678f6b3f-8d1a-4253-8125-28b8ee89842b@arm.com>
Date: Tue, 27 Jan 2026 11:00:14 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] arm64: mm: Don't abuse memblock NOMAP to check
 for overlaps
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-20-ardb+git@google.com>
 <d0f2df03-21da-473f-ab89-64a964c18f08@arm.com>
 <CAMj1kXGsedZnV7GJZqo6Yfb4mi6YpMCu=fnHOwDib8-OxBij2g@mail.gmail.com>
 <1bd6e787-00af-4d4c-a882-a0b8fb7f6a2f@arm.com>
 <CAMj1kXEJPPWe4JE7SBYuQMcdTwQHvPqBO9Djj=tcW3DsNknkpw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXEJPPWe4JE7SBYuQMcdTwQHvPqBO9Djj=tcW3DsNknkpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2026 10:47, Ard Biesheuvel wrote:
> On Tue, 27 Jan 2026 at 11:39, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/01/2026 10:27, Ard Biesheuvel wrote:
>>> On Tue, 27 Jan 2026 at 11:21, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 26/01/2026 09:26, Ard Biesheuvel wrote:
>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>
>>>>> Now that the DRAM mapping routines respect existing table mappings and
>>>>> contiguous block and page mappings, it is no longer needed to fiddle
>>>>> with the memblock tables to set and clear the NOMAP attribute. Instead,
>>>>> map the kernel text and rodata alias first, avoiding contiguous
>>>>> mappings, so that they will not be added later when mapping the
>>>>> memblocks.
>>>>
>>>> Should we do something similar for kfence? Currently we have
>>>> arm64_kfence_alloc_pool() which marks some memory NOMAP then
>>>> arm64_kfence_map_pool() which PTE-maps it and clears NOMAP. Presumably we could
>>>> rationalize into a single function that does it all, prior to mapping the bulk
>>>> of the linear map?
>>>>
>>>
>>> Yeah, good point - I did not spot that but I will address it in the
>>> next revision.
>>>
>>>>>
>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>> ---
>>>>>  arch/arm64/mm/mmu.c | 27 ++++++++------------
>>>>>  1 file changed, 10 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>> index 80587cd47ce7..18415d4743bf 100644
>>>>> --- a/arch/arm64/mm/mmu.c
>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>> @@ -1149,12 +1149,17 @@ static void __init map_mem(void)
>>>>>               flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>>>
>>>>>       /*
>>>>> -      * Take care not to create a writable alias for the
>>>>> -      * read-only text and rodata sections of the kernel image.
>>>>> -      * So temporarily mark them as NOMAP to skip mappings in
>>>>> -      * the following for-loop
>>>>> +      * Map the linear alias of the [_text, __init_begin) interval
>>>>> +      * as non-executable now, and remove the write permission in
>>>>> +      * mark_linear_text_alias_ro() above (which will be called after
>>>>> +      * alternative patching has completed). This makes the contents
>>>>> +      * of the region accessible to subsystems such as hibernate,
>>>>> +      * but protects it from inadvertent modification or execution.
>>>>> +      * Note that contiguous mappings cannot be remapped in this way,
>>>>> +      * so we should avoid them here.
>>>>>        */
>>>>> -     memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>>>>> +     __map_memblock(kernel_start, kernel_end, PAGE_KERNEL,
>>>>> +                    flags | NO_CONT_MAPPINGS);
>>>>
>>>> So the reason to disallow cont mappings is because we need to modify the
>>>> permissions later? It _is_ safe to change permissions on a live contiguous
>>>> mapping in this way. That was clarified in the architecture a couple of years
>>>> back and we rely on it for contpte_wrprotect_ptes(); see comment there.
>>>>
>>>
>>> OK, good to know - I was hoping to get your take on this ...
>>>
>>>> I think we could relax this?
>>>>
>>>
>>> OK, I suppose that means that we can drop the NO_CONT_MAPPINGS here,
>>> but we still need to map the kernel text/rodata alias initially to
>>> ensure that no block mappings are created that would need to broken
>>> down, right?
>>
>> Yes, but...
>>
>> I think your intent is that the multiple __map_memblock() calls are just
>> controlling the allowed leaf mapping sizes.
> 
> Indeed.
> 
>> It becomes problematic if the 2
>> calls use different permissions... which they do.
>>
>> PAGE_KERNEL vs pgprot_tagged(PAGE_KERNEL).
>>
>> Is it possible that the text/rodata section ends up tagged, which is not intended?
>>
> 
> 
> OK so toggling the R/O attribute on a live contiguous mapping is
> permitted (provided that ultimately, the entire contiguous region is
> updated accordingly) but the same doesn't apply to MT_NORMAL vs
> MT_NORMAL_TAGGED, right?

This is the rule:

RJQQTC
For a TLB lookup in a contiguous region mapped by translation table entries that
have consistent values for the Contiguous bit, but have the OA, attributes, or
permissions misprogrammed, that TLB lookup is permitted to produce an OA, access
permissions, and memory attributes that are consistent with any one of the
programmed translation table values.

So, yes, it is fine to modify the attributes (and I assume the memory type
counts as attributes) on the live mapping...

> 
> So let's use just the same prot and flags for the initial mapping, and
> use MT_NORMAL_TAGGED when we remap the text alias R/O.

...but that wasn't my point. I belive the intent is that all of the linear map
uses MT_NORMAL_TAGGED except for the kernel text and rodata, which uses
MT_NORMAL. In some configs (e.g. force_pte_mapping() == true), your change will
result in all the linear map, including text and rodata being MT_NORMAL_TAGGED.

Thanks,
Ryan

