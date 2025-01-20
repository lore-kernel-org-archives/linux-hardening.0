Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB15188A0E;
	Mon, 20 Jan 2025 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737408118; cv=none; b=uBSnIrgrU5KGM9oTgyPrBLWDYdEVjpnch7lNlvvjUgJpTyPhTrocygVZ+g9Pv0gGSsaSJjp/0VKa12nXQ/9c4QC8KbuYQ7P9s8cQVC7tmz4W1Ql+ZnOpYcDZIIz+pKq1DoLISkdvQlbjisPz/cGNl1MrsaZdvCpvKK5rK76E0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737408118; c=relaxed/simple;
	bh=KCO/gIzlf23YfApjs34d0NXSgiVq62DivBkSsyLijps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jva6IOSwLqxPmUAXSAFjwOznmD7uOoDBxjpP1GbnaOFhps66/Nu9SR3zU1tAwNaXtnkw9SylSMr0p9QkICjcSZprINXGslRH7Ymrwtbl3c70/94BSdOeeg++AD7+wTWT7CJy0L0D7gLPDPu8SG/VbRmKojc9YQYI9ArfKMRajnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCYNrIDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCYNrIDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F52C4CEDD;
	Mon, 20 Jan 2025 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737408118;
	bh=KCO/gIzlf23YfApjs34d0NXSgiVq62DivBkSsyLijps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCYNrIDXHQOg33zOoDeTJxe9gYTSE5wPBl6w9G9GyBtzkM3SgExIBtpzgsiRghYIX
	 PWxhmD5UiPb4HytNg2gZvjbmWs/zda3GDNyEvay+QvPqIxtUhwRgs2+KkM4np9fl2a
	 GBlEACBbAKRbgim73Yr8kDYjFQ5EctQTViRc46NW8zXzhiwsNoVjqCW5fiVjVZWxzb
	 k2BxvDQxyV1a6y7CFS8KvzX66XP5S3h3gMddkvgC3A4xgnDtbX3PSXy9VaRvOHcrHh
	 RQG8zZE9E6fHGeuuYh8K2/7i1zIuTdQ/F7LgsXTQr+fnJljZkd0VGrslp7mg2Y+0at
	 0zPd1VNJoNUkA==
Date: Mon, 20 Jan 2025 13:21:54 -0800
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Daniel Micay <danielmicay@gmail.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: security: Allow default HARDENED_USERCOPY to be
 set at compile time
Message-ID: <202501201311.C67EEFBD7F@keescook>
References: <20250117130337.4716-1-mgorman@techsingularity.net>
 <20250117130337.4716-3-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117130337.4716-3-mgorman@techsingularity.net>

On Fri, Jan 17, 2025 at 01:03:36PM +0000, Mel Gorman wrote:
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

With the addition of the compile-time default, we can also provide
better hot-path hinting for the static branches (likely as a separate
patch), that would rename "bypass_usercopy_checks" to
"perform_usercopy_checks" to avoid confusing negatives, and then:

DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
			   perform_usercopy_checks);

and then adjust set_hardened_usercopy:

static int __init set_hardened_usercopy(void)
{
        if (enable_checks)
                static_branch_enable(&perform_usercopy_checks);
	else
                static_branch_disable(&perform_usercopy_checks);
        return 1;
}

and finally adjust __check_object_size:

        if (!static_branch_maybe(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
				 &perform_usercopy_checks))
                return;

But if the perf difference isn't measurable (it's probably lost to the
cost of doing the checks), this change isn't needed at all, but would
fully duplicate the logic used for init_on_alloc etc.

>  
>  static int __init parse_hardened_usercopy(char *str)
>  {
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 00e6e2ed0c43..537a6431892e 100644
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

To avoid regressions for people moving their configs forward (and IMO
get the right setting by default), I think this should instead be
"default HARDENED_USERCOPY".

> +	help
> +	  This has the effect of setting "hardened_usercopy=on" on the kernel
> +	  command line. This can be disabled with "hardened_usercopy=off".
> +
>  endmenu
>  
>  menu "Hardening of kernel data structures"
> -- 
> 2.43.0
> 

Otherwise looks good!

-- 
Kees Cook
