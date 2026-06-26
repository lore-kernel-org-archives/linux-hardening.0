Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A53839B8
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495989; cv=none; b=dfYy7AINt0ehqwqNy2CNUMm70YjLVdn7JzL2X2xKxpjoS7aL+FNqf57Mn9pkfjy8gRg9Ums1WZs8c9BvwlAvcFZMeWmZSHmxo+IocB046FsLAmXY1UzZpwvLfhswcPCGn6m1K2E1Krjl9gFhp+3Qrs/Kby2GWJVyf+crLuCb4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495989; c=relaxed/simple;
	bh=wL1mDlj1B0uKViOJkUopeCSzDfb8iMOilrC1GdMCM+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdVT9ANVST5z2jwzL/bhQHZGCx86OQ8YNWwmsJpidNVxSLBD+DVpa4lwOn744tC9o61hwVkRUjS7fIzunQvfwf+iv3orW3bAcleGEwKaaQJmqifIXarijed2HO3zthqfFl8yCDJVuw8cS/Tnor/fQTyQ3/V9goiyPeq9DMiu5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=WQyslLZ5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="WQyslLZ5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845c38dee22so656280b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782495987; x=1783100787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYdU2INu7hZoMU5N3uXMCRXJgZo0rwNDYyNP33ro2pk=;
        b=WQyslLZ5XTr0+SoQqgKgQ3f/9FLwyOhZar8AiP9ciEOSuRQdcmm5kAOi1ULAVMS0wq
         lNX6o42BVC9jFSQhPMcwvADgf4UQt5qO4N+tJp2PxZ1hFiTY7lZrnsZv54wQcAJTlam3
         SwaMX+nUjhqF815EkpIw4OQzTDQjf8jw3TbBOSF0ydBjJ8XCwF5U+4bbrRN7o2+hDdoO
         PP7RwHB0mN/vzIfrAHnIn60fqf5IvOZRP7eXFM6RbGUGNHKzJ2aSo48YPyg0lNLQPNU/
         n5xbr1BOq9+XYoPWkqhaHj0J6y42sSxwZEV7qGc0vIpTAqCdjTAHmC+5E+e+LVcVjAvG
         epZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495987; x=1783100787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYdU2INu7hZoMU5N3uXMCRXJgZo0rwNDYyNP33ro2pk=;
        b=eTJH+tcEwwNYiCnVssy+zJVG6qXhmGGCSiy8czZfCuD8elmnmmV1HISM1AvPzjJArW
         nlK5M6Nx8qA9le8dQawdHwM30/0oyCyv7rK3LdmZgpPRyBTFIBGxd8x3mkOGKnA/lZqT
         jU+gMn4WJ5ZtwuN1wZtlcXGtw/UPfV2d3CQvbNMu0YVJFjlvrBDzcumVwRs8mNAd4OTW
         G60991andRJrk8rakUJWzAZ5USrmH4LxXFDHUhxT/1KcZeG69kYpBGp/sUD9yFGNBE0v
         FlrYpkRuudvgAlSEh4Qs95lgGU+pUTO4kc0ICRZCYDHPFfnlk0Hnay4XcHls9XtFABja
         YL4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8EACtl5QQAOE4NE1qIEbTkYMjG45OAVqTDHo/qhWY5PB9RZCt+DQYLR1QvOn+tCLzLOR1lP013ii6YMoV9D9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzosMPe7d8VuvHON+1sQGuPYyXALIUwFXNLNlACQM88KSKx7pTU
	lNBzBiwaLVopyhP2qGHihM92uNQxVTT3hRLEEPpJpeOGSQI+FKl/x8o+Q12txxOUPw==
X-Gm-Gg: AfdE7cm76sj0QtD/qCH+yYo4EXNdgGDxIxoOKMkLG+2xzRdl7P3xBQYfhQHI/cvNyaT
	dtyJLaatt1trAxzlYuqVF4mEFYiVF7+FRy1K7uAy7cnl2Q6PvCH4ul24109uuebVJfpJZwsG7Qa
	7DBXnR0UUIzujmz6/58QONT/T1+XtdRUdVy8WtBlO0+SuauZkadKQYE1gQ+YtNQ53Wb8BFlvsFs
	RbArFXtsarguArmCjXdkIYQKgK/A1O8kTBW9mfXE334wSOqBPsDaafU0FmAK37w6URQkXu3nK0K
	10ZXKrUR2e0o25GLsYxFsLJQns1P5QTqa/KUajmQav0YOekSSgebW6ICMysorKeKQ8NT97rfPuI
	f/s4hXK96nrP+bHm5bhE9DgW6dqYcMKvUtG+2yaiP3GW7QMAx3kpm/rHN5eKqSXtO+MB4eew=
X-Received: by 2002:a05:6a00:1810:b0:845:d2e3:263b with SMTP id d2e1a72fcca58-845d2e328c9mr1122732b3a.53.1782495986902;
        Fri, 26 Jun 2026 10:46:26 -0700 (PDT)
Received: from p1 ([2607:fb90:ec0b:1b9c:b43d:8c36:8c16:36f7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845c81922fasm1650394b3a.1.2026.06.26.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:26 -0700 (PDT)
Date: Fri, 26 Jun 2026 10:46:23 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-hardening@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, 
	Ruoyu Wang <fishw@asu.edu>, Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <yu6l7zo4dmqcnho7thkf7sk42lt6xkz6uxxwxmg73x23vihlnp@pe7vdut4o2jc>
References: <20260626173444.2252041-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626173444.2252041-1-xmei5@asu.edu>

On Fri, Jun 26, 2026 at 10:34:44AM -0700, Xiang Mei wrote:
> With CONFIG_VMAP_STACK, kernel stacks are allocated in the vmalloc area,
> which an unprivileged user can surround with attacker-controlled data by
> spraying vmap allocations adjacent to a target stack (for example via
> XDP_UMEM_REG, though other vmalloc spray paths work too). Today each
> guarded vmalloc allocation is followed by a single unmapped guard page.
> 
> A single guard page is not enough to contain the x86_64 ENTER
> instruction used as a one-instruction stack pivot. ENTER imm16, imm8
> builds a stack frame and lowers RSP by:
> 
> 	imm16 + 8 * (L + 1),  L = imm8 & 0x1f
> 
> imm16 is an unsigned 16-bit operand (ENTER never raises RSP), and L is
> in [0, 31], so the maximum displacement of a single ENTER is:
> 
> 	0xffff + 8 * 0x20 = 0x100ff bytes
> 
> That is more than enough to step off the current stack, across the
> one-page guard, and into the adjacent sprayed pages. When those pages
> contain a return sled feeding a ROP chain, reaching any ENTER gadget
> (opcode 0xc8, abundant as both intended and unintended gadgets) turns a
> control-flow hijack into full ROP execution without any register control
> at the hijack site, making it a one-gadget-style primitive that
> significantly eases exploitation. The pivot happens after the control
> transfer, so it is not constrained by CFI (kCFI/FineIBT).
> 
> Widen the guard region from one page to VMAP_GUARD_PAGES (0x11 pages,
> 0x11000 bytes), which is the smallest whole-page span exceeding the
> 0x100ff-byte maximum single-ENTER pivot. A pivot off the top of the
> stack now lands in the unmapped guard and faults, instead of in mapped,
> attacker-controlled memory. RANDOMIZE_KSTACK_OFFSET only perturbs RSP by
> a sub-page amount, so it does not change the required width.
> 
> Introduce a VMAP_GUARD_PAGES knob that defaults to a single page (no
> change for current architectures) and can be overridden per arch via
> asm/vmalloc.h, and set it to 0x11 on x86_64. This is deliberately scoped
> to x86_64: the 0x100ff bound is a property of the ENTER opcode, and ENTER
> is also a one-byte opcode (0xc8) that appears as abundant unintended
> gadgets. Other architectures (e.g. arm64) have no equivalent
> single-instruction, immediate-controlled pivot reachable as an unaligned
> unintended gadget, so they keep the one-page guard and pay no cost.
> 
> The override is gated on CONFIG_X86_64 rather than applying to all of x86:
> VMAP_STACK is selected only on x86_64, so 32-bit kernel stacks are not in
> the vmalloc area and the technique does not apply there. 32-bit x86 also
> has a far smaller vmalloc window, where widening every guarded area by 16
> pages would needlessly pressure the address space.
> 
> The guard pages are never populated, so there is no extra physical
> memory and no additional page-table population beyond the larger virtual
> span; the cost is virtual address space and vmap_area bookkeeping, which
> is negligible against the 64-bit vmalloc window. get_vm_area_size() is
> adjusted by the same VMAP_GUARD_SIZE so the usable size reported to
> callers is unchanged.
> 
> On x86 this widens the guard for all guarded vmap areas, not only thread
> stacks. ret2enter targets the stack specifically, so a narrower
> alternative is to apply the wider guard only on the thread-stack
> allocation path via a dedicated VM_ flag; we kept the change in the
> common path as defense in depth for any vmalloc-adjacent pivot target,
> but are happy to scope it to stacks if maintainers prefer.
> 
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Jennifer Miller <jmill@asu.edu>
> ---
>  arch/x86/include/asm/vmalloc.h | 21 +++++++++++++++++++++
>  include/linux/vmalloc.h        | 16 ++++++++++++++--
>  mm/vmalloc.c                   |  2 +-
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/vmalloc.h b/arch/x86/include/asm/vmalloc.h
> index 49ce331f3ac6..2c341f398227 100644
> --- a/arch/x86/include/asm/vmalloc.h
> +++ b/arch/x86/include/asm/vmalloc.h
> @@ -5,6 +5,27 @@
>  #include <asm/page.h>
>  #include <asm/pgtable_areas.h>
>  
> +/*
> + * The x86 ENTER instruction can be used as a one-instruction stack pivot:
> + * ENTER imm16, imm8 lowers RSP by imm16 + 8 * (L + 1), L = imm8 & 0x1f.
> + * imm16 is an unsigned 16-bit operand (ENTER never raises RSP) and L is in
> + * [0, 31], so a single ENTER can lower RSP by at most
> + * 0xffff + 8 * 0x20 = 0x100ff bytes. With CONFIG_VMAP_STACK the kernel
> + * stack lives in the vmalloc area, where an unprivileged user can spray
> + * adjacent allocations; a single-page guard is too small to contain such a
> + * pivot. Use 0x11 guard pages (0x11000 bytes), the smallest whole-page
> + * span exceeding 0x100ff, so the pivot faults in the guard instead of
> + * landing in attacker-controlled memory.
> + *
> + * Restrict this to 64-bit: VMAP_STACK is selected only on x86_64, so 32-bit
> + * kernel stacks are not in the vmalloc area and the technique does not apply.
> + * 32-bit also has a far smaller vmalloc window, where a 16-page-per-area
> + * widening would needlessly pressure the address space.
> + */
> +#ifdef CONFIG_X86_64
> +#define VMAP_GUARD_PAGES	0x11
> +#endif
> +
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>  
>  #ifdef CONFIG_X86_64
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 3b02c0c6b371..b8546e519deb 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -49,6 +49,18 @@ struct iov_iter;		/* in uio.h */
>  #define IOREMAP_MAX_ORDER	(7 + PAGE_SHIFT)	/* 128 pages */
>  #endif
>  
> +/*
> + * Number of unmapped guard pages appended to each guarded vmalloc
> + * allocation. The default is a single page; an architecture may override
> + * VMAP_GUARD_PAGES (via asm/vmalloc.h) when a wider guard is needed to
> + * contain a worst-case single-instruction stack pivot into an adjacent,
> + * attacker-controlled vmap allocation (see arch/x86 for the ENTER case).
> + */
> +#ifndef VMAP_GUARD_PAGES
> +#define VMAP_GUARD_PAGES	1
> +#endif
> +#define VMAP_GUARD_SIZE		(VMAP_GUARD_PAGES * PAGE_SIZE)
> +
>  struct vm_struct {
>  	union {
>  		struct vm_struct *next;	  /* Early registration of vm_areas. */
> @@ -236,8 +248,8 @@ int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
>  static inline size_t get_vm_area_size(const struct vm_struct *area)
>  {
>  	if (!(area->flags & VM_NO_GUARD))
> -		/* return actual size without guard page */
> -		return area->size - PAGE_SIZE;
> +		/* return actual size without guard region */
> +		return area->size - VMAP_GUARD_SIZE;
>  	else
>  		return area->size;
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index bb6ae08d18f5..8bb2b3ef40a8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3217,7 +3217,7 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
>  		return NULL;
>  
>  	if (!(flags & VM_NO_GUARD))
> -		size += PAGE_SIZE;
> +		size += VMAP_GUARD_SIZE;
>  
>  	area->flags = flags;
>  	area->caller = caller;
> -- 
> 2.43.0
>


Hi hardening team and maintainers,

This patch widens the vmalloc guard region on x86_64 to close a
class of stack-pivot primitive against CONFIG_VMAP_STACK kernels. We would
like the hardening and mm/x86 maintainers' view on whether this belongs in
the common guard path or should be scoped to thread stacks.

The description below is intentionally theoretical: it explains why a single
guard page is insufficient, without operational exploitation detail.

Background / threat model
=========================

With CONFIG_VMAP_STACK (the default on x86_64), kernel thread stacks live in
the vmalloc area, which allocates roughly linearly. In principle an
unprivileged user can place attacker-controlled vmalloc allocations near a
target stack, the vmalloc area exposes several allocation paths reachable
from userspace, so at the moment of a control-flow hijack the live stack
can be adjacent to attacker-controlled mapped pages.

Today each guarded vmalloc allocation is followed by a single unmapped guard
page. The guard relies on the assumption that a corrupted RSP cannot jump
far enough, in one step, to clear the guard and land in the next mapped
allocation. On x86_64 that assumption does not hold.

The primitive
=============

The x86_64 ENTER instruction (ENTER imm16, imm8) builds a stack frame in a
single instruction and lowers RSP by:

    imm16 + 8 * (L + 1),  L = imm8 & 0x1f

imm16 is an unsigned 16-bit operand and ENTER never raises RSP, so a single
ENTER lowers RSP by up to 0xffff + 8 * 0x20 = 0x100ff bytes, which is more than a
page. A single instruction can therefore move RSP off the current stack,
across the one-page guard, and into an adjacent vmalloc allocation.

Theoretically this matters because:

  - The displacement is attacker-chosen (via the immediates) up to 0x100ff,
    so the pivot can clear any guard narrower than that in one step.
  - ENTER is reachable as a gadget, so a pivot of this size is available
    without depending on register state at the hijack site.
  - The pivot happens after the control transfer, so it is not constrained
    by forward-edge CFI (kCFI / FineIBT).

Taken together these make it a one-gadget-style pivot that generalizes
across control-flow hijacks: because no register control is required at the
hijack site, any control-flow hijack able to reach a single ENTER gadget can
move RSP into an adjacent vmalloc allocation. The net effect is that a single
guard page is not a reliable boundary between a pivoted RSP and the next
mapped allocation on x86_64.

Because this lifts a generic primitive across control-flow hijacks rather
than easing one specific bug, we think the guard itself should be widened so
the boundary holds regardless of the originating hijack.

We have a working proof-of-concept and are happy to share it privately with
maintainers; we are keeping the offensive details off the public list.

The fix
=======

Widen the guard region from one page to the smallest whole-page span that
exceeds the worst-case single-ENTER displacement: 0x11 pages (0x11000 bytes
> 0x100ff). A pivot off the top of the stack then lands in unmapped guard
memory and faults, instead of in mapped, attacker-controlled pages.

This is scoped to x86_64 via a VMAP_GUARD_PAGES knob that defaults to one
page (no change for any other architecture) and is overridden only under
CONFIG_X86_64. The 0x100ff bound is a property of the ENTER opcode, which is
also a one-byte unintended gadget; other architectures have no equivalent
single-instruction, immediate-controlled pivot reachable as an unaligned
gadget, so they keep the one-page guard and pay no cost. VMAP_STACK is
selected only on x86_64, so 32-bit x86 is excluded as well.

Cost: the guard pages are never populated, so there is no extra physical
memory and no extra page-table population beyond the larger virtual span --
only virtual address space and vmap_area bookkeeping, negligible against the
64-bit vmalloc window. get_vm_area_size() is adjusted by the same amount so
the usable size reported to callers is unchanged.

Open question for maintainers
=============================

On x86_64 this widens the guard for all guarded vmap areas, not only thread
stacks. ret2enter targets the stack specifically, so a narrower alternative
is to apply the wider guard only on the thread-stack allocation path via a
dedicated VM_ flag. We kept it in the common path as defense in depth for any
vmalloc-adjacent pivot target, but are happy to scope it to stacks if you
prefer.

We would like to hear your feedback and suggestions.

Thanks,
Xiang
 
