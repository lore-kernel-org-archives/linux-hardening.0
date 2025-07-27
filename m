Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527221A426;
	Sun, 27 Jul 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631494; cv=none; b=Xrd46ikV/qOytNzBnf2jI1FPX9GEyskNKz/Ceuzk2ERZMGUvg7wvZmxe1piqmvFjoGWIMYceWMUhotSAWh2r6imRlnVxaAvS6cn5tdUY+2WVhB0JE8XZc5kOyPgDICREm2CH9E+yJ4GQIR8k05L6KOfLMQvv2H+QT381faJUtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631494; c=relaxed/simple;
	bh=urSz8rDjHicplSAJE4AaaacmFFB9vhHitFdGRexF+Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA8e3tYDTVQjiiytjIl1c0Sa9ca1Hwhag/7UMMET8U2APGf09z8sN84qogBqcZoJcmYpg4k9cL57h0pJMETokD3una1b6/Y4tRh+pJ0bCh8TzZdm2Hjj2aep1zIFsba8NVQIySD9MeO/2n8BBmg9A9CsRiNWCFMvc1ifcaL5Ofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEv2fiBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEv2fiBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9048AC4CEEB;
	Sun, 27 Jul 2025 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753631494;
	bh=urSz8rDjHicplSAJE4AaaacmFFB9vhHitFdGRexF+Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEv2fiBJkYIyzGlsYaAusnzNXOeYUW5CIbDSHmdtJeMD1Dvn0gKzzDRepbR9UDKYy
	 LS64k2JAePhCkvobAkNBCymLoVlFhj2TOO+8XobA9L7Au1AVeh5rgIPn0DbbBTdAOB
	 A/27xUSr3bYrwTTke3Em3yOluDzyOBmhFsb6qg3H1ikNvLnvuyZBEdBzOTikk8Gah+
	 R9nI8xZuwAErYAhU7Eu+ysMHXtsIsd3RRnwQFCrdQQdE2PLufiqN2nJ9BC0/iJ+k3n
	 dYE+6QBS36I02VhVy/zzZ5qFOAuLQC/lZ6iZTDsIZbRWdVh9eqj5RSfS8y3RwtdMYE
	 8E4VgmpNe2J6A==
Date: Sun, 27 Jul 2025 08:51:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kstack_erase: Disable kstack_erase for all of arm
 compressed boot code
Message-ID: <20250727155129.GC1183915@ax162>
References: <20250726212945.work.975-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726212945.work.975-kees@kernel.org>

On Sat, Jul 26, 2025 at 02:29:45PM -0700, Kees Cook wrote:
> When building with CONFIG_KSTACK_ERASE=y and CONFIG_ARM_ATAG_DTB_COMPAT=y,
> the compressed boot environment encounters an undefined symbol error:
> 
>     ld.lld: error: undefined symbol: __sanitizer_cov_stack_depth
>     >>> referenced by atags_to_fdt.c:135
> 
> This occurs because the compiler instruments the atags_to_fdt() function
> with sanitizer coverage calls, but the minimal compressed boot environment
> lacks access to sanitizer runtime support.
> 
> The compressed boot environment already disables stack protector with
> -fno-stack-protector. Similarly disable sanitizer coverage by adding
> $(DISABLE_KSTACK_ERASE) to the general compiler flags (and remove it
> from the one place it was noticed before), which contains the appropriate
> flags to prevent sanitizer instrumentation.
> 
> This follows the same pattern used in other early boot contexts where
> sanitizer runtime support is unavailable.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYtBk8qnpWvoaFwymCx5s5i-5KXtPGpmf=_+UKJddCOnLA@mail.gmail.com
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20250726004313.GA3650901@ax162
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm/boot/compressed/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index f9075edfd773..a159120d1e42 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -9,7 +9,6 @@ OBJS		=
>  
>  HEAD	= head.o
>  OBJS	+= misc.o decompress.o
> -CFLAGS_decompress.o += $(DISABLE_KSTACK_ERASE)
>  ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
>  OBJS	+= debug.o
>  AFLAGS_head.o += -DDEBUG
> @@ -96,6 +95,7 @@ KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  
>  ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
>  	     -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
> +	     $(DISABLE_KSTACK_ERASE) \
>  	     -I$(obj)
>  ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
>  asflags-y := -DZIMAGE
> -- 
> 2.34.1
> 
