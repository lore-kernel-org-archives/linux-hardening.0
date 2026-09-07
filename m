Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC383769E8
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796656; cv=none; b=KsyPkbnQpZzVO6V4U9Ysfbebcd6fkGTi+ZbGL/9xsqip20DqmjbXz35pNsNyccASHMNeOW78kjZZ+H0Zc8kHDsYBSYFlsWGvyzex0eiW9bHCTrNJQmePMqCqshKEaK0VWSxiyJTCuqOUOVljg/YSPv8KstPn27oVchtN1oncqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796656; c=relaxed/simple;
	bh=w5zh8+YEqIL7Da8jRMe/ZtD44KnS8L2RNXnBst2nX6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsiyyYh13BvmiM7GdotgeeY5u7s7eSI1hp0I06XaqaRIODSRzvL68z4H03KnQu9kv9oOgUOOxrjSnFLvx7Lhqqqz7whN6QjDJ4CLTfDnM1BOTECYlHmHL8YgNm9iH91tgNnPuqA4xlhLgRRJW8h/8C1XnlZAJwpi1AEiAuTxvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AaM3yh0x; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AaM3yh0x"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50E381476;
	Mon,  7 Sep 2026 08:57:29 -0700 (PDT)
Received: from [10.57.6.26] (unknown [10.57.6.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378513F7B4;
	Mon,  7 Sep 2026 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788796653; bh=w5zh8+YEqIL7Da8jRMe/ZtD44KnS8L2RNXnBst2nX6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AaM3yh0xOgzbvXYmz93UziW0pjOZ1xdk/WQ3/O6JBZpUCfdcXFozelYjzp+orLKxK
	 z43acjBXfj4jU2BjMV5jUqWkdSRU1RZzLKUxqilJT1vHvX1ZsaA+m73yq9rjzrXGTK
	 Fl+At6aoBW9W2QS1w2vo0WFra64rnVfprPZ3MDoY=
Message-ID: <1293ff87-51ad-456b-b973-26f29d0beaff@arm.com>
Date: Mon, 7 Sep 2026 17:57:24 +0200
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
 <66270f42-931f-4043-b24c-edcc4cad74b8@arm.com>
 <ap694bZb0crWvLo3@a079125.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <ap694bZb0crWvLo3@a079125.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2026 15:36, Linu Cherian wrote:
>>>> Introduce a new function, set_memory_pkey(), which sets the
>>>> protection key (pkey) of pages in the specified linear mapping
>>>> range. Architectures implementing kernel pkeys (kpkeys) must
>>>> provide a suitable implementation; an empty stub is added as
>>> Could you make it explicit here why we are restricting this only
>>> to the linear mapping range ? Would be helpful to add the reasoning
>>> in the commit message and as comments.
>>>
>>> Essentially we are also making a assumption here that there are no
>>> aliases to the linear map ?
>> We're not assuming this, this function is called on pages that are also
>> mapped as part of the kernel image. But indeed it ignores aliases,
>> unlike e.g. set_memory_ro(). Really its name is wrong as discussed below.
> Just trying to understand, does it also imply that we dont have use cases that has aliases.

We don't need to change the pkey of mappings outside the direct map for
protecting page tables, at least not yet. They are almost always
accessed via the direct map, but as Ard's recent series [1] shows, there
are exceptions.

- Kevin

[1]
https://lore.kernel.org/all/20260827164409.3421848-6-ardb+git@google.com/
