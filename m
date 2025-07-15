Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1429460;
	Tue, 15 Jul 2025 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557098; cv=none; b=hWKInuYNecDt9CXr+pwZ1Qv/p/v52lgSBVsG3zbUje7hGstzeymtRC74x/VH6MPd5Eu+DtLJBtYMPRvXKGj8UhK4F1cN56LtcnyAx0Q0XFv1POyY8ZM223sT9+nJo+45lx6kbgq50xkHmTOBplBvnpv8xGhQEXMat7sS5+BQ7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557098; c=relaxed/simple;
	bh=NCxeWajkAUs9bRTh2l1UFYhJ6aa6IaY0AK5/Z1ervfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWWTi3FlknYPPOy6ajs5zmkfHgUqgvWF/xa88Ov1ASdtreYLFWUnRRylSpzSt+LcJ42HvO4ehEprpwNEBI05D3h4441/KJB9lz6pM9I/Hkf1HQ2+FPHu2Y2oVaVbJN54XZyApjTvE44AscGh5Tq7Gmj0LfLcrAF2YcUs07aVRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyx5a6OP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyx5a6OP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EC3C4CEE3;
	Tue, 15 Jul 2025 05:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752557098;
	bh=NCxeWajkAUs9bRTh2l1UFYhJ6aa6IaY0AK5/Z1ervfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lyx5a6OPKarBRQ6Pb+svz+/t9zik7m+i/FpVNATOBXQvxodzxARoFJZhrSYfOcWzN
	 CJQWbOZ9zMV7jE7owZz6PNb3inyS5zWlRZlzY2NFR+1svOXUpxz7RbRsbh61EgRbH7
	 NNH7ZgWw+BA7byKYn5lPy8VNBhEGa+P9nlQwWdgFL6xMZftrOnVkDSfTT2tYeDVZA9
	 T89E3bzJUZFC8pRRfzR/XwWqcbNVgd0jOw1KbrNui1SP3dy+An+ieKocv/6kfRysrY
	 wE4qilBmfWLvwHlQeqYTjCx9Zs1goYHiWAJJeqqr68l6qutNZv9GJQAEipkWSBbHA1
	 ePPvIBqXDNBow==
Date: Mon, 14 Jul 2025 22:24:58 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] string: Group str_has_prefix() and strstarts()
Message-ID: <202507142224.28276C2D8@keescook>
References: <20250711085514.1294428-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711085514.1294428-1-andriy.shevchenko@linux.intel.com>

On Fri, Jul 11, 2025 at 11:55:14AM +0300, Andy Shevchenko wrote:
> The two str_has_prefix() and strstarts() are about the same
> with a slight difference on what they return. Group them in
> the header.

It seems more like strstarts should just be a macro around
str_has_prefix() != 0?

-Kees

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/string.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 01621ad0f598..fdd3442c6bcb 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -345,16 +345,6 @@ extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
>  
>  int ptr_to_hashval(const void *ptr, unsigned long *hashval_out);
>  
> -/**
> - * strstarts - does @str start with @prefix?
> - * @str: string to examine
> - * @prefix: prefix to look for.
> - */
> -static inline bool strstarts(const char *str, const char *prefix)
> -{
> -	return strncmp(str, prefix, strlen(prefix)) == 0;
> -}
> -
>  size_t memweight(const void *ptr, size_t bytes);
>  
>  /**
> @@ -562,4 +552,14 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
>  	return strncmp(str, prefix, len) == 0 ? len : 0;
>  }
>  
> +/**
> + * strstarts - does @str start with @prefix?
> + * @str: string to examine
> + * @prefix: prefix to look for.
> + */
> +static inline bool strstarts(const char *str, const char *prefix)
> +{
> +	return strncmp(str, prefix, strlen(prefix)) == 0;
> +}
> +
>  #endif /* _LINUX_STRING_H_ */
> -- 
> 2.47.2
> 

-- 
Kees Cook
