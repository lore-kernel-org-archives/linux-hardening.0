Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD431960A;
	Mon,  4 May 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884732; cv=none; b=M4HkxW0j/TYIswYuiAGQhWi3+G0k9ybzlJCqq5FxLzyvFlwXxOEb4nbj4DVpazlDbHGuWJCmu2IufekZMZyg0fzMponHAvoyYD+Ubt3Hjavle5U34eHQ+mRLGA/+QK+APtQ/bLm4vytoM6drgHsfgfvHLKaj9vYDOVPn528oePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884732; c=relaxed/simple;
	bh=Bg78KoT8CemEyZViwGh6uhzKeqfwdHIhOCQAX57fvRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcDePO+QD5YuEODvd3Po98ZOM3b9VZkGnTfwVoADAuCiFKcQfkidkUbVrUCbbjvFdMlXnS68eI/y9wP188X5G71GELAsXf01ppTx2iRJwOee3xmvoYT7ZJ9wuz29AHI4wWzEPsCt6TnW0ULGjTYTbBju3N2j1FMtrWPpOn7DIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NNK2jSQl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NNK2jSQl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C45251713;
	Mon,  4 May 2026 01:52:04 -0700 (PDT)
Received: from [10.57.34.72] (unknown [10.57.34.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 753B83F763;
	Mon,  4 May 2026 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777884730; bh=Bg78KoT8CemEyZViwGh6uhzKeqfwdHIhOCQAX57fvRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNK2jSQl2B1FVgfn2NY38+h+ww+DbMNckBAn2S5WShSlWOVB0HBAEnYt4Fe7b6x8r
	 dxSgc0GWneyT0Czpajo6Kg4LAJHpFew1oH5j4LCCUImRsL01mFadAPdBOU2JBaDpev
	 sv3EtzBHR9deCjHx0SIYcZRxWDBCuRlBTCHUr4bA=
Message-ID: <4f50dad3-76a6-4117-b5f0-d939c6e551f6@arm.com>
Date: Mon, 4 May 2026 10:52:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-30-ardb+git@google.com>
 <15555e9f-65ab-4811-b20c-8ada90bdc9d0@arm.com>
 <5279ea66-0e31-4f53-ad76-4fd8ebc012fc@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <5279ea66-0e31-4f53-ad76-4fd8ebc012fc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2026 19:37, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2026, at 15:55, Kevin Brodsky wrote:
>> On 27/04/2026 17:34, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The linear aliases of the kernel text and rodata are mapped read-only in
>>> the linear map as well. Given that the contents of these regions are
>>> mostly identical to the version in the loadable image, mapping them
>>> read-only and leaving their contents visible is a reasonable hardening
>>> measure.
>>>
>>> Data and bss, however, are now also mapped read-only but the contents of
>>> these regions are more likely to contain data that we'd rather not leak.
>> That sounds like a good rationale but I wonder, is there anything
>> stopping us from unmapping text/rodata as well?
>>
> There is the zero page now, which may be accessed via
> 'page_address(ZERO_PAGE(0))'. Also, anything that dereferences page tables
> (like /sys/kernel/debug/kernel_page_tables) will expect to have read-only
> access to swapper_pg_dir.

Isn't swapper_pg_dir always accessed via the kernel mapping? If the zero
page is the only data that actually needs to be accessed via the linear
map, maybe we could move it alongside fixmap_pgdir so that we can unmap
everything else from the linear map?

>>> So let's unmap these entirely in the linear map when the kernel is
>>> running normally.
>>>
>>> When going into hibernation or waking up from it, these regions need to
>>> be mapped, so map the region initially, and toggle the valid bit so
>>> map/unmap the region as needed.
>> Doesn't safe_copy_page() already handle that? I suppose this is an
>> optimisation to avoid modifying the linear map for every page, but if so
>> it would be good to spell it out.
>>
> Uhm, good question.
>
> When hibernate was first implemented for arm64, we had to bring back the
> linear alias of the kernel image, and when I started working on this, I
> hadn't realised that we have safe_copy_page() now which should take care
> of this even if the linear alias is invalid.
>
> However, if I remove this handling, things breaks mysteriously, and it
> is a bit tricky to debug so it may take me some time to answer this
> question. In any case, I will address this in the next revision, and
> put you on cc.

Sounds good, thanks!

>>> [...]
>>>  
>>>  #ifdef CONFIG_KFENCE
>>> @@ -1162,7 +1198,7 @@ static void __init map_mem(void)
>>>  
>>>  	/* Map the kernel data/bss so it can be remapped later */
>>>  	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
>>> -		       flags);
>>> +		       flags | NO_BLOCK_MAPPINGS);
>> Might be an obvious question but why do we need this?
>>
> set_memory_valid() only works on regions that are mapped down to pages.

AFAIU since [1] this is no longer the case. Even if we don't have
BBML2-noabort, we should be able to modify a block-mapped region, as
long as we're not splitting any block (which should not happen here
since we're always changing permissions on the same range).

- Kevin

[1]
https://lore.kernel.org/all/20250917190323.3828347-1-yang@os.amperecomputing.com/

