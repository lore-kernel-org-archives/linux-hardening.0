Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32A17BB21;
	Mon, 12 Jan 2026 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256337; cv=none; b=BLH6rFjJ25+7wGBVD2n6EjAH/TYWJnGDRTLh5bJXXfqsGCI/ams36bGuOj1C1VyiuJvcSFR8qQJoT0/yX++dpacFS+48qPr+z+v+v5ZVrh9857H+mSjTAyYcHuel1lOct2U99mg3ros6KBIHAQwofzUp4HMdAzOJkKn9aKjpZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256337; c=relaxed/simple;
	bh=KyQFdBKjUzO5sPiILeRcWwM71388VJmvQOy/oTHzT6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyP+TJToPEbJz7aaO3CCPJt2GRhuMXpeMMDaLpHwB9Ahsz+taM8laOcJhC3lXtzwUKnGE5T0aMLW4tWzNPFebGSLD1t3E44vql+Lf4wcqzgthVzHMihF/N/CUV10VwHFVz/9YToI6D0EDauwBplzrNRIyd5R/QOB3L3qMt5Y6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0ykvvbX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0ykvvbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D33EC116D0;
	Mon, 12 Jan 2026 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768256337;
	bh=KyQFdBKjUzO5sPiILeRcWwM71388VJmvQOy/oTHzT6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0ykvvbXPAoydDRQijRYesUT6k+Zr6f6EVBDTuwSCiqyvWh2VnUKCU+35FMXtS08t
	 Xycqxo01MyqN6/ADuqpHqJgwVuv4xn7sZj1Bgvf9zTHKRKHiGP2W3gEejJNaAiPW1V
	 WDuKpdqpcY1G6Qo3rQD2nl/h5fYITaIaSivbSkQnbOhdnKpggjUM1VLNoaLhbaCXG6
	 fLNNVDSwWIxPcOHxD8kM4a8kLiGWF5N8seQ7sxCw7O6/4g+JrlXDIEebz4sYmQKgLj
	 6+69yAXLOzPrnUHc8OSEgpLybVUJEsrVzQIU4pTb+TI3wExAps+ERhBAesdeGzPT1d
	 EC/yhEMbONZxQ==
Date: Mon, 12 Jan 2026 14:18:56 -0800
From: Kees Cook <kees@kernel.org>
To: david.laight.linux@gmail.com
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fortify: Use C arithmetic not FIELD_xxx() in
 FORTIFY_REASON defines
Message-ID: <202601121415.CEB3C024@keescook>
References: <20251214125857.3308-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214125857.3308-1-david.laight.linux@gmail.com>

On Sun, Dec 14, 2025 at 12:58:57PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> FIELD_GET() and FIELD_PREP() are mainly useful for hardware register
> accesses, but here they are being used for some very simple oprations.
> 
> This wouldn't matter much, but they contain a lot of compile-time
> checks (that really aren't needed here) that bloat the expansion
> of FIELD_GET(GENMASK(7, 1), func) to over 18KB.
> Even with the 'bloat reduced' FIELD_GET/PREP they are still hundreds of
> characters.
> 
> Replace FIELD_GET(BIT(0), r) with ((r) & 1), FIELD_GET(GENMASK(7, 1), r) with
> (r) >> 1), and (FIELD_PREP(BIT(0), write) | FIELD_PREP(GENMASK(7, 1), func))
> with ((func) << 1 | (write)).
> 
> The generated code is the same, but it makes the .c file less obfuctaced,
> the .i file much easier to read, and should marginally decrease compilation
> time.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> 
> Note that changing 'const u8 reason' to 'const unsigned int reason' generates
> better code - in this case removing 2 instructions (one in each of the called
> functions).
> 
>  include/linux/fortify-string.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index b3b53f8c1b28..171982e53c9a 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -2,7 +2,6 @@
>  #ifndef _LINUX_FORTIFY_STRING_H_
>  #define _LINUX_FORTIFY_STRING_H_
>  
> -#include <linux/bitfield.h>
>  #include <linux/bug.h>
>  #include <linux/const.h>
>  #include <linux/limits.h>
> @@ -10,10 +9,9 @@
>  #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
>  #define __RENAME(x) __asm__(#x)
>  
> -#define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
> -#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
> -#define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
> -					 FIELD_PREP(GENMASK(7, 1), func))
> +#define FORTIFY_REASON_DIR(r)		((r) & 1)
> +#define FORTIFY_REASON_FUNC(r)		((r) >> 1)

Sure, we can do this. I agree, the preprocessor gunk is huge currently.
For the above, how about keeping with the original logic and use:

#define FORTIFY_REASON_FUNC(r)			(((r) & 0xF) >> 1)

> +#define FORTIFY_REASON(func, write)	((func) << 1 | (write))

and:

> +#define FORTIFY_REASON(func, write)	((func) << 1 | (write))

#define FORTIFY_REASON(func, write)	(((func) << 1 | ((write) & 1)) & 0xF)

so we're always getting processing a u8?

-Kees

-- 
Kees Cook
