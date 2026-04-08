Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF62D739B;
	Wed,  8 Apr 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663359; cv=none; b=Q9dw6vYyXDUbogiAhRKj2swlAscCXdYn/AvHMD/e1gqopZAOZHC90ilxryDRK0qNjuqkuD/hjZqYRiyD1Flb0OAQYJX1ELoDQKqBgZ0siIhKkUxRER1//9Q6RtFe0up9C7FFW7ZQDv+6AmV14QYmt1DlaZ4ueU54A2kcbZDhYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663359; c=relaxed/simple;
	bh=r/R0opesZ0OWIZ40nIHX1yp9W851g1DNMvMXMB87n2E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nm6PkgwNp9n6K0oGDsgiua7vKJfiMb0IZNJjls+DsJ4l4S1XfVuBQQBjHfFfAjY45h8nx3yuLrj6z68dZBfQ1wWow4wjsP0HKOSmypmn1hfMNXm31yvTMsVVs6Pu8/PGNsd0IZFTOi4DZnFA+N05VRmkQfZZb5zQ/ccTWjwotTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUkP437X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUkP437X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F42C19421;
	Wed,  8 Apr 2026 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775663358;
	bh=r/R0opesZ0OWIZ40nIHX1yp9W851g1DNMvMXMB87n2E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UUkP437XB+xLQwp9KZxWQV8gddCXunJWdKyd4nT+nycaB5y9yhzDzmUxOfzu+6OZB
	 Rcbeh9LbJbBb5SsNMwXQlI/KgmEJZL0kEftSvdpHCy4vATkJywVFyQEPh/Lc9PLbzo
	 1P9ldSlXucuhO9hUIW6cZlS/2fVXhwjGTiWCwOvXM803vUj1LF+5JC6sTRO5eGpGRK
	 ukOz5x/MSI0vRejNO9Lftbj9/HCb3nDHiTeLDJsdJRo2+nhJZKGbVxIUV7VIzHF/k3
	 bJ0Zw/b0Nn2TQcYxZlo+Xk9pbMwc5B6J981SOjVJrrmTttlbkAU1d6N6ds2h4BTXWK
	 Rb4lKC9MymFBg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 19FC5F40082;
	Wed,  8 Apr 2026 11:49:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 08 Apr 2026 11:49:17 -0400
X-ME-Sender: <xms:_HjWaRvIDHtwcI1aUCL0gkswEfZjmgChUOhfIC9zlWF2TCEsxuDVXQ>
    <xme:_HjWaVRJrJ5Bzc4bOVQU0_q4ltB069PJx3Ibtc3vSOjil0NQ5jQvf_DvZaY31kU2C
    LEa-rZYzwg1DjjOy_jfyyfUOCmNO6pLGO8e0YRnCKFUsGqJQ74oyl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepvdeuheeitdevtdelkeduudetgffftdelteefteevjeevjeeiheefhfejieej
    fedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedthedttdejledq
    feefvdduieegudehqdgrrhgusgeppehkvghrnhgvlhdrohhrghesfihorhhkohhfrghrug
    drtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrnhhshhhumhgrnhdrkhhhrghnughurghlsegrrhhmrdgtohhmpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghr
    khdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehrhigrnhdrrhhosggvrh
    htshesrghrmhdrtghomhdprhgtphhtthhopegrrhgusgdoghhithesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtoheplhhiiihprhhutghkrgesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepshgvthhhjhgvnhhkihhnshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhgv
    vghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:_XjWaRrJykn2JmtyYSiwQr_eAK4dKEZCGoUZRnOqIFI7_hVu-yB_iA>
    <xmx:_XjWaaB6Z958gwilTDoPa8Lcg8hhxBW7Q_OJOn_bLiYfG1PCxDGK4w>
    <xmx:_XjWaacXq_IVZOXySlQzPZjXybeV1Enaxayqr7JqIwO8OsU68TigxQ>
    <xmx:_XjWaau7eg8vAIhYRrdIPCq48doPrsJBE7-TwQfNnbnLgszDjyg_DA>
    <xmx:_XjWaZiUa8C1v_f7wnD0C6E7RcVz5hEeHcMjXa5sFp-mJOWamvraZg0u>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E56A7700069; Wed,  8 Apr 2026 11:49:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHdOulA2uaL-
Date: Wed, 08 Apr 2026 17:48:56 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, linux-hardening@vger.kernel.org
Message-Id: <61c62386-214a-4b71-b3ae-2d76ed0e9a53@app.fastmail.com>
In-Reply-To: <adZ4LpvJJz-3K20O@arm.com>
References: <20260320145934.2349881-15-ardb+git@google.com>
 <20260320145934.2349881-22-ardb+git@google.com> <adZ4LpvJJz-3K20O@arm.com>
Subject: Re: [PATCH v3 07/13] arm64: mm: Use hierarchical XN mapping for the fixmap
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, 8 Apr 2026, at 17:45, Catalin Marinas wrote:
> On Fri, Mar 20, 2026 at 03:59:42PM +0100, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>> 
>> Nothing in the fixmap or in its vicinity requires executable
>> permissions, and given that it is placed at exactly 1 GiB from the end
>> of the virtual address space, we can safely set the hierarchical XN
>> attributes on the level 2 table entries covering the fixmap, without
>> running the risk of inadvertently taking away the executable permissions
>> on an adjacent mappings.
>> 
>> This is a hardening measure that reduces the risk of the fixmap being
>> abused to create executable mappings in the kernel address space.
>> 
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  arch/arm64/mm/fixmap.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
>> index c5c5425791da..c3dd3c868cf5 100644
>> --- a/arch/arm64/mm/fixmap.c
>> +++ b/arch/arm64/mm/fixmap.c
>> @@ -48,7 +48,8 @@ static void __init early_fixmap_init_pte(pmd_t *pmdp, unsigned long addr)
>>  	if (pmd_none(pmd)) {
>>  		ptep = bm_pte[BM_PTE_TABLE_IDX(addr)];
>>  		__pmd_populate(pmdp, __pa_symbol(ptep),
>> -			       PMD_TYPE_TABLE | PMD_TABLE_AF);
>> +			       PMD_TYPE_TABLE | PMD_TABLE_AF |
>> +			       PMD_TABLE_PXN | PMD_TABLE_UXN);
>>  	}
>>  }
>
> Sashiko reckons this breaks kpti. I think that's valid but I couldn't
> reproduce it on qemu (maybe it doesn't implement hierarchical
> permissions).

Yeah, I think that observation is accurate, and it doesn't really affect the rest so I was just going to drop it.

> Then I tried FVP and the whole series panics (unrelated to
> kpti). With kvm-arm.mode=protected, I think kvm_ksym_ref() is lm_alias()
> and we have kvm_hyp_init_symbols() trying to flush the bss.
>

Interesting - I'll look into this for the next respin.



> Unable to handle kernel paging request at virtual address 
> fff00000748f7000
> Mem abort info:
>   ESR = 0x0000000096000147
> ** replaying previous printk message **
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x07: level 3 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000147, ISS2 = 0x00000000
>   CM = 1, WnR = 1, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> swapper pgtable: 4k pages, 52-bit VAs, pgdp=00000000f40ad000
> [fff00000748f7000] pgd=18000008fffff403, p4d=18000008ffffe403, 
> pud=18000008ffffd403, pmd=18000008fffe9403, pte=00e80000f48f7406
> Internal error: Oops: 0000000096000147 [#1]  SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
> 7.0.0-rc3-00013-g6bb20b972b8c #2 PREEMPT
> Hardware name: FVP Base RevC (DT)
> pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : dcache_clean_inval_poc+0x24/0x48
> lr : kvm_arm_init+0xb48/0x1338
> sp : ffff80008005bd20
> x29: ffff80008005bd60 x28: ffff95c63230b000 x27: 0000000000000004
> x26: 0000000000000001 x25: ffff95c631a160c0 x24: 0000000000000008
> x23: 0000000000000000 x22: 0000000000000000 x21: fff00000748f7000
> x20: 0000000000002000 x19: 0001101131111112 x18: 00000000ffffffff
> x17: ffff95c6321fdd88 x16: 0000000031427afd x15: 0000000000000100
> x14: 0000000000000000 x13: 0000000000077a9a x12: fff000087f805650
> x11: fff000087f805630 x10: ffffc1ffe005db08 x9 : 0000000000000000
> x8 : 0000000080000000 x7 : ffff80008005bc50 x6 : 000f63580145a000
> x5 : ffff95c6322f8000 x4 : 0000000000000000 x3 : 000000000000003f
> x2 : 0000000000000040 x1 : fff00000748f9000 x0 : fff00000748f7000
> Call trace:
>  dcache_clean_inval_poc+0x24/0x48 (P)
>  do_one_initcall+0x60/0x1d4
>  kernel_init_freeable+0x24c/0x2d4
>  kernel_init+0x24/0x140
>  ret_from_fork+0x10/0x20
> Code: 9ac32042 d1000443 8a230000 d503201f (d50b7e20)
> ---[ end trace 0000000000000000 ]---
>
> -- 
> Catalin
