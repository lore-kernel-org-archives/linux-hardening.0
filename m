Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC53EEAD3
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145272; cv=none; b=YSah10PE+m1L71c4I51Q2j7H1MWlnA0+7crGtb0zOfi3fq9vMXcoH51gjosIfH+UL3X2AzfTO5CMhY1uLLTa01aXFp2xzKbT/wZA9HwXA3AvkbsfvrHDbfUn9TyR+anpFT4K4ruXG+j8FtBN0Mk/7C5NgOoBYfJzHY6yskAeuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145272; c=relaxed/simple;
	bh=6dgUYUuzfhsDSIYKKAB+5XI3CWqUbj017l5cX3HrvDY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/alrMT1bhO0N45KAuYM8I7aMvpO86QBBdg7cHK0ubUO1BS7saETSwcWJeW2I6Sr3ezmY1jRWlmiUh+MaSZK0VGqU3TwXx5j5+N5Z+DwThFFckViJthRzx18YuPEdtbEbevE/yhU/SLPxEuo115cSrY8ZfKlTMjbZvMn4n7gx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf2j480R; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf2j480R"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf41bab353so33657855ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785145270; x=1785750070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DxypF0mqvE1RlhZs44JfIUVBgafKcdOhHfFx2Mq1iJY=;
        b=Rf2j480Rze2GkGrKykZ6rmQk7DordpPXHwZvWA89zZpdbBo1e/Kiqee+YIT52xvaIk
         g98Fimf51txajcGPPqvoP79ChhOppRsmRmUKhYrtkoWvejB9HyXuU8bmWFEmjSdNuuA7
         yT/vfGh8DM0QPtS+3bbhek3oDLmqifScB0l9sIMxR/3jzLd2nowP2FyTJ3xVHtGkS3oI
         s2Ti7eB1midP1ep7RJb8q/+C9C885KTABBC8V8OfNf0BkBQ8EuIT0C5LpFIrVu58QLl0
         LqHbQZshEI6YCiUrOyeJ0lhm0AhjoOJqvkcHF/TsuhjjhHw8UjnVFJMZmvX9mnN+F1ZJ
         qh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145270; x=1785750070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxypF0mqvE1RlhZs44JfIUVBgafKcdOhHfFx2Mq1iJY=;
        b=gNiDC33brGPfISw4CmwYNPSae1GGc0uEQTa5gwUr4iNgwo+i640QINI65V/r7FAtfW
         LeXnpUTkCcojOkd1T3GFugqg82cIsxq8f3q6iTKOuLzJzxoKU0TZGfiMkDN9oi6b7BsU
         grL9VeT9drOMuqs74Z54es+Q6GfGSXqJohNaE0vFzaYle9tjmzfQ4o16m53fl3VHcV4D
         C6Ai7aMaMt3jNCbk9/zr2Cjd7gsRExoGAgRR6IIlDHNmx8pwb1b8or0kHJaHmJmtjGHG
         vE5zUgdJpT7kbCcTn593xTASTSIOTlVTK7orBz9SOOtoe4Kq0p+U4omG6MkdUdH1JEaa
         CKhA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/BEsR0uVFp2j8M8+I3yClXkzA5roB6jgcw8jQWCgiVcKfM00wWP7dumNlvfG9M19+gygoI1QM0MGFLNc/g6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFvaeYMSYkq9Lm+iUntb5unLdAuH//gUUy9fETHPL+CSCXmwt
	hWbF3l1wGO876jQsois3z1YSp8++mW8jQ3Q+s3VlLK2Q9E8GRJYLX3T0
X-Gm-Gg: AR+sD13LJY6ZSKxKVk06vanJnofXp+XLLaeSBsGMz3QSFeELrsFcAyJR+rqk+EI77wV
	NQdJ+zK1Zu+K0rQX7YB1XoAqpXDZvXK809MFaX07SxfVtVt5KU7KNcapjdXiMETl1X1TSwluW2L
	uMGsTDa122bah1Pitujk8iQCnmcc/AZeGbR71MiVcPzQ23rWrjYHiGcse4zWbrUxMB///f5MNoA
	fSjSgpzefcaMI9G8wTgBOPx4IY/kMwS8r0q8tOGXar1p2avH6E4yFhGI6OU6d+MLKOQurJzZLE/
	2mJEfANJ0KcZaioKhwUNUFPSF87+Pmi6nMSGm6LQmz5eUNHSla1s6spEMJwCycUzvDCryExKu0+
	NvQl+AwD/jg3MRVNYz/p7aS+xCei6Ji0OaqmmigGFiPikWWN2M8dcpV1uL+uvboAqfJq7+uitwk
	9TbJj2/9tuZHC04KGLdlpeN8L7VYIW9FpBY0KJo7UIxFj9CId4hWnImjp9S6Dk2dh6t0vww4gYv
	Y4XgVk4Chfh5tuG
X-Received: by 2002:a17:903:244a:b0:2cf:9f0b:b560 with SMTP id d9443c01a7336-2cfde866990mr74953715ad.29.1785145270129;
        Mon, 27 Jul 2026 02:41:10 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7ee3b1sm31369645ad.62.2026.07.27.02.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:41:09 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 27 Jul 2026 10:40:55 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 08/17] iio: core: add hierarchical channel
 relationships
Message-ID: <6tdoluaxt24zpkb4rrfe56lcb7ohphkbvi2klqplw7zibxy6xs@yi6m7bydrqaq>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
 <20260722-ad9910-iio-driver-v9-8-459d1df5ac56@analog.com>
 <20260725232432.7a0d4292@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725232432.7a0d4292@jic23-huawei>

On 25/07/26 23:24, Jonathan Cameron wrote:
> On Wed, 22 Jul 2026 16:50:17 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add parent-child relationship between iio channels by creating a parent
> > pointer field in iio_chan_spec struct and exposing a sysfs attribute that
> > returns the parent channel prefix.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> Hi Rodrigo.
> 
> One small thing below
> 
> Jonathan
> 
> > ---
> >  drivers/iio/industrialio-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/iio/iio.h         |  5 +++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index aa9d6474edd9..f7e3048354b9 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -856,6 +856,22 @@ static ssize_t iio_read_channel_label(struct device *dev,
> >  					 to_iio_dev_attr(attr)->c, buf);
> >  }
> >  
> > +static ssize_t iio_read_channel_parent(struct device *dev,
> > +				       struct device_attribute *attr,
> > +				       char *buf)
> > +{
> > +	const struct iio_chan_spec *chan = to_iio_dev_attr(attr)->c->parent;
> > +	ssize_t len;
> > +
> > +	len = __iio_chan_prefix_emit(dev, chan, IIO_SEPARATE, buf, PAGE_SIZE);
> > +	if (len < 0)
> > +		return len;
> > +
> > +	buf[len++] = '\n';
> 
> Use sysfs_emit_at() for this rather than a direct write. I'd rather not have
> to think about what happens if __iio_chan_prefix_emit() returns exactly
> PAGE_SIZE().

We can have __iio_chan_prefix_emit() called with PAGE_SIZE - 1?

Filenames should be capped at 255.. so that NAME_MAX << PAGE_SIZE 

As you suggest, we need a local buffer. Not sure we need to do an extra copy...
 
> > +
> > +	return len;
> > +}
> > +

-- 
Kind regards,

Rodrigo Alencar
