Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82B48F822
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453704; cv=none; b=OtnCr3pgyLj3fd1DTRFKMQf7iNPej32/hpG1VCRpsekRxuIaDYJLvMjoNYN2KGhMcYD+Pg4UZhEPmKvhOG0kPiVpg2S+Bj4jFplNN/tkidlMAV89OWPjbHEeUx2n0l9WBO0/EdQJB5XItTMwnh4ibwCrmMEhSaY59VQ23PTi4x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453704; c=relaxed/simple;
	bh=fMTmPuGTue6HNbPKyeiunkqMe/FTnn9ZFj8qnYLsnh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgyzGnhppmyzCSHY6MMj7kC7yuZkF2Yv4DYIdm8uSGzthfhpLFWTcAZRQhCiORIguaKIGwPdMJQXR9w4sAytZMduLlW5ieOv/xdkgZAJanOkJd3ShUgRIyb+2PxbiAIY0fMd0vJc+M/XBSCZsrGcl3m6korOISFayMdexhv2msQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JRoxl9E+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JRoxl9E+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4E81596;
	Thu,  3 Sep 2026 09:41:39 -0700 (PDT)
Received: from [10.57.6.2] (unknown [10.57.6.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9A193F673;
	Thu,  3 Sep 2026 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788453702; bh=fMTmPuGTue6HNbPKyeiunkqMe/FTnn9ZFj8qnYLsnh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JRoxl9E+QrX+IO3atrSghjI9x/qg48SBeUoB1iHXHkCx7rak+q7DUoHyAtcB2PWYV
	 hmycgMaqDchkjeaR2c2OvTp7h462MRv11iGZ4k/gz8RFYH0JjEvEaYuMwxBYfLXZdP
	 a/vAsnGfvbfQ8np3IkFUOQE1xCeEA50NtIZsQ9qE=
Message-ID: <66270f42-931f-4043-b24c-edcc4cad74b8@arm.com>
Date: Thu, 3 Sep 2026 18:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 02/25] set_memory: Introduce set_memory_pkey() stub
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
 <20260818-kpkeys-v9-2-743ad31b2c8f@arm.com>
 <apbiQtt-cAlLkDqV@a079125.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <apbiQtt-cAlLkDqV@a079125.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2026 16:33, Linu Cherian wrote:
> Kevin,
>
> On Tue, Aug 18, 2026 at 03:08:44PM +0100, Kevin Brodsky wrote:
>> Introduce a new function, set_memory_pkey(), which sets the
>> protection key (pkey) of pages in the specified linear mapping
>> range. Architectures implementing kernel pkeys (kpkeys) must
>> provide a suitable implementation; an empty stub is added as
> Could you make it explicit here why we are restricting this only
> to the linear mapping range ? Would be helpful to add the reasoning
> in the commit message and as comments.
>
> Essentially we are also making a assumption here that there are no
> aliases to the linear map ?

We're not assuming this, this function is called on pages that are also
mapped as part of the kernel image. But indeed it ignores aliases,
unlike e.g. set_memory_ro(). Really its name is wrong as discussed below.

>> fallback.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  include/linux/set_memory.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
>> index 3030d9245f5a..7b3a8bfde3c6 100644
>> --- a/include/linux/set_memory.h
>> +++ b/include/linux/set_memory.h
>> @@ -84,4 +84,11 @@ static inline int set_memory_decrypted(unsigned long addr, int numpages)
>>  }
>>  #endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
>>  
>> +#ifndef CONFIG_ARCH_HAS_KPKEYS
>> +static inline int set_memory_pkey(unsigned long addr, int numpages, int pkey)
>> +{
>> +	return 0;
>> +}
>> +#endif
> Would be better to make this (linar map range)constraint on the API name or that passed
> as a boolean flag ?

Indeed, in fact I've been thinking about renaming this function for a
while and I've already done it locally :) It'll be set_direct_map_pkey()
in the next version.

> Also, it would be better to have the __is_lm_address checks in this generic wrapper which
> then calls arch_set_memory_pkey ?

That's not unreasonable, but such pattern isn't used by other functions
in set_memory.h and I'd rather not deviate too much without a good reason.

- Kevin
