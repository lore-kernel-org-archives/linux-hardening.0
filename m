Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B440D58C
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043189; cv=none; b=Z1a4ucaAtVMxnz99Nacz0LvwFFIAJnDRWutF+ZAKVf2d6lDFXa8W/46ljdbzHoKDTcGfZw/J51ummiVNWi459b5AkR8rKfYpsLPLrTvueFh2/WVfRU+ZlHRAJciK1dRsydOdvk44L1ZQS2RJfTd8m0HrC9LmV6AqmLcmMxtYs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043189; c=relaxed/simple;
	bh=qagFDp3J5fIfiyzBNIi1t4DhzgkTYU0l51sSsmyjYQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omAux7O9EmdXSe8aWocfn+6UeBqr3+IUT9H2EMi/JZAFgIRbMGu1aaOOYxZ7bQ8gHICrbaa0n3kQ4zgflDErsAhLp4gu08EG/hteRlQsJGhmCJUuHyo3sSdu6DJM6APgd1MxxlyI9N8IESQXw9S0uDcMYihWkqWhLekiSbjAuXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvTmT4+g; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvTmT4+g"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4863cd278d7so3819677b6e.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 15:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043186; x=1781647986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2SuYOT/HPXvKrCZtDe/qeMWaHPEqePbJHi5tDeXlEA=;
        b=hvTmT4+gEnDiH5ui0as01NC1roZS3n0EaARgy72wRnkbR5eMbnpE/jyfX5v8shlPip
         jYJQlr3fK2ixyqC1IJwS20BZ0Hij3NyWsR29OzksMCxhlTfEltc0gUUrMRCd2vctcb0h
         MHJ3BlA/8XgeAdTsL8VzS+7v12JfNUD5DegI5dGyM/D04CLFJGkXev1d/yVOcfjLMCF8
         hCbcQaKYkfAa6Lu2AixKt+zgJNfZSBT72Atpl6dx2i4CcE8qYHQ90vxK9sFnjgblKfcF
         kKghq3tZbcQg8+MFo2QzOGZa9eHmgwE6hUYU2RiV+XJym2ikPPW80Jx+0omexY8zMiOh
         2z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043186; x=1781647986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2SuYOT/HPXvKrCZtDe/qeMWaHPEqePbJHi5tDeXlEA=;
        b=n8a9ambWYdnJkyy1vHC+MH2xCtcubm8zlTtx23GxVdiI9pcHMYObDII0ZkmLd7b2YG
         5G3RNncejPi07HOJN+jHGLwAJGz4728PYY7TmQr8LHTfVBxEvY89k3d9p1Eu+WAmDW8L
         PnPcktYyRVhCDqNXOndG6syo9g6z3lTTLgX1B7eQGVXb9120OYt+QRVy0whZ/9F56rwX
         usan75co1xqgh/W5EtYxr0JxNCgxukVL5l73OBxMyyvuzVmRcIEdoTlLFr1+OjP2D8VP
         xsvVFa84bVLsk39t5CbBiAxGTA7BXTBif7KpHXfSlC7khIzQ4/cOilv5mggBbUgagoAc
         JJTw==
X-Forwarded-Encrypted: i=1; AFNElJ+KIcP5/9sI8Nz7cHKTxrYSyAtiD/rv/eZQQvq55Eq25a8Z3cxj5hui6+zhvuj+2fMvL2HhBNQj2Dt+Pstdh4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfsEny1d+1vdc/c0HEvOeU0mJ/vD8DHm0ZyzXKPD+rvEzuNwO
	AWczaKL9KdxFQdUbBbMKG/YW6CdldcG+RKKv4i656BaGxA+sSRp7BWc8
X-Gm-Gg: Acq92OEvvSZKrNU9jA+wJS/ExFVSy/ninTSi3BEdShmJf8Lnx8wBwDyXz7Qv5OOcdI4
	9RvC/BYAV8H5iMfqqo0MgjxVQMY6//J2amzBsNFXQnFaJi1GPgRWt+9GvArt3xqTydFWTcf1Ri9
	PzTwlRDjTche74tRLujllBRDPgg2coYpqYo3P6PVbEWDQv3djYpGXpfOMalp5mVTDTsIjf8NnCd
	47EKrJycvs261QAVDbpMpvKLzsYYs+0+0I2C63ULZGyA2bP6REFcwIKXGXJWktzbqyjklEukYcR
	mNp1oAnvWDqPFXh0+72Yz712b1OWTaWft/oFSljwccdBtfDLEC45IpclGjosln5CfUpZWpQe1C7
	+wSEl/Tp2v8hmZ7tzl6upr7Q0lHGOrAZuFnejRt6lnVmrUS3j3ZFuCuklfyWiKzbHs9ddYwiiwD
	XeuhELat+TrQXaof5E8vCpDWXlOTMjS5Qo8+Y/ICCxR/DLPhkdSjyMNBMksMZz+Bg=
X-Received: by 2002:a05:6808:1190:b0:482:4df4:ef5 with SMTP id 5614622812f47-4868dc826ccmr13806953b6e.3.1781043185864;
        Tue, 09 Jun 2026 15:13:05 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm17105048b6e.4.2026.06.09.15.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:13:05 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:13:02 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 11/12] iio: dac: ad5686: write_raw: use
 guard(mutex)()
Message-ID: <20260609171302.5764edb2@linuxescape>
In-Reply-To: <20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 11:13:06 +0100
Rodrigo Alencar via B4 Relay
<devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use guarded mutex lock to facilitate code review when adding new
> attributes. This will allow for early returns, avoiding error-prone
> locking and unlocking in error paths. Gain-control support will add
> the scale attribute.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 

I agree with Joshua on this, linux/cleanup.h should definitely be
included. However I don't think sending a v3 is worth the trouble
(Jonathan may tweak while applying but I wouldn't count on it), so with
or without:

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

-- 
best regards,
max
