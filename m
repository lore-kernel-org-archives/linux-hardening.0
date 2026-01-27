Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621D30AD06;
	Tue, 27 Jan 2026 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511776; cv=none; b=Vkm5HrE6jlLtdY4F/UiK6L+8WZXJhZ52ua6I5RiYdVHwxuFyE7CQt83kAVvPF+Pti1qpUFa1Ks17sATTlL2cnMTzwcOQm/Ot68x0Ey84kIa7Hz8oMGAcVVFBthBvHJAmN7cTuAjXjEp3YpBi0Hgdfe7438vW8npoGgogu47sKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511776; c=relaxed/simple;
	bh=Q8Y+TflVioNAldzPa+3mSbnQFa04093Rh5NmJoiX8lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma8XbKEqbC8RKLPI1bHooA65eNw02jOqRK8msfTJ0LAqiE24IMv15qFmYrOz6cVTLHOCw/uDwlcneZqCm3073cixkFml9AC83dPY8Oy2YIFg3ipwFhgbTX4btjvW0bxcKqDQGSpHKrJnPlXtbw2HJgDtJiZly9yARKxwMZ71h3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB99B1595;
	Tue, 27 Jan 2026 03:02:47 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88D1E3F632;
	Tue, 27 Jan 2026 03:02:52 -0800 (PST)
Message-ID: <2edde60e-b9fa-4458-b1be-ce786e78ff14@arm.com>
Date: Tue, 27 Jan 2026 11:02:50 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] arm64: mm: Unmap kernel data/bss entirely from
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
 <20260126092630.1800589-22-ardb+git@google.com>
 <3d6b2d69-ba7c-4da0-80e1-d1b80da47696@arm.com>
 <CAMj1kXHOkQKS4yP=mqsE-s-W0sg=cvrY6mx53WVQi0pOeLCDkQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXHOkQKS4yP=mqsE-s-W0sg=cvrY6mx53WVQi0pOeLCDkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2026 10:54, Ard Biesheuvel wrote:
> On Tue, 27 Jan 2026 at 11:50, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 26/01/2026 09:26, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The linear aliases of the kernel text and rodata are mapped read-only in
>>> the linear map as well. Given that the contents of these regions are
>>> mostly identical to the version in the loadable image, mapping them
>>> read-only and leaving their contents visible is a reasonable hardening
>>> measure.
>>
>> what about ro_after_init? Could that contain secrets that we don't want to leak?
>> What is the advantage of leaving text/rodata ro in the linear map vs just
>> umapping the whole lot?
>>
> 
> Unmapping it would be preferred, but there are some pieces (such as
> the zero page and swapper_pg_dir) that are expected to be visible via
> the linear map.
> 
>>>
>>> Data and bss, however, are now also mapped read-only but the contents of
>>> these regions are more likely to contain data that we'd rather not leak.
>>> So let's unmap these entirely in the linear map when the kernel is
>>> running normally.
>>>
>>> When going into hibernation or waking up from it, these regions need to
>>> be mapped, so map the region initially, and toggle the valid bit so
>>> map/unmap the region as needed.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm64/mm/mmu.c | 40 ++++++++++++++++++--
>>>  1 file changed, 37 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index fdbbb018adc5..06b2d11b4561 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -24,6 +24,7 @@
>>>  #include <linux/mm.h>
>>>  #include <linux/vmalloc.h>
>>>  #include <linux/set_memory.h>
>>> +#include <linux/suspend.h>
>>>  #include <linux/kfence.h>
>>>  #include <linux/pkeys.h>
>>>  #include <linux/mm_inline.h>
>>> @@ -1027,6 +1028,31 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
>>>                                end - start, prot, early_pgtable_alloc, flags);
>>>  }
>>>
>>> +static void remap_linear_data_alias(bool unmap)
>>> +{
>>> +     set_memory_valid((unsigned long)lm_alias(__init_end),
>>> +                      (unsigned long)(__pgdir_start - __init_end) / PAGE_SIZE,
>>> +                      !unmap);
>>> +}
>>> +
>>> +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
>>> +                                  unsigned long mode, void *unused)
>>> +{
>>> +     switch (mode) {
>>> +     default:
>>> +             break;
>>> +     case PM_POST_HIBERNATION:
>>> +     case PM_POST_RESTORE:
>>> +             remap_linear_data_alias(true);
>>> +             break;
>>> +     case PM_HIBERNATION_PREPARE:
>>> +     case PM_RESTORE_PREPARE:
>>> +             remap_linear_data_alias(false);
>>> +             break;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>>  void __init mark_linear_text_alias_ro(void)
>>>  {
>>>       /*
>>> @@ -1035,6 +1061,16 @@ void __init mark_linear_text_alias_ro(void)
>>>       update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>>>                           (unsigned long)__init_begin - (unsigned long)_text,
>>>                           PAGE_KERNEL_RO);
>>> +
>>> +     remap_linear_data_alias(true);
>>> +
>>> +     if (IS_ENABLED(CONFIG_HIBERNATION)) {
>>> +             static struct notifier_block nb = {
>>> +                     .notifier_call = arm64_hibernate_pm_notify
>>> +             };
>>> +
>>> +             register_pm_notifier(&nb);
>>> +     }
>>>  }
>>>
>>>  #ifdef CONFIG_KFENCE
>>> @@ -1163,7 +1199,7 @@ static void __init map_mem(void)
>>>       __map_memblock(kernel_start, init_begin, PAGE_KERNEL,
>>>                      flags | NO_CONT_MAPPINGS);
>>>       __map_memblock(init_end, kernel_end, PAGE_KERNEL,
>>> -                    flags | NO_CONT_MAPPINGS);
>>> +                    flags | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
>>>
>>>       /* map all the memory banks */
>>>       for_each_mem_range(i, &start, &end) {
>>> @@ -1176,8 +1212,6 @@ static void __init map_mem(void)
>>>                              flags);
>>>       }
>>>
>>> -     __map_memblock(init_end, kernel_end, PAGE_KERNEL_RO,
>>> -                    flags | NO_CONT_MAPPINGS);
>>
>> In the previous patch, perhaps this should be moved to
>> mark_linear_text_alias_ro() and combined with the update_mapping_prot() there?
>>
> 
> Why? Isn't it better to just remap it r/o from the outset if it never
> needs to be mapped r/w to begin with?
> 
> The same applies to the rodata region but -again- it is the root page
> tables that are manipulated via the writable linear alias during boot.
> 
> I'll try to address all of that in the next rev - thanks.

Cool, I'll look out for it.

