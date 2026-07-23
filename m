Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884F1F4180;
	Thu, 23 Jul 2026 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779431; cv=none; b=YA10YceiI7gh2dV7h3WKqE4GiDrWx6QxB/e+a/0FL8KdPXX9+xNB0x4F98t/PpIiaqAmgJ4PeVRuAqsui68k51lvxwdy/utGCNzKunrrEExp6Iomqb/c8AU5V/AG/mSPewTaLy1/Vr58Nxh3Cn6HWAJBnNlcHPuP+5SMv+Ljy4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779431; c=relaxed/simple;
	bh=E0Rjsps/xJlTRSGb+PTaIiXw3BDhi35L401e5jn8DSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlYBt+AjI9iDkGV9JNgDES9BEJlkPoDaK00kCQ4nlx67GYHsuHzFzuts3DRkX6IsLURVD14uUtUcq5M7T/VPFNIXzcIquerIemqzhGR44GUy7Mqz8ygYNedGimfNXwJklw2i/X9Zx8Nyijo7qJsGFm7YT91zIWLZJbC0RmzwI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYZ8yOXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYZ8yOXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36651F000E9;
	Thu, 23 Jul 2026 04:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784779430;
	bh=vpwp5B7HhMWhTc8W1xHIybqX6WzARouv9Ols0jGqF+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XYZ8yOXgrk05A74BBKkdQ+L83HEOEmXA1kUwKgNE0R7QcZXP5rO6ClxqMrL73rwRp
	 8Cuigp5A6Zsj4MJLHJhcG8cBw+cK2DbjWvPvJlly7DA2rN9nSnpNOW7q1SHzyYqQW5
	 s4lo5VfA8dYHP0R69sCZEf4dL1tu1UAsZPjvSUS7rnZ8stardbyHKkP8nqOYD7WZ/U
	 9+f0Y85CuWglOxj3T2z33LqROahEOB4HCp0Wo5L0OD2iIVZUYOj7sU+FclxEKPO+mA
	 qd1OqXtn+qJKO35XBhSWlIf9uHHdftVlka5JH34xZgva0+FuvgGrOzKlMs7e5u2v+o
	 cgmr/kirSJL+Q==
Date: Wed, 22 Jul 2026 21:03:49 -0700
From: Kees Cook <kees@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, david@kernel.org, urezki@gmail.com
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc
 allocations
Message-ID: <202607222102.E6A5679@keescook>
References: <20260722142936.3287702-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722142936.3287702-1-dev.jain@arm.com>

On Wed, Jul 22, 2026 at 02:29:35PM +0000, Dev Jain wrote:
> The vmalloc allocator stores the actual allocation size inside the
> vm_struct structure. We can use this bound in usercopy instead of the
> page-aligned va_end to catch usercopy beyond the actual allocation size.
> 
> For vmap, the requested_size field is always page-aligned since it maps a
> certain number of pages. Same for vm_map_ram (alongwith, not even having
> a vm_struct). So the check is only relevant for vmalloc mappings.
> 
> Because there are early vm areas registered even before vmalloc_init,
> requested_size may be zero. So also check whether the requested_size
> is set.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Looks good to me! Can you update the LKDTM tests to check for this more
tightened range check with a new vmalloc-based test?

If other mm folks can double-check this, I'll happily take this via the
hardening tree.

Thanks!

-Kees

> ---
> Applies on mm-new (3d18f3499c48).
> 
>  mm/usercopy.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 5de7a518b1b1c..772681aff8477 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -176,10 +176,28 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  
>  	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
>  		struct vmap_area *area = find_vmap_area(addr);
> +		struct vm_struct *vm;
>  
>  		if (!area)
>  			usercopy_abort("vmalloc", "no area", to_user, 0, n);
>  
> +		vm = area->vm;
> +		/*
> +		 * Mappings with a vm_struct track the originally requested
> +		 * size. Check against that rather than the page-rounded
> +		 * vmap_area->va_end so copies cannot reach vmalloc tail
> +		 * padding. vmap mappings are always page aligned.
> +		 */
> +		if (vm && (vm->flags & VM_ALLOC) && vm->requested_size) {
> +			unsigned long size = vm->requested_size;
> +
> +			offset = addr - area->va_start;
> +			if (offset > size || n > size - offset)
> +				usercopy_abort("vmalloc", NULL, to_user,
> +					       offset, n);
> +			return;
> +		}
> +
>  		if (n > area->va_end - addr) {
>  			offset = addr - area->va_start;
>  			usercopy_abort("vmalloc", NULL, to_user, offset, n);
> -- 
> 2.43.0
> 

-- 
Kees Cook
