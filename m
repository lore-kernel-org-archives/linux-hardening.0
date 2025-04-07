Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F150223322;
	Mon,  7 Apr 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050936; cv=none; b=ebHxOkKK2En4lGEI2MmsI8Py02u323bLwPIsBFDFcQ4O92n8FJPkUv88RDJE/WGut+LDkhKxZlVupxeqD84DgJiygXl8F4pEnI5ZfPSsIx+nymZDkMMHgKZnJzFT6A3HATgFXcadjOz526bI+BXhLF5fnD82uAsWPJvHVb+r48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050936; c=relaxed/simple;
	bh=bX0m/b/PLIXsfP0Rb6A4/at5T5eN/V1QBNChpybmFXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGWHigPK+YZfrt0arClxTYMZGVco4+6X03MnwblxeRDx59O0B9Bw8WMNJ8iniQQfz7O3EYa5J7AO8olq0QnSsJPFtbUdk1aNTF3lO1rmO/Z7GYJlHwTgDm2p3dDiMROU4ziPQNtCkanysZYWW658SqzACmDPXdENq6Ze0+e6occ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQKBqAxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQKBqAxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363E8C4CEDD;
	Mon,  7 Apr 2025 18:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744050936;
	bh=bX0m/b/PLIXsfP0Rb6A4/at5T5eN/V1QBNChpybmFXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQKBqAxkScUYrhK2HAxoeJ/9wv1TFHB1k4XIYwgH0PUhYmN8yUx3wUZaGWxwClWI3
	 gH8pDIwY62b9h+taQYfK0N+HU8FQR3QlSQn5ZdrbnPqfRKXqrl/gQd/lU3dAOZMH4F
	 GbXupJgPUb6lzU36A7sKEFbrV3bMf1S/IrKxl81DETLejRTPksatdcgIVADI5y98f/
	 IACWxtL3GZyodOIMpFPlZCPROAGygg6gImCw8KgUN2sR5D45YID0cKnTI0RGFP9ZZz
	 GKjgJV+FlsiVaoddwZ+ewawhR/7jpHUUi4hLifYpITPfnjf6II1zNRklmi4v/g+AzV
	 W6m7M3yRk038w==
Date: Mon, 7 Apr 2025 11:35:33 -0700
From: Kees Cook <kees@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] regulator: hi6421v600: Truncate long strings for
 trailing NUL
Message-ID: <202504071134.1AAF30CAF5@keescook>
References: <20250310222408.work.339-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310222408.work.339-kees@kernel.org>

On Mon, Mar 10, 2025 at 03:24:09PM -0700, Kees Cook wrote:
> GCC 15's -Wunterminated-string-initialization saw that these strings
> were being truncated. Adjust the initializer so that the needed final
> NUL character will be present.
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  drivers/regulator/hi6421v600-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
> index e5f6fbfc9016..e74f992fd85f 100644
> --- a/drivers/regulator/hi6421v600-regulator.c
> +++ b/drivers/regulator/hi6421v600-regulator.c
> @@ -275,7 +275,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
>  }
>  
>  static const struct platform_device_id hi6421_spmi_regulator_table[] = {
> -	{ .name = "hi6421v600-regulator" },
> +	{ .name = "hi6421v600-regulato" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(platform, hi6421_spmi_regulator_table);
> @@ -283,7 +283,7 @@ MODULE_DEVICE_TABLE(platform, hi6421_spmi_regulator_table);
>  static struct platform_driver hi6421_spmi_regulator_driver = {
>  	.id_table = hi6421_spmi_regulator_table,
>  	.driver = {
> -		.name = "hi6421v600-regulator",
> +		.name = "hi6421v600-regulato",
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe	= hi6421_spmi_regulator_probe,

Friendly ping on this patch. Who can pick this up?

Thanks!

-Kees

-- 
Kees Cook
