Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7B3FAE14
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820968; cv=none; b=XCafkTrZ5rrsOizCewwkH/CoZdqAQxXS+yslYpO7/ngFfMUmpGFPUyvsj/j65MKQVVUqFAR2O6uGH6GqI3K+WPeZyDGVRy1LljtzPoC0T1efs+TeImzDkmQileAUZqfXNtZ3ggXDfSdvl16wcfcu24KA786Wy0w/tk1GJWUNjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820968; c=relaxed/simple;
	bh=yry31P4khI+DRCBsZQHN2ujbaVqF7+s8d6cewX4+B1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVwpoddeIRhtYJksfsid5xEP/VRms2mE3dhg4iqHOPr4hCW/dAduoDkUMV1heuuYMVKB3US5mmPBtD/UXU2I+cRZwhuYpKl++jb3Z8HbXlRVu60OXkMNEqygngxRUqEt2jCX/gjs6NPiNsoJo1pzjybqaFcuwW5/+Wnk4KZ8mOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eteg5u/K; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eteg5u/K"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 839861691;
	Thu, 27 Aug 2026 01:55:57 -0700 (PDT)
Received: from [10.43.20.79] (unknown [10.43.20.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72F0C3F85F;
	Thu, 27 Aug 2026 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787820961; bh=yry31P4khI+DRCBsZQHN2ujbaVqF7+s8d6cewX4+B1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eteg5u/KjRoj4FqWoRxTrgkSEGR4f8fW0aVO5jwh1hz61B2z2iPGtiU82NS9WV9JT
	 ZMYCuFuGK/zi0HegqQE/Y/R4pKvDOIk9vBKgcOa699KxUiPkVxDtngXV0YPfqvM7Tv
	 hUcCWW01AMbuMDiY2Csh1ojTfk35TAijFUYNmMwo=
Message-ID: <c33d081b-7886-4db2-b1d9-61dc195844e5@arm.com>
Date: Thu, 27 Aug 2026 10:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: mm: Map fixmap PTE tables r/o in the linear
 map
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>,
 linux-hardening@vger.kernel.org
References: <20260805104042.1107678-2-ardb+git@google.com>
 <5a3b89a6-bc42-42c3-82e8-25d6f1a2c5d2@arm.com>
 <a277a83a-cc01-443d-be42-775ce0bc96dd@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <a277a83a-cc01-443d-be42-775ce0bc96dd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2026 11:07, Ard Biesheuvel wrote:
>>> [...]
>>>
>>> +static int __init fixmap_remap_ro(void)
>>> +{
>>> +	return set_direct_map_ro((unsigned long)lm_alias(&bm_pte), NR_BM_PTE_TABLES);
>> Should we not also remap bm_pmd and bm_pud?
>>
>> For that matter, do we need RW access via the linear map for any page
>> annotated with __bss_pgtbl? I suppose that might be the case for
>> kasan_early_shadow_* but I don't know enough about KASAN to tell for sure.
>>
> bm_pte[] is special because it is only ever written via the kernel mapping,
> and never via the linear map. This is why it is being singled out in this
> patch.

Right I see __set_fixmap(). This is a very special case of calling
__set_pte() on a pointer derived from a global (i.e. pointing to the
kernel image and not the LM) so it makes sense to treat it differently.

I do wonder whether there is that much value in protecting bm_pte while
all page tables in init_pg_dir (also at a fixed offset in the LM) remain
writeable though.

Either way all this is interesting for my series protecting page tables
with pkeys [1] - it seems that to protect the fixmap, the easiest option
would be to change the pkey of .pgtlb in both the kernel image and LM
(the former for bm_pte, and the latter for everything else).

[1] https://lore.kernel.org/all/20260818-kpkeys-v9-0-743ad31b2c8f@arm.com/

> Whether or not bm_pmd[] can be treated as a special case depends on the page
> size: with 4k pages, the whole array covers a virtual region of 1G, which is
> currently guaranteed to be shared only with the PCI I/O space (but we could
> move that out). With 16k pages, it covers 64G, and so it is shared with the
> vmemmap and other virtual mappings in the vmalloc region, and so the current
> kernel mapping code expects to be able to write those entries.
>
> What we might do is generalize the logic that uses the fixmap to modify
> pgd level entries in swapper_pg_dir, and use it for all modifications
> at PMD level or higher if those tables are in .rodata
>
> But this is a bit more complicated than this change, so I decided to
> present this as a separate change.

Definitely, this is orthogonal to this patch. I wonder what the
performance impact would be if we used the fixmap for setting all kernel
entries at PMD and above. It would be nice to keep that logic easily
togglable, because with the kpkeys approach I mentioned above we have a
(most likely) much cheaper way of protecting these page tables.

>>> +}
>>> +late_initcall(fixmap_remap_ro);
>> Is mark_rodata_ro() definitely too early to remap these pages RO?
>>
> No, we might just call this from there, afaict.

Sounds good, could we then use update_mapping_prot()? I suppose not as
that would require mapping bm_pte separately in map_mem()?

- Kevin
