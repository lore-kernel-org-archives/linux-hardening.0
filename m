Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235989;
	b=NskCxU/1q2GRMazaqHTmjXTih4o3frTQGzz4IZC7K9Legv0uwQaYbK8vuIAZw8XcfvnD
	 BVm1Y5rsyeQE5wYeJQyoD6rYQvvPKjvSJ9QLyx511QB49nq6PIw8AV4052QUqd+DXzGgx
	 cwXbEIDKnzc+mh89P+uPHyACsALgJNyyFFBigCpyUKciLo1UYpuRw0N2A3L9vSP1q8l/0
	 Zr5vhUXTd8NiyXLWY4hkQcz8ZlwjdR/QPYYa4qVHDoOWY8hgNs7DjsWLIgNOETI7age+u
	 rQAt53+LzWd5tWZfxkFNSK5Crb3LsHrV2VXt7m0ihYjZXNgaetGgy56RQAaLEgAFfWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235989;
	h=Received:DKIM-Signature:Date:From:List-Id:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9cRdiyFE5hmtMw4CHCQv9a9kkD9YdZDXT5dVOPNTVYE=;
	b=mb2fttXDw1yKtG/N9duu5C/NfhVhPOLrTt97aR957zTbk8WsT5PxcnxU8shDMXvNaQe4
	 QYA+zz4cHH7A+1X6kU9hyaZRLJunEb2hSVzmgHznjIxOJ95wR0lVhbCfhUFY3M2NP62TN
	 4R1Am2P88MHuBheCiijkaOQxvkF/i/oEsoo6NjefZlSZ6ITSRYzvuYt30swI8BxFjq+up
	 8AFyncR2LEA7Rkm0VNVZd68Sxf7qu1v5EWte+P/RusI/HCZS8amij61reBzwJnkrqNRyr
	 o2tAovWjtd78UyYrf8Q/zA/KKaUKFrkJRJmG6P5vfTFp4YcB+5k1hEvthXI9yzNCCqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YuxPP/j0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0C1B6606A323;
	Mon,  9 Nov 2026 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuxPP/j0
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7E35B1F008A3;
	Mon,  9 Nov 2026 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235988;
	bh=9cRdiyFE5hmtMw4CHCQv9a9kkD9YdZDXT5dVOPNTVYE=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To;
	b=YuxPP/j0nyZ7lI64277PyW95OHzNOPlKOeQapmneAUMfEjIkfUY2op9J/3OpOCmNn
	 wJkGZbqmAQRU6jDVK9SKmA6lKnaCcEuDxpmKIh4lT6YZ8JlGuKaKdUyW+kKtssXhGw
	 FGNjoiWySjjJlq2MgZLVtqrRdQsRi6nPAELJKWtKNPYPX9t3uhW1Kp6IilP6BwH+D+
	 7eASem1dY4qjBDHEpcI5j6xefRNUJ9Z+ZhouQUGDdJOK7KPKGJJWWBAqW9azqvz2kr
	 VWq28TUA4eJmMhMaTQKCtxPJyreO7SlWCb+hZ7x8xh8X45jk5EKwOW9W3DBKK7Nf1K
	 8lbuawWI/Op+w==
Date: Mon, 9 Nov 2026 15:53:04 +0100
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
Message-ID: <llvzidb4mkbx2wbhmvd2mmjmsf7ft6s6h6wbv72v2r3sacy3z4@5sxktqh2mzi4>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
 <auug8QoQ62ETGg1D@ashevche-desk.local>
 <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>
 <avG8MITPLRuFcZdO@devuan>
 <6b7uxzbhrce55f5bgkvmg2r2h4ax4xg7le6vxkhzezbsef23gq@ojm3wm33v3xn>
 <avHXwL53ClRQptIh@devuan>
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
In-Reply-To: <avHXwL53ClRQptIh@devuan>

On Mon, Nov 09, 2026 at 03:30:08PM +0100, Alejandro Colomar wrote:
> Hi Bartosz,
> 
> > Date: 2026-11-09 13:59:05+0100
> > From: Bartosz Golaszewski <brgl@kernel.org>
> >
> [...]
> > > > > > +int fwnode_property_get_names(const struct fwnode_handle *fwnode, char ***props)
> > > > > 
> > > > > Triple indirection is rare. Do we really need it?
> > > > > 
> > > > 
> > > > I don't have a better alternative. Having two functions: one for
> > > > counting the names and another for retrieving them into a
> > > > caller-provided array is IMO the worse alternative, so I'd keep it.
> > > 
> > > Would it be possible to return the pointer, and then pass the count as
> > > a parameter?
> > > 
> > 
> > Is this really better? I think it's less intuitive than just passing a
> > pointer to an array of strings.
> 
> Returning allocated pointers has a benefit for static analysis: the
> function could be marked with __attribute__((__malloc__(deallocator))).
> 

I had a comment under a different patch in this series, where I
suggested that returning the number of properties could be used to
simply count the properties with props == NULL. This would make the
function future-proof in case we need that functionality.

Bart
