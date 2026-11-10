Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301246;
	b=yaE1NsytD8vL3dhlRxHGLPb+ppQ3ETRQDVk5LbWj3Gnn+2MdR34LKA6YD4YZlERfchye
	 fDFMnVYpFjSgOlnQu3xlqjBiLGvW1P68/2y0TSl2TQu98uDgQtVkup4KhW/ELTDCztx1x
	 /pSi5SmdlGrRk5noiGCBSarRixSMrJZ4k9ZUfAVMuyIP+6DfK5aP3R894XS6uBnOCf6I5
	 jXEXKDzEKHqrbi1NS1ioTCOv3METtHfoRdzWOrTJjoknBqbdHoXw59UWHOX9laAAyNrAK
	 lmaNqpWvhgrev1PgRSSpP7FxuI2/wYX8wMeANlCd0r1jwTnrX+i6p/jnLCV0GVV2b1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301246;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3j4gUsFhEh2nfdqytzisLXu8cCMHpm+EG29QS7tXFIk=;
	b=bramT4WtNLGa2APwAUU6fYywM8iogboX1ObOkqfQH4I5iHWlN91eEqugdin/6B9SgfSo
	 95yiT59A5ABPQv9ST6h51QhAMjnU7i8ADU0YO/rDLFnGCnZDEGkiG9MrH1psfwT3C2ZcS
	 t/v8eg/DG4gU1qc0OxB48fC5GYHQ4rNKQ0amOjyvGB8TW4skj40weU01iZHVecQVJ3Sv+
	 OGbx5LEbvcxG3dKLAiyOZBCQ41qjL3jqy8spM6aCqL5vlz0wJU2003oNrA70eSPM+1r7f
	 HBeeJyRxftxpjUsjAHhOLwiHSJ5jFmenfBozaBUWihUb39D0xS+4Q9VnwYymqHVFFFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJ1oZCGt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1EA1C606A31C;
	Tue, 10 Nov 2026 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CJ1oZCGt
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D8F6F1F0089F;
	Tue, 10 Nov 2026 09:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301245;
	bh=3j4gUsFhEh2nfdqytzisLXu8cCMHpm+EG29QS7tXFIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CJ1oZCGtt8PFgApVSJmdynBE9Wmam/U0OvgYSvGasShw/YozvRFpLUi8X6bjCGv/D
	 G0HtjT1u9vUxOPaFvc+YTxRCQtEse6KllRxUbHS3VOijvQhaoPPdrREToIl0bihk4z
	 q14+LZArzQ23MiUVmXtPTnGLQTGgs/Efvq7fyHYfZ5ghYvC/di8AibaaPtzNtMJDAT
	 WVZEikd0ub96ezYKgALsvts4KlYsbsZrYr96pQzkih+yQ0+wn6ISnt+zU5PRBWH79g
	 /GrNytRGplUi6HjUr68yk/KanlCmARcQT2OZt3E8q9q/3ILDFPkuO+eA4XY+B4726y
	 xfSircixq+Hng==
Date: Tue, 10 Nov 2026 10:00:42 +0100
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
Message-ID: <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local>
 <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local>
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
In-Reply-To: <avICwdxyi-W1Y3PD@ashevche-desk.local>

On Mon, Nov 09, 2026 at 07:28:33PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 09, 2026 at 02:07:46PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski wrote:
> 
> ...
> 
> > > > +	for_each_property_of_node(node, prop)
> > > > +		count++;
> > > 
> > > Hmm... Don't we have a helper for that already?
> > 
> > I haven't found one. Though I'm thinking that maybe
> > fwnode_property_get_names() with props == NULL could serve that purpose?
> > Possibly wrapped in a static inline fwnode_property_count()? Would
> > anyone use it though?
> 
> I haven't found any users for this. Most of the current ones of
> for_each_property_of_node() are filtering by property name.
> 

Yep, so no need to have it now.

> ...
> 
> > > > +		names[i] = kstrdup(prop->name, GFP_KERNEL);
> > > 
> > > Can property be statically defined somewhere? We might want to also optimize
> > > these duplications with const variant (here or elsewhere, for fwnode generic
> > > path, I believe).
> > 
> > Please rephrase because I'm not quite following what you're saying.
> 
> Can prop->name come from something that is declared as
> 
> static const ... foo = {
> 	... .name = "bar";
> };
>

You can't know it for every instance of struct fwnode_handle, so the
answer is: no.

PS: is there a way of using match_string() with non-const data?

Bart
