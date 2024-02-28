Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194D86246
	for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153873; cv=none; b=pQvMcHzkEuLkQ5sX0/Koalyc+APPTCg8Qaz0tgIQSWhFVQIgtcKMdljTeLkVlIby1SYvawYk2Wu4uNsMtWEy6+WsWczSXn6gh85CdPWxquPxXR0a/FmaWkyxR4HSz9zuqpbxVGmSIvhAmmE3TNoAF+GOEHILCymNjKNGNfzNjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153873; c=relaxed/simple;
	bh=BWK+pvcfV2O3YEKV4oJw3LGLSCHFNN4QIpIDXt2sN9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sv2uf9Kk1J3/vZeOv4IZ0fOfN/EbCB+4NfBjy2rh32eYVBd0mGqdGaOW2wOMtfbcgw6C3Wxw/9MNAnpptVhNENOFuPouuTuvAyzsej7ZXHCQ2mQsbSO1mUmvZTe8XCJjOt+wvDSkRxbyY49oDiBbwgO/2n7UHw96sgniJ99lLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YDLSFNYe; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YDLSFNYe"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28464c554so1929101fa.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 12:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709153868; x=1709758668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e4AfvVPSrhK1drWl8zME51ZTsz4Zd61RouuRi/BwYE=;
        b=YDLSFNYeZ2o8Li6YIKeBGjjEV1kXv9SKeZuDq5S5eAVipbpetuMbCWEnCtG+QHk7mN
         rjY+6cFF2NjPLzUuFxwszsvVtrAcdzCT2/gUE/xhEzsQT7Bo0zaMFSjaZas3fmJg3cdP
         3nlzYqqg8fMvvTrkkCdiRdZKwuIYnveoqAiEr+FVRccHeNYbVZNot0ZxL34JlLIM/+LC
         pcNy1g4BmM4j874sUSAVYSaXaiKNAQ9WVu1u6RhJ37XdusAslPOq+fxYEbnLQs23J7wt
         tI4a8VRHDWgmuA2SIEdEkEuyUtcclgoCMkE0WBAdzDvphKUGu2TGbjerOvXbBUFpmDtU
         uBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709153868; x=1709758668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e4AfvVPSrhK1drWl8zME51ZTsz4Zd61RouuRi/BwYE=;
        b=gb5fWzh3B0LpwwF6Qwtjp8je12cuyYd92o2IhZU7ZO25vSrnCS4ZJwM2Lk0tpHf37X
         nvTQopygR3MDar3zCNhwj57px4F7iXFv8qPYtjL17AyoyCaTK5WEuNT7DxoGX0gAk2S2
         y7jUPQWFvJ1u8bA57AOy/9dTVxcrSkrxLrQYVDFXIP8rtA1/ED8KUH7aIvHi529NfzmU
         gI8sFGv1MElFR3yf6pGiYC4y5YOTdpyCw1EEr+9yXBNsptUQ2k/9IhlOR4nKuij+abB0
         K5X7Zcih37ehTBoJZZWA6s98x+NT3Vk5I3W9UHj0yobbmqRcfjGi+MBY5QK2y60uVZmP
         Lv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKdxnuuRnoBM7MlthQpjpA66H8eb59xyMNmT20hik0tSoyFgsif4MW2GaXmI3PGDSw2S8HSlBBfszggRogQP3hqeDC1gVHGA7bNwlpCkyx
X-Gm-Message-State: AOJu0Yx+WeB3X/bb6nqTIJGzNnTexuUHl5HgmBkLeajWCMWrOJiDvb0C
	q4rVe/9kz0Corn/i2Zmxs+/GT1JKl66c8nYSsuOZE1mdmigPdkFglaAue7EXZCEV0/+i8pNW3DN
	wjPg1D4KNgv31UxBqjUMgan1TEJ1Uo8pHPuaONg==
X-Google-Smtp-Source: AGHT+IEOnOOyvWjN2Iqi7AnFbpftsb9Ykrl/ECUJUwlscNtR6jsb4MdUfMY/fGs0PnTtZQ7ONz+3NPiATH7jgCyTqPQ=
X-Received: by 2002:a05:651c:14a:b0:2d2:b452:3adf with SMTP id
 c10-20020a05651c014a00b002d2b4523adfmr24174ljd.27.1709153868001; Wed, 28 Feb
 2024 12:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com> <20240228204919.3680786-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228204919.3680786-5-andriy.shevchenko@linux.intel.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 28 Feb 2024 14:57:36 -0600
Message-ID: <CAMknhBGj_+hw0F-g3R6iY0HEooGH1a8gfj1hYx_Laj93OQbQwQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] iio: core: Calculate alloc_size only once in iio_device_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> No need to rewrite the value, instead use 'else' branch.
> This will also help further refactoring the code later on.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/industrialio-core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index bd305fa87093..1986b3386307 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1643,11 +1643,10 @@ struct iio_dev *iio_device_alloc(struct device *p=
arent, int sizeof_priv)
>         struct iio_dev *indio_dev;
>         size_t alloc_size;
>
> -       alloc_size =3D sizeof(struct iio_dev_opaque);
> -       if (sizeof_priv) {
> -               alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN);
> -               alloc_size +=3D sizeof_priv;
> -       }
> +       if (sizeof_priv)
> +               alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN) + size=
of_priv;

Isn't this using alloc_size before it is assigned? Perhaps you meant this:

    alloc_size =3D ALIGN(sizeof(struct iio_dev_opaque),
IIO_DMA_MINALIGN) + sizeof_priv;


> +       else
> +               alloc_size =3D sizeof(struct iio_dev_opaque);
>
>         iio_dev_opaque =3D kzalloc(alloc_size, GFP_KERNEL);
>         if (!iio_dev_opaque)
