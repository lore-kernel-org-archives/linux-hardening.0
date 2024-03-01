Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BDC3D544
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325722; cv=none; b=ZgycXHBIioHPT26VPfU/Q6me1E4PrCZQVYXF9LzbGQ1lCSM5VDjdXD5L2MgxoIO2lArie1n/dy4WBp59+fqwQ08+zXRwHY1Y3miTSj0r/VTU7PxIbkxEyXHNMEkRWBplEy6Dwwr0BsoqV2h2hXAJ/dhKFqXVKtLcrlZ49jKjRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325722; c=relaxed/simple;
	bh=b00h7L6AGlfaD5kvd71sZ7vd6gXSPpX60QhiF/qhUzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6YRyxFD3YgUxMNYPyzKjFDO+7ClpaXm0DX8rLnWFdXAAX0S1wKpg0lKJ2pALqGCCrX5fmvlR9aajTJEo9z1SDf/mE4iRZHcpWF5c5+78vFTuLkDSOVZjkaVvm4PLhcgabKEZFjhnozO0jJNQSVxr8H/MWSUHQO1heBk3wGeZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SEUoTPHn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SEUoTPHn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e58d259601so1627798b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325720; x=1709930520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8fnGBiVDyvj0+sJf46kp+vk3quKyy9Lc46ziSRLCxE=;
        b=SEUoTPHn2JRwBvVhJO/3HAb1PqWgDpVUy2Y6wftKnM9qb36vU1yO0P5JAoLtHIz39g
         Vhx/PL9u1UfMVRrDa/e3wy2YAZOx6ZQgmWNJEvImR4WQtuNNyL4fde10ppdyFYelSRyZ
         8aKheVPSidhC9OZxizwRDS86gn1jvyQYULShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325720; x=1709930520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8fnGBiVDyvj0+sJf46kp+vk3quKyy9Lc46ziSRLCxE=;
        b=rObWxwTDSIfKAVQGdji6+uBd2Zn1w/wMEpzKyrXmUYBao+Yn2lc7fJP3g0y9ETf+Or
         QeRutfQlhaRExMZPoMKULl682GJpSudEsErby7VK8Fbni+3uIN5SVZZtJa6aUgoIX1DU
         by5lZRTLvq9BIWjTVSla4bPufT+TotMCH8bd3W05wKXNAFy5+R8RdfiwWIMzr5jiDizH
         BUL77nOaP9lF6jx/44J8T+kRnZjNSOTTlkqul6qQ8fPvqZdD6mSmNO3sYZy9wpYsWghK
         jVezPopLKlV9whQAXuTrTJy6mjsXcB7vv8SE1oFxgQRfc10LzKM8/uz0XDkMWdf+nKd1
         iyqg==
X-Forwarded-Encrypted: i=1; AJvYcCWplgsJnsG4Tx+Is+g1xZfVVI5aKkvinaq7V75jlXXQ7aG+ONfcSZINaA1gXSgscO/DXzxEyTVsTeh66lfSQ6M1K6A/NcFK9uTgplMRc9NC
X-Gm-Message-State: AOJu0YzIU0L0CM45bZ3S17VfaJ15eUsWul4f/2h5IGnR4bnt9yo1Ulsf
	KNWEbsl6Fhi1j8wXaK2dhI6uaGkgMj4c34pYbF3H5N4B8IlqQrwzf9xg7GoNo0GCQtSBZG71TIM
	=
X-Google-Smtp-Source: AGHT+IEi6FI+IEbwGBctosMmFcuCICddCBpYdWwOsgDnXRw+Iqlkx7u/X41Y65hzbIQOLhuXmk2gFg==
X-Received: by 2002:a05:6a20:299e:b0:1a0:e4a6:2d86 with SMTP id f30-20020a056a20299e00b001a0e4a62d86mr2273919pzh.59.1709325720658;
        Fri, 01 Mar 2024 12:42:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r6-20020a62e406000000b006e0416c42c3sm3375303pfh.198.2024.03.01.12.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:42:00 -0800 (PST)
Date: Fri, 1 Mar 2024 12:41:59 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: axi-spi-engine: use __counted_by() attribute
Message-ID: <202403011235.C326E3D46@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-2-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-2-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:19PM -0600, David Lechner wrote:
> This adds the __counted_by() attribute to the flex array at the end of
> struct spi_engine_program in the AXI SPI Engine controller driver.
> 
> Suggested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index d89f75170c9e..e801eed820df 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -75,7 +75,7 @@
>  
>  struct spi_engine_program {
>  	unsigned int length;
> -	uint16_t instructions[];
> +	uint16_t instructions[] __counted_by(length);
>  };

You'll also need to change places where you deal with changes to
"length", as now accesses to "instructions" will be bounds-checked
by the compiler. For example, this change:

static void spi_engine_program_add_cmd(struct spi_engine_program *p,
         bool dry, uint16_t cmd)
{
         p->length++;
         if (!dry)
                 p->instructions[p->length - 1] = cmd;
}

-- 
Kees Cook
