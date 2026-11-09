Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229149;
	b=AYt9oXkaUbT8EZ3NHvVKMzM1SF3xaxkoUnZ99O4x73JwiNWv5eC0/yJDqeE9s1v1MZCy
	 /rTQ6aY7DrCukfjLsEwwVvZeOIg2Gy4bt+pl6A/9qgsgTxnlmgTL4oN3h95IZRjRRZTp9
	 ysRh1bTnHka8LHkWFc2LsXScx9tt4GUoUObthpQOzVsfW0eBQnC4JDeSXHK3zKTUX8bYn
	 K2eLUgg+uCO2xadXfEQPoZliYYwcGX0MJs4tF9f/8u8MOTj20/+jgA0EE0zPi2ROLInJ7
	 Isa72c8DHfGJZMazzGYbQVAJH2bw2BZGe/7Pu3Glkkggh+OZIkVll16QzRmpxPCDoZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229149;
	h=Received:DKIM-Signature:Date:From:List-Id:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AgPWtX2b8WDA+AlWa5FiGBRQHnI96ns3/UnezvTReOQ=;
	b=02fgUmWbmxvGSphaSPmnVcV5NP6aWNd4208SIiMB7tTcYa63zhdTpKxoN8rDY1tlw5Qu
	 s3O6UXUwNt/SFCo75LmGfdye6E9ZKxJy84f6HpGjJie6z0Rhq7W1YKGDIq/ZsKWAXYFWj
	 AnEeujgg2ybxsABjDKwM1fmMOZvoKAYY2Vz5w2Tm2MZ5FV+/KsYp/bqGk4KSmhA5nQ8/8
	 tneIBKH5btR/+N3PkEoB9nqCRZBdN4Sp8a7wwFA8hz9F1hM/NxyR7oE6mZ/ZtOfZG4zu7
	 988bPPop5XbIsuUGzYKvQ50UPAcL2+EdqOvsXyhPK+3/sSjEHGKwPWHCbEiTNJvcrtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNhLqBEF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 654A5606A31C;
	Mon,  9 Nov 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNhLqBEF
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 109CC1F0089F;
	Mon,  9 Nov 2026 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794229148;
	bh=AgPWtX2b8WDA+AlWa5FiGBRQHnI96ns3/UnezvTReOQ=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To;
	b=gNhLqBEFK1Otcoz6kOcl8AqHPtHv7qEPr0U+I0z4MWf8WhzgXLhW/Vt5oWZEELKrr
	 EE7PYOYyKOZ22M5KArTUhaRGWKHmwIM3d2IQCCogRIZLC3JW6OKgC0Xv1IHBNMwx84
	 t4om38IyKDsEJF/Yu61FetRbTLG8MNBJPic31qO+lTpp0aYjqq3EDXrYyCnGaQVgH7
	 w2DEV0VlOHeX4DNmk9b80qO67inf2ex1j5akhtb7utrdNToVFI7MyYgy0+jDrSbYI2
	 DdvYT7zXKacO7HHjvqjWST1fU0P98JF5jKU3+yA2MoVzCd6XNuYDOaV8WL2xksG1mT
	 RdAHgTUgpQsyQ==
Date: Mon, 9 Nov 2026 13:59:05 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/9] device property: provide fwnode_property_get_names()
Message-ID: <6b7uxzbhrce55f5bgkvmg2r2h4ax4xg7le6vxkhzezbsef23gq@ojm3wm33v3xn>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
 <auug8QoQ62ETGg1D@ashevche-desk.local>
 <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>
 <avG8MITPLRuFcZdO@devuan>
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
In-Reply-To: <avG8MITPLRuFcZdO@devuan>

On Mon, Nov 09, 2026 at 01:29:58PM +0100, Alejandro Colomar wrote:
> Hi Bartosz,
> 
> > Date: 2026-11-09 12:16:56+0100
> > From: Bartosz Golaszewski <brgl@kernel.org>
> >
> > On Wed, Nov 04, 2026 at 11:17:37PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 04, 2026 at 03:03:46PM +0100, Bartosz Golaszewski wrote:
> > > 
> > > > + */
> > > > +int fwnode_property_get_names(const struct fwnode_handle *fwnode, char ***props)
> > > 
> > > Triple indirection is rare. Do we really need it?
> > > 
> > 
> > I don't have a better alternative. Having two functions: one for
> > counting the names and another for retrieving them into a
> > caller-provided array is IMO the worse alternative, so I'd keep it.
> 
> Would it be possible to return the pointer, and then pass the count as
> a parameter?
> 

Is this really better? I think it's less intuitive than just passing a
pointer to an array of strings.

My personal preference is what I did in v1. Unless there are strong
objections, I'd prefer to keep it this way.

Bart
