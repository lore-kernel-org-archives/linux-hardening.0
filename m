Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646943EFD36
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081388; cv=none; b=YyeDjTW/Z1wVuQb8+dNUKx53W8ejvlhndn/EIzfvlJBeTDQNsAwW/aJnXushcFCyV/Ffu6SfYMWqC+llOwZgtLb4cyrvac95gT5P0Hh9N0x7spZtZQLveuXrqgjVmFgEEj8tLHpVK71EOllQajgYI9v5fGurJtaZpJ6jsyZwdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081388; c=relaxed/simple;
	bh=ip9HLEiG0rLbNmSPtdtn1g8pMwO4gElNKtnSHYmseRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOgfpeVltbgoG2ibaJ/PUhjiTOQolhNLM427QbUWXTmfRH4OXwvBvTlsYNSNnyg60e/AirU/KXmqGhBmEjzkANmCTuB7V7B8gwpkFsDjFrQEOTIZT+wmgvUzb5+YPiROGrY17eQSJOvAN+PclyU4CuDOg0ChLF1GV9/6cN+DV9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uFirFSB7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uFirFSB7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB5FC1A00;
	Wed,  6 May 2026 08:29:37 -0700 (PDT)
Received: from [10.57.35.178] (unknown [10.57.35.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ECE23F7B4;
	Wed,  6 May 2026 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778081383; bh=ip9HLEiG0rLbNmSPtdtn1g8pMwO4gElNKtnSHYmseRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uFirFSB72AiOef9KIv+LoT9vVvtJCtTeQjSPmbbHWBwooyjT8eiFl6hli9r8u2BPS
	 gHyC5cl7Wkl3o2/jxclgGiXD3j4kM3UhGaulOOhnlK8I+2AmysP0zN+JdbUzX+Vc9a
	 hoBjF8BQMLMCsZkysXmV9xqpxgEHR0MXfBg+hjU8=
Message-ID: <77d63e89-04be-4b76-b360-dc45badd1a78@arm.com>
Date: Wed, 6 May 2026 17:29:30 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 00/24] pkeys-based page table hardening
To: linux-hardening@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Ira Weiny
 <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>
References: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260505-kpkeys-v7-0-20c0bdd97197@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2026 18:05, Kevin Brodsky wrote:
> Kevin Brodsky (23):
>       mm: Introduce kpkeys
>       set_memory: Introduce set_memory_pkey() stub
>       arm64: mm: Enable overlays for all EL1 indirect permissions
>       arm64: Introduce por_elx_set_pkey_perms() helper
>       arm64: Implement asm/kpkeys.h using POE
>       arm64: set_memory: Implement set_memory_pkey()
>       arm64: Context-switch POR_EL1
>       arm64: Enable kpkeys
>       memblock: Move INIT_MEMBLOCK_* macros to header
>       mm: kpkeys: Introduce kpkeys_hardened_pgtables feature
>       mm: kpkeys: Protect regular page tables
>       mm: kpkeys: Introduce early page table allocator
>       mm: kpkeys: Protect vmemmap page tables
>       mm: kpkeys: Introduce hook for protecting static page tables
>       arm64: kpkeys: Implement arch_supports_kpkeys_early()
>       arm64: kpkeys: Support KPKEYS_CTX_PGTABLES
>       arm64: kpkeys: Ensure the linear map can be modified
>       arm64: kpkeys: Protect early page tables
>       arm64: kpkeys: Protect init_pg_dir
>       arm64: kpkeys: Guard page table writes
>       arm64: kpkeys: Batch KPKEYS_CTX_PGTABLES switches
>       arm64: kpkeys: Enable kpkeys_hardened_pgtables support
>       mm: Add basic tests for kpkeys_hardened_pgtables
>
> Yeoreum Yun (1):
>       arm64: Initialize POR_EL1 register on cpu_resume()
>
>  arch/arm64/Kconfig                        |   2 +
>  arch/arm64/include/asm/cpufeature.h       |  12 ++
>  arch/arm64/include/asm/kpkeys.h           |  76 ++++++++++++
>  arch/arm64/include/asm/pgtable-prot.h     |  16 +--
>  arch/arm64/include/asm/pgtable.h          |  66 +++++++++-
>  arch/arm64/include/asm/por.h              |  11 ++
>  arch/arm64/include/asm/processor.h        |   2 +
>  arch/arm64/include/asm/set_memory.h       |   4 +
>  arch/arm64/kernel/cpufeature.c            |   5 +-
>  arch/arm64/kernel/process.c               |   9 ++
>  arch/arm64/kernel/sleep.S                 |  12 ++
>  arch/arm64/mm/fault.c                     |   2 +
>  arch/arm64/mm/init.c                      |   1 +
>  arch/arm64/mm/mmu.c                       |  48 +++++---
>  arch/arm64/mm/pageattr.c                  |  29 ++++-
>  include/asm-generic/kpkeys.h              |  21 ++++
>  include/linux/kpkeys.h                    | 177 ++++++++++++++++++++++++++
>  include/linux/memblock.h                  |  11 ++
>  include/linux/mm.h                        |  14 ++-
>  include/linux/set_memory.h                |   7 ++
>  mm/Kconfig                                |   5 +
>  mm/Makefile                               |   2 +
>  mm/kpkeys_hardened_pgtables.c             | 180 +++++++++++++++++++++++++++
>  mm/memblock.c                             |  11 --
>  mm/sparse-vmemmap.c                       |  29 +++--
>  mm/tests/kpkeys_hardened_pgtables_kunit.c | 198 ++++++++++++++++++++++++++++++
>  security/Kconfig.hardening                |  24 ++++
>  27 files changed, 923 insertions(+), 51 deletions(-)

Sashiko has found quite a few issues, some of which are potentially
concerning. I'll address them in RFC v8 - no need to point me to them
until then.

- Kevin
