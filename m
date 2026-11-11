Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434670;
	b=2RaJlGrt0AIf0osrk6ZfJMoY4+tUUwEjESIFMCTql0yd6Y2rCyEQB8xuUqHUqK5Ea8iD
	 9RnqyFGfZxFwbIaUBsaluOVZx34q0XX+1nPeZvmrkwOQA+Z1aiSDB3McpwUe3MM9iHd2b
	 mNMKGEc/JvS/G3T/u5zf8gMugf+03ubz9vZjPENsD/ru5Z9ReXW0KzSGwr0SPN1MBNPlw
	 grwaYTLS4TA99d1UQwmcF551QpHv8mjQdN/GzemyYimxL+O/k6Z5frDRJdjgNBw/MfzcM
	 UGIRZyq3Xoz7cViJO8HID72uahlERb2cxq0E+v1qNZOsNOKFyR6om+M1uCguijgxW3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nzxOIbpVWvN1/7w7Gefz50DVN7UAEAU8g5PqRLWlbIs=;
	b=O8WKob+Zu86YBoSnSNYSTtIPDpVpu/mRUDBlvIVewJBmd2YNGgTW9wabziL/vmBq7YM6
	 wFLZdSu3ViCz3LXRxCgfdMClMM5NCbdupP30X6OZfbqTJ9Mlk/bVDUjZsRlLwRNEGbiL6
	 USCOLDApV21Uhv0Q1fgYl8uGsxWb1ROd8V7ZvylEVsbG5mEL981/OgWj65i/a2J1D7CIg
	 HXgggH3y/EU9c5mgtEnVubQhydP955zvH6jML3lPkcAvYkwvMZj7PjPu8G2qoMitFZlEc
	 +kk4KZsWShK+9iinLhBFrmyAHlhrjz3mtdQ7L6YsngG+rAOf8q0U4u4PtSNqZwE09pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LU7GxPKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DA3606A331;
	Wed, 11 Nov 2026 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LU7GxPKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AC51F00A05;
	Wed, 11 Nov 2026 22:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434670;
	bh=nzxOIbpVWvN1/7w7Gefz50DVN7UAEAU8g5PqRLWlbIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LU7GxPKI5n8f1/eFXRMUCp8bBPzHUzSZVdG7KSr//4qrmweTs4YE133NVhBI6TvTh
	 JdR6QgYr5cp3sJ0Io1vkqPZAvaDvRB/r1Kwp+aquWMHwdeiusSBaFNRuiqW3lwFGg1
	 EXDK9ejy199Ydh62HTLOj6jlJZpIiM/05MVhUG+NzSJp97/w42z8ADMnerfLiJFmCc
	 5EVZywoMkbSKVUNxdvM+7fJrAkkKBEkU3iHKezFMGKcGXCZssNkoHPoqxuuRUO4zEP
	 1aPo3mPJTKC8ETN+9rBJJkYyWsVup+RPAPXOlR+YOb5dNcOgvhQTAt5V2VLfdFeTkQ
	 IQtDOZ92kD8ww==
Date: Wed, 11 Nov 2026 23:04:24 +0100
From: Thorsten Blum <blum@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: nicolas.dufresne@collabora.com, benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de, mchehab@kernel.org,
	hverkuil+cisco@kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kees@kernel.org,
	justinstitt@google.com, morbo@google.com,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v2] media: verisilicon: Replace strlcat() with scnprintf()
Message-ID: <avTmaEUzcTHR-Q6W@kernel.org>
References: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
 <20261111032446.29803-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111032446.29803-1-nikitash.mariiaw@gmail.com>

On Tue, Nov 10, 2026 at 07:24:46PM -0800, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API [1], replace the
> strscpy() and strlcat() calls in hantro_add_func() with a single
> scnprintf() call.
> 
> This preserves the resulting string, including NUL termination
> and truncation behavior.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> ---
> Changes in v2:
> - Replace seq_buf with a single scnprintf() call, as suggested
>   by Hans Verkuil.
> 
>  drivers/media/platform/verisilicon/hantro_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Nit: the prefix "media: hantro:" would probably be a better fit.

Otherwise, this looks good to me.

Reviewed-by: Thorsten Blum <blum@kernel.org>
