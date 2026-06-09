Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD113FFFBE
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005516; cv=none; b=MxKdTlc1TsECZywM6Rd69vliTtyADSrrFpdf+uBNMGSDqmF8yeW57BM/FYlZP99yt1bRWtF7Wm21n9vGh/eHrhf+4zc/gnsozI5zwDap8MWSTjWIu7GPEOBClFD6hVUsoCUYIzr9xBvHhdQZQ/hAFXMbylAV3XxKEYKhanrc/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005516; c=relaxed/simple;
	bh=wPjBskY0AvwX4uV3dMM2KtL87IZhP255mH61hEhnhDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG+IRxyXiOvfMMzgppZPFt9RfHvCqYh148J7EsyagWqORLz4TWVlPdKx6+/N+uXQ5X7+qyd8YjoLpClTOTm80sht3LtN4/1Idyy1vpIdN0CiQmcV84kr13UEA8R+LR3LIr5HMmxPQi+kZXz1XKr1HfDqbVcIeT21tO87hBDO2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdQa+oSy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdQa+oSy"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490a76757e5so35290615e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781005513; x=1781610313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sd/8+FiL/OAz+ifKhhV2zV1pQBjjhziXICmo+Y2PAGk=;
        b=FdQa+oSyheq3FvpbvSlI1Mu/yjPyYyqU2eDk2y5Slm4OMtavqU7NPmw4QNhh054W32
         ML02v748HnJJ0kQm0NSTRbLQ+TxAE9uYCE1xIaqAJeXLOgwh4/AQmItLZXmnG009rWgp
         f1V6rredFWmKbb1faqhAIKdwq8cFz8CPhzibAXxvIGmrre8aYFWUz9Si7pIpBo0FcIFV
         1SViRCWzS8KqeLlrBjZu546lrU2qHCBce7O94Iaoc2C7Y2LIu5iwLTKgH7pJ9UrSEuyb
         93sjt7L5M2B3av0alelRWbXbyTOPX5mOG8PGsL2SxhYfCl6wxdTwbXcwWWq8M37yLwTM
         U0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005513; x=1781610313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd/8+FiL/OAz+ifKhhV2zV1pQBjjhziXICmo+Y2PAGk=;
        b=dMLED0GBCbtuBYNU4ofSPGC9/NbnttsawLfzpdXZ+E/HjeePIn9WaBYQGATiLl03KF
         1E7w1I5ebeqB/sW3KPvGSEEk5mn8CRoCFVEGrebFtuJDCQa7ls/TilJ2r8Tj0scmc7VW
         9C8bBxBVAzojxFF9289LX4VSslT7V3/adsn1Zx+92YVhI3jdX1BFoxkej/DKpeydiY6W
         /fURvNQ+KEEHtRFk/P/3d/6zHkdIJjpw8BV7aSFn06Ilxf88T7+RuKxFN+TsdEjkTQL5
         4yt8tqGKDitK64rvBdwZdO2mDS3h7mvMZj9QiSac0oGtnZkIwuzRxEjpcknBbl5dA5GK
         Z/nQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NH0tpN+ZZq7W2TcPCmbdudk0JARXS9nHwU2vo3YlTls9XKskDsXHXOhjnbseWWgp5YZbnkCtP5I87IrxN2eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpH4feyVmDWQ0zXgAUhb2cNHjk0CYQkUGLRNw/Y1uhmo26HlA
	DhTWre/zgqXMerRUvVxPhYgUnx1VTVhsvBAGg+nCpzORdb5lf4auz3F49sJCWg==
X-Gm-Gg: Acq92OE78W1XWZseyPb7EMojdJsltc+7qGoRXiKlQ6Cy6ltC8udnoaxvwb5fZlfReDn
	i0PkqYiK0LO5i6VxRP0Enm2XT3elksgmHwzCizK6ZNdx5c4L8Hy/yU0BtnkTv1pQa98xYfIdlHw
	0fRjP+iu21F4bcuPUgHtGlHOuZIaRxXC0OoRkMYTX7uEiXuvm6IEjmqDYNHAGiFr9E2/Sx5lYly
	NeHGz3kBPnrQlWI84uODHcdAsb8elvRGsAtNDBPhj+d0YNublerpxoazIsIJgZunnNT2UTK/Uby
	HWnWco25jgfBrJaHXqTT2HNKNWA7/151QU9BdZeEyp+HeysEdCIa0+FM7qj/pHkze+wpo8knRE0
	I6iLu9chaOjdQIv+2b2ryigfvMRp3dMPhno/R8F8MlRn7cXidkjL9/h8gm49ddOBV086moIBAvq
	stwWc2JAMOZOFncVZzgHBijeYDHA==
X-Received: by 2002:a05:600c:c3dc:20b0:490:c2a2:b1d4 with SMTP id 5b1f17b1804b1-490c2a2b3d1mr217625405e9.35.1781005512977;
        Tue, 09 Jun 2026 04:45:12 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm478478705e9.15.2026.06.09.04.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:45:12 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:46:12 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, 
	rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 11/12] iio: dac: ad5686: write_raw: use guard(mutex)()
Message-ID: <aif8y-O-z6SzVBxe@nsa>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
 <20260609122605.000010b9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609122605.000010b9@gmail.com>

On Tue, Jun 09, 2026 at 12:26:05PM +0200, Joshua Crofts wrote:
> On Tue, 09 Jun 2026 11:13:06 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Use guarded mutex lock to facilitate code review when adding new
> > attributes. This will allow for early returns, avoiding error-prone
> > locking and unlocking in error paths. Gain-control support will add
> > the scale attribute.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Althoug <linux/cleanup.h> is included in <linux/device.h>, it's better
> to explicitly add the include for it as IIO drivers are currently being
> moved away from these catch-all headers.

Also we wanna use the IWYU principle (which should not be only an IIO
thing :)).

- Nuno Sá

> 
> With that fixed,
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> -- 
> Kind regards
> 
> CJD
