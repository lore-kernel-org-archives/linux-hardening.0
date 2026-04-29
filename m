Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53554396587;
	Wed, 29 Apr 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449445; cv=none; b=gnS2WQGZlixFbT5g3SBVxX7ZWsbz8xD2UxIiG6JbqMdNhHkn9lgdjEuyVhwi8O9TXKL36wVOJeTk6EJR+ka4mQQA1skrWZwnhGIdYJhQsdV33wN9OGkLS+DHJHKt1QE7ujhTrStimNf+aPbi7wzfct1wWsfBT2lnt9nqVyxiONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449445; c=relaxed/simple;
	bh=PPTQwN6FHCEM1yLuNFwiLgAzpEKdINGGfUZaIfMV9DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIF9NHSxlN+ikGjSCp46jUgjagsHXC/9oEHkNO6ASUslGnuSKVKPpCTFbdXOcSUpolXK6Qu6qtboz7zn53Mn0iZRovXevC/RQfPGEJOAPL6g9zVSUNVLcbeoWQ3RbeU9iWzG9wntclZ3o7z4PCjZwkoSnAQpP1eK2OmpArC59hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tu884VDN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tu884VDN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D5982574;
	Wed, 29 Apr 2026 00:57:10 -0700 (PDT)
Received: from [10.57.62.76] (unknown [10.57.62.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0283F62B;
	Wed, 29 Apr 2026 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777449436; bh=PPTQwN6FHCEM1yLuNFwiLgAzpEKdINGGfUZaIfMV9DE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tu884VDNcnff9i319agoWfbHCU09dt7nv52tTghEcTpUmoE/TLPT0pXCWMeWZK+hR
	 5tZo5fr795P2mHfGf0u5pH2d+gOGMhuK62mkoBPTbQE/fpcwqBc2rXrefL8saY2apM
	 vGNABGXJYLp2iVd9jeWXE4aOkG4vyKK3pzyrtv+I=
Message-ID: <1ba0b6ce-3e71-45f7-a3c8-cdc5aadcaf27@arm.com>
Date: Wed, 29 Apr 2026 09:57:10 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] arm64: mm: Map the linear alias of text/rodata
 as tagged
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
 <20260427153416.2103979-18-ardb+git@google.com>
 <82091dd4-9d11-4054-89ec-99aadaeec7b2@arm.com>
 <6f514d91-c8ce-473f-8383-f3b9a4cc2f7a@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <6f514d91-c8ce-473f-8383-f3b9a4cc2f7a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/04/2026 18:23, Ard Biesheuvel wrote:
> Hi Kevin,
>
> On Tue, 28 Apr 2026, at 16:16, Kevin Brodsky wrote:
>> On 27/04/2026 17:34, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> Before moving the empty_zero_page into the __ro_after_init section, make
>>> sure it has the memory-tagged type. This is needed to ensure that
>>> cpu_enable_mte() will be able to initialize the tags correctly.
>> mark_linear_text_alias_ro() is called after all features have been
>> detected and enabled, so do we actually need this?
>>
>> AFAICT the lines that matter for cpu_enable_mte() are those, in map_mem():
>>
>>     __map_memblock(pgdp, kernel_start, kernel_end,
>>                PAGE_KERNEL, NO_CONT_MAPPINGS);
>>
>> It is probably this call that needs to be changed to use
>> pgprot_tagged(PAGE_KERNEL).
>>
> I see. I guess we should probably update both, no?

We could, but would we ever access the tags in data mapped read-only?
cpu_enable_mte() needs tag access to zero them, but AFAIU it's really a
special case that is only relevant to the situation where the data is RW.

- Kevin
