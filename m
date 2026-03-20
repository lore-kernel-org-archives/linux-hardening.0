Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1932C0298;
	Fri, 20 Mar 2026 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031558; cv=none; b=gFe3QdDE3wNGyGy6KmBiFnRV7RpxmnEynX/dmr+AvYgjpVbPBc+O4Om7YgQ4/UKq3oKzGXjTJlJ07sQ0KNKDIIxy5lX5vPwWp77UExmuX8h7pPK0FOhKBD1n9igxnpROpGS80fzJfTunup08VG9Cm5UQ9crL1zNfbkit4mrGzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031558; c=relaxed/simple;
	bh=pY481yzdsrUvkHEvpVDOYWKFxW9PhHpIuM//ewGf95Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXrfntXbwZyuWwSX5tufJfzRiDosD1H1Za9PW/NEl1+E8FqgE3QMcT8TCq0quk+bLxXB8e3CzutHLahnbbMC8zyefBquxV/I9SpkYJI76unPmyMiVeaZB0yJDZ/w8jKMQvibN7qSfLaQMJwXkzBSo1Tyg+Cy/dCUHrPH/hCkJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp4upb1j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp4upb1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3194C4CEF7;
	Fri, 20 Mar 2026 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774031557;
	bh=pY481yzdsrUvkHEvpVDOYWKFxW9PhHpIuM//ewGf95Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jp4upb1jpiE6Q5EkVAiJr79fytYg7leaQgWLxAR50WVh7+viRIjFb1c3xMmVPoRBF
	 OvenfGHRH/el/iNmD+0Ti6qg8n0Nnr/afp8yEfjM43h2JQI7XnftB94VZWq3aEPc2T
	 lyxWsKwLCZXweO5eG+ES3HhLisTEuyuY2u2xyocxr0rrUbnENjPzsrbviM4Jgn8HoZ
	 RpQZtPZyyBvMTTI04wZUNjqlTy3WFI637fLnJXZjr54Y0uzHx4TW12yAGrdB+8zMt5
	 3bl3PS4P+r86MbZLGPOoPYtVvAsjuHmhFKxhOm+9NYCW12FQTTAmuTpj+rl1dCDpt2
	 V+8nJuzl6K0nA==
Date: Fri, 20 Mar 2026 11:32:37 -0700
From: Kees Cook <kees@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: platform-driver-x86@vger.kernel.org,
	Kenneth Chan <kenneth.t.chan@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: panasonic-laptop: simplify allocation of
 sinf
Message-ID: <202603201131.55E516E@keescook>
References: <20260320004928.29914-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320004928.29914-1-rosenp@gmail.com>

On Thu, Mar 19, 2026 at 05:49:28PM -0700, Rosen Penev wrote:
> Change to a flexible array member to allocate once instead of twice.
> 
> Allows using __counted_by for extra runtime analysis. Move the counting
> variable assignment to right after allocation as required by
> __counted_by.
> 
> Remove + 1 to allocation. It's already done in the previous line.

Are you sure this is an accidental +1? I see the "num_sifr++" that
happens earlier, but it's not immediately clear why either that or the
+1 in the original allocation are needed. I'd like to understand why
either/both are/aren't needed.

-Kees

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/platform/x86/panasonic-laptop.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index d923ddaa4849..4d663fffbcc8 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -248,11 +248,11 @@ struct pcc_acpi {
>  	int			ac_brightness;
>  	int			dc_brightness;
>  	int			current_brightness;
> -	u32			*sinf;
>  	struct acpi_device	*device;
>  	struct input_dev	*input_dev;
>  	struct backlight_device	*backlight;
>  	struct platform_device	*platform;
> +	u32			sinf[] __counted_by(num_sifr);
>  };
>  
>  /*
> @@ -1017,21 +1017,15 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  	 */
>  	num_sifr++;
>  
> -	pcc = kzalloc_obj(struct pcc_acpi);
> +	pcc = kzalloc_flex(*pcc, sinf, num_sifr);
>  	if (!pcc) {
>  		pr_err("Couldn't allocate mem for pcc");
>  		return -ENOMEM;
>  	}
>  
> -	pcc->sinf = kcalloc(num_sifr + 1, sizeof(u32), GFP_KERNEL);
> -	if (!pcc->sinf) {
> -		result = -ENOMEM;
> -		goto out_hotkey;
> -	}
> -
> +	pcc->num_sifr = num_sifr;
>  	pcc->device = device;
>  	pcc->handle = device->handle;
> -	pcc->num_sifr = num_sifr;
>  	device->driver_data = pcc;
>  	strscpy(acpi_device_name(device), ACPI_PCC_DEVICE_NAME);
>  	strscpy(acpi_device_class(device), ACPI_PCC_CLASS);
> @@ -1039,7 +1033,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  	result = acpi_pcc_init_input(pcc);
>  	if (result) {
>  		pr_err("Error installing keyinput handler\n");
> -		goto out_sinf;
> +		goto out_hotkey;
>  	}
>  
>  	if (!acpi_pcc_retrieve_biosdata(pcc)) {
> @@ -1111,8 +1105,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  	backlight_device_unregister(pcc->backlight);
>  out_input:
>  	input_unregister_device(pcc->input_dev);
> -out_sinf:
> -	kfree(pcc->sinf);
>  out_hotkey:
>  	kfree(pcc);
>  
> @@ -1140,7 +1132,6 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
>  
>  	input_unregister_device(pcc->input_dev);
>  
> -	kfree(pcc->sinf);
>  	kfree(pcc);
>  }
>  
> -- 
> 2.53.0
> 

-- 
Kees Cook
