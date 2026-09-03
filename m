Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD62477984
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453840; cv=none; b=IoNhj7f1gGTd5JF2szp7FhpG5thZTUkOsj61pJEJQf3w4Vfip5Vxx+y5U0ZAfZ1JBSWE7o/PD+/1Kpanu76Dfnft8PL5Eic51Axgad8C89eUnLjaPG2dbZardTYVK98qzSb9vBEI5+OTDrUncOP9LiNnAxMmZBWGjIycaKZ8Nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453840; c=relaxed/simple;
	bh=vWWRzkp0+9oMKve+SrPMb4YS1xG2sCsAn/SyP8y3BvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMDwzKPG0bczZDJZPZ7WsWrbhL/UM0vFJdEgWbw1QpaTZGXNn//MktdFGIO1UBwlCczL50vCs4tg9VdlSe94M2VhBWwZk8zPkqoJcfN2jDF+6TsXGqwzEaTvfgJka8IFdinivBWQ038naF4qWULPncKbWzxIdnFOnZMGDnfKrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tENFd08k; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tENFd08k"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DF901596;
	Thu,  3 Sep 2026 09:43:54 -0700 (PDT)
Received: from [10.57.6.2] (unknown [10.57.6.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D35D3F673;
	Thu,  3 Sep 2026 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788453837; bh=vWWRzkp0+9oMKve+SrPMb4YS1xG2sCsAn/SyP8y3BvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tENFd08kZU5BI9AevP2DP6ylP6FwwMDs48XD+uMO7L0Bhz+L9BtkDN4I/SheeQ1Zu
	 vh3KCgFk+KLoT4gq3yBTLs7TWPaLUAlYsO6mFXeDPTzA2CxeRUO++TSblimvJgqJm4
	 jYV5T0gUjWBtFbQkkOYjGhGmPiH+d6vIqx+nfiEE=
Message-ID: <c234ed1b-b8ba-4a90-bb16-96d34878b893@arm.com>
Date: Thu, 3 Sep 2026 18:43:48 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 04/25] arm64: Introduce por_elx_set_pkey_perms()
 helper
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
 <20260818-kpkeys-v9-4-743ad31b2c8f@arm.com>
 <apbkbH6Q4p5KYmpE@a079125.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <apbkbH6Q4p5KYmpE@a079125.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2026 16:42, Linu Cherian wrote:
> Kevin,
>
> On Tue, Aug 18, 2026 at 03:08:46PM +0100, Kevin Brodsky wrote:
>> Introduce a helper that sets the permissions of a given pkey
>> (POIndex) in the POR_ELx format, and make use of it in
>> arch_set_user_pkey_access().
>>
>> new_por now represents the permissions of a single pkey, so rename
>> it to new_perms and change its type accordingly.
>>
>> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  arch/arm64/include/asm/por.h |  7 +++++++
>>  arch/arm64/mm/mmu.c          | 26 ++++++++++----------------
>>  2 files changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
>> index d913d5b529e4..19b3dd1d43a0 100644
>> --- a/arch/arm64/include/asm/por.h
>> +++ b/arch/arm64/include/asm/por.h
>> @@ -31,4 +31,11 @@ static inline bool por_elx_allows_exec(u64 por, u8 pkey)
>>  	return perm & POE_X;
>>  }
>>  
>> +static inline u64 por_elx_set_pkey_perms(u64 por, u8 pkey, u8 perms)
>> +{
>> +	u64 shift = POR_ELx_PERM_SHIFT(pkey);
>> +
>> +	return (por & ~(POE_MASK << shift)) | ((u64)perms << shift);
> We could use standard bit field access macros here ?

Good idea, will do.

- Kevin
