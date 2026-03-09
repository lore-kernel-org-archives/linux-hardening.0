Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113A3CE4B2
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065501; cv=none; b=DBBIDiIY4YjVyjr8xxgS92A4UuoftIAKpc6HQR+46qMPTVqnbnaim0aQu3RwpbhzILX+ewG73XCMMP/h+YV7PGJQNGrRr1LmVdCLp0jUCVcK++MirCcqCZF3L6k7YNZ/K0WOAX9X3JjSmhetw5H4KPhp7AGyPFc3TthnMvHqrlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065501; c=relaxed/simple;
	bh=Hqy01tOmlql+ZEgGRFBT4aqwchvquGYinxvKDR+qxzo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YkNAaQrvBtqohpE3/9b6BUCSE2/GbJFNKpfH0Y65BTC7/6jf7VQY04So6bNXWpTQR23Sskkp8h2aLjuNFA5ksMfte8A3jp+h/utbGuHWEcRwujykjhLE767os274/C0eIwziStrutYd+rJf49uVhbmQke6F4ruPjZXjeYOGlqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYkisno8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYkisno8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD48EC2BC9E;
	Mon,  9 Mar 2026 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773065501;
	bh=Hqy01tOmlql+ZEgGRFBT4aqwchvquGYinxvKDR+qxzo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tYkisno8tUIiZWQW6DbK88hTFCpkFxsz/oJE6Guth04Ml01CXM4VAMahkV8CbSsYE
	 UocABe/550C8Xdj5xqQ2FXqL/SN4AdvyVIgTXC0hnXEGpLVHCyfuhTcR1+GJaeM6A1
	 usR+l34caxi+YSQRZGOfLY5OUCUmSdp7wS6YNl02+efmhZGJON8xadA18rPgu8P1vK
	 wMM0bp170gMy6rXUvaoCO/ZdzDnRoTswTyiRjSV2Z2SllhPM7I5ukwM+Yg61BuYRmS
	 xkOpzZo9dSmzgR+pasmPMgWT+Utc5xdBRUUjSzrSzpfzyawnC7sqKTYb4DhEhwEUGw
	 NZKBftgtJJMkQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C582EF40068;
	Mon,  9 Mar 2026 10:11:39 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 09 Mar 2026 10:11:39 -0400
X-ME-Sender: <xms:G9WuaaT25rAveLqBalCSNqyTDlVO8X7SXb-wDTwPayLJazjEmi7ixQ>
    <xme:G9WuaakvrUbGt8tYivWWl-irqJqnUColKO1pXG5elVAdX9lqDFh7NYLxRF6MvxGBJ
    3s4bP9Gobmoi-LHF_t3ONY5Ge3Islz8JFyqduiHm9MHFFIMS7Mm8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeffeevtdeifedttddtuddukeefkeffjeehjedvtdeihfdutdevhfeljefh
    leeiudenucffohhmrghinheplhgushdrshgsnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppehkvghrnh
    gvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohepudefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtph
    htthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhgsihiijhgr
    khesghhmrghilhdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehjphhoihhmsghovgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgt
    phhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:G9WuaXOk1jWchlE0vEGxUEYmVEDdLw-CbZpnjuZ8jlHzyGd9Q35bhg>
    <xmx:G9WuaZOknt-rop4R8cbhnh55BpiaB-BLFo2wj6qOAnm6EFcFoTtoEg>
    <xmx:G9WuaRJsbCByS0DUBITlhDnxZj8AP27wmCEqAI7XCS-TPKBN0-3buQ>
    <xmx:G9Wuabq3RJOhx1VhtJWt7oyjPJ07B1V_ZfWHQe4WFFr1TcNPkenLKQ>
    <xmx:G9WuaVOV6bp818HAwpMkWUQRASIqqkHdpSPgJb83ulmPOtg4OC129CVC>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9D24C700069; Mon,  9 Mar 2026 10:11:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Agw7_yjux95B
Date: Mon, 09 Mar 2026 15:11:19 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Borislav Petkov" <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Kees Cook" <kees@kernel.org>,
 "Uros Bizjak" <ubizjak@gmail.com>, "Brian Gerst" <brgerst@gmail.com>,
 linux-hardening@vger.kernel.org
Message-Id: <a29fa2af-a894-40bd-923d-51115dca7940@app.fastmail.com>
In-Reply-To: <20260306190729.GMaasl8VFJh31kS3mi@fat_crate.local>
References: <20260108092526.28586-21-ardb@kernel.org>
 <20260108092526.28586-24-ardb@kernel.org>
 <20260306190729.GMaasl8VFJh31kS3mi@fat_crate.local>
Subject: Re: [RFC/RFT PATCH 03/19] x86: Combine .data with .bss in kernel mapping
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, 6 Mar 2026, at 20:07, Borislav Petkov wrote:
> On Thu, Jan 08, 2026 at 09:25:30AM +0000, Ard Biesheuvel wrote:
>> The primary mapping of the kernel image is made using huge pages where
>> possible, mostly to minimize TLB pressure (Only the entry text section
>> requires alignment to 2 MiB). This involves some rounding and padding of
>> the .text and .rodata sections, resulting in gaps.  These gaps are
>> smaller than a huge page, and are remapped using different permissions,
>> resulting in fragmentation of the huge page mappings at the edges of
>> those regions.
>> 
>> Similarly, there is a gap between .data and .bss, where the init text
>> and data regions reside. This means that the end of the .data region and
>> the start of the .bss region are not covered by huge page mappings
>> either, even though both regions use the same permissions (RW+NX).
>> 
>> Improve the situation, by placing .data and .bss adjacently in the
>> linker map, and putting the init text and data regions after .rodata,
>> taking the place of the rodata/data gap. This results in one fewer gap,
>> and a more efficient mapping of the .data and .bss regions.
>> 
>> To preserve the x86_64 ELF layout with PT_LOAD regions aligned to 2 MiB,
>> start the second ELF segment at .init.data and align it to 2 MiB.  The
>> resulting padding will be covered by the init region and will be freed
>> along with it after boot.
>> 
>> defconfig + Clang 19:
>> 
>> Before:
>> 
>>   0xffffffff81000000-0xffffffff82200000    18M  ro  PSE  GLB x  pmd
>>   0xffffffff82200000-0xffffffff8231c000  1136K  ro       GLB x  pte
>>   0xffffffff8231c000-0xffffffff82400000   912K  RW       GLB NX pte
>>   0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE  GLB NX pmd
>>   0xffffffff82a00000-0xffffffff82b40000  1280K  ro       GLB NX pte
>>   0xffffffff82b40000-0xffffffff82c00000   768K  RW       GLB NX pte
>>   0xffffffff82c00000-0xffffffff83400000     8M  RW  PSE  GLB NX pmd
>>   0xffffffff83400000-0xffffffff83800000     4M  RW       GLB NX pte
>> 
>> After:
>> 
>>   0xffffffff81000000-0xffffffff82200000    18M  ro  PSE  GLB x  pmd
>>   0xffffffff82200000-0xffffffff8231c000  1136K  ro       GLB x  pte
>>   0xffffffff8231c000-0xffffffff82400000   912K  RW       GLB NX pte
>>   0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE  GLB NX pmd
>>   0xffffffff82a00000-0xffffffff82b40000  1280K  ro       GLB NX pte
>>   0xffffffff82b40000-0xffffffff82c00000   768K  RW       GLB NX pte
>>   0xffffffff82c00000-0xffffffff82e00000     2M  RW  PSE  GLB NX pmd
>>   0xffffffff82e00000-0xffffffff83000000     2M  RW       GLB NX pte
>>   0xffffffff83000000-0xffffffff83800000     8M  RW  PSE  GLB NX pmd
>> 
>> With the gaps removed/unmapped (pti=on)
>> 
>> Before:
>> 
>>   0xffffffff81000000-0xffffffff81200000     2M  ro  PSE  GLB x  pmd
>>   0xffffffff81200000-0xffffffff82200000    16M  ro  PSE      x  pmd
>>   0xffffffff82200000-0xffffffff8231c000  1136K  ro           x  pte
>>   0xffffffff8231c000-0xffffffff82400000   912K                  pte
>>   0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE      NX pmd
>>   0xffffffff82a00000-0xffffffff82b40000  1280K  ro           NX pte
>>   0xffffffff82b40000-0xffffffff82c00000   768K                  pte
>>   0xffffffff82c00000-0xffffffff83400000     8M  RW  PSE      NX pmd
>>   0xffffffff83400000-0xffffffff8342a000   168K  RW           NX pte
>>   0xffffffff8342a000-0xffffffff836f3000  2852K                  pte
>>   0xffffffff836f3000-0xffffffff83800000  1076K  RW           NX pte
>> 
>> After:
>> 
>>   0xffffffff81000000-0xffffffff81200000     2M  ro  PSE  GLB x  pmd
>>   0xffffffff81200000-0xffffffff82200000    16M  ro  PSE      x  pmd
>>   0xffffffff82200000-0xffffffff8231c000  1136K  ro           x  pte
>>   0xffffffff8231c000-0xffffffff82400000   912K                  pte
>>   0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE      NX pmd
>>   0xffffffff82a00000-0xffffffff82b40000  1280K  ro           NX pte
>>   0xffffffff82b40000-0xffffffff82e3d000  3060K                  pte
>>   0xffffffff82e3d000-0xffffffff83000000  1804K  RW           NX pte
>>   0xffffffff83000000-0xffffffff83800000     8M  RW  PSE      NX pmd
>> 
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  arch/x86/kernel/vmlinux.lds.S | 91 +++++++++++---------
>>  arch/x86/mm/init_64.c         |  5 +-
>>  arch/x86/mm/pat/set_memory.c  |  2 +-
>>  3 files changed, 52 insertions(+), 46 deletions(-)
>
> I guess we could do this - I don't see why not... we'll have to take it for
> a longer spin tho.
>
>> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>> index 3a24a3fc55f5..1dee2987c42b 100644
>> --- a/arch/x86/kernel/vmlinux.lds.S
>> +++ b/arch/x86/kernel/vmlinux.lds.S
>> @@ -61,12 +61,15 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
>>  #define X86_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
>>  
>>  #define X86_ALIGN_RODATA_END					\
>> -		. = ALIGN(HPAGE_SIZE);				\
>> -		__end_rodata_hpage_align = .;			\
>
> $ git grep __end_rodata_hpage_align
> arch/x86/include/asm/sections.h:13:extern char __end_rodata_hpage_align[];
> arch/x86/tools/relocs.c:93:     "__end_rodata_hpage_align|"
>
> I guess you wanna remove those too and say that that marker is unused. Better
> yet do that in a pre-patch.
>

Indeed. When __end_rodata_hpage_align exists, it is always equal to __end_rodata_aligned, so it can just be dropped entirely.

