Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283DE45C12
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046719; cv=none; b=n/JgtKT72YdsxvwIrSdVhrBC4FhWA3Lg50blfsi5SZUUGD+iFb44xUQ4qQSsJMTmQ7M+PlTqPPfRpvYAb39vyRbQmLGwfpwxurEHQMQIpjarnYzvW1uiwoTICqObrvOqJfg9W2bmAEDEryqknM6FvyHnpTnnUFCxDccIP8EieJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046719; c=relaxed/simple;
	bh=kSWaf0T42y646FQrMOgidBDWNtFYUcqFgyfSwWs06uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anvlIq3IVgh62vKqpPWSUcCFCkVZlt7PNk71/wtvcaq7RVi3pqu5IEA6+amjhIxFIQnWpLbGZ0OmfANsW3b0xD+PjoYYzSXu69aa/QTLRyENZVwZ+XudQyVfmNeIhPJxHDXoFF033AHDFY6dYje7yVNlV9hUUnRVFX6TKAiZBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jkMshWzM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkMshWzM"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dd7c5437b0so971204b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 13:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706046717; x=1706651517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3m8Jdqm9fDAro0OE/v0vg8c+BzdlqtwcgqM37BtUlok=;
        b=jkMshWzM8TNBzndN0qDNbjM6oj++5s70NUQAP20ggBF0A1n+M6Lkw34nuqRskrn4j/
         Jj0YXDGcWucbfVPSF8qpQedJ221OnN+3Xpdikq2DI7qkjYBtQXD9EZ8TSzIqNjIdZfZ9
         kWO2INka5Swis4C/ils8U1fqrXWBHQOXSiLSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046717; x=1706651517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m8Jdqm9fDAro0OE/v0vg8c+BzdlqtwcgqM37BtUlok=;
        b=ua3lDaTR+s5Cf/ZTc9sk0u4fHovgBskBhPC8bZCzKeAaVih0OkVjEvF2eQfAPh8u3A
         V/fVfQU//u23TmZbeIm0zhjngAGZY0nd0Zrtz2fta9JmLog2IYa39WcpPbLJ+no7jbIh
         Oi2rcHy4y+PrT0OQegVse3vaRFF3u65iiSFCI5WsjtdHEhZqf8Qgw07OtMxsV2wOE8vK
         mVk0yckUspfFezKTZkTaXgjTY7qSriJ0GWeRSHJKRb9jogvdGY3JqnD34K0Du+foaaPh
         83k2Mmjar5ZJKLv0CupwWO9vf5uBEY4T6zEiWZCLH16vbtn1KE0in9Dyy7vro1771iMd
         B0ZQ==
X-Gm-Message-State: AOJu0YxMD3Dx/W/aioJKIjaTDj9RH+YDzmilXVL8Af4xsiI+lW85qTJd
	OkzQfU3Hl8wr+v7P/n1wUL+SN9Gu4k8KkzPiaX0rSb68ihSoZR4NO25djSw9Kg==
X-Google-Smtp-Source: AGHT+IEiZH65kDuz45X35O0gknDmN1vpQXEzf+9pSZY4aFj4FC3xx0EIuvtCpDEgsJOH3XOgCzTh8w==
X-Received: by 2002:a62:8482:0:b0:6db:cdbc:311e with SMTP id k124-20020a628482000000b006dbcdbc311emr6110817pfd.61.1706046717492;
        Tue, 23 Jan 2024 13:51:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a00214e00b006dcd6a5ba14sm2312377pfk.59.2024.01.23.13.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:51:57 -0800 (PST)
Date: Tue, 23 Jan 2024 13:51:56 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/82] overflow: Introduce add_wrap()
Message-ID: <202401231340.85EBDEA@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-3-keescook@chromium.org>
 <1c36c4bc-b3ad-4a8a-834d-241d424dbe65@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c36c4bc-b3ad-4a8a-834d-241d424dbe65@prevas.dk>

On Tue, Jan 23, 2024 at 09:14:20AM +0100, Rasmus Villemoes wrote:
> On 23/01/2024 01.26, Kees Cook wrote:
> > Provide a helper that will perform wrapping addition without tripping
> > the arithmetic wrap-around sanitizers.
> > 
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index ac088f73e0fd..30779905a77a 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -124,6 +124,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >  		check_add_overflow(a, b, &__result);\
> >  	}))
> >  
> > +/**
> > + * add_wrap() - Intentionally perform a wrapping addition
> > + * @a: first addend
> > + * @b: second addend
> > + *
> > + * Return the potentially wrapped-around addition without
> > + * tripping any overflow sanitizers that may be enabled.
> > + */
> > +#define add_wrap(a, b)					\
> > +	({						\
> > +		typeof(a) __sum;			\
> > +		if (check_add_overflow(a, b, &__sum))	\
> > +			/* do nothing */;		\
> > +		__sum;					\
> > +	})
> > +
> 
> I don't know where this is supposed to be used, but at first glance this
> seems to introduce a footgun. This is not symmetric in a and b, so both
> the type and value of the result may differ between add_wrap(a, b) and
> add_wrap(b, a). That seems dangerous.

I see three options here (and for add_would_overflow()):

1- document that it is typed to the first argument (but this seems weak)
2- require a and b have the same type, and use typeof(a) (but is possibly
   inflexible, like the problems we've had with min()/max())
3- explicitly require a result type (this seems overly verbose, and might
   have problems like we've had with min_t()/max_t())

In the one place this series uses add_wrap(), I have these arguments:

	int segs
	u32 delta

and the result type is expected to be int:

	return atomic_add_return(add_wrap(segs, delta), p_id) - segs;

So as written (option 1) it's (accidentally?) correct.

It would be rejected with option 2, which seems a strong signal that
it's not a good option.

So, your idea about explicit typing is probably best, since I can't
examine the lvalue type within the macro.

	return atomic_add_return(add_wrap(int, segs, delta), p_id) - segs;

I'll give this a try and check for binary differences.

-Kees

-- 
Kees Cook
