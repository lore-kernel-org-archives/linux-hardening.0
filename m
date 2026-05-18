Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39073CAE72
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101057; cv=none; b=t6uEloP/IwZUTRX2AwsxJ05S/Vg3wSHm/3PiABdtLn6DkE2loN6Sw4QueqaGgts/IWtbXfO2aHXWTND0HhVFCKDjkDrH6zckUTjsv/aZ34TbsxCNcBlmfkkGbZHjR0Pf4szcIjQwNCQ2xWK9wXyvxYBXVvZKQfM1F6WVkg3BEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101057; c=relaxed/simple;
	bh=RhWcqJg8RgbB1MJofKvo7sLooBa12dtFpi62aR3SVlA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr9m97D/SeJkUGZUZ3UuZjEsrWGf5ldksdcIbNdImyME/NaaAnXady0v2/svTsRINLxTdNyQpAswuRMG7QGjvjX32YPxu+ArgSIJgodkYob/vUF/rOEhISuCX38gQWfuze/xTHFNk7mi+/0s4bRJIa/2TsnHQSheMixbQztF+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asZJ33ak; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asZJ33ak"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso24088745e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101046; x=1779705846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1TfHYXVTtFe8YaePf+Qyu1Vi9txD3OHA9vREKcQqPtk=;
        b=asZJ33ak0Vyy8BzpgsbV8W9yMbtX/3IobBUzr6evd39lgTXOwdAsjwODlfiA4IfAWV
         oN2OnFgvI2KR7G0tI39EJoC2fqB15i+Tqr9txxVJAk6KnuhLmeWYGExopq05wJAwiFJE
         Hb9JoeDGMQI2c3ucBkTa+n2oT+jPrnPBYnKg7JDpCVrBrWHVjC5OFQuEFZGq7SQXfQkP
         pvKYzzeynmi/TmhskNCTCa1nmWStYvTAvKqBS92w3opnpjZJszpcLQ7BbDsEY5o8aja7
         kPut9jURfdR2rRm+bRGJ04JxbKpKFAaoaqvUxwb8W4wnLoML7brSjDknuKjGztLjVWyG
         wJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101046; x=1779705846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TfHYXVTtFe8YaePf+Qyu1Vi9txD3OHA9vREKcQqPtk=;
        b=CXTMsilyPqL7sl9V/9Q7ZOt2gyucig+HuywonLrkcDWOzYjapEjvQFHwJZwa5GzNP+
         TpODiKxG9GWa9aOblbpaZtIe+gn76+xV5XW+AoVsk0YKItLTjD/EX0MzvLN9lfpeuLd+
         7btXGO16vC0GuXP3ZUh1jwUkmzgB5Y9c0l7kz+hbX9hPpsUd86W+AcOednnQs5PvYUX6
         0f/VMG5fwzf3Tl6+gN90KiHUjiCMNJiraY8sxzYNtP+bdd4mZMlKMabJw24bJ2kDt2hY
         eQQTgBWyeccI5l+yyLsF6dlMXZh2maos9rBY0fPxqD6T1SM9+UK/hbHITXU01UmyOD1A
         ZWVA==
X-Forwarded-Encrypted: i=1; AFNElJ+X+Mi1rLYmJknQZJLtz3o//nVVXqvxqsEI9yRVTymyaDopqwj9UExDUMRQPcUpzT62xPckZ5G7Jjjw2XPEXBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5a4aoAPUNTy1cxFJZZYUvq1WQCbRLnywN3xE8yJJWdK8/Juk
	W4hM0zaW101XwrCNllBxvmA5yrcIJRyEZifT3SkoDp1LubXYqn+TJkP8
X-Gm-Gg: Acq92OHIZeASNvlzOEw+D5QqsQuNG9i/I8dDpnXYhkgQj1dODCO1IF8G9tmUY6jK1LE
	wEeSQu6JLtKOznvP7TXMOyPgevdP0VSI5C1l1dCU6tqwLlftkbqPNVZBuTkn/RxiZqcszLUOavY
	Ea8VcpqOFtuRougfB07761XgmFwxthzMC0Yr87g9mu1HYDgCCJ8EuYShpiGq6qqHune+b7SE0Jk
	O7MsQIGFmZDpULDMQoYSHLZyEbGDjo5UHtY/lKSe6icG7IgzB7N5NimGJSggcTO7KN/PolN7M4J
	OC5IMyCq683xwSnRWBUCiKHMzD1q048RFd3G7yjVL7bK5O/DZKol8WQUzMgfFibODbRy00aJAP/
	sxnDEirm+05rkSwpbZI6rOA/B1Uq33gTSsDPy1pfiKBxXUo1bmkeVvx/8Zv6ifcK+Gjruku7iUL
	niSb6bp2lfC/IQyjjxEjvBNxxpMFmSV0pg4JQKTiMl+zCuCMTx3YeeolK0lD8Og/CuyxbM3q45x
	hc4rL8xAYqzoSYxkBeK0jZLiVT73r13IP+IyHeGX7UzEtqQnw==
X-Received: by 2002:a05:600c:13ca:b0:48f:eb8b:9988 with SMTP id 5b1f17b1804b1-48feb8b9a84mr122520795e9.23.1779101046286;
        Mon, 18 May 2026 03:44:06 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm36544342f8f.33.2026.05.18.03.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:44:05 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 18 May 2026 11:43:58 +0100
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/13] iio: core: validate file offset in
 iio_debugfs_write_reg()
Message-ID: <hr3phupisl7dc3sch64tjkpeb25z2lkxwsxumcviauvstu2b46@rba2dqhoezze>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-1-31599c88314a@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517-ad9910-iio-driver-v5-1-31599c88314a@analog.com>

On 26/05/17 07:04PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The `*ppos != 0` check introduces a functional regression for sequential writes, masking the true bug which is the inappropriate use of `simple_write_to_buffer()`.
> - [High] Unpatched uninitialized stack memory reads in other IIO drivers caused by the identical anti-pattern.
> --
> 
> commit 7c5ddbc34738b9e84e226b9906348d61e3569bf4
> Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> iio: core: validate file offset in iio_debugfs_write_reg()
> 
> This patch adds a check to ensure that the file offset is zero in
> iio_debugfs_write_reg() before calling simple_write_to_buffer(). This is
> intended to prevent leaving the start of the buffer uninitialized if a write
> occurs at a non-zero offset.
> 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index bd6f4f9f45330..e587aca79b8e7 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -419,7 +419,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
> >  	char buf[80];
> >  	int ret;
> >  
> > -	if (count >= sizeof(buf))
> > +	if (count >= sizeof(buf) || *ppos != 0)
> 
> Does this cause a functional regression for sequential writes?
> 
> If a user writes multiple commands to the same open file descriptor, for
> example using (echo "cmd1"; echo "cmd2") > direct_reg_access, the first
> write advances the file position. This means *ppos will be non-zero on the
> second write, causing it to fail with -EINVAL.
> 
> Before simple_write_to_buffer() was introduced, the code used
> copy_from_user() and ignored *ppos, correctly treating every write() call
> as a distinct command starting at the beginning of the buffer.
> 
> Since simple_write_to_buffer() is designed for stateful linear memory buffers
> rather than stateless command endpoints using local stack arrays, would it be
> better to revert the use of simple_write_to_buffer() entirely and use
> copy_from_user() or strndup_user() to parse each write independently?
> 
> Additionally, does this leave a similar pattern unpatched in other IIO
> drivers?
> 
> While this patch addresses the issue in iio_debugfs_write_reg(), the same
> pattern of using simple_write_to_buffer() into a local stack array still
> exists in other locations:
> 
> 1. iio_backend_debugfs_write_reg() in drivers/iio/industrialio-backend.c
> 2. ad3552r_hs_write_data_source() in drivers/iio/dac/ad3552r-hs.c
> 
> Both functions use simple_write_to_buffer() into uninitialized local stack
> arrays without checking *ppos.
> 
> Furthermore, ad9467_chan_test_mode_write() in drivers/iio/adc/ad9467.c
> uses the same pattern. While the buffer is zero-initialized there,
> sequential writes will still be functionally broken.
> 
> >  		return -EINVAL;

This was me trying to fix an issue and maybe creating another.
Probably I would just drop this, and leave this to be handled later.
At least it was good to indicate that such issue exist.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com?part=1

-- 
Kind regards,

Rodrigo Alencar

