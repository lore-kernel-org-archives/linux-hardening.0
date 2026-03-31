Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36C27FD49;
	Tue, 31 Mar 2026 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937918; cv=none; b=dg6/NPvt/pliycbFX6CCLFJHlxeZwbCWJGUKyrrNWvXK4aEHAjKuTR1wcUHwcJx49vJ5L3GOv1NzZIdzdyjkVIsIBA5hMgd6pBrMTDVtZOjS0tEbfbUCWoct+EqK3eiddRZTTEu7cvtbTOPSIXMOvoJPGM37JQa83N0ZG7NKkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937918; c=relaxed/simple;
	bh=U0Gypix0B1lyS8WO/z9V5SWKJeE4tpw0piwNWZ/hmy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKrW3vEEiMo5Fa+oFugeQiTFhieW7c7qnKy4JH0W1mtKElbqpNwDtkwquZN06v6iBxMhvpicSXQZIJVS9EbtbeEXwoiCosDhCppvtSU3PPvCL/JvOZVAt7rRmzHEMy9tjzNc9FcoMBhqjpbwL43pEyuaKDe30noUOt4b9DaRkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg4GXNP0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg4GXNP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54DFC19423;
	Tue, 31 Mar 2026 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774937917;
	bh=U0Gypix0B1lyS8WO/z9V5SWKJeE4tpw0piwNWZ/hmy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rg4GXNP08lxZZkvwPdiPT9KmUnxglGU87iQxSstq6SG7kepaXR9X+9NR7oWIqQhD2
	 WP28YtDLmhD880YjXi6F26eb9p3YHxB11yp2+8GXAbL5UJvT6ZWcjfpmdRKPBSqCR/
	 Zh7sQ0cDD8g8MTfnjw3HNClvDZZuPJWM+msdi6n+1jupi0NDPVihsuB97pZv7jc+PB
	 UQxBVI/V5c9AA3U0E5Rb5xusuJ0FtOb5gO7d+mDZDHHSFhg6UDXb0mHT2sz0MX5IeQ
	 5C+VtgrXCPrLa/G19BC0Y4JYOegnhBnoZfilyjnMXXGb9baG/57JLg/YjB760FGaTq
	 uoZprzvqLpCkA==
Date: Mon, 30 Mar 2026 23:18:37 -0700
From: Kees Cook <kees@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 3/3] fortify: Simplify strlen() logic
Message-ID: <202603302312.29AE002@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
 <20260330132003.3379-4-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330132003.3379-4-david.laight.linux@gmail.com>

On Mon, Mar 30, 2026 at 02:20:03PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The __builtin_choose_expr() doesn't gain you anything, replace with
> a simple ?: operator.
> Then __is_constexpr() can then be replaced with __builtin_constant_p().
> This still works for static initialisers - the expression can contain
> a function call - provided it isn't actually called.
> 
> Calling the strnlen() wrapper just add a lot more logic to read through.
> Replace with a call to __real_strnlen().
> 
> However the compiler can decide that __builtin_constant_p(__builtin_strlen(p))
> is false, but split as ret = __builtin_strlen(p); __builtin_constant_p(ret)
> and it suddenly becomes true.
> So an additional check is needed before calling __real_strnlen().

Ah, there it is, exactly the issue I'm remembering, see
commit 4f3d1be4c2f8 ("compiler.h: add const_true()")

Instead of this patch, I should likely replace the open-coded versions
of const_true() here.

Regardless, we should not change this or the compiletime_strlen() macro
as you've suggested, IMO. They both work as they already are, so I see
no reason re-open this can of worms without a good reason.

What was the specific code that caused an issue for you with
__fortify_strlen ?

-Kees

> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  include/linux/fortify-string.h | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 758afd7c5f8a..6cd670492270 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -230,9 +230,8 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
>  }
>  
>  /*
> - * Defined after fortified strnlen to reuse it. However, it must still be
> - * possible for strlen() to be used on compile-time strings for use in
> - * static initializers (i.e. as a constant expression).
> + * strlen() of a compile-time string needs to be a constant expression
> + * so it can be used, for example, as a static initializer.
>   */
>  /**
>   * strlen - Return count of characters in a NUL-terminated string
> @@ -247,9 +246,9 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
>   * Returns number of characters in @p (NOT including the final NUL).
>   *
>   */
> -#define strlen(p)							\
> -	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),	\
> -		__builtin_strlen(p), __fortify_strlen(p))
> +#define strlen(p)					\
> +	(__builtin_constant_p(__builtin_strlen(p)) ?	\
> +		__builtin_strlen(p) : __fortify_strlen(p))
>  __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
>  __kernel_size_t __fortify_strlen(const char * const POS p)
>  {
> @@ -259,7 +258,14 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
>  	/* Give up if we don't know how large p is. */
>  	if (p_size == SIZE_MAX)
>  		return __underlying_strlen(p);
> -	ret = strnlen(p, p_size);
> +	/*
> +	 * 'ret' can be constant here even though the __builtin_constant_p(__builtin_strlen(p))
> +	 * in the #define wrapper is false.
> +	 */
> +	ret = __builtin_strlen(p);
> +	if (__builtin_constant_p(ret))
> +		return ret;
> +	ret = __real_strnlen(p, p_size);
>  	if (p_size <= ret)
>  		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, p_size, ret + 1, ret);
>  	return ret;
> -- 
> 2.39.5
> 

-- 
Kees Cook
