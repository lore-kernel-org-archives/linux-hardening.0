Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70032936F
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150597; cv=none; b=Q7JW2Qz+1sb7TRb4zSPHzULmQMr7Iytc955DN++5VRxiTeR2+FQPd67YeeFVyfqTiUU1lC4k2nvk1OCpFVYzpubgrkc7/pXd7mXkgqkBGMfXmZYfA+p8lhJ8XJIu/HgRvwdS4aOujDWheEr+aYal9ZlTVBRf6Vg+0KXh6LXyLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150597; c=relaxed/simple;
	bh=aqk2LM6hpgCOWfRb/Un7WlOl38/KprMa96AWrDKyW7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuAMTc361xCLqFyF1rbkUTCZYoP98w/yu3wX37dQbXist8P6/6vAMm679p8IikKQukprKnqQSW+nZDPRdh76rE8fJ6vtjNjcg5BaRnE6PwYiefTSlIuTJIybw/I2MaJhR8I9LPlY1pEEARAH2XCG++Hthm165eCBl/oqdnpy+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjOxoAKI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjOxoAKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B9AC19422
	for <linux-hardening@vger.kernel.org>; Fri, 23 Jan 2026 06:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769150596;
	bh=aqk2LM6hpgCOWfRb/Un7WlOl38/KprMa96AWrDKyW7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kjOxoAKISOSipxhNkp7rcWXClzHO5+wQuY8f8sMdSLvB6df0sxsIcrwA/kv9Bu7/E
	 jrE7kBrIUvy1ocDNdaXtU6OKF+R7x41xcMrrnq+sOtCJjqNAYhaDr9jJfdGw2PzHeJ
	 iUOH0CcdGewOhrzCC2Lods9oUOKpxiiC+tisLhsZ70HGAzy5ADAVKIKDkp43pWvmx+
	 41Rg9WHt84DgcrdQKMxhswhcR4Nq3hTDLOgP/ANgQS6QPKIVH7+rfC6PYZ4wHJTr2F
	 QoY08v2/bQRP6AcgI3wec97UWQ52bDIq5rOrfqHFwWz59uwvxPqYG7U2yGSmLX8ALE
	 tonCMCVGJAPiA==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c3259da34so1086980a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 22:43:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKhcsCt8VphXgNmHkUIqj8p0rs61cJRw7o833Y6zLSPlSsK79EJEybGPdma3KeeuHomVhkRQhCjrWDgVA3seU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEemYHI3lNFCBcJgj8BazNnfoL7Sl+NfK11zJ8VXuN05TdSRFk
	AlyyteQ83qSheLmgPmlv1GX7foNG5N6vQNjB88z8Z7Vd2N1qLoWOoKqoIk/lmOhz9+0BmromBCy
	KNsNv2NCJOhZoV1PegFK90S//UfRUo9c=
X-Received: by 2002:a17:90b:48c7:b0:353:3f04:1b78 with SMTP id
 98e67ed59e1d1-35378ba82c3mr165587a91.4.1769150596446; Thu, 22 Jan 2026
 22:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119164747.1402434-6-ardb+git@google.com> <20260119164747.1402434-7-ardb+git@google.com>
 <d5c7ed76-2b54-4c6e-961f-6ba1e4011467@arm.com>
In-Reply-To: <d5c7ed76-2b54-4c6e-961f-6ba1e4011467@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 23 Jan 2026 07:43:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG8Q+VjXP08-hZhQ16Fe39+_JiSpPfh389gQ7twHr7eBQ@mail.gmail.com>
X-Gm-Features: AZwV_Qha-p15Q9tTNXYW38TrzPMT-C7I_9EAbgr6vtgxZom2Hdl3sYGASm7Mtes
Message-ID: <CAMj1kXG8Q+VjXP08-hZhQ16Fe39+_JiSpPfh389gQ7twHr7eBQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: Move fixmap page tables to end of kernel image
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ryan Roberts <ryan.roberts@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Anshuman,

On Fri, 23 Jan 2026 at 07:12, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 19/01/26 10:17 PM, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Move the fixmap page tables out of the BSS section, and place them at
> > the end of the image, right before the init_pg_dir section where some of
> > the other statically allocated page tables live.
> >
> > These page tables are currently the only data objects in vmlinux that
> > are meant to be accessed via the kernel image's linear alias, and so
> > placing them together allows the remainder of the data/bss section to be
> > remapped read-only or unmapped entirely.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/vmlinux.lds.S | 5 +++++
> >  arch/arm64/mm/fixmap.c          | 7 ++++---
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index ad6133b89e7a..df530e6f3e53 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -334,6 +334,11 @@ SECTIONS
> >       __pi___bss_start = __bss_start;
> >
> >       . = ALIGN(PAGE_SIZE);
> > +     .pgdir : {
> > +             __pgdir_start = .;
>
> Does __fixmap_pgdir_start with an end marker __fixmap_pgdir_end sound better ?
>

No. __pgdir_start covers the init_pg_dir as well. And I don't think we
should be adding end markers that we do not intend to use.

> > +             *(.fixmap_bss)
> > +     }
> > +
> >       __pi_init_pg_dir = .;
> >       . += INIT_DIR_SIZE;
> >       __pi_init_pg_end = .;
> > diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> > index c5c5425791da..b649ea1a46e4 100644
> > --- a/arch/arm64/mm/fixmap.c
> > +++ b/arch/arm64/mm/fixmap.c
> > @@ -31,9 +31,10 @@ static_assert(NR_BM_PMD_TABLES == 1);
> >
> >  #define BM_PTE_TABLE_IDX(addr)       __BM_TABLE_IDX(addr, PMD_SHIFT)
> >
> > -static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
> > -static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> > -static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> > +#define __fixmap_bss __section(".fixmap_bss") __aligned(PAGE_SIZE)
> > +static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __fixmap_bss;
> > +static pmd_t bm_pmd[PTRS_PER_PMD] __fixmap_bss __maybe_unused;
> > +static pud_t bm_pud[PTRS_PER_PUD] __fixmap_bss __maybe_unused;
> >
> >  static inline pte_t *fixmap_pte(unsigned long addr)
> >  {
>
