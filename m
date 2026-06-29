Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756403CF047
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775713; cv=pass; b=NYhP/GdQhRHeGjEYxKCAGAn4favE6Dq8Al2tJTOqW4dPwnaROUordfp89iJj53zsmP7K2P117bXeiz8SAnMii/4wnz4c1/U6EcMRRHs7D6KrE9zJyj5oYB5wft4ueErH0KyRrVp1A2H+KZeItwF3qbjNO5E9w6sUdw7btq1cyzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775713; c=relaxed/simple;
	bh=PQ0mE7g5erfsOhoLoShoPcQ0FaRjRPOroxOu6dnk4ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkLjcOaXB2Ai9zkHrclSv66PwAy7O/BthwFJVG3iRGfX4mn2eeevF5EK5Gr+pcj7eYnZZEr7thLJxcsgB604/7ts5RJeKAdLHajIJakKHrCd/GGhQyafcDY7zsRincl/B5pkFmfvkKa4nk2QvWcjF2TVH0fD8AaRQR/1/NdtBcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=p4vueTXD; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="p4vueTXD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ca15944645so6032485ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 16:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782775711; cv=none;
        d=google.com; s=arc-20260327;
        b=l2hG10LDxqmDwTJvMiCy4mNScyMeB3Zuhbn5CbJGlMwZMBNv+168H3fLHMClCQp+RO
         mNT+elywilxz2A46aNO0GWYuz7kCeXxqnPAMnCjORijUPFiulbHY8ZJCZzp+XLFcUXts
         8ZuSH7pjPU6aIwsInKSLNLbXHWXl0kU5cfLTW+WbPvD9eJf4B0ssj8kkhCWbFP/Fq5oS
         rTeUhyq8aDaqWVWGqfC0wK4epbZq8ztvU5JZf/osT/SaQ4nAUuiemVgPt4c2Ni3MHyte
         AKAjrsA5/c4u6tLLG3YjKQ/hs8Qc8RPtkiFaeivyfJEMznMk0vJW3FCbNHIqhgmzq3yy
         TLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LxNwVLEcxtw3ITw0JLgqNmraBcVesmt4fflNScBtpzo=;
        fh=Xh47QWMgy2wuzodKwEajpnFGslYNQ5eZUXNkhiQGAbM=;
        b=TOlgeZEQsoKK7CHpp+katReIl9XwjG04flAYrgr1dL1ZF10yHuPJcN3a319vfx7Wfi
         IfFxnJxcVkLgj5mB8ZCHDlhqlFRGkreAulVSgzRMJp7p5wguWboEum3geV+8EL1m1ua0
         o4CjG238SPRT4mOUmtEk6k8xXn2jDuXQy/Vk1f7XDH6TC15h+Sfo7uKqx0+50E93hR9W
         d/bJBX/F5GWKHZPr4FgzUdVjz4KeUhYZCrLrnRlydUZzBaXqyEh0DQfXxaAttdCWpCgi
         c1IsAXTqtru68cBfEpBPZLlv+jQjV4PYD+Pf3EhEfk4xfzOIUmzL5wZrPIGSAOxTPJCM
         TG3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782775711; x=1783380511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxNwVLEcxtw3ITw0JLgqNmraBcVesmt4fflNScBtpzo=;
        b=p4vueTXD8jz/5b2fEkpK5VZf/t3TuFAadbJTFr8FuOBjxEpsZIwAQNS8C9c6WmJywt
         HePdrbzksSfmZBfaRtPPvm0USQdNl+5NtnPxArCf5B7lqmUlz9VmEMr0TLU+purnAL2U
         ZXScV55e5c5j8XSjTuv+MxRjx/X7W/h8K5BGZ93lKXQjsspWTmhi4E/jDQKS263UXrY5
         QjNMVWTHPlgeieUIF/pcFlJNgolApFJG/bs/NcD8vSqnRYfJeT7kYAZAIo847Zfsg3nu
         skulfQGfJdDdRbwzzhKOWW+oCm4XKV7g7Uxv8/8qO+5r2z564Fg5oHb6wef83uTIC5cB
         7ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782775711; x=1783380511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxNwVLEcxtw3ITw0JLgqNmraBcVesmt4fflNScBtpzo=;
        b=eGoPNMQzWQAF6Z48BxVmuLQ131biW2HJgLtvpl3omOwfbVMPaj6Cn9390FKHyGdzS6
         mg81O4b5VC5Em6RtKBuX0ncuUaw+QCrTw/8NLa6IqAVAfpvjAZGD1kRrjIsfFK62Jz5I
         v8YsWZ8RZV5QeaqL3B6WxKi7YRcge9jC1kloEJv+Vy5gy3JIX4koOCv84EdSC/ZHaIzC
         pcovkqF31MuYUgI5T397O3rnOi/ddA80chA98CafGCo9fyKa5/kXs7UDEGkw7EWm1d8U
         3+q4YoZbueXDcL4Pjahh0rNiQ3MSMhzElFf4aA0VDmOEfBAiQnv9ZAW2Z3ByuwY566fH
         hDsA==
X-Forwarded-Encrypted: i=1; AHgh+RpQDAlr2e2ApZ8P/xGS5bil6X7Whm6JCK4spMaN+u3+rfUR+A1lRiqmp+scS0mo7CkHFONwrWX1kiMTNXCIXXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx06yUrFoXelTw7YaUwFYl8lsSTv5aJxrw4dV5DD+jq2pj0k03h
	vVZvmVBDPQNXAndhMXxa10jsI7RXrYFXxc8gGqTZN1LXZ+5OOoLyOmVxRZLi8yJUQZ/czHOHP2s
	U19KWH+LyczZHha+jRhRpb3c8F39aOp7EjWhd6gLy
X-Gm-Gg: AfdE7clUDWfm1VyET/sApbBMYS6ikw7vL1O9t/nibwhXVFSXGp5HciV5CJMOSv6OsYG
	n+kBlKyTXDiM+Ydhf/YLlMhr0SWbyz7mQAMldMW0fGNl4ofr7GrZsnvjjBNWPFJgfdbPdh5keX9
	fjUv6yAzJPX8u7E/iIjhu7PZoRg/jH9xKDFZcTfQXD+Wl8HB5yqS0Uwg3ey1J8YS0uUZY7eOmov
	zGITBxRjG9seCKds6RlrwaliB4HhO6b2pV+bjowzHLt9g3EKfFG3JNhkEqiTm1OnRaCFV/pvWbu
	gsW3bpYPrcYk26oDsn+BV6zNBKI=
X-Received: by 2002:a17:902:ecc8:b0:2c7:d603:117f with SMTP id
 d9443c01a7336-2ca2ed3240amr8621505ad.26.1782775710608; Mon, 29 Jun 2026
 16:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629214712.1198680-1-xmei5@asu.edu> <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
In-Reply-To: <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 29 Jun 2026 16:28:19 -0700
X-Gm-Features: AVVi8CfuflCaxfF7hmS1_WNIDJ8ZXm1g5ojY_cTwVKflYDavL-nSp0Q_fJQv3jM
Message-ID: <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, 
	Ruoyu Wang <fishw@asu.edu>, Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 3:29=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 6/29/26 14:47, Xiang Mei wrote:
> > With CONFIG_VMAP_STACK, kernel stacks are allocated in the vmalloc area=
,
> > which an unprivileged user can surround with attacker-controlled data b=
y
> > spraying vmap allocations adjacent to a target stack (for example via
> > XDP_UMEM_REG, though other vmalloc spray paths work too). Today each
> > guarded vmalloc allocation is followed by a single unmapped guard page.
> >
> > A single guard page is not enough to contain the x86_64 ENTER
> > instruction used as a one-instruction stack pivot. ENTER imm16, imm8
> > builds a stack frame and lowers RSP by:
> >
> >       imm16 + 8 * (L + 1),  L =3D imm8 & 0x1f
> >
> > imm16 is an unsigned 16-bit operand (ENTER never raises RSP), and L is
> > in [0, 31], so the maximum displacement of a single ENTER is:
> >
> >       0xffff + 8 * 0x20 =3D 0x100ff bytes
>
> This needs some more discussion of why this _specific_ instruction is so
> important and why a good old 'add'. Peter asked about this on v1 and it
> didn't make it into v2.
>

Thanks, I see it; we can also add more background introduction to the
commit message so readers can understand why ENTER is so special.

> I think it boils down to ENTER doing a bunch of useful stuff setting up
> a new frame in a single instruction. That single instruction is easier
> to conjure up from another exploit or bad control flow than actually
> setting up a stack frame.
>
> But, really, if ENTER is so evil and nobody uses it, shouldn't we just
> have an MSR bit somewhere to tell the CPU to #UD for it rather than
> playing these stack games?
>

I totally agree, and we'd like to see such a control. If I understand
correctly, that's a hardware/architectural change, so for current CPUs
we still need a software mitigation to harden the kernel.

> > That is more than enough to step off the current stack, across the
> > one-page guard, and into the adjacent sprayed pages. When those pages
> > contain a return sled feeding a ROP chain, reaching any ENTER gadget
> > (opcode 0xc8, abundant as both intended and unintended gadgets) turns a
> > control-flow hijack into full ROP execution without any register contro=
l
> > at the hijack site, making it a one-gadget-style primitive that
> > significantly eases exploitation. The pivot happens after the control
> > transfer, so it is not constrained by CFI (kCFI/FineIBT).
>
> This all sounds super theoretical.
>
> I don't think we should mess with any of this without there being some
> sign that this is an actual, practical juicy exploit target.
>
Yes, I am sorry to reuse some incorrect comments I copied from v1.
I'll remove the CFI-related content since we assume we already have
control flow hijacking.
Thanks for pointing it out.

> > Introduce a VMAP_GUARD_PAGES knob that defaults to a single page (no
> > change for current architectures) and can be overridden per arch via
> > asm/vmalloc.h, and set it to 0x11 on x86_64. This is deliberately scope=
d
> > to x86_64: the 0x100ff bound is a property of the ENTER opcode, and ENT=
ER
> > is also a one-byte opcode (0xc8) that appears as abundant unintended
> > gadgets. Other architectures (e.g. arm64) have no equivalent
> > single-instruction, immediate-controlled pivot reachable as an unaligne=
d
> > unintended gadget, so they keep the one-page guard and pay no cost.
>
> To even be considered, this series needs to be refactored properly.
> Making this VMAP_GUARD_PAGES a separate patch is the bare minimum.
>
Good suggestion, I will do it in v3:

    1/3 - introduce VMAP_GUARD_PAGES
    2/3 - mark percpu vmap areas VM_NO_GUARD
    3/3 - set VMAP_GUARD_PAGES to 0x11 on x86_64

> > The override is gated on CONFIG_X86_64 rather than applying to all of x=
86:
> > VMAP_STACK is selected only on x86_64, so 32-bit kernel stacks are not =
in
> > the vmalloc area and the technique does not apply there. 32-bit x86 als=
o
> > has a far smaller vmalloc window, where widening every guarded area by =
16
> > pages would needlessly pressure the address space.
>
> Shouldn't you condition it on HAVE_ARCH_VMAP_STACK, not X86_64 directly?
>

Yup, that's better; we'll do the following in v3:
```
#if defined(CONFIG_X86_64) && defined(CONFIG_VMAP_STACK)
#define VMAP_GUARD_PAGES 0x11
#endif
```

> > The guard pages are never populated, so there is no extra physical
> > memory and no additional page-table population beyond the larger virtua=
l
> > span; the cost is virtual address space and vmap_area bookkeeping, whic=
h
> > is negligible against the 64-bit vmalloc window. get_vm_area_size() is
> > adjusted by the same VMAP_GUARD_SIZE so the usable size reported to
> > callers is unchanged.
>
> Let's be thorough here, though, please. You're arguing that there's no
> real cost to this. It's going to make the vmalloc() address space more
> sparse and put pressure on the intermediate paging structure caches.
> Whether that pressure matters is debatable.
>
> But I do think you owe at least some rudimentary performance checks on th=
is.
>

I'll do some cost tests before sending v3 and the correct statement.

> BTW, this is LLM-wordy. If you send another version of this, please work
> on making it more concicse.
>
The v3 comments would be concise.

> > On x86 this widens the guard for all guarded vmap areas, not only threa=
d
> > stacks. ret2enter targets the stack specifically, so a narrower
> > alternative is to apply the wider guard only on the thread-stack
> > allocation path via a dedicated VM_ flag; we kept the change in the
> > common path as defense in depth for any vmalloc-adjacent pivot target,
> > but are happy to scope it to stacks if maintainers prefer.
>
> The simplest code thing for now is to just make it apply to all
> vmalloc() allocations. That also theoretically has the largest impact,
> but it's probably the best patch to start with.
>
> > While widening the guard, also mark percpu vmap areas VM_NO_GUARD.
> > pcpu_get_vm_areas() and pcpu_page_first_chunk() size each area exactly =
and
> > reserve no guard, so get_vm_area_size() would subtract a guard that was
> > never added and underflow if an area were smaller than the guard. This =
is
> > a latent correctness fix only: on x86_64 percpu areas are megabyte-scal=
e,
> > far larger than the guard.
>
> Honestly, I think this is just a sign that the code needs refactoring
> rather than hacks.
>
> If you go forward with this, I think vm_struct just needs a
> area->guard_nr_pages. Then the internal users of the structure just set
> area->size and the guard size. They don't have to fiddle with VM_NO_GUARD=
.
>
Agree, the problem exists before our patch (get_vm_area_size() is
already one page less).
> > +/*
> > + * The x86 ENTER instruction can be used as a one-instruction stack pi=
vot:
> > + * ENTER imm16, imm8 lowers RSP by imm16 + 8 * (L + 1), L =3D imm8 & 0=
x1f.
> > + * imm16 is an unsigned 16-bit operand (ENTER never raises RSP) and L =
is in
> > + * [0, 31], so a single ENTER can lower RSP by at most
> > + * 0xffff + 8 * 0x20 =3D 0x100ff bytes. With CONFIG_VMAP_STACK the ker=
nel
> > + * stack lives in the vmalloc area, where an unprivileged user can spr=
ay
> > + * adjacent allocations; a single-page guard is too small to contain s=
uch a
> > + * pivot. Use 0x11 guard pages (0x11000 bytes), the smallest whole-pag=
e
> > + * span exceeding 0x100ff, so the pivot faults in the guard instead of
> > + * landing in attacker-controlled memory.
> > + *
> > + * Restrict this to 64-bit: VMAP_STACK is selected only on x86_64, so =
32-bit
> > + * kernel stacks are not in the vmalloc area and the technique does no=
t apply.
> > + * 32-bit also has a far smaller vmalloc window, where a 16-page-per-a=
rea
> > + * widening would needlessly pressure the address space.
> > + */
> > +#ifdef CONFIG_X86_64
> > +#define VMAP_GUARD_PAGES     0x11
> > +#endif
>
> That comment is way too big. What is it protecting? What does the number
> come from? We don't need to see the gory details in the comment.
>
> /*
>  * Protect against control flow hijacks to gadgets using the ENTER
>  * instruction. Those can jump a bit over 64k on the stack so make the
>  * guard 64k+4k.
>  */
> #ifdef CONFIG_VMAP_STACK
> #define VMAP_GUARD_PAGES        0x11
> #endif
>
> Right? What else do you really need?
>
Got it, simple comments and thanks for the example.

> >  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> >
> >  #ifdef CONFIG_X86_64
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 3b02c0c6b371..b8546e519deb 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -49,6 +49,18 @@ struct iov_iter;           /* in uio.h */
> >  #define IOREMAP_MAX_ORDER    (7 + PAGE_SHIFT)        /* 128 pages */
> >  #endif
> >
> > +/*
> > + * Number of unmapped guard pages appended to each guarded vmalloc
> > + * allocation. The default is a single page; an architecture may overr=
ide
> > + * VMAP_GUARD_PAGES (via asm/vmalloc.h) when a wider guard is needed t=
o
> > + * contain a worst-case single-instruction stack pivot into an adjacen=
t,
> > + * attacker-controlled vmap allocation (see arch/x86 for the ENTER cas=
e).
> > + */
>
> Heh, are you getting paid by the word here? These are way too verbose.
>
I'll clean them in v3.
> > +#ifndef VMAP_GUARD_PAGES
> > +#define VMAP_GUARD_PAGES     1
> > +#endif
> > +#define VMAP_GUARD_SIZE              (VMAP_GUARD_PAGES * PAGE_SIZE)
>
> This could also be quite trivially expressed in Kconfig:
>
> config VMAP_GUARD_PAGES
>         int
>         default 1
>         default ARCH_VMAP_GUARD_PAGES if ARCH_VMAP_GUARD_PAGES
>
Good suggestion, it'll be in v3.
> >  struct vm_struct {
> >       union {
> >               struct vm_struct *next;   /* Early registration of vm_are=
as. */
> > @@ -236,8 +248,8 @@ int vmap_pages_range(unsigned long addr, unsigned l=
ong end, pgprot_t prot,
> >  static inline size_t get_vm_area_size(const struct vm_struct *area)
> >  {
> >       if (!(area->flags & VM_NO_GUARD))
> > -             /* return actual size without guard page */
> > -             return area->size - PAGE_SIZE;
> > +             /* return actual size without guard region */
> > +             return area->size - VMAP_GUARD_SIZE;
> >       else
> >               return area->size;
> >
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index b0676b8054ed..9f7262228be1 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -3243,7 +3243,7 @@ int __init pcpu_page_first_chunk(size_t reserved_=
size, pcpu_fc_cpu_to_node_fn_t
> >       }
> >
> >       /* allocate vm area, map the pages and copy static data */
> > -     vm.flags =3D VM_ALLOC;
> > +     vm.flags =3D VM_ALLOC | VM_NO_GUARD;
> >       vm.size =3D num_possible_cpus() * ai->unit_size;
> >       vm_area_register_early(&vm, PAGE_SIZE);
>
> Yeah, I'd much rather see:
>
>         vm.size  =3D num_possible_cpus() * ai->unit_size;
>         vm.guard =3D 0;
>
> (or whatever we name the structure member) in cases like this.
>
> So, yeah, this is a cute PoC hack. But it's gluing about 10 different
> things into one patch instead of doing proper refactoring. Plus, I'm not
> really even sure it's worth it in the first place.

Yeah, I'll separate them into a series of patches. I believe it's a
worthy patch since it's a huge benefit to have a generic
one-gadget-style gadget. We have tested this one-gadget-style stack
pivoting on real CVEs and got the exploitation working without
additional changes.

Thanks for your review. I'll do the benchmarking and deliver v3.

Xiang
