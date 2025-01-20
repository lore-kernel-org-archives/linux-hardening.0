Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2F1EE029;
	Mon, 20 Jan 2025 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737408357; cv=none; b=rfFE4twwOUqYvQjlpsNvt9B9JAlUfDhmi7tV9ZnoplpO/WDxxN0II/SRyA35HTGJWuUoMawXpYUhXBYUBRSe4DpzXpQEojphTlRQp1/Li9jyAgqLXZLjhTuH59bz3J4G8JrOPfZmVWS5H80X4aOQtSjT48ubUXqnU096GUr0MiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737408357; c=relaxed/simple;
	bh=8s8Fd6Qp//qutlU5hE9152IVPfZKvxoJLfFUmw1PogY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmZC0AYhJ/LGBZQ6sBjLqCeanKb+NopKvOCeQ5NlbACTuEFd1CvalbwitQBB9Mmjf/Ri6vAFsdxFoLRNWa56xGlFuMq9PvdfOQDKIC6uIqSH4zteTONnaw8IMlZscNFH50ZqZC5NDVdkfdDnjbr/+z/8i0QK1G6ilXCIMHUKA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPg7+hs+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPg7+hs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB1CC4CEDD;
	Mon, 20 Jan 2025 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737408357;
	bh=8s8Fd6Qp//qutlU5hE9152IVPfZKvxoJLfFUmw1PogY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPg7+hs+4gYOHWCGg6X5tq7mc7MK8XtthG8sKJgoQKM3UmkqonCx1Ei0gCqUeCjVR
	 Iko9iWOEzGwfKPN3mZvai7XHmPYnL8FBg32Klh++e4v+PVhapjg9f4B5k6UNGrqBeO
	 RdRES5jFKAlXcuP2+f7wf2EHtqYcUCfwRMIGx4vlPP6dXoemRM+wFBrMpHP9jXxSfG
	 x9XErTV6OocZZPyokvcypjqujNNscUPfjkPyHQdqZDLOo0/qPef2DU7VTGZZhACEmu
	 yzgaZ1x9cE+wOrEl9C6J9NKEcYaBmukkXFlzRo0P9491tluqasFOlA++2Y2zl2ij7g
	 GWYRCdGvePhHA==
Date: Mon, 20 Jan 2025 13:25:54 -0800
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Daniel Micay <danielmicay@gmail.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] fortify: Move FORTIFY_SOURCE under 'Kernel hardening
 options'
Message-ID: <202501201324.AE24A0C67@keescook>
References: <20250117130337.4716-1-mgorman@techsingularity.net>
 <20250117130337.4716-4-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117130337.4716-4-mgorman@techsingularity.net>

On Fri, Jan 17, 2025 at 01:03:37PM +0000, Mel Gorman wrote:
> FORTIFY_SOURCE is a hardening option both at build and runtime. Move
> it under 'Kernel hardening options'.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  security/Kconfig           | 9 ---------
>  security/Kconfig.hardening | 9 +++++++++
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index fe7346dc4bc3..bca84f839fbe 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -159,15 +159,6 @@ config LSM_MMAP_MIN_ADDR
>  	  this low address space will need the permission specific to the
>  	  systems running LSM.
>  
> -config FORTIFY_SOURCE
> -	bool "Harden common str/mem functions against buffer overflows"
> -	depends on ARCH_HAS_FORTIFY_SOURCE
> -	# https://github.com/llvm/llvm-project/issues/53645
> -	depends on !CC_IS_CLANG || !X86_32
> -	help
> -	  Detect overflows of buffers in common string and memory functions
> -	  where the compiler can determine and validate the buffer sizes.
> -
>  config STATIC_USERMODEHELPER
>  	bool "Force all usermode helper calls through a single binary"
>  	help
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 537a6431892e..8d005fe154ef 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -301,6 +301,15 @@ config HARDENED_USERCOPY_DEFAULT_ON
>  	  This has the effect of setting "hardened_usercopy=on" on the kernel
>  	  command line. This can be disabled with "hardened_usercopy=off".
>  
> +config FORTIFY_SOURCE
> +	bool "Harden common str/mem functions against buffer overflows"
> +	depends on ARCH_HAS_FORTIFY_SOURCE
> +	# https://github.com/llvm/llvm-project/issues/53645
> +	depends on !CC_IS_CLANG || !X86_32
> +	help
> +	  Detect overflows of buffers in common string and memory functions
> +	  where the compiler can determine and validate the buffer sizes.
> +
>  endmenu

Please move this before HARDENED_USERCOPY -- it's a more general config
and also comes first alphabetically. ;)

I would note that the LLVM bug referenced was fixed in Clang 15+, a
separate patch (not required by you) should fix that if it the tests
actually pass on x86_32 again...

>  
>  menu "Hardening of kernel data structures"
> -- 
> 2.43.0
> 

-Kees

-- 
Kees Cook
