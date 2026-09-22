Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1755D87C
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092575; cv=none; b=KQghJYrXAX8Hw73ucAlcKxQrfmbmFw+poywbxcR29ino1jSYWe0gfXxK8gncr1pphUyu4q9M4XkiQ1xu5Lz2CqWh/74GyRG2fFtpEyQqncQ2c3UhkXfAIC3hkFtG+U41DZYUyKzQhlllVrYLIj0RHbJW99588LSO3/DVhl56MTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092575; c=relaxed/simple;
	bh=cJMB1C5NwgZ9t/F2vTcnLRABUGE483z9RikyK8kCd+M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3aJSyR+MLVOPBcKACpqxNqZDkUKawTtg4BCp8fikGXTeJFbplpMzMZ8ay6b6ctzu6pTG4+Jzrn/OASs09f1lhnDdKf1dFBjQDq/Qhu6sq2b8QTsYxF09lwcHqSjIJCPQQF7mduMjGHyN/v2z7IgoFrF72Ge39RITfzZSS6ZZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbShvM61; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbShvM61"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so24322385e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092572; x=1790697372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2oj0aTA7VOJyZrVWcneUoZKYnaLkcgMjrZp/pYzU3RY=;
        b=qbShvM61cN8CPZifWFN5SJ+3FTVRuLGjpuSm0/2kL8b650xzaSMwfhsCVBL6MHrxS5
         NS3hznVK17OmaUgIv4yY+7hHuKuIkMpI1NjVczlSqTtsxiaky8Cz+IjWF92Q75rDuex1
         qir951Zo3h+29zze3mon1Ukei5drCIfFZFPZB6hG/ATGXtNGXkD6VDEeIGtfcmui7igK
         ZP6E95p/uTkgJG1s0DZVQ/8e7oINGyz/+OBjvsgBj295vSLEMlkgm4T86a7KPO0YktUC
         cbdZrIFjDTpSiNEDdsiPbKVXOXPzxuSjKs/Gv+xR69UpM1e/ZbIivbHdH/3nJsKv7Bsq
         EojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092572; x=1790697372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2oj0aTA7VOJyZrVWcneUoZKYnaLkcgMjrZp/pYzU3RY=;
        b=yg8VmWDPqHpVyfGryK4KNaxRi0lL6g0NVy+kzA17moNUoWLfUz8ZuJ1Po/dnkC9i2A
         hUKgzRO3KXqLMpjr+km8xc/e22yOahS9iEv3eTHxBoJkS0YTsJE4x6V2EGLri6nCbeji
         WIjJcBQcJAWzpiP3dIU0LwbT+Ws6eyWYjxy2oIajiirDfjATcJzQ0+86KAFv5nm21Giq
         gxOOaxWc4HYQ3HW5TkFGiK9TXWTvzu1T8Al+dcjKc+34wrsrR/lji4PWaj/bfVvxTBZ+
         K4NjeDoyaGxneFZPzc+oVPoHsSyq4QuKkdsXE//veYSAoKJMVXryPMzj6Lw3fotFEeWB
         ziVw==
X-Forwarded-Encrypted: i=1; AKwUvBzy7CjrIucg0iDCFEAFxKZ557ozWgU9Z/P5d0zib6khI4Srw/lmLUynKhv8U6vwWMAbhWv6XIZ9GzvXb5++Bqc=@vger.kernel.org
X-Gm-Message-State: AFuF++m9jHYLA7+u+MW2v8fD4gMUUbUvI1SV3xNSecTj5gK7A5g0dqAt
	OY+Uh7d7UbRWx+ij2N5K5Q0YboM3HSN/0+j338M2qz8rTLFGMXwiZMOJ
X-Gm-Gg: AYBFou3Xii7qm2W/Ab7whX/xRRa+fzzbrS6ecA8vliZuzV5r5NdPkHYVgHhiIHG2z2i
	DTsVH6M9U9Ac30poDi7JgpAEiA/vauH1T5NsVFIhWz2h6ZradyAp78RlPcIN0sxdQI2H94f6NTT
	SW9JHFCXr4Kf53JdWmAzEI0RqExIFwqqVTAcbb78DvcxqcPOU9J4VHpJ+VxXjaxuNrj9OUVL9P3
	Sv+A6XQGOf7nIMmQDc5aop0DZhu788pG6QAqG15PPze0uPUsTs6o9m6nvkHKkHL6+OONaZIBaPS
	rbwaYyluScFBWR+5s1tLErGD7KNqYIv5U0irwEPrUUjcAdfQfzblhoGQgzw5078oFXB4k6LMWm1
	09EEqeQD23JkU/3zdpr+4d/Ot32gvuv9F5no1W5lV2hOBhI/6dQZSoyh2MmyHDAoOoF3A2LL3ks
	ZrNK5BkVC128tSNo0C+XB7hvIgInYKfSCiNynVOVU0uLHb5QZOQzzMWYqhQASQpUo9/uKBc0U32
	SWT338+0REw05bZhvRlK5lu1OzhuPbJXoi1lqjOGI7XsArbl/2zN6DLl80Y/UCbu+J/j1BU6ZcS
	IpI03atghkAy+A==
X-Received: by 2002:a05:600c:3b05:b0:49c:fa21:e746 with SMTP id 5b1f17b1804b1-49fc57570c8mr186611695e9.28.1790092571470;
        Tue, 22 Sep 2026 08:56:11 -0700 (PDT)
Received: from HYB-2NH2WFe09VB.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm325825e9.5.2026.09.22.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:56:08 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 22 Sep 2026 16:56:03 +0100
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v10 04/17] iio: add IIO_FREQUENCY channel type
Message-ID: <xevuqaudwm4hpnhbful263yx6r45liuch6yc7xjk2i7wly3oxo@xe2htu27rkl7>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
 <20260729-ad9910-iio-driver-v10-4-aa1f6167729e@analog.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-ad9910-iio-driver-v10-4-aa1f6167729e@analog.com>

esOn 29/07/26 09:25, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add IIO_FREQUENCY channel type to support Direct Digital Synthesizer (DDS)
> devices that handles frequency values written directly to its buffered
> interface.

...

> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/uapi/linux/iio/types.h  | 1 +
>  tools/iio/iio_event_monitor.c   | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index bdf3d4c06331..a45277bc5d99 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -99,6 +99,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_ATTENTION] = "attention",
>  	[IIO_ALTCURRENT] = "altcurrent",
>  	[IIO_COVERAGE] = "coverage",
> +	[IIO_FREQUENCY] = "frequency",

Hi Jonathan,

Thanks for not giving up on this one! Taking a look at the testing branch,
I think this line was dropped during the rebase (addressing a conflict)

-- 
Kind regards,

Rodrigo Alencar
