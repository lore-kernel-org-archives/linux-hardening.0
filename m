Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520063CF95E
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810866; cv=none; b=qGGrjUpC9Kz1cRQBpwEcjca5Jecia9geZDkAKx8TB+C+F4S6q/tRv4MeXqi+tetR1kP0zBjQRPOay82tuoxBLHkwn5DO4Viw4o9xEzK4hcXlHitZJ0gYezIwi01Q/7TP9dJm6LzDV6HI1VmtABAqQRXNLCMT9xWxdpY+XMAocnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810866; c=relaxed/simple;
	bh=gWU2+q57VLQEQbWXLkaWbWHCxJakIwq33zdaa5p1Eu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LH+B2a5QUxyt28FvVJ+BPWX/BqIraPTMWx1CjPDVkQwYJZDDn5B+877DmG+Zt5vMlin093dvd709XWTpgZ5hvPzv0tlanrFpPiLJhiaXofBAxAlFeKTmp7+pGixTxsp7Kyfke6xEwygScLx6FFIQxZJ3cd1+b9GIY4rTYC97Dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XjRXYR50; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XjRXYR50"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1DF2C1C;
	Tue, 30 Jun 2026 02:14:20 -0700 (PDT)
Received: from [10.57.81.132] (unknown [10.57.81.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16E913FAFB;
	Tue, 30 Jun 2026 02:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782810864; bh=gWU2+q57VLQEQbWXLkaWbWHCxJakIwq33zdaa5p1Eu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XjRXYR504D+Vxscp6Uvahb1H/yAoW0+cH56gS/Gc1aRNw2VZXb9jFW5zgD3p2d2gO
	 3E/MVCbHlFCImB7zkUo3wn4AUZVbYzG1ySzXEwb8GqLYQwL+DiAWM4MRJgJUnn/nTl
	 k7YNttTCKDuukMPf3Ch7PvgZk+8uZgczy5xupOUA=
Message-ID: <0ac4e410-c73a-4fe7-a248-4c0ff735e73f@arm.com>
Date: Tue, 30 Jun 2026 11:14:10 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v8 02/24] set_memory: Introduce set_memory_pkey() stub
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 linux-hardening@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com>
 <20260526-kpkeys-v8-2-eaaacdacc67c@arm.com>
 <e026ab6b-aee2-48e7-9bb5-1735d7a23859@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <e026ab6b-aee2-48e7-9bb5-1735d7a23859@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2026 17:41, David Hildenbrand (Arm) wrote:
> On 5/26/26 13:15, Kevin Brodsky wrote:
>> Introduce a new function, set_memory_pkey(), which sets the
>> protection key (pkey) of pages in the specified linear mapping
>> range. Architectures implementing kernel pkeys (kpkeys) must
>> provide a suitable implementation; an empty stub is added as
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
>> +
>>  #endif /* _LINUX_SET_MEMORY_H_ */
>>
> This patch looks rather odd, given that this is just a stub that won't be used
> before patch #20.
>
> And there, it's only used from arm64 code? So why do we need the common-code stub?

It is primarily used in patch 12, the generic kpkeys page table
allocator, so we do need a stub.

The ordering might be a little confusing indeed, but I tried to follow
the following order: 1. kpkeys/generic, 2. kpkeys/arm64, 3.
kpkeys_hardened_pgtables/generic, 4. kpkeys_hardened_pgtables/arm64.
Happy to reorder if you have other preferences.

- Kevin
