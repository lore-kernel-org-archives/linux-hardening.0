Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E830EF92
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793866; cv=none; b=k7vGS0QiP/NV9LB/AEz8go/TeJRnaYkA+GMnthrJqVx0DG/dUlFEQ5H9ieqDYV6vRnptUtQz7P3kRZgZdcg8o4Q8DeW8kCke7UWKXjoeI+wqA8xy5amKnrdN/XuU6BYG872Xp0tcOJxhy/DGHBIdlfLL8TAkh067HtXDahWjOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793866; c=relaxed/simple;
	bh=Yu6YeUOnFWPrCqIB5YEhtWIJyvV2BtUwFJn4XL9Gr70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCSbm91devksUmiYLqQ2fRhm08vs8K8oE5GCBSpXbFVFpYSkHhOUzTT0nVD7oPQJUIxneyiAJrnbZGQXcv1MCcpc2wnbFXAgGm33QACij61BPn7zQv/fMg9iQ/YEb9Ov5hfObfSTvmgGE4QvxDEp4b/ImqCm54F2rhpQG2PpjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeZm+h0M; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeZm+h0M"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-463f1165e16so882194f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781793862; x=1782398662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LemwOVSIrC22MjpNchRABfurYl4fHAx2ajxQmykJZ0A=;
        b=PeZm+h0MeG/A4/vv6gjIH0cRQLAoj4HR9JrACHWMuI476CY1k5gxpPl4O1f7KE/bra
         kaINdOfHenQopsMxCwSzvrhxH0snVHNZZNFYrArNkbfbFu9M4SLt5RP1/hI5UjYPSG+7
         uZ8sBJiEb18lP2gu4tl5zLgmgsVmREZ8uRatSMWukfDqGnp1CBKoyRSQjshkfFrFtz4u
         Sm53tA+s4coHz+RTU3+DyNUtjb2p2EDXnt1b0z3D26bgzWyX/i8N2s7y8a3EF0PVdhm+
         A8Hxy8ifIkZO6i889+NLb5uWt7u64mXks1uiFqczlrpmwYtrHsALfv4900rh4FmX5Nwn
         w1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781793862; x=1782398662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LemwOVSIrC22MjpNchRABfurYl4fHAx2ajxQmykJZ0A=;
        b=JCV0Rmdhg8FGy0vzsjvW+46rMiv5PONDBukPnwVuDYwzL1Q4jtILSNbwt/FNVWXZoP
         zsq6hYgVo5yyxnCCf3EyW87BTzf4KMlRCsFbQdE3w8uHN9BJc4+ZxSKQaFSnPEL3xJMV
         AmDUlVgj5nCjOfU9u+XFhSsLzPMg2AlM7L8Rib0dNbUVt2x1Duk6/QjlRk1RZ6CAikiI
         H0R8Usp9e9Dw9O0VegGXRg7LHXksvv27FRIGoT6cnrXpJM5e+mUG1Du2Lb1g0qMprOWW
         4Ln8bvtnkGDFHTcv/ml6DEcV3XY2mI8D0KT0qWz15oml5qpNpPDQYgfu6yZA9PidyGQg
         0mBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mxgcpPEo3fCMLbFibExXl6oOTixGI4+/YCGuJSCVIB5w5yWi1+p66sP+aVWix8KRCqcgOIjnK1dLJ2VqC2Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiFD8IfhhGAgiUPvVS1uXEjKgO9HayV1fof524/HQNClvZsv5
	8SXAiM+xo67BWIQUq4w2sppD13FF9pDOhW32a6c9iukdNIg9Ojjdbypj
X-Gm-Gg: AfdE7cl/uFTmYQlmyFvNb5osNDkGPuECLHtHRhwpJRQJfLaDESJItldWdejm2CrQP0F
	gv3fDJnJgHwjkw5wwUgjiyyCRRz6ose3OWBhXzDuOgN7q/tmm3KTF0Kx8zR0/f6iBLvlXqJk68o
	khpSfKPtP/Hpcc4aoAeUE/5LjR5QNoKqm1fXTEA7I5UXTTO1ForasWApdJSUkqwalzrLXCCzxzJ
	5ISKZb7FcfDlyy7bOt9aCNSskPaX5W+/rvm/IkCBvY21Z0G5wI5xEHfh8y7IwM6FL3q5ldsMt2d
	wwQfHO2scGlr9c56F7F4K5+jbtFiZwWAn8ZUBBtK4zYd5844nm8htFS/soXZYDvB3yIY2uYfXjV
	EUQbQcVRrV1b8Ldfy/lKqohH+ZOF9aCc+bA1wI9O7Gon6tqDZU8CU7juUi41DayQB0CtxXG66xn
	WWMysH
X-Received: by 2002:adf:e811:0:b0:460:1233:ecf2 with SMTP id ffacd0b85a97d-4623908e11dmr12410883f8f.30.1781793861659;
        Thu, 18 Jun 2026 07:44:21 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b1083e3sm20736217f8f.20.2026.06.18.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:44:21 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:45:23 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 05/16] iio: core: support 64-bit register through
 debugfs
Message-ID: <ajQDsZWJQRKKM0dv@nsa>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-5-79125ffbe430@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618-ad9910-iio-driver-v6-5-79125ffbe430@analog.com>

On Thu, Jun 18, 2026 at 02:27:21PM +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add debugfs_reg64_access function pointer field into iio_info and modify
> file operation callbacks to favor 64-bit variant when it is available.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 33 ++++++++++++++++++++++++---------
>  include/linux/iio/iio-opaque.h  |  2 +-
>  include/linux/iio/iio.h         |  4 ++++
>  3 files changed, 29 insertions(+), 10 deletions(-)
> 
> @@ -471,7 +485,8 @@ static void iio_device_register_debugfs(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque;
>  
> -	if (indio_dev->info->debugfs_reg_access == NULL)
> +	if (!indio_dev->info->debugfs_reg_access &&
> +	    !indio_dev->info->debugfs_reg64_access)
>  		return;

Not really that important but should dev_warn() in case someone gives
both callbacks? Can't use both anyways.

(We now have agentic help reviewing the code so maybe even if someone
does it for some reason it won't pass review :))

- Nuno Sá
>  
>  	if (!iio_debugfs_dentry)
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index b87841a355f8..98330385e08d 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -73,7 +73,7 @@ struct iio_dev_opaque {
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry			*debugfs_dentry;
>  	unsigned int			cached_reg_addr;
> -	char				read_buf[20];
> +	char				read_buf[24];
>  	unsigned int			read_buf_len;
>  #endif
>  };
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 711c00f67371..1c7d12af22da 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -484,6 +484,7 @@ struct iio_trigger; /* forward declaration */
>   * @update_scan_mode:	function to configure device and scan buffer when
>   *			channels have changed
>   * @debugfs_reg_access:	function to read or write register value of device
> + * @debugfs_reg64_access: function to read or write 64-bit register value of device
>   * @fwnode_xlate:	fwnode based function pointer to obtain channel specifier index.
>   * @hwfifo_set_watermark: function pointer to set the current hardware
>   *			fifo watermark level; see hwfifo_* entries in
> @@ -572,6 +573,9 @@ struct iio_info {
>  	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
>  				  unsigned int reg, unsigned int writeval,
>  				  unsigned int *readval);
> +	int (*debugfs_reg64_access)(struct iio_dev *indio_dev,
> +				    unsigned int reg, u64 writeval,
> +				    u64 *readval);
>  	int (*fwnode_xlate)(struct iio_dev *indio_dev,
>  			    const struct fwnode_reference_args *iiospec);
>  	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned int val);
> 
> -- 
> 2.43.0
> 
> 
