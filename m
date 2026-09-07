Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4A23EEAC7
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796243; cv=none; b=rT2e4lJ+hNgbXucxJptmGRyl/SiQOV7mEkOL7fgTecgRxFHH8goBgy0cH9d3uJpx6hzSoO6dFPIt5mr3bP5uMuFsbIgpmA/hTC1RdUs3qmhtmtKpyPt34WumdNYdiA0AzywuerHzsDl20rsj+lhi5etucZ4MHzYGTSaZcT0s44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796243; c=relaxed/simple;
	bh=SlilMlpGicltaebBQ8I/GC+iE4frt6Y1f/gAHvySSDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/Lx8yrlUUK56Y6Zf/B15+0Ec/CtOcPmxGQP1xP9PKhUdN1APDKYDSRsIVwPOFbjI5vsVb+gvPqzTj1ENPnODGrblkH2vKbum0cBRk3q0LEDpyVgptdHgZkzYcHS5zgH4hWCQODTuwXzqoQA8XzfNhOTdMWso6TjzPvQDXZNrnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iqQG57G5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iqQG57G5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F17421476;
	Mon,  7 Sep 2026 08:50:35 -0700 (PDT)
Received: from [10.57.6.26] (unknown [10.57.6.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84DEE3F7B4;
	Mon,  7 Sep 2026 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788796239; bh=SlilMlpGicltaebBQ8I/GC+iE4frt6Y1f/gAHvySSDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iqQG57G5PDVhyw+vfLok9WQkjMSwIU3sN60egn04GlddymBAdaexzT4zstzK5PxY0
	 28Bg4YQ63K5zQ+At/Qb/iDsJW7qSK16xoEp8sCDBbDw6BZlhdLqg23swtYz/GX344K
	 +AGPNAn1CqfVXdKotmnH1oNQu3GUWshCTEXPjLlQ=
Message-ID: <37bfd819-2bd4-4893-9d58-48c7e10880a3@arm.com>
Date: Mon, 7 Sep 2026 17:50:31 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 11/25] mm: kpkeys: Introduce
 kpkeys_hardened_pgtables feature
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>,
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, Peter Zijlstra <peterz@infradead.org>,
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
 <20260818-kpkeys-v9-11-743ad31b2c8f@arm.com>
 <178877845406.3691569.11239630051799000768.b4-review@b4>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <178877845406.3691569.11239630051799000768.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2026 12:54, Mike Rapoport wrote:
> Hi Kevin,
>
>> kpkeys_hardened_pgtables is a hardening feature based on kpkeys. It
>> aims to prevent the corruption of page tables by: 1. mapping all
>> page table pages, both kernel and user, with a privileged pkey
>> (KPKEYS_PKEY_PGTABLES), and 2. granting write access to that pkey
>> only when running at in a privileged kpkeys context
>> (KPKEYS_CTX_PGTABLES). This patch introduces basic infrastructure;
>> the implementation of both aspects will follow.
>>
>> The feature is exposed as CONFIG_KPKEYS_HARDENED_PGTABLES; it
>> requires explicit architecture opt-in by selecting
>> ARCH_HAS_KPKEYS_HARDENED_PGTABLES, since much of the page table
>> handling is arch-specific.
>>
>> Because this feature relies on kpkeys being supported and modifies
>> attributes of the linear map, it must be inactive on boot.
>> kpkeys_hardened_pgtables_init() enables it by toggling a static key;
>> this function must be called by supported architectures in
>> mem_init(), before any call to pagetable_alloc() is made.
> Presuming other architecures will use kpkeys framework it's better to
> call kpkeys_hardened_pgtables_init() from mm_core_init() rather than
> stick into each arch's mem_init().

Ah yes I was wondering whether it was acceptable to stick another call
directly in mm_core_init(), but I suppose it doesn't hurt. I can move
the call to kpkeys_hardened_pgtables_init() just before
memblock_free_all() and leave mem_init() alone.

Thanks for chipping in!

- Kevin
