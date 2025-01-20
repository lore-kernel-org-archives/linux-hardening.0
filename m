Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71327194C78;
	Mon, 20 Jan 2025 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407448; cv=none; b=Tkc4tMkHWUzC0yY7/6INYw/PAPIu2A3vB4iqmN/pwoDj50jorKc7oQ6tg+n6577zxBWTk2t85EIjImlVNW8WTRmOzN3hPwltrdeNpGcNqenNr2fb/HC6oKSB74OCb1eZ8XkawSx6ie7MlC24d19FWD6qG50jtq0vM3RBYsPWAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407448; c=relaxed/simple;
	bh=yUlmELXOb4rfYZ4Rmz94aC92qm8PbhGPnzsTDq1BxQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvC7fuTT0N+HzhMI4Hju8h0UNUgRx/+7a8S4UDnE6gLrguvsLxafJd/BH8KG/9j7pOGhdShr6g0tQjf+4vkbHwXl3d05jM/9pmpB+3Ueg4/wTCkjxHNd2F4m79IEFf75YIGXJku6hnJJwB43BaVj9iA16Ri5fL5vHI+ruglKTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6mRKFVc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6mRKFVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA9C4CEDD;
	Mon, 20 Jan 2025 21:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737407447;
	bh=yUlmELXOb4rfYZ4Rmz94aC92qm8PbhGPnzsTDq1BxQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6mRKFVcVuZylWvDsguiBjATm8aeu65LaE9Ejl4pa0nFvhY6xWUcD9kdxndpB2ami
	 yYwOM4fxGc3Y3wufXBSkdzcqTGgRX1ypSM9Ah4vfBLoeNEB7GdzrlEUq2ddfw72xR9
	 i8y6ObkCQof8LkOAMDB3n6cD/Qd87KajGJNSPa+oFnvOb6FPeuOFq2SD2cAcoN8TnF
	 2Mb8oBZ4n/IYphNTGIWZV4+iXxC6c0nAyWn0u8W+pNaL0Uanln+1vDpgpNNaYS6gC5
	 ut94XJEiSp/f9MegijO1wPZSV8D8zjzff8COp3kEZv/xrS7kG+vMUZaJuFLxu3Reai
	 Ff5BWow/3NiFg==
Date: Mon, 20 Jan 2025 13:10:44 -0800
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Daniel Micay <danielmicay@gmail.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: security: Move hardened usercopy under 'Kernel
 hardening options'
Message-ID: <202501201309.73DA8439B@keescook>
References: <20250117130337.4716-1-mgorman@techsingularity.net>
 <20250117130337.4716-2-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117130337.4716-2-mgorman@techsingularity.net>

On Fri, Jan 17, 2025 at 01:03:35PM +0000, Mel Gorman wrote:
> There is a submenu for 'Kernel hardening options' under "Security".
> Move HARDENED_USERCOPY under the hardening options as it is clearly
> related.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  security/Kconfig           | 12 ------------
>  security/Kconfig.hardening | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 28e685f53bd1..fe7346dc4bc3 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -159,18 +159,6 @@ config LSM_MMAP_MIN_ADDR
>  	  this low address space will need the permission specific to the
>  	  systems running LSM.
>  
> -config HARDENED_USERCOPY
> -	bool "Harden memory copies between kernel and userspace"
> -	imply STRICT_DEVMEM
> -	help
> -	  This option checks for obviously wrong memory regions when
> -	  copying memory to/from the kernel (via copy_to_user() and
> -	  copy_from_user() functions) by rejecting memory ranges that
> -	  are larger than the specified heap object, span multiple
> -	  separately allocated pages, are not on the process stack,
> -	  or are part of the kernel text. This prevents entire classes
> -	  of heap overflow exploits and similar kernel memory exposures.
> -
>  config FORTIFY_SOURCE
>  	bool "Harden common str/mem functions against buffer overflows"
>  	depends on ARCH_HAS_FORTIFY_SOURCE
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index c9d5ca3d8d08..00e6e2ed0c43 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -279,6 +279,22 @@ config ZERO_CALL_USED_REGS
>  
>  endmenu
>  
> +menu "String manipulation"

I think "string" means different things to different people. I'd prefer
"Bounds checking" or "Spatial safety" if it's going to be a separate
menu section.

> +
> +config HARDENED_USERCOPY
> +	bool "Harden memory copies between kernel and userspace"
> +	imply STRICT_DEVMEM
> +	help
> +	  This option checks for obviously wrong memory regions when
> +	  copying memory to/from the kernel (via copy_to_user() and
> +	  copy_from_user() functions) by rejecting memory ranges that
> +	  are larger than the specified heap object, span multiple
> +	  separately allocated pages, are not on the process stack,
> +	  or are part of the kernel text. This prevents entire classes
> +	  of heap overflow exploits and similar kernel memory exposures.
> +
> +endmenu
> +
>  menu "Hardening of kernel data structures"

Otherwise, looks good.

-- 
Kees Cook
