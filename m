Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A91D8E01
	for <linux-hardening@vger.kernel.org>; Thu,  6 Feb 2025 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738875071; cv=none; b=Fi+zs8eRD6QuBLAZhcVf1qTvgUk3wa1nmFBgot/z3ExJXkn7PP9u8soQ84GlmELhSWYKqG5HzNj9zrOFjGDRI08YCvtr50pEGEW7Wuujiv3/cARdIvykxXZPcqvikp+Z666KVhzkn4qgxGjclvPwQpIf2Wv6D3FsLn1/i4umxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738875071; c=relaxed/simple;
	bh=Dtff0GL1xKXUSDWIQ2ixg6LQn9NZNfEnTj9dVkbYHHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZhf9Ay6Om8iqn+VHrCIUXSQTqMqjWvTHf7tZ0otr1/kwNH/Zvnl1/0Z/pcDivMH2ty3edV9fH2uUieQHxMGTpr/1ttSqbzPNOMcC6/FAl0p1JRtNaclC+AUT2JU7wUdGbr8eeFbGFpBzzHwXnUhxcQx+v8/cbEd+lP4rLc/uL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MjQGalvT; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MjQGalvT"
Date: Thu, 6 Feb 2025 15:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738875051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lkz9WsvZrg/DkOjRJWw65ldHcgxFNBIwJwXf0q6oNCg=;
	b=MjQGalvT/H/W4smNRB177hqw36WLr498jBP1wANQHn093qF2VqNS6XG15wp93CM73JC+qD
	9+ALgkULewP9isD7CNJA9WpskHnEU2rhhDNFgqGur6w09oS+bwzEpqeKrv8mmztAhJ1+lz
	ybj9YmjY8tc1yXNRcLcx4OYroD+8+eg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andy Shevchenko <andy@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] compiler.h: Introduce __must_be_char_array()
Message-ID: <wsa57yhzrz6wryqq2bjepfhyteqn5jnnsvf5scthkxz5yrayxh@q74gtz55o7dz>
References: <20250206175216.work.225-kees@kernel.org>
 <20250206181133.3450635-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206181133.3450635-2-kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 06, 2025 at 10:11:29AM -0800, Kees Cook wrote:
> In preparation for adding stricter type checking to the str/mem*()
> helpers, provide a way to check that a variable is a character array
> via __must_be_char_array().
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Suggested-by? :)

> ---
>  include/linux/compiler.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 7af999a131cb..a577fe0b1f8a 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -221,7 +221,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #endif /* __CHECKER__ */
>  
>  /* &a[0] degrades to a pointer: a different type from an array */
> -#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
> +#define __is_array(a)		(!__same_type((a), &(a)[0]))
> +#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
> +							"must be array")
> +
> +#define __is_char_array(a)	(__is_array(a) && sizeof((a)[0]) == 1)
> +#define __must_be_char_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_char_array(a), \
> +							"must be byte array")
>  
>  /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
>  #define __must_be_cstr(p) \
> -- 
> 2.34.1
> 
