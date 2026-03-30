Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C4331A5E;
	Mon, 30 Mar 2026 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914623; cv=none; b=lM3vXJTKNhoJZoD92ZFGHpXvbsuoGYJoIDPVkpc2O2IQAb5QZyYtIQvKM1f5RgbesqUgvAzZAmndNMm9JpnS1TKeDh1xAX1iIOAAXk1sI2Muv88NMfYhcbXlQZ3m/J/RH5MxRBhHseehoXSoOVkTNdNLgkX7ifbangg0OEpsQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914623; c=relaxed/simple;
	bh=S8TvrXXYbTGdUmf8zAYnrXIAtiQEMKVDFz9XcPyEtlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acDk2RlJR8W7O2AOUxlgf++93O2kvKElGdgTRa5iCMDaM6HnREBFiIQ0lnSJiG1i1oIT4l+L+YbS6lXARCYJspWT3RDt8OpA0urqgCZrHz/6MyqtCPrKJu2aQJvFrFDb87LjeyLrDZW6HHAsRMxKbezfOfTFXQJZ6o11UXqdjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwemHsxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwemHsxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CA3C19423;
	Mon, 30 Mar 2026 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774914622;
	bh=S8TvrXXYbTGdUmf8zAYnrXIAtiQEMKVDFz9XcPyEtlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwemHsxFpu99wMUqJdaf4jby/tkKZwLpQEghjbfbbuqeaTURLIb7ciN1vpYKZ2GG4
	 jx8Uho1mGDLTpnPWU4Tmjta1wGidYm2g1w7DE0DglYZUTDF2J0IYDIQ4oW2EMTfB3u
	 teXm2nM0dqbH+5N+2GM+8pQtPS1dtb8DkI9Z2BEG+w3NF3GW/KHB+WuzIPg8vNjf/k
	 pIbEpPz9xD56KUzzClYPgyL9QqhcQQQ1/aykMKlV0Br7M5b4QTjwOKLDnOYOvo7YUc
	 hKm/0S0OKeAmYKuhzaAdZ+iEbsoCHW+fvvB93g8LPqjKqaXqAdSQuWQvu4V+wh35t7
	 K2kLjJ1gj6pRw==
Date: Mon, 30 Mar 2026 16:50:22 -0700
From: Kees Cook <kees@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 1/3] fortify: replace __compiletime_lessthan() with
 statically_true()
Message-ID: <202603301649.A136F870E@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
 <20260330132003.3379-2-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330132003.3379-2-david.laight.linux@gmail.com>

On Mon, Mar 30, 2026 at 02:20:01PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> __compiletime_lessthan(a, b) is exactly the same as statically_true(a < b)
> Replace the former by the latter.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

This one is a clear win: I didn't know about statically_true(). This
results in identical code.

I'll pick this one up.

-Kees

> ---
>  include/linux/fortify-string.h | 47 +++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 171982e53c9a..214d237214d5 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -154,11 +154,6 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
>  #define POS0			__pass_object_size(0)
>  #endif
>  
> -#define __compiletime_lessthan(bounds, length)	(	\
> -	__builtin_constant_p((bounds) < (length)) &&	\
> -	(bounds) < (length)				\
> -)
> -
>  /**
>   * strncpy - Copy a string to memory with non-guaranteed NUL padding
>   *
> @@ -196,7 +191,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
>  {
>  	const size_t p_size = __member_size(p);
>  
> -	if (__compiletime_lessthan(p_size, size))
> +	if (statically_true(p_size < size))
>  		__write_overflow();
>  	if (p_size < size)
>  		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p_size, size, p);
> @@ -287,14 +282,14 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
>  	 * If size can be known at compile time and is greater than
>  	 * p_size, generate a compile time write overflow error.
>  	 */
> -	if (__compiletime_lessthan(p_size, size))
> +	if (statically_true(p_size < size))
>  		__write_overflow();
>  
>  	/* Short-circuit for compile-time known-safe lengths. */
> -	if (__compiletime_lessthan(p_size, SIZE_MAX)) {
> +	if (statically_true(p_size < SIZE_MAX)) {
>  		len = __compiletime_strlen(q);
>  
> -		if (len < SIZE_MAX && __compiletime_lessthan(len, size)) {
> +		if (len < SIZE_MAX && statically_true(len < size)) {
>  			__underlying_memcpy(p, q, len + 1);
>  			return len;
>  		}
> @@ -469,12 +464,12 @@ __FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
>  		 */
>  
>  		/* Error when size is larger than enclosing struct. */
> -		if (__compiletime_lessthan(p_size_field, p_size) &&
> -		    __compiletime_lessthan(p_size, size))
> +		if (statically_true(p_size_field < p_size) &&
> +		    statically_true(p_size < size))
>  			__write_overflow();
>  
>  		/* Warn when write size is larger than dest field. */
> -		if (__compiletime_lessthan(p_size_field, size))
> +		if (statically_true(p_size_field < size))
>  			__write_overflow_field(p_size_field, size);
>  	}
>  	/*
> @@ -557,15 +552,15 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  		 */
>  
>  		/* Error when size is larger than enclosing struct. */
> -		if (__compiletime_lessthan(p_size_field, p_size) &&
> -		    __compiletime_lessthan(p_size, size))
> +		if (statically_true(p_size_field < p_size) &&
> +		    statically_true(p_size < size))
>  			__write_overflow();
> -		if (__compiletime_lessthan(q_size_field, q_size) &&
> -		    __compiletime_lessthan(q_size, size))
> +		if (statically_true(q_size_field < q_size) &&
> +		    statically_true(q_size < size))
>  			__read_overflow2();
>  
>  		/* Warn when write size argument larger than dest field. */
> -		if (__compiletime_lessthan(p_size_field, size))
> +		if (statically_true(p_size_field < size))
>  			__write_overflow_field(p_size_field, size);
>  		/*
>  		 * Warn for source field over-read when building with W=1
> @@ -573,8 +568,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  		 * the same time.
>  		 */
>  		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) ||
> -		     __compiletime_lessthan(p_size_field, size)) &&
> -		    __compiletime_lessthan(q_size_field, size))
> +		     statically_true(p_size_field < size)) &&
> +		    statically_true(q_size_field < size))
>  			__read_overflow2_field(q_size_field, size);
>  	}
>  	/*
> @@ -699,7 +694,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
>  {
>  	const size_t p_size = __struct_size(p);
>  
> -	if (__compiletime_lessthan(p_size, size))
> +	if (statically_true(p_size < size))
>  		__read_overflow();
>  	if (p_size < size)
>  		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, p_size, size, NULL);
> @@ -713,9 +708,9 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
>  	const size_t q_size = __struct_size(q);
>  
>  	if (__builtin_constant_p(size)) {
> -		if (__compiletime_lessthan(p_size, size))
> +		if (statically_true(p_size < size))
>  			__read_overflow();
> -		if (__compiletime_lessthan(q_size, size))
> +		if (statically_true(q_size < size))
>  			__read_overflow2();
>  	}
>  	if (p_size < size)
> @@ -730,7 +725,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
>  {
>  	const size_t p_size = __struct_size(p);
>  
> -	if (__compiletime_lessthan(p_size, size))
> +	if (statically_true(p_size < size))
>  		__read_overflow();
>  	if (p_size < size)
>  		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, p_size, size, NULL);
> @@ -742,7 +737,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
>  {
>  	const size_t p_size = __struct_size(p);
>  
> -	if (__compiletime_lessthan(p_size, size))
> +	if (statically_true(p_size < size))
>  		__read_overflow();
>  	if (p_size < size)
>  		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, p_size, size, NULL);
> @@ -755,7 +750,7 @@ __FORTIFY_INLINE void *kmemdup_noprof(const void * const POS0 p, size_t size, gf
>  {
>  	const size_t p_size = __struct_size(p);
>  
> -	if (__compiletime_lessthan(p_size, size))
> +	if (statically_true(p_size < size))
>  		__read_overflow();
>  	if (p_size < size)
>  		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, p_size, size,
> @@ -793,7 +788,7 @@ char *strcpy(char * const POS p, const char * const POS q)
>  		return __underlying_strcpy(p, q);
>  	size = strlen(q) + 1;
>  	/* Compile-time check for const size overflow. */
> -	if (__compiletime_lessthan(p_size, size))
> +	if (statically_true(p_size < size))
>  		__write_overflow();
>  	/* Run-time check for dynamic size overflow. */
>  	if (p_size < size)
> -- 
> 2.39.5
> 

-- 
Kees Cook
