Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4232199B8;
	Tue, 25 Feb 2025 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445425; cv=none; b=nA+TBEdSxlt3zUwZyVKnWEqaj1E9a54bjnimqTCZ/7p0wYBJ+w57L0bWkprvnzyjb+oqj9pmuxyh4QODklOTRjCASob0Ke0lp5ivnwcPkygZxR2qsIlN/ioX4sR6pf+vTqmofUtNGbnHDCgyD3LAY38UGEdzmi6hWAdblV1HGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445425; c=relaxed/simple;
	bh=qVBpEBOr3T9ej//S5va2dYCUn5teYHqMQYnjiTs0RJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh5PL2tWej2sE0BG6nmKvMqIglnTIssOlE9idDWsbfGlo3t6LDXhpWCjFGNI1H3wELXtDKm7ibLhvwtfw6PCRINOehRHh6ma/gsZlr/R8nXVgzrwy8dSrUgliZpuHc3eTeg4x1u/7rhSUdZv8x2uvP2fofZ4CqdzhPV4EWrf0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj0s2Yu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj0s2Yu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11094C4CED6;
	Tue, 25 Feb 2025 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740445425;
	bh=qVBpEBOr3T9ej//S5va2dYCUn5teYHqMQYnjiTs0RJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uj0s2Yu3wPdceenGrkKQiKxquc9/687ysdpx17KJFeceHbZWBw8hKJIL/4nO19wDc
	 ANzsCbqSO1xH7WJ2+HudcZwuGCVCYxd1D2v6FIzL9Ll4Vpm3m1LZGYLsAIK0C49Q2m
	 QU8I1utLt9nFMjZ/ZBOrxcrOYQONo7H5qFeR3PUp3TTytRVqZw12j4KYJLR1T5qMfC
	 SYwCiaqt3iW8W/Dzf4rS842EtfCYrNuB4BqqtbNkRbQ9/fvLkII1teivkxN7uNV2QT
	 zFNQBwr+dOYSKMAnqauYNkohyg6Om7R9NkONYRjlBjXSjJDKtv0xGE4W8h9va1l6w9
	 jNMPI/L2NCezw==
Date: Mon, 24 Feb 2025 17:03:41 -0800
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
	ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [PATCH v7 3/7] mseal, system mappings: enable x86-64
Message-ID: <202502241703.10E2F5926F@keescook>
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

I think these (in all patches) were supposed to be reworked without the
"vm_flags" variable addition?

-- 
Kees Cook
