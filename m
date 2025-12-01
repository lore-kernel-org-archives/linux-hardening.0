Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C31C5D72;
	Mon,  1 Dec 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764580793; cv=none; b=hIJ7NLzFNmB1gqyRPd2gWTxUD0x4dFgI7AS2qg2njln143aY+sGkaKABMq1K/kvt6/QfSNCHeaLrn97ioLj+YZRZ2jW/Rv9zlRB1jSjv7pNsUt5BcNqk+eaQXuySfaYOa3DdrwpX2zKRrW2/tTPSGAeqXsCVX+Rf9cQly6upoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764580793; c=relaxed/simple;
	bh=0DdZnabsp3ToxFO0rRcwfSvvjKjrFHLPmIfy3O6p5es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tq8fX6Kt1VZPGGws/Ud+z7Bx/vIsZHTZ+kHD7F6MoMkzKDC1p1zwkJ9vpV/1NFtJm+jkVzxvOUXVpOVHf4Qs3Lc3X+XArN88n60Ozv8ra225SszBWXfURujglHkBpmzDXi/vPzZShyPg5WsKQsCXXweEY8ufUKlfb9AC/Ej1viI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C10497;
	Mon,  1 Dec 2025 01:19:42 -0800 (PST)
Received: from [10.57.43.170] (unknown [10.57.43.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC6FF3F73B;
	Mon,  1 Dec 2025 01:19:43 -0800 (PST)
Message-ID: <c1226873-c790-49bd-876d-4539f95b4caf@arm.com>
Date: Mon, 1 Dec 2025 10:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 11/18] mm: Introduce kpkeys_hardened_pgtables
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
 Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <20250815085512.2182322-12-kevin.brodsky@arm.com>
 <aSnRVJwuRWPmPxqN@e129823.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <aSnRVJwuRWPmPxqN@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2025 17:44, Yeoreum Yun wrote:
>> +int kpkeys_protect_pgtable_memory(struct folio *folio)
>> +{
>> +	unsigned long addr = (unsigned long)folio_address(folio);
> I think it might need to use untagged_addr()?

I've never seen untagged_addr() used on folio_address()/page_address()
(see for instance set_direct_map_valid_noflush() and
__kernel_map_pages() in arch/arm64/mm/pageattr.c).

It does seem that page_to_virt() sets the tag if KASAN is enabled
though... I'm not sure what to think, is there a wider issue here? We
might just be lucky and the sort of pages that these functions are
called on don't have their KASAN tag set.

- Kevin
