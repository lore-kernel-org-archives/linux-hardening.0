Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D3216E39;
	Mon,  3 Mar 2025 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027463; cv=none; b=bUpnP2OCa/LBHrubq4DAVwbVuwAmyQcT7PxA12tzpF4ouk8eQ2XmTDLbLVBbUtdi0c5urSNFXSOCgj4s6En3wHbRIT8vjZupnXX8gOkygCdqC4OwcKjMO4/bMuKGct7/KBGwMbBYBJjWjytrna8pZYMkTNe4sUESTXYoN3W4s8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027463; c=relaxed/simple;
	bh=5BSrm78ZdiZpd6d7RFmo04AXI1XgqE2bODxVuNYHABw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8Yra/C1EthI/WNCxq7gpoJZBzaJAhqUdOli9I0evpP3KrN5F3Xz+kcn7d9AKFi0YJC57Kw4YNEH/MeLhiUkZEU6GmtDfeKGQbeW/wN7uJv2lp/z+O1QQL7R3av7KTgnvSycJ3xwhuzuqImshAaKiy+QN85sc9Z+0ZwKvD8zzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtW73n4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtW73n4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2D3C4CED6;
	Mon,  3 Mar 2025 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027463;
	bh=5BSrm78ZdiZpd6d7RFmo04AXI1XgqE2bODxVuNYHABw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MtW73n4Vj+GsxA+mk7MCxqoWRKoRIvGlHPK6uh5KhGrUzxVybpwLq3d+c64EsgKhv
	 ZobD32ctEGxCuutKNlIfWe0FTE+0w542eruf/QTiz6J4t/F/VbP/LgKYS9e32p450W
	 o+ghU6v32K7qaofVjH9cIsGSoZITeiw9V14jyWs3xq8UzACPSANnpVvO6Uga7uhT9r
	 3eg7zZ9sTiNEEHtlaneUSTmTBhi+W7iy3eMCuM7cZoueILx7gMg2j3Rp5Sz2xdady1
	 rIgZJ1XayJ3DaX7ByXGrxQf4RH82LdpK5byozFg6rvycCjKYbP0GTPAPxDyZPnb4UZ
	 W1dLjIgKS9k4w==
Date: Mon, 3 Mar 2025 10:44:20 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Peter Rosin <peda@axentia.se>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
Message-ID: <202503031040.223DEF2781@keescook>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302230220.245739-3-thorsten.blum@linux.dev>

On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
> Convert mux_control_ops to a flexible array member at the end of the
> mux_chip struct and add the __counted_by() compiler attribute to
> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() to calculate the number of bytes to allocate for a new
> mux chip and to remove the following Coccinelle/coccicheck warning:
> 
>   WARNING: Use struct_size
> 
> Use size_add() to safely add any extra bytes.
> 
> Compile-tested only.

I believe this will fail at runtime. Note that sizeof_priv follows the
allocation, so at the very least, you'd need to update:

static inline void *mux_chip_priv(struct mux_chip *mux_chip)
{
        return &mux_chip->mux[mux_chip->controllers];
}

to not use the mux array itself as a location reference because it will
be seen as out of bounds.

To deal with this, the location will need to be calculated using
mux_chip as the base, not mux_chip->mux as the base. For example, see
commit 838ae9f45c4e ("nouveau/gsp: Avoid addressing beyond end of rpc->entries")

-Kees

> 
> Link: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/mux/core.c         | 7 +++----
>  include/linux/mux/driver.h | 4 ++--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 02be4ba37257..a3840fe0995f 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -98,13 +98,12 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
>  	if (WARN_ON(!dev || !controllers))
>  		return ERR_PTR(-EINVAL);
>  
> -	mux_chip = kzalloc(sizeof(*mux_chip) +
> -			   controllers * sizeof(*mux_chip->mux) +
> -			   sizeof_priv, GFP_KERNEL);
> +	mux_chip = kzalloc(size_add(struct_size(mux_chip, mux, controllers),
> +				    sizeof_priv),
> +			   GFP_KERNEL);
>  	if (!mux_chip)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
>  	mux_chip->dev.class = &mux_class;
>  	mux_chip->dev.type = &mux_type;
>  	mux_chip->dev.parent = dev;
> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
> index 18824064f8c0..e58e59354e23 100644
> --- a/include/linux/mux/driver.h
> +++ b/include/linux/mux/driver.h
> @@ -56,18 +56,18 @@ struct mux_control {
>  /**
>   * struct mux_chip -	Represents a chip holding mux controllers.
>   * @controllers:	Number of mux controllers handled by the chip.
> - * @mux:		Array of mux controllers that are handled.
>   * @dev:		Device structure.
>   * @id:			Used to identify the device internally.
>   * @ops:		Mux controller operations.
> + * @mux:		Array of mux controllers that are handled.
>   */
>  struct mux_chip {
>  	unsigned int controllers;
> -	struct mux_control *mux;
>  	struct device dev;
>  	int id;
>  
>  	const struct mux_control_ops *ops;
> +	struct mux_control mux[] __counted_by(controllers);
>  };
>  
>  #define to_mux_chip(x) container_of((x), struct mux_chip, dev)
> -- 
> 2.48.1
> 
> 

-- 
Kees Cook
