Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF024A1A;
	Tue, 25 Feb 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470888; cv=none; b=Pf0cd/0QwiMle7wE2ElI/wZg2cbDTWAjIvG2CoOO7QiijMns96h2ZwIjpr/xrjfEcZbeNafPz2YAWgiMlOtgX7Ens6o1WTRSNA6OY7AIL57+tTpxLTIjnuEhVKm9hRg+actKRwn+uTzBWF4T3SGPV9B7zfzGPk6BYbixPGaiv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470888; c=relaxed/simple;
	bh=jDu0V+akQ3h725aTgIuKzINMQUKK/xDZt/5z+cC5YTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml1aEXrD7Oa/FPlOmdwjWRByq0pG8WGVvyCVxUepbtldQewSLD2Cbd8BjztnCnfOCRYd0FijDGUPMe4nG3wgS5/gxtaLs0iLpj/Xt0OqDZbOnPq4kDoPDq9Fh1lqIwmFjt15xrvjGcizxMCvq049O65wtXryNziTPvEM5zfvWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aSd0uwaM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K82ey+kS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aSd0uwaM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K82ey+kS"
Date: Tue, 25 Feb 2025 09:08:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740470884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9SrLxlsEKlN3z3PPX6qEc7Y1rqFZZfeIMG6CIYjw5ec=;
	b=aSd0uwaMRywXvfcwXz6E1s7WMMvPcS0fYeUImVK48trosJ/EnRp7LhEgrMV21c+66KVfb7
	68PvEh3spC0ixnzYv27hMl+brE4z78pFErb/7JUsLrxuTKaycdO/GzJJFOmjtRtgTB7ugx
	3TFTgnpMe7RT5g8tgvNX7T+N1G7Xg8VCUT3rNPT+kafdqaNq1r2L9oX8dt/bpYZTeGV7Qd
	7mhK8dl9FaVKXK9mELw/pgmctxokVMVyuUjcU6Zx408mhtgNftILuvY9CPOhyIpVXxbrfB
	3N8WtEHxXanUo9y89jAfzlXW+6aDBnEzFt5gUG0cjhzNo+yKZVFsV2VWSsKQSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740470884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9SrLxlsEKlN3z3PPX6qEc7Y1rqFZZfeIMG6CIYjw5ec=;
	b=K82ey+kSuc3PRkirrZCoSiOX7lC9ayDulqa2XPhk/ii8GpYPFzo//WeKXtLq/Qxa8f55Jc
	u70VogiGsVuYjhAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, adobriyan@gmail.com, johannes@sipsolutions.net, 
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [PATCH v7 3/7] mseal, system mappings: enable x86-64
Message-ID: <20250225085728-24167715-8562-45a8-86cd-0ea503e4bc73@linutronix.de>
References: <20250224225246.3712295-1-jeffxu@google.com>
 <20250224225246.3712295-4-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225246.3712295-4-jeffxu@google.com>

Hi Jeff,

On Mon, Feb 24, 2025 at 10:52:42PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> covering the vdso, vvar, vvar_vclock.
> 
> Production release testing passes on Android and Chrome OS.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  arch/x86/Kconfig          |  1 +
>  arch/x86/entry/vdso/vma.c | 16 ++++++++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 87198d957e2f..8fa17032ca46 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -26,6 +26,7 @@ config X86_64
>  	depends on 64BIT
>  	# Options that are inherently 64-bit kernel only:
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 39e6efc1a9ca..1b1c009f20a8 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long text_start;
> +	unsigned long vm_flags;
>  	int ret = 0;
>  
>  	if (mmap_write_lock_killable(mm))
> @@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  	/*
>  	 * MAYWRITE to allow gdb to COW and set breakpoints
>  	 */
> +	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	vma = _install_special_mapping(mm,
>  				       text_start,
>  				       image->size,
> -				       VM_READ|VM_EXEC|
> -				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> +				       vm_flags,
>  				       &vdso_mapping);
>  
>  	if (IS_ERR(vma)) {
> @@ -276,11 +278,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  		goto up_fail;
>  	}
>  
> +	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	vma = _install_special_mapping(mm,
>  				       addr,
>  				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       vm_flags,
>  				       &vvar_mapping);

This hunk (and the vvar mapping in the arm64 patch) will conflict with my
"Generic vDSO datapage" series.
That series is already part of the tip tree (branch timers/vdso) and scheduled
for the next merge window.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=timers/vdso

The conflict resolution is fairly easy:
Move the new flag logic into lib/vdso/datastore.c

Depending on the expected mainline timing for this series either mention this
somewhere for the conflict resolution by Linus or rebase your series on top of
tip/timers/vdso.

>  	if (IS_ERR(vma)) {
> @@ -289,11 +292,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
>  		goto up_fail;
>  	}
>  
> +	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> +	vm_flags |= VM_SEALED_SYSMAP;
>  	vma = _install_special_mapping(mm,
>  				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
>  				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
> -				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
> -				       VM_PFNMAP,
> +				       vm_flags,
>  				       &vvar_vclock_mapping);
>  
>  	if (IS_ERR(vma)) {
> -- 
> 2.48.1.658.g4767266eb4-goog
> 
