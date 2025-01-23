Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF161E49B;
	Thu, 23 Jan 2025 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593861; cv=none; b=p5xsB77D2YbMYwT2kRaawNm2OnNgzrf43XK8/GmGiZ0hHc2kGEb+tUKtlmPCqhVnJwELDktLWTC0TfhBGnFiYAhoeJbw1w7QNlNCuFH7OEfIXnl1605Qo0TIFP5jjYl2VUiUemAFpVJDeO90rL9dGwkJLJKyg4W0gCd9IilGdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593861; c=relaxed/simple;
	bh=3IZ9gXoNl/HLe+ZSOCWj/1mf1cqNCXh92IJ/RCIjrrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtwurBTvra80sU5mTxJ5rSqzkULizBHcjeQ4LQMBSpIgGU87vJrQYHqaE78619YEXQnycd0Znoxa4gOh7Kob/D+3pNy6b9tL7xtRTiXOKKX5rXC4Ejaxyam+SdE3RASkUhcMqxcaKfRQF9lSbyUY/p06g88+C0l6/X/H0wcco/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ+aXal5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ+aXal5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DE7C4CED2;
	Thu, 23 Jan 2025 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737593861;
	bh=3IZ9gXoNl/HLe+ZSOCWj/1mf1cqNCXh92IJ/RCIjrrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQ+aXal5DU1WV4juxX8u17f1Ccf9iUbdsy7iwdnqZzzSDi1oaSn4wqfaroC6e77He
	 Sppxg1AuU0IMUdFdswx8M8AmTIavgRTx1Dl0grnLzZFHu+fAjY34wZ/6Y32ZSoEKxM
	 1RgAEPpNJWXKbaHMcQPI40m3hkPUQft94L0+V/QIfoz6PMYkcXNxysmamAe74L1Ds0
	 hrgcnkicvBM4jIkWA04V3LDuKFiqF90XgUVtNtauHINCO/TRD1dg2XDl6tHkcsC4Mc
	 jkWc6x4EMF4YG0OQpHqyyAPLTyT3uAH6vxxDhiPMI4wf3jfm6oj9v9NMCxR9YxQHF7
	 icYMpY5JJhJZw==
Date: Wed, 22 Jan 2025 16:57:37 -0800
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Daniel Micay <danielmicay@gmail.com>, Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: security: Allow default HARDENED_USERCOPY to be
 set at compile time
Message-ID: <202501221651.3F5A6ACD@keescook>
References: <20250122171925.25472-1-mgorman@techsingularity.net>
 <20250122171925.25472-3-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122171925.25472-3-mgorman@techsingularity.net>

On Wed, Jan 22, 2025 at 05:19:23PM +0000, Mel Gorman wrote:
> HARDENED_USERCOPY defaults to on if enabled at compile time. Allow
> hardened_usercopy= default to be set at compile time similar to
> init_on_alloc= and init_on_free=. The intent is that hardening
> options that can be disabled at runtime can set their default at
> build time.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 4 +++-
>  mm/usercopy.c                                   | 3 ++-
>  security/Kconfig.hardening                      | 8 ++++++++
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3872bc6ec49d..5d759b20540a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1773,7 +1773,9 @@
>  			allocation boundaries as a proactive defense
>  			against bounds-checking flaws in the kernel's
>  			copy_to_user()/copy_from_user() interface.
> -		on	Perform hardened usercopy checks (default).
> +			The default is determined by
> +			CONFIG_HARDENED_USERCOPY_DEFAULT_ON.
> +		on	Perform hardened usercopy checks.
>  		off	Disable hardened usercopy checks.
>  
>  	hardlockup_all_cpu_backtrace=
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 83c164aba6e0..4cf33305347a 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -255,7 +255,8 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
>  }
>  EXPORT_SYMBOL(__check_object_size);
>  
> -static bool enable_checks __initdata = true;
> +static bool enable_checks __initdata =
> +		IS_ENABLED(CONFIG_HARDENED_USERCOPY_DEFAULT_ON);
>  
>  static int __init parse_hardened_usercopy(char *str)
>  {
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 9088d613d519..adcc260839c7 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -293,6 +293,14 @@ config HARDENED_USERCOPY
>  	  or are part of the kernel text. This prevents entire classes
>  	  of heap overflow exploits and similar kernel memory exposures.
>  
> +config HARDENED_USERCOPY_DEFAULT_ON
> +	bool "Harden memory copies by default"
> +	depends on HARDENED_USERCOPY
> +	default n

This must be "default HARDENED_USERCOPY" or existing distro builds will
break. All major distros enable this by default, and I don't want to
risk HARDENED_USERCOPY_DEFAULT_ON getting missed and getting globally
disabled.

> +	help
> +	  This has the effect of setting "hardened_usercopy=on" on the kernel
> +	  command line. This can be disabled with "hardened_usercopy=off".
> +
>  endmenu
>  
>  menu "Hardening of kernel data structures"

-Kees

-- 
Kees Cook
