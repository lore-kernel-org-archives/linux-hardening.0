Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83A2E5418;
	Tue, 27 Jan 2026 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508241; cv=none; b=egmXSJ56/LE69fgeHsvhse2vaZMpr7F2R0SJCK5oMiXp01kez1NrgQhCguIOjGlAkxDVXghEW4lS9SAw8FnGcfSa5fIfk+Zz/OBLw1/CUwuRfurmzg/T4UAyDClO4KGK5fTzrLvbyTpLw0j5bwQe4jXgTHZwXoW3lWSEFV8lJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508241; c=relaxed/simple;
	bh=fYFyDRXD/cCvNjntdemil+ButU8cS4XwyAZolz427Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPTcRTP6fUaLXOk+hhx0h+BfRK8z8LlotpmkEkEAQPYXfodE86/vyEo9AgZZg2nSPjVo1oAoZBwXj9hYVb0XA46SHfvrQL8bbMmao3H5JwkG3r9l00QXvsyNSR6ExdiPC7YMsj2aFIfm3wPc88vj0IIMLV8XLugab85TNOHhtQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2672F1655;
	Tue, 27 Jan 2026 02:03:53 -0800 (PST)
Received: from [10.57.94.246] (unknown [10.57.94.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4FF23F73F;
	Tue, 27 Jan 2026 02:03:57 -0800 (PST)
Message-ID: <427d39c1-ab02-4a66-a0ba-d4fb98ab72d6@arm.com>
Date: Tue, 27 Jan 2026 10:03:56 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] arm64: Move the zero page to rodata
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-13-ardb+git@google.com>
 <3d59a8d9-a382-48d8-b79c-f5c23e86c1b7@arm.com>
 <CAMj1kXF4k9EstLkxdNje_rwTehdu2MYvyh7n+4GoMWNcjcHYcA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXF4k9EstLkxdNje_rwTehdu2MYvyh7n+4GoMWNcjcHYcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2026 09:49, Ard Biesheuvel wrote:
> On Tue, 27 Jan 2026 at 10:34, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 26/01/2026 09:26, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The zero page should contain only zero bytes, and so mapping it
>>> read-write is unnecessary. Combine it with reserved_pg_dir, which lives
>>> in the read-only region of the kernel, and already serves a similar
>>> purpose.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm64/kernel/vmlinux.lds.S | 1 +
>>>  arch/arm64/mm/mmu.c             | 3 +--
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>>> index ad6133b89e7a..b2a093f5b3fc 100644
>>> --- a/arch/arm64/kernel/vmlinux.lds.S
>>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>>> @@ -229,6 +229,7 @@ SECTIONS
>>>  #endif
>>>
>>>       reserved_pg_dir = .;
>>> +     empty_zero_page = .;
>>>       . += PAGE_SIZE;
>>>
>>>       swapper_pg_dir = .;
>>
>> Isn't there a magic macro for getting from swapper to reserved? That will need
>> updating?
>>
> 
> Why? This just adds an alias to refer to the same allocation.

Oh yes, sorry I completely missed that. And you've even stated it in the commit
log...

I'm struggling to see where this gets zeroed though? I assume it must be zeroed
before the old empty_zero_page would have been so everything works fine?

Assuming yes, then:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
>> /*
>>  *  Open-coded (swapper_pg_dir - reserved_pg_dir) as this cannot be calculated
>>  *  until link time.
>>  */
>> #define RESERVED_SWAPPER_OFFSET (PAGE_SIZE)
>>
>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 9ae7ce00a7ef..c36422a3fae2 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -66,9 +66,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
>>>
>>>  /*
>>>   * Empty_zero_page is a special page that is used for zero-initialized data
>>> - * and COW.
>>> + * and COW. Defined in the linker script.
>>>   */
>>> -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>>>  EXPORT_SYMBOL(empty_zero_page);
>>
>> What's the benefit of giving it it's own place in the linker script vs just
>> declaring it as const and having it placed in the rodata?
>>
> 
> Because it collapses the two into one.

