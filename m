Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114739A06B;
	Mon, 30 Mar 2026 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914868; cv=none; b=j4UdHVZRzlTzNaLdDFX1hB6jN1Ri2Xcsost0zLSakNNaWWTO1c32vuDzui5NpCf2d1Qo7dcaxqPRyuTLPZqJBXCpTx7oQqF0zUzzlLURKTNWRUhy1VYfIvwzHsTM8XpjZ1bbk2VA4xONm6YZ3M7IR7TO8Gu/fFS6g2d22cdj+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914868; c=relaxed/simple;
	bh=jAbF37JHJZ7yAvWaljHIVlybXwa+rgOL2qaxswOkMM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr7TdB4YtAtwQ9bAFHSsZSK0wlzZ15qrUaJMkcpsBkdHcUjHmIfABMHVgoxWD9sBlHUWF5Sa+CMlMXjCrv2C9HFYlR6vKurIpdDyet5unsv+/lwHoEVKl5I7VT62gTR0c8a3LvtqSUW53UfkvmIwMGLRpz40xTk4Qp5Qct7RkqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujjQSRN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujjQSRN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695CFC2BCB1;
	Mon, 30 Mar 2026 23:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774914868;
	bh=jAbF37JHJZ7yAvWaljHIVlybXwa+rgOL2qaxswOkMM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujjQSRN8crbDIi1p2qdvgrkQqfeDszBibPTiaZXX2yjuHMPS4u6EXQ6J1VgFCCMpW
	 TmMs+0my0RqVU5XHSqIVH3K0fh3vGodLFUKrjWLrmHn8/OJsQNw5dtRhg061RSTRph
	 63iz75xO3h/DMH/6jKlqSZviaC8N+B7hXfogE53zBkiJb8L9eAwwnDuIwWOU1aq3IL
	 Z6yvbGtNYp7T7NayRY/cnQcNmvrVCK6t5OTqAlbSkfoBc5X4hp4t76bFYCzsKoKSgp
	 g+FM2qi++8RbqjwDUyN0Xvd2Ysai3d1vg1XMJSBD4C2OoWFk7SJhesE9pWwNKjsKJf
	 WifwzQD8FFPVw==
Date: Mon, 30 Mar 2026 16:54:27 -0700
From: Kees Cook <kees@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <202603301650.E7C1536632@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
 <20260330132003.3379-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330132003.3379-3-david.laight.linux@gmail.com>

On Mon, Mar 30, 2026 at 02:20:02PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> If the string is constant there is no need to call __real_strlen()
> even when maxlen is a variable - just return the smaller value.
> 
> If the size of the string variable is unknown fortify_panic() can't be
> called, change the condition so that the compiler can optimise it away.
> 
> Change __compiletime_strlen(p) to return a 'non-constant' value
> for non-constant strings (the same as __builtin_strlen()).
> Simplify since it is only necessary to check that the size is constant
> and that the last character is '\0'.
> Explain why it is different from __builtin_strlen().
> Update the kunit tests to match.

This will need very very careful checking. It took a lot of tweaking to
get __compiletime_strlen() to behave correctly across all supported
versions of GCC and Clang. It has some very ugly glitches possible. I'm
not saying your replacement is broken: I mean to say I'm going to need
to spend a bunch of time proving to myself that this is a safe
replacement.

Outside of that, though, I don't think dropping the various SIZE_MAX
tests is correct. Again, I'll need to spend some time double-checking.

-Kees

> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  include/linux/fortify-string.h | 44 +++++++++++++++++-----------------
>  lib/tests/fortify_kunit.c      |  8 +++----
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 214d237214d5..758afd7c5f8a 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -58,19 +58,22 @@ void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("
>  void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
>  void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("detected write beyond size of field (1st parameter); maybe use struct_group()?");
>  
> -#define __compiletime_strlen(p)					\
> -({								\
> -	char *__p = (char *)(p);				\
> -	size_t __ret = SIZE_MAX;				\
> -	const size_t __p_size = __member_size(p);		\
> -	if (__p_size != SIZE_MAX &&				\
> -	    __builtin_constant_p(*__p)) {			\
> -		size_t __p_len = __p_size - 1;			\
> -		if (__builtin_constant_p(__p[__p_len]) &&	\
> -		    __p[__p_len] == '\0')			\
> -			__ret = __builtin_strlen(__p);		\
> -	}							\
> -	__ret;							\
> +/*
> + * __builtin_strlen() generates a compile-time error for 'const char foo[4] = "abcd";'.
> + * But that is a valid source for both strnlen() and strscpy() with a constant
> + * length less than or equal to 4.
> + * __compiletime_strlen() returns a non-constant for such items.
> + * Beware of strings with embedded '\0', __builtin_strlen() can be much smaller
> + * than __member_size();
> + * The return value must only be used when it is a constant.
> + */
> +extern size_t __fortify_undefined;
> +#define __compiletime_strlen(p)							\
> +({										\
> +	char *__p = (char *)(p);						\
> +	const size_t __p_size = __member_size(p);				\
> +	__p_size == SIZE_MAX || !statically_true(__p[__p_size - 1] == '\0') ?	\
> +		__fortify_undefined : __builtin_strlen(__p);			\
>  })
>  
>  #if defined(__SANITIZE_ADDRESS__)
> @@ -215,16 +218,13 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
>  	const size_t p_len = __compiletime_strlen(p);
>  	size_t ret;
>  
> -	/* We can take compile-time actions when maxlen is const. */
> -	if (__builtin_constant_p(maxlen) && p_len != SIZE_MAX) {
> -		/* If p is const, we can use its compile-time-known len. */
> -		if (maxlen >= p_size)
> -			return p_len;
> -	}
> +	/* If p is const, we can use its compile-time-known len. */
> +	if (__builtin_constant_p(p_len))
> +		return p_len < maxlen ? p_len : maxlen;
>  
>  	/* Do not check characters beyond the end of p. */
> -	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
> -	if (p_size <= ret && maxlen != ret)
> +	ret = __real_strnlen(p, p_size < maxlen ? p_size : maxlen);
> +	if (ret == p_size && p_size < maxlen)
>  		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, p_size, ret + 1, ret);
>  	return ret;
>  }
> @@ -289,7 +289,7 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
>  	if (statically_true(p_size < SIZE_MAX)) {
>  		len = __compiletime_strlen(q);
>  
> -		if (len < SIZE_MAX && statically_true(len < size)) {
> +		if (statically_true(len < size)) {
>  			__underlying_memcpy(p, q, len + 1);
>  			return len;
>  		}
> diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
> index fc9c76f026d6..9b3b7201c02d 100644
> --- a/lib/tests/fortify_kunit.c
> +++ b/lib/tests/fortify_kunit.c
> @@ -102,11 +102,11 @@ static void fortify_test_known_sizes(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, __compiletime_strlen(unchanging_12), 12);
>  
>  	KUNIT_EXPECT_FALSE(test, __is_constexpr(__builtin_strlen(array_unknown)));
> -	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
> +	KUNIT_EXPECT_FALSE(test, __is_constexpr(__compiletime_strlen(array_unknown)));
>  
>  	/* Externally defined and dynamically sized string pointer: */
>  	KUNIT_EXPECT_FALSE(test, __is_constexpr(__builtin_strlen(test->name)));
> -	KUNIT_EXPECT_EQ(test, __compiletime_strlen(test->name), SIZE_MAX);
> +	KUNIT_EXPECT_FALSE(test, __is_constexpr(__compiletime_strlen(test->name)));
>  }
>  
>  /* This is volatile so the optimizer can't perform DCE below. */
> @@ -128,12 +128,12 @@ static noinline size_t want_minus_one(int pick)
>  		str = "1";
>  		break;
>  	}
> -	return __compiletime_strlen(str);
> +	return __builtin_constant_p(__compiletime_strlen(str));
>  }
>  
>  static void fortify_test_control_flow_split(struct kunit *test)
>  {
> -	KUNIT_EXPECT_EQ(test, want_minus_one(pick), SIZE_MAX);
> +	KUNIT_EXPECT_FALSE(test, want_minus_one(pick));
>  }
>  
>  #define KUNIT_EXPECT_BOS(test, p, expected, name)			\
> -- 
> 2.39.5
> 

-- 
Kees Cook
