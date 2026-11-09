Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223190;
	b=jpESuOJLPQNKPPdkRr9cgKkrtLXdCPWtwNIo4xx0tPOw4WUraeTEiv8DBCer2TrLy3CZ
	 bE7EGl15byEaLvKhUvgSvTHQd+UBqgIOr8ju49SbXJ+5PxZsqu9pHFbWBoC7yGAXgY4NC
	 v07G3zAG/OGuIbIm9D61gapxmsF0WAjHt2dO8deFBKTrnFLDLWgcI43M8Y45BniwTLMIF
	 8G7uMZtdh85OCAzaFD+nwvkoSS0+QfgGx/e2fc/ekvT2/cmdMtsa/i/7Rn22Fjd5UM6iE
	 gRI//3gdBrlxPy/8gW3obiJkGYRSLPAusuflCk0aAfOyrnQB7PeNNbdLWCnlMES24gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223190;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lY6O5vQk9+JczPENJHYrp1HUtZoEwLFGCDuEEIYM8M0=;
	b=JnYW5zMfSeuDCxSDSfuebHE/fJn+g8Fs0NrwjVFmrGWTfHY/0BAvNKokbYegO1Iun0H0
	 SF91FqPtXY1ZYF+foYc/6x1W6Drx3PA58Btv7FtKdhVEbaJBLaeYlcR78/w3aB4SCzygl
	 p30T3LJ4TqyjsUnPF1Z59s1TF/1q1x5h8V3s+ItjfWLCLyuY0v0sZvK1UvVWRJDCFWFpm
	 /4tbmHLuKmw4wJo0AiV6VGe9DFWfIzI/EJNh0gIAnmDEmhlvpkv2k28ido92qZ6ze760x
	 KoUTdWE4dTAieZB9Li6LWnUWJpLIIkxCqK9kl15xftWAHFVC8OzSQ/tA+6twVVg/Zhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCWQBaPf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 704F2606A322;
	Mon,  9 Nov 2026 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCWQBaPf
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 33EFB1F008A5;
	Mon,  9 Nov 2026 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223190;
	bh=lY6O5vQk9+JczPENJHYrp1HUtZoEwLFGCDuEEIYM8M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CCWQBaPfZi1MG+dTcJAQyHkuMP7MyNLJMrJYZUyrhewaBgyMdCYBipTYs9Zmy48BB
	 AM+96bBxOxsNmO9fPkVPjLtj+JTUPBJseLz8jJV+1vwMKiR39WxFtM6SEZqhPfjZLT
	 ePAMSZQ05MJl3ma34ufuX12k7NuQl5T4yRzQUxKTFDmTei12X+7VXWCr4JkVEoEzyw
	 /8abAvup8mBBdjFQpgaa5QXumRFng7IOFSSGVZox99SR38XaHB6N5ZbkZCKHO89m8T
	 paGW8xiKSEDQJjfAzna0nx1XvRx4ZwAjKz0kRhs+VqcCvrKCCwNerlKl/5cfxxiJ4S
	 FMRvMQjfxmvPQ==
Date: Mon, 9 Nov 2026 12:19:46 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/9] device property: provide fwnode_property_get_names()
Message-ID: <eymdomw4dby2zwlfio2l2wdyp2m7hblb2xwks2masnc26jb2xn@jkwf2v4heamc>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
 <auug8QoQ62ETGg1D@ashevche-desk.local>
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
In-Reply-To: <auug8QoQ62ETGg1D@ashevche-desk.local>

On Wed, Nov 04, 2026 at 11:17:37PM +0200, Andy Shevchenko wrote:
> 
> > +{
> > +	int ret1, ret2 = -ENXIO, n1, n2, i, j, count;
> > +	char **prim = NULL, **sec = NULL, **merged;
> > +
> > +	if (IS_ERR_OR_NULL(fwnode))
> > +		return -EINVAL;
> > +
> > +	ret1 = fwnode_call_int_op(fwnode, property_get_names, &prim);
> > +	if (!IS_ERR_OR_NULL(fwnode->secondary))
> > +		ret2 = fwnode_call_int_op(fwnode->secondary, property_get_names, &sec);
> > +
> > +	if (ret1 == -ENXIO && ret2 == -ENXIO)
> > +		return -ENXIO;
> > +
> > +	n1 = max(ret1, 0);
> > +	n2 = max(ret2, 0);
> > +
> > +	CLASS(strarray, prim_props)(prim, n1);
> > +	CLASS(strarray, sec_props)(sec, n2);
> > +
> > +	if (ret1 < 0 && ret1 != -ENXIO)
> > +		return ret1;
> > +
> > +	if (ret2 < 0 && ret2 != -ENXIO)
> > +		return ret2;
> 
> > +	if (n1 == 0 && n2 == 0)
> > +		return 0;
> 
> Shouldn't these checks be before any CLASS()? Otherwise seems strange to me.
> 
 
Actually, not ok for this: we create these classes in order to
automatically free the string arrays when returning so we must create
them before the checks. The above check for double -ENXIO doesn't need
it because no string array could have been created.

Bart
