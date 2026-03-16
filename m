Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A0339878;
	Mon, 16 Mar 2026 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678571; cv=none; b=FVocPPFoYpO5zqmDh6vL4yKHk4BiOAnOpw4Nf7kLhfBJJaTSyWN6McZLZ/MBOrl7kyRimV3iY4vd9jcSWz8zI3UcTyvWxPQTuQPQa7zJQFgAyFLCrKXZiKb5OPn49PgA3d2QjdGu4ziRVHkUbolhR+IyOtsu+14z31J7xg7eZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678571; c=relaxed/simple;
	bh=GPTAIwzf+5Y4nS8faoI0ZQWyzFRbIbWS5/4aW3EQ8O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2UcygitpqJ6AI6Ln6bmD8QXUiiAGjvS/Gx34j9SWH4cWQ9S4bMWoV8Pcxl/DrUItRgxZmKCocsE1dabX3AX8c4gI8O4j8GD4IiZbD78/m0JEraQA2jW4dAI/RTNzozZcdCOnooLsyEnB51A+Tgcw3mRk1/rTavyOzzZD61Rkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xh5NJCIV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xh5NJCIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA370C19421;
	Mon, 16 Mar 2026 16:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773678571;
	bh=GPTAIwzf+5Y4nS8faoI0ZQWyzFRbIbWS5/4aW3EQ8O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xh5NJCIV3qHIZoVmIV2skZCvruY2ls7+LxWEMmilwj0QtpdlsO4QW7+NLyt+cSgDV
	 FKGeSmq8ww6DCFfaZKayLqFBYMGwzbVtNgRLsZY7vMtflhoes6qAsAUCvqwzTP9KRX
	 n0eZvabvbSSND2wC9jhLfBN7iwj7oAntwUmbPUo4=
Date: Mon, 16 Mar 2026 17:29:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Josh Law <objecting@objecting.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, andy@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: replace BUG_ON with WARN_ON_ONCE in strlcat
Message-ID: <2026031622-brewery-mauve-435e@gregkh>
References: <20260316161728.84485-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316161728.84485-1-objecting@objecting.org>

On Mon, Mar 16, 2026 at 04:17:28PM +0000, Josh Law wrote:
> BUG_ON() in a library function is too harsh -- it panics the kernel
> when a caller passes a dest string whose length already meets or
> exceeds count. This is a caller bug, not a reason to bring down the
> entire system.
> 
> Replace with WARN_ON_ONCE() and a safe early return. The return value
> of count signals truncation to the caller, consistent with strlcat
> semantics (return >= count means the output was truncated).
> 
> This follows the guidance in include/asm-generic/bug.h which
> explicitly discourages BUG_ON: "Don't use BUG() or BUG_ON() unless
> there's really no way out."
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/string.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index b632c71df1a5..ae3eb192534d 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -255,8 +255,9 @@ size_t strlcat(char *dest, const char *src, size_t count)
>  	size_t len = strlen(src);
>  	size_t res = dsize + len;
>  
> -	/* This would be a bug */
> -	BUG_ON(dsize >= count);
> +	/* This would be a caller bug */
> +	if (WARN_ON_ONCE(dsize >= count))
> +		return count;

You still just crashed the system for the few billion or so Linux
systems out there with panic-on-warn enabled :(

And is returning 'count' really the correct thing to do here when you
didn't actually copy any data?

thanks,

greg k-h
