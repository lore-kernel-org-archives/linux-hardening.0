Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083533F9;
	Thu, 23 Jan 2025 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594085; cv=none; b=c29G6XndJNcOg2BS+/9QvZZmVBDE858NFQ0pMCLL7votDItvgI8aiC4Z4SWTrvTebm+KsUCdswIID2TxCGeDiLm7t1bWc+5MpL7yAi9W/kwbMavGHIVyvMQbvHgny0v5V70+Sxa1IvHq6l1nyvX1jcPGZHeTaXja1a8ADOH5xY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594085; c=relaxed/simple;
	bh=FzTDNqwA3Pthmmg1rBKFrLjwzrfQE9uSIA/nSnLLkuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUyMb0ZWWN4UUEFY/V0JPgg51eX0VFwhpWT+z2GVlFL9BcDeizArfyIokodJmJHkhb0FOZhiaKvEr7vz48JSruay2FufBdtvm+RJK8/p+ioxVUtoRLW9vTs+k5zYoBs/VlEOvdo6Y7vj2ieIYU6OtdJHUhq2Tw0VCy46NczwsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYuJgqRJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYuJgqRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C8BC4CED2;
	Thu, 23 Jan 2025 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737594085;
	bh=FzTDNqwA3Pthmmg1rBKFrLjwzrfQE9uSIA/nSnLLkuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYuJgqRJyJptzMSHVAxj5PHzIeUJEdLJFb1hGn3I3qX9zscU1M5YJFwz4QzFzzcUL
	 3X1Lv0ngVePf0CsqklohPHOcaKhQDmUAxfOVh7TfugZ3R5zys64J8BycM9GtlMjCex
	 j1SMSW1WHoNqaq0sdxgs4zvpQ9o+SJc4PgRRImKKguVJO7tXkvXBXXJvIxH6ma+c5Q
	 HFQ/ACyGcNRaFlO0c6IrwnOcMfApmidLN6h9x3Fs32eqehCqz0hu9Fht32Xez3vHaR
	 mPkK4lWCumzY0XZ/H5HsKjGFGgVj0rtTeLPUZCGVneY2EkaMq6Yv4KmiN6dQObWb6h
	 8Qi9ZShpl5IVg==
Date: Wed, 22 Jan 2025 17:01:21 -0800
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Daniel Micay <danielmicay@gmail.com>, Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: security: Check early if HARDENED_USERCOPY is
 enabled
Message-ID: <202501221657.E657471E6B@keescook>
References: <20250122171925.25472-1-mgorman@techsingularity.net>
 <20250122171925.25472-4-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122171925.25472-4-mgorman@techsingularity.net>

On Wed, Jan 22, 2025 at 05:19:24PM +0000, Mel Gorman wrote:
> HARDENED_USERCOPY is checked within a function so even if disabled, the
> function overhead still exists. Move the static check inline.
> 
> This is at best a micro-optimisation and any difference in performance
> was within noise but it is relatively consistent with the init_on_*
> implementations.
> 
> Suggested-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/thread_info.h |  8 ++++++++
>  mm/usercopy.c               | 11 ++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index cf2446c9c30d..832f6a97e64c 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -221,9 +221,17 @@ static inline int arch_within_stack_frames(const void * const stack,
>  extern void __check_object_size(const void *ptr, unsigned long n,
>  					bool to_user);
>  
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
> +			   validate_usercopy_range);

This should be DECLARE_STATIC_KEY_MAYBE_RO()

>  static __always_inline void check_object_size(const void *ptr, unsigned long n,
>  					      bool to_user)
>  {
> +	if (static_branch_maybe(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
> +				&validate_usercopy_range)) {
> +		return;
> +	}
> +
>  	if (!__builtin_constant_p(n))
>  		__check_object_size(ptr, n, to_user);
>  }

This is accidentally correct ("if validate, skip" matches "if not
enabled, disable validation" below, but is very confusing. Also, yes,
this is good to be moved into the inline, but let's wrap it in the
compile-time __builtin_constant_p() check:

static __always_inline void check_object_size(const void *ptr, unsigned long n,
					      bool to_user)
{
	if (!__builtin_constant_p(n) &&
	    static_branch_maybe(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
				&validate_usercopy_range))
		__check_object_size(ptr, n, to_user);
}

> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 4cf33305347a..2e86413ed244 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -201,7 +201,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
>  	}
>  }
>  
> -static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
> +DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_HARDENED_USERCOPY_DEFAULT_ON,
> +			   validate_usercopy_range);
> +EXPORT_SYMBOL(validate_usercopy_range);
>  
>  /*
>   * Validates that the given object is:
> @@ -212,9 +214,6 @@ static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
>   */
>  void __check_object_size(const void *ptr, unsigned long n, bool to_user)
>  {
> -	if (static_branch_unlikely(&bypass_usercopy_checks))
> -		return;
> -
>  	/* Skip all tests if size is zero. */
>  	if (!n)
>  		return;
> @@ -271,7 +270,9 @@ __setup("hardened_usercopy=", parse_hardened_usercopy);
>  static int __init set_hardened_usercopy(void)
>  {
>  	if (enable_checks == false)
> -		static_branch_enable(&bypass_usercopy_checks);
> +		static_branch_enable(&validate_usercopy_range);
> +	else
> +		static_branch_disable(&validate_usercopy_range);

This should be:

	if (enable_checks)
		static_branch_enable(&validate_usercopy_range);
	else
		static_branch_disable(&validate_usercopy_range);

>  	return 1;
>  }
>  
> -- 
> 2.43.0
> 

-- 
Kees Cook
