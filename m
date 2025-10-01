Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953229BDBF;
	Wed,  1 Oct 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339351; cv=none; b=UDatUE3XPWOlt3tUt8zyRB8r4KZhJlmftoQH/nTuyFYQhiQAUcvUw7AxMrZiUrkWlzxzrE0wVypprtXLtaeGD8sGOXmO2VixN4Bs8YBbLxsbFOrMJOAxSAvGIqD2Z+j8T+rbg+lIYhnXaEgTpDFySFEe45uCQGXt46V1dKDe0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339351; c=relaxed/simple;
	bh=KtHH5slsD8Ox5MoPLqaiqd9jBeTgdv0YVlgjsuTd720=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeQ/hRdBhIQQ6iZ6RvF0jz2W7NGYip87U/gsbrm77z7tejO6zx5hicaCLyKpEYRrn1+QB9ZQLt4OKEkzUTKxloSWFhKycmZdstl1lPL4ww7512R2u3ICB4iU79jvM++mIYYv1Wl36uA1Vigug06opDDDeH6cgm72U2HneI284/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDF2116F8;
	Wed,  1 Oct 2025 10:22:19 -0700 (PDT)
Received: from [10.57.66.40] (unknown [10.57.66.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30AE33F59E;
	Wed,  1 Oct 2025 10:22:22 -0700 (PDT)
Message-ID: <69b1c489-b4cb-4bee-aff1-6c76fc48cf29@arm.com>
Date: Wed, 1 Oct 2025 19:22:20 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 13/18] mm: Map page tables with privileged pkey
To: David Hildenbrand <david@redhat.com>, linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <20250815085512.2182322-14-kevin.brodsky@arm.com>
 <48ed62b1-cceb-4bce-923c-25c11dbccc37@redhat.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <48ed62b1-cceb-4bce-923c-25c11dbccc37@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/10/2025 17:28, David Hildenbrand wrote:
> On 15.08.25 10:55, Kevin Brodsky wrote:
>
> Just wondering, should the patch subject be:
>
> "mm: protect page tables with privileged pkey" ?
>
> At least patch #2 tells me that set_memory_pkey() will set the
> protection key, and the function is called
> "kpkeys_protect_pgtable_memory"?
>
> Just trying to connect the dots here :)

That's fair! I suppose I meant "map with privileged pkey" in the sense
of "modify the mapping/PTE to set the pkey". But I see how that can be
confusing, as we're not creating any mapping. I'll reword that in v6.

>
>> If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map allocated page
>> table pages using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that
>> page tables can only be written under guard(kpkeys_hardened_pgtables).
>>
>> This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
>> (default).
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>   include/linux/mm.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index d9371d992033..4880cb7a4cb9 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -34,6 +34,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/cacheinfo.h>
>>   #include <linux/rcuwait.h>
>> +#include <linux/kpkeys.h>
>>     struct mempolicy;
>>   struct anon_vma;
>> @@ -2979,6 +2980,8 @@ static inline bool __pagetable_ctor(struct
>> ptdesc *ptdesc)
>>         __folio_set_pgtable(folio);
>>       lruvec_stat_add_folio(folio, NR_PAGETABLE);
>> +    if (kpkeys_protect_pgtable_memory(folio))
>> +        return false;
>>       return true;
>>   }
>>   @@ -2989,6 +2992,7 @@ static inline void pagetable_dtor(struct
>> ptdesc *ptdesc)
>>       ptlock_free(ptdesc);
>>       __folio_clear_pgtable(folio);
>>       lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>> +    kpkeys_unprotect_pgtable_memory(folio);
>
> This is all rather nasty. Not your fault.
>
> In the near future page tables will not be folios, and the whole
> ptdesc_folio() conversion will not make any sense.

Ah, interesting. Any patches/series I should be aware of?

>
> Likely you should make kpkeys_protect_pgtable_memory() etc. consume an
> address range, or a page range right from the start.

Got it. That said, as per the discussion on the cover letter [1], it's
quite likely that we'll have to change the approach completely anyway
(i.e. allocate PTPs from a dedicated pool where the pkey is already set).

- Kevin

[1] lore.kernel.org/r/aMwd7IJVECEy8mzf@willie-the-truck
