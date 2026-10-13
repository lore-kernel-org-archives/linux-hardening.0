Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C1471D05;
	Tue, 13 Oct 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862211; cv=none; b=K4tHStxQ9vnCucY5/Tz+uhnkUXwH1BGuSVzhZtODtsIzUfFELUyl0eCpfiwPVkR9OTzl4a1qSbNSxC2eeZjQXASJ8HSwxU3+45UskrFf4A2Gs20m4h3HxGCm7yw6vKvRNlQ+gNH2YP0sZRvoCDsHAhlyaYRfaLWMfudrh74BXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862211; c=relaxed/simple;
	bh=4Qef8mw9B/3SyBaLqPmU6dpj0xf6m3vhFa9+oju2XUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OphKkrdYH3TT76IoAa+qoqkIZVWppueLg7+DyZHTbx2r/JBrdcxO9IfvOmhbVFT/vfxSGBmQyG/vxasCTIQEIuYgavQVYTFlkidEdPYdE5ZGM3u0urOrKEi19ousChIFkyY2DyGTWwTSgZnCAaIIyPRym6yMaNb2DyJwZ7/027s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APIUhXsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APIUhXsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ECB1F000FF;
	Tue, 13 Oct 2026 03:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791862210;
	bh=4bIhRUB5qYXPPx9rnaic+yeUzHv9NR67/mntjeyjQlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=APIUhXsNDCB5dA/RZy8qU0syLou5dggMFD+Ki0LiKZP3OTcTd3M2JvqA1VajCdY1Q
	 dnWxQw8XwtTBPfnhJ7yKjyqGwYfi2tS5imcMh8k++7coWppCTsbCGRvIbfSjH3Io4c
	 q+1k2LRslVadompWVSQnkRC98FS3HDz5fn5ySVUYhSMdgLQrm2Zx48oHdMpTTq7Kah
	 Z5Cu9Dj267RwRHY4SU8hjS1+UqKKGS3AGeuZEVAbLmJZvEKAClzY6fdUHUNcWzUANW
	 vfX3NE/syhQ1d91b0nkoHGWkOzNoVOZ3XFs9eSIyZw6DFRwvGv2dZeHI7MoOiRiSWg
	 NwLmLo8A85QEA==
Date: Mon, 12 Oct 2026 20:30:10 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Match arithmetic in both parts of
 __builtin_choose_expr
Message-ID: <202610122028.BB0EDC98@keescook>
References: <20261012205919.4012405-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012205919.4012405-1-morbo@google.com>

On Mon, Oct 12, 2026 at 08:59:19PM +0000, Bill Wendling wrote:
> The two parts of the '__builtin_choose_expr()' had different arithmetic
> expressions. This patch correct it so that both parts calculate:
> 
>   COUNT * sizeof(*MEMBER) + __must_be_array(MEMBER)
> 
> In practice, the call to '__must_be_array' is meant to assert if
> 'MEMBER' isn't an array and return '0' otherwise. However, symmetry is
> less prone to subtle errors (and far more satisfying).
> 
> Fixes: 230f6fa2c1db ("overflow: Provide constant expression struct_size")

A Fixes trailer implies a bug being solved. What problem is there here?
I only see downsides to this change: this adds even more layers of
macros and inlinings to gain the size_add() for a constant integer 0.

?

> -		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
> +		size_add(size_mul(count, sizeof(*(p)->member)),		\
> +			 __must_be_array((p)->member)))

-- 
Kees Cook
