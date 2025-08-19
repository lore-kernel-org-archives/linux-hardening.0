Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BC2311958;
	Tue, 19 Aug 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596114; cv=none; b=fsH7C0kjpmFuvx0jAZUevXI/JoVnr/dID2lD5YK1+CFOqTNRaio5tSWSemGWoziptmNT5NOinYW3mj3pRuNGho1537NzJhfDxp/aTJRowln4HTKaheta/In7GIWuP1t/vCirQjwXYR0v6P4nJVUNrNlXPrZGGt2yTB0WD2dFeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596114; c=relaxed/simple;
	bh=MvE7dKsHCKQMgkg8nrZJ4gLbc2EgzV6+yymuNk9iMkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGS+sk/Afu2cG0U0jYtmPH25pQXtgUp9GFD+6tht2Te0NfckZFwpiW6Pqkd7C4Ftm54EDVxcE1ysyuPXxs1nleJHMhmOjqGxtw4qdQMMJ+5UXA2UmuOYuD0uYB3E/rS+dIDWde6C56dC06k+ErGQ5zbB+4oQiikEX/y1EiL6Uyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE351BD0;
	Tue, 19 Aug 2025 02:35:04 -0700 (PDT)
Received: from [10.57.56.191] (unknown [10.57.56.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4496B3F58B;
	Tue, 19 Aug 2025 02:35:03 -0700 (PDT)
Message-ID: <e4f546cd-67c0-4198-975d-266a7cb9807a@arm.com>
Date: Tue, 19 Aug 2025 11:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 13/18] mm: Map page tables with privileged pkey
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "maz@kernel.org" <maz@kernel.org>,
 "luto@kernel.org" <luto@kernel.org>,
 "mbland@motorola.com" <mbland@motorola.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "david@redhat.com" <david@redhat.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pierre.langlois@arm.com" <pierre.langlois@arm.com>,
 "Weiny, Ira" <ira.weiny@intel.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "jeffxu@chromium.org" <jeffxu@chromium.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "jannh@google.com" <jannh@google.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
 "qperret@google.com" <qperret@google.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "broonie@kernel.org" <broonie@kernel.org>
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <20250815085512.2182322-14-kevin.brodsky@arm.com>
 <616011cf17f1654ac3ad8757f0f33425b3af1ddd.camel@intel.com>
 <b6579c2a-2262-4279-81a5-8235092bea13@arm.com>
 <c8196481fdd338e9d066376b6e9bf1dfcd6ea462.camel@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <c8196481fdd338e9d066376b6e9bf1dfcd6ea462.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 19:01, Edgecombe, Rick P wrote:
> On Mon, 2025-08-18 at 18:02 +0200, Kevin Brodsky wrote:
>> The benchmarking results (see cover letter) don't seem to point to a
>> major performance hit from setting the pkey on arm64 (worth noting that
>> the linear mapping is PTE-mapped on arm64 today so no splitting should
>> occur when setting the pkey). The overhead may well be substantially
>> higher on x86.
> It's surprising to me. The batching seems to be about switching the pkey, not
> the conversion of the direct map.

Correct, there is still a set_memory_pkey() for each PTP.

>  And with batching you measured a fork
> benchmark actually sped up a tiny bit. Shouldn't it involve a pile of page table
> allocations and so extra direct map work?

It should indeed...

> I don't know if it's possible the mock implementation skipped some set_memory()
> work somehow?

In fact you're absolutely right, in the mock implementation I
benchmarked set_memory_pkey() is in fact a no-op :( This is because
patch 6 gates set_memory_pkey() on system_supports_poe(), but the mock
implementation [1] only modifies arch_kpkeys_enabled(). In other words
the numbers in the cover letter correspond to the added pkey register
switches, without touching the page tables.

I am now re-running the benchmarks with set_memory_pkey() actually
modifying the page tables. I'll reply to the cover letter with the
updated numbers.

- Kevin

[1]
https://gitlab.arm.com/linux-arm/linux-kb/-/commit/fd75b43abb354e84d06f3dfb05ce839e9fb13e08

