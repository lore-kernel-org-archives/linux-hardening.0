Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A1344D81
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510837; cv=none; b=d8TEPPH6+Z1V+NItRNDFxAigygwM4nTOYxv9Qm7mSA5CE+sGVYCGOhJDnCUH3Dx/dryMKAVliBtC3WH4oHVjbeBD8UFQ9i1nuEe5NZc3cEpWTKP25O5++SSU46Ez+9Xkn4q1wfyVbmW6m235AfFJXjYQKPp1594xRICtJbyPHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510837; c=relaxed/simple;
	bh=NgcZQPM56B0R2rDd+OZ+Z7xk1FAyH0scmoSUohCjNNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5myw/erOrrKXESd1NsDlhyQLmnTmxgQYz4bmKnCYPyTBF4Y0J73AJKzCQXSZ3IgIouQugxEDU3fuG1vJn2E2aHdMvkWUDltPdV4Wmxk8U5BuAVay+vn5rA0/b4e8BWKWJM2aKAXuk7AIshx5ReuhvQ5JzAOaP9bOohL1cJwSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfY1NMCy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfY1NMCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A677C2BCB2
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769510837;
	bh=NgcZQPM56B0R2rDd+OZ+Z7xk1FAyH0scmoSUohCjNNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BfY1NMCykH+rT2Vd+IIZIv5VeibMoWVJUlZoPodYIJI9rkrBXkXGIGKynUny9XW80
	 cxK5C9rGHtr54eGmOaoVUalMklILC/TtC2e/7ul30AjoohRuFqjEDz/KZ3Ek43/qLM
	 ceZkBSPUyYsdA8vzRW9MoLwlw+0T9W4P44bH5q+on6sJAuj1dCn9cYw77gQFeBBMuo
	 EvI54qa/1ZRs68+JeoehTuPdz5lr4TNEvswACXJzu3Q8a2L1oV+YQKruU9YYQnKhzt
	 y9TVFXZhwKHm2yQWeukY98ko7F8phpe5aJHq0aSz2E54RZOb+Wo6EPYwVgf34weOJc
	 JV0DuM8PSO0TQ==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so2674002a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 02:47:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDh8JcZCVDW87BB63bL1+c8HewQOEo2TD0KB6QOfLjveR4K72pn9MfrrEzGbHw8rztM0Eg2wzeTIjRoCHp2vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/fWDYmyMrkK1bFlaMj11ryU/P2hx44DbI3h2iwNu5TVJ/4bF
	VezqI9REv1+p+NFr9O5ASGJjakf9WsdYdF/y7O6K9aWXwjbBQ6XanEzylxtUzNTrtXtTaT5hDIv
	yIyNqOrskVpUCWLJUBySzSQyPjGUwr9I=
X-Received: by 2002:a17:90a:c884:b0:353:3999:5c04 with SMTP id
 98e67ed59e1d1-353fed70e16mr1786608a91.17.1769510836548; Tue, 27 Jan 2026
 02:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-20-ardb+git@google.com> <d0f2df03-21da-473f-ab89-64a964c18f08@arm.com>
 <CAMj1kXGsedZnV7GJZqo6Yfb4mi6YpMCu=fnHOwDib8-OxBij2g@mail.gmail.com> <1bd6e787-00af-4d4c-a882-a0b8fb7f6a2f@arm.com>
In-Reply-To: <1bd6e787-00af-4d4c-a882-a0b8fb7f6a2f@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Jan 2026 11:47:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEJPPWe4JE7SBYuQMcdTwQHvPqBO9Djj=tcW3DsNknkpw@mail.gmail.com>
X-Gm-Features: AZwV_Qg8lKu-uI20uHzW8xMtxl2N0ls9Z64VrDBC_7ZMLKdMOXFmcoU5zbQe31U
Message-ID: <CAMj1kXEJPPWe4JE7SBYuQMcdTwQHvPqBO9Djj=tcW3DsNknkpw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] arm64: mm: Don't abuse memblock NOMAP to check
 for overlaps
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 11:39, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 27/01/2026 10:27, Ard Biesheuvel wrote:
> > On Tue, 27 Jan 2026 at 11:21, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 26/01/2026 09:26, Ard Biesheuvel wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> Now that the DRAM mapping routines respect existing table mappings and
> >>> contiguous block and page mappings, it is no longer needed to fiddle
> >>> with the memblock tables to set and clear the NOMAP attribute. Instead,
> >>> map the kernel text and rodata alias first, avoiding contiguous
> >>> mappings, so that they will not be added later when mapping the
> >>> memblocks.
> >>
> >> Should we do something similar for kfence? Currently we have
> >> arm64_kfence_alloc_pool() which marks some memory NOMAP then
> >> arm64_kfence_map_pool() which PTE-maps it and clears NOMAP. Presumably we could
> >> rationalize into a single function that does it all, prior to mapping the bulk
> >> of the linear map?
> >>
> >
> > Yeah, good point - I did not spot that but I will address it in the
> > next revision.
> >
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>> ---
> >>>  arch/arm64/mm/mmu.c | 27 ++++++++------------
> >>>  1 file changed, 10 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >>> index 80587cd47ce7..18415d4743bf 100644
> >>> --- a/arch/arm64/mm/mmu.c
> >>> +++ b/arch/arm64/mm/mmu.c
> >>> @@ -1149,12 +1149,17 @@ static void __init map_mem(void)
> >>>               flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >>>
> >>>       /*
> >>> -      * Take care not to create a writable alias for the
> >>> -      * read-only text and rodata sections of the kernel image.
> >>> -      * So temporarily mark them as NOMAP to skip mappings in
> >>> -      * the following for-loop
> >>> +      * Map the linear alias of the [_text, __init_begin) interval
> >>> +      * as non-executable now, and remove the write permission in
> >>> +      * mark_linear_text_alias_ro() above (which will be called after
> >>> +      * alternative patching has completed). This makes the contents
> >>> +      * of the region accessible to subsystems such as hibernate,
> >>> +      * but protects it from inadvertent modification or execution.
> >>> +      * Note that contiguous mappings cannot be remapped in this way,
> >>> +      * so we should avoid them here.
> >>>        */
> >>> -     memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> >>> +     __map_memblock(kernel_start, kernel_end, PAGE_KERNEL,
> >>> +                    flags | NO_CONT_MAPPINGS);
> >>
> >> So the reason to disallow cont mappings is because we need to modify the
> >> permissions later? It _is_ safe to change permissions on a live contiguous
> >> mapping in this way. That was clarified in the architecture a couple of years
> >> back and we rely on it for contpte_wrprotect_ptes(); see comment there.
> >>
> >
> > OK, good to know - I was hoping to get your take on this ...
> >
> >> I think we could relax this?
> >>
> >
> > OK, I suppose that means that we can drop the NO_CONT_MAPPINGS here,
> > but we still need to map the kernel text/rodata alias initially to
> > ensure that no block mappings are created that would need to broken
> > down, right?
>
> Yes, but...
>
> I think your intent is that the multiple __map_memblock() calls are just
> controlling the allowed leaf mapping sizes.

Indeed.

> It becomes problematic if the 2
> calls use different permissions... which they do.
>
> PAGE_KERNEL vs pgprot_tagged(PAGE_KERNEL).
>
> Is it possible that the text/rodata section ends up tagged, which is not intended?
>


OK so toggling the R/O attribute on a live contiguous mapping is
permitted (provided that ultimately, the entire contiguous region is
updated accordingly) but the same doesn't apply to MT_NORMAL vs
MT_NORMAL_TAGGED, right?

So let's use just the same prot and flags for the initial mapping, and
use MT_NORMAL_TAGGED when we remap the text alias R/O.
