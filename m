Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546CF4EBAF7
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453730; cv=none; b=jvwWRcpDz4Ok/dJrUVj64MPwWV6h5NumR/3CqwvaTUtfify0FQ5YSKG3YktafJTFD9hZppq+1eioljFZsAypcQm6Yca/BIJbMJM33+A6W87K+T5ySqY2Xsy1RaYx0dd04pFMwLE7p4dc7p0Ph+t9hprAOi7k6/XGyoi6x9B71CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453730; c=relaxed/simple;
	bh=hpWgr2ZJY3qJKLttzHDS9l/xybICdRKBZ0Vb9KipRwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVm2cQBWPhrRcDeR10Z/62ElVP3l16MtYUY9/AZ8CFNIK5mU0A+lWPVXkHUBZ2F9wgqpDTZ1qPuMUarenCE92feK5LUmyDTI3aBL6BFgx4VQ3ucPohiTdLwuHXaTCMOVQbyQgbXv9hWvLYZtJ4svn0zTxGVDfGGyhI0oo1iTd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jS2Asm/U; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jS2Asm/U"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEC7E1596;
	Thu,  3 Sep 2026 09:42:03 -0700 (PDT)
Received: from [10.57.6.2] (unknown [10.57.6.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F24943F673;
	Thu,  3 Sep 2026 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788453727; bh=hpWgr2ZJY3qJKLttzHDS9l/xybICdRKBZ0Vb9KipRwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jS2Asm/UwfhzBaNFvf9emw9gKWsaUHT9+Ly9ueyblpJtMszHw0BiQrvZPl/Bzqq5c
	 ROwk1AuUKsBRjDM/KXiD2FJZeqlNkN/NkAdAbAKu5SuquX6KDjPQzQ8pgcjEcU7WYq
	 AOJfjrL3ylui6l8L/lkx7tW8ReJG/FtIsmjp6kbU=
Message-ID: <91154245-af39-4e93-bf2f-dd878f86c9a0@arm.com>
Date: Thu, 3 Sep 2026 18:41:57 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 03/25] arm64: mm: Enable overlays for all EL1
 indirect permissions
To: Linu Cherian <linu.cherian@arm.com>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-3-743ad31b2c8f@arm.com>
 <apbjpkTgtdXZQ9Sm@a079125.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <apbjpkTgtdXZQ9Sm@a079125.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2026 16:39, Linu Cherian wrote:
> Kevin,
>
> On Tue, Aug 18, 2026 at 03:08:45PM +0100, Kevin Brodsky wrote:
>> In preparation of using POE inside the kernel, enable "Overlay
>> applied" for kernel memory types in PIR_EL1. This ensures that the
>> permissions set in POR_EL1 affect all kernel mappings.
>>
>> User memory types must be left untouched (overlays not applied)
>> because any privileged access to user memory (e.g. futex atomic
>> without FEAT_LSUI) would then be mistakenly checked against POR_EL1.
>>
>> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  arch/arm64/include/asm/pgtable-prot.h | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index 212ce1b02e15..d4d45ab86a5a 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -183,9 +183,9 @@ static inline bool __pure lpa2_is_enabled(void)
>>  	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW)     | \
>>  	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_READONLY),      PIE_R)      | \
>>  	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_SHARED),        PIE_RW)     | \
>> -	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_ROX),    PIE_RX)     | \
>> -	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_EXEC),   PIE_RWX)    | \
>> -	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_RO),     PIE_R)      | \
>> -	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL),        PIE_RW))
>> +	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_ROX),    PIE_RX_O)   | \
>> +	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_EXEC),   PIE_RWX_O)  | \
>> +	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL_RO),     PIE_R_O)    | \
>> +	PIRx_ELx_PERM_PREP(pte_pi_index(_PAGE_KERNEL),        PIE_RW_O))
>>  
>>  #endif /* __ASM_PGTABLE_PROT_H */
> IMHO its better to have this patch just before, "arm64: Enable kpkeys" for
> easier review. Otherwise,

Sure, I'll move it.

> Reviewed-by: Linu Cherian <linu.cherian@arm.com>

Thanks!

- Kevin
