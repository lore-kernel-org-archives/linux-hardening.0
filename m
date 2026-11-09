Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223020;
	b=DmOm/5WGzf+jrRj04hW1Pjp9QheR/M573jhL3aptjuUuipNzJ59LgYJCa8r8Ld3qXzFS
	 c+mPPt7GJWdPi39mS95w1GSGqLP3Ukq+E8qd7Re/VYDnencLWITSFVEXcJ7lK+XMSfAjH
	 GuzNAsdXe1qbiUL1QwX7ELbaKhYOahDoGwJ9cle708bw4Syqd2IS2IyHSEHH1Tam0BEnt
	 54RXUZvKisBxKk5Q9JcLPTg2eAh6nJn3qFsyh9yZZrspfWEobWS2yJVQcPaDCyMmN9D5o
	 zLCEB1BQ4L2BHcG59HO6aEBK7rZEx3KUvRUf0XYpO3TPiYRIo7oCiJfo5o/o0LZ321w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TbcHcyfuJQt7NcynrxjX6hRUiJtfdZradZAYhvPwFbk=;
	b=iTn0++ROjIxRAGMYkzLtH9Qxft9plTeqUk7AmyhbaeXnrFUNktrlpy2qxeugBJRAS79S
	 DcluamstS7fX8bBTLecYGGdx0petEEyzZDExlgws78oUvjJ38A7CKjEW6aRTeHuhM8Z0y
	 FdHCb2EzcbxJcTdEeSd0PzWcamxujKEkS31PjsR1WaKIyaVytcdjrLKUhFy1xhTQaHe1j
	 l3E1frRXfzQ3UA8HhwQboZvFRYzOY2K/ovvObBOAMUByBaKNU0YEkUS3pujzRoFACjzZ7
	 4VuMe/Pg+9wV294Hg538ktcSSAqIu5TLcTqIIyvqxWRoyH1REqT9F+iXgPzWrf1p6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TGulpBK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 545BD606A321;
	Mon,  9 Nov 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGulpBK/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 038AC1F0089F;
	Mon,  9 Nov 2026 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223019;
	bh=TbcHcyfuJQt7NcynrxjX6hRUiJtfdZradZAYhvPwFbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TGulpBK/V/tw5aJTu+5PVTBw4ZbjAKQJGgzCDSIpdqi8SENIRrw+2PQiWnwvtqzc5
	 ChNFfyxaya1KTgpRtdoAxKmJBKiIlJvWDBG7Y1GqdiZqN6BGjugkEgFhhTUFXCXwlF
	 rshQohUDtdJxaufinBA311FTp6kEF4RuZTuFCeg+vc+q42XrOnBVGUDKWtQE9JfvAv
	 SlK8sl0iE1hYeXcVT8di7mfuiNWkHi16/BU16vWVu39pQnxAvVYBe9tYTaUb2Edzkk
	 SNwaeOcqq5ty3SkW7knK0Y0AU2O3hWd77ti91OWudFTlirXJq50eRL8epnOdqJ8o/R
	 nIRnpQdVXTMdQ==
Date: Mon, 9 Nov 2026 12:16:56 +0100
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
Message-ID: <lmib6742yptkwh7mzduw5xqid6h6rsqchs6aot3usjkcocmxqs@cvcpkwqag6nz>
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
> On Wed, Nov 04, 2026 at 03:03:46PM +0100, Bartosz Golaszewski wrote:
> 
> > + */
> > +int fwnode_property_get_names(const struct fwnode_handle *fwnode, char ***props)
> 
> Triple indirection is rare. Do we really need it?
> 

I don't have a better alternative. Having two functions: one for
counting the names and another for retrieving them into a
caller-provided array is IMO the worse alternative, so I'd keep it.

> 
> > +	merged = kcalloc(n1 + n2, sizeof(*merged), GFP_KERNEL);
> 
> Shouldn't here be something from overflow.h?
>

I guess size_add() would fit.

Ok for other comments.

Bart
