Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229671;
	b=uuTfE2ApL2C/S4WrCQ5OlsrjQte9x1ghoMi1C9cKP5YiiKfzvt405Tguvci8QD0fE+Lu
	 eUE76JRlFZgiUeiFogzyGGC9eB32IMHFOLZojbRShxne4Bs72LpeeJpz+kumNGTz5sVwE
	 cQdXkM6OstVo47XzjAYWogl4lCn5oGKU+UoMjjCUmIulO1Ou8KJEAa0AeesW4wBvpFGWO
	 DVi8rjPtjOyqqu8U9XAQgGoAu4quT3R937Du00QHwdo5G6XOBgfkV2DKlOt14r6oEBZnM
	 Q5ywJpvTyr8jV/13Lf+d2QD+MN6/zaYkP63xzriYqk7ebMLMVpAqz1dLS3DJXOUQN0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229671;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RlG2R7zxRuzI1EwTLRR97Wkh9iIVS7sG83F7CjPUTS4=;
	b=Wnkto+fWoyo6o5QIFv6dIjug6m+zpwu8H8yqmrrjagXUZou0GFnX63FoilxHA5uQ27kO
	 Qt8Xqq+EThDm1f/Dmsjj2IHrIWQtC49E09aYcvhhu1a3VkvYQnASrLK10wK+1z/L3ghiW
	 ddWLmjS1p5K0YW5KXusjW1XIjjtUgr1+1daotbBundU3hmjEZc6xikqyNebcSow98rggh
	 6iFrbX+TiU/WAHfwmkDH/s+bApRjcGoVe9FU9G3aXEaRGQU45zTK5iYWeMCTDaXfg9lSb
	 olTN97UbYkLv7KiNQl3L0Wc+otUJpab2r/C/UHRYe0rv7vipl2T4WtRo+0WQwoAJRWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeCoO0RO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 50033606A321;
	Mon,  9 Nov 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeCoO0RO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0322C1F008A1;
	Mon,  9 Nov 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794229670;
	bh=RlG2R7zxRuzI1EwTLRR97Wkh9iIVS7sG83F7CjPUTS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WeCoO0RO+xOQaqdf1sP8Sqxy+c4iFkJe1+fbwymEKAsYf7i/NbpXCV/eoqytqluFq
	 +pIPuYx3iRQh0asqKseSbXVL712LLWoxN23cMr+fbLDVC2hXiFhEFBDKQTck3ceIHu
	 73rp6aIi5Pfgac1pP8K8eee5eaMxamHMPOc1+nSrqMbdR9kFl09HvLEZbt2uB3Imbn
	 tUrRfQ3l6dCDvVX4ElyF2HliGALI4BAovrXPxH4qxbi4/sA+qQAJxX8zIANWJmEqlB
	 uq5FfhVsO0eO3NnmjCQ2IER510TFKsc4c9ChhGney8s0OLno8d63rESt6Sdva1A3f2
	 tee2LVaVvN7aw==
Date: Mon, 9 Nov 2026 14:07:46 +0100
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
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
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
In-Reply-To: <auuhy40x1BMoW96-@ashevche-desk.local>

On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski wrote:
> > Implement the property_get_names() callback from the fwnode interface
> > for OF nodes.
> 
> ...
> 
> >  #include <linux/string.h>
> > +#include <linux/string_helpers.h>
> 
> Same comment as per fwnode patch.
> 
> ...
> 
> > +static int of_fwnode_property_get_names(const struct fwnode_handle *fwnode,
> > +					char ***props)
> > +{
> > +	const struct device_node *node = to_of_node(fwnode);
> > +	struct property *prop;
> > +	int count = 0, i = 0;
> > +	char **names;
> 
> > +	for_each_property_of_node(node, prop)
> > +		count++;
> 
> Hmm... Don't we have a helper for that already?
> 

I haven't found one. Though I'm thinking that maybe
fwnode_property_get_names() with props == NULL could serve that purpose?
Possibly wrapped in a static inline fwnode_property_count()? Would
anyone use it though?

> > +	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
> > +	if (!names)
> > +		return -ENOMEM;
> > +
> > +	for_each_property_of_node(node, prop) {
> > +		names[i] = kstrdup(prop->name, GFP_KERNEL);
> 
> Can property be statically defined somewhere? We might want to also optimize
> these duplications with const variant (here or elsewhere, for fwnode generic
> path, I believe).
> 

Please rephrase because I'm not quite following what you're saying.

Bart

> > +		if (!names[i]) {
> > +			kfree_strarray(names, i);
> > +			return -ENOMEM;
> > +		}
> > +		i++;
> > +	}
> > +
> > +	*props = names;
> > +	return count;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
