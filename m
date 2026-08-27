Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E133A029
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824836; cv=none; b=hIac5GxAfCeInKTtbxLNJekyU9KwOqkldUi5HIOMDBRJ3vPfRO4UAYI20fSUJuvuc8/1UM8kyvJvsiYTAPaeZstIdF6kOsVNICU7Cf9S/pq7K8j54WAVp4ao5qf1wiJENbImkkfs4g8XX3s7Xi3/Qdx7Y1nANrJyTzeBxiN3KiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824836; c=relaxed/simple;
	bh=N6tRlbMdPzHcK7LXdQ66VmH7fyetGjDjgJHta0FwHo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ln5QRKZ3vZGNtnHsJF8mZl+ruN7b25bGnr8BQWYZ9ue4NAPICBxyDrIeSWTNaRYYjUIjV6BAKvcr0nvGrVJb2xY2CF4rPCU/xrmdZ9rkjXs801/SryOMtQ1DlRLjyAYE6UeNquhhssreh6xvcKRR18oRkOQZ+8lCLxoeVz69hgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RSOBswGl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RSOBswGl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A52E152B;
	Thu, 27 Aug 2026 03:00:20 -0700 (PDT)
Received: from [10.43.20.79] (e126510-lin.lund.arm.com [10.43.20.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 605093F66F;
	Thu, 27 Aug 2026 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787824824; bh=N6tRlbMdPzHcK7LXdQ66VmH7fyetGjDjgJHta0FwHo4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RSOBswGlGSPkd1nR7KER8o9NgcnSJCgNuGoVdWEkf1sPYoTS2FDHAijLap/iN9N8m
	 cOhFoqQIw5zB4nKdu77GuIpS3NpyAqZ1g2OCitZmDf3fDWwc6SN0OxzA1esIUNJG6b
	 VjsmBCAkBFTm6PCZPDUEbXI1HeypOrYPW6Yv9O6I=
Message-ID: <aacacc48-4e20-423f-b1cd-d8593485bf9d@arm.com>
Date: Thu, 27 Aug 2026 12:00:18 +0200
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
 <c33d081b-7886-4db2-b1d9-61dc195844e5@arm.com>
 <1c0299ab-9f5f-4c7b-826e-a0547f7863dd@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <1c0299ab-9f5f-4c7b-826e-a0547f7863dd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 11:04, Ard Biesheuvel wrote:
> On Thu, 27 Aug 2026, at 10:55, Kevin Brodsky wrote:
>> On 26/08/2026 11:07, Ard Biesheuvel wrote:
>>>>> [...]
>>>>>
>>>>> +static int __init fixmap_remap_ro(void)
>>>>> +{
>>>>> +	return set_direct_map_ro((unsigned long)lm_alias(&bm_pte), NR_BM_PTE_TABLES);
>>>> Should we not also remap bm_pmd and bm_pud?
>>>>
>>>> For that matter, do we need RW access via the linear map for any page
>>>> annotated with __bss_pgtbl? I suppose that might be the case for
>>>> kasan_early_shadow_* but I don't know enough about KASAN to tell for sure.
>>>>
>>> bm_pte[] is special because it is only ever written via the kernel mapping,
>>> and never via the linear map. This is why it is being singled out in this
>>> patch.
>> Right I see __set_fixmap(). This is a very special case of calling
>> __set_pte() on a pointer derived from a global (i.e. pointing to the
>> kernel image and not the LM) so it makes sense to treat it differently.
>>
>> I do wonder whether there is that much value in protecting bm_pte while
>> all page tables in init_pg_dir (also at a fixed offset in the LM) remain
>> writeable though.
>>
> Yes, so those need to be taken care of as well.

But init_pg_dir needs to remain writeable in the LM, right?

>> Either way all this is interesting for my series protecting page tables
>> with pkeys [1] - it seems that to protect the fixmap, the easiest option
>> would be to change the pkey of .pgtlb in both the kernel image and LM
>> (the former for bm_pte, and the latter for everything else).
>>
>> [1] https://lore.kernel.org/all/20260818-kpkeys-v9-0-743ad31b2c8f@arm.com/
>>
> Thanks, I've been meaning to go through those but they are a bit overwhelming :-)

Yes there's a fair bit to go through, sorry for that... You'll probably
be most interested in patch 12, 13 and 19-21 - that's where page tables
are being mapped with a special pkey. The cover letter should give
enough context for them to make sense on their own.

>>> Whether or not bm_pmd[] can be treated as a special case depends on the page
>>> size: with 4k pages, the whole array covers a virtual region of 1G, which is
>>> currently guaranteed to be shared only with the PCI I/O space (but we could
>>> move that out). With 16k pages, it covers 64G, and so it is shared with the
>>> vmemmap and other virtual mappings in the vmalloc region, and so the current
>>> kernel mapping code expects to be able to write those entries.
>>>
>>> What we might do is generalize the logic that uses the fixmap to modify
>>> pgd level entries in swapper_pg_dir, and use it for all modifications
>>> at PMD level or higher if those tables are in .rodata
>>>
>>> But this is a bit more complicated than this change, so I decided to
>>> present this as a separate change.
>> Definitely, this is orthogonal to this patch. I wonder what the
>> performance impact would be if we used the fixmap for setting all kernel
>> entries at PMD and above. It would be nice to keep that logic easily
>> togglable, because with the kpkeys approach I mentioned above we have a
>> (most likely) much cheaper way of protecting these page tables.
>>
> I'm currently experimenting with using __put_kernel_nofault() to update
> the descriptors at all levels (including PTE) and handling the fault
> using the fixmap approach. That way, all statically allocated page
> tables could move to .rodata (except bm_pte[]) and there should be no
> substantial performance impact.

Doesn't that still mean modifying a fixmap PTE every time we update
kernel page tables? That doesn't exactly sound cheap.

>>>>> +}
>>>>> +late_initcall(fixmap_remap_ro);
>>>> Is mark_rodata_ro() definitely too early to remap these pages RO?
>>>>
>>> No, we might just call this from there, afaict.
>> Sounds good, could we then use update_mapping_prot()? I suppose not as
>> that would require mapping bm_pte separately in map_mem()?
>>
> Yeah, but perhaps we should do the latter anyway, so we can remap the
> region even if !can_set_direct_map().

Yep makes sense. Not having to add yet another set_direct_map_* function
is definitely welcome ;)

- Kevin
