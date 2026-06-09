Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB44352C35
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018584; cv=none; b=qiVQFIQ/9OMZQNi96AHOrtwgNWtOrd2LziflkbZyGnvbF4N5yA+9Yy+xshkdtCQBen/qkNeAgB24csRJgxe1g7Ueb4KH47cmjtOAAsWxtOYTfkZAc3B8CN4JmhVAWg9SukAkCM2s+yRJv+Rpu9rkoGJ3nQxwRGSzoxGPWcYxc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018584; c=relaxed/simple;
	bh=kuIHPRKQTH2/4GUOzUX9fYHsOqljjnSwteHizxDZwoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTZS3W+JlyBh89Oa5OzNNqabZ6MQmLpZQA9w/j3X3u8/JJbmfeFjX6X/Og/R8pXq8KQH309MYrJeLBbt9EAyjoBEVIAgIWZcYmMttGe+ud0tKHwCPUGFox7qxjnRKtsTMvsuF7udQHpCpi+4qtZB5NTU8h8yOWpjfimffcAneb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmEgUkYs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmEgUkYs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so49941485e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018580; x=1781623380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9e8wekR8dwGp203+UO+bawrLa7V5VSovtR0ieIMnb0=;
        b=EmEgUkYsqMXt3PcL2oDNtf4s31q2zIbcBJv/dN84jh8FsfWBK6bQgpP48p9P2tDD/1
         dC2PzE8lCP94utuoolSC3mrZmT5deLI7gAsHVNVxnKBUNJldj6ztV6L5jc8BLzPe1ZFw
         laN0EYv2YwD4Id02DUnA/aEtlKE7lfFKGVbiNBtGBk26cqsiGXz0PU1060nPlJij50kb
         CedZQ5Z9kyJW6JNhqkEOq/SFUuZEKYRerPMbLyw7JEJOqGV7VJxtXJHA79f8qj/xusS4
         8SOaprgxETdCFvrtBp4kJ7WPgIaIDew3eLOWiIEUWYESOQcYeCp+vREh/qFl95ARSnFZ
         KLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018580; x=1781623380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9e8wekR8dwGp203+UO+bawrLa7V5VSovtR0ieIMnb0=;
        b=C10jOZ5f1nRidHJJXu3JmqTglgpmzl5w9KZY3ZOKzaVhctmeZdUFkKiimoFXdNTH7P
         UNBr7IpywrVYMV30jopjMkfV7FugjOFRwBtp6k8qyOnfMHgznpB2BlvWtvv4ncNJdx+b
         fWYiRcFcffcQTuMPmHdytRfzmqhaGd3YeIxlYkWl1BNGGlyzCCB3VkhsTaPMO9DiG0MP
         F7ronaKvmXnijvqb4mqDPnL1tGlt9UNeNbWueqCA/i0CsBwY+IeftrIXDmxEvpaZZIFB
         WZGjuxWCIaxUnYn316M7HsA7/x4KzplDhrr8r0J8j6ODwT1s7bsJSL/b6UcDXs4fq0AF
         X/HA==
X-Forwarded-Encrypted: i=1; AFNElJ/uytdu8WF0/v5O0au8Up1eVbAXuWeodozyU7KXyaDi2HkJYoD6IqrcF1mNty+acgSsL1waCN4FTHgHJn1Gd0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPx0VDDcOSfjkPNQY2aKcmhXqWgfbaRZV0+8IYbZrWnfhChGQx
	PZDc8VsMhKae2QHRL2Yt/QwYHRcSUgcLpu9QgxCKkYqbePrgDK6GfWrB
X-Gm-Gg: Acq92OHN4GYV7zaq5RvRvGJ1TKQCWEvfLosH1FnNCApCfv9/zEA/wHR8+zeGleAyoZJ
	28Gw+WiUE/rTtVbU01weSWrRCVfSrUDfDb0WP7Hp2BNUtMciEg+sdxgu8Ir+JTB/CshjfCQBQqJ
	tEq1UwvYSn07JUTp4FgAJGOLSM2JP+4JFn5js9HbL3HompJnF+qfUmRAoN9ErUPK2n0ANBiTC2h
	Hcf/0KsV1j2ig0kUXgX90pxUvM0gYTvy/c19vrGfXFGnp9WbWyzbsNhpC7sN32781Mt1KWhQG8X
	GDfRmvmuzKx6xlGV/P+Ypj+d2+6m+CR5Tm2g0y6URS77vr3Ho8chE64k99frTlPEsMXGw/6Uq82
	yKTVc1WLdeJSfOqWmDWRJgdBmBXBoj7YeOM6fQauGctBt7oVbeLSt88eiEdl1HZMMP9wykCQRvz
	L36yQrhbLA6g7RB5ItqduUJdUcSmwTGjkd1b8GVPs6tb2O+CRBU2t5bj3RedlPCMQC5ccgwDY=
X-Received: by 2002:a05:600c:3e87:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-490c251d8e4mr357536025e9.0.1781018580077;
        Tue, 09 Jun 2026 08:23:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e5a00sm484287205e9.15.2026.06.09.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:22:59 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:22:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, <linux-hardening@vger.kernel.org>, "Arnd
 Bergmann" <arnd@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH next] driver core: Replace strcpy() with memcpy()
Message-ID: <20260609162258.5228eda2@pumpkin>
In-Reply-To: <DJ4KTIFM6YN7.3E07VW7CCJ19U@kernel.org>
References: <20260606202633.5018-1-david.laight.linux@gmail.com>
	<DJ4KTIFM6YN7.3E07VW7CCJ19U@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jun 2026 16:08:55 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Sat Jun 6, 2026 at 10:25 PM CEST, david.laight.linux wrote:
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 75b4698d0e58..63fdfffe1a8c 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -617,10 +617,11 @@ static void platform_device_release(struct device *dev)
> >  struct platform_device *platform_device_alloc(const char *name, int id)
> >  {
> >  	struct platform_object *pa;
> > +	size_t len = strlen(name);  
> 
> This could be strlen(name) + 1 right away, which would also avoid the memcpy()
> to implicitly rely on kzalloc() zeroing the memory, where strcpy() was
> self-contained before.

I tried not to do that 'optimisation'.
Here the kzalloc() is almost certainly needed for other reasons.
There is also the issue that, in principle (but probably not in practise),
the input string might change between the strlen() and the copy.
So it is probably best practise to not rely on the '\0' still being
there when the copy is done.

> 
> >  
> > -	pa = kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);
> > +	pa = kzalloc(sizeof(*pa) + len + 1, GFP_KERNEL);
> >  	if (pa) {
> > -		strcpy(pa->name, name);
> > +		memcpy(pa->name, name, len);  
> 
> But in general, what's the improvement? strlen() still operates on a potentially
> unbounded string?
> 
> It removes the redundant strlen() calculation that is implied by the current
> code, though this may be eliminated by CSE optimization.

CSE won't eliminate it.
It probably wouldn't eliminate a second strlen(name) either.

I'm not trying to remove strlen(), just strcpy().

But not just changing them all the strscpy().

	David
