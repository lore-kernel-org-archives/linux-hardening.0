Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909042;
	b=dzEx4zPWi/Y5CrO3Fs+ErK33wKRYSZcht/T1Y8lSfoQkIY0Nrr0YkhiSZV9X+fr3oU+H
	 Pj64EKJICDBr1dWYnHdy/uqIS6G3Qj0Cq4HPN9RG5z/grZ9SEi8DlUHMVFYHVxyfH8mjJ
	 t40s/oeGVGttmELrHpbMUx90YQrHmNdsTaHyiskQXpesMA2xWyMnJUlsEIoeVTqBhDuvM
	 7eAvlNB+1inxfoyCih23iIz1Ebu0/nlZhLr40bAAfVbI10sd0oR/FTlzgK3xxfgG/MO27
	 BtYsstxMt/N2mA1K4Qkgb7t32E/mjfmQJ76Cfxt0Rn05ej/kqUedUCxmN7j0XuBu20g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909042;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/Tjr3NK2jnP3mAfz+NG3DFEwrc05uLjvR2FDaflNUl4=;
	b=uBGNGuqIZgrn0w1KbL+jXFRja3Z02ZAyLdrqddStSyLmX1H/cLBgv8b/oQYfES5GsKQ6
	 quTow5i2rHrKnkqmtFaqbn7zIimBa+7zpXQDPr1pRoQ6Y+gG8Gx/W/6TS6fKVTlsO0kPm
	 bGCZuT2qwV6g2ZwEic4w9oMHxzVjaLX2P3XcCBhstf0oPMgWExyVh2Hd0ZxH+3oHZnCv9
	 FrOYECmzEltVEYs3CdTpErBE8S3qfe55V8YpWHCqgMpnXJZUGJai9hhz2iWk4xAgnvs23
	 A4Veua1HQJke7I8S5USaHJa8+m8c4hERVl49vv1MgC+DICESpewWCFDu5bb7K3K6rhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kW9yl6+m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F1041606A32C;
	Tue, 17 Nov 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kW9yl6+m
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E53C61F000C6;
	Tue, 17 Nov 2026 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909041;
	bh=/Tjr3NK2jnP3mAfz+NG3DFEwrc05uLjvR2FDaflNUl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kW9yl6+m69jWFKGambjdBHYkZBthgb1qoNYcD8yrVSvgLh9/l3MuUEq7XYr6ZB7Au
	 bMLeDulxAfuDSo7vnSukfqrjpIt1IRkC3N7mD0oe0S3DrAZjwF4iTMgWE1twr4GTXM
	 9cR0lo4OaRQyDEO7KK+PyCU5/Snkb4aqcrAdgDStofsn2ftLaley0+2GLHBSCWcATM
	 4YemSy4FxJam4QVpWUGlgEDhYdAxmAGb4FQWw+nu5rBuXgQQC9VENs0aQ4gzPbRzCk
	 nHu6aXf//rJLeQXs3/5zkeib95aQoONVMBdjiATPzA14P1aoznSTjo14EmstNiA/1v
	 71QT52NZW9CmQ==
Date: Tue, 17 Nov 2026 10:50:38 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 10/10] gpio: shared: generalize most code to firmware
 nodes
Message-ID: <riqrrdjxaygsphy2mxe5xbsrokjtw6kyrneiyzsh7kld4qnrwf@iaa73bchswrz>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-10-4edc23d5cf50@oss.qualcomm.com>
 <avc4g9cbAOEElzRX@ashevche-desk.local>
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
In-Reply-To: <avc4g9cbAOEElzRX@ashevche-desk.local>

On Fri, Nov 13, 2026 at 06:19:15PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 13, 2026 at 04:47:10PM +0100, Bartosz Golaszewski wrote:
> > Ahead of adding support for sharing of GPIOs for other types of firmware
> > nodes, convert as much code in gpiolib-shared.c as possible to using
> > fwnode APIs and guard the remaining OF-specific bits with CONFIG_OF
> > guards.
> 
> ...
> 
> > -static int gpio_shared_of_scan(void)
> > +static __maybe_unused int gpio_shared_fwnode_traverse(struct fwnode_handle *curr)
> >  {
> > -	if (of_root)
> > -		return gpio_shared_of_traverse(of_root);
> > +	int ret;
> > +
> > +	if (gpio_shared_fwnode_ignore(curr))
> > +		return 0;
> > +
> > +	ret = gpio_shared_fwnode_scan_properties(curr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	fwnode_for_each_child_node_scoped(curr, child) {
> > +		ret = gpio_shared_fwnode_traverse(child);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	return 0;
> >  }
> > -#else
> > +
> >  static int gpio_shared_of_scan(void)
> >  {
> > +#if IS_ENABLED(CONFIG_OF)
> > +	if (of_root)
> > +		return gpio_shared_fwnode_traverse(of_fwnode_handle(of_root));
> > +#endif
> > +
> >  	return 0;
> >  }
> > -#endif /* CONFIG_OF */
> 
> Hmm... What do you exactly get from the compiler without this uglyfication?
>

The alternative is an empty stub for gpio_shared_of_scan() and keeping
CONFIG_OF around most of the code in that file. I think it looks better
this way.

Bart
