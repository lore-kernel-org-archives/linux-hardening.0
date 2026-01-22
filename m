Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC02D9EE4;
	Thu, 22 Jan 2026 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087349; cv=none; b=OeEfoiG6QUi96S8/rR8+LUZXVIent3ScJKwFQ67maHJEnbTDCkUk3fdVv2SinaOO66d1nQa4cKS4592qtKTk2QJsWqRCfaypdduv49aHk/zsbVYhhLpqflCGRXjPyQ5zvP2rMEhG4q+PkMdd4IXJNFcKk7z8lBySOVfmgXbwMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087349; c=relaxed/simple;
	bh=IhW6uUCJlNXzA+TUnDHjZyo5vY2/t+69NEGwibYM8dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/zsfPUQZfGaY9JV8q13CRn0lIvSiEujtoSEgWo3kRuIJjcGLXpCM4e21QJxEqDi6E3QOU7ph2LCwJvi2sZdyRrIsI5++b+WsCS/HWmAmNVJX9oeTXNBBs56esRBMm00Cs2LLziaKq/AbJHoWE6iotrfgck40PPZ3ZKXqrXLfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IqvFE5Oo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IqvFE5Oo"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE8FA40E02E6;
	Thu, 22 Jan 2026 13:09:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OpEuhyP9S9W8; Thu, 22 Jan 2026 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769087340; bh=FTY8h/DDiUOsL09Qp+kNw6L9gb+o7GHc7+dFlJ4jzho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqvFE5OoLj2Cp2yWUHUH3Hbu6afIMkm7mkvwYrSxGqxbvsNz1SjoVWgkTP2wjP3lB
	 LP75ev5EXK8QqvXoGfoNvkIFMwRpbm4+BsVe3r1YCInQZFEPOsbnQRVmZ8SY23A9Ve
	 itCCZuMIDyCSB8HWJxxiZFph9nHGVoVZmUrYIO2wT6oPdsvi0I+FMfsYtyAgAESd/J
	 WZJThOkvpA9a0RWeK+31RY71asBzSXxb4ToTF340iBjCNYckkxdZVZDUPZn1yHOZq7
	 QLvX3C63E9r6b2+V/C804mbMn4adDqPpw+j0AxqwS6BhobvwCrN/H6sI+HY8gRuUEe
	 twLara1s9/nXpGAIj09QADHU9iepMo0SMsY9gmtqcwik2cwzp4s9ERybkLdeHckExX
	 tRsQf/1gbQ6E6NeGSyvHdZYfI8hMSTd9kkIlsIeWHbZtQ0zHVGQfaZX9mB11/A7t87
	 a72eZck2OgvOBQJAd0S2GPjV7kaCnbHY7bCON2Ly+TSGulTcTisVsstxZvgWFy48M6
	 19PQyECDUc30QhxQpCr/Dfu3RK+FQMMy3FLKkBEL0Wof3viQ2SxGX1MIcQAqCqxMDL
	 BXVtz2A/M6qr5POIrEk6QxF4yo/9m5YB+xUoeUJVxIE0hlipAt4QwO+mKQb5/GeUJj
	 ju/Lm7JqkHwt2jRwwGpKa/AE=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 55C4740E027A;
	Thu, 22 Jan 2026 13:08:47 +0000 (UTC)
Date: Thu, 22 Jan 2026 14:08:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 01/19] x86/idt: Move idt_table to __ro_after_init
 section
Message-ID: <20260122130839.GFaXIhV9SPFzS-RDnj@fat_crate.local>
References: <20260108092526.28586-21-ardb@kernel.org>
 <20260108092526.28586-22-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108092526.28586-22-ardb@kernel.org>

On Thu, Jan 08, 2026 at 09:25:28AM +0000, Ard Biesheuvel wrote:
> Currently, idt_table is allocated as page-aligned .bss, and remapped
> read-only after init. This breaks a 2 MiB large page into 4k page
> mappings, which defeats some of the effort done at boot to map the
> kernel image using large pages, for improved TLB efficiency.
> 
> Mark this allocation as __ro_after_init instead, so it will be made
> read-only automatically after boot, without breaking up large page
> mappings.
> 
> This also fixes a latent bug on i386, where the size of idt_table is
> less than a page, and so remapping it read-only could potentially affect
> other read-write variables too, if those are not page-aligned as well.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/idt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index f445bec516a0..d6da25d7964f 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -170,7 +170,7 @@ static const __initconst struct idt_data apic_idts[] = {
>  };
>  
>  /* Must be page-aligned because the real IDT is used in the cpu entry area */
> -static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
> +static gate_desc idt_table[IDT_ENTRIES] __aligned(PAGE_SIZE) __ro_after_init;
>  
>  static struct desc_ptr idt_descr __ro_after_init = {
>  	.size		= IDT_TABLE_SIZE - 1,
> @@ -308,9 +308,6 @@ void __init idt_setup_apic_and_irq_gates(void)
>  	idt_map_in_cea();
>  	load_idt(&idt_descr);
>  
> -	/* Make the IDT table read only */
> -	set_memory_ro((unsigned long)&idt_table, 1);
> -
>  	idt_setup_done = true;
>  }

Good idea, except my guest shows me something else:

before:

[    0.186281] IDT table: 0xffffffff89c7f000

0xffffffff89c00000-0xffffffff89c7f000         508K     RW                 GLB NX pte
0xffffffff89c7f000-0xffffffff89c80000           4K     ro                 GLB NX pte
0xffffffff89c80000-0xffffffff89e00000        1536K     RW                 GLB NX pte
0xffffffff89e00000-0xffffffff8be00000          32M     RW         PSE     GLB NX pmd

This is clearly a single, 4K RO pageframe right in the middle of a splintered
2M page.

after:

[    0.180635] IDT table: 0xffffffff822cf000

0xffffffff81e00000-0xffffffff82200000           4M     ro         PSE     GLB NX pmd
0xffffffff82200000-0xffffffff8236f000        1468K     ro                 GLB NX pte
0xffffffff8236f000-0xffffffff82400000         580K     RW                 GLB NX pte
0xffffffff82400000-0xffffffff89800000         116M     RW         PSE     GLB NX pmd

but after applying your patch it looks like it still broke the 2M mapping as
the remaining piece is RW.

If I do this:

static gate_desc idt_table[IDT_ENTRIES] __aligned(PMD_SIZE) __ro_after_init;

it still doesn't help:

[    0.197808] IDT table: 0xffffffff82800000

0xffffffff81e00000-0xffffffff82800000          10M     ro         PSE     GLB NX pmd
0xffffffff82800000-0xffffffff828a0000         640K     ro                 GLB NX pte
0xffffffff828a0000-0xffffffff82a00000        1408K     RW                 GLB NX pte
0xffffffff82a00000-0xffffffff89e00000         116M     RW         PSE     GLB NX pmd

because that trailing piece of the 2M page is still RW.

And who knows what else am I breaking when doing this:

[    2.368601] ------------[ cut here ]------------
[    2.389816] [CRTC:35:crtc-0] vblank wait timed out
[    2.396676] WARNING: drivers/gpu/drm/drm_atomic_helper.c:1920 at drm_atomic_helper_wait_for_vblanks.part.0+0x1ba/0x1e0, CPU#1: kworker/1:0/57
[    2.406715] Modules linked in:
[    2.408462] CPU: 1 UID: 0 PID: 57 Comm: kworker/1:0 Not tainted 6.19.0-rc6+ #4 PREEMPT(full)
...

I don't know, sacrificing a 2M page just for the idt_table and so that it
doesn't get splintered, not sure it is worth it.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
