Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF830BF6D
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083557; cv=none; b=tdy6IB5crbtQ3AHQCx7GRjXpkwIYHGCpCszAGz9W2VucDV7e2tzevPS5LzkfhL4QhFQcQc13HLrsrSErC2aq/zl8Cy5h95pJ5pqN1rE/blMJZgXKerO2y1JRDUqjfrzYl8dun8vFaPknZz4FUNrrPn6Jtxy020YBRR0w9ITHKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083557; c=relaxed/simple;
	bh=1vXzvFUOfc9XwAC8q5N/sOdpK4L0M5KL0CA4o+35Qi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jfy9NqHgXXGoTjAfTMGCexrJy/Rn1xP8Qoo2bk4BsceDsp6vKEXt3N2j+b7e9Um4WPGc/V6BWf1vSYw1J/J+UzysqMSnu0uZzTGFxxkLxFDMlxwRpEY2kQg/Ry72VeyFbUkWNoo1PtJTRsbWV+ooGwpW6UyCbukEuyT3jjwP1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/VZGEtD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/VZGEtD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so82797845e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jun 2026 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781083552; x=1781688352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m47JVDwNRIxN+tYRIL+SQbEWAt5ykAINiL7bz4tPVs=;
        b=j/VZGEtDSOp5KXC8Vx6xZP6ZnCyTe3E08JQTSrdpJ4g6+mjXsE6+fiRTV6ii9aM2fN
         qqedzMniD0DbLr1xbQ0CJGP0INIAaTMAd7hMFApSgiMKKc+qIDzh69hFYvCg8kWE7BTJ
         sWovgSU/ZK6840Fn0R9LN6pxh0RTcZvj7JfDF0j6MKKWLvj7DLxK1ihbw2VZM35CGOgV
         3HnXrxlZggfn6n1AWubBbktOgYQpAK6qsp9Vifa5ICSnAqVyxoI4ZvEK+nhaDQiXA/Nd
         kM7wNzgNfwq2CbQfJdevPEdD+kXtb/0vs3Km3L0yvgBXKyHsO0HvijpTCtHRklINGDjK
         QVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781083552; x=1781688352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6m47JVDwNRIxN+tYRIL+SQbEWAt5ykAINiL7bz4tPVs=;
        b=SnoNkHyebZ27/fKjJIouvK+sMzb47BK/0o8+4dNxhOsQqD6Ao/buntz37j8JN7s9Fv
         f6WWuopm3Yeq3dGO0+e3EaRlXfX2+lXcxtgKsHjmSMSQmiNXJa0o3KzuBGdyQ76SKIiy
         pRbjg78DPCbRfJIdXfbhOEGY0RXWXeU8y4DpZmrLPUhyZG0Dps6V9XAtFYGvsjwl0A8g
         y/rvIsAQgisCVSSwJsEWERHbnprsIg+klA5XXz4YkUdMeC4ucX+T+Oxes03Pegin4nu+
         KRDfwp46bQTgvXpChme3MPNBWrClejQbj0V7GsgLvlVipqN7jbaIIl0AuFfKruIomd3A
         PqFw==
X-Forwarded-Encrypted: i=1; AFNElJ+3ku4tdHPuH+TRvUUUFrmjPv5KPJB6NUSHKlfHlCC6Hi+5K7NYRvcfKe+zIDxvQ4F3nZo7PulKxXawYtkTMcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5XU7xBUJTSNNWe8sfNsbTs+00POs3NjC636zrIV7dJKKgm//
	rpwNCBKKr4+Hy1nXRHpYEF6VjblvYGYJXvAarItQDI8p050l3px5Os66
X-Gm-Gg: Acq92OEDlb7o/y00XEHhC8e6oHqGHXjAj1a76uqB1Pd/WVFVcrzGgPTWvvOOgQ8yTRO
	Fcr6tycf4tmAXZ72eyJr6zLqFt859Zo0NJIIycFG07p8UkuCGwqjLHITzDew5oKfuuuje6uhtjv
	UGgHAPb45jpN+YvdRkLqDkx01TrWzqe8kGAglWEI07qlcEo++5/hEM/TRSooVlUFTYGVT/mg371
	B9EPxo168BlG2W1b0ERtV5IunyRfBpSogBNzZtHa06oRPDScQcyQ3809Y7Ld4IVIrJB4JfttDcb
	oE3oEclQhB+saG+iGcepiefiWnV2MXh3GAW3qs8foAr5EEM8R+KfbcgUGD9fBF0DLovNUxyrRD2
	jYzt69U/SO/FTkEO5WPpE6bkcQubz7pr5a7MyaXktmUfkHCrVNdTJm4mT469OSeoMkwjjhsrvmd
	qlNzuqfTdkonJLT3C9snDN9xdvx7leSpZWT4eEoyXJ1sSzuu1enfu5ep3Sw+BFBfLhAoDjweg=
X-Received: by 2002:a05:600c:8183:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490c25c6625mr340667165e9.25.1781083551620;
        Wed, 10 Jun 2026 02:25:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm552542965e9.6.2026.06.10.02.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:25:51 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:25:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, <linux-hardening@vger.kernel.org>, "Arnd
 Bergmann" <arnd@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH next] driver core: Replace strcpy() with memcpy()
Message-ID: <20260610102550.723c4cc1@pumpkin>
In-Reply-To: <DJ4VVUTU8GK2.22DI9BDCKGEUW@kernel.org>
References: <20260606202633.5018-1-david.laight.linux@gmail.com>
	<DJ4KTIFM6YN7.3E07VW7CCJ19U@kernel.org>
	<20260609162258.5228eda2@pumpkin>
	<DJ4VVUTU8GK2.22DI9BDCKGEUW@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 00:49:10 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Jun 9, 2026 at 5:22 PM CEST, David Laight wrote:
> > On Tue, 09 Jun 2026 16:08:55 +0200
> > "Danilo Krummrich" <dakr@kernel.org> wrote:
> >  
> >> On Sat Jun 6, 2026 at 10:25 PM CEST, david.laight.linux wrote:  
> >> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> >> > index 75b4698d0e58..63fdfffe1a8c 100644
> >> > --- a/drivers/base/platform.c
> >> > +++ b/drivers/base/platform.c
> >> > @@ -617,10 +617,11 @@ static void platform_device_release(struct device *dev)
> >> >  struct platform_device *platform_device_alloc(const char *name, int id)
> >> >  {
> >> >  	struct platform_object *pa;
> >> > +	size_t len = strlen(name);    
> >> 
> >> This could be strlen(name) + 1 right away, which would also avoid the memcpy()
> >> to implicitly rely on kzalloc() zeroing the memory, where strcpy() was
> >> self-contained before.  
> >
> > I tried not to do that 'optimisation'.
> > Here the kzalloc() is almost certainly needed for other reasons.  
> 
> This is true, it is needed for other reasons anyway. My point is that currently
> it is self-contained and it doesn't matter if the preconditions ever change, so
> I'd rather we have strlen(name) + 1 right away.
> 
> > There is also the issue that, in principle (but probably not in practise),
> > the input string might change between the strlen() and the copy.  
> 
> This is not a concern for this function, but let's assume it was, then your
> proposed patch wouldn't prevent anything bad either.
> 
> For instance, if the string would change to be shorter than what strlen()
> measured, the memcpy() becomes invalid either way.

Becoming shorter doesn't matter.
The problem is if is becomes longer (in some fixed length buffer).
Then the copied string isn't terminated.
This does happen for updates of current->comm so can be a real problem.

> 
> Also, in that case the strcpy() would be more robust and vice versa with a
> longer one. But again, this is not a realistic scenario anyway.
> 
> > So it is probably best practise to not rely on the '\0' still being
> > there when the copy is done.
> >  
> >>   
> >> >  
> >> > -	pa = kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);
> >> > +	pa = kzalloc(sizeof(*pa) + len + 1, GFP_KERNEL);
> >> >  	if (pa) {
> >> > -		strcpy(pa->name, name);
> >> > +		memcpy(pa->name, name, len);    
> >> 
> >> But in general, what's the improvement? strlen() still operates on a potentially
> >> unbounded string?
> >> 
> >> It removes the redundant strlen() calculation that is implied by the current
> >> code, though this may be eliminated by CSE optimization.  
> >
> > CSE won't eliminate it.  
> 
> Ok, but in the context of platform_device_alloc() not a huge benefit either.
> 
> Is there any other reason for this change? Am I missing something?

I'm sure there is an overall plan to remove all calls to strcpy() and strcat()
because of their potential to overrun the destination buffer.

-- David
