Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8910DBE5E;
	Mon, 25 Aug 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107118; cv=none; b=Xu253khy5edewycYO6xW8x6r5CopfSpl0jkEHQzn9/PHJeVDSoT/biU1wJ8S1cIOzivJvO4GNG73Wv57rHF2in1fiVo30DOhLUWmToda+o9UVk9WxCv16M7k/9zvXE5gHxtWY+Wg++gCGFcmyHmW8JAem2J2XH0TgaUbfiIG5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107118; c=relaxed/simple;
	bh=r50dDkvFDO+w+5+hTwJQC3IZEVejQAJBD9RW2mT+j/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQH0/b0uy1oQh9cqDsKd9g6WLu+vKnJM+abChR0lq5v9OdvCKD7kLcSUfzXqmUarGdqc4hFnAHLlwK4hNzciNGcA65fvVNgGSok7ZfARoHxDKcNpty6iaJGz1JWHCsb5aq5AQmTQfFbNZEcty4JS79fibTkMj1p+/n0EWsXmo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 601921D70;
	Mon, 25 Aug 2025 00:31:45 -0700 (PDT)
Received: from [10.57.89.148] (unknown [10.57.89.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366D23F738;
	Mon, 25 Aug 2025 00:31:47 -0700 (PDT)
Message-ID: <8e4e5648-9b70-4257-92c5-14c60928e240@arm.com>
Date: Mon, 25 Aug 2025 09:31:44 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 00/18] pkeys-based page table hardening
To: Yang Shi <yang@os.amperecomputing.com>, linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
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
 <98c9689f-157b-4fbb-b1b4-15e5a68e2d32@os.amperecomputing.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <98c9689f-157b-4fbb-b1b4-15e5a68e2d32@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2025 19:29, Yang Shi wrote:
> Hi Kevin,
>
> On 8/15/25 1:54 AM, Kevin Brodsky wrote:
>> This is a proposal to leverage protection keys (pkeys) to harden
>> critical kernel data, by making it mostly read-only. The series includes
>> a simple framework called "kpkeys" to manipulate pkeys for in-kernel
>> use,
>> as well as a page table hardening feature based on that framework,
>> "kpkeys_hardened_pgtables". Both are implemented on arm64 as a proof of
>> concept, but they are designed to be compatible with any architecture
>> that supports pkeys.
>
> [...]
>
>>
>> Note: the performance impact of set_memory_pkey() is likely to be
>> relatively low on arm64 because the linear mapping uses PTE-level
>> descriptors only. This means that set_memory_pkey() simply changes the
>> attributes of some PTE descriptors. However, some systems may be able to
>> use higher-level descriptors in the future [5], meaning that
>> set_memory_pkey() may have to split mappings. Allocating page tables
>
> I'm supposed the page table hardening feature will be opt-in due to
> its overhead? If so I think you can just keep kernel linear mapping
> using PTE, just like debug page alloc.

Indeed, I don't expect it to be turned on by default (in defconfig). If
the overhead proves too large when block mappings are used, it seems
reasonable to force PTE mappings when kpkeys_hardened_pgtables is enabled.

>
>> from a contiguous cache of pages could help minimise the overhead, as
>> proposed for x86 in [1].
>
> I'm a little bit confused about how this can work. The contiguous
> cache of pages should be some large page, for example, 2M. But the
> page table pages allocated from the cache may have different
> permissions if I understand correctly. The default permission is RO,
> but some of them may become R/W at sometime, for example, when calling
> set_pte_at(). You still need to split the linear mapping, right?

When such a helper is called, *all* PTPs become writeable - there is no
per-PTP permission switching.

PTPs remain mapped RW (i.e. the base permissions set at the PTE level
are RW). With this series, they are also all mapped with the same pkey
(1). By default, the pkey register is configured so that pkey 1 provides
RO access. The net result is that PTPs are RO by default, since the pkey
restricts the effective permissions.

When calling e.g. set_pte(), the pkey register is modified to enable RW
access to pkey 1, making it possible to write to any PTP. Its value is
restored when the function exit so that PTPs are once again RO.

- Kevin
