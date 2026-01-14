Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159D17BA2;
	Wed, 14 Jan 2026 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348915; cv=none; b=DBaXvDESKAzYxQCIiHvT1je0QV4PCWPzWthFw+ZRhL3N1wSNzk7/4E1Y6wKDSIx2aViGVM/4knTDK7AJf3GGr5gSg4TWqMb8q5zY3Q+U3E5W1ZqymLYdgAU7M5D3058a53x3Hh2r/wZMcYP6YSuR7AcjXnila1FdyaHZY4BYPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348915; c=relaxed/simple;
	bh=W4YTayVf5TSDAo17cT/laWi8gi0U4yzOg65DXbHoELs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6aH/Rhzs011H3l2+ofk8dHWhw5WwAGIGpSh0ElaeeXAoopGepXoyK3jN005BqJoiJGNJ4kUIScDw2cGPI3VmQkyqpqv8wvcikiHDIhhtpsSVeK3ycjjDJlc7VNssyTjmnAavTdBWAVSyRGV/SjECyQx/lYqiHpfJ2uOh/mauXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahdkftaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahdkftaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254C0C116C6;
	Wed, 14 Jan 2026 00:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768348914;
	bh=W4YTayVf5TSDAo17cT/laWi8gi0U4yzOg65DXbHoELs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahdkftaFqK4uMfGQdz/e2IHOoadYaTllC2J5d9XW8nQ1p3xYdPdQL6zj56xTNqfCL
	 j5DuRiACpVcwieg2H0K2Cm53iU9WFhdFrYRnwkNQ+RfPwHWFPLDXsuwfUoUqpGjmYR
	 xPTxEWPM9a6W1vkPt5NS7NFomqBhSrnp1r4FEU7IOLdMqEXjTOVitHarLpgCI9I+Gq
	 AeHqSEatU5Gx9zrTjfOTavEpB4Gy3qlvUe8iVOBXOt68yFC4JR1pwVB6AiuXU1ANvb
	 377JEOoXpUHs5ZXvY1J49dhF1c+upxhHZSC7Hpw1nHEs0WqrNcuwGTGYA5c4sR7VyC
	 vYhD0Vro8LMZQ==
Date: Tue, 13 Jan 2026 16:01:51 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, kees@kernel.org, andy@kernel.org,
	akpm@linux-foundation.org, martin.petersen@oracle.com,
	ardb@kernel.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, samuel.holland@sifive.com,
	linus.walleij@linaro.org, nathan@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 01/14] lib/string: extract generic strlen() into
 __generic_strlen()
Message-ID: <20260114000151.GB2178@quark>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-2-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082748.250916-2-jiangfeng@kylinos.cn>

On Tue, Jan 13, 2026 at 04:27:35PM +0800, Feng Jiang wrote:
> To support performance benchmarking in KUnit tests, extract the
> generic C implementation of strlen() into a standalone function
> __generic_strlen(). This allows tests to compare architecture-optimized
> versions against the generic baseline without duplicating code.
> 
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 1b564c36d721..961645633b4d 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -197,6 +197,7 @@ extern char * strstr(const char *, const char *);
>  #ifndef __HAVE_ARCH_STRNSTR
>  extern char * strnstr(const char *, const char *, size_t);
>  #endif
> +extern __kernel_size_t __generic_strlen(const char *);
>  #ifndef __HAVE_ARCH_STRLEN
>  extern __kernel_size_t strlen(const char *);
>  #endif
> diff --git a/lib/string.c b/lib/string.c
> index b632c71df1a5..047ecb38e09b 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -412,8 +412,7 @@ char *strnchr(const char *s, size_t count, int c)
>  EXPORT_SYMBOL(strnchr);
>  #endif
>  
> -#ifndef __HAVE_ARCH_STRLEN
> -size_t strlen(const char *s)
> +size_t __generic_strlen(const char *s)
>  {
>  	const char *sc;
>  
> @@ -421,6 +420,13 @@ size_t strlen(const char *s)
>  		/* nothing */;
>  	return sc - s;
>  }
> +EXPORT_SYMBOL(__generic_strlen);
> +
> +#ifndef __HAVE_ARCH_STRLEN
> +size_t strlen(const char *s)
> +{
> +	return __generic_strlen(s);
> +}
>  EXPORT_SYMBOL(strlen);

A similar problem exists with the architecture-optimized CRC and crypto
functions.  Historically, these subsystems exported both generic and
architecture-optimized functions.

We've actually been moving away from that design to simplify things.
For example, for CRC-32C there's now just the crc32c() function which
delegates to the "best" CRC-32C implementation, with no direct access to
the generic implementation of CRC-32C.

crc_kunit then just tests and benchmarks crc32c().  To check how the
performance of crc32c() changes when its implementation changes (whether
the change is the addition of an arch-optimized implementation or a
change in an existing arch-optimized implementation), the developer just
needs to run crc_kunit with two kernels, before and after.

I suggest just doing that.  In that case there would be no need to
export the generic implementations of these functions.

(Also note that *if* the generic functions are exported, they probably
should be exported only when the KUnit test is enabled.  There's no need
to include them in the kernel image when the test isn't enabled.)

- Eric
