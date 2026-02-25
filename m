Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830121B192;
	Wed, 25 Feb 2026 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052961; cv=none; b=unqVq/5/z7paT1l1oOCDh+RSLRkEs0ujwSwYFD5UVAyOCDY35edLeD2oSBJAfIvN4yPrnyNoivavwqvJOeeAzNk14iNWSmQ+KzErRUG2FX/ZDP7RwH2nDRg1afSbcsueL1K0hZGbP45IPB0xZMZGTlqjt6bbKbQlDZlpXcsMtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052961; c=relaxed/simple;
	bh=adIw2HzvvVKUNxw4bER7Mw4i20wDhM+s3uu7esAOwOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/WUcmf15iS4ORd/Wnq/46QGoSe3fxVPF2OaBvn7SUraqPlNb8Rpu8FEuPW9/q7tg2BEaYcisgg0q8ICbHUthYO8pCUHZrt7XRBUJJQ54U4ucX/kysxt+qgGQmoQ5q4vSjZUttZtkbqgT9JhI2MH95sPR7KZYExVDBmGW75hmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCKO3SWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCKO3SWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C24C116D0;
	Wed, 25 Feb 2026 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772052960;
	bh=adIw2HzvvVKUNxw4bER7Mw4i20wDhM+s3uu7esAOwOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCKO3SWIh9kEtlgeiO6XKm9iiU1lfFIJ3m1RZXyLDpy9DQzKVdHqQML137JPhjDeR
	 xykPQbm4z9LWcVyECIQaQT3RyYu2e7LguTlsUI3ecz7bVtucwrU5Dft3LSpk59plaJ
	 E4bVDM/m9k/diAu1vZRWB2zJzJ5BtiBgDOuMckfi0eIdf6D27kVLMTlEIRjR1baCPZ
	 v+sAdLa1+RfyXeEiPwzYxodEPzc0PR9HvfV5E3dFftuQ6XqYZUz2qvhVJhU1pvyqg9
	 djnb/LCtsHZw7C6ZC3ReBkxFt0laRandcKd6juT/logpcEEdd9mpCqyDQK84NtOSar
	 VlKXOq0sDYQoQ==
Date: Wed, 25 Feb 2026 12:56:00 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] most: usb: Use kzalloc_objs for endpoint address array
Message-ID: <202602251250.D5F6E027@keescook>
References: <20260225180329.712101-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225180329.712101-2-thorsten.blum@linux.dev>

On Wed, Feb 25, 2026 at 07:03:29PM +0100, Thorsten Blum wrote:
> Replace kcalloc() with kzalloc_objs() when allocating the endpoint
> address array to keep the size type-safe and match nearby allocations.
> Reformat ->busy_urbs allocation to a single line. No functional change.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/most/most_usb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
> index d2c0875727a3..6437733afee0 100644
> --- a/drivers/most/most_usb.c
> +++ b/drivers/most/most_usb.c
> @@ -1009,13 +1009,11 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
>  		goto err_free_conf;
>  
>  	mdev->iface.channel_vector = mdev->cap;
> -	mdev->ep_address =
> -		kcalloc(num_endpoints, sizeof(*mdev->ep_address), GFP_KERNEL);
> +	mdev->ep_address = kzalloc_objs(*mdev->ep_address, num_endpoints);

This case was skipped because mdev->ep_address is "u8 *". This is a
pretty long way to go about allocating "num_endpoints"-many bytes.
Perhaps this should just be:

	mdev->ep_address = kzalloc(num_endpoints, GFP_KERNEL);

Though maybe in keeping with all the other num_endpoints allocations,
your patch is fine as-is. I'd be nice to use __counted_by_ptr() here,
but the num_endpoints is in a sub-structure, which isn't supported yet.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
