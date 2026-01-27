Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F733C539
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509676; cv=none; b=BSRlhdiicmV1eAYkyJGGcCxi85CC6NWDaw+tvxpt40QJVfaJoguzN8AY0VBuLcJ05fVidXNzIg2Fq5d2cyqxlI/fhJGfn7Yl5ToZjOyfTIfmiSNd8Kh5H4IUF4P2V9Qfp/sSIkgHUxws9wXmzJsINPm1uBv1ssM7K2MBC38sBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509676; c=relaxed/simple;
	bh=/mDT6OHoRnLArwoBDXzNOiyG6NIcgxSyrDQMIYzcNZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7yrIpVcLpa5+SlhhG92LAy4ZiD6erz/3q2T63UmRExBACLID7sY4rXQFxC8G55QfyrHY0hn4bAJMWQ0nDAYZKOVwrTwQX9i5yWUJonaozfZBSJIfl96vtdIvXrWx3ejL5lhGuS9c46BE5tZoMivYzOxeVqhBFpCBNyMieD8lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq3EbLXO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq3EbLXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6924CC2BC87
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769509676;
	bh=/mDT6OHoRnLArwoBDXzNOiyG6NIcgxSyrDQMIYzcNZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lq3EbLXOgOz6mKTrPN8MePxdEzg4jWrAXjobiH5fDLUdC2xcXck7GdwSEC33CKNR7
	 a4hDG4MtBFnnzOljPhqjQNRXidnZTSts7lQpOpZmQ64TezF9J25R98sw/kgwELHSco
	 CM/52hKWi9cnNx9gPrpQOQDsCt4Czfcg+E2C5ZfpTRlDky7MX46p7xZhWJfA3CMXyQ
	 OgpKYyCURyJtjiSb2annc6i3izFlV5gfrezRZZXkqCpojZ8yNHdS5jX/TjLFA6VpGx
	 BtgVYVhr9WbPlmVS8uSr80UIx9+5Z6CEfMtkfPcYgVH66OU3v0qWiczNvJCti+0cTm
	 RRpHbhtTh8zbQ==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c3259da34so3214374a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 02:27:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvQt4i6Xi1SDiXv9usGR8xesjxkqea36P6mzLe/IWFKy6C9hAvlQYxKJNs6BqMr7+3JgAPp20yEToEInq/Ed0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeB5jGWG23TBBBWTDILtPtOXrROB8gX7iLA+lvHfOy+dhZU8G/
	QyAlVFV6EVBCU7uptvVgm+Sokc/T3yCQHWVW16mY6J8EglvVZwSbw2J1cf70N86H5/NxYKEYdsT
	ocjVgVGbfBJDIhjcA1TZPHVj329aRNIk=
X-Received: by 2002:a17:90b:2888:b0:343:c3d1:8bb1 with SMTP id
 98e67ed59e1d1-353fed9b231mr1042823a91.28.1769509676010; Tue, 27 Jan 2026
 02:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-20-ardb+git@google.com> <d0f2df03-21da-473f-ab89-64a964c18f08@arm.com>
In-Reply-To: <d0f2df03-21da-473f-ab89-64a964c18f08@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Jan 2026 11:27:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGsedZnV7GJZqo6Yfb4mi6YpMCu=fnHOwDib8-OxBij2g@mail.gmail.com>
X-Gm-Features: AZwV_QgnFAVmYzE3tjtmAWVlFHRGsy9TyNlREmz0cp2ucdVCyh2Euly8VHrPN-c
Message-ID: <CAMj1kXGsedZnV7GJZqo6Yfb4mi6YpMCu=fnHOwDib8-OxBij2g@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] arm64: mm: Don't abuse memblock NOMAP to check
 for overlaps
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 11:21, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 26/01/2026 09:26, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Now that the DRAM mapping routines respect existing table mappings and
> > contiguous block and page mappings, it is no longer needed to fiddle
> > with the memblock tables to set and clear the NOMAP attribute. Instead,
> > map the kernel text and rodata alias first, avoiding contiguous
> > mappings, so that they will not be added later when mapping the
> > memblocks.
>
> Should we do something similar for kfence? Currently we have
> arm64_kfence_alloc_pool() which marks some memory NOMAP then
> arm64_kfence_map_pool() which PTE-maps it and clears NOMAP. Presumably we could
> rationalize into a single function that does it all, prior to mapping the bulk
> of the linear map?
>

Yeah, good point - I did not spot that but I will address it in the
next revision.

> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/mm/mmu.c | 27 ++++++++------------
> >  1 file changed, 10 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 80587cd47ce7..18415d4743bf 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -1149,12 +1149,17 @@ static void __init map_mem(void)
> >               flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >
> >       /*
> > -      * Take care not to create a writable alias for the
> > -      * read-only text and rodata sections of the kernel image.
> > -      * So temporarily mark them as NOMAP to skip mappings in
> > -      * the following for-loop
> > +      * Map the linear alias of the [_text, __init_begin) interval
> > +      * as non-executable now, and remove the write permission in
> > +      * mark_linear_text_alias_ro() above (which will be called after
> > +      * alternative patching has completed). This makes the contents
> > +      * of the region accessible to subsystems such as hibernate,
> > +      * but protects it from inadvertent modification or execution.
> > +      * Note that contiguous mappings cannot be remapped in this way,
> > +      * so we should avoid them here.
> >        */
> > -     memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> > +     __map_memblock(kernel_start, kernel_end, PAGE_KERNEL,
> > +                    flags | NO_CONT_MAPPINGS);
>
> So the reason to disallow cont mappings is because we need to modify the
> permissions later? It _is_ safe to change permissions on a live contiguous
> mapping in this way. That was clarified in the architecture a couple of years
> back and we rely on it for contpte_wrprotect_ptes(); see comment there.
>

OK, good to know - I was hoping to get your take on this ...

> I think we could relax this?
>

OK, I suppose that means that we can drop the NO_CONT_MAPPINGS here,
but we still need to map the kernel text/rodata alias initially to
ensure that no block mappings are created that would need to broken
down, right?
