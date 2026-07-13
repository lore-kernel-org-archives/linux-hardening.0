Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C13E00B5
	for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959504; cv=none; b=smaz7QvDO97E1OsEJtgWgLfU7alLru32uYbHqifauURrauiDOYssvod3YUnjP8rP9foywbLH/YGdlNRO/iRaOAltvePmob0GPHCGHRnn55Nl0JDnnbJTZ3Yutr66U2j/MhCJRg2eD5Q9vvsuxP4lMkVSivKvuboyFLX6W3TOadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959504; c=relaxed/simple;
	bh=j/xGGVpfBmZ38fXC8JgNuKE6Pd+vPTqjmTMDjnqgZk4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkSLuKD0fA3Ux+dlmSQ/VP1dzDXkQoF3N6PPciOV2Ytw122PrBLpCe3abk8okbUVulZqgMNASP71jy/hUwg14PYlUCZAD9DiXSB2HLsm8PW8ur9bh4FZ85gQcYsjiJt0JTcN4g5FH1/2nZk2BUODMyDYUNnXWjCSKy62jJtPNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOopP5Le; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOopP5Le"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so769045e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959501; x=1784564301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TbGjb/jMJnZzb2UpXKwZzIOhvZ257eTjhYHwFcycWxE=;
        b=KOopP5Lek6WwBkVP78wZIawLKodi3zHxJ8ipLT+pzfncbVPORan7bKbC/pxSFKaEAf
         R2hH9ufjSC48FbdymIqun3oH7vkyg+0S7P46qLJ0DuiHPbVypbotReu+4J8SVSe3Kx9g
         qRBqU1rshS7IpsGxaACI1ffgoJiofV1zj9/az25SHRVcaJqZx5cwcarVqdhYbh3wmrtC
         9RuYWevfr1+BiWjHGzMZO7E3YXlBBJrgLimCNSea9wDT4qfV45AAFsH7Llinz0LxJazx
         GuPQ8BnAFAQhoFJ6Qfoy2QUe7iItfn5Y1QJ5ZlGoIVJyzhpwDv52N4vfe3RdHrxPTF2c
         gWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959501; x=1784564301;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbGjb/jMJnZzb2UpXKwZzIOhvZ257eTjhYHwFcycWxE=;
        b=kcWXGJtXllIaoUTOf3pkit3gPR53FADrcM8CODIbszT1p/SDoBrOBUzpqvK0DE2Uvg
         PG+ACqK4KThcAZhC6E7/+WfzloBNT3UwL/Z/gS3Ibv/yFTA0BmYnhbwHbXZKIKw3Tdak
         BAXfWgFt4VEQrMiaZawEGTBf00X+8hUANpxRgYV6O6MVwMHBNa2NO6642lJsGgJd8kx2
         mPTUtzUWTrl3TYLA3NXk92P7B7BUaUlLCVrqJtyl0Yf7fB0xhL8M+Vz628+v7MR2OoIs
         idkBrnYKokgtdTz1suHE16XAG/s2FXkabp4AiRzXNP+NvfzPA83859TcoQHWcteq5ulm
         5KUg==
X-Forwarded-Encrypted: i=1; AHgh+RobDgZKCYOVlo7dhrdbiuHEZwPsd29FQ6EhA/inDEhy/BF+1pCHiQyejknjvkXMHHjXHxKPvsABrGDSm/2JA9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HXGTDCmQctqTvYUrQfjSn8sl06eBoqiIiLs2LGCS294BspvL
	6MYw+Q5BbW18Znd8KobPp1mOGJcBxhaHIozjiARb0iH+15ECN7WrADFj
X-Gm-Gg: AfdE7clF/AWe/CFes9LEN0eSx9V4OU1VupkbBs8Hv9NKA5QRxJMbcDxGwNA72Q+1cAz
	OMewhV9JOVjyoIUmJZ74R5xmc2Ueltt8ZecJL/Ia+y1vWGZ9yf+g5ohucpwGkzfk0RqXU1EDOpO
	AU6H+Lp099nmyOU2X1iORmtgk0DpV8HW2dgKLcA26H6SPZKUX3thaDPwaJvBJy5raZKWhML7EPo
	OXtXZ7TIyRMcZ703UR6bxPWzn22jxqe1gLQ8h10qR1zjJmFJaCeGIE1ttRnRtogiSazR1PmlkFg
	UabkpUOEpvYwSlHylStIb3f9EJiEnb/BnJwtqbWSyIqzqw83dffWtpQ+a3KDXmAhW6fVh8AaAZ1
	z73E/O+nCkqWJEpR+GIFxfcmbp+TNPqO/mMNgsoWc3KYnRdCAk5LS5oMldg+S6YQeclsm2/8Ui9
	iS4JETFor4mbjqQlELdvnmSfw0mwDBrW+1NqlL7zy+25z6VdAPeehSxjf3BW0qgJsMwnn3cIlil
	MhVKJV5f/s1ChZ+zKUcE8yOBVo=
X-Received: by 2002:a05:600c:1392:b0:493:f753:24e8 with SMTP id 5b1f17b1804b1-493fed59338mr80519895e9.6.1783959500626;
        Mon, 13 Jul 2026 09:18:20 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32a2casm7873375e9.12.2026.07.13.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:18:19 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 13 Jul 2026 17:18:14 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 4/7] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <2shq75gvzzm27rodbgmtxkbgt5n2a7dafjc2mmkttwnshmhyqr@pdytastitwfm>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-4-1bcc8c280e4d@analog.com>
 <alM8M78O9-cRSxR-@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alM8M78O9-cRSxR-@ashevche-desk.local>

On 12/07/26 10:03, Andy Shevchenko wrote:
> On Fri, Jul 10, 2026 at 12:20:48PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Use of local SPI bus data to manage a collection of SPI transfers and
> > flush them to the SPI platform driver with the sync() operation. This
> > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > overhead per spi_sync() call, which will be helpful when enabling
> > triggered buffer support.
> 
> ...
> 
> >  int ad5686_probe(struct device *dev,
> >  		 const struct ad5686_chip_info *chip_info,
> > -		 const char *name, const struct ad5686_bus_ops *ops)
> > +		 const char *name, const struct ad5686_bus_ops *ops,
> > +		 void *bus_data)
> 
> Can't you utilise the dev->platform_data for this? I believe it's exactly
> the case where it suits.

I could use dev_set_drvdata(), I understand that platform_data is to be injected
by the board/platform configuration.

SPI/I2C cores do write it, from the board-info structs at device creation:
    - drivers/spi/spi.c:835
	proxy->dev.platform_data = (void *) chip->platform_data; (from spi_board_info::platform_data)
    - drivers/i2c/i2c-core-base.c:973
	client->dev.platform_data = info->platform_data; (from i2c_board_info::platform_data)

After device creation, the core itself doesn't touch it.

-- 
Kind regards,

Rodrigo Alencar
