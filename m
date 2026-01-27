Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06733AD90
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511267; cv=none; b=cV5dl3tXHGVe7q95qgHcCjH5B/Vd5uFMlGvYAFW21QLuZ8Foq6sOR6kf+o3OgmG+hN1umZGRkpObJj0XfQB/bwNgQzKEKHtPrO9X3ddT0xLMgSQbfJROB3TtUYz/b2+jTpxdm9+Zb1GGv3mmZQ5QoIouXQ6qzRJK3gUrOIZu8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511267; c=relaxed/simple;
	bh=1zj6N7gTcxCu/r4o1le0S27hB0lFUZ+XfoNr6hf0nzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwBZWI9uUPvY6YcWg/r1Q+TKxRVCBv+1Jj1KIOG16kFiuh5PTZabhtYciH3KYvMn9hNZyiZqN7tamfzAsT0J10gWGy2dpl/o253KKuTvoxxBlaQbz6IhytVGOeZdxYnwxUoVcoC/NWzf3bh8jHhfF3gM/SsrKvnzSUPiSgPNPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2+P0bVq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2+P0bVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C10C2BC86
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769511266;
	bh=1zj6N7gTcxCu/r4o1le0S27hB0lFUZ+XfoNr6hf0nzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q2+P0bVqe42G1GLBv9tLDdTmoYatmAYgpr2lebm9U+wYiBwQ7yRWZ/nz/ZzWEJ/3Q
	 5Y0F7WRyl30J3QvsIrugEB2vgX83ap8twZ/mDjV6W8G8D+nzJQHQdas68cNJgeE0kH
	 u7rxeQJsOawob8QQcEC1v4sd5k/58+pX3DCzdD9N26TeH8xY9N83FUN8CyUmXKBRIT
	 c+nyaQaA3DhPnjJy8dZRQacWuQV05tfCr+CzGhpFVgXQUfo/TJJCmDUFgG/B+UMD/B
	 PPAJWnmS6NJDwcrrONNHOoPOPHaH1QiPNfLhIf7OLh6CMA+JlYAEBZQd9zrbeOwKG7
	 OsZI8lJNlyp8A==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c718c5481so3187559a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 02:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXok2jnYMvgPXGuujyTPxedOMjbUF+jPueqsIp4Nr6axPHHjw0klu00tyBv264YWEheG2Z8NZtOYO3VlVJ0Gl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsAqwcbGWANjXbx3mwTvZahQh8J7wUyAgC5nVyZQU6khyTUNK
	idN5JXReES/0kibVwoStZW1Wc2hcoRIozx78I3q121Pgbp37lyrAmNb+lMXuLPuDD2V7egnVfjp
	Y571yutBl5M1gphfhuqcogDdMX7blO7o=
X-Received: by 2002:a17:90b:384e:b0:340:b912:536 with SMTP id
 98e67ed59e1d1-353fed87a7amr1231123a91.31.1769511266354; Tue, 27 Jan 2026
 02:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-22-ardb+git@google.com> <3d6b2d69-ba7c-4da0-80e1-d1b80da47696@arm.com>
In-Reply-To: <3d6b2d69-ba7c-4da0-80e1-d1b80da47696@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Jan 2026 11:54:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHOkQKS4yP=mqsE-s-W0sg=cvrY6mx53WVQi0pOeLCDkQ@mail.gmail.com>
X-Gm-Features: AZwV_Qibxd-KFIZ9NRSH1JXOSfc8o1oX7aG6NgeR2e6yFoPlJ3Tc05yOx_4JMx8
Message-ID: <CAMj1kXHOkQKS4yP=mqsE-s-W0sg=cvrY6mx53WVQi0pOeLCDkQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 11:50, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 26/01/2026 09:26, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The linear aliases of the kernel text and rodata are mapped read-only in
> > the linear map as well. Given that the contents of these regions are
> > mostly identical to the version in the loadable image, mapping them
> > read-only and leaving their contents visible is a reasonable hardening
> > measure.
>
> what about ro_after_init? Could that contain secrets that we don't want to leak?
> What is the advantage of leaving text/rodata ro in the linear map vs just
> umapping the whole lot?
>

Unmapping it would be preferred, but there are some pieces (such as
the zero page and swapper_pg_dir) that are expected to be visible via
the linear map.

> >
> > Data and bss, however, are now also mapped read-only but the contents of
> > these regions are more likely to contain data that we'd rather not leak.
> > So let's unmap these entirely in the linear map when the kernel is
> > running normally.
> >
> > When going into hibernation or waking up from it, these regions need to
> > be mapped, so map the region initially, and toggle the valid bit so
> > map/unmap the region as needed.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/mm/mmu.c | 40 ++++++++++++++++++--
> >  1 file changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index fdbbb018adc5..06b2d11b4561 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/set_memory.h>
> > +#include <linux/suspend.h>
> >  #include <linux/kfence.h>
> >  #include <linux/pkeys.h>
> >  #include <linux/mm_inline.h>
> > @@ -1027,6 +1028,31 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
> >                                end - start, prot, early_pgtable_alloc, flags);
> >  }
> >
> > +static void remap_linear_data_alias(bool unmap)
> > +{
> > +     set_memory_valid((unsigned long)lm_alias(__init_end),
> > +                      (unsigned long)(__pgdir_start - __init_end) / PAGE_SIZE,
> > +                      !unmap);
> > +}
> > +
> > +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
> > +                                  unsigned long mode, void *unused)
> > +{
> > +     switch (mode) {
> > +     default:
> > +             break;
> > +     case PM_POST_HIBERNATION:
> > +     case PM_POST_RESTORE:
> > +             remap_linear_data_alias(true);
> > +             break;
> > +     case PM_HIBERNATION_PREPARE:
> > +     case PM_RESTORE_PREPARE:
> > +             remap_linear_data_alias(false);
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> >  void __init mark_linear_text_alias_ro(void)
> >  {
> >       /*
> > @@ -1035,6 +1061,16 @@ void __init mark_linear_text_alias_ro(void)
> >       update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
> >                           (unsigned long)__init_begin - (unsigned long)_text,
> >                           PAGE_KERNEL_RO);
> > +
> > +     remap_linear_data_alias(true);
> > +
> > +     if (IS_ENABLED(CONFIG_HIBERNATION)) {
> > +             static struct notifier_block nb = {
> > +                     .notifier_call = arm64_hibernate_pm_notify
> > +             };
> > +
> > +             register_pm_notifier(&nb);
> > +     }
> >  }
> >
> >  #ifdef CONFIG_KFENCE
> > @@ -1163,7 +1199,7 @@ static void __init map_mem(void)
> >       __map_memblock(kernel_start, init_begin, PAGE_KERNEL,
> >                      flags | NO_CONT_MAPPINGS);
> >       __map_memblock(init_end, kernel_end, PAGE_KERNEL,
> > -                    flags | NO_CONT_MAPPINGS);
> > +                    flags | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> >
> >       /* map all the memory banks */
> >       for_each_mem_range(i, &start, &end) {
> > @@ -1176,8 +1212,6 @@ static void __init map_mem(void)
> >                              flags);
> >       }
> >
> > -     __map_memblock(init_end, kernel_end, PAGE_KERNEL_RO,
> > -                    flags | NO_CONT_MAPPINGS);
>
> In the previous patch, perhaps this should be moved to
> mark_linear_text_alias_ro() and combined with the update_mapping_prot() there?
>

Why? Isn't it better to just remap it r/o from the outset if it never
needs to be mapped r/w to begin with?

The same applies to the rodata region but -again- it is the root page
tables that are manipulated via the writable linear alias during boot.

I'll try to address all of that in the next rev - thanks.
