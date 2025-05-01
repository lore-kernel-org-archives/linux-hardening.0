Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6951BE871;
	Thu,  1 May 2025 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130641; cv=none; b=ldb9lhTflaeXp495fh6YTdRjc2R3Bvsa52734ZQKoVau7Fx8wTf6GZgutwFjY8zUXMvRAlxGPjRtkASK5a1gSuDf6x822Z4nN57r3sKeoryWoATWi931nkSm/0AvswSpBmLJ4oIgVuj57H+4R/kwO302vSE4c3ZUJGv0ZdLsn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130641; c=relaxed/simple;
	bh=ron9HqA8+t8nkH2BOQWiN+u0cKbt+JCnXchGocA0OeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dShM2fexlOtylVYcHRNHLHkeR3RpSb9TgY0aM48tmHice4NK88XTxB0hOuvfqkfReJR9B1r47dhU7/qOEZtlKHRxVLLnYCg1o/HIV3RPIQo8XuCG24xvYcC1GzlPstK9a9lgZYaZURYTjHUB2A2RW/9YrQg8/I8dZ5vi7i4K9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pInP4n1W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pInP4n1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FB1C4CEE3;
	Thu,  1 May 2025 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746130637;
	bh=ron9HqA8+t8nkH2BOQWiN+u0cKbt+JCnXchGocA0OeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pInP4n1WGE4ySBYjEKwqg//xtiX1BBrxMBY516nQcPLHxkwN6AZtpsNADBnv87Qt2
	 NV3u2CqWmyGj/4Ixv4L0aigqT5sxGKI/ZN2r6Y7B01eHGMggBRby9AMv6L9cSeOKZ0
	 PBlSkI0wJXgyRwUwsCqWegk6982akbLvgjVPTPfSHepYilG/9NKgxzMy6UOXBe7TUk
	 DnZYxjE5b+X1D7fuVtSplI0DtkNJsbbllvUGsehCzZjaiQkPJSY4iBI++Wu4NGB7Yj
	 3xguE4RPLNbgp7L7Bybxd6Z3z5WFtkAO33oqAxtHLJdjbahVML+7CXWiJFg7PGWYcG
	 iqZT6oyYXGLfQ==
Date: Thu, 1 May 2025 13:17:14 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] overflow: Fix direct struct member initialization
 in _DEFINE_FLEX()
Message-ID: <202505011315.AC9590F@keescook>
References: <aBK2TUEeQfCFop9Y@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBK2TUEeQfCFop9Y@kspp>

On Wed, Apr 30, 2025 at 05:46:21PM -0600, Gustavo A. R. Silva wrote:
> Currently, to statically initialize the struct members of the `type`
> object created by _DEFINE_FLEX(), the internal `obj` member must be
> explicitly referenced at the call site. See:
> 
> struct flex {
> 	int a;
> 	int b;
> 	struct foo flex_array[];
> };
> 
> _DEFINE_FLEX(struct flex, instance, flex_array,
> 	     FIXED_SIZE, = {
> 		.obj = {
> 			.a = 0,
> 			.b = 1,
> 		},
> 	});
> 
> This leaks _DEFINE_FLEX() internal implementation details and make
> the helper harder to use and read.
> 
> Fix this and allow for a more natural and intuitive C99 init-style:
> 
> _DEFINE_FLEX(struct flex, instance, flex_array,
> 	     FIXED_SIZE, = {
> 		.a = 0,
> 		.b = 1,
> 	});
> 
> Also, update "counter" member initialization in DEFINE_FLEX().
> 
> Fixes: 26dd68d293fd ("overflow: add DEFINE_FLEX() for on-stack allocs")
> Link: https://lore.kernel.org/linux-hardening/c4828c41-e46c-43c9-a73a-38ce8ab2c1c4@embeddedor.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/overflow.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 69533e703be5..170d3cfe7ecc 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -404,7 +404,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)

Earlier up in the file:

...
 * @initializer: initializer expression (could be empty for no init).
   ^^^^^^^^^
 */
#define _DEFINE_FLEX(type, name, member, count, initializer...)

This argument now becomes required, which is fine, but we should keep
the docs updated and double check any existing "_DEFINE_FLEX" users that
may have an empty final argument (I don't see any, so that's nice).

>  	union {									\
>  		u8 bytes[struct_size_t(type, member, count)];			\
>  		type obj;							\
> -	} name##_u initializer;							\
> +	} name##_u = { .obj initializer };					\
>  	type *name = (type *)&name##_u
>  
>  /**
> @@ -444,7 +444,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   * elements in array @member.
>   */
>  #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
> -	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
> +	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .COUNTER = COUNT, })
>  
>  /**
>   * STACK_FLEX_ARRAY_SIZE() - helper macro for DEFINE_FLEX() family.

But otherwise, yes, let's do this!

-- 
Kees Cook
