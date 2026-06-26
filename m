Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FBB3839B8
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496142; cv=pass; b=LMSDktDGYr635f6ysMyn4LlvwlvnLEZJrBP/xPQLcXJrSm/WQ2y0qWxRvp0xTxbAOD/IuLeN3xVr5/oQre7oSg6NdzGb+TtSLKZ9NzhDkfN8I7B01bI4g0gLsZVYTAvTiY0D03YN6hzsKjUyoOZIpBvZRKrAN2Po7b7NowKH29s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496142; c=relaxed/simple;
	bh=P18pbPoXBXa7kDJINUpyNzLPCtpgJwbWe/niuI/RSco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yli78rwdNHXDVd9CrWYjPb5GoEWhLzT1HNXOD5uHFsK+EDURd9V79AVEV/Dmt1UPzZfOx/s81ygmm17ijDPIvEiz2fL8GXkkFY8bCkmyMv9p65hAqKSDVxv8fsDXNYmLoImvdahYVsTZ37HomMDRQqx2I4t6vmJd6H0/MCg1q9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NyoS4mom; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="NyoS4mom"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c7f11150cfso8464985ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 10:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782496138; cv=none;
        d=google.com; s=arc-20260327;
        b=DJkJQwXD14aP70bs3QElkL1EllHj27BDXJ/diZIGIL3J4Nh3QTLFLDHI77spfOxpAm
         IGfW1K1/4OjtCY9dF9AM2uIzK6827ZjnWnKsZ/BH6w3BRdRchmY46OYo99Rs5sQGNIM4
         /wfTiCXlYihbAaPjhu28Efbakza6Q70kbj2Jz+U3kIB7sELO0Zv5RrO/AykbHIEZAWo3
         pL8iJK5ikTi1d+J7/eHeiItQ9eGGfV03btcy0y9GKGAD2USEAxkPXuMzkjeuz/BBysNa
         zaHPwKfyUiuqKt3ZKRJ6RR36Cl/35ZyZgHlx7SdHxND9KD7LKN9cRvJLk0K7CDyepzPF
         d0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wPiBM+E5Ju94wzqMADw6UMZMV0vo32ARI3eqTrkdDy0=;
        fh=q6/6Ykq+NVvltxBCHOkRIU1wLunxCaO50saz/AxBul4=;
        b=bknMJeGA7oVoYYeVG2ozN3eIlVWES3GI4PtCnRvx9y6Uh+wmcHysh89eF0opTmRrN/
         u7+lCNCsbhNcgRzRUCLfO4T84sPw07OyPoPHBIVs2xiuaMPrnxau8rfqi0T49DZiqP4Z
         3F7ltY7kAF/MMrV8188JEZ2XFgjYEbflM/LQYJ+osPC809LLkGVXlx3+UEqoia7VBoVr
         YsbXfOukC0GWvc+SvLemgh10sppFY9fUAGQL5kgLL922WxtC01FKhg8i+1z3+jEYv8FW
         AjFrisgqyx/UTgStqFL6wJA8abj6Qht7wmDnHAYRY0/hSWVo6R7GX2bmvtgzlUmJCiVT
         gNYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782496138; x=1783100938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPiBM+E5Ju94wzqMADw6UMZMV0vo32ARI3eqTrkdDy0=;
        b=NyoS4momuZUqlsX/bvly7grLO0iwPvRiOXHa8Qo7zZRjxGnX5B0QT8IlNcWGHUR1LY
         f2cselsxZkhmpTY4d9FSNKjmE/EhK/DTfydGXW79iyZaT0lXuNYLrimYkdirbyooh8fY
         U9MmasniNYh+0/lKWRXfwp8YWnYi1MblIzFby4SRA5H8pgbuSv9Gv21xW9cazg7xw+IC
         twK5ChCADsDYu+d0GZkXsLePc6ct1S81DjWWACAruSylSuJU0vqgTohPxOFwvEWy63we
         ar0jjoN+vpkM39C3SlZKDd2V1CKRKbjR1lcTHLTeGi4j3NpxKQPkCHCE1hk30jL1jllQ
         ftqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782496138; x=1783100938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPiBM+E5Ju94wzqMADw6UMZMV0vo32ARI3eqTrkdDy0=;
        b=Lt2I/h+GTjbwhr4Jqqj6hjo+CHRXE8BXf+kmnwjX8Xf7Pgh3K6+bH5TaDpVSWXjN76
         Z7LVlKFGVtvIWfch3h2HSSXzBb7tlj1FktXIWvyVvJaqEne5i+eO85WN7lQjkkSTQybp
         2On3Oektjq1SP1+22mGEnMgqhHBa9DHoMZrsifCFZz11V3UHuIKz5qxhUpshaRszANen
         mhiwZfuyP1g7w0EDCDLmQSlaeO2nSihpyykum2vX0U7WGBUO6iZQ0rgqvlDSnYPzeP3k
         o6bJRL6UYBQdkZ0PibRuyqT/Zc6fIQyRs9M9iXefz5EAmvxo0kT1Nsgud5aRugTOCgay
         1HXw==
X-Forwarded-Encrypted: i=1; AHgh+RqH+ej1tXfH1pAbeLDNB++D6POUS6AMwnjGMkbuPkD4DiX6l5QSgEmrpnZHcEHCmEc2FOLXFLY7nMk3dTUXP7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4lAgw9nhu3SUb6YqkEboC0N1tcZoLXpmmHwsp6gI/LFrbMEe/
	c4rxwcapdDvKKEdOt3IQ4b3CHkK2iBp+/r6dI4AAyyzeP8X/5vS9sQpPQXXe1qNsUxuGAseld5F
	U0P3xMx12wUSEGCsQtYgWlB5NDXNfzyQ6KwK8z9OZ
X-Gm-Gg: AfdE7cly9kYdi5klKulB+2eJeZBeVuyk7wBG7XYKJHEWHXf/VFBDoZsyLbM4236wJah
	wmx3xFAeWVUMOWkzXpAHJ7xXDef/81EalQsF+MadsLAU/xo81gTKX+nw9HM8ThiqN/hbepIsnEP
	13FlqbcWx4zLOUbY0bD/ymW9gowepu8X0Z56iPKkv/Nyx5C33VEgwkZ9nYVj1Qk/DjMq2oxAvur
	aiG47N5L+uKiRKDkKeFHZHEd3tAOtoQk65ZXvX4/ViMle10L+jZhzqji2K6SFmaDOLowxv5gFUk
	fzvDlqbespIIlLw1I5VlIeWnLhQ87wU=
X-Received: by 2002:a17:902:ce81:b0:2c0:cf44:3b3d with SMTP id
 d9443c01a7336-2c7fc7579b0mr80875375ad.26.1782496137705; Fri, 26 Jun 2026
 10:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626173444.2252041-1-xmei5@asu.edu> <yu6l7zo4dmqcnho7thkf7sk42lt6xkz6uxxwxmg73x23vihlnp@pe7vdut4o2jc>
In-Reply-To: <yu6l7zo4dmqcnho7thkf7sk42lt6xkz6uxxwxmg73x23vihlnp@pe7vdut4o2jc>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 26 Jun 2026 10:48:46 -0700
X-Gm-Features: AVVi8CeGKAZBpyQZXB1HQ0x9CI7wJdF0pT0XJ5Q6sZegQF17kMZVeso3AFwnI0M
Message-ID: <CAPpSM+Qwmv_wsNFnEjtk3GbLdZB_JtH5vW0v-Cj-CyiE8M_UEw@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 10:46=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> On Fri, Jun 26, 2026 at 10:34:44AM -0700, Xiang Mei wrote:
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
> >
> > That is more than enough to step off the current stack, across the
> > one-page guard, and into the adjacent sprayed pages. When those pages
> > contain a return sled feeding a ROP chain, reaching any ENTER gadget
> > (opcode 0xc8, abundant as both intended and unintended gadgets) turns a
> > control-flow hijack into full ROP execution without any register contro=
l
> > at the hijack site, making it a one-gadget-style primitive that
> > significantly eases exploitation. The pivot happens after the control
> > transfer, so it is not constrained by CFI (kCFI/FineIBT).
> >
> > Widen the guard region from one page to VMAP_GUARD_PAGES (0x11 pages,
> > 0x11000 bytes), which is the smallest whole-page span exceeding the
> > 0x100ff-byte maximum single-ENTER pivot. A pivot off the top of the
> > stack now lands in the unmapped guard and faults, instead of in mapped,
> > attacker-controlled memory. RANDOMIZE_KSTACK_OFFSET only perturbs RSP b=
y
> > a sub-page amount, so it does not change the required width.
> >
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
> >
> > The override is gated on CONFIG_X86_64 rather than applying to all of x=
86:
> > VMAP_STACK is selected only on x86_64, so 32-bit kernel stacks are not =
in
> > the vmalloc area and the technique does not apply there. 32-bit x86 als=
o
> > has a far smaller vmalloc window, where widening every guarded area by =
16
> > pages would needlessly pressure the address space.
> >
> > The guard pages are never populated, so there is no extra physical
> > memory and no additional page-table population beyond the larger virtua=
l
> > span; the cost is virtual address space and vmap_area bookkeeping, whic=
h
> > is negligible against the 64-bit vmalloc window. get_vm_area_size() is
> > adjusted by the same VMAP_GUARD_SIZE so the usable size reported to
> > callers is unchanged.
> >
> > On x86 this widens the guard for all guarded vmap areas, not only threa=
d
> > stacks. ret2enter targets the stack specifically, so a narrower
> > alternative is to apply the wider guard only on the thread-stack
> > allocation path via a dedicated VM_ flag; we kept the change in the
> > common path as defense in depth for any vmalloc-adjacent pivot target,
> > but are happy to scope it to stacks if maintainers prefer.
> >
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Jennifer Miller <jmill@asu.edu>
> > ---
> >  arch/x86/include/asm/vmalloc.h | 21 +++++++++++++++++++++
> >  include/linux/vmalloc.h        | 16 ++++++++++++++--
> >  mm/vmalloc.c                   |  2 +-
> >  3 files changed, 36 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/vmalloc.h b/arch/x86/include/asm/vmal=
loc.h
> > index 49ce331f3ac6..2c341f398227 100644
> > --- a/arch/x86/include/asm/vmalloc.h
> > +++ b/arch/x86/include/asm/vmalloc.h
> > @@ -5,6 +5,27 @@
> >  #include <asm/page.h>
> >  #include <asm/pgtable_areas.h>
> >
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
> > +
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
> > +#ifndef VMAP_GUARD_PAGES
> > +#define VMAP_GUARD_PAGES     1
> > +#endif
> > +#define VMAP_GUARD_SIZE              (VMAP_GUARD_PAGES * PAGE_SIZE)
> > +
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
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index bb6ae08d18f5..8bb2b3ef40a8 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3217,7 +3217,7 @@ struct vm_struct *__get_vm_area_node(unsigned lon=
g size,
> >               return NULL;
> >
> >       if (!(flags & VM_NO_GUARD))
> > -             size +=3D PAGE_SIZE;
> > +             size +=3D VMAP_GUARD_SIZE;
> >
> >       area->flags =3D flags;
> >       area->caller =3D caller;
> > --
> > 2.43.0
> >
>
>
> Hi hardening team and maintainers,
>
> This patch widens the vmalloc guard region on x86_64 to close a
> class of stack-pivot primitive against CONFIG_VMAP_STACK kernels. We woul=
d
> like the hardening and mm/x86 maintainers' view on whether this belongs i=
n
> the common guard path or should be scoped to thread stacks.
>
> The description below is intentionally theoretical: it explains why a sin=
gle
> guard page is insufficient, without operational exploitation detail.
>
> Background / threat model
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> With CONFIG_VMAP_STACK (the default on x86_64), kernel thread stacks live=
 in
> the vmalloc area, which allocates roughly linearly. In principle an
> unprivileged user can place attacker-controlled vmalloc allocations near =
a
> target stack, the vmalloc area exposes several allocation paths reachable
> from userspace, so at the moment of a control-flow hijack the live stack
> can be adjacent to attacker-controlled mapped pages.
>
> Today each guarded vmalloc allocation is followed by a single unmapped gu=
ard
> page. The guard relies on the assumption that a corrupted RSP cannot jump
> far enough, in one step, to clear the guard and land in the next mapped
> allocation. On x86_64 that assumption does not hold.
>
> The primitive
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The x86_64 ENTER instruction (ENTER imm16, imm8) builds a stack frame in =
a
> single instruction and lowers RSP by:
>
>     imm16 + 8 * (L + 1),  L =3D imm8 & 0x1f
>
> imm16 is an unsigned 16-bit operand and ENTER never raises RSP, so a sing=
le
> ENTER lowers RSP by up to 0xffff + 8 * 0x20 =3D 0x100ff bytes, which is m=
ore than a
> page. A single instruction can therefore move RSP off the current stack,
> across the one-page guard, and into an adjacent vmalloc allocation.
>
> Theoretically this matters because:
>
>   - The displacement is attacker-chosen (via the immediates) up to 0x100f=
f,
>     so the pivot can clear any guard narrower than that in one step.
>   - ENTER is reachable as a gadget, so a pivot of this size is available
>     without depending on register state at the hijack site.
>   - The pivot happens after the control transfer, so it is not constraine=
d
>     by forward-edge CFI (kCFI / FineIBT).
Please ignore this line; it is not related since we assume we already
have a CFH primitive. Sorry for the confusion.
>
> Taken together these make it a one-gadget-style pivot that generalizes
> across control-flow hijacks: because no register control is required at t=
he
> hijack site, any control-flow hijack able to reach a single ENTER gadget =
can
> move RSP into an adjacent vmalloc allocation. The net effect is that a si=
ngle
> guard page is not a reliable boundary between a pivoted RSP and the next
> mapped allocation on x86_64.
>
> Because this lifts a generic primitive across control-flow hijacks rather
> than easing one specific bug, we think the guard itself should be widened=
 so
> the boundary holds regardless of the originating hijack.
>
> We have a working proof-of-concept and are happy to share it privately wi=
th
> maintainers; we are keeping the offensive details off the public list.
>
> The fix
> =3D=3D=3D=3D=3D=3D=3D
>
> Widen the guard region from one page to the smallest whole-page span that
> exceeds the worst-case single-ENTER displacement: 0x11 pages (0x11000 byt=
es
> > 0x100ff). A pivot off the top of the stack then lands in unmapped guard
> memory and faults, instead of in mapped, attacker-controlled pages.
>
> This is scoped to x86_64 via a VMAP_GUARD_PAGES knob that defaults to one
> page (no change for any other architecture) and is overridden only under
> CONFIG_X86_64. The 0x100ff bound is a property of the ENTER opcode, which=
 is
> also a one-byte unintended gadget; other architectures have no equivalent
> single-instruction, immediate-controlled pivot reachable as an unaligned
> gadget, so they keep the one-page guard and pay no cost. VMAP_STACK is
> selected only on x86_64, so 32-bit x86 is excluded as well.
>
> Cost: the guard pages are never populated, so there is no extra physical
> memory and no extra page-table population beyond the larger virtual span =
--
> only virtual address space and vmap_area bookkeeping, negligible against =
the
> 64-bit vmalloc window. get_vm_area_size() is adjusted by the same amount =
so
> the usable size reported to callers is unchanged.
>
> Open question for maintainers
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> On x86_64 this widens the guard for all guarded vmap areas, not only thre=
ad
> stacks. ret2enter targets the stack specifically, so a narrower alternati=
ve
> is to apply the wider guard only on the thread-stack allocation path via =
a
> dedicated VM_ flag. We kept it in the common path as defense in depth for=
 any
> vmalloc-adjacent pivot target, but are happy to scope it to stacks if you
> prefer.
>
> We would like to hear your feedback and suggestions.
>
> Thanks,
> Xiang
>
