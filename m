Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912399;
	b=pCBNospL9ZA9O2m1R9b84NNAg/5dWMgcJtwQoe8LYs5H7rW6iDccDVhfsRf+jLqI9s7G
	 CjD9LwrmLtVnYK9r8R388rb+staUuQ0k5dkZCpmdb25xdsUtTqSUZSB20teNty6P7sQjv
	 g/iWlASDmVvxP14xueFSBTGWuKBPP6CNNbD6lO9sWL8BZoM2fH6Nowac8LSGQimOo43Ei
	 Y1ssbD+pRA2s2PoXhx3HQwwGbuDLj/oKhWbO1fOBK6mKZhQg59iNYR1IMaY/Vgjayz8ha
	 IyOuHsg+uKYyxrdu6i61J7rkfzi1uqnnabqN3Qd8JEQdZ0Lsfp3+YxN1a9CkP3Yr+Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912399;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aDis8V/KVsikzKIBvDsHdyEbmMntZyFSoT1LoqQ4Fuc=;
	b=myeK7cVsYhtPEsZVVstrEaqErzkuaM3KTQQW969eG3UXBFfmCqB+bHXnPVA4T8ycC78J
	 QWh/Bt+NOVEF0UbH7zScT1P5O7BuYFe/rDxd7SBBpV+nDVcz4nTo7kWfzTPrLS0nnCK4W
	 hG/AJDHMqo+24qfirHFqp9yBnK9a1UJV5GMICV2wQMEpa1p12BSdFjs1iIEfARR4BAPZD
	 HDgHRsg1NsDGFsLTv/S+6fZ8hAnwQ0X+m85705dAykSM9SSZa2Chc3HzcCfU8Bw3JNpB0
	 GLSlBWF1sZ/LzGYZbTCevBqs/wLXOHKbUakbbpk1rlucDuTw23wSEnIypx7bI4W7fOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOe5qFt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 724D4606A31C;
	Tue, 17 Nov 2026 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOe5qFt4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D78C81F000C4;
	Tue, 17 Nov 2026 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794912399;
	bh=aDis8V/KVsikzKIBvDsHdyEbmMntZyFSoT1LoqQ4Fuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WOe5qFt42uJK8YgtDTJm9LvnLmTNo5JoA40/u2CH6DON1DkzUCnp4kE0O3f0IFz/0
	 zwmkh6pGNADvmDdQrPaAmnN8cwWQu25o9j3QkVDpgGw9U9jSqsP0pcXqwYxKJejF5H
	 4hRJaIEIBiIZZElQaeI1oxrKcDf8y01CIqVwMw1T24IzfsZheIDdAHnq6zONExyQaC
	 k80IoiicFea6bbhKr0QxPTSTtLAxFg42XfJipF1MEBQBX+nVOEK7uEDe1GwPuCyhQj
	 N4M5wyRu4VTfVXtFXnOqQLore6NUBjKxH+tXFk+UD2fm/U2flpQZ2EqYDHQHA51QBh
	 7fFiQnZC7iJcw==
Date: Tue, 17 Nov 2026 11:46:35 +0100
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
Message-ID: <ofjnhfxx32khew77khya2whrfg336qvfsxwq25gz2psckhducv@cnfhpk2uobg4>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-10-4edc23d5cf50@oss.qualcomm.com>
 <avc4g9cbAOEElzRX@ashevche-desk.local>
 <riqrrdjxaygsphy2mxe5xbsrokjtw6kyrneiyzsh7kld4qnrwf@iaa73bchswrz>
 <avwrKmg3uyvP19pq@ashevche-desk.local>
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
In-Reply-To: <avwrKmg3uyvP19pq@ashevche-desk.local>

On Tue, Nov 17, 2026 at 12:23:38PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 17, 2026 at 10:50:38AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Nov 13, 2026 at 06:19:15PM +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 13, 2026 at 04:47:10PM +0100, Bartosz Golaszewski wrote:
> 
> ...
> 
> > > > -static int gpio_shared_of_scan(void)
> > > > +static __maybe_unused int gpio_shared_fwnode_traverse(struct fwnode_handle *curr)
> > > >  {
> > > > -	if (of_root)
> > > > -		return gpio_shared_of_traverse(of_root);
> > > > +	int ret;
> > > > +
> > > > +	if (gpio_shared_fwnode_ignore(curr))
> > > > +		return 0;
> > > > +
> > > > +	ret = gpio_shared_fwnode_scan_properties(curr);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	fwnode_for_each_child_node_scoped(curr, child) {
> > > > +		ret = gpio_shared_fwnode_traverse(child);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > >  
> > > >  	return 0;
> > > >  }
> > > > -#else
> > > > +
> > > >  static int gpio_shared_of_scan(void)
> > > >  {
> > > > +#if IS_ENABLED(CONFIG_OF)
> > > > +	if (of_root)
> > > > +		return gpio_shared_fwnode_traverse(of_fwnode_handle(of_root));
> > > > +#endif
> > > > +
> > > >  	return 0;
> > > >  }
> > > > -#endif /* CONFIG_OF */
> > > 
> > > Hmm... What do you exactly get from the compiler without this uglyfication?
> > 
> > The alternative is an empty stub for gpio_shared_of_scan() and keeping
> > CONFIG_OF around most of the code in that file. I think it looks better
> > this way.
> 
> My question basically was what will go wrong if you drop that #if completely?
>

Kernel will not link with !CONFIG_OF as of_root is defined and exported in
drivers/of/base.c.

Bart
