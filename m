Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C592DCC07;
	Wed, 28 May 2025 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748467949; cv=none; b=sz8HHGfDS8MaGYcY0IO173TEOFNdeWcW5sJtv+mvLnlvhAlxkYouf0vz+fPrm9+szRcyK60YYh3YGc+obP0UwFdXdMeEnWPNoIjFWWwUZudQmHP0fl39ovToP3dIl4NSNE9az5y9vFVLDrxI0xL75E4d0U41bPGHJOJKK63bPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748467949; c=relaxed/simple;
	bh=k1uGfz08eTAbpykTbdoMZWrusskWSVO4QedSWOoPJLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKs0CkDPOnit6qQkJgQQyN6NmsHH+Y9l/86cbPLfNnDt7DyCZ7wIt5jn8kgvJ2TjKdZKo1TY0IeUBkiQmMrGPqPgV4DLhV5eb21ur9qW3tO0SiF29Bgzy3qSdIHUQsaAIeLzAFXzCDbQDHNteOXQSw6cXcvvc0oJEEB2bszkxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph16VZd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph16VZd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F59C4CEE3;
	Wed, 28 May 2025 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748467948;
	bh=k1uGfz08eTAbpykTbdoMZWrusskWSVO4QedSWOoPJLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ph16VZd8x8KAjTQxonH/32Sn9Kljc1Y6K57i6hLtxNo4oVq7ZyqTKMTXTczXruzze
	 8uOfAJUhfhp7+3DUgNFDNh6fiY0SCitmoEIzhBuIRgY/BgUSZjQZxo0hWNitQCMIzi
	 4RTncsQS3mPzASM/SmvoerbWeooZZwiBr/cynaenmV94bAqZdRvN5kxSb4kLajD75B
	 33GC9EDLd0zeZX9FhNAYUfpX5s8UpSY5EgCoyZ5euOkI3AJkViQKXXibKYMki5XjUT
	 FAwg0j+UZMbYfHj06LRsoPqtkFLQcV6YMx0waQ/ypJqScvU2J4O/px4GvqwzIYs8Vu
	 NOpsb7NXXEXqg==
Date: Wed, 28 May 2025 14:32:23 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: integer-overflow: depend on BROKEN to keep this
 out of CI
Message-ID: <20250528213223.GA3885532@ax162>
References: <20250528182616.work.296-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528182616.work.296-kees@kernel.org>

On Wed, May 28, 2025 at 11:26:22AM -0700, Kees Cook wrote:
> Depending on !COMPILE_TEST isn't sufficient to keep this feature out of
> CI because we can't stop it from being included in randconfig builds.
> This feature is still highly experimental, and is developed in lock-step
> with Clang's Overflow Behavior Types[1]. Depend on BROKEN to keep it
> from being enabled by anyone not expecting it.
> 
> Link: https://discourse.llvm.org/t/rfc-v2-clang-introduce-overflowbehaviortypes-for-wrapping-and-non-wrapping-arithmetic/86507 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Should this have a 'Cc: stable@vger.kernel.org' on it? There might not
be much randconfig testing on stable but it is still very much possible
for some random user to turn this on and report problems.

Regardless of that though, I think this is a good idea with how much of
this feature is still being ironed out.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Once this lands, I plan to mark all issues in the CBL issue tracker that
came about from UBSAN_INTEGER_WRAP as 'have a workaround applied' since
it will not be possible for regular users to hit them but you may
consider notating them in case they need to be addressed before the
feature can be reenabled.

> ---
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: llvm@lists.linux.dev
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  lib/Kconfig.ubsan | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index f6ea0c5b5da3..96cd89668467 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -118,6 +118,8 @@ config UBSAN_UNREACHABLE
>  
>  config UBSAN_INTEGER_WRAP
>  	bool "Perform checking for integer arithmetic wrap-around"
> +	# This is very experimental so drop the next line if you really want it
> +	depends on BROKEN
>  	depends on !COMPILE_TEST
>  	depends on $(cc-option,-fsanitize-undefined-ignore-overflow-pattern=all)
>  	depends on $(cc-option,-fsanitize=signed-integer-overflow)
> -- 
> 2.34.1
> 
> 
