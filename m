Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949601AB505;
	Wed,  8 Jan 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372814; cv=none; b=NzOHdPGB+9mqHn6RB3JA/d6VBDMmRURsIHqDYZ2m4bNkdMLImYmzarUTuUtQaYb896ghiVaTchAFXykDflvCtMFYqunIwoYeaikP69CN00Qv3t1iLc/95+ultFGF7jkxgfKf+IUJvywO2Y3vMnegIAet7gdWOcSt3d7cAvVQ/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372814; c=relaxed/simple;
	bh=IqHNz4jGCSHdLU/v7gFB90RubCkbGOwNmD62v759kLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFQPjMWxJ3c8F60SnRIJKlhy6i4O/tW2T6yF10a3vVkVN1t1JIZ0k2zF+fvFZF4TxiAzR7Uy+20rVTmoWGvuxHAG1173eqZy7stNbtl0qfLZXzaVs2GLHPQ+cnfOhxOpMV4Y0yEZ6oeEu5HRmkrQxanJmbA+isoDGiz1iqAXolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqqhld36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqqhld36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC40C4CED3;
	Wed,  8 Jan 2025 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372814;
	bh=IqHNz4jGCSHdLU/v7gFB90RubCkbGOwNmD62v759kLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jqqhld36VaOhc4U4M6kxct6fFS8kHdK7lHw2xlVmw2zO7NyQalVVcV1CxmxwXIxij
	 Yu/7EzhGOdoS1OBpRr/t0wxXZTJ2BRmHaD6+EomU8EIyKP7MGPtAnnuIdrVTjYwA8g
	 zekmpdi+IBweYQMYG6B1s38NplkCl78gsiDc5ryqo6OR0OxKTwoBgpxNkpIhOX2QX1
	 NNz9ZK+LidHprUGIY1ymhRk7hwsb6VMJz+0g0ftH58s5Tm4bAx1YPTCO5/fg600k0g
	 vmvhQsJ1pNaT1YxqnWqH4Lgz+9pp37nSyqzFJ2GPSDdd7CTqmrv0GFvSjhvxhDKUGs
	 LeColx5kjEuOQ==
Date: Wed, 8 Jan 2025 13:46:50 -0800
From: Kees Cook <kees@kernel.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	David Laight <david.laight@aculab.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] fortify: turn strlen() into an inline function using
 __builtin_constant_p()
Message-ID: <202501081331.E4B6DF747@keescook>
References: <20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr>

On Wed, Jan 08, 2025 at 11:27:51PM +0900, Vincent Mailhol wrote:
> The strlen(p) function-like macro uses:
> 
>   __is_constexpr(__builtin_strlen(p))
> 
> in which GCC would only yield true if the argument p is a string
> literal. Otherwise, GCC would return false even if p is a const
> string.
> 
> In contrary, by using:
> 
>   __builtin_constant_p(__builtin_strlen(p))
> 
> then GCC can also recognizes when p is a compile time constant string.
> 
> The above is illustrated in [1].
> 
> N.B.: clang is not impacted by any of this and gives the same results
> with either __is_constexpr() and __builting_constant_p().
> 
> Use __builtin_constant_p() instead of __is_constexpr() so that GCC can
> do the folding on constant strings. This done, strlen() does not
> require any more to be a function-like macro, so turn it into a static
> inline function. In the process, __fortify_strlen() had to be moved
> above strlen() so that it became visible to strlen().

This is what __compiletime_strlen() ended up doing, so this seems
reasonable to me.

> On a side note, strlen() did a double expansion of its argument p.

It did? Ah, was it due to __is_constexpr() wrapping? The other
expressions should have been side-effect free:

       __builtin_choose_expr(__is_constexpr(__builtin_strlen(p)), \
               __builtin_strlen(p), __fortify_strlen(p))


I don't think you build-tested this with Clang, though?

  CC      scripts/mod/devicetable-offsets.s
In file included from ../scripts/mod/devicetable-offsets.c:3:
In file included from ../include/linux/mod_devicetable.h:14:
In file included from ../include/linux/uuid.h:11:
In file included from ../include/linux/string.h:389:
../include/linux/fortify-string.h:272:17: error: redeclaration of 'strlen' must not have the 'overloadable' attribute
  272 | __kernel_size_t strlen(const char *p)
      |                 ^
../include/linux/string.h:200:24: note: previous unmarked overload of function is here
  200 | extern __kernel_size_t strlen(const char *);
      |                        ^

The externs will need to be reworked if it's no longer depending on asm
renaming.

> Turning it into an inline function also resolved this side issue.
> 
> [1] https://godbolt.org/z/rqr3YvoP4
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> This patch is the successor of patch [1] which was part of a longer
> series [2]. Meanwhile, I decided to split it, so I am sending this again,
> but as a stand-alone patch.
> 
> Changelog since [1]: use __builtin_constant_p() instead and turn
> strlen() into an inline function
> 
> [1] https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-6-4e4cbaecc216@wanadoo.fr/
> [2] https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr/
> ---
>  include/linux/fortify-string.h | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index e4ce1cae03bf770047ce8a7c032b183683388cd5..bd22dd66e5f5b66ad839df42247e6436e0afd053 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -4,7 +4,6 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bug.h>
> -#include <linux/const.h>
>  #include <linux/limits.h>
>  
>  #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
> @@ -241,6 +240,21 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
>   * possible for strlen() to be used on compile-time strings for use in
>   * static initializers (i.e. as a constant expression).

^^ This comment, however, is I think what sinks this patch. Please see
commit 67ebc3ab4462 ("fortify: Make sure strlen() may still be used as a
constant expression") which required that strlen() not be an inline. I'm
pretty sure the build will start failing again (though perhaps only on
older GCC versions).

The lib/test_fortify/ target still successfully builds, so that's good
though. :)

-- 
Kees Cook
