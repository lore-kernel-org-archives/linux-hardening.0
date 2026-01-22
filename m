Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE99322DAF
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089706; cv=none; b=pVMWju+0bAzaPiScHZhpqyMmTAEjopGnLCm6DOsLayPajUD/XfIBicJ3kg2EemGY/VhkbQf00skKY8PJcdw6vBfnlwl54/sPI01+AgA5nAkPOMfSed7fdMJVXMFSs+iJBk5yu/YM+DEK3Xkm3YfUP2sCpACy2aRYatHcU8A2TD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089706; c=relaxed/simple;
	bh=JwTEBPYYRNpl6oFwdaBqO28RaREp40OASdFjAgMxsMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8zKUOlX3+UJm/MRrv8SiBuSvKFRoMQUu82KT2tqS1eVQyt5ET27HktNL0NsJJX1R/hvxg25zaH1NlK3bPpo/PKR1cE6x1xmgFsOkuabgSCbVdFa7UA4fEwX84mNUpgcHVrLNtQaoc6PDbQ9Bl/YP5L6+AnW0ToTVBwOfGz78zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEh6L0Ur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEh6L0Ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DA9C19422
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769089706;
	bh=JwTEBPYYRNpl6oFwdaBqO28RaREp40OASdFjAgMxsMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KEh6L0UrmNwvNBnSRsFLYPAJj+wLQLG43e8g40eLG3msec984HxcwmYhL/LJPhwoW
	 h6kV9nErOkmgeLas943w8yUnzXdSz3uDKNpsrIo7FxLV3L1BdUKiXV/rNtPVMosR5g
	 yOOWD1JIsiE3ynqdAeLMVaAHdfEub53QwVXo8DMQmoVQfJw1LkAgjnVN26WF0SWWab
	 vEldFBX5pSkPUTBksykiTHDBaG+GDRuURFbciq7TupJrGn/9edqZFyhdRhSD+0qkHQ
	 ooed2iBuDNt9p3SfgHrDriAbVGjX9H/c+iZvfGuo8DvQwYpaB/GgonK2D/0ImAD92w
	 g2WGwCI3CBZZA==
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a09757004cso9139265ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 05:48:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmyC7yEOpWl6nDfqIj8HNE33sKta+GZsHGyTPc87NUJkp1OfA2olQtvqKlB3qpucFtCd8BcUxBtMQbgqhvvnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4grf9qrp5L3DgR9Y9xhkw50E197TTKeR+4LeRZSElVdsBDMhK
	FDJDQ4fOkACmN4TJM4cMPoWqnX5zwCcMU358wRT3QOI8CGO0OAlDCDSa4YI+oUp34euYCcVpaMf
	tFPb7qf4IXgCI/kZbtM7CmCY1DgfTnBI=
X-Received: by 2002:a17:903:2f91:b0:2a7:5751:5b30 with SMTP id
 d9443c01a7336-2a757515da0mr86500515ad.12.1769089706004; Thu, 22 Jan 2026
 05:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-22-ardb@kernel.org>
 <20260122130839.GFaXIhV9SPFzS-RDnj@fat_crate.local>
In-Reply-To: <20260122130839.GFaXIhV9SPFzS-RDnj@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Jan 2026 14:48:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFK-Xf73wHDnidhDdMpb=UrWaf3vQhnggmNqOJspKYqvg@mail.gmail.com>
X-Gm-Features: AZwV_QgCNq5zlt3kD8itG0eRFmVZtq7QexkuOfA-I3ZO8CWbIUBk_EUb8ITu0z8
Message-ID: <CAMj1kXFK-Xf73wHDnidhDdMpb=UrWaf3vQhnggmNqOJspKYqvg@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 01/19] x86/idt: Move idt_table to __ro_after_init section
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 14:09, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 08, 2026 at 09:25:28AM +0000, Ard Biesheuvel wrote:
> > Currently, idt_table is allocated as page-aligned .bss, and remapped
> > read-only after init. This breaks a 2 MiB large page into 4k page
> > mappings, which defeats some of the effort done at boot to map the
> > kernel image using large pages, for improved TLB efficiency.
> >
> > Mark this allocation as __ro_after_init instead, so it will be made
> > read-only automatically after boot, without breaking up large page
> > mappings.
> >
> > This also fixes a latent bug on i386, where the size of idt_table is
> > less than a page, and so remapping it read-only could potentially affect
> > other read-write variables too, if those are not page-aligned as well.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/kernel/idt.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> > index f445bec516a0..d6da25d7964f 100644
> > --- a/arch/x86/kernel/idt.c
> > +++ b/arch/x86/kernel/idt.c
> > @@ -170,7 +170,7 @@ static const __initconst struct idt_data apic_idts[] = {
> >  };
> >
> >  /* Must be page-aligned because the real IDT is used in the cpu entry area */
> > -static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
> > +static gate_desc idt_table[IDT_ENTRIES] __aligned(PAGE_SIZE) __ro_after_init;
> >
> >  static struct desc_ptr idt_descr __ro_after_init = {
> >       .size           = IDT_TABLE_SIZE - 1,
> > @@ -308,9 +308,6 @@ void __init idt_setup_apic_and_irq_gates(void)
> >       idt_map_in_cea();
> >       load_idt(&idt_descr);
> >
> > -     /* Make the IDT table read only */
> > -     set_memory_ro((unsigned long)&idt_table, 1);
> > -
> >       idt_setup_done = true;
> >  }
>
> Good idea, except my guest shows me something else:
>
> before:
>
> [    0.186281] IDT table: 0xffffffff89c7f000
>
> 0xffffffff89c00000-0xffffffff89c7f000         508K     RW                 GLB NX pte
> 0xffffffff89c7f000-0xffffffff89c80000           4K     ro                 GLB NX pte
> 0xffffffff89c80000-0xffffffff89e00000        1536K     RW                 GLB NX pte
> 0xffffffff89e00000-0xffffffff8be00000          32M     RW         PSE     GLB NX pmd
>
> This is clearly a single, 4K RO pageframe right in the middle of a splintered
> 2M page.
>
> after:
>
> [    0.180635] IDT table: 0xffffffff822cf000
>
> 0xffffffff81e00000-0xffffffff82200000           4M     ro         PSE     GLB NX pmd
> 0xffffffff82200000-0xffffffff8236f000        1468K     ro                 GLB NX pte
> 0xffffffff8236f000-0xffffffff82400000         580K     RW                 GLB NX pte
> 0xffffffff82400000-0xffffffff89800000         116M     RW         PSE     GLB NX pmd
>
> but after applying your patch it looks like it still broke the 2M mapping as
> the remaining piece is RW.
>

That is because the init region is between .data and .bss, which are
not 2M aligned, and so freeing/remapping the init region breaks the
hugepage mapping of the region between them. This is addressed in
patch #3.
