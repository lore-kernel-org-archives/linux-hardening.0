Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96023371D13;
	Fri,  6 Mar 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824077; cv=none; b=V7tnTIrLE/nNrTlGQ/kBvII6PUvMG/rPXJPs4ZLM3kItNLpxQgq1IuQa8snNzzbMdAzgZpr7nbdqz6uPLAS03nFxNm9VwX14ZWseuJZps5hKOrsXviwNBf2hQKFJcwawFxqodcmNxhlkUQpBz94AzaFwreSBHenbZ6mIfVhdLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824077; c=relaxed/simple;
	bh=xPJRUSL3AtNhtQpKFIFbeJvy7s2fPZV47BrF9QetGlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG7IovSmsxRMHNOKN8AFadJFQy/np7uQ75/bjqAhbkosA9aZHvQvfAB+2gdQjR9CLs8ZzaqAtzg+3pSn1VT7/QLMcZN4Pc0BLJS3Hh+68+GpapodKTpatK8mzF4O6y2uw7xcY6UlN8jHtFmzSawR6LTzW9IRzoOiqgmFqA8P0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hY4kHGKP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hY4kHGKP"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6391540E00DA;
	Fri,  6 Mar 2026 19:07:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I5oAVjMNrSus; Fri,  6 Mar 2026 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772824068; bh=+g7vj2Pr06GEhBB8roLz7/XPYaq/16z+ovE0uDpMds4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hY4kHGKPLV8ZkEbHO+lUplRd3UxjgfDfQy4+239AwLDtBDAH3dLkNK1U4l7ijl5ba
	 Mw9yVSZi9nXN90h9YCoTaSX0o28P4txLqjXqpShmr8sRmQFYHRCJywd3ZyD91T/QKa
	 68sX/0+JM3zq/BesrL8J0RzdOPvq7CzEziudC4zbxQ5ZjlbUFrp3nFrMVqNbPXYRLr
	 WqLwK/QWQr11RpO4E7uwL3OxlJ6RwcuHQZvSrZAPxD+0xeLmhU9h/XSiuf+ePcqdzO
	 BQJLCKoUm1dtc8CB5V0GRViLT4iA1PJs0JzVslDvOQDi/9KP1AUx3J3f9361iOOCpO
	 o1i3udgncfWXxwVK5IIEX0M54XBOTyEg/4twFLHZfkviRR7BBz47pkbXS+P8yTX5nX
	 csjgaVxzRDsotFb1hrLv0o3G6aGhJPGB2qQNU/lBc9JykK60XLhaIGSNtoZVq7v7XS
	 tWhOrhEoWysXzs+TXh8E0daF2Pimaj+w5zISXnOPC57Op89YQlCyQQ7TOCqpR2OQPG
	 h6ZfmZFFv3YLxj/Y6XGmVzQ+oO1qnhcxP81EMoUP/4AKs/xRpqL6g6rAcaIcSeewto
	 Tu42KXcHuBLs+VpKVwFqeVWQBiXdOUAeF/suUsdHcQHVVoYAX0rv4HgB86e45dYM5n
	 Lv9IA0muqbmnftBcPhS0zKo0=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 146D140E0031;
	Fri,  6 Mar 2026 19:07:35 +0000 (UTC)
Date: Fri, 6 Mar 2026 20:07:29 +0100
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
Subject: Re: [RFC/RFT PATCH 03/19] x86: Combine .data with .bss in kernel
 mapping
Message-ID: <20260306190729.GMaasl8VFJh31kS3mi@fat_crate.local>
References: <20260108092526.28586-21-ardb@kernel.org>
 <20260108092526.28586-24-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108092526.28586-24-ardb@kernel.org>

On Thu, Jan 08, 2026 at 09:25:30AM +0000, Ard Biesheuvel wrote:
> The primary mapping of the kernel image is made using huge pages where
> possible, mostly to minimize TLB pressure (Only the entry text section
> requires alignment to 2 MiB). This involves some rounding and padding of
> the .text and .rodata sections, resulting in gaps.  These gaps are
> smaller than a huge page, and are remapped using different permissions,
> resulting in fragmentation of the huge page mappings at the edges of
> those regions.
> 
> Similarly, there is a gap between .data and .bss, where the init text
> and data regions reside. This means that the end of the .data region and
> the start of the .bss region are not covered by huge page mappings
> either, even though both regions use the same permissions (RW+NX).
> 
> Improve the situation, by placing .data and .bss adjacently in the
> linker map, and putting the init text and data regions after .rodata,
> taking the place of the rodata/data gap. This results in one fewer gap,
> and a more efficient mapping of the .data and .bss regions.
> 
> To preserve the x86_64 ELF layout with PT_LOAD regions aligned to 2 MiB,
> start the second ELF segment at .init.data and align it to 2 MiB.  The
> resulting padding will be covered by the init region and will be freed
> along with it after boot.
> 
> defconfig + Clang 19:
> 
> Before:
> 
>   0xffffffff81000000-0xffffffff82200000    18M  ro  PSE  GLB x  pmd
>   0xffffffff82200000-0xffffffff8231c000  1136K  ro       GLB x  pte
>   0xffffffff8231c000-0xffffffff82400000   912K  RW       GLB NX pte
>   0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE  GLB NX pmd
>   0xffffffff82a00000-0xffffffff82b40000  1280K  ro       GLB NX pte
>   0xffffffff82b40000-0xffffffff82c00000   768K  RW       GLB NX pte
>   0xffffffff82c00000-0xffffffff83400000     8M  RW  PSE  GLB NX pmd
>   0xffffffff83400000-0xffffffff83800000     4M  RW       GLB NX pte
> 
> After:
> 
>   0xffffffff81000000-0xffffffff82200000    18M  ro  PSE  GLB x  pmd
>   0xffffffff82200000-0xffffffff8231c000  1136K  ro       GLB x  pte
>   0xffffffff8231c000-0xffffffff82400000   912K  RW       GLB NX pte
>   0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE  GLB NX pmd
>   0xffffffff82a00000-0xffffffff82b40000  1280K  ro       GLB NX pte
>   0xffffffff82b40000-0xffffffff82c00000   768K  RW       GLB NX pte
>   0xffffffff82c00000-0xffffffff82e00000     2M  RW  PSE  GLB NX pmd
>   0xffffffff82e00000-0xffffffff83000000     2M  RW       GLB NX pte
>   0xffffffff83000000-0xffffffff83800000     8M  RW  PSE  GLB NX pmd
> 
> With the gaps removed/unmapped (pti=on)
> 
> Before:
> 
>   0xffffffff81000000-0xffffffff81200000     2M  ro  PSE  GLB x  pmd
>   0xffffffff81200000-0xffffffff82200000    16M  ro  PSE      x  pmd
>   0xffffffff82200000-0xffffffff8231c000  1136K  ro           x  pte
>   0xffffffff8231c000-0xffffffff82400000   912K                  pte
>   0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE      NX pmd
>   0xffffffff82a00000-0xffffffff82b40000  1280K  ro           NX pte
>   0xffffffff82b40000-0xffffffff82c00000   768K                  pte
>   0xffffffff82c00000-0xffffffff83400000     8M  RW  PSE      NX pmd
>   0xffffffff83400000-0xffffffff8342a000   168K  RW           NX pte
>   0xffffffff8342a000-0xffffffff836f3000  2852K                  pte
>   0xffffffff836f3000-0xffffffff83800000  1076K  RW           NX pte
> 
> After:
> 
>   0xffffffff81000000-0xffffffff81200000     2M  ro  PSE  GLB x  pmd
>   0xffffffff81200000-0xffffffff82200000    16M  ro  PSE      x  pmd
>   0xffffffff82200000-0xffffffff8231c000  1136K  ro           x  pte
>   0xffffffff8231c000-0xffffffff82400000   912K                  pte
>   0xffffffff82400000-0xffffffff82a00000     6M  ro  PSE      NX pmd
>   0xffffffff82a00000-0xffffffff82b40000  1280K  ro           NX pte
>   0xffffffff82b40000-0xffffffff82e3d000  3060K                  pte
>   0xffffffff82e3d000-0xffffffff83000000  1804K  RW           NX pte
>   0xffffffff83000000-0xffffffff83800000     8M  RW  PSE      NX pmd
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 91 +++++++++++---------
>  arch/x86/mm/init_64.c         |  5 +-
>  arch/x86/mm/pat/set_memory.c  |  2 +-
>  3 files changed, 52 insertions(+), 46 deletions(-)

I guess we could do this - I don't see why not... we'll have to take it for
a longer spin tho.

> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 3a24a3fc55f5..1dee2987c42b 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -61,12 +61,15 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
>  #define X86_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
>  
>  #define X86_ALIGN_RODATA_END					\
> -		. = ALIGN(HPAGE_SIZE);				\
> -		__end_rodata_hpage_align = .;			\

$ git grep __end_rodata_hpage_align
arch/x86/include/asm/sections.h:13:extern char __end_rodata_hpage_align[];
arch/x86/tools/relocs.c:93:     "__end_rodata_hpage_align|"

I guess you wanna remove those too and say that that marker is unused. Better
yet do that in a pre-patch.

> -		__end_rodata_aligned = .;
> +		. = ALIGN(PAGE_SIZE);				\
> +		__end_rodata_aligned = ALIGN(HPAGE_SIZE);
>  
>  #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
>  #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
> +
> +#define DATA_SEGMENT_START					\
> +	. = ALIGN(HPAGE_SIZE);					\
> +	__data_segment_start = .;
>  #else
>  
>  #define X86_ALIGN_RODATA_BEGIN

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
