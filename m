Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995221D5BC;
	Mon,  7 Apr 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052051; cv=none; b=cI3TWL9bMr6csIkATgIFJonKgMXZdPC4ChSy4p40clGZQN90qK86Q5IoZiGqdKCBv5g5wnoQg7eZxb4Ucbsf5wwx3yeBxdmfRZfK37n2kEa/0WtHvIdcnIlvTJV62b4FRZpR5nQBwjdiSLknQL5FcRinGaiUhcoEJSserfRA7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052051; c=relaxed/simple;
	bh=Rjy7+gHwcN5R3Q73bvt6j0hYFAhCoXmIade8cQmpJMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1Q00KGDzi30xpKwO7zUQd3MAV8MSt70D3Q/FEOIRgfUg/572ayPKdGd6sNgVy0QL5LY1Mj16onD/Li7a9OtsZAq9BKzeP4ulJ4fh7nxm420Vr7M75PqMbSbIYjgxenClGA0ZIKe+VE1t8e2ZOIcmLYqXZaUVjNzGVaUeW0kw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRxqjllV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRxqjllV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BF8C4CEDD;
	Mon,  7 Apr 2025 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052050;
	bh=Rjy7+gHwcN5R3Q73bvt6j0hYFAhCoXmIade8cQmpJMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mRxqjllVEIoHXhcJ/cG5hI4NQhcJJVXXZCXKz6zeihbNv2UHA8cCI26AfONkeVsMp
	 KUcbrdYILgvle3TQ3jwdv6NcpYrWXhcHUoF4wnUGjF+fdxEw5uHX6Q3vvJYObGFJdl
	 Y4lb0RpVJW++Nmxjhie4hZZ7K99UiVFuQhk9cVGoGIdM5SEBdGbaPunJxFF3YkzhUV
	 qLdPoBlNeX90W5d+7psGkDqt0I30Sfs2HrdtLiWHroUVhjGFJzANyFJatMMHzpjZ+o
	 DPTFMPCuDwOqnRGxZ4p/VP4XmZ3APiCPSUmPhRojBcZeEiqKXUASLjlWu/7BHnMDH3
	 Qevkot55QUWmA==
Date: Mon, 7 Apr 2025 11:54:08 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-hardening@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: Replace deprecated strncpy() with strscpy()
Message-ID: <202504071153.46436ACBB@keescook>
References: <20250320165647.34859-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320165647.34859-2-thorsten.blum@linux.dev>

On Thu, Mar 20, 2025 at 05:56:44PM +0100, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy() instead. Since kzalloc() already zeroes out the destination
> buffer, the potential NUL-padding by strncpy() is unnecessary. strscpy()
> copies only the required characters and guarantees NUL-termination.

Looks right to me; thanks for the details!

> 
> Since the destination buffer has a fixed length, strscpy() automatically
> determines its size using sizeof() when the argument is omitted. This
> makes an explicit sizeof() call unnecessary.
> 
> The source string is also NUL-terminated and meets the __must_be_cstr()
> requirement of strscpy().
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Kees Cook <kees@kernel.org>


> ---
>  drivers/usb/gadget/legacy/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index b6a30d88a800..fcce84a726f2 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -1615,7 +1615,7 @@ static int activate_ep_files (struct dev_data *dev)
>  		mutex_init(&data->lock);
>  		init_waitqueue_head (&data->wait);
>  
> -		strncpy (data->name, ep->name, sizeof (data->name) - 1);
> +		strscpy(data->name, ep->name);
>  		refcount_set (&data->count, 1);
>  		data->dev = dev;
>  		get_dev (dev);

-- 
Kees Cook
