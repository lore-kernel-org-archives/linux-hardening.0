Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10C1D6195;
	Wed, 28 May 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457684; cv=none; b=iY8aLj4ZotueLFyTn0VmOzoRaudIXMeX/g+H7w2jaq4ewk4cS9WkprHkzTi1a4oojiGTygu3p8mbQ4fVkWZxJimVCfILILB8TXyQ1AXd+QoNdEiHUH0y25fqdY4XKR0+ym3nmf5+OGuyCSJ2G9wROAiWpsWKrX+qU6tcxnz3J7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457684; c=relaxed/simple;
	bh=88jiFbiWXxQjEfk75aIqQJTC9S1U6V82qnd2mDX5eMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awUDbmmbxCkdMem3kjScyuSQqoshwMiy6/Kyw+CSH8J0YeaEjI7x/zBRheRnEURwMAiSvPwSZfvMkEvXsWbXn55QGPD3LpEnATX4aP8z//Dv9ivX6IeqX5xaLphD7q/BysQeo81uYSrL4eSkUqRYorW4X6FAEbYwMIH/7cpStmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh6TZtd4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh6TZtd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4A0C4CEE3;
	Wed, 28 May 2025 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748457684;
	bh=88jiFbiWXxQjEfk75aIqQJTC9S1U6V82qnd2mDX5eMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fh6TZtd4BwJ3gLtPi8bJX8vPFi9xo9xpHxwyoq7/9vtewCDoK6lC1nC1BHLIfla8a
	 OsAKxOkT+YhG4xRB8DEIDVr9Zt8kJODv+Ziu/qOKaWZ3fBpW+Uh5TpnVyEWwgfn1hl
	 N6krXmCs/aqFhSGFMAB3QzC1PkSggKoQjdSifltnRgqNoev2cfp3Iqhoyo4QY4kQ9a
	 QCtK+WGzPaAuzUEiXI0ZiFYuEwW5dggEHNsDxmDFhuWVuyhCCu8OCR7TQC0SD6d6CT
	 m2LLINfQEqJ492dXNnIZZoWerPGneY2A+8koINbV2hkhYRGNmJUizUcw6tqZkgLXIB
	 fCKUk6v46UIyg==
Date: Wed, 28 May 2025 18:41:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: integer-overflow: depend on BROKEN to keep this
 out of CI
Message-ID: <20250528184122.GA1002333@google.com>
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

Acked-by: Eric Biggers <ebiggers@kernel.org>

- Eric
