Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BD63DABF6;
	Tue, 10 Dec 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822935; cv=none; b=Xp9vtPax95S+yi1baWzIwqnNsL/mhav+OvQ5EpLvlsWJho7EZhneM8LGTh1+4Kovb6g87ALQKxGU2QiKW85EtD1gZsc0uDSoo9yQl/JYEWEVV0RKV9HKuV/Ah4eDcsjvjhNMItaRvbI8+9MMaSvbvbWrXj0V8q+b0ZQDWvkrVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822935; c=relaxed/simple;
	bh=Ra3gryCYi4QFXUQV0tEPjUb5HQBFqm+ow1hjzmuwWQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtkMGY5EIEjvGBnT9NlfqQrs9dtc03CWpekJDRgR1WnhcyNoX2/tlK+2zKdfI0COujoOF1D4d1xPisp2kDu14w+nW2ZoWMV/tL4vxJ8N1j3qyrcPat5hern9SBtSD+jfQ+Kg5H9+JhzhQgw0x2R4BJQPhz6n+k06U86wC39Lupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F337113E;
	Tue, 10 Dec 2024 01:29:20 -0800 (PST)
Received: from [10.57.69.139] (unknown [10.57.69.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005943F58B;
	Tue, 10 Dec 2024 01:28:47 -0800 (PST)
Message-ID: <7124d7f4-1d4c-4497-94d8-243af2ed071a@arm.com>
Date: Tue, 10 Dec 2024 10:28:44 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/16] arm64: mm: Reset pkey in __tlb_remove_table()
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 aruna.ramakrishna@oracle.com, broonie@kernel.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, jannh@google.com, jeffxu@chromium.org,
 joey.gouly@arm.com, kees@kernel.org, maz@kernel.org,
 pierre.langlois@arm.com, qperret@google.com, ryan.roberts@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <20241206101110.1646108-14-kevin.brodsky@arm.com>
 <20241209102913.GJ21636@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241209102913.GJ21636@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2024 11:29, Peter Zijlstra wrote:
> On Fri, Dec 06, 2024 at 10:11:07AM +0000, Kevin Brodsky wrote:
>> [...]
>>
>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>> index a947c6e784ed..d1611ffa6d91 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -10,10 +10,14 @@
>>  
>>  #include <linux/pagemap.h>
>>  #include <linux/swap.h>
>> +#include <linux/kpkeys.h>
>>  
>>  static inline void __tlb_remove_table(void *_table)
>>  {
>> -	free_page_and_swap_cache((struct page *)_table);
>> +	struct page *page = (struct page *)_table;
>> +
>> +	kpkeys_unprotect_pgtable_memory((unsigned long)page_address(page), 1);
>> +	free_page_and_swap_cache(page);
>>  }
> Same as for the others, perhaps stick this in generic code instead of in
> the arch code?

This should be doable, with some refactoring. __tlb_remove_table() is
currently called from two functions in mm/mmu_gather.c, I suppose I
could create a wrapper there that calls
kpkeys_unprotect_pgtable_memory() and then __tlb_remove_table(). Like in
the p4d case I do however wonder how robust this is, as
__tlb_remove_table() could end up being called from other places.

- Kevin
