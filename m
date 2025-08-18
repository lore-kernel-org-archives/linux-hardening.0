Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD831A070;
	Mon, 18 Aug 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532975; cv=none; b=DjahL8jIi8A5OqyGLtkS9JciiV4XojWOCJ+Lc0XFP7AQ6hKDMYFy10hxwby3J0nv/XV+qwje5wkl0+wId3hMzZjb2BV0oMwAEXnnDU/8PO/UYNqXd4cXdEALleGcVFggo9/2ZcgynaA5mm1PP+Pu3+ubbibFh60rxGD0BZgceEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532975; c=relaxed/simple;
	bh=tz0d9rCWNPVFVAlcAoNU0yPn0mQPwXExjPwll0A+KXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioClsGQ4lghOfCu6qGmdgqejZGmXmoRbM8DlBW/s/YkwvjFI2Y4JgALJeUyXMvesG2DLSqqXKERcd1p1SbrxBo+UYFSV+7nM7a9/BWcPIufjZz8xBb7tIvMAzczbZjpi7pCvCFIAs223aSbj046f3669DtLXFan2dQwh1NBKFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ECF31596;
	Mon, 18 Aug 2025 09:02:44 -0700 (PDT)
Received: from [10.57.58.12] (unknown [10.57.58.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB0343F63F;
	Mon, 18 Aug 2025 09:02:46 -0700 (PDT)
Message-ID: <b6579c2a-2262-4279-81a5-8235092bea13@arm.com>
Date: Mon, 18 Aug 2025 18:02:44 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 13/18] mm: Map page tables with privileged pkey
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc: "maz@kernel.org" <maz@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "mbland@motorola.com" <mbland@motorola.com>,
 "david@redhat.com" <david@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "joey.gouly@arm.com"
 <joey.gouly@arm.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "pierre.langlois@arm.com" <pierre.langlois@arm.com>,
 "jeffxu@chromium.org" <jeffxu@chromium.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "jannh@google.com" <jannh@google.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
 "qperret@google.com" <qperret@google.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <20250815085512.2182322-14-kevin.brodsky@arm.com>
 <616011cf17f1654ac3ad8757f0f33425b3af1ddd.camel@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <616011cf17f1654ac3ad8757f0f33425b3af1ddd.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/08/2025 18:37, Edgecombe, Rick P wrote:
> On Fri, 2025-08-15 at 09:55 +0100, Kevin Brodsky wrote:
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index d9371d992033..4880cb7a4cb9 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -34,6 +34,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/cacheinfo.h>
>>  #include <linux/rcuwait.h>
>> +#include <linux/kpkeys.h>
>>  
>>  struct mempolicy;
>>  struct anon_vma;
>> @@ -2979,6 +2980,8 @@ static inline bool __pagetable_ctor(struct ptdesc *ptdesc)
>>  
>>  	__folio_set_pgtable(folio);
>>  	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>> +	if (kpkeys_protect_pgtable_memory(folio))
>> +		return false;
>>  	return true;
>>  }
> It seems like this does a kernel range shootdown for every page table that gets
> allocated? If so it throws a pretty big wrench into the carefully managed TLB
> flush minimization logic in the kernel.
>
> Obviously this is much more straightforward then the x86 series' page table
> conversion batching stuff, but TBH I was worried that even that was going to
> have a performance hit. I think how to efficiently do direct map permissions is
> the key technical problem to solve for pkeys security usages. They can switch on
> and off fast, but applying the key is just as much of a hit as any other kernel
> memory permission. (I assume this works the similarly to x86's?)

The benchmarking results (see cover letter) don't seem to point to a
major performance hit from setting the pkey on arm64 (worth noting that
the linear mapping is PTE-mapped on arm64 today so no splitting should
occur when setting the pkey). The overhead may well be substantially
higher on x86.

I agree this is worth looking into, though. I will check the overhead
added by set_memory_pkey() specifically (ignoring pkey register
switches), and maybe try to allocate page tables with a dedicated
kmem_cache instead, reusing this patch [1] from my other kpkeys series.
A kmem_cache won't be as optimal as a dedicated allocator, but batching
the page freeing may already improve things substantially.

- Kevin

[1]
https://lore.kernel.org/linux-hardening/20250815090000.2182450-4-kevin.brodsky@arm.com/

