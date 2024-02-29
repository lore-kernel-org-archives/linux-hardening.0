Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B7A38
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164914; cv=none; b=A/P/MWywjEtcH8kKCgY/ujl+xYC+te9bqb1ynQwW21cgxiukAtUGwBDg0QEfhxyJ3M24/g7uA7ILpiCIQpbwmPDWhWIl0pXOwzYa0lxUEDUtr9zwnEQoAYstkBUYcVS+uSkR+FK6Zk0/oiacz04elcfwtcYcIsVvMkQKkZGddMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164914; c=relaxed/simple;
	bh=qxsoqrA85W0ZABODeQ55zexBoMTqe+0G6tTR4C4edFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGB8bTXTQ/ZzpMAseRO+TVmlrgftt8W9AmfbXGAiYORLjS2hA5aYt14U3ohCLO6U9401ud7zG0VBwIH2hDuXutcW8hTJrB2ylfWrFEJr/GQ0DPUay5HrX9CP8qo/eJhUqsXSA8QfaohROLmMh1Qs2NmORTKSLzUuy9EISm2AJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y3RfdnXT; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y3RfdnXT"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1a9b567edso129343b6e.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 16:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709164911; x=1709769711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEBIJm8L8y8D/KMJdxSN242jmeihBdO84S0mND9uaps=;
        b=Y3RfdnXTWmbJLlQXNnkjy+ZF0gXZKzA0KjRs2qwdBt21m8GvVCMIXgNMBURHBwjeKJ
         IyVQt+Po3ndN5q7/hWcZF56J5FgF+RMhrM8DzLqJmi0EnLfSTqemYneQq1kvGQU9wY3x
         Apg7VWhU2fM47BtJyjtDA9BGDyI3ypa2yFpm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164911; x=1709769711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEBIJm8L8y8D/KMJdxSN242jmeihBdO84S0mND9uaps=;
        b=kv7VD4e2CtLYkzK4YRpXEUpyUAonmaXn4Er9AgH49rwio2ekU3RtY9cRYE15eoXahq
         QLkGLb7cpuP4OyYfq0+ZcZ0bAeyJVTy/AgF+OAUVQk33OFasI/YPPKjDe/b8f800BWtT
         EYOaHRi/3KTurE67OIvggMBChsX+4a85UBagF6Rj1URgSvsXN2M5DAr9dbHlBF4460tn
         He2LngU244WWejSN240Ux3Kva10vpUIOho0eh/BI2cpcgwHcWBZI1Q6TPSPirqBD2bUM
         xIN1aFOVbNw/OY67gzfLtq6qOlDvpLoexL9VM0w478pCBvRP3f0XsWTg98CFs8KvHU8e
         PRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzcx0UbHt/qLHkGT81Z8KcnMieWLeV7chEFw5sVf8I+jsMogMhe3j+V+pTZgIwe1hrOfnyflyWkOdAXxCgGKpSOS0DayeZibC4i3Q4CGwt
X-Gm-Message-State: AOJu0YxMBbvC5nPuvmEVQjix8Bf3xT6fCt3au0OEtwhT6iL3rDDUbHAL
	G1cPc0vfQB7w03JM+dV+sRzDmrxUegv7zD3gzXEMaU7TuqF6T7mQLn1WBuZRMw==
X-Google-Smtp-Source: AGHT+IGs0rI0VXo4/NJKO1cSeuk/mHsATz8xyv2BYMzSCXsOlf2JpK8n8vhC+odnJINdbkFZX6M9Dw==
X-Received: by 2002:a05:6808:19a4:b0:3c1:af9f:a866 with SMTP id bj36-20020a05680819a400b003c1af9fa866mr607658oib.45.1709164910890;
        Wed, 28 Feb 2024 16:01:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a24-20020a631a18000000b005dc491ccdcesm60329pga.14.2024.02.28.16.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:01:50 -0800 (PST)
Date: Wed, 28 Feb 2024 16:01:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <202402281554.C1CEEF744@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook>
 <20240228144148.5c227487@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228144148.5c227487@kernel.org>

On Wed, Feb 28, 2024 at 02:41:48PM -0800, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 13:46:10 -0800 Kees Cook wrote:
> > I really don't like hiding these trailing allocations from the compiler.
> > Why can't something like this be done (totally untested):
> > 
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 118c40258d07..dae6df4fb177 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2475,6 +2475,8 @@ struct net_device {
> >  	/** @page_pools: page pools created for this netdevice */
> >  	struct hlist_head	page_pools;
> >  #endif
> > +	u32			priv_size;
> > +	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
> 
> I like, FWIW, please submit! :)

So, I found several cases where struct net_device is included in the
middle of another structure, which makes my proposal more awkward. But I
also don't understand why it's in the _middle_. Shouldn't it always be
at the beginning (with priv stuff following it?)
Quick search and examined manually: git grep 'struct net_device [a-z0-9_]*;'

struct rtw89_dev
struct ath10k
etc.

Some even have two included (?)

But I still like the idea -- Gustavo has been solving these cases with
having two structs, e.g.:

struct net_device {
	...unchanged...
};

struct net_device_alloc {
	struct net_device	dev;
	u32			priv_size;
	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
};

And internals can use struct net_device_alloc...

-Kees

-- 
Kees Cook
