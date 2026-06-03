Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C021474CC
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509796; cv=none; b=N0hXo0mHGJjIxBflk4OZf2XeZHOc0mir1H8eOTkX9xShxdHqKVe0jGwHmhNiIcFq0xeMBEYXuvOEWmBrpkbjmcnCcGtCJomzhFkG3t8v0MGI/8q1ErV3Me3fNdC5s8Ub4E7LWEAWg/V5NCUcPb2oHPD2+5+Bk01teW3/Nxy3ezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509796; c=relaxed/simple;
	bh=ySf7/WNEBUjqbEjsFjmTLnMeckZ/xsYDfJ4orOwY9/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKQAtWEW8svz58VklImWVflJaq6dxImMZqPlNIp3Njh5UpitWXZi2ozHxLOod/mNzZVSH4hTgUHRbxTlYvwQQOdb7qIXnb/wP0/4FiWfz/4wlCoVVNywOt5dbYL0rKQ90LFAyKjfqUS3jWxhWpLRVS9LiU0wTsfgFCauIqhYLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Htci5tqQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htci5tqQ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b903567fdso6261595a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 03 Jun 2026 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509794; x=1781114594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrbiXUlsk45eySsbtONrBewq/djyZBhyYFXfnKgyx7M=;
        b=Htci5tqQrTB/Z8hUDrLhWB5b7/BqEiftHeOiy5uNda6fkwO2u8z8ZaamNC5Mm7+Vow
         NLBO92mwqGgfMpQuNgQqtMTbNXj81AjCOeJGWJ/tf6fXM0D/s6d0zyCQxLSIs8r5FKzN
         XsNh7Fq+58wiND8z7eec658vknoMLESs3/pTUIUTrKLn2f3TqyGs7JNYW5V5OhagIR5+
         0HNQxj32BJ8zqfH96GXVXiYSCQB6V1yFf4f5vbIxn+7v+0H9XzcSTTWLNheBryWIk0FE
         8oR4ebTLrMvrVUM+a5CvpgWdAxTgTuQ09Hmekb0ZkI/Qy3mRzcL7YKziU8BTZDVRaxvE
         /2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509794; x=1781114594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrbiXUlsk45eySsbtONrBewq/djyZBhyYFXfnKgyx7M=;
        b=UdtcX+aJjfsM5FX6PLhMVr9QPBvkrTPyzo9mps4RaItvKj7jQxPc6rAdOHecRUHE0m
         kvCPLUd3/naLaLjtPlaLxVIqsM9EFfhhH+oxfSLm+kPatX++oGLyjPLK9B2ltbK+iZiA
         FdAUskv8wcsLc33DjOsC0g9kBAr0I3oFejm6m24ngeWL+HVvEYeOK6fbp34lSdbNe3Nv
         1Dynz9c0w1Te0xpqO7a7/h2y/ag7+WWS8p+u7XqHtmGHhlSfeYBIPqCmuXLYthm9fu/w
         l5EINZJAb5FxPPXqxXu8IlmqyXXNzGMzfQGqFwbvZZWvyfX4hTkjbSw+VuMUelu4hf9m
         CoZg==
X-Forwarded-Encrypted: i=1; AFNElJ+zqzPT04YVED5eDiUZRUkvG7t2oFeMjKf2E8KIGTXvoOa8eZ23skrRdV0Po1g9lC/gBILn39RIoKmU4gjyEw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkXubTAGLkv3KEueNjImvwQqldc5cFZ+rGzDgcNQ2y7+JkOgO
	jiGcNOXtilo7aMaeR5nk6MxRSV4plqbaFtTxQ7j1SlZstnmppStHeGgF
X-Gm-Gg: Acq92OHcOqferND/T8V4f0V+9pLsCcpvhTzfGVXod7Tdq0T5Z1W1aVFVK9WsGFKuPM1
	0LLF2z75yr2eKOStgJOaY0U4QT11JCw5pLWEZLFfkaO+GdWrWPk21ZfyaIZt7OhIJ3RD268/sOW
	9WD3/bSrPEACtfF6MbEcQLvq5HPo7TtXIWVNpilRgps00ek4PuYV7774ksniSh6/hPnO7sNm5CM
	qbWqdxLRiIgEa8niv81XIPu1O+dUkPoVWKz448IvvO11RPv8TuvChAMBVa+GVmjr1psRuNBpyEd
	Tg4J9d/Y8g+r/6wA4gRftsRXXj2tcEpjte0rzK66PmsqBqP3bERD6tLJ9xQVoD8xYZW/+hZp8ou
	Iz1+hkEoTTng09vgQkZ9OB9FhUj4695RYCAtbE2oJmiBHP3bF6go5sQk1NUGOv/8yEXKygLPuHd
	NYri6od5aGqPDgQQoCZ+QUmgea5bbu8jfSBV8KGs/4aKQ5CGxLD1tsrbaeoJyOZxrB2yyuuebN1
	8PSNgrIeQ==
X-Received: by 2002:a17:90b:3f90:b0:367:db13:aca6 with SMTP id 98e67ed59e1d1-36e319bff94mr4221552a91.26.1780509794151;
        Wed, 03 Jun 2026 11:03:14 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d1fec5asm331867a91.10.2026.06.03.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:03:13 -0700 (PDT)
Date: Wed, 3 Jun 2026 23:33:03 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v7 11/15] powerpc/code-patching: Avoid r/w mapping of the
 zero page
Message-ID: <aiBsMg9WdDy-dRk_@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-28-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529150150.1670604-28-ardb+git@google.com>

On Fri, May 29, 2026 at 05:02:02PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The only remaining use of map_patch_area() is mapping the zero page, and
> immediately unmapping it again so that the intermediate page table
> levels are all guaranteed to be populated.
> 
> The use of the zero page here is completely arbitrary, and not harmful
> per se, but currently, it creates a writable mapping, and does so in a
> manner that requires that the empty_zero_page[] symbol is not
> const-qualified.
> 
> Given that this is about to change, and that map_patch_area() now never
> maps anything other than the zero page, let's simplify the code and
> - remove the helpers and call [un]map_kernel_page() directly
> - take the PA of empty_zero_page directly
> - create a read-only temporary mapping.
> 
> This allows empty_zero_page[] to be repainted as const u8[] in a
> subsequent patch, without making substantial changes to this code
> patching logic.
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Link: https://lore.kernel.org/all/20260520085423.485402-1-ardb@kernel.org/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/powerpc/lib/code-patching.c | 52 +-------------------
>  1 file changed, 2 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index f84e0337cc02..44ff9f684bef 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -60,9 +60,6 @@ struct patch_context {
>  
>  static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
>  
> -static int map_patch_area(void *addr, unsigned long text_poke_addr);
> -static void unmap_patch_area(unsigned long addr);
> -
>  static bool mm_patch_enabled(void)
>  {
>  	return IS_ENABLED(CONFIG_SMP) && radix_enabled();
> @@ -117,11 +114,11 @@ static int text_area_cpu_up(unsigned int cpu)
>  
>  	// Map/unmap the area to ensure all page tables are pre-allocated
>  	addr = (unsigned long)area->addr;
> -	err = map_patch_area(empty_zero_page, addr);
> +	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
>  	if (err)
>  		return err;
>  
> -	unmap_patch_area(addr);
> +	unmap_kernel_page(addr);
>  
>  	this_cpu_write(cpu_patching_context.area, area);
>  	this_cpu_write(cpu_patching_context.addr, addr);
> @@ -233,51 +230,6 @@ static unsigned long get_patch_pfn(void *addr)
>  		return __pa_symbol(addr) >> PAGE_SHIFT;
>  }
>  
> -/*
> - * This can be called for kernel text or a module.
> - */
> -static int map_patch_area(void *addr, unsigned long text_poke_addr)
> -{
> -	unsigned long pfn = get_patch_pfn(addr);
> -
> -	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
> -}
> -
> -static void unmap_patch_area(unsigned long addr)
> -{
> -	pte_t *ptep;
> -	pmd_t *pmdp;
> -	pud_t *pudp;
> -	p4d_t *p4dp;
> -	pgd_t *pgdp;
> -
> -	pgdp = pgd_offset_k(addr);
> -	if (WARN_ON(pgd_none(*pgdp)))
> -		return;
> -
> -	p4dp = p4d_offset(pgdp, addr);
> -	if (WARN_ON(p4d_none(*p4dp)))
> -		return;
> -
> -	pudp = pud_offset(p4dp, addr);
> -	if (WARN_ON(pud_none(*pudp)))
> -		return;
> -
> -	pmdp = pmd_offset(pudp, addr);
> -	if (WARN_ON(pmd_none(*pmdp)))
> -		return;
> -
> -	ptep = pte_offset_kernel(pmdp, addr);
> -	if (WARN_ON(pte_none(*ptep)))
> -		return;
> -
> -	/*
> -	 * In hash, pte_clear flushes the tlb, in radix, we have to
> -	 */
> -	pte_clear(&init_mm, addr, ptep);
> -	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -}
> -
>  static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>  {
>  	int err;
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 
I don't see any functional change.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
