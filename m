Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4763358AD
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510178; cv=none; b=JFkZauT6xV9/RdHxRlt/psPCXEh2gqZXYZTU7m5kVjF6+BF/yotFk8hpNtQ4kwV5h6XNbGGQKcVP8rg29DahQdsXFPBy8sZzTqxFLRYk2ooGhuNCIRh/FKf3IkQfCnTo79f9wFos1KQ5t+PC36j+k0F08sS7Ix0VNm1F+uJs/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510178; c=relaxed/simple;
	bh=JWTemWwM8d5hhy1rFLzCx4ZbXQ4gREt3z806buBxXvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPIJ6Mt67xKpLw4nxKzN2U4fnlxgVvjyNLJthpp+vuH51O271jGLp/pesWQWsLvhGeiFY7OfSUklXYbVONTYAEYRgxi90IUOm5lkoAgUlsbpgodtd2XUyn+njWll6LLj7Eog1y+alDAhXE1np0bmvZOaJpizBHtooVc4tn/1Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSLjw3bd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSLjw3bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637D8C16AAE
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769510178;
	bh=JWTemWwM8d5hhy1rFLzCx4ZbXQ4gREt3z806buBxXvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FSLjw3bd94FzMmh6MGlELk5hhjfx9ROvv6MbDiOH8uDFQe2XpMdUafdN7f4nnicLZ
	 4VRg7FPWoILKnntN6UbBx5EEZL6WAK5N8l0+nAmt5HckcvY5sNLaZnEiO6m5PdWIWw
	 mDQCZL+o0oruFF8FnNq3nR+R0leXdSYwpS+MvOYL96aubdKmCIjj9EusqYir7SodbA
	 vljJ4b04GsW3F1HNrlr2/C2JMVjoyqYG8zBUbG2e6w3qDcIDZ9EH6xzPzhw7M2H8y0
	 CuA+bfslR5smK0pfnyi1C4/qGHdxgVUaTcMibGHwQ0KICm84tumTz8fR0zEaItw7Tt
	 BxaIKz0tC+IMA==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso2980002a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 02:36:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiCeNLf6/pvYkvVnYx6HoVDVzXkIPjDZ1u5ldAv8b50HtSWwSTXXkLzsDJ5Gbu4jT8AtowKytwdCUvW5lYyxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjA4nIzuKrLovYRdfEa+xTaY63giwJZmIs5lLWXLXhW+WpBHBl
	TXd6PSu1n6EcDZkKixZbJ5NvySeUUOXaVXFYFp34eN+ht799mt7RZWkph645n+3NRckINqsuCSn
	/tGJPUQqsqvetP86yjdWrBztp5D4ljRU=
X-Received: by 2002:a17:90b:51c1:b0:34c:9cec:dd83 with SMTP id
 98e67ed59e1d1-353fed88ea4mr1233428a91.27.1769510177575; Tue, 27 Jan 2026
 02:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-21-ardb+git@google.com> <62b1723a-2ff3-4cac-ad99-a0e8d388ef12@arm.com>
In-Reply-To: <62b1723a-2ff3-4cac-ad99-a0e8d388ef12@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Jan 2026 11:36:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHh2X0fWSZtN_xYQCwwwWKFJfBXaCec-BGXp3FDhE6S5g@mail.gmail.com>
X-Gm-Features: AZwV_Qhbzo8JaH40i9sS1ev3RFs_7gBcKYuj7o2DgvCuXJsGAVkF_l4j0hvuOSk
Message-ID: <CAMj1kXHh2X0fWSZtN_xYQCwwwWKFJfBXaCec-BGXp3FDhE6S5g@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] arm64: mm: Map the kernel data/bss read-only in
 the linear map
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 11:33, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 26/01/2026 09:26, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > On systems where the bootloader adheres to the original arm64 boot
> > protocol, the placement of the kernel in the physical address space is
> > highly predictable, and this makes the placement of its linear alias in
> > the kernel virtual address space equally predictable, given the lack of
> > randomization of the linear map.
> >
> > The linear aliases of the kernel text and rodata regions are already
> > mapped read-only, but the kernel data and bss are mapped read-write in
> > this region. This is not needed, so map them read-only as well.
> >
> > Note that the statically allocated kernel page tables do need to be
> > modifiable via the linear map, so leave these mapped read-write.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/sections.h |  1 +
> >  arch/arm64/mm/mmu.c               | 10 ++++++++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
> > index 51b0d594239e..f7fe2bcbfd03 100644
> > --- a/arch/arm64/include/asm/sections.h
> > +++ b/arch/arm64/include/asm/sections.h
> > @@ -23,6 +23,7 @@ extern char __irqentry_text_start[], __irqentry_text_end[];
> >  extern char __mmuoff_data_start[], __mmuoff_data_end[];
> >  extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
> >  extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
> > +extern char __pgdir_start[];
> >
> >  static inline size_t entry_tramp_text_size(void)
> >  {
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 18415d4743bf..fdbbb018adc5 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -1122,7 +1122,9 @@ static void __init map_mem(void)
> >  {
> >       static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> >       phys_addr_t kernel_start = __pa_symbol(_text);
> > -     phys_addr_t kernel_end = __pa_symbol(__init_begin);
> > +     phys_addr_t init_begin = __pa_symbol(__init_begin);
> > +     phys_addr_t init_end = __pa_symbol(__init_end);
> > +     phys_addr_t kernel_end = __pa_symbol(__pgdir_start);
> >       phys_addr_t start, end;
> >       phys_addr_t early_kfence_pool;
> >       int flags = NO_EXEC_MAPPINGS;
> > @@ -1158,7 +1160,9 @@ static void __init map_mem(void)
> >        * Note that contiguous mappings cannot be remapped in this way,
> >        * so we should avoid them here.
> >        */
> > -     __map_memblock(kernel_start, kernel_end, PAGE_KERNEL,
> > +     __map_memblock(kernel_start, init_begin, PAGE_KERNEL,
> > +                    flags | NO_CONT_MAPPINGS);
> > +     __map_memblock(init_end, kernel_end, PAGE_KERNEL,
> >                      flags | NO_CONT_MAPPINGS);
>
> I'm probably being dumb again... why map [init_end, kernel_end) RW here, only to
> remap RO below? Why not just map RO here?
>

Because the loop that iterates over the memblocks will remap it RW
again anyway, so whether we map RW or RO at this point is irrelevant.
This call just needs to occur here to ensure that no block mappings
needs to be broken up later.


> >
> >       /* map all the memory banks */
> > @@ -1172,6 +1176,8 @@ static void __init map_mem(void)
> >                              flags);
> >       }
> >
> > +     __map_memblock(init_end, kernel_end, PAGE_KERNEL_RO,
> > +                    flags | NO_CONT_MAPPINGS);
>
> This seems iffy since __map_memblock() doesn't flush the tlb. If you want to
> update an existing mapping you want to be calling update_mapping_prot() right?
>

Fair enough - I'll use that here.
