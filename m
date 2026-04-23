Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D332505AA
	for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931989; cv=none; b=QnagdyhNuCNzC6/obBxNOsZERPy3cIpxdU9pmDvNDSZgeVBfbFVkQGLX9OO4p4uFvudHOvDs1RsR8UmBaj4XKqDsMYdc2oiCIN09AnqjuL8q/i76R2gncLJpELMIPKDXhCjjZNVHPxbNbXqnkV8foctNSb8rMkZvF961sc486Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931989; c=relaxed/simple;
	bh=LnSlgQumZUymdbffnu2vKTkuUg/jqjTtpU53P+tI4/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM5FcKG40l+E+sVFqeO1182RO04Zs2XNiQgsJuaE/LiLvJKWNwzt056AIoUWRpJ8VBE7me9ziSQTWF0NmaU00e3Pzw5bHMa7QyB7XWpaVM4xNfdPb+vpGewr9ZzeYlZ+GUvE0utYzJ5a0yqPFQ6uZ6GeIJvJBkDIMWyV+aFn45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzewHmE8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzewHmE8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b150559bso50332335e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776931984; x=1777536784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJ/DBvdc9fYsH91lLLkmQGITtRq+02I8omXtrs2jaHE=;
        b=HzewHmE88QfzJe5H8u7jpQ9L32urpkszkqUX7kZb83fDqw12zm3MQ5qRLHIkWFehkC
         b6JtwqSubFjuZAZCoZalERm03pCc2syyDbUwQg/CQJmgcZW4fNofqKBiUZDLD0AzvMfZ
         ZIiL1/36bZ3+jSD2Lsyp5OwzSf6Du9eGUw4KXevieTB1MrXEb3nEtt/424neKKaQHiHq
         g9HqqJsq464f1gs1twntie7bepbsyFIMtZqL8YAKS9Rcs4eWcB+67JLpPdfhKl1Ky7eM
         4uny3ylFz9R0ucfO0b63dC1RAgWgGub2zTlzlFPboIt00yHEwc3Q3qK1VL1QKs9klw1P
         W8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931984; x=1777536784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ/DBvdc9fYsH91lLLkmQGITtRq+02I8omXtrs2jaHE=;
        b=iUe6/IHSGJsLmE/MBg8jWn1Gt/sKxdJ4jWLuYbeytgu/gu7pxfk/syItLgOS/w0LYK
         qkOsK1dLgsQLgbnu+w5dKcjtvO7E67yct/VLQHgewq800Eq3/rM/oR9/EQKWvRQMG5X+
         Tp+WcEyX4wYXvtPLIvTuwHbi+Qq8/JqN1uiC3Y9G6aiShek1NPHb605jU79/4mhuBrzc
         iTLzkRkltX6peJka3b6g/Nnj+ehNw3LkfHu39d/F0hdSe68he3tKP8ecn0yFUR6JEnpG
         uyRErWCpp1pUc5vak0KOuwWQdlq01sGHajbOZJZDdcDryM15arYIuinXaC6t2yzCuG0u
         Rmsg==
X-Forwarded-Encrypted: i=1; AFNElJ+wU1yPA68FI1TGyroQd/qwGJIRSw8lM9PT73dOwqTjzhN/wbyfDH68jY94gEpTpFUPbrVrNdtWWeW8pSzDtck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45SXD6hajEwPQuR15H6zyVTx/IzxUwSklAr3In3gfSYt/Y45B
	n/Oei4ewDO732X2iDX491L9GtOl/szHp3VqZUUUkvK3PDsfU4jkcoJC0
X-Gm-Gg: AeBDieuaqXkV1H0asCmfYtnwexA3NMwJxafFPHvKBofWHBwKZZ/DMS7oV2GLakQ0IZQ
	yKM4kJORihPXIJB+OrJdhRj5yjzohHWE2otC8x7UzpURoCZq3JzXI0YmzsvON0l3Y0U4qk9uvD2
	fEy5HKDPVkyQpOL64cuCtP/VaAULCeEEkI0NhG7j2Zzp8eNYc/VEda6palxnYyqkpCXpj5rlQJz
	vTPVieocNAOPRZ5UqumhQVXlRXFBzUXncB4G/u9pFNqtEf3PSE1Cq4ynUjJhEVI4310n5wYzuQn
	mwPGPMbuGRTchBGce0JG1MDbaoAaOlG2ZqohZPAkW5ZvNp1Qd7Lg9PnzXZgAUV2MsoOWmCO9les
	kw8x2AxYM9kNEP7921ZBu5EmmuigsM3KEY0GmAQGnnjqiNEebjOAQ9wC6hXDPMrQBVLQ+KcNZ3i
	lW2Tn4NWkBdw6qHIilVEcSzDjr
X-Received: by 2002:a05:600d:10:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-4891b0c8c48mr201117645e9.1.1776931984093;
        Thu, 23 Apr 2026 01:13:04 -0700 (PDT)
Received: from nsa ([45.94.208.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm517098165e9.5.2026.04.23.01.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:13:03 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:13:54 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 13/22] iio: dac: ad5686: fix input raw value check
Message-ID: <aenUZEkeDGaovVir@nsa>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-13-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-ad5313r-iio-support-v1-13-ed7dca001d1b@analog.com>

On Wed, Apr 22, 2026 at 03:45:47PM +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use in_range() to fix range check for input raw value, which is off by
> one, i.e., for a 10-bit DAC the max valid value is 1023, but 1 << 10
> equals 1024, which passes the previous check, allowing an out-of-range
> write.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---

I'll reply just to this one but it seems to apply to all "fixes"
patches. They look like a real fix so I would expect to see a Fixes tag
(as Andy suggested) and see those commits coming first in the series.

Other than that, code looks good (for those patches)

- Nuno Sá
>  drivers/iio/dac/ad5686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 19d791c655b7..07a944311f0e 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -185,7 +185,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > (1 << chan->scan_type.realbits) || val < 0)
> +		if (!in_range(val, 0, 1 << chan->scan_type.realbits))
>  			return -EINVAL;
>  
>  		mutex_lock(&st->lock);
> 
> -- 
> 2.43.0
> 
> 
