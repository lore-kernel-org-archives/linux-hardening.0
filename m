Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22E233687;
	Wed, 11 Dec 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924269; cv=none; b=KKGQ9CyV85d7b/tKluK+ZczWM3t6+Y8r2+bSHbzO4oa98M0ZoSXLGUpWj7VfJkYO3H650DjG/przgdZjS4vin80IlPJE+KIEvoe5kQbPbYAxcS9efNMBWcGgsd5A/3iWHPl9drUMslZ7Rq58D2m8mNrbEnRRaWc2aLkGGRh6vIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924269; c=relaxed/simple;
	bh=oKNTFar/NGVE0/+3Jq3sEukwsBR9JHdJonczUbMdNAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krC3mcSqE6ODJ98hGLBqzmZIfVpqLToDyad5AvQq5+1O8RRZkK9yUbcFMJc9fohmZCH1eKYdKBXCtNThi+GipkaAyBWEmg0yNv1DRyPY/oA+TCMy4YoZjwv6RjYYk1TyronRe2tmzbOo1iyVt90h54cMCIphsE5YHPbc7OHSmZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 588FD1063;
	Wed, 11 Dec 2024 05:38:14 -0800 (PST)
Received: from [10.57.70.51] (unknown [10.57.70.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D18793F720;
	Wed, 11 Dec 2024 05:37:41 -0800 (PST)
Message-ID: <a8fea276-152f-4cf3-a87f-e48ae6e5c024@arm.com>
Date: Wed, 11 Dec 2024 14:37:38 +0100
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
 <7124d7f4-1d4c-4497-94d8-243af2ed071a@arm.com>
 <20241210122706.GO8562@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241210122706.GO8562@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/2024 13:27, Peter Zijlstra wrote:
> On Tue, Dec 10, 2024 at 10:28:44AM +0100, Kevin Brodsky wrote:
>> On 09/12/2024 11:29, Peter Zijlstra wrote:
>>> On Fri, Dec 06, 2024 at 10:11:07AM +0000, Kevin Brodsky wrote:
>>>> [...]
>>>>
>>>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>>>> index a947c6e784ed..d1611ffa6d91 100644
>>>> --- a/arch/arm64/include/asm/tlb.h
>>>> +++ b/arch/arm64/include/asm/tlb.h
>>>> @@ -10,10 +10,14 @@
>>>>  
>>>>  #include <linux/pagemap.h>
>>>>  #include <linux/swap.h>
>>>> +#include <linux/kpkeys.h>
>>>>  
>>>>  static inline void __tlb_remove_table(void *_table)
>>>>  {
>>>> -	free_page_and_swap_cache((struct page *)_table);
>>>> +	struct page *page = (struct page *)_table;
>>>> +
>>>> +	kpkeys_unprotect_pgtable_memory((unsigned long)page_address(page), 1);
>>>> +	free_page_and_swap_cache(page);
>>>>  }
>>> Same as for the others, perhaps stick this in generic code instead of in
>>> the arch code?
>> This should be doable, with some refactoring. __tlb_remove_table() is
>> currently called from two functions in mm/mmu_gather.c, I suppose I
>> could create a wrapper there that calls
>> kpkeys_unprotect_pgtable_memory() and then __tlb_remove_table(). Like in
>> the p4d case I do however wonder how robust this is, as
>> __tlb_remove_table() could end up being called from other places.
> I don't foresee other __tlb_remove_table() users, this is all rather
> speicific code. But if there ever were to be new users, it is something
> they would have to take into consideration.

Fair enough, I'll handle that in mm/mmu_gather.c then.

- Kevin
