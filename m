Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612E3DB30B
	for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339374; cv=none; b=LKGNfHpjinuF+A8ehJY8Wb93qgKO6QwRY9+un0TdwOBs8SsE/Nm11lYbXIMbl6p3tV2pcP0wN5CsNsrs5jIPBmQ/7cnZ3G+Jq7y/gOXXZ2i93vii0V0E2+8kovJlVwyH5ly1o4vHRK64K9zC0kB9LFPlM3EwGGjMzcczzSu5KUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339374; c=relaxed/simple;
	bh=Mzr3VbRrl8kAj9srJsaqIcS01nB54Eujf3nC1FUodv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXDrfOUELiqhZFpt+DuvY2M9kIimflbb/7UdrA5WH+RZ2UPKp9lOb4/Vr9s1Hst7dA5lkdNKkBeC8cEbv+kQX9/AKsfCmWDjRmkRacr5A1N4upCX/+7u1vzuehUw2njQQJVFtZGuvQQa/olm4rq77XDsz8BdQCjoLMlEVi9NGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmCg3j8i; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmCg3j8i"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e61817b178so3142145ad.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792339372; x=1792944172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OclAn790U4McE2PSKb1Cj/mf9bWrhuoW13sPXANUyZ4=;
        b=RmCg3j8iUndpoIwFPUkZA0BxsOQnS7LPP6TbqytU1nHDI8rlH+HqHx79j0cfOS4uij
         HA1vg1uwaehH7Zhg0xM+BrgBpdyRFQW3QoQc2O52/hfRT+qfWGpf1tkN80K7gE6v2m3Z
         F/DR5dUC55z/nW1j1VpFvqZeoe4VAUISZ3XoUNMpajS0pTp+i3LsjAqHtH8HMP8aBIeU
         FmqDJXnxE9Ce42juKaqpLMwBsKjUfYOkgiiFePm87RvJPcNnp6ffbBoU2nFELr3KxtDe
         78dmFJutQDYrjQcLd7mBRvkZiz4lXZe3MRu+FWJRIa0PZ4a2tChcQwFCbr3fUR0Xg5QB
         /PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792339372; x=1792944172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OclAn790U4McE2PSKb1Cj/mf9bWrhuoW13sPXANUyZ4=;
        b=yX1Xe0eru69ofOjp+CFDviMfdbf+AKIoQFvJM8IR5yfks36EnzUiJ4NxcsKbIjuw49
         BUz5cPS3ZFs3K+WzRaWd5+gIVojakNLe30nRc6IQPdRTIvaW+SPwMt8oKbgEeS0HvOyT
         5gAi1l892criPmgcA++KM4fX5LajUDoYkjdfRIXuotbij5jcUqDTIv3e1yf/emVSEsSC
         8OmpwfLqBMyIMyJlbDL+VIHEF8RQr24qgOuQ6rr2ohiB3qZWI13rRocAotty5K072cdN
         nxtmab9JUAe56CuNO8GCz8XD6iHIbaxNR3FseQhrxL1S2JmjhuaRBeQwDXsuJRrOJLIR
         1pPA==
X-Forwarded-Encrypted: i=1; AKwUvBwdO42SFZNgt1ip5gJOLSo8J5Xl9b42wFPw2fZJaaTbhU2loCJv/mgsUQAgEWGNNKAKnC/65qxg+iMLb2uGc3o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVPJC+fgQ536vpyD0ehnCKqte7HuXfSprFB2vwvZdXTgFecP38
	o0xEU6gtTYNI936EkxvmIJ7OxCGAA63FypbrmZ6B9tfMf36MM3E1cQLd
X-Gm-Gg: AYBFou2/Kf9v1E9vkh0tU8b9WVMvLjwrfyodtP5P5kfUrtxZ4FcLdqN0EXHIfU4m2Lq
	mJ0kg3b+V6sXzJjfzmM+6YQTPEwcKHE0u2WGFO0kxSZ6P6Zz83Bm1c10UaB/Eo6fWpSxAU088yX
	5LSc6tMZy2ofWbNtzFZUB0Aw27sH0X727Ttz5zef4y4qn/c0TQMDfofZYs0FT/byvEE7dbAQIvW
	dFnj8gd2XksFeVs9C7J5bifc2lPORw/w8fdwO3udtcMM4Bm0YW5mFYsU6YiyxOxhkudwvaK3aJB
	wahhHHhAY2qUHbU5ozRnjQ8q3/n+AyVxRFqi3aQmc/nCgBMNd/q1fXZf5ILLoly2KVXTdHgwZzh
	+lDrS6sc/DXZ1xuVFc5jtFGKlmqTbT4XYAofFhtJyVhcrz0gB8XtjY0gJqe3Oip4KdKazimcnGa
	tVjZaAdMIaFuMVMlv1aF7PdPklaH5gootTvbndg//ecNsmAKxh0Vp/3DzcjHyUuVWKWu+JkPOwN
	4EBcmN90SRXR2fU11NnJ2cI8A==
X-Received: by 2002:a05:6a00:7095:b0:8a0:5de3:a170 with SMTP id d2e1a72fcca58-8a05de3a1dcmr2036797b3a.45.1792339372164;
        Sun, 18 Oct 2026 09:02:52 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57269315sm2981539b3a.23.2026.10.18.09.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:02:51 -0700 (PDT)
Date: Mon, 19 Oct 2026 00:02:45 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Ville Syrjala <syrjala@sci.fi>, 
	Henk Vergonet <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Message-ID: <al4du5juolbkhpa42fmewxaa62kre7ohmz7h6pako2dkjtnqtt@cdziwambsido>
Mail-Followup-To: Greg KH <greg@kroah.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Ville Syrjala <syrjala@sci.fi>, 
	Henk Vergonet <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-kernel@vger.kernel.org
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-2-shlomojune6@gmail.com>
 <30bc6e07072076b0591fd416f50f4fc3@gmail.com>
 <2026101727-ebay-five-72f8@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026101727-ebay-five-72f8@gregkh>

On Sat, Oct 17, 2026 at 10:19:59AM +0200, Greg KH wrote:
> On Fri, Oct 16, 2026 at 12:17:05PM -0700, Dmitry Torokhov wrote:
> > Hi Shihuang,
> > 
> > On Sat, Oct 17, 2026 at 01:04:07AM +0800, Shihuang Liu wrote:
> > > The pxrc and xpad drivers build the physical path by appending a
> > > constant "/input0" suffix with strlcat() after usb_make_path().
> > >
> > > In preparation for removing the deprecated strlcat() API[1],
> > > replace it with strnlen() followed by strscpy() into the remainder
> > > of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
> > > strlcat with better alternatives") did for the usbhid drivers.
> > ...
> > >  	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> > > -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> > > +	len = strnlen(pxrc->phys, sizeof(pxrc->phys));
> > > +	strscpy(pxrc->phys + len, "/input0", sizeof(pxrc->phys) - len);
> > 
> > I really dislike this conversion pattern, and I do not want to see it
> > open-coded across 18 drivers in this series.
> > 
> > usb_make_path() is just a trivial wrapper around snprintf() that already
> > returns the length of the formatted string. Calling usb_make_path(),
> > ignoring its return value, rescanning the buffer with strnlen(), and
> > then open-coding pointer and size arithmetic for strscpy() (along with
> > an extra local variable in every probe function) makes the code much
> > uglier and harder to read than what we had before.
> > 
> > All of these USB input drivers already include <linux/usb/input.h>, and
> > drivers across other subsystems (drivers/hid/usbhid/, drivers/media/rc/,
> > drivers/media/usb/, sound/usb/caiaq/, drivers/usb/storage/onetouch.c)
> > all use the exact same usb_make_path() + suffix pattern ("/input0",
> > "/input%d", "/ir0", "/button", etc.).
> > 
> > If we want to get rid of strlcat() here, please introduce a generic
> > helper in include/linux/usb.h (or a USB input helper in
> > include/linux/usb/input.h) that formats the USB path together with the
> > subpath in a single pass, for example:
> > 
> > __printf(4, 5)
> > int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> > 		     const char *fmt, ...);
> > 
> > (or a simple const char *suffix variant if formatting is not needed).
> > Then each driver can do:
> > 
> > 	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
> > 
> > and even drivers/hid/usbhid/hid-core.c can simply do:
> > 
> > 	usb_make_subpath(dev, hid->phys, sizeof(hid->phys),
> > 			 "input%d", intf->altsetting[0].desc.bInterfaceNumber);
> > 
> > instead of repeating this strnlen() + strscpy() boilerplate everywhere.
> 
> I'm all for that too, and putting it in the USB core for everyone to use
> would be great.

Hi Dmitry, Greg,

Thanks for the suggestions and review. I'll respin the series on top of a
new helper in USB core.

Thanks.

--
Shihuang Liu
