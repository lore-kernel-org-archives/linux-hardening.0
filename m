Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DDE34D926;
	Wed, 29 Apr 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473042; cv=none; b=Sb1N0SXeqSKFPhPIZWy8lgw/dIBGsm+xpfnWJ/DpkG3b6ENvykVw4wli4FBJu0/+uUbTrvPvdqSXCekHrSndNGT0WTAGTkyE5wbSGNmbZN4RbL5M3yqidDF1DgQaO65QsvmR2o1RWn7OIZFADEuC0PoleP0cLL0rCVXMe7Wbmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473042; c=relaxed/simple;
	bh=yYUcrffafPaOm77R9dKuGdogYVbwK0I1WaJfySVSriM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkA0PHCgLI72rYhpAOmlEiGrstWOuw34vxczp/aRPm1UGBCTuLsw+j62dltyfgca0/vbrOhcHqzQesjJRKUPdJcxtim7uJqyPC/R890jW2ay/nhD9vF1ZrB0gzwFzwUZtcieSNMVOxQKkDCQ8I9MTer/Rf9d6YPS1802ncjPFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uyCgDRP/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uyCgDRP/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82B5E1BCB;
	Wed, 29 Apr 2026 07:30:34 -0700 (PDT)
Received: from [10.57.62.76] (unknown [10.57.62.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE18C3F62B;
	Wed, 29 Apr 2026 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777473040; bh=yYUcrffafPaOm77R9dKuGdogYVbwK0I1WaJfySVSriM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uyCgDRP/abTLDH1GF4bhkMX0G6Uck4hgIgyUBRuXB/drSr9g4g9bKGm5viIR9oygl
	 cP56E8UqUoyxELCQIEk1OYF0wK9VrLrDWxYYc+nMmpWw8waMr9WI7BvBrp4N2WqRfM
	 sg1QsRk3kKCYoyYwdAkATJHWTz8jmDVV0zK0xhLo=
Message-ID: <2f5692d7-6589-4717-8258-f43d8227d74a@arm.com>
Date: Wed, 29 Apr 2026 16:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] arm64: mm: Don't abuse memblock NOMAP to check
 for overlaps
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
 <20260427153416.2103979-28-ardb+git@google.com>
 <8a315ca2-3754-4a66-990e-55b85191aa6e@arm.com>
 <1f9c1ca5-c15c-4a08-aa8c-cbe64f7f205b@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <1f9c1ca5-c15c-4a08-aa8c-cbe64f7f205b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2026 16:23, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2026, at 12:54, Kevin Brodsky wrote:
>> On 27/04/2026 17:34, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> Now that the DRAM mapping routines respect existing table mappings and
>>> contiguous block and page mappings, it is no longer needed to fiddle
>>> with the memblock tables to set and clear the NOMAP attribute in order
>>> to omit text and rodata when creating the linear map.
>>>
>>> Instead, map the kernel text and rodata alias first with the desired
>>> attributes, so that they will not be remapped later with different
>>> attributes when mapping the memblocks.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm64/mm/mmu.c | 24 +++++++-------------
>>>  1 file changed, 8 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 5e2348b15783..1a4b4337d29a 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1148,12 +1148,15 @@ static void __init map_mem(void)
>>>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>  
>>>  	/*
>>> -	 * Take care not to create a writable alias for the
>>> -	 * read-only text and rodata sections of the kernel image.
>>> -	 * So temporarily mark them as NOMAP to skip mappings in
>>> -	 * the following for-loop
>>> +	 * Map the linear alias of the [_text, __init_begin) interval
>>> +	 * as non-executable now, and remove the write permission in
>>> +	 * mark_linear_text_alias_ro() above (which will be called after
>>> +	 * alternative patching has completed). This makes the contents
>>> +	 * of the region accessible to subsystems such as hibernate,
>>> +	 * but protects it from inadvertent modification or execution.
>>>  	 */
>>> -	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>>> +	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
>> Is it now necessary for that mapping to be tagged? If so, it should
>> probably be called out in the commit message.
>>
> As you've pointed out, the initial r/w mapping of the linear alias of rodata
> will need to be mapped tagged before moving the zero page there. So this patch
> will just preserve that, rather than remapping the region tagged explicitly as
> it does now.

Right! I got lost in all the mappings :)

- Kevin
