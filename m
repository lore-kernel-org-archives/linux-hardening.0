Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26D3D3D05;
	Wed,  8 Apr 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660990; cv=none; b=VJ2p083BR5tEiW0pNTVx3eii/ET5bYqx9Ch8Bn8fbk5kYUqiisplqcHz0FaGN0G4EZ2YpBqfjDYQC9DejJwluM6xq7lZnj0zyMvZg6+EvV/GgvSMeYLC3TjYP9eJUqE77PqmFo2H0X28IgFjyy2TJb5ICwQEk1aBCqwrfyyo9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660990; c=relaxed/simple;
	bh=mGjriEUZMr+g1US10EShfrBqzpTUxxutiWrD+5RgSQA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C9x+ShaEGxxQBk5O/u/7QLrbjYwbm/pg2seoRxiLmFslTHkTgnZoKM+41BSVVIfuig/xU1yM2FKCFo2DRTfU5gZbAwdTrtxsTUjaKRg96bCcHcNjDjRkQuIYPdINmmPf2wsMm7TF8x+byTVXPtn6n3wsw0xEGcUHupqhc9PWZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPNSFvNw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPNSFvNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB81C19421;
	Wed,  8 Apr 2026 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775660989;
	bh=mGjriEUZMr+g1US10EShfrBqzpTUxxutiWrD+5RgSQA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rPNSFvNwU9jUtaJkM6mI86/toyzKHxm0pb4sc8hYlgcvdzpXI/tmpLVuJKLupvvXS
	 InsiegzET6+urXis2LaRuun+w+XYJ42FqQeAYhwlfVP56LYM5h9zSZO4Ds2HKBP/YW
	 N4VQ0B1MeL5ppNRABL9U8MaIotmsI9URRiJmrgjE/y7X0nxgkEbQQE3YBlem/wDXCL
	 77whK/enQA/j6MjtdK77Uz35+JctjdJkcpUnnF/Yco11/Y7JfacGi7vAGCyHR/qcPY
	 mBNNTQPOtHBsQ+zZwp0BiWOQoia2iCnJstAvRse5f/7yKtRORnz5yyaBO8uBWK5ul/
	 pgEBui0w7LdCA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 21B8FF4007E;
	Wed,  8 Apr 2026 11:09:48 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 08 Apr 2026 11:09:48 -0400
X-ME-Sender: <xms:vG_WaSW2T0IDV5IhknxKHye7IAvdBN05GVF0K1UTR3cSTuIj32wYTQ>
    <xme:vG_WaZafQLXikZhBFOkTobqaBllyDe5eDbOCV38dXYSOzanJUKXElLQaf9XCiyBpT
    nsjVRGNh0ujXaBkZmBKfL34yp8W1mZvxtLYdfEhLEG3qP14hYOVCrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepuddvvdfhgfetueevleejvdejudeigfekheeggeetteetueeitdfgieelfeej
    kedunecuffhomhgrihhnpehlughsrdhssgdpshgrshhhihhkohdruggvvhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhguodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeelqdeffedvudeigeduhe
    dqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrhgurdgtohhmpdhnsggp
    rhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnshhhuh
    hmrghnrdhkhhgrnhguuhgrlhesrghrmhdrtghomhdprhgtphhtthhopegtrghtrghlihhn
    rdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnh
    gusegrrhhmrdgtohhmpdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgt
    ohhmpdhrtghpthhtoheprghruggsodhgihhtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehlihiiphhruhgtkhgrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsvghthhhj
    vghnkhhinhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vG_WaaTndSDqM8rvYCzXCurufS_g5gaePe1OFHhpwGY20cQHYEBycg>
    <xmx:vG_WaWJ369XN4dDFHzXG379k7hR9VwtaBG7BzOD1GWUzNdkGao1K6w>
    <xmx:vG_WaUECzCmOnWaaoNBzviV2d6HqqY21_KQW2-mjV6yB9uE-uip9iQ>
    <xmx:vG_WaT37PO0vSGNgj1WyXpV6jvRd_wfPkbo0qFGVBzO0lRunMPq7Xg>
    <xmx:vG_WacLR1efsObTuQS-qBINiOr_7UseIdHQ1uy5t31lM2Gxq-brV63Lp>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F2328700065; Wed,  8 Apr 2026 11:09:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVizydSA80Ew
Date: Wed, 08 Apr 2026 17:09:26 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, linux-hardening@vger.kernel.org
Message-Id: <52abb233-80c5-4363-871d-cd52667291ad@app.fastmail.com>
In-Reply-To: <adZbgYJqY6bisaoZ@arm.com>
References: <20260320145934.2349881-15-ardb+git@google.com>
 <20260320145934.2349881-16-ardb+git@google.com> <adZbgYJqY6bisaoZ@arm.com>
Subject: Re: [PATCH v3 01/13] arm64: Move the zero page to rodata
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, 8 Apr 2026, at 15:43, Catalin Marinas wrote:
> Hi Ard,
>
> On Fri, Mar 20, 2026 at 03:59:36PM +0100, Ard Biesheuvel wrote:
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 2964aad0362e..2d021a576e50 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -229,6 +229,7 @@ SECTIONS
>>  #endif
>>  
>>  	reserved_pg_dir = .;
>> +	empty_zero_page = .;
>>  	. += PAGE_SIZE;
>>  
>>  	swapper_pg_dir = .;
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index a6a00accf4f9..795743913ce5 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -66,9 +66,8 @@ long __section(".mmuoff.data.write") __early_cpu_boot_status;
>>  
>>  /*
>>   * Empty_zero_page is a special page that is used for zero-initialized data
>> - * and COW.
>> + * and COW. Defined in the linker script.
>>   */
>> -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>>  EXPORT_SYMBOL(empty_zero_page);
>
> I looked at Sashiko's reports
> (https://sashiko.dev/#/patchset/20260320145934.2349881-15-ardb+git@google.com)
> and it has a point here that with MTE, map_mem() doesn't map the
> empty_zero_page as Tagged in the for_each_mem_range() loop. The
> subsequent cpu_enable_mte() will fail to initialise the tags. I think
> this problem disappears with patch 11 where all the linear map is now
> Tagged.
>
> We either ignore it or we temporarily map the kernel as Tagged until the
> linear alias is removed later:
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 795743913ce5..5290f7537074 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1175,7 +1175,7 @@ static void __init map_mem(pgd_t *pgdp)
>  	 * so we should avoid them here.
>  	 */
>  	__map_memblock(pgdp, kernel_start, kernel_end,
> -		       PAGE_KERNEL, NO_CONT_MAPPINGS);
> +		       pgprot_tagged(PAGE_KERNEL), NO_CONT_MAPPINGS);
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>  	arm64_kfence_map_pool(early_kfence_pool, pgdp);
>  }
>

OK. There were some other very good comments too, I'll look into those and respin this for the next cycle.
