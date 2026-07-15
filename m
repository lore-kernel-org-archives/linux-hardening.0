Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662D3B0ACC;
	Wed, 15 Jul 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131951; cv=none; b=HoYAlpCsJS9DxQY8jpGXwqZFphiDhsBzjmShoNqcEYUxAxxVxpw8GQZleS1hagVi4mIyOgoEslx+q8j++CayOpA+D2/6H7ZHF9xwePXbfZRHnz5q4E/gKgYHWB+ZWbmAzKM4LK0/t2gBpPbrEcoMLRyYVIZ1ubBVswCynVKRc5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131951; c=relaxed/simple;
	bh=y4gC8zi3Yrz7Nv7k7PnRgXnEWvM+DrzITO+wnJaqJpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8jYHFCA9JzwACOuqz1FvdsY74d1EhvNofb/gIIxzy/fsyH66nxOcEIFMNnnyY8J2GCrAxtsFdKsORnuff/E9dfCAh2Siwyqmmqlwd2YuZsbs6tJaEY6Fhc8Ta1MnjFRGvR7x+sctJY5FynqG0lBehcSjkFIA+HziXtonOBXtYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dylNt978; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dylNt978"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574141F000E9;
	Wed, 15 Jul 2026 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131938;
	bh=jBsPc1sdVMZeS0SD97mtqytIPT72XDqmZkV+oGgvpws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dylNt978SCdqcb7nXeQsrdnVnSMvLKiAx2NsXYxwxT5b/Pylh0e4C83rYPgsdaWzN
	 MWA4R55Ga9LpUzFiMhUZNe0E0HlBh6v9sQ12vgsX35yAHe7KWvV5ac6A1xBBJQ3Eyw
	 D627dcPf6Kf4vGiZHDeYCXpqNc8ZrGrCLayuFLijoMeH0jwrArNFDLGK/sPE4aoV7D
	 9c+Z2aFzj1hyOMNus6Elret8vvS49MD+Kxl66AcuACv8K1ubVJOr4+H7c9Echj0Xrc
	 hWGBuUpeYDOIwE4JGfcNzISGo429y6siYXjeXcaB4/41dUDw0iY75ZNhLNGFt0tzQL
	 g6mUmnr9wjCAQ==
Date: Wed, 15 Jul 2026 09:12:18 -0700
From: Kees Cook <kees@kernel.org>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [RFC PATCH] overflow: Add DECLARE_SIZED_FLEX() helper family
Message-ID: <202607150906.33F01B40@keescook>
References: <20260714151818.538869-1-jtaubepe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714151818.538869-1-jtaubepe@redhat.com>

On Tue, Jul 14, 2026 at 11:18:18AM -0400, Jesse Taube wrote:
> Add new DECLARE_SIZED_FLEX() helper to set the default size of a
> flexible-array member. The code is identical to the declaration in
> __DEFINE_FLEX() which has also been changed to use DECLARE_SIZED_FLEX().
> 
> Add DECLARE_COUNTED_FLEX_ARRAY() helper which is a variant of
> DECLARE_FLEX_ARRAY() with a counted-by attribute.
> 
> Also add default sized variants of
> DECLARE_FLEX_ARRAY(), DECLARE_SIZED_FLEX(), and
> DECLARE_COUNTED_FLEX_ARRAY(), DECLARE_COUNTED_SIZED_FLEX().

Where do you want to use these new helpers?

> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> ---
>  include/linux/overflow.h | 58 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index a8cb6319b4fb..a3384cae49e5 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -464,6 +464,59 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>   */
>  #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
>  
> +/**
> + * __DECLARE_SIZED_FLEX() - helper macro for DECLARE_SIZED_FLEX() family.
> + * Allows for easily declaring a structure with a trailing flexible array member
> + * to have a specific size.
> + *
> + * @obj: object to be given a specific size
> + * @name: Name of the array member.
> + * @count: Number of elements in the array; must be compile-time const.
> + */
> +#define __DECLARE_SIZED_FLEX(obj, name, count)	\
> +	_Static_assert(__builtin_constant_p(count),		\
> +		       "default sized flex array members require compile-time const count");	\
> +	union {							\
> +		u8 bytes[struct_size_t(obj, name, count)];	\
> +		obj;						\
> +	}
> +
> +/**
> + * DECLARE_COUNTED_FLEX_ARRAY() - Declare a counted flexible array
> + *
> + * @type: Type name.
> + * @name: Name of the array member.
> + * @counter: Name of the __counted_by member.
> + */
> +#define DECLARE_COUNTED_FLEX_ARRAY(type, name, counter)\
> +	struct { \
> +		size_t counter; \
> +		type name[] __counted_by(counter); \
> +	}
> +
> +/**
> + * DECLARE_SIZED_FLEX() - Declare a structure with a trailing flexible array
> + * member with a default size.
> + *
> + * @type: Type name.
> + * @name: Name of the array member.
> + * @count: Number of elements in the array; must be compile-time const.
> + */
> +#define DECLARE_SIZED_FLEX(type, name, count)	\
> +	__DECLARE_SIZED_FLEX(type name[], name, count)
> +
> +/**
> + * DECLARE_COUNTED_SIZED_FLEX() - Declare a structure with a trailing flexible
> + * array member counted by count, with a default size.
> + *
> + * @type: Type name.
> + * @name: Name of the array member.
> + * @counter: Name of the __counted_by member.
> + * @count: Number of elements in the array; must be compile-time const.
> + */
> +#define DECLARE_COUNTED_SIZED_FLEX(type, name, counter, count)	\
> +	__DECLARE_SIZED_FLEX(DECLARE_COUNTED_FLEX_ARRAY(type, name, counter), name, count)

I ask about where these will be used because one of the things I want to
keep tied together is the "counter" and "count", which usually means the
declaration should be combined with an initializer in some way so that
the counter gets assigned, as DEFINE_FLEX() ultimately does.

I'm worried that extracting the internal construction of __DEFINE_FLEX
means we may run the risk of increasing the risk of losing that tie.

So, I'd love to understand how you want to use this, as that would help
my understanding and potentially shape the design so we can keep counter
and count strongly associated.

> +
>  /**
>   * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
>   * Enables caller macro to pass arbitrary trailing expressions
> @@ -477,10 +530,7 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>  #define __DEFINE_FLEX(type, name, member, count, trailer...)			\
>  	_Static_assert(__builtin_constant_p(count),				\
>  		       "onstack flex array members require compile-time const count"); \
> -	union {									\
> -		u8 bytes[struct_size_t(type, member, count)];			\
> -		type obj;							\
> -	} name##_u trailer;							\
> +	__DECLARE_SIZED_FLEX(type obj, member, count) name##_u trailer;		\
>  	type *name = (type *)&name##_u

-Kees

-- 
Kees Cook
