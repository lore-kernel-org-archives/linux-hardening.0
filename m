Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE4381AE7
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484278; cv=none; b=rxssQJCHT0j7m/7ArX7dGLNAa0Q9Mg4Rv3gxOapoUAE3TnmmIzn3iGKaGwYNsUYP2By+D7v6tv11zBxxgT7z8qWc6b/mq5VMiBkjFQZ5kX3EqFqIQOrP42reHfBLeVI7im3RMMaSoajDp8gl7mDwR3GINkiz6QAZ3+Mk3maXFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484278; c=relaxed/simple;
	bh=vfvNLdQCP2QhgLDeoKvh1hjaGJlPfVJ1+fo5Yn6Jecc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Y/7v/RkevaKegx/JUTLAyyim9V/zRTjiiVs74NmsyuqCVxiIwOQXCwICQMZybizEWHJGpjWfIRllXsbCw3174OSYfl3rOVTSPqdmM/QH11mhyKTDRwOxuD5hf5gWnaXtG15sx0ruo1Y7PdUb/qWw0nNx9BPsV8/Vn/d+tYhlgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhWTc2kL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhWTc2kL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255A8C2BCB8;
	Wed, 29 Apr 2026 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777484278;
	bh=vfvNLdQCP2QhgLDeoKvh1hjaGJlPfVJ1+fo5Yn6Jecc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NhWTc2kLqISC5cwpSaPxT08oZAR2+Ea2mdTwaAtC7zfURsVmZFc5zYzcXqeODPoMT
	 GfLpls0zUnpArSFmLXmZZxEe6rMgSWJXOYLv6cGvbDhYy6FMYhtIlpMU4KBUubq0MG
	 nb9IORFEQRoWwqut9t+ISmzEiL0RAO7cg0BxgUeLjfl6lppK/6Yaa5f/dnBPqVNmF0
	 ynDULK1FvJNJ2jjAL2d3Np7Ix9i6mD/mpOi+kJIZB+f9KgWJAZrFOsgpcy3N8sSJbU
	 0a3eQI+pvfcmfprB8bguLRFdvz/SStQqI697+nnKZDepWjxQl3yRmbI07PelexrSYM
	 e3nVc53WtHTfw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 17A57F40068;
	Wed, 29 Apr 2026 13:37:57 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 29 Apr 2026 13:37:57 -0400
X-ME-Sender: <xms:9UHyabil4gFIhI35RxQ22UuSNHNUkw9Gl9vB9hejUQPNihaezXAeVg>
    <xme:9UHyaS2zkp-hVMCSov8m8UGYssLiK3_6M3qyfK4l3l_D1CjpRGZmC909PkD83E_Fi
    eSKrvH9Eu7cVaZTPiq9OolwN5mpRfGrLbWaGcLNzr8EpoLZ_TZaN7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekhedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepvdeuheeitdevtdelkeduudetgffftdelteefteevjeevjeeiheefhfejieej
    fedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedthedttdejledq
    feefvdduieegudehqdgrrhgusgeppehkvghrnhgvlhdrohhrghesfihorhhkohhfrghrug
    drtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrnhhshhhumhgrnhdrkhhhrghnughurghlsegrrhhmrdgtohhmpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehkvghv
    ihhnrdgsrhhoughskhihsegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlh
    grnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhm
    rdgtohhmpdhrtghpthhtoheprghruggsodhgihhtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehlihiiphhruhgtkhgrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsvght
    hhhjvghnkhhinhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvihgusehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9UHyaWgQb1qiAVaJjoQmSh7-aME5apWDBmmct_h1ZbRpaWqUF1O1ZQ>
    <xmx:9UHyaTU2aUe7OQDYsiV3OM63w4dVKA3wC2sabKazPUG70HBRWQ_JEw>
    <xmx:9UHyaftUUZf1dvcEHx9i6fPR6mCODp2HqXCW28kYfGqXHQNunaTWHA>
    <xmx:9UHyacZvo8qjSYr5_Z8113kMxB2VDyho27deuIeQoZQVj8k6BrOasg>
    <xmx:9UHyaY4XbJ-nGJxGfmQQyDaIGs8Ez_hlo6t2c5K8X0b_4QYOsYPSyMkH>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E9C20700065; Wed, 29 Apr 2026 13:37:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Apr 2026 19:37:36 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
Message-Id: <5279ea66-0e31-4f53-ad76-4fd8ebc012fc@app.fastmail.com>
In-Reply-To: <15555e9f-65ab-4811-b20c-8ada90bdc9d0@arm.com>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-30-ardb+git@google.com>
 <15555e9f-65ab-4811-b20c-8ada90bdc9d0@arm.com>
Subject: Re: [PATCH v4 13/15] arm64: mm: Unmap kernel data/bss entirely from the linear
 map
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, 29 Apr 2026, at 15:55, Kevin Brodsky wrote:
> On 27/04/2026 17:34, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> The linear aliases of the kernel text and rodata are mapped read-only in
>> the linear map as well. Given that the contents of these regions are
>> mostly identical to the version in the loadable image, mapping them
>> read-only and leaving their contents visible is a reasonable hardening
>> measure.
>>
>> Data and bss, however, are now also mapped read-only but the contents of
>> these regions are more likely to contain data that we'd rather not leak.
>
> That sounds like a good rationale but I wonder, is there anything
> stopping us from unmapping text/rodata as well?
>

There is the zero page now, which may be accessed via
'page_address(ZERO_PAGE(0))'. Also, anything that dereferences page tables
(like /sys/kernel/debug/kernel_page_tables) will expect to have read-only
access to swapper_pg_dir.


>> So let's unmap these entirely in the linear map when the kernel is
>> running normally.
>>
>> When going into hibernation or waking up from it, these regions need to
>> be mapped, so map the region initially, and toggle the valid bit so
>> map/unmap the region as needed.
>
> Doesn't safe_copy_page() already handle that? I suppose this is an
> optimisation to avoid modifying the linear map for every page, but if so
> it would be good to spell it out.
>

Uhm, good question.

When hibernate was first implemented for arm64, we had to bring back the
linear alias of the kernel image, and when I started working on this, I
hadn't realised that we have safe_copy_page() now which should take care
of this even if the linear alias is invalid.

However, if I remove this handling, things breaks mysteriously, and it
is a bit tricky to debug so it may take me some time to answer this
question. In any case, I will address this in the next revision, and
put you on cc.

>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  arch/arm64/mm/mmu.c | 44 ++++++++++++++++----
>>  1 file changed, 37 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 9361b7efb848..a464f3d2d2df 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/set_memory.h>
>> +#include <linux/suspend.h>
>>  #include <linux/kfence.h>
>>  #include <linux/pkeys.h>
>>  #include <linux/mm_inline.h>
>> @@ -1040,6 +1041,31 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
>>  				 end - start, prot, early_pgtable_alloc, flags);
>>  }
>>  
>> +static void remap_linear_data_alias(bool unmap)
>> +{
>> +	set_memory_valid((unsigned long)lm_alias(__init_end),
>> +			 (unsigned long)(__fixmap_pgdir_start - __init_end) / PAGE_SIZE,
>> +			 !unmap);
>> +}
>> +
>> +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
>> +				     unsigned long mode, void *unused)
>> +{
>> +	switch (mode) {
>> +	default:
>> +		break;
>> +	case PM_POST_HIBERNATION:
>> +	case PM_POST_RESTORE:
>> +		remap_linear_data_alias(true);
>> +		break;
>> +	case PM_HIBERNATION_PREPARE:
>> +	case PM_RESTORE_PREPARE:
>> +		remap_linear_data_alias(false);
>> +		break;
>> +	}
>> +	return 0;
>> +}
>> +
>>  void __init mark_linear_text_alias_ro(void)
>>  {
>>  	/*
>> @@ -1048,6 +1074,16 @@ void __init mark_linear_text_alias_ro(void)
>>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>>  			    (unsigned long)__init_begin - (unsigned long)_text,
>>  			    pgprot_tagged(PAGE_KERNEL_RO));
>> +
>> +	remap_linear_data_alias(true);
>
> It's really hard to know what this does without looking at the function.
> How about mark_linear_data_alias_valid(false)?
>

Sure.

>> +
>> +	if (IS_ENABLED(CONFIG_HIBERNATION)) {
>> +		static struct notifier_block nb = {
>> +			.notifier_call = arm64_hibernate_pm_notify
>> +		};
>> +
>> +		register_pm_notifier(&nb);
>> +	}
>>  }
>>  
>>  #ifdef CONFIG_KFENCE
>> @@ -1162,7 +1198,7 @@ static void __init map_mem(void)
>>  
>>  	/* Map the kernel data/bss so it can be remapped later */
>>  	__map_memblock(init_end, kernel_end, pgprot_tagged(PAGE_KERNEL),
>> -		       flags);
>> +		       flags | NO_BLOCK_MAPPINGS);
>
> Might be an obvious question but why do we need this?
>

set_memory_valid() only works on regions that are mapped down to pages.


